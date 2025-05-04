Return-Path: <linux-wireless+bounces-22410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010CAA8947
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5203A6422
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AAF224CC;
	Sun,  4 May 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxTI6/r4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30623A6
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391924; cv=none; b=GNqhJCukfVwBITemlf03v+mRbTcbCNhprsR1jdwxdt8RfqVmBy5lNSTMsDj+6/HvmS0+eMpB7lwvhkEQX1Dsrd2rA5EoHxBgNWuRR4q6xe2BqRjh6Ly1+1lVVGqO/nbUCQTkUsV5t8ADOQcHAqS5lzm7USAG4Iy9LdSQtpYmmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391924; c=relaxed/simple;
	bh=6aYuEiEuUR6MOT9bNGymSQkVrhDhEEYY8l9LZsqVuvo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NrykXx0B/McsVVMuQXpeJH5Feqsz4PxwHAkdpEXVI9ynULuwCYr5Tj7RglqQKKwHfCpQm92/TYRa6aSJWU53aXlvKNnq7x3DN8tfBg0OtftC8tjXFolSJjA8qfQmEdNpWr0DrG4UXAHh31St64/qKQexd1fxGgJrO1dJUcH9ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxTI6/r4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso790587766b.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391921; x=1746996721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NUNQHQ3f5RRPDvBfWhXy5HBi8yHtn507yoQzMrFRLeU=;
        b=PxTI6/r4gty++9ybFgGB3wSMmD+vhleAqNQdZrjcnEWS1u8oADUJILiq+lbTeCOAuE
         LeDwB89pWgT12HLWF+i8qEFEXODeoNCVM1kulgs1EHDMc/pZvvDC77RYBtBmgxEoSzyI
         koSShVt03FCQlLK7uqmgpPgw51RLkGTj07GRhb2veIK68Cmtn+jMOvR77duhJk8rdsEe
         Rr1pKnCNa3YxyO2/00PmRaX8POgfEuL1tBsof2+MMCXMp0caPgGRGeZDcLaHJ6gIeXBE
         MMT1qCW/i2KE0qTlUXTIu1zFtubOHPXwMZZdCOHtAjOcBkVZJmf+dSVOIuLtWZ3lsXqn
         jMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391921; x=1746996721;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUNQHQ3f5RRPDvBfWhXy5HBi8yHtn507yoQzMrFRLeU=;
        b=H2/YlYIBuBpsUmOaGcQGNQipo1u3PXy/L0WlPRT5S/+2XAOJ+EcsWgY7FuNGXFZEJz
         JBpSUvvPkJvFMHVRAP9weY1Rl07D3ariIYLvRdAjY6YOZnIhs992+rGtcw/knP0zoz4s
         lkYd1P+D9ngHyQGoFZk61+irOEDWmeOS04rmP2YQPiNEEim7Wsl4Y8NVN5kPaQMG4cgk
         K6YkwvFuunlUgEI2bXNsbrnEwjuj1UQ+E1GXWOBTaQapgerMVFnvmMa/VjU10C6SCShE
         tHpLUdUYQT1VDdWP1snPIPaPCjE4DFnlN5sWBqFjUtpi9N+Xqr0WaryGX/xVcqrEBg6v
         5ulQ==
X-Gm-Message-State: AOJu0YxGxuxzp0rjggUDjAdTwDjzEMUxG1i7/vk03FviTBJoYdhfSQl0
	LOSksdZ8LCZ+5vVkLI7qhEAMyCBOnUbM/1xOfiTchfCUGcdNupWB/PrAtg==
X-Gm-Gg: ASbGnctVF5tkDS8xZmLjqBW11682bEVNGt5pnbj/dXnIq7wl1SUxgA8WbNKN3DrnIHr
	DCOG8d4y/gLe4+mvKEVeqSquD08t87kLPSiSSXaa89kWpIDUCaWFiWStQAPsVkNybQnEOx8xUXC
	oId/Ru3kTX2NxkPFgbGhcE66kgcGx6+4iYjADC2tH0uBcp8745dRgRXQ7JutPlcEXFNqFtyr1eS
	3CoQrmI0pxGJp+SlDVah9us9MB1PeNbBXTI13ONAUo86Fq6WrX7Ho1bXjFLBGrqCDCmog6hdty9
	9BTilHVPKSNro0IQBknH5dbsQtLdo5FBx66xtSpToz+u53et6w==
X-Google-Smtp-Source: AGHT+IGBqY5fqNJP72rAzOPGf2pEnXEMQNLJPgeg14MJMy3U5yeCXrr2fNe3JU1nQroyn7abpdcTWw==
X-Received: by 2002:a17:907:6a0f:b0:ac7:2f8b:6844 with SMTP id a640c23a62f3a-ad1a495a1f8mr415531466b.23.1746391920783;
        Sun, 04 May 2025 13:52:00 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189508c2csm370633866b.130.2025.05.04.13.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:52:00 -0700 (PDT)
Message-ID: <039543e0-07c4-4e46-9c79-a507a8123467@gmail.com>
Date: Sun, 4 May 2025 23:51:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 07/13] wifi: rtw89: Add extra TX headroom for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In the case of USB the TX descriptor is transmitted in the same buffer
as the 802.11 frame, so add the required headroom.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a6e67e22349e..0161721bb0e8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5251,6 +5251,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	int ret;
 	int tx_headroom = IEEE80211_HT_CTL_LEN;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		tx_headroom += chip->txwd_body_size + chip->txwd_info_size;
+
 	hw->vif_data_size = struct_size_t(struct rtw89_vif, links_inst, n);
 	hw->sta_data_size = struct_size_t(struct rtw89_sta, links_inst, n);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
-- 
2.49.0


