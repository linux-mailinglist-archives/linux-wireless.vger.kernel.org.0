Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ADE4D3AB0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiCIT7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 14:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbiCIT7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 14:59:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245AFD0A
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 11:58:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r10so4759033wrp.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Mar 2022 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVQRk2QQrTJSkM5cVvf2Yf3o40nLlVWYyttPpn3LNZU=;
        b=osk9PoKUMEvqnpaL28rk83foKMcyTl/bOIRvXgBVtMMniTYxXhoQyrk6ZivZSm9dBm
         TZR5tN7alCJss+3D1kdp0nfzYfQh7zcMoFI71aZskvYIojONgDj/JY0tcqpRJzY9jeuQ
         tJYUhkmlcKGPROr5VY0aOQKN8d5/0+4yrfliSNUtuxb1xb7qUNRT7ZTzUDzQV74IGJTF
         s9hUhW9bF3zTkYNyK2agwClQ/tCdaULXqtynpzJZH58Y8DhKQu1UWxGgjuOtsDpaBGU9
         re2WMtRbGTKA/5/V1miVbS9FwvLLoId67aftMMaH2E7W4SmdHefiTZ+ASZygqH3RxH5F
         H+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVQRk2QQrTJSkM5cVvf2Yf3o40nLlVWYyttPpn3LNZU=;
        b=zaGBzI8G44RbPis7wVpeERU2sW9jSywHRgxz05RJGSsizhJBucgwVs3VH4nhhQPF8r
         OGfU8tVNKuLWAgRWeDFPudhnd2k1m/Wjji0vqdUs+YffGw3Vmmfc6RDGj93K0RLtlxTm
         HC5pTUMe6jrkBJX+lDrNTSPRWcvYrRcoEdYN6s/8Ee90azPVWSmDz3EunUaoNs4FAiFZ
         o7ygQhYjJbhKnbz0BaVKAH21MZSQmlYb57IW+tT58hckohuVa20/Zbb3U5w3noM5DZ1U
         TH6hqF8NEUvVcStDYuXO+GwuAuLofCL1bxMmZgxywWv8bY5wppMlASCqH8v/Q9oxGQFE
         k65Q==
X-Gm-Message-State: AOAM5339LJ4QaPtvJNOk5w67rZhYq2DhMYFmr9WwGaibzENvoKLMJi2G
        flgg9qpYFGlSqadgpea4ko7Qw0/Rz3CWeL7r
X-Google-Smtp-Source: ABdhPJyBkTTSoOmXGUOgKYHkDN5ifGFol6nzGDsjDvX7qI5lJJmiLZ9E1OwI2gTXhXk9znYoK0ts+g==
X-Received: by 2002:a5d:59a3:0:b0:1f5:1eee:fc90 with SMTP id p3-20020a5d59a3000000b001f51eeefc90mr937225wrr.625.1646855912911;
        Wed, 09 Mar 2022 11:58:32 -0800 (PST)
Received: from build-server.fritz.box (p200300c56f16bf00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f16:bf00:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id d25-20020adfa419000000b001f04b3a4b46sm2420403wra.94.2022.03.09.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:58:32 -0800 (PST)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, nbd@nbd.name, johannes@sipsolutions.net,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v2 0/2] mac80211: extend current rate control tx status API
Date:   Wed,  9 Mar 2022 20:57:57 +0100
Message-Id: <20220309195759.1494-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This patch series extends the current rate control tx status API.
ieee80211_tx_info has a fixed limit in size (SKB_CB) and its ieee80211_tx_rate
is not suitable to annotate e.g. the mcs rate set from IEEE 802.11ax nor
additional per packet information like tx-power.

The commit 18fb84d986b3 introduced the extended on-stack struct
ieee80211_tx_status, which makes the tx status API more extensible.

With this patch we introduce a new struct ieee80211_rate_status that extends
current rate control tx status API further, in order to achieve:
(1)     receive tx power status feedback for transmit power control per
        packet or packet retry
(2)     dynamic mapping of wifi chip specific multi-rate retry (mrr) chains
        with different lengths
(3)     increase the limit of annotatable rate indices to support
        IEEE802.11ax rate sets and beyond

(1) cannot be achieved with the use of struct ieee80211_tx_info because both
control and status buffer have a fixed SKB_CB size limit. E.g. the current 
control buffer size would only allow tx-power annotations per packet,
not per mrr chain. The status buffer has no free space left. Struct
ieee80211_tx_status is intended to add such extensions.

(2) is motivated by the varying length of mrr chains in common wireless
hardware supported by Linux. E.g. Atheros chipsets support four mrr chain
stages, mediatek chips vary from a single mrr chain stage up to 8 stages, all
with specific restrictions in rate configuration, retry count and tx-power
control ability.
Currently the number of mrr chain stages is fixed to 4 (defined by
IEEE80211_TX_MAX_RATES). Although this value could be increased, a change
would affect all wireless drivers and probably cause additional problems.
Therefore we introduce a dynamic-sized solution that supports different
numbers of mrr chain stages hence a dynamic allocation of chain stages
supported by different wifi chipsets.

(3) The current struct ieee80211_tx_info uses a s8 integer for rate idx,
which would be to less for e.g. IEEE802.11ax rate annotations. To overcome
this limitation, we introduce struct rate_info from cfg80211.h. This struct
is not limited to annotate rates hence addressing rates up to 802.11ax and
also future rate sets are usable.

Our new struct is intended for all information related to RC and TPC that
needs to be passed from driver to mac80211 and its RC/TPC algorithms like
Minstrel_HT. Multiple instances of this struct can be included in struct
ieee80211_tx_status via a pointer and a length variable. Those can be
allocated on-stack. The former reference to a single instance of struct
rate_info is replaced with our new annotation.

Compile-Tested: current wireless-next tree with all flags on
Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
                Linux 5.10.83

---
v2: Fixed some typos and a missing ! in changes in status.c
---

Jonas Jelonek (2):
  mac80211: extend current rate control tx status API
  mac80211: minstrel_ht: support ieee80211_rate_status

 drivers/net/wireless/mediatek/mt76/tx.c |  13 ++-
 include/net/mac80211.h                  |  10 +-
 net/mac80211/rc80211_minstrel_ht.c      | 131 ++++++++++++++++++++++--
 net/mac80211/rc80211_minstrel_ht.h      |   2 +-
 net/mac80211/status.c                   |  91 +++++++++-------
 5 files changed, 195 insertions(+), 52 deletions(-)

-- 
2.30.2

