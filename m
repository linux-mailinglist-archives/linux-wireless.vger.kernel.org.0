Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F514A239
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgA0Krx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:47:53 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:18680 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgA0Krw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:47:52 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAka4X020081
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:51 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xrkfeb1q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFAauN29w6Tu3YwIUiBOA30arBgbxYxNxaTlOcgFQSW6kSCwkjMjzLtttaV6kyj7WiAKZ54Din7Vagqz8pT4wdFXfRO/4bIk6gdaSbwA8ZZB3IDTKVOE3LoSaMp8RzmU8N7noV7XYzmECU+NEKUeVovRE1SSCmp+4qIqHNxXi0+6BQ0rohOEEJCoZU986qBGIbraRbTRUPDCBFZSz7e7HQVwzoEBSiyF8qFihMuzsubj4/pWYs1iKu5mJX1FKK6Y7nNzuh4DiLebbb7mQEpv7fX6FfwYhjSm5caK6aLD5Nh+MsBoYTWkblzUUNS+Db/aRdcmk2dKHwGqlrXErKPg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Liou6SrXUyYwCPlfKzZTd5mG9M8XwbUKH708V8pty+0=;
 b=keKOG6gczXIFAiuVykZKjH/xEwsIpMWqFr9vDjCKMRkoLSPavJ+zAwKmasleiTCWPAMfijyvp6xjlxOtb84plaC9ZN4/1mlr0GEckyd7gKLidDBfSW+WldFo6Si3ST/FJV2+KfYPkyvOVjwECFsy9oCE11KTvrInTm25qjVGa8sdzvj3pqmd1gnVAWEX4VqLJMQCibpZn+TjGcl7gJ6DxZQtTqsfcRIoii7dW/Ri4ECYxNVduean3yaw7TscnJDhV59sgBimwCWOVMForIwkDie3wTWAZTc3pRL1Ev0tPX2ao50/1YjXr0RJrPQzBN/Rw9SapmYsvfjCuaATZGdSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Liou6SrXUyYwCPlfKzZTd5mG9M8XwbUKH708V8pty+0=;
 b=jPrYn63ZnVm2PzXqF8S61r7zhg1fEC7SBqEmfuLSLYYn/kK6Q/JF+sRRwtyn/gCAq9rVjCM4kc2PIa/POvoKGLHcWKIQRDBT761mK/zEI7mnSr/LSSTrdstbDk6T/fNdx3/rm8SrTlKOeYUNmHQIMUQ/7ENpUNQNnDpJulnOpdc=
Received: from BYAPR05MB5653.namprd05.prod.outlook.com (20.177.186.21) by
 BYAPR05MB6200.namprd05.prod.outlook.com (20.178.55.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Mon, 27 Jan 2020 10:47:49 +0000
Received: from BYAPR05MB5653.namprd05.prod.outlook.com
 ([fe80::ce6:7fe6:2cfe:855d]) by BYAPR05MB5653.namprd05.prod.outlook.com
 ([fe80::ce6:7fe6:2cfe:855d%2]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:47:49 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:49 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:49 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:48 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 04/10] qtnfmac: drop QTN_TLV_ID_NUM_IFACE_COMB TLV type
Thread-Topic: [PATCH 04/10] qtnfmac: drop QTN_TLV_ID_NUM_IFACE_COMB TLV type
Thread-Index: AQHV1P8Tum6BfTbxR0aoEemeEu554Q==
Date:   Mon, 27 Jan 2020 10:46:49 +0000
Message-ID: <20200127104634.7248-5-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 67b629fb-decf-448c-5750-08d7a3163632
x-ms-traffictypediagnostic: SN6PR05MB5391:|BYAPR05MB6200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB53915054F4D70151A5C00B7BA30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:47:46 AM
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(71200400001)(478600001)(7696005)(52116002)(6486002)(6916009)(36756003)(66946007)(16526019)(186003)(86362001)(103116003)(956004)(2616005)(26005)(66556008)(64756008)(66476007)(66446008)(54906003)(81166006)(81156014)(8936002)(107886003)(4326008)(316002)(1076003)(8676002)(5660300002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6200;H:BYAPR05MB5653.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zCXFN9yt2yK8SjUZeLovcnI6QoTlppNQ4bwVEdnCmL0N41rjw1gv8O+8iJIDHMATv9d5ZqPkGIKwA9YNvb4eHfggESotIW8AxaohlEJnuy7z7sbqTE4ge9/qdOtD/cOzDlmN2xVy4eUybXTqABM78+CCryrzib8NCnrj98dQKovdVrPzG6J4+p3NudmChUlsvy3xdKNbiQ8WhGtnxpxUn+csRf4Op9pXZNmXF+ob//EMBl5G6llMv295VrOxYrLeurGRXtiJKENKIjPROPmTEV0vDXtiARNrTKDgI8xUd1LSwEZgOp6b+Ybin/W8T7TwLxRgO2B91zkm99GCvgEEHBgliYp9s39bJsB2l/xQzqz2O62nJLTnEfGGOZ6uw7PLQwmVspWkWfLxBPowcu+mba4K/a5BXTinRF8SycCYPe9ncDVTumTKv47mYMzqBMu
x-ms-exchange-antispam-messagedata: w3aBjjBiSIa/p38opATAARAv5aUPbkyxxDlLHHWPMTqSWHnQbf2DOrFHn6kV3hOcOKYO9Vo/fnCP+2/3bGRSQabrQJzf+vNecnTfV+SCTxpKlVwHdFEOvEOK9cszZeuneZScO9YHw6ZY25QFGQxcaw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b629fb-decf-448c-5750-08d7a3163632
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PSPXGmiqeJqHDtLLi9xnnmVZ39wPElSnWKbvxCBzr40WoPcSrMWo7OJ7g47sY4LzhklX9w7VRdmNjEGjQdBlSKLe2+tQ0yAEXKHV3g/jedfiNK8Bc1QCnVOpEBu1klr+5/WMwFvDsjLEjyW4WW17mZVPC+fxg3taXpzW+M6CpqkWWKTv4TRJUqkkUCfYrMEqTLbVv/Uotc9LnyknrnyjwHtbLlyIghb9ljnIqYC2GU=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:47:49.0796
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6200
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Information about interface combinations is now available in a fixed
portion of struct qlink_resp_get_mac_info. Use that information to
get interface combinations. TLV type QTN_TLV_ID_NUM_IFACE_COMB is
not needed anymore and can be dropped.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 48 +++++++++----------=
----
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    |  5 ---
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index ca7d59a0a848..1cba0182a5b8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1023,10 +1023,9 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 			     size_t tlv_buf_size)
 {
 	const u8 *tlv_buf =3D resp->var_info;
-	struct ieee80211_iface_combination *comb =3D NULL;
+	struct ieee80211_iface_combination *comb =3D mac->macinfo.if_comb;
 	size_t n_comb =3D 0;
 	struct ieee80211_iface_limit *limits;
-	const struct qlink_iface_comb_num *comb_num;
 	const struct qlink_iface_limit_record *rec;
 	const struct qlink_iface_limit *lim;
 	const struct qlink_wowlan_capab_data *wowlan;
@@ -1084,32 +1083,6 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 		}
=20
 		switch (tlv_type) {
-		case QTN_TLV_ID_NUM_IFACE_COMB:
-			if (tlv_value_len !=3D sizeof(*comb_num))
-				return -EINVAL;
-
-			comb_num =3D (void *)tlv->val;
-
-			/* free earlier iface comb memory */
-			qtnf_mac_iface_comb_free(mac);
-
-			mac->macinfo.n_if_comb =3D
-				le32_to_cpu(comb_num->iface_comb_num);
-
-			mac->macinfo.if_comb =3D
-				kcalloc(mac->macinfo.n_if_comb,
-					sizeof(*mac->macinfo.if_comb),
-					GFP_KERNEL);
-
-			if (!mac->macinfo.if_comb)
-				return -ENOMEM;
-
-			comb =3D mac->macinfo.if_comb;
-
-			pr_debug("MAC%u: %zu iface combinations\n",
-				 mac->macid, mac->macinfo.n_if_comb);
-
-			break;
 		case QTN_TLV_ID_IFACE_LIMIT:
 			if (unlikely(!comb)) {
 				pr_warn("MAC%u: no combinations advertised\n",
@@ -1266,13 +1239,15 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 	return 0;
 }
=20
-static void
+static int
 qtnf_cmd_resp_proc_mac_info(struct qtnf_wmac *mac,
 			    const struct qlink_resp_get_mac_info *resp_info)
 {
 	struct qtnf_mac_info *mac_info;
 	struct qtnf_vif *vif;
=20
+	qtnf_mac_iface_comb_free(mac);
+
 	mac_info =3D &mac->macinfo;
=20
 	mac_info->bands_cap =3D resp_info->bands_cap;
@@ -1302,6 +1277,16 @@ qtnf_cmd_resp_proc_mac_info(struct qtnf_wmac *mac,
 	       sizeof(mac_info->ht_cap_mod_mask));
 	memcpy(&mac_info->vht_cap_mod_mask, &resp_info->vht_cap_mod_mask,
 	       sizeof(mac_info->vht_cap_mod_mask));
+
+	mac_info->n_if_comb =3D resp_info->n_iface_combinations;
+	mac_info->if_comb =3D kcalloc(mac->macinfo.n_if_comb,
+				    sizeof(*mac->macinfo.if_comb),
+				    GFP_KERNEL);
+
+	if (!mac->macinfo.if_comb)
+		return -ENOMEM;
+
+	return 0;
 }
=20
 static void qtnf_cmd_resp_band_fill_htcap(const u8 *info,
@@ -1657,7 +1642,10 @@ int qtnf_cmd_get_mac_info(struct qtnf_wmac *mac)
 		goto out;
=20
 	resp =3D (const struct qlink_resp_get_mac_info *)resp_skb->data;
-	qtnf_cmd_resp_proc_mac_info(mac, resp);
+	ret =3D qtnf_cmd_resp_proc_mac_info(mac, resp);
+	if (ret)
+		goto out;
+
 	ret =3D qtnf_parse_variable_mac_info(mac, resp, var_data_len);
=20
 out:
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 9838ea6b212a..8966fb68a61a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -1399,7 +1399,6 @@ enum qlink_tlv_id {
 	QTN_TLV_ID_STA_STATS		=3D 0x0212,
 	QTN_TLV_ID_COVERAGE_CLASS	=3D 0x0213,
 	QTN_TLV_ID_IFACE_LIMIT		=3D 0x0214,
-	QTN_TLV_ID_NUM_IFACE_COMB	=3D 0x0215,
 	QTN_TLV_ID_CHANNEL_STATS	=3D 0x0216,
 	QTN_TLV_ID_KEY			=3D 0x0302,
 	QTN_TLV_ID_SEQ			=3D 0x0303,
@@ -1430,10 +1429,6 @@ struct qlink_tlv_hdr {
 	u8 val[0];
 } __packed;
=20
-struct qlink_iface_comb_num {
-	__le32 iface_comb_num;
-} __packed;
-
 struct qlink_iface_limit {
 	__le16 max_num;
 	__le16 type;
--=20
2.11.0

