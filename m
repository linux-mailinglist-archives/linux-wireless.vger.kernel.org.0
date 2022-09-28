Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C255ED8BB
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 11:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiI1JUC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiI1JUB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 05:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CB3FA1B
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 02:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE5B61DD8
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 09:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2440DC433D6;
        Wed, 28 Sep 2022 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664356793;
        bh=8L80Xj1FiutXYpNFzbgGiYF33cS8E/iW8AXgctuYFnk=;
        h=From:To:Cc:Subject:Date:From;
        b=Y3XhRyuAi84P9mK8NAl1qdZaq2LO34xmYFoU9aUtIqaKpKaLGW8pzrFG+eqB6wREd
         5Wz+DXIk37mu6fyLQ3KLLWqvI6sSAhKmNC9o//sUOjoI9AZD8CTOoDiJSsQCiSrlgY
         ARkhbQo7IcPEt8hbh44dM7RYptE1yQ9XBjwQm/y3kc9ub4gxabQE654O9b0NeRqSo0
         n6GUOjHiS/j/Eb6lMfxFM11lLUI7uwzDlADFmgxZJo/HZgK3bxfP0lZZJOtWOgG9Pp
         t1PnyioSLxowyuBAM0HobD1XULF/NCUBxEDlzp+knbrMh79jZkGWL5L83Rm8VW6Pzs
         43mJr9sE5p1wQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, ryder.Lee@mediatek.com,
        evelyn.tsai@mediatek.com, daniel@makrotopia.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] wifi: mt76: introduce WED TX support for mt7986 SoC
Date:   Wed, 28 Sep 2022 11:19:40 +0200
Message-Id: <cover.1664356281.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable WED TX support for mt7915 and mt7986-wmac drivers running on MT7986 SoC.
This is series is based on the following net-next series not merged yet in
wireless-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=377c17c6757ccf43e97f681a6ac5163d3735ab0a

Lorenzo Bianconi (3):
  wifi: mt76: mt7915: move wed init routines in mmio.c
  wifi: mt76: mt7915: enable wed for mt7986 chipset
  wifi: mt76: mt7915: enable wed for mt7986-wmac chipset

 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  75 +++++++---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 135 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  93 +-----------
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  13 ++
 .../net/wireless/mediatek/mt76/mt7915/soc.c   |  21 ++-
 8 files changed, 222 insertions(+), 121 deletions(-)

-- 
2.37.3

