Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D902416F76
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbhIXJun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 05:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245345AbhIXJu2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 05:50:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5E6961076;
        Fri, 24 Sep 2021 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632476935;
        bh=CBHrpn9pv+Ege2emjmFDZoZvLzxMth9+ICVOybNkphY=;
        h=From:To:Cc:Subject:Date:From;
        b=GgQfLOdV1XDc/N7tVJWZFPY1QB2eMUd81h+I8nG1TTtsRgH1IaJz9/v4GA1LocFCr
         IJBn0n45fH+SjjJtZm2SUcIiwAR0HeHLKBUs+lsbVIoO3aQhE5SYSzRxWQUOnE3ww9
         +RPGOSzgDgUv1DwwvljhHx/XSw7aWjLh4dCbuo01HTTSvgyAUWnFny5CYUGtv7PBEM
         Xrkm23nTHEevPqv/046oxrWDYK8nq2MyIxxH/Wf/Z2vFPV10v0pHc782jV8A+RGAEH
         LjyUx6zWmjB0OLxE4GMR2W629HfxhwGppPsZu88lBv2v4hTSRT5saTrDRBn4EwlIW3
         zqPyxZ4ATV74Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH 0/2] introduce a dedicated mt7915 debugfs sub-dir for ext-phy
Date:   Fri, 24 Sep 2021 11:48:17 +0200
Message-Id: <cover.1632476677.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a dedicated mt76 debugfs sub-dir for ext-phy in dbdc mode for mt7915
driver. This is a preliminary series to add zero-wait dfs support.

Lorenzo Bianconi (2):
  mt76: rely on phy pointer in mt76_register_debugfs_fops routine
    signature
  mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy

 drivers/net/wireless/mediatek/mt76/debugfs.c  |  5 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 63 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  2 +-
 7 files changed, 45 insertions(+), 39 deletions(-)

-- 
2.31.1

