Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD381299
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHEG4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 02:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEG4G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 02:56:06 -0400
Received: from localhost.localdomain (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0009206C1;
        Mon,  5 Aug 2019 06:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564988166;
        bh=Ci3tD/WLOUy1SjR/cfKNW61aCGHTRVNY2jtEThCxpJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=dgLopSjzyTZEhRGpXkfC5KqMMbDcX7pKt1dU3QaDtNrfkvJ11MMtyHJdWb1uyhHIp
         mVBCe4jqZdAxlpRKLZt0iy2HroNJAGo51KgIgf34rwljrLkK8nFRb8C23+EW28i7nu
         Sv4H+E/3fHX96ady8r5dOLYdVyv83/hlXp6lZcDY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com, ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 0/3] enable channel survey for mt76u and mt7615
Date:   Mon,  5 Aug 2019 08:55:50 +0200
Message-Id: <cover.1564987866.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce channel survey support for mt76x02u and mt7615 drivers
in order to enable ACS for all of them

Lorenzo Bianconi (3):
  mt76: mt76x02u: enable survey support
  mt76: mt7603: move survey_time in mt76_dev
  mt76: mt7615: enable survey support

 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 ++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  5 ++--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  4 ++--
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  1 -
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 24 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 ++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  3 +++
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  9 +++++++
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  1 +
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |  7 ++++++
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  5 ++++
 13 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.21.0

