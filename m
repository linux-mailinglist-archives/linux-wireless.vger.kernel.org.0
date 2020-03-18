Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C878189C17
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCRMl2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 08:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgCRMl2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 08:41:28 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5112076D;
        Wed, 18 Mar 2020 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584535288;
        bh=Q3YkWDIso2rkDToYkjHZTdthkqcDiWBoQtFaHy10IgA=;
        h=From:To:Cc:Subject:Date:From;
        b=vg4hfPo8Ao2hPKsZNNHUeEquAd5IxUr/Gl/q8ObhifNxoP38+w2ZtiQABhSTB77Qy
         2YlXjcealooVQ4e3aZwZ0D3BaKy1Li1ijoCTGQnAxmxCkmRCpcZWqgdEG7djfSa69Y
         ovA530FD5QZqMesrT562CAeJXkKlGHy513UGznPg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] fix endianness issues in mt7663e driver
Date:   Wed, 18 Mar 2020 13:41:02 +0100
Message-Id: <cover.1584534454.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix endianness issues reported by kbuild test robot

Lorenzo Bianconi (3):
  mt76: mt7615: fix mt7663e firmware struct endianness
  mt76: mt7615: fix endianness in unified command
  mt76: mt7615: add missing declaration in mt7615.h

 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 16 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h   |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.25.1

