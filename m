Return-Path: <linux-wireless+bounces-27268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBFFB5530D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A80EAC608C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723F3168E4;
	Fri, 12 Sep 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+p7L5Oc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6803074B2
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690142; cv=none; b=pvMIFkBcYrhw78HV2n6jjtDyM5UcD8XRPoRQigGPfvZCDsTGumOCjvDvnR3VvDnvukfWfCDz+Fi7BYpT/aDszA/U7zMAmIMrXVTTsKMNXisTc58ejW4zGdFvElh2ZIae50vevNjVwsQ3rQN8Vnyw5DN5qhSvAEIwK7gqHkndveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690142; c=relaxed/simple;
	bh=lpXtNXUnkeD2hxRlppy/xJK2BmpxX53cp8KUKDOIVGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tp8Eb7yHaCjEJmwpIGmfRUrsIp5+3AeFmD4k3VfjDtKPS/HCtVgQ1cyPcy4f5qO6Ynrtzt8SM5sEwsDLAVTpOKpxOTjLamSinnxHdrW26R6fIbDMCTeWpa5Rq/+cGjiisb87DIM/ukKARmiYKBsAl0MfmwB1yLMD22sTRJJvfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+p7L5Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA67C4CEF4;
	Fri, 12 Sep 2025 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757690142;
	bh=lpXtNXUnkeD2hxRlppy/xJK2BmpxX53cp8KUKDOIVGw=;
	h=From:To:Cc:Subject:Date:From;
	b=J+p7L5OcNJ/gFFxeT3+GwrXmQZpky2LLx7teJP+yC+sZHFDojv3xFkTMVFtVPdBp/
	 bSIytXfPwYQiMX/BtFRFUSv3uT+8fDYic6pVCrb51RLucKitUwlzshqUtayqNIgakS
	 nCgVgCHqfEWYSq2E6xptcc7AjSxDjB5LURPv0WiowLZpr7lNpnsJOIPM0CuRP7J+J2
	 6llMHn8rzKKo9v72t6vcl5OkBc2kycdtNY0udpodlZHAG7G7Jz9ZTssa3OJIVXc+0p
	 cR682EP6sMEmNMSj9KHu2JlJO0dC/v7x7t14+nWhh6nmuffnYcZtwoLLY/v69c6n7P
	 D6XRCnDSQinrg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: lorenzo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH mt76] wifi: mt76: mt7996: Do not use #elifdef directive
Date: Fri, 12 Sep 2025 17:15:34 +0200
Message-ID: <8215423cad3d3a35e016b7d2b84d5036c3a0d092.1757690020.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not use #elifdef directive since it is a C23 extension but rely
on #elif defined() instead.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index be8bf03aeb4b..fae9c4e07ab9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2258,7 +2258,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.net_fill_forward_path = mt7996_net_fill_forward_path,
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_setup_tc = mt76_wed_net_setup_tc,
-#elifdef CONFIG_MT7996_NPU
+#elif defined(CONFIG_MT7996_NPU)
 	.net_setup_tc = mt76_npu_net_setup_tc,
 #endif
 	.change_vif_links = mt7996_change_vif_links,
-- 
2.51.0


