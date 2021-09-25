Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87612418100
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbhIYK24 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Sep 2021 06:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234922AbhIYK2z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Sep 2021 06:28:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 952AF610EA;
        Sat, 25 Sep 2021 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632565641;
        bh=eggPwwc4vRWZk4I6mJCe9UVRMjT4UM7c46DaoIaR9dg=;
        h=From:To:Cc:Subject:Date:From;
        b=hWcoL7/9kx/1l2dwKHeu50FMFagop6aCZWn7+CSfInF2i2DgwAe+B+YsDij42l0Rn
         9HAMvMbXjWq8+jHGpcpAx55HcYt5SQ6OFRC1oictVoGfb0iaHk4svtns8k6mAWc1GU
         5GSfQWF6d+mk+D4Eh6Kene8RnO9oGo2C7ZcYOJc1drSV0eBcO4AADCIH0Y//jAza4i
         NRyJk3w4e/+UDJ7mZvi/lIN+sfgf06OqqquAfJUcCzHam6sYuedVc6SvGDQ91XpIIr
         0dZ77nAd7dZuYxUj0+8GserJQLqZPFphrzHobUhGainBH1DhfwyELl3H/+bg6BwPCk
         YXZn5GbI5IBBg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 0/2] introduce a dedicated mt7915 debugfs sub-dir for ext-phy
Date:   Sat, 25 Sep 2021 12:26:56 +0200
Message-Id: <cover.1632565435.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a dedicated mt76 debugfs sub-dir for ext-phy in dbdc mode for mt7915
driver. This is a preliminary series to add zero-wait dfs support.

Changes since v1:
- rebase on top of mt76 master

Lorenzo Bianconi (2):
  mt76: rely on phy pointer in mt76_register_debugfs_fops routine
    signature
  mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy

 drivers/net/wireless/mediatek/mt76/debugfs.c  |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   4 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |   2 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 159 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   6 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |   2 +-
 7 files changed, 94 insertions(+), 86 deletions(-)

-- 
2.31.1

