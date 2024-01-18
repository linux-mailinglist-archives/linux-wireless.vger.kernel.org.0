Return-Path: <linux-wireless+bounces-2212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A9832018
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 21:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDE1C234E6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1D52E82B;
	Thu, 18 Jan 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="nOxFdn9K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AA31758
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608076; cv=none; b=DwYdsAAATxFO8CnbfganeR4Q0o3wuznCu+cwhLVM693S74ACVVa//idSdkn1zdJTxCgTp64M36OKhS1bQagQU+tk0Iv+S6VPfEZkTd3q69xPA99zoN4KaWuKUHGuM+VpAhmT7ZM/i0q7pH1fhcLoyW5JEQiZR2OdKuT0J8WO7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608076; c=relaxed/simple;
	bh=/vTfgtyVYDExTkSgyEoSylFpYPMk6fjG/H8qj1PWuJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpoCOPywRXtUqZqpD3k15hAEo02DBJXtWFbt3+wjUJyHH5RLpSmiuuXa3Ijral/s7KXYNqtRAAPtVIPNC7JBQYLcGgDVOXRoUVk1Y6ocFpYc7ztflg/tOqZQlkdVkEX387WsVN2e1H4y0afg3PaGrIbfUfy+snTPbx3pRKXb95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=nOxFdn9K; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nFPRCsAoE0PWSCm07IF+LFbJmh9UozGQwWBa+8jVUC0=; b=nOxFdn9KwjHzpx8ucyP+8dD+x1
	8QIXjKKgtBMYt3yq3MlKVpVsqM74gIA7A3yMc5Bt0leZvobyuDRMaV6ScZSGLOT+zAIYWyjqySCgV
	jp82qa2dDJgUr1dQyr2o4spsJVXJbPGZcYUc/HRH/osj+FU8cUC2no249VXGzhn5YQEs=;
Received: from p200300daa7090900680536e7cb8d8cd3.dip0.t-ipconnect.de ([2003:da:a709:900:6805:36e7:cb8d:8cd3] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rQYQz-0054tJ-DZ; Thu, 18 Jan 2024 20:52:17 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 5/5] wifi: mt76: mt7915: update mt798x_wmac_adie_patch_7976
Date: Thu, 18 Jan 2024 20:52:16 +0100
Message-ID: <20240118195216.80974-5-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118195216.80974-1-nbd@nbd.name>
References: <20240118195216.80974-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Add support for a newer ADIE version

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 8b4809703efc..f5b99917c08e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -516,7 +516,8 @@ static int mt798x_wmac_adie_patch_7976(struct mt7915_dev *dev, u8 adie)
 	if (ret)
 		return ret;
 
-	if (version == 0x8a00 || version == 0x8a10 || version == 0x8b00) {
+	if (version == 0x8a00 || version == 0x8a10 ||
+	    version == 0x8b00 || version == 0x8c10) {
 		rg_xo_01 = 0x1d59080f;
 		rg_xo_03 = 0x34c00fe0;
 	} else {
-- 
2.43.0


