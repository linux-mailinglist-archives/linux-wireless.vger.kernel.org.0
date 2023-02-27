Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957E6A4F91
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 00:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB0XLd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 18:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0XLc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 18:11:32 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C944211F6
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 15:11:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id fd25so4624790pfb.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 15:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cNCysxX10lTLEsdFza/ysayL6e/hODJOco6BvsCk1c=;
        b=JWSsG1WLVCmoTQY/A00Tz5aXyVh6MyLzSHrVsPLQYIVGE/Bbf7/012JJhSnqM+Q8RX
         0h8BcjdEuGKrDxFFY5IFDE6jgeTeAoocnix7ASC6gDinCgBQM53wwyYnkpYpEa+Mk914
         isceTYSd6VGGsxQDN309L4VrKXTr0WVLbGM0qecpfnHLGPNnG6oiWugy32hcCwE6OxVJ
         z3oG+5Kc9M6YwI3i+R6hGmreeY8rH+zE8zZml4eskNZuqOBrPcM/sQNloJCQ0OaeWCNq
         Bn1rRczFAmEqCeChIC5KPNj7KHaYcmNJqiwZrFsikCgZypb6xkvTSPh22UIqMtWSTwOU
         DZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cNCysxX10lTLEsdFza/ysayL6e/hODJOco6BvsCk1c=;
        b=5tE+MJfp3RPn2XbCrcFYFBoEG951W+26CUbzmES34yUE6Kd0qXL2Fditvznb/jT7A0
         Sya5lBCl09x+YrWabRaiovM11fD/tct6c3PFuVhqvlEZGweLlPuM1uVwz9kveJnBmA/Z
         6GaT954mRs2lzh0+roA3p5uwVSgsF1QOuCQCO2EctNDvhCpbb7OFdKy+m2bAmeQLGUSe
         Eqtqdkwv5YHeUKEkMr72VZ8X4Yr3HxtHIh0zxrVzYxFd8uM58xfNbrG/YAvmZ8loRLSJ
         1OTcFwqMTBBWSWCMTBYx7lJPwtNhwxD8yvkpxnU/gxIHeYl5HgOZMQvvyx/w13s5QC6U
         oFWA==
X-Gm-Message-State: AO0yUKURP0WR4iSTWI0nKdd4Ar2ZR/Bp11MOFkhS2GcyxtTmPJfNgYEy
        k3oU+w9Y1Z9Clrib0zlYuJfBuQ==
X-Google-Smtp-Source: AK7set8TP9jB7PA2XFdfMsMoCZIirx2cDvVq54VEboz3xPHoXFZc0R+Nr2mANIb+ZSaB4TRWG7tP0w==
X-Received: by 2002:a62:1dc8:0:b0:5df:421d:1962 with SMTP id d191-20020a621dc8000000b005df421d1962mr567051pfd.2.1677539490575;
        Mon, 27 Feb 2023 15:11:30 -0800 (PST)
Received: from virs-pc-014.morsemicro.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id e18-20020a62aa12000000b00593cd0f37dcsm4715654pff.169.2023.02.27.15.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 15:11:30 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] iw: S1G: add list command support for 802.11ah
Date:   Tue, 28 Feb 2023 12:11:24 +1300
Message-Id: <20230227231124.711053-1-gilad.itzkovitch@virscient.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>

In this changeset S1G frequencies are displayed for any S1G band
with their relevant properties.

Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 info.c | 15 ++++++++++++++-
 util.c |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/info.c b/info.c
index 5229d44..7d649b8 100644
--- a/info.c
+++ b/info.c
@@ -297,6 +297,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	struct nlattr *tb_freq[NL80211_FREQUENCY_ATTR_MAX + 1];
 	static struct nla_policy freq_policy[NL80211_FREQUENCY_ATTR_MAX + 1] = {
 		[NL80211_FREQUENCY_ATTR_FREQ] = { .type = NLA_U32 },
+		[NL80211_FREQUENCY_ATTR_OFFSET] = { .type = NLA_U32 },
 		[NL80211_FREQUENCY_ATTR_DISABLED] = { .type = NLA_FLAG },
 		[NL80211_FREQUENCY_ATTR_NO_IR] = { .type = NLA_FLAG },
 		[__NL80211_FREQUENCY_ATTR_NO_IBSS] = { .type = NLA_FLAG },
@@ -392,12 +393,24 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 				}
 				nla_for_each_nested(nl_freq, tb_band[NL80211_BAND_ATTR_FREQS], rem_freq) {
 					uint32_t freq;
+					uint32_t offset = 0;
+
 					nla_parse(tb_freq, NL80211_FREQUENCY_ATTR_MAX, nla_data(nl_freq),
 						  nla_len(nl_freq), freq_policy);
 					if (!tb_freq[NL80211_FREQUENCY_ATTR_FREQ])
 						continue;
 					freq = nla_get_u32(tb_freq[NL80211_FREQUENCY_ATTR_FREQ]);
-					printf("\t\t\t* %d MHz [%d]", freq, ieee80211_frequency_to_channel(freq));
+					if (tb_freq[NL80211_FREQUENCY_ATTR_OFFSET])
+						offset = nla_get_u32(
+							tb_freq[NL80211_FREQUENCY_ATTR_OFFSET]);
+
+					if (tb_freq[NL80211_FREQUENCY_ATTR_OFFSET])
+						printf("\t\t\t* %d.%d MHz", freq, offset);
+					else
+						printf("\t\t\t* %d MHz", freq);
+
+					if (ieee80211_frequency_to_channel(freq))
+						printf(" [%d]", ieee80211_frequency_to_channel(freq));
 
 					if (tb_freq[NL80211_FREQUENCY_ATTR_MAX_TX_POWER] &&
 					    !tb_freq[NL80211_FREQUENCY_ATTR_DISABLED])
diff --git a/util.c b/util.c
index 8a2ba10..ba7dc26 100644
--- a/util.c
+++ b/util.c
@@ -199,6 +199,8 @@ int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
 
 int ieee80211_frequency_to_channel(int freq)
 {
+	if (freq < 1000)
+		return 0;
 	/* see 802.11-2007 17.3.8.3.2 and Annex J */
 	if (freq == 2484)
 		return 14;

base-commit: d6fd2757f7aab638022ffa635e32e21594ec382d
-- 
2.25.1

