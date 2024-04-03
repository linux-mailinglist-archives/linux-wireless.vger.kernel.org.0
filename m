Return-Path: <linux-wireless+bounces-5799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51375896D4D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041C328FB0B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613E141987;
	Wed,  3 Apr 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Rynh5nfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467D1411FC
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141574; cv=none; b=WJEF3Oz/IJZUB5cMOu2kIn1viwkeQxT05ZeDaGcjtlKwqc3aMsJBviYUZhUyXc8PbMTeoFQqNENdYdMkj2OySE6UEFMQL8D88yGYDPMchCo+bpq9GymcW/CsrtttdxRUro+MVApc4EzUs8UVlam5oHKm/Ejtgs3Q7NqVkgXkIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141574; c=relaxed/simple;
	bh=3pPu2xFkXtt7BjFh2iifsfATstRYhotjO3FLhgWcLs4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9GiCibRqApqyeBA2MopRRReoEUiGZtMy15eOPTu3P2kcGU+JX0lL+NV9lDoOLLEY5DNPNmyDiKMRFax+CmKhxrKsoeSfM+hxjlA4R7ludPMicRJlktStoQhbqAHPyo2wSRhlc8NcniLf3BkSjve0JScCEr4JuPeNqxiqO+KeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Rynh5nfE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PkGdDKVzAxMIUh6m5BfYHa5tYvyWTCa6SC1zFQMksm8=; b=Rynh5nfEwxi4N0TSCHgoJLg9V5
	DpG7hrOnb2gGuokhx7z1RBiy3fUz2OaX7y31j/iMCmJsh6LHU/eS2/4rCVPkFiAnXVP/BOXwc4MAl
	6g9EDeLxj6JIrV9IJ7JIOrUQkyvSGRoL2/BPpNwQ8H3M2JCdLjzEKno28QD48IygQbx4=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt3-00CgfA-Qk
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:33 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 07/13] wifi: mt76: mt7915: only set MT76_MCU_RESET for the main phy
Date: Wed,  3 Apr 2024 12:30:26 +0200
Message-ID: <20240403103032.54823-7-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bo Jiao <Bo.Jiao@mediatek.com>

The MT76_MCU_RESET flag is only read on the main phy.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f350b3f7a0bd..8008ce3fa6c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1345,10 +1345,8 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
-	if (ext_phy) {
+	if (ext_phy)
 		set_bit(MT76_RESET, &ext_phy->state);
-		set_bit(MT76_MCU_RESET, &ext_phy->state);
-	}
 
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
-- 
2.43.0


