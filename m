Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D86A6906
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 09:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCAIoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 03:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCAIoR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 03:44:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2443EC72
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 00:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677660241; x=1709196241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0tNTkLVIc7ndGPfsPYZiK68okoSBQiHczxKndGTxKdg=;
  b=dnA1baIIlfqqc+fyMSIG4Er7JToxZphNX6oNLu/MP25z6PWIwg6yF3n9
   mR4GAm9V9KY+tkjR8IkZpeRfYrWeINfe6h7y8bD58fJmEXzX8qQWPDbOZ
   9362DKy7uunh3WU2O7QFy5dWiTWJ5B734rdyhzcabVd/M0JGnBEmPAcDO
   ngWdbYM2S19fToe7/W7zk2ERYavvO8YYhP+V6ZVPMLemRij4QKgaG65Iy
   17rewSN/fZOSDL/NUDkRJ8rhlN5rAz0LmL10cEL3oq5AZ6OJfSUGsAxWy
   22g9fEjbxp3EhBDbrFeWmd+zIwFtl6fGpyvsI3ZxXGGJtovjfXJ3vpzKb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336647531"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336647531"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 00:44:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798353470"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="798353470"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 00:43:59 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/2] mac80211/radiotap patches from our internal tree 2023-02-28 
Date:   Wed,  1 Mar 2023 10:43:45 +0200
Message-Id: <20230301084347.44102-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
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

Two more patches from our internal tree with preparations for adding EHT
and new radiotap TLV format.

The changes were tested by kbuild bot in the pending branch.

Thanks
Gregory

Mordechay Goodstein (2):
  wifi: ieee80211_radiotap: Add EHT radiotap definitions
  wifi: mac80211: add support for driver adding radiotap TLVs

 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  27 +--
 drivers/net/wireless/mac80211_hwsim.c         |  45 ++--
 include/net/ieee80211_radiotap.h              | 208 +++++++++++++++++-
 include/net/mac80211.h                        |  44 +---
 net/mac80211/rx.c                             |  82 +++----
 5 files changed, 277 insertions(+), 129 deletions(-)

-- 
2.38.1

