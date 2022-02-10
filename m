Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277754B1602
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbiBJTM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:12:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245101AbiBJTMz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:12:55 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CCB1167
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=BPfuNrLrkTB+MLaVJ7tJheRjY8CABVwaIaS07Wk7tLk=; t=1644520370; x=1645729970; 
        b=JniEhyh5w1/LDMBoE06aVmecxiy2fzq0ZUSBNKW9UjllMiOLay7HVPOXArcq2QdKs2QD6yviFE6
        urcEUAZfpxi3/IRYg8dMUPmT7MPlr+V2bVoqejhR5QRP2gUs0HlCGBsGQY2cdFpHzna/rV4fxSxAP
        SUxOAsrwo5JygaZ+GM7+6nM6ZFQAIG6KrJGUT0Fl/Tbd/89hgBjwXnEwOP9jBcYy8cNZ6Zwhhk4IS
        h2v1SqTRnlksN1leDOz7/oEOE6mQzp5NTPQ3Sr64wXsLjXfv73jjA1jSM2TbKjd2rQB0PPUE9g8DU
        +i/N3pp3Ysu/MJQkpx6VMyHqnneRwOqd3xWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEs2-00HBq2-Jv;
        Thu, 10 Feb 2022 20:12:46 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] ieee80211: use tab to indent struct ieee80211_neighbor_ap_info
Date:   Thu, 10 Feb 2022 20:12:43 +0100
Message-Id: <20220210201242.da8fa2e5ae8d.Ia452db01876e52e815f6337fef437049df0d8bd9@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Somehow spaces were used here, use tab instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ec1a43834611..72bd76a768e0 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4330,10 +4330,10 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_RNR_TBTT_PARAMS_COLOC_AP			0x40
 
 struct ieee80211_neighbor_ap_info {
-       u8 tbtt_info_hdr;
-       u8 tbtt_info_len;
-       u8 op_class;
-       u8 channel;
+	u8 tbtt_info_hdr;
+	u8 tbtt_info_len;
+	u8 op_class;
+	u8 channel;
 } __packed;
 
 enum ieee80211_range_params_max_total_ltf {
-- 
2.34.1

