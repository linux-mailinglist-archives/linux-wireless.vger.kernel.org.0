Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4F5BE38C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiITKmH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiITKll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2B2644A
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az6so1589527wmb.4
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lCjzjKCaFdTI757gIVvr0E42NHozbsB3zARbd5WgRjw=;
        b=J9oxrOuo3zTjagn7Pnb5Q1Zlhu1rhk8rjmVz0KjuG6jHevZDpkxVa1fkEHnp7tEIr1
         wHFQkR3izu8CpMSqWoVQ+KOvRtBDbcO9SYqIEuJRjyQPACYN7A0P9IKOVp+VrYZQetcy
         UbydPyNQD1jT57/RmnTmWmsl4gtqrXMSzDmw8WpnW8PshYjmPKjidPul2C3vC6VlX8LF
         +zwPvBPUT+336w5x7ooVQF7gR844IEmJR5grFzmcHvY4f9+gTFlXjTt+by/LYJnHStpQ
         xqwb6BCnw2RdUsbIFv5PbRN6V+pRQabTDVMDfZdO7HpcAd8a1zhoIKxpypexJ3pza44p
         N5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lCjzjKCaFdTI757gIVvr0E42NHozbsB3zARbd5WgRjw=;
        b=aunVNEMyAAXNvrESIoF30xkvZByFru0ccfbV9UYNEbVRorcdRJJHGRK+qC510bB3at
         8BmSXYljGc8ugbL5WFCglF4xkIIr6UMoEtqG5N3f+CByOwmxyC8cAGrckPlytWeJZks/
         3fy6Tu+dwX4C0hV1fUBdvvB0cmqv630w8hn0ZOT+CsUKRp72w2Zwoz5VRa+YthB6YF58
         405bsLXBK+zfGCNufbxx5HU8ihxILFuzcU2n3NG7VwKXGMopDy70qNfyCYskzwumEJeN
         1l7jU2GcbDKNiQgU78Z6n8Zk+SPLjz5Dh1AV9KY7Qxb3kOWmE7+XPQhT45U1YoMnxrls
         s1ug==
X-Gm-Message-State: ACrzQf2h3hYM0HAGxvdjJRQZUnwojAYivaIpqKTbxCYtrkFC9hIqHdjN
        EpfeuFfYAZP8uH5d8ppR/xrxx8C2KQbCUw==
X-Google-Smtp-Source: AMsMyM4LIchiwjh4hNc4OFW2t2QvslwdBauU4x6jxyi7OU3qsplWINvgJAT3MD82B3FwApIb+ZNo7g==
X-Received: by 2002:a05:600c:35c8:b0:3b4:bf50:f844 with SMTP id r8-20020a05600c35c800b003b4bf50f844mr1959074wmq.192.1663670453162;
        Tue, 20 Sep 2022 03:40:53 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1d4500880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1d:4500:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c4fc200b003a5fa79007fsm2182018wmq.7.2022.09.20.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:40:52 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC v2 3/6] mac80211: add hardware flags for TPC support
Date:   Tue, 20 Sep 2022 12:40:29 +0200
Message-Id: <20220920104032.496697-4-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920104032.496697-1-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 67d9087e031f..c4b55c7273ed 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2610,6 +2610,13 @@ struct ieee80211_txq {
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
@@ -2667,6 +2674,8 @@ enum ieee80211_hw_flags {
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

