Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2181E1A6A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 06:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgEZEb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 00:31:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11517 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbgEZEb6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 00:31:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590467517; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qz0vEoYnUtpMVBdcWKiJrjIfvSGU0XIqgiV1Wt5GnXE=; b=bACOVX1O6VUvawt+txIy11HRSioowEkcwNi0fDQLkA6i7JCTbV5vyPntChFQ6tRhEmKP6pZw
 M4/Dch92/X145/cmg06OOM8WJitPlSB4erxN2MEMJYayuJSLEp118sdegdvqvbjobwNwnac/
 SVWrL36rG59vP7dDO4D3iP0DKlg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ecc9bb9b65440fdba43db46 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 04:31:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91BBCC433C9; Tue, 26 May 2020 04:31:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1012C433CA;
        Tue, 26 May 2020 04:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1012C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH] cfg80211: propagate iftype HE 6 GHz capability
Date:   Mon, 25 May 2020 21:31:31 -0700
Message-Id: <1590467491-21187-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Advertise per interface HE 6 GHz band capability to user space
which will be used to build IEs.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/nl80211.c       | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9c0a912f1684..10dd250c7d6a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3527,6 +3527,8 @@ enum nl80211_mpath_info {
  *     capabilities IE
  * @NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE: HE PPE thresholds information as
  *     defined in HE capabilities IE
+ * @NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAP: HE 6 GHz band capabilities as in HE
+ *     6 GHz band capabilities IE
  * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band HE capability attribute currently
  *     defined
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
@@ -3539,6 +3541,7 @@ enum nl80211_band_iftype_attr {
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY,
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET,
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
+	NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAP,
 
 	/* keep last */
 	__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bcd7a452e8b1..af9f296ed2af 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1607,6 +1607,13 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
 			    sizeof(he_cap->ppe_thres), he_cap->ppe_thres))
 			return -ENOBUFS;
+
+		if (he_cap->has_he_6ghz) {
+			if (nla_put_u16(msg,
+					NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAP,
+					he_cap->he_6ghz.cap))
+				return -ENOBUFS;
+		}
 	}
 
 	return 0;
-- 
2.7.4

