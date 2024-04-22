Return-Path: <linux-wireless+bounces-6694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A548AD6B3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E18BB214C9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876121C6B7;
	Mon, 22 Apr 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A90xos3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FB1BC44
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821920; cv=none; b=buNKeWa8tj64vXzn5BeiBVFjqVSDVurFlWhzSA9cEMwJoXy2uDWmj1rREdYE9QRLibTiRp/oA2juZoqJALhgcQHqKdJLkXfo1KljegGR6M3Hd3GFqXZF17aXQA7zEjIcfjjbwKU725XKNdQz+OFK52N7hzxG09eT5JpOxfDLSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821920; c=relaxed/simple;
	bh=ajPxnt7gCx0vfajBZutwiSuj827lIiwYHft8666EiNM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jZqIFBOUm1qac41K7icqzOdx9yNL6XrOr/tF1t1sLqvZD45Dtr/LBgYpe0kZrquc4OBdWJG4Dam6sJyTgR4XDgED/lB+s9uECgcMOrQlIg8EawQcGqOkdK7voPDdGmXrH1pXBLUQlBunfZdhCGAfUp9hgy+E8NB0LsSbRY39Ih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A90xos3S; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56fffd131a8so2113566a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821917; x=1714426717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulibjzx9i2fQGA5kvBeDnDdAF3MfC5guqlFISqU367g=;
        b=A90xos3SppKSt5hfUARXiGFXtjxT1CvBSbeFJ35lkDJJJqbEA4EUavwT+DPI+Ofwrp
         4cqUhPSOfUsljocSHBfPADStMHMFL4I43dTFPBGt0m2WP+B/L3wIqIDJteIBheH5Sl4b
         UIMeRhzv+UbKBTGGEr9IOG34B/aabUBDqpsLNlaYr+n8PMpypO9uhfc0lhPlRXrX6DX1
         ZgAsoQB8lJ3GlUxIQ6T4stqdCHuNgzUte0tq3xEcwSFyuBmIGlyI/wrm4h/y3rYM88DB
         wVX/ixUwSlvyXdh1so39SIV8IQcqRtQUZEJRz+QsJ5OR2U4GkaarVzGRkh8YVu+17iP1
         y7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821917; x=1714426717;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ulibjzx9i2fQGA5kvBeDnDdAF3MfC5guqlFISqU367g=;
        b=qFdNv6taig+4vRSy1auaM/UiCO6x8OIi4+NnH7boIDjRlbdk1w/VS8kg30hPcapJIY
         k697WY2pBtTBph2P5fuLC8N+9t9FnpwIOGj2R5HpE3IORxhQApVgx0oJTTIwWVJWfccD
         iD5A2ywU4wLXd6Y4i71gFF5MAy1wzaZT/YdO8FuPmfhYh0AoQum+PDWV1n8CJrV4vNPi
         VQY0cVsG5E38oNIztas9n4T3N5SLIZr2JixMg1afErKeJ8x+A2uMGgSNUYB1o/OxVsu1
         01yQ1i+BW4YhoJ+sUqP1HgeQM6ieMoNy/ZAKhbL1Yp2/cgLv8Fx8KGlZcIMyhiH9lFmT
         msxQ==
X-Gm-Message-State: AOJu0YyTf4el0J5P2rJuY/u7pV3Qpsj3IUqhtVY7Hbwon1J9nVrqt03M
	SqXFitjR4HQBK7/XMkMHWQHo9x+ScjmF8vWMciZJA0wPaBhbjB12miWJf/5M
X-Google-Smtp-Source: AGHT+IH1cWs4Ok1CmtAnM3kriDH84eX5tYLSzPy26xqCw/MUTMAAPUgvXPUgWxM1m3cx/wu7bf5Ptw==
X-Received: by 2002:a50:d699:0:b0:570:5b70:3407 with SMTP id r25-20020a50d699000000b005705b703407mr8537608edi.10.1713821917066;
        Mon, 22 Apr 2024 14:38:37 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id q23-20020a50c357000000b0056e672573e5sm6237356edb.88.2024.04.22.14.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:38:36 -0700 (PDT)
Message-ID: <7df66d1f-87a1-4f44-9aac-ce75438abde3@gmail.com>
Date: Tue, 23 Apr 2024 00:38:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v4] wifi: rtl8xxxu: Add LED control code for RTL8723BU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Software control (on/off) and hardware control (automatic blinking)
tested with EDUP EP-N8568.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Add empty line to silence checkpatch.

v3:
 - Remove unnecessary braces to silence checkpatch.

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
+
+	ledcfg &= LEDCFG2_DPDT_SELECT;
+
+	if (brightness == LED_OFF)
+		ledcfg |= LEDCFG2_SW_LED_CONTROL | LEDCFG2_SW_LED_DISABLE;
+	else if (brightness == LED_ON)
+		ledcfg |= LEDCFG2_SW_LED_CONTROL;
+	else if (brightness == RTL8XXXU_HW_LED_CONTROL)
+		ledcfg |= LEDCFG2_HW_LED_CONTROL | LEDCFG2_HW_LED_ENABLE;
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


