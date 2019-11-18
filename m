Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73635100054
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRI1Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:27:16 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:3032 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfKRI1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:27:16 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAI8Qmac009660
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:14 -0700
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0a-00183b01.pphosted.com with ESMTP id 2waf9fmcye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgSeudefy1vOjZ+g3fWJ6auZSEj3/HD+dXB6KOXJh8gcvjww8Ef+FOWjCHUqaqYBS41b7iX+kJVFpYScEnS/rTRpI7JsfL/leTMP7oD0i+YRttz9GjmclogqD44uzsAxh78aaJRBhFbBDie3TNTSfTbuQ+5egl9lsvFgeQ2HLiStsCysTDpJMcZxA4AJI8h+pYBnMNYzMobtQTCQWh31TZI9iOfSqztmr4CGSaqOPd2BmcsZM+zTFKur1qlcL2YUi8gAWviYOexXDP+LgiHJ5cG4zWCuis0GneyWZjPfbJ2pTAjiLYhLsdgz3b5ennMlMuBYLmpYP3IEe03aqRq2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8qmQSiGqlh+K6uSBRe/FMnu2F+3KVrUnGIGu+n32/Q=;
 b=XnMeit0uoSjbd1pOQ6eTkDx7ku7x5dhqAfTviNhLzSJkEjbNWbttJ5CJgBNz+5pmYu37KnsFCSg9uwAmngxGNGqEoFuvrtVPJxBheIF2VFgmaGqGUu+rZCG0hV5jNuCAwlSqpF1ZH2xSs4J2yIWA62kUrjAepZ+v1ce4jUFNfo6vDirX5soHcinpvsI8wfLzb53KKMfEvWFDpia0Us90fhWELw2Qx+a2uij7s+qDwJPiYUbGIGEiHbOGWmTjH+1h79h0wBNufwW/On1vzJT31D8AzQSSwP8hJ+HRSBy6337vRZAjp8q+PZ+0Nu7DeqvQ2LUvK5XwW7c295vP2SSDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8qmQSiGqlh+K6uSBRe/FMnu2F+3KVrUnGIGu+n32/Q=;
 b=IKriHdIFaIuYoflRHK86QyxLP2M52Yao0LsOYprDGgIeoZvXfa44IgyGpOSSWFivkQortw5IVQOdyYVZryKufIedaZydwt8xWqfcaqMtWQCUbDkFzZyXgeAIE7GA/uoArbJU4FOLFtfjSAL0wq/RxUa5JlHFjOWTSKeFcagCAC4=
Received: from BN8PR05MB5987.namprd05.prod.outlook.com (20.178.212.145) by
 BN8PR05MB6162.namprd05.prod.outlook.com (20.178.208.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Mon, 18 Nov 2019 08:27:12 +0000
Received: from BN8PR05MB5987.namprd05.prod.outlook.com
 ([fe80::c5af:987b:6787:7138]) by BN8PR05MB5987.namprd05.prod.outlook.com
 ([fe80::c5af:987b:6787:7138%7]) with mapi id 15.20.2474.015; Mon, 18 Nov 2019
 08:27:11 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:15 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:15 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 6/7] qtnfmac: add TLV for extension IEs
Thread-Topic: [PATCH 6/7] qtnfmac: add TLV for extension IEs
Thread-Index: AQHVnelsK5u2FZ+VPU+PV+ooq5Q2rA==
Date:   Mon, 18 Nov 2019 08:23:14 +0000
Message-ID: <20191118082255.6032-7-sergey.matyukevich.os@quantenna.com>
References: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30d4c86e-5cb0-4f57-3105-08d76c008eab
x-ms-traffictypediagnostic: SN6PR05MB6320:|BN8PR05MB6162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB6320B9CFBBF040D3101C21EAA34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:27:09 AM
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39840400004)(346002)(199004)(189003)(103116003)(107886003)(66476007)(66066001)(66556008)(64756008)(446003)(305945005)(5640700003)(1076003)(54906003)(6916009)(66946007)(52116002)(14454004)(6506007)(386003)(186003)(50226002)(316002)(7736002)(66446008)(25786009)(4326008)(2351001)(36756003)(71190400001)(11346002)(8936002)(2616005)(476003)(2501003)(76176011)(486006)(478600001)(86362001)(436003)(3846002)(6512007)(81166006)(99286004)(5660300002)(71200400001)(8676002)(6116002)(102836004)(14444005)(6436002)(81156014)(26005)(2906002)(6486002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR05MB6162;H:BN8PR05MB5987.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FM4cTHTXHjfGtVniKfjLE0VI+tCE5n53bYmvJhz7ByRp16YV9etmMPbCyxQsGHrEtDb8fm94DzAGbMG/yjkN7XYgGVUYZl/r6OQaS3uAuAghbUiDkl9npfVXb2seQ7FabV/uvpB6eIlGrE2ZiDwrEC9zPrFYOpw1ydih0H3H4hyzLveDRICOosEqi2g2LYohvkUD4oG8Kd31x7d852KQOVIqhG7vxvgwpeN3XzWhUYUCBH5vuxzA6AoaBQiRCGIzCANhHOhpeOx1ogWis/2upYNPENWBRZ9IE718xevhz4GyuzU6Uvtmg1UChCdNpHTKAV3AhhTyf4JBHP/dkWiqzlPASltkTa3Y+TRungW9mZKj/6tNivsYo+FfcumnHCjXarRrkYHzrKllDukX8C2HUyjS3TNUQHLlhEIuG7ZNWCJVw4Zps0bWS7iro/iEa8S4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d4c86e-5cb0-4f57-3105-08d76c008eab
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7Z7L6LWr29m9E97Wq6mX9NvUK1Q6nXZA+bFDSq6RpfwyoVzO0moFdq4LnvIxx9Fry+tGimIAm14EkWaTtrHqNVc5+2bmrGneKarI5D4mjq1O6VMobzH1eNgpNR7BnwcVESn7fg51hLxLJK6eN655cBZH1U1DHN/DWCLNh5jWZjToTKK3OBg5nwSwEXr0QA2JdcI8MzFJT9t5ojZx8cw9kjROwAfbZFDH9hujQ9mWMQ=
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:27:11.9641
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB6162
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180076
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mikhail Karpenko <mkarpenko@quantenna.com>

Extension information elements have additional field for ID. This
commit adds TLV for such elements and a structure for interface HE
capabilities communication with firmware.

Signed-off-by: Mikhail Karpenko <mkarpenko@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/qlink.h | 35 ++++++++++++++++++++++=
++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 18b2ddf39ef8..75527f1bb306 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -1269,6 +1269,7 @@ struct qlink_event_mic_failure {
  * @QTN_TLV_ID_SCAN_SAMPLE_DURATION: total duration of sampling a single c=
hannel
  *	during a scan including off-channel dwell time and operating channel
  *	time.
+ * @QTN_TLV_ID_IFTYPE_DATA: supported band data.
  */
 enum qlink_tlv_id {
 	QTN_TLV_ID_FRAG_THRESH		=3D 0x0201,
@@ -1304,6 +1305,7 @@ enum qlink_tlv_id {
 	QTN_TLV_ID_SCAN_DWELL_ACTIVE	=3D 0x0413,
 	QTN_TLV_ID_SCAN_DWELL_PASSIVE	=3D 0x0416,
 	QTN_TLV_ID_SCAN_SAMPLE_DURATION	=3D 0x0417,
+	QTN_TLV_ID_IFTYPE_DATA		=3D 0x0418,
 };
=20
 struct qlink_tlv_hdr {
@@ -1465,6 +1467,39 @@ struct qlink_tlv_ie_set {
 	u8 ie_data[0];
 } __packed;
=20
+/**
+ * struct qlink_tlv_ext_ie - extension IE
+ *
+ * @eid_ext: element ID extension, one of &enum ieee80211_eid_ext.
+ * @ie_data: IEs data.
+ */
+struct qlink_tlv_ext_ie {
+	struct qlink_tlv_hdr hdr;
+	u8 eid_ext;
+	u8 ie_data[0];
+} __packed;
+
+#define IEEE80211_HE_PPE_THRES_MAX_LEN		25
+struct qlink_sband_iftype_data {
+	__le16 types_mask;
+	struct ieee80211_he_cap_elem he_cap_elem;
+	struct ieee80211_he_mcs_nss_supp he_mcs_nss_supp;
+	u8 ppe_thres[IEEE80211_HE_PPE_THRES_MAX_LEN];
+} __packed;
+
+/**
+ * struct qlink_tlv_iftype_data - data for QTN_TLV_ID_IFTYPE_DATA
+ *
+ * @n_iftype_data: number of entries in iftype_data.
+ * @iftype_data: interface type data entries.
+ */
+struct qlink_tlv_iftype_data {
+	struct qlink_tlv_hdr hdr;
+	u8 n_iftype_data;
+	u8 rsvd[3];
+	struct qlink_sband_iftype_data iftype_data[0];
+} __packed;
+
 struct qlink_chan_stats {
 	__le32 chan_num;
 	__le32 cca_tx;
--=20
2.11.0

