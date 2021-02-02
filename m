Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACFE30B770
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 06:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhBBFwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 00:52:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34017 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhBBFwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 00:52:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1125pEekD018636, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1125pEekD018636
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 2 Feb 2021 13:51:14 +0800
Received: from localhost (172.21.236.51) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 13:51:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] rtw88: 8821c: correct functions and support RFE type2 card
Date:   Tue, 2 Feb 2021 13:50:09 +0800
Message-ID: <20210202055012.8296-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.236.51]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix incorrect access address alignment and CCK RSSI report. And, support
8821CE RFE type 2 card by third patch with newer firmware.

Guo-Feng Fan (3):
  rtw88: coex: 8821c: correct antenna switch function
  rtw88: 8821c: Correct CCK RSSI
  rtw88: 8821c: support RFE type2 wifi NIC

 drivers/net/wireless/realtek/rtw88/main.c     |   2 +
 drivers/net/wireless/realtek/rtw88/main.h     |   7 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 109 ++++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  22 +
 .../wireless/realtek/rtw88/rtw8821c_table.c   | 397 ++++++++++++++++++
 .../wireless/realtek/rtw88/rtw8821c_table.h   |   1 +
 6 files changed, 525 insertions(+), 13 deletions(-)

-- 
2.21.0

