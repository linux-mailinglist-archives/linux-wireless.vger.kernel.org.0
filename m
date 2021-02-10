Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0583165DE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBJL7l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 06:59:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44970 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230410AbhBJL5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 06:57:37 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9o6q-0049Ur-Mt; Wed, 10 Feb 2021 13:56:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 13:56:29 +0200
Message-Id: <iwlwifi.20210210135352.b0ec69f312bc.If77fd9c61a96aa7ef2ac96d935b7efd7df502399@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210115637.276676-1-luca@coelho.fi>
References: <20210210115637.276676-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 04/12] iwlwifi: mvm: fix the type we use in the PPAG table validity checks
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The value we receive from ACPI is a long long unsigned integer but the
values should be treated as signed char.  When comparing the received
value with ACPI_PPAG_MIN_LB/HB, we were doing an unsigned comparison,
so the negative value would actually be treated as a very high number.

To solve this issue, assign the value to our table of s8's before
making the comparison, so the value is already converted when we do
so.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6a6567a7372b..3bfb80dd17cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -965,16 +965,23 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 			union acpi_object *ent;
 
 			ent = &wifi_pkg->package.elements[idx++];
-			if (ent->type != ACPI_TYPE_INTEGER ||
-			    (j == 0 && ent->integer.value > ACPI_PPAG_MAX_LB) ||
-			    (j == 0 && ent->integer.value < ACPI_PPAG_MIN_LB) ||
-			    (j != 0 && ent->integer.value > ACPI_PPAG_MAX_HB) ||
-			    (j != 0 && ent->integer.value < ACPI_PPAG_MIN_HB)) {
-				ppag_table.v1.enabled = cpu_to_le32(0);
+			if (ent->type != ACPI_TYPE_INTEGER) {
 				ret = -EINVAL;
 				goto out_free;
 			}
+
 			gain[i * num_sub_bands + j] = ent->integer.value;
+
+			if ((j == 0 &&
+			     (gain[i * num_sub_bands + j] > ACPI_PPAG_MAX_LB ||
+			      gain[i * num_sub_bands + j] < ACPI_PPAG_MIN_LB)) ||
+			    (j != 0 &&
+			     (gain[i * num_sub_bands + j] > ACPI_PPAG_MAX_HB ||
+			      gain[i * num_sub_bands + j] < ACPI_PPAG_MIN_HB))) {
+				ppag_table.v1.enabled = cpu_to_le32(0);
+				ret = -EINVAL;
+				goto out_free;
+			}
 		}
 	}
 	ret = 0;
-- 
2.30.0

