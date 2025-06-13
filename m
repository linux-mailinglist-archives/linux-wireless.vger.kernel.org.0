Return-Path: <linux-wireless+bounces-24088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F90BAD84ED
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856443AE617
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5662D8DB0;
	Fri, 13 Jun 2025 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM3tyTAH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5072E337E;
	Fri, 13 Jun 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800535; cv=none; b=CY6a/I+qowU34WJkV2soe4Idz2N8FYHvjL7ORTvULjcV8vcNxcyxrBAjVFnuSbREPtWS/npzmKmpeiZxTiaOigos84X4dX+R1xr8AlvgQm2UYtnwJOGhvfIBMfu5DDGRxbJ4gvHWllhHD4L//ytALacCrmcKc7ueWoM2WdayMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800535; c=relaxed/simple;
	bh=c4VPRTpmVLRj51P1P/drS8KkDTxWgLY6SmOUwd3FyJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLaMrF5dpyHl0ckglUaeam9BmqLYqNRj2sjjVoV91mfCJKS8OYmEZklLrBcIPdLWiyjKTFWhLQfewIpKOatm/66AHfk3UkUC+IWrlC/XvXdIW4wECs8MWULWH4UgYxO7+vhWnhro8SQT9V5pVUCiC+AIPfzscT0Gk785vsJNGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM3tyTAH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4530e6f4db4so1669795e9.2;
        Fri, 13 Jun 2025 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749800530; x=1750405330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mHRCW2P2LDNhBI8HSjh6g8BIpo2V/XePOS2AmYos8w=;
        b=EM3tyTAHZ4vQMPbujSWWp1Gkzb3ZPSIn3rk33DwT6K4lSc+jeL9J8N27+CixW6fYT0
         1OUxtpctKxaL+aPMMbnphqVwNR1XKRSZfjHVOyFgY3bXOCEIAbcaqq53FBNliiCxh3G3
         KBAWtWz/gwhwx20DAaaGfORW5QNNvWDM9wUa4iMV9BdZsJUrpy2as4i2q8QcZAXpvyEM
         fIHzaCJHRg3EEf5UUFTVuceR97qKcpxdKWI1T5T/pXYf9699zpAwscPyt5gNJhb8Tjrh
         pp/uhOTu0vFyGpP00bsedA1EK233qj2Fj6ZAFoP2N4x5QakM6Za1JqskTMYw1W5MjxmG
         lV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749800530; x=1750405330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mHRCW2P2LDNhBI8HSjh6g8BIpo2V/XePOS2AmYos8w=;
        b=eT5zvoyUJWJ07oS/JKAGZdI0AGieeCeX8qjEK9BkYosVGjMv28f7MF9sgSoJDdB9xe
         LedWz/e542dLzXW+T5bWi6PEUH/jxJpumH8NlU6eOQ+kk3jBc3FW9ArKqVHowPM/kk6J
         EYdt+3+JB1lZLcldIqSL4ThrT3x3lQlly4PsAwKAOC51BzZG6C7h4vYtkTQsYKsEWDnA
         X2dqpzO2FlfyKc9lpFy0Y6+9UOK+KckQTdJX7Mz5vg6Xh6ydK0Q14x5eTLbgjcDFfAgN
         gHO5ccNZy4rCShWkJm25d9/TVGeRr6MJu+1YdNSIixRxKEAgJ4sHMJROVZZt9MxnlSy5
         ww0w==
X-Forwarded-Encrypted: i=1; AJvYcCWuHvg+pCgaS64pMASSiQN+kwesl+JgC+WMzwGmuUn8PVwaUZVRlK2fCZBhOXW29JPbv/CZUjlD6g0LhKFyspY=@vger.kernel.org, AJvYcCXB2lFBgl0WFjVC+qWJ2+ftOCUDTwIaUsWDohauj2LWBjVbYXjFNeV8hHr6d3xvfsimqJZt+WH3gIqpQpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxggJlGij6LCQwudKWgrIPbq7lLHSKyWCI3Q7z7v9zBoohp5e1b
	68emfWH1MSA++R7mHAvW0DhOfbbqIZWVkdOC9VcTRfe0v7Y1ubAmt/Velj1LnVJP
X-Gm-Gg: ASbGncv4lJ1qbMVFpF4CQJ83srWmHl1gzh+i5nSXXdD0qJjAdrm0XM5XTLNDwVtDl/M
	vHxHOCCd65NElSul3WFKQAx4BmJ6DOnuBuBlJK039osRYM/ncjnyNQz/agae8EV8/j4f48CwM2G
	+KC0O+a7FpIphxu8Cvz7yrF08FiPenO308Mbx5frCsMOypq83yp1QGcZhvrnSzdw1IwKpnJUEUF
	zFXIvVIM95/VYRvCqoHqqhSve/4/5nZDly0M9kEbZy/AHooPN/5nlwP+ZtjuJrMfoBcYUm+pDv5
	kMD2Km+j64BhF1PowAg78WEiRE8zIQY2HuYT64AH0lcrTxKVVMnA2qqfl5PjMg1bFICNpMSC0ll
	tsPdygDA41rnSjbeBrxuebsxa+PlrDmDEJ4k5e6jFpcVHAAlnBNtiHDUtISGUGfFTcD4LLs5OWO
	Wp8Q1973Mh
X-Google-Smtp-Source: AGHT+IGX3ElMSuMPQPMhJruu5vPH6ifXwBOMevT//Ehz8t4/ajxGCobDDyPCH92F6MevBuNrEmCMwQ==
X-Received: by 2002:a05:6000:22c2:b0:3a4:d30a:7633 with SMTP id ffacd0b85a97d-3a56874032cmr674690f8f.15.1749800530234;
        Fri, 13 Jun 2025 00:42:10 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec300ef49063bf04e52e9.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:ef49:63b:f04e:52e9])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568b08785sm1518728f8f.56.2025.06.13.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 00:42:09 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rtw-next] wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
Date: Fri, 13 Jun 2025 09:38:36 +0200
Message-ID: <20250613074014.69856-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9800869271a34ca3835743207c0a4109@realtek.com>
References: <9800869271a34ca3835743207c0a4109@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `dma_mapping_error()` is true, if a new `skb` has been allocated,
then it must be de-allocated.

Compile tested only

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 898f597f70a9..472072630f8d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -572,8 +572,11 @@ static int _rtl_pci_init_one_rxdesc(struct ieee80211_hw *hw,
 		dma_map_single(&rtlpci->pdev->dev, skb_tail_pointer(skb),
 			       rtlpci->rxbuffersize, DMA_FROM_DEVICE);
 	bufferaddress = *((dma_addr_t *)skb->cb);
-	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress))
+	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress)) {
+		if (!new_skb)
+			kfree_skb(skb);
 		return 0;
+	}
 	rtlpci->rx_ring[rxring_idx].rx_buf[desc_idx] = skb;
 	if (rtlpriv->use_new_trx_flow) {
 		/* skb->cb may be 64 bit address */
-- 
2.43.0


