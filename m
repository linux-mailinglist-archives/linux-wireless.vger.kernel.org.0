Return-Path: <linux-wireless+bounces-10852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8100945711
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 06:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85A81C230C5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 04:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD324A955;
	Fri,  2 Aug 2024 04:28:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DA208D7;
	Fri,  2 Aug 2024 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572882; cv=none; b=ct165hJhAmKjnKZIywhPz3ZUVbEJBAmhXVadaoxqTYTnPq6faDAQ//xapuiEMr7DIEEhgSEGWxl46XvbKIBPewyqKvOjDwQozEWR9OCl3dGF+n2yrSlEEeiXXw9i/x7OGAXTDCGDdkifSEUAzWVMfg9Ov8bWMiO31u7zHLU5Vqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572882; c=relaxed/simple;
	bh=0sA4qP4oa2I6sIScrWlfoGqUSY09O6KqqY/soVRrwMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j9VKwJNx0tfJAgAJsXLZrvX7N4l1wKUCtVBIOLcYZTVCD9hhTBM2SPamS7sRUj7USFwOWx4RqpLW89C3Sdg/YDcSG3ig99UGU5rCEwu7SEy4fxZKWk8OQAj30ksMLTLkDk4ZrXaAUMOVPM4pAoqq6CpMOeSMCb3JVoQXs7RIHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAAX9hg9YKxm9r_rAg--.10938S2;
	Fri, 02 Aug 2024 12:27:52 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	johannes.berg@intel.com,
	gregory.greenman@intel.com,
	benjamin.berg@intel.com,
	daniel.gabay@intel.com,
	make24@iscas.ac.cn,
	dan.carpenter@linaro.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in iwl_mvm_alloc_sta_after_restart()
Date: Fri,  2 Aug 2024 12:27:40 +0800
Message-Id: <20240802042740.1567091-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAX9hg9YKxm9r_rAg--.10938S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrykJr4UCrWUAryDKr15Arb_yoWDWFg_Cr
	1SgFn3Jr1DCF4YvrsrCF4fZ34YyFyq93W8ur97ta9xKr4DCFyUJrZ0qa4UtrZ09r4UAFnr
	G3WDCFyxC39IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
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


