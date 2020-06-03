Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3C1ECCCD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgFCJmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:42:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42388 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgFCJmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:42:35 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0539gNPZ1012441, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0539gNPZ1012441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 3 Jun 2020 17:42:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:42:23 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:42:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v2 0/5] rtw88: 8821c: the rest patches to support 8821c
Date:   Wed, 3 Jun 2020 17:42:13 +0800
Message-ID: <20200603094218.19942-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

[Note] this set is based on another set:
    [v3,0/7] rtw88: 8821c: add basic function routines
    https://patchwork.kernel.org/cover/11585415/

After this set, the RTL8821CE device is supported by rtw88.
The CCK PD settings allows the device to adjust to the environment.
The power tracking mechanism can detect the thermal value of the
device and modify the power index.

As RTL8821CE is an 802.11ac 1x1 device, the STBC the no supported.

v1 -> v2
  * rebase
  * add definition for some register


Tzu-En Huang (5):
  rtw88: 8821c: add cck pd settings
  rtw88: 8821c: add power tracking
  rtw88: 8821c: add beamformee support
  rtw88: single rf path chips don't support TX STBC
  rtw88: 8821c: Add 8821CE to Kconfig and Makefile

 drivers/net/wireless/realtek/rtw88/Kconfig    |  14 +
 drivers/net/wireless/realtek/rtw88/Makefile   |   6 +
 drivers/net/wireless/realtek/rtw88/bf.c       |   5 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   4 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   2 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 361 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |   4 +
 7 files changed, 392 insertions(+), 4 deletions(-)

-- 
2.17.1

