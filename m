Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D676A6CB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjHACMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHACMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187DC1B2
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712BqA32016485, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712BqA32016485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:11:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 1 Aug 2023 10:12:06 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:12:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: introduce infrastructure of firmware elements
Date:   Tue, 1 Aug 2023 10:11:25 +0800
Message-ID: <20230801021127.15919-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801021127.15919-1-pkshih@realtek.com>
References: <20230801021127.15919-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to pack more data into firmware file, we introduce firmware
elements and append BB_MCU firmware first. The first part of new firmware
file is still unchanged firmware of WiFi CPU, so the new firmware format
can be backward compatible to old format. The new elements part consists
of ID and size basically, which can append more elements simply. To avoid
unaligned access in certain platform and be easy to read, headers of all
elements start at 16-byte aligned address.

 +===========================================+
 |             original firmware             |
 |                             +-------------+
 |                             |   padding   |
 +===========================================+
 | elm ID 1 | elm size |  other header data  |
 +----------+----------+                     |
 |                                           |
 +-------------------------------------------+
 | content (variable length)                 |
 |                             +-------------+
 |                             |   padding   |
 +===========================================+
 | elm ID 2 | elm size |  other header data  |
 +----------+----------+                     |
 |                                           |
 +-------------------------------------------+
 | content (variable length)                 |
 |                   +-----------------------+
 |                   | (no padding for the last one)
 +===================+

More detail of element header is shown below. The additional fields
'version' and 'element_priv[]' are meta data of elements, so that we can
know element version easily, and element_priv[] provide specific fields
for certain element, such as RF path index for RF parameter tables.

 +===========================================+
 |  elm ID  | elm size | version  |   rsvd0  |
 +----------+----------+----------+----------+
 |        rsvd1/2      |  element_priv[]     |
 +-------------------------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  6 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 98 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 31 +++++++
 3 files changed, 135 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 48cfac6e41ffe..ed8119ef2da06 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3779,6 +3779,12 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	ret = rtw89_fw_recognize_elements(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to recognize firmware elements\n");
+		return ret;
+	}
+
 	ret = rtw89_chip_efuse_info_setup(rtwdev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 61b9af79f91dd..f613a50a747e4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -284,6 +284,26 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	return 0;
 }
 
+static u32 rtw89_mfw_get_size(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
+	const struct firmware *firmware = fw_info->req.firmware;
+	const struct rtw89_mfw_hdr *mfw_hdr =
+		(const struct rtw89_mfw_hdr *)firmware->data;
+	const struct rtw89_mfw_info *mfw_info;
+	u32 size;
+
+	if (mfw_hdr->sig != RTW89_MFW_SIG) {
+		rtw89_warn(rtwdev, "not mfw format\n");
+		return 0;
+	}
+
+	mfw_info = &mfw_hdr->info[mfw_hdr->fw_nr - 1];
+	size = le32_to_cpu(mfw_info->shift) + le32_to_cpu(mfw_info->size);
+
+	return size;
+}
+
 static void rtw89_fw_update_ver_v0(struct rtw89_dev *rtwdev,
 				   struct rtw89_fw_suit *fw_suit,
 				   const struct rtw89_fw_hdr *hdr)
@@ -366,6 +386,21 @@ int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	return rtw89_fw_update_ver(rtwdev, type, fw_suit);
 }
 
+static
+int __rtw89_fw_recognize_from_elm(struct rtw89_dev *rtwdev,
+				  const struct rtw89_fw_element_hdr *elm,
+				  const void *data)
+{
+	enum rtw89_fw_type type = (enum rtw89_fw_type)data;
+	struct rtw89_fw_suit *fw_suit;
+
+	fw_suit = rtw89_fw_suit_get(rtwdev, type);
+	fw_suit->data = elm->u.common.contents;
+	fw_suit->size = le32_to_cpu(elm->size);
+
+	return rtw89_fw_update_ver(rtwdev, type, fw_suit);
+}
+
 #define __DEF_FW_FEAT_COND(__cond, __op) \
 static bool __fw_feat_cond_ ## __cond(u32 suit_ver_code, u32 comp_ver_code) \
 { \
@@ -530,6 +565,69 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+struct rtw89_fw_element_handler {
+	int (*fn)(struct rtw89_dev *rtwdev,
+		  const struct rtw89_fw_element_hdr *elm, const void *data);
+	const void *data;
+	const char *name;
+};
+
+static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
+	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
+					(const void *)RTW89_FW_BBMCU0, NULL},
+	[RTW89_FW_ELEMENT_ID_BBMCU1] = {__rtw89_fw_recognize_from_elm,
+					(const void *)RTW89_FW_BBMCU1, NULL},
+};
+
+int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
+	const struct firmware *firmware = fw_info->req.firmware;
+	const struct rtw89_fw_element_handler *handler;
+	const struct rtw89_fw_element_hdr *hdr;
+	u32 elm_size;
+	u32 elem_id;
+	u32 offset;
+	int ret;
+
+	offset = rtw89_mfw_get_size(rtwdev);
+	offset = ALIGN(offset, RTW89_FW_ELEMENT_ALIGN);
+	if (offset == 0)
+		return -EINVAL;
+
+	while (offset + sizeof(*hdr) < firmware->size) {
+		hdr = (const struct rtw89_fw_element_hdr *)(firmware->data + offset);
+
+		elm_size = le32_to_cpu(hdr->size);
+		if (offset + elm_size >= firmware->size) {
+			rtw89_warn(rtwdev, "firmware element size exceeds\n");
+			break;
+		}
+
+		elem_id = le32_to_cpu(hdr->id);
+		if (elem_id >= ARRAY_SIZE(__fw_element_handlers))
+			goto next;
+
+		handler = &__fw_element_handlers[elem_id];
+		if (!handler->fn)
+			goto next;
+
+		ret = handler->fn(rtwdev, hdr, handler->data);
+		if (ret)
+			return ret;
+
+		if (handler->name)
+			rtw89_info(rtwdev, "Firmware element %s version: %4ph\n",
+				   handler->name, hdr->ver);
+
+next:
+		offset += sizeof(*hdr) + elm_size;
+		offset = ALIGN(offset, RTW89_FW_ELEMENT_ALIGN);
+	}
+
+	return 0;
+}
+
 void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   u8 type, u8 cat, u8 class, u8 func,
 			   bool rack, bool dack, u32 len)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index eb3300cd9147f..34dc96d949734 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3499,6 +3499,36 @@ struct rtw89_fw_logsuit_hdr {
 	__le32 ids[];
 } __packed;
 
+#define RTW89_FW_ELEMENT_ALIGN 16
+
+enum rtw89_fw_element_id {
+	RTW89_FW_ELEMENT_ID_BBMCU0 = 0,
+	RTW89_FW_ELEMENT_ID_BBMCU1 = 1,
+};
+
+struct rtw89_fw_element_hdr {
+	__le32 id; /* enum rtw89_fw_element_id */
+	__le32 size; /* exclude header size */
+	u8 ver[4];
+	__le32 rsvd0;
+	__le32 rsvd1;
+	__le32 rsvd2;
+	union {
+		struct {
+			u8 priv[8];
+			u8 contents[];
+		} __packed common;
+		struct {
+			u8 idx;
+			u8 rsvd[7];
+			struct {
+				__le32 addr;
+				__le32 data;
+			} __packed regs[];
+		} __packed reg2;
+	} __packed u;
+} __packed;
+
 struct fwcmd_hdr {
 	__le32 hdr0;
 	__le32 hdr1;
@@ -3680,6 +3710,7 @@ struct rtw89_fw_h2c_rf_get_mccch {
 
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
+int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev);
 const struct firmware *
 rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
-- 
2.25.1

