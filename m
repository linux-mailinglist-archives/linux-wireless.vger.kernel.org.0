Return-Path: <linux-wireless+bounces-13204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495D985EFF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1E628A8BB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64DE17DFEC;
	Wed, 25 Sep 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCCQ9/lO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E921A642;
	Wed, 25 Sep 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266424; cv=none; b=BXNT3v1duLwLoP646FbxIDCY2TjEXKD3pCqboFCeJ/4btLjzTdYW7JFideDCX3Azc/MooNvpZvA2D9GHK5B3Mn67spUcId0fJJRR8j2lVgCTl9a8zhUQQLh84ZKNx8hlOrXkH5hhDsMro0DAE9oOSCyJHIBRpIN+wK6fydbsK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266424; c=relaxed/simple;
	bh=ev5wvojVnFyXFugc+1rqnmORPLhCYPvYkXPNKMIuqu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkz0O/jN9GOjoDFXdHWVlfoMriqsZtxeiLCJB5GGE6TkFm/KKuXBejepm2lrnyVlZBABkYVyBsYMmZNAihMwzR8VT9ng7H381fWE7Q+kgbRMFkBgtIM8yWE02i/YH57HGDmj3Ru+9FXnjGUunGOHWicTDo8DN46kltEP8qEEkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCCQ9/lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF3BC4CECD;
	Wed, 25 Sep 2024 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266424;
	bh=ev5wvojVnFyXFugc+1rqnmORPLhCYPvYkXPNKMIuqu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCCQ9/lONINeJn5fIC5DHfHEv9tLd9Em12OTupakeob05YrkXEraoxWHk2YKsusia
	 m1oqvohzMZmrzpIwVQYBx7HzbALjFshqEf01OzuJXhs+YZdoKE9OSMSHNKaxNnfbkd
	 KVThyadGy6nO0ZLsVn8byC0rpsKvLjOnl8d3lYUd27mzcuLazl5fVocunJGGeE/iDc
	 KTvaLWBdSUbOQPB/vgv7JsK/bvIYiSti9yAG526F0GZoCt7sg6x3oVH3uPlye9ntCc
	 dbme0cKJW4bQueSlCT5IupVFigYd9vFtURYL7//5+pX+sbONODTnWu73IQOju4X98u
	 MybFRcFA9dYrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	yunchuan@nfschina.com,
	Bo.Jiao@mediatek.com,
	shayne.chen@mediatek.com,
	henry.yen@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 053/139] wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
Date: Wed, 25 Sep 2024 08:07:53 -0400
Message-ID: <20240925121137.1307574-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 8f7152f10cb434f954aeff85ca1be9cd4d01912b ]

Prevent racing against other functions disabling the same worker

Link: https://patch.msgid.link/20240827093011.18621-17-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2222fb9aa103e..38d27f8721733 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1538,12 +1538,14 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		set_bit(MT76_RESET, &phy2->mt76->state);
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 	}
+
+	mutex_lock(&dev->mt76.mutex);
+
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
 	napi_disable(&dev->mt76.tx_napi);
 
-	mutex_lock(&dev->mt76.mutex);
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
-- 
2.43.0


