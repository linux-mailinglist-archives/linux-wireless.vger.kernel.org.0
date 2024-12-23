Return-Path: <linux-wireless+bounces-16707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4E59FA8FB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 02:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFAF7A205B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A138DE0;
	Mon, 23 Dec 2024 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kKre8Kil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B931DDA8;
	Mon, 23 Dec 2024 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917532; cv=none; b=EO2ZpGvs4+5kQl4IU9hKuD/VWNCvXVR5NMmoAveUTgetKGciqn33+KTtw7ef3sjqSANPe2dP3OFNlbVqLnBGAR7RWyVuRH3cHXxRmejO1GlOEy4J64oyhtkN65MqtaHgg2YQLNj3/l2aopGSidUD7O1QAj4gikZqNxRHBu5untk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917532; c=relaxed/simple;
	bh=8ou9LlguTwyEV+M74zW3vdjCQ+MGHuYcOWdmmX96lEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+Apvy6Ip4gMZnvYXvEfWux8xJbM9RCCJlpc7jpBXyZBEVP4lzlAwmmA299O/AHjz1ZfxgEUzXnN6mplpmM4YLK0Os3l2b7ncfL7TsRH1AtQxMEtI4D7DdGhCqKuVP+mfIT42nmTLcUJ8MYUi5dkHF016EYefGAbDhvLeRuozMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kKre8Kil; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=HquINi6LMi37dKa43YAg1uxOYXWj2/1Hvuwsih+Xmkk=; b=kKre8KilghFdqaE+
	e2ZND1ztlnG5eFtIZFDwMbhn5w/GfYWZqXj1OAW1vLOJ7mUJ2/pYRbMXWw+tcrQAwBOIEe2Q1Y0ZB
	vP7GeTno+gMBeH9k7HsMOwBFRmElutHoM3EQGFbNiZnlGfHoHt0DU8UbO/9sPu0OmYZQpMMtgI5r6
	/SDYj+do7sAelEzOROZR2Mp+U7FCJ4/eRo9kELaDoKDAoBcMOzALEqkich0cODKp+JklQ31B/wPlg
	WbcCd7oDz8M2vI1/dUx5+J5qliycSAkrmIaagp5q/qBKO0wJhw0fvqNSFPgoNbJeaHBsW2doV+89O
	rJTfEp1WQu9dOERiMw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPXIl-006oGv-0t;
	Mon, 23 Dec 2024 01:32:07 +0000
From: linux@treblig.org
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 5/6] iwlwifi: Remove unused iwl_bz_name
Date: Mon, 23 Dec 2024 01:32:01 +0000
Message-ID: <20241223013202.340180-6-linux@treblig.org>
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

iwl_bz_name[] has been unused since the resent
commit 6795a37161fb ("wifi: iwlwifi: Print a specific device name.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index cd1fe8490ae5..589fba0cc045 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -159,7 +159,6 @@ const struct iwl_cfg_trans_params iwl_gl_trans_cfg = {
 	.low_latency_xtal = true,
 };
 
-const char iwl_bz_name[] = "Intel(R) TBD Bz device";
 const char iwl_fm_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
 const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
 const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 34c91deca57b..e17fadfc0227 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -543,7 +543,6 @@ extern const char iwl_ax211_name[];
 extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
-extern const char iwl_bz_name[];
 extern const char iwl_fm_name[];
 extern const char iwl_gl_name[];
 extern const char iwl_mtp_name[];
-- 
2.47.1


