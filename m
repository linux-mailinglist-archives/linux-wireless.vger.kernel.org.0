Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1814EDB3
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 14:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAaNpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 08:45:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55992 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728708AbgAaNpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 08:45:42 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixWc7-0002Nv-Vw; Fri, 31 Jan 2020 15:45:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:45:26 +0200
Message-Id: <20200131134530.931641-4-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131134530.931641-1-luca@coelho.fi>
References: <20200131134530.931641-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 3/7] iwlwifi: mvm: update the DTS measurement type
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

Till now, the driver asked the fw for a DTS measurement in automatic
mode. This triggered a flow in which the fw actively measured the
temperature.  This is not needed anymore, as the fw performs
measurements by itself, without the driver triggering them, and the
current cadence in which the fw performs such measurements is
sufficient.

In addition, in some time-sensitive scenarios, in which the driver asks
the fw for an active measurement twice in a short time (<100ms), the fw
asserts with code 0x20100801.

Change the DTS measurement to _WITHOUT_MEASURE instead, so the fw will
respond with the last measurement it has performed.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index fcad25ffd811..418e59b7c671 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2013 - 2014, 2019 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014, 2019 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -234,7 +234,7 @@ static int iwl_mvm_get_temp_cmd(struct iwl_mvm *mvm)
 		.flags = cpu_to_le32(DTS_TRIGGER_CMD_FLAGS_TEMP),
 	};
 	struct iwl_ext_dts_measurement_cmd extcmd = {
-		.control_mode = cpu_to_le32(DTS_AUTOMATIC),
+		.control_mode = cpu_to_le32(DTS_DIRECT_WITHOUT_MEASURE),
 	};
 	u32 cmdid;
 
-- 
2.24.1

