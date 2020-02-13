Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FE15BDF2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBMLp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:45:59 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:17030 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729511AbgBMLp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:45:59 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DBhBds010061
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:45:58 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00183b01.pphosted.com with ESMTP id 2y1ufxergd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUZxEN8oYe1Vo5REHk+r2Vu3A1qeFX6u/VClPIhscXoCvSYJ7EDO8cvP80ex4JdIIzv4c4A4XD4sO2LvXHQfE/YhdFcawdEQQM4ARILKRGbKr0eRUsfFVARCsHwkD6Mrkrj2xw+YhsjuYqURUvZR5s7sPPnVt0Sd7ckgKVya7LuA/vaWuDyPPsEE1QOIDokB3Ksz00MGaIEqwl80DLRNk3BTAOeXJ9dFUI2VI+HZ9x+eDxm5tEeElW3Curcp5NAvcIA+RuRXdSJIPhNzdceb9kAQKkzAHh+j5TQiUoVnE0AFI7l7W1FLVwA83FZoSfkCMIylHXuqYiX7/FyDsaq6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el9npCRvZOYKPizhWjXAh+K6CK3jY3SRFNl394/bMFM=;
 b=iDJblHeovyd9TCJKb6OPojFCrk2Ls/w4SnjQQdcYuixfodNfROSdoZqFM9ngPKLaR5mTiIXQ0TMIn9zQXQy+TgC+tJhW5aXZ4hUCzkPzbOcMUzX3pl1RdVJLa3VIXakWjdskvN63K/t/+tHeCewkBRklKKssZ5bWZawsgmXFtdnHc7lbLNwqSBHFJ08aW/+wlgiji9bBQ3SipG9NQIU5tO/7vFSuTsluDhls1F6uMUHiRr+wuKMRanKykfIu82EIZo2lHrxCJJgs3XRyN2PPxgqCqTz6jJ5WDBeS4UC1WYiIzuj0HCrBJukVA5B/y4Iuib61cLQpFymbe+qNwMoE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el9npCRvZOYKPizhWjXAh+K6CK3jY3SRFNl394/bMFM=;
 b=dVpBjSAEf6wsmlI3e5h3Fum/USPEJafU+pwOMHYu5nBhXMdd1cd/s/hY0gT/obRe93zvd9Fp4InnQgZniGvweOawujHEir0AkEW1MNjaUFc5tQaEimYWG70KWc9KneLYvFdGae4KlH3jnkFlL3m+4RaNPv7mIMV0HGqgPiBZhX0=
Received: from SN6PR05MB4109.namprd05.prod.outlook.com (52.132.125.141) by
 SN6PR05MB4078.namprd05.prod.outlook.com (52.132.124.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.6; Thu, 13 Feb 2020 11:45:56 +0000
Received: from SN6PR05MB4109.namprd05.prod.outlook.com
 ([fe80::6476:f5a8:6675:edc6]) by SN6PR05MB4109.namprd05.prod.outlook.com
 ([fe80::6476:f5a8:6675:edc6%7]) with mapi id 15.20.2750.000; Thu, 13 Feb 2020
 11:45:56 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5597.namprd05.prod.outlook.com (52.135.111.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:45:28 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:45:28 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0129.eurprd05.prod.outlook.com (2603:10a6:7:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 11:45:27 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 1/5] qtnfmac: support WPA3 SAE in AP mode
Thread-Topic: [PATCH 1/5] qtnfmac: support WPA3 SAE in AP mode
Thread-Index: AQHV4mMWctbKJmYQ5EeAELHrKvmqUg==
Date:   Thu, 13 Feb 2020 11:45:28 +0000
Message-ID: <20200213114518.4415-2-sergey.matyukevich.os@quantenna.com>
References: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0129.eurprd05.prod.outlook.com
 (2603:10a6:7:28::16) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 262b71f4-621d-4602-4a34-08d7b07a38a9
x-ms-traffictypediagnostic: SN6PR05MB5597:|SN6PR05MB4078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB55972196FEB0AFCDC72B669BA31A0@SN6PR05MB5597.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:45:53 AM
x-ms-oob-tlc-oobclassifiers: OLM:87;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(136003)(366004)(346002)(199004)(189003)(1076003)(66446008)(316002)(7696005)(52116002)(64756008)(66476007)(66556008)(81166006)(66946007)(86362001)(478600001)(2616005)(956004)(103116003)(16526019)(5660300002)(26005)(2906002)(186003)(36756003)(6486002)(4326008)(107886003)(81156014)(6916009)(71200400001)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4078;H:SN6PR05MB4109.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgYmGOdORkN9S2Vm/7EbgWQFWgg+LveJwhNjwgvGFSDpzQEJ2XLmEpd/r+aFfX++sAbA7wGeF7YUAmmLW1a4Mpkwf+nQzU/2jOzjgX4JYTPZBpf/a8+JG01oHOiRJgpKaKd7ggbHa+5LXC44XnH5BQAS17/4wZio0NrVLjr5xR1gyKmzfYVXI3/MqHGdpTkxYfCtnhKlbTergGIBRHNcM0HEBKmfX4X84s1I5/4AqrC9oa+1heiaXR6OG0cuU5ID+72aSOJkneRM06k312rfM3lribjMYzJdjV9kzV0wXUWPPyZiERIdOcqcrwW2FkJPeayBU9ObsqV+Lr/kZE2zHvSBqSQoO0FXNzqCYSAZ0+fDxZI1cAotVV7t7TxFGm5BUB+wlIdmEVWKxab/bsJofjE2+qWaqNBQJ0fxp1jMLSm+t1TECHK5PhbQJzAIdmrE
x-ms-exchange-antispam-messagedata: Ajr/ZLCkFv5I17lDc6ETHYOVYY8xkOHCdxTxvT6tECMbTqE082TiUtpnL5z6SnVyq/c/9ivwHQhMcsjDt07CakyR5QFWwTeqItyF+7y4Ja+kRO3x3MPPHPa0jVrnRwQ+/hp/vGjF3JNFjCjccIaKTA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262b71f4-621d-4602-4a34-08d7b07a38a9
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHk0mroDFlGxx5g3tuOTHr8l1DihRpYElnN8sgyYLBUaKntGPpTG7r5drPDJVB04iJlrQH6p+fCqaCpnuBVg+Q1W4MgaAm3TdbRADGxzxdQSf/Q3+PFPCjWMyixVayrwMBAbZbnpfAoNJILCMUA3Wks4Cq0U8ER6O7SSC7d72RiYDbEL2qJG82Ga/SG4hYaE
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:45:56.0672
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4078
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=990 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130093
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable WPA3 SAE support in AP mode. Driver currently supports cards
that offload SAE authentication to userspace. So allow userspace
software to subscribe and to send AUTH frames. Besides, enable
AP mode support in external_auth cfg80211 callback.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c | 9 ++++-----
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c    | 6 +++---
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index 73d5014a4234..a5ab1270add1 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -60,7 +60,8 @@ qtnf_mgmt_stypes[NUM_NL80211_IFTYPES] =3D {
 		      BIT(IEEE80211_STYPE_AUTH >> 4),
 	},
 	[NL80211_IFTYPE_AP] =3D {
-		.tx =3D BIT(IEEE80211_STYPE_ACTION >> 4),
+		.tx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4),
 		.rx =3D BIT(IEEE80211_STYPE_ACTION >> 4) |
 		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
 		      BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
@@ -679,10 +680,8 @@ qtnf_external_auth(struct wiphy *wiphy, struct net_dev=
ice *dev,
 	struct qtnf_vif *vif =3D qtnf_netdev_get_priv(dev);
 	int ret;
=20
-	if (vif->wdev.iftype !=3D NL80211_IFTYPE_STATION)
-		return -EOPNOTSUPP;
-
-	if (!ether_addr_equal(vif->bssid, auth->bssid))
+	if (vif->wdev.iftype =3D=3D NL80211_IFTYPE_STATION &&
+	    !ether_addr_equal(vif->bssid, auth->bssid))
 		pr_warn("unexpected bssid: %pM", auth->bssid);
=20
 	ret =3D qtnf_cmd_send_external_auth(vif, auth);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index ccc1e06dfcf6..4a4c213fe9f1 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -2211,7 +2211,7 @@ int qtnf_cmd_send_external_auth(struct qtnf_vif *vif,
=20
 	cmd =3D (struct qlink_cmd_external_auth *)cmd_skb->data;
=20
-	ether_addr_copy(cmd->bssid, auth->bssid);
+	ether_addr_copy(cmd->peer, auth->bssid);
 	cmd->status =3D cpu_to_le16(auth->status);
=20
 	qtnf_bus_lock(vif->mac->bus);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/w=
ireless/quantenna/qtnfmac/event.c
index 7e408b5c5549..cb610a7864ea 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -578,9 +578,9 @@ qtnf_event_handle_external_auth(struct qtnf_vif *vif,
 	ether_addr_copy(auth.bssid, ev->bssid);
 	auth.action =3D ev->action;
=20
-	pr_info("%s: external auth bss=3D%pM action=3D%u akm=3D%u\n",
-		vif->netdev->name, auth.bssid, auth.action,
-		auth.key_mgmt_suite);
+	pr_debug("%s: external SAE processing: bss=3D%pM action=3D%u akm=3D%u\n",
+		 vif->netdev->name, auth.bssid, auth.action,
+		 auth.key_mgmt_suite);
=20
 	ret =3D cfg80211_external_auth_request(vif->netdev, &auth, GFP_KERNEL);
 	if (ret)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 7ee1070f985f..5e9254f8fa8a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -589,7 +589,7 @@ struct qlink_cmd_connect {
  */
 struct qlink_cmd_external_auth {
 	struct qlink_cmd chdr;
-	u8 bssid[ETH_ALEN];
+	u8 peer[ETH_ALEN];
 	__le16 status;
 	u8 payload[0];
 } __packed;
--=20
2.11.0

