Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E0068745A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Feb 2023 05:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBBETA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 23:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBBESo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 23:18:44 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F53D903
        for <linux-wireless@vger.kernel.org>; Wed,  1 Feb 2023 20:18:37 -0800 (PST)
Received: (qmail 25534 invoked from network); 2 Feb 2023 04:18:35 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 2 Feb 2023 04:18:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=2018; bh=WBmp0YX/hZCszTpsY1kNZEHJ5
        l7sy/Ei1QfsPfN2/V8=; b=lZGxXfGqLHkxQi5tSmSPJIVUKfN2fojixhOzmP3iv
        Bx60yT/pgIb226W+zneoJoPt+JJgussl1r9kHrCRnqoL7y0tg7jc9SiM1Dkn8tUt
        Ey1A/9k0P29VM6DbKiiw9vz/7yDYMHiAk2VggYLgQXA1AWZnztPCAGpOiKFK1v5W
        MI=
Received: (qmail 74567 invoked from network); 2 Feb 2023 04:18:34 -0000
Received: by simscan 1.4.0 ppid: 74492, pid: 74551, t: 1.0706s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 2 Feb 2023 04:18:33 -0000
From:   equu@openmail.cc
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        equu@openmail.cc
Subject: [PATCH v2 0/3] PCI: of: Load extra data only from compatible DT nodes
Date:   Thu,  2 Feb 2023 12:18:20 +0800
Message-Id: <20230202041823.2879262-1-equu@openmail.cc>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Edward Chow <equu@openmail.cc>

In order to solve the issue reported in
https://github.com/openwrt/openwrt/pull/11345 , this patchset attempt
to add mechanisms to ckeck whether an OF DT node is compatible to the
PCI device installed on the corresponding location or the driver for
it, and make ath9k and ath10k only load extra data from compatible
nodes.

V1 -> V2:
1, Update commit messages and comments, minor improvement on code

2, Update commit messages and comments.

3, Update commit messages and comments.

Signed-off-by: Edward Chow <equu@openmail.cc>

Edward Chow (3):
  PCI: of: Match pci devices or drivers against OF DT nodes
  wifi: ath9k: stop loading incompatible DT cal data
  wifi: ath10k: only load compatible DT cal data

 drivers/net/wireless/ath/ath10k/core.c |  28 +++
 drivers/net/wireless/ath/ath10k/pci.c  |   2 +-
 drivers/net/wireless/ath/ath10k/pci.h  |   2 +
 drivers/net/wireless/ath/ath9k/ath9k.h |   1 +
 drivers/net/wireless/ath/ath9k/init.c  |  26 +++
 drivers/net/wireless/ath/ath9k/pci.c   |   2 +-
 drivers/pci/of.c                       | 299 +++++++++++++++++++++++++
 drivers/pci/pci-driver.c               |   5 -
 drivers/pci/pci.h                      |  56 +++++
 include/linux/of_pci.h                 |  25 +++
 include/linux/pci.h                    |   6 +
 11 files changed, 445 insertions(+), 7 deletions(-)

-- 
2.39.0

