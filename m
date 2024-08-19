Return-Path: <linux-wireless+bounces-11603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E6D95661B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7702DB22CE8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F0515B107;
	Mon, 19 Aug 2024 08:55:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F119947A;
	Mon, 19 Aug 2024 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057719; cv=none; b=Ts/1ECPXWv/GVVE6InC2zlArQVfxPetv/6o7zmRtXnFqaDa2ijo3IItTdsxK9pceD7jk0zQCMLKe0GH6FkLSpxEry/LhTtzaMPJ1tTXlQrpfgpqLdHfM66xYjUcnv2KeUuMALIeI4rLyfdpDYTb2hNw/9XobM6+l1s2NPF5fV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057719; c=relaxed/simple;
	bh=BZ+tG3sPqkdp1r8WVl3AmA1qeUmicg7w7NSIoJ6H0IM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gR/Xe4Y8JnmfYbisuGQkVu8GQpwI3V534I0JtVsAHeW/k3rIEDVNzv8Zp9mVqStVSuEmG+0Mug+Fiq+hdrG6hsHzjQ69pwkq56st0vMzJj3TijqoS7saRFAZltFFg9TQcUoEFR0eZ+QDAca0nrpERI3ay4Bz8pz+oDKlkkYYKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3XQBaCMNmOqISCA--.43879S2;
	Mon, 19 Aug 2024 16:55:00 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	allen.ye@mediatek.com,
	chank.chen@mediatek.com,
	meichia.chiu@mediatek.com,
	Bo.Jiao@mediatek.com,
	evelyn.tsai@mediatek.com,
	Money.Wang@mediatek.com,
	akpm@linux-foundation.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he
Date: Mon, 19 Aug 2024 16:54:49 +0800
Message-Id: <20240819085449.1013279-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3XQBaCMNmOqISCA--.43879S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4DZw1UtrWxKF1xJr13Jwb_yoWDXrXE9r
	n29FnIqw48Kw48Kr429wnxuryay3ykZF97Gay5tayfta97J3yUZF1IvFn3Ar13uFn7ZF1U
	J3ZrJFy0y395WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRNAwsUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Fix the NULL pointer dereference in mt7996_mcu_sta_bfer_he
routine adding an sta interface to the mt7996 driver.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2e4fa9f48dfb..cba28d8d5562 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1544,6 +1544,9 @@ mt7996_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	u8 nss_mcs = mt7996_mcu_get_sta_nss(mcs_map);
 	u8 snd_dim, sts;
 
+	if (!vc)
+		return;
+
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
 
 	mt7996_mcu_sta_sounding_rate(bf);
-- 
2.25.1


