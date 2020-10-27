Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F029D29A28A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 03:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504400AbgJ0CMz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Oct 2020 22:12:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36135 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504385AbgJ0CMz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Oct 2020 22:12:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09R2CmcrE015791, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09R2CmcrE015791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 10:12:48 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 27 Oct 2020 10:12:48 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 00/11] rtw88: coex: fix field issues and add debug interfaces
Date:   Tue, 27 Oct 2020 10:11:46 +0800
Message-ID: <20201027021157.6116-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This patchset adds coex code synchronized from our internal tree, in which
we fix many field issues, and add debug interfaces that is helpful to debug
in field. Also, some coding style fixes are included.

There are totally 32 patches, so I plan to submit them as three patchsets,
and this is the first one.

v2: remove rtw_coex_coex_dm_reset from "rtw88: coex: coding style adjustment".
    Reported-by: kernel test robot <lkp@intel.com>

Ching-Te Ku (11):
  rtw88: coex: fixed some wrong register definition and setting
  rtw88: coex: update coex parameter to improve A2DP quality
  rtw88: coex: reduce magic number
  rtw88: coex: coding style adjustment
  rtw88: coex: Modify the timing of set_ant_path/set_rf_para
  rtw88: coex: add separate flag for manual control
  rtw88: coex: modified for BT info notify
  rtw88: coex: change the parameter for A2DP when WLAN connecting
  rtw88: coex: update WLAN 5G AFH parameter for 8822b
  rtw88: coex: add debug message
  rtw88: coex: simplify the setting and condition about WLAN TX
    limitation

 drivers/net/wireless/realtek/rtw88/coex.c     | 673 ++++++++++++++----
 drivers/net/wireless/realtek/rtw88/coex.h     |  36 +-
 drivers/net/wireless/realtek/rtw88/debug.c    |   4 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   4 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  13 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |  15 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  65 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |   2 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  65 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 102 +--
 11 files changed, 719 insertions(+), 263 deletions(-)

-- 
2.21.0

