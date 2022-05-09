Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8930E5203B2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiEIRoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiEIRoM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 13:44:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5B13EA0
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 10:40:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so20493674wrg.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 May 2022 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NR3VaO7MDabOJ2H3SjZymPVWXps9LzQQRuk1CCKUpyE=;
        b=COJCAUaEBeuuQxtyXz5bvT32fAX9GuEjN9HdJIDZ/6I4Av9vTSBeV6CutvN4xlTsjg
         /NHc1p+h8mcl4TTGP27Woy+0Rl5w/Zj8bwjNzAmZlVkWp2h1O2298VUxKY8CtU5pg6/X
         mHQyjbXa+HgREQEQQjDbFAD/HtSu/XGfMSjfCwAVUoCiMjIk46vmRKKfUqNwyuK7m/iY
         lxQLrBOvVMH0QFzBmL+1hczNhNSAvSFRPa+ue+qKpnply/GVbfRARiNS8kd3pTQzLOAY
         VNBvtZwBtBft3Dyzm0mvcoYbuJ+LVJwjj9XGZ5PoA5lPuw4l+6PA9o06mp7rWGZ/yY23
         un2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NR3VaO7MDabOJ2H3SjZymPVWXps9LzQQRuk1CCKUpyE=;
        b=uDS0xRP50cDEDl2hmqXfgSwgvYgQMjQtalRBVkDndrKtf8pkxFn6Nb4BePyq7oYGmI
         L9jxemUpfX8wa1H8hYO4sNbDy5L0RHqc9XyOBHs2bWUPlxLAsJvFLJYxkoLH5MeZVaWm
         L/o9qiZGpaTRND1CcUY8VwTcqRnZgudWs7SJJMyA+IjD9/dHkCxzZRYJ+AcpbA+Z4pBN
         2ELoGlouxo+048RLH43iJsLwxQb8jJlpfS1oDTQU8snMqmT6tM3tvr6q2iLyUdfpP3zk
         c71yPdaqEipMVo6sOnTeqoChrXzVPFvEG0J7DCxKyECgqOxEvAh4r2jFGD55VtO/ox0u
         nHXQ==
X-Gm-Message-State: AOAM531ILRwfN+vuAIiO6U+ecVS7K6whgbLRIigtbqxg937hf6+6j6LS
        3vfr7PACLI4cB7/hBmjZPv+oAn6bbcQ=
X-Google-Smtp-Source: ABdhPJzbqion3DyfH9Fktw7SbTN4zu0eyYw5+Q9Ys75v26vTMv8AleDSmfHTKP6oGkn5YIcbE+sJdQ==
X-Received: by 2002:adf:fb03:0:b0:20a:e253:b8c7 with SMTP id c3-20020adffb03000000b0020ae253b8c7mr14516578wrr.119.1652118015979;
        Mon, 09 May 2022 10:40:15 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f11c200880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f11:c200:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id bh26-20020a05600c3d1a00b003942a244ee8sm14106253wmb.45.2022.05.09.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:40:15 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, johannes@sipsolutions.net,
        thomas.huehn@hs-nordhausen.de, greearb@candelatech.com,
        kvalo@kernel.org, Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v4 0/2] mac80211: extend current rate control tx status API
Date:   Mon,  9 May 2022 19:39:56 +0200
Message-Id: <20220509173958.1398201-1-jelonek.jonas@gmail.com>
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
Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with
                OpenWrt Linux 5.10.113

---
v4: mistakenly compile-tested with old mac80211-next tree, switched to
        current wireless-next and fixed ath11k build error with first patch

v3: - Changed concept of handling different tx power level steps
    - Fixed some minor incorrect changes
    - Adjusted changes in mt76

v2: Fixed some typos and a missing ! in changes in status.c
---


Jonas Jelonek (2):
  mac80211: extend current rate control tx status API
  mac80211: minstrel_ht: support ieee80211_rate_status

 drivers/net/wireless/ath/ath11k/dp_tx.c |   8 +-
 drivers/net/wireless/mediatek/mt76/tx.c |   5 +-
 include/net/mac80211.h                  |  33 +++++-
 net/mac80211/rc80211_minstrel_ht.c      | 138 ++++++++++++++++++++++--
 net/mac80211/rc80211_minstrel_ht.h      |   2 +-
 net/mac80211/status.c                   |  91 +++++++++-------
 6 files changed, 223 insertions(+), 54 deletions(-)

-- 
2.30.2

