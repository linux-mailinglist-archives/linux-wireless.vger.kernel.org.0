Return-Path: <linux-wireless+bounces-20492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CFCA66FCD
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 10:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A7D170919
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC401A7249;
	Tue, 18 Mar 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="orNCR5xg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595731422AB
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290228; cv=none; b=ZT0N0OmTJG8ixP+aC4CDmklBAnkFv4jb0B/ScMEtvcapNlobLlEQZHMoNwGXy5DPq0bq2VXrJow5oerEB5XVELC+3/zOQaSppFXYW6Xjmc/Acuh1UFhtpaxRaUNx49Apv54rskzuFjj6g0nmRsIsVDf9F3anEowL/fYSuI8wmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290228; c=relaxed/simple;
	bh=+op1/v9dK/k7mvr9L9Qgoolnf8dCT50y4N+KBm7fZ+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0/fy5I5R5S4XW65VEJtWSQiyj/n+B1EISDbt5yCGaT2TBqY5B9mmBNUYvOjPLyW6WRbo3tc12zhaF5NGmeJNw4sDLIqMl7jAj7fJJNKcjrkREqEuE6erpig1FcA7mqtLYJXWncVileLJyNOarELh6swiSn6SGaJXtRe0mTZ8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=orNCR5xg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QZ19+/2cTLIjgtsDbNRKLejFX5MVg4jDHuA/6Eb0aIo=;
	t=1742290227; x=1743499827; b=orNCR5xgmWL4z5wGCI47yebICLrzioybc8/wfpp6osLLwBx
	WFLfqtp+7lSgUJgmxXMR4K0JXAciaO66zHef1Zy7EWMXYEG9IedmCN5zzXCHUgIzGU2zWRaKpD8uv
	qnDLPHPgbWMMDEI9a6B6E6pd340jbruHkG7mZUpwetApDV/QpCdSjXif97lUq/LnJ3pi8wjEijrXe
	1PB4uttLCHMzBW8fmgebxOKKamWsEEmXUu1tUXP29WFqDZ0t48991X3h6zWIn3JLbf5QXpAGxlsTP
	zbKcIdJTti7b5V73nzNyrYvZwiqkx1EAUdkkD3eH1xbuX4VFyKhSf8/9mgmPnizQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuTHE-0000000FBmW-0WPK;
	Tue, 18 Mar 2025 10:30:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: iwlwifi: remove a buggy else statement in op_mode selection
Date: Tue, 18 Mar 2025 10:29:43 +0100
Message-ID: <20250318103019.bf54d0474909.Icfb129d4cf13b42b13e2ac4aa1bd171ef46bf561@changeid>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318093019.185216-4-johannes@sipsolutions.net>
References: <20250318093019.185216-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This led to weird behavior. The next debug print was not printed.

Fixes: d1e879ec600f9 ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index dcf07ac042f7..15d2211e565c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1732,7 +1732,6 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 #if IS_ENABLED(CONFIG_IWLMLD)
 	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION)
 		op = &iwlwifi_opmode_table[MLD_OP_MODE];
-	else
 #else
 	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION) {
 		IWL_ERR(drv,
-- 
2.48.1


