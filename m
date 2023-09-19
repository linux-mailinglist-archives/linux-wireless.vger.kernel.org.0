Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26F7A5886
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 06:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjISEt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 00:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjISEt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 00:49:28 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7EFC110F;
        Mon, 18 Sep 2023 21:49:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 8907F602F96E1;
        Tue, 19 Sep 2023 12:48:57 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com, jirislaby@kernel.org,
        mickflemm@gmail.com, mcgrof@kernel.org, toke@toke.dk,
        afaerber@suse.de, mani@kernel.org, chunkeey@googlemail.com,
        loic.poulain@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     johannes.berg@intel.com, syoshida@redhat.com,
        alexander@wetzel-home.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, wcn36xx@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH v2 wireless-next 0/9] Remove unnecessary (void*) conversions
Date:   Tue, 19 Sep 2023 12:48:33 +0800
Message-Id: <20230919044832.522947-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove all unnecessary (void*) conversions under the directory drivers/net/wireless/ath.

Changes in v2:
 - fix file path error in v1 patch 
 - change the prototype to remove the local variable(Jeff Johnson's suggestion.)[1]

[1] https://lore.kernel.org/all/5bb164e7-c147-64d1-031d-0ba20cfffa77@nfschina.com/

Wu Yunchuan (9):
  wifi: ar5523: Remove unnecessary (void*) conversions
  carl9170: remove unnecessary (void*) conversions
  wifi: wcn36xx: remove unnecessary (void*) conversions
  wifi: ath5k: remove unnecessary (void*) conversions
  ath6kl: remove unnecessary (void*) conversions
  wifi: ath10k: Remove unnecessary (void*) conversions
  wifi: ath12k: Remove unnecessary (void*) conversions
  wifi: ath11k: remove unnecessary (void*) conversions
  wifi: ath9k: Remove unnecessary (void*) conversions

 drivers/net/wireless/ath/ar5523/ar5523.c      |  2 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c      | 16 ++++-----
 drivers/net/wireless/ath/ath11k/dp.c          |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c       | 13 +++----
 drivers/net/wireless/ath/ath11k/hal.c         |  8 ++---
 drivers/net/wireless/ath/ath11k/hal_rx.c      | 17 ++++-----
 drivers/net/wireless/ath/ath11k/hal_tx.c      |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  4 +--
 drivers/net/wireless/ath/ath11k/spectral.c    |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  6 ++--
 drivers/net/wireless/ath/ath12k/dp_mon.c      |  9 ++---
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c       |  5 ++-
 drivers/net/wireless/ath/ath5k/base.c         |  4 +--
 drivers/net/wireless/ath/ath5k/pci.c          |  4 +--
 drivers/net/wireless/ath/ath6kl/main.c        |  4 +--
 drivers/net/wireless/ath/ath6kl/txrx.c        |  2 +-
 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c |  2 +-
 drivers/net/wireless/ath/ath9k/common-init.c  |  2 +-
 .../net/wireless/ath/ath9k/common-spectral.c  |  2 +-
 drivers/net/wireless/ath/ath9k/debug.c        |  2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c      | 10 +++---
 .../net/wireless/ath/ath9k/htc_drv_debug.c    |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 36 +++++++++----------
 drivers/net/wireless/ath/ath9k/htc_hst.c      |  2 +-
 drivers/net/wireless/ath/ath9k/init.c         | 12 +++----
 drivers/net/wireless/ath/ath9k/link.c         |  2 +-
 drivers/net/wireless/ath/ath9k/pci.c          |  6 ++--
 drivers/net/wireless/ath/carl9170/usb.c       | 10 +++---
 drivers/net/wireless/ath/wcn36xx/dxe.c        |  6 ++--
 drivers/net/wireless/ath/wcn36xx/smd.c        | 20 +++++------
 drivers/net/wireless/ath/wcn36xx/testmode.c   |  2 +-
 32 files changed, 101 insertions(+), 117 deletions(-)

-- 
2.30.2

