Return-Path: <linux-wireless+bounces-22869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D587CAB3AC1
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DE87ACBF8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF422A1CA;
	Mon, 12 May 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="jAsPt2ph"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C5229B2E
	for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060509; cv=none; b=Ec+GexBNZ1EWA2iFcJspy0po8fyrtOlJ2Amr1xDpwDi6c0sw1w+NocwSKSHsF5EMfysF2GKrdXpJj9CfLBOAEZ2Zk9WjeJisLJ6Gf+3HX9Fm0kgTs4CnuHkfUM0pdep9ED/fh3N6Vz9v4wgR9cWxq1pWul2Z5DcIo0yrlZSfRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060509; c=relaxed/simple;
	bh=Of7ka9hMXGo16Owrab9b8hlZNOg2CKSZZ/6dxQLWwYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0g//fDrwnaD63pEtdRA2e9Dl6Uicyv1+S13FfJNMsrkIbv55pleU0R3n3b6pAN9syfmlkOaSf4kADoPuuHM4WdYvuDcm+J6TVFOOnXCdDmbfqifjTcuF3/NbGRjCM6gMHLReE0V/4GVVK8tyh+cOa50QttjwvWI229M1lSpENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=jAsPt2ph; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-702628e34f2so45176447b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1747060506; x=1747665306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R97yIxV0uT7GwLkeFinXJPFtVVZBVzQD6JSs+qYgRtA=;
        b=jAsPt2phxoTxOivw5vKCveJitapS7PQPH01Zz+6TZuU5l5nxdYkK8dGPFJhFr8yQ94
         ATdanrN9+oW8qg3gaS4ShKsE+7dD4evQLzDWu2jmANRSd65qHp9M2TMPLJdfXf6YaIj7
         UwgZY/1H+AzqbaeNiDPToY7CcIgQ8uDSKEnN5ikYL4cd5QRMo6D2DNWULwYyBLsl5+Bx
         rt7Hdo06cxBaQEoN3WcRnysASsmexPmpOI/jYjuMHQl3m84t7l9Bcbkp/cGXNgPjawuf
         D22u+bi7WGPHNpPCw9xLxjEyrkBUV9Ct8mYGPPPIdvmu5H5C+GEn6TZBTrNrHzCS5RBg
         AXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060506; x=1747665306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R97yIxV0uT7GwLkeFinXJPFtVVZBVzQD6JSs+qYgRtA=;
        b=jMHExTxlUZ62wioV//5YqvY/4HfcEb3YRiZi6HvuK7GmFylliVbKuAL5//CLs7BpQJ
         tVYfpYzY4+VHlIeMggul0TqFG3xEI7JH/Lq8+ctPk1QgHqkIAEq0qFLnB4fELev192mf
         Yip9GdJOxDHq8syU7BevrjowIu2jy9Mrx70/r35WC/9nO6OqG6Y2ABZvnPw0d/UAoBBZ
         1JDQNCTpyFomSUyNmdIJMhBiVlh9tnSLXHipwTOAIclOpjiG2m8PNtbFHJrSCquPqbzB
         av6PEEBM0Ohq+lFa9ZnWhmV7tySr+iS6myNhQRsMaLK94KLABaRg0Qa8k3zG69jpjJZp
         kZLA==
X-Gm-Message-State: AOJu0Yw5fccpRkANmyCEndw9Z/lleTtvMmPOHN8r8U6ojGoyRChSXcDq
	HYo9z1/1Pql1YLYKgwCPdaRhAid1Wb8TGvtzj+kLEJHGqSz7+AbD+0AOvr1mn7P64oigSZUGQq8
	=
X-Gm-Gg: ASbGncvcRc8K17L9pKHiHjct3lLL+iV9beJ6i7Hfmo1wgQCpAZ8d4XZugfh4deJmVIv
	2wUVAt+8vwNMsBq7bUJqUJES5ju2gqcIO7vK4BN4sqmmGUeHBNoBv/4OKWa/+YwB2H/Gfr2GJWK
	/Mna1QDE2KzVSovkYrJa3k2dMnDQkOIuQ1+xSqBx19X3iZ4orNlcd/4kR7lv4ZBltpuGWgSrg/T
	6RwTEKkr4fU2Nm3h8ia9nIUDP+X+eGGK9CS24HiZnclCQra4wyO5GKUNZMbsd5awOufDhYReAVI
	DihE0/5sB+TwR4eY4av+Xja/xxZ8gwEnTSLabYKROiW0C1/r3nNDPiDc/dPVUXH/nBOAI/4=
X-Google-Smtp-Source: AGHT+IGE2LN1p7qpCZfamnkZ0PsFnvtQNvYY7UOf7e0PlcjYwjwD4fqs4hNHekAP0v3CdFC1Gp1jRw==
X-Received: by 2002:a05:690c:6a86:b0:706:afbf:50cc with SMTP id 00721157ae682-70a3fe87c32mr174422477b3.11.1747060505874;
        Mon, 12 May 2025 07:35:05 -0700 (PDT)
Received: from localhost.localdomain ([185.119.2.99])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d8da29dsm19655157b3.54.2025.05.12.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:35:05 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Yan-Hsuan Chuang <yhchuang@realtek.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH] wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds
Date: Mon, 12 May 2025 14:33:37 +0000
Message-Id: <20250512143337.54199-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the size to 6 instead of 2, since 'para' array is passed to
'rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1])', which reads
5 bytes:

void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data)
{
    ...
    SET_BT_WIFI_CONTROL_DATA1(h2c_pkt, *data);
    SET_BT_WIFI_CONTROL_DATA2(h2c_pkt, *(data + 1));
    ...
    SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, *(data + 4));

Detected using the static analysis tool - Svace.
Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index c929db1e53ca..347807801270 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -309,7 +309,7 @@ static void rtw_coex_tdma_timer_base(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	u8 para[2] = {0};
+	u8 para[6] = {0};
 	u8 times;
 	u16 tbtt_interval = coex_stat->wl_beacon_interval;
 
-- 
2.25.1


