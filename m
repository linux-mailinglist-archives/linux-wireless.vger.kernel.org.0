Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59564631550
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKTRB0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKTRBZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E62B1AB
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963684; x=1700499684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9CvHY+w4KOA7Hp14D65vIXCzlERGri46IjYwlLOYCZk=;
  b=eBQA/LCinY6OGRSI4h7l+fsDJ/eYNhPofwDEyPZl8Hu/pvDQqb0xYCv0
   61Gm3VKDBOJpTCxRYbHYE3wuho/+UlbWCC6XysHcDZfGj/sQkz0JtfK9Y
   OnX6ZLnj8D/Qej4EEX2sMGVEuHNUlyBbVIyEE4kwXhiY1fLdrChhHaJ+J
   e/KAB/WghMQAxdNW5s5N59EimHq236ReQooUM0MyYKsIMWcPBC55TZfx8
   hYJxz1az9hz7ZMpA1aOielIBEhO4N1YxdUcR+bqjmqKIJxWrplBMd0WV2
   hMPpKuR/+DuQzMJjyFHiesSNlrWgl1IwTANjyT4ePgubjkJsmXrpQtG8w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234820"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234820"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719397"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719397"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:19 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/9] wifi: iwlwifi: updates intended for v6.2 2022-11-20 
Date:   Sun, 20 Nov 2022 19:00:30 +0200
Message-Id: <20221120170039.1788067-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's the third set of patches intended for v6.2. It contains
EHT adjustments for iwlwifi. It contains only iwlwifi changes,
all the required mac80211/cfg80211 changes are already merged
upstream.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Thanks,
Gregory.

Abhishek Naik (1)
  wifi: iwlwifi: nvm: Update EHT capabilities for GL device

Ilan Peer (1):
  wifi: iwlwifi: mvm: Advertise EHT capabilities

Johannes Berg (4):
  wifi: iwlwifi: mvm: support 320 MHz PHY configuration
  wifi: iwlwifi: mvm: set HE PHY bandwidth according to band
  wifi: iwlwifi: mvm: advertise 320 MHz in 6 GHz only conditionally
  wifi: iwlwifi: nvm-parse: support A-MPDU in EHT 2.4 GHz

Miri Korenblit (1):
  wifi: iwlwifi: mvm: support PPE Thresholds for EHT

Mordechay Goodstein (2):
  wifi: iwlwifi: rs: add support for parsing max MCS per NSS/BW in 11be
  wifi: iwlwifi: mvm: add support for EHT 1K aggregation size

 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   6 +-
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  33 ++-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   3 +
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |   3 +-
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 235 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 179 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  54 ++--
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 125 +++++++++-
 12 files changed, 544 insertions(+), 113 deletions(-)

-- 
2.35.3

