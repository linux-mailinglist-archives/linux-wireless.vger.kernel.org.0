Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10D414A23C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgA0KsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:48:22 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:29612 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgA0KsW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:48:22 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAhO5h020730
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:21 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrhdav4ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKvKJPjcuF0xZyvAbEGEO9PqqCWVQs9tEVDi84AGLgnircORmx076sCafDMXo1eZ+gTlcShaIcGonHwaHTcAGPUmBq+LU3Fwpzw7l0L9EdJWbe514OO8jzpMpTpIWNiQ4tfBPaY0TjERCz9qQLSes7DPriUs+zJ2xABg7C0mx7ZlmV0r05Nxc5XKoSIwrFpZkViwKSCQOm+NOahNFyCo2lgC2tImJry8RG3a6TqoG8H0PZLTCwcXvfG1ouYHfsi00FGFiW/6lioZ7sqPNMvdh7yInKYu/NJobSVNZ36z9Je9ySE0Vz25oTX0vmwG5lOf+p5Bumb3th4EnRZ0PHlYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRQYQis7pIDMi+O7bkBCizx99YauRsyw+xAbHjMk8jA=;
 b=HcuydxE7VOoKQKt3fsxCMCXh5TYHzUk7U8C7B5168De85vg4v4PAAjHurWVhEXxD67Uy+BUGRjfywZ8ENUeVnvZPS+m2RAhH4wXLy4L1nn2q030eRSwIVtiw2jvno1hBfxMUs1mih4EHfzp9U8aHJmNJRKfU4jnpOxPseDCAmcMOFQm52Is4YE/qfctJbklF8u4ZkuBCJTO91sLUkAgjhwvrJhWpsqu0c4X6XufS55B0kDyamoLjMmAK6rL8yP925662KvSZH6MDcF50JSeQHf5ZaZQ+phEOU8B6Y+uXWMWXUp1Li/pDzmZlVex7VXOOgBWSbqTcEMdqombnOK9otQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRQYQis7pIDMi+O7bkBCizx99YauRsyw+xAbHjMk8jA=;
 b=QbGJrwomOJ9d6p6IlNb6+SxNQfn+pYdftj9vL/Xc6/7i62X/xX5KRewDXvZn4Fr2OFhtFbBgs9rT3ivIjjqyxsRyt4e0Y6+VjU3IXPmfjiFxv6FouyMm+jGx4gHjX+58z2EYKuz+NBpVTfnYQiH+64YgZ1DF+s9zdIlKrmf33l4=
Received: from DM6PR05MB5355.namprd05.prod.outlook.com (20.176.120.31) by
 DM6PR05MB6316.namprd05.prod.outlook.com (20.178.26.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Mon, 27 Jan 2020 10:48:14 +0000
Received: from DM6PR05MB5355.namprd05.prod.outlook.com
 ([fe80::5c62:c0b8:edc3:9745]) by DM6PR05MB5355.namprd05.prod.outlook.com
 ([fe80::5c62:c0b8:edc3:9745%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:48:14 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:52 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:52 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:50 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 06/10] qtnfmac: pass max scan SSIDs limit on per-radio basis
Thread-Topic: [PATCH 06/10] qtnfmac: pass max scan SSIDs limit on per-radio
 basis
Thread-Index: AQHV1P8VeSWP+A+gTUKLxJkQLuqFUQ==
Date:   Mon, 27 Jan 2020 10:46:52 +0000
Message-ID: <20200127104634.7248-7-sergey.matyukevich.os@quantenna.com>
References: <20200127104634.7248-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200127104634.7248-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:7:67::28) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb599b63-b58e-469f-302e-08d7a31637e6
x-ms-traffictypediagnostic: SN6PR05MB5391:|DM6PR05MB6316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5391450C596F0F6C5CA12973A30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:48:12 AM
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39840400004)(346002)(366004)(189003)(199004)(71200400001)(316002)(103116003)(186003)(16526019)(478600001)(86362001)(4326008)(2616005)(956004)(6916009)(107886003)(2906002)(8676002)(81156014)(81166006)(36756003)(66476007)(66556008)(64756008)(66446008)(8936002)(54906003)(1076003)(5660300002)(66946007)(52116002)(6486002)(7696005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB6316;H:DM6PR05MB5355.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVu3TDc1IM09fQjqGLFajgsgxXgsfUem0C4Uc7+ToR6fwTKQM+/+oQ1yJhm7vzuJSPPtdyR1HWb7CVqp5/ksJYLx7UjXAqNzftafTg8qNgwPwWu1hcRtVRKksx5zjyBCMuNneHr8FFgyfgJVR+XV0i8kAlkFh5htrFWGHzmHldM70rWlVnr8igszekorKwunnA99o9HHyFOsP7Cuvj64jzwBhqXX7ZRnqnHNL1H1jONdL53Jh4ixCdDc2K3QLZi0uPlKhR945ogW70aHkD1kEhkfLzJr+SkzY/neWoYgRQiKCzDFra8IjZbx4jcB6bF4Ml8WWppQzvx21rlsKh3+9eTCHsXuVorWvEo4YOthScF2HUx4vbM2YzJqHgpzPu5GknU+068jfd6bk18XJ9NZPF7v4tC0HQiR3v8uuVx+ZSsvGlMf209EPHu0s1cOt9lp
x-ms-exchange-antispam-messagedata: 9cIJsVlLcwJ+ItKcD7q34s+XHAqGyWxXpnxulI8uqufmqBAhWkAZSl9N2I15Sk5tqpzLkdpVG6RUs76aWmzoXYsRpHmf5W9KPebE0tzjO/Yxpt16TGm6L9CQfMIch1BSErvgDGLBAiUIo+/SSDgWow==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb599b63-b58e-469f-302e-08d7a31637e6
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ep2ZYPEKHSaTQCZReEm2jfveK2CmoGNJRb6FqrsoBvMJurV5vznZgKYtAzs39ga+4jwX9cRVizPNVJYTy5SnULWIu738WbzNUG/uL3qGw6NpE8ysygCVvfbik6WWq/z+ddXARBx+Ehoqka4IzKj3X9VvfeFF/1FHznffsLTrvhtF37JsjEaeKJP1fk9AINaHRn53q9A81UvS3z5KKjpazTtIDlz7TNO93FCVMNJPSwE=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:48:14.1948
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6316
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Each radio on a given wifi device may have different max scan SSIDs
limitation, so take this information from a per-radio info structure.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 4 +---
 drivers/net/wireless/quantenna/qtnfmac/core.h     | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 4 +---
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index a53ffe04a903..73d5014a4234 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -1108,7 +1108,7 @@ int qtnf_wiphy_register(struct qtnf_hw_info *hw_info,=
 struct qtnf_wmac *mac)
 	wiphy->coverage_class =3D macinfo->coverage_class;
=20
 	wiphy->max_scan_ssids =3D
-		(hw_info->max_scan_ssids) ? hw_info->max_scan_ssids : 1;
+		(macinfo->max_scan_ssids) ? macinfo->max_scan_ssids : 1;
 	wiphy->max_scan_ie_len =3D QTNF_MAX_VSIE_LEN;
 	wiphy->mgmt_stypes =3D qtnf_mgmt_stypes;
 	wiphy->max_remain_on_channel_duration =3D 5000;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 6a13b29bf814..a4be2aa19997 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -941,9 +941,6 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 		case QTN_TLV_ID_UBOOT_VER:
 			uboot_ver =3D (const void *)tlv->val;
 			break;
-		case QTN_TLV_ID_MAX_SCAN_SSIDS:
-			hwinfo->max_scan_ssids =3D *tlv->val;
-			break;
 		case QTN_TLV_ID_BITMAP:
 			memcpy(hwinfo->hw_capab, tlv->val,
 			       min(sizeof(hwinfo->hw_capab), (size_t)tlv_len));
@@ -1272,6 +1269,7 @@ qtnf_cmd_resp_proc_mac_info(struct qtnf_wmac *mac,
 	mac_info->sretry_limit =3D resp_info->retry_short;
 	mac_info->lretry_limit =3D resp_info->retry_long;
 	mac_info->coverage_class =3D resp_info->coverage_class;
+	mac_info->max_scan_ssids =3D resp_info->max_scan_ssids;
=20
 	memcpy(&mac_info->ht_cap_mod_mask, &resp_info->ht_cap_mod_mask,
 	       sizeof(mac_info->ht_cap_mod_mask));
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index 6fe82179df7f..b993f9ca14c5 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -84,6 +84,7 @@ struct qtnf_mac_info {
 	u8 sretry_limit;
 	u8 coverage_class;
 	u8 radar_detect_widths;
+	u8 max_scan_ssids;
 	u16 max_acl_mac_addrs;
 	struct ieee80211_ht_cap ht_cap_mod_mask;
 	struct ieee80211_vht_cap vht_cap_mod_mask;
@@ -117,7 +118,6 @@ struct qtnf_hw_info {
 	u8 total_rx_chain;
 	char fw_version[ETHTOOL_FWVERS_LEN];
 	u32 hw_version;
-	u8 max_scan_ssids;
 	u8 hw_capab[QLINK_HW_CAPAB_NUM / BITS_PER_BYTE + 1];
 };
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 38d3d60926ff..16acb10386ad 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -965,6 +965,7 @@ enum qlink_dfs_regions {
  * @num_rx_chain: Number of receive chains used by WMAC.
  * @vht_cap_mod_mask: mask specifying which VHT capabilities can be altere=
d.
  * @ht_cap_mod_mask: mask specifying which HT capabilities can be altered.
+ * @max_scan_ssids: maximum number of SSIDs the device can scan for in any=
 scan.
  * @bands_cap: wireless bands WMAC can operate in, bitmap of &enum qlink_b=
and.
  * @max_ap_assoc_sta: Maximum number of associations supported by WMAC.
  * @radar_detect_widths: bitmask of channels BW for which WMAC can detect =
radar.
@@ -1378,8 +1379,6 @@ struct qlink_event_mic_failure {
  * @QTN_TLV_ID_STA_STATS: per-STA statistics as defined by
  *	&struct qlink_sta_stats. Valid values are marked as such in a bitmap
  *	carried by QTN_TLV_ID_BITMAP.
- * @QTN_TLV_ID_MAX_SCAN_SSIDS: maximum number of SSIDs the device can scan
- *	for in any given scan.
  * @QTN_TLV_ID_SCAN_DWELL_ACTIVE: time spent on a single channel for an ac=
tive
  *	scan.
  * @QTN_TLV_ID_SCAN_DWELL_PASSIVE: time spent on a single channel for a pa=
ssive
@@ -1415,7 +1414,6 @@ enum qlink_tlv_id {
 	QTN_TLV_ID_CALIBRATION_VER	=3D 0x0406,
 	QTN_TLV_ID_UBOOT_VER		=3D 0x0407,
 	QTN_TLV_ID_RANDOM_MAC_ADDR	=3D 0x0408,
-	QTN_TLV_ID_MAX_SCAN_SSIDS	=3D 0x0409,
 	QTN_TLV_ID_WOWLAN_CAPAB		=3D 0x0410,
 	QTN_TLV_ID_WOWLAN_PATTERN	=3D 0x0411,
 	QTN_TLV_ID_SCAN_FLUSH		=3D 0x0412,
--=20
2.11.0

