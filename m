Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4AA211A20
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgGBCUz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 22:20:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17178 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgGBCUz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 22:20:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593656454; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=v0gYd3Xj2m8+HRBZ3MVrzbE4J7T7ZOsDZxIPyzDGQmQ=; b=di4ou2HOCky2hCLMDKWQ9ZI3C/T/yqA/AIMhBHXvLQ6KBvGru2za8lDfIQaa6GscXkdf+Tk8
 8Kj4I82ciQwlbm6bQle7gurPKV6Ds9WRP4xUSgVvb209sBfauZ2MQ5UwT2Qsluh0ypmwkPmd
 irISLqDnXk5Bye5i54XEjR1lu2c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5efd4471bfb34e631ca4fc8c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 02:20:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 309D6C433CB; Thu,  2 Jul 2020 02:20:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31776C433C6;
        Thu,  2 Jul 2020 02:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31776C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH] mac80211: fix warning in 6 GHz IE addition in mesh mode
Date:   Wed,  1 Jul 2020 19:20:24 -0700
Message-Id: <1593656424-18240-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The commit 24a2042cb22f ("mac80211: add HE 6 GHz Band Capability
element") failed to check device capability before adding HE 6 GHz
capability element. Below warning is reported in 11ac device in mesh.
Fix that by checking device capability at HE 6 GHz cap IE addition
in mesh beacon and association request.

WARNING: CPU: 1 PID: 1897 at net/mac80211/util.c:2878
ieee80211_ie_build_he_6ghz_cap+0x149/0x150 [mac80211]
[ 3138.720358] Call Trace:
[ 3138.720361]  ieee80211_mesh_build_beacon+0x462/0x530 [mac80211]
[ 3138.720363]  ieee80211_start_mesh+0xa8/0xf0 [mac80211]
[ 3138.720365]  __cfg80211_join_mesh+0x122/0x3e0 [cfg80211]
[ 3138.720368]  nl80211_join_mesh+0x3d3/0x510 [cfg80211]

Fixes: 24a2042cb22f ("mac80211: add HE 6 GHz Band Capability element")
Reported-by: Markus Theil <markus.theil@tu-ilmenau.de>
Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/mac80211/mesh.c | 13 +++++++++++++
 net/mac80211/util.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5f1ca25b6c97..e88beb3ff6db 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -617,6 +617,19 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
 			    struct sk_buff *skb)
 {
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_sband_iftype_data *iftd;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
+	iftd = ieee80211_get_sband_iftype_data(sband,
+					       NL80211_IFTYPE_MESH_POINT);
+	/* The device doesn't support HE in mesh mode or at all */
+	if (!iftd)
+		return 0;
+
 	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
 	return 0;
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 21c94094a699..dd9f5c7a1ade 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2878,6 +2878,10 @@ void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(!iftd))
 		return;
 
+	/* Check for device HE 6 GHz capability before adding element */
+	if (!iftd->he_6ghz_capa.capa)
+		return;
+
 	cap = le16_to_cpu(iftd->he_6ghz_capa.capa);
 	cap &= ~IEEE80211_HE_6GHZ_CAP_SM_PS;
 
-- 
2.7.4

