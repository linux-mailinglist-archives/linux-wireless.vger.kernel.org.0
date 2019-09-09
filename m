Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCCAD372
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbfIIHQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 03:16:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57948 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfIIHQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 03:16:25 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x897GHtA014328, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x897GHtA014328
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Sep 2019 15:16:17 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 9 Sep 2019 15:16:16 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 0/8] rtw88: enhance and stabilize T-Put performance
Date:   Mon, 9 Sep 2019 15:16:03 +0800
Message-ID: <1568013371-21805-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patch set could enhance and stabilize the throughput
performance for rtw88, especially for RTL8822CE.

The RFKs, such as IQK and DPK, can make sure the radio
components works more reliable. They reduce the distortion
and nonlinearity that the components inherently have.

The parameter update is a result that is fine-tuned to
optimize the hardware utilization.

And CCK PD can help to adjust CCK signal threshold to
reduce FAs, and get a better TRX performance in 2.4G.

Interrupt migration helps some slower platforms not to
over utilize the host CPU, reduce its loading.


v1 -> v2
   * fix implicit fall-through warnings
   * add more log for FW IQK


Chin-Yen Lee (1):
  rtw88: 8822c: update pwr_seq to v13

Tsang-Shian Lin (1):
  rtw88: 8822c: Enable interrupt migration

Tzu-En Huang (2):
  rtw88: 8822c: add SW DPK support
  rtw88: add dynamic cck pd mechanism

Yan-Hsuan Chuang (4):
  rtw88: 8822c: update PHY parameter to v38
  rtw88: 8822c: add FW IQK support
  rtw88: move IQK/DPK into phy_calibration
  rtw88: allows to receive AMSDU in AMPDU

 drivers/net/wireless/realtek/rtw88/coex.c          |    2 +-
 drivers/net/wireless/realtek/rtw88/coex.h          |    1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    1 +
 drivers/net/wireless/realtek/rtw88/main.h          |   56 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |  145 +
 drivers/net/wireless/realtek/rtw88/phy.h           |    2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |   17 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    7 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      | 1178 +++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h      |   86 +
 .../net/wireless/realtek/rtw88/rtw8822c_table.c    | 6930 ++++++++++++++------
 .../net/wireless/realtek/rtw88/rtw8822c_table.h    |    3 +
 13 files changed, 6325 insertions(+), 2105 deletions(-)

-- 
2.7.4

