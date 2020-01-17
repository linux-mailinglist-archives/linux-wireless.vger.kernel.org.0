Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA921407FD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 11:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAQKb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 05:31:29 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:2848 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAQKb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 05:31:29 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Yow9O1h+N7raD/EczN45TYPh9TlmuQRRkhKU4Z7IX1pj7VgaWV6pwB+VSTJxWWh+3ldwG/XjGU
 QtlXy5nGMUTtLRsl1psv8vSuKQoa8gCLL1ncDS1oPUY262EXgfFruz4bkm7d8BFwMN9E4ryY1L
 LDrND3hm9HwFpPSd3Q5LowSZE9U/3zvQ27KEdsF8OJbvV5JV90+NRjnCVH8mlXxOJEAFQw1tz0
 SERqBFu+ULn2vTQd6gPenK4Qh5uGmtBjM/ebfvPSgNOZmJz8RKnUVlwz01YBcClK2TJtAW1ukG
 Mic=
X-IronPort-AV: E=Sophos;i="5.70,329,1574146800"; 
   d="scan'208";a="62264555"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 03:31:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 03:31:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jan 2020 03:31:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQUTt8TLOhfxniEQyNENuNOZNMeCwZ5skQxq6KY7Ij2QH7SdNmQ4f2wfnkyiaCT7F8fskqU+sogFWc4wEqm/8ySB4SNqo6uRRy2VOENof6sOkcI7tMkOoYgaFu5RYsUxKfmk7RwEstY3sHqOOKifoJjhE9iylfmADIdJFIH+Dai6AVyPpHXWXbweUEwD9nhD2bo/9G/BJjCDyBNmietW8kc4yDN8NyMbK1aCVARbsfq8/3GcQiPXcoJOhEP6kSiBo1ANCX3VCXo4lEkEZ8jC8ptVtZ+3QwWMX8Ck7kiingQWPNRVjCh2m2ucuCrRUJxDhR/oqnqkAMDjBPd1mRycRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfgWzpRFGgji9ThLLnQuNckw2tiAw6dT5i9rtxJLgsw=;
 b=he6hc2F1OwSlzbOxvsZ5iVpQQG9muG3UcJGS26FjsQHF+KxA+mHmswQLhZbIRBy5rL7NnWRnVi3TrJexV8l8wuAwaJcZ01q/JdmAXpnBZ0O887vpWQ1dm9hDUwxFIAdrZ1U13ufgyGakpeHDI7zm2XlKW8xU58yhHrWDhhPnzE/2hKg3EOjnxO2AtqUKuRPa64y7o4tX5rTB6jybit1F0ulwnYyY/ebBjlj3+bseYb97IiYekmgd+CvhjAqifkBvNF0klZdQcaZhN/Dsb3z2ushNFmS29WTTKtsNxTjze2yZwX8WGDCVPYnfPXsGcpbsJaLUWmDouNMzOu+yPZAn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfgWzpRFGgji9ThLLnQuNckw2tiAw6dT5i9rtxJLgsw=;
 b=lmPDsA8VbVXpDEvU//KjuerxIZL402grG8GtStv8NyMwGnmr+D4D+i1Be3evxlnFxyWAqxmKuGBuIuQzmrrVZ2R5jiEpgL5UKQ0DjCWTLQjtm8YWPikH8jyHYRdLxrFDnS9i1Wo3b7D3nl1RkAPiQcVofftu2kXarFRfZojMYxw=
Received: from DM6PR11MB3996.namprd11.prod.outlook.com (20.176.125.206) by
 DM6PR11MB2907.namprd11.prod.outlook.com (20.177.217.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 10:31:25 +0000
Received: from DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392]) by DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392%5]) with mapi id 15.20.2623.018; Fri, 17 Jan 2020
 10:31:25 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/4] staging: wilc1000: move firmware API struct's to separate
 header file
Thread-Topic: [PATCH 2/4] staging: wilc1000: move firmware API struct's to
 separate header file
Thread-Index: AQHVzSFEHS1Yrl/GPkS/Rb+ODnC2zg==
Date:   Fri, 17 Jan 2020 10:31:25 +0000
Message-ID: <20200117160157.8706-3-ajay.kathat@microchip.com>
References: <20200117160157.8706-1-ajay.kathat@microchip.com>
In-Reply-To: <20200117160157.8706-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae769b65-8d6c-4666-8f24-08d79b386771
x-ms-traffictypediagnostic: DM6PR11MB2907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2907CADEBCE2FB357BABF9E7E3310@DM6PR11MB2907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(8936002)(6916009)(5660300002)(6486002)(81166006)(478600001)(26005)(76116006)(91956017)(8676002)(81156014)(66946007)(66476007)(66446008)(64756008)(66556008)(36756003)(4326008)(2906002)(86362001)(316002)(6506007)(2616005)(107886003)(71200400001)(1076003)(6512007)(186003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB2907;H:DM6PR11MB3996.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcacPRPXI46za5+Txr3u+IECcmlYnOaSm0r3dgsp5ycpdeCz2OWYnZi3/NPVG/Fg5OzHBp7Xu6GXSWshfTEVaUT/FjkcXnjXrC+k+V6a1ISwHGmkyUpXjkDSYeEOjAFbH4avErU2+tlcqQcpaEvx01franYCc5S591zWRZh2wOKP469oWM3LF4ec38zs2fwtjffeTYUOOro3HICKFCvUgy3NrA91kJl7SqtZAtrChbmmGxnwocvWH84s+Fw6tZLU+94iM4iMGwwTsszbkDB6L3C3jbs9jXRmXfT9STMC4aA3NfpncORtbP/0ZapgN6l6K9Ef1QzGybUGL2oHhtLcy+xOKYvlBgWR5RQCiA6gqatQS7li8nVtxXWO+MX+tLz7vTiu132pqps9VwdG8XJr5vlawhIpcsuZ9LIKJu3KKje6BGJaiopnqvyw78KGRa6J
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae769b65-8d6c-4666-8f24-08d79b386771
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 10:31:25.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YO5bhfWenUuWXSL3+UwkG/jzmKNIUKfuHGXlRuxYhdq0hr3FWPac2s8R1kwhy+3TU8DIIoAFxcHUco67boK2DMe6om6JQBEKoN3P2sbwvTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2907
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

It's recommended to keep the 'struct' used for passing data to firmware
in separate header file. So added 'fw.h' header file to keep struct's
used to pass data to firmware.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/fw.h      | 119 +++++++++++++++++++++++++++++
 drivers/staging/wilc1000/hif.c     |  88 ---------------------
 drivers/staging/wilc1000/hif.h     |  19 -----
 drivers/staging/wilc1000/netdev.h  |   1 -
 drivers/staging/wilc1000/wlan_if.h |   1 +
 5 files changed, 120 insertions(+), 108 deletions(-)
 create mode 100644 drivers/staging/wilc1000/fw.h

diff --git a/drivers/staging/wilc1000/fw.h b/drivers/staging/wilc1000/fw.h
new file mode 100644
index 000000000000..21d71a9e8b47
--- /dev/null
+++ b/drivers/staging/wilc1000/fw.h
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
+struct assoc_resp {
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
diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif.=
c
index 349e45d58ec9..1ee3d7274bd6 100644
--- a/drivers/staging/wilc1000/hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -10,7 +10,6 @@
 #define WILC_HIF_CONNECT_TIMEOUT_MS             9500
=20
 #define WILC_FALSE_FRMWR_CHANNEL		100
-#define WILC_MAX_RATES_SUPPORTED		12
=20
 struct wilc_rcvd_mac_info {
 	u8 status;
@@ -27,48 +26,6 @@ struct wilc_del_all_sta {
 	u8 mac[WILC_MAX_NUM_STA][ETH_ALEN];
 };
=20
-struct wilc_op_mode {
-	__le32 mode;
-};
-
-struct wilc_reg_frame {
-	u8 reg;
-	u8 reg_id;
-	__le16 frame_type;
-} __packed;
-
-struct wilc_drv_handler {
-	__le32 handler;
-	u8 mode;
-} __packed;
-
-struct wilc_wep_key {
-	u8 index;
-	u8 key_len;
-	u8 key[0];
-} __packed;
-
-struct wilc_sta_wpa_ptk {
-	u8 mac_addr[ETH_ALEN];
-	u8 key_len;
-	u8 key[0];
-} __packed;
-
-struct wilc_ap_wpa_ptk {
-	u8 mac_addr[ETH_ALEN];
-	u8 index;
-	u8 key_len;
-	u8 key[0];
-} __packed;
-
-struct wilc_gtk_key {
-	u8 mac_addr[ETH_ALEN];
-	u8 rsc[8];
-	u8 index;
-	u8 key_len;
-	u8 key[0];
-} __packed;
-
 union wilc_message_body {
 	struct wilc_rcvd_net_info net_info;
 	struct wilc_rcvd_mac_info mac_info;
@@ -86,51 +43,6 @@ struct host_if_msg {
 	bool is_sync;
 };
=20
-struct wilc_noa_opp_enable {
-	u8 ct_window;
-	u8 cnt;
-	__le32 duration;
-	__le32 interval;
-	__le32 start_time;
-} __packed;
-
-struct wilc_noa_opp_disable {
-	u8 cnt;
-	__le32 duration;
-	__le32 interval;
-	__le32 start_time;
-} __packed;
-
-struct wilc_join_bss_param {
-	char ssid[IEEE80211_MAX_SSID_LEN];
-	u8 ssid_terminator;
-	u8 bss_type;
-	u8 ch;
-	__le16 cap_info;
-	u8 sa[ETH_ALEN];
-	u8 bssid[ETH_ALEN];
-	__le16 beacon_period;
-	u8 dtim_period;
-	u8 supp_rates[WILC_MAX_RATES_SUPPORTED + 1];
-	u8 wmm_cap;
-	u8 uapsd_cap;
-	u8 ht_capable;
-	u8 rsn_found;
-	u8 rsn_grp_policy;
-	u8 mode_802_11i;
-	u8 p_suites[3];
-	u8 akm_suites[3];
-	u8 rsn_cap[2];
-	u8 noa_enabled;
-	__le32 tsf_lo;
-	u8 idx;
-	u8 opp_enabled;
-	union {
-		struct wilc_noa_opp_disable opp_dis;
-		struct wilc_noa_opp_enable opp_en;
-	};
-} __packed;
-
 /* 'msg' should be free by the caller for syc */
 static struct host_if_msg*
 wilc_alloc_work(struct wilc_vif *vif, void (*work_fun)(struct work_struct =
*),
diff --git a/drivers/staging/wilc1000/hif.h b/drivers/staging/wilc1000/hif.=
h
index 22ee6fffd599..db9179171f05 100644
--- a/drivers/staging/wilc1000/hif.h
+++ b/drivers/staging/wilc1000/hif.h
@@ -17,14 +17,11 @@ enum {
 	WILC_CLIENT_MODE =3D 0x4
 };
=20
-#define WILC_MAX_NUM_STA			9
-#define WILC_MAX_NUM_SCANNED_CH			14
 #define WILC_MAX_NUM_PROBED_SSID		10
=20
 #define WILC_TX_MIC_KEY_LEN			8
 #define WILC_RX_MIC_KEY_LEN			8
=20
-#define WILC_MAX_NUM_PMKIDS			16
 #define WILC_ADD_STA_LENGTH			40
 #define WILC_NUM_CONCURRENT_IFC			2
=20
@@ -35,12 +32,6 @@ enum {
=20
 #define WILC_MAX_ASSOC_RESP_FRAME_SIZE   256
=20
-struct assoc_resp {
-	__le16 capab_info;
-	__le16 status_code;
-	__le16 aid;
-} __packed;
-
 struct rf_info {
 	u8 link_speed;
 	s8 rssi;
@@ -59,16 +50,6 @@ enum host_if_state {
 	HOST_IF_FORCE_32BIT		=3D 0xFFFFFFFF
 };
=20
-struct wilc_pmkid {
-	u8 bssid[ETH_ALEN];
-	u8 pmkid[WLAN_PMKID_LEN];
-} __packed;
-
-struct wilc_pmkid_attr {
-	u8 numpmkid;
-	struct wilc_pmkid pmkidlist[WILC_MAX_NUM_PMKIDS];
-} __packed;
-
 struct cfg_param_attr {
 	u32 flag;
 	u16 short_retry_limit;
diff --git a/drivers/staging/wilc1000/netdev.h b/drivers/staging/wilc1000/n=
etdev.h
index cd8f0d72caaa..d5f7a6037fbc 100644
--- a/drivers/staging/wilc1000/netdev.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -21,7 +21,6 @@
 #define FLOW_CONTROL_LOWER_THRESHOLD		128
 #define FLOW_CONTROL_UPPER_THRESHOLD		256
=20
-#define WILC_MAX_NUM_PMKIDS			16
 #define PMKID_FOUND				1
 #define NUM_STA_ASSOCIATED			8
=20
diff --git a/drivers/staging/wilc1000/wlan_if.h b/drivers/staging/wilc1000/=
wlan_if.h
index 7c7ee66c35f5..f85fd575136d 100644
--- a/drivers/staging/wilc1000/wlan_if.h
+++ b/drivers/staging/wilc1000/wlan_if.h
@@ -8,6 +8,7 @@
 #define WILC_WLAN_IF_H
=20
 #include <linux/netdevice.h>
+#include "fw.h"
=20
 /********************************************
  *
--=20
2.24.0
