Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244E87327F0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbjFPGyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242498AbjFPGye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B501FE8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898472; x=1718434472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PFomWAGrjdI6BtMMsExASXRKirLoxCyJK5u0Kx6Mj8=;
  b=FgvF/vtMILdDCpFVKm0/XEja/I/FCmWIsMcdNJ13kvtUnUizCcwJp5/t
   B6qQtUs5xxDJMdrZ7Fl9PORnSPp8kZu6/oL9YAo326Ow1Gb5GTfq4c1FI
   Nnw0iuRYZpdbu4tcHr0xaYN8zxpRMtYxe9NPxlEMWNfzEvnJGi4UuuybA
   lw1VhaR6uZSP+FD2hrYZ/gqLs4lbYTJWo74k4fJSHOJ+4l3OvOzhVFurW
   6HX2HH1jLYbq2JA64/91MCnfqxSWibiZ6bAM5CCGcNN5D/5K1L5ZmO9FX
   GRkjB7Yd57iH579yQrsCS67wwORZCQ48MNYUb4vfJKc4UDr476dihD8KQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078796"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078796"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802719992"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802719992"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Naik <abhishek.naik@intel.com>,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/20] wifi: mac80211: handle TDLS data frames with MLO
Date:   Fri, 16 Jun 2023 09:53:52 +0300
Message-Id: <20230616094948.4bf648b63dfd.I98ef1dabd14b74a92120750f7746a7a512011701@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

If the device is associated with an AP MLD, then TDLS data frames
should have
 - A1 = peer address,
 - A2 = own MLD address (since the peer may now know about MLO), and
 - A3 = BSSID.

Change the code to do that.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tx.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d8460a14b6bd..b5183f6365aa 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2753,10 +2753,20 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		tdls_peer = test_sta_flag(sta, WLAN_STA_TDLS_PEER);
 
 		if (tdls_peer) {
+			/* For TDLS only one link can be valid with peer STA */
+			int tdls_link_id = sta->sta.valid_links ?
+					   __ffs(sta->sta.valid_links) : 0;
+			struct ieee80211_link_data *link;
+
 			/* DA SA BSSID */
 			memcpy(hdr.addr1, skb->data, ETH_ALEN);
 			memcpy(hdr.addr2, skb->data + ETH_ALEN, ETH_ALEN);
-			memcpy(hdr.addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+			link = rcu_dereference(sdata->link[tdls_link_id]);
+			if (WARN_ON_ONCE(!link)) {
+				ret = -EINVAL;
+				goto free;
+			}
+			memcpy(hdr.addr3, link->u.mgd.bssid, ETH_ALEN);
 			hdrlen = 24;
 		}  else if (sdata->u.mgd.use_4addr &&
 			    cpu_to_be16(ethertype) != sdata->control_port_protocol) {
@@ -3066,10 +3076,18 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (test_sta_flag(sta, WLAN_STA_TDLS_PEER)) {
+			/* For TDLS only one link can be valid with peer STA */
+			int tdls_link_id = sta->sta.valid_links ?
+					   __ffs(sta->sta.valid_links) : 0;
+			struct ieee80211_link_data *link;
+
 			/* DA SA BSSID */
 			build.da_offs = offsetof(struct ieee80211_hdr, addr1);
 			build.sa_offs = offsetof(struct ieee80211_hdr, addr2);
-			memcpy(hdr->addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+			link = rcu_dereference(sdata->link[tdls_link_id]);
+			if (WARN_ON_ONCE(!link))
+				break;
+			memcpy(hdr->addr3, link->u.mgd.bssid, ETH_ALEN);
 			build.hdr_len = 24;
 			break;
 		}
-- 
2.38.1

