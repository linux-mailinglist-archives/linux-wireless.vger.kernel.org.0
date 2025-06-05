Return-Path: <linux-wireless+bounces-23757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F4ACEE68
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AF0178477
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F61F4C9F;
	Thu,  5 Jun 2025 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MycVClR7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FB1F4631
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122306; cv=none; b=UZu+ARLADmvWH8rCi0KaAG/qHZZB3jwNRcG3eKIjwQcFcXx+jeuSZEV9UI+9ryABwcLiu0zjoJYbYuGZ4FuNky2n5p2+Jn6+2SIGv/8t0zckko4YnlzZZt3aPYWONBgJO/NMNNPLfRpFnlLHdm1qdQ7YldoKRYSUfdq2yYUZAeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122306; c=relaxed/simple;
	bh=oBSODQMsy1/d5/U6vE4OfmyUvi5gh7AawwYdZIj6y5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ebsaa//HiCkeuvESRIClotwCIp4oIJAcc33j6DGHezNQ6UNMGa6UiPXO3+REkwGl3v41SpMGbj191eqg/vIqkTxyoh2qTJBfGCZbdYtfoCegBKI9c/QM8KOgfFdqxHr3SDKyRuVPi4s5tpjmtxL+NQ/WIuFCYlQ5oVTMblwvaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MycVClR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E3CC4CEEB;
	Thu,  5 Jun 2025 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749122305;
	bh=oBSODQMsy1/d5/U6vE4OfmyUvi5gh7AawwYdZIj6y5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MycVClR7i4Ggd4SLTz8CmzHwMSEzB/HiZKzqwvdl99ZbjSM08LzPexT01HXjeaZJY
	 xNCuc+03lYp4Jiuyo5xv2c7KYe+ycdRNClQAnPkiha/9mmdDB0cZzejavJyNe0eU/o
	 EXcxzMjitXzc6/qOX+ioylo18VrsukR0LzacOPfUAqLuiYpavBeW7e2oYcX+0nTPkH
	 ZfTycHPsEREIiGXDiNPaglCh+/imgXwfZwZZZFhogFHU2Lak6d1Pj/7lTqFqxk2edL
	 kDSlIrGtgqe+UpkPuzstMcQB0TAXL4VytFnGA3AKXhka3pKq+/RxgBAZ0w3ie9uk50
	 W39gFTtib4aQg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 05 Jun 2025 13:14:16 +0200
Subject: [PATCH mt76 1/5] wifi: mt76: Assume
 __mt76_connac_mcu_alloc_sta_req runs in atomic context
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-mt7996-sleep-while-atomic-v1-1-d46d15f9203c@kernel.org>
References: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
In-Reply-To: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Greear <greearb@candelatech.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Rely on GFP_ATOMIC flag in __mt76_connac_mcu_alloc_sta_req since it can
run in atomic context. This is a preliminary patch to fix a 'sleep while
atomic' issue in mt7996_mac_sta_rc_work().

Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index cb13d0a768789af956f810e5af19507e436a449a..fa08e952dffa9d6e623a1f6819f136be3a5a0c76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -287,7 +287,7 @@ __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif_link *mvif
 
 	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
 				     &hdr.wlan_idx_hi);
-	skb = mt76_mcu_msg_alloc(dev, NULL, len);
+	skb = __mt76_mcu_msg_alloc(dev, NULL, len, len, GFP_ATOMIC);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 

-- 
2.49.0


