Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDD70122C
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbjELWaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELWaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 18:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6540ED
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 15:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADA50658CC
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 22:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDC1C4339B;
        Fri, 12 May 2023 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683930615;
        bh=ENaVh9GdmsvG1R+lZ1aYYQxPUOkcyHwdZpoWF3+zMb4=;
        h=From:To:Cc:Subject:Date:From;
        b=OYCVqupLA4C/wsRZhzrvAW7zlY18s+gdeNUsHWPMoOHnU6PkYyzpL+8u3y7G/s7Yi
         CaIff+2wyy+qdeUXn8+/nLOYho/wxLPIPrAVPJQ9By3bBlWfJWKBc5vgw8XUtydjTu
         n28CujL/0d2PcStBl06pZsQgrhmnEpwoDdax3WB+hu/3izWp59d1GdJ+7TNFpfUrPU
         PUYlNTCGDRdQoMli1w0kyxHE5bvbHUJY2dzt9jbT08IcmdoaSArrxXhMtajFnTEcQo
         ldHKXuFFyWsTrKD+YJX1O5Y+DBbhwPMgVqnQYzVmGQtBo8B8J3Hy1yhSpADam+8mrR
         2muX20Yl/ASrQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] wifi: mt76: move mib_stats structure in mt76.h
Date:   Sat, 13 May 2023 00:29:52 +0200
Message-Id: <cover.1683930235.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mib_stats structure in mt76.h and get rid of private drivers copy.

Lorenzo Bianconi (3):
  wifi: mt76: mt7915: move mib_stats structure in mt76.h
  wifi: mt76: mt7996: rely on mib_stats shared definition
  wifi: mt76: mt7921: rely on mib_stats shared definition

 drivers/net/wireless/mediatek/mt76/mt76.h     | 63 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 63 +------------------
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 31 +--------
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  4 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 56 +----------------
 13 files changed, 80 insertions(+), 161 deletions(-)

-- 
2.40.1

