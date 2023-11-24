Return-Path: <linux-wireless+bounces-53-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BFA7F790E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79B0B20BF2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515772FC59;
	Fri, 24 Nov 2023 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hLHEoSCO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E71733;
	Fri, 24 Nov 2023 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2wxrylrSD098+RrYmJNUHBHYAaD0hX9xrQiFrNIZx9A=; t=1700843716; x=1702053316; 
	b=hLHEoSCOoqHqbVNYWJbpWQgyM9C6WSpdkLsif/4f3IbHjmyLNSo3HJIYe3nySZHnrV7abODJJ9S
	7mbadmcw+Pod1wlfEB9emf8ACmzWj/dXAofD8Fslmzy74JQ+Lvm3Q/qg6dJkfoWcr4O7JS84dSPR5
	yDRIPKGzx9lFMRGIcF9G6kzy70IG+EtC3AO7S91fgsjrz0uKwmpH2XKd0+2o7tjh6UA9q8orE+1Be
	igHeq6DqB9HN0rQmC7GAUB8WeD27nPEw2VGbjcbAtiRjF8SoE4G9r62TVwKTqtbZLaWzr32NZKCNv
	VImtt+mJ6vZzGandzS3sYkeHlIlGi/LtRWNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6Z98-00000002fA8-2pL6;
	Fri, 24 Nov 2023 17:35:14 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/6] fixes for debugfs/wireless locking issue
Date: Fri, 24 Nov 2023 17:25:23 +0100
Message-ID: <20231124162522.16344-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a locking issue in wireless where it takes a lock inside
a debugfs file handler that's also taken around the removal of
the debugfs file, and this causes a deadlock due to the proxy
object use. Fixing the debugfs removal is tricky because some
of the objects represented there fundamentally are deleted with
the lock held. Not taking the lock in the debugfs file is also
not really the right thing to do. Therefore, right now, the only
way to fix this would be to not have the debugfs files entirely,
but that isn't really helpful either.

Thus, here's a way to fix it that doesn't just remove the files.

The first patch is just a consistency thing in debugfs, right now
directory dentries don't have d_fsdata, normal file use the proxy
fops object, and automount uses the original autmount (function)
pointer, no proxy object. This is an issue if an automount dentry
were ever removed, which right now it isn't as far as I can tell,
but it still makes little sense, so fix it here by also allocating
an object for it, just not with real_fops making it a proxy, but
with the automount pointer inside.

The second patch annotates debugfs with lockdep to actually find
deadlock scenarios such as the one in wireless, indeed with that
and accessing one of the affected debugfs files, lockdep detects
the situation.

The third patch introduces a concept of 'cancellation', whereby a
debugfs file handler that is "long-running" may enter (and later
leave, of course) a cancellation section, where a function call
is made when the file is removed while the handler is running, and
the cancellation function can then abort the handling. This is
pretty generic so far.

The later patches (and I assume those would go through the wireless
tree) then fix the locking issue by declaring that the work that's
going to happen under lock is "long-running" per the above, and
setting up a cancellation. The way it works is that it actually
defers the real handling to a workqueue but then waits for it, but
that waiting can be aborted (and the work stopped) if the file is
removed before the work was able to run, thus fixing the deadlock.

I hope this is an acceptable compromise in terms of functionality
in debugfs vs. the user. It'd be possible to set up something of
the same sort in debugfs, but I feel the cancellation API is more
generic and thus more useful, and the actual details of what's in
the actual file handlers don't matter then.

johannes



