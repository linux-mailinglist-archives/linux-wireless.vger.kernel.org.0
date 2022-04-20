Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDC7507FCA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 06:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349227AbiDTEQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 00:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEQv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 00:16:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2B167C3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 21:14:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id r10so760906pfh.13
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 21:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vp8wZAPOTAacECbW24GNgBEaRn/U2vif8Hb//GR4nuw=;
        b=tFwJw8BbXDB1gNJcKPwDEbGh1i77zCUCF6tEaib5fHlfqYOuCiUpu3mBiG+YgAUEz7
         vnq29ogNOiBViBNDPPcL0H9WOeRZJEL9zh1EFUVRM88XdRSvgY9IZqjmFrmbJSS52TWR
         aiZRC2h3G09VM5bueUYiYWss+n3HiEqSD4SHNDbtCq0p2/Bj5+ToI0px02cMzz/0yI7c
         ztTQ+zZthOElWdIymAmYLo8avBVaVAyckSbmqaGIVU4cgMj5OEIfYJZUY8ocPngTLIXV
         ja7t04PqyAdHXJ6jY3j38Mk7O5DzNNcBeMWkTF0s4qlKKYv1QZ/HkznfVbvEI8oWJ9hQ
         re/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vp8wZAPOTAacECbW24GNgBEaRn/U2vif8Hb//GR4nuw=;
        b=drLRrwmmLysVW3VAnAwCbEU4r+2HTEpkudhfqwmq6jBD1Us3cOcddOw8jW0QY9vogd
         IZiz8dtEVvzPMPKVX1j66dYlsoJWbcI5nZcbW7t7A2qChGQjP97sutq/nWEMBixBC94Y
         jp7uflLqsupbAH4O/tJCeBvTFjd3yMlqairMPFqHsm8zKfkljiq8NzUtjZJX9sLblz24
         BuRAeCyRkpu+uqv48IQmC8ge3NeTeQ+FtA+y3jXQDvbWPcQo4o3h3DrJNiNYhVk+YB/7
         rd84K8lvLDdA6vT3ztLw1j1uT4Xro64eVBDSBp5lpZVndyzTm846OkNnwTwSyZSoaqNg
         PWeA==
X-Gm-Message-State: AOAM530k274S7dwyJ7B6D46EWAwfK4GIqG65OtaktzN5TyAiqt1TYIHf
        eo1vub3Ky0z0GIfbMXmQK1snp153W1HAluNs
X-Google-Smtp-Source: ABdhPJwo6sOVq8Gr1OnSTKJF30bwZDjbYUTpJ/W7TSMe766U2zsEDUXar4SAJgwDBzUReHrmTBcexg==
X-Received: by 2002:a63:b58:0:b0:399:522b:d92f with SMTP id a24-20020a630b58000000b00399522bd92fmr17551697pgl.141.1650428046990;
        Tue, 19 Apr 2022 21:14:06 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm18891545pfc.190.2022.04.19.21.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:14:06 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH] nl80211: validate S1G channel width
Date:   Wed, 20 Apr 2022 04:13:21 +0000
Message-Id: <20220420041321.3788789-2-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420041321.3788789-1-kieran.frewen@morsemicro.com>
References: <20220420041321.3788789-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Validate the S1G channel width input by user to ensure it matches
that of the requested channel

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/wireless/nl80211.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ee1c2b6b6971..4f7e43e82b52 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3172,6 +3172,15 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	} else if (attrs[NL80211_ATTR_CHANNEL_WIDTH]) {
 		chandef->width =
 			nla_get_u32(attrs[NL80211_ATTR_CHANNEL_WIDTH]);
+		if (chandef->chan->band == NL80211_BAND_S1GHZ) {
+			/* User input error for channel width doesn't match channel  */
+			if (chandef->width != ieee80211_s1g_channel_width(chandef->chan)) {
+				NL_SET_ERR_MSG_ATTR(extack,
+						    attrs[NL80211_ATTR_CHANNEL_WIDTH],
+						    "bad channel width");
+				return -EINVAL;
+			}
+		}
 		if (attrs[NL80211_ATTR_CENTER_FREQ1]) {
 			chandef->center_freq1 =
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ1]);
-- 
2.25.1

