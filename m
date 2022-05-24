Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB30532986
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiEXLlj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiEXLlf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B9D41316
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmA2g69I2MKneHs6rxRuya8wRBG3TMyh/5F4jpJstQgbnQ4/OK6CGD0xwHCcI8r6vhogDD0z9/rpY5QZF3t3/4YSPYrc+3oqhlC1U0jkX59amJ4pyACz341G7bOnDOXkfJgj4OJRXm7RM7XS7c6j5rycqf0acNFMPqQDmJW65mXG0A/7dhCIs5tPvOdhwF33Ga1N15psTQjFpQR5F+0kxvHbRDGjys7skSaDidMO3BlVjZSt/HWlzhUhKmppkBaNsq5B1kCAU0dWX6VkDOASAENO8WDz6IyaI0Vl6+GVPo4jOO+0E+5lSLmNg52qoMkTruPYf6dkFK8a3pfc6pItsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv3Azjr+w6grboMjCEQiIIVS7F/Ov3OpdstixAN8Moc=;
 b=Nr4xkNzlbCGv/4FEEC2nikUk1dh1MXqgze2mka+jB4yiRD2oB1lEfg/PxBvxdt1LxsLB6oWOImhPCAKQrnZEjm1pP21aAXX6q7G84So+3n7owoaFkj7tVtlokflB43d2jQ1E4m+uhbRyE+5opOG6dDmEtKKleOxhDZU4yBkXw11Md+4AKZ14wuWi1El+rwWdE5ujYn6GCIKzoRdg3KaQaWwGlrf0tf4gx5JyA5gJlW5l5/Qyf3r/fOFIZ7lrNvWkjRvFeOJmT1xfQJtdBBRH+dStaVVoZxbIC0hgNvlj+WJpoX368eoCo+aD1J39E55GqhQurme5N5tlaC39bbE6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv3Azjr+w6grboMjCEQiIIVS7F/Ov3OpdstixAN8Moc=;
 b=y09XWT+3Cz7YIS+XH6RMrLJlhrKtroZ6Ju0JvZaQ157ujnW1kKxJ/32g3/pV0KLmYOl3RnbFWObVNgUOBD74xVV/MyDv8FpNQcl21kwi9C/znAqNwWlORvIlOjtfcNyEhz/TPqRRauiJTK/hO9zFjgPYI/1t3wvRwHsc4Uz77WE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:33 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 87/96] cl8k: add utils.h
Date:   Tue, 24 May 2022 14:34:53 +0300
Message-Id: <20220524113502.1094459-88-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b7de008-f36f-47b1-20da-08da3d79fe5a
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0669D2171731D1A06CD6F437F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bc0CB20GHBakoVz6zAmDpfKwDMevHSN8D2o9iFHoIMo07AjJ+b5nlMu/IcLELrKvgdsmc6PJpqfOH4ilVs5ju3/5POETsI9EHbOLRH6blulsqRnkRVqWO9/8Kls9M5i3KT1S1ZwMFuCMjlUXxxFkoM3YmRdcGgncfEu1lqON0ec2AGbwdsApDChkAmXuQjSyUkE9hlVZtC8JQ137KggRgxzShlB+kOZo2udWGItiNfrKAR1CWIr9uXyv7SdV27LARgnMs0soPTjSWGpwOTXMG9DzrPDd2BVyowJaBSPY9ARyluFdDlsn17z1B+GQ6mWAZcegPU3CA1omZ92Z0YmHfQPVYDWy+9ViCTp1DE93sOu3+AJ+zHnb5pWwFPQqZeipLH/acluZwgRBPRkm74uH4PgDOXdIWc77CUJ5RlfqeuG6F/3h6jqL/jKjKNotWfZb/G4YR2GlC3zSAktWewicAc972wQJFYpowXa/Oa15bbHEPHYeI2pW6ltLX6pezR0iXeAklbgZO5WK6wUthLoJp08dFstWFdmGvNGhUHxC/cdDWQbXA8Ck+dAOL/N7vrQFstfrQexTj9LReDWDEc9YMLOb+OTMlODkbdczQLfrA7+SJ0yDaOJSLPyf56OnbELm12ZgRq2MZ3fskRhm+nq3p1Fh0Wo0b80D1WNpCPWJ9ZDKI1ORb/h/pqz5Jh+LGrhvPE5UrAMwtJ4Dw5yaoIZYPYD0oEaKhdV0V3AURfAMOuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbHyk4SePv3cQPm6qp3JZ4NM76fodeCW6Xcrc2wFc/YdOFhk7nEt24b5SvbH?=
 =?us-ascii?Q?EOjQuKLq7FcU+UXhudYgheYNqetF5fs6xza/dtTTaZ6ZDuGnxkMZV5h4mtQi?=
 =?us-ascii?Q?tnuGt01HtQ3GCPNS0Cfg4ZKKmO+tyx70VWdYNvePCn+0et0V6xnNIFmiMxWD?=
 =?us-ascii?Q?Kp2s0anjPqblww5r1+OvTBakCrou2KyTrmV9IMhfOhjhK4jWtfGRHYsrPyz8?=
 =?us-ascii?Q?f+Py9bi/0ki+oyftyj8OoNuNL0L9jNWr0LXFo5v/tgKICgmiosY42JhEP7NX?=
 =?us-ascii?Q?q1xjTAeDXqgfX52ih6oj+oHBulcvr4cMziuZSfSJ87qFzkVhEoUNkZAwcf5i?=
 =?us-ascii?Q?DPDDd6xfmzcVhT2OI1yY5kkNPYIVrDHbNCdTbUAARFXieCvVPvpk/1f77R/t?=
 =?us-ascii?Q?d/WPoG6++h6nXsDyD9Y8YmKc/mSEkLAg/bAxtFrCy9RFChRUc0eycZ4ohT+/?=
 =?us-ascii?Q?lB2H4DGPlGzAxBQ0HbdprrYOBIw2dXOnaXFTkEYj8EYWmq8xDO8M22uZY9/j?=
 =?us-ascii?Q?AB6g+0MWuf/swyx6Fw4//kD0cqFO3bviXWkonK6h/gCfIchBrky6fXyngcTB?=
 =?us-ascii?Q?DtF4kUFUbslY7X2+U/R+ajSEpdn77MiKfrb0w7vEmt4KFSCL/Oc8WYFv5r3c?=
 =?us-ascii?Q?cZmf7tFzYugMNqce2yjTs5rGoF+n+gBPe9oI2UdgdNtdxjv1LLvLxFeqhfKF?=
 =?us-ascii?Q?mtUtXmvuOx4AEADLYNVoyPyX7Lky6vZ288VD9h6tU3nihzc3n1KHoi+iqFFg?=
 =?us-ascii?Q?WzbLnMhhaPJGTxpRRdwt6n52hKCh1ynx9xoLrKSAUuZZCgBesjo0ekpnPQec?=
 =?us-ascii?Q?eHh3TkQoMRdTmLgue+XvQrYbx4aEolgJ3MkQvAErV7y+YtmKZGrNsUjwSeI5?=
 =?us-ascii?Q?efBd3Zdvs/gOQpgV+I40j77K9pY3/OC3sJ5EKZWgY24UI86iSJg/0E/uwDUs?=
 =?us-ascii?Q?TbjdFxOYm2TY3DNY+Xcs/dD16ut6mZv8pVd9cpwRNGczfPQrwWmIT/iQG7pF?=
 =?us-ascii?Q?NqF1/C8uQVGbP17f82qp4Gx+TFlx1oObGY6x92LcNR/ZWCEmlHssEW4mBKwg?=
 =?us-ascii?Q?O5E3P6yAM/M1DpxKbzYHH6p6PVLZAIXHNXqNC86sndL4ryChvftgUHYzj1ru?=
 =?us-ascii?Q?innpIhINtDZ3wS8r+NGCR7tykgGbYQYsk+NEBPlD1OFpsOKilTza8L0Ei+Xt?=
 =?us-ascii?Q?urFCsCp6W/1r50VgdzVfiUnQZbIhLdvmWMfOS4Kp+Vo1x/vMvW+L0BMeDXJz?=
 =?us-ascii?Q?Y6+oR50vc3XqeAQsuViyCQ97MlzveFXmS9hm/gTzH2aZVkiVjdQl2Kq07WiD?=
 =?us-ascii?Q?0cHVcUp4xzwFZOkhvdCZCMcHFwLc8GtG7gCRrPwxrHJ+1XfE9vuFJJp3eVbD?=
 =?us-ascii?Q?InjSrmbI6N+7GKgfbijBCg6nkH44W2zvXbGwM4AkmfmghlgzN8/++HiqCtaF?=
 =?us-ascii?Q?fXlGNwb2MGdShERNO53Nyk1UbipagPecaywwM9978Nw4elfILdgEjHuG3fsd?=
 =?us-ascii?Q?06PNkmEiiBNU9ptICXzLjqE266xANLiv5kb7qPsHrbc40L4s3Qo9ejNMZkBV?=
 =?us-ascii?Q?v91RmNzBrafsruv+Omt4hQeeVEgWp70esvgOyTi9NU2jhMH/kVp1HKH5WpvM?=
 =?us-ascii?Q?5rzHj/US5/UfP7nsBICTYCboHpDBeyrFbGkBd6u+zN0AFysJVtzFQ8FEU8GQ?=
 =?us-ascii?Q?EUkx7TOb31MmcF5r/zOnMdTcFrwxhDpTY5OQQmRCgGZAdi8fRSegCEa2TvgM?=
 =?us-ascii?Q?6/cZaASgwEtbIzxrZcK7Nyb7cSuKoMk=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7de008-f36f-47b1-20da-08da3d79fe5a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:59.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Q2+0BkXMa225GkI9yyzvGokMAnWz0nZgIsdoyFIR40ThakhSIUSbAeDK9Eq/286GcODtwYN4Wrui1MKD9prdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/utils.h | 185 +++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils.h

diff --git a/drivers/net/wireless/celeno/cl8k/utils.h b/drivers/net/wireless/celeno/cl8k/utils.h
new file mode 100644
index 000000000000..052687183dd3
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_UTILS_H
+#define CL_UTILS_H
+
+#include "def.h"
+#include "ieee80211_i.h"
+#include "chip.h"
+
+/*
+ * GI_LTF field for common info
+ * 0 - 1x HE-LTF + 1.6 us GI
+ * 1 - 2x HE-LTF + 1.6 us GI
+ * 2 - 4x HE-LTF + 3.2 us GI
+ */
+enum cl_he_ltf_gi {
+	HE_LTF_X1_GI_16, /* Not supported */
+	HE_LTF_X2_GI_16,
+	HE_LTF_X4_GI_32,
+
+	HE_LTF_MAX
+};
+
+#define CL_TF_GI_LTF_TO_GI(gi_ltf) \
+	((gi_ltf) == HE_LTF_X4_GI_32 ? WRS_GI_LONG : \
+	 ((gi_ltf) == HE_LTF_X2_GI_16 ? WRS_GI_SHORT : \
+	   ((gi_ltf) == HE_LTF_X1_GI_16 ? WRS_GI_SHORT : WRS_GI_LONG)))
+
+#define CL_TF_GI_TO_GI_LTF(gi) \
+	((gi) == WRS_GI_LONG ? HE_LTF_X4_GI_32 : \
+	 ((gi) == WRS_GI_SHORT ? HE_LTF_X2_GI_16 : \
+	   ((gi) == WRS_GI_VSHORT ? HE_LTF_X2_GI_16 : HE_LTF_X4_GI_32)))
+
+#define CL_TF_RU_ALLOC_MAX_TYPE_1 36
+#define CL_TF_RU_ALLOC_MAX_TYPE_2 52
+#define CL_TF_RU_ALLOC_MAX_TYPE_3 60
+#define CL_TF_RU_ALLOC_MAX_TYPE_4 64
+#define CL_TF_RU_ALLOC_MAX_TYPE_5 66
+#define CL_TF_RU_ALLOC_MAX_TYPE_6 67
+#define CL_TF_RU_ALLOC_MAX_TYPE_7 68
+
+/*
+ *IEEE80211 G Rate provided by Hostapd in WLAN_EID_SUPP_RATES EID
+ *EID Rate = ieee802Rate/5
+ */
+#define CL_80211G_RATE_6MB     12
+#define CL_80211G_RATE_9MB     18
+#define CL_80211G_RATE_12MB     24
+#define CL_80211G_RATE_18MB     36
+#define CL_80211G_RATE_24MB     48
+#define CL_80211G_RATE_36MB     72
+#define CL_80211G_RATE_48MB     96
+#define CL_80211G_RATE_54MB     108
+
+#define CL_SUPP_RATE_MASK     0x7F
+
+#define BAND_IS_5G_6G(cl_hw) \
+		(cl_band_is_5g(cl_hw) || cl_band_is_6g(cl_hw))
+
+static const u8 tid_to_ac[] = {
+	AC_BE, AC_BK, AC_BK, AC_BE, AC_VI, AC_VI, AC_VO, AC_VO
+};
+
+static inline u16 cl_adc_to_mv(u16 adc)
+{
+	return (adc * 1800) >> 12;
+}
+
+static inline struct ieee80211_vif *NETDEV_TO_VIF(struct net_device *dev)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+
+	if (!wdev)
+		return NULL;
+
+	return wdev_to_ieee80211_vif(wdev);
+}
+
+static inline struct cl_hw *NETDEV_TO_CL_HW(struct net_device *dev)
+{
+	struct ieee80211_hw *hw = wdev_priv(dev->ieee80211_ptr);
+
+	return hw->priv;
+}
+
+static inline struct cl_vif *NETDEV_TO_CL_VIF(struct net_device *dev)
+{
+	struct ieee80211_vif *vif = NETDEV_TO_VIF(dev);
+
+	WARN_ON(!vif);
+
+	if (unlikely(vif->type == NL80211_IFTYPE_AP_VLAN)) {
+		struct cl_hw *cl_hw = NETDEV_TO_CL_HW(dev);
+
+		return cl_vif_get_by_dev(cl_hw, dev);
+	}
+
+	return (struct cl_vif *)vif->drv_priv;
+}
+
+static inline struct cl_vif *TX_INFO_TO_CL_VIF(struct cl_hw *cl_hw,
+					       struct ieee80211_tx_info *tx_info)
+{
+	struct ieee80211_vif *vif = tx_info->control.vif;
+
+	WARN_ON(!vif);
+
+	if (unlikely(vif->type == NL80211_IFTYPE_AP_VLAN))
+		return cl_vif_get_by_mac(cl_hw, vif->addr);
+
+	return (struct cl_vif *)(vif->drv_priv);
+}
+
+void cl_hex_dump(char *caption, u8 *buffer, u32 length, u32 offset, bool is_byte);
+u8 cl_convert_gi_format_wrs_to_fw(u8 wrs_mode, u8 gi);
+u8 cl_convert_gi_format_fw_to_wrs(u8 format_mode, u8 gi);
+u8 cl_map_gi_to_ltf(u8 mode, u8 gi);
+s8 cl_calc_noise_floor(struct cl_hw *cl_hw, const s8 *reg_noise_floor);
+u8 cl_convert_signed_to_reg_value(s8 val);
+u8 cl_width_to_bw(enum nl80211_chan_width width);
+u8 cl_center_freq_offset(u8 bw);
+u8 cl_max_bw_idx(u8 wrs_mode, bool is_24g);
+bool cl_hw_mode_is_b_or_bg(struct cl_hw *cl_hw);
+bool cl_is_eapol(struct sk_buff *skb);
+u8 cl_ru_alloc_to_ru_type(u8 ru_alloc);
+bool cl_is_valid_g_rates(const u8 *rate_ie);
+enum cl_wireless_mode cl_recalc_wireless_mode(struct cl_hw *cl_hw,
+					      bool ieee80211n,
+					      bool ieee80211ac,
+					      bool ieee80211ax);
+
+enum cl_mu_ofdma_ru_type {
+	CL_MU_OFDMA_RU_TYPE_NONE = 0,
+	CL_MU_OFDMA_RU_TYPE_26,    /* 2.5MHz */
+	CL_MU_OFDMA_RU_TYPE_52,    /* 5MHz */
+	CL_MU_OFDMA_RU_TYPE_106,   /* 10MHz */
+	CL_MU_OFDMA_RU_TYPE_242,   /* 20MHz */
+	CL_MU_OFDMA_RU_TYPE_484,   /* 40MHz */
+	CL_MU_OFDMA_RU_TYPE_996,   /* 80MHz */
+	CL_MU_OFDMA_RU_TYPE_2x996, /* 160MHz */
+	CL_MU_OFDMA_RU_TYPE_MAX
+};
+
+enum nl80211_he_ru_alloc cl_ru_type_to_nl80211_he_ru_alloc(enum cl_mu_ofdma_ru_type ru_type);
+u8 cl_mu_ofdma_grp_convert_ru_type_to_bw(struct cl_hw *cl_hw, u8 ru_type);
+void cl_ieee802_11_parse_elems(const u8 *ies, size_t ies_len, struct ieee802_11_elems *elems);
+
+/*
+ * cl_file_open_and_read - Read the whole file into an allocated buffer.
+ *
+ * Allocates a buffer large enough to hold the contents of file at @filename and reads the
+ * contents of that file into that buffer. Upon success, the address of the allocated buffer
+ * is returned (which needs to be free later). Upon failure, returns NULL.
+ */
+size_t cl_file_open_and_read(struct cl_chip *chip, const char *filename,
+			     char **buf);
+
+/* Traffic analysis */
+/* Check if a packet has specific LLC fields e.g. DSAP, SSAP and Control */
+#define PKT_HAS_LLC_HDR(a) ((a[0] == 0xAA) && (a[1] == 0xAA) && (a[2] == 0x03))
+
+/* Multiply by 4 because IHL is number of 32-bit words */
+#define IPV4_HDR_LEN(ihl) ((ihl) << 2)
+
+bool cl_set_network_header_if_proto(struct sk_buff *skb, u16 protocol);
+bool cl_is_ipv4_packet(struct sk_buff *skb);
+bool cl_is_ipv6_packet(struct sk_buff *skb);
+bool cl_is_tcp_ack(struct sk_buff *skb, bool *syn_rst_push);
+
+/* Band helpers */
+bool cl_band_is_6g(struct cl_hw *cl_hw);
+bool cl_band_is_5g(struct cl_hw *cl_hw);
+bool cl_band_is_24g(struct cl_hw *cl_hw);
+u8 cl_band_to_fw_idx(struct cl_hw *cl_hw);
+u8 cl_band_from_fw_idx(u32 phy_band);
+
+static inline unsigned short cl_get_ether_type(int offset, unsigned char *src_buf)
+{
+	unsigned short type_len = *(unsigned short *)(src_buf + offset);
+
+	return (unsigned short)be16_to_cpu(htons(type_len));
+}
+
+#endif /* CL_UTILS_H */
-- 
2.36.1

