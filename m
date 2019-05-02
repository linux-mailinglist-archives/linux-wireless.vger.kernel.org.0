Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BDE11611
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfEBJHE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 05:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfEBJHD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 05:07:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECEAF5945E;
        Thu,  2 May 2019 09:07:02 +0000 (UTC)
Received: from localhost (ovpn-204-54.brq.redhat.com [10.40.204.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67CED1001E85;
        Thu,  2 May 2019 09:07:02 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH 0/7] rt2800: add experimental watchdog implementation
Date:   Thu,  2 May 2019 11:06:53 +0200
Message-Id: <1556788021-6531-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 02 May 2019 09:07:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add watchdog to address some remaining problems of Ralink devices
random hungs.

RFC -> v1
 - better description for module parameter 
 - fix white space

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

