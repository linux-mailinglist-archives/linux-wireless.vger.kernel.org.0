Return-Path: <linux-wireless+bounces-1736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0C82B316
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F5828CAA7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0344EB28;
	Thu, 11 Jan 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0eNAbPA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9D4F8A1
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf22a89a54so1107047a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704990968; x=1705595768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWaKUFOEQs6+gB1a2uNeNHJpEyheeTWync3ztV5iZJ8=;
        b=Y0eNAbPAcIOTlZgp+CTWM4b7sJD74UJsG9b62QCJdFHvpzWOWaBNWF2r+Vp3iOoj9X
         AqVbWgIDXcwAU1fqGmJq9zLYdPUy21wq0oRJOn9PMT5CGV93Aru6h6Dt9ut2MELc/Nwt
         bpKtsDYPZYKZqa+GV8IfEhA9WPql/3HGpNYaMoViXXxPsoQjPnxAUY9pnariRa2v8RHN
         vooqCm52Q4RhSdrldPpeSvixMiW/rooz09uT3HpxA4lrz9TGAtB6Re4k37TIfeMZg+QD
         f4v48rPrfE/QIybpnAUUQX51nACcOi/eCGnxQds0BFJNj/JvldfjN2FMlYOtRKCYmLww
         /AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990968; x=1705595768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWaKUFOEQs6+gB1a2uNeNHJpEyheeTWync3ztV5iZJ8=;
        b=EyF5nY21MENQx2/tt9b1uF4nJO0vR09c5KGGzIm9ZA9mPG3GUwPwTsbGCWZn5qZVif
         EjOffKh7D6xFvLpmnR5EAdeGZRqlXK6+1rioOaCs/FjcXrwLMVcqMvaXcQbrGr45xO1B
         2Vdlr/rQSaem6luInUG5ymmWmanIvbH0VM5f1wHECpiki/ZzChM/2T/Oib5l7yss8Ugo
         sG/m4OMI65wNo2Znxpeu9iPl2n7GDhDiHdYQ3nMlbeR6DTH10If1CCQBT/6Lr7Pyndk+
         GEzAaLYt6GIIHG1S9vCfCopVF+g9+WD3lpcatl5kG3GxZPVy/TnL6qyRBtUIabkv7rb8
         Ksdg==
X-Gm-Message-State: AOJu0YzpIV6Z/vGdFcW+8AFQZB/IDY/5d3zxNTELvJ90F1j3CYCzDcJ/
	t1fXyATSoOgZmMXxMBNtdXnQBF2HxCBsusvg
X-Google-Smtp-Source: AGHT+IEqYAUZ07cLwY5ISppXHLJuG0yGOH+3YhrgQLGBpl4GhpdDi/xD+qzmJPmYV8EgVssHqR3vJA==
X-Received: by 2002:a05:6a20:5652:b0:199:4b49:b876 with SMTP id is18-20020a056a20565200b001994b49b876mr81283pzc.114.1704990968382;
        Thu, 11 Jan 2024 08:36:08 -0800 (PST)
Received: from localhost.localdomain (1-170-108-156.dynamic-ip.hinet.net. [1.170.108.156])
        by smtp.googlemail.com with ESMTPSA id u22-20020aa78496000000b006d990981439sm1377965pfn.49.2024.01.11.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:36:07 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: martin.kaistra@linutronix.de
Cc: Jes.Sorensen@gmail.com,
	bigeasy@linutronix.de,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Subject: [PATCH v3 21/21] wifi: rtl8xxxu: declare concurrent mode support for 8188f
Date: Fri, 12 Jan 2024 00:36:02 +0800
Message-ID: <20240111163603.2325-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222101442.626837-22-martin.kaistra@linutronix.de>
References: <20231222101442.626837-22-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The rtl8xxxu driver can't establish the connection after applying this series
of the patches. Please help me, thanks!

OS: Arch Linux (kernel version: 6.6.10-arch1-1)
devices tested: MERCUSYS MW300UM (RTL8192EU)
                MERCURY MW310UH  (RTL8192FU)

dmesg:
[  161.984182] usb 1-4: new high-speed USB device number 3 using ehci-pci
[  162.131919] usb 1-4: New USB device found, idVendor=0bda, idProduct=818b, bcdDevice= 2.00
[  162.131930] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  162.131935] usb 1-4: Product: 802.11n NIC 
[  162.131938] usb 1-4: Manufacturer: Realtek 
[  162.131941] usb 1-4: SerialNumber: 00e04c000001
[  162.355271] usb 1-4: RTL8192EU rev B (SMIC) romver 0, 2T2R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
[  162.355288] usb 1-4: RTL8192EU MAC: 00:eb:d8:76:23:92
[  162.355294] usb 1-4: rtl8xxxu: Loading firmware rtlwifi/rtl8192eu_nic.bin
[  162.356370] usb 1-4: Firmware revision 35.7 (signature 0x92e1)
[  163.453122] usb 1-4: Enabling HT_20_40 on the 2.4GHz band
[  163.455327] usbcore: registered new interface driver rtl8xxxu
[  163.475365] rtl8xxxu 1-4:1.0 wlp0s18f2u4: renamed from wlan0
[  186.034061] wlp0s18f2u4: authenticate with bc:e6:3f:5f:9c:cd
[  186.045683] wlp0s18f2u4: send auth to bc:e6:3f:5f:9c:cd (try 1/3)
[  186.050060] wlp0s18f2u4: authenticated
[  186.054184] wlp0s18f2u4: associate with bc:e6:3f:5f:9c:cd (try 1/3)
[  186.077089] wlp0s18f2u4: RX AssocResp from bc:e6:3f:5f:9c:cd (capab=0x411 status=0 aid=1)
[  186.078853] usb 1-4: rtl8xxxu_bss_info_changed: HT supported
[  186.081741] wlp0s18f2u4: associated
[  186.218451] wlp0s18f2u4: Limiting TX power to 30 (30 - 0) dBm as advertised by bc:e6:3f:5f:9c:cd
[  195.553755] warning: `ThreadPoolForeg' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[  231.035382] wlp0s18f2u4: deauthenticating from bc:e6:3f:5f:9c:cd by local choice (Reason: 3=DEAUTH_LEAVING)
[  233.770396] wlp0s18f2u4: authenticate with bc:e6:3f:5f:9c:cd
[  233.782081] wlp0s18f2u4: send auth to bc:e6:3f:5f:9c:cd (try 1/3)
[  233.784161] wlp0s18f2u4: authenticated
[  233.787506] wlp0s18f2u4: associate with bc:e6:3f:5f:9c:cd (try 1/3)
[  233.803705] wlp0s18f2u4: RX AssocResp from bc:e6:3f:5f:9c:cd (capab=0x411 status=0 aid=1)
[  233.805501] usb 1-4: rtl8xxxu_bss_info_changed: HT supported
[  233.808383] wlp0s18f2u4: associated
[  233.836597] wlp0s18f2u4: Limiting TX power to 30 (30 - 0) dBm as advertised by bc:e6:3f:5f:9c:cd
[  279.032159] wlp0s18f2u4: deauthenticating from bc:e6:3f:5f:9c:cd by local choice (Reason: 3=DEAUTH_LEAVING)
[  280.657559] wlp0s18f2u4: authenticate with bc:e6:3f:5f:9c:cd
[  280.669301] wlp0s18f2u4: send auth to bc:e6:3f:5f:9c:cd (try 1/3)
[  280.671303] wlp0s18f2u4: authenticated
[  280.674082] wlp0s18f2u4: associate with bc:e6:3f:5f:9c:cd (try 1/3)
[  280.688088] wlp0s18f2u4: RX AssocResp from bc:e6:3f:5f:9c:cd (capab=0x411 status=0 aid=1)
[  280.689881] usb 1-4: rtl8xxxu_bss_info_changed: HT supported
[  280.692761] wlp0s18f2u4: associated
[  280.743720] wlp0s18f2u4: Limiting TX power to 30 (30 - 0) dBm as advertised by bc:e6:3f:5f:9c:cd
[  326.035411] wlp0s18f2u4: deauthenticating from bc:e6:3f:5f:9c:cd by local choice (Reason: 3=DEAUTH_LEAVING)
[  328.697827] wlp0s18f2u4: authenticate with bc:e6:3f:5f:9c:cd
[  328.709441] wlp0s18f2u4: send auth to bc:e6:3f:5f:9c:cd (try 1/3)
[  328.716384] wlp0s18f2u4: authenticated
[  328.720811] wlp0s18f2u4: associate with bc:e6:3f:5f:9c:cd (try 1/3)
[  328.739267] wlp0s18f2u4: RX AssocResp from bc:e6:3f:5f:9c:cd (capab=0x411 status=0 aid=1)
[  328.741111] usb 1-4: rtl8xxxu_bss_info_changed: HT supported
[  328.744014] wlp0s18f2u4: associated
[  328.765823] wlp0s18f2u4: Limiting TX power to 30 (30 - 0) dBm as advertised by bc:e6:3f:5f:9c:cd
[  374.035605] wlp0s18f2u4: deauthenticating from bc:e6:3f:5f:9c:cd by local choice (Reason: 3=DEAUTH_LEAVING)
[  675.415603] wlp0s18f2u4: authenticate with bc:e6:3f:5f:9c:cd
[  675.427238] wlp0s18f2u4: send auth to bc:e6:3f:5f:9c:cd (try 1/3)
[  675.434465] wlp0s18f2u4: authenticated
[  675.437328] wlp0s18f2u4: associate with bc:e6:3f:5f:9c:cd (try 1/3)
[  675.451227] wlp0s18f2u4: RX AssocResp from bc:e6:3f:5f:9c:cd (capab=0x411 status=0 aid=1)
[  675.453061] usb 1-4: rtl8xxxu_bss_info_changed: HT supported
[  675.455938] wlp0s18f2u4: associated
[  675.508092] wlp0s18f2u4: Limiting TX power to 30 (30 - 0) dBm as advertised by bc:e6:3f:5f:9c:cd
[  721.037516] wlp0s18f2u4: deauthenticating from bc:e6:3f:5f:9c:cd by local choice (Reason: 3=DEAUTH_LEAVING)
[  723.744620] wlp0s18f2u4: authenticate with bc:e6:3f:5f:9c:cd
[  723.756204] wlp0s18f2u4: send auth to bc:e6:3f:5f:9c:cd (try 1/3)
[  723.758400] wlp0s18f2u4: authenticated
[  723.760735] wlp0s18f2u4: associate with bc:e6:3f:5f:9c:cd (try 1/3)
[  723.774653] wlp0s18f2u4: RX AssocResp from bc:e6:3f:5f:9c:cd (capab=0x411 status=0 aid=1)
[  723.776369] usb 1-4: rtl8xxxu_bss_info_changed: HT supported
[  723.779249] wlp0s18f2u4: associated
[  723.847090] wlp0s18f2u4: Limiting TX power to 30 (30 - 0) dBm as advertised by bc:e6:3f:5f:9c:cd

