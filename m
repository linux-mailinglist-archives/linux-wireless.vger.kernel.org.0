Return-Path: <linux-wireless+bounces-13187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28843985CFF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD75A285D5B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3831B011E;
	Wed, 25 Sep 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR4JTJ5F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348301B010A;
	Wed, 25 Sep 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265677; cv=none; b=YT/FxJlm2Z7b0G59zaIZyoHJ1o6eZqZ0lDpf9CQhFJvdaqYSAaeHplrZIYPUvf4MK4XCWA8xrG6Whw6aNBqEPgNyeXdb/VS5IswUB5W7U4YOqo0G2frgVNgyE8TnkfGBQ07LKkHqXvq945QpeEpyTwQ9L35u91MPzA/l2u3aRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265677; c=relaxed/simple;
	bh=VEIQZWdTQ9dg2khM6hUR5xSlsXQRX0LggRkXcpNBBSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBwvo5Nr1ugXWz9CoE5gQ8uiNZGI6s293kcJxsE27og5BxtcEnK9HDbgoF5O6EDn+vzUuDl/6febD0J9X4xfKDAepGZZX0QN1zK6jUj6qlPBkzKMETtsoPooDwOtjt+V1K/Ko3UMuTLkOG8yOEj9MSVHOtDTFpVD8PtICAqoF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR4JTJ5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B63C4CEC3;
	Wed, 25 Sep 2024 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265677;
	bh=VEIQZWdTQ9dg2khM6hUR5xSlsXQRX0LggRkXcpNBBSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZR4JTJ5FiF4QC2JXi3mYMjKw/KKJ8OUpyCKX3vMEC2kQ9qxtbeTRNz1AAHujDU7b1
	 /xGw5Az43uEj27u/FraajUFuv8G+F9nGg9LQc8I6QEQA35cikjqvZVXJdJhYjaJRpV
	 23Z7oE4na77TGrtCt08LFKeossUUbE/ZptNoWEh2yAPlGxxXHFf3ZD/V6qXAKePH4U
	 ly+Kft5qXIK35ojB2YQmMy4/Gm/F+EFcY5V4YCAaYTNNGOs05HRCm6CU38/o2Wq84k
	 +Oe/KlwBcfb9eoIo6UGvPOXaw4u4qS9Vpx+MrQlIolwQsDg8utRBx7Bu6SVqSJAX1z
	 omNkaW+YekEBg==
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
	allen.ye@mediatek.com,
	yunchuan@nfschina.com,
	shayne.chen@mediatek.com,
	henry.yen@mediatek.com,
	Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 068/197] wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
Date: Wed, 25 Sep 2024 07:51:27 -0400
Message-ID: <20240925115823.1303019-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 8008ce3fa6c7e..387d47e9fcd38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1537,12 +1537,14 @@ void mt7915_mac_reset_work(struct work_struct *work)
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
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mtk_wed_device_stop(&dev->mt76.mmio.wed);
-- 
2.43.0


