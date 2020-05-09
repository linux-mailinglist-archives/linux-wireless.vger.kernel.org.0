Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE66C1CBBA6
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 02:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgEIANd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 20:13:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53460 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbgEIANd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 20:13:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588983212; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=dKANdmrJlaFLRIkTGL+hMGdoJGsE4uHCx6btM3q5HFQ=; b=jwFGrjZI5fSzN66Vt+h8OOb67nz22FUOhkE9wAVI7X4JslSH3t9VAZK8cUTJiOCrqnyujnJJ
 43ZZdcYhVkjtfv++PK5LH76XnNcnP8Do5sRqsvGn6w7lI0Qrh5wWmHziCaSfOXLj0vVTqSpR
 hHcpOJiLEIzsNMDwP6F49CZpxgk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5f5a2.7f0f2d4199d0-smtp-out-n01;
 Sat, 09 May 2020 00:13:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA42DC43637; Sat,  9 May 2020 00:13:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF16CC432C2;
        Sat,  9 May 2020 00:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF16CC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v3 04/11] mac80211: add HE 6 GHz Band Capabilities into parse extension
Date:   Fri,  8 May 2020 17:12:58 -0700
Message-Id: <1588983185-5741-4-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
References: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle 6 GHz band capability element parsing for association.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/linux/ieee80211.h  | 1 +
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/util.c        | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 77462dff6db3..86b094738ce9 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2614,6 +2614,7 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_MAX_CHANNEL_SWITCH_TIME = 52,
 	WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION = 55,
 	WLAN_EID_EXT_NON_INHERITANCE = 56,
+	WLAN_EID_EXT_HE_6GHZ_BAND_CAP = 59,
 };
 
 /* Action category code */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f8ed4f621f7f..5e33746d7210 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1491,6 +1491,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_he_operation *he_operation;
 	const struct ieee80211_he_spr *he_spr;
 	const struct ieee80211_mu_edca_param_set *mu_edca_param_set;
+	const struct ieee80211_he_6ghz_band_cap *he_6ghz_cap_elem;
 	const u8 *uora_element;
 	const u8 *mesh_id;
 	const u8 *peering;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 20436c86b9bf..5a33755c22f4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -936,6 +936,10 @@ static void ieee80211_parse_extension_element(u32 *crc,
 		    len >= ieee80211_he_spr_size(data))
 			elems->he_spr = data;
 		break;
+	case WLAN_EID_EXT_HE_6GHZ_BAND_CAP:
+		if (len == sizeof(struct ieee80211_he_6ghz_band_cap))
+			elems->he_6ghz_cap_elem = data;
+		break;
 	}
 }
 
-- 
2.7.4
