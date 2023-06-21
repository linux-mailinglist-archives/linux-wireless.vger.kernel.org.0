Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3D737FCC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjFUKOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjFUKN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:13:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6546F1FC0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342427; x=1718878427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qGeMVQkpoh1iT5PUcD67vdX2DTU9lhd1W70ozO5Gb0A=;
  b=CapoAKL4U7CprEkGiOr7T/lvMofau3reTBhjXXVIxeqzY2FIKLxPF6Uh
   SoMDdYIfOjLRh0pd5iagww78WEP5Gg/PwLZDkvFJ6JdiYHCr/QRT4amPD
   dhvnAG10BP/ClKZ4BJvGo+Grs14JS0cGFUs1huU5HJGNtAnTq29TqGSr2
   rbPUFH9E75vEeIiE/gSXDIqJMFryOOB7mf+yl84PEagvNe3zNGF9E1ucc
   loY+LJXT3NIrjxONqirhsOQ+/vqO7UGTYgHBfmhHvJefK5FxCKBx/2pNk
   qHMU2+xC3R6rRcZMdlki8nhPtjh5yQDMuz6zJV7c/RwqAaMhS9y1bHKYB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506310"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506310"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599027"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599027"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/18] wifi: iwlwifi: updates intended for v6.5 2023-06-21 
Date:   Wed, 21 Jun 2023 13:12:04 +0300
Message-Id: <20230621101222.218083-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.5.

Most of this patchset is dedicated to refactoring of
the configuration related code, splitting it according to
device families.

It also advances the firmare revision to 83 for the newer
device families.

Thanks,
Gregory

Gregory Greenman (1):
  wifi: iwlwifi: bump FW API to 83 for AX/BZ/SC devices

Johannes Berg (13):
  wifi: iwlwifi: split 22000.c into multiple files
  wifi: iwlwifi: give Sc devices their own family
  wifi: iwlwifi: don't load old firmware for Sc
  wifi: iwlwifi: don't load old firmware for Bz
  wifi: iwlwifi: don't load old firmware for ax210
  wifi: iwlwifi: don't load old firmware for 22000
  wifi: iwlwifi: remove support for *nJ devices
  wifi: iwlwifi: pcie: also drop jacket from info macro
  wifi: iwlwifi: unify Bz/Gl device configurations
  wifi: iwlwifi: also unify Sc device configurations
  wifi: iwlwifi: also unify Ma device configurations
  wifi: iwlwifi: cfg: remove trailing dash from FW_PRE constants
  wifi: iwlwifi: cfg: clean up Bz module firmware lines

Mukesh Sisodiya (3):
  wifi: iwlwifi: Add support for new Bz version
  wifi: iwlwifi: Add support for new CNVi (SC)
  wifi: iwlwifi: remove support of A0 version of FM RF

Yi Kuo (1):
  wifi: iwlwifi: pcie: add device id 51F1 for killer 1675

 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |  18 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 871 +-----------------
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  22 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  10 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 301 ++++++
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 183 ++++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 166 ++++
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  24 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  70 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  75 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 516 +++--------
 18 files changed, 934 insertions(+), 1381 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c

-- 
2.38.1

