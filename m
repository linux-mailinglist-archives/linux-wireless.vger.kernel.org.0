Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8A1FCC6C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFQLc5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 07:32:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25676 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQLc4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 07:32:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592393575; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=1meUstU7f4R51xkuXQj+/cO2/RzxThox/KP1Ekl9dCI=; b=sowZDtIkjOHGD9b4coUFQkva2JGxEqE6WFcrBetoR3owCsWk2cFzjwG3yfN91Mzz2ltAARnT
 4GVmfjyeO6vYPchCCd1IVrrTycnveMG57vE6KV2mlMD08pyJGmkzox+2T9UBN7OCnLQjhi34
 I6Fq15CHlzOJFhGMEoOra4jkZpo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ee9ff4ef3deea03f3fb842b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Jun 2020 11:32:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44812C433C9; Wed, 17 Jun 2020 11:32:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vjakkam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjakkam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35250C433CA;
        Wed, 17 Jun 2020 11:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35250C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjakkam@codeaurora.org
From:   Veerendranath Jakkam <vjakkam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ieee80211: Add missing and new AKM suite selector definitions
Date:   Wed, 17 Jun 2020 17:01:32 +0530
Message-Id: <20200617113132.13477-1-vjakkam@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the definitions for missing AKM selectors defined in
IEEE P802.11-REVmd/D3.0, table 9-151. These definitions will
be used by various drivers that support these new AKM suites.

Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
---
 include/linux/ieee80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index fe15f831841b..9f732499ea88 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3333,13 +3333,17 @@ struct ieee80211_multiple_bssid_configuration {
 #define WLAN_AKM_SUITE_TDLS			SUITE(0x000FAC, 7)
 #define WLAN_AKM_SUITE_SAE			SUITE(0x000FAC, 8)
 #define WLAN_AKM_SUITE_FT_OVER_SAE		SUITE(0x000FAC, 9)
+#define WLAN_AKM_SUITE_AP_PEER_KEY		SUITE(0x000FAC, 10)
 #define WLAN_AKM_SUITE_8021X_SUITE_B		SUITE(0x000FAC, 11)
 #define WLAN_AKM_SUITE_8021X_SUITE_B_192	SUITE(0x000FAC, 12)
+#define WLAN_AKM_SUITE_FT_8021X_SHA384		SUITE(0x000FAC, 13)
 #define WLAN_AKM_SUITE_FILS_SHA256		SUITE(0x000FAC, 14)
 #define WLAN_AKM_SUITE_FILS_SHA384		SUITE(0x000FAC, 15)
 #define WLAN_AKM_SUITE_FT_FILS_SHA256		SUITE(0x000FAC, 16)
 #define WLAN_AKM_SUITE_FT_FILS_SHA384		SUITE(0x000FAC, 17)
 #define WLAN_AKM_SUITE_OWE			SUITE(0x000FAC, 18)
+#define WLAN_AKM_SUITE_FT_PSK_SHA384		SUITE(0x000FAC, 19)
+#define WLAN_AKM_SUITE_PSK_SHA384		SUITE(0x000FAC, 20)
 
 #define WLAN_MAX_KEY_LEN		32
 
-- 
2.20.1

