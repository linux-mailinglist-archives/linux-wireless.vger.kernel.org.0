Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C4612CF2
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfECLxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:53:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58242 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfECLxp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:53:45 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43Brdh0000711, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43Brdh0000711
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:53:39 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 3 May 2019 19:53:39 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/5] rtw88: minor fixes from suggestions during review
Date:   Fri, 3 May 2019 19:53:30 +0800
Message-ID: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The series fix some small problems for rtw88, most of the suggestions
are from the review process.


v1 -> v2

 - modify description for LPS, ", turn off" -> ", to turn off"
 - drop patch "rtw88: mac: remove dangerous while (1)",
   should re-write the power sequence parsing code to make sense of avoiding
   infinite loop
 - unify Makefile license to Dual GPL/BSD


Yan-Hsuan Chuang (5):
  rtw88: add license for Makefile
  rtw88: pci: use ieee80211_ac_numbers instead of 0-3
  rtw88: pci: check if queue mapping exceeds size of ac_to_hwq
  rtw88: fix unassigned rssi_level in rtw_sta_info
  rtw88: more descriptions about LPS

 drivers/net/wireless/realtek/rtw88/Makefile |  2 ++
 drivers/net/wireless/realtek/rtw88/main.c   |  2 +-
 drivers/net/wireless/realtek/rtw88/pci.c    | 10 ++++++----
 drivers/net/wireless/realtek/rtw88/phy.c    |  4 ++--
 4 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.7.4

