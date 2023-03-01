Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D66A6A9F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCAKLb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCAKLA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:11:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6803B872
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665458; x=1709201458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=co+rVrOFCKc3kxBy40bN3jUQjfcwyBOsRNDN0fBumQk=;
  b=TPwdAIDGCK6mhH8A3Y0yXFw1jo8VJxp11pAnZDoHU2yV8FnMQBzBk4fQ
   /SyS0730BkyRHgKUyeqPgRCi26JYG/N1aPiZ3ysF0NjwIctt4SeavxHgR
   iieAtMsJ0lys7wFWbf2vpTYJZR5xu2qFPRsGFsnALhdFwfdXBmpnnmP2Y
   JcKOHpER0mnl2vYATMPTYmIpq0XJe+9IFXmozYO3Jyw3LHcejTsR/z9h0
   WjJNft2m+Il9rnSUdIYnW13XD25Gzu//cY8pC5RxCkIkpXiRDKIdKy272
   zrstwVtzMV8q/W2humzDTOo8xMPLMbIpFY+Wd0kkJj52CMInMNqLfq5Ik
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662988"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589262"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589262"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:55 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 23/23] wifi: mac80211: add support for driver adding radiotap TLVs
Date:   Wed,  1 Mar 2023 12:09:35 +0200
Message-Id: <20230301115906.b18fd5da8477.I576400ec40a7b35ef97a3b09a99b3a49e9174786@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The new TLV format enables adding TLVs after the fixed
fields in radiotap, as part of the radiotap header.
Support this and move vendor data to the TLV format,
allowing a reuse of the RX_FLAG_RADIOTAP_VENDOR_DATA as
the new RX_FLAG_RADIOTAP_TLV_AT_END flag.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 27 +++---
 drivers/net/wireless/mac80211_hwsim.c         | 45 +++++-----
 include/net/ieee80211_radiotap.h              | 20 +++++
 include/net/mac80211.h                        | 44 ++--------
 net/mac80211/rx.c                             | 82 ++++++-------------
 5 files changed, 91 insertions(+), 127 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 549dbe0be223..d1769464d75b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -209,33 +209,34 @@ static void iwl_mvm_add_rtap_sniffer_config(struct iwl_mvm *mvm,
 					    struct sk_buff *skb)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	struct ieee80211_vendor_radiotap *radiotap;
-	const int size = sizeof(*radiotap) + sizeof(__le16);
+	struct ieee80211_radiotap_vendor_tlv *radiotap;
+	const u16 vendor_data_len = sizeof(mvm->cur_aid);
+	const u16 padding = ALIGN(vendor_data_len, 4) - vendor_data_len;
 
 	if (!mvm->cur_aid)
 		return;
 
-	/* ensure alignment */
-	BUILD_BUG_ON((size + 2) % 4);
+	radiotap = skb_put(skb, sizeof(*radiotap) + vendor_data_len + padding);
+	radiotap->type = cpu_to_le16(IEEE80211_RADIOTAP_VENDOR_NAMESPACE);
+	radiotap->len = cpu_to_le16(sizeof(*radiotap) -
+				    sizeof(struct ieee80211_radiotap_tlv) +
+				    vendor_data_len);
 
-	radiotap = skb_put(skb, size + 2);
-	radiotap->align = 1;
 	/* Intel OUI */
 	radiotap->oui[0] = 0xf6;
 	radiotap->oui[1] = 0x54;
 	radiotap->oui[2] = 0x25;
 	/* radiotap sniffer config sub-namespace */
-	radiotap->subns = 1;
-	radiotap->present = 0x1;
-	radiotap->len = size - sizeof(*radiotap);
-	radiotap->pad = 2;
-
+	radiotap->oui_subtype = 1;
+	radiotap->vendor_type = 0;
+	/* clear reserved field */
+	radiotap->reserved = 0;
 	/* fill the data now */
 	memcpy(radiotap->data, &mvm->cur_aid, sizeof(mvm->cur_aid));
 	/* and clear the padding */
-	memset(radiotap->data + sizeof(__le16), 0, radiotap->pad);
+	memset(radiotap->data + vendor_data_len, 0, padding);
 
-	rx_status->flag |= RX_FLAG_RADIOTAP_VENDOR_DATA;
+	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
 }
 
 /* iwl_mvm_pass_packet_to_mac80211 - passes the packet for mac80211 */
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index e9b9340a97dc..152617034d19 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1534,37 +1534,38 @@ static void mac80211_hwsim_add_vendor_rtap(struct sk_buff *skb)
 	 * the values accordingly.
 	 */
 #ifdef HWSIM_RADIOTAP_OUI
-	struct ieee80211_vendor_radiotap *rtap;
+	struct ieee80211_radiotap_vendor_tlv *rtap;
+	static const char vendor_data[8] = "ABCDEFGH";
+
+	// Make sure no padding is needed
+	BUILD_BUG_ON(sizeof(vendor_data) % 4);
+	/* this is last radiotap info before the mac header, so
+	 * skb_reset_mac_header for mac8022 to know the end of
+	 * the radiotap TLV/beginning of the 802.11 header
+	 */
+	skb_reset_mac_header(skb);
 
 	/*
 	 * Note that this code requires the headroom in the SKB
 	 * that was allocated earlier.
 	 */
-	rtap = skb_push(skb, sizeof(*rtap) + 8 + 4);
+	rtap = skb_push(skb, sizeof(*rtap) + sizeof(vendor_data));
+
+	rtap->len = cpu_to_le16(sizeof(*rtap) -
+				sizeof(struct ieee80211_radiotap_tlv) +
+				sizeof(vendor_data));
+	rtap->type = cpu_to_le16(IEEE80211_RADIOTAP_VENDOR_NAMESPACE);
+
 	rtap->oui[0] = HWSIM_RADIOTAP_OUI[0];
 	rtap->oui[1] = HWSIM_RADIOTAP_OUI[1];
 	rtap->oui[2] = HWSIM_RADIOTAP_OUI[2];
-	rtap->subns = 127;
+	rtap->oui_subtype = 127;
+	/* clear reserved field */
+	rtap->reserved = 0;
+	rtap->vendor_type = 0;
+	memcpy(rtap->data, vendor_data, sizeof(vendor_data));
 
-	/*
-	 * Radiotap vendor namespaces can (and should) also be
-	 * split into fields by using the standard radiotap
-	 * presence bitmap mechanism. Use just BIT(0) here for
-	 * the presence bitmap.
-	 */
-	rtap->present = BIT(0);
-	/* We have 8 bytes of (dummy) data */
-	rtap->len = 8;
-	/* For testing, also require it to be aligned */
-	rtap->align = 8;
-	/* And also test that padding works, 4 bytes */
-	rtap->pad = 4;
-	/* push the data */
-	memcpy(rtap->data, "ABCDEFGH", 8);
-	/* make sure to clear padding, mac80211 doesn't */
-	memset(rtap->data + 8, 0, 4);
-
-	IEEE80211_SKB_RXCB(skb)->flag |= RX_FLAG_RADIOTAP_VENDOR_DATA;
+	IEEE80211_SKB_RXCB(skb)->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
 #endif
 }
 
diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 0fc2667a9a5d..95436686d3fe 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -369,6 +369,26 @@ struct ieee80211_radiotap_tlv {
 	u8 data[];
 } __packed;
 
+/**
+ * struct ieee80211_radiotap_vendor_tlv - vendor radiotap data information
+ * @type: should always be set to IEEE80211_RADIOTAP_VENDOR_NAMESPACE
+ * @len: length of data
+ * @oui: radiotap vendor namespace OUI
+ * @oui_subtype: radiotap vendor sub namespace
+ * @vendor_type: radiotap vendor type
+ * @reserved: should always be set to zero (to avoid leaking memory)
+ * @data: the actual vendor namespace data
+ */
+struct ieee80211_radiotap_vendor_tlv {
+	__le16 type; /* IEEE80211_RADIOTAP_VENDOR_NAMESPACE */
+	__le16 len;
+	u8 oui[3];
+	u8 oui_subtype;
+	__le16 vendor_type;
+	__le16 reserved;
+	u8 data[];
+} __packed;
+
 /* ieee80211_radiotap_eht_usig - content of U-SIG tlv (type 33)
  * see www.radiotap.org/fields/U-SIG.html for details
  */
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5df9eb828a58..3a43ce5fd4ec 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1375,9 +1375,12 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  *	subframes share the same sequence number. Reported subframes can be
  *	either regular MSDU or singly A-MSDUs. Subframes must not be
  *	interleaved with other frames.
- * @RX_FLAG_RADIOTAP_VENDOR_DATA: This frame contains vendor-specific
- *	radiotap data in the skb->data (before the frame) as described by
- *	the &struct ieee80211_vendor_radiotap.
+ * @RX_FLAG_RADIOTAP_TLV_AT_END: This frame contains radiotap TLVs in the
+ *	skb->data (before the 802.11 header).
+ *	If used, the SKB's mac_header pointer must be set to point
+ *	to the 802.11 header after the TLVs, and any padding added after TLV
+ *	data to align to 4 must be cleared by the driver putting the TLVs
+ *	in the skb.
  * @RX_FLAG_ALLOW_SAME_PN: Allow the same PN as same packet before.
  *	This is used for AMSDU subframes which can have the same PN as
  *	the first subframe.
@@ -1429,7 +1432,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_ONLY_MONITOR		= BIT(17),
 	RX_FLAG_SKIP_MONITOR		= BIT(18),
 	RX_FLAG_AMSDU_MORE		= BIT(19),
-	RX_FLAG_RADIOTAP_VENDOR_DATA	= BIT(20),
+	RX_FLAG_RADIOTAP_TLV_AT_END	= BIT(20),
 	RX_FLAG_MIC_STRIPPED		= BIT(21),
 	RX_FLAG_ALLOW_SAME_PN		= BIT(22),
 	RX_FLAG_ICV_STRIPPED		= BIT(23),
@@ -1569,39 +1572,6 @@ ieee80211_rx_status_to_khz(struct ieee80211_rx_status *rx_status)
 	       (rx_status->freq_offset ? 500 : 0);
 }
 
-/**
- * struct ieee80211_vendor_radiotap - vendor radiotap data information
- * @present: presence bitmap for this vendor namespace
- *	(this could be extended in the future if any vendor needs more
- *	 bits, the radiotap spec does allow for that)
- * @align: radiotap vendor namespace alignment. This defines the needed
- *	alignment for the @data field below, not for the vendor namespace
- *	description itself (which has a fixed 2-byte alignment)
- *	Must be a power of two, and be set to at least 1!
- * @oui: radiotap vendor namespace OUI
- * @subns: radiotap vendor sub namespace
- * @len: radiotap vendor sub namespace skip length, if alignment is done
- *	then that's added to this, i.e. this is only the length of the
- *	@data field.
- * @pad: number of bytes of padding after the @data, this exists so that
- *	the skb data alignment can be preserved even if the data has odd
- *	length
- * @data: the actual vendor namespace data
- *
- * This struct, including the vendor data, goes into the skb->data before
- * the 802.11 header. It's split up in mac80211 using the align/oui/subns
- * data.
- */
-struct ieee80211_vendor_radiotap {
-	u32 present;
-	u8 align;
-	u8 oui[3];
-	u8 subns;
-	u8 pad;
-	u16 len;
-	u8 data[];
-} __packed;
-
 /**
  * enum ieee80211_conf_flags - configuration flags
  *
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c7e44bc8ed5a..0abb88baab57 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -55,7 +55,7 @@ static struct sk_buff *ieee80211_clean_skb(struct sk_buff *skb,
 	/* After pulling radiotap header, clear all flags that indicate
 	 * info on skb->data.
 	 */
-	status->flag &= ~(RX_FLAG_RADIOTAP_VENDOR_DATA |
+	status->flag &= ~(RX_FLAG_RADIOTAP_TLV_AT_END |
 			  RX_FLAG_RADIOTAP_LSIG |
 			  RX_FLAG_RADIOTAP_HE_MU |
 			  RX_FLAG_RADIOTAP_HE);
@@ -126,9 +126,6 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	/* allocate extra bitmaps */
 	if (status->chains)
 		len += 4 * hweight8(status->chains);
-	/* vendor presence bitmap */
-	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA)
-		len += 4;
 
 	if (ieee80211_have_rx_timestamp(status)) {
 		len = ALIGN(len, 8);
@@ -190,34 +187,28 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 		len += 2 * hweight8(status->chains);
 	}
 
-	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
-		struct ieee80211_vendor_radiotap *rtap;
-		int vendor_data_offset = 0;
+	if (status->flag & RX_FLAG_RADIOTAP_TLV_AT_END) {
+		int tlv_offset = 0;
 
 		/*
 		 * The position to look at depends on the existence (or non-
 		 * existence) of other elements, so take that into account...
 		 */
 		if (status->flag & RX_FLAG_RADIOTAP_HE)
-			vendor_data_offset +=
+			tlv_offset +=
 				sizeof(struct ieee80211_radiotap_he);
 		if (status->flag & RX_FLAG_RADIOTAP_HE_MU)
-			vendor_data_offset +=
+			tlv_offset +=
 				sizeof(struct ieee80211_radiotap_he_mu);
 		if (status->flag & RX_FLAG_RADIOTAP_LSIG)
-			vendor_data_offset +=
+			tlv_offset +=
 				sizeof(struct ieee80211_radiotap_lsig);
 
-		rtap = (void *)&skb->data[vendor_data_offset];
+		/* ensure 4 byte alignment for TLV */
+		len = ALIGN(len, 4);
 
-		/* alignment for fixed 6-byte vendor data header */
-		len = ALIGN(len, 2);
-		/* vendor data header */
-		len += 6;
-		if (WARN_ON(rtap->align == 0))
-			rtap->align = 1;
-		len = ALIGN(len, rtap->align);
-		len += rtap->len + rtap->pad;
+		/* TLVs until the mac header */
+		len += skb_mac_header(skb) - &skb->data[tlv_offset];
 	}
 
 	return len;
@@ -313,9 +304,9 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 	u32 it_present_val;
 	u16 rx_flags = 0;
 	u16 channel_flags = 0;
+	u32 tlvs_len = 0;
 	int mpdulen, chain;
 	unsigned long chains = status->chains;
-	struct ieee80211_vendor_radiotap rtap = {};
 	struct ieee80211_radiotap_he he = {};
 	struct ieee80211_radiotap_he_mu he_mu = {};
 	struct ieee80211_radiotap_lsig lsig = {};
@@ -336,18 +327,17 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 		skb_pull(skb, sizeof(lsig));
 	}
 
-	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
-		rtap = *(struct ieee80211_vendor_radiotap *)skb->data;
-		/* rtap.len and rtap.pad are undone immediately */
-		skb_pull(skb, sizeof(rtap) + rtap.len + rtap.pad);
+	if (status->flag & RX_FLAG_RADIOTAP_TLV_AT_END) {
+		/* data is pointer at tlv all other info was pulled off */
+		tlvs_len = skb_mac_header(skb) - skb->data;
 	}
 
 	mpdulen = skb->len;
 	if (!(has_fcs && ieee80211_hw_check(&local->hw, RX_INCLUDES_FCS)))
 		mpdulen += FCS_LEN;
 
-	rthdr = skb_push(skb, rtap_len);
-	memset(rthdr, 0, rtap_len - rtap.len - rtap.pad);
+	rthdr = skb_push(skb, rtap_len - tlvs_len);
+	memset(rthdr, 0, rtap_len - tlvs_len);
 	it_present = &rthdr->it_present;
 
 	/* radiotap header, set always present flags */
@@ -369,13 +359,8 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 				 BIT(IEEE80211_RADIOTAP_DBM_ANTSIGNAL);
 	}
 
-	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
-		it_present_val |= BIT(IEEE80211_RADIOTAP_VENDOR_NAMESPACE) |
-				  BIT(IEEE80211_RADIOTAP_EXT);
-		put_unaligned_le32(it_present_val, it_present);
-		it_present++;
-		it_present_val = rtap.present;
-	}
+	if (status->flag & RX_FLAG_RADIOTAP_TLV_AT_END)
+		it_present_val |= BIT(IEEE80211_RADIOTAP_TLV);
 
 	put_unaligned_le32(it_present_val, it_present);
 
@@ -706,22 +691,6 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 		*pos++ = status->chain_signal[chain];
 		*pos++ = chain;
 	}
-
-	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
-		/* ensure 2 byte alignment for the vendor field as required */
-		if ((pos - (u8 *)rthdr) & 1)
-			*pos++ = 0;
-		*pos++ = rtap.oui[0];
-		*pos++ = rtap.oui[1];
-		*pos++ = rtap.oui[2];
-		*pos++ = rtap.subns;
-		put_unaligned_le16(rtap.len, pos);
-		pos += 2;
-		/* align the actual payload as requested */
-		while ((pos - (u8 *)rthdr) & (rtap.align - 1))
-			*pos++ = 0;
-		/* data (and possible padding) already follows */
-	}
 }
 
 static struct sk_buff *
@@ -797,6 +766,13 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	bool only_monitor = false;
 	unsigned int min_head_len;
 
+	if (WARN_ON_ONCE(status->flag & RX_FLAG_RADIOTAP_TLV_AT_END &&
+			 !skb_mac_header_was_set(origskb))) {
+		/* with this skb no way to know where frame payload starts */
+		dev_kfree_skb(origskb);
+		return NULL;
+	}
+
 	if (status->flag & RX_FLAG_RADIOTAP_HE)
 		rtap_space += sizeof(struct ieee80211_radiotap_he);
 
@@ -806,12 +782,8 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	if (status->flag & RX_FLAG_RADIOTAP_LSIG)
 		rtap_space += sizeof(struct ieee80211_radiotap_lsig);
 
-	if (unlikely(status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA)) {
-		struct ieee80211_vendor_radiotap *rtap =
-			(void *)(origskb->data + rtap_space);
-
-		rtap_space += sizeof(*rtap) + rtap->len + rtap->pad;
-	}
+	if (status->flag & RX_FLAG_RADIOTAP_TLV_AT_END)
+		rtap_space += skb_mac_header(origskb) - &origskb->data[rtap_space];
 
 	min_head_len = rtap_space;
 
-- 
2.38.1

