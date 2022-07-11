Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2556D259
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiGKBIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGKBIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:08:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC92A47D
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:08:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 5so3183107plk.9
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/41UlKQKx9NDMQjTETKiMHddFQC+LRRYf3LFL7cwKQ0=;
        b=dwXJrSfz0TCr4q+pGPuMfTIyyG1ITOASVlvS9RlWgUeGGL7hIdoBM3EGO1AkhGXYJh
         h2Bey4MQMOU29VYRekzZBNsJHZET0ivByc+OUWbCnFVpq7NYtyMP8z/RTZbCEdqDQJQw
         wlsmVRZinAV/2hxwEvmuit3/PVHuG8+dOVhjU4EQyQioO+SSlOFJVOjDuyWZHOJtl3uj
         ydXUNkcr/pi2zdD5Q8iK7dXFNMfhE4IQ69mJlZUQeLvA/3fAUPBZCyAJuUkYWYXwKXKL
         HlH3/iCkjbjwHnHqKlosV2X7of8K5KTnHgcTwH+2pePhIFz21GGZ70ISxnSTPy6o9dg0
         FRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/41UlKQKx9NDMQjTETKiMHddFQC+LRRYf3LFL7cwKQ0=;
        b=a8kR+gRkF08vkL0d7hX1s3EXMPL64hEnxKjv42EV9FmZPVG4Nb5L8JUNb3h+jYNX2R
         mY2EGIYNKigs7pflww3Nn3L8IjbjV89wuFezhG2lrmJSfm5AJcB8u+DoHb6lIIuzd+Nb
         aiuS65dCKDaDmct+aLchKEuS2nrCgOvVO8l1VuXmOPWiEWSoCkBk2cGRyL8td/ZIUZLt
         qW3GhPrOvRh6r4WWTR4e3nD+F9R/v9HiA5eQOy1FxX9MYx0aZp/XBX4VX1xuxNEGF6OY
         OU4zWzfcqMWXrb6O7I8bJ9xpzGN6Ll4DskOR/n5G0t24bGdVvuiKds48jAoPYkM5Y2cK
         icgw==
X-Gm-Message-State: AJIora/srhcvkMjNICGk5A5FNkPdmKqcSXQe0Lx/+Os+ZSfsp4xspJat
        FayyFUCQqsXBZG+mAsDmE5g8TKsomNk5bCvh
X-Google-Smtp-Source: AGRyM1sOOajwD6CDUAoaoIXkIobxBBG1VWHO+rKILdeQdxiAXl5AXaf5bfvKGdFmuQmUL4p1r/UxwA==
X-Received: by 2002:a17:903:41c7:b0:16c:4e4c:7440 with SMTP id u7-20020a17090341c700b0016c4e4c7440mr1472306ple.169.1657501733232;
        Sun, 10 Jul 2022 18:08:53 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:08:52 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH 00/12] Additional support for 802.11ah (S1G)
Date:   Mon, 11 Jul 2022 01:08:04 +0000
Message-Id: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
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

This patchset builds on the work down by Thomas Pedersen to add further
support for 802.11ah in cfg80211 and mac80211. The ultimate goal is
to enable the successful starting of an AP on 802.11ah using 802.11ah
terms by implementing the various features that are required by the
AP. The features are split into their own commits, please see those
patches for more details.

The patchset has been tested on both real hardware (Morse Micro MM610x)
and mac80211_hwsim, in AP and STA modes. Basic regression testing was
performed on 802.11n with mac80211_hwsim by starting an AP and having a
STA interface connect to it.

802.11ah features/support missing:
 - Rate control integration
 - Regulatory database updates (only US regulatory information exists)
 - Optional 802.11ah (S1G) features such as RAW, TWT and AID grouping

Kieran Frewen (12):
  cfg80211: regulatory: extend regulatory support for S1G
  mac80211: update TIM for S1G specification changes
  mac80211: S1G beacon/short beacon support
  nl80211: support setting S1G short beacon period
  nl80211: support advertising S1G capabilities
  mac80211: support ieee80211_ext format
  mac80211: S1G capabilities information element in probe request
  cfg80211: S1G rate flags
  nl80211: support advertising S1G rate information
  mac80211: support S1G rate encoding.
  cfg80211: support for calculating S1G bitrates
  mac80211_hwsim: support for S1G rate information

 drivers/net/wireless/mac80211_hwsim.c |  40 +++-
 include/net/cfg80211.h                |  16 +-
 include/net/mac80211.h                |  33 ++-
 include/uapi/linux/nl80211.h          |  27 +++
 net/mac80211/cfg.c                    |  43 +++-
 net/mac80211/ieee80211_i.h            |   1 +
 net/mac80211/rx.c                     |  32 ++-
 net/mac80211/sta_info.c               |   7 +
 net/mac80211/sta_info.h               |   7 +
 net/mac80211/tx.c                     |  27 ++-
 net/mac80211/util.c                   |  67 +++++-
 net/wireless/nl80211.c                |  37 ++++
 net/wireless/reg.c                    |  50 +++--
 net/wireless/reg_s1g.h                | 281 ++++++++++++++++++++++++++
 net/wireless/util.c                   | 144 ++++++++++++-
 15 files changed, 758 insertions(+), 54 deletions(-)
 create mode 100644 net/wireless/reg_s1g.h

-- 
2.25.1

