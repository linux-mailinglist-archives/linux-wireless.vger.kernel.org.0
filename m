Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2F366960
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhDUKob (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhDUKoa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:44:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D007A61440;
        Wed, 21 Apr 2021 10:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619001837;
        bh=NexHP4miQbFJEgMAFGGCvdMLJK3x+JD4kXUlmDt1o+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=lH46GEYFLnM/coevyIADoWgrRY5ZMHtpeBujMvdyiAeEgGb2pPH/p7oXSnf7jNWxW
         8J0olVOZvkK8lY7JwoTBLOXAd/ux2ocPZcIPLgjPqGeYt7e99a7bnSs7NX0B1vTJuz
         eEwMat8/RPE/4YzM9cLB3EBQQur+ZObVSqC4d657zasD2ZY6v2cgA1VFPqYM34y6Rx
         oSg8ZoiQIYOEZn+G3IIc/toOOd2Dl/YIw2bbHfai5rB8XvWqnMvESPl3QBZ24j9O0W
         5KBErbgflUrKLsYnb4sDwfy6qUWrGfJw5EO8NPzVgte0CUlKBphHAkKSMllRyAkQe2
         MQ8FB8ORX7McA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 0/4] improve runtime-pm support for mt7663/mt7921
Date:   Wed, 21 Apr 2021 12:43:47 +0200
Message-Id: <cover.1619001617.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is the second series to fix/improve runtime-pm support for mt7663/mt7921
chipsets.
This series is based on the series below:
https://patchwork.kernel.org/project/linux-wireless/list/?series=469235

Lorenzo Bianconi (3):
  mt76: mt7921: improve doze opportunity
  mt76: mt7663: add awake and doze time accounting
  mt76: connac: unschedule mac_work before going to sleep

Sean Wang (1):
  mt76: mt7921: mt7921_stop should put device in fw_own state

 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 32 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 24 +++++++++++---
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  6 ++--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  6 ++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 7 files changed, 63 insertions(+), 11 deletions(-)

-- 
2.30.2

