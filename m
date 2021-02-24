Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03AF323BD8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhBXMWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 07:22:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48090 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhBXMWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 07:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614169366; x=1645705366;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=IJl5Wyo74a8eOocXY8Df1ZxlNf98dZaxGSa1HpMTp44=;
  b=pc59Xv9YsQcBXQRhhNf03Ja+KWdKFp4n3t7Mg6o2XpMKhHVj+jw5514Q
   zftSvuqZ+uehIlk8SpyuSme8LPU+6MWek+vY9wFpwYIxeB18lhDTw0pvd
   vXYOEudXFrxEzMFeNnsDN3MovcyG05U6MgL5rJGTM4tIteqeCdEzIiJJi
   oEaX2nPW+ogkHDZlGa7nvz2dAoOgmt7fBnjK7mWtFJSQ3ipCZzK4vDsMa
   r0q0Litj2VL5kekWe2vyazcvScWdK0hTZEdKfvgxrhuvDXaBS0xgbqbmi
   RlagkOT/vlBeij54rwoZ82RKFav4RvMYM7EZhCP5QqviWWt39sWOkmOKb
   w==;
IronPort-SDR: ONIC5eoL4V+baxpac963NLp61//aV/Ntkhq8KLsMrwTGeUO8Dybj9lgb/POjwnBr/AGUR7dHrj
 nq0oAUGghqcPpt+2X24YyuNM7nAPZ06UVXp5i/UlmbgN1x5u/JIvHE1+S9A7vUKpqk3GHVNMQx
 VYIGD1laVTis064Xfow6UBUubCdhG7taFlNSDKQE0HDE4H1+rTfI3Bn8x2Hm86coKPL/TsUJME
 EQ8L5juGtYaISExIHHNmHy96LMSTWcYTuOUppazdWQothsSS28QRJo6WE74EYIGytPYW2MOI6H
 Jm4=
X-IronPort-AV: E=Sophos;i="5.81,202,1610434800"; 
   d="scan'208";a="45280750"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2021 05:21:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 05:21:29 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 24 Feb 2021 05:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVpEnNym446o9K3qP7QKNr7cWxpYB9iCBl9tYkDlAY7D8PhEkUrkenh9YCQ96Swd+paEBaEyohMMSdgR9FPiUXi6vSeQIaFB1U2zr+CyS+4M0zz2RUQO58tWluRs30a3waoDg1mx7Ou9x041E4YM62qEtyF5SU9V4Q/7EDEkJIfvi6jRsl7rUixXTfq/ndH/8lIB7LTkVz0Re4RJaYXfuaJ/HeK5cZD76PJBKkI3YaJyGR/0gvokCqvH+pTI7piMiY83kpCEOw653U+n8E4SRjNXle2FxSiMpSHSxBHIy2M4P/4o+H+A0e0YFy9enTurwe7rHE2TPF45Kfry2Ks0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELAclxir8PkQqv9apRMgR2D4d54m6oinR5cXOMU0Xlg=;
 b=LKZ5nqpcPcZDSVk9x337XbRJnsu8kY+/v0nCTd/gQBdASH0RI47WiBrm/+8QpnbbImBEkQ93lekMbfF8YOhbsfJ/1Nf3MWnmTAQiUrLpZCgl+gt2xoCEZSQ6WbBH/ALbzSV9eABRKlWmmqJyHm1gZtON8GUHIAFmrHaLjeNQ4esfWkscVfnjFzEean/keZjNq1VL9SAe/yT8spl0EgFsw87oedWFbPxrmKACfq4uA3VDqlomvtYOkJL4FxBBYUoNqFJhbxiUfCQSju8SbdXpMMtSHvC7ZTbClCNUHzLD1VQRYxLh3X33Y1MZZ2CMbkiw1pwvs7CTmW95BbWDbsV/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELAclxir8PkQqv9apRMgR2D4d54m6oinR5cXOMU0Xlg=;
 b=ZLZIhu9PWw5cNL0IKnZBxK7/bxTKB+IXGvZsM5st+50WgbX2DV3V/lTohbAv/+9wcuWeNY71tnm8J5wDNDrBpUG4qPMblcI3PrJdlEgv1pw3vOrkFxiCU1JLj8n8um7AhoCPU8PM8uOpdfZ1PAsLeTXniIHaQs4LoLClM3eUCmI=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3542.namprd11.prod.outlook.com (2603:10b6:a03:b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Wed, 24 Feb
 2021 12:21:28 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Wed, 24 Feb 2021
 12:21:28 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH] wilc1000: use wilc handler as cookie in
 request_threaded_irq()
Thread-Topic: [PATCH] wilc1000: use wilc handler as cookie in
 request_threaded_irq()
Thread-Index: AQHXCqeTc8gMGR/R+EWdEgZdzjM0Kw==
Date:   Wed, 24 Feb 2021 12:21:28 +0000
Message-ID: <20210224122044.15146-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b2b439b-33cb-4a09-039a-08d8d8beb5fd
x-ms-traffictypediagnostic: BYAPR11MB3542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB35429C1E3974F9BEBDD7689FE39F9@BYAPR11MB3542.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TI50IzUMzvR5MmS+eHBln3a6oTJzvRRqINB/UsBL46De/vrc8ZNMvaVc/HOGADH6hPu2PV5GEagGcBp5u1LTab4rDHKo9rijuaaFovIoClAZfS0h2hfBUeuw6BSuG5+w3WscWNl0+UXqVf3jH13r95ZLAE79Sbk4vGJ6PiOCzpNMhnWiVy9hFWjO53rBfNSfZztwTFwBHaWQxEYA1oARCrjWjpM+RddyDER0Klp5EfYgBxu345dVyC8wKMwkWKMDEES4E2Tz2171L24e95HmMPs1IFQ6vJEPiV+pKhF6mxgpboWUqIlKeZpQ8MugU8u/mqFQEJPJSiSg+WbkIOBLUO5X1vh01AjOv7kdJVAmLU1wt5ZMkSbxZ+xWwCDdMhYuEnaLDZAojmf0attBfPziuMUYBH2X9YeI8QRXZJ6/ei1/31AB9pY8hd1FDa+WUXavCVX+2EUhQltojFiRUOnDpsQ4ox4tEpOL1+HCRUBrmXBaJl2yvVXcftU99+ecEPTalUQcFRkWs03NNT/s9L0uxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(316002)(71200400001)(186003)(4326008)(6486002)(86362001)(36756003)(8676002)(8936002)(54906003)(478600001)(55236004)(2616005)(2906002)(83380400001)(26005)(5660300002)(1076003)(64756008)(66476007)(6506007)(6512007)(66556008)(91956017)(110136005)(76116006)(107886003)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?TZRpIiRVeAiPrl1lgVrFpZwWbsrKP5q+vlL/wRC6kaKJVO5Cz2mcrExUi/?=
 =?iso-8859-1?Q?/QFOQdVWcMCbrGbZlxgx5KUlgVKV4UkRIZxcb/cb2rkO11mtbD2hS8oGJK?=
 =?iso-8859-1?Q?/HURsssuX8Yv2ZZWoS6PQX/z9S2mLCllZoKJIYd02oNjzyZf6/ixYSx1T1?=
 =?iso-8859-1?Q?GiU1aPixg2HLBSYFqIlzGd4itXTDRKd2nyx/DIJhtRkMMrNiS5I4FVN6wW?=
 =?iso-8859-1?Q?Ad1XCdKPPbDT+WBQ8uJx0Y+8q9go0bpfavwIy1fnADIRbou3ZPlnGpSQ1H?=
 =?iso-8859-1?Q?0CZYQmO+xk7oL8AGQ6rowhYQDTagHyykv1LeQO1kTx4O6eUl5VIpB8xuKK?=
 =?iso-8859-1?Q?YPtPTIsRbou6hYktPc1NR31zVDCDdtwOr+fspoScsul4HMUSDBLvyVOJqU?=
 =?iso-8859-1?Q?UWlrUrW3Blh3XMdUpqZ3miI/1dQvOs5qxHMeOgrT15FKjJwKfyBzn3uKJC?=
 =?iso-8859-1?Q?5kR33c+MHQtBgEHUmM5DQzOMONylyuwWtuOoemOl1aXUf1PjFS22hmarIF?=
 =?iso-8859-1?Q?QW42IW4p0h4ycpNqXl+R+4EdKTtt8TNoMWa3x9pu3ZhPrry8anJbh653q5?=
 =?iso-8859-1?Q?lbxS5lCIEN+aY2F09gqiTGg1tORc303MK5xy8olrpeILo9k0Yvj7ermVSv?=
 =?iso-8859-1?Q?ZT5wMGl00tf2HFqpUwIc3whmmGftWrBDe4RPN6FekuIQuEVWoYsmUafcvb?=
 =?iso-8859-1?Q?cHdKCUR/ZlW98QWnP7LQcPPFvJEFeeAWzB/VsCO3L04+sUq9soMRNOD5k6?=
 =?iso-8859-1?Q?556DpjbBAs2guTnqkhaKAbZKX5YPt9GRImBDzYr9suJ+/+IpOr5ikigDY1?=
 =?iso-8859-1?Q?ii/hclGrSDcQIvuT/XyUIzrjEcVrsU3aVoS2H9qCgzl7++oY9nvGV9m4aY?=
 =?iso-8859-1?Q?5vxAIEQ921Fe+WrPcgGJ+9URzm568XZWSQ7E2igl2YAWpIdcfOjGA6sIB8?=
 =?iso-8859-1?Q?6Tz/pIQJSw6Vf3A60L0/+Msxf6dqVbW6PYKqbfY/Uvj8YlD06MtYVWbb0/?=
 =?iso-8859-1?Q?9NCkF4LpQFwnYA63ae2PNLD0L7+IE/0lUxkymylFp0jduxOprgQVzcl5Zi?=
 =?iso-8859-1?Q?/1Vn5j7UkIvf8bkmo9T+sJ0GEpAhJ7GXgHnO6lJqbKRCwJZX6DntkkU316?=
 =?iso-8859-1?Q?H/TwW6WKC13HRzClQuZ6gWWb5NbBAiGNeboGgb7uys0Y6bJ6cVgicHajMj?=
 =?iso-8859-1?Q?CIopxxFypIq3pgcpMTW0cK/dyR92DXcLn6txTgKq2fG6YwYDZ8OZ7O3Euf?=
 =?iso-8859-1?Q?04aEU49sh5UEQy1tAYWNnWCimZzTFkQhOdBe7VgukGIUi/e5WmXI2px0rM?=
 =?iso-8859-1?Q?KTfHScit2gc7qGQDtGigg7jM+mZ7hagcYfxu7XiPET1lKllh/oMhYacIqi?=
 =?iso-8859-1?Q?ay4573CLCTJrhOJa0tCbgj1rND+HRvBg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2b439b-33cb-4a09-039a-08d8d8beb5fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 12:21:28.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KKbgnbHNwgRhW5EJNqRqhm/MKbnvYz00zV2spwzob+6ATNnvVamSK+s/IhF0dp7ddMX6+9j7pfpO03LUbRnKkAUUO8UZCsJOjhIo+HeeBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3542
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use same cookie for request_threaded_irq() & free_irq() to properly free
IRQ during module unload. free_irq() already uses *wilc* handler so the
changes are required for request_threaded_irq().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 1b205e7d97a8..66f725aad209 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -24,12 +24,10 @@
=20
 static irqreturn_t isr_uh_routine(int irq, void *user_data)
 {
-	struct net_device *dev =3D user_data;
-	struct wilc_vif *vif =3D netdev_priv(dev);
-	struct wilc *wilc =3D vif->wilc;
+	struct wilc *wilc =3D (struct wilc *)user_data;
=20
 	if (wilc->close) {
-		netdev_err(dev, "Can't handle UH interrupt\n");
+		pr_err("Can't handle UH interrupt");
 		return IRQ_HANDLED;
 	}
 	return IRQ_WAKE_THREAD;
@@ -37,12 +35,10 @@ static irqreturn_t isr_uh_routine(int irq, void *user_d=
ata)
=20
 static irqreturn_t isr_bh_routine(int irq, void *userdata)
 {
-	struct net_device *dev =3D userdata;
-	struct wilc_vif *vif =3D netdev_priv(userdata);
-	struct wilc *wilc =3D vif->wilc;
+	struct wilc *wilc =3D (struct wilc *)userdata;
=20
 	if (wilc->close) {
-		netdev_err(dev, "Can't handle BH interrupt\n");
+		pr_err("Can't handle BH interrupt\n");
 		return IRQ_HANDLED;
 	}
=20
@@ -60,7 +56,7 @@ static int init_irq(struct net_device *dev)
 	ret =3D request_threaded_irq(wl->dev_irq_num, isr_uh_routine,
 				   isr_bh_routine,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "WILC_IRQ", dev);
+				   "WILC_IRQ", wl);
 	if (ret) {
 		netdev_err(dev, "Failed to request IRQ [%d]\n", ret);
 		return ret;
--=20
2.24.0
