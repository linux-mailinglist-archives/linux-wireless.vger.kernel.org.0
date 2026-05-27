Return-Path: <linux-wireless+bounces-36991-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EERoGwmyFmokogcAu9opvQ
	(envelope-from <linux-wireless+bounces-36991-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:57:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3A5E16D2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 029B93004635
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C03E3D86;
	Wed, 27 May 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qVW1nfdV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D213E3D92
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872190; cv=none; b=BTxoajLRxt4ygISG2tOkinmOoEpQjJsaqotLEGnvpxNwUTcncTuDAAgo9NFIEvV86y+mBDDj21aALxNHcJnq6XIc8SjRs2JLlYi7m2moLIrREg2yrAqEmNhchLhC6Gj1QIruzjiVYSipR37OfA672eqtCVxfuGxksCETd9yU98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872190; c=relaxed/simple;
	bh=FoxOanfjvtz/5d4PlW05q0sUjgkt9pM16wGtz/kgkLU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=D9djqrhRiRYREW7rZvm+im5hTtyKS0SR540KLUtqHzptOaPZ3qdnlYVXC0RngVYFgvl2Zm5dYa/nNN6pEtyXnFJ+GfFaJS2H9RnjrJfcvk8fF2tJRY91XRZJg0Bb7jBInsA1f1I4kPW3nDoJ4JS5wEYMk2NKil5B6MgyyHk8u9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qVW1nfdV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64R8uOvQ52313343, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779872184; bh=KrJjfkZnY+hP10NAgDH3KZYbMOJNO9mgI79IBOtVw8U=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=qVW1nfdVaR2okr6VV/w6o/GmvS+tdBNwhC9iNHcNMW7D4E+xerAN3KEL3jyj+sF/A
	 Ba3qJ7pZTgpleE1PZ7jZXyHrxXn8qIQCnOu3mslNRvtT09nGEuDYtWGKj4R9KUrbKH
	 Awlp130KUwDIRejp7LZDazuThlT9ELipZ+mPljH0JoZk2LGHn6Y57DIR6JDOpl8wxk
	 dwEXXqAzEVvAX56lct2l+VqyFC2++2QZ677xkxVGL1/Xkji7twhMczK+gnecXZGlKe
	 0PQq1BKZi5pVdh82wmjYcxBm80NTpA6QPZeFG3DX2Q/dSopQsF2Ff9hdMpbzCmfN/4
	 Wi2ZPkqaUqv6Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64R8uOvQ52313343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 16:56:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 16:56:24 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 27 May 2026 16:56:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v4] wifi: rtw89: usb: Support switching to USB 3 mode
In-Reply-To: <e955451c-93a1-4d04-8024-d224a04f1d4a@gmail.com>
References: <e955451c-93a1-4d04-8024-d224a04f1d4a@gmail.com>
Message-ID: <39c261ba-6818-471b-ae2c-c0908942b2f0@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 27 May 2026 16:56:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36991-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,realtek.com:email,realtek.com:dkim]
X-Rspamd-Queue-Id: 67F3A5E16D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The Realtek wifi 6/7 devices which support USB 3 are weird: when first
> plugged in, they pretend to be USB 2. The driver needs to send some
> commands to the device, which make it disappear and come back as a
> USB 3 device.
> 
> Implement the required commands in rtw89.
> 
> Add a new function rtw89_usb_write32_quiet() to avoid the warnings
> when writing to R_{AX,BE}_PAD_CTRL2. Even though the write succeeds,
> usb_control_msg() returns -EPROTO, probably because the USB device
> disappears immediately. This results in some confusing warnings in
> the kernel log.
> 
> When a USB 3 device is plugged into a USB 2 port, rtw89 will try to
> switch it to USB 3 mode only once. The device will disappear and come
> back still in USB 2 mode, of course.
> 
> Tested with RTL8832AU, RTL8832BU, RTL8832CU, and RTL8912AU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

8368970b6240 wifi: rtw89: usb: Support switching to USB 3 mode

---
https://github.com/pkshih/rtw.git


