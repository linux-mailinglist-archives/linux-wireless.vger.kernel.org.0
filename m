Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF7FAF53
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfKMLHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:39 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:30068 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727780AbfKMLHj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:39 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADArlt3028773
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:37 -0700
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2055.outbound.protection.outlook.com [104.47.41.55])
        by mx0b-00183b01.pphosted.com with ESMTP id 2w7psmbgb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAnqhzUbC8mLSEqp5wB4wX0GtebhbWdwsGq4StRISZgBzzXqpYCwHuF1aLTswvUhJEu+NgQ+MxVI/GqLftQRdKRqWqgnc8oEpnA5FUJgwWnm7Y0UeF6B4fLuvqHantHhEPiCEEF9XOjDG15wFrOD1QlIQlbLqPEXXe5cK3xgwFiCdMms5vlmdMVRh58sDmxZOJOHhcXqZTn7pGqPbNwXmuINil7/kp6b5htdXPleHockI+RkmQyHK9FwzPtwcdMUYj3OOFeejjCg3OlR2+8CRFyfCO8+EkgyWkVXyaVJYRMuKcWDaSB2UYLa0GtTECa/szltFWI1HKRWWqXgVesvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unbZJshkuaKpYC0MuiWC54zXGOmrKukjn4+euqiSGpI=;
 b=UbeXmu4jnMLxl1ufGts+NyF0oLtpu4FyNp3Phv9zBTQNiyyi1qCvDOsblTH2F+ouaKQHtkjuAagnF+nJIqXoijs5tzEyWnIeRiF13dvBFFHyVphTLUogVG9PX7kgS2vVqLN4aAPWEeHXclcQ1g3agYytys419vusu3LZ/5xU93sjjwzGAEhbJc7pbl3qzoG1z8Q0hMi/G0uSuaxxE5E76QEbxHHLlyczYoRjnIYUL/hZ9QL3kKiGN4XrdsDBhNJYgzR1dAPP+HSgNFjp6odxZOswQZWODBweHf6JE5Ls5T2eCbNq+AldFPh/fVmrE7yT1Eubx4Qt8KKjkaLGllqM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unbZJshkuaKpYC0MuiWC54zXGOmrKukjn4+euqiSGpI=;
 b=PqHasP6LkQKbbOSecbaS3CIRLI95wb8UUAKLAhLfo9PnLgX0LTC5ujnuDXoy94C/kR0PSRkTIp42MrNy7DjBlgHNNGo15Lfp2liceyvvoOWl6iQuMozSsRf4hXAjy4TK4FVmE3snITLoeBV8bR/yCYpvfJgQy/z4RXD7PLaHHtA=
Received: from DM5PR0501MB3733.namprd05.prod.outlook.com (10.167.110.151) by
 DM5PR0501MB3701.namprd05.prod.outlook.com (10.167.106.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.21; Wed, 13 Nov 2019 11:07:36 +0000
Received: from DM5PR0501MB3733.namprd05.prod.outlook.com
 ([fe80::6848:5b92:9e42:fc23]) by DM5PR0501MB3733.namprd05.prod.outlook.com
 ([fe80::6848:5b92:9e42:fc23%2]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:07:36 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5295.namprd05.prod.outlook.com (52.135.109.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:06:58 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:06:58 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 6/7] qtnfmac: handle MIC failure event from firmware
Thread-Topic: [PATCH 6/7] qtnfmac: handle MIC failure event from firmware
Thread-Index: AQHVmhJ37ztStXznuU6xhMrM859dCA==
Date:   Wed, 13 Nov 2019 11:06:57 +0000
Message-ID: <20191113110639.9226-7-sergey.matyukevich.os@quantenna.com>
References: <20191113110639.9226-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191113110639.9226-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3206c4d-0e80-4039-32e6-08d768299999
x-ms-traffictypediagnostic: SN6PR05MB5295:|DM5PR0501MB3701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB52950B7EC20F56BB20464080A3760@SN6PR05MB5295.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:34 AM
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(376002)(346002)(136003)(366004)(189003)(199004)(26005)(316002)(81156014)(81166006)(2906002)(256004)(103116003)(14454004)(66946007)(14444005)(8936002)(1076003)(478600001)(446003)(99286004)(102836004)(2501003)(6916009)(476003)(54906003)(6506007)(76176011)(386003)(11346002)(2616005)(36756003)(186003)(436003)(71190400001)(71200400001)(107886003)(8676002)(486006)(52116002)(86362001)(6436002)(25786009)(4326008)(5640700003)(6486002)(7736002)(66476007)(3846002)(66446008)(66556008)(6512007)(66066001)(50226002)(5660300002)(6116002)(2351001)(305945005)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0501MB3701;H:DM5PR0501MB3733.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ja/MjinHhaWpGeTeC6GNCdMRoZaNxnhTdPPdgXqsPG1VeyH+i0rN2kfuROOIWjWpZE1msmNCzj1HFXiv8tK3tmuMCf04GeGdcftl8GGaKxOrcnBO871901JfTP409Bst8r9Nxtdo0/PZAVV6Sb0cdyDu4eNUocE0Y4q34cwOtdcZr+JfxzRi6bYL2l1NMXDitevCoyW7iAIPdfP0ZXIzcPTufVouonIpafJ8DMIhW+h0d0mIXmTlOZmcrmy8E5ya8xyxMBvyy1e8jjF4mVGVG2tn0beCKjT+p+lOu28hon176WYjYE80P8O/+SrV3UNYbhBgF5RZhKJSGooJWKg46rqA8E9RwTORmdCzrSlXc6xDSbCVQIGzkVAziIMbXM9Cy1lIxqAUhfKebZQHrRfM/wDM/PKiIvBUEP52PLtUUS+udZSQGa3d4emTGPBNQbdK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3206c4d-0e80-4039-32e6-08d768299999
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfBtWLzskz2cr/pZ1o6+IjMarnXO1lk5V190vZofhLlssyZsKU1XJiFjROu2i4AjiXIkb5S581xuc6uHTzQvnbqum9RinSW4oy6RdV8pKJRy2KOQIPaV3DpCxUNCoRDoSvjtoYFTarCTY6eu40oKNBWe1eh0afvMyl0Ofb5UIBRhHrRgBqY8qWnLKfbq5EUV6+STEFWOxHJ0oaPqW5ENqkma/tRCHfamIYBIQh/jAWYV6ruU78txyijqZ76joTnr
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:36.3169
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3701
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911130103
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report MIC failure from firmware to cfg80211 subsystem
using dedicated callback cfg80211_michael_mic_failure.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/event.c | 40 ++++++++++++++++++++++=
++++
 drivers/net/wireless/quantenna/qtnfmac/qlink.h | 15 ++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/w=
ireless/quantenna/qtnfmac/event.c
index 7846383c8828..51af93bdf06e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -618,6 +618,42 @@ qtnf_event_handle_external_auth(struct qtnf_vif *vif,
 	return ret;
 }
=20
+static int
+qtnf_event_handle_mic_failure(struct qtnf_vif *vif,
+			      const struct qlink_event_mic_failure *mic_ev,
+			      u16 len)
+{
+	struct wiphy *wiphy =3D priv_to_wiphy(vif->mac);
+	u8 pairwise;
+
+	if (len < sizeof(*mic_ev)) {
+		pr_err("VIF%u.%u: payload is too short (%u < %zu)\n",
+		       vif->mac->macid, vif->vifid, len,
+		       sizeof(struct qlink_event_mic_failure));
+		return -EINVAL;
+	}
+
+	if (!wiphy->registered || !vif->netdev)
+		return 0;
+
+	if (vif->wdev.iftype !=3D NL80211_IFTYPE_STATION) {
+		pr_err("VIF%u.%u: MIC_FAILURE event when not in STA mode\n",
+		       vif->mac->macid, vif->vifid);
+		return -EPROTO;
+	}
+
+	pairwise =3D mic_ev->pairwise ?
+		NL80211_KEYTYPE_PAIRWISE : NL80211_KEYTYPE_GROUP;
+
+	pr_info("%s: MIC error: src=3D%pM key_index=3D%u pairwise=3D%u\n",
+		vif->netdev->name, mic_ev->src, mic_ev->key_index, pairwise);
+
+	cfg80211_michael_mic_failure(vif->netdev, mic_ev->src, pairwise,
+				     mic_ev->key_index, NULL, GFP_KERNEL);
+
+	return 0;
+}
+
 static int qtnf_event_parse(struct qtnf_wmac *mac,
 			    const struct sk_buff *event_skb)
 {
@@ -680,6 +716,10 @@ static int qtnf_event_parse(struct qtnf_wmac *mac,
 		ret =3D qtnf_event_handle_external_auth(vif, (const void *)event,
 						      event_len);
 		break;
+	case QLINK_EVENT_MIC_FAILURE:
+		ret =3D qtnf_event_handle_mic_failure(vif, (const void *)event,
+						    event_len);
+		break;
 	default:
 		pr_warn("unknown event type: %x\n", event_id);
 		break;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 8a3c6344fa8e..ac1ebe4bb580 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -958,6 +958,7 @@ enum qlink_event_type {
 	QLINK_EVENT_FREQ_CHANGE		=3D 0x0028,
 	QLINK_EVENT_RADAR		=3D 0x0029,
 	QLINK_EVENT_EXTERNAL_AUTH	=3D 0x0030,
+	QLINK_EVENT_MIC_FAILURE		=3D 0x0031,
 };
=20
 /**
@@ -1151,6 +1152,20 @@ struct qlink_event_external_auth {
 	u8 action;
 } __packed;
=20
+/**
+ * struct qlink_event_mic_failure - data for QLINK_EVENT_MIC_FAILURE event
+ *
+ * @src: source MAC address of the frame
+ * @key_index: index of the key being reported
+ * @pairwise: whether the key is pairwise or group
+ */
+struct qlink_event_mic_failure {
+	struct qlink_event ehdr;
+	u8 src[ETH_ALEN];
+	u8 key_index;
+	u8 pairwise;
+} __packed;
+
 /* QLINK TLVs (Type-Length Values) definitions
  */
=20
--=20
2.11.0

