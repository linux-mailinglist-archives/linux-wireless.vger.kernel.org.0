Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA1542BF1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiFHJtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiFHJtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 05:49:03 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4E254447
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654679823; x=1686215823;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+hqvrlweXqUUJvGqzmpbjouvmvYOvQThyZa5f0+gUgY=;
  b=FwUESqGmd5l8z+Anc+fUgEaoppF/XFEFoPDiF8lqya6vmo5k9gN3IEme
   fTMW8yyzCQHHS5573S64rev08jSQf4GeldO0vfIsH/InceWAKDz1CdVni
   7kTf3hKGWFkXQuoFJi8hAFJQsFPVu8uDwouXbnTgqQF29i7SzOQ6uMGzA
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2022 02:16:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:16:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 02:16:56 -0700
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 02:16:54 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] cfg80211: Indicate MLO connection info in connect and roam callbacks
Date:   Wed, 8 Jun 2022 14:46:37 +0530
Message-ID: <1654679797-7740-1-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The MLO links used for connection with an MLD AP are decided by the
driver in case of SME offloaded to driver.

Add support for the drivers to indicate the information of links used
for MLO connection in connect and roam callbacks, update the connected
links information in wdev from connect/roam result sent by driver.
Also, send the connected links information to userspace.

Add a netlink flag attribute to indicate that userspace supports
handling of MLO connection. Drivers must not do MLO connection when this
flag is not set. This is to maintain backwards compatibility with older
supplicant versions which doesn't have support for MLO connection.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   2 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |   4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   6 +-
 drivers/net/wireless/rndis_wlan.c                  |   5 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   4 +-
 drivers/staging/wlan-ng/cfg80211.c                 |   2 +-
 include/net/cfg80211.h                             |  84 +++--
 include/uapi/linux/nl80211.h                       |   6 +
 net/wireless/mlme.c                                |   4 +-
 net/wireless/nl80211.c                             | 120 ++++++-
 net/wireless/sme.c                                 | 391 +++++++++++++++------
 11 files changed, 480 insertions(+), 148 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 33ed547..e11c7e9 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -807,7 +807,7 @@ void ath6kl_cfg80211_connect_event(struct ath6kl_vif *vif, u16 channel,
 		cfg80211_put_bss(ar->wiphy, bss);
 	} else if (vif->sme_state == SME_CONNECTED) {
 		struct cfg80211_roam_info roam_info = {
-			.bss = bss,
+			.links[0].bss = bss,
 			.req_ie = assoc_req_ie,
 			.req_ie_len = assoc_req_len,
 			.resp_ie = assoc_resp_ie,
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 98b4c18..ea7bd40 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1822,8 +1822,8 @@ wmi_evt_reassoc_status(struct wil6210_vif *vif, int id, void *d, int len)
 	freq = ieee80211_channel_to_frequency(ch, NL80211_BAND_60GHZ);
 
 	memset(&info, 0, sizeof(info));
-	info.channel = ieee80211_get_channel(wiphy, freq);
-	info.bss = vif->bss;
+	info.links[0].channel = ieee80211_get_channel(wiphy, freq);
+	info.links[0].bss = vif->bss;
 	info.req_ie = assoc_req_ie;
 	info.req_ie_len = assoc_req_ie_len;
 	info.resp_ie = assoc_resp_ie;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index f6bd151..ab0d248 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6017,8 +6017,8 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
 done:
 	kfree(buf);
 
-	roam_info.channel = notify_channel;
-	roam_info.bssid = profile->bssid;
+	roam_info.links[0].channel = notify_channel;
+	roam_info.links[0].bssid = profile->bssid;
 	roam_info.req_ie = conn_info->req_ie;
 	roam_info.req_ie_len = conn_info->req_ie_len;
 	roam_info.resp_ie = conn_info->resp_ie;
@@ -6061,7 +6061,7 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 		} else {
 			conn_params.status = WLAN_STATUS_AUTH_TIMEOUT;
 		}
-		conn_params.bssid = profile->bssid;
+		conn_params.links[0].bssid = profile->bssid;
 		conn_params.req_ie = conn_info->req_ie;
 		conn_params.req_ie_len = conn_info->req_ie_len;
 		conn_params.resp_ie = conn_info->resp_ie;
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index ff24483..0552429 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2813,8 +2813,9 @@ static void rndis_wlan_do_link_up_work(struct usbnet *usbdev)
 						resp_ie_len, 0, GFP_KERNEL);
 		} else {
 			struct cfg80211_roam_info roam_info = {
-				.channel = get_current_channel(usbdev, NULL),
-				.bssid = bssid,
+				.links[0].channel =
+					get_current_channel(usbdev, NULL),
+				.links[0].bssid = bssid,
 				.req_ie = req_ie,
 				.req_ie_len = req_ie_len,
 				.resp_ie = resp_ie,
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 349aa3c..cf35125 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -450,8 +450,8 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 
 		notify_channel = ieee80211_get_channel(wiphy, freq);
 
-		roam_info.channel = notify_channel;
-		roam_info.bssid = cur_network->network.mac_address;
+		roam_info.links[0].channel = notify_channel;
+		roam_info.links[0].bssid = cur_network->network.mac_address;
 		roam_info.req_ie =
 			pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2;
 		roam_info.req_ie_len =
diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 7951bd6..fc7747b 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -647,7 +647,7 @@ void prism2_disconnected(struct wlandevice *wlandev)
 void prism2_roamed(struct wlandevice *wlandev)
 {
 	struct cfg80211_roam_info roam_info = {
-		.bssid = wlandev->bssid,
+		.links[0].bssid = wlandev->bssid,
 	};
 
 	cfg80211_roamed(wlandev->netdev, &roam_info, GFP_KERNEL);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1b52189..2ff521a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2742,6 +2742,9 @@ struct cfg80211_auth_request {
  *	request (connect callback).
  * @ASSOC_REQ_DISABLE_HE:  Disable HE
  * @ASSOC_REQ_DISABLE_EHT:  Disable EHT
+ * @CONNECT_REQ_MLO_SUPPORT: Userspace indicates support for handling MLD links.
+ *	Drivers shall disable MLO features for the current association if this
+ *	flag is not set.
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
@@ -2750,6 +2753,7 @@ enum cfg80211_assoc_req_flags {
 	CONNECT_REQ_EXTERNAL_AUTH_SUPPORT	= BIT(3),
 	ASSOC_REQ_DISABLE_HE			= BIT(4),
 	ASSOC_REQ_DISABLE_EHT			= BIT(5),
+	CONNECT_REQ_MLO_SUPPORT			= BIT(6),
 };
 
 /**
@@ -5737,12 +5741,13 @@ static inline void WARN_INVALID_LINK_ID(struct wireless_dev *wdev,
 		!(wdev->valid_links & BIT(link_id)));
 }
 
-#define for_each_valid_link(wdev, link_id)					\
-	for (link_id = 0;							\
-	     link_id < ((wdev)->valid_links ? ARRAY_SIZE((wdev)->links) : 1);	\
-	     link_id++)								\
-		if (!(wdev)->valid_links ||					\
-		    ((wdev)->valid_links & BIT(link_id)))
+#define for_each_valid_link(link_info, link_id)			\
+	for (link_id = 0;					\
+	     link_id < ((link_info)->valid_links ?		\
+			ARRAY_SIZE((link_info)->links) : 1);	\
+	     link_id++)						\
+		if (!(link_info)->valid_links ||		\
+		    ((link_info)->valid_links & BIT(link_id)))
 
 /**
  * DOC: Utility functions
@@ -7253,13 +7258,6 @@ struct cfg80211_fils_resp_params {
  *	indicate that this is a failure, but without a status code.
  *	@timeout_reason is used to report the reason for the timeout in that
  *	case.
- * @bssid: The BSSID of the AP (may be %NULL)
- * @bss: Entry of bss to which STA got connected to, can be obtained through
- *	cfg80211_get_bss() (may be %NULL). But it is recommended to store the
- *	bss from the connect_request and hold a reference to it and return
- *	through this param to avoid a warning if the bss is expired during the
- *	connection, esp. for those drivers implementing connect op.
- *	Only one parameter among @bssid and @bss needs to be specified.
  * @req_ie: Association request IEs (may be %NULL)
  * @req_ie_len: Association request IEs length
  * @resp_ie: Association response IEs (may be %NULL)
@@ -7271,17 +7269,41 @@ struct cfg80211_fils_resp_params {
  *	not known. This value is used only if @status < 0 to indicate that the
  *	failure is due to a timeout and not due to explicit rejection by the AP.
  *	This value is ignored in other cases (@status >= 0).
+ * @valid_links: For MLO connection, BIT mask of the valid link ids. Otherwise
+ *	zero.
+ * @ap_mld_addr: For MLO connection, MLD address of the AP. Otherwise %NULL.
+ * @links : For MLO connection, contains link info for the valid links indicated
+ *	using @valid_links. For non-MLO connection, links[0] contains the
+ *	connected AP info.
+ * @links.addr: For MLO connection, MAC address of the STA link. Otherwise
+ *	%NULL.
+ * @links.bssid: For MLO connection, MAC address of the AP link. For non-MLO
+ *	connection, links[0].bssid points to the BSSID of the AP (may be %NULL).
+ * @links.bss: For MLO connection, entry of bss to which STA link is connected.
+ *	For non-MLO connection, links[0].bss points to entry of bss to which STA
+ *	is connected. It can be obtained through cfg80211_get_bss() (may be
+ *	%NULL). It is recommended to store the bss from the connect_request and
+ *	hold a reference to it and return through this param to avoid a warning
+ *	if the bss is expired during the connection, esp. for those drivers
+ *	implementing connect op. Only one parameter among @bssid and @bss needs
+ *	to be specified.
  */
 struct cfg80211_connect_resp_params {
 	int status;
-	const u8 *bssid;
-	struct cfg80211_bss *bss;
 	const u8 *req_ie;
 	size_t req_ie_len;
 	const u8 *resp_ie;
 	size_t resp_ie_len;
 	struct cfg80211_fils_resp_params fils;
 	enum nl80211_timeout_reason timeout_reason;
+
+	const u8 *ap_mld_addr;
+	u16 valid_links;
+	struct {
+		const u8 *addr;
+		const u8 *bssid;
+		struct cfg80211_bss *bss;
+	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 /**
@@ -7351,8 +7373,8 @@ cfg80211_connect_bss(struct net_device *dev, const u8 *bssid,
 
 	memset(&params, 0, sizeof(params));
 	params.status = status;
-	params.bssid = bssid;
-	params.bss = bss;
+	params.links[0].bssid = bssid;
+	params.links[0].bss = bss;
 	params.req_ie = req_ie;
 	params.req_ie_len = req_ie_len;
 	params.resp_ie = resp_ie;
@@ -7423,24 +7445,40 @@ cfg80211_connect_timeout(struct net_device *dev, const u8 *bssid,
 /**
  * struct cfg80211_roam_info - driver initiated roaming information
  *
- * @channel: the channel of the new AP
- * @bss: entry of bss to which STA got roamed (may be %NULL if %bssid is set)
- * @bssid: the BSSID of the new AP (may be %NULL if %bss is set)
  * @req_ie: association request IEs (maybe be %NULL)
  * @req_ie_len: association request IEs length
  * @resp_ie: association response IEs (may be %NULL)
  * @resp_ie_len: assoc response IEs length
  * @fils: FILS related roaming information.
+ * @valid_links: For MLO roaming, BIT mask of the new valid links is set.
+ *	Otherwise zero.
+ * @ap_mld_addr: For MLO roaming, MLD address of the new AP. Otherwise %NULL.
+ * @links : For MLO roaming, contains new link info for the valid links set in
+ *	@valid_links. For non-MLO roaming, links[0] contains the new AP info.
+ * @links.addr: For MLO roaming, MAC address of the STA link. Otherwise %NULL.
+ * @links.bssid: For MLO roaming, MAC address of the new AP link. For non-MLO
+ *	roaming, links[0].bssid points to the BSSID of the new AP. May be
+ *	%NULL if %links.bss is set.
+ * @links.channel: the channel of the new AP.
+ * @links.bss: For MLO roaming, entry of new bss to which STA link got
+ *	roamed. For non-MLO roaming, links[0].bss points to entry of bss to
+ *	which STA got roamed (may be %NULL if %links.bssid is set)
  */
 struct cfg80211_roam_info {
-	struct ieee80211_channel *channel;
-	struct cfg80211_bss *bss;
-	const u8 *bssid;
 	const u8 *req_ie;
 	size_t req_ie_len;
 	const u8 *resp_ie;
 	size_t resp_ie_len;
 	struct cfg80211_fils_resp_params fils;
+
+	const u8 *ap_mld_addr;
+	u16 valid_links;
+	struct {
+		const u8 *addr;
+		const u8 *bssid;
+		struct ieee80211_channel *channel;
+		struct cfg80211_bss *bss;
+	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 509253b..2c55414 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2688,6 +2688,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_MLO_LINKS: A nested array of links, each containing some
  *	per-link information and a link ID.
  *
+ * @NL80211_ATTR_MLO_SUPPORT: Flag attribute to indicate user space supports MLO
+ *	connection. Used with %NL80211_CMD_CONNECT. If this attribute is not
+ *	included in NL80211_CMD_CONNECT drivers must not perform MLO connection.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3205,6 +3209,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MLO_LINKS,
 	NL80211_ATTR_MLO_LINK_ID,
 
+	NL80211_ATTR_MLO_SUPPORT,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index fab2d62..4fdd306 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -42,8 +42,8 @@ void cfg80211_rx_assoc_resp(struct net_device *dev, struct cfg80211_bss *bss,
 
 	memset(&cr, 0, sizeof(cr));
 	cr.status = (int)le16_to_cpu(mgmt->u.assoc_resp.status_code);
-	cr.bssid = mgmt->bssid;
-	cr.bss = bss;
+	cr.links[0].bssid = mgmt->bssid;
+	cr.links[0].bss = bss;
 	cr.req_ie = req_ies;
 	cr.req_ie_len = req_ies_len;
 	cr.resp_ie = resp_ie;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9c8bf1b..e968792 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -796,6 +796,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED_ARRAY(nl80211_policy),
 	[NL80211_ATTR_MLO_LINK_ID] =
 		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS),
+	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -11383,6 +11384,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 		connect.flags |= CONNECT_REQ_EXTERNAL_AUTH_SUPPORT;
 	}
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_MLO_SUPPORT]))
+		connect.flags |= CONNECT_REQ_MLO_SUPPORT;
+
 	wdev_lock(dev->ieee80211_ptr);
 
 	err = cfg80211_connect(rdev, dev, &connect, connkeys,
@@ -17134,10 +17138,29 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 {
 	struct sk_buff *msg;
 	void *hdr;
+	unsigned int link;
+	size_t link_info_size = 0;
+	const u8 *connected_addr = cr->valid_links ?
+				   cr->ap_mld_addr : cr->links[0].bssid;
+
+	if (cr->valid_links) {
+		for_each_valid_link(cr, link) {
+			/* Nested attribute header */
+			link_info_size += NLA_HDRLEN;
+			/* Link ID */
+			link_info_size += nla_total_size(sizeof(u8));
+			link_info_size += cr->links[link].addr ?
+					  nla_total_size(ETH_ALEN) : 0;
+			link_info_size += (cr->links[link].bssid ||
+					   cr->links[link].bss) ?
+					  nla_total_size(ETH_ALEN) : 0;
+		}
+	}
 
 	msg = nlmsg_new(100 + cr->req_ie_len + cr->resp_ie_len +
 			cr->fils.kek_len + cr->fils.pmk_len +
-			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+			(cr->fils.pmkid ? WLAN_PMKID_LEN : 0) + link_info_size,
+			gfp);
 	if (!msg)
 		return;
 
@@ -17149,8 +17172,8 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    (cr->bssid &&
-	     nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, cr->bssid)) ||
+	    (connected_addr &&
+	     nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, connected_addr)) ||
 	    nla_put_u16(msg, NL80211_ATTR_STATUS_CODE,
 			cr->status < 0 ? WLAN_STATUS_UNSPECIFIED_FAILURE :
 			cr->status) ||
@@ -17176,6 +17199,38 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 	       nla_put(msg, NL80211_ATTR_PMKID, WLAN_PMKID_LEN, cr->fils.pmkid)))))
 		goto nla_put_failure;
 
+	if (cr->valid_links) {
+		int i = 1;
+		struct nlattr *nested;
+
+		nested = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+		if (!nested)
+			goto nla_put_failure;
+
+		for_each_valid_link(cr, link) {
+			struct nlattr *nested_mlo_links;
+			const u8 *bssid = cr->links[link].bss ?
+					  cr->links[link].bss->bssid :
+					  cr->links[link].bssid;
+
+			nested_mlo_links = nla_nest_start(msg, i);
+			if (!nested_mlo_links)
+				goto nla_put_failure;
+
+			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link) ||
+			    (bssid &&
+			     nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, bssid)) ||
+			    (cr->links[link].addr &&
+			     nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				     cr->links[link].addr)))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, nested_mlo_links);
+			i++;
+		}
+		nla_nest_end(msg, nested);
+	}
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
@@ -17192,11 +17247,32 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 {
 	struct sk_buff *msg;
 	void *hdr;
-	const u8 *bssid = info->bss ? info->bss->bssid : info->bssid;
+	size_t link_info_size = 0;
+	unsigned int link;
+	const u8 *connected_addr = info->ap_mld_addr ?
+				   info->ap_mld_addr :
+				   (info->links[0].bss ?
+				    info->links[0].bss->bssid :
+				    info->links[0].bssid);
+
+	if (info->valid_links) {
+		for_each_valid_link(info, link) {
+			/* Nested attribute header */
+			link_info_size += NLA_HDRLEN;
+			/* Link ID */
+			link_info_size += nla_total_size(sizeof(u8));
+			link_info_size += info->links[link].addr ?
+					  nla_total_size(ETH_ALEN) : 0;
+			link_info_size += (info->links[link].bssid ||
+					   info->links[link].bss) ?
+					  nla_total_size(ETH_ALEN) : 0;
+		}
+	}
 
 	msg = nlmsg_new(100 + info->req_ie_len + info->resp_ie_len +
 			info->fils.kek_len + info->fils.pmk_len +
-			(info->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+			(info->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+			link_info_size, gfp);
 	if (!msg)
 		return;
 
@@ -17208,7 +17284,7 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, connected_addr) ||
 	    (info->req_ie &&
 	     nla_put(msg, NL80211_ATTR_REQ_IE, info->req_ie_len,
 		     info->req_ie)) ||
@@ -17227,6 +17303,38 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 	     nla_put(msg, NL80211_ATTR_PMKID, WLAN_PMKID_LEN, info->fils.pmkid)))
 		goto nla_put_failure;
 
+	if (info->valid_links) {
+		int i = 1;
+		struct nlattr *nested;
+
+		nested = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+		if (!nested)
+			goto nla_put_failure;
+
+		for_each_valid_link(info, link) {
+			struct nlattr *nested_mlo_links;
+			const u8 *bssid = info->links[link].bss ?
+					  info->links[link].bss->bssid :
+					  info->links[link].bssid;
+
+			nested_mlo_links = nla_nest_start(msg, i);
+			if (!nested_mlo_links)
+				goto nla_put_failure;
+
+			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link) ||
+			    (bssid &&
+			     nla_put(msg, NL80211_ATTR_BSSID, ETH_ALEN, bssid)) ||
+			    (info->links[link].addr &&
+			     nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
+				     info->links[link].addr)))
+				goto nla_put_failure;
+
+			nla_nest_end(msg, nested_mlo_links);
+			i++;
+		}
+		nla_nest_end(msg, nested);
+	}
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 3560220..a11b99c 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -258,7 +258,7 @@ void cfg80211_conn_work(struct work_struct *work)
 
 			memset(&cr, 0, sizeof(cr));
 			cr.status = -1;
-			cr.bssid = bssid;
+			cr.links[0].bssid = bssid;
 			cr.timeout_reason = treason;
 			__cfg80211_connect_result(wdev->netdev, &cr, false);
 		}
@@ -367,7 +367,7 @@ void cfg80211_sme_rx_auth(struct wireless_dev *wdev, const u8 *buf, size_t len)
 
 		memset(&cr, 0, sizeof(cr));
 		cr.status = status_code;
-		cr.bssid = mgmt->bssid;
+		cr.links[0].bssid = mgmt->bssid;
 		cr.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED;
 		__cfg80211_connect_result(wdev->netdev, &cr, false);
 	} else if (wdev->conn->state == CFG80211_CONN_AUTHENTICATING) {
@@ -681,6 +681,20 @@ static void disconnect_work(struct work_struct *work)
 
 DECLARE_WORK(cfg80211_disconnect_work, disconnect_work);
 
+static void
+cfg80211_connect_result_release_bsses(struct wireless_dev *wdev,
+				      struct cfg80211_connect_resp_params *cr)
+{
+	unsigned int link;
+
+	for_each_valid_link(cr, link) {
+		if (!cr->links[link].bss)
+			continue;
+		cfg80211_unhold_bss(bss_from_pub(cr->links[link].bss));
+		cfg80211_put_bss(wdev->wiphy, cr->links[link].bss);
+	}
+}
+
 /*
  * API calls for drivers implementing connect/disconnect and
  * SME event handling
@@ -698,21 +712,33 @@ void __cfg80211_connect_result(struct net_device *dev,
 #ifdef CONFIG_CFG80211_WEXT
 	union iwreq_data wrqu;
 #endif
+	unsigned int link;
+	const u8 *connected_addr;
+	bool bss_not_found = false;
 
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
-		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)) {
-		cfg80211_put_bss(wdev->wiphy, cr->bss);
-		return;
+		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
+		goto out;
+
+	if (cr->valid_links) {
+		if (WARN_ON(!cr->ap_mld_addr))
+			goto out;
+
+		for_each_valid_link(cr, link) {
+			if (WARN_ON(!cr->links[link].addr))
+				goto out;
+		}
 	}
 
 	wdev->unprot_beacon_reported = 0;
 	nl80211_send_connect_result(wiphy_to_rdev(wdev->wiphy), dev, cr,
 				    GFP_KERNEL);
+	connected_addr = cr->valid_links ? cr->ap_mld_addr : cr->links[0].bssid;
 
 #ifdef CONFIG_CFG80211_WEXT
-	if (wextev) {
+	if (wextev && !cr->valid_links) {
 		if (cr->req_ie && cr->status == WLAN_STATUS_SUCCESS) {
 			memset(&wrqu, 0, sizeof(wrqu));
 			wrqu.data.length = cr->req_ie_len;
@@ -729,23 +755,38 @@ void __cfg80211_connect_result(struct net_device *dev,
 
 		memset(&wrqu, 0, sizeof(wrqu));
 		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-		if (cr->bssid && cr->status == WLAN_STATUS_SUCCESS) {
-			memcpy(wrqu.ap_addr.sa_data, cr->bssid, ETH_ALEN);
-			memcpy(wdev->wext.prev_bssid, cr->bssid, ETH_ALEN);
+		if (connected_addr && cr->status == WLAN_STATUS_SUCCESS) {
+			memcpy(wrqu.ap_addr.sa_data, connected_addr, ETH_ALEN);
+			memcpy(wdev->wext.prev_bssid, connected_addr, ETH_ALEN);
 			wdev->wext.prev_bssid_valid = true;
 		}
 		wireless_send_event(dev, SIOCGIWAP, &wrqu, NULL);
 	}
 #endif
 
-	if (!cr->bss && (cr->status == WLAN_STATUS_SUCCESS)) {
-		WARN_ON_ONCE(!wiphy_to_rdev(wdev->wiphy)->ops->connect);
-		cr->bss = cfg80211_get_bss(wdev->wiphy, NULL, cr->bssid,
-					   wdev->u.client.ssid, wdev->u.client.ssid_len,
-					   wdev->conn_bss_type,
-					   IEEE80211_PRIVACY_ANY);
-		if (cr->bss)
-			cfg80211_hold_bss(bss_from_pub(cr->bss));
+	if (cr->status == WLAN_STATUS_SUCCESS) {
+		for_each_valid_link(cr, link) {
+			if (WARN_ON_ONCE(!cr->links[link].bss))
+				break;
+		}
+
+		for_each_valid_link(cr, link) {
+			if (cr->links[link].bss)
+				continue;
+
+			cr->links[link].bss =
+				cfg80211_get_bss(wdev->wiphy, NULL,
+						 cr->links[link].bssid,
+						 wdev->u.client.ssid,
+						 wdev->u.client.ssid_len,
+						 wdev->conn_bss_type,
+						 IEEE80211_PRIVACY_ANY);
+			if (!cr->links[link].bss) {
+				bss_not_found = true;
+				break;
+			}
+			cfg80211_hold_bss(bss_from_pub(cr->links[link].bss));
+		}
 	}
 
 	cfg80211_wdev_release_bsses(wdev);
@@ -755,26 +796,40 @@ void __cfg80211_connect_result(struct net_device *dev,
 		wdev->connect_keys = NULL;
 		wdev->u.client.ssid_len = 0;
 		wdev->conn_owner_nlportid = 0;
-		if (cr->bss) {
-			cfg80211_unhold_bss(bss_from_pub(cr->bss));
-			cfg80211_put_bss(wdev->wiphy, cr->bss);
-		}
+		cfg80211_connect_result_release_bsses(wdev, cr);
 		cfg80211_sme_free(wdev);
 		return;
 	}
 
-	if (WARN_ON(!cr->bss))
+	if (WARN_ON(bss_not_found)) {
+		cfg80211_connect_result_release_bsses(wdev, cr);
 		return;
+	}
 
-	wdev->links[0].client.current_bss = bss_from_pub(cr->bss);
+	memset(wdev->links, 0, sizeof(wdev->links));
+	wdev->valid_links = cr->valid_links;
+	for_each_valid_link(cr, link)
+		wdev->links[link].client.current_bss =
+			bss_from_pub(cr->links[link].bss);
 	wdev->connected = true;
-	ether_addr_copy(wdev->u.client.connected_addr, cr->bss->bssid);
+	ether_addr_copy(wdev->u.client.connected_addr, connected_addr);
+	if (cr->valid_links) {
+		for_each_valid_link(cr, link)
+			memcpy(wdev->links[link].addr, cr->links[link].addr,
+			       ETH_ALEN);
+	}
 
 	if (!(wdev->wiphy->flags & WIPHY_FLAG_HAS_STATIC_WEP))
 		cfg80211_upload_connect_keys(wdev);
 
 	rcu_read_lock();
-	country_elem = ieee80211_bss_get_elem(cr->bss, WLAN_EID_COUNTRY);
+	for_each_valid_link(cr, link) {
+		country_elem =
+			ieee80211_bss_get_elem(cr->links[link].bss,
+					       WLAN_EID_COUNTRY);
+		if (country_elem)
+			break;
+	}
 	if (!country_elem) {
 		rcu_read_unlock();
 		return;
@@ -787,12 +842,60 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!country_data)
 		return;
 
-	regulatory_hint_country_ie(wdev->wiphy, cr->bss->channel->band,
+	regulatory_hint_country_ie(wdev->wiphy,
+				   cr->links[link].bss->channel->band,
 				   country_data, country_datalen);
 	kfree(country_data);
+
+	return;
+out:
+	for_each_valid_link(cr, link)
+		cfg80211_put_bss(wdev->wiphy, cr->links[link].bss);
 }
 
-/* Consumes bss object one way or another */
+static void cfg80211_update_link_bss(struct wireless_dev *wdev,
+				     struct cfg80211_bss **bss)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct cfg80211_internal_bss *ibss;
+
+	if (!*bss)
+		return;
+
+	ibss = bss_from_pub(*bss);
+	if (list_empty(&ibss->list)) {
+		struct cfg80211_bss *found = NULL, *tmp = *bss;
+
+		found = cfg80211_get_bss(wdev->wiphy, NULL,
+					 (*bss)->bssid,
+					 wdev->u.client.ssid,
+					 wdev->u.client.ssid_len,
+					 wdev->conn_bss_type,
+					 IEEE80211_PRIVACY_ANY);
+		if (found) {
+			/* The same BSS is already updated so use it
+			 * instead, as it has latest info.
+			 */
+			*bss = found;
+		} else {
+			/* Update with BSS provided by driver, it will
+			 * be freshly added and ref cnted, we can free
+			 * the old one.
+			 *
+			 * signal_valid can be false, as we are not
+			 * expecting the BSS to be found.
+			 *
+			 * keep the old timestamp to avoid confusion
+			 */
+			cfg80211_bss_update(rdev, ibss, false,
+					    ibss->ts);
+		}
+
+		cfg80211_put_bss(wdev->wiphy, tmp);
+	}
+}
+
+/* Consumes bss object(s) one way or another */
 void cfg80211_connect_done(struct net_device *dev,
 			   struct cfg80211_connect_resp_params *params,
 			   gfp_t gfp)
@@ -802,55 +905,34 @@ void cfg80211_connect_done(struct net_device *dev,
 	struct cfg80211_event *ev;
 	unsigned long flags;
 	u8 *next;
+	size_t link_info_size = 0;
+	unsigned int link;
 
-	if (params->bss) {
-		struct cfg80211_internal_bss *ibss = bss_from_pub(params->bss);
-
-		if (list_empty(&ibss->list)) {
-			struct cfg80211_bss *found = NULL, *tmp = params->bss;
-
-			found = cfg80211_get_bss(wdev->wiphy, NULL,
-						 params->bss->bssid,
-						 wdev->u.client.ssid, wdev->u.client.ssid_len,
-						 wdev->conn_bss_type,
-						 IEEE80211_PRIVACY_ANY);
-			if (found) {
-				/* The same BSS is already updated so use it
-				 * instead, as it has latest info.
-				 */
-				params->bss = found;
-			} else {
-				/* Update with BSS provided by driver, it will
-				 * be freshly added and ref cnted, we can free
-				 * the old one.
-				 *
-				 * signal_valid can be false, as we are not
-				 * expecting the BSS to be found.
-				 *
-				 * keep the old timestamp to avoid confusion
-				 */
-				cfg80211_bss_update(rdev, ibss, false,
-						    ibss->ts);
-			}
-
-			cfg80211_put_bss(wdev->wiphy, tmp);
-		}
+	for_each_valid_link(params, link) {
+		cfg80211_update_link_bss(wdev, &params->links[link].bss);
+		link_info_size += params->links[link].bssid ? ETH_ALEN : 0;
+		link_info_size += params->links[link].addr ? ETH_ALEN : 0;
 	}
 
-	ev = kzalloc(sizeof(*ev) + (params->bssid ? ETH_ALEN : 0) +
+	ev = kzalloc(sizeof(*ev) + (params->ap_mld_addr ? ETH_ALEN : 0) +
 		     params->req_ie_len + params->resp_ie_len +
 		     params->fils.kek_len + params->fils.pmk_len +
-		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
+		     (params->fils.pmkid ? WLAN_PMKID_LEN : 0) + link_info_size,
+		     gfp);
+
 	if (!ev) {
-		cfg80211_put_bss(wdev->wiphy, params->bss);
+		for_each_valid_link(params, link)
+			cfg80211_put_bss(wdev->wiphy,
+					 params->links[link].bss);
 		return;
 	}
 
 	ev->type = EVENT_CONNECT_RESULT;
 	next = ((u8 *)ev) + sizeof(*ev);
-	if (params->bssid) {
-		ev->cr.bssid = next;
-		memcpy((void *)ev->cr.bssid, params->bssid, ETH_ALEN);
+	if (params->ap_mld_addr) {
+		ev->cr.ap_mld_addr = next;
+		memcpy((void *)ev->cr.ap_mld_addr, params->ap_mld_addr,
+		       ETH_ALEN);
 		next += ETH_ALEN;
 	}
 	if (params->req_ie_len) {
@@ -890,9 +972,28 @@ void cfg80211_connect_done(struct net_device *dev,
 	ev->cr.fils.update_erp_next_seq_num = params->fils.update_erp_next_seq_num;
 	if (params->fils.update_erp_next_seq_num)
 		ev->cr.fils.erp_next_seq_num = params->fils.erp_next_seq_num;
-	if (params->bss)
-		cfg80211_hold_bss(bss_from_pub(params->bss));
-	ev->cr.bss = params->bss;
+	ev->cr.valid_links = params->valid_links;
+	for_each_valid_link(params, link) {
+		if (params->links[link].bss)
+			cfg80211_hold_bss(
+				bss_from_pub(params->links[link].bss));
+		ev->cr.links[link].bss = params->links[link].bss;
+
+		if (params->links[link].addr) {
+			ev->cr.links[link].addr = next;
+			memcpy((void *)ev->cr.links[link].addr,
+			       params->links[link].addr,
+			       ETH_ALEN);
+			next += ETH_ALEN;
+		}
+		if (params->links[link].bssid) {
+			ev->cr.links[link].bssid = next;
+			memcpy((void *)ev->cr.links[link].bssid,
+			       params->links[link].bssid,
+			       ETH_ALEN);
+			next += ETH_ALEN;
+		}
+	}
 	ev->cr.status = params->status;
 	ev->cr.timeout_reason = params->timeout_reason;
 
@@ -910,6 +1011,9 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
 #ifdef CONFIG_CFG80211_WEXT
 	union iwreq_data wrqu;
 #endif
+	unsigned int link;
+	const u8 *connected_addr;
+
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
@@ -919,48 +1023,76 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
 	if (WARN_ON(!wdev->connected))
 		goto out;
 
+	if (info->valid_links) {
+		if (WARN_ON(!info->ap_mld_addr))
+			goto out;
+
+		for_each_valid_link(info, link) {
+			if (WARN_ON(!info->links[link].addr))
+				goto out;
+		}
+	}
+
 	cfg80211_wdev_release_bsses(wdev);
 
-	if (WARN_ON(!info->bss))
-		return;
+	for_each_valid_link(info, link) {
+		if (WARN_ON(!info->links[link].bss))
+			goto out;
+	}
 
-	cfg80211_hold_bss(bss_from_pub(info->bss));
-	wdev->links[0].client.current_bss = bss_from_pub(info->bss);
-	ether_addr_copy(wdev->u.client.connected_addr, info->bss->bssid);
+	memset(wdev->links, 0, sizeof(wdev->links));
+	wdev->valid_links = info->valid_links;
+	for_each_valid_link(info, link) {
+		cfg80211_hold_bss(bss_from_pub(info->links[link].bss));
+		wdev->links[link].client.current_bss =
+			bss_from_pub(info->links[link].bss);
+	}
 
+	connected_addr = info->valid_links ?
+			 info->ap_mld_addr :
+			 info->links[0].bss->bssid;
+	ether_addr_copy(wdev->u.client.connected_addr, connected_addr);
+	if (info->valid_links) {
+		for_each_valid_link(info, link)
+			memcpy(wdev->links[link].addr, info->links[link].addr,
+			       ETH_ALEN);
+	}
 	wdev->unprot_beacon_reported = 0;
 	nl80211_send_roamed(wiphy_to_rdev(wdev->wiphy),
 			    wdev->netdev, info, GFP_KERNEL);
 
 #ifdef CONFIG_CFG80211_WEXT
-	if (info->req_ie) {
-		memset(&wrqu, 0, sizeof(wrqu));
-		wrqu.data.length = info->req_ie_len;
-		wireless_send_event(wdev->netdev, IWEVASSOCREQIE,
-				    &wrqu, info->req_ie);
-	}
+	if (!info->valid_links) {
+		if (info->req_ie) {
+			memset(&wrqu, 0, sizeof(wrqu));
+			wrqu.data.length = info->req_ie_len;
+			wireless_send_event(wdev->netdev, IWEVASSOCREQIE,
+					    &wrqu, info->req_ie);
+		}
+
+		if (info->resp_ie) {
+			memset(&wrqu, 0, sizeof(wrqu));
+			wrqu.data.length = info->resp_ie_len;
+			wireless_send_event(wdev->netdev, IWEVASSOCRESPIE,
+					    &wrqu, info->resp_ie);
+		}
 
-	if (info->resp_ie) {
 		memset(&wrqu, 0, sizeof(wrqu));
-		wrqu.data.length = info->resp_ie_len;
-		wireless_send_event(wdev->netdev, IWEVASSOCRESPIE,
-				    &wrqu, info->resp_ie);
+		wrqu.ap_addr.sa_family = ARPHRD_ETHER;
+		memcpy(wrqu.ap_addr.sa_data, connected_addr, ETH_ALEN);
+		memcpy(wdev->wext.prev_bssid, connected_addr, ETH_ALEN);
+		wdev->wext.prev_bssid_valid = true;
+		wireless_send_event(wdev->netdev, SIOCGIWAP, &wrqu, NULL);
 	}
-
-	memset(&wrqu, 0, sizeof(wrqu));
-	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-	memcpy(wrqu.ap_addr.sa_data, info->bss->bssid, ETH_ALEN);
-	memcpy(wdev->wext.prev_bssid, info->bss->bssid, ETH_ALEN);
-	wdev->wext.prev_bssid_valid = true;
-	wireless_send_event(wdev->netdev, SIOCGIWAP, &wrqu, NULL);
 #endif
 
 	return;
 out:
-	cfg80211_put_bss(wdev->wiphy, info->bss);
+	for_each_valid_link(info, link)
+		cfg80211_put_bss(wdev->wiphy, info->links[link].bss);
 }
 
-/* Consumes info->bss object one way or another */
+/* Consumes info->links.bss object(s) one way or another */
 void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 		     gfp_t gfp)
 {
@@ -969,25 +1101,41 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 	struct cfg80211_event *ev;
 	unsigned long flags;
 	u8 *next;
+	unsigned int link;
+	size_t link_info_size = 0;
+	bool bss_not_found = false;
+
+	for_each_valid_link(info, link) {
+		link_info_size += info->links[link].addr ? ETH_ALEN : 0;
+		link_info_size += info->links[link].bssid ? ETH_ALEN : 0;
 
-	if (!info->bss) {
-		info->bss = cfg80211_get_bss(wdev->wiphy, info->channel,
-					     info->bssid, wdev->u.client.ssid,
-					     wdev->u.client.ssid_len,
-					     wdev->conn_bss_type,
-					     IEEE80211_PRIVACY_ANY);
+		if (info->links[link].bss)
+			continue;
+
+		info->links[link].bss =
+			cfg80211_get_bss(wdev->wiphy,
+					 info->links[link].channel,
+					 info->links[link].bssid,
+					 wdev->u.client.ssid,
+					 wdev->u.client.ssid_len,
+					 wdev->conn_bss_type,
+					 IEEE80211_PRIVACY_ANY);
+
+		if (!info->links[link].bss) {
+			bss_not_found = true;
+			break;
+		}
 	}
 
-	if (WARN_ON(!info->bss))
-		return;
+	if (WARN_ON(bss_not_found))
+		goto out;
 
 	ev = kzalloc(sizeof(*ev) + info->req_ie_len + info->resp_ie_len +
 		     info->fils.kek_len + info->fils.pmk_len +
-		     (info->fils.pmkid ? WLAN_PMKID_LEN : 0), gfp);
-	if (!ev) {
-		cfg80211_put_bss(wdev->wiphy, info->bss);
-		return;
-	}
+		     (info->fils.pmkid ? WLAN_PMKID_LEN : 0) +
+		     (info->ap_mld_addr ? ETH_ALEN : 0) + link_info_size, gfp);
+	if (!ev)
+		goto out;
 
 	ev->type = EVENT_ROAMED;
 	next = ((u8 *)ev) + sizeof(*ev);
@@ -1027,12 +1175,43 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 	ev->rm.fils.update_erp_next_seq_num = info->fils.update_erp_next_seq_num;
 	if (info->fils.update_erp_next_seq_num)
 		ev->rm.fils.erp_next_seq_num = info->fils.erp_next_seq_num;
-	ev->rm.bss = info->bss;
+	if (info->ap_mld_addr) {
+		ev->rm.ap_mld_addr = next;
+		memcpy((void *)ev->rm.ap_mld_addr, info->ap_mld_addr,
+		       ETH_ALEN);
+		next += ETH_ALEN;
+	}
+	ev->rm.valid_links = info->valid_links;
+	for_each_valid_link(info, link) {
+		ev->rm.links[link].bss = info->links[link].bss;
+
+		if (info->links[link].addr) {
+			ev->rm.links[link].addr = next;
+			memcpy((void *)ev->rm.links[link].addr,
+			       info->links[link].addr,
+			       ETH_ALEN);
+			next += ETH_ALEN;
+		}
+
+		if (info->links[link].bssid) {
+			ev->rm.links[link].bssid = next;
+			memcpy((void *)ev->rm.links[link].bssid,
+			       info->links[link].bssid,
+			       ETH_ALEN);
+			next += ETH_ALEN;
+		}
+	}
 
 	spin_lock_irqsave(&wdev->event_lock, flags);
 	list_add_tail(&ev->list, &wdev->event_list);
 	spin_unlock_irqrestore(&wdev->event_lock, flags);
 	queue_work(cfg80211_wq, &rdev->event_work);
+
+	return;
+out:
+	for_each_valid_link(info, link)
+		cfg80211_put_bss(wdev->wiphy, info->links[link].bss);
+
 }
 EXPORT_SYMBOL(cfg80211_roamed);
 
-- 
2.7.4

