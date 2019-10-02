Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2EC47CE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfJBGfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57688 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfJBGfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZYFj013038, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZYFj013038
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:34 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:33 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 00/14] rtw88: add software TX queue support
Date:   Wed, 2 Oct 2019 14:35:17 +0800
Message-ID: <20191002063531.18135-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This adds support for software TX queue that is provided by
mac80211 stack. Also can take advantage of AMSDU, by letting
it to aggregate the MSDUs in the TX queue.

With software TX queue, driver can handle the rate control
mechanism, by set/check the current state of the TX queues.

If driver is going to use software TX queue, it is better to
also add ieee80211_ops::flush for better control of either
software/hardware queues. This can help mac80211 to flush
the queues whenever it wants to.

And TX queues should follow the EDCA params, add
ieee80211_ops::conf_tx to setup the parameters accordingly.

There's also some fixes for the driver. One can check in
the log to see what the fixes for. The most important fix
is ("rtw88: fix beaconing mode rsvd_page memory violation issue").
Because there's kernel memory violation that could generate
protection fault, when user wants to start beaconing modes
such as AP.


Chin-Yen Lee (1):
  rtw88: check firmware leave lps successfully

Ping-Ke Shih (4):
  rtw88: Don't set RX_FLAG_DECRYPTED if packet has no encryption
  rtw88: use struct rtw_fw_hdr to access firmware header
  rtw88: fix NSS of hw_cap
  rtw88: fix error handling when setup efuse info

Tzu-En Huang (1):
  rtw88: report tx rate to mac80211 stack

Yan-Hsuan Chuang (8):
  rtw88: allows to set RTS in TX descriptor
  rtw88: add driver TX queue support
  rtw88: take over rate control from mac80211
  rtw88: add TX-AMSDU support
  rtw88: flush hardware tx queues
  rtw88: fix beaconing mode rsvd_page memory violation issue
  rtw88: configure TX queue EDCA parameters
  rtw88: raise firmware version debug level

 drivers/net/wireless/realtek/rtw88/fw.c       | 149 ++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/fw.h       |  51 ++++--
 drivers/net/wireless/realtek/rtw88/mac.c      | 131 ++++++++++++---
 drivers/net/wireless/realtek/rtw88/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c | 154 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.c     |  70 +++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  50 +++++-
 drivers/net/wireless/realtek/rtw88/ps.c       |  29 ++++
 drivers/net/wireless/realtek/rtw88/ps.h       |   2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   7 +-
 drivers/net/wireless/realtek/rtw88/rx.c       |  22 +--
 drivers/net/wireless/realtek/rtw88/rx.h       |  11 ++
 drivers/net/wireless/realtek/rtw88/tx.c       | 133 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/tx.h       |   8 +
 drivers/net/wireless/realtek/rtw88/util.c     |  27 +++
 17 files changed, 767 insertions(+), 86 deletions(-)

-- 
2.17.1

