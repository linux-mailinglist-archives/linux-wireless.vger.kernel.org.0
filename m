Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED9137022
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgAJOyi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 09:54:38 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:60807 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgAJOyi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:38 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 4B18F580078;
        Fri, 10 Jan 2020 15:54:36 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/2] nl80211: add src and dst mac attributes
Date:   Fri, 10 Jan 2020 15:54:23 +0100
Message-Id: <20200110145424.4518-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is a prerequisite for handling preauth frames
over nl80211 control port correctly in ap mode.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/uapi/linux/nl80211.h | 6 ++++++
 net/wireless/nl80211.c       | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 341e0e8cae46..c284bd828669 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2400,6 +2400,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
  *	(u16).
  *
+ * @NL80211_ATTR_SRC_MAC: MAC address used in control port over nl80211 transmit
+ * @NL80211_ATTR_DST_MAC: MAC address used in control port over nl80211 receive
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2864,6 +2867,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_VLAN_ID,
 
+	NL80211_ATTR_SRC_MAC,
+	NL80211_ATTR_DST_MAC,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fa3526592c51..467a48b818f9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -625,6 +625,8 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
 	[NL80211_ATTR_VLAN_ID] = NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
+	[NL80211_ATTR_SRC_MAC] = NLA_POLICY_ETH_ADDR,
+	[NL80211_ATTR_DST_MAC] = NLA_POLICY_ETH_ADDR,
 };
 
 /* policy for the key attributes */
-- 
2.24.1

