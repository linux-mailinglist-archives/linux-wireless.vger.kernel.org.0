Return-Path: <linux-wireless+bounces-35550-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ATbMOR98WkOhQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35550-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:41:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BE648EB49
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2A0F301151E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 03:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15CA24A067;
	Wed, 29 Apr 2026 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="txgY3Oz6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8EA2032D
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434074; cv=none; b=qUPmngXBRjdQATdUL3yk97xPu5DXlwfFHSR2rbpAetw/c9ZEz3XszVIwrdUuuWiVh21NK3VNE6C8YBEcebZrScQqYwVli0vgYfqCFclEJ3v2BFdiE2Vu18FQtBfi6TF0GiIC029Qa7ikC928DrBsBW+csH7rIL102F0hRUQ4cZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434074; c=relaxed/simple;
	bh=U4W9R2PXYluPE/Sd3GbsfdKy/U8U8Nru7DDg6gqIKKc=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=d0E5ab+oWBtDDT0jzG8XJvrUPfrVgVSdO9sAyXcF7VROUNXRjpHplZlqOuml3/ojWWNl68LsZ8ZGIIvCf7Ec/ecwr/vz9AZlU5+s4MxxCRDJ5hJEbWdLPjPG+IHw8y1+bbLAtgMoxr+XC9/3JRPJjGkYY9f+L+v4OAfP0ithaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=txgY3Oz6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T3f8Bx9930605, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777434068; bh=qO6to9TMcpgIve7cKm6DhF7n6Emeh/bDBuQzZItxRDs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=txgY3Oz61mT5Ob4t3z25milLjoroEg7AVGXU/Ptir1gluYcfa5Cwsdza1EJneKF0p
	 XJsPHB9h9xA/tCLiZwNqExX/wGOCdSwnjRj1K5TOHEENrWuTZde3ydUuL1xnaAz3S/
	 Be1uUOj+LXq3AfFCPLnMTE/S3wNlXtxrM7+/qmM0l9xgjgZj/mpN6pr7L/7iLJBJzt
	 RkGs7ZurIsOd4fTrsrSwt9TxRIp+dnR2x+zCbF52oi0xuCVrlmOEd50EBFenPG3WOd
	 mgLsPCZv0UI1nkrgPolgQS+yLonOqAXkFmQ2nKXSl9nVzunCiFe6NO6tZGwdmxLnjM
	 N1jPIAhOy826w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T3f8Bx9930605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 11:41:08 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 11:41:09 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 11:41:06 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 11:41:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2 01/11] wifi: rtw89: usb: Support 2 bulk in endpoints
In-Reply-To: <3d30c8d1-fa25-48d0-b27d-7d634c5aa005@gmail.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com> <3d30c8d1-fa25-48d0-b27d-7d634c5aa005@gmail.com>
Message-ID: <16a53b83-495a-459b-80a1-ed19d14621d6@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 11:41:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E6BE648EB49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35550-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,RTKEXHMBS03.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RTL8912AU has 2 bulk in endpoints, not 1, so raise the limit.
> 
> The second bulk-in is for USB interrupt mode for SER (system error
> recovery) flow. SER is not currently implemented for USB devices in
> rtw89.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

11 patch(es) applied to rtw-next branch of rtw.git, thanks.

8d722eeac1a7 wifi: rtw89: usb: Support 2 bulk in endpoints
6f4621340312 wifi: rtw89: Fix rtw89_usb_ops_mac_lv1_rcvy() for RTL8922AU
0cc43249ea97 wifi: rtw89: Fix rtw89_usb_ops_mac_pre_init() for RTL8922AU
0df7f0c22d96 wifi: rtw89: Fix rtw89_usb_ops_mac_post_init() for RTL8922AU
32cee8a9bb66 wifi: rtw89: usb: Enable RX aggregation for RTL8922AU
c3dfef1e3552 wifi: rtw89: Fix rtw8922a_pwr_{on,off}_func() for USB
c423ed43c93c wifi: rtw89: Let hfc_param_ini have separate settings for USB 2/3
bd87e927006c wifi: rtw89: Add rtw8922a_hfc_param_ini_usb{2,3}
abe23df7c89f wifi: rtw89: Add rtw8922a_dle_mem_usb{2,3}
6bb58cd6e176 wifi: rtw89: Add rtw8922au.c
f07d1009e972 wifi: rtw89: Enable the new rtw89_8922au module

---
https://github.com/pkshih/rtw.git


