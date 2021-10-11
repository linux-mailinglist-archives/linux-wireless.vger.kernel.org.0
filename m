Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0215C428AD6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhJKKkq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhJKKkp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:40:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E795B60E54;
        Mon, 11 Oct 2021 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633948725;
        bh=UMJ7ASTuKEwkKpOZEU4PB74SUzkIEKxXfyR3Cy0vOKM=;
        h=From:To:Cc:Subject:Date:From;
        b=ubW5MrKWC/NOaZCHYgrRJDmygbr2QZPHvWsxaNgd4U6CgwAYBpH/pdR9Wc+7+7qHf
         5XcBG7hRwxx4/Q4MbJzRzo+oeVDaYmiZdPzncnJMFgN1Dhu9BZJgLlwhNYu4a0vcj9
         yZk3zKbezHLdN1y4TT5fMcdbKF0PWnxNxOYY3UEWMTKABu1vyqvo/gYUXnsE9RqaLl
         AmEzu3rIBKo4QXLMX9L8iQuNk3Q4RfjI1qnmOtrXcKEgvA0NbvVL2kOWBk3MCsj031
         hd4KbVzQyzJoVYspn0WYz5wBbpIrW6e4awoOJbH6SC7xxgjwMbDtvJsjDMjeB1NdQO
         osr+ehTPuSnvA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v3 0/3] introduce a dedicated mt7915 debugfs sub-dir for ext-phy
Date:   Mon, 11 Oct 2021 12:38:26 +0200
Message-Id: <cover.1633948549.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a dedicated mt76 debugfs sub-dir for ext-phy in dbdc mode for mt7915
driver. This is a preliminary series to add zero-wait dfs support.

Changes since v2:
- rebase on top of mt76 master
- add patch 3/3

Changes since v1:
- rebase on top of mt76 master

Lorenzo Bianconi (3):
  mt76: rely on phy pointer in mt76_register_debugfs_fops routine
    signature
  mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy
  mt76: mt7915: improve code readability for xmit-queue handler

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

