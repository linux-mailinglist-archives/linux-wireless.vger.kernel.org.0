Return-Path: <linux-wireless+bounces-26712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB472B38809
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6474980667
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8E215F7C;
	Wed, 27 Aug 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku8Y5dvK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE117B505
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313529; cv=none; b=Q+mgFlH/IpLYus9bp8+l3E8oLZGGiixfd9UZaIPtnlEVud4jC/ZEoA4Yb0aBkisi3VIiB25ymwZz1gRP2mzlyN8o/Uf4bl8eV3Zuj3cVw4gmpMrlrb8GBGsQZeqPsvmcQ3j0dRlkX4VRcK34s/GGFrc9pgi/3VJ0BZfa2aoRBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313529; c=relaxed/simple;
	bh=220c5B6VjSJCqx2eqnvidM1hfL9LyySlQASzMHhB6Qw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Yb/V5GpowQVE1sWL21Y162/fBAne2lkNA/z28aI06w4xf5Xgb6B1YLqpdm33vWqJKZBo7l9XvCxhvcUen5/Y3t3fku13NlmzH64bi5Kkg07bA4nxebe4H4R+Ix6hQFbl/qbCk/BaOSi9bDSjg63utiRpPC3QzZVtT/n55a2Xon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku8Y5dvK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso37756285e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313526; x=1756918326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wq/4KIHtwvndAlL9shIdvYLpPatloBjheW1Zp8nfPSM=;
        b=Ku8Y5dvKspyO8rpx42AktASeHh3YkSUVjEiib8W1raFFe7GoCXZEpfqtkWvrC7gsOG
         MvEtEwNb87w6xV8SE5ABjLgl2+3C0loiXCLaQLNTUuhTDP8T52UCGalHNjwtPKu+0lpn
         Z/NdEIfZ+Q6d0gJk2oU1SBZE7YOu2nltWJbytdTHRro/nyd65iA1sWqC3IkKdk9tGyaa
         v7jcszkvhrK9vEZ14AGfSKeNyQnNGAe9JBkQKeg9P4IJBbKMglp//nRiKfn3Gk+V5yv+
         JtL3gIQuLRxHRvdfe5qr4XzMWBndcuYL5ykHOdbIFDylU4uAjh9jq0fEjvN0DVgLw156
         9UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313526; x=1756918326;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq/4KIHtwvndAlL9shIdvYLpPatloBjheW1Zp8nfPSM=;
        b=jld+T/QTJalQAcD5vWdQ9mQARKNQTsvgJWpUAOI+v2YjhS5wE3GmTST9m4ZqYSMmcQ
         GGkVHK2uZDa8MNFxFOh3gmCmm1hS5WVxi2pg8fSQRThUmtY6RZhAZ55RZLp9vduI3VU1
         njHThjeOfs23S+7gXeL9qAeXNo6hHgur5ysC2uGFFmr/WqjQMQvuvw2yOT4i0Qwirb8c
         oekW7LdEfK/eCdgKnSuRf/5lhy9STE0Fh2zfR5VS/2JhrRF33Yestoft368bq+mGU1Om
         /8fc+hQSPqnm0Qsm6DLDJfN6+7LofA3dq8WIZAOzJoVx08KLA2PYpN5+7Bpp0IZ+TjUp
         kJXg==
X-Gm-Message-State: AOJu0YySY8bQmf/OeIyKtV1aacOHWLdNJ5NpXf8hPGsY6kBDAKrHIEsm
	F5TGp34ftchNDCA42JHySyp5TtHI7T1Pnc1zYzrORwqoDRgYqU8dQ0TmmxJ7Og==
X-Gm-Gg: ASbGncvpcZLNgiPhmhnrHi5hIzhE7jX+urAgofLEZ3YFxK5QLWUVzReUxlI3vyboRQ/
	P5Vq5MPPnoL0TIJcJGRCBPiy8PRgudec0RhdwwXvVD+SQei5P8r9YFUE8KMIiY1dHlI+BpXDqsb
	gBFSTh11LiTjVGiOzTx/avYT2JTbHVjEH6MYlEKHMZrZkFoTXzgfQEFtxWNR3wxRYlcRNSeaFWw
	pujdlO6EyCUtCTxA6W1r0vAC6hpX3hJWlhox1Zb/l2Yel0MUl8lmuK1tivZ4zde2bAnA12sdgLS
	xoq9n3ckw8t+803PO5PI/64UcQRnzZNjzCUdOR6EKCRIbbDctZUne5k6skhlQVGJph3TcKJ539U
	xc7g50PURAFu9WRpD5rcDLeTu3l/wwA==
X-Google-Smtp-Source: AGHT+IGd6eVehcg/e3ZqiYG1pPAyMt1SjZl628KLmUIfAuUfYgOW1jkjCthR0LYPmxjN+Vo3qwKyeA==
X-Received: by 2002:a05:600c:4451:b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-45b517cba3bmr173164875e9.35.1756313525915;
        Wed, 27 Aug 2025 09:52:05 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f2eb7c5sm39906505e9.23.2025.08.27.09.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:52:05 -0700 (PDT)
Message-ID: <ded9dfa8-b097-48d5-8cb2-1b4aff3d0d4c@gmail.com>
Date: Wed, 27 Aug 2025 19:52:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 05/11] wifi: rtw89: Fix
 rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the DMA mode according to the interface type.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 06fc113ffaf0..6c2de561ddcc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3980,8 +3980,15 @@ static void rtw89_mac_dmac_func_pre_en_ax(struct rtw89_dev *rtwdev)
 
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
2.50.1


