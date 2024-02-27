Return-Path: <linux-wireless+bounces-4080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EF869035
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC6B28717
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B113A250;
	Tue, 27 Feb 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YncKY+rs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239813AA46
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036159; cv=none; b=s+JLDQDqE69u80OXNF5K3zE6PVJC4R+BTU/nFrxGs/8YpWhlqbyaHTm7S2Qv/sFDZNAVJmOnLJzvzCfnlfEe7yHRQazXRCRAhZieiMF249DkYMc2ptCdpj1ineq25pKRjNgJIMHEulFYEb7jzQGM336o26NmGz1PjGG+wihz7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036159; c=relaxed/simple;
	bh=Bc+tfR9PORnAejShRTyuqC1VzC8XAup7i/x1Cu1o+gk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZE47ymBdkNe0v1MyGpr9aQ89F4dfHO1SGtfkytk+grC9JGNTGkFtQKVGNIJYX7DcmQOi7xEPpbSwmXpH3IBSOsdQOhUXzosWtuyjFnnvMnL092Fol5PwOmAjgWZqubmPJvoBemBZMMLh9BXKL4bUR/Ztq/ZNV+XR17AsFo8RqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YncKY+rs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so578300466b.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709036154; x=1709640954; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9UFfMpj7LvbT3SKdAwiLiuI9hFcnk3TnXUHrA8lk2E=;
        b=YncKY+rsbKq3wm70o6TDGplv1kohr566CH3S/sS8dNttLExGjGj6jEZkXoZiQLDqdB
         Cgl8nLXkVRqLoSQ6+gnAyref6uPzxZj6Ua2cnsNPyyjH9DxJlOjUEOALMUmmba9YuRqb
         Bc9wlg5sruVM7ELsOBDqZ1x6YJe0fmIJPeWwYGdH8EvRb//nARtOWmtGZUxH0Zn97Gh3
         4ulHgnXsprF7PIucsJDtoyTbuN+RhGanZ4AX5qqpTnra5Zgdg8FBMSRCKlV92da1jIPk
         WYz7prdUGw3ENJW4bDaA5WamQKaRE80Gz9TSGU/iUK9aLA5MJURNrr9lqC9Ye6prDI75
         9KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036154; x=1709640954;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y9UFfMpj7LvbT3SKdAwiLiuI9hFcnk3TnXUHrA8lk2E=;
        b=ZMHD6R6zoZpIU5XD9O0rhNyOOkhbfECPsWyJp882MYf2VH+gehqf0eI0cKPBuT8wOn
         yXH08YSamUxwY/lAffVHcjU7GrsVZbDwy3h4FXQLGgUsv9V3m6dM2f+bhs8XHpAAfdOs
         ZmyO8g6FdxvWd01M1rYaqjXt6JCBKUPJ2uK+W5+0XG573Ako9cYPJzAMbwvdsdDEHErI
         hDK1sHAySOaJkyXobZSun9HHXBD5rosjEnsINg6gy9wTP+kAhkoqP9t+P8nJ43F479MW
         zKcRNHNoZ5GvqZY6X7lHDzGURqoxdgAFs26e5LfXWQAqmeo4vkDSxhFUbqFS0qfWCP7R
         StdQ==
X-Gm-Message-State: AOJu0YxoqiO+CJC2CJZcdW9Pq9O0F9l85CAKL+viygbRAmSnF1iEsxAA
	y/0yzFu/ilCeHI8wRJ+5xvbbEUZMq1EHMuIJWrR4AnCz8yoLGjDa3QrYLW5M
X-Google-Smtp-Source: AGHT+IF5eO9k1z2LgXURinXTBqZwlJ90bA95n+KQejQ3v+FuLRL0UGJpWFdJkhtgnHn63xHqOgjJww==
X-Received: by 2002:a17:906:f144:b0:a43:3f37:4d94 with SMTP id gw4-20020a170906f14400b00a433f374d94mr4211857ejb.16.1709036154270;
        Tue, 27 Feb 2024 04:15:54 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a43bf7ef577sm321678ejc.188.2024.02.27.04.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:15:53 -0800 (PST)
Message-ID: <4e2c968d-f25c-4a40-be97-4fdcbdde69cf@gmail.com>
Date: Tue, 27 Feb 2024 14:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: Remove rtl_intf_ops.read_efuse_byte
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

PCI drivers and USB drivers can both use the same function,
read_efuse_byte(), and they can call it directly.

rtl8192de was the only user.

Tested only with the upcoming rtl8192du driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c          | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c | 6 ++----
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index d059cfe5a2a9..11709b6c83f1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -2374,7 +2374,6 @@ EXPORT_SYMBOL(rtl_pci_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 const struct rtl_intf_ops rtl_pci_ops = {
-	.read_efuse_byte = read_efuse_byte,
 	.adapter_start = rtl_pci_start,
 	.adapter_stop = rtl_pci_stop,
 	.check_buddy_priv = rtl_pci_check_buddy_priv,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
index 743ac6871bf4..4ba42f6be3f2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -1669,10 +1669,8 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
 	u8 cutvalue[2];
 	u16 chipvalue;
 
-	rtlpriv->intf_ops->read_efuse_byte(hw, EEPROME_CHIP_VERSION_H,
-					   &cutvalue[1]);
-	rtlpriv->intf_ops->read_efuse_byte(hw, EEPROME_CHIP_VERSION_L,
-					   &cutvalue[0]);
+	read_efuse_byte(hw, EEPROME_CHIP_VERSION_H, &cutvalue[1]);
+	read_efuse_byte(hw, EEPROME_CHIP_VERSION_L, &cutvalue[0]);
 	chipvalue = (cutvalue[1] << 8) | cutvalue[0];
 	switch (chipvalue) {
 	case 0xAA55:
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 01df00a43cdb..85187390b7de 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2292,7 +2292,6 @@ struct rtl_hal_ops {
 
 struct rtl_intf_ops {
 	/*com */
-	void (*read_efuse_byte)(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf);
 	int (*adapter_start)(struct ieee80211_hw *hw);
 	void (*adapter_stop)(struct ieee80211_hw *hw);
 	bool (*check_buddy_priv)(struct ieee80211_hw *hw,
-- 
2.43.2

