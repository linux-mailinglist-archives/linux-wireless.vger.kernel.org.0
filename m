Return-Path: <linux-wireless+bounces-24821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3ABAF93A5
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0702A17FCB1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268402D9EE5;
	Fri,  4 Jul 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4HHiL8S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212A2D9488
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634510; cv=none; b=gUKGvghXQ+vhD8XG6KnpWRlfYVruJptrv5baFsXw2gSKH80xsHyYh21rAn/6R5T7YQIqyaLaHAcVqy+YwmoiyDaVrS2YcOov1e+wz/CD2ITJM/vAZ+z/+cS9mJk+f59OYc2AuoYvIToLSH8VXt9pOfvbFm+2KvGlOHhBBRMQa84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634510; c=relaxed/simple;
	bh=Tqd6c2PBuvH0+CD+jJ53eqF3MMSBYOHgiwjdQEVbvJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUtbcRjP0TJ/Skp1r6K9BzzGOXaPpRIGgPWPo/kyd6OdiQm8c2/X/icY6vxWQLDYlw+Ge1Rl1tuiK9Bz2m6wAJfUVmUmHVj2+yk0c4hs0Bj1v4ws2Xvop4tK0CqumhcwNGw5nqI1ixwDbZblPOJbYCnHoX32so+ABiFjFF9iOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4HHiL8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BA9C4CEE3;
	Fri,  4 Jul 2025 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634509;
	bh=Tqd6c2PBuvH0+CD+jJ53eqF3MMSBYOHgiwjdQEVbvJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P4HHiL8S0fid99gDAM/Ju/gve81njtuioaHPOpZXNN196xJDpjEOXF8OyR2+Ju+8D
	 5NaHh+e5FOwmezX0iSHaUWaogNU1ByowWfYp972EhseAqjUKYR35kgdQEHnG7xSpxG
	 ozi/mnANdDxkXYJy4jzgaddfO1+QReMUDUjj9PlUComKK/fMpaWpTT3w2ZssLE9k1m
	 RYuy+9S01Ruk9wKT8NN50i3cSWWNyonfIw5WZuqNMGvAHvOehD8F/If+NPmJnjRaPy
	 Xti5lBb943WKCT60csqa5nkR0jiwzZ/5pFTQKNV4zFe5eB6OxQDMnBt99vRSOXxlwT
	 VMG4vSOd+96Vw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:06 +0200
Subject: [PATCH mt76 2/9] wifi: mt76: mt7996: Fix secondary link lookup in
 mt7996_mcu_sta_mld_setup_tlv()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-2-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Use proper link_id value for secondary link lookup in
mt7996_mcu_sta_mld_setup_tlv routine.

Fixes: 00cef41d9d8f5 ("wifi: mt76: mt7996: Add mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index f0adc0b4b8b6ccdc6ce11991a4d99b89500fe7a9..1bf5632cb0f754d49ec6201254d35652d23c0a8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2243,8 +2243,7 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 
 	if (nlinks > 1) {
 		link_id = __ffs(links & ~BIT(msta->deflink_id));
-		msta_link = mt76_dereference(msta->link[msta->deflink_id],
-					     &dev->mt76);
+		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
 		if (!msta_link)
 			return;
 	}

-- 
2.50.0


