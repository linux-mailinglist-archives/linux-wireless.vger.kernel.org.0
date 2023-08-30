Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB778D9AB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjH3Sdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242429AbjH3IbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8911A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384280; x=1724920280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bm/+/CGNkcgz0FlZkmKx4Un+gNJF25gz6/WvHqrtoDE=;
  b=lbla/HhSj1s4M7zBR5LabT98/d2ISeZLTx/6tRQ3wCh0naB822Lmcq+U
   0ec1FdNQUc69Qtn4+SD2mZAUhrXf9ww7He0p0MOwdYZNAl9NWx1W4RsAp
   AYFpPGboyb2qMg5Nle7oa9hTRjFsx0fsl99gNJUG51CzgrddvFUIs9HNH
   +LnFGKzHK9bktPTYGgR8u5Kd5EEsHJrT9WCxqfWoP0UvRtcp2zCSJz2/R
   TrK+SgcOUVO6ITIkZKhSkgialzW4LOl5r1SkmKjRjKbvmNTdkMfW+awyZ
   EC88WpBU6+MrGE2IUU7CW0ThuAnBZvd138R15MvslWBmHeP+jW6d3RpRj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958828"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958828"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829151987"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829151987"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/16] wifi: iwlwifi: updates intended for v6.6 2023-08-30 
Date:   Wed, 30 Aug 2023 11:30:48 +0300
Message-Id: <20230830083104.546619-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.6.

The changes are:
* CSA support for MLD and a few CSA fixes
* kernel-doc fixes
* a fix for enable_ini module parameter
* a few fixes and improvements in Rx path
* several other fixes

Thanks,
Gregory

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: support CSA with MLD
  wifi: iwlwifi: honor the enable_ini value

Johannes Berg (13):
  wifi: iwlwifi: mvm: increase session protection after CSA
  wifi: iwlwifi: mvm: disconnect long CSA only w/o alternative
  wifi: iwlwifi: fix some kernel-doc issues
  wifi: iwlwifi: queue: fix kernel-doc
  wifi: iwlwifi: dvm: remove kernel-doc warnings
  wifi: iwlwifi: pcie: fix kernel-doc issues
  wifi: iwlwifi: mvm: fix kernel-doc
  wifi: iwlwifi: fw: reconstruct the API/CAPA enum number
  wifi: iwlwifi: mvm: move RU alloc B2 placement
  wifi: iwlwifi: mvm: check link more carefully
  wifi: iwlwifi: mvm: reduce maximum RX A-MPDU size
  wifi: iwlwifi: pcie: fix RB status reading
  wifi: iwlwifi: increase number of RX buffers for EHT devices

Miri Korenblit (1):
  wifi: iwlwifi: don't use an uninitialized variable

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 10 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  8 +--
 .../net/wireless/intel/iwlwifi/dvm/commands.h | 33 +++++++----
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  | 14 +++--
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h   | 12 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |  9 +--
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  1 +
 .../net/wireless/intel/iwlwifi/fw/api/rfi.h   |  7 ++-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 16 +++--
 .../net/wireless/intel/iwlwifi/fw/api/txq.h   |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 27 ++++++---
 .../wireless/intel/iwlwifi/fw/notif-wait.h    |  3 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 --
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 51 ++++++----------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  2 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   | 13 ++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 13 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 ++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 28 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 23 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +-
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  9 ++-
 .../wireless/intel/iwlwifi/pcie/internal.h    | 59 +++++++++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 12 ++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  6 +-
 34 files changed, 225 insertions(+), 186 deletions(-)

-- 
2.38.1

