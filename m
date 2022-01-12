Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2B48CA6E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 18:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355824AbiALRyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 12:54:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47570 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355808AbiALRyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 12:54:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CA52B8202A;
        Wed, 12 Jan 2022 17:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D3CC36AEA;
        Wed, 12 Jan 2022 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010053;
        bh=swqsQNuYek3FepMXDWC6pnHvlm5lcDio8s4og0woaT4=;
        h=From:To:Cc:Subject:Date:From;
        b=tK7nzYOSWYMLAGjJa4S8Dab2Y2Pe8aQGAcjbqpeQVWJ1+Z3kybZcT5xX5mawcGK8U
         KYtNn89YofUDy0rcTUBFyCAdHKrVXopzUDwIL0lsXx+qgviArh7PbCczBZi16T9umQ
         QJyPRPEWtO+8ysHzIJfGFlhVItRmXDceneBOcwiuMayvW10xjVcriaUt0bfu3bT2Bb
         xkZlAAMRVg4Jj3bXquop9lHqIpfk0k8+0W7eOQf6iXMupFPLVIACzYL4cwLPg64liZ
         kSeyW3bqeN+aPc3W+YIo/QY+CnAaijLn/dgN/qJSTiXcO1Zif/EE982ZE/GHQ40zkC
         sbxO0J/vKQY5A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com, devicetree@vger.kernel.org, robh@kernel.org
Subject: [PATCH v2 0/6] introduce background radar support for mt7915 driver
Date:   Wed, 12 Jan 2022 18:53:49 +0100
Message-Id: <cover.1642009736.git.lorenzo@kernel.org>
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

Changes since v1:
- repost adding devicetree ml in cc

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

