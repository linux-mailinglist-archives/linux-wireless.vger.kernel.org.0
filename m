Return-Path: <linux-wireless+bounces-20498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A5A67604
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 15:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4394C8809BB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68D20E32B;
	Tue, 18 Mar 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1t200xR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54E20DD72
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306976; cv=none; b=pIPsbOBnBzOqBfsvkk7bT1ZghJJa5lxL6N/WDC+/mRBomi+2H1z7WpakrR8/t01XRL2qKm2BbkrUI+yJBgqYBqgF91F2Nn3PEgPzpVJT6RISVQS59mbZmZXyeo5ZPWXJ0yUEtvDCvFiePdM8M0rO0uVloCG+lBooEKlaaDFvpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306976; c=relaxed/simple;
	bh=zDHI4NxcfLyRjUGYpn4UZZ5bdShE030s+5L3+ybnjE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Onqss5bzeF3zx8xu3nOZo7BZWNVtMWoXUcZBUtv984/caVA6de5hKHu+lYoMalLpAcfRSxUzga4agWMrZsVajVwwA7PfisgKwRx+nTzZc2PCbu3FUTtOBguF5IKT1tlDlwW3T+Y6RE1ebdtyZAjNQo5HJ8WlMgwpoC0VQ4ADby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1t200xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D82C4CEDD;
	Tue, 18 Mar 2025 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306976;
	bh=zDHI4NxcfLyRjUGYpn4UZZ5bdShE030s+5L3+ybnjE8=;
	h=From:To:Cc:Subject:Date:From;
	b=X1t200xRSHIT2n7wukaJcQPP28TOmEbf7plhtGRZQohfoEkuWvk48/9KfTds2wMsV
	 ePmy+bhxin37MCv3pTNj23eIsSrOU6EEnKjGZ1p/wmcpyKVn8hTw8KNvNMJTOP8qNK
	 2eeWFkG1d5CQhgTOyRrWTrN2snyRMSe76TS1YrPuZ/XK7RJMAYaC8LBtA7hC85xe7R
	 88OBVtEw3KnLGKPLVPrNNKOsUIvDx+aHNksMBtbH9v22JNiPYSoMdFZw3haP8/e/g7
	 UGW7yKAbBOEkgXJQ0fEaUEr+RwhYX+5gQq74G2nQPXtPeewUXAeFpxDfPb/Z2mqLYJ
	 hd0ymzETs+NDg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH mt76] wifi: mt76: mt7996: remove unnecessary check in mt7996_mcu_add_sta()
Date: Tue, 18 Mar 2025 15:09:27 +0100
Message-ID: <db48a9520dc6fd7041977aca967535ba750eeec5.1742306818.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary conn_state check in mt7996_mcu_add_sta routine since
it is already checked above in the same function.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 89e4f0e88583..ddd555942c73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2325,7 +2325,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 		/* starec muru */
 		mt7996_mcu_sta_muru_tlv(dev, skb, link_conf, link_sta);
 
-		if (sta->mlo && conn_state != CONN_STATE_DISCONNECT) {
+		if (sta->mlo) {
 			mt7996_mcu_sta_mld_setup_tlv(dev, skb, sta);
 			mt7996_mcu_sta_eht_mld_tlv(dev, skb, sta);
 		}
-- 
2.48.1


