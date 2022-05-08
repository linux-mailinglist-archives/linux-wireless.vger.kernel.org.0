Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6055851EE75
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiEHPP1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiEHPPW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 11:15:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2C6DF20
        for <linux-wireless@vger.kernel.org>; Sun,  8 May 2022 08:11:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d5so16272415wrb.6
        for <linux-wireless@vger.kernel.org>; Sun, 08 May 2022 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NXjCuVkY8iGV+7u5uOVgz6eVaPr2NaEzZv3vOuLoG0=;
        b=ijxVNixyd8WO6mA4twG2YuLfuvsd0cG+eZXdV+u87Iqb+ptuP6T/CG5BfSmYrl+Xh0
         OFYGGeMNZzB2zrJS9aoHBLU9UZ2995oCZEIN18frek7wLq8BqdocqSJd6oJJOV6gSb4o
         QTr7PlnXBPfh8t3Ln1PcpMOlPEjAACdwN5Z1oOA5pABVHO8hvY8w0eip7+2jVY+dOuHe
         avP+8hmFdBrlmpsRw6+Ai2+jFlaXRHju9bnd7J3DcJV5SzYkybaxVKfx3ucOmYRy1HM1
         qc4Ik5yGvT7otA4Nx5hAAZKoXxvEYFpmBwsnTTuS8r0zq1x5Smh3YtT0Vfvm7XYJ6f65
         CXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0NXjCuVkY8iGV+7u5uOVgz6eVaPr2NaEzZv3vOuLoG0=;
        b=KOyduXKe7ajXd9NT1blrHRY0hbnF2d90Kt4UK+GvADYkt/GosCgVf2vq8SKbBYwUzv
         hyBqaVPUtSA3DVteiLbPtFHY2JPQWIC1l6WFIqmucTvVBhXgZOR3oaIxz2r7GOUtP8pd
         braDkrUoQJ4YcRVx7/9GUBvNCUpcRgzSh0yq8sAL0Li9P6aeGtibAtXm1mxTTq5xnDI3
         50FjB/OdPex39GUfmdcrTaJ7S3tfzZwsfC5pgizyz8Iq2Rk9cEMY1YtLAO0c66PknFAo
         6mbLaXWkbnVMIq8CD9YndeFKO1m6T89W1skvGywCe3w2Fe4lr0zl8bDv39I0KW9zqe4r
         mYLg==
X-Gm-Message-State: AOAM532tp5PQYNGeNakEWF0I8CFZrxrMlNmQjtc6uAL1ABZjGeLvfCCq
        P4N37SLQjXoyxqRaIJGH5/q+dmdQosI=
X-Google-Smtp-Source: ABdhPJwwm2d3UJtv5PiNL9l78mONoyBuUq89GIg6vkzxShOG8PxD4fQMXOH8UwoICnBNARAkLSWCFw==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr10403998wrz.690.1652022689472;
        Sun, 08 May 2022 08:11:29 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1bf700880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1b:f700:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c145600b003942a244f2esm14788023wmi.7.2022.05.08.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 08:11:28 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, nbd@nbd.name, johannes@sipsolutions.net,
        thomas.huehn@hs-nordhausen.de,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v3 0/2] mac80211: extend current rate control tx status API
Date:   Sun,  8 May 2022 17:10:54 +0200
Message-Id: <20220508151056.2431775-1-jelonek.jonas@gmail.com>
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
v3: - Changed concept of handling different tx power level steps
    - Fixed some minor incorrect changes
    - Adjusted changes in mt76

v2: Fixed some typos and a missing ! in changes in status.c
---

Jonas Jelonek (2):
  mac80211: extend current rate control tx status API
  mac80211: minstrel_ht: support ieee80211_rate_status

 drivers/net/wireless/mediatek/mt76/tx.c |   5 +-
 include/net/mac80211.h                  |  33 +++++-
 net/mac80211/rc80211_minstrel_ht.c      | 138 ++++++++++++++++++++++--
 net/mac80211/rc80211_minstrel_ht.h      |   2 +-
 net/mac80211/status.c                   |  91 +++++++++-------
 5 files changed, 216 insertions(+), 53 deletions(-)

-- 
2.30.2

