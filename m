Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEF14A23B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgA0KsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:48:16 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:63146 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730011AbgA0KsQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:48:16 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAgsQ5020773
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:12 -0700
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrkum3utp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR4eQAgf0xD7Ly2ZN58u4afqBTULfseKKPBVFLNr7uN7nehZO2TsYDqYd3LjPxDhTgJI0QiZ6+6mDyd9RwrQePkwucz0kZPzSpsEKzswfNKhJPPKmZm9rdE9cHB3njoiDY74wFo5l0+VQ4F9wVtbyheQrQtqgNhv10r1y2Bm+oTK/mH8VvQh36g6ZRMeuZAoEQVKcZmx5C77K9ws1K5s/RFMsZnhbNubtI4aUviMsn+kkac39/2ebxQQf7/EowJaMZCgQ9j2QKGFQ98CpBpvzs388lsBqaC2YZlzX52+EFkjpPOwgaIRKMu/4Ve92rjc0PVcEgs2nj/rguaDNm04oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H86sMeOAMNXDtkig2hgtjKNI8PXVUJ3LZOQA13Zx+Bs=;
 b=IaDKXaQj5Jqsh6GksI0dPYOUNO2+sE9ZDtoGBA/VV+MO8KK5BSfZ4hSEf3kBohtmWyjoM33/BOn372Ng89I5aMrWE8mSHM9OFtMrXMrXaHShzELtGAaMgp9eN6XULA5CdoVjrs8psV44FUJJzbEWGiLsXjiJrnLbpp8ghWh0NjmrKaeZkgCXb0ytUteCYELy6wzUMn6saEtgqJOy/0S8CLdpiJfOULMwjO6Nji1tVkTc2+zzvRWCmkd2sk9rqGP3AojbO3lTrOrgy0lsYvHBcTSQV2ZwWbYqMGpluNNUF5SZaxLlYubA1XwY3aXZzZrblg6UavZuPOMfamzqGDGtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H86sMeOAMNXDtkig2hgtjKNI8PXVUJ3LZOQA13Zx+Bs=;
 b=Yhmrq+vUP4oVC3/jxAJL9o96ajR1FDykI1J1ruXi2BomHz/GtI04CkGovgI55Tw9k/DbF6YLBXxJeNjgvUvdwZzbTst3m5wpfzFmDW48vZIUJsNQT5zVqdBOjq3gWrDDdkjWv2FjAxa6wQ++fuTcWgyZhFZZKcP4Jz4rm0ZhSxc=
Received: from SN6PR05MB4845.namprd05.prod.outlook.com (52.135.114.206) by
 SN6PR05MB5168.namprd05.prod.outlook.com (20.177.250.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12; Mon, 27 Jan 2020 10:48:10 +0000
Received: from SN6PR05MB4845.namprd05.prod.outlook.com
 ([fe80::6c4f:1012:10ba:848f]) by SN6PR05MB4845.namprd05.prod.outlook.com
 ([fe80::6c4f:1012:10ba:848f%4]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:48:10 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:53 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:53 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:52 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 07/10] qtnfmac: cleanup alignment in firmware communication
 protocol
Thread-Topic: [PATCH 07/10] qtnfmac: cleanup alignment in firmware
 communication protocol
Thread-Index: AQHV1P8WuSgkX+NvKEWdD/uWL/S/sA==
Date:   Mon, 27 Jan 2020 10:46:53 +0000
Message-ID: <20200127104634.7248-8-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: f280fb77-2afa-4d83-3b59-08d7a31638bb
x-ms-traffictypediagnostic: SN6PR05MB5391:|SN6PR05MB5168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB53912630F1D3392A70773A1BA30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:48:07 AM
x-ms-oob-tlc-oobclassifiers: OLM:283;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39840400004)(396003)(346002)(376002)(136003)(189003)(199004)(86362001)(30864003)(103116003)(66446008)(66946007)(66476007)(54906003)(36756003)(64756008)(66556008)(6916009)(316002)(5660300002)(8936002)(8676002)(81156014)(81166006)(1076003)(478600001)(52116002)(4326008)(71200400001)(107886003)(186003)(16526019)(26005)(7696005)(2906002)(2616005)(956004)(6486002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB5168;H:SN6PR05MB4845.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wm7A0jCDhoCBn2Omc9KPFgCWGHvzOVxsPQcBDyXcA7VKt3ftsDsgy08pDN9rOFunMZDf+N1dINDek61CvxWMNvABIJP2vefNBcWhkNjGKIo//49SmUYEZZ9zHQlSk0wTw6W+bAvLk4vDuz/MNzjFumtyI1DxBDSy1UmHPKflqckx3XWRJDC00DdxjitkpvzHN9+eDl0tQsFvWyE7P4LhFx5DUhSiCsjOWnhf3VGMfXrcRru9kw8Rl4i2AUlYLZM0aE21dADsuSAUmLe0po3AF9F2xGybToaEFJkYw0OvdIxx01ez/ZUys6HSELLSLX8mE021v7J4D8jUF3amreqfzrmfBQSRqvIWbV2Pdh2xXgkIUjHrpdoeaswuUHavtHfUXs5fa5tM1acmvCtXT0N8vFiMpiZBwVCZla+EMXGKm2FFcMQ9yV5nJFrA5zcA+SVN
x-ms-exchange-antispam-messagedata: L4xZEShZBCDYLoHSAT3jq4EbBqDZWm0dExEnJy9bOf3UzCcInwQofLqesnnQt3Zd6GZCpgH62Nj2cVge2Max7oekwyppvOvufMEoN85VaIPwTEHj7banpBNpGAHdHKOyMRU/xNtynKISPBYeQiDj3A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f280fb77-2afa-4d83-3b59-08d7a31638bb
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8ZMx2Vl7CrjkEGIEL1dfXMAR4vEjdav5n9EC7UcH+NhRgxII/NonfyBq4gmjmoR8uBJ9uT4pecouRFmalsHDVqM7t6qeYX7OVjf1n8NtAqOe3LhBxiWFiLS//hT7l9vy8NnBgb7IXV/JI7AxpB58hNuxfJcLxWEdMyJ8tk/SZonEAQQUM13U7dbmTY8OXTvAwICxECsbRe9qQsyTOIz3Q==
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:48:10.2767
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5168
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Make sure that all elements in QLINK protocol message are aligned to
4 bytes. For this purpose add necessary amount of padding bytes to
each message. Besides, add padding for non-aligned variable length
fields, e.g. SSID, so that the first byte of the next variable length
element is aligned. to 4 bytes. Finally, introduce TLV parsing helpers
to reduce boilerplate TLV parsing code.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c  | 142 ++++++++---------=
----
 drivers/net/wireless/quantenna/qtnfmac/event.c     |  58 ++-------
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     |  27 +++-
 .../net/wireless/quantenna/qtnfmac/qlink_util.h    |  37 +++---
 4 files changed, 103 insertions(+), 161 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index a4be2aa19997..1271d38e4c7a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -175,7 +175,8 @@ static void qtnf_cmd_tlv_ie_set_add(struct sk_buff *cmd=
_skb, u8 frame_type,
 {
 	struct qlink_tlv_ie_set *tlv;
=20
-	tlv =3D (struct qlink_tlv_ie_set *)skb_put(cmd_skb, sizeof(*tlv) + len);
+	tlv =3D (struct qlink_tlv_ie_set *)skb_put(cmd_skb, sizeof(*tlv) +
+						 round_up(len, QLINK_ALIGN));
 	tlv->hdr.type =3D cpu_to_le16(QTN_TLV_ID_IE_SET);
 	tlv->hdr.len =3D cpu_to_le16(len + sizeof(*tlv) - sizeof(tlv->hdr));
 	tlv->type =3D frame_type;
@@ -190,20 +191,24 @@ static bool qtnf_cmd_start_ap_can_fit(const struct qt=
nf_vif *vif,
 {
 	unsigned int len =3D sizeof(struct qlink_cmd_start_ap);
=20
-	len +=3D s->ssid_len;
-	len +=3D s->beacon.head_len;
-	len +=3D s->beacon.tail_len;
-	len +=3D s->beacon.beacon_ies_len;
-	len +=3D s->beacon.proberesp_ies_len;
-	len +=3D s->beacon.assocresp_ies_len;
-	len +=3D s->beacon.probe_resp_len;
+	len +=3D round_up(s->ssid_len, QLINK_ALIGN);
+	len +=3D round_up(s->beacon.head_len, QLINK_ALIGN);
+	len +=3D round_up(s->beacon.tail_len, QLINK_ALIGN);
+	len +=3D round_up(s->beacon.beacon_ies_len, QLINK_ALIGN);
+	len +=3D round_up(s->beacon.proberesp_ies_len, QLINK_ALIGN);
+	len +=3D round_up(s->beacon.assocresp_ies_len, QLINK_ALIGN);
+	len +=3D round_up(s->beacon.probe_resp_len, QLINK_ALIGN);
=20
 	if (cfg80211_chandef_valid(&s->chandef))
 		len +=3D sizeof(struct qlink_tlv_chandef);
=20
-	if (s->acl)
+	if (s->acl) {
+		unsigned int acl_len =3D struct_size(s->acl, mac_addrs,
+						   s->acl->n_acl_entries);
+
 		len +=3D sizeof(struct qlink_tlv_hdr) +
-		       struct_size(s->acl, mac_addrs, s->acl->n_acl_entries);
+			round_up(acl_len, QLINK_ALIGN);
+	}
=20
 	if (len > (sizeof(struct qlink_cmd) + QTNF_MAX_CMD_BUF_SIZE)) {
 		pr_err("VIF%u.%u: can not fit AP settings: %u\n",
@@ -315,7 +320,8 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
=20
 	if (s->ht_cap) {
 		struct qlink_tlv_hdr *tlv =3D (struct qlink_tlv_hdr *)
-			skb_put(cmd_skb, sizeof(*tlv) + sizeof(*s->ht_cap));
+			skb_put(cmd_skb, sizeof(*tlv) +
+				round_up(sizeof(*s->ht_cap), QLINK_ALIGN));
=20
 		tlv->type =3D cpu_to_le16(WLAN_EID_HT_CAPABILITY);
 		tlv->len =3D cpu_to_le16(sizeof(*s->ht_cap));
@@ -339,7 +345,8 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 		size_t acl_size =3D struct_size(s->acl, mac_addrs,
 					      s->acl->n_acl_entries);
 		struct qlink_tlv_hdr *tlv =3D
-			skb_put(cmd_skb, sizeof(*tlv) + acl_size);
+			skb_put(cmd_skb,
+				sizeof(*tlv) + round_up(acl_size, QLINK_ALIGN));
=20
 		tlv->type =3D cpu_to_le16(QTN_TLV_ID_ACL_DATA);
 		tlv->len =3D cpu_to_le16(acl_size);
@@ -581,10 +588,10 @@ qtnf_sta_info_parse_flags(struct nl80211_sta_flag_upd=
ate *dst,
 }
=20
 static void
-qtnf_cmd_sta_info_parse(struct station_info *sinfo,
-			const struct qlink_tlv_hdr *tlv,
+qtnf_cmd_sta_info_parse(struct station_info *sinfo, const u8 *data,
 			size_t resp_size)
 {
+	const struct qlink_tlv_hdr *tlv;
 	const struct qlink_sta_stats *stats =3D NULL;
 	const u8 *map =3D NULL;
 	unsigned int map_len =3D 0;
@@ -595,7 +602,7 @@ qtnf_cmd_sta_info_parse(struct station_info *sinfo,
 	(qtnf_utils_is_bit_set(map, bitn, map_len) && \
 	 (offsetofend(struct qlink_sta_stats, stat_name) <=3D stats_len))
=20
-	while (resp_size >=3D sizeof(*tlv)) {
+	qlink_for_each_tlv(tlv, data, resp_size) {
 		tlv_len =3D le16_to_cpu(tlv->len);
=20
 		switch (le16_to_cpu(tlv->type)) {
@@ -610,9 +617,11 @@ qtnf_cmd_sta_info_parse(struct station_info *sinfo,
 		default:
 			break;
 		}
+	}
=20
-		resp_size -=3D tlv_len + sizeof(*tlv);
-		tlv =3D (const struct qlink_tlv_hdr *)(tlv->val + tlv_len);
+	if (!qlink_tlv_parsing_ok(tlv, data, resp_size)) {
+		pr_err("Malformed TLV buffer\n");
+		return;
 	}
=20
 	if (!map || !stats)
@@ -736,9 +745,7 @@ int qtnf_cmd_get_sta_info(struct qtnf_vif *vif, const u=
8 *sta_mac,
 		goto out;
 	}
=20
-	qtnf_cmd_sta_info_parse(sinfo,
-				(const struct qlink_tlv_hdr *)resp->info,
-				var_resp_len);
+	qtnf_cmd_sta_info_parse(sinfo, resp->info, var_resp_len);
=20
 out:
 	qtnf_bus_unlock(vif->mac->bus);
@@ -907,18 +914,10 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 	plat_id =3D le32_to_cpu(resp->plat_id);
 	hw_ver =3D le32_to_cpu(resp->hw_ver);
=20
-	tlv =3D (const struct qlink_tlv_hdr *)resp->info;
-
-	while (info_len >=3D sizeof(*tlv)) {
+	qlink_for_each_tlv(tlv, resp->info, info_len) {
 		tlv_type =3D le16_to_cpu(tlv->type);
 		tlv_len =3D le16_to_cpu(tlv->len);
=20
-		if (tlv_len + sizeof(*tlv) > info_len) {
-			pr_warn("malformed TLV 0x%.2X; LEN: %u\n",
-				tlv_type, tlv_len);
-			return -EINVAL;
-		}
-
 		switch (tlv_type) {
 		case QTN_TLV_ID_BUILD_NAME:
 			bld_name =3D (const void *)tlv->val;
@@ -948,9 +947,11 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 		default:
 			break;
 		}
+	}
=20
-		info_len -=3D tlv_len + sizeof(*tlv);
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_len);
+	if (!qlink_tlv_parsing_ok(tlv, resp->info, info_len)) {
+		pr_err("Malformed TLV buffer\n");
+		return -EINVAL;
 	}
=20
 	pr_info("\nBuild name:            %s\n"
@@ -1019,7 +1020,6 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 			     const struct qlink_resp_get_mac_info *resp,
 			     size_t tlv_buf_size)
 {
-	const u8 *tlv_buf =3D resp->var_info;
 	struct ieee80211_iface_combination *comb =3D mac->macinfo.if_comb;
 	size_t n_comb =3D 0;
 	struct ieee80211_iface_limit *limits;
@@ -1029,7 +1029,6 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 	u16 rec_len;
 	u16 tlv_type;
 	u16 tlv_value_len;
-	size_t tlv_full_len;
 	const struct qlink_tlv_hdr *tlv;
 	u8 *ext_capa =3D NULL;
 	u8 *ext_capa_mask =3D NULL;
@@ -1068,16 +1067,9 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 		break;
 	}
=20
-	tlv =3D (const struct qlink_tlv_hdr *)tlv_buf;
-	while (tlv_buf_size >=3D sizeof(struct qlink_tlv_hdr)) {
+	qlink_for_each_tlv(tlv, resp->var_info, tlv_buf_size) {
 		tlv_type =3D le16_to_cpu(tlv->type);
 		tlv_value_len =3D le16_to_cpu(tlv->len);
-		tlv_full_len =3D tlv_value_len + sizeof(struct qlink_tlv_hdr);
-		if (tlv_full_len > tlv_buf_size) {
-			pr_warn("MAC%u: malformed TLV 0x%.2X; LEN: %u\n",
-				mac->macid, tlv_type, tlv_value_len);
-			return -EINVAL;
-		}
=20
 		switch (tlv_type) {
 		case QTN_TLV_ID_IFACE_LIMIT:
@@ -1183,14 +1175,10 @@ qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 				mac->macid, tlv_type);
 			break;
 		}
-
-		tlv_buf_size -=3D tlv_full_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
 	}
=20
-	if (tlv_buf_size) {
-		pr_warn("MAC%u: malformed TLV buf; bytes left: %zu\n",
-			mac->macid, tlv_buf_size);
+	if (!qlink_tlv_parsing_ok(tlv, resp->var_info, tlv_buf_size)) {
+		pr_err("Malformed TLV buffer\n");
 		return -EINVAL;
 	}
=20
@@ -1383,7 +1371,6 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_support=
ed_band *band,
 			     size_t payload_len)
 {
 	u16 tlv_type;
-	size_t tlv_len;
 	size_t tlv_dlen;
 	const struct qlink_tlv_hdr *tlv;
 	const struct qlink_channel *qchan;
@@ -1418,24 +1405,15 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_suppo=
rted_band *band,
 		return -ENOMEM;
 	}
=20
-	tlv =3D (struct qlink_tlv_hdr *)resp->info;
-
-	while (payload_len >=3D sizeof(*tlv)) {
+	qlink_for_each_tlv(tlv, resp->info, payload_len) {
 		tlv_type =3D le16_to_cpu(tlv->type);
 		tlv_dlen =3D le16_to_cpu(tlv->len);
-		tlv_len =3D tlv_dlen + sizeof(*tlv);
-
-		if (tlv_len > payload_len) {
-			pr_warn("malformed TLV 0x%.2X; LEN: %zu\n",
-				tlv_type, tlv_len);
-			goto error_ret;
-		}
=20
 		switch (tlv_type) {
 		case QTN_TLV_ID_CHANNEL:
 			if (unlikely(tlv_dlen !=3D sizeof(*qchan))) {
 				pr_err("invalid channel TLV len %zu\n",
-				       tlv_len);
+				       tlv_dlen);
 				goto error_ret;
 			}
=20
@@ -1538,13 +1516,10 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_suppo=
rted_band *band,
 			pr_warn("unknown TLV type: %#x\n", tlv_type);
 			break;
 		}
-
-		payload_len -=3D tlv_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_dlen);
 	}
=20
-	if (payload_len) {
-		pr_err("malformed TLV buf; bytes left: %zu\n", payload_len);
+	if (!qlink_tlv_parsing_ok(tlv, resp->info, payload_len)) {
+		pr_err("Malformed TLV buffer\n");
 		goto error_ret;
 	}
=20
@@ -1689,16 +1664,16 @@ int qtnf_cmd_send_update_phy_params(struct qtnf_wma=
c *mac, u32 changed)
 		qtnf_cmd_skb_put_tlv_u32(cmd_skb, QTN_TLV_ID_RTS_THRESH,
 					 wiphy->rts_threshold);
 	if (changed & WIPHY_PARAM_COVERAGE_CLASS)
-		qtnf_cmd_skb_put_tlv_u8(cmd_skb, QTN_TLV_ID_COVERAGE_CLASS,
-					wiphy->coverage_class);
+		qtnf_cmd_skb_put_tlv_u32(cmd_skb, QTN_TLV_ID_COVERAGE_CLASS,
+					 wiphy->coverage_class);
=20
 	if (changed & WIPHY_PARAM_RETRY_LONG)
-		qtnf_cmd_skb_put_tlv_u8(cmd_skb, QTN_TLV_ID_LRETRY_LIMIT,
-					wiphy->retry_long);
+		qtnf_cmd_skb_put_tlv_u32(cmd_skb, QTN_TLV_ID_LRETRY_LIMIT,
+					 wiphy->retry_long);
=20
 	if (changed & WIPHY_PARAM_RETRY_SHORT)
-		qtnf_cmd_skb_put_tlv_u8(cmd_skb, QTN_TLV_ID_SRETRY_LIMIT,
-					wiphy->retry_short);
+		qtnf_cmd_skb_put_tlv_u32(cmd_skb, QTN_TLV_ID_SRETRY_LIMIT,
+					 wiphy->retry_short);
=20
 	ret =3D qtnf_cmd_send(mac->bus, cmd_skb);
 	if (ret)
@@ -2054,13 +2029,13 @@ static void qtnf_cmd_scan_set_dwell(struct qtnf_wma=
c *mac,
 		 scan_req->duration_mandatory ? "mandatory" : "max",
 		 dwell_active, dwell_passive, duration);
=20
-	qtnf_cmd_skb_put_tlv_u16(cmd_skb,
+	qtnf_cmd_skb_put_tlv_u32(cmd_skb,
 				 QTN_TLV_ID_SCAN_DWELL_ACTIVE,
 				 dwell_active);
-	qtnf_cmd_skb_put_tlv_u16(cmd_skb,
+	qtnf_cmd_skb_put_tlv_u32(cmd_skb,
 				 QTN_TLV_ID_SCAN_DWELL_PASSIVE,
 				 dwell_passive);
-	qtnf_cmd_skb_put_tlv_u16(cmd_skb,
+	qtnf_cmd_skb_put_tlv_u32(cmd_skb,
 				 QTN_TLV_ID_SCAN_SAMPLE_DURATION,
 				 duration);
 }
@@ -2416,25 +2391,15 @@ qtnf_cmd_resp_proc_chan_stat_info(struct survey_inf=
o *survey,
 {
 	const struct qlink_chan_stats *stats =3D NULL;
 	const struct qlink_tlv_hdr *tlv;
-	size_t tlv_full_len;
 	u16 tlv_value_len;
 	u16 tlv_type;
 	const u8 *map =3D NULL;
 	unsigned int map_len =3D 0;
 	unsigned int stats_len =3D 0;
=20
-	tlv =3D (struct qlink_tlv_hdr *)payload;
-
-	while (payload_len >=3D sizeof(*tlv)) {
+	qlink_for_each_tlv(tlv, payload, payload_len) {
 		tlv_type =3D le16_to_cpu(tlv->type);
 		tlv_value_len =3D le16_to_cpu(tlv->len);
-		tlv_full_len =3D tlv_value_len + sizeof(*tlv);
-
-		if (tlv_full_len > payload_len) {
-			pr_warn("malformed TLV 0x%.2X; LEN: %u\n",
-				tlv_type, tlv_value_len);
-			return -ENOSPC;
-		}
=20
 		switch (tlv_type) {
 		case QTN_TLV_ID_BITMAP:
@@ -2449,13 +2414,10 @@ qtnf_cmd_resp_proc_chan_stat_info(struct survey_inf=
o *survey,
 			pr_info("Unknown TLV type: %#x\n", tlv_type);
 			break;
 		}
-
-		payload_len -=3D tlv_full_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
 	}
=20
-	if (payload_len) {
-		pr_warn("malformed TLV buf; bytes left: %zu\n", payload_len);
+	if (!qlink_tlv_parsing_ok(tlv, payload, payload_len)) {
+		pr_err("Malformed TLV buffer\n");
 		return -EINVAL;
 	}
=20
@@ -2657,7 +2619,7 @@ int qtnf_cmd_set_mac_acl(const struct qtnf_vif *vif,
 	if (!cmd_skb)
 		return -ENOMEM;
=20
-	tlv =3D skb_put(cmd_skb, sizeof(*tlv) + acl_size);
+	tlv =3D skb_put(cmd_skb, sizeof(*tlv) + round_up(acl_size, QLINK_ALIGN));
 	tlv->type =3D cpu_to_le16(QTN_TLV_ID_ACL_DATA);
 	tlv->len =3D cpu_to_le16(acl_size);
 	qlink_acl_data_cfg2q(params, (struct qlink_acl_data *)tlv->val);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/w=
ireless/quantenna/qtnfmac/event.c
index 51af93bdf06e..9d3849488fc7 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -25,7 +25,6 @@ qtnf_event_handle_sta_assoc(struct qtnf_wmac *mac, struct=
 qtnf_vif *vif,
 	size_t payload_len;
 	u16 tlv_type;
 	u16 tlv_value_len;
-	size_t tlv_full_len;
 	const struct qlink_tlv_hdr *tlv;
 	int ret =3D 0;
=20
@@ -58,23 +57,17 @@ qtnf_event_handle_sta_assoc(struct qtnf_wmac *mac, stru=
ct qtnf_vif *vif,
 	sinfo->generation =3D vif->generation;
=20
 	payload_len =3D len - sizeof(*sta_assoc);
-	tlv =3D (const struct qlink_tlv_hdr *)sta_assoc->ies;
=20
-	while (payload_len >=3D sizeof(*tlv)) {
+	qlink_for_each_tlv(tlv, sta_assoc->ies, payload_len) {
 		tlv_type =3D le16_to_cpu(tlv->type);
 		tlv_value_len =3D le16_to_cpu(tlv->len);
-		tlv_full_len =3D tlv_value_len + sizeof(struct qlink_tlv_hdr);
-
-		if (tlv_full_len > payload_len) {
-			ret =3D -EINVAL;
-			goto out;
-		}
=20
 		if (tlv_type =3D=3D QTN_TLV_ID_IE_SET) {
 			const struct qlink_tlv_ie_set *ie_set;
 			unsigned int ie_len;
=20
-			if (payload_len < sizeof(*ie_set)) {
+			if (tlv_value_len <
+			    (sizeof(*ie_set) - sizeof(ie_set->hdr))) {
 				ret =3D -EINVAL;
 				goto out;
 			}
@@ -88,12 +81,10 @@ qtnf_event_handle_sta_assoc(struct qtnf_wmac *mac, stru=
ct qtnf_vif *vif,
 				sinfo->assoc_req_ies_len =3D ie_len;
 			}
 		}
-
-		payload_len -=3D tlv_full_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
 	}
=20
-	if (payload_len) {
+	if (!qlink_tlv_parsing_ok(tlv, sta_assoc->ies, payload_len)) {
+		pr_err("Malformed TLV buffer\n");
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -153,7 +144,6 @@ qtnf_event_handle_bss_join(struct qtnf_vif *vif,
 	size_t payload_len;
 	u16 tlv_type;
 	u16 tlv_value_len;
-	size_t tlv_full_len;
 	const struct qlink_tlv_hdr *tlv;
 	const u8 *rsp_ies =3D NULL;
 	size_t rsp_ies_len =3D 0;
@@ -235,24 +225,17 @@ qtnf_event_handle_bss_join(struct qtnf_vif *vif,
 	}
=20
 	payload_len =3D len - sizeof(*join_info);
-	tlv =3D (struct qlink_tlv_hdr *)join_info->ies;
=20
-	while (payload_len >=3D sizeof(struct qlink_tlv_hdr)) {
+	qlink_for_each_tlv(tlv, join_info->ies, payload_len) {
 		tlv_type =3D le16_to_cpu(tlv->type);
 		tlv_value_len =3D le16_to_cpu(tlv->len);
-		tlv_full_len =3D tlv_value_len + sizeof(struct qlink_tlv_hdr);
-
-		if (payload_len < tlv_full_len) {
-			pr_warn("invalid %u TLV\n", tlv_type);
-			status =3D WLAN_STATUS_UNSPECIFIED_FAILURE;
-			goto done;
-		}
=20
 		if (tlv_type =3D=3D QTN_TLV_ID_IE_SET) {
 			const struct qlink_tlv_ie_set *ie_set;
 			unsigned int ie_len;
=20
-			if (payload_len < sizeof(*ie_set)) {
+			if (tlv_value_len <
+			    (sizeof(*ie_set) - sizeof(ie_set->hdr))) {
 				pr_warn("invalid IE_SET TLV\n");
 				status =3D WLAN_STATUS_UNSPECIFIED_FAILURE;
 				goto done;
@@ -275,15 +258,10 @@ qtnf_event_handle_bss_join(struct qtnf_vif *vif,
 				break;
 			}
 		}
-
-		payload_len -=3D tlv_full_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
 	}
=20
-	if (payload_len)
-		pr_warn("VIF%u.%u: unexpected remaining payload: %zu\n",
-			vif->mac->macid, vif->vifid, payload_len);
-
+	if (!qlink_tlv_parsing_ok(tlv, join_info->ies, payload_len))
+		pr_warn("Malformed TLV buffer\n");
 done:
 	cfg80211_connect_result(vif->netdev, join_info->bssid, NULL, 0, rsp_ies,
 				rsp_ies_len, status, GFP_KERNEL);
@@ -368,7 +346,6 @@ qtnf_event_handle_scan_results(struct qtnf_vif *vif,
 	size_t payload_len;
 	u16 tlv_type;
 	u16 tlv_value_len;
-	size_t tlv_full_len;
 	const struct qlink_tlv_hdr *tlv;
 	const u8 *ies =3D NULL;
 	size_t ies_len =3D 0;
@@ -387,21 +364,17 @@ qtnf_event_handle_scan_results(struct qtnf_vif *vif,
 	}
=20
 	payload_len =3D len - sizeof(*sr);
-	tlv =3D (struct qlink_tlv_hdr *)sr->payload;
=20
-	while (payload_len >=3D sizeof(struct qlink_tlv_hdr)) {
+	qlink_for_each_tlv(tlv, sr->payload, payload_len) {
 		tlv_type =3D le16_to_cpu(tlv->type);
 		tlv_value_len =3D le16_to_cpu(tlv->len);
-		tlv_full_len =3D tlv_value_len + sizeof(struct qlink_tlv_hdr);
-
-		if (tlv_full_len > payload_len)
-			return -EINVAL;
=20
 		if (tlv_type =3D=3D QTN_TLV_ID_IE_SET) {
 			const struct qlink_tlv_ie_set *ie_set;
 			unsigned int ie_len;
=20
-			if (payload_len < sizeof(*ie_set))
+			if (tlv_value_len <
+			    (sizeof(*ie_set) - sizeof(ie_set->hdr)))
 				return -EINVAL;
=20
 			ie_set =3D (const struct qlink_tlv_ie_set *)tlv;
@@ -424,12 +397,9 @@ qtnf_event_handle_scan_results(struct qtnf_vif *vif,
 				ies_len =3D ie_len;
 			}
 		}
-
-		payload_len -=3D tlv_full_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
 	}
=20
-	if (payload_len)
+	if (!qlink_tlv_parsing_ok(tlv, sr->payload, payload_len))
 		return -EINVAL;
=20
 	bss =3D cfg80211_inform_bss(wiphy, channel, frame_type,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 16acb10386ad..3577482c5076 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -19,6 +19,8 @@
 #define QLINK_PROTO_VER		\
 	QLINK_VER(QLINK_PROTO_VER_MAJOR, QLINK_PROTO_VER_MINOR)
=20
+#define QLINK_ALIGN	4
+
 #define QLINK_MACID_RSVD		0xFF
 #define QLINK_VIFID_RSVD		0xFF
=20
@@ -184,7 +186,7 @@ struct qlink_chandef {
 	__le16 center_freq1;
 	__le16 center_freq2;
 	u8 width;
-	u8 rsvd;
+	u8 rsvd[3];
 } __packed;
=20
 #define QLINK_MAX_NR_CIPHER_SUITES            5
@@ -340,9 +342,9 @@ struct qlink_cmd {
 	struct qlink_msg_header mhdr;
 	__le16 cmd_id;
 	__le16 seq_num;
-	u8 rsvd[2];
 	u8 macid;
 	u8 vifid;
+	u8 rsvd[2];
 } __packed;
=20
 /**
@@ -404,6 +406,7 @@ struct qlink_cmd_mgmt_frame_register {
 	struct qlink_cmd chdr;
 	__le16 frame_type;
 	u8 do_register;
+	u8 rsvd[1];
 } __packed;
=20
 /**
@@ -441,6 +444,7 @@ struct qlink_cmd_frame_tx {
 struct qlink_cmd_get_sta_info {
 	struct qlink_cmd chdr;
 	u8 sta_addr[ETH_ALEN];
+	u8 rsvd[2];
 } __packed;
=20
 /**
@@ -460,6 +464,7 @@ struct qlink_cmd_add_key {
 	u8 addr[ETH_ALEN];
 	__le32 cipher;
 	__le16 vlanid;
+	u8 rsvd[2];
 	u8 key_data[0];
 } __packed;
=20
@@ -489,6 +494,7 @@ struct qlink_cmd_set_def_key {
 	u8 key_index;
 	u8 unicast;
 	u8 multicast;
+	u8 rsvd[1];
 } __packed;
=20
 /**
@@ -499,6 +505,7 @@ struct qlink_cmd_set_def_key {
 struct qlink_cmd_set_def_mgmt_key {
 	struct qlink_cmd chdr;
 	u8 key_index;
+	u8 rsvd[3];
 } __packed;
=20
 /**
@@ -515,6 +522,7 @@ struct qlink_cmd_change_sta {
 	__le16 if_type;
 	__le16 vlanid;
 	u8 sta_addr[ETH_ALEN];
+	u8 rsvd[2];
 } __packed;
=20
 /**
@@ -525,8 +533,9 @@ struct qlink_cmd_change_sta {
 struct qlink_cmd_del_sta {
 	struct qlink_cmd chdr;
 	__le16 reason_code;
-	u8 subtype;
 	u8 sta_addr[ETH_ALEN];
+	u8 subtype;
+	u8 rsvd[3];
 } __packed;
=20
 enum qlink_sta_connect_flags {
@@ -593,6 +602,7 @@ struct qlink_cmd_external_auth {
 struct qlink_cmd_disconnect {
 	struct qlink_cmd chdr;
 	__le16 reason;
+	u8 rsvd[2];
 } __packed;
=20
 /**
@@ -604,6 +614,7 @@ struct qlink_cmd_disconnect {
 struct qlink_cmd_updown {
 	struct qlink_cmd chdr;
 	u8 if_up;
+	u8 rsvd[3];
 } __packed;
=20
 /**
@@ -627,6 +638,7 @@ enum qlink_band {
 struct qlink_cmd_band_info_get {
 	struct qlink_cmd chdr;
 	u8 band;
+	u8 rsvd[3];
 } __packed;
=20
 /**
@@ -702,6 +714,7 @@ struct qlink_cmd_chan_switch {
 	u8 radar_required;
 	u8 block_tx;
 	u8 beacon_count;
+	u8 rsvd[3];
 } __packed;
=20
 /**
@@ -805,6 +818,7 @@ struct qlink_cmd_pm_set {
 	struct qlink_cmd chdr;
 	__le32 pm_standby_timer;
 	u8 pm_mode;
+	u8 rsvd[3];
 } __packed;
=20
 /**
@@ -1225,6 +1239,7 @@ struct qlink_event_bss_join {
 struct qlink_event_bss_leave {
 	struct qlink_event ehdr;
 	__le16 reason;
+	u8 rsvd[2];
 } __packed;
=20
 /**
@@ -1341,10 +1356,10 @@ struct qlink_event_radar {
  */
 struct qlink_event_external_auth {
 	struct qlink_event ehdr;
+	__le32 akm_suite;
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
-	u8 ssid_len;
 	u8 bssid[ETH_ALEN];
-	__le32 akm_suite;
+	u8 ssid_len;
 	u8 action;
 } __packed;
=20
@@ -1560,6 +1575,7 @@ struct qlink_tlv_ie_set {
 	struct qlink_tlv_hdr hdr;
 	u8 type;
 	u8 flags;
+	u8 rsvd[2];
 	u8 ie_data[0];
 } __packed;
=20
@@ -1572,6 +1588,7 @@ struct qlink_tlv_ie_set {
 struct qlink_tlv_ext_ie {
 	struct qlink_tlv_hdr hdr;
 	u8 eid_ext;
+	u8 rsvd[3];
 	u8 ie_data[0];
 } __packed;
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink_util.h b/drivers/=
net/wireless/quantenna/qtnfmac/qlink_util.h
index f873beed2ae7..9164b750396c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink_util.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink_util.h
@@ -20,8 +20,9 @@ static inline void qtnf_cmd_skb_put_tlv_arr(struct sk_buf=
f *skb,
 					    u16 tlv_id, const u8 arr[],
 					    size_t arr_len)
 {
-	struct qlink_tlv_hdr *hdr =3D skb_put(skb, sizeof(*hdr) + arr_len);
+	struct qlink_tlv_hdr *hdr;
=20
+	hdr =3D skb_put(skb, sizeof(*hdr) + round_up(arr_len, QLINK_ALIGN));
 	hdr->type =3D cpu_to_le16(tlv_id);
 	hdr->len =3D cpu_to_le16(arr_len);
 	memcpy(hdr->val, arr, arr_len);
@@ -35,27 +36,6 @@ static inline void qtnf_cmd_skb_put_tlv_tag(struct sk_bu=
ff *skb, u16 tlv_id)
 	hdr->len =3D cpu_to_le16(0);
 }
=20
-static inline void qtnf_cmd_skb_put_tlv_u8(struct sk_buff *skb, u16 tlv_id=
,
-					   u8 value)
-{
-	struct qlink_tlv_hdr *hdr =3D skb_put(skb, sizeof(*hdr) + sizeof(value));
-
-	hdr->type =3D cpu_to_le16(tlv_id);
-	hdr->len =3D cpu_to_le16(sizeof(value));
-	*hdr->val =3D value;
-}
-
-static inline void qtnf_cmd_skb_put_tlv_u16(struct sk_buff *skb,
-					    u16 tlv_id, u16 value)
-{
-	struct qlink_tlv_hdr *hdr =3D skb_put(skb, sizeof(*hdr) + sizeof(value));
-	__le16 tmp =3D cpu_to_le16(value);
-
-	hdr->type =3D cpu_to_le16(tlv_id);
-	hdr->len =3D cpu_to_le16(sizeof(value));
-	memcpy(hdr->val, &tmp, sizeof(tmp));
-}
-
 static inline void qtnf_cmd_skb_put_tlv_u32(struct sk_buff *skb,
 					    u16 tlv_id, u32 value)
 {
@@ -85,4 +65,17 @@ u32 qlink_utils_chflags_cfg2q(u32 cfgflags);
 void qlink_utils_regrule_q2nl(struct ieee80211_reg_rule *rule,
 			      const struct qlink_tlv_reg_rule *tlv_rule);
=20
+#define qlink_for_each_tlv(_tlv, _start, _datalen)			\
+	for (_tlv =3D (const struct qlink_tlv_hdr *)(_start);		\
+	     (const u8 *)(_start) + (_datalen) - (const u8 *)_tlv >=3D	\
+		(int)sizeof(*_tlv) &&					\
+	     (const u8 *)(_start) + (_datalen) - (const u8 *)_tlv >=3D	\
+		(int)sizeof(*_tlv) + le16_to_cpu(_tlv->len);		\
+	     _tlv =3D (const struct qlink_tlv_hdr *)(_tlv->val +		\
+		round_up(le16_to_cpu(_tlv->len), QLINK_ALIGN)))
+
+#define qlink_tlv_parsing_ok(_tlv_last, _start, _datalen)	\
+	((const u8 *)(_tlv_last) =3D=3D \
+		(const u8 *)(_start) + round_up(_datalen, QLINK_ALIGN))
+
 #endif /* _QTN_FMAC_QLINK_UTIL_H_ */
--=20
2.11.0

