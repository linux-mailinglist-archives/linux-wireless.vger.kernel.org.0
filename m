Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2310009B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKRImP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:42:15 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:64690 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbfKRImP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:42:15 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8e7fK006573
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:42:13 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0b-00183b01.pphosted.com with ESMTP id 2waew9ux9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4t7JfgTYAjlSW3e+538f+0/j9GpITR4vdUee1rU1imI93LcL3Ay7lCwp2tWq71T4Fk2NLfcs/mWEizEKCaZ24gLug5I0dL3hcc6YPZq98+GCk0GnbiWevYYkGfdrM/C76liW6wgK+njIIpa57uKB4QbLd5BXDKSVgKhQCoqTyQ3695hKeqcki8JGnn0COZe0IWAwxJEgL4TZbsOWRwKfOcmvkQwJrwVu8kXZUoOGwe5kjEEFPwsTdFKTylY4KoiPgBKastJQue3XMw0GQZL0rN/rRdO+smV29mDpMmsuID2PdKx5eTEntNLruzBfP78r5SVIdYuChZ1mYmyWQ9xDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFPXb7eGTO4UjtFF0jCHL6v2DUynuNFrC+UtByV6kXA=;
 b=m6w+c6AJB0gqDu49ppNjFgxpmBbjc3Q2jQ20R1i3kPGWDHeVLKEFceD/lxYWqfO6iOhfBzaJ3j3IL9zBYjVVfSRBTo7USqSXAQv8IwgM9Rc98lyda6szv0e7uRdmXL/f7exlRi+NgxW4rkkfZnvoEjcNXU/WR6Okn4WT1nyFAOR6PuNXpZBCw0WkOel7mzvGMIn+T9DdJhFuZIUqzL1BZePZKtUr8XmZjF2LeT5Wy9pE2Efazztqwuuk5UwmUgjZ6PEjR7TFV3gAd4Gl6AfayZEm2C155P1rHY4VC/jmlbSRKy3x2C/6xMnct58xyagqyafNvHHR7bxs/WJOgo8THg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFPXb7eGTO4UjtFF0jCHL6v2DUynuNFrC+UtByV6kXA=;
 b=S3TXQj+Xnik4AjgN+IeFhkyWOXk93mRPGOMUo+4YBc4XeIAA2mffxedjEYFwIt+AyOr3XqamMTMhL/vSnGkvqIOot2P7tinxGK5S5kWYItmkSTc/CAbLKnjMFb4grLT/+rgUWv34PPQpw2xgXJrXeJMXVSG8X6SheTydYQ2a9Ac=
Received: from SN6PR05MB5328.namprd05.prod.outlook.com (52.135.111.216) by
 SN6PR05MB4095.namprd05.prod.outlook.com (52.135.66.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.9; Mon, 18 Nov 2019 08:27:24 +0000
Received: from SN6PR05MB5328.namprd05.prod.outlook.com
 ([fe80::3801:4c01:20fc:2aa6]) by SN6PR05MB5328.namprd05.prod.outlook.com
 ([fe80::3801:4c01:20fc:2aa6%6]) with mapi id 15.20.2474.015; Mon, 18 Nov 2019
 08:27:24 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:17 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:17 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 7/7] qtnfmac: process HE capabilities requests
Thread-Topic: [PATCH 7/7] qtnfmac: process HE capabilities requests
Thread-Index: AQHVneltVi/rQ8KGKEyoXxJmDlwU6w==
Date:   Mon, 18 Nov 2019 08:23:16 +0000
Message-ID: <20191118082255.6032-8-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 9d00f7b5-fb3a-47a8-b513-08d76c008fdd
x-ms-traffictypediagnostic: SN6PR05MB6320:|SN6PR05MB4095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB6320C77A119A3C13EC7C653DA34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:27:21 AM
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(446003)(436003)(2906002)(2616005)(486006)(476003)(11346002)(71200400001)(71190400001)(66066001)(316002)(305945005)(478600001)(36756003)(6506007)(386003)(7736002)(6512007)(5640700003)(6436002)(54906003)(3846002)(4326008)(186003)(86362001)(52116002)(66446008)(64756008)(66556008)(66476007)(81156014)(81166006)(26005)(8676002)(6116002)(66946007)(1076003)(107886003)(76176011)(2501003)(2351001)(102836004)(103116003)(25786009)(6486002)(14454004)(99286004)(50226002)(256004)(14444005)(5660300002)(8936002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4095;H:SN6PR05MB5328.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+Ik266OuNc8hAGTunRuBeBpIu4EtKKAcBegNiN3L6LklMtUHdbyrrIp+SKPlIIvvTvpK9OEuJwho2EeBAXuMtje0wSVNj4FjVwLgmTs6MLJbsm6gBDItJhNQ/yOVDHFGdO1/GyuKSR8/igvX3n7w9yRA4bKp8UN7tDjYkBV18JUrUiihGhiFCi3CJ0CVeJn/tarRpKXTBxvTh5pZcj8C8IDdmi6EH/sL74RGhKhXcDWVtz6voDndm89R7P9iUJCPfOV4Qe1JV9t/mzmo5H6DelqyAndCDraU4twV4hrNYHoFo1o5H4HHOxw0FEYCzQLhAWbMeC89ctlCL0TVyJOpXzx5wLfyjjRsTjvoKcqL0k61XunZ8MyDmmdBTzaDjndufPF6Z9jvxeMyZ/Klzezt3XwGNYz8foV+MMEPcGHCDNL+hxybqBwADcnwFdYsBsE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d00f7b5-fb3a-47a8-b513-08d76c008fdd
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lj7BcbTLQ4pIom5dutm6PLblnXxfK7zra9ZcSwtz7XxsO2GWiBSVA2IMw83AZlyoiRE22mgvfRRjDGB6T5+N7frDa8BvDq/gANJvPhdBRhDQcxKWw8V1I++MeRZ6AyMSe/WMQEacSFPws1w0HFW3wqTxsgqGnr8/jKwLET3/4851ECD2HYQHwhIIghO7n66BS+ug3OJakHujQjZW7q3yRn5iy+eZuRFOGsAqHuf1Yz8=
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:27:24.0472
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4095
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mikhail Karpenko <mkarpenko@quantenna.com>

Pass HE interface type data requests between firmware and driver.

Signed-off-by: Mikhail Karpenko <mkarpenko@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 90 +++++++++++++++++++=
+++-
 drivers/net/wireless/quantenna/qtnfmac/core.c     |  3 +
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 1c1b377932cf..548f6ff6d0f2 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -214,6 +214,20 @@ static bool qtnf_cmd_start_ap_can_fit(const struct qtn=
f_vif *vif,
 	return true;
 }
=20
+static void qtnf_cmd_tlv_ie_ext_add(struct sk_buff *cmd_skb, u8 eid_ext,
+				    const void *buf, size_t len)
+{
+	struct qlink_tlv_ext_ie *tlv;
+
+	tlv =3D (struct qlink_tlv_ext_ie *)skb_put(cmd_skb, sizeof(*tlv) + len);
+	tlv->hdr.type =3D cpu_to_le16(WLAN_EID_EXTENSION);
+	tlv->hdr.len =3D cpu_to_le16(sizeof(*tlv) + len - sizeof(tlv->hdr));
+	tlv->eid_ext =3D eid_ext;
+
+	if (len && buf)
+		memcpy(tlv->ie_data, buf, len);
+}
+
 int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 			   const struct cfg80211_ap_settings *s)
 {
@@ -309,6 +323,10 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 		memcpy(tlv->val, s->vht_cap, sizeof(*s->vht_cap));
 	}
=20
+	if (s->he_cap)
+		qtnf_cmd_tlv_ie_ext_add(cmd_skb, WLAN_EID_EXT_HE_CAPABILITY,
+					s->he_cap, sizeof(*s->he_cap));
+
 	if (s->acl) {
 		size_t acl_size =3D struct_size(s->acl, mac_addrs,
 					      s->acl->n_acl_entries);
@@ -1292,6 +1310,69 @@ static void qtnf_cmd_resp_band_fill_vhtcap(const u8 =
*info,
 	memcpy(&bcap->vht_mcs, &vht_cap->supp_mcs, sizeof(bcap->vht_mcs));
 }
=20
+static void qtnf_cmd_conv_iftype(struct ieee80211_sband_iftype_data
+				  *iftype_data,
+				  const struct qlink_sband_iftype_data
+				  *qlink_data)
+{
+	iftype_data->types_mask =3D le16_to_cpu(qlink_data->types_mask);
+
+	iftype_data->he_cap.has_he =3D true;
+	memcpy(&iftype_data->he_cap.he_cap_elem, &qlink_data->he_cap_elem,
+	       sizeof(qlink_data->he_cap_elem));
+	memcpy(iftype_data->he_cap.ppe_thres, qlink_data->ppe_thres,
+	       ARRAY_SIZE(qlink_data->ppe_thres));
+
+	iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80 =3D
+		qlink_data->he_mcs_nss_supp.rx_mcs_80;
+	iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80 =3D
+		qlink_data->he_mcs_nss_supp.tx_mcs_80;
+	iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_160 =3D
+		qlink_data->he_mcs_nss_supp.rx_mcs_160;
+	iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160 =3D
+		qlink_data->he_mcs_nss_supp.tx_mcs_160;
+	iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80p80 =3D
+		qlink_data->he_mcs_nss_supp.rx_mcs_80p80;
+	iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80p80 =3D
+		qlink_data->he_mcs_nss_supp.tx_mcs_80p80;
+}
+
+static int qtnf_cmd_band_fill_iftype(const u8 *data,
+				     struct ieee80211_supported_band *band)
+{
+	unsigned int i;
+	struct ieee80211_sband_iftype_data *iftype_data;
+	const struct qlink_tlv_iftype_data *tlv =3D
+		(const struct qlink_tlv_iftype_data *)data;
+	size_t payload_len =3D tlv->n_iftype_data * sizeof(*tlv->iftype_data) +
+		sizeof(*tlv) -
+		sizeof(struct qlink_tlv_hdr);
+
+	if (tlv->hdr.len !=3D cpu_to_le16(payload_len)) {
+		pr_err("bad IFTYPE_DATA TLV len %u\n", tlv->hdr.len);
+		return -EINVAL;
+	}
+
+	kfree(band->iftype_data);
+	band->iftype_data =3D NULL;
+	band->n_iftype_data =3D tlv->n_iftype_data;
+	if (band->n_iftype_data =3D=3D 0)
+		return 0;
+
+	iftype_data =3D kcalloc(band->n_iftype_data, sizeof(*iftype_data),
+			      GFP_KERNEL);
+	if (!iftype_data) {
+		band->n_iftype_data =3D 0;
+		return -ENOMEM;
+	}
+	band->iftype_data =3D iftype_data;
+
+	for (i =3D 0; i < band->n_iftype_data; i++)
+		qtnf_cmd_conv_iftype(iftype_data++, &tlv->iftype_data[i]);
+
+	return 0;
+}
+
 static int
 qtnf_cmd_resp_fill_band_info(struct ieee80211_supported_band *band,
 			     struct qlink_resp_band_info_get *resp,
@@ -1305,6 +1386,7 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_support=
ed_band *band,
 	struct ieee80211_channel *chan;
 	unsigned int chidx =3D 0;
 	u32 qflags;
+	int ret =3D -EINVAL;
=20
 	memset(&band->ht_cap, 0, sizeof(band->ht_cap));
 	memset(&band->vht_cap, 0, sizeof(band->vht_cap));
@@ -1442,6 +1524,12 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_suppor=
ted_band *band,
 			qtnf_cmd_resp_band_fill_vhtcap(tlv->val,
 						       &band->vht_cap);
 			break;
+		case QTN_TLV_ID_IFTYPE_DATA:
+			ret =3D qtnf_cmd_band_fill_iftype((const uint8_t *)tlv,
+							band);
+			if (ret)
+				goto error_ret;
+			break;
 		default:
 			pr_warn("unknown TLV type: %#x\n", tlv_type);
 			break;
@@ -1469,7 +1557,7 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_support=
ed_band *band,
 	band->channels =3D NULL;
 	band->n_channels =3D 0;
=20
-	return -EINVAL;
+	return ret;
 }
=20
 static int qtnf_cmd_resp_proc_phy_params(struct qtnf_wmac *mac,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index f5aa2c547b94..5fb598389487 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -543,6 +543,9 @@ static void qtnf_core_mac_detach(struct qtnf_bus *bus, =
unsigned int macid)
 		if (!wiphy->bands[band])
 			continue;
=20
+		kfree(wiphy->bands[band]->iftype_data);
+		wiphy->bands[band]->n_iftype_data =3D 0;
+
 		kfree(wiphy->bands[band]->channels);
 		wiphy->bands[band]->n_channels =3D 0;
=20
--=20
2.11.0

