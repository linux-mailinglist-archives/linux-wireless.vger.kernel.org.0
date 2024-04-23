Return-Path: <linux-wireless+bounces-6712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF58AE324
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF50AB23A46
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB45768EC;
	Tue, 23 Apr 2024 10:54:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23767C09F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869655; cv=none; b=UPFyXffxcOzklOXiT+hQ8cp6g6RiMWfEobU2p1f5UTQ6BJOenhM1XDlvxdbpUoRAXb9l3vWI6v1FDpz3WF6FV4VxA4vT/qaIVoRb8Qsqebm9T8g8DJv0FQHUg3+YSIxxw78sRThBPrg92LnJx7dWltSnh075u07W8p2fFZoICJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869655; c=relaxed/simple;
	bh=RC4yRHaJQnnRVus39AvNH1o/IyIimwuSA7o3ErMWDtU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=opf8RxCxjkAbkvVA7lu4vcHqFpt9ZfWaKoMNtP70S5aga4utKdVP5MEg+m4LRWqOvgm1P02PQqYgM0+q4GIaEPR4wBM8LiR0USI7PzWfCuH2DO7QflEK/c0ToOgjWPpbdIdsVzQQNu7b3oT3JZ1y7NVLMbn/2Z1vi3vCb+wdnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43NAs99S11171305, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43NAs99S11171305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 18:54:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 18:54:09 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 18:54:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Add separate MAC init table for RTL8192CU
In-Reply-To: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
References: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <adb078c0-e78f-4bc7-ae77-69a93c6dd292@RTEXMBS04.realtek.com.tw>
Date: Tue, 23 Apr 2024 18:54:08 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Until now RTL8192CU family was using the MAC init table from RTL8723AU,
> but these tables are not identical in the two vendor drivers. Import
> the correct table for RTL8192CU.
> 
> Also move the existing MAC init table to rtl8xxxu_8723a.c, which is
> the only remaining user.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

110951b8faa0 wifi: rtl8xxxu: Add separate MAC init table for RTL8192CU
fbeddb4a767d wifi: rtl8xxxu: Add LED control code for RTL8192CU family

---
https://github.com/pkshih/rtw.git


