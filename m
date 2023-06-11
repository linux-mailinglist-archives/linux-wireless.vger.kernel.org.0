Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6A72B111
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjFKJO5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjFKJOq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 05:14:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE5193
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jun 2023 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686474884; x=1718010884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJuoJh2TcfX39MFCErjj5fvCceVT1KoTF7WcioLJ3t8=;
  b=GlRvOr32AaevG+TgIH44WR9gfGfZYOpEk+LNDAB64ZtHdTUdksvHeVtm
   ikd3aLLy3NX0mr5y6TtZnlgHg/62fR7SS7ELNpHtUzqTqyp65jg3pcFUs
   S99zGOuETQp0ZuehxC/Ebd88NznwgvhobGM6lcCiTxnNnHFdViuCPRsF0
   WPXWSWCjerQ6o3E/gFNIwZjbDz3S7HtHANX+msKBQ1AXru3KEGJLrL1nR
   vSReKeKFkX86F5xZCwoNTv0aP4FsGSFVg0Uyon7A9Xh7fP0xSV8Nl/vYY
   9WBS49pQpuAA1w0jcBC4vkTwF9fvR5Tuo5/V6gDQvnXVEcseBFbGAa7Gi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="347488932"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="347488932"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688249735"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="688249735"
Received: from rganonx-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.222.121])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/4] wifi: mac80211: Add debugfs entry to report dormant links
Date:   Sun, 11 Jun 2023 12:14:26 +0300
Message-Id: <20230611121219.7fa5f022adfb.Iff6fa3e1a3b00ae726612f9d5a31f7fe2fcbfc68@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611091429.24517-1-gregory.greenman@intel.com>
References: <20230611091429.24517-1-gregory.greenman@intel.com>
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

From: Ilan Peer <ilan.peer@intel.com>

Add debugfs entry to report dormant (valid but disabled) links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/debugfs_netdev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 3fea86c9a276..6253d0127207 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -693,6 +693,19 @@ IEEE80211_IF_FILE(dot11MeshConnectedToAuthServer,
 	debugfs_create_file(#name, mode, sdata->vif.debugfs_dir, \
 			    sdata, &name##_ops)
 
+#define DEBUGFS_ADD_X(_bits, _name, _mode) \
+	debugfs_create_x##_bits(#_name, _mode, sdata->vif.debugfs_dir, \
+				&sdata->vif._name)
+
+#define DEBUGFS_ADD_X8(_name, _mode) \
+	DEBUGFS_ADD_X(8, _name, _mode)
+
+#define DEBUGFS_ADD_X16(_name, _mode) \
+	DEBUGFS_ADD_X(16, _name, _mode)
+
+#define DEBUGFS_ADD_X32(_name, _mode) \
+	DEBUGFS_ADD_X(32, _name, _mode)
+
 #define DEBUGFS_ADD(name) DEBUGFS_ADD_MODE(name, 0400)
 
 static void add_common_files(struct ieee80211_sub_if_data *sdata)
@@ -722,6 +735,7 @@ static void add_sta_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD_MODE(tdls_wider_bw, 0600);
 	DEBUGFS_ADD_MODE(valid_links, 0200);
 	DEBUGFS_ADD_MODE(active_links, 0600);
+	DEBUGFS_ADD_X16(dormant_links, 0400);
 }
 
 static void add_ap_files(struct ieee80211_sub_if_data *sdata)
-- 
2.38.1

