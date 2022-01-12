Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3483848C5AF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353998AbiALOOV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354001AbiALOOI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:14:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC798C061748
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 06:14:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A814BB81EFA
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 14:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0129CC36AEA;
        Wed, 12 Jan 2022 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996844;
        bh=jvQ4RJX3cwgo9i2OaYEV0kZXeRMeyIimFbdYUVQeqxk=;
        h=From:To:Cc:Subject:Date:From;
        b=dXZdE+D+dZwgn8gw3g2SQERb51r1azVVC9IF/qhMhfDUNegwPvNbJSTc2JaIcr21M
         FhiscjY9HmaJ01g1X80Xv9WzcppQZffMYjPuv3Id301dLRMdeTWcvz1jHPrXAs676w
         tKgToxXrqZmLS9z5Ma0IelB66qL8usiVqFtLZOS3URrOi6FasJvnYVK2y0zIdwyhyM
         UsiD95HnMz3s90lPpG3st9Ce02a/3C8Fs2WMZuFSdDWuOCYiw7lcm/oF83RI5n/7X/
         ixJFVUUPPurmTZTvUSFIoHPJMDlvgZ57Rse2/aARSm2Yz6B7cCxQNpWCaNnIDCQLmZ
         oANMdWU7LSpew==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: [PATCH 0/6] introduce background radar support for mt7915 driver
Date:   Wed, 12 Jan 2022 15:13:47 +0100
Message-Id: <cover.1641996493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce radar/CAC background detection support for mt7915 driver
Background radar/CAC detection allows to avoid the CAC downtime
switching on a different channel during CAC detection on the selected
radar channel.

Lorenzo Bianconi (6):
  mt76: mt7915: introduce mt7915_set_radar_background routine
  mt76: mt7915: enable radar trigger on rdd2
  mt76: mt7915: introduce rdd_monitor debugfs node
  mt76: mt7915: report radar pattern if detected by rdd2
  mt76: mt7915: enable radar background detection
  dt-bindings:net:wireless:mediatek,mt76: add disable-radar-offchan

 .../bindings/net/wireless/mediatek,mt76.yaml  |   9 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  55 +++++++++-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  10 ++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  50 +++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 100 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  23 ++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   7 ++
 8 files changed, 253 insertions(+), 2 deletions(-)

-- 
2.34.1

