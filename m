Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A631B836A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 04:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDYC4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 22:56:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:34437 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgDYC4q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 22:56:46 -0400
IronPort-SDR: PmjMR7te2WQieiljCRU6PKZAGeHq6Uzgt04UCGpbIOIKT7edzjHVNMzpr26ihqqS0yb7PPP6Tw
 EWJhvowhl4Lw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:56:46 -0700
IronPort-SDR: TjiheuF1U0SCP/HhyD+l8+nQPtHMaxGtem8ZMPFB2qcXcKrhWFQaBEhYpxO7S55Qt/ya8CryaU
 tWI4fedGLoEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="457643506"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 24 Apr 2020 19:56:44 -0700
Date:   Sat, 25 Apr 2020 10:56:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, kbuild-all@lists.01.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH wireless-drivers-next] rtw88: __rtw_download_firmware()
 can be static
Message-ID: <20200425025633.GL26573@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1wdgqsy.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Fixes: 15d2fcc6b2de ("rtw88: add legacy firmware download for 8723D devices")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 mac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 6092604abfb9e..3cc0b363df8ce 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -650,7 +650,7 @@ static void download_firmware_end_flow(struct rtw_dev *rtwdev)
 	rtw_write16(rtwdev, REG_MCUFW_CTRL, fw_ctrl);
 }
 
-int __rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+static int __rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 {
 	struct rtw_backup_info bckp[DLFW_RESTORE_REG_NUM];
 	const u8 *data = fw->firmware->data;
@@ -814,7 +814,7 @@ static int download_firmware_validate_legacy(struct rtw_dev *rtwdev)
 	return -EINVAL;
 }
 
-int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
+static int __rtw_download_firmware_legacy(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 {
 	int ret = 0;
 
