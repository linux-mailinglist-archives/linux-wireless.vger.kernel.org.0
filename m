Return-Path: <linux-wireless+bounces-10138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2928192C693
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 01:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55C11F2273D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 23:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703BF187541;
	Tue,  9 Jul 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="X+7NiPBA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A11FA3
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567710; cv=none; b=QQ2Fpk1QyEl46gkYKl5ySLq7YpLFNp8dovJ0nS1vXbzUr7WWNvbPexarKqkhX7rHuKIzvFkJw6lXZ1/VCqeXSAvFBbeKuD8cT1OBgpeYcYz5ZzPpe5rw7ND//w33LLgxEQpKBYpYPH2o/j3ZO47pWowCD1z/+sc/ucF0dvjTzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567710; c=relaxed/simple;
	bh=+K4OgN/iUdM17OyedpZPgwcnkao8B61tsbza6AB8jEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rapSlkDVCS+GiFt743lN753lXVlN9UiZW33kli661LmkzO77ELqw2LukhdMS0aw2Q7X9yFDzToE19FHLFI1TmLozI5aoj0fOPop1Nj68SiPVg5YEZmhesbkW2NwyRuUWp6E7yxurw1Q9GwPENeHvGmsxfyUu/tIhGpZN4Nybh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=X+7NiPBA; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D111BB80065
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 23:28:19 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 3862413C2B0;
	Tue,  9 Jul 2024 16:28:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3862413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1720567699;
	bh=+K4OgN/iUdM17OyedpZPgwcnkao8B61tsbza6AB8jEM=;
	h=From:To:Cc:Subject:Date:From;
	b=X+7NiPBAP76Ggw3kWPCZy50UJFf4LkvQuEL1WKN3eC3xlCfEmE+CG18LqoXjIqCGk
	 Y9WNqn2IikNf2ZZgvvancY37oyjVW1eQeDAf9mjpBnET/KyGtHiJvbf/XKnT0DScgi
	 zGl8FrSUD6c0DPdbmFTosCSyMZWjiNZ6hKkNdv9w=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi:  Add esr info to debugfs
Date: Tue,  9 Jul 2024 16:28:17 -0700
Message-ID: <20240709232817.3369578-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1720567700-s9Opu68PuGhH
X-MDID-O:
 us5;at1;1720567700;s9Opu68PuGhH;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

To help provide some clues about how eMLSR is working
or not.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 40b095082d56..c1677b36309a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1085,6 +1085,25 @@ static ssize_t iwl_dbgfs_fw_system_stats_read(struct file *file,
 			 "accu_radio_stats.tx_time %lld\n",
 			 mvm->accu_radio_stats.tx_time);
 
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.esr_disable_reason: 0x%x\n",
+			 mvmvif->esr_disable_reason);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.link_selection_res: 0x%x\n",
+			 mvmvif->link_selection_res);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.primary_link: %d\n",
+			 mvmvif->primary_link);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.link_selection_primary: %d\n",
+			 mvmvif->link_selection_primary);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.last_esr_exit: ts: %lu  reason: 0x%x\n",
+			 mvmvif->last_esr_exit.ts, mvmvif->last_esr_exit.reason);
+	pos += scnprintf(pos, endpos - pos,
+			 "mvmvif.esr_active: %d\n",
+			 mvmvif->esr_active);
+
 release_send_out:
 	mutex_unlock(&mvm->mutex);
 
-- 
2.42.0


