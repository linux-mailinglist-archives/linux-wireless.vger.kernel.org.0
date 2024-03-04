Return-Path: <linux-wireless+bounces-4335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB786FBC1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 09:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E231F21728
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 08:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDEC17560;
	Mon,  4 Mar 2024 08:22:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kevlo.org (mail.kevlo.org [220.134.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931C171AF
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.134.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540524; cv=none; b=uaM2m5+mUXsBKYJ7dGrIh7dQ4AgHlv8V4+AV132FzmIUiAxndrCtKiKNwPHxSxdq+EuJlE7ynXxgIvmRQEm1hUHCNe4MNr//qRrX9jIs92MIMcOMLWRFwodga3dJUYoZ34SHZlh968b88rBA8MhjkkLuJtqftYRPAk7xQ00/P9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540524; c=relaxed/simple;
	bh=71ZK4g1MeT75y19WsqXFQT1Zj55AUp39uYBT0Fbz4pI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gkNSjMr4q6FaHenEfnlDWBtUYySTzriq0Zo74ar/sGc9j7tdW3N/q7OR9jFbCRnpEvDsMlssJCSw3z4r4v9WjRpgm/CmwKVSImb6MO3bv/qVgF7PDD3qur2GokklArkZnGIDmmScH5B7C1XixL7N+Iamp2r2dEf1SGmrRRHuzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kevlo.org; spf=pass smtp.mailfrom=kevlo.org; arc=none smtp.client-ip=220.134.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kevlo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevlo.org
Received: from localhost (ns.kevlo.org [local])
	by ns.kevlo.org (OpenSMTPD) with ESMTPA id 07a1ee66;
	Mon, 4 Mar 2024 16:22:00 +0800 (CST)
Date: Mon, 4 Mar 2024 16:22:00 +0800
From: Kevin Lo <kevlo@kevlo.org>
To: ath11k@lists.infradead.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: adjust a comment to reflect reality
Message-ID: <ZeWEqGVibkMg2APi@ns.kevlo.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On QCA6390/QCN9074/WCN6855, MHISTATUS may still have SYSERR bit set
after SOC_GLOBAL_RESET.

changes for v2:
- update comment about resetting MHICTRL to clear SYSERR

Signed-off-by: Kevin Lo <kevlo@kevlo.org>
--- 
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index fb4ecf9a103e..956fff0d4962 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -158,9 +158,8 @@ void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab)
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "mhistatus 0x%x\n", val);
 
-	/* Observed on QCA6390 that after SOC_GLOBAL_RESET, MHISTATUS
-	 * has SYSERR bit set and thus need to set MHICTRL_RESET
-	 * to clear SYSERR.
+	/* After SOC_GLOBAL_RESET, MHISTATUS may still have SYSERR bit set 
+	 * and thus need to set MHICTRL_RESET to clear SYSERR.
 	 */
 	ath11k_pcic_write32(ab, MHICTRL, MHICTRL_RESET_MASK);
 

