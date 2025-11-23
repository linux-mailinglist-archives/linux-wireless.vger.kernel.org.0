Return-Path: <linux-wireless+bounces-29265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA2C7E31D
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8843D4E1222
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60412C1586;
	Sun, 23 Nov 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqBCl/u+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80D296BC1
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913463; cv=none; b=DB5ahnh/nG1u8Eui5gaCczfOuH+oEUKZFpu7KiHtUMI7qpDzzkvGGRB64En8cOIwP9VdTxPerXYtyDRHP9oeeDWQz5FjEC73LYnDUE/moCAeLNeoN77/iqYkQD/i4SlwSJYsKeax98mWENT03gHQtxwh3un9nRPU7OPXDIjWrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913463; c=relaxed/simple;
	bh=DA4mYMYeSzQXc7AajabPfNH5s8hK81KCWelaMzYP5fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nrdvtPQWcGxEv/6Of4xFl8GpDLbmznXOEt5hmhefJO1qWyzwqVxPtKNSYVG74cGyXI77U63gcxFHZogpjs5xAFrHTPgwjHhalIOO2tgLmwHDvxiSLBedoN0jtD5XiWrxv7jXZiY5694XXYAEHc22KkA7KwuSOVzM38PkAKDMHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqBCl/u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC57C113D0;
	Sun, 23 Nov 2025 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913463;
	bh=DA4mYMYeSzQXc7AajabPfNH5s8hK81KCWelaMzYP5fw=;
	h=From:Date:Subject:To:Cc:From;
	b=EqBCl/u+P5d8cz0pXXAJc7NGZqTD2yIZ5ZYEbhlqI7xEiJaVHDWFkVvSKtO9nB6wJ
	 dvmnOjYxrZxxty3wXEqNsh8L3QC/NDxeLJhJj+O8NMC6hkz3CXDNQnvYt0SLEW8ywj
	 hMq8OAsP+bY1Iot5+k7sFqN3GthRVy1Ry5cxqKOo2HKgDf3IPYGukqt79gYNzlQBKJ
	 UGz9v2pBAUQ4jDSI+wqagzkX4TbYTolhxSbK2G4f3h4jzcLs8Kg8/8clcER37FLeia
	 M8nLe1DeK3OGYOMlPrY5wVVQiCc9fpaVNw5YICp7mXviGcpZZXCVeS0Q9ROwhSIaIu
	 ujx/Nv4o6O+4g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 23 Nov 2025 16:57:19 +0100
Subject: [PATCH mt76] wifi: mt76: npu: Rely on rcu_dereference_protected()
 in mt76_npu_setup_tc_block_cb()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-fix-airoha_ppe_dev-sparse-warning-v1-1-1972143d259d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDQAwAvyI5G+hGukK/UoqkblZzWZcEtCD+v
 YvHOczMCS6m4vDqTjDZ1XUrDULfwbxyWQQ1NQZ60DMEGjDrD1ltW3mqVaYkO3plc8GDrWhZMMY
 5Uk7fMY8ErVNNmnQ/3p/r+gMa8GwNcwAAAA==
X-Change-ID: 20251123-fix-airoha_ppe_dev-sparse-warning-66c62fdb7f72
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix the following sparse warning in mt76_npu_setup_tc_block_cb routine
running rcu_dereference_protected() to get ppe_dev pointer.

drivers/net/wireless/mediatek/mt76/npu.c:314:63: warning: incorrect type in argument 1 (different address spaces)
drivers/net/wireless/mediatek/mt76/npu.c:314:63:    expected struct airoha_ppe_dev *dev
drivers/net/wireless/mediatek/mt76/npu.c:314:63:    got struct airoha_ppe_dev [noderef] __rcu *ppe_dev

Fixes: 62f1347fa5bf6 ("wifi: mt76: Introduce the NPU generic layer")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/npu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index df5cecd05f50366397a25f14092702513049c5d6..ec36975f6dc946f5dbc5ab6029b0574fbc602615 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -304,15 +304,22 @@ static int mt76_npu_setup_tc_block_cb(enum tc_setup_type type,
 				      void *type_data, void *cb_priv)
 {
 	struct mt76_phy *phy = cb_priv;
+	struct mt76_dev *dev = phy->dev;
+	struct airoha_ppe_dev *ppe_dev;
+	int err = -EOPNOTSUPP;
 
 	if (type != TC_SETUP_CLSFLOWER)
 		return -EOPNOTSUPP;
 
-	if (!mt76_ppe_device_active(phy->dev))
-		return -EOPNOTSUPP;
+	mutex_lock(&dev->mutex);
+
+	ppe_dev = rcu_dereference_protected(dev->mmio.ppe_dev, &dev->mutex);
+	if (ppe_dev)
+		err = airoha_ppe_dev_setup_tc_block_cb(ppe_dev, type_data);
+
+	mutex_unlock(&dev->mutex);
 
-	return airoha_ppe_dev_setup_tc_block_cb(phy->dev->mmio.ppe_dev,
-						type_data);
+	return err;
 }
 
 static int mt76_npu_setup_tc_block(struct mt76_phy *phy,

---
base-commit: e1ed98b1836e2bf0aba98f9790be4f3c6bca9d0d
change-id: 20251123-fix-airoha_ppe_dev-sparse-warning-66c62fdb7f72

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


