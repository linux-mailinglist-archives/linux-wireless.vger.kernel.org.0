Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EEF51A596
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353491AbiEDQg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353485AbiEDQg4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC046B0F
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DB5E61712
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 16:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70453C385A5;
        Wed,  4 May 2022 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651681999;
        bh=cXXorQrMkkkeV2i5726p7Z821ZxQbQOvtmceDVvhp+w=;
        h=From:To:Cc:Subject:Date:From;
        b=Emrx/oNL4g3KDjNJVUQ5N3n8lfO7jjWfcAItq0AZq0gO9LxML313Z95jFYFVRBU37
         TRQePMgQh++GvLP0I3FJgMv/2QJFwXlNbuNwX2+pvqPm06C6ajFdZrsV8kQl3pLXhp
         dmLIEJffM+xdNN+GiYNb8ZpAiYhlV4cuEsGvQ9cT68lXFan/pMrYXVsf0v9yT/Eke6
         aqN4MHK10pBBSugN45NiPGMoMBqLjrLh38P6n45112PGUvkiBl0QgLJzswnfF4D8c8
         EZmllA8fZD1/os7+208LGZiTk5XhBusmzGUrtDrBlGS+vGt6nrPR2MLsKamPl4m1Hf
         tx+F3vkOLBgiA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH wireless-next 0/3] wifi: netif_napi_add() conversions
Date:   Wed,  4 May 2022 09:33:13 -0700
Message-Id: <20220504163316.549648-1-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert wifi callers to the new netif_napi_add() APIs.

The callers passing 64 or NAPI_POLL_WEIGHT to the non-Tx flavor
are left alone. I'm planning to include wifi drivers in the massive
tree-wide patch/series which will drop the last argument from
netif_napi_add(). Alternatively I can switch all of wifi to
netif_napi_add_tx_weight() and back after the netif_napi_add()
change makes its wait into wireless-next.
Please LMK if you prefer that.

Jakub Kicinski (3):
  wifi: wil6210: switch to netif_napi_add_tx()
  wifi: mt76: switch to netif_napi_add_tx()
  wifi: qtnfmac: switch to netif_napi_add_weight()

 drivers/net/wireless/ath/wil6210/netdev.c              | 10 ++++------
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c        |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c        |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c      |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c        |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c        |  4 ++--
 .../net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   |  4 ++--
 .../net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |  4 ++--
 8 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.34.1

