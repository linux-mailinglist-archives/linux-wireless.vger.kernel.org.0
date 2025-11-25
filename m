Return-Path: <linux-wireless+bounces-29339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E3C856B1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405FA4E1F63
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3F52D7D42;
	Tue, 25 Nov 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnsTtp7j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C826222578
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080912; cv=none; b=soi1NPJQdjenlVfPAJqyAPaRSWGMvDRWg3pTtKtYRqLGwjsgjRm75bzfmcGPUmHy4ADZIQLFHqhSJz0oYAHx83IxpzrmwlZ1COUnK99pqRIHxUV3PbMW0DYXAn/mp6AqtCbcdI64kojuntr2Cy7ywawVT2u92N8096IkeULlNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080912; c=relaxed/simple;
	bh=KWcAC33stGYSGE0zvQZfSpXEw9LHnJwjed5LDWeubuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdgjdZ0Lg8dGj6Yj61FN/q4A3ZYBEbxVh5nKJqxj6vXILIxGvM8NffAxjJ6aucVOfhSwimwkSsxCG6ftEBIO+EfgTp9gdfdsDlLh/qTX6zA0sD/vFP0PBAxWxEW9CeithOwFxVHLcprfofnX1VekivKP8G5+GSZJhBj4a11DFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnsTtp7j; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so3252163f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764080909; x=1764685709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JAphU0cH3ceIFX/NL4RhLMIKJFwd3sLjevWt8KuG4Hs=;
        b=cnsTtp7jpoR5ZPcI8updaOCjd2bbTHDlKwt8kM9UxahDO/ftYV2VoBS0qVh8L2L3aU
         0/kvvagc0LaiuY7HNDQ5LQv/J0zhmauHtpPgu8ZRYAvxrBkP2TXT0NhFOU+ujcKS3kJG
         1TrY9JtiIn40jmnpjJpBAz7KzHswrnD8+B8KOFDloI6MF3axhFUOAZyUAZFH0eHiacPd
         X12bYV+FghPnBNg89mFHzj5xbaGyilEdPb807xC6fTYqVDb4epLylARQOuFlXsxbD3JL
         BqMFT6ux2NB/n6Fj1+ajvi7JaxEhRjo671++BGhyzms2zc8dN0Y3OLaIKs+t61NltAiJ
         or7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080909; x=1764685709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAphU0cH3ceIFX/NL4RhLMIKJFwd3sLjevWt8KuG4Hs=;
        b=wpLOJxlYnQULdGGp4zSiyVeV1gDAvPVjU+gG49I3KpaTuAYFn4JEYzNYOvsTMblY9v
         eQNmhDJ4h8FhD2QX81TLbXJ9OHSKyDXrS35jB5SaU5GHsDcAbfcMxJn7XVZWSOFd8i2L
         QHex8zX4tsAY9lS4nPW6FeC4tsWDAbSYKLnaekYK0AY4JrvNp4FeB2bPWiWsnTH0kk/W
         VjOZA3LhMDRolV9juIkCU7VuwFF4siYNTfAU0bWULfFddogESGhp/6UBmvMunRe0uZ9H
         aUScAQryA1QHxBM2BTF8pPJZeeeHi6wb65sgGk28pFI7Hud0qY+NXMmFtvG9sXt2mdM2
         NZeA==
X-Forwarded-Encrypted: i=1; AJvYcCXOQt+fr/ewcnQEHE/9HtiYEZnU5bVVNDr0pRRybD3n8X5TR3f6I8iEWt0K/gO6sBv12B1iScqAiZZRQyq4pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7lpusoZiCmgOZAFKTRxnjovCxG4itbTfs9YmMn4lhndEjQmu
	Z/KaTBGgTXq3p/cf41EMqK8UNkZklOJYL/F8y59RD7dBwp0CXnJAq9jG
X-Gm-Gg: ASbGncsrvIC7U4hXxgi/HXhf9fux68y5JEBxi7APPsER2SE/OjefPR1tGt5Biy2RgE2
	xaF1h/RY5nKu7ldLAU7DPgEHuczyh4bhKa7AkyAQi8Ui1z0FhstHVoCO9yMf74RNq4LDb8xHz8m
	aj92yf6RojFn108K5Omvmwn0wSSKNmmlXO5aPy13919152NtVit4ejlUrD/EpTG3zoGtiF0WT4O
	AJ83BlrWivQnzGK2veaYLIgc4ERjLSU2jJSI0KwfuUG9bzoy+5/gd3ATQUpaflD2mANXsklvrzq
	dFe15HloWhMDSQs5qq11yr0dzdxaDEJHoeMuCziE7+2tPLK1ZvuXtVz8LHLqIkCJe7NCB0oKdkO
	O/U57J6AKS94fKQTqtwEW38J2htxV3hKuu7RHALOfoysHE7JheW1/M2nIjDhNa+e7wbjQb5O/01
	BBMGBmvUAUulKdPxy1J6B/l8Fgeg==
X-Google-Smtp-Source: AGHT+IEqA6HDUrBNX63cSpBKkeoaSj+oHLwImQUfcsZ2vVjQkznOGyiU7c2nMqKOmiSejP6/HoFHig==
X-Received: by 2002:a5d:5f44:0:b0:42b:41dc:1b58 with SMTP id ffacd0b85a97d-42cc1d19957mr15867880f8f.45.1764080908831;
        Tue, 25 Nov 2025 06:28:28 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm35959194f8f.38.2025.11.25.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:28:28 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	P Praneesh <quic_ppranees@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Scott Mercer <TheRootEd24@gmail.com>
Subject: [PATCH] wifi: ath11k: fix rssi station dump for IPQ5018 and QCN6122
Date: Tue, 25 Nov 2025 15:28:14 +0100
Message-ID: <20251125142821.18152-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 031ffa6c2cd3 ("wifi: ath11k: fix rssi station dump not updated in
QCN9074") didn't account for IPQ5018 and QCN6122 WiFi card that are
based on QCN9074.

Update the .mpdu_info_get_peerid to use the QCN9074 variant to correctly
receive consistent RSSI station data.

Reported-by: Scott Mercer <TheRootEd24@gmail.com>
Suggested-by: Scott Mercer <TheRootEd24@gmail.com>
Tested-by: Scott Mercer <TheRootEd24@gmail.com>
Fixes: 031ffa6c2cd3 ("wifi: ath11k: fix rssi station dump not updated in QCN9074")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/ath/ath11k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index caa6dc12a790..05d7acbbab56 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1175,7 +1175,7 @@ const struct ath11k_hw_ops ipq5018_ops = {
 	.rx_desc_get_attention = ath11k_hw_qcn9074_rx_desc_get_attention,
 	.reo_setup = ath11k_hw_ipq5018_reo_setup,
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
-	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.mpdu_info_get_peerid = ath11k_hw_qcn9074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
 	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
-- 
2.51.0


