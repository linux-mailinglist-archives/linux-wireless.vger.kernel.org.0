Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD40D182C12
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 10:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCLJLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 05:11:05 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:42637 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLJLF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 05:11:05 -0400
Received: from isengard.tu-ilmenau.de (unknown [141.24.111.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 832A658006C;
        Thu, 12 Mar 2020 10:11:03 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/3] nl80211: add no pre-auth attribute and ext. feature flag for ctrl. port
Date:   Thu, 12 Mar 2020 10:10:53 +0100
Message-Id: <20200312091055.54257-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312091055.54257-1-markus.theil@tu-ilmenau.de>
References: <20200312091055.54257-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the nl80211 control port is used before this patch, pre-auth frames
(0x88c7) are send to userspace uncoditionally. While this enables userspace
to only use nl80211 on the station side, it is not always useful for APs.
Furthermore, pre-auth frames are ordinary data frames and not related to
the control port. Therefore it should for example be possible for pre-auth
frames to be bridged onto a wired network on AP side without touching
userspace.

For backwards compatibility to code already using pre-auth over nl80211,
this patch adds a feature flag to disable this behavior, while it remains
enabled by default. An additional ext. feature flag is added to detect this
from userspace.

Thanks to Jouni for pointing out, that pre-auth frames should be handled as
ordinary data frames.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/uapi/linux/nl80211.h | 13 ++++++++++++-
 net/wireless/nl80211.c       |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b002ef2060fa..66fffc30bb73 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1632,7 +1632,8 @@ enum nl80211_commands {
  *	flag is included, then control port frames are sent over NL80211 instead
  *	using %CMD_CONTROL_PORT_FRAME.  If control port routing over NL80211 is
  *	to be used then userspace must also use the %NL80211_ATTR_SOCKET_OWNER
- *	flag.
+ *	flag. When used with %NL80211_ATTR_CONTROL_PORT_NO_PREAUTH, pre-auth
+ *	frames are not forwared over the control port.
  *
  * @NL80211_ATTR_TESTDATA: Testmode data blob, passed through to the driver.
  *	We recommend using nested, driver-specific attributes within this.
@@ -2442,6 +2443,9 @@ enum nl80211_commands {
  *	on output (in wiphy attributes) it contains only the feature sub-
  *	attributes.
  *
+ * @NL80211_ATTR_CONTROL_PORT_NO_PREAUTH: disable preauth frame rx on control
+ *	port in order to forward/receive them as ordinary data frames.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2912,6 +2916,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_TID_CONFIG,
 
+	NL80211_ATTR_CONTROL_PORT_NO_PREAUTH,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5642,6 +5648,10 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_BEACON_PROTECTION: The driver supports Beacon protection
  *	and can receive key configuration for BIGTK using key indexes 6 and 7.
  *
+ * @NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH: The driver can disable the
+ *	forwarding of preauth frames over the control port. They are then
+ *	handled as ordinary data frames.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5690,6 +5700,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
 	NL80211_EXT_FEATURE_BEACON_PROTECTION,
+	NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 59f233790686..0f91e02a77c6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -652,6 +652,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HE_BSS_COLOR] = NLA_POLICY_NESTED(he_bss_color_policy),
 	[NL80211_ATTR_TID_CONFIG] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_tid_config_attr_policy),
+	[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
-- 
2.25.1

