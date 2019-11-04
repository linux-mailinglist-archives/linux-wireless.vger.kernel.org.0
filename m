Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3712CED7B3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 03:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfKDCaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Nov 2019 21:30:12 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42162 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfKDCaL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Nov 2019 21:30:11 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA42U4TH024356, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA42U4TH024356
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 4 Nov 2019 10:30:04 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 4 Nov 2019 10:30:03 +0800
From:   <yhchuang@realtek.com>
To:     <jwboyer@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <linux-firmware@kernel.org>
Subject: [PATCH v2] rtw88: RTL8723D: add firmware file v48
Date:   Mon, 4 Nov 2019 10:29:48 +0800
Message-ID: <20191104022948.24735-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add firmware file for RTL8723D series devices.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  * rebase on top of master

 WHENCE                |   1 +
 rtw88/rtw8723d_fw.bin | Bin 0 -> 28884 bytes
 2 files changed, 1 insertion(+)
 create mode 100644 rtw88/rtw8723d_fw.bin

diff --git a/WHENCE b/WHENCE
index 7e885ec..69e7a00 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2849,6 +2849,7 @@ File: rtw88/rtw8822b_fw.bin
 File: rtw88/rtw8822c_fw.bin
 File: rtw88/rtw8822c_wow_fw.bin
 File: rtw88/README
+File: rtw88/rtw8723d_fw.bin
 
 Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 
diff --git a/rtw88/rtw8723d_fw.bin b/rtw88/rtw8723d_fw.bin
new file mode 100644
index 0000000000000000000000000000000000000000..ac2b9250c39e15c9fd183711fff3cfcc022fb691
GIT binary patch
literal 28884
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

literal 0
HcmV?d00001

-- 
2.17.1

