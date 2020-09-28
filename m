Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30527AD34
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1Lvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1Lvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:51:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFBCC061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:51:37 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMrgs-00CSf1-RI; Mon, 28 Sep 2020 13:51:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix some more kernel-doc in mesh
Date:   Mon, 28 Sep 2020 13:51:30 +0200
Message-Id: <20200928135129.6409460c28b7.I43657d0b70398723e59e4e724f56af88af0fec7e@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a few more missing kernel-doc annotations in mesh code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mesh_plink.c | 1 +
 net/mac80211/mesh_ps.c    | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 15f2fc658f70..aca26df7587d 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -144,6 +144,7 @@ static u32 mesh_set_short_slot_time(struct ieee80211_sub_if_data *sdata)
 
 /**
  * mesh_set_ht_prot_mode - set correct HT protection mode
+ * @sdata: the (mesh) interface to handle
  *
  * Section 9.23.3.5 of IEEE 80211-2012 describes the protection rules for HT
  * mesh STA in a MBSS. Three HT protection modes are supported for now, non-HT
diff --git a/net/mac80211/mesh_ps.c b/net/mac80211/mesh_ps.c
index 76d19c09d26e..204830a55240 100644
--- a/net/mac80211/mesh_ps.c
+++ b/net/mac80211/mesh_ps.c
@@ -12,6 +12,7 @@
 
 /**
  * mps_qos_null_get - create pre-addressed QoS Null frame for mesh powersave
+ * @sta: the station to get the frame for
  */
 static struct sk_buff *mps_qos_null_get(struct sta_info *sta)
 {
@@ -44,6 +45,7 @@ static struct sk_buff *mps_qos_null_get(struct sta_info *sta)
 
 /**
  * mps_qos_null_tx - send a QoS Null to indicate link-specific power mode
+ * @sta: the station to send to
  */
 static void mps_qos_null_tx(struct sta_info *sta)
 {
@@ -400,6 +402,8 @@ static void mpsp_trigger_send(struct sta_info *sta, bool rspi, bool eosp)
 
 /**
  * mpsp_qos_null_append - append QoS Null frame to MPSP skb queue if needed
+ * @sta: the station to handle
+ * @frames: the frame list to append to
  *
  * To properly end a mesh MPSP the last transmitted frame has to set the EOSP
  * flag in the QoS Control field. In case the current tailing frame is not a
-- 
2.26.2

