Return-Path: <linux-wireless+bounces-38911-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HzlpLZwWU2rDWwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38911-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 06:22:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F8C743D31
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 06:22:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="gW+c/fD9";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38911-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38911-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABFD301379C
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 04:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088936C0DC;
	Sun, 12 Jul 2026 04:22:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444635A3A9;
	Sun, 12 Jul 2026 04:22:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783830168; cv=none; b=p7bkrNr+iKFhvVfSCLlMnMChqXjT6Gv1FiihKtiHOQf10ZIHEIBPZjwjt2+r0HqDkGcDvVX6D31GbA0/2j1FdU1Zwr9kEtv1H05GN97TqxFWDc9cvFaTE2xD2A5F+q2y5MTGd9/GpHkUB0UZWgint+owkuyxrnXnNYF8gBl3f14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783830168; c=relaxed/simple;
	bh=UpIY7V0pTTlevXHW+Z12acJHmEW7eFT4SMwJiWy74LQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=W7a4k60gQK9zE/9mpQF8MgZxc8X/TrQwLYFKZGzBPdiVx8VrJTfTiQtxmzWY6a3XbUNUGIdewtXB2k7EF8XsJupID/XtLVurd9FhB9g/uD7AB4dr/lkTG7gQ8yOXyfPiRVEWY50GwvvAUox1FtoBDSbTy+ZpaFefsgPb6ek90RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gW+c/fD9; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C4MRWU0543991, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783830148; bh=j+4cgdZH3hb6hZ/5BjzpqEpBgMRkvFPmXCi+xOVSD9s=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=gW+c/fD9Qw1+g5YuZOa7GGnyQ8pq+pEo8bT9+mruWuiRnDWZRuqJ+pfbxbw1NJLMP
	 MFbN3o3m+QuVjyhBFIIQLoDXLLxWXvl4RDqN6e35eU3QGJdMxJK6G+ylSMwcWyvfRU
	 JmloqN9vWTqpdarwZ3lDLOrLUYfT/5a3eCocNQxqAYuKFXr3mncy3H2QeEHmvQNdy5
	 Sc+ENgVxcorKURycXILOkAm7sdgXEQxax97UqB+xAuNDWCBShd0ueNNOgUmPmfrRNu
	 JgNp0HmS8ZFg+yfHlqvYr3CifJMRzW5+GOFB69gClvY4dDsWTzghlFDFYoe3IU6HOb
	 QZ5QpgWk9dsRw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C4MRWU0543991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 Jul 2026 12:22:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 12:22:27 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 12:22:27 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 12:22:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fan Wu <fanwu01@zju.edu.cn>, <Jes.Sorensen@gmail.com>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Fan Wu
	<fanwu01@zju.edu.cn>
Subject: Re: [PATCH] wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop
In-Reply-To: <20260630033117.3377-1-fanwu01@zju.edu.cn>
References: <20260630033117.3377-1-fanwu01@zju.edu.cn>
Message-ID: <1c64aa87-6c3e-46aa-bbed-eeb909eab914@RTKEXHMBS05.realtek.com.tw>
Date: Sun, 12 Jul 2026 12:22:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38911-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:Jes.Sorensen@gmail.com,m:kvalo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:JesSorensen@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[zju.edu.cn,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:dkim,zju.edu.cn:email,RTKEXHMBS05.realtek.com.tw:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0F8C743D31

Fan Wu <fanwu01@zju.edu.cn> wrote:

> rtl8xxxu arms rx_urb_wq from the RX completion path:
> rtl8xxxu_rx_complete() hands the URB to rtl8xxxu_queue_rx_urb(), which
> queues it on rx_urb_pending_list and, once the list grows past
> RTL8XXXU_RX_URB_PENDING_WATER, schedules rx_urb_wq.  The worker
> rtl8xxxu_rx_urb_work() drains rx_urb_pending_list, recovers priv through
> container_of, and resubmits each URB through rtl8xxxu_submit_rx_urb(),
> which anchors it on rx_anchor and dereferences priv->udev.
> 
> rtl8xxxu_stop() cancels the sibling work items (c2hcmd_work, ra_watchdog,
> update_beacon_work) but never cancels rx_urb_wq, so a worker armed during
> the last burst of RX traffic can run rtl8xxxu_rx_urb_work() after
> rtl8xxxu_disconnect() has called ieee80211_free_hw(), which frees priv,
> producing a use-after-free.  The window opens under active RX traffic
> (pending count above the watermark) followed by a disconnect.
> 
> There are two teardown races to close:
> 
>   * rtl8xxxu_queue_rx_urb() decided whether to enqueue under rx_urb_lock
>     but called schedule_work() after dropping the lock.  A completion
>     that observed shutdown == false and released the lock could then call
>     schedule_work() after rtl8xxxu_stop() had set shutdown and
>     cancel_work_sync() had already returned, arming the worker to run
>     after the teardown.  Move schedule_work() under the same !shutdown
>     branch so the arming decision is atomic with the shutdown check.
> 
>   * rtl8xxxu_rx_urb_work() anchors every URB it drained back onto
>     rx_anchor through rtl8xxxu_submit_rx_urb().  A worker still running
>     when usb_kill_anchored_urbs(&priv->rx_anchor) returned would submit a
>     URB that escaped the kill.  In rtl8xxxu_stop(), call
>     cancel_work_sync(&priv->rx_urb_wq) before the kill so the worker is
>     drained first.
> 
> After priv->shutdown is set under rx_urb_lock, completions can no longer
> queue rx_urb_wq. cancel_work_sync() then drains the last queued or running
> worker, and the following usb_kill_anchored_urbs() kills the URBs it may
> have submitted.
> 
> rtl8xxxu_disconnect() is covered because ieee80211_unregister_hw()
> guarantees .stop() runs for a live interface before ieee80211_free_hw()
> frees priv.  The probe error path needs no cancel: rx_urb_wq is
> INIT_WORK()'d there but cannot have been scheduled, since no URB is
> submitted before ieee80211_register_hw() succeeds.
> 
> This bug was found by static analysis.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6c080026ecc1 wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop

---
https://github.com/pkshih/rtw.git


