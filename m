Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2369C46F5B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFOKBC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOKBB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:01:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADD228553D;
        Sat, 15 Jun 2019 10:01:01 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CA2D5C269;
        Sat, 15 Jun 2019 10:01:01 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH v2 0/7] rt2800: add experimental watchdog implementation
Date:   Sat, 15 Jun 2019 12:00:53 +0200
Message-Id: <20190615100100.29800-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 15 Jun 2019 10:01:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add watchdog to address some remaining problems of Ralink devices
random hungs.

RFC -> v1
 - better description for module parameter 
 - fix white space

v1 -> v2:
 - rebase on latest tree.

Stanislaw Gruszka (7):
  rt2x00: allow to specify watchdog interval
  rt2800: add helpers for reading dma done index
  rt2800: initial watchdog implementation
  rt2800: add pre_reset_hw callback
  rt2800: do not nullify initialization vector data
  rt2x00: add restart hw
  rt2800: do not enable watchdog by default

 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 96 ++++++++++++++++++-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    | 11 +++
 .../net/wireless/ralink/rt2x00/rt2800mmio.c   | 31 ++++++
 .../net/wireless/ralink/rt2x00/rt2800mmio.h   |  2 +
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |  3 +
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  3 +
 .../net/wireless/ralink/rt2x00/rt2800usb.c    | 11 +++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   | 10 ++
 .../net/wireless/ralink/rt2x00/rt2x00debug.c  | 35 +++++++
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    | 10 +-
 .../net/wireless/ralink/rt2x00/rt2x00link.c   | 15 ++-
 .../net/wireless/ralink/rt2x00/rt2x00queue.h  |  6 ++
 12 files changed, 221 insertions(+), 12 deletions(-)

-- 
2.20.1

