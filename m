Return-Path: <linux-wireless+bounces-4901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102E87FD54
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 13:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029ED1F2359B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973887F499;
	Tue, 19 Mar 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whl8MqBb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745967CF03
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849951; cv=none; b=ed+haxJ8wmVUtbC5Iv7ZfX1WXCZU7KCzTENcJvtoXQcHsPcfqFxrBmr38mACmw6AJ52pdd0sYxLWNI/RYhxHuRhgT93GNi1HqcO607HwVT78cseLcZg3eNqj8hLzVedsdxoT/CmXHs3sc2o0N+aNQv/CfwjTiPNe/dXb0GPVWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849951; c=relaxed/simple;
	bh=jbL5yL060xn9hTPjy4Qy/WXnGskckZCSHcM9eCIR0NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMtHzZ28e/oGScDO6qCpS2E3eNNSshnEjpp78ByH0W7HgwoEChwKtjkGyRyqyah8sfU1edzOo3dJMLa+l2nl3mOL75unhFDjQQtW2zTnAEf6MY9lJtFe3ON7QlZ1IlZY6YJg87L/6455k40termA+VNSc1IA5n7v4lMPRzH/VtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whl8MqBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA3FC43390;
	Tue, 19 Mar 2024 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710849950;
	bh=jbL5yL060xn9hTPjy4Qy/WXnGskckZCSHcM9eCIR0NI=;
	h=From:To:Cc:Subject:Date:From;
	b=Whl8MqBb+kkkLfTjCrOW7DUrQiUAxSYQMutbOj6x1+uZjUXq8Zur0kqAWZMwNxCQx
	 1FgnGU4f74ZTtHXiLpIJMrdQqiHgDKOuRaUKpzMIs+VMyI/vhTzOy6QpNq4czGYlNM
	 YF3DsyIJZhY7RIE/c6nft3Kj9NiffxNN0HBvXz9G+N2rn4IY0BxJjXsQQu/UD90XXe
	 U11ZOJoYtHd7anhKe0DByCal3TBlU28QfOKyOeoJS3WmLqLx1aUAbihkBcLJCRKAnx
	 YteXamo9yUiXtl/h/zkoKLrmaiMnyvHH8lE+bNyWEFzZugn9czGb3KYxln8hH7xgRW
	 U0kP06Tr0mtCQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: linux-wireless@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	shayne.chen@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7996: fix uninitialized variable in mt7996_irq_tasklet()
Date: Tue, 19 Mar 2024 13:05:36 +0100
Message-ID: <a9a5135d456e3070b79716e92422fa9fb9b98854.1710849730.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set intr1 to 0 in mt7996_irq_tasklet() in order to avoid possible
uninitialized variable usage if wed is not active for hif2.

Fixes: 83eafc9251d6 ("wifi: mt76: mt7996: add wed tx support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 304e5fd14803..928a9663b49e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -519,7 +519,7 @@ static void mt7996_irq_tasklet(struct tasklet_struct *t)
 	struct mt7996_dev *dev = from_tasklet(dev, t, mt76.irq_tasklet);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct mtk_wed_device *wed_hif2 = &dev->mt76.mmio.wed_hif2;
-	u32 i, intr, mask, intr1;
+	u32 i, intr, mask, intr1 = 0;
 
 	if (dev->hif2 && mtk_wed_device_active(wed_hif2)) {
 		mtk_wed_device_irq_set_mask(wed_hif2, 0);
-- 
2.44.0


