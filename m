Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF43B1CC2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFWOnp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 10:43:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21230 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhFWOno (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 10:43:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624459287; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DVpqjGIy/7HG8Elia0zAgMZnQ9jg9/So2d0is0MWAP8=; b=G6G9vNUE/qelbKeDpkhf7hymyIiR93uzZ9yhuixDTpTLoHh6rxJhStWKVNcfF7xnkT1XUkIy
 r3LnG0WDtQGk5bTqQFRIkfQMi00DD8uWimi2mWtjuxd4TkIjBDKlB7lmoI+JzGdnBrDM+RZU
 JJV9NndnhmV6c3j5j/fzxPB5B5g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60d348000090905e16613322 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 14:41:04
 GMT
Sender: akalaise=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D728C4338A; Wed, 23 Jun 2021 14:41:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akalaise-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akalaise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86595C433F1;
        Wed, 23 Jun 2021 14:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86595C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akalaise@codeaurora.org
From:   Abinaya Kalaiselvan <akalaise@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Abinaya Kalaiselvan <akalaise@codeaurora.org>
Subject: [PATCHv3] mac80211: fix NULL ptr dereference during mesh peer connection for non HE devices
Date:   Wed, 23 Jun 2021 20:10:44 +0530
Message-Id: <1624459244-4497-1-git-send-email-akalaise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"sband->iftype_data" is not assigned with any value for non HE supported
devices, which causes NULL pointer access during mesh peer connection
in those devices. Fix this by accessing the pointer after HE
capabilities condition check.

Fixes: 7f7aa94bcaf0 (mac80211: reduce peer HE MCS/NSS to own capabilities)
Signed-off-by: Abinaya Kalaiselvan <akalaise@codeaurora.org>
---
v3:
* Indentation warning is fixed 
v2:
* ieee80211_sta_he_cap structure instance is initialized.

 net/mac80211/he.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 0c0b970..96a47b0 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -111,7 +111,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct sta_info *sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
-	struct ieee80211_sta_he_cap own_he_cap = sband->iftype_data->he_cap;
+	struct ieee80211_sta_he_cap own_he_cap = {0};
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
 	u8 mcs_nss_size;
@@ -123,6 +123,8 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	if (!he_cap_ie || !ieee80211_get_he_sta_cap(sband))
 		return;
 
+	own_he_cap = sband->iftype_data->he_cap;
+
 	/* Make sure size is OK */
 	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap_ie_elem);
 	he_ppe_size =
-- 
2.7.4

