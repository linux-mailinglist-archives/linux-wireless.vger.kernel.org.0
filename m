Return-Path: <linux-wireless+bounces-5212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905288AB3A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE581C372FA
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C98A446D9;
	Mon, 25 Mar 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmVX4qMD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831A482F4
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382321; cv=none; b=GyqPGEzUtEo2CVlVTWJb2nJD5tFGNuMLpYU40pBOxzfpOneRyZ+Tn6N4n4wqjkyznFwVtaqzHI+biaiT04Sdtfnjc/v3H7XW/APTASobqaj7vgQ79sG2nFZ7u/LURnaaOQrtljRhgPZF+XZHD/qlJ/fe8+XyPKHmBUGMiMHP6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382321; c=relaxed/simple;
	bh=oReHDUpC6TA5VUbgzAw3E1izvq773nmHZTtGXvqXmKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EuxlK6bmTK2ghGfnNCTC5SqsOK2I2GAXizGPFEOdo8tfyqSTDJtOgm42E6USoKO+KLiE/l3G7viqn9ZgQmatddH51l0hFDUKMfqnNLyMpWWaf8MiqcWpGEOkKXdUTKqndQosasbM8sulfFSW+/kqAoNFbfqb4HVtrPWRoNYVy8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmVX4qMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29174C43390;
	Mon, 25 Mar 2024 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382320;
	bh=oReHDUpC6TA5VUbgzAw3E1izvq773nmHZTtGXvqXmKI=;
	h=From:To:Cc:Subject:Date:From;
	b=KmVX4qMDnHBYxgBmeIO5xIic9jQ0NdGwVOuypfeUDy11xrfFlicxZR9ys/pxIqSh+
	 tioPOGrxAQjRS88Oy6yedDbknxUINo5+kQvem02VwmzqwRKuB4VWNBDopydwy+BYzw
	 2/sfVTwSbtf5Cp1CKxW7ZBNHNQqjdyPbsEN+AGSSIFWLgl0cu7X03XXeIbb+HuA2ms
	 zPnfbOa3/6+m7dGQRAQlSDkaFNtWVMo5d+T3tNECSgy6Ufq8wm1wkMMwHXxb1/fjGe
	 myLg+S0ChIEBN3mzF81nfV+pCZtT11WhlkLpkz7VeM37f2dyJuuwKya197nOWEeBQB
	 DFuPlYzjXfDTg==
From: Kalle Valo <kvalo@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: mt7915: workaround dubious x | !y warning
Date: Mon, 25 Mar 2024 17:58:38 +0200
Message-Id: <20240325155838.1558680-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse warns:

drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:526:9: warning: dubious: x | !y

Workaround it by using the '?' operator. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
v2:

* use parenthesis

 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 450f4d221184..578013884e43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -523,7 +523,8 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 
 	/* WM CPU info record control */
 	mt76_clear(dev, MT_CPU_UTIL_CTRL, BIT(0));
-	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw.debug_wm);
+	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) |
+		(dev->fw.debug_wm ? 0 : BIT(0)));
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR, BIT(5));
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR, BIT(5));
 
-- 
2.39.2


