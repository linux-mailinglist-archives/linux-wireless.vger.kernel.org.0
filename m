Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9960C13AE8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfEDP3X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfEDP3X (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:23 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42EB620644;
        Sat,  4 May 2019 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983762;
        bh=8UrpEQTy2iVjsoMcSg9OkGhUL4czwuxJIvchZ2ZGkrY=;
        h=From:To:Cc:Subject:Date:From;
        b=bRa9oNJp8zDAnmdfzB1SdVRYejwPu+SUOxNGp2CUWlP8r5zLXiU5LzoiXXNEBA5ZS
         RwXXWFURbL4E6KNze/JyhFHwqOjwZ44LBRhdt04zpgH9qK/w+thKV8aEmf1Nj9T3XQ
         NsHKBuTtWkmaia+glSGSqlD2HQIKo/IpMS7vQUmA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 00/17] use standard signature for mt7615 mcu api
Date:   Sat,  4 May 2019 17:28:52 +0200
Message-Id: <cover.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_mcu_ops data structure in mt7615 mcu code in order
to reuse the code with other bus types and unify the code with mt7603
driver

Changes since RFC:
- rebase ontop of https://patchwork.kernel.org/patch/10928753/
- fix net_type initialization in mt7615_mcu_set_bss_info

Lorenzo Bianconi (17):
  mt7615: mcu: simplify __mt7615_mcu_set_wtbl
  mt7615: mcu: simplify __mt7615_mcu_set_sta_rec
  mt7615: mcu: remove bss_info_convert_vif_type routine
  mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl_bmc
  mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl
  mt7615: mcu: unify mt7615_mcu_add_wtbl_bmc and mt7615_mcu_del_wtbl_bmc
  mt7615: mcu: remove unused parameter in mt7615_mcu_del_wtbl
  mt7615: remove query from mt7615_mcu_msg_send signature
  mt7615: remove dest from mt7615_mcu_msg_send signature
  mt7615: mcu: remove skb_ret from mt7615_mcu_msg_send
  mt7615: mcu: unify __mt7615_mcu_set_dev_info and
    mt7615_mcu_set_dev_info
  mt7615: mcu: do not use function pointers whenever possible
  mt7615: mcu: remove unused structure in mcu.h
  mt7615: mcu: use standard signature for mt7615_mcu_msg_send
  mt7615: initialize mt76_mcu_ops data structure
  mt7615: mcu: init mcu_restart function pointer
  mt7615: mcu: run __mt76_mcu_send_msg in mt7615_mcu_send_firmware

 .../net/wireless/mediatek/mt76/mt7615/main.c  |   17 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 1147 ++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   49 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   11 +-
 4 files changed, 556 insertions(+), 668 deletions(-)

-- 
2.20.1

