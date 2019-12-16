Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBE1206F6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfLPNUG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 08:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfLPNUG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 08:20:06 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE0A20684;
        Mon, 16 Dec 2019 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576502406;
        bh=4S31E7c3YFrAVQlSlYC6IelzuWjUFYPDZL1zcK1xuHw=;
        h=From:To:Cc:Subject:Date:From;
        b=IJdarKqIay6ewWe6EFSdc9lNyYRrmrTuW5m1VwNqrXzaZsa78r4ZseUDq3eNFdC8p
         xYeZZUaZdeY7Pdnk2uXVnflhvbykqii1qKf/McwnTSES85GnHli4h3RByw0f6s1TCL
         uzwGMhmZO9QdfSfrThsS5Rk/NAckh7tQGIsMHDNc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 0/2] improve mt76 led code readability
Date:   Mon, 16 Dec 2019 14:19:57 +0100
Message-Id: <cover.1576502217.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve code readability relying on FIELD_PREP macro for led register
definitions and remove open coding

Changes since v1:
- remove _MASK suffix from register definitions and move the
  code in *_init.c

Lorenzo Bianconi (2):
  mt76: mt76x02: simplify led reg definitions
  mt76: mt7603: simplify led reg definitions

 drivers/net/wireless/mediatek/mt76/mt7603/init.c  |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h  | 15 +++------------
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h | 12 +++---------
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c |  6 +++---
 4 files changed, 12 insertions(+), 27 deletions(-)

-- 
2.21.0

