Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810655329FA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 14:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiEXMGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 08:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiEXMGb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 08:06:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775B8140F3
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653393988; x=1684929988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QvPShWavlqycyc7emBoGM/bci8w1HSNyYRjB+2WLsK8=;
  b=i2NRht1I17UFJR6cIYw8khlz0+JJBCjeELBcrgzqjVkyGnse+CvRMTSH
   Yo6c3gAP+XKL/jUhl3m2sl7BgS01amSscBgx5sWHjFH9AAKx17cmpn75j
   MCx86wajAPboZ9ZgUx/UHZQ9LyoxUI3AYTqtWOnmyMMleYJ5zAZdiBWiT
   lHtmkKFf/paiZKjxQCxSOwO6sW+Fe8zT1AozPvIsO2FPFAnzRIZx4p0Ov
   txASup3T/6hMfQyAVGRB4JX+wELKIRh3c5OjK5eefbTvwVPmImtPV8nTS
   H1vLUENFnTC7/wZfkP0iQfze0ttzjf0nr+rpbi3hBhIYibB6+vpagOv5o
   w==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="174813202"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2022 05:06:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 24 May 2022 05:06:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 24 May 2022 05:06:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glSzV3ks8HiMqlhP79RfFRnv4hoAEYhyCouSzeqQu/QrSK5Dld0AwRFPDsqVymc0Ovi7zZg09fZ8dM+cqyOdZZmqQKNtR+qmueG/buc0KDKvnHOEeFfl5A9U5k1TFWLaG5HyYa5gQtEKJT/I7ihZXbFZZM/ksZwnvkSYZBWTQUlANBVQx/sAvi21Vk43gkAlV1O/BoqR1YwTBpZslJePc01/ZCW1aQezVqGbUOsM/BQG6/jsdHBAPUGQm7MngfeOZCzy+35zGMJK5beZhz/Xrm82dgMyPiaVZIhBRl6hovdvE49kEHKnHIqVc3oEhirZ7kojeK4m76b8VEVWbnMxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6OPWaXFTzPjXUf2LRzjG60TuPUkZcQmmsfiZeowXhQ=;
 b=ag326NpbeE0iAXvv+SBJ2QubF4EvZv5sxbD5ikV/pRBOu6LCL9fkLG2lV+cjQlzdtRo9FOi52/1is71B1h+gz9K4Nr64sbmDE0p5zzzZL/QWNlFBGZhUvUMvOfb8G2w00Uuy1tn8h5hKcp1nvaY9CBScACQ6sF4x0PbnNBzpG0GqDMxsLCjDkBLWtfMaE3RpU4H1t7hlvS89rrd86Fq/1ZB0UrHImLN1ha3YCak92r5rBeILKkCHaJ2Yw8GSrxj5l+xyGkZKHr2tpJuMJfgesTpXUJ4edYqFcX74PRc7rIPtGhX4wfVtSnWO2uMW9e7pWU5ot5blYUA1hVaErl1Rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6OPWaXFTzPjXUf2LRzjG60TuPUkZcQmmsfiZeowXhQ=;
 b=WPj9ZHiIy2Rxeu6QC1soDlkXWehalohDF1yXoC+tMTdjxGjV7UUiB7whdGLGaKl/dpAH280p/S6iHdjB4/Vt3/7wWSPs91MV1WBaUYzrl6XNzdWnI3ML8cFoCPNRN2WZulbzzzs714M+C3Ipaii5CqblcFZYjyMjow/Wm92hzVY=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 12:06:20 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 12:06:20 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 2/4] wilc1000: remove WEP security support
Thread-Topic: [PATCH v3 2/4] wilc1000: remove WEP security support
Thread-Index: AQHYb2atc0Rv+0c5GkCRWFtb0Wyyww==
Date:   Tue, 24 May 2022 12:06:20 +0000
Message-ID: <20220524120606.9675-2-ajay.kathat@microchip.com>
References: <20220524120606.9675-1-ajay.kathat@microchip.com>
In-Reply-To: <20220524120606.9675-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c01cd2c-7109-4e2d-711b-08da3d7dd060
x-ms-traffictypediagnostic: CH0PR11MB5412:EE_
x-microsoft-antispam-prvs: <CH0PR11MB541258DF24B883B0B9ADABE2E3D79@CH0PR11MB5412.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RaZw5hQkwYnEugvaNiKmmn6nJxjBb9ZtZ4KkVd9AZGXXY0+m04dF9lOQENWDHzX2mMAx1Z4LT4m2ptttDTi/tWbNVqrDVGMEmEoSBbl1pWiU7zI6TRxKXvBiKL5BoBbruWVxrODE70MQprUT3lW5vNbUhYXSDmZyR395gYys0xmLQ61Ux9dRjiuRQ/1NvoxjGpcRDh/cYDBN2t3iVPojoaQCIgO4yhLmiB381MoPXIv7XOUPuP2mpxPlscwbVBo97iyw4tcGGF0kAufAGh3aJxT+TNtpwkCJIBwxnoNZV3QYvutoPwGw+nF4fvGu1ZOznSAUDznJgYyoe/JOVqV49tJ9C8qqNonuUon/ZtvK4cStbWpUudm+5SNAWWub/nZQggxpYdHZronVCRhkNwi9taoZl0hsZ+Ct9C+n3KJrJDgEJaH0bqyuZjOWLdil36wKZLAj4Y3hDBR4HzzzZZpgMLQZLitLoN69in/NZJfX8KmThUeAQMBbpWxNvejXToZ2HDoWL8NqtlKCDQmb+/XcR2GWK2zLVFCYlB7T2/ODELvG2ERU69cLO6sDihrqXLsoDK1MMfY4DWr9HmEgxrdgpiFHQIpDr3bW6FHxUJXLM6HpIYQb3ZjChA89K7W9+3BUrZq/3b1PWFbY2kG+CkldOyRltuBJRN6rovsbpU7kIN53krTxD4VllEWwHVMq02WHj0jbUjDunzGP8aOYwrhzxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(83380400001)(2906002)(8936002)(1076003)(2616005)(6486002)(5660300002)(86362001)(508600001)(26005)(15650500001)(107886003)(38100700002)(38070700005)(36756003)(316002)(122000001)(8676002)(4326008)(6512007)(66946007)(66476007)(6506007)(186003)(66446008)(76116006)(91956017)(64756008)(71200400001)(66556008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?34TevHvIErgbBmE7yneD0kt6NCLwkhnbCY8wpZCDt6+O89OBZNmBuOTwDD?=
 =?iso-8859-1?Q?9xR9fhEPXZZFWq4Ep8ZmT4DjKB03MrPGki2f1NlAuKc/76qqzUSkZSStSE?=
 =?iso-8859-1?Q?qu0dQQlE/jP51Rm0EwASrymBiafvLWt+i4eBdT72CplZkp824qbQivM3SX?=
 =?iso-8859-1?Q?x10srZP8jWJ2w9rLXc7y0JWL4tXqS13sRZXjo1rbWxd0VEU/9jLVU9ja6+?=
 =?iso-8859-1?Q?PKqs+Ehy7j9dW+hCpTSjhGqxurYanc2D8hfGUubY4/7b7/pa5XIdTqcqMh?=
 =?iso-8859-1?Q?zQ+t6Ns7hSWNyeitZLvCm3QJ55/3TofUPhuu28hOPyb1rARbhgIXcDkZZX?=
 =?iso-8859-1?Q?HlOEhfYaem38mbvKsHHYcw6AznIvQYm4cbnA8QSPNU+i5r5ropgMsPibZ7?=
 =?iso-8859-1?Q?mc9eIhBUpcIOvH3B8c3qjHyDE0YvE+vDcpWjLEPLF6b6JrRyIwpCd+f3ey?=
 =?iso-8859-1?Q?E3HqKHAhKAeR0rBjxJKSbVFQQtM0N8EAFSqzVe72nhlTEIyUQYdpl5LbMp?=
 =?iso-8859-1?Q?uNLuBRLpxOWzpxKpQxhn5y55I6NJPqw6XYpOkQLAUhwYpUp8hhr5wk8/5O?=
 =?iso-8859-1?Q?MqHr1FyGISvMzNMGhpvdhsJIHmL9v42LCKwHj2geaQe9KbVt2YAthg3o87?=
 =?iso-8859-1?Q?6ddp55LJoBJx2eTpC0d5V1y8wvKBdYH934GFqyNYNeO1cPVeUABMKYXbEN?=
 =?iso-8859-1?Q?8CEXduZNRdQDPwS9+CGx9anr9/uPFMXUOQn0dZBbwNqy7B2sR1GPsKdmj1?=
 =?iso-8859-1?Q?rRiClaVMI6f6lo4qzfauVHmYvbh/W6X7x5pzoieCBXsIRkBAfBJXrabW83?=
 =?iso-8859-1?Q?mKY0PexDgplMTCtHJ/5nCgF55eEkPKnAAX03bSypmfVVIKaPVlpyEFIjXi?=
 =?iso-8859-1?Q?ry9qoLCppqtn2Sb50DcJ/Tm7Q+HIZ9nKReKYvz6NowpTCI3K4kHPsF6jPP?=
 =?iso-8859-1?Q?53wttqsbG9vhCd+PIC+3oksM8t7PhRieaVUpPWmaAPqeJdyf56GZf0EBAz?=
 =?iso-8859-1?Q?3t9fw406Xyup2RMFu3sMrPo+fFuvgE5VdO+TBnNn1a6rK0blTDSHETSs1M?=
 =?iso-8859-1?Q?F+XsejIjiTBHAItrvoOqzj45GEJS/8uAened5H2IBhB3JjB5wOrMTBQ9WM?=
 =?iso-8859-1?Q?IvMckuTl109ukIMPXT5PfvUW+ufKHRCA9eLAnRYSUcvE0G7TyvE5OZZo16?=
 =?iso-8859-1?Q?Duxe8Lldym8x4X3ETmbP0L658ofH4264rWGiM9n7+2cYE4tZ4gnGpzluoT?=
 =?iso-8859-1?Q?Xu+x+Yt7/9apAaRKBe6GQR1rujOn76DhgWiDRGSwx2OcrcvGSX2vKUkSuY?=
 =?iso-8859-1?Q?ChJFozZQk3sFka7sRsq0OJb7ixFbKeap7qDvmgCwSnTt5zsah0frlHUGHE?=
 =?iso-8859-1?Q?EtROz+6dg9qgRnVIQEWCzuBxugGSVYZn97jZqLEaT83jcIfYZjapZycMZK?=
 =?iso-8859-1?Q?xvK2kcDowhQPq+PfuWdk3yJKl0N5i8SimYZkGr9YgNYGouIMIGRwQzlwp5?=
 =?iso-8859-1?Q?OlA7Yyt5eoLqt9pC3aJuGMIbgQ9jsmOiQCXwOP5zApYOo+NTwvRnGGqdPA?=
 =?iso-8859-1?Q?v0kbBPxTytAU5uml6nd00VbB/maeH84L3WjfAL+GsmMZim5LAE8NJ3bLP+?=
 =?iso-8859-1?Q?TfteZFk2213BmoWvHcv3BYhnVVBzieVhJuZ8bMKj6jlMUYAmOAhxHBVlew?=
 =?iso-8859-1?Q?VSY1xEEOl6fNUAlsRHrlpHqFA+19eNRaCTTQHyJzyL2xI3nOn3nQ62cibU?=
 =?iso-8859-1?Q?C9tbPkJODo/w0d+4wHCr9J+HQaJUWVir45J4/1eFd7s/v9WBG2nw+QEmul?=
 =?iso-8859-1?Q?QgbaslIFWOj0dpBnaXBXN9XQy1rjU4RadF0Mt05igqeyjJwROX1t?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c01cd2c-7109-4e2d-711b-08da3d7dd060
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:06:20.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYZELRLbcpOOy2emfc8Cg3MH5xO8A5md8NJZQS8rhU0GORQdkAjPNTPI6BjqbmJiDf/BU6pOL050sa6YtbvJF4Yrbw34kUS4TWKvUoyPnAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5412
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

Deprecated WEP security for WILC driver as well as in firmware from
15.6 FW release onwards. After WEP security removal, freeup some codespace
which helped to add new features like WPA3 etc.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  76 +------------
 drivers/net/wireless/microchip/wilc1000/fw.h  |   6 --
 drivers/net/wireless/microchip/wilc1000/hif.c | 102 ------------------
 drivers/net/wireless/microchip/wilc1000/hif.h |   6 --
 .../net/wireless/microchip/wilc1000/netdev.h  |  10 --
 5 files changed, 2 insertions(+), 198 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 8d8378bafd9b..256026d57a70 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -313,32 +313,9 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
=20
 	vif->connecting =3D true;
=20
-	memset(priv->wep_key, 0, sizeof(priv->wep_key));
-	memset(priv->wep_key_len, 0, sizeof(priv->wep_key_len));
-
 	cipher_group =3D sme->crypto.cipher_group;
 	if (cipher_group !=3D 0) {
-		if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP40) {
-			security =3D WILC_FW_SEC_WEP;
-
-			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
-			memcpy(priv->wep_key[sme->key_idx], sme->key,
-			       sme->key_len);
-
-			wilc_set_wep_default_keyid(vif, sme->key_idx);
-			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
-						 sme->key_idx);
-		} else if (cipher_group =3D=3D WLAN_CIPHER_SUITE_WEP104) {
-			security =3D WILC_FW_SEC_WEP_EXTENDED;
-
-			priv->wep_key_len[sme->key_idx] =3D sme->key_len;
-			memcpy(priv->wep_key[sme->key_idx], sme->key,
-			       sme->key_len);
-
-			wilc_set_wep_default_keyid(vif, sme->key_idx);
-			wilc_add_wep_key_bss_sta(vif, sme->key, sme->key_len,
-						 sme->key_idx);
-		} else if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
+		if (sme->crypto.wpa_versions & NL80211_WPA_VERSION_2) {
 			if (cipher_group =3D=3D WLAN_CIPHER_SUITE_TKIP)
 				security =3D WILC_FW_SEC_WPA2_TKIP;
 			else
@@ -373,10 +350,6 @@ static int connect(struct wiphy *wiphy, struct net_dev=
ice *dev,
 		auth_type =3D WILC_FW_AUTH_OPEN_SYSTEM;
 		break;
=20
-	case NL80211_AUTHTYPE_SHARED_KEY:
-		auth_type =3D WILC_FW_AUTH_SHARED_KEY;
-		break;
-
 	default:
 		break;
 	}
@@ -487,14 +460,6 @@ static int disconnect(struct wiphy *wiphy, struct net_=
device *dev,
 	return ret;
 }
=20
-static inline void wilc_wfi_cfg_copy_wep_info(struct wilc_priv *priv,
-					      u8 key_index,
-					      struct key_params *params)
-{
-	priv->wep_key_len[key_index] =3D params->key_len;
-	memcpy(priv->wep_key[key_index], params->key, params->key_len);
-}
-
 static int wilc_wfi_cfg_allocate_wpa_entry(struct wilc_priv *priv, u8 idx)
 {
 	if (!priv->wilc_gtk[idx]) {
@@ -552,33 +517,6 @@ static int add_key(struct wiphy *wiphy, struct net_dev=
ice *netdev, u8 key_index,
 	struct wilc_priv *priv =3D &vif->priv;
=20
 	switch (params->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
-		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP) {
-			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
-
-			if (params->cipher =3D=3D WLAN_CIPHER_SUITE_WEP40)
-				mode =3D WILC_FW_SEC_WEP;
-			else
-				mode =3D WILC_FW_SEC_WEP_EXTENDED;
-
-			ret =3D wilc_add_wep_key_bss_ap(vif, params->key,
-						      params->key_len,
-						      key_index, mode,
-						      WILC_FW_AUTH_OPEN_SYSTEM);
-			break;
-		}
-		if (memcmp(params->key, priv->wep_key[key_index],
-			   params->key_len)) {
-			wilc_wfi_cfg_copy_wep_info(priv, key_index, params);
-
-			ret =3D wilc_add_wep_key_bss_sta(vif, params->key,
-						       params->key_len,
-						       key_index);
-		}
-
-		break;
-
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 		if (priv->wdev.iftype =3D=3D NL80211_IFTYPE_AP ||
@@ -676,13 +614,6 @@ static int del_key(struct wiphy *wiphy, struct net_dev=
ice *netdev,
 		priv->wilc_ptk[key_index] =3D NULL;
 	}
=20
-	if (key_index <=3D 3 && priv->wep_key_len[key_index]) {
-		memset(priv->wep_key[key_index], 0,
-		       priv->wep_key_len[key_index]);
-		priv->wep_key_len[key_index] =3D 0;
-		wilc_remove_wep_key(vif, key_index);
-	}
-
 	return 0;
 }
=20
@@ -713,13 +644,10 @@ static int get_key(struct wiphy *wiphy, struct net_de=
vice *netdev, u8 key_index,
 	return 0;
 }
=20
+/* wiphy_new_nm() will WARNON if not present */
 static int set_default_key(struct wiphy *wiphy, struct net_device *netdev,
 			   u8 key_index, bool unicast, bool multicast)
 {
-	struct wilc_vif *vif =3D netdev_priv(netdev);
-
-	wilc_set_wep_default_keyid(vif, key_index);
-
 	return 0;
 }
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wir=
eless/microchip/wilc1000/fw.h
index 1114530d03e4..237ca348d1f8 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -41,12 +41,6 @@ struct wilc_drv_handler {
 	u8 mode;
 } __packed;
=20
-struct wilc_wep_key {
-	u8 index;
-	u8 key_len;
-	u8 key[];
-} __packed;
-
 struct wilc_sta_wpa_ptk {
 	u8 mac_addr[ETH_ALEN];
 	u8 key_len;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 71b44cfe0dfc..573750356007 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1038,108 +1038,6 @@ static void timer_connect_cb(struct timer_list *t)
 		kfree(msg);
 }
=20
-int wilc_remove_wep_key(struct wilc_vif *vif, u8 index)
-{
-	struct wid wid;
-	int result;
-
-	wid.id =3D WID_REMOVE_WEP_KEY;
-	wid.type =3D WID_STR;
-	wid.size =3D sizeof(char);
-	wid.val =3D &index;
-
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to send remove wep key config packet\n");
-	return result;
-}
-
-int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index)
-{
-	struct wid wid;
-	int result;
-
-	wid.id =3D WID_KEY_ID;
-	wid.type =3D WID_CHAR;
-	wid.size =3D sizeof(char);
-	wid.val =3D &index;
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to send wep default key config packet\n");
-
-	return result;
-}
-
-int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
-			     u8 index)
-{
-	struct wid wid;
-	int result;
-	struct wilc_wep_key *wep_key;
-
-	wid.id =3D WID_ADD_WEP_KEY;
-	wid.type =3D WID_STR;
-	wid.size =3D sizeof(*wep_key) + len;
-	wep_key =3D kzalloc(wid.size, GFP_KERNEL);
-	if (!wep_key)
-		return -ENOMEM;
-
-	wid.val =3D (u8 *)wep_key;
-
-	wep_key->index =3D index;
-	wep_key->key_len =3D len;
-	memcpy(wep_key->key, key, len);
-
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to add wep key config packet\n");
-
-	kfree(wep_key);
-	return result;
-}
-
-int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
-			    u8 index, u8 mode, enum authtype auth_type)
-{
-	struct wid wid_list[3];
-	int result;
-	struct wilc_wep_key *wep_key;
-
-	wid_list[0].id =3D WID_11I_MODE;
-	wid_list[0].type =3D WID_CHAR;
-	wid_list[0].size =3D sizeof(char);
-	wid_list[0].val =3D &mode;
-
-	wid_list[1].id =3D WID_AUTH_TYPE;
-	wid_list[1].type =3D WID_CHAR;
-	wid_list[1].size =3D sizeof(char);
-	wid_list[1].val =3D (s8 *)&auth_type;
-
-	wid_list[2].id =3D WID_WEP_KEY_VALUE;
-	wid_list[2].type =3D WID_STR;
-	wid_list[2].size =3D sizeof(*wep_key) + len;
-	wep_key =3D kzalloc(wid_list[2].size, GFP_KERNEL);
-	if (!wep_key)
-		return -ENOMEM;
-
-	wid_list[2].val =3D (u8 *)wep_key;
-
-	wep_key->index =3D index;
-	wep_key->key_len =3D len;
-	memcpy(wep_key->key, key, len);
-	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list,
-				      ARRAY_SIZE(wid_list));
-	if (result)
-		netdev_err(vif->ndev,
-			   "Failed to add wep ap key config packet\n");
-
-	kfree(wep_key);
-	return result;
-}
-
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index)
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index 77616fc77575..c9740457ed58 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -151,12 +151,6 @@ struct host_if_drv {
 };
=20
 struct wilc_vif;
-int wilc_remove_wep_key(struct wilc_vif *vif, u8 index);
-int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index);
-int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
-			     u8 index);
-int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
-			    u8 index, u8 mode, enum authtype auth_type);
 int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
 		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
 		 u8 mode, u8 cipher_mode, u8 index);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index a067274c2014..630b1e85e68f 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -45,12 +45,6 @@ struct wilc_wfi_key {
 	u32 cipher;
 };
=20
-struct wilc_wfi_wep_key {
-	u8 *key;
-	u8 key_len;
-	u8 key_idx;
-};
-
 struct sta_info {
 	u8 sta_associated_bss[WILC_MAX_NUM_STA][ETH_ALEN];
 };
@@ -63,8 +57,6 @@ struct wilc_wfi_p2p_listen_params {
 };
=20
 static const u32 wilc_cipher_suites[] =3D {
-	WLAN_CIPHER_SUITE_WEP40,
-	WLAN_CIPHER_SUITE_WEP104,
 	WLAN_CIPHER_SUITE_TKIP,
 	WLAN_CIPHER_SUITE_CCMP,
 	WLAN_CIPHER_SUITE_AES_CMAC
@@ -132,8 +124,6 @@ struct wilc_priv {
 	struct net_device *dev;
 	struct host_if_drv *hif_drv;
 	struct wilc_pmkid_attr pmkid_list;
-	u8 wep_key[4][WLAN_KEY_LEN_WEP104];
-	u8 wep_key_len[4];
=20
 	/* The real interface that the monitor is on */
 	struct net_device *real_ndev;
--=20
2.25.1
