Return-Path: <linux-wireless+bounces-10454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52193A1D6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188511C223F8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8A15351B;
	Tue, 23 Jul 2024 13:43:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3886152DED;
	Tue, 23 Jul 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742232; cv=none; b=uXHR8j//mgfZw9BFBx8rimYimigDfarqxoePCKglHWXnW8wZijZJn16nYB2XetmSp/SF9dIKDEL0l15JJjgCBadah0LFvFrOFRpKAM01/wCFkuXDlRc46qCmNKapNOTVWrCd4IdYHWz7FNJ31XSbTQat1kSejcMd2/0+J53vna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742232; c=relaxed/simple;
	bh=0sA4qP4oa2I6sIScrWlfoGqUSY09O6KqqY/soVRrwMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dtpXbuGop0dgHh+IQnqsPPSse0afVbd1z1QLTDbq21GPNgNHFohTCH2QeGOViygbPwfiywiuonSLh1vmOIJZKQSqadYWtCz3KR2HunrKfUJn/ly10H0GhuLPEZIKdBhz9gHcFVvXFe2+/sRgsUyboOQPhNH027gX98Bjzc8ArM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHcECEs59mgYKQAA--.4709S2;
	Tue, 23 Jul 2024 21:43:41 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	johannes.berg@intel.com,
	gregory.greenman@intel.com,
	benjamin.berg@intel.com,
	make24@iscas.ac.cn,
	emmanuel.grumbach@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mvm: fix an error code in iwl_mvm_alloc_sta_after_restart()
Date: Tue, 23 Jul 2024 21:43:30 +0800
Message-Id: <20240723134330.1327001-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHcECEs59mgYKQAA--.4709S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrykJr4UCrWUAryDKr15Arb_yoWDWFg_Cr
	1SgFn3Jr1DCF4YvrsrCF4fZ34YyFyq93W8ur97ta9xKr4DCFyUJrZ0qa4UtrZ09r4UAFnr
	G3WDCFyxC39IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VU122NtUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

This error path should return -EINVAL instead of success.

Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index d5a204e52076..477239a1ed83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -644,12 +644,12 @@ static int iwl_mvm_alloc_sta_after_restart(struct iwl_mvm *mvm,
 						  lockdep_is_held(&mvm->mutex));
 
 		if (!link_conf)
-			continue;
+			return -EINVAL;
 
 		mvm_link = mvmvif->link[link_conf->link_id];
 
 		if (!mvm_link || !mvm_link_sta)
-			continue;
+			return -EINVAL;
 
 		sta_id = mvm_link_sta->sta_id;
 		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta,
-- 
2.25.1


