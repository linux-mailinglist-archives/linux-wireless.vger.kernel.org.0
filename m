Return-Path: <linux-wireless+bounces-9434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4C912603
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5FCB2CACE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A0C8FB;
	Fri, 21 Jun 2024 12:45:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39641C6D
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973921; cv=none; b=LLSK7HbRHOjjrIClQ4TDqolCwYFeXj5HY9RPxnf5eN5n6zVODaEIToVdH9pR4C0+XWnHWffSnR+zBLHU9Gcsl0qVznwGJF5kn/4hKPLCkmwmUPB6+nE9ViZo7p+e28ezJq56aZ18D4pDpv51lXd++sLmfZJkbvOqzt84LSFGL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973921; c=relaxed/simple;
	bh=jJKBMqZsqiH2TBdoDvABcGSzfNHWnY6jcmKNDkL4VYY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=tTOb9EDOy51aGUrUd08o5jkbq1BiXRu1et0zlAQl2pw4Y03hAhBolGjR/OAciak8mqhjqpcUEms2pl0U5E0NNt+QRakPDLIj5SCnErIPjghAs3jg58zW440ctWnZ8b2iLzvhhqfAkEejLZj/4D5qg8yBdw63RYDBmSlQN64bC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45LCj2ovD4095849, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45LCj2ovD4095849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 20:45:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 20:45:03 +0800
Received: from [127.0.1.1] (172.16.22.19) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 20:45:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH v3] wifi: rtw88: usb: Further limit the TX aggregation
In-Reply-To: <cb46ea35-7e59-4742-9c1f-01ceeaad36fb@gmail.com>
References: <cb46ea35-7e59-4742-9c1f-01ceeaad36fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e13c95a4-a747-43c3-837c-a145c63e9546@RTEXMBS04.realtek.com.tw>
Date: Fri, 21 Jun 2024 20:45:01 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Currently the number of frames sent to the chip in a single USB Request
> Block is limited only by the size of the TX buffer, which is 20 KiB.
> Testing reveals that as many as 13 frames get aggregated. This is more
> than what any of the chips would like to receive. RTL8822CU, RTL8822BU,
> and RTL8821CU want at most 3 frames, and RTL8723DU wants only 1 frame
> per URB.
> 
> RTL8723DU in particular reliably malfunctions during a speed test if it
> receives more than 1 frame per URB. All traffic seems to stop. Pinging
> the AP no longer works.
> 
> Fix this problem by limiting the number of frames sent to the chip in a
> single URB according to what each chip likes.
> 
> Also configure RTL8822CU, RTL8822BU, and RTL8821CU to expect 3 frames
> per URB.
> 
> RTL8703B may or may not be found in USB devices. Declare that it wants
> only 1 frame per URB, just in case.
> 
> Tested with RTL8723DU and RTL8811CU.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d7dd13ea54af wifi: rtw88: usb: Further limit the TX aggregation

---
https://github.com/pkshih/rtw.git


