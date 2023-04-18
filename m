Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D926E5D57
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjDRJ2f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjDRJ2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432E59DC
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810113; x=1713346113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFZzjlBJUrBUqSEi6KJiGRChfZKnYqb7TLfJ058eggc=;
  b=NKM3lVw4fZECBh0/k5VNSFAG7b2ahjaTylFuUblCEb63pcXk7/H5/I9q
   Yw3cByhgbVrPTZ/4yVd0jOoGr8MjSptk6HwYh8aA6h2vzC8guGGMrvxqg
   BpGG5KOJuYLS6OOX/4jGeG1yTVUCVc4/vCtK2PZsuQ9lFI6RFow4UK5F0
   igYAfG8C2rUmLfU+bHCSKpvml7ZyfescYglM2CUf1985CMYB29Ffc9xZa
   pJMCdHRB6509T+1ilEk1p2PMrunmElhILlsk8cbYK3GfjTvWPw5wLTPl6
   1/B9JY8aWXKG+qZ8fj/ls+K/jmXtrusmmoe7fk2TEAKDQS5sv3f2vygdU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341163"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341163"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511213"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511213"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/11] wifi: iwlwifi: mvm: fix MIC removal confusion
Date:   Tue, 18 Apr 2023 12:28:06 +0300
Message-Id: <20230418122405.81345b6ab0cd.Ibe0348defb6cce11c99929a1f049e60b5cfc150c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The RADA/firmware collaborate on MIC stripping in the following
way:
 - the firmware fills the IWL_RX_MPDU_MFLG1_MIC_CRC_LEN_MASK
   value for how many words need to be removed at the end of
   the frame, CRC and, if decryption was done, MIC
 - if the RADA is active, it will
   - remove that much from the end of the frame
   - zero the value in IWL_RX_MPDU_MFLG1_MIC_CRC_LEN_MASK

As a consequence, the only thing the driver should need to do
is to
 - unconditionally tell mac80211 that the MIC was removed
   if decryption was already done
 - remove as much as IWL_RX_MPDU_MFLG1_MIC_CRC_LEN_MASK says
   at the end of the frame, since either RADA did it and then
   the value is 0, or RADA was disabled and then the value is
   whatever should be removed to strip both CRC & MIC

However, all this code was historically grown and getting a
bit confused. Originally, we were indicating that the MIC was
not stripped, which is the version of the code upstreamed in
commit 780e87c29e77 ("iwlwifi: mvm: add 9000 series RX processing")
which indicated RX_FLAG_DECRYPTED in iwl_mvm_rx_crypto().

We later had a commit to change that to also indicate that the
MIC was stripped, adding RX_FLAG_MIC_STRIPPED. However, this was
then "fixed" later to only do that conditionally on RADA being
enabled, since otherwise RADA didn't strip the MIC bytes yet.
At the time, we were also always including the FCS if the RADA
was not enabled, so that was still broken wrt. the FCS if the
RADA isn't enabled - but that's a pretty rare case. Notably
though, it does happen for management frames, where we do need
to remove the MIC and CRC but the RADA is disabled.

Later, in commit 40a0b38d7a7f ("iwlwifi: mvm: Fix calculation of
frame length"), we changed this again, upstream this was just a
single commit, but internally it was split into first the correct
commit and then an additional fix that reduced the number of bytes
that are removed by crypt_len. Note that this is clearly wrong
since crypt_len indicates the length of the PN header (always 8),
not the length of the MIC (8 or 16 depending on algorithm).
However, this additional fix mostly canceled the other bugs,
apart from the confusion about the size of the MIC.

To fix this correctly, remove all those additional workarounds.
We really should always indicate to mac80211 the MIC was stripped
(it cannot use it anyway if decryption was already done), and also
always actually remove it and the CRC regardless of the RADA being
enabled or not. That's simple though, the value indicated in the
metadata is zeroed by the RADA if it's enabled and used the value,
so there's no need to check if it's enabled or not.

Notably then, this fixes the MIC size confusion, letting us receive
GCMP-256 encrypted management frames correctly that would otherwise
be reported to mac80211 8 bytes too short since the RADA is turned
off for them, crypt_len is 8, but the MIC size is 16, so when we do
the adjustment based on IWL_RX_MPDU_MFLG1_MIC_CRC_LEN_MASK (which
indicates 20 bytes to remove) we remove 12 bytes but indicate then
to mac80211 the MIC is still present, so mac80211 again removes the
MIC of 16 bytes, for an overall removal of 28 rather than 20 bytes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 9dbf14fa0ca7..542f6658f2d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -106,28 +106,12 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	/*
 	 * For non monitor interface strip the bytes the RADA might not have
-	 * removed. As monitor interface cannot exist with other interfaces
-	 * this removal is safe.
+	 * removed (it might be disabled, e.g. for mgmt frames). As a monitor
+	 * interface cannot exist with other interfaces, this removal is safe
+	 * and sufficient, in monitor mode there's no decryption being done.
 	 */
-	if (mic_crc_len && !ieee80211_hw_check(mvm->hw, RX_INCLUDES_FCS)) {
-		u32 pkt_flags = le32_to_cpu(pkt->len_n_flags);
-
-		/*
-		 * If RADA was not enabled then decryption was not performed so
-		 * the MIC cannot be removed.
-		 */
-		if (!(pkt_flags & FH_RSCSR_RADA_EN)) {
-			if (WARN_ON(crypt_len > mic_crc_len))
-				return -EINVAL;
-
-			mic_crc_len -= crypt_len;
-		}
-
-		if (WARN_ON(mic_crc_len > len))
-			return -EINVAL;
-
+	if (len > mic_crc_len && !ieee80211_hw_check(mvm->hw, RX_INCLUDES_FCS))
 		len -= mic_crc_len;
-	}
 
 	/* If frame is small enough to fit in skb->head, pull it completely.
 	 * If not, only pull ieee80211_hdr (including crypto if present, and
@@ -411,9 +395,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		if (!(status & IWL_RX_MPDU_STATUS_MIC_OK))
 			return -1;
 
-		stats->flag |= RX_FLAG_DECRYPTED;
-		if (pkt_flags & FH_RSCSR_RADA_EN)
-			stats->flag |= RX_FLAG_MIC_STRIPPED;
+		stats->flag |= RX_FLAG_DECRYPTED | RX_FLAG_MIC_STRIPPED;
 		*crypt_len = IEEE80211_CCMP_HDR_LEN;
 		return 0;
 	case IWL_RX_MPDU_STATUS_SEC_TKIP:
-- 
2.38.1

