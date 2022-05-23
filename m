Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F9531396
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiEWOJT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiEWOJO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 10:09:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761858E7C
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653314952; x=1684850952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+atr0/0MXTn7B0bydlEGXJeZuoDpzYPQdLS76n4uN5k=;
  b=ZSf5HCAnktUQbdgAr89dz4VwNBwbqumUnyc3iIDeTeOdnJ4MUb88QqvL
   /oDlO5Ii6vBMO7KYDHuBkm6nkB5r5KGNwJX5FGmvnDuZIvDuHk/rUKS6L
   SkSukPrPca/kB8XqrgutR2FqHMg6bCUEz7Yyo/RDF5gJMqDyZjDjWmMCJ
   glXweh/UzK1MZMURxWv3nwuKFZsAdQJfVcA0DOadsvq9XUy/gzGRw05fz
   N2fDQY63hMMxY1sAXbRTUKf+jDzwH6FmSMnY42Q+GkED8es9qOeQSzPIg
   o08JIDc06GU6uuyU/K8vdPvuQHT/1+1CADa8ro1qXKVTlmjF3enlzk34u
   g==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="165280799"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 07:09:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 07:09:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 23 May 2022 07:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmoRLmCYWkB0zOf7qwrSbh3r0wszaqqhVkb8IPwlJ6vqW6R4mDfkgP/3Gt/d1sysLisME9IrcJNKpUCGEUdRuXxNy1yR7bt0/ag25KIzOqWKwYs4lkbapbTxZKBoP0gwBgeRn9EFI0LVeW3FkuK5YiMYuJ/m4Ev0mquhiRPHofBcfT4QA306npAKJw/3dA1aBvYUpw7Z/c6BxzUQ0+rpCIMh3h+CAlnkEbflGLlt95RLG85DGimeDYLk0Rtqb2/2C9t6+xb+r0wyNgwpeHZ7cN7dHcslCT12b3WMgwAKN5RifImtCC9MTJjU2mE7BRck4c7+5Ooq/p2XCNt8D7Eu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/RbBnx9MuTxXy3AIuE07M1tgT9K4llkesdWxxCcjfc=;
 b=AIRfyyRm22Kam78WOkcYVqGJqSzs4zarA5VUHilMNQ8qZXwaX4eyjbqTNsIOIXky7W4mv7Y9nbvWwDAztLVNCV5ktNt2Abg0GQkn9XRQIx59OLFEfjpjxZowD9I0lhDHs2bpO2songwIC5ek8mFrmC9CwjPV+4sfWYByOyEFSspzPvpQlCEXVGlsTcGCw+fu7Q2f25TsN8ojnGY+HxreL3NPJYkEvMCm6kYmGfjWe1IjTfmn412ir/d11NT48X6xHpVlhRiY0bmMKNVPKE2i5AdcvCqP88cDhX8JwrD8W3/ZmFuBZXUjjKfWIMZe2NGcHzTi7WrbHqSUZA9buA/ULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/RbBnx9MuTxXy3AIuE07M1tgT9K4llkesdWxxCcjfc=;
 b=iHNUvLB4sHAnJo5VGjYznI1wZT+X/gx8/shAmMrZLoFUs9cJ58hC8R7fm7rt1LnSCqVCeN6hByCuXCno9avFtVAgncjJCileSjwFp1nI23RuTjK+SROaCIZL6HjIKCZoxhez5+fIftObzsgdaN+Zy+Iidsjy74uwacaOvmJayzw=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 14:09:08 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 14:09:08 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 4/4] wilc1000: add IGTK support
Thread-Topic: [PATCH v2 4/4] wilc1000: add IGTK support
Thread-Index: AQHYbq6rTRndsxX6oEWOZv6VnFIdPg==
Date:   Mon, 23 May 2022 14:09:08 +0000
Message-ID: <20220523140812.164028-4-ajay.kathat@microchip.com>
References: <20220523140812.164028-1-ajay.kathat@microchip.com>
In-Reply-To: <20220523140812.164028-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c823430c-f1c5-4dc0-5922-08da3cc5cdeb
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB560076D1335649CADA556374E3D49@SJ0PR11MB5600.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7a1FHWcp/C43N+Tq+kq4rQputLFaQHqHowx1aSdaL59DDJs+xg63V57R0vM+ScKbU8R3gSwub6zMPaHeEO28NKpLESryFF7HK5RHxDCmymfZOqmt8Mv8250mHXkkyeVHkyhEJ/MAh94vLzAcWNqsW6IQYGo3kahrYOp7t+08Qbz0dqrW6ODZ2HhWNDnbLo/hTLPQYM1hURZvIGsikRCDpNQCdozwAGQxOKiu4a+oC1tr5P0k9nfRE/h4Fj5KmbdfxqF4YVZ6vV6aOgvs8EB5By3wvHejiYynOOuOemHyGGt+T5as+cvGiuZPKdLdgLNrqAoZeatm2Xa9sZhlRgZUc8WWewfZOYJ10d4arRrI3Z4oxXcgG9iPR8yOw9JP2R9jE9huJ/lg4ROhGOr8B7FGNWylkgUS8oMYSxX8VZzszGyPTP57jDubdweoBpwWbtoucZpYRVhvMna0otkAQhLtnfuniZy+0zxe+JATDX7kescGvwU16aN1xUgg7pWtK5L4GyKAUrZVifdccwkcFK7SpGPv5NHZak74WT8ke7K2HYUmd4KcAWS1Yb3RXpXlURsFE4ApcciB9Kq9OejWMcnIqOGs1Yt8ktak0GPJsOmva3wLn7WT+C+dJ6THPnMIiMrAzlZ3okx+Nv8TvkeqdoJNUCB8EjmFjuP3uwqTJ+rkLIRRTmfHjUBXRXMhrVhimEdgP/KeOdrskQN9KbUpBU6PVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(83380400001)(76116006)(86362001)(91956017)(5660300002)(6486002)(36756003)(8936002)(508600001)(64756008)(66446008)(66946007)(316002)(8676002)(66476007)(66556008)(186003)(6512007)(30864003)(6916009)(122000001)(6506007)(54906003)(1076003)(107886003)(2616005)(2906002)(71200400001)(38070700005)(38100700002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2bTykAOBrXTBi8g2nJN/cS6d41ib373j8k8foFNH5bwSaEtLrHkKirf+gK?=
 =?iso-8859-1?Q?5TD1QVQsdvPpxnJajx1xmmgnPlMAt26IznUNyYVADG5TR+ULHO0D25f1NW?=
 =?iso-8859-1?Q?d5RMQISyEe+m2ocLygxuYWMuN/ZsTBoXhOLa7DADQSAy8lEiTcwvHMUkve?=
 =?iso-8859-1?Q?cUcfQiSoiAm+8wtLA6qh8FVfomhX2w/vRTnSjt38xI1bl3KoVNvis16+uB?=
 =?iso-8859-1?Q?vmBV4AJdVf04dkxiveri5cej2vK1rSzUNHFrKuEvw7DNFsTqe6O7AuBcP7?=
 =?iso-8859-1?Q?KBUZKYNZA6phyQgh1eQetRVfGMc1wAEa/tQ4I3VnuSAKyCm4dAgqqDBBaq?=
 =?iso-8859-1?Q?NFH2WQUX2GfE0FbiQ3DBPWrv+NwnbwQuoZy3Od03Qwok0i0xGX5DMuNcMH?=
 =?iso-8859-1?Q?d5GSppVbGbLoGYHgJBcLLgHm1/aaveIBk6w89+jCDJLPxL688nmA+7Vq67?=
 =?iso-8859-1?Q?gJiApNiTAf3cXYWRl0QWbYCmwhbJEYjO3Xfgo3w47cGbeUIEJde1DCKoBS?=
 =?iso-8859-1?Q?UU14niGpqerU8htkDOllQuS0bpkoDZAPkj46UKiAxA21YyiOhjpk6T8TZq?=
 =?iso-8859-1?Q?oPxEyxP94X2TffrOQ4bruqiW5r2mnSSyNO8EefKcoh14nmQKbtuLGFMMlD?=
 =?iso-8859-1?Q?aEJgS+fmbnCsvx/QYlnQ6QjDIh4dUvpgUB48stG47Vlae3WUaIqk3Cqlbv?=
 =?iso-8859-1?Q?ysAz9QAI5dkFHxmm40KLU/CJB07/ftLs7jkQpq/HpWV6JOUwBFPaCr3xBI?=
 =?iso-8859-1?Q?N7TDdwwV4Odo9ihZNV7fJc+SUzwbVq1KNznUu2ZphL0BY/mryALDFXID4z?=
 =?iso-8859-1?Q?ZrngRjGbHONDH1GmtLazg28/FlWjO0yk92860unD5V/fUNK4jnEpsSVm39?=
 =?iso-8859-1?Q?JU0KI14xG7GD4Gbh61zonq53jvjzT4teyc5P3rL0TAdXbbVkUScLl2ZytO?=
 =?iso-8859-1?Q?MG6iCtgdgpSzrmwFdtxm4YPqRXYDO6HfWUzHRH6y34kvRNns7rs3OhaslX?=
 =?iso-8859-1?Q?ltT04RL45gyIulwDEJ5gCzdLQRycZTuqOxkWr9yRbsBVkcvVJqUNG979mz?=
 =?iso-8859-1?Q?Ye+2aFWKF64MRSjmnEWhhZB13wA1lLbOX/17nqlMbXnZVLW7uC8KLlHxex?=
 =?iso-8859-1?Q?6QLZlhcDXbNYkuQHR9Ix4ha83mSst9il4Z3hKqp9YO9L0Boi0B4lPNzhVA?=
 =?iso-8859-1?Q?1F/+J4w0qxXFTDMIMj/dkFvKmDuuzPlIkdVU1/wfkdhgucI/mblecYjs7e?=
 =?iso-8859-1?Q?1wd9Uq0REVfTpVY2SrNbj1ude5k/enmQHHC35kDA0uOvOZm1PRBFOsJJqf?=
 =?iso-8859-1?Q?5D4YjfflmycrV9Z/dFjR0nkCazupB+pwoHP/vcRbQY+rBdaq3cKB+1FZ4d?=
 =?iso-8859-1?Q?AoKgkf4GRUk3Evn6N+xFG3WV1XTF+MhskdYLqqw8xCQ1uk8Ni07kTtp0ff?=
 =?iso-8859-1?Q?P7GgqIwtC+6Em9myFZE9hMXWhFVMC4J/hIQUrHxEx2ktxpLSh80xg9aiOJ?=
 =?iso-8859-1?Q?CX6jCmQlBR3PoNy1vurbudZ8Ywq/BNVaKcPXZFkY0tWAQjkY9Fecy0A6G4?=
 =?iso-8859-1?Q?XVsO46zuObNtXRyW9k4pfKlgKCWQubG0HQEHPi+V2pxpn5dPPV75d50XSF?=
 =?iso-8859-1?Q?RLw8Kpe54Ik6pH/dfVGxbIjIOP8SfKyHYZ7hatlk0Mr8Kl6nTcqS95olek?=
 =?iso-8859-1?Q?B9Ow0Kdz7739hlGN603Ex6ghdwHc0hY0NrRqNA1zUL+YryMsE4zZj87msU?=
 =?iso-8859-1?Q?avtdpHdrd+W5JGXunFwM9DNj/CvW/dZMWhFMo4/5UWUeuK/1yQcE2ry199?=
 =?iso-8859-1?Q?XDZ61AP3BvYWuOlZ7SEsRlP22c1O0IucCjVbLg+NZ4H4ef1AMBYi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c823430c-f1c5-4dc0-5922-08da3cc5cdeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 14:09:08.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fa0MStKjGi5f4vik2xyBES+FieODvU3FczUGkWxS0uqRuTkMs6bxFqWpKF4CcCUxjcrsqgc7J9qfBS6TEVOy8FQ1HproJiQ7Hpt++ERr12E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Add support to handle IGTK keys which are required for MFP to FW. Index ID
4 and 5 are used to store the IGTK key.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 114 ++++++++++++++----
 drivers/net/wireless/microchip/wilc1000/fw.h  |   8 ++
 drivers/net/wireless/microchip/wilc1000/hif.c |  56 ++++++++-
 drivers/net/wireless/microchip/wilc1000/hif.h |   5 +
 .../net/wireless/microchip/wilc1000/netdev.h  |   1 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  10 ++
 6 files changed, 171 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index ea59ce9fd991..1ac4684fab25 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -307,6 +307,7 @@ static int connect(struct wiphy *wiphy, struct net_devi=
ce *dev,
 	int ret;
 	u32 i;
 	u8 security =3D WILC_FW_SEC_NO;
+	enum mfptype mfp_type =3D WILC_FW_MFP_NONE;
 	enum authtype auth_type =3D WILC_FW_AUTH_ANY;
 	u32 cipher_group;
 	struct cfg80211_bss *bss;
@@ -416,6 +417,13 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 	wfi_drv->conn_info.arg =3D priv;
 	wfi_drv->conn_info.param =3D join_params;
=20
+	if (sme->mfp =3D=3D NL80211_MFP_OPTIONAL)
+		mfp_type =3D WILC_FW_MFP_OPTIONAL;
+	else if (sme->mfp =3D=3D NL80211_MFP_REQUIRED)
+		mfp_type =3D WILC_FW_MFP_REQUIRED;
+
+	wfi_drv->conn_info.mfp_type =3D mfp_type;
+
 	ret =3D wilc_set_join_req(vif, bss->bssid, sme->ie, sme->ie_len);
 	if (ret) {
 		netdev_err(dev, "wilc_set_join_req(): Error\n");
@@ -495,6 +503,18 @@ static int wilc_wfi_cfg_allocate_wpa_entry(struct wilc=
_priv *priv, u8 idx)
 	return 0;
 }
=20
+static int wilc_wfi_cfg_allocate_wpa_igtk_entry(struct wilc_priv *priv, u8=
 idx)
+{
+	idx -=3D 4;
+	if (!priv->wilc_igtk[idx]) {
+		priv->wilc_igtk[idx] =3D kzalloc(sizeof(*priv->wilc_igtk[idx]),
+					       GFP_KERNEL);
+		if (!priv->wilc_igtk[idx])
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
 				      struct key_params *params)
 {
@@ -531,6 +551,7 @@ static int add_key(struct wiphy *wiphy, struct net_devi=
ce *netdev, u8 key_index,
 	u8 op_mode;
 	struct wilc_vif *vif =3D netdev_priv(netdev);
 	struct wilc_priv *priv =3D &vif->priv;
+	struct wilc_wfi_key *key;
=20
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -594,6 +615,26 @@ static int add_key(struct wiphy *wiphy, struct net_dev=
ice *netdev, u8 key_index,
 					   key_index);
=20
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		ret =3D wilc_wfi_cfg_allocate_wpa_igtk_entry(priv, key_index);
+		if (ret)
+			return -ENOMEM;
+
+		key =3D priv->wilc_igtk[key_index - 4];
+		ret =3D wilc_wfi_cfg_copy_wpa_info(key, params);
+		if (ret)
+			return -ENOMEM;
+
+		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP ||
+		    priv->wdev.iftype =3D=3D NL80211_IFTYPE_P2P_GO)
+			op_mode =3D WILC_AP_MODE;
+		else
+			op_mode =3D WILC_STATION_MODE;
+
+		ret =3D wilc_add_igtk(vif, params->key, keylen, params->seq,
+				    params->seq_len, mac_addr, op_mode,
+				    key_index);
+		break;
=20
 	default:
 		netdev_err(netdev, "%s: Unsupported cipher\n", __func__);
@@ -611,23 +652,34 @@ static int del_key(struct wiphy *wiphy, struct net_de=
vice *netdev,
 	struct wilc_vif *vif =3D netdev_priv(netdev);
 	struct wilc_priv *priv =3D &vif->priv;
=20
-	if (priv->wilc_gtk[key_index]) {
-		kfree(priv->wilc_gtk[key_index]->key);
-		priv->wilc_gtk[key_index]->key =3D NULL;
-		kfree(priv->wilc_gtk[key_index]->seq);
-		priv->wilc_gtk[key_index]->seq =3D NULL;
-
-		kfree(priv->wilc_gtk[key_index]);
-		priv->wilc_gtk[key_index] =3D NULL;
-	}
-
-	if (priv->wilc_ptk[key_index]) {
-		kfree(priv->wilc_ptk[key_index]->key);
-		priv->wilc_ptk[key_index]->key =3D NULL;
-		kfree(priv->wilc_ptk[key_index]->seq);
-		priv->wilc_ptk[key_index]->seq =3D NULL;
-		kfree(priv->wilc_ptk[key_index]);
-		priv->wilc_ptk[key_index] =3D NULL;
+	if (!pairwise && (key_index =3D=3D 4 || key_index =3D=3D 5)) {
+		key_index -=3D 4;
+		if (priv->wilc_igtk[key_index]) {
+			kfree(priv->wilc_igtk[key_index]->key);
+			priv->wilc_igtk[key_index]->key =3D NULL;
+			kfree(priv->wilc_igtk[key_index]->seq);
+			priv->wilc_igtk[key_index]->seq =3D NULL;
+			kfree(priv->wilc_igtk[key_index]);
+			priv->wilc_igtk[key_index] =3D NULL;
+		}
+	} else {
+		if (priv->wilc_gtk[key_index]) {
+			kfree(priv->wilc_gtk[key_index]->key);
+			priv->wilc_gtk[key_index]->key =3D NULL;
+			kfree(priv->wilc_gtk[key_index]->seq);
+			priv->wilc_gtk[key_index]->seq =3D NULL;
+
+			kfree(priv->wilc_gtk[key_index]);
+			priv->wilc_gtk[key_index] =3D NULL;
+		}
+		if (priv->wilc_ptk[key_index]) {
+			kfree(priv->wilc_ptk[key_index]->key);
+			priv->wilc_ptk[key_index]->key =3D NULL;
+			kfree(priv->wilc_ptk[key_index]->seq);
+			priv->wilc_ptk[key_index]->seq =3D NULL;
+			kfree(priv->wilc_ptk[key_index]);
+			priv->wilc_ptk[key_index] =3D NULL;
+		}
 	}
=20
 	return 0;
@@ -642,11 +694,20 @@ static int get_key(struct wiphy *wiphy, struct net_de=
vice *netdev, u8 key_index,
 	struct  key_params key_params;
=20
 	if (!pairwise) {
-		key_params.key =3D priv->wilc_gtk[key_index]->key;
-		key_params.cipher =3D priv->wilc_gtk[key_index]->cipher;
-		key_params.key_len =3D priv->wilc_gtk[key_index]->key_len;
-		key_params.seq =3D priv->wilc_gtk[key_index]->seq;
-		key_params.seq_len =3D priv->wilc_gtk[key_index]->seq_len;
+		if (key_index =3D=3D 4 || key_index =3D=3D 5) {
+			key_index -=3D 4;
+			key_params.key =3D priv->wilc_igtk[key_index]->key;
+			key_params.cipher =3D priv->wilc_igtk[key_index]->cipher;
+			key_params.key_len =3D priv->wilc_igtk[key_index]->key_len;
+			key_params.seq =3D priv->wilc_igtk[key_index]->seq;
+			key_params.seq_len =3D priv->wilc_igtk[key_index]->seq_len;
+		} else {
+			key_params.key =3D priv->wilc_gtk[key_index]->key;
+			key_params.cipher =3D priv->wilc_gtk[key_index]->cipher;
+			key_params.key_len =3D priv->wilc_gtk[key_index]->key_len;
+			key_params.seq =3D priv->wilc_gtk[key_index]->seq;
+			key_params.seq_len =3D priv->wilc_gtk[key_index]->seq_len;
+		}
 	} else {
 		key_params.key =3D priv->wilc_ptk[key_index]->key;
 		key_params.cipher =3D priv->wilc_ptk[key_index]->cipher;
@@ -667,6 +728,14 @@ static int set_default_key(struct wiphy *wiphy, struct=
 net_device *netdev,
 	return 0;
 }
=20
+static int set_default_mgmt_key(struct wiphy *wiphy, struct net_device *ne=
tdev,
+				u8 key_index)
+{
+	struct wilc_vif *vif =3D netdev_priv(netdev);
+
+	return wilc_set_default_mgmt_key_index(vif, key_index);
+}
+
 static int get_station(struct wiphy *wiphy, struct net_device *dev,
 		       const u8 *mac, struct station_info *sinfo)
 {
@@ -1626,6 +1695,7 @@ static const struct cfg80211_ops wilc_cfg80211_ops =
=3D {
 	.del_key =3D del_key,
 	.get_key =3D get_key,
 	.set_default_key =3D set_default_key,
+	.set_default_mgmt_key =3D set_default_mgmt_key,
 	.add_virtual_intf =3D add_virtual_intf,
 	.del_virtual_intf =3D del_virtual_intf,
 	.change_virtual_intf =3D change_virtual_intf,
diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
index 9449c5d0b472..5c5cac4aab02 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -54,6 +54,14 @@ struct wilc_ap_wpa_ptk {
 	u8 key[];
 } __packed;
=20
+struct wilc_wpa_igtk {
+	u8 index;
+	u8 pn_len;
+	u8 pn[6];
+	u8 key_len;
+	u8 key[];
+} __packed;
+
 struct wilc_gtk_key {
 	u8 mac_addr[ETH_ALEN];
 	u8 rsc[8];
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 5d9d3aba737c..4038a254465f 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -271,12 +271,19 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u=
8 scan_type,
 static int wilc_send_connect_wid(struct wilc_vif *vif)
 {
 	int result =3D 0;
-	struct wid wid_list[4];
+	struct wid wid_list[5];
 	u32 wid_cnt =3D 0;
 	struct host_if_drv *hif_drv =3D vif->hif_drv;
 	struct wilc_conn_info *conn_attr =3D &hif_drv->conn_info;
 	struct wilc_join_bss_param *bss_param =3D conn_attr->param;
=20
+
+        wid_list[wid_cnt].id =3D WID_SET_MFP;
+        wid_list[wid_cnt].type =3D WID_CHAR;
+        wid_list[wid_cnt].size =3D sizeof(char);
+        wid_list[wid_cnt].val =3D (s8 *)&conn_attr->mfp_type;
+        wid_cnt++;
+
 	wid_list[wid_cnt].id =3D WID_INFO_ELEMENT_ASSOCIATE;
 	wid_list[wid_cnt].type =3D WID_BIN_DATA;
 	wid_list[wid_cnt].val =3D conn_attr->req_ies;
@@ -1143,6 +1150,36 @@ int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk=
, u8 ptk_key_len,
 	return result;
 }
=20
+int wilc_add_igtk(struct wilc_vif *vif, const u8 *igtk, u8 igtk_key_len,
+		  const u8 *pn, u8 pn_len, const u8 *mac_addr, u8 mode, u8 index)
+{
+	int result =3D 0;
+	u8 t_key_len =3D igtk_key_len;
+	struct wid wid;
+	struct wilc_wpa_igtk *key_buf;
+
+	key_buf =3D kzalloc(sizeof(*key_buf) + t_key_len, GFP_KERNEL);
+	if (!key_buf)
+		return -ENOMEM;
+
+	key_buf->index =3D index;
+
+	memcpy(&key_buf->pn[0], pn, pn_len);
+	key_buf->pn_len =3D pn_len;
+
+	memcpy(&key_buf->key[0], igtk, igtk_key_len);
+	key_buf->key_len =3D t_key_len;
+
+	wid.id =3D WID_ADD_IGTK;
+	wid.type =3D WID_STR;
+	wid.size =3D sizeof(*key_buf) + t_key_len;
+	wid.val =3D (s8 *)key_buf;
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	kfree(key_buf);
+
+	return result;
+}
+
 int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len=
,
 		    u8 index, u32 key_rsc_len, const u8 *key_rsc,
 		    const u8 *rx_mic, const u8 *tx_mic, u8 mode,
@@ -1932,3 +1969,20 @@ int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_p=
ower)
=20
 	return wilc_send_config_pkt(vif, WILC_GET_CFG, &wid, 1);
 }
+
+int wilc_set_default_mgmt_key_index(struct wilc_vif *vif, u8 index)
+{
+        struct wid wid;
+        int result;
+
+        wid.id =3D WID_DEFAULT_MGMT_KEY_ID;
+        wid.type =3D WID_CHAR;
+        wid.size =3D sizeof(char);
+        wid.val =3D &index;
+        result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+        if (result)
+                netdev_err(vif->ndev,
+                           "Failed to send default mgmt key index\n");
+
+        return result;
+}
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index f1a0a1f042ca..d8dd94dcfe14 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -108,6 +108,7 @@ struct wilc_conn_info {
 	u8 bssid[ETH_ALEN];
 	u8 security;
 	enum authtype auth_type;
+	enum mfptype mfp_type;
 	u8 ch;
 	u8 *req_ies;
 	size_t req_ies_len;
@@ -155,6 +156,9 @@ struct wilc_vif;
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index);
+int wilc_add_igtk(struct wilc_vif *vif, const u8 *igtk, u8 igtk_key_len,
+		  const u8 *pn, u8 pn_len, const u8 *mac_addr, u8 mode,
+		  u8 index);
 s32 wilc_get_inactive_time(struct wilc_vif *vif, const u8 *mac,
 			   u32 *out_val);
 int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len=
,
@@ -210,4 +214,5 @@ void wilc_network_info_received(struct wilc *wilc, u8 *=
buffer, u32 length);
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th);
 void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				struct cfg80211_crypto_settings *crypto);
+int wilc_set_default_mgmt_key_index(struct wilc_vif *vif, u8 index);
 #endif
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index a0d9e981500e..822e65d00f53 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -129,6 +129,7 @@ struct wilc_priv {
 	struct net_device *real_ndev;
 	struct wilc_wfi_key *wilc_gtk[WILC_MAX_NUM_STA];
 	struct wilc_wfi_key *wilc_ptk[WILC_MAX_NUM_STA];
+	struct wilc_wfi_key *wilc_igtk[2];
 	u8 wilc_groupkey;
=20
 	/* mutexes */
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index 18f13b5643e8..df2f5a63bdf6 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -91,6 +91,12 @@ enum authtype {
 	WILC_FW_AUTH_OPEN_SYSTEM_SHA256 =3D 13
 };
=20
+enum mfptype {
+	WILC_FW_MFP_NONE =3D 0x0,
+	WILC_FW_MFP_OPTIONAL =3D 0x1,
+	WILC_FW_MFP_REQUIRED =3D 0x2
+};
+
 enum site_survey {
 	WILC_FW_SITE_SURVEY_1CH =3D 0,
 	WILC_FW_SITE_SURVEY_ALL_CH =3D 1,
@@ -661,6 +667,9 @@ enum {
 	WID_LOG_TERMINAL_SWITCH		=3D 0x00CD,
 	WID_TX_POWER			=3D 0x00CE,
 	WID_WOWLAN_TRIGGER		=3D 0X00CF,
+	WID_SET_MFP                     =3D 0x00D0,
+
+	WID_DEFAULT_MGMT_KEY_ID		=3D 0x00D2,
 	/*  EMAC Short WID list */
 	/*  RTS Threshold */
 	/*
@@ -750,6 +759,7 @@ enum {
 	WID_REMOVE_KEY			=3D 0x301E,
 	WID_ASSOC_REQ_INFO		=3D 0x301F,
 	WID_ASSOC_RES_INFO		=3D 0x3020,
+	WID_ADD_IGTK                    =3D 0x3022,
 	WID_MANUFACTURER		=3D 0x3026, /* Added for CAPI tool */
 	WID_MODEL_NAME			=3D 0x3027, /* Added for CAPI tool */
 	WID_MODEL_NUM			=3D 0x3028, /* Added for CAPI tool */
--=20
2.25.1
