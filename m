Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0359F1B7C1E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgDXQrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57974 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgDXQrW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1Tz-000OcH-IY; Fri, 24 Apr 2020 19:47:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:46:56 +0300
Message-Id: <20200424164707.2715869-1-luca@coelho.fi>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/11]  iwlwifi: updates intended for v5.8 2020-04-24-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.8.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* HW configuration rework continues;
* Some debugging fixes;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: move iwl_set_soc_latency to iwl-drv to be used by other
    op_modes

Luca Coelho (7):
  iwlwifi: mvm: initialize iwl_dev_tx_power_cmd to zero
  iwlwifi: mvm: add IML/ROM information to the assertion dumps
  iwlwifi: pcie: remove outdated comment about PCI RTPM reference
  iwlwifi: pcie: remove mangling for iwl_ax101_cfg_qu_hr
  iwlwifi: pcie: convert QnJ with Hr to the device table
  iwlwifi: pcie: remove occurrences of 22000 in the FW name defines
  iwlwifi: pcie: convert all AX101 devices to the device tables

Mordechay Goodstein (2):
  iwlwifi: yoyo: remove magic number
  iwlwifi: dump api version in yaml format

Shahar S Matityahu (1):
  iwlwifi: dbg: set debug descriptor to NULL outside of
    iwl_fw_free_dump_desc

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  96 +++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  25 ++--
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 104 +++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  55 ++++++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   1 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  15 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  53 +--------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  20 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 111 +++++-------------
 9 files changed, 278 insertions(+), 202 deletions(-)

-- 
2.26.2

