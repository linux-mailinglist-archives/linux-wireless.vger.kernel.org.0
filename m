Return-Path: <linux-wireless+bounces-9002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19C90860E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703C52826A8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBE18413D;
	Fri, 14 Jun 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WRLQrdaF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3751836C9;
	Fri, 14 Jun 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353203; cv=none; b=KqT6fsp/hwn8QJ3xz4utDEghpPbju+6gdd/Nt+KM++7Bh/bGXPloAEndFG+P0acSk31sN/X6qaaHzK/5lGV1bS3ROhxXo4uOLIRii7SK4mg7E7aSjZ1YARgFnJhZL50fNmnyvsa2SWXeQrm4hv3GT8/kpalZLLuKy6So4lS2ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353203; c=relaxed/simple;
	bh=c87zkrYQathqmL08Ikj+Bp9MMl6Lx+n8tveNEu7A9fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELnCNzXqrM6qrGpvGED9OJN0gX8lkeqKFSuRgV81b4YHYvNCpjMeUPNa/EvdJ+Yr0mJPpc06xy/gfUANcxXGRk82IRpeqmq6LTgmc1a2KjpwHUaJpYPgGKIsb7Iim0y/iskuj9gJROfHth8+CzdzoopV8O8U7D8wFlxFyRBY10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WRLQrdaF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=6QB6APzgPEir2tuJKv/0C3N2LXOxzygezOBO8QcTSh8=; t=1718353201; x=1719562801; 
	b=WRLQrdaFiF6y+3AxT2kT9kK6RN+rJo1YthqNQYz5MzJ4PLy77f7SsNqcn07JwSTam5CQ/OrB7p2
	r91pv6C7KtP8yWOSafLBMpGMl52z0c9ZR9Qx0Q16T++YEyhLxiravzxkZUo6Va9H5kG58Eububzbr
	ydmhGxjfrOIqivYNSlRGacFU596GN1HiyAfC7cSyN1NGiRTWOrKsEof3YRpwX2AIGVzNjARvEX83L
	Z5oh2e/CgnpIzd9f/yU3OX5EYPhdlA9J3Uf+Uy7M45j3KoS1OAw/jUsBd+47LAgolnqvHHm0KVMI9
	FnZRvUyNbVYhID6jd9NKdKWcmhEAZfQnElBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sI2AA-0000000DZpq-2Rhg;
	Fri, 14 Jun 2024 10:19:58 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v5 0/4] tracing: improve symbolic printing
Date: Fri, 14 Jun 2024 10:19:12 +0200
Message-ID: <20240614081956.19832-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 was:
 - rebased on 6.9-rc1
 - always search for __print_sym() and get rid of the DYNPRINT flag
   and associated code; I think ideally we'll just remove the older
   __print_symbolic() entirely
 - use ':' as the separator instead of "//" since that makes searching
   for it much easier and it's still not a valid char in an identifier
 - fix RCU

v3:
 - fix #undef issues
 - fix drop_monitor default
 - rebase on linux-trace/for-next (there were no conflicts)
 - move net patches to 3/4
 - clarify symbol name matching logic (and remove ")" from it)

v4:
 - fix non-module build and possibly dynamic event handling

v5:
 - fix build warning in non-module build

To recap, it's annoying to have

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: 0x20000

and much nicer to see

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: RX_DROP_MONITOR

but this doesn't work now because __print_symbolic() can only
deal with a hard-coded list (which is actually really big.)

So here's __print_sym() which doesn't build the list into the
kernel image, but creates it at runtime. For userspace, it
will look the same as __print_symbolic() (it literally shows
__print_symbolic() to userspace) so no changes are needed,
but the actual list of values exposed to userspace in there
is built dynamically. For SKB drop reasons, this then has all
the reasons known when userspace queries the trace format.

I guess patch 3/4 should go through net-next, so not sure
how to handle this patch series. Or perhaps, as this will not
cause conflicts, in fact I've been rebasing it for a long time,
go through tracing anyway with an Ack from netdev? But I can
also just wait for the trace patch(es) to land and resubmit the
net patches after. Assuming this looks good at all :-)

Thanks,
johannes


