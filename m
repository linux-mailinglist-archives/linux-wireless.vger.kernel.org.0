Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5C1E4A62
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbgE0Qhs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 12:37:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:49690 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388698AbgE0Qhs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 12:37:48 -0400
IronPort-SDR: oBPkLAKEdSBpu54tj8WgmzZRj2TOa1wIJBD0Dj1Ic/7gDkVEwsRn/UJKhU81yLpt33kusZyNhf
 sZ6K/WR4xjOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 09:37:48 -0700
IronPort-SDR: azPK73Mx9jL1rcgfmFowai0hm/CW8h4x0xWNVKcbW1l30FKt8KQuftnCgImrkfuHaOTqVUsZY6
 qykDrO91Mrdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="266895006"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2020 09:37:47 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdz3q-000HHA-JI; Thu, 28 May 2020 00:37:46 +0800
Date:   Thu, 28 May 2020 00:37:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org
Subject: [RFC PATCH mac80211-next] net: ethtool:
 ethnl_act_cable_test_tdr_cfg() can be static
Message-ID: <20200527163713.GA37306@c08b96c6f6ed>
References: <202005280023.WcZcdZML%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005280023.WcZcdZML%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Fixes: f2bc8ad31a7f ("net: ethtool: Allow PHY cable test TDR data to configured")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 cabletest.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 9991688d7d1d5..7b7a0456c15ce 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -227,9 +227,9 @@ cable_test_tdr_act_policy[ETHTOOL_A_CABLE_TEST_TDR_MAX + 1] = {
 };
 
 /* CABLE_TEST_TDR_ACT */
-int ethnl_act_cable_test_tdr_cfg(const struct nlattr *nest,
-				 struct genl_info *info,
-				 struct phy_tdr_config *cfg)
+static int ethnl_act_cable_test_tdr_cfg(const struct nlattr *nest,
+					struct genl_info *info,
+					struct phy_tdr_config *cfg)
 {
 	struct nlattr *tb[ETHTOOL_A_CABLE_TEST_TDR_CFG_MAX + 1];
 	int ret;
