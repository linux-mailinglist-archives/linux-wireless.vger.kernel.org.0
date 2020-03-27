Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631CF195140
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgC0GdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49560 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgC0GdY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:24 -0400
IronPort-SDR: HBsXZD4FMuHU9y1yIM+NWXROZNQys7SXVwmTAS9bXpukJK3Y63xX6w2GoAzjbZ+1rlrrNr1wYq
 C5SYu1BcqY21l5JuovO/1kFmj3CH0pY5nFQJ7vuIj89zmf9/DteDaCiDAkUsraJrYYyBad+zmA
 URDP12x+oDKZe1r+oDhd/X1psAh/kkivFAuieQYkksCoauwfCg2sLLoBJShK2Mqb9CN4JqNztL
 V7r5er0fQdxgcljuqwFv3fLGVh7JaQ2Khk6uKI0Evn+XfzQDnjpkllRycITe4lY0YP1+zb1sdq
 5Kw=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="70452420"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 23:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBtIqvp/HwdZeUYTCrQuUeFZQY3kEhDqam639OCHH2E82SKWGa9UP0UirnWnusVxoy8kFQhIqnbNp/wRT5cyl4qXdyxs69ueIAXuxo9bk4+bpJ6KLcgFvS/1FtqDjCGJ4+tv47hnDTTfPUj/9UKdcHuvHS0ooT2uRGLFU8o2EljX9WmiVosaZT0urqx/hjjMEVdXxzmbiBDVjc9Zm3bi+wV2TMG9xjdWIrUYuUDokc5p8gNMZMR7/aOt7VVy1LipBJpUvUeJojfmR4c38DIu5zrrOxsOnDAe3Co1U9lhZlMjRoRNjDeQAWMTToH59+HrAaLljRnFkQE4LKi/nbnJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VCCAjLlHZpgaDwGevFyCYBEocjz2NqxutWYXwKrJUw=;
 b=UT//qJAaUzR9KQFZxyrlgXLgiBae3LCqJIcxjQPak5hmNivXfCCjBq1W6Nt1AE1f8sZvYV1rv+/BPEyGUTfO1u9G9cXxy1safVzxuHjrMyNSCFEmIMXMVGD0hlI0ChbQsDVFZx6LndQPvMCeXMQKQsnxDEFiMP91Z2Tlif9HhFURCte8wCVxomSSMfVSlM6QEzAF27z38GxkySqUmNlTen1fcsAojFv2aRZfnx0Pio4eUnpyoMwgNBKrBCqFU+Qa68dnFJFqnR1ty3uZk/QwvjU/yE8ml0i9dkhU4XqhMRrjclhBfeg0S8L7YHSzEUy/H2sDqFEXbDIqfUdJM3Z32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VCCAjLlHZpgaDwGevFyCYBEocjz2NqxutWYXwKrJUw=;
 b=biUALuJPlpAvov+qA4dAhjDFp2mGFITN5OOYhXr0WJVvUKG98OqK7TRTQgyMjXK5DcoNIO+zUfke9F1bYOErdwsjSn9l6EnxIOMfo/Yqr91j3INMglhG5NWAyWDm1mq1HLRShxJ+y355y6KUpYKzy+lx/Qv6I7pl/97o91RoaLs=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:19 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 15/17] wilc1000: add fw.h
Thread-Topic: [PATCH v6 15/17] wilc1000: add fw.h
Thread-Index: AQHWBAGbACn5i8c7/U6jrcpbBxo9Xw==
Date:   Fri, 27 Mar 2020 06:33:19 +0000
Message-ID: <20200327063302.20511-16-ajay.kathat@microchip.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
In-Reply-To: <20200327063302.20511-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65676796-24a9-4392-9a80-08d7d218bda6
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33976F53D6EE12A319EE1514E3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(186003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2h0pPmifo2OBwcuwzIAxd+/1Tpn0xZzVh/wA026h4r3EiRn7DB2zMmADJ/Ov43LCdsYHYO4yOuQgOTrpPOwYPv3tkyhuK+v3nG9xm3YvFJavLFzOR1fsx1rTaXBWOfaJOeN6tDVTrQaKvOX0FrivyYjUi1/wuO3qGK7D4Z4Twx0xGj1cjY7muOyFOLrlNt8C3DbI9++wLexLJOYDizpIuwV72hqZ0tVH4ak8JuUoS6xfGI0n2qQxaflbR85iBnmO7CUshkmcpdP0SH3dWcZO1nKf0JnTULN1+5DsUL7DiP8T3oBj/Q1+BMxy7//zUFxWC6oXXlMsWqDqnybzjWT7P1yZ0Om+TWwyjfWuIZWjApqv4zuVTSJg7wi5OvDCuJpvCoIY7ao2aApYDQSQKtAf8UZ7487q6+bF9MDiBYEHtEBia+UfHmP/rS1uHPIdvd4
x-ms-exchange-antispam-messagedata: 5mE0b2o4JIJUinXiMBHpHiyU/2mecdiqDhIgP2U6W48GaEik+fUic6vmfO/4HZX2YV6jdZnDD2Kdyea2L6iqKolCWJrL4DxPDBIFO1VAodvAKQ0x5exOW4Mz/wLGo/rIMVNO1poIkQx7ynQJ5U6HJw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65676796-24a9-4392-9a80-08d7d218bda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:19.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHcNmHOCHUIuGi1NYEnrQKP/y49exRIia94BuOv2OrwKnoY0cm23kw8+hJzDT88kEfRBEqXdgpYbVl3Q7UnvVU1CeT+U20ccerFoCDPvEgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/fw.h' to
'drivers/net/wireless/microchip/wilc1000/fw.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/fw.h | 119 +++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/fw.h

diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
new file mode 100644
index 000000000000..a76e1dea4345
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef WILC_FW_H
+#define WILC_FW_H
+
+#include <linux/ieee80211.h>
+
+#define WILC_MAX_NUM_STA			9
+#define WILC_MAX_RATES_SUPPORTED		12
+#define WILC_MAX_NUM_PMKIDS			16
+#define WILC_MAX_NUM_SCANNED_CH			14
+
+struct wilc_assoc_resp {
+	__le16 capab_info;
+	__le16 status_code;
+	__le16 aid;
+} __packed;
+
+struct wilc_pmkid {
+	u8 bssid[ETH_ALEN];
+	u8 pmkid[WLAN_PMKID_LEN];
+} __packed;
+
+struct wilc_pmkid_attr {
+	u8 numpmkid;
+	struct wilc_pmkid pmkidlist[WILC_MAX_NUM_PMKIDS];
+} __packed;
+
+struct wilc_reg_frame {
+	u8 reg;
+	u8 reg_id;
+	__le16 frame_type;
+} __packed;
+
+struct wilc_drv_handler {
+	__le32 handler;
+	u8 mode;
+} __packed;
+
+struct wilc_wep_key {
+	u8 index;
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+struct wilc_sta_wpa_ptk {
+	u8 mac_addr[ETH_ALEN];
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+struct wilc_ap_wpa_ptk {
+	u8 mac_addr[ETH_ALEN];
+	u8 index;
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+struct wilc_gtk_key {
+	u8 mac_addr[ETH_ALEN];
+	u8 rsc[8];
+	u8 index;
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+struct wilc_op_mode {
+	__le32 mode;
+} __packed;
+
+struct wilc_noa_opp_enable {
+	u8 ct_window;
+	u8 cnt;
+	__le32 duration;
+	__le32 interval;
+	__le32 start_time;
+} __packed;
+
+struct wilc_noa_opp_disable {
+	u8 cnt;
+	__le32 duration;
+	__le32 interval;
+	__le32 start_time;
+} __packed;
+
+struct wilc_join_bss_param {
+	char ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_terminator;
+	u8 bss_type;
+	u8 ch;
+	__le16 cap_info;
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 beacon_period;
+	u8 dtim_period;
+	u8 supp_rates[WILC_MAX_RATES_SUPPORTED + 1];
+	u8 wmm_cap;
+	u8 uapsd_cap;
+	u8 ht_capable;
+	u8 rsn_found;
+	u8 rsn_grp_policy;
+	u8 mode_802_11i;
+	u8 p_suites[3];
+	u8 akm_suites[3];
+	u8 rsn_cap[2];
+	u8 noa_enabled;
+	__le32 tsf_lo;
+	u8 idx;
+	u8 opp_enabled;
+	union {
+		struct wilc_noa_opp_disable opp_dis;
+		struct wilc_noa_opp_enable opp_en;
+	};
+} __packed;
+#endif
--=20
2.24.0
