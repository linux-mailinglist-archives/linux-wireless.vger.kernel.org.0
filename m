Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84DA3F0007
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 11:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhHRJK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 05:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhHRJKz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 05:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FF7D6103A;
        Wed, 18 Aug 2021 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629277819;
        bh=FUetz0LLpB84WuiuwWiNbghoL59ODuuLsMcql9VxFyY=;
        h=From:To:Cc:Subject:Date:From;
        b=fG4M1iMKzBN+k8CSfoZDZNqEY8x8/H+CX/7YIa19AcAfSw41T/qiGJy996w2HBCNy
         YDdloSYGcaLMB3An5u2VxzFxCvvElSiKp9SMYI52Fg8P7mbsrKPHodhQJZwCyf+Yrc
         gDC3voNOqmnROrUrmlocrT5a36zgfyX8GbI2jwTXxYzZtbNm3MPBU/zwq9T00/LHV7
         L+h1Eh/ZagbLTMlo64vY2Ryy+qspsOkkO8AjmP38hq+LKT0IYadamqkqUl0lVkIjuW
         wbAq/mGer2tnHwijsM1WMYRnmOgnwGqVfJ0uz6FAqKxGmKNe11PQ9WG1UnOjwdP+xp
         68NUTGERf89fQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 0/5] add tx status reporting to mt7921 driver
Date:   Wed, 18 Aug 2021 11:09:55 +0200
Message-Id: <cover.1629277624.git.lorenzo@kernel.org>
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

Lorenzo Bianconi (5):
  mt76: mt7921: start reworking tx rate reporting
  mt76: mt7921: add support for tx status reporting
  mt76: mt7921: report tx rate directly from tx status
  mt76: mt7921: remove mcu rate reporting code
  mt76: mt7921: remove mt7921_sta_stats

 .../net/wireless/mediatek/mt76/mt7921/init.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 364 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   9 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  28 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 133 -------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  47 ---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  21 +-
 7 files changed, 278 insertions(+), 325 deletions(-)

-- 
2.31.1

