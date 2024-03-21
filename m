Return-Path: <linux-wireless+bounces-5099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315F885C2A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F24B24F96
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB486ACD;
	Thu, 21 Mar 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6MfFBfN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4086AC6
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035280; cv=none; b=f/fvKbok0MtqkYhDA4ceQKvq4rN6/Oe0U13vmg678xN+uMLbvyr9VF53Qk0iV0SKQkmvvSNZIgtpRIrwFzFH4IjLMIWPh6GXLUFQE8NuDX5w0KfodrDnMD3HFHEw73uxRhvjBHtyS0nHX9OMqmzEro4AWh5kByHFmP2JxQBSv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035280; c=relaxed/simple;
	bh=MAHUPtYjdGc+9hQjJoAj0zR0wpCQp51B1j0aTAHtuuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPs5QPVd26QbJjQkblGr1h2gaQpEh2CNt/kL+4BiEz/RsfHutl11K0nY2EvkcZdiL+o/vofC4WbSYqLy4HvTXU+LkLEtuzHm48syDM30wFRe5A3ImWYw9amfFS4v3X+1SBIdv8R7xD6c8ST0iZhzpOoJyPyzJZnX0/8VJkU+4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6MfFBfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A86C43390;
	Thu, 21 Mar 2024 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035279;
	bh=MAHUPtYjdGc+9hQjJoAj0zR0wpCQp51B1j0aTAHtuuk=;
	h=From:To:Cc:Subject:Date:From;
	b=p6MfFBfNAdVwWojjb/eAHspZ3SudeVqtYjKy2IJM//3Y4TaljCJiIN3dyDbzm5csw
	 H733ilr46+ch7QFNladD/6F3GOoCRM9yCSkc2iPKdrq1SEhSW802aDHh/caSYYMPbV
	 zTMtiSU/jJXRzOy9xdvwqjnLQEehuLhu9uvx46p1mRK4KsfXfIp0Q6uWKXuBCa8buH
	 OkI/Ih3hYT/B03wOfZj/GVBgRfm27ItaLSMHEnLUnLHaxopqsvOackgQMRfGE/88lk
	 b9tEIBch+dlUOZoxYmA9hP3/mrxhIWDjEOzm6tKTKucK6j0ej6ekrIO1KSJ1XPuiME
	 qXZ/aDsAcjShQ==
From: Kalle Valo <kvalo@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: workaround dubious x | !y warning
Date: Thu, 21 Mar 2024 17:34:37 +0200
Message-Id: <20240321153437.403259-1-kvalo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 450f4d221184..3f47aafb1a6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -523,7 +523,7 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 
 	/* WM CPU info record control */
 	mt76_clear(dev, MT_CPU_UTIL_CTRL, BIT(0));
-	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw.debug_wm);
+	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | dev->fw.debug_wm ? 0 : BIT(0));
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR, BIT(5));
 	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR, BIT(5));
 

base-commit: 61cdb09ff760dd32439cde1200a1a8bd208807cd
-- 
2.39.2


