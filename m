Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6ABE10AA8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEAQHs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 12:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEAQHr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 12:07:47 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E507020644;
        Wed,  1 May 2019 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726867;
        bh=izbZIsb9daLMsGyIDdOx/KgEK+e30p9cas+sU3oeLmU=;
        h=From:To:Cc:Subject:Date:From;
        b=B1vPMIaMg4iEg0CaUZ9zmyb2QiqgWAz79skL4c6UfnaqPzesSVBdtPjwzsIiJ+p5F
         JSWf/e53GLgzHOJLc08nZPl/JLSQk+oPhipewjEdvDNmWyg6ibCJk9A3cd8hTMV4C8
         iVSuln/o1qpIJgklRkbNhwb8kw0S0d3voRzk/JAQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [RFC 00/17] use standard signature for mt7615 mcu api
Date:   Wed,  1 May 2019 18:07:22 +0200
Message-Id: <cover.1556726268.git.lorenzo@kernel.org>
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

Lorenzo Bianconi (17):
  mt7615: mcu: simplify __mt7615_mcu_set_wtbl
  mt7615: mcu: simplify __mt7615_mcu_set_sta_rec
  mt7615: mcu: remove bss_info_convert_vif_type routine
  mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl_bmc
  mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl
  mt7615: mcu: unify mt7615_mcu_add_wtbl_bmc and mt7615_mcu_del_wtbl_bmc
  mt7615: mcu: remove unused paramter in mt7615_mcu_del_wtbl
  mt7615: remove query from mt7615_mcu_msg_send signature
  mt7615: remove dest from mt7615_mcu_msg_send signature
  mt7615: mcu: remove skb_ret from mt7615_mcu_msg_send
  mt7615: mcu: unify __mt7615_mcu_set_dev_info and
    mt7615_mcu_set_dev_info
  mt7615: mcu: do not use function pointer whenever possible
  mt7615: mcu: remove unused structure in mcu.h
  mt7615: mcu: use standard signature for mt7615_mcu_msg_send
  mt7615: initialize mt76_mcu_ops data structure
  mt7615: mcu: init mcu_restart function pointer
  mt7615: mcu: run __mt76_mcu_send_msg in mt7615_mcu_send_firmware

 .../net/wireless/mediatek/mt76/mt7615/main.c  |   17 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 1125 ++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   49 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   11 +-
 4 files changed, 545 insertions(+), 657 deletions(-)

-- 
2.20.1

