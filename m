Return-Path: <linux-wireless+bounces-4040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C16986876A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 03:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FA1C2134D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 02:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36A14F78;
	Tue, 27 Feb 2024 02:52:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kevlo.org (ns.kevlo.org [220.134.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61361746E
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 02:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.134.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002320; cv=none; b=QDq6j3Oz761T87msFo6OmwVv0DM896tpT9oz9oLLiaQpjJna1Dp4f9jq99cgbzJiHLYVUsMfzkM93rCO04/LLuOYYXHbQ4FBywOQDi+i0bl3KzWccwdgZp/Y5ZIKeChTe742O0w0//I1R4T5yRBVeMl21R3vir34lXhDsJMMUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002320; c=relaxed/simple;
	bh=3kmg2rcjI53Rr2QIt03wBMWRGGEOd5noondpHfO46jI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ngfqEbKIBi+YWepqXYSaJk7XQzSz5wuuxEr+hVggYtwAghnpNeycbE9yv77LAV1o60jjD88d4kwOz0VrUOSAcEj6ihXC5BwN6UlLzIe6x1yDKuO/V3Aq0kqry+glMStKTgXB5jbVcRSd7tOw1H3GTTQspcQiixRwNGhUKPiNECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kevlo.org; spf=pass smtp.mailfrom=kevlo.org; arc=none smtp.client-ip=220.134.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kevlo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevlo.org
Received: from localhost (ns.kevlo.org [local])
	by ns.kevlo.org (OpenSMTPD) with ESMTPA id 61ec6d79;
	Tue, 27 Feb 2024 10:45:15 +0800 (CST)
Date: Tue, 27 Feb 2024 10:45:15 +0800
From: Kevin Lo <kevlo@kevlo.org>
To: ath11k@lists.infradead.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: adjust a comment to reflect reality
Message-ID: <Zd1Muyd8mtA1Hih7@ns.kevlo.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In ath11k_mhi_set_mhictrl_reset(), I observed on QCA6390/QCN9074/WCN6855,
MHISTATUS has SYSERR bit always been set after SOC_GLOBAL_RESET.

Signed-off-by: Kevin Lo <kevlo@kevlo.org>
---
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 3de7fa6f88d0..1198e80d9dff 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -158,8 +158,8 @@ void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab)
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "mhistatus 0x%x\n", val);
 
-	/* Observed on QCA6390 that after SOC_GLOBAL_RESET, MHISTATUS
-	 * has SYSERR bit set and thus need to set MHICTRL_RESET
+	/* After SOC_GLOBAL_RESET, MHISTATUS has SYSERR bit
+	 * always been set and thus need to set MHICTRL_RESET
 	 * to clear SYSERR.
 	 */
 	ath11k_pcic_write32(ab, MHICTRL, MHICTRL_RESET_MASK);

