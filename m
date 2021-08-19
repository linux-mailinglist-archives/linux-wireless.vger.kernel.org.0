Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFAA3F1537
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhHSIdC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 04:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237185AbhHSIdB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 04:33:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2944C610FA;
        Thu, 19 Aug 2021 08:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629361945;
        bh=+AAObEjMIRTJImIgDgXmA1crtVBMnTcnxYJDm392mZo=;
        h=From:To:Cc:Subject:Date:From;
        b=CuxYcMACdkS6r5OMSlqnrkzklGTDNhT0z3LYGg/ja/K1W292odPwdvFS+n5mXzZTc
         dWHh7kS3xsao4ZW/ySs+yIFo4vNkT1DR90IMyOsXO3Yr8ziyDntr20bsUjZzKHZbGg
         DIMl/cWMwDHuP9fd5SypUe7ypc4wwdy5aUrl/HKgdtJTf0fHeY8p/3cNBX+XbV8DGk
         8y9rduARZcx8yxIREgo1fEUmT9psy5H/B2FYdr9hw3SxRoLCacwGdm0K7iHINjLccD
         89GbpMZG2hS3LcSM/KQFC7hGMOr5ceUgCybdgPpHoD3kUhtqmquA4M+UhL088K10sU
         ZdkSsT3+LUD2Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v2 0/5] add tx status reporting to mt7921 driver
Date:   Thu, 19 Aug 2021 10:32:00 +0200
Message-Id: <cover.1629361688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report tx rate from tx status packets instead of receiving periodic mcu
event. This improves flexibility, accuracy and AQL performance, and
simplifies code flow for better readability.
Add some code cleanup

Changes since v1:
- fix rate flags in mt7921_mac_sta_poll() for ht rates

Lorenzo Bianconi (5):
  mt76: mt7921: start reworking tx rate reporting
  mt76: mt7921: add support for tx status reporting
  mt76: mt7921: report tx rate directly from tx status
  mt76: mt7921: remove mcu rate reporting code
  mt76: mt7921: remove mt7921_sta_stats

 .../net/wireless/mediatek/mt76/mt7921/init.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 365 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   9 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  28 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 133 -------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  47 ---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  21 +-
 7 files changed, 279 insertions(+), 325 deletions(-)

-- 
2.31.1

