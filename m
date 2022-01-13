Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08F948D01D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 02:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiAMBZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 20:25:29 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:39822 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231290AbiAMBZZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 20:25:25 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 20:25:25 EST
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6B101277DE
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 01:16:52 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6BAF71A0068
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 01:16:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4B22E500077
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 01:16:50 +0000 (UTC)
Received: from ct524-freya.jbr.candelatech.com. (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A24C713C2B0;
        Wed, 12 Jan 2022 17:16:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A24C713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1642036609;
        bh=u6BWvetPQcuyHWQ7ixuGV3LAgYOBFjh34u/bUXUVoyE=;
        h=From:To:Cc:Subject:Date:From;
        b=mkqM8Ym+9H/LkAEJp8RpFRD3Wae4RAUKhNJq3PpeHuIKEAWVBsg82et1Rbhwo/5WK
         BL1hAr3rNKnTc+8+eAkSyc/BYuOCmFp9ZLgPrJBg1A5maOSnNZIvb/VTJtzYng26vJ
         Mp4+u33R7ni0f6A/WMutTuVnBtBLzzc/D/OlmA/s=
From:   chuck.smileyrekiere@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Chuck SmileyRekiere <chuck.smileyrekiere@candelatech.com>
Subject: [PATCH] Revert "iwlwifi: mvm: disable RX-diversity in powersave"
Date:   Wed, 12 Jan 2022 17:16:46 -0800
Message-Id: <20220113011646.38569-1-chuck.smileyrekiere@candelatech.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1642036610-7ootQilsisUU
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chuck SmileyRekiere <chuck.smileyrekiere@candelatech.com>

This reverts commit b94d328763785738d052d176c345d8cc9d999e9a.

The number of rx spatial streams would not go to 2 spatial streams
when testing on WiFi 6E AX210 radios. Reverting this commit allows
for the WiFi 6E AX210 radios to go to 2 spatial streams. The issue
only showed up when testing on WiFi 6E.

Signed-off-by: Chuck SmileyRekiere <chuck.smileyrekiere@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 941cce77a5b2..acceb4069f54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -446,9 +446,6 @@ bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_CAM)
-		return false;
-
 	if (num_of_ant(iwl_mvm_get_valid_rx_ant(mvm)) == 1)
 		return false;
 
-- 
2.31.1

