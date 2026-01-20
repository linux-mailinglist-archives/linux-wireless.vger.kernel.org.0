Return-Path: <linux-wireless+bounces-31019-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NeCHNyLcWkLJAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31019-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 03:30:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDA60F2F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 03:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA60A629C45
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78142885E;
	Tue, 20 Jan 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="NT9s+muK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096E429808;
	Tue, 20 Jan 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913265; cv=none; b=jmsWnnnvLLLAuswEpQ78032HY6RuoJjYpjmI8bYNlE5Ldukn6ckh4vBbmkOe3i6HYJ0nvbCKiVkk61LeAErD4RpWZeHNwTgMz7xqx6RLXvluOSF7kh0LWpUUAksg5SgqtNnZ29HPt6aeTMgHkuTBNZCMSBtEL9cT0Ksz2IMbkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913265; c=relaxed/simple;
	bh=fCbA4BKaLc8+mkYdGw5vebXt+snFLUPEpFWbOO/0Gfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhqM7flB3KRASLJ1XIIJGDBkVHJnvRvGBZh6g0I+KckYmG/bHTqYpKC1xml4Ye5dop4ehX9w+75u6gcSz5aNUAGsPl0XCZPO+g5ScY1sN0e/4TbvSnenjkKWOcTNfUg5fTwR3ruXzXsdj/kp2LrFeSEBjDNX5RDrgYAo5rLSy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=NT9s+muK; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 314f7cba5;
	Tue, 20 Jan 2026 20:47:36 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: johannes@sipsolutions.net
Cc: chunkeey@googlemail.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_rdevanat@quicinc.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] wifi: p54: Fix memory leak in p54_beacon_update()
Date: Tue, 20 Jan 2026 12:47:32 +0000
Message-Id: <20260120124732.2644702-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <01724c7be8e023f6b5cd0ac6b48c3e125bc1fd9b.camel@sipsolutions.net>
References: <01724c7be8e023f6b5cd0ac6b48c3e125bc1fd9b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bdb723d3603a1kunmcab5ab42268874
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHk1JVk8aS09IHk5NHx1MGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NT9s+muK5aEK3CsnCP9Lj0ZVnZQK3r9rIoYLdyPRehz7Kqp14K5w5yborwVI6qcCZniVlrcZHyQnXs3oZ2PhqDBahoLnUDv/oqN9rnC7L/0uAn4pHCU2dGnnrvJn5d3WHC8fGvh4sknajV+FPOpl/5lmeYAVEk4ygdDr5Da4Thg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=7lHSuxt0eyLVNGy5QOK9DGVQ07F5djSNFJ7Zc9mEVbg=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	DATE_IN_PAST(1.00)[37];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[googlemail.com,vger.kernel.org,quicinc.com,seu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-31019-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: E9BDA60F2F
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 09:16:05AM +0100, Johannes Berg wrote:
> On Mon, 2026-01-19 at 11:31 +0000, Zilin Guan wrote:
> > In p54_beacon_update(), beacon is allocated via ieee80211_beacon_get().
> > If p54_beacon_format_ie_tim() fails, the function returns immediately
> > without freeing the allocated beacon skb, leading to a memory leak.
> > 
> > Since no other references to this memory exist, it must be freed locally
> > before returning the error. Fix this by freeing the buffer using
> > dev_kfree_skb_any() in the error path.
> > 
> > Compile tested only. Issue found using a prototype static analysis tool
> > and code review.
> > 
> > Fixes: 0ac0d6cedf61 ("p54: Move mac80211 glue code")
> 
> That doesn't seem right, although that commit didn't really "move" code,
> it added unused code ... but I think that it probably could go further
> back.
> 
> johannes

Thanks for pointing this out. I traced it further back and found the issue
was introduced in commit e5ea92a7528d ("p54: AP & Ad-hoc testing").

I will update the Fixes tag and send v2.

Regards,
Zilin Guan

