Return-Path: <linux-wireless+bounces-10428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A559938DAC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 12:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA16C281A00
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376E168498;
	Mon, 22 Jul 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3rt3AWU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049F1B977
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645440; cv=none; b=e0gAUCUg2gBhsYsypEijZXpb+RZNQiRFi3ZJ0rgisWXk/tsQkRF4noPzTeU2o55FBG4vvUZI/jkVHcUua4mp3+g8Z/vmwTwXaXFNGnOpl3jGggAS69oLLpmHUvnxhY5XW01JX27cGDOthC5dVZIx1dkMO2KEHi9XkURAFNbu1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645440; c=relaxed/simple;
	bh=aLvRISfHWsDXunOrxRg0QPym1BW+dnjPb6b2oyGKJIQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nyRBQa7uREh3A7UoIKeFZNifuE1JQgtU6VRbs+LJIHiPkji4zqC+gqId5k3vJj73wuKpmAl5szUOI4uPecEyg7Mf+jlzwhAkrpsiH66BXHh8bTgINEMOHXBFSlqkvCOsOPGkfD1tBaK8UaqmQ0rb9rhQRT25PEDrPzFV4bfQSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3rt3AWU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so3377132a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721645437; x=1722250237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XdYOM+yhonSxVm3KG6txmu/CkLzvekzG+71K/RcgCw=;
        b=P3rt3AWUVnRmB3tYM82j/SMrA+yYc4slGKe5EEjNTXi6d4odSu4StDVUE0uCtlzK9Z
         McrGIk9IIcmiwJg7+YsD/rZzblnzJE85LGgi869GyeRR/Gb1uIhwe7mk7u/9QpOcHpvX
         HLJ6d4a6huGeb1cgasKG5WT2st598oXz2IdGJTjicQSMZ34REOuEIYlRyeK7rvR/Ke4I
         gutb7IHbPVHMZLhFclN6jbnTLWokjD/8jVBhMgQYMLwup8CHk3OHSXsc7qu7ooIcwBfz
         L0DtckWm8BzPMu0eRm/TAJj3ow/V58pwG+yIKM+Huokcmy+FVVWMwt1Z8THNKARDZ00J
         SOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645437; x=1722250237;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2XdYOM+yhonSxVm3KG6txmu/CkLzvekzG+71K/RcgCw=;
        b=KO+3p3wL/D3wpuq3gsbsx6o//q1Di93GcJLnI74FqJwMgt70siZqEZ3B4D7ctNwZ+c
         ErxjhlArKPyc6CV5r+GIo0SQqQFRRZFzT9YA+gEU/1474UFeUc11yeGlyFWKBG+IhpUg
         RsUroXPNjzSWg/20scCjw07DOq+5Ip4xElhooWr8cl4f7xYJs5IYCHP8VzD2/k0mVDgg
         b4CJ5JgjNLAjOHor53t+gp7V0p3VtbpAeI03bWuBU62a2LsJsv5ZC8+eLlvYN8QvP3oO
         qw8UaHBKqeEdYstGYg7O4XRL/W/4iSZ9dG4lzA1VDyPTeqvaPMqUy0n2j27CbVieH/Z9
         BPzQ==
X-Gm-Message-State: AOJu0YyQjg0iPSr39rFPQ+57KpSPz73WZLMXSZ+NgJxWxoN2FKZVSuNz
	vJq90bwcQZBFa9uGFOtHNGUlJMAuIax1cmOUnwrz8H0txMqYXEJQMIGB9g==
X-Google-Smtp-Source: AGHT+IGqL4bRLYBZfy+wE/Kwq3KsEtHwQYze83XQD+cP5bHj1vYxskMBYFXhvvFl+3X/1pBjNKNewA==
X-Received: by 2002:a05:6402:4405:b0:5a2:b867:3bcc with SMTP id 4fb4d7f45d1cf-5a47bb8e893mr4011135a12.38.1721645407384;
        Mon, 22 Jul 2024 03:50:07 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a3e642b647sm4816502a12.55.2024.07.22.03.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 03:50:07 -0700 (PDT)
Message-ID: <d3267712-e458-4a02-9408-f3d443185207@gmail.com>
Date: Mon, 22 Jul 2024 13:50:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/2] wifi: rtw88: 8822c: Fix reported RX band width
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"iw dev wlp2s0 station dump" shows incorrect rx bitrate:

tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
rx bitrate:     86.7 MBit/s VHT-MCS 9 VHT-NSS 1

This is because the RX band width is calculated incorrectly. Fix the
calculation according to the phydm_rxsc_2_bw() function from the
official drivers.

After:

tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
rx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1

It also works correctly with the AP configured for 20 MHz and 40 MHz.

Tested with RTL8822CE.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Use Fixes instead of Cc: stable.
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index bc807b13e9ce..e265a35184ab 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2612,12 +2612,14 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	else
 		rxsc = GET_PHY_STAT_P1_HT_RXSC(phy_status);
 
-	if (rxsc >= 9 && rxsc <= 12)
+	if (rxsc == 0)
+		bw = rtwdev->hal.current_band_width;
+	else if (rxsc >= 1 && rxsc <= 8)
+		bw = RTW_CHANNEL_WIDTH_20;
+	else if (rxsc >= 9 && rxsc <= 12)
 		bw = RTW_CHANNEL_WIDTH_40;
-	else if (rxsc >= 13)
-		bw = RTW_CHANNEL_WIDTH_80;
 	else
-		bw = RTW_CHANNEL_WIDTH_20;
+		bw = RTW_CHANNEL_WIDTH_80;
 
 	channel = GET_PHY_STAT_P1_CHANNEL(phy_status);
 	rtw_set_rx_freq_band(pkt_stat, channel);
-- 
2.45.2


