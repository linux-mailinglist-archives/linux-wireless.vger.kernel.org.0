Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7125C3F288F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 10:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhHTIia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 04:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhHTIi3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 04:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 476E8610E6;
        Fri, 20 Aug 2021 08:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629448672;
        bh=EpKuWnMmWYbqHhMcPfdUHs4BDd/K9pKTMJyPpETs0h0=;
        h=From:To:Cc:Subject:Date:From;
        b=Tpm/oP9k8a0TSZyU+AA78XzCh9TqN6XCBUEHka4NFH0vGIvHQ/fcN/58Zc4cg3Vkz
         mfsgaBof9iDUXhNZ6N9sAjGNxBCS9WbVe6V12zHzvTWsNRB3mq43aQEMqie6W0jH0N
         ZYPTOmjn4rNDjDuA9jOV26YirjRP0djJEJrFFFkN7uq19i5Sy0id7XVC3rBiP70WA7
         P9kdnJuYsFmjdR8+aD9nzlRhLomXX8LKew2SCWQyt0EcwuRSWJ8ZzFW+ZmD9TNxkMF
         /WEEedzf7oZ+BAp2YGWFim2y9ZNedZ8q+9L9C6EShfQSv/oupESY9WQUarmBmscGOi
         Ir1DBNeDoYjeQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v3 0/5] add tx status reporting to mt7921 driver
Date:   Fri, 20 Aug 2021 10:37:40 +0200
Message-Id: <cover.1629448559.git.lorenzo@kernel.org>
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

Changes since v2:
- remove magic numbers and introduce definitions for them

Changes since v1:
- fix rate flags in mt7921_mac_sta_poll() for ht rates

Lorenzo Bianconi (5):
  mt76: mt7921: start reworking tx rate reporting
  mt76: mt7921: add support for tx status reporting
  mt76: mt7921: report tx rate directly from tx status
  mt76: mt7921: remove mcu rate reporting code
  mt76: mt7921: remove mt7921_sta_stats

 .../net/wireless/mediatek/mt76/mt7921/init.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 368 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  20 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  28 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 133 -------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  47 ---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  21 +-
 7 files changed, 292 insertions(+), 326 deletions(-)

-- 
2.31.1

