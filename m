Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D1689270
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 09:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjBCIiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 03:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBCIiN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 03:38:13 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05842ED5B
        for <linux-wireless@vger.kernel.org>; Fri,  3 Feb 2023 00:38:10 -0800 (PST)
Received: (qmail 21165 invoked from network); 3 Feb 2023 08:38:08 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 3 Feb 2023 08:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=2018; bh=5gzfbHktKF+FWt0viMzIrFRdh
        S69aRKSaTvqnSftuGo=; b=XwzvZdVp9AwXvjXTQfNJpfOUeJirBmYwc46OWPJEz
        33lQxADYJzBJ2rRdKzGDn6tv6vBUtLnTq1TM7j8+2z21Pl/G3ljQVXpht8t4qD5S
        5G/CR/MVm91FwPE45AxF42786KHtaMw7e1v2l3ChfV7RsowcFAtpmME35jvrb9oe
        b4=
Received: (qmail 35399 invoked from network); 3 Feb 2023 08:38:08 -0000
Received: by simscan 1.4.0 ppid: 35085, pid: 35391, t: 1.0775s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 3 Feb 2023 08:38:06 -0000
From:   equu@openmail.cc
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        equu@openmail.cc, kernel test robot <lkp@intel.com>
Subject: [PATCH v4 0/3] PCI: of: Load extra data only from compatible DT nodes
Date:   Fri,  3 Feb 2023 16:37:28 +0800
Message-Id: <20230203083731.349695-1-equu@openmail.cc>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
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

V3 -> V4:
1, Fix some syntax errors.

Signed-off-by: Edward Chow <equu@openmail.cc>
Reported-by: kernel test robot <lkp@intel.com>

Edward Chow (3):
  PCI: of: Match pci devices or drivers against OF DT nodes
  wifi: ath9k: stop loading incompatible DT cal data
  wifi: ath10k: only load compatible DT cal data

 drivers/net/wireless/ath/ath10k/core.c |  29 +++
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
 11 files changed, 446 insertions(+), 7 deletions(-)

-- 
2.39.1

