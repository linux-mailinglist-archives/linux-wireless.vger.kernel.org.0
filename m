Return-Path: <linux-wireless+bounces-16704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D7B9FA8F4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 02:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC16165797
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B83D531;
	Mon, 23 Dec 2024 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="n7E1sjEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0EBA33;
	Mon, 23 Dec 2024 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917531; cv=none; b=FinpWi58w2UEsKVIdSSj4orTaSik/9BzGOtORvvNkp5QnCjVyCO6CR4FApQZHoDBJ8h74gEUk0ab68mQ5ANMS1LUDbjKL2IpkIDKfM1rJUI0S76iRXjdETPVdGrTv3uERuVxspD6lEB+XpBanC4xjJ9hx9zXGqDrbU7gvT6oPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917531; c=relaxed/simple;
	bh=es/BSfafOQu9aJV/H85pIMU+pNqTBjwOJDkB15yG0eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPxlwX8OSkdPqXYUBHxFfWeC7q04mgHH0rbSyD9LSebA/e2d28R85mtOWMGNHicN/3za9dTT3MstICVeZP5Hq7T3FWTGiE2xDQ7X5HHJtIrbs91TcjhSEQY9mwAIXYaPepMQlnuuPIcnfG+Okx+LQ18otbm1/8sMThr8kLR4o/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=n7E1sjEq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=23CkBGQ2yrQnc+unEFyAjbUDJwtLvJlxXwZBoTMJE0w=; b=n7E1sjEqWf++EBvG
	4NhvYwaS3jJY4folcTKZzBCQwpHi/0ogMAqwmq7Z79pSxyMSab5cOmipaIWcxLgBihJrx5hAK8IdL
	4X/0sw+XoDvBuUwb8sbQ6EU8UbwmVZLLCdY4S+TVItp8CWUG49e6cBg3ks+ZivIETeo1hBLc5iJ1S
	QioqD1567pP8PqMLfPUr1TwAoAQGf28+mWZfGgVssqZZIVYwfW1W/6TIyETy2SDsnzUicvAYNFo7I
	rj0aBpJCACAVk7KzdixGHtPQjyepeEuFxIrrUmsdAyadm1PVwey6R6sOaxUAm/B+Sb8XNdEnG/n/k
	iHleVx2momyYWaY3nQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPXIi-006oGv-1q;
	Mon, 23 Dec 2024 01:32:04 +0000
From: linux@treblig.org
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/6] iwlwifi: Remove unused iwl_rx_ant_restriction
Date: Mon, 23 Dec 2024 01:31:57 +0000
Message-ID: <20241223013202.340180-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223013202.340180-1-linux@treblig.org>
References: <20241223013202.340180-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

iwl_rx_ant_restriction() was added in 2009 by
commit 46f9381aa3fb ("iwlwifi: Thermal Throttling Management - part 2")
but never used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c | 11 -----------
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
index 43e8d04d5a8b..e1d78550e443 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.c
@@ -124,17 +124,6 @@ enum iwl_antenna_ok iwl_tx_ant_restriction(struct iwl_priv *priv)
 	return restriction->tx_stream;
 }
 
-enum iwl_antenna_ok iwl_rx_ant_restriction(struct iwl_priv *priv)
-{
-	struct iwl_tt_mgmt *tt = &priv->thermal_throttle;
-	struct iwl_tt_restriction *restriction;
-
-	if (!priv->thermal_throttle.advanced_tt)
-		return IWL_ANT_OK_MULTI;
-	restriction = tt->restriction + tt->state;
-	return restriction->rx_stream;
-}
-
 #define CT_KILL_EXIT_DURATION (5)	/* 5 seconds duration */
 #define CT_KILL_WAITING_DURATION (300)	/* 300ms duration */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
index 4af792d41dce..198f934a0d16 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
@@ -100,7 +100,6 @@ u8 iwl_tt_current_power_mode(struct iwl_priv *priv);
 bool iwl_tt_is_low_power_state(struct iwl_priv *priv);
 bool iwl_ht_enabled(struct iwl_priv *priv);
 enum iwl_antenna_ok iwl_tx_ant_restriction(struct iwl_priv *priv);
-enum iwl_antenna_ok iwl_rx_ant_restriction(struct iwl_priv *priv);
 void iwl_tt_enter_ct_kill(struct iwl_priv *priv);
 void iwl_tt_exit_ct_kill(struct iwl_priv *priv);
 void iwl_tt_handler(struct iwl_priv *priv);
-- 
2.47.1


