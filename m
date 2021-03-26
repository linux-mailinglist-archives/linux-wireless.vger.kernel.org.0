Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2834A286
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 08:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCZHaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 03:30:12 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37216 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCZH3u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 03:29:50 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12Q7Th4I2006650, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12Q7Th4I2006650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 15:29:43 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 15:29:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>
Subject: [PATCH 0/3] rtw89: 8822c: add GAPK
Date:   Fri, 26 Mar 2021 15:29:23 +0800
Message-ID: <20210326072926.28313-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

GAPK is used to calibrate RF character to make every module good
performance. With a debug switch, we can make sure if it helps in field.

Besides, we sort the register definition to make it looks better. Since
previous patchset "rtw88: add some fixes and 8822c features" also changes
the registers, I create this patchset based on the previous one, expecting
this patchset is merged later than it.

Guo-Feng Fan (3):
  rtw88: 8822c: reorder macro position according to the register number
  rtw88: 8822c: Add gap-k calibration to improve long range performance
  rtw88: 8822c: debug: allow debugfs to enable/disable TXGAPK

 drivers/net/wireless/realtek/rtw88/debug.c    |  91 +++
 drivers/net/wireless/realtek/rtw88/fw.c       |  12 +
 drivers/net/wireless/realtek/rtw88/fw.h       |   5 +
 drivers/net/wireless/realtek/rtw88/main.h     |  31 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   8 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 724 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 336 ++++----
 7 files changed, 1065 insertions(+), 142 deletions(-)

-- 
2.21.0

