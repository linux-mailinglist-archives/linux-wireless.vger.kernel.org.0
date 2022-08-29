Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957605A4F7F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiH2OmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiH2OmF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:42:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774192F62
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq11so10461279wrb.12
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fm7qEMv+xUI/3r1l2+5+ZPC82d9Mfm+oNWCnOPxaifI=;
        b=RZUII4V41Sj5NMQ8xYO9vnAGhXUy2ZXF+wpCvQ3BAIhgeufcZZmxp5cOSylR5K1zGs
         Ln/CJMtDTGYvQpxW6PL17WWNfKycLsxjZAwfkUdGpkGAWZ5X8JREyelQzoL4VT0ioliC
         mOm/BKuv/ph4tz91bP6DXGJ/9Sdvmqh4GUXWH9c3ZAdXebZNTSyiJu733hKZ+DQRBHpg
         R9KMeRDju8SNJ7okWBdQdmo7wJ2QuSoYlqH8jLCL5Y0HNUgeW3kwRvK4CUNP17u8fEKv
         MHbK0Bc0fZrg4+VbMBTgXcLLJIlIiwvDyP3qJ+Ol8pUyDsmKGuqwWP7cUJTAvBmw+0gg
         crlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fm7qEMv+xUI/3r1l2+5+ZPC82d9Mfm+oNWCnOPxaifI=;
        b=2Hyf83zBJH3WhMYbsupQhaABjynHmWQP37LHFdWugMPAAEiuMApN2oaTf7LE8XgNLB
         0Lf7j+DmTrKrCekSEGU2qr0X8qTwbRT5Guk9TFVOwxAfmEhrtk71BKrVdUD0pAlOyLMD
         P7tSM8vk8o1ZSJxrD0v/FxbFSaAd0VuSho4c5iCjdMy38KYg8VD+lYsI+GJYY9cNoba6
         rgrKJRNRl9WCbtwhYaEoVXN0Ww0KTGkMN43/yuJ3k6ZDDxchJDdtEmr8B/ldPieJ9afY
         h0D3AIG2hEvI9sCXOCTN0Zsh6ERtrm0vbQe2X48iyPsEtdLBVS78awAN8U5Z9z8uQBmN
         pH6g==
X-Gm-Message-State: ACgBeo2aUNkXYHCHOQf1jAFPWBI8fRzynZJ7KPgNOwvJ/OdrbX3lDLAg
        9zi0GACyx5lWGnDYV6MuZ7ikypbwz/w=
X-Google-Smtp-Source: AA6agR5BUeLckLLdSQZsed6IdrBbFgCbaRJrDSzkT/XSCrxgivv9+1D6+3W9XNzFnn0NCynzU93E9Q==
X-Received: by 2002:a05:6000:1b92:b0:220:7d86:2e30 with SMTP id r18-20020a0560001b9200b002207d862e30mr6769817wru.530.1661784123298;
        Mon, 29 Aug 2022 07:42:03 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f18a600880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f18:a600:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9398431wmc.41.2022.08.29.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:42:02 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC 3/4] mac80211: add hardware flags for TPC support
Date:   Mon, 29 Aug 2022 16:41:46 +0200
Message-Id: <20220829144147.484787-4-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829144147.484787-1-jelonek.jonas@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds two hardware flags for drivers to indicate their
transmit power control (TPC) capabilities: TPC per packet or TPC
per mrr stage of each data packet. The driver has to register with its
TPC capabilities when it is registering at the mac80211.

Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 include/net/mac80211.h | 9 +++++++++
 net/mac80211/debugfs.c | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 659662f8b5dd..ce3241313e06 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2564,6 +2564,13 @@ struct ieee80211_txq {
  * @IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX: Hardware/driver handles transmitting
  *	multicast frames on all links, mac80211 should not do that.
  *
+ * @IEEE80211_HW_SUPPORTS_TPC_PER_PACKET: The hardware/driver supports transmit
+ * 	power control (TPC) with one power level per data packet.
+ *
+ * @IEEE80211_HW_SUPPORTS_TPC_PER_MRR: The hardware/driver supports transmit
+ * 	power control (TPC) with individual power levels for each
+ * 	multi-rate-retry (mrr) stage per packet.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2621,6 +2628,8 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP,
 	IEEE80211_HW_DETECTS_COLOR_COLLISION,
 	IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX,
+	IEEE80211_HW_SUPPORTS_TPC_PER_PACKET,
+	IEEE80211_HW_SUPPORTS_TPC_PER_MRR,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 78c7d60e8667..daeef1e04cb5 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -496,6 +496,8 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_CONC_MON_RX_DECAP),
 	FLAG(DETECTS_COLOR_COLLISION),
 	FLAG(MLO_MCAST_MULTI_LINK_TX),
+	FLAG(SUPPORTS_TPC_PER_PACKET),
+	FLAG(SUPPORTS_TPC_PER_MRR),
 #undef FLAG
 };
 
-- 
2.30.2

