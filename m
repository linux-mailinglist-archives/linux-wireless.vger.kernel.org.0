Return-Path: <linux-wireless+bounces-34131-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJDtJSHVyWmO2wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34131-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:42:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9047354A0F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA6D300B9C1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE7175A88;
	Mon, 30 Mar 2026 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mUg35Dfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C101A681E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774834974; cv=none; b=RDXIY9v67VaZ0xhvjY003d1djwD/nq2dXEqg/kzipak2Y/2qZi2n+JpkQoKkWkvddRdlTd3uJf0D9RqIwTyKqQiTM1ZNe8ae2nsNNiCeq5jYQS3OJJapo2xMIotYMbNHyyA1thFNMcM8ffMZs6pTYbBdU6YiNLUVzFglm2UGHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774834974; c=relaxed/simple;
	bh=NlN6p5GTvLnzKiciaglLAtRsffW3zGBVWjnr7YxJizs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=HgDjpUBLv1PZ9d2ihk+ycsB6KYT5bom+FPCnqnLqcCKM7P1yzmgDCDLVCta8RyyE1GWB5GEDXKi6owlX1AgqPL6RpS8M5NsBY9tEtA0i5//EmIr+euJMD/dqK0YuIWPf5L60kgyAc3R1o5cgqRxRhaomw91c+/ZOc3R7W+BGHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mUg35Dfm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U1gmB43065387, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774834968; bh=qW4DWoXSSqxstBfwI3zNsLlMI5v5B8Jw3jU55NKac4I=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=mUg35Dfmdg94Etd4hMhSZ/BAF25TrIzRG47YUy5EJlJBYRr/LwfANla33aCQM0EiN
	 8d0wVJOXFOUyi5WnIJ/Rn2o8UQY1mzRyc82vD4+fiQsM3hprWdchiWJqysnFNzzF4G
	 /8j6PVF/DWNZcIgQq+hS/jZYRaAe7cHhk1XORF7ii18YbpG1IO/oh534w244sCltV+
	 ZN1wxoACbWwTifqeCZtD41F25PxAVDvfL7VZHuJT7Bu+XU3bzqTiYdkpBLT1m5xyHJ
	 3tzaSjqTzyadxeGw5YNgsX6gryWaVyCWAhAwvIrdLxx0qenNHSP1cJGSzvijywQKh1
	 DTtiThawuj9SQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U1gmB43065387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:42:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 09:42:40 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 09:42:17 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 09:42:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtw88: TX QOS Null data the same way as Null data
In-Reply-To: <2b53fb0d-b1ed-47b6-8caa-2bb9ae2acb80@gmail.com>
References: <2b53fb0d-b1ed-47b6-8caa-2bb9ae2acb80@gmail.com>
Message-ID: <4e7aad6d-1a00-44a6-80d9-6a00c5e0392a@RTKEXHMBS04.realtek.com.tw>
Date: Mon, 30 Mar 2026 09:42:17 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34131-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E9047354A0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> When filling out the TX descriptor, Null data frames are treated like
> management frames, but QOS Null data frames are treated like normal
> data frames. Somehow this causes a problem for the firmware.
> 
> When connected to a network in the 2.4 GHz band, wpa_supplicant (or
> NetworkManager?) triggers a scan every five minutes. During these scans
> mac80211 transmits many QOS Null frames in quick succession. Because
> these frames are marked with IEEE80211_TX_CTL_REQ_TX_STATUS, rtw88
> asks the firmware to report the TX ACK status for each of these frames.
> Sometimes the firmware can't process the TX status requests quickly
> enough, they add up, it only processes some of them, and then marks
> every subsequent TX status report with the wrong number.
> 
> The symptom is that after a while the warning "failed to get tx report
> from firmware" appears every five minutes.
> 
> This problem apparently happens only with the older RTL8723D, RTL8821A,
> RTL8812A, and probably RTL8703B chips.
> 
> Treat QOS Null data frames the same way as Null data frames. This seems
> to avoid the problem.
> 
> Tested with RTL8821AU, RTL8723DU, RTL8811CU, and RTL8812BU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

737e980e1298 wifi: rtw88: TX QOS Null data the same way as Null data

---
https://github.com/pkshih/rtw.git


