Return-Path: <linux-wireless+bounces-31325-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EOGMrZce2nXEAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31325-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 14:12:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA3BB0493
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE644301015C
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44803385EF8;
	Thu, 29 Jan 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fwG47ksc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF42EE607
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692340; cv=none; b=MR6zllUJjbQyrNuwqfbljYAFB9kBMoOpBlXtK+KFKrx1IHiOCA3xap/zqz/iwhvsj4sxlBd+wqlpOLS71Whit6JehIZgDmMH2tjc8O6T93ygVNGJy7pk1WgzQrll3+0wpTZETEGrzP4PpZ+YfbAfhD5IfeRItBqp1yjO17jFMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692340; c=relaxed/simple;
	bh=OotoHTPRgUMi3fQM3Vo+nCiMnoHrv+jFaLC/tSKyrYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhY/2bAuKPlbK6fFCRAKJ/HSKzRUSBJ1UpX292eBSgISNrv7pkGLT6ckXZEMY8I5gAXC87Q2cMaER+LppqAnMJKRIyx91hZpch4jJ4Y5nRUqqKg9B32Dg3BZhTAvLAgsLpzNeZc0OI9FvWr8m8jdEq90QJzp60T1hXV+7snPV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fwG47ksc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60TDC49J03036054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769692324; bh=OotoHTPRgUMi3fQM3Vo+nCiMnoHrv+jFaLC/tSKyrYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fwG47kscxfuuO4HI9dj+WEFYbisXtBcYxeCVidPu7h7cZaZ6NwHC4+vuybkDVawbx
	 Y6Wjpl1ufCwlJSxJBTiz2cRKVLEiTtRLy8OyDSDrl+g7lnBrPg6WpX3dVtIqx31fWJ
	 JxUMxMhc2Dwy3d6ZNHh/uKJcmYBNyYMvJAX6o+uJKHizSPo8VJUBYqTIL8ClKa20np
	 9xSCwlLBcGCVkF3kzNxVuSYvrsSK/arR6Yi+D0l56EPSLbuHfOWaUDK1XQkPzknxWs
	 TEJIEnTclchM948kg1wM4Vzakngmo3k92ZYXOJfpiVNZSFVSYeHH0cp88bJNpLCJaN
	 xDK8hZbplXPVQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60TDC49J03036054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 21:12:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 29 Jan 2026 21:12:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 29 Jan 2026 21:12:04 +0800
From: Mh_chen <mh_chen@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Isaiah <isaiah@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ping-Ke Shih" <pkshih@realtek.com>
Subject: RE: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcj8eqprwyThrh+0qoaRiP29pAsrVpIhaA
Date: Thu, 29 Jan 2026 13:12:04 +0000
Message-ID: <04842866166144debe97f7d32decd819@realtek.com>
References: <471ce67a-8633-46f3-882e-6051ab022a7e@gmail.com>
 <202601291256.60TCusZS3018440@rtits1.realtek.com.tw>
In-Reply-To: <202601291256.60TCusZS3018440@rtits1.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31325-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[justthetip.ca,gmail.com,realtek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mh_chen@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: 2BA3BB0493
X-Rspamd-Action: no action

+Isaiah,

-----Original Message-----
From: Lucid Duck <lucid_duck@justthetip.ca>=20
Sent: Wednesday, January 28, 2026 4:01 AM
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; Mh_c=
hen <mh_chen@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking in-f=
light URBs


External mail : This email originated from outside the organization. Do not=
 reply, click links, or open attachments unless you recognize the sender an=
d know the content is safe.



On Mon, 26 Jan 2026, Bitterblue Smith wrote:
> The CH12 checks in the completion handler are unnecessary since there=20
> is one in the resource checking function.

You're right. I'll remove the redundant check in v2.

> Is there a reason to add a new counter instead of just using the=20
> length of each tx_queue?

Good question. The tx_queue length tracks SKBs queued for submission, but d=
oesn't account for URBs that have been submitted to USB core and are in-fli=
ght (between submit and completion callback). An SKB is dequeued before usb=
_submit_urb(), so skb_queue_len() would undercount actual resource usage.

The atomic counter tracks the full lifecycle: incremented at submit, decrem=
ented at completion. This gives mac80211 accurate backpressure even when UR=
Bs are pending in the USB subsystem.

Happy to hear if I'm missing something that would make skb_queue_len() work=
 here.

--
Lucid Duck

