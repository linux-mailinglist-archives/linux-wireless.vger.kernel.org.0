Return-Path: <linux-wireless+bounces-6376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372F8A68FD
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8026B20816
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32041127E32;
	Tue, 16 Apr 2024 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRfVKsJg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9784FA0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264543; cv=none; b=cG5eFrK/TiTaoZ2/bWz9wXZcqxPN1UeU5F7HeO36ovYmWeHZz/RI3jN7810SYenLIJaUSIUCzP1Rpnznw4FLQ/UvdGDAw8Wskro9RZGtUnSmZoPATYmrzg9FbEqkuysvhcIrgTosijOAVPTAh0kVNL7yQs674r21+zmksj/jw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264543; c=relaxed/simple;
	bh=l1WODMEkpD/vtalLFVe+QYBgh3moc/L2lDCvsW6aUM8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HK1evxg1cHpEW9NgGTeZHWUvipCLTP9arJ9dBEACq2ALlntJSNZU/wiVwvUA9DCydyZgTw+p6HO8BxObYlNnbSXoPfz1WGDm3Xk7iX2gNSnfng/pyCOyD0qUSPBmlqfm/qngyRGU/C0Ty/uEWxZkS8MVQWshaPqNvRazorSz1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRfVKsJg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-346406a5fb9so3252153f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713264540; x=1713869340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b83sboEqTPego8HsvJMBEhEEo8zBau4fa8NN9fXFIf8=;
        b=TRfVKsJgP+FsX+7WcFrHfaK7/MYLq+Pv7Tj8E0tmON+rre0sU25s4Efqr6OCdDTx1/
         YWhnNfj71+GVpGM9akNM6IsEepO3nzsnFqqsMD6c0LBoVyKcIxXxwjZ42Ia3TDGESbKS
         bKKA2wdoZxnfbZ3RWOF8x/os+8SHtmblUZEnhINdI/p4rmrRQOh4JsKV9J6WCDH+Hwzj
         eQje3Zoo4Qm8Yqb2A/DOn84l1cQSZHfqQueuCYshE1PFyj2kQz6veS3JRWN98mFsUpsN
         9/o/cqFcHet3LtjyQTF9DihrTkJWIaIPaIGM79zrJZEkFtciBxDq9wc0WYFV4DTyZ+oi
         7bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264540; x=1713869340;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b83sboEqTPego8HsvJMBEhEEo8zBau4fa8NN9fXFIf8=;
        b=MFYpH1qqOO+ss92owD1L20c845nn36hz5Qi9ez58C2c2G+MbeiH2Vip34MH038Hspj
         LO+PxsuFRmCQiqmaRbhiJfeQLk66cinY8HuvDjpIfBLKme7uG7zAwmyaa+tLo13PCqhR
         HVy5Q69fXz//jCMtCmoKdU7ibXCyuGXwsR24Ye1DVJ6tC4tB5Znxm1VQqBOepqa22Fz6
         P7U1O95j/CVrHzgxlVZMrw6np1JENrQ18ueNUf2bC4GhTHcLrscYYuXFHefpvFw5DxH7
         iPDBcsG2q1CXpeaYkgpfm1c7lgGc6CXL6423nF138IcfrVwEnA7+4i+d4tIQhlOt5sKi
         XN2Q==
X-Gm-Message-State: AOJu0YwypUYbQm8GfN6V0+QyPx1PPNxQ0p0NUwTOHff2ELDqSMfwps4v
	AkJF9lLwJAiU/7HfAr4TIYhMe/Cw0RHMjs8EUehBjUJljqEWYpOVvgPt04xR
X-Google-Smtp-Source: AGHT+IHRnAsV0CzRuE48P3CnZzaG90F9p7Trk89VHsCVbaYygNns/H0qIs1FheNFvSIvBMKOxHqKRQ==
X-Received: by 2002:a5d:6d84:0:b0:343:6ca4:97e8 with SMTP id l4-20020a5d6d84000000b003436ca497e8mr9896890wrs.45.1713264539687;
        Tue, 16 Apr 2024 03:48:59 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id gb32-20020a05600045a000b003462b54bc8asm14488924wrb.109.2024.04.16.03.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 03:48:59 -0700 (PDT)
Message-ID: <c0e93225-4672-48ac-9bdf-9d0fad00116e@gmail.com>
Date: Tue, 16 Apr 2024 13:48:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Add LED control code for RTL8723BU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Software control (on/off) and hardware control (automatic blinking)
tested with EDUP EP-N8568.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - More information in the commit message.
---
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 9640c841d20a..c677a47ed46d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1701,6 +1701,28 @@ static s8 rtl8723b_cck_rssi(struct rtl8xxxu_priv *priv, struct rtl8723au_phy_sta
 	return rx_pwr_all;
 }
 
+static int rtl8723bu_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct rtl8xxxu_priv *priv = container_of(led_cdev,
+						  struct rtl8xxxu_priv,
+						  led_cdev);
+	u8 ledcfg = rtl8xxxu_read8(priv, REG_LEDCFG2);
+	ledcfg &= LEDCFG2_DPDT_SELECT;
+
+	if (brightness == LED_OFF) {
+		ledcfg |= LEDCFG2_SW_LED_CONTROL | LEDCFG2_SW_LED_DISABLE;
+	} else if (brightness == LED_ON) {
+		ledcfg |= LEDCFG2_SW_LED_CONTROL;
+	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
+		ledcfg |= LEDCFG2_HW_LED_CONTROL | LEDCFG2_HW_LED_ENABLE;
+	}
+
+	rtl8xxxu_write8(priv, REG_LEDCFG2, ledcfg);
+
+	return 0;
+}
+
 struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.identify_chip = rtl8723bu_identify_chip,
 	.parse_efuse = rtl8723bu_parse_efuse,
@@ -1731,6 +1753,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8723b_cck_rssi,
+	.led_classdev_brightness_set = rtl8723bu_led_brightness_set,
 	.writeN_block_size = 1024,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
-- 
2.44.0


