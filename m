Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2877836E672
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 10:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhD2IEN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 04:04:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43419 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbhD2IEJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 04:04:09 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13T83IAf8025423, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13T83IAf8025423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 16:03:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 16:03:17 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 29 Apr
 2021 16:03:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 06/19] rtw89: add files to download and communicate with firmware
Date:   Thu, 29 Apr 2021 16:01:36 +0800
Message-ID: <20210429080149.7068-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210429080149.7068-1-pkshih@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXH36502.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwMjo0NTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:29:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163401 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:33:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwNzoyMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:51:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163403 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:54:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware must be downloaded right after HCI basic initialization, and
then we can obtain hardware capabilities that are used to do mac80211
register hw.

To download firmware, we need to parse the header to know how many sections
the firmware has, and then download each section to proper location.

We introduce H2C and C2H to do bi-direction communication with firmware,
and both support packet-based and register-based methods.
Normally, we use packet-based H2C/C2H, because it has no number and size
limits. In contrast, register-based H2C/C2H has only one message and
fix-four-dword in size.

Header size of packet-based H2C/C2H is eight bytes (two dwords), which uses
a hierarchical IDs, containing type, category, class and function, to
classify a H2C or C2H command.

When a C2H is received in interrupt context, we don't process it right
there, but queue the skb and wake up a ieee80211 work to handle the skb.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1316 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 1150 ++++++++++++++++++++
 2 files changed, 2466 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/fw.h

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
new file mode 100644
index 000000000000..5c9f7f5423a9
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -0,0 +1,1316 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "cam.h"
+#include "coex.h"
+#include "debug.h"
+#include "fw.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+
+static struct sk_buff *rtw89_fw_h2c_alloc_skb(u32 len, bool header)
+{
+	struct sk_buff *skb;
+	u32 header_len = 0;
+
+	if (header)
+		header_len = H2C_HEADER_LEN;
+
+	skb = dev_alloc_skb(len + header_len + 24);
+	if (!skb)
+		return NULL;
+	skb_reserve(skb, header_len + 24);
+	memset(skb->data, 0, len);
+
+	return skb;
+}
+
+struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(u32 len)
+{
+	return rtw89_fw_h2c_alloc_skb(len, true);
+}
+
+struct sk_buff *rtw89_fw_h2c_alloc_skb_no_hdr(u32 len)
+{
+	return rtw89_fw_h2c_alloc_skb(len, false);
+}
+
+static u8 _fw_get_rdy(struct rtw89_dev *rtwdev)
+{
+	u8 val = rtw89_read8(rtwdev, R_AX_WCPU_FW_CTRL);
+
+	return FIELD_GET(B_AX_WCPU_FWDL_STS_MASK, val);
+}
+
+#define FWDL_WAIT_CNT 400000
+int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
+{
+	u8 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(_fw_get_rdy, val,
+				       val == RTW89_FWDL_WCPU_FW_INIT_RDY,
+				       1, FWDL_WAIT_CNT, false, rtwdev);
+	if (ret) {
+		switch (val) {
+		case RTW89_FWDL_CHECKSUM_FAIL:
+			rtw89_err(rtwdev, "fw checksum fail\n");
+			return -EINVAL;
+
+		case RTW89_FWDL_SECURITY_FAIL:
+			rtw89_err(rtwdev, "fw security fail\n");
+			return -EINVAL;
+
+		case RTW89_FWDL_CV_NOT_MATCH:
+			rtw89_err(rtwdev, "fw cv not match\n");
+			return -EINVAL;
+
+		default:
+			return -EBUSY;
+		}
+	}
+
+	set_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
+
+	return 0;
+}
+
+static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
+			       struct rtw89_fw_bin_info *info)
+{
+	struct rtw89_fw_hdr_section_info *section_info;
+	const u8 *fw_end = fw + len;
+	const u8 *bin;
+	u32 i;
+
+	if (!info)
+		return -EINVAL;
+
+	info->section_num = GET_FW_HDR_SEC_NUM(fw);
+	info->hdr_len = RTW89_FW_HDR_SIZE +
+			info->section_num * RTW89_FW_SECTION_HDR_SIZE;
+	SET_FW_HDR_PART_SIZE(fw, FWDL_SECTION_PER_PKT_LEN);
+
+	bin = fw + info->hdr_len;
+
+	/* jump to section header */
+	fw += RTW89_FW_HDR_SIZE;
+	section_info = info->section_info;
+	for (i = 0; i < info->section_num; i++) {
+		section_info->len = GET_FWSECTION_HDR_SEC_SIZE(fw);
+		if (GET_FWSECTION_HDR_CHECKSUM(fw))
+			section_info->len += FWDL_SECTION_CHKSUM_LEN;
+		section_info->redl = GET_FWSECTION_HDR_REDL(fw);
+		section_info->dladdr =
+				GET_FWSECTION_HDR_DL_ADDR(fw) & 0x1fffffff;
+		section_info->addr = bin;
+		bin += section_info->len;
+		fw += RTW89_FW_SECTION_HDR_SIZE;
+		section_info++;
+	}
+
+	if (fw_end != bin) {
+		rtw89_err(rtwdev, "[ERR]fw bin size\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static
+int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
+			struct rtw89_fw_suit *fw_suit)
+{
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
+	const u8 *mfw = fw_info->firmware->data;
+	u32 mfw_len = fw_info->firmware->size;
+	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
+	const struct rtw89_mfw_info *mfw_info;
+	int i;
+
+	if (mfw_hdr->sig != RTW89_MFW_SIG) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW, "use legacy firmware\n");
+		/* legacy firmware support normal type only */
+		if (type != RTW89_FW_NORMAL)
+			return -EINVAL;
+		fw_suit->data = mfw;
+		fw_suit->size = mfw_len;
+		return 0;
+	}
+
+	for (i = 0; i < mfw_hdr->fw_nr; i++) {
+		mfw_info = &mfw_hdr->info[i];
+		if (mfw_info->cv != rtwdev->hal.cv ||
+		    mfw_info->type != type ||
+		    mfw_info->mp)
+			continue;
+
+		fw_suit->data = mfw + le32_to_cpu(mfw_info->shift);
+		fw_suit->size = le32_to_cpu(mfw_info->size);
+		return 0;
+	}
+
+	rtw89_err(rtwdev, "no suitable firmware found\n");
+	return -ENOENT;
+}
+
+static void rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
+				enum rtw89_fw_type type,
+				struct rtw89_fw_suit *fw_suit)
+{
+	const u8 *hdr = fw_suit->data;
+
+	fw_suit->major_ver = GET_FW_HDR_MAJOR_VERSION(hdr);
+	fw_suit->minor_ver = GET_FW_HDR_MINOR_VERSION(hdr);
+	fw_suit->sub_ver = GET_FW_HDR_SUBVERSION(hdr);
+	fw_suit->sub_idex = GET_FW_HDR_SUBINDEX(hdr);
+	fw_suit->build_year = GET_FW_HDR_YEAR(hdr);
+	fw_suit->build_mon = GET_FW_HDR_MONTH(hdr);
+	fw_suit->build_date = GET_FW_HDR_DATE(hdr);
+	fw_suit->build_hour = GET_FW_HDR_HOUR(hdr);
+	fw_suit->build_min = GET_FW_HDR_MIN(hdr);
+	fw_suit->cmd_ver = GET_FW_HDR_CMD_VERSERION(hdr);
+
+	rtw89_info(rtwdev,
+		   "Firmware version %u.%u.%u.%u, cmd version %u, type %u\n",
+		   fw_suit->major_ver, fw_suit->minor_ver, fw_suit->sub_ver,
+		   fw_suit->sub_idex, fw_suit->cmd_ver, type);
+}
+
+static
+int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
+{
+	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
+	int ret;
+
+	ret = rtw89_mfw_recognize(rtwdev, type, fw_suit);
+	if (ret)
+		return ret;
+
+	rtw89_fw_update_ver(rtwdev, type, fw_suit);
+
+	return 0;
+}
+
+int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = __rtw89_fw_recognize(rtwdev, RTW89_FW_NORMAL);
+	if (ret)
+		return ret;
+
+	/* It still works if wowlan firmware isn't existing. */
+	__rtw89_fw_recognize(rtwdev, RTW89_FW_WOWLAN);
+
+	return 0;
+}
+
+void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+			   u8 type, u8 cat, u8 class, u8 func,
+			   bool rack, bool dack, u32 len)
+{
+	struct fwcmd_hdr *hdr;
+
+	hdr = (struct fwcmd_hdr *)skb_push(skb, 8);
+
+	if (!(rtwdev->fw.h2c_seq % 4))
+		rack = true;
+	hdr->hdr0 = cpu_to_le32(FIELD_PREP(H2C_HDR_DEL_TYPE, type) |
+				FIELD_PREP(H2C_HDR_CAT, cat) |
+				FIELD_PREP(H2C_HDR_CLASS, class) |
+				FIELD_PREP(H2C_HDR_FUNC, func) |
+				FIELD_PREP(H2C_HDR_H2C_SEQ, rtwdev->fw.h2c_seq));
+
+	hdr->hdr1 = cpu_to_le32(FIELD_PREP(H2C_HDR_TOTAL_LEN,
+					   len + H2C_HEADER_LEN) |
+				(rack ? H2C_HDR_REC_ACK : 0) |
+				(dack ? H2C_HDR_DONE_ACK : 0));
+
+	rtwdev->fw.h2c_seq++;
+}
+
+static void rtw89_h2c_pkt_set_hdr_fwdl(struct rtw89_dev *rtwdev,
+				       struct sk_buff *skb,
+				       u8 type, u8 cat, u8 class, u8 func,
+				       u32 len)
+{
+	struct fwcmd_hdr *hdr;
+
+	hdr = (struct fwcmd_hdr *)skb_push(skb, 8);
+
+	hdr->hdr0 = cpu_to_le32(FIELD_PREP(H2C_HDR_DEL_TYPE, type) |
+				FIELD_PREP(H2C_HDR_CAT, cat) |
+				FIELD_PREP(H2C_HDR_CLASS, class) |
+				FIELD_PREP(H2C_HDR_FUNC, func) |
+				FIELD_PREP(H2C_HDR_H2C_SEQ, rtwdev->fw.h2c_seq));
+
+	hdr->hdr1 = cpu_to_le32(FIELD_PREP(H2C_HDR_TOTAL_LEN,
+					   len + H2C_HEADER_LEN));
+}
+
+static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len)
+{
+	struct sk_buff *skb;
+	u32 ret = 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw hdr dl\n");
+		return -ENOMEM;
+	}
+
+	skb_put_data(skb, fw, len);
+	rtw89_h2c_pkt_set_hdr_fwdl(rtwdev, skb, FWCMD_TYPE_H2C,
+				   H2C_CAT_MAC, H2C_CL_MAC_FWDL,
+				   H2C_FUNC_MAC_FWHDR_DL, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		ret = -1;
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len)
+{
+	u8 val;
+	int ret;
+
+	ret = __rtw89_fw_download_hdr(rtwdev, fw, len);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]FW header download\n");
+		return ret;
+	}
+
+	ret = read_poll_timeout_atomic(rtw89_read8, val, val & B_AX_FWDL_PATH_RDY,
+				       1, FWDL_WAIT_CNT, false,
+				       rtwdev, R_AX_WCPU_FW_CTRL);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]FWDL path ready\n");
+		return ret;
+	}
+
+	rtw89_write32(rtwdev, R_AX_HALT_H2C_CTRL, 0);
+	rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
+
+	return 0;
+}
+
+static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
+				    struct rtw89_fw_hdr_section_info *info)
+{
+	struct sk_buff *skb;
+	const u8 *section = info->addr;
+	u32 residue_len = info->len;
+	u32 pkt_len;
+	int ret;
+
+	while (residue_len) {
+		if (residue_len >= FWDL_SECTION_PER_PKT_LEN)
+			pkt_len = FWDL_SECTION_PER_PKT_LEN;
+		else
+			pkt_len = residue_len;
+
+		skb = rtw89_fw_h2c_alloc_skb_no_hdr(pkt_len);
+		if (!skb) {
+			rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+			return -ENOMEM;
+		}
+		skb_put_data(skb, section, pkt_len);
+
+		ret = rtw89_h2c_tx(rtwdev, skb, true);
+		if (ret) {
+			rtw89_err(rtwdev, "failed to send h2c\n");
+			ret = -1;
+			goto fail;
+		}
+
+		section += pkt_len;
+		residue_len -= pkt_len;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+static int rtw89_fw_download_main(struct rtw89_dev *rtwdev, const u8 *fw,
+				  struct rtw89_fw_bin_info *info)
+{
+	struct rtw89_fw_hdr_section_info *section_info = info->section_info;
+	u8 section_num = info->section_num;
+	int ret;
+
+	while (section_num--) {
+		ret = __rtw89_fw_download_main(rtwdev, section_info);
+		if (ret)
+			return ret;
+		section_info++;
+	}
+
+	mdelay(5);
+
+	ret = rtw89_fw_check_rdy(rtwdev);
+	if (ret) {
+		rtw89_warn(rtwdev, "download firmware fail\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rtw89_fw_dl_fail_dump(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u16 val16, index;
+
+	val32 = rtw89_read32(rtwdev, R_AX_WCPU_FW_CTRL);
+	rtw89_err(rtwdev, "[ERR]fwdl 0x1E0 = 0x%x\n", val32);
+
+	val16 = rtw89_read16(rtwdev, R_AX_BOOT_DBG + 2);
+	rtw89_err(rtwdev, "[ERR]fwdl 0x83F2 = 0x%x\n", val16);
+
+	rtw89_write32(rtwdev, R_AX_DBG_CTRL, 0xf200f2);
+	rtw89_write32_mask(rtwdev, R_AX_SYS_STATUS1, B_AX_SEL_0XC0, 1);
+
+	for (index = 0; index < 15; index++) {
+		val32 = rtw89_read32(rtwdev, R_AX_DBG_PORT_SEL);
+		rtw89_err(rtwdev, "[ERR]fw PC = 0x%x\n", val32);
+		udelay(10);
+	}
+}
+
+int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
+{
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
+	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
+	struct rtw89_fw_bin_info info;
+	const u8 *fw = fw_suit->data;
+	u32 len = fw_suit->size;
+	u8 val;
+	int ret;
+
+	if (!fw || !len) {
+		rtw89_err(rtwdev, "fw type %d isn't recognized\n", type);
+		return -ENOENT;
+	}
+
+	ret = rtw89_fw_hdr_parser(rtwdev, fw, len, &info);
+	if (ret) {
+		rtw89_err(rtwdev, "parse fw header fail\n");
+		goto fwdl_err;
+	}
+
+	ret = read_poll_timeout_atomic(rtw89_read8, val, val & B_AX_H2C_PATH_RDY,
+				       1, FWDL_WAIT_CNT, false,
+				       rtwdev, R_AX_WCPU_FW_CTRL);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]H2C path ready\n");
+		goto fwdl_err;
+	}
+
+	ret = rtw89_fw_download_hdr(rtwdev, fw, info.hdr_len);
+	if (ret) {
+		ret = -EBUSY;
+		goto fwdl_err;
+	}
+
+	ret = rtw89_fw_download_main(rtwdev, fw, &info);
+	if (ret) {
+		ret = -EBUSY;
+		goto fwdl_err;
+	}
+
+	fw_info->h2c_seq = 0;
+	fw_info->rec_seq = 0;
+	rtwdev->mac.rpwm_seq_num = RPWM_SEQ_NUM_MAX;
+	rtwdev->mac.cpwm_seq_num = CPWM_SEQ_NUM_MAX;
+
+	return ret;
+
+fwdl_err:
+	rtw89_fw_dl_fail_dump(rtwdev);
+	return ret;
+}
+
+int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_info *fw = &rtwdev->fw;
+
+	wait_for_completion(&fw->completion);
+	if (!fw->firmware)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void rtw89_load_firmware_cb(const struct firmware *firmware, void *context)
+{
+	struct rtw89_fw_info *fw = context;
+	struct rtw89_dev *rtwdev = fw->rtwdev;
+
+	if (!firmware || !firmware->data) {
+		rtw89_err(rtwdev, "failed to request firmware\n");
+		complete_all(&fw->completion);
+		return;
+	}
+
+	fw->firmware = firmware;
+	complete_all(&fw->completion);
+}
+
+int rtw89_load_firmware(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_info *fw = &rtwdev->fw;
+	const char *fw_name = rtwdev->chip->fw_name;
+	int ret;
+
+	fw->rtwdev = rtwdev;
+	init_completion(&fw->completion);
+
+	ret = request_firmware_nowait(THIS_MODULE, true, fw_name, rtwdev->dev,
+				      GFP_KERNEL, fw, rtw89_load_firmware_cb);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to async firmware request\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+void rtw89_unload_firmware(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_info *fw = &rtwdev->fw;
+
+	rtw89_wait_firmware_completion(rtwdev);
+
+	if (fw->firmware)
+		release_firmware(fw->firmware);
+}
+
+#define H2C_CAM_LEN 60
+int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_CAM_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_CAM_LEN);
+	rtw89_cam_fill_addr_cam_info(rtwdev, rtwvif, skb->data);
+	rtw89_cam_fill_bssid_cam_info(rtwdev, rtwvif, skb->data);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_ADDR_CAM_UPDATE,
+			      H2C_FUNC_MAC_ADDR_CAM_UPD, 0, 1,
+			      H2C_CAM_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_BA_CAM_LEN 4
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, bool valid, u8 macid,
+			struct ieee80211_ampdu_params *params)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_BA_CAM_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c ba cam\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_BA_CAM_LEN);
+	SET_BA_CAM_MACID(skb->data, macid);
+	if (!valid)
+		goto end;
+	SET_BA_CAM_VALID(skb->data, valid);
+	SET_BA_CAM_TID(skb->data, params->tid);
+	if (params->buf_size > 64)
+		SET_BA_CAM_BMAP_SIZE(skb->data, 4);
+	else
+		SET_BA_CAM_BMAP_SIZE(skb->data, 0);
+	/* If init req is set, hw will set the ssn */
+	SET_BA_CAM_INIT_REQ(skb->data, 0);
+	SET_BA_CAM_SSN(skb->data, params->ssn);
+
+end:
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_BA_CAM,
+			      H2C_FUNC_MAC_BA_CAM, 0, 1,
+			      H2C_BA_CAM_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_GENERAL_PKT_LEN 6
+#define H2C_GENERAL_PKT_ID_UND 0xff
+int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_GENERAL_PKT_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_GENERAL_PKT_LEN);
+	SET_GENERAL_PKT_MACID(skb->data, macid);
+	SET_GENERAL_PKT_PROBRSP_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
+	SET_GENERAL_PKT_PSPOLL_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
+	SET_GENERAL_PKT_NULL_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
+	SET_GENERAL_PKT_QOS_NULL_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
+	SET_GENERAL_PKT_CTS2SELF_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_FW_INFO,
+			      H2C_FUNC_MAC_GENERAL_PKT, 0, 1,
+			      H2C_GENERAL_PKT_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_LPS_PARM_LEN 8
+int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev, u8 macid)
+{
+	struct sk_buff *skb;
+	struct rtw89_lps_parm *lps_param = &rtwdev->lps_parm;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_LPS_PARM_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_LPS_PARM_LEN);
+
+	SET_LPS_PARM_MACID(skb->data, lps_param->macid);
+	SET_LPS_PARM_PSMODE(skb->data, lps_param->psmode);
+	SET_LPS_PARM_LASTRPWM(skb->data, lps_param->lastrpwm);
+	SET_LPS_PARM_RLBM(skb->data, 1);
+	SET_LPS_PARM_SMARTPS(skb->data, 1);
+	SET_LPS_PARM_AWAKEINTERVAL(skb->data, 1);
+	SET_LPS_PARM_VOUAPSD(skb->data, 0);
+	SET_LPS_PARM_VIUAPSD(skb->data, 0);
+	SET_LPS_PARM_BEUAPSD(skb->data, 0);
+	SET_LPS_PARM_BKUAPSD(skb->data, 0);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_PS,
+			      H2C_FUNC_MAC_LPS_PARM, 0, 1,
+			      H2C_LPS_PARM_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_CMC_TBL_LEN 68
+int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev, u8 macid)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_CMC_TBL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_CMC_TBL_LEN);
+	SET_CTRL_INFO_MACID(skb->data, macid);
+	SET_CTRL_INFO_OPERATION(skb->data, 1);
+	SET_CMC_TBL_TXPWR_MODE(skb->data, 0);
+	SET_CMC_TBL_NTX_PATH_EN(skb->data, 2);
+	SET_CMC_TBL_PATH_MAP_A(skb->data, 0);
+	SET_CMC_TBL_PATH_MAP_B(skb->data, 0);
+	/* RTW_WKARD_DEF_CMACTBL_CFG */
+	SET_CMC_TBL_PATH_MAP_C(skb->data, 0);
+	SET_CMC_TBL_PATH_MAP_D(skb->data, 0);
+	SET_CMC_TBL_ANTSEL_A(skb->data, 0);
+	SET_CMC_TBL_ANTSEL_B(skb->data, 0);
+	SET_CMC_TBL_ANTSEL_C(skb->data, 0);
+	SET_CMC_TBL_ANTSEL_D(skb->data, 0);
+	SET_CMC_TBL_DOPPLER_CTRL(skb->data, 0);
+	SET_CMC_TBL_TXPWR_TOLERENCE(skb->data, 0);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
+			      H2C_CMC_TBL_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
+				     struct ieee80211_sta *sta, u8 *pads)
+{
+	bool ppe_th;
+	u8 ppe16, ppe8;
+	u8 nss = min(sta->rx_nss, rtwdev->chip->tx_nss) - 1;
+	u8 ppe_thres_hdr = sta->he_cap.ppe_thres[0];
+	u8 ru_bitmap;
+	u8 n, idx, sh;
+	u16 ppe;
+	int i;
+
+	if (!sta->he_cap.has_he)
+		return;
+
+	ppe_th = FIELD_GET(IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
+			   sta->he_cap.he_cap_elem.phy_cap_info[6]);
+	if (!ppe_th) {
+		u8 pad;
+
+		pad = FIELD_GET(IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK,
+				sta->he_cap.he_cap_elem.phy_cap_info[9]);
+
+		for (i = 0; i < RTW89_PPE_BW_NUM; i++)
+			pads[i] = pad;
+	}
+
+	ru_bitmap = FIELD_GET(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK, ppe_thres_hdr);
+	n = hweight8(ru_bitmap);
+	n = 7 + (n * IEEE80211_PPE_THRES_INFO_PPET_SIZE * 2) * nss;
+
+	for (i = 0; i < RTW89_PPE_BW_NUM; i++) {
+		if (!(ru_bitmap & BIT(i))) {
+			pads[i] = 1;
+			continue;
+		}
+
+		idx = n >> 3;
+		sh = n & 7;
+		n += IEEE80211_PPE_THRES_INFO_PPET_SIZE * 2;
+
+		ppe = le16_to_cpu(*((__le16 *)&sta->he_cap.ppe_thres[idx]));
+		ppe16 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
+		sh += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
+		ppe8 = (ppe >> sh) & IEEE80211_PPE_THRES_NSS_MASK;
+
+		if (ppe16 != 7 && ppe8 == 7)
+			pads[i] = 2;
+		else if (ppe8 != 7)
+			pads[i] = 1;
+		else
+			pads[i] = 0;
+	}
+}
+
+int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct sk_buff *skb;
+	u8 pads[RTW89_PPE_BW_NUM];
+
+	memset(pads, 0, sizeof(pads));
+	__get_sta_he_pkt_padding(rtwdev, sta, pads);
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_CMC_TBL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_CMC_TBL_LEN);
+	SET_CTRL_INFO_MACID(skb->data, rtwsta->mac_id);
+	SET_CTRL_INFO_OPERATION(skb->data, 1);
+	SET_CMC_TBL_DISRTSFB(skb->data, 1);
+	SET_CMC_TBL_DISDATAFB(skb->data, 1);
+	SET_CMC_TBL_RTS_TXCNT_LMT_SEL(skb->data, 0);
+	SET_CMC_TBL_DATA_TXCNT_LMT_SEL(skb->data, 0);
+	if (vif->type == NL80211_IFTYPE_STATION)
+		SET_CMC_TBL_ULDL(skb->data, 1);
+	else
+		SET_CMC_TBL_ULDL(skb->data, 0);
+	SET_CMC_TBL_MULTI_PORT_ID(skb->data, rtwvif->port);
+	SET_CMC_TBL_NOMINAL_PKT_PADDING(skb->data, pads[RTW89_CHANNEL_WIDTH_20]);
+	SET_CMC_TBL_NOMINAL_PKT_PADDING40(skb->data, pads[RTW89_CHANNEL_WIDTH_40]);
+	SET_CMC_TBL_NOMINAL_PKT_PADDING80(skb->data, pads[RTW89_CHANNEL_WIDTH_80]);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
+			      H2C_CMC_TBL_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
+				 struct rtw89_sta *rtwsta)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_CMC_TBL_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_CMC_TBL_LEN);
+	SET_CTRL_INFO_MACID(skb->data, rtwsta->mac_id);
+	SET_CTRL_INFO_OPERATION(skb->data, 1);
+	if (rtwsta->cctl_tx_time) {
+		SET_CMC_TBL_AMPDU_TIME_SEL(skb->data, 1);
+		SET_CMC_TBL_AMPDU_MAX_TIME(skb->data, rtwsta->ampdu_max_time);
+	}
+	if (rtwsta->cctl_tx_retry_limit) {
+		SET_CMC_TBL_DATA_TXCNT_LMT_SEL(skb->data, 1);
+		SET_CMC_TBL_DATA_TX_CNT_LMT(skb->data, rtwsta->data_tx_cnt_lmt);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
+			      H2C_CMC_TBL_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_VIF_MAINTAIN_LEN 4
+int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif *rtwvif,
+			      enum rtw89_upd_mode upd_mode)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_VIF_MAINTAIN_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_VIF_MAINTAIN_LEN);
+	SET_FWROLE_MAINTAIN_MACID(skb->data, rtwvif->mac_id);
+	SET_FWROLE_MAINTAIN_SELF_ROLE(skb->data, rtwvif->self_role);
+	SET_FWROLE_MAINTAIN_UPD_MODE(skb->data, upd_mode);
+	SET_FWROLE_MAINTAIN_WIFI_ROLE(skb->data, rtwvif->wifi_role);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
+			      H2C_FUNC_MAC_FWROLE_MAINTAIN, 0, 1,
+			      H2C_VIF_MAINTAIN_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_JOIN_INFO_LEN 4
+int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   u8 dis_conn)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_JOIN_INFO_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_JOIN_INFO_LEN);
+	SET_JOININFO_MACID(skb->data, rtwvif->mac_id);
+	SET_JOININFO_OP(skb->data, dis_conn);
+	SET_JOININFO_BAND(skb->data, rtwvif->mac_idx);
+	SET_JOININFO_WMM(skb->data, rtwvif->wmm);
+	SET_JOININFO_TGR(skb->data, rtwvif->trigger);
+	SET_JOININFO_ISHESTA(skb->data, 0);
+	SET_JOININFO_DLBW(skb->data, 0);
+	SET_JOININFO_TF_MAC_PAD(skb->data, 0);
+	SET_JOININFO_DL_T_PE(skb->data, 0);
+	SET_JOININFO_PORT_ID(skb->data, rtwvif->port);
+	SET_JOININFO_NET_TYPE(skb->data, rtwvif->net_type);
+	SET_JOININFO_WIFI_ROLE(skb->data, rtwvif->wifi_role);
+	SET_JOININFO_SELF_ROLE(skb->data, rtwvif->self_role);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
+			      H2C_FUNC_MAC_JOININFO, 0, 1,
+			      H2C_JOIN_INFO_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
+			     bool pause)
+{
+	struct rtw89_fw_macid_pause_grp h2c = {{0}};
+	u8 len = sizeof(struct rtw89_fw_macid_pause_grp);
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_JOIN_INFO_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
+		return -ENOMEM;
+	}
+	h2c.mask_grp[grp] = cpu_to_le32(BIT(sh));
+	if (pause)
+		h2c.pause_grp[grp] = cpu_to_le32(BIT(sh));
+	skb_put_data(skb, &h2c, len);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_MAC_MACID_PAUSE, 1, 0,
+			      len);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_EDCA_LEN 12
+int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			  u8 ac, u32 val)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_EDCA_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c edca\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_EDCA_LEN);
+	RTW89_SET_EDCA_SEL(skb->data, 0);
+	RTW89_SET_EDCA_BAND(skb->data, rtwvif->mac_idx);
+	RTW89_SET_EDCA_WMM(skb->data, 0);
+	RTW89_SET_EDCA_AC(skb->data, ac);
+	RTW89_SET_EDCA_PARAM(skb->data, val);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_USR_EDCA, 0, 1,
+			      H2C_EDCA_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_OFLD_CFG_LEN 8
+int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
+{
+	static const u8 cfg[] = {0x09, 0x00, 0x00, 0x00, 0x5e, 0x00, 0x00, 0x00};
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_OFLD_CFG_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c ofld\n");
+		return -ENOMEM;
+	}
+	skb_put_data(skb, cfg, H2C_OFLD_CFG_LEN);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_OFLD_CFG, 0, 1,
+			      H2C_OFLD_CFG_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_RA_LEN 16
+int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi)
+{
+	struct sk_buff *skb;
+	u8 *cmd;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_RA_LEN);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c join\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_RA_LEN);
+	cmd = skb->data;
+	rtw89_debug(rtwdev, RTW89_DBG_RA,
+		    "ra cmd msk: %llx ", ra->ra_mask);
+
+	RTW89_SET_FWCMD_RA_MODE(cmd, ra->mode_ctrl);
+	RTW89_SET_FWCMD_RA_BW_CAP(cmd, ra->bw_cap);
+	RTW89_SET_FWCMD_RA_MACID(cmd, ra->macid);
+	RTW89_SET_FWCMD_RA_DCM(cmd, ra->dcm_cap);
+	RTW89_SET_FWCMD_RA_ER(cmd, ra->er_cap);
+	RTW89_SET_FWCMD_RA_INIT_RATE_LV(cmd, ra->init_rate_lv);
+	RTW89_SET_FWCMD_RA_UPD_ALL(cmd, ra->upd_all);
+	RTW89_SET_FWCMD_RA_SGI(cmd, ra->en_sgi);
+	RTW89_SET_FWCMD_RA_LDPC(cmd, ra->ldpc_cap);
+	RTW89_SET_FWCMD_RA_STBC(cmd, ra->stbc_cap);
+	RTW89_SET_FWCMD_RA_SS_NUM(cmd, ra->ss_num);
+	RTW89_SET_FWCMD_RA_GILTF(cmd, ra->giltf);
+	RTW89_SET_FWCMD_RA_UPD_BW_NSS_MASK(cmd, ra->upd_bw_nss_mask);
+	RTW89_SET_FWCMD_RA_UPD_MASK(cmd, ra->upd_mask);
+	RTW89_SET_FWCMD_RA_MASK_0(cmd, FIELD_GET(MASKBYTE0, ra->ra_mask));
+	RTW89_SET_FWCMD_RA_MASK_1(cmd, FIELD_GET(MASKBYTE1, ra->ra_mask));
+	RTW89_SET_FWCMD_RA_MASK_2(cmd, FIELD_GET(MASKBYTE2, ra->ra_mask));
+	RTW89_SET_FWCMD_RA_MASK_3(cmd, FIELD_GET(MASKBYTE3, ra->ra_mask));
+	RTW89_SET_FWCMD_RA_MASK_4(cmd, FIELD_GET(MASKBYTE4, ra->ra_mask));
+
+	if (csi) {
+		RTW89_SET_FWCMD_RA_BFEE_CSI_CTL(cmd, 1);
+		RTW89_SET_FWCMD_RA_BAND_NUM(cmd, ra->band_num);
+		RTW89_SET_FWCMD_RA_CR_TBL_SEL(cmd, ra->cr_tbl_sel);
+		RTW89_SET_FWCMD_RA_FIXED_CSI_RATE_EN(cmd, ra->fixed_csi_rate_en);
+		RTW89_SET_FWCMD_RA_RA_CSI_RATE_EN(cmd, ra->ra_csi_rate_en);
+		RTW89_SET_FWCMD_RA_FIXED_CSI_MCS_SS_IDX(cmd, ra->csi_mcs_ss_idx);
+		RTW89_SET_FWCMD_RA_FIXED_CSI_MODE(cmd, ra->csi_mode);
+		RTW89_SET_FWCMD_RA_FIXED_CSI_GI_LTF(cmd, ra->csi_gi_ltf);
+		RTW89_SET_FWCMD_RA_FIXED_CSI_BW(cmd, ra->csi_bw);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RA,
+			      H2C_FUNC_OUTSRC_RA_MACIDCFG, 0, 0,
+			      H2C_RA_LEN);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
+			struct rtw89_fw_h2c_rf_reg_info *info,
+			u16 len, u8 page)
+{
+	struct sk_buff *skb;
+	u8 class = info->rf_path == RF_PATH_A ?
+		   H2C_CL_OUTSRC_RF_REG_A : H2C_CL_OUTSRC_RF_REG_B;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c rf reg\n");
+		return -ENOMEM;
+	}
+	skb_put_data(skb, info->rtw89_phy_config_rf_h2c[page], len);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, class, page, 0, 0,
+			      len);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
+			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
+			      bool rack, bool dack)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for raw with hdr\n");
+		return -ENOMEM;
+	}
+	skb_put_data(skb, buf, len);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, h2c_class, h2c_func, rack, dack,
+			      len);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len)
+{
+	struct sk_buff *skb;
+
+	skb = rtw89_fw_h2c_alloc_skb_no_hdr(len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c raw\n");
+		return -ENOMEM;
+	}
+	skb_put_data(skb, buf, len);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h)
+{
+	skb_queue_tail(&rtwdev->c2h_queue, c2h);
+	ieee80211_queue_work(rtwdev->hw, &rtwdev->c2h_work);
+}
+
+static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
+				    struct sk_buff *skb)
+{
+	u8 category = RTW89_GET_C2H_CATEGORY(skb->data);
+	u8 class = RTW89_GET_C2H_CLASS(skb->data);
+	u8 func = RTW89_GET_C2H_FUNC(skb->data);
+	u16 len = RTW89_GET_C2H_LEN(skb->data);
+	bool dump = true;
+
+	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+		return;
+
+	switch (category) {
+	case RTW89_C2H_CAT_TEST:
+		break;
+	case RTW89_C2H_CAT_MAC:
+		rtw89_mac_c2h_handle(rtwdev, skb, len, class, func);
+		if (class == RTW89_MAC_C2H_CLASS_INFO &&
+		    func == RTW89_MAC_C2H_FUNC_C2H_LOG)
+			dump = false;
+		break;
+	case RTW89_C2H_CAT_OUTSRC:
+		if (class >= RTW89_PHY_C2H_CLASS_BTC_MIN &&
+		    class <= RTW89_PHY_C2H_CLASS_BTC_MAX)
+			rtw89_btc_c2h_handle(rtwdev, skb, len, class, func);
+		else
+			rtw89_phy_c2h_handle(rtwdev, skb, len, class, func);
+		break;
+	}
+
+	if (dump)
+		rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "C2H: ", skb->data, skb->len);
+}
+
+void rtw89_fw_c2h_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						c2h_work);
+	struct sk_buff *skb, *tmp;
+
+	skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
+		skb_unlink(skb, &rtwdev->c2h_queue);
+		mutex_lock(&rtwdev->mutex);
+		rtw89_fw_c2h_cmd_handle(rtwdev, skb);
+		mutex_unlock(&rtwdev->mutex);
+		dev_kfree_skb_any(skb);
+	}
+}
+
+static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
+				  struct rtw89_mac_h2c_info *info)
+{
+	static const u32 h2c_reg[RTW89_H2CREG_MAX] = {
+		R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,
+		R_AX_H2CREG_DATA2, R_AX_H2CREG_DATA3
+	};
+	u8 i, val, len;
+	int ret;
+
+	ret = read_poll_timeout(rtw89_read8, val, val == 0, 1000, 5000, false,
+				rtwdev, R_AX_H2CREG_CTRL);
+	if (ret) {
+		rtw89_warn(rtwdev, "FW does not process h2c registers\n");
+		return ret;
+	}
+
+	len = DIV_ROUND_UP(info->content_len + RTW89_H2CREG_HDR_LEN,
+			   sizeof(info->h2creg[0]));
+
+	RTW89_SET_H2CREG_HDR_FUNC(&info->h2creg[0], info->id);
+	RTW89_SET_H2CREG_HDR_LEN(&info->h2creg[0], len);
+	for (i = 0; i < RTW89_H2CREG_MAX; i++)
+		rtw89_write32(rtwdev, h2c_reg[i], info->h2creg[i]);
+
+	rtw89_write8(rtwdev, R_AX_H2CREG_CTRL, B_AX_H2CREG_TRIGGER);
+
+	return 0;
+}
+
+static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
+				 struct rtw89_mac_c2h_info *info)
+{
+	static const u32 c2h_reg[RTW89_C2HREG_MAX] = {
+		R_AX_C2HREG_DATA0, R_AX_C2HREG_DATA1,
+		R_AX_C2HREG_DATA2, R_AX_C2HREG_DATA3
+	};
+	u32 ret;
+	u8 i, val;
+
+	info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
+
+	ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
+				       RTW89_C2H_TIMEOUT, false, rtwdev,
+				       R_AX_C2HREG_CTRL);
+	if (ret) {
+		rtw89_warn(rtwdev, "c2h reg timeout\n");
+		return ret;
+	}
+
+	for (i = 0; i < RTW89_C2HREG_MAX; i++)
+		info->c2hreg[i] = rtw89_read32(rtwdev, c2h_reg[i]);
+
+	rtw89_write8(rtwdev, R_AX_C2HREG_CTRL, 0);
+
+	info->id = RTW89_GET_C2H_HDR_FUNC(*info->c2hreg);
+	info->content_len = (RTW89_GET_C2H_HDR_LEN(*info->c2hreg) << 2) -
+				RTW89_C2HREG_HDR_LEN;
+
+	return 0;
+}
+
+int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
+		     struct rtw89_mac_h2c_info *h2c_info,
+		     struct rtw89_mac_c2h_info *c2h_info)
+{
+	u32 ret;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (!h2c_info && !c2h_info)
+		return -EINVAL;
+
+	if (!h2c_info)
+		goto recv_c2h;
+
+	ret = rtw89_fw_write_h2c_reg(rtwdev, h2c_info);
+	if (ret)
+		return ret;
+
+recv_c2h:
+	if (!c2h_info)
+		return 0;
+
+	ret = rtw89_fw_read_c2h_reg(rtwdev, c2h_info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
new file mode 100644
index 000000000000..5609446b5b1d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -0,0 +1,1150 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_FW_H__
+#define __RTW89_FW_H__
+
+#include "core.h"
+
+enum rtw89_fw_dl_status {
+	RTW89_FWDL_INITIAL_STATE = 0,
+	RTW89_FWDL_FWDL_ONGOING = 1,
+	RTW89_FWDL_CHECKSUM_FAIL = 2,
+	RTW89_FWDL_SECURITY_FAIL = 3,
+	RTW89_FWDL_CV_NOT_MATCH = 4,
+	RTW89_FWDL_RSVD0 = 5,
+	RTW89_FWDL_WCPU_FWDL_RDY = 6,
+	RTW89_FWDL_WCPU_FW_INIT_RDY = 7
+};
+
+#define RTW89_GET_C2H_HDR_FUNC(info) \
+	u32_get_bits(info, GENMASK(6, 0))
+#define RTW89_GET_C2H_HDR_LEN(info) \
+	u32_get_bits(info, GENMASK(11, 8))
+
+#define RTW89_SET_H2CREG_HDR_FUNC(info, val) \
+	u32p_replace_bits(info, val, GENMASK(6, 0))
+#define RTW89_SET_H2CREG_HDR_LEN(info, val) \
+	u32p_replace_bits(info, val, GENMASK(11, 8))
+
+#define RTW89_H2CREG_MAX 4
+#define RTW89_C2HREG_MAX 4
+#define RTW89_C2HREG_HDR_LEN 2
+#define RTW89_H2CREG_HDR_LEN 2
+#define RTW89_C2H_TIMEOUT 1000000
+struct rtw89_mac_c2h_info {
+	u8 id;
+	u8 content_len;
+	u32 c2hreg[RTW89_C2HREG_MAX];
+};
+
+struct rtw89_mac_h2c_info {
+	u8 id;
+	u8 content_len;
+	u32 h2creg[RTW89_H2CREG_MAX];
+};
+
+enum rtw89_mac_h2c_type {
+	RTW89_FWCMD_H2CREG_FUNC_H2CREG_LB = 0,
+	RTW89_FWCMD_H2CREG_FUNC_CNSL_CMD,
+	RTW89_FWCMD_H2CREG_FUNC_FWERR,
+	RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE,
+	RTW89_FWCMD_H2CREG_FUNC_GETPKT_INFORM,
+	RTW89_FWCMD_H2CREG_FUNC_SCH_TX_EN
+};
+
+enum rtw89_mac_c2h_type {
+	RTW89_FWCMD_C2HREG_FUNC_C2HREG_LB = 0,
+	RTW89_FWCMD_C2HREG_FUNC_ERR_RPT,
+	RTW89_FWCMD_C2HREG_FUNC_ERR_MSG,
+	RTW89_FWCMD_C2HREG_FUNC_PHY_CAP,
+	RTW89_FWCMD_C2HREG_FUNC_TX_PAUSE_RPT,
+	RTW89_FWCMD_C2HREG_FUNC_NULL = 0xFF
+};
+
+enum rtw89_fw_c2h_category {
+	RTW89_C2H_CAT_TEST,
+	RTW89_C2H_CAT_MAC,
+	RTW89_C2H_CAT_OUTSRC,
+};
+
+#define FWDL_SECTION_MAX_NUM 10
+#define FWDL_SECTION_CHKSUM_LEN	8
+#define FWDL_SECTION_PER_PKT_LEN 2020
+
+struct rtw89_fw_hdr_section_info {
+	u8 redl;
+	const u8 *addr;
+	u32 len;
+	u32 dladdr;
+};
+
+struct rtw89_fw_bin_info {
+	u8 section_num;
+	u32 hdr_len;
+	struct rtw89_fw_hdr_section_info section_info[FWDL_SECTION_MAX_NUM];
+};
+
+struct rtw89_fw_macid_pause_grp {
+	__le32 pause_grp[4];
+	__le32 mask_grp[4];
+} __packed;
+
+struct rtw89_h2creg_sch_tx_en {
+	u8 func:7;
+	u8 ack:1;
+	u8 total_len:4;
+	u8 seq_num:4;
+	u16 tx_en:16;
+	u16 mask:16;
+	u8 band:1;
+	u16 rsvd:15;
+} __packed;
+
+#define RTW89_SET_FWCMD_RA_IS_DIS(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(0))
+#define RTW89_SET_FWCMD_RA_MODE(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(5, 1))
+#define RTW89_SET_FWCMD_RA_BW_CAP(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(7, 6))
+#define RTW89_SET_FWCMD_RA_MACID(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(15, 8))
+#define RTW89_SET_FWCMD_RA_DCM(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(16))
+#define RTW89_SET_FWCMD_RA_ER(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(17))
+#define RTW89_SET_FWCMD_RA_INIT_RATE_LV(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(19, 18))
+#define RTW89_SET_FWCMD_RA_UPD_ALL(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(20))
+#define RTW89_SET_FWCMD_RA_SGI(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(21))
+#define RTW89_SET_FWCMD_RA_LDPC(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(22))
+#define RTW89_SET_FWCMD_RA_STBC(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(23))
+#define RTW89_SET_FWCMD_RA_SS_NUM(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(26, 24))
+#define RTW89_SET_FWCMD_RA_GILTF(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(29, 27))
+#define RTW89_SET_FWCMD_RA_UPD_BW_NSS_MASK(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(30))
+#define RTW89_SET_FWCMD_RA_UPD_MASK(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(31))
+#define RTW89_SET_FWCMD_RA_MASK_0(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, GENMASK(7, 0))
+#define RTW89_SET_FWCMD_RA_MASK_1(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, GENMASK(15, 8))
+#define RTW89_SET_FWCMD_RA_MASK_2(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, GENMASK(23, 16))
+#define RTW89_SET_FWCMD_RA_MASK_3(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, GENMASK(31, 24))
+#define RTW89_SET_FWCMD_RA_MASK_4(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x02, GENMASK(7, 0))
+#define RTW89_SET_FWCMD_RA_BFEE_CSI_CTL(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x02, BIT(31))
+#define RTW89_SET_FWCMD_RA_BAND_NUM(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, GENMASK(7, 0))
+#define RTW89_SET_FWCMD_RA_RA_CSI_RATE_EN(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, BIT(8))
+#define RTW89_SET_FWCMD_RA_FIXED_CSI_RATE_EN(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, BIT(9))
+#define RTW89_SET_FWCMD_RA_CR_TBL_SEL(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, BIT(10))
+#define RTW89_SET_FWCMD_RA_FIXED_CSI_MCS_SS_IDX(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, GENMASK(23, 16))
+#define RTW89_SET_FWCMD_RA_FIXED_CSI_MODE(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, GENMASK(25, 24))
+#define RTW89_SET_FWCMD_RA_FIXED_CSI_GI_LTF(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, GENMASK(28, 26))
+#define RTW89_SET_FWCMD_RA_FIXED_CSI_BW(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, GENMASK(31, 29))
+
+#define RTW89_SET_FWCMD_SEC_IDX(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(7, 0))
+#define RTW89_SET_FWCMD_SEC_OFFSET(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(15, 8))
+#define RTW89_SET_FWCMD_SEC_LEN(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(23, 16))
+#define RTW89_SET_FWCMD_SEC_TYPE(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, GENMASK(3, 0))
+#define RTW89_SET_FWCMD_SEC_EXT_KEY(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, BIT(4))
+#define RTW89_SET_FWCMD_SEC_SPP_MODE(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, BIT(5))
+#define RTW89_SET_FWCMD_SEC_KEY0(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x02, GENMASK(31, 0))
+#define RTW89_SET_FWCMD_SEC_KEY1(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x03, GENMASK(31, 0))
+#define RTW89_SET_FWCMD_SEC_KEY2(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x04, GENMASK(31, 0))
+#define RTW89_SET_FWCMD_SEC_KEY3(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x05, GENMASK(31, 0))
+
+#define RTW89_SET_EDCA_SEL(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(1, 0))
+#define RTW89_SET_EDCA_BAND(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(3))
+#define RTW89_SET_EDCA_WMM(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, BIT(4))
+#define RTW89_SET_EDCA_AC(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x00, GENMASK(6, 5))
+#define RTW89_SET_EDCA_PARAM(cmd, val) \
+	RTW89_SET_FWCMD(cmd, val, 0x01, GENMASK(31, 0))
+#define FW_EDCA_PARAM_TXOPLMT_MSK GENMASK(26, 16)
+#define FW_EDCA_PARAM_CWMAX_MSK GENMASK(15, 12)
+#define FW_EDCA_PARAM_CWMIN_MSK GENMASK(11, 8)
+#define FW_EDCA_PARAM_AIFS_MSK GENMASK(7, 0)
+
+#define GET_FWSECTION_HDR_SEC_SIZE(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(23, 0))
+#define GET_FWSECTION_HDR_CHECKSUM(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 1), BIT(28))
+#define GET_FWSECTION_HDR_REDL(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 1), BIT(29))
+#define GET_FWSECTION_HDR_DL_ADDR(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr)), GENMASK(31, 0))
+
+#define GET_FW_HDR_MAJOR_VERSION(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(7, 0))
+#define GET_FW_HDR_MINOR_VERSION(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(15, 8))
+#define GET_FW_HDR_SUBVERSION(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(23, 16))
+#define GET_FW_HDR_SUBINDEX(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(31, 24))
+#define GET_FW_HDR_MONTH(fwhdr)		\
+	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(7, 0))
+#define GET_FW_HDR_DATE(fwhdr)		\
+	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(15, 8))
+#define GET_FW_HDR_HOUR(fwhdr)		\
+	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(23, 16))
+#define GET_FW_HDR_MIN(fwhdr)		\
+	le32_get_bits(*((__le32 *)(fwhdr) + 4), GENMASK(31, 24))
+#define GET_FW_HDR_YEAR(fwhdr)		\
+	le32_get_bits(*((__le32 *)(fwhdr) + 5), GENMASK(31, 0))
+#define GET_FW_HDR_SEC_NUM(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 6), GENMASK(15, 8))
+#define GET_FW_HDR_CMD_VERSERION(fwhdr)	\
+	le32_get_bits(*((__le32 *)(fwhdr) + 7), GENMASK(31, 24))
+#define SET_FW_HDR_PART_SIZE(fwhdr, val)	\
+	le32p_replace_bits((__le32 *)(fwhdr) + 7, val, GENMASK(15, 0))
+
+#define SET_CTRL_INFO_MACID(table, val) \
+	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0))
+#define SET_CTRL_INFO_OPERATION(table, val) \
+	le32p_replace_bits((__le32 *)(table) + 0, val, BIT(7))
+#define SET_CMC_TBL_MASK_DATARATE GENMASK(8, 0)
+#define SET_CMC_TBL_DATARATE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(8, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATARATE, \
+			   GENMASK(8, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_FORCE_TXOP BIT(0)
+#define SET_CMC_TBL_FORCE_TXOP(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(9)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_FORCE_TXOP, \
+			   BIT(9)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_BW GENMASK(1, 0)
+#define SET_CMC_TBL_DATA_BW(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(11, 10)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATA_BW, \
+			   GENMASK(11, 10)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_GI_LTF GENMASK(2, 0)
+#define SET_CMC_TBL_DATA_GI_LTF(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(14, 12)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DATA_GI_LTF, \
+			   GENMASK(14, 12)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DARF_TC_INDEX BIT(0)
+#define SET_CMC_TBL_DARF_TC_INDEX(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(15)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DARF_TC_INDEX, \
+			   BIT(15)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ARFR_CTRL GENMASK(3, 0)
+#define SET_CMC_TBL_ARFR_CTRL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(19, 16)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ARFR_CTRL, \
+			   GENMASK(19, 16)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ACQ_RPT_EN BIT(0)
+#define SET_CMC_TBL_ACQ_RPT_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(20)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ACQ_RPT_EN, \
+			   BIT(20)); \
+} while (0)
+#define SET_CMC_TBL_MASK_MGQ_RPT_EN BIT(0)
+#define SET_CMC_TBL_MGQ_RPT_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(21)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_MGQ_RPT_EN, \
+			   BIT(21)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ULQ_RPT_EN BIT(0)
+#define SET_CMC_TBL_ULQ_RPT_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(22)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_ULQ_RPT_EN, \
+			   BIT(22)); \
+} while (0)
+#define SET_CMC_TBL_MASK_TWTQ_RPT_EN BIT(0)
+#define SET_CMC_TBL_TWTQ_RPT_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(23)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_TWTQ_RPT_EN, \
+			   BIT(23)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DISRTSFB BIT(0)
+#define SET_CMC_TBL_DISRTSFB(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(25)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DISRTSFB, \
+			   BIT(25)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DISDATAFB BIT(0)
+#define SET_CMC_TBL_DISDATAFB(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(26)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_DISDATAFB, \
+			   BIT(26)); \
+} while (0)
+#define SET_CMC_TBL_MASK_TRYRATE BIT(0)
+#define SET_CMC_TBL_TRYRATE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, BIT(27)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_TRYRATE, \
+			   BIT(27)); \
+} while (0)
+#define SET_CMC_TBL_MASK_AMPDU_DENSITY GENMASK(3, 0)
+#define SET_CMC_TBL_AMPDU_DENSITY(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 1, val, GENMASK(31, 28)); \
+	le32p_replace_bits((__le32 *)(table) + 9, SET_CMC_TBL_MASK_AMPDU_DENSITY, \
+			   GENMASK(31, 28)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_RTY_LOWEST_RATE GENMASK(8, 0)
+#define SET_CMC_TBL_DATA_RTY_LOWEST_RATE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(8, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_DATA_RTY_LOWEST_RATE, \
+			   GENMASK(8, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_AMPDU_TIME_SEL BIT(0)
+#define SET_CMC_TBL_AMPDU_TIME_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(9)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_AMPDU_TIME_SEL, \
+			   BIT(9)); \
+} while (0)
+#define SET_CMC_TBL_MASK_AMPDU_LEN_SEL BIT(0)
+#define SET_CMC_TBL_AMPDU_LEN_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(10)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_AMPDU_LEN_SEL, \
+			   BIT(10)); \
+} while (0)
+#define SET_CMC_TBL_MASK_RTS_TXCNT_LMT_SEL BIT(0)
+#define SET_CMC_TBL_RTS_TXCNT_LMT_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(11)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_TXCNT_LMT_SEL, \
+			   BIT(11)); \
+} while (0)
+#define SET_CMC_TBL_MASK_RTS_TXCNT_LMT GENMASK(3, 0)
+#define SET_CMC_TBL_RTS_TXCNT_LMT(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(15, 12)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_TXCNT_LMT, \
+			   GENMASK(15, 12)); \
+} while (0)
+#define SET_CMC_TBL_MASK_RTSRATE GENMASK(8, 0)
+#define SET_CMC_TBL_RTSRATE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(24, 16)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTSRATE, \
+			   GENMASK(24, 16)); \
+} while (0)
+#define SET_CMC_TBL_MASK_VCS_STBC BIT(0)
+#define SET_CMC_TBL_VCS_STBC(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, BIT(27)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_VCS_STBC, \
+			   BIT(27)); \
+} while (0)
+#define SET_CMC_TBL_MASK_RTS_RTY_LOWEST_RATE GENMASK(3, 0)
+#define SET_CMC_TBL_RTS_RTY_LOWEST_RATE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 2, val, GENMASK(31, 28)); \
+	le32p_replace_bits((__le32 *)(table) + 10, SET_CMC_TBL_MASK_RTS_RTY_LOWEST_RATE, \
+			   GENMASK(31, 28)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_TX_CNT_LMT GENMASK(5, 0)
+#define SET_CMC_TBL_DATA_TX_CNT_LMT(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(5, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_DATA_TX_CNT_LMT, \
+			   GENMASK(5, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_TXCNT_LMT_SEL BIT(0)
+#define SET_CMC_TBL_DATA_TXCNT_LMT_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(6)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_DATA_TXCNT_LMT_SEL, \
+			   BIT(6)); \
+} while (0)
+#define SET_CMC_TBL_MASK_MAX_AGG_NUM_SEL BIT(0)
+#define SET_CMC_TBL_MAX_AGG_NUM_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(7)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_MAX_AGG_NUM_SEL, \
+			   BIT(7)); \
+} while (0)
+#define SET_CMC_TBL_MASK_RTS_EN BIT(0)
+#define SET_CMC_TBL_RTS_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(8)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_RTS_EN, \
+			   BIT(8)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CTS2SELF_EN BIT(0)
+#define SET_CMC_TBL_CTS2SELF_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(9)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_CTS2SELF_EN, \
+			   BIT(9)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CCA_RTS GENMASK(1, 0)
+#define SET_CMC_TBL_CCA_RTS(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(11, 10)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_CCA_RTS, \
+			   GENMASK(11, 10)); \
+} while (0)
+#define SET_CMC_TBL_MASK_HW_RTS_EN BIT(0)
+#define SET_CMC_TBL_HW_RTS_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(12)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_HW_RTS_EN, \
+			   BIT(12)); \
+} while (0)
+#define SET_CMC_TBL_MASK_RTS_DROP_DATA_MODE GENMASK(1, 0)
+#define SET_CMC_TBL_RTS_DROP_DATA_MODE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(14, 13)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_RTS_DROP_DATA_MODE, \
+			   GENMASK(14, 13)); \
+} while (0)
+#define SET_CMC_TBL_MASK_AMPDU_MAX_LEN GENMASK(10, 0)
+#define SET_CMC_TBL_AMPDU_MAX_LEN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(26, 16)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_AMPDU_MAX_LEN, \
+			   GENMASK(26, 16)); \
+} while (0)
+#define SET_CMC_TBL_MASK_UL_MU_DIS BIT(0)
+#define SET_CMC_TBL_UL_MU_DIS(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, BIT(27)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_UL_MU_DIS, \
+			   BIT(27)); \
+} while (0)
+#define SET_CMC_TBL_MASK_AMPDU_MAX_TIME GENMASK(3, 0)
+#define SET_CMC_TBL_AMPDU_MAX_TIME(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 3, val, GENMASK(31, 28)); \
+	le32p_replace_bits((__le32 *)(table) + 11, SET_CMC_TBL_MASK_AMPDU_MAX_TIME, \
+			   GENMASK(31, 28)); \
+} while (0)
+#define SET_CMC_TBL_MASK_MAX_AGG_NUM GENMASK(7, 0)
+#define SET_CMC_TBL_MAX_AGG_NUM(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(7, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_MAX_AGG_NUM, \
+			   GENMASK(7, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_BA_BMAP GENMASK(1, 0)
+#define SET_CMC_TBL_BA_BMAP(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(9, 8)); \
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BA_BMAP, \
+			   GENMASK(9, 8)); \
+} while (0)
+#define SET_CMC_TBL_MASK_VO_LFTIME_SEL GENMASK(2, 0)
+#define SET_CMC_TBL_VO_LFTIME_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(18, 16)); \
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_VO_LFTIME_SEL, \
+			   GENMASK(18, 16)); \
+} while (0)
+#define SET_CMC_TBL_MASK_VI_LFTIME_SEL GENMASK(2, 0)
+#define SET_CMC_TBL_VI_LFTIME_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(21, 19)); \
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_VI_LFTIME_SEL, \
+			   GENMASK(21, 19)); \
+} while (0)
+#define SET_CMC_TBL_MASK_BE_LFTIME_SEL GENMASK(2, 0)
+#define SET_CMC_TBL_BE_LFTIME_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(24, 22)); \
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BE_LFTIME_SEL, \
+			   GENMASK(24, 22)); \
+} while (0)
+#define SET_CMC_TBL_MASK_BK_LFTIME_SEL GENMASK(2, 0)
+#define SET_CMC_TBL_BK_LFTIME_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(27, 25)); \
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_BK_LFTIME_SEL, \
+			   GENMASK(27, 25)); \
+} while (0)
+#define SET_CMC_TBL_MASK_SECTYPE GENMASK(3, 0)
+#define SET_CMC_TBL_SECTYPE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 4, val, GENMASK(31, 28)); \
+	le32p_replace_bits((__le32 *)(table) + 12, SET_CMC_TBL_MASK_SECTYPE, \
+			   GENMASK(31, 28)); \
+} while (0)
+#define SET_CMC_TBL_MASK_MULTI_PORT_ID GENMASK(2, 0)
+#define SET_CMC_TBL_MULTI_PORT_ID(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(2, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_MULTI_PORT_ID, \
+			   GENMASK(2, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_BMC BIT(0)
+#define SET_CMC_TBL_BMC(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(3)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_BMC, \
+			   BIT(3)); \
+} while (0)
+#define SET_CMC_TBL_MASK_MBSSID GENMASK(3, 0)
+#define SET_CMC_TBL_MBSSID(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(7, 4)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_MBSSID, \
+			   GENMASK(7, 4)); \
+} while (0)
+#define SET_CMC_TBL_MASK_NAVUSEHDR BIT(0)
+#define SET_CMC_TBL_NAVUSEHDR(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(8)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_NAVUSEHDR, \
+			   BIT(8)); \
+} while (0)
+#define SET_CMC_TBL_MASK_TXPWR_MODE GENMASK(2, 0)
+#define SET_CMC_TBL_TXPWR_MODE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(11, 9)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_TXPWR_MODE, \
+			   GENMASK(11, 9)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_DCM BIT(0)
+#define SET_CMC_TBL_DATA_DCM(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(12)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_DCM, \
+			   BIT(12)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_ER BIT(0)
+#define SET_CMC_TBL_DATA_ER(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(13)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_ER, \
+			   BIT(13)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_LDPC BIT(0)
+#define SET_CMC_TBL_DATA_LDPC(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(14)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_LDPC, \
+			   BIT(14)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_STBC BIT(0)
+#define SET_CMC_TBL_DATA_STBC(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(15)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_STBC, \
+			   BIT(15)); \
+} while (0)
+#define SET_CMC_TBL_MASK_A_CTRL_BQR BIT(0)
+#define SET_CMC_TBL_A_CTRL_BQR(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(16)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_BQR, \
+			   BIT(16)); \
+} while (0)
+#define SET_CMC_TBL_MASK_A_CTRL_UPH BIT(0)
+#define SET_CMC_TBL_A_CTRL_UPH(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(17)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_UPH, \
+			   BIT(17)); \
+} while (0)
+#define SET_CMC_TBL_MASK_A_CTRL_BSR BIT(0)
+#define SET_CMC_TBL_A_CTRL_BSR(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(18)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_BSR, \
+			   BIT(18)); \
+} while (0)
+#define SET_CMC_TBL_MASK_A_CTRL_CAS BIT(0)
+#define SET_CMC_TBL_A_CTRL_CAS(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(19)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_A_CTRL_CAS, \
+			   BIT(19)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DATA_BW_ER BIT(0)
+#define SET_CMC_TBL_DATA_BW_ER(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(20)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_DATA_BW_ER, \
+			   BIT(20)); \
+} while (0)
+#define SET_CMC_TBL_MASK_LSIG_TXOP_EN BIT(0)
+#define SET_CMC_TBL_LSIG_TXOP_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(21)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_LSIG_TXOP_EN, \
+			   BIT(21)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CTRL_CNT_VLD BIT(0)
+#define SET_CMC_TBL_CTRL_CNT_VLD(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, BIT(27)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_CTRL_CNT_VLD, \
+			   BIT(27)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CTRL_CNT GENMASK(3, 0)
+#define SET_CMC_TBL_CTRL_CNT(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 5, val, GENMASK(31, 28)); \
+	le32p_replace_bits((__le32 *)(table) + 13, SET_CMC_TBL_MASK_CTRL_CNT, \
+			   GENMASK(31, 28)); \
+} while (0)
+#define SET_CMC_TBL_MASK_RESP_REF_RATE GENMASK(8, 0)
+#define SET_CMC_TBL_RESP_REF_RATE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(8, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_RESP_REF_RATE, \
+			   GENMASK(8, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ALL_ACK_SUPPORT BIT(0)
+#define SET_CMC_TBL_ALL_ACK_SUPPORT(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(12)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ALL_ACK_SUPPORT, \
+			   BIT(12)); \
+} while (0)
+#define SET_CMC_TBL_MASK_BSR_QUEUE_SIZE_FORMAT BIT(0)
+#define SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(13)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_BSR_QUEUE_SIZE_FORMAT, \
+			   BIT(13)); \
+} while (0)
+#define SET_CMC_TBL_MASK_NTX_PATH_EN GENMASK(3, 0)
+#define SET_CMC_TBL_NTX_PATH_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(19, 16)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_NTX_PATH_EN, \
+			   GENMASK(19, 16)); \
+} while (0)
+#define SET_CMC_TBL_MASK_PATH_MAP_A GENMASK(1, 0)
+#define SET_CMC_TBL_PATH_MAP_A(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(21, 20)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_A, \
+			   GENMASK(21, 20)); \
+} while (0)
+#define SET_CMC_TBL_MASK_PATH_MAP_B GENMASK(1, 0)
+#define SET_CMC_TBL_PATH_MAP_B(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(23, 22)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_B, \
+			   GENMASK(23, 22)); \
+} while (0)
+#define SET_CMC_TBL_MASK_PATH_MAP_C GENMASK(1, 0)
+#define SET_CMC_TBL_PATH_MAP_C(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(25, 24)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_C, \
+			   GENMASK(25, 24)); \
+} while (0)
+#define SET_CMC_TBL_MASK_PATH_MAP_D GENMASK(1, 0)
+#define SET_CMC_TBL_PATH_MAP_D(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, GENMASK(27, 26)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_PATH_MAP_D, \
+			   GENMASK(27, 26)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ANTSEL_A BIT(0)
+#define SET_CMC_TBL_ANTSEL_A(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(28)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_A, \
+			   BIT(28)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ANTSEL_B BIT(0)
+#define SET_CMC_TBL_ANTSEL_B(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(29)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_B, \
+			   BIT(29)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ANTSEL_C BIT(0)
+#define SET_CMC_TBL_ANTSEL_C(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(30)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_C, \
+			   BIT(30)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ANTSEL_D BIT(0)
+#define SET_CMC_TBL_ANTSEL_D(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 6, val, BIT(31)); \
+	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_D, \
+			   BIT(31)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ADDR_CAM_INDEX GENMASK(7, 0)
+#define SET_CMC_TBL_ADDR_CAM_INDEX(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(7, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_ADDR_CAM_INDEX, \
+			   GENMASK(7, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_PAID GENMASK(8, 0)
+#define SET_CMC_TBL_PAID(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(16, 8)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_PAID, \
+			   GENMASK(16, 8)); \
+} while (0)
+#define SET_CMC_TBL_MASK_ULDL BIT(0)
+#define SET_CMC_TBL_ULDL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, BIT(17)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_ULDL, \
+			   BIT(17)); \
+} while (0)
+#define SET_CMC_TBL_MASK_DOPPLER_CTRL GENMASK(1, 0)
+#define SET_CMC_TBL_DOPPLER_CTRL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(19, 18)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_DOPPLER_CTRL, \
+			   GENMASK(19, 18)); \
+} while (0)
+#define SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING GENMASK(1, 0)
+#define SET_CMC_TBL_NOMINAL_PKT_PADDING(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(21, 20)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING, \
+			   GENMASK(21, 20)); \
+} while (0)
+#define SET_CMC_TBL_NOMINAL_PKT_PADDING40(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(23, 22)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING, \
+			   GENMASK(23, 22)); \
+} while (0)
+#define SET_CMC_TBL_MASK_TXPWR_TOLERENCE GENMASK(3, 0)
+#define SET_CMC_TBL_TXPWR_TOLERENCE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(27, 24)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_TXPWR_TOLERENCE, \
+			   GENMASK(27, 24)); \
+} while (0)
+#define SET_CMC_TBL_NOMINAL_PKT_PADDING80(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(31, 30)); \
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING, \
+			   GENMASK(31, 30)); \
+} while (0)
+#define SET_CMC_TBL_MASK_NC GENMASK(2, 0)
+#define SET_CMC_TBL_NC(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(2, 0)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NC, \
+			   GENMASK(2, 0)); \
+} while (0)
+#define SET_CMC_TBL_MASK_NR GENMASK(2, 0)
+#define SET_CMC_TBL_NR(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(5, 3)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NR, \
+			   GENMASK(5, 3)); \
+} while (0)
+#define SET_CMC_TBL_MASK_NG GENMASK(1, 0)
+#define SET_CMC_TBL_NG(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(7, 6)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NG, \
+			   GENMASK(7, 6)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CB GENMASK(1, 0)
+#define SET_CMC_TBL_CB(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(9, 8)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CB, \
+			   GENMASK(9, 8)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CS GENMASK(1, 0)
+#define SET_CMC_TBL_CS(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(11, 10)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CS, \
+			   GENMASK(11, 10)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_TXBF_EN BIT(0)
+#define SET_CMC_TBL_CSI_TXBF_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(12)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_TXBF_EN, \
+			   BIT(12)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_STBC_EN BIT(0)
+#define SET_CMC_TBL_CSI_STBC_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(13)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_STBC_EN, \
+			   BIT(13)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_LDPC_EN BIT(0)
+#define SET_CMC_TBL_CSI_LDPC_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(14)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_LDPC_EN, \
+			   BIT(14)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_PARA_EN BIT(0)
+#define SET_CMC_TBL_CSI_PARA_EN(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(15)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_PARA_EN, \
+			   BIT(15)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_FIX_RATE GENMASK(8, 0)
+#define SET_CMC_TBL_CSI_FIX_RATE(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(24, 16)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_FIX_RATE, \
+			   GENMASK(24, 16)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_GI_LTF GENMASK(2, 0)
+#define SET_CMC_TBL_CSI_GI_LTF(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(27, 25)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GI_LTF, \
+			   GENMASK(27, 25)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_GID_SEL BIT(0)
+#define SET_CMC_TBL_CSI_GID_SEL(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(29)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GID_SEL, \
+			   BIT(29)); \
+} while (0)
+#define SET_CMC_TBL_MASK_CSI_BW GENMASK(1, 0)
+#define SET_CMC_TBL_CSI_BW(table, val) \
+do { \
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(31, 30)); \
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_BW, \
+			   GENMASK(31, 30)); \
+} while (0)
+
+#define SET_FWROLE_MAINTAIN_MACID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0))
+#define SET_FWROLE_MAINTAIN_SELF_ROLE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(9, 8))
+#define SET_FWROLE_MAINTAIN_UPD_MODE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(12, 10))
+#define SET_FWROLE_MAINTAIN_WIFI_ROLE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(16, 13))
+
+#define SET_JOININFO_MACID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0))
+#define SET_JOININFO_OP(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, BIT(8))
+#define SET_JOININFO_BAND(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, BIT(9))
+#define SET_JOININFO_WMM(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(11, 10))
+#define SET_JOININFO_TGR(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, BIT(12))
+#define SET_JOININFO_ISHESTA(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, BIT(13))
+#define SET_JOININFO_DLBW(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 14))
+#define SET_JOININFO_TF_MAC_PAD(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(17, 16))
+#define SET_JOININFO_DL_T_PE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(20, 18))
+#define SET_JOININFO_PORT_ID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 21))
+#define SET_JOININFO_NET_TYPE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(25, 24))
+#define SET_JOININFO_WIFI_ROLE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(29, 26))
+#define SET_JOININFO_SELF_ROLE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 30))
+
+#define SET_GENERAL_PKT_MACID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0))
+#define SET_GENERAL_PKT_PROBRSP_ID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8))
+#define SET_GENERAL_PKT_PSPOLL_ID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 16))
+#define SET_GENERAL_PKT_NULL_ID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24))
+#define SET_GENERAL_PKT_QOS_NULL_ID(h2c, val) \
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(7, 0))
+#define SET_GENERAL_PKT_CTS2SELF_ID(h2c, val) \
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(15, 8))
+
+#define SET_BA_CAM_VALID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, BIT(0))
+#define SET_BA_CAM_INIT_REQ(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, BIT(1))
+#define SET_BA_CAM_ENTRY_IDX(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(3, 2))
+#define SET_BA_CAM_TID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 4))
+#define SET_BA_CAM_MACID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8))
+#define SET_BA_CAM_BMAP_SIZE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(19, 16))
+#define SET_BA_CAM_SSN(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 20))
+
+#define SET_LPS_PARM_MACID(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0))
+#define SET_LPS_PARM_PSMODE(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(15, 8))
+#define SET_LPS_PARM_RLBM(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(19, 16))
+#define SET_LPS_PARM_SMARTPS(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(23, 20))
+#define SET_LPS_PARM_AWAKEINTERVAL(h2c, val) \
+	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24))
+#define SET_LPS_PARM_VOUAPSD(h2c, val) \
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, BIT(0))
+#define SET_LPS_PARM_VIUAPSD(h2c, val) \
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, BIT(1))
+#define SET_LPS_PARM_BEUAPSD(h2c, val) \
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, BIT(2))
+#define SET_LPS_PARM_BKUAPSD(h2c, val) \
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, BIT(3))
+#define SET_LPS_PARM_LASTRPWM(h2c, val) \
+	le32p_replace_bits((__le32 *)(h2c) + 1, val, GENMASK(15, 8))
+
+#define RTW89_GET_C2H_CATEGORY(c2h) \
+	le32_get_bits(*((__le32 *)c2h), GENMASK(1, 0))
+#define RTW89_GET_C2H_CLASS(c2h) \
+	le32_get_bits(*((__le32 *)c2h), GENMASK(7, 2))
+#define RTW89_GET_C2H_FUNC(c2h) \
+	le32_get_bits(*((__le32 *)c2h), GENMASK(15, 8))
+#define RTW89_GET_C2H_LEN(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 1), GENMASK(13, 0))
+
+#define RTW89_GET_MAC_C2H_DONE_ACK_CAT(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(1, 0))
+#define RTW89_GET_MAC_C2H_DONE_ACK_CLASS(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(7, 2))
+#define RTW89_GET_MAC_C2H_DONE_ACK_FUNC(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(15, 8))
+#define RTW89_GET_MAC_C2H_DONE_ACK_H2C_RETURN(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(23, 16))
+#define RTW89_GET_MAC_C2H_DONE_ACK_H2C_SEQ(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(31, 24))
+
+#define RTW89_GET_MAC_C2H_REV_ACK_CAT(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(1, 0))
+#define RTW89_GET_MAC_C2H_REV_ACK_CLASS(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(7, 2))
+#define RTW89_GET_MAC_C2H_REV_ACK_FUNC(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(15, 8))
+#define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(23, 16))
+
+#define RTW89_GET_PHY_C2H_RA_RPT_MACID(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(15, 0))
+#define RTW89_GET_PHY_C2H_RA_RPT_RETRY_RATIO(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 2), GENMASK(23, 16))
+#define RTW89_GET_PHY_C2H_RA_RPT_MCSNSS(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(6, 0))
+#define RTW89_GET_PHY_C2H_RA_RPT_MD_SEL(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(9, 8))
+#define RTW89_GET_PHY_C2H_RA_RPT_GILTF(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(12, 10))
+#define RTW89_GET_PHY_C2H_RA_RPT_BW(c2h) \
+	le32_get_bits(*((__le32 *)(c2h) + 3), GENMASK(14, 13))
+
+#define RTW89_RA_RATE_MASK_NSS GENMASK(6, 4)
+#define RTW89_RA_RATE_MASK_MCS GENMASK(3, 0)
+#define RTW89_MK_HT_RATE(nss, mcs) (FIELD_PREP(GENMASK(4, 3), nss) | \
+				    FIELD_PREP(GENMASK(2, 0), mcs))
+
+#define RTW89_FW_HDR_SIZE 32
+#define RTW89_FW_SECTION_HDR_SIZE 16
+
+#define RTW89_MFW_SIG	0xFF
+
+struct rtw89_mfw_info {
+	u8 cv;
+	u8 type; /* enum rtw89_fw_type */
+	u8 mp;
+	u8 rsvd;
+	__le32 shift;
+	__le32 size;
+	u8 rsvd2[4];
+} __packed;
+
+struct rtw89_mfw_hdr {
+	u8 sig;	/* RTW89_MFW_SIG */
+	u8 fw_nr;
+	u8 rsvd[14];
+	struct rtw89_mfw_info info[];
+} __packed;
+
+struct fwcmd_hdr {
+	__le32 hdr0;
+	__le32 hdr1;
+};
+
+#define RTW89_H2C_RF_PAGE_SIZE 500
+#define RTW89_H2C_RF_PAGE_NUM 3
+struct rtw89_fw_h2c_rf_reg_info {
+	enum rtw89_rf_path rf_path;
+	__le32 rtw89_phy_config_rf_h2c[RTW89_H2C_RF_PAGE_NUM][RTW89_H2C_RF_PAGE_SIZE];
+	u16 curr_idx;
+};
+
+#define H2C_SEC_CAM_LEN			24
+
+#define H2C_HEADER_LEN			8
+#define H2C_HDR_CAT			GENMASK(1, 0)
+#define H2C_HDR_CLASS			GENMASK(7, 2)
+#define H2C_HDR_FUNC			GENMASK(15, 8)
+#define H2C_HDR_DEL_TYPE		GENMASK(19, 16)
+#define H2C_HDR_H2C_SEQ			GENMASK(31, 24)
+#define H2C_HDR_TOTAL_LEN		GENMASK(13, 0)
+#define H2C_HDR_REC_ACK			BIT(14)
+#define H2C_HDR_DONE_ACK		BIT(15)
+
+#define FWCMD_TYPE_H2C			0
+
+#define H2C_CAT_MAC		0x1
+
+/* CLASS 0 - FW INFO */
+#define H2C_CL_FW_INFO			0x0
+#define H2C_FUNC_MAC_GENERAL_PKT	0x1
+
+/* CLASS 2 - PS */
+#define H2C_CL_MAC_PS			0x2
+#define H2C_FUNC_MAC_LPS_PARM		0x0
+
+/* CLASS 3 - FW download */
+#define H2C_CL_MAC_FWDL		0x3
+#define H2C_FUNC_MAC_FWHDR_DL		0x0
+
+/* CLASS 5 - Frame Exchange */
+#define H2C_CL_MAC_FR_EXCHG		0x5
+#define H2C_FUNC_MAC_CCTLINFO_UD	0x2
+
+/* CLASS 6 - Address CAM */
+#define H2C_CL_MAC_ADDR_CAM_UPDATE	0x6
+#define H2C_FUNC_MAC_ADDR_CAM_UPD	0x0
+
+/* CLASS 8 - Media Status Report */
+#define H2C_CL_MAC_MEDIA_RPT		0x8
+#define H2C_FUNC_MAC_JOININFO		0x0
+#define H2C_FUNC_MAC_FWROLE_MAINTAIN	0x4
+
+/* CLASS 9 - FW offload */
+#define H2C_CL_MAC_FW_OFLD		0x9
+#define H2C_FUNC_MAC_MACID_PAUSE	0x8
+#define H2C_FUNC_USR_EDCA		0xF
+#define H2C_FUNC_OFLD_CFG		0x14
+
+/* CLASS 10 - Security CAM */
+#define H2C_CL_MAC_SEC_CAM		0xa
+#define H2C_FUNC_MAC_SEC_UPD		0x1
+
+/* CLASS 12 - BA CAM */
+#define H2C_CL_BA_CAM			0xc
+#define H2C_FUNC_MAC_BA_CAM		0x0
+
+#define H2C_CAT_OUTSRC			0x2
+
+#define H2C_CL_OUTSRC_RA		0x1
+#define H2C_FUNC_OUTSRC_RA_MACIDCFG	0x0
+
+#define H2C_CL_OUTSRC_RF_REG_A		0x8
+#define H2C_CL_OUTSRC_RF_REG_B		0x9
+
+int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
+int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
+int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
+int rtw89_load_firmware(struct rtw89_dev *rtwdev);
+void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
+int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev);
+void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
+			   u8 type, u8 cat, u8 class, u8 func,
+			   bool rack, bool dack, u32 len);
+int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev, u8 macid);
+int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta);
+int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
+				 struct rtw89_sta *rtwsta);
+int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
+void rtw89_fw_c2h_work(struct work_struct *work);
+int rtw89_fw_h2c_vif_maintain(struct rtw89_dev *rtwdev,
+			      struct rtw89_vif *rtwvif,
+			      enum rtw89_upd_mode upd_mode);
+int rtw89_fw_h2c_join_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   u8 dis_conn);
+int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
+			     bool pause);
+int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			  u8 ac, u32 val);
+int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi);
+int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
+			struct rtw89_fw_h2c_rf_reg_info *info,
+			u16 len, u8 page);
+int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
+			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
+			      bool rack, bool dack);
+int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len);
+int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid);
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, bool valid, u8 macid,
+			struct ieee80211_ampdu_params *params);
+int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev, u8 macid);
+struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(u32 len);
+struct sk_buff *rtw89_fw_h2c_alloc_skb_no_hdr(u32 len);
+int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
+		     struct rtw89_mac_h2c_info *h2c_info,
+		     struct rtw89_mac_c2h_info *c2h_info);
+
+static __always_inline void RTW89_SET_FWCMD(u8 *cmd, u32 val, u8 offset, u32 mask)
+{
+	u32 *cmd32 = (u32 *)cmd;
+
+	le32p_replace_bits((__le32 *)(cmd32 + offset), val, mask);
+}
+
+#endif
-- 
2.21.0

