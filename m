Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9096F6D2A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjEDNp4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjEDNpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 09:45:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827AA7DB6
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683207948; x=1714743948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWPwiXIV8XBAvOD9Vb4WxXzDPpW7bSqzkKu/5ReSOgQ=;
  b=R9VAr31XRCP9m/nBtnXUexRh4FTgsf26RcaFWqeVcLyYhr9khSS44y5O
   k6E1sk1pU1GZtOYeV/fG5i5d62PL79DqR0YHPkyN+yq0MZg8EXKNjwqLw
   H6GwA5Vue5wn3i2vS0nldbvWACs/JXEh0So+Xftg0j8SRpWcUC0Vjk/1S
   n6q4wtQizCn6Zyv7X2xJ2z8UUn17/x2Vtb198EYpzbsr9ODd9AAD6xMtf
   7LVxDXO0/xe0M4FuDak3RPAT+OsQNChDFL3KeixEUmHPiASWnSGIvnbZ8
   /TN9M5ExkF/ndD73gH3wFG0OubOX1AQkG/p/Kq060O/YR5zhPZKCpp16B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="435242688"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435242688"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766591858"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766591858"
Received: from haddadra-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.238.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:45:46 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/11] wifi: mac80211: fetch and store the EML capability information
Date:   Thu,  4 May 2023 16:45:10 +0300
Message-Id: <20230504134511.828474-11-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504134511.828474-1-gregory.greenman@intel.com>
References: <20230504134511.828474-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to teach the low level driver about the EML capability which
includes information for EMLSR / EMLMR operation.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 35 +++++++++++++++++++++++++++++++++++
 include/net/mac80211.h    |  2 ++
 net/mac80211/mlme.c       | 11 +++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c271184a3968..fba4c44da832 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4635,6 +4635,41 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 	return sizeof(*mle) + common + mle->variable[0];
 }
 
+/**
+ * ieee80211_mle_get_eml_cap - returns the EML capability
+ * @data: pointer to the multi link EHT IE
+ *
+ * The element is assumed to be big enough. This must be checked by
+ * ieee80211_mle_size_ok().
+ * If the EML capability can't be found (the type is not basic, or
+ * the EML capability presence bit is clear), 0 will be returned.
+ */
+static inline u16 ieee80211_mle_get_eml_cap(const u8 *data)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control = le16_to_cpu(mle->control);
+	const u8 *common = mle->variable;
+
+	if (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE) !=
+	    IEEE80211_ML_CONTROL_TYPE_BASIC)
+		return 0;
+
+	/* common points now at the beginning of ieee80211_mle_basic_common_info */
+	common += sizeof(struct ieee80211_mle_basic_common_info);
+
+	if (!(control & IEEE80211_MLC_BASIC_PRES_EML_CAPA))
+		return 0;
+
+	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
+		common += 1;
+	if (control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY)
+		common += 2;
+
+	return get_unaligned_le16(common);
+}
+
 /**
  * ieee80211_mle_size_ok - validate multi-link element size
  * @data: pointer to the element data
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac0370e76874..f75d941eece8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1790,6 +1790,7 @@ enum ieee80211_offload_flags {
  * @ps: power-save mode (STA only). This flag is NOT affected by
  *	offchannel/dynamic_ps operations.
  * @aid: association ID number, valid only when @assoc is true
+ * @eml_cap: EML capabilities as described in P802.11be_D2.2 Figure 9-1002k.
  * @arp_addr_list: List of IPv4 addresses for hardware ARP filtering. The
  *	may filter ARP queries targeted for other addresses than listed here.
  *	The driver must allow ARP queries targeted for all address listed here
@@ -1812,6 +1813,7 @@ struct ieee80211_vif_cfg {
 	bool ibss_creator;
 	bool ps;
 	u16 aid;
+	u16 eml_cap;
 
 	__be32 arp_addr_list[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	int arp_addr_cnt;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0020c9e41caa..4ea383aafcac 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4838,6 +4838,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			 IEEE80211_CONN_DISABLE_EHT)) &&
 	    he_oper) {
 		const struct cfg80211_bss_ies *cbss_ies;
+		const struct element *eht_ml_elem;
 		const u8 *eht_oper_ie;
 
 		cbss_ies = rcu_dereference(cbss->ies);
@@ -4848,6 +4849,16 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			eht_oper = (void *)(eht_oper_ie + 3);
 		else
 			eht_oper = NULL;
+
+		eht_ml_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+						     cbss_ies->data, cbss_ies->len);
+
+		/* data + 1 / datalen - 1 since it's an extended element */
+		if (eht_ml_elem &&
+		    ieee80211_mle_size_ok(eht_ml_elem->data + 1,
+					  eht_ml_elem->datalen - 1))
+			sdata->vif.cfg.eml_cap =
+				ieee80211_mle_get_eml_cap(eht_ml_elem->data + 1);
 	}
 
 	/* Allow VHT if at least one channel on the sband supports 80 MHz */
-- 
2.38.1

