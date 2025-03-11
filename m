Return-Path: <linux-wireless+bounces-20196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C89A5D29B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F6E189E17E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE56264A7C;
	Tue, 11 Mar 2025 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2FpFhmx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1F25CC65;
	Tue, 11 Mar 2025 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741732607; cv=none; b=MNzMnSvb2hpDw7EDu2OuCRDIZ0giz8CMHLunMNs6QrFOW3mJdS1KB2QzMGynLHrniVjHJ5dxaw3OAaYal1w1Ulp1KjbdW70cvDndH0HpZv0aTj4SDJ028cVQoPRyiGMJzdrr5dPCoUyN+JAY7yZrsBzmve1QgRT0Pd4L3M/tGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741732607; c=relaxed/simple;
	bh=wM5YpCPAs9G1JoVGTrc4vk6jpgxDmDet8K8f0RnT1H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9PfRYOfKXqNZvjII4KEf5vJhqyVDA0uUsV/6aFl+2xC4MBz5PLFQRu3Ss6KEoKosoGkdihmmIv3ZaAp7ewtoXeMcJqR+uZkND7B8WVg4aSUXsyAB+H7At+o4Bi2TKnoQ+m2VYPTcJU6zp/3DmU/8GPZVOJlrAMYJDHHYu9+H3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2FpFhmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8BBC4CEE9;
	Tue, 11 Mar 2025 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741732607;
	bh=wM5YpCPAs9G1JoVGTrc4vk6jpgxDmDet8K8f0RnT1H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2FpFhmxSQ05aBBF3ApZtyAcZVrINLsyI4keKn51LE481+/xcR1LlPN6KbnA0crPh
	 QwkxPmnb+SDdockdpjj1lxTosFc8ClA/qRVY49xVMBO7YbLAHOWeMlY+61IlhHhBqA
	 08KH7uWFXEdyqyg7X+6/hV0e6gcEEX+cK4Q+yOgxLwmQfGdQObIgiTR83UQPY2HYIx
	 pl1zjkxRobakHFOlhZCz5o2CTJVflFeve8+TZ0XHtbz8QB5IYRdI3O32r0hNHtCnwg
	 2EL+sQcMOAYhnA+S4bOTX0Fh0PcxzAw8cRdBfcAUneCssSQ9LAvkc2fF6jKE/3xTBK
	 ce42dp6X5Qjjg==
Date: Tue, 11 Mar 2025 15:36:42 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kalle Valo <kvalo@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
	En-Wei Wu <en-wei.wu@canonical.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Alexander Wetzel <alexander@wetzel-home.de>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-kernel@vger.kernel.org,
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Add __nonstring annotations for
 unterminated strings
Message-ID: <202503111530.43283E3@keescook>
References: <20250310222318.work.395-kees@kernel.org>
 <12b44f58b339aa92f1b17fb7b33e30a920aad86c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b44f58b339aa92f1b17fb7b33e30a920aad86c.camel@sipsolutions.net>

On Tue, Mar 11, 2025 at 10:25:10AM +0100, Johannes Berg wrote:
> On Mon, 2025-03-10 at 15:23 -0700, Kees Cook wrote:
> > 
> >  drivers/net/wireless/virtual/virt_wifi.c     | 2 +-
> >  drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 2 +-
> > 
> 
> That's not mac80211?

Hrm, you're right. The automation I use for splitting up "treewide"
changes per subsystem tries to guess at a reasonable subject give a set
of files, based on historical git subject prefixes. And these two files
ended up grouped together because no more specific subsystem claimed
them.

It seems I should probably split this into two, as:

wifi: zd1211rw:
wifi: virt_wifi:

> Also, I have no idea how you came up with the CC list but it seems
> excessive. :)

It's based on my permutation of arguments to get_maintainers.pl that
seems to work best for splitting my "treewide" changes per subsystem:

        ccs = subprocess.run(["./scripts/get_maintainer.pl", "--email",
                              "--git-min-percent", "15",
                              "--git-since", '3-years-ago',
                              "--no-rolestats", patch.name],

-Kees

-- 
Kees Cook

