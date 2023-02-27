Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537466A418A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 13:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjB0MRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 07:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0MRi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 07:17:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064971A491
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 04:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D92960A26
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918BBC433EF
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677500257;
        bh=Vbv3yXAadM9f62NzLHhD8wEysJwGrAgIUPLoy0TdGAI=;
        h=From:To:Subject:Date:From;
        b=J9s180H7oY4KDiVAyuS8/F/QZ1f6Mc+2xPJ+VbKXpofem4u9ApbQAWFUvvMKZ1zH6
         hghEYmi21mPrTaW4ubPfpHgSfnPiNw+SpG+8BT6J1Elt+GOSnJG3uuJJqfWp2s59Zi
         eas4OfEKkq/eIve7Y5jXoHFlgbvYKoBrsST1dzKX/hYuYTfKpO4eb3dI4Ea8Hub+jt
         aa3LGNsEwtd1IR1TE63tm39KkqNImknSyPnGo0pe93j6+4E7QzNbkY6biNi91wRd53
         +P/PNZXlb5Tv/Rl/V4m5HPxpN9VPCTri4CHdBB5u9ZcSK109WoqmsT3t41fSpnIFAq
         5mDO0yBWWR3Gg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] wifi: create legacy and virtual directories
Date:   Mon, 27 Feb 2023 14:17:30 +0200
Message-Id: <20230227121732.8967-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The top-level directory drivers/net/wireless is cluttered with three old legacy
drivers and two virtual drivers. To make it faster to find the vendor
directories add new directories legacy and virtual and move the rest of the
drivers there.

Kalle Valo (2):
  wifi: move mac80211_hwsim and virt_wifi to virtual directory
  wifi: move raycs, wl3501 and rndis_wlan to legacy directory

 drivers/net/wireless/Kconfig                  | 75 +------------------
 drivers/net/wireless/Makefile                 | 11 +--
 drivers/net/wireless/legacy/Kconfig           | 55 ++++++++++++++
 drivers/net/wireless/legacy/Makefile          |  6 ++
 drivers/net/wireless/{ => legacy}/ray_cs.c    |  0
 drivers/net/wireless/{ => legacy}/ray_cs.h    |  0
 drivers/net/wireless/{ => legacy}/rayctl.h    |  0
 .../net/wireless/{ => legacy}/rndis_wlan.c    |  0
 drivers/net/wireless/{ => legacy}/wl3501.h    |  0
 drivers/net/wireless/{ => legacy}/wl3501_cs.c |  0
 drivers/net/wireless/virtual/Kconfig          | 20 +++++
 drivers/net/wireless/virtual/Makefile         |  3 +
 .../wireless/{ => virtual}/mac80211_hwsim.c   |  0
 .../wireless/{ => virtual}/mac80211_hwsim.h   |  0
 .../net/wireless/{ => virtual}/virt_wifi.c    |  0
 15 files changed, 88 insertions(+), 82 deletions(-)
 create mode 100644 drivers/net/wireless/legacy/Kconfig
 create mode 100644 drivers/net/wireless/legacy/Makefile
 rename drivers/net/wireless/{ => legacy}/ray_cs.c (100%)
 rename drivers/net/wireless/{ => legacy}/ray_cs.h (100%)
 rename drivers/net/wireless/{ => legacy}/rayctl.h (100%)
 rename drivers/net/wireless/{ => legacy}/rndis_wlan.c (100%)
 rename drivers/net/wireless/{ => legacy}/wl3501.h (100%)
 rename drivers/net/wireless/{ => legacy}/wl3501_cs.c (100%)
 create mode 100644 drivers/net/wireless/virtual/Kconfig
 create mode 100644 drivers/net/wireless/virtual/Makefile
 rename drivers/net/wireless/{ => virtual}/mac80211_hwsim.c (100%)
 rename drivers/net/wireless/{ => virtual}/mac80211_hwsim.h (100%)
 rename drivers/net/wireless/{ => virtual}/virt_wifi.c (100%)


base-commit: ec52d77d077529f198fd874c550a26b9cc86a331
-- 
2.30.2

