Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC12263FF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jul 2020 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGTPl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 11:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729884AbgGTPl0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:26 -0400
Received: from lore-desk.redhat.com (unknown [151.48.143.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B1120773;
        Mon, 20 Jul 2020 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259686;
        bh=r4W7EsX8/iO5ESKISTjkif6SOIEaEOyViqk38w2yuMo=;
        h=From:To:Cc:Subject:Date:From;
        b=u2nhqjvh0NhZqc8Teld6+TGkMD5nGywng7cDQjVlHub2ELmzJzByLrb0GGWhnwNAh
         URpM3n/Y+ih3Ps71YuxAMduyN5P0jS5hC4bVy5bLYPWYFfKO3c+iNeAM30mlAM5nHb
         CtRgYF9Ng+HFReeRhkRNpdh/pk+sOHCR8eef2JxU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] mt76: mt7615: make drv_own/fw_own non-pci specific
Date:   Mon, 20 Jul 2020 17:41:18 +0200
Message-Id: <cover.1595259089.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce set_drv_ctrl and set_fw_ctrl function pointers in
mt7615_mcu_ops data structure in order to be used even by non-pci chipsets.
This is a preliminary patch to enable runtime-pm for mt7663s chipset.

Lorenzo Bianconi (2):
  mt76: mt7615: move drv_own/fw_own in mt7615_mcu_ops
  mt76: mt7663s: move drv_own/fw_own in mt7615_mcu_ops

 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 158 +++++++++---------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   8 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |   4 +-
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  16 +-
 6 files changed, 104 insertions(+), 90 deletions(-)

-- 
2.26.2

