Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35D8701C75
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjENJQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENJQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C326AB
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055772; x=1715591772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kdRbVgqcqYyxMrZWZr2y3jhmcjH7thuw6k2DYHegLBI=;
  b=OkCpWCakAGZnrbgnjcVJmiKy+GGl9EnhnO9Pmkm3szEWaxWrUOxfRmER
   B4nVZMneXvQwIY7EL97ApvXcqckrNX+knnq0WEPGg2M8+PuYLobHKA/Px
   jsEi6e5pE0aVNkpNi5+5oxI++QRY8loDQSv9R2WZcc0NiXaZ3a3wy3bzN
   O43Ua2xM0jXPMDtTIEs/75lD8AeSlu/tQsFW19k82AG59uxDGKKKImmuT
   VKvIc3CjJpCdIo4IbMU7ttAr44TX3k7mh85HxklMo+XsyGrk/+p49qBN5
   Zrzb43YE9y5PEM6OTeP4OVY1wYAW7K5xwsEwrRQeSQU1BfP4vR4sVvlvc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366811"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366811"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300220"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300220"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 00/12] wifi: iwlwifi: fixes for v6.4 2023-05-14 
Date:   Sun, 14 May 2023 12:15:43 +0300
Message-Id: <20230514091555.168392-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here're a few iwlwifi fixes that we'd like to send to v6.4.
Fixing a few locking and memory issues, MLO fix and a few other
rather small fixes.

Thanks,
Gregory

Alon Giladi (2):
  wifi: iwlwifi: fix OEM's name in the ppag approved list
  wifi: iwlwifi: mvm: fix OEM's name in the tas approved list

Ariel Malamud (1):
  wifi: iwlwifi: mvm: Add locking to the rate read flow

Gregory Greenman (1):
  wifi: iwlwifi: mvm: fix access to fw_id_to_mac_id

Johannes Berg (6):
  wifi: iwlwifi: mvm: always free dup_data
  wifi: iwlwifi: mvm: don't double-init spinlock
  wifi: iwlwifi: mvm: fix cancel_delayed_work_sync() deadlock
  wifi: iwlwifi: mvm: fix number of concurrent link checks
  wifi: iwlwifi: fw: fix DBGI dump
  wifi: iwlwifi: mvm: don't trust firmware n_channels

Miri Korenblit (1):
  wifi: iwlwifi: Don't use valid_links to iterate sta links

Mukesh Sisodiya (1):
  wifi: iwlwifi: mvm: fix initialization of a return value

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 19 ++++---
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  5 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 12 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 55 +++++++++----------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  9 +--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 14 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  | 10 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  9 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 13 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 13 files changed, 92 insertions(+), 63 deletions(-)

-- 
2.38.1

