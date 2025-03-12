Return-Path: <linux-wireless+bounces-20231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91EA5DB28
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36F17AA57E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C723E35D;
	Wed, 12 Mar 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFL20cpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540F22E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778053; cv=none; b=KIqOs2/Gfkn3GXAzyuSA0inFx3LIpMaULESQilHjhlEmEMNaeBeevfgUKM54n90bVHOjSfIDLXXmF/6qn72O7WghLR44A/y/EdVViJQKMNLctrw2n0AD2Myd4F16lg3eh1P8oc8Atq3d0hBeM3ePdCldAkwODQ9L0ISUD/qsitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778053; c=relaxed/simple;
	bh=gBYGGRWaS8lOGVSxVW8+XecchMXFP9cQ/1BVUQ52D+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmu58Wh7ANTPKFn9FRFMTI/C9jy4KhIEi9/HzOGrR/W0YT2ABsdHvyeOsd7B3v64JCTl7OUOjdtlBh5WDcLMZiUOxteBMUnF5kMp8gLtn6bAS7QuxDFIw8nj3X8vD2M6DYUnM0VNzfNfLbVbwvEVMaYDrx6WYjGXHZXOKuJzPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFL20cpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CBAC4CEE3;
	Wed, 12 Mar 2025 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778053;
	bh=gBYGGRWaS8lOGVSxVW8+XecchMXFP9cQ/1BVUQ52D+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TFL20cpXW3kq1wjv5IjD1axcG2dThJyxMi8c3EeCKtkzqHdHQVZZSGGE2yrxan99h
	 zbvoWkNSDgyevK1ceMFHKqHXut9/cGKC3kRegZn8+tLDRBcaE0NyfIFSnZ48Wycrq4
	 oQRJx5C6/I8RWvGxlLXXyTKlfHiSMc2HSxZNH66O8Dfy3dKVmhCynOb0hCVeV2wgFG
	 pkAKIXFqfepigC39+tizQaxIzwqw1KrCzS+xvz8g1UtkOWJXQgTtXzaEz9GNDN7Rf6
	 ONiNE3BS4GGgwdYsWxJdwCZ+7lNyVo++VdF8qPXsO+5cke4kUtkwFSyci5aVb+Oa+i
	 ZCnjHgnRgir4g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:49 +0100
Subject: [PATCH 05/21] wifi: mt76: mt7996: Rely on wcid_to_sta in
 mt7996_mac_add_txs_skb()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-5-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

This is a preliminary patch to enable MLO for MT7996 driver

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index eed692cd64a6acedb2f6d9aaf6f459bf4a4f5b08..9f8436edc81377d852dd4e7221575c7e1255187c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1287,7 +1287,7 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
 		struct ieee80211_sta *sta;
 		u8 tid;
 
-		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		sta = wcid_to_sta(wcid);
 		tid = FIELD_GET(MT_TXS0_TID, txs);
 		ieee80211_refresh_tx_agg_session_timer(sta, tid);
 	}

-- 
2.48.1


