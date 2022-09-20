Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0493F5BE38F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiITKmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiITKlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 06:41:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20CBE8
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so799111wmb.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EZdN8DP0TEBsw0gymjqjo0ReqMrvDok41gT3lMT56+8=;
        b=FhzpppJP2E8xQNmqRlvSVTEmncLXyb4Imy/Xmrgg85MgU9QDD5jbi341hsPBxTE7g6
         NCmy/75BvUXUi0oEWE+J8xd4aYTPktLGenUSFsTSpxwXgQQbNe4p/A6CbJcpStrAZfaf
         a84sk5RYjrrThtIV4swpK+WIXvXTWUdq72UJqKlNqfMwC0HFu+YTbXEH8ys/cuGQHHKp
         Ag+w/udSkIRxqV6CUujcAnqR/2Pe59qukMY9Z4JqM6jRyFU/LDm1otpqRxGuk9/8yUWR
         v+K4HxnETf/v7emfoXsvBuDG/IQmtsDGuaLdaSWS4MJTbvYL81e3Xmxd+yyPFeFoTYI8
         GplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EZdN8DP0TEBsw0gymjqjo0ReqMrvDok41gT3lMT56+8=;
        b=p3ek8S91KBK24Xlw+ofnvy9QvdcvuJyIs0BzB5etNoSe+ULgXhMpIf4sE5+vDgNrG+
         sskMRnLHJEk5YGyNyj0k5K03P4c7GBUsuXKw+Kt6MOtlIp5AvyRE8uX2OCj8hXkN1eh4
         tk7DXadX9JSVGlaq2ltcejBHVs0CLE6H21uAeXRs9WTysous7/DUjR32Awu/oDXtCPor
         KYVKuxEySFFK8oRYr+WLCk4jMde4deQP3YOhBO2OBO3lWZjZtsCcZTKrTLIWRWfyklCd
         6wgMH0lMfwLotTbcYBE3VfwscPYOpyDtVe2RoHdVBzi/na6Mf9Ksmvzml2VIGFX3fagE
         KtAA==
X-Gm-Message-State: ACrzQf0R7xhDeqcW1ZeptlOKGVEkDBjRBdEsAVG5QGHXHIGjvWb5krH0
        JVwBnb5hxBUf2pNl+8QY4plBDw6PwG/zag==
X-Google-Smtp-Source: AMsMyM6CCuHQ5vhKbPjDJ4Q9R3opFg6jGLdDJQmfkVHKIJ20H91llmgTbyttO9g+W2+01mckfRZM0A==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr1915663wmb.146.1663670450050;
        Tue, 20 Sep 2022 03:40:50 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f1d4500880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f1d:4500:880d:3dff:fede:fb04])
        by smtp.googlemail.com with ESMTPSA id o2-20020a05600c4fc200b003a5fa79007fsm2182018wmq.7.2022.09.20.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:40:49 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [RFC v2 0/6] mac80211: add TPC support in control path
Date:   Tue, 20 Sep 2022 12:40:26 +0200
Message-Id: <20220920104032.496697-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Transmit power control (TPC) per packet hence per station can be used to
manage interference and increase overall spatial reuse and therefore
increases sum throughput in WiFi networks with multiple APs and STAs.
Although several of today's wifi chips, e.g., from QCA and from Mediatek
support fine-grained TPC per packet, the Linux mac80211 layer does not
provide support for this annotation nor control yet.

This series proposes several changes to introduce TPC support in
mac80211, in particular to annotate tx-power per packet/per mrr stage in
the tx control path.
The patches include new members in the tx control path structs, a
modified tx-power level support annotation, hardware flags, hwsim
support, debugfs support in minstrel_ht for fixed TPC and an utility
function for the convenient use of struct ieee80211_rate_status
(introduced by 44fa75f207d8a106bc75e6230db61e961fdbf8a8) for tx-power
status report in drivers.
An proof-of-concept ath9k support was implemented for testing these
changes on real ath9k hardware, this implementation is planned to be
brought upstream later.

Compile-Tested: current wireless-next tree with all flags on
Tested-on: PCEngines APU with ath9k WiFi device on OpenWrt Linux
	Kernel 5.15.68, AP<->STA setup with both ath9k and hwsim
	(used current OpenWrt testing kernel)

---
v2:
- added exemplary hwsim support
- added debugfs in minstrel_ht for fixed TPC
---

Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Jonas Jelonek (6):
  mac80211: modify tx-power level annotation
  mac80211: add tx-power annotation in control path
  mac80211: add hardware flags for TPC support
  mac80211: add utility function for tx_rate - rate_info conversion
  mac80211_hwsim: add TPC per packet support
  mac80211: minstrel_ht - add debugfs entry per sta for fixed tx-power

 drivers/net/wireless/mac80211_hwsim.c      | 175 ++++++++++++++++++++-
 drivers/net/wireless/mac80211_hwsim.h      |   1 +
 include/net/mac80211.h                     |  66 ++++++--
 net/mac80211/debugfs.c                     |   2 +
 net/mac80211/rc80211_minstrel_ht.c         |  14 ++
 net/mac80211/rc80211_minstrel_ht.h         |  11 ++
 net/mac80211/rc80211_minstrel_ht_debugfs.c |  11 ++
 net/mac80211/util.c                        |  35 +++++
 8 files changed, 296 insertions(+), 19 deletions(-)

-- 
2.30.2

