Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE96623D7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 12:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjAILHt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 06:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjAILHq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 06:07:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD396140BF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 03:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673262465; x=1704798465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8SAXlWZr1DpjxUTgayRpNkbsoPnGRFkfGatirv2d26Q=;
  b=JE+SAeqU4tYVR71TC5x0c3FbwvUo3DrlfdEh2cYmAF+SJB2CtlexhPGd
   RKfKaonEPsWxYt7Ai+fRQiOXRr6MyoYTai5kYx78g61gcPE94vCledPlo
   Dl8xXo8LXzCFtJ4eEoJlcuV4eXjgX7dF6wssDZ6qhDw+mt1acqwDVxfYt
   F20bR7zttJob+yGJlzLeumapkAOabyoZmfIElJuHn+BEiLcsJ1GZvuEsH
   LUvh/qz7tuZ8XlaCOpVw3s7gyvUEPVsEZEPQ0KOzCGL4GfyUYfU3R3ZFK
   zxnrLXinNYjGlYm9zHx76W54COZcs/Y/Apz6M9SsH9YcmqLquaw1G1g59
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="387296429"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="387296429"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:07:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="689003121"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="689003121"
Received: from djacobi-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.191.194])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:07:43 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/2] iwlwifi: updates intended for v6.3 2023-01-09
Date:   Mon,  9 Jan 2023 13:07:20 +0200
Message-Id: <20230109110722.212758-1-gregory.greenman@intel.com>
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

Two EHT commits for suporting minimal EHT rate, in mac80211 and
iwlwifi.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Thanks!
Gregory

Johannes Berg (2):
  mac80211: support minimal EHT rate reporting on RX
  iwlwifi: mvm: add minimal EHT rate reporting

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  7 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  7 ++++++
 include/net/mac80211.h                        | 19 ++++++++++++---
 net/mac80211/rx.c                             |  9 +++++++
 net/mac80211/sta_info.c                       |  9 ++++++-
 net/mac80211/sta_info.h                       | 24 ++++++++++++++-----
 net/mac80211/util.c                           | 13 ++++++++++
 7 files changed, 78 insertions(+), 10 deletions(-)

-- 
2.38.1

