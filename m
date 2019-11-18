Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA610004F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfKRI0x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:26:53 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:59130 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbfKRI0w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:26:52 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8Mo7Y014367
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:26:51 -0700
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2053.outbound.protection.outlook.com [104.47.49.53])
        by mx0b-00183b01.pphosted.com with ESMTP id 2wad7bc1r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFJu/bcHouWlKu0a30wbwrIif9lGKiME0yTcdyJV7lh5bCWMilAtni7oAbqlBYAWX7iggMb44dAf2GolIZIeEpgaCbxBwOh/7m4/COhd0+8JH9QAymxG9Sl+OrQiiGSq0uCR0DaNPNqb8Z6ERXPNV2MK+3GvMFc1HYAraP16dlpX9tKWZT6u9ofnNF0Pfa9P/yrVBYk1bQE3kN6Q+WxZ4ejf7TNRtP6NiBFubulvph4ih4LBoiiWbLPTa3ZAkL1DyWR6dQIBAQkdWiCuOZYPRvXyMxmeJqUyTZ30sfuluPSTM6dCk+ucBRkHqY8/8bW3dt1eqkJn0/iuVTz9k9FFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjlOWrVV3nAfIqrveudgWRQEJaz3xB+ca0UcR504I0w=;
 b=C95emdOORagFQog1amrFisFkps3nuD5vYS717QPqrxn1CUZPS898hQ1bCSLHVqaYo0MVWQ4duYqaYZYJ+/vtgcoeKOhdNilrgNRHaVA2xX4ZwVQP3tT7Oj6tMaAyRluFQhYOCNwKunQWCcQtaz5KiZS36iXi5cIhC7Dj/2pANAYbAWWEqeZKwwaLDZOeVVCCcMXkNfpum939PAyvif8HfL/xG4MH6Sak9LWRma1f0mefDoQzn82QW3NpiT504ecBxeUegAm2Fqrb74sgoGi5YPJwz0voh1RsUx01UE1/wxvOFWGbitEGY+ovXc/J/9jl9V6OoeiMlJaNc+YQwHCdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjlOWrVV3nAfIqrveudgWRQEJaz3xB+ca0UcR504I0w=;
 b=K0XlKaOq6zt6i7dGArNKoGCYHxJz/mnDjRD+N6ZLyEhw3u81W4+iGqnSTCUjfSLjtaXxS00rNhndVEtFcaBEFatPEXzgsq5+WjzVb5QwDEQymCbC+10+K6geB1C1vHBTdyhNmCfSkh2cQSgRmIIuNlaD4rZ/jB/OaKpDKhWYlg0=
Received: from CY4PR05MB3654.namprd05.prod.outlook.com (10.171.247.150) by
 CY4PR05MB2901.namprd05.prod.outlook.com (10.169.187.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.10; Mon, 18 Nov 2019 08:26:49 +0000
Received: from CY4PR05MB3654.namprd05.prod.outlook.com
 ([fe80::bc1b:71ab:9da9:f5e7]) by CY4PR05MB3654.namprd05.prod.outlook.com
 ([fe80::bc1b:71ab:9da9:f5e7%7]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:26:49 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:04 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:04 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 1/7] qtnfmac: remove VIF in firmware in case of error
Thread-Topic: [PATCH 1/7] qtnfmac: remove VIF in firmware in case of error
Thread-Index: AQHVnelmcE/9nT2PWUyUjLHxu0IUeA==
Date:   Mon, 18 Nov 2019 08:23:04 +0000
Message-ID: <20191118082255.6032-2-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: ea7c2389-fd4a-4dc7-effb-08d76c008893
x-ms-traffictypediagnostic: SN6PR05MB6320:|CY4PR05MB2901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB6320431A3C66A52B5456E978A34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:26:47 AM
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39840400004)(136003)(396003)(346002)(366004)(199004)(189003)(54906003)(86362001)(2906002)(446003)(11346002)(102836004)(305945005)(26005)(7736002)(186003)(6506007)(386003)(3846002)(6116002)(66066001)(436003)(476003)(2616005)(71190400001)(6486002)(76176011)(52116002)(5640700003)(486006)(6916009)(71200400001)(6436002)(6512007)(256004)(5024004)(4326008)(103116003)(316002)(50226002)(64756008)(2501003)(36756003)(2351001)(66476007)(66446008)(66556008)(478600001)(66946007)(14454004)(81166006)(25786009)(107886003)(81156014)(1076003)(99286004)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR05MB2901;H:CY4PR05MB3654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H9Ycm842lfkaq5+yBq9ECa4iGRn0XyWotVR41EbZss713cP1VToKCh0+3LskV+un0yn92v1rMEeq5wDdmkc3Akft4AU4BFAXP/JVERyixJ/M4072u/B9w6q20vb2XVaCMmY0QkOwUO3oBhhuBb/leLqDEEWXKtyCPa53wWQZM2JKPNIcyOmeZjRSiCjw7rJVU+wDjRC65ZP1efCMQxARj42iKAI0mH2ksg2vkyuvGrH7NXsgORnPhqhGPs3FdoF9yNjHLXzLlullFpd9BQE1cxRQRP+ijYyZpMs3736gYchRP/gOJowpkMofuQE4sol14nL7zpIBMQO9uU9+NEDQLyaxlEIU/3k6u2ZwVSesGsZVjQ+Vhwb8ko3aXb7/2viJs/7GNkWVk7t3Md5nykE5shczdHU5NtQCpEJ0HTyq1N6Eq9Y7g27qnM8HaZs5K2+Z
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7c2389-fd4a-4dc7-effb-08d76c008893
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sT09YimVnJXhddSOq602oOv8Odvt3wpyivMGkZPkvhH3n3APwcXrJo84F6DuUc2S0qice9UjD99exsgYDCP0ST3PagrcjXDSPoqaejesvW4HXtgqfNQybVS1EkYTeeXyjWOjg+xgdnrP5u9cMcF2VbOZEbP2v/FNJsnxOPEO1UBR61F3r/jRj+3niy4L434nzhy4mrVqXWcjDufGmcT7J8SQXsocenTwJ/nZCZxMW4c=
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:26:49.2108
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB2901
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180075
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Currently in case of error when registering network device with the
kernel, we won't properly cleanup VIF state in firmware due to DEL_VIF
command will not be send to wifi card. Make sure it does.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c |  8 +++-----
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 19 +++++++++----------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index aa0ed0f2b973..4f02159a69db 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -238,22 +238,20 @@ static struct wireless_dev *qtnf_add_virtual_intf(str=
uct wiphy *wiphy,
 		pr_err("VIF%u.%u: FW reported bad MAC: %pM\n",
 		       mac->macid, vif->vifid, vif->mac_addr);
 		ret =3D -EINVAL;
-		goto err_mac;
+		goto error_del_vif;
 	}
=20
 	ret =3D qtnf_core_net_attach(mac, vif, name, name_assign_t);
 	if (ret) {
 		pr_err("VIF%u.%u: failed to attach netdev\n", mac->macid,
 		       vif->vifid);
-		goto err_net;
+		goto error_del_vif;
 	}
=20
 	vif->wdev.netdev =3D vif->netdev;
 	return &vif->wdev;
=20
-err_net:
-	vif->netdev =3D NULL;
-err_mac:
+error_del_vif:
 	qtnf_cmd_send_del_intf(vif);
 err_cmd:
 	vif->wdev.iftype =3D NL80211_IFTYPE_UNSPECIFIED;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 8116b224c946..9ccc17ad1176 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -465,10 +465,8 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct=
 qtnf_vif *vif,
=20
 	dev =3D alloc_netdev_mqs(sizeof(struct qtnf_vif *), name,
 			       name_assign_type, ether_setup, 1, 1);
-	if (!dev) {
-		vif->wdev.iftype =3D NL80211_IFTYPE_UNSPECIFIED;
+	if (!dev)
 		return -ENOMEM;
-	}
=20
 	vif->netdev =3D dev;
=20
@@ -491,7 +489,7 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct =
qtnf_vif *vif,
 	ret =3D register_netdevice(dev);
 	if (ret) {
 		free_netdev(dev);
-		vif->wdev.iftype =3D NL80211_IFTYPE_UNSPECIFIED;
+		vif->netdev =3D NULL;
 	}
=20
 	return ret;
@@ -588,19 +586,19 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus,=
 unsigned int macid)
 	ret =3D qtnf_cmd_send_get_phy_params(mac);
 	if (ret) {
 		pr_err("MAC%u: failed to get PHY settings\n", macid);
-		goto error;
+		goto error_del_vif;
 	}
=20
 	ret =3D qtnf_mac_init_bands(mac);
 	if (ret) {
 		pr_err("MAC%u: failed to init bands\n", macid);
-		goto error;
+		goto error_del_vif;
 	}
=20
 	ret =3D qtnf_wiphy_register(&bus->hw_info, mac);
 	if (ret) {
 		pr_err("MAC%u: wiphy registration failed\n", macid);
-		goto error;
+		goto error_del_vif;
 	}
=20
 	mac->wiphy_registered =3D 1;
@@ -612,15 +610,16 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus,=
 unsigned int macid)
=20
 	if (ret) {
 		pr_err("MAC%u: failed to attach netdev\n", macid);
-		vif->wdev.iftype =3D NL80211_IFTYPE_UNSPECIFIED;
-		vif->netdev =3D NULL;
-		goto error;
+		goto error_del_vif;
 	}
=20
 	pr_debug("MAC%u initialized\n", macid);
=20
 	return 0;
=20
+error_del_vif:
+	qtnf_cmd_send_del_intf(vif);
+	vif->wdev.iftype =3D NL80211_IFTYPE_UNSPECIFIED;
 error:
 	qtnf_core_mac_detach(bus, macid);
 	return ret;
--=20
2.11.0

