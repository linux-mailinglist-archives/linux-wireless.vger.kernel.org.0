Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FEE0E3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 12:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfD2Kyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 06:54:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfD2Kyd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 06:54:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 421CB85A03;
        Mon, 29 Apr 2019 10:54:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 973956443A;
        Mon, 29 Apr 2019 10:54:32 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [RFC/RFT 0/7] rt2800: add experimental watchdog implementation
Date:   Mon, 29 Apr 2019 12:54:23 +0200
Message-Id: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 29 Apr 2019 10:54:33 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add watchdog to address some remaining problems of Ralink devices
random hungs.

Stanislaw Gruszka (7):
  rt2x00: allow to specify watchdog interval
  rt2800: add helpers for reading dma done index
  rt2800: initial watchdog implementation
  rt2800: add pre_reset_hw callback
  rt2800: do not nullify initialization vector data
  rt2x00: add restart hw
  rt2800: do not enable watchdog by default

 drivers/net/wireless/ralink/rt2x00/rt2800lib.c   | 96 ++++++++++++++++++++++--
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h   | 11 +++
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c  | 31 ++++++++
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.h  |  2 +
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c   |  3 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c   |  3 +
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c   | 11 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h      | 10 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00debug.c | 35 +++++++++
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c   | 10 ++-
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c  | 15 ++--
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.h |  6 ++
 12 files changed, 221 insertions(+), 12 deletions(-)

-- 
2.7.5

