Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06504C56A5
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 16:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiBZPjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Feb 2022 10:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiBZPjf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Feb 2022 10:39:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949E3EB5
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 07:38:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r10so8827366wrp.3
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+NsKRak4E6oWm24P8nfd/b8QFJedBnhyKM2Lb80NbQ=;
        b=EXRuw7z7qc0vwMRKpAfr8VvDGGjUuSa6Mc0RiOhng5X5QQaY9luYB6dLtwKauDaOBA
         OvOLCS3eL1wm9frcnkc4S2BVaXCZ1oYKwTsVY7IUznTUNfLc/HIPsoirdehNHrEiyFQB
         7EkQJBSQa79eq1p/nfYkh6VUmMMKhWOYk62BK0QzzRABo09/NqCQro3Ccq8/nX2WktJm
         4fcFJ/V3DmfG5FmIo78QZIkO/Xi8hMkMgQN5yrqdiEyO51xPL5up2PjhhXRjQK9rZ4Fd
         5wMRIAuUfya0Sz46LwlGH99ljcTtMOt0uagECMWIBCSoROmvgRVhdgqF6vbt08wyD63F
         Yv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+NsKRak4E6oWm24P8nfd/b8QFJedBnhyKM2Lb80NbQ=;
        b=KaFV6cAbBwFrTSl7D+F6YxF2j3iDhbHMbd6VjuSwE4SxQoUcOHDH90Q4Fv9DECYJPc
         xQ8jFQ+LpuAaO8UgswS9xhP7a5/IOLDvo/2iWMCGFA4atusmbv2ZAAWpYMZHSkSm1Y6L
         dqsz+aA5oCkJCulAjEdHTyFO5oHGLebau3ZJM1/QVojF5WfzdzpURnqBtY6BWCj3XF+y
         9jPNKDQ81jykQRcVAJgWcVxyiE43M23mjGWGpq8RdZVrdUJ5H8FutcJAltAjFDAM1ogO
         P4Vff2XkFXwgfw4tuR2GCX27ggfLiU9IZ4l+JnmEkTCoDx5yPvRuYEcoWdidl22SKCdS
         PEBQ==
X-Gm-Message-State: AOAM532882e8ocY0lrsSFRaVoSGKry/0+Y+LWGQ5k1YKAkZzzI3Y7ozd
        tFDj4AlWSCFEBE53iTAoFVlvGCAU2/PnKQ==
X-Google-Smtp-Source: ABdhPJy30CEMsQ57N4Xp6XjPaDKFT/2DjuF+9cPa7iac1tGwjKSK6SeCe2Wl/ugZp/Cz1m8he6YO3Q==
X-Received: by 2002:a5d:5143:0:b0:1ef:7e70:6677 with SMTP id u3-20020a5d5143000000b001ef7e706677mr3465929wrt.515.1645889937990;
        Sat, 26 Feb 2022 07:38:57 -0800 (PST)
Received: from build-server.fritz.box (p200300c56f4ead00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f4e:ad00:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0037c050d73dcsm10239054wmq.46.2022.02.26.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 07:38:57 -0800 (PST)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, ndb@nbd.name, johannes@sipsolutions.net,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH 0/2] mac80211: extend current rate control tx status API
Date:   Sat, 26 Feb 2022 16:38:41 +0100
Message-Id: <20220226153843.912-1-jelonek.jonas@gmail.com>
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
additional per packet information linke tx-power.

The commit 18fb84d986b3 introduced the extended on-stack struct
ieee80211_tx_status, which makes the tx status API more extensible.

With this patch we introduce a new struct ieee80211_rate_status that extends
current rate control tx status API further, in order to achieve:
(1)     receive tx power status feedback for transmit power control per
        packet or packet retry
(2)     dynamic mapping of wifi chip specifc multi-rate retry (mrr) chains
        with different lengths
(3)     increase the limit of annotatable rate indices to support
        IEEE802.11ax rate sets and beyond

(1) cannot be achieved with the use of struct ieee80211_tx_info because both
control and status buffer have a fixed SKB_CB size limit space. E.g. the
current control buffer size would only allow tx-power annotations per packet,
not per MRR chain. The status buffer has no free space left. Struct
ieee80211_tx_status is intended to add such extensions.

(2) is motivated by the varying length of mrr chains in common wireless
hardware supported by Linux. E.g. Atheros chipsets support four mrr chain
stages, mediatek chistrictions in rate configuration, retry count and tx-power
control ability.
Currently the number of mrr chain stages is fixed to 4 (defined by
IEEE80211_TX_MAX_RATES). Although this value could be increased, a change
would affect to all wireless drivers and probably cause additional problems.
Therefore we introduce a dynamic-sized solution that supports different
numbers of mrr chain stages hence a dynamic allocation of chain stages
supported by different wifi chipsets.

(3) The current struct ieee80211_tx_info uses a s8 integer for rate idx,
which would be to less for e.g. IEEE802.11ax rate annotations. To overcome
these limitation, we introduce struct rate_info from cfg80211.h. This struct
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

