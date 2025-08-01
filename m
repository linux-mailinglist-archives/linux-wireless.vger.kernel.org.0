Return-Path: <linux-wireless+bounces-26087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB4B1883F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9585188CF3B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9FD248873;
	Fri,  1 Aug 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYm6ogaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C16218596
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080735; cv=none; b=XShE4uO9EEvoM6o8miXSPifumC5KgVDw/E0VZiW8QkaKpXa6GdcW+t6f+JhnuJQULclMaQwECon/2ruNf8lpDTUc2TwUgJUdKNq++NQ2eqbKFUNbrJVqfp05mzdT8xJ7N9lCAr8+DTd5tFHkSKTkvwB33wx5ySul4Z8B9V9mqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080735; c=relaxed/simple;
	bh=J6fsbq+VJijcWidS9RQXgGbhzkRR0aRD7C0PCQL9Ijg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LjXDP94DvsRcxRf8EXP+hNla8L5nhTop4Qb/2dDljhJCw2fhtndBoh/jV5QcMDgx6XnPVOGnILSmqhjA/yem976rleuFe9AoWyqujzzLUPMl7R0Fn8OYlIbDk0+CGv7uBRfkSJTCeyFSeb1qxzITaZFdfBl6gCJbkhlAmfNiZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYm6ogaQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso4942689a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080732; x=1754685532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qLhDqMwjYH8xtSYl9RuD8nBKqI0NrKxN2VL6h9H5iD8=;
        b=eYm6ogaQU65x1AVHwMdVOK1l/QbfdNZ350W3LwLy+W568lkSESKOUdnAb8BtFJiOnH
         vDJXnrFTmqxMY/Lk/nx25UWPcFomb7CrS20RIY8Zjk3jyhpSKJek9zpX10GoaM+8+3mE
         DvGrpcntw0yOUuIwYv3CezQLHa46PFLpKGT+jQsaRCO9yZzK0CaNfHbTCGJpD461KZ69
         yRZ1k+7kIo+fUdMzLkmrW0NlepNYYF0fM1YyHmZaT5i4ncoLLMvjsU7gbS5Z2WrDHiza
         W5eLGSoq50FSB8xdIVITbq4FJMdrAI36PTEhp0IQWqcURmC1r06/3zZrqfPk8GutJ/cS
         BSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080732; x=1754685532;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLhDqMwjYH8xtSYl9RuD8nBKqI0NrKxN2VL6h9H5iD8=;
        b=JP/XsRQcQM0SnZS2/tJWSUYCOdNsFYyLZktP6uGT4Bm2zWHn5CE85pxw3LRk5YlCV8
         +c296loZmwcHB2CjqRUxu1Ho8g04KpM/2ZR5SNyNuJdU2PIFO1XzVYKz20HB4yzTNscC
         wOBiG9fF6GBtcbPaHVykyhs76E5xjYrDlEo7mmQVtul82nFVX9+HYJYJlCId7X77Hkhh
         p5SEtbBcOLJ7Hcoyd5nN5Rb7YJWyjxavc/YzcFqJ3Ws3htv2gzcQbRZm25Nh3jQmv39R
         AXcAwmsYZq8HDNsEKDahvJDW8NZSH57fgYcHnHZIKdE42qQjSrt544+sSX8TXgk5m/It
         vg0w==
X-Gm-Message-State: AOJu0YwneRhiD4jvLHj4ahS6lCjqHnqkmaJgW/ye2dpRItw1Wvdp4BTw
	qIHRU2EoDhR1Y6osUcGuMqhVO1AEJJoluGCvt8dqIqJN/kKvFw3uEuQFZ7TyNA==
X-Gm-Gg: ASbGncspNr1W3m8ZTaWWE+RLWfctUskmycrTLgip6qSnqoPj+ZQB8ryL7Hx/9yOpp0/
	iEcKA5hyVc0aJnE/R+TMC4Sh7mZLW0itadPacTuey8ToRKuMTwdEjQYF85WRV22cSAfQ+IzhMVs
	rhL8ePSTpVF4xtCs6yQzZRFNJYKKbqEv74DFWh9n1rBgMbnlJYCYLEab8Yorm2nHVU3z4TFbXhJ
	fWF7Nk+sN1joMSCSEtqLg7MkhuPlcPibomww1sMSa/wrCGMp5efxWSzJC4mWz02lbNG8q9PhcAe
	5CAkfJJW9uUhK5E1d9Jk/aDbaVrF2bK6J5It2AbBVrHyxeL0IL3jwGikdc25+twO0J9lgcXUfd6
	2TERSAWhLDGmPA4MNMJPmN8MaJkPnQQ==
X-Google-Smtp-Source: AGHT+IFjiKSoDA1WTiJZNF5xRl06rQ1+dovcL4QD7q5/jJtanzW9Jv/De2r4DcxL0Qrqa1fZ8t0zWQ==
X-Received: by 2002:a05:6402:5210:b0:615:b9cf:ef65 with SMTP id 4fb4d7f45d1cf-615e6eb6c15mr580793a12.1.1754080732271;
        Fri, 01 Aug 2025 13:38:52 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aeccsm1741397a12.2.2025.08.01.13.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:38:51 -0700 (PDT)
Message-ID: <bac2edf7-b027-4eef-a67a-7a4c3b3f01d7@gmail.com>
Date: Fri, 1 Aug 2025 23:38:50 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 05/11] wifi: rtw89: Fix
 rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Language: en-US
In-Reply-To: <2527e1be-3121-4f29-8539-72f4bfb225a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the DMA mode according to the interface type.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fce48ac97a02..2d473f1bb66c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3979,8 +3979,15 @@ static void rtw89_mac_dmac_func_pre_en_ax(struct rtw89_dev *rtwdev)
 
 	val = rtw89_read32(rtwdev, R_AX_HAXI_INIT_CFG1);
 	val &= ~(B_AX_DMA_MODE_MASK | B_AX_STOP_AXI_MST);
-	val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_PCIE_1B) |
-	       B_AX_TXHCI_EN_V1 | B_AX_RXHCI_EN_V1;
+	val |= B_AX_TXHCI_EN_V1 | B_AX_RXHCI_EN_V1;
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_PCIE_1B);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_USB);
+	else
+		val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_SDIO);
+
 	rtw89_write32(rtwdev, R_AX_HAXI_INIT_CFG1, val);
 
 	rtw89_write32_clr(rtwdev, R_AX_HAXI_DMA_STOP1,
-- 
2.50.0


