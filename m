Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539CDC45E7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 04:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfJBCbk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 22:31:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46006 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBCbk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 22:31:40 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x922VYAh031844, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x922VYAh031844
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 10:31:35 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 10:31:34 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 05/12] rtw88: remove unused lps state check helper
Date:   Wed, 2 Oct 2019 10:31:21 +0800
Message-ID: <20191002023128.12090-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002023128.12090-1-yhchuang@realtek.com>
References: <20191002023128.12090-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This is no more used, remove it.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  - rebase on top of wireless-drivers-next

 drivers/net/wireless/realtek/rtw88/ps.c | 5 -----
 drivers/net/wireless/realtek/rtw88/ps.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index a1541774cf0d..d57996e446fb 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -91,11 +91,6 @@ static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
 	set_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 }
 
-bool rtw_in_lps(struct rtw_dev *rtwdev)
-{
-	return test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
-}
-
 void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index d2aae613bca4..5aed11b5c182 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -12,6 +12,5 @@ int rtw_leave_ips(struct rtw_dev *rtwdev);
 
 void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id);
 void rtw_leave_lps(struct rtw_dev *rtwdev);
-bool rtw_in_lps(struct rtw_dev *rtwdev);
 
 #endif
-- 
2.17.1

