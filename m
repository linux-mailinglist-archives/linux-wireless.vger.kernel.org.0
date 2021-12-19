Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5034E479FF8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 10:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhLSJBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 04:01:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51276 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231580AbhLSJBe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 04:01:34 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mys4P-001O16-HF; Sun, 19 Dec 2021 11:01:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 11:01:24 +0200
Message-Id: <20211219090128.42417-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 0/4] iwlwifi: fixes for new W=1 warnings and errors
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi Kalle,

As agreed, here are the patches to fix the W=1 warnings and errors
reported by Jacub.

Please take them directly to wireless-drivers-next as we discussed.

Thanks!

Cheers,
Luca.


Johannes Berg (3):
  iwlwifi: mei: fix W=1 warnings
  iwlwifi: mvm: add missing min_size to kernel-doc
  iwlwifi: mvm: add dbg_time_point to debugfs

Luca Coelho (1):
  iwlwifi: mvm: fix imbalanced locking in iwl_mvm_start_get_nvm()

 drivers/net/wireless/intel/iwlwifi/mei/main.c    | 10 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     |  3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.34.1

