Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C870A2A0032
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3Ikb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 04:40:31 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48078 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3Ik1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 04:40:27 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09U8eIeU5008838, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09U8eIeU5008838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Oct 2020 16:40:18 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 30 Oct 2020 16:40:17 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 0/4] Update Some Power Saving Feature For the New FW
Date:   Fri, 30 Oct 2020 16:40:09 +0800
Message-ID: <20201030084013.8457-1-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

These patches update the way of working with the new firmware.
First, there are new information that driver can get from firmware. The
infomation are the supported power saving mode of the firmware, and the
synchronization approach of the firmware(by driver polling registers or
getting a firmware C2H).
Second, update the mechanism for synchronizing the state of power saving
with the firmware.

Chin-Yen Lee (4):
  rtw88: sync the power state between driver and firmware
  rtw88: store firmware feature in firmware header
  rtw88: add C2H response for checking firmware leave lps
  rtw88: decide lps deep mode from firmware feature.

 drivers/net/wireless/realtek/rtw88/fw.c       |   6 +-
 drivers/net/wireless/realtek/rtw88/fw.h       |  11 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   2 +-
 drivers/net/wireless/realtek/rtw88/main.c     |  50 +++++--
 drivers/net/wireless/realtek/rtw88/main.h     |   5 +-
 drivers/net/wireless/realtek/rtw88/ps.c       | 135 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/ps.h       |   3 +-
 drivers/net/wireless/realtek/rtw88/wow.c      |   5 +-
 8 files changed, 155 insertions(+), 62 deletions(-)

-- 
2.17.1

