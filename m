Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEE1817BF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgCKMTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 08:19:30 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:13865 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgCKMTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 08:19:30 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: rdyFTKc/btFutVmPW3WZ5IBF7mBz9X/9Jzd0JfCqd6zpG8gYqWPF8BsQp/3XMmlypoWnsJRWyB
 vw3eLyKRENQwfaeXHZoIXtATilFje/BJNO1ms8WCuZoG4pt6Lcd/ZEhvLxdIEcEtQEocrGcCu5
 mUt3wBJV08x8raH+wSGcWlpzpKb83i6OmcN8UJaYLhNvBRn6bq3Y1iquKCr+8RrNcu2MUkbXLT
 mYBIioMPfFWvIRpi1ZFa5np6rXdSzAczDtGUqC2PbgwsDVdiWcru1WXzYbLO3LDH1l8LWgaVoM
 COI=
X-IronPort-AV: E=Sophos;i="5.70,540,1574146800"; 
   d="scan'208";a="69605604"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2020 05:19:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Mar 2020 05:19:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Mar 2020 05:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkbhi/dEUN4TMfdqxXP6WKmE0lBYiaaCDDdejkcIkIiWWiiSO3exdBsBa3YpkvPPQ5P2JAeWuM3s62O+8kXNHPaOznmAsxy/ypVw4LVE8qnVfCiJlYAeq3aKhDGur3wVKxP0jOEEbiHiwMTzDfZOFWRT40zWzhtwlRBYZkTSimKr5LQHpsCyy+DbXmWmcSRdukofUqbdmy3CLTDeP0I//eZ84DysdkVXeLb61njE320i1T3UgWd/lmgZR9K8DcASJ9wtfr3wvd/MlwjMhsFLGo5MPHk5UsnenRPh17TI3HYkEqJ6DLYk7TJ1ucKTzUmStruKosSmyTqp9QVq2ZxdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VCCAjLlHZpgaDwGevFyCYBEocjz2NqxutWYXwKrJUw=;
 b=X4b+HyNbYJdrI1Uyam2f+l8tK7yQEH5N+2yXdoTLHEdfWwnmsdYX6oKR+lBcozVl6Ku85vELLQRRWGegEy+vrWcbuDQH8OHTcBBp1cVGPpLWMdXPuGbgC3gk2wNUeQlCD7s7LBWPMSRBGprLOTqHCkwjpVDVz2h8DZY1WrYVEWFfiaNwj+H+bn/1Q1wvbiqACuPFYWIgV10L2ROEJhlNmE7+6OruVxYB7p4mzy8ifWO9lR/53gfFC6oQ4Yp0FHE5vUTqQY8JEOTsUiw6z/fd7iLRV1UrIY5oO+p89u8dPJOwbdDEqqolAwi9DMLgoBUa5TCS3EzFb3V3xxhpTnEzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VCCAjLlHZpgaDwGevFyCYBEocjz2NqxutWYXwKrJUw=;
 b=Rf9idTTDXEIgW1zHqwQ1nKLeDG590S4VIS7poiQtY+aJzzLzHqhKF4piEtcQpHdIqZQFSmilbV5MojBHlDfztW1yI6DuW3/Y2tf9Z0I6REVBzKYQSAvG5E4PJg0Ut7QOpXYjsvv7Gz12M7BV8pzMQuqVzJ06LVo++3CsDm5n5OY=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 11 Mar
 2020 12:19:26 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 12:19:26 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v5 15/17] wilc1000: add fw.h
Thread-Topic: [PATCH v5 15/17] wilc1000: add fw.h
Thread-Index: AQHV9584kyiR50ziCEKU4aX9+HaYBA==
Date:   Wed, 11 Mar 2020 12:18:50 +0000
Message-ID: <20200311121809.5610-16-ajay.kathat@microchip.com>
References: <20200311121809.5610-1-ajay.kathat@microchip.com>
In-Reply-To: <20200311121809.5610-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70294101-c261-422c-3593-08d7c5b6709f
x-ms-traffictypediagnostic: BYAPR11MB2805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2805B006DFFA127774CF2B3EE3FC0@BYAPR11MB2805.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(478600001)(2906002)(71200400001)(8936002)(81166006)(81156014)(6666004)(316002)(5660300002)(54906003)(6506007)(1076003)(8676002)(6512007)(86362001)(36756003)(107886003)(4326008)(6486002)(76116006)(91956017)(66476007)(64756008)(66446008)(66946007)(66556008)(6916009)(2616005)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2805;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RinnTdHxNzjgv6epABpW1LnU/ZIP8MuyBgfd9r5+aEqazl1oAQ4vRWsA8vLYWlVfobRrt9zvqP9HJhfEcNDrIY0h+eu1476HLYsQesOwFv71Z1BO/ZjIRqtEc+b6mHoYzXbKp/hbmrDsHhEZtj5rIrnuMl+17zjwuPySJRqGu3fZtVsq4R//5+TG90VnvW3aXaXU9vbeM6XMtTSKE3U551fwFCTI8iDVYPzVFVo98ulMAZkIMlPCHzpsP/qbpVddWFwD/SNPaV6FmUQwH8LUjgb839ObcuQ3M5IJpBloWd5TK5HS/+TBaC+SWdXQl47h+U8qMKfZyOas6BOH/DufAZcTHRAak1NNW+/AiTpaccRe4WOiFrYru3ORsr591WnIOjeET4YeQw8dVwO27fl+7Cj8+8qvfaf34VZe0GNsMg6IdJCL1E1XUchoasfQCsEb
x-ms-exchange-antispam-messagedata: uxV29TFBvPEd8G1Iz+WlcyIMRRisfsZ6JbafpH/w3Al7vgKWR5vtjRLCD9lL1guyFUn55UD67U1/X25W7+t21NXr8faeroMW4jR3vXyC2PFh+NpKimfr/qQiw6voBV3YvRXuPK/116pldzXZmgkGBg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70294101-c261-422c-3593-08d7c5b6709f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 12:18:50.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4Aoo+fOC/A+TRCGKx1ycHDR5Ch/vBXpgPYx30dqOPImO/jDKtnnzrmyn17hl3OA2XxbYxvGTYTOxuusOAJGyCJo634BuSt77QGWtPhPgVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
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
