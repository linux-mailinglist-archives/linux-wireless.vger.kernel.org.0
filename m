Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575FF926D4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfHSOf2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 10:35:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36822 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727094AbfHSOf1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 10:35:27 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzikn-0007sP-HS; Mon, 19 Aug 2019 17:35:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 17:34:54 +0300
Message-Id: <20190819143507.6989-10-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819143507.6989-1-luca@coelho.fi>
References: <20190819143507.6989-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 09/22] iwlwifi: add ldbg config cmd debug print
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

add support to print ldbg command in mvm and xvt mode

type=feature
ticket=none

Change-Id: Ic5a963db7785f616e49af7f7e7ee0cd86408e07d
Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Reviewed-on: https://git-amr-3.devtools.intel.com/gerrit/223367
automatic-review: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Tested-by: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index bf0b9ee05c44..2aa5320e9d1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -414,6 +414,7 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(SCAN_ITERATION_COMPLETE),
 	HCMD_NAME(D0I3_END_CMD),
 	HCMD_NAME(LTR_CONFIG),
+	HCMD_NAME(LDBG_CONFIG_CMD),
 };
 
 /* Please keep this array *SORTED* by hex value.
-- 
2.23.0.rc1

