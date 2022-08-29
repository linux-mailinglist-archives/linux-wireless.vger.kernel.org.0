Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA265A4F7C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiH2OmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiH2OmB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:42:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA791D09
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs25so10491615wrb.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DhjREJDG3Lr2FBD5sQwmu2BRBBTKMPn9QJqgBhANq4Y=;
        b=qcd0PyG4HVohmBvfTqQnzay2ET3hLWhv1Joe+164A719a4cxfb7goTGBGMgdU2FH6s
         YEOEGeiY4roohpzD1pa+/PE1UipiFFmVc2ZwiszCRWY34hqG8o1z3wl/sxAlg+sOGUMR
         2F3qw192upxEViAIClaL67MSY4X+RdqPo+bzCxtQA1qUluKR8R27TPQowhWImclKwAJT
         HhxJ2L8+NdlIciFSOvmakz9ngBeZABG1QCcV72KxS7yTq60IAJlN6OW375SMkSDuLxcT
         sCMRxEdmRi56RAKhbKGy4MsowJLD5OlZkQD/YB1n3CHpqoB38ugeCQ8EQZSH90mqHIy+
         BH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DhjREJDG3Lr2FBD5sQwmu2BRBBTKMPn9QJqgBhANq4Y=;
        b=mleSCRvt1+dvAjQCx+pSlH92MtgPrp7NakzIIx5zfQdGYGRJdEvFpW20VVDA6Bnhc3
         /BTR8fZJ0sLUvtLPo4qFBcTBhmNyAu4qxJeb/ANRyPypg0yOIF0E1s83i5S16JXpxeiv
         K25MDUknDwaCbN8bUZTXFwki++r1dHISXH6GasLAn/555WxYTz2JpNFpib5bGJi8z77x
         20EXpBgqnlrAgC9L0CJVKfQsVPxZji3INmh+FPJIsy5ci1HvetfEQKA3rXTJQ0kHDRwD
         V8bX6xwaGnMUw0JI4W6yDLV6wwqNb50jC0Gi7p87ErtBEVbE6gOAcpSTxdi35EI5Fc8T
         ValQ==
X-Gm-Message-State: ACgBeo3aQ7E1We/ZaORdvHeFTwLpSdU1YqHHtuYUHbXlss7cjvr23rog
        n45c4vMOyprPraJVLLNakR6GXLGH8co=
X-Google-Smtp-Source: AA6agR5k63yFvr8daq+6u5i5X/q+OpffwifSsLYl54AZcOdjEAe+57AQbR2YdX3HVjcXobXf/sM+3A==
X-Received: by 2002:a5d:488c:0:b0:226:ded7:69f8 with SMTP id g12-20020a5d488c000000b00226ded769f8mr1555005wrq.418.1661784118585;
        Mon, 29 Aug 2022 07:41:58 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f18a600880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f18:a600:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id q3-20020a1ce903000000b003a61306d79dsm9398431wmc.41.2022.08.29.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:41:57 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC 0/4] mac80211: add TPC support in control path
Date:   Mon, 29 Aug 2022 16:41:43 +0200
Message-Id: <20220829144147.484787-1-jelonek.jonas@gmail.com>
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

Transmit power control (TPC) per packet hence per station can be used to
manage interference and increase overall spatial reuse and therefore
increases sum throughput in WiFi networks with multiple APs and STAs.
Although several of today's wifi chips, e.g., from QCA and from Mediatek
support fine-grained TPC per packet, the Linux mac80211 layer does not
provide support this annotation nor control yet.

This series proposes several changes to introduce TPC support in
mac80211, in particular to annotate tx-power per packet/per mrr stage in
the Tx control path.
The patches include new nembers in the Tx control path structs, a
modified tx-power level support annotation, hardware flags and an
utility function for the convenient use of struct ieee80211_rate_status
(introduced by 44fa75f207d8a106bc75e6230db61e961fdbf8a8) for tx-power
status report in drivers.

Compile-Tested: current wireless-next tree with all flags on
Tested-on PCEngines APU with ath9k WiFi device on OpenWrt Linux
        Kernel 5.10.137
I tested the tx-power annotation with an implementation of TPC in ath9k
(not included in this RFC) and small changes in minstrel_ht for debugfs
access. Tx-power status report in ath9k required the proposed utility
function in mac80211.

Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Jonas Jelonek (4):
  mac80211: modify tx-power level annotation
  mac80211: add tx-power annotation in control path
  mac80211: add hardware flags for TPC support
  mac80211: add utility function for tx_rate - rate_info conversion

 include/net/mac80211.h | 60 +++++++++++++++++++++++++++++++++++-------
 net/mac80211/debugfs.c |  2 ++
 net/mac80211/util.c    | 35 ++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 10 deletions(-)

-- 
2.30.2

