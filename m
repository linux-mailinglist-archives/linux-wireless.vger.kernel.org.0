Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC257BB05
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiGTQD0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiGTQDY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87A5466D
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658333001; x=1689869001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uZgP9VIHQFVV5BzTT0h8WkMFqvxZKt5wmqjdYmFeq+Y=;
  b=ixguRjGcBaxh1f8apWSjjFAyyt+ZvFk61OlDK0Nw1Lu6pDW0lHJxqXy1
   eyngeDMoyKMuQioZvr00zxzSTpJVByuenJ5l0TUR0fgtYr9U9EdX5YOWG
   T8YMM1iek1Svn9bDS7Pyo70hkKSgxt49kCRz7vhHhERb5dYoWqBmvN8+X
   /26HMO0ux1LeiHkpuA9+S1hvZZ494bbbU5Np9t3zDc1ueamjRuvgeZDcN
   jrMhZdBYDkbnW636RUIs746xh4IvF9q08CPM/pnsFOOS05EQh3Mt5syiy
   0qmgCrrp3w8r5yAuFvnY91fEEw+svSpsQsTOJLvMaT/6oCYMlVm0+OMDJ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="173122941"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjBtFJ++cjw4KD4A9kxumDTHw3nFTUyH6c9TnvVJCWlVp84yg9n6wP2H+b91hkY3vZSrIYDrS1B8MxeiuyUPzF8YusV5660CCsyOBz5yG+m4AwwoWFEUyA/OIppRXoBimwrhO73eaXlsoM0ASHBMwIYyIfNjZjleF/Wm0UoduD44Tz6mLClByPf6JjIT1HyMadCA+9jTjfo7eGjEoCRAXwz8MIDVork0ON3C1IyhMFzETay9IGF3efYLGUbzjqqwEbxeWFArTRor5s89LHSogfwntofyL/p8/eMJ73BQQrZbbHon1Xyla4TArOz7HWqeSYL+w6oDJI0VeqHWzs3HXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOuXvQVx5xdSFn1oppAKOc2fhy74QGJDfB3/SqxC+zE=;
 b=U8ko58Ykt+16QqOxai5Rsf36q/fwYLx09T8uUYx5yn3APYwDETCJJ5PvIg94cQi5vKTiQOh1Fkjv69VrEBIFAGhfyzzOD1/45nliqeiT4qHVQUJ8MmNJKAkAhXK91F8S0HmiA1t+Crm45+bT7JSpYAk9YECZ/PMu1j/ZWun0JFTi/RzH1ZK988jG/x5Ce3VqBfAtrNSD6CXr7pRxWl7H4DZip8Vte8aiPBTByN3uvRkxTsKtIBh7uFN5teJQ8peVKFTWnZZtiOfOTQFSZI2GkTPwTjm0dN88ewDrhhLPfjXDxGbrEkTd9pPA0may2xrbHJs1r7TFbmz6IWekjm4HMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOuXvQVx5xdSFn1oppAKOc2fhy74QGJDfB3/SqxC+zE=;
 b=BGxqwrCVegLi6YnH07pI5ZfkIhuT8IB1FAizPupsj06a9ej1r2rNwq/24/5OsBuVK/7TvYZA7xhrqxP6hCu7O8viJmW1FShEIK/rU3duduieDclcutGxaM9xuZPAT320525zccZ5HPfYRJZKhPWuQcgaJ3d4YPUXpwKohNrDS74=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:05 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:04 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/8] wifi: wilc1000: set station_info flag only when signal
 value is valid
Thread-Topic: [PATCH 4/8] wifi: wilc1000: set station_info flag only when
 signal value is valid
Thread-Index: AQHYnFIx4NLfwcl9sESOagg4tMRVTQ==
Date:   Wed, 20 Jul 2022 16:03:04 +0000
Message-ID: <20220720160302.231516-4-ajay.kathat@microchip.com>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
In-Reply-To: <20220720160302.231516-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40058d9d-938c-4703-6e05-08da6a695490
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4BwUBKbJoZKeC/XJuOM0NaAGcrxf7oNIbWDcS/kKZBzH+jXu276SMFCxWaT7ue4n1BV6OzHxGFdMqLFhEAZrYrZrNpPuyB50Eu2fV1aSJCotAl6jGkX3kT0+ivAvmnYGcXZwrzgTYh2cb/BzaAUG5eWxSPxWdvYPGho3/VUi01Kz1J+28TQ9GbwolBt6IlKtwPcmT4r1a7gwc1uXtEUi5iPZRsT3JnBOk/P57m2fwOg2v/mdN52dZePuedBMGksWaIAgu40p7gKwJSR+R/s4oV2zWZLlzhGr/pDpgCkSgKlN7jeNfkbtgsMKJEFgRYFLWbS7J1EYIBlZqBEsyyYab+YvcKh/T8xnmUgcmIi87XnkzQ2HolE/PXVCB2fvW2Ch1LJ724FxUkS1JSFOcGLdFb/YfiB+UsfWxKFXFL/pHZTSNDJGFUabCe8FIMYlA4tEG4DGe63bk6veM97loGDXPklLbyQ4OaRYV7a9SyAly8zsvSru2+5OWVk1WZGzwmV7Y4kWOKtTaxaAnkPXTNFGQHaPtRgEyo7Q7D6ijSTlCO6o6f1xMlKq9tkXBQ0uxRYwWJ047N8Aj6BZQP9Y5ZZ4a+GkPWT36T0XTk1zvdMhW4sA806zz6xjxxCZHxQEZK+YQTs5qLbWv+TApLESOiUThWzxjCikDsGfWwwISP8x5HoxWXCMZtz740Wb7GQwvlqmFqlOHpd/SQQnla0QByf9xuS0Z9+YQCwYvsRIT+7uE4ogy1Zt7xLIqpSjSr7v8SShkZoTRaEJanJnp0ILvDKHA74BfRNf2HeVA+zfKzPnqRpc24x55xWB4yD7rWIHrbNB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(107886003)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(4744005)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6jZNF0UNmqGHIdZIuFvyQEMhW4EusnnXiWtfzHY9rXEWOKfMFleFiDaGbn?=
 =?iso-8859-1?Q?oFsM8fJatKJuoonFodcUCoPcrFDFTI2OWUXU5sEnw9dkEk0NKvx7+c2817?=
 =?iso-8859-1?Q?Dx6FyxzGbf3KkfK8nZkWg5+y0jvjE0EkzbVJ/3zklfgSfYuj4asY+n17OR?=
 =?iso-8859-1?Q?bwaoZj1IzyeCoPlEkt9/XFBAjZL98CbzxxlXbSJqxb3zLXfWCsyKbn9UIj?=
 =?iso-8859-1?Q?mFdyxMZdSjcMKdgbfOYWkFmP74sA6ux4Ckohg1+J/Tylw3P2uL4p+Ailtz?=
 =?iso-8859-1?Q?SbEr9chhOhGwm2KIsYMwZ7816vAY0IiwfcCAGcvTLwYld0wgGQHtmejBe3?=
 =?iso-8859-1?Q?5lDUxZ2RvUnIUhaAmLXvVmeRIu4eiLxDr6Ev5yWlIbbU6E+6sEhSZKp9QX?=
 =?iso-8859-1?Q?k1CJDjXqx8t/qeHh51b3MYPp633fMLhVgW3+d+o+l+xruzAla5MYD3iIe+?=
 =?iso-8859-1?Q?d9HSjI0ExZxn8PDY+7M6ve8+X+5Os+bMeNv8627idZILTRWUvjk7ugBweN?=
 =?iso-8859-1?Q?50P1v+FSkaHWrtsv0bGoiw4ymWo/4jEVnP6f0GsA2uNLmzAJ0Zey2uB0ld?=
 =?iso-8859-1?Q?dYuJLY6xVcFMLzGDW1x6pDL4D/3rz0laW/MnZAJVskChqQLeINwcVywEht?=
 =?iso-8859-1?Q?QVwUsxVmKRCzZLWxs/Xo9yX+iu51Ris73HhjWyxTcDsDsac6p3lhwqbHG5?=
 =?iso-8859-1?Q?gHPY8Fh5wmrw5Hir8hLPbR/pxwrSn0B4Wjmy+bW/Crb4jAbPWBEFL1085d?=
 =?iso-8859-1?Q?56YyRuMuY+TVZZG97WW8MCVT3fObjPbnM/aD10pzcDUf0usmIdBUGlOxW+?=
 =?iso-8859-1?Q?aX9XHVc6ycwJeaxmctJJINMfgvpWLqanlSVduOoPZBf5qyHIuijEv6bCD2?=
 =?iso-8859-1?Q?sGSCAnsQVNUjsmsbtNTTlpc4g5SDDmd1Akx9SKYudRnCtYWSf406rScjom?=
 =?iso-8859-1?Q?CYYYOwR/2vquxqmhfSPC7f8iw9UGmemQwBqRbc2Jk+fKPC0dfHKXfHIt7n?=
 =?iso-8859-1?Q?z+8egMpHpWcqP1Zx6mKJJG4th2ECGEdLvyKunnEbv5d4cVWpQ4XWSVPSVo?=
 =?iso-8859-1?Q?/PWp5Wc5VSLEOiIZwv3ys7OtvmbGdN/1OSiDqnha0KpmYGoevHi1/IriTn?=
 =?iso-8859-1?Q?hLZKYlewxAYKvnzf18M9r/MrN6OSi4gRt4CT+SzMf9jCZGcDbKJzPFsTR8?=
 =?iso-8859-1?Q?Q8XwgJrAKqTv4vzW+aC8w9dTr2N+V+qvPaNMH7zOAx27btCuvcQJvmvAC2?=
 =?iso-8859-1?Q?OZIJ4dKcMPoQOQsmqOJPHAFDX0xzyz9ohqrm5CvkLCJ3DvnahUwNkH33/h?=
 =?iso-8859-1?Q?GPjiRZGqyKP4snhWf5FybH4CwyuHKnWL/No7pCD8NvUsB/GsYUAarGYlGE?=
 =?iso-8859-1?Q?OiZaPz3Z/3fGRbmHK+Gmg6h2cbJ4tuCKYGQPOSGN8GJ0o/fJQ8DlK748i8?=
 =?iso-8859-1?Q?kNGR62kaj2SQYObIfFYwTx6WRd+PKXkKQaz8bkkU8VvYGa9F1/qjHYaazB?=
 =?iso-8859-1?Q?GhW2zQsFt0/jZO25IcQUlXEfDOST0p74zDsSIC0YVYeo70Q4ex1t9qRSQL?=
 =?iso-8859-1?Q?GIjbdzVmnsSuBWeWT+TLsgPyegBVIfVELGd9YXdoiycGM2sjFYtOZvZeP2?=
 =?iso-8859-1?Q?HC3IMFWWpi6SxTlo40qXwwAk3D9zhZRwUQz/nd3lpVnUXdTYFZICX/7YI4?=
 =?iso-8859-1?Q?ehKNZ53KcR13K58ezSc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40058d9d-938c-4703-6e05-08da6a695490
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:04.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S28IYio57SWTrjzkRzKyUoMGyoceh2flyM+EEk5czHk8slr5TJLtbaraiqkIXoOwQrFeBhgFb78TXkXiZWeuafcEzxFOlG7duUCufjT9B6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Set station_info->filled to indicate signal level only when its value is
received successfully using wilc_get_rssi().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 19862d932f1f..1e184ac93afa 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1312,12 +1312,11 @@ static int dump_station(struct wiphy *wiphy, struct=
 net_device *dev,
 	if (idx !=3D 0)
 		return -ENOENT;
=20
-	sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_SIGNAL);
-
 	ret =3D wilc_get_rssi(vif, &sinfo->signal);
 	if (ret)
 		return ret;
=20
+	sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	memcpy(mac, vif->priv.associated_bss, ETH_ALEN);
 	return 0;
 }
--=20
2.34.1
