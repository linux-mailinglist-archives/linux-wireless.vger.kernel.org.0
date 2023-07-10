Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0674D236
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjGJJvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 05:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGJJuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 05:50:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488B3AA7
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688982284; x=1720518284;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=x3zv9dsB9oa5z94WWqi/rmQdzxi8+HuiD4yaJsR8GHk=;
  b=pF2Cz2W868Vjfn77FZ7blnr2M4B8mkTThKeq6OITkqPUQ2eI3fPOS5Nl
   5j2bL7w4U7PK+zvgv7U9KH6v+5afAraei47RsSnbuqu7DfRcAka7dBY9F
   nqFCyIl/bluuuYD4WF9SuK469wbGuJNOOvMqg2gi5HRSf7hgz34y3KqNh
   8dTBaH7LEa0Q0M25gAnweN7maY8byCLGnUFqbtjP57MuQAEoyKjHhhnTy
   d0lX/kz0IHOaEphwjJ4nt2oG+qjXwinqxvBVlVQtMpT1kdWlONudUJKgM
   /Swvo3cqeQvV7MZ1CBVHxbt0DofiDMEC9Ej8fYBUPsyK/rH4Q4akLH1kY
   w==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="219609897"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2023 02:44:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 10 Jul 2023 02:44:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 10 Jul 2023 02:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4ZOxV5PnR0LbtLau+L8ZM9vWbvoKaUQP97ATVLnDP76QvbCVPxtlg8fvSUFQyDeb+3cHvzmwsrQHevCCo9tyFSzxd3IZJyfWm3zdaGwo29wdSotVR3shTg2Y52fqVXDXQMZOexRjklsw/h8LMuA2Z7OgfZEMO90RSm8jfxJdDXl3XiHEm4elKMP8Jvwmheu3DLd5siMWGrk/HUMkr5NyMtZBhqIuK50MsL2WSc+CKiklbibzGJn4btascKHrRZ/8au8XQw98rE9nlWwLWxtKnK1tdSGxLBbPzRKz8HvWYqS0/+s2a1NcwP9vo0wsO7xxTNHduTDQbtl7tHjQiT+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0lAMyWwWFjy4fXNHuYHUcsg65fxILUNjnKdDTmLuFM=;
 b=MDIlS8gtvopmGoVZw7UCwrvvqtnyxfFL9dDdSNpxZ31jB/bsgEwlACzF5crZIqAk5pUNDH6m1FR0ylo8SwLfPMg7ONwv8485f06sZG0kajLnK61Jn7bM1l3Vcmj7Y42KPbjeSYDxwGsxSF1kSXRpq2QvOj/E0tTZYOZVZovALzZijp600QHhEICoRqHoxl4a43UnZblojnkcRpuYWERlYlTrNal/jhnxdBk2IJ3XGql3YSDf4H63wNGuV93kMKtFfYVAV4gT4pP8PsYP/d2g+qqVCcQ1PxX9qwnVNfrVGlbts72R1Vn5qoPJvjkxzTbPzV5pu/gCSXHvyzuLS3gq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0lAMyWwWFjy4fXNHuYHUcsg65fxILUNjnKdDTmLuFM=;
 b=e2X5LDT40TxsH2XDSh7oqPg7yWgU6H+yMhUvoK15HoP7qwr5GzYu17jX49CJZbhQawNhNL5fN1QyUrdwtvCNPROgjHYRdL8wVUkRtzCcXrP4LpN8V8BqX5UqQS0KA7mjV6cKvHZYdvOnNzPn6e+/Ez+MMADXWzVjv+AsfR2HwQk=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 09:44:04 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::e09e:159a:ea7e:1884]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::e09e:159a:ea7e:1884%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:44:03 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH] wifi: wilc1000: remove use of has_thrpt_enh3 flag
Thread-Topic: [PATCH] wifi: wilc1000: remove use of has_thrpt_enh3 flag
Thread-Index: AQHZsxMPwXszMpuH1EGsdQmB8pBnWQ==
Date:   Mon, 10 Jul 2023 09:44:03 +0000
Message-ID: <20230710094401.235222-1-prasurjya.rohansaikia@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|MN0PR11MB6012:EE_
x-ms-office365-filtering-correlation-id: 67fe7234-d1ab-4b16-4b56-08db812a327a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zi+OgsdYoKd5GDOLUZZTR3e2MEv2rweVNX3JTwQvE/aGXv6S3pJFBKnV9LiRZuO+ePqEe7nZvv73x3ULm/mGh/Zxzanrt21YeRapI2HbmUbsAwK9uNhZsCA/Nkrd92a6tvsZHLKX1QMKYkTl6WFVTcSZq02PD2v5bXmuLT/+5NylSA8DQElL40E7qYiQO26O51NLBt4ukK8qDb4XZfI5tRiXDfIudAHjVdnF2Zv/Cr9BcTItLu6U2pyzLwcnD940Mj/tQ1tgJQfve4l9hZKiKJkjQp/dLOJOkqjYVsSG+H/8/0rOfOJXI+VyvIZt27uddEsvEa+dBy3+IYQVRhBRTZNCF6cCAxU1E/6TrQWl+IwXOcFMPVq9JBMBpJIAEzDsD2hsJnYhPoItTZGGVp/5l1zyUFPsrDfgeJnmLaortAGJHFbavV4BKMIHGE8rEMuZz+Be/YCwj6jcbG1q+6PzE9RYHVRyzD3IlJxKebPQRWsTkYeBEPppwLnrzftpSPK6V4T9dE51TiNc3DaIonKkERenh7plk1Qx99Z3nJmNw4WYRua4cVbYOIZKpMDCqUN+JPky5yF9jgNlS2Wm+r17HbFNkkZ7bX8u9UEuqFnV281ha5ftLjOZ7zLOwmkwpRJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38070700005)(36756003)(71200400001)(6486002)(54906003)(76116006)(91956017)(122000001)(107886003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6916009)(64756008)(66446008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9kwlH/o7qMspfHIe4ipuOnXkGqNXecP9zWee9zVo16eGYh/J1x4zgm4vEG?=
 =?iso-8859-1?Q?63Ahk2HfD2Pv0qUst3ch4Y9NjaS6AUZMe9mjthiEL83cQ/yYKbskqECbEl?=
 =?iso-8859-1?Q?VxHpC3Lnwa4QxEygmLoo0wjbVRUa+XDAEOStFXUN0P8dOBVOzf8Bf8i4/w?=
 =?iso-8859-1?Q?3SgBToRkENgYWicXnQ7kXRL1CVrUzUyi825cVWtU55TvtsRkjkuuf4WvBc?=
 =?iso-8859-1?Q?9gFujloTIRehAd29S1DgrPJ5YZRbpaMGHjzJbzEtrPg6iS5g9B8zOZktoD?=
 =?iso-8859-1?Q?kheCy4+tMUd2daZ36W/5/WMnraKaVAIRjkWzrllAtWdjzi6aGJGsnoaoqC?=
 =?iso-8859-1?Q?oFQxplwtKgu2lQ6D36lvtgPKLfNOgQQ4ngM7Vzi/S5OMB5XO7fpjssDy7A?=
 =?iso-8859-1?Q?ljpWqKlSSugl+7NGT80mDvdWt3IsPO6vmeeVl5x6+3EdgsThPjst/OD7a0?=
 =?iso-8859-1?Q?15C+pRZI0C7XghLa/FYH52c9rxL1cm6QVUl8icEdzkMuBd92i5CR//TIVI?=
 =?iso-8859-1?Q?zi6dB83oYJLiQn1W2sBYFBtRizep5smeITnuCSxAxcuZs+A8q6lC+B/+VT?=
 =?iso-8859-1?Q?uhU2FxVuuPYiNjtvJCw/odEZsNcXUZYEpKxBsQHuYlYuNsleiTZ64P0jvF?=
 =?iso-8859-1?Q?njJyNc7H6CPes+dKRdRwlBeZoGtUagnSTOaBIj6GB8JxaW4wM/EQJamS/v?=
 =?iso-8859-1?Q?CiW/GPCCDxP5m0IOHv6uY89vwnfu162ZsUsfqefx7b2jKbvDG7uY73nKVe?=
 =?iso-8859-1?Q?UvcRDS+ctVmFyqiwz8AvWrBT6NA4aTUKTFULFzxVy+F488i+K10GJn6jYm?=
 =?iso-8859-1?Q?+/i41h1oLPcgI+CyWTI3ZTRKKdnQFcBj3qtog/YOPReHuBZ6kwijuKhE4J?=
 =?iso-8859-1?Q?dtqq5K2v9jMRmphX0n5KpMD4PLcV0d9cgcdq4iKBxgK2hTC7EYGZtXBYne?=
 =?iso-8859-1?Q?ptX4z2onpD9Kqg0XBm3duler6jIfUX495CQ7XNVR2Uo6v8ilHu262iekFC?=
 =?iso-8859-1?Q?PBzZ1EmnQKc/Tv/3fSsYcx7xI2/906NzOD8IawQ92gfuOPJ5Rqd6OqlgvM?=
 =?iso-8859-1?Q?9prPbpJSKsGOOn0wrZbNyNwhwqBF/+jA1Lkl+Fv68uiVJjC3WsSEV0nPJY?=
 =?iso-8859-1?Q?405Oq/9B4pdB/xhJcpEKyvhqOvpUHZLOtSObLlGqUfDjSYkvR9H6yH5dB5?=
 =?iso-8859-1?Q?AKNEBnFFFSWcm22t1QHsN8tuCK0sMk+PjN98dNAib+OrHY3ok8MfH4BQ11?=
 =?iso-8859-1?Q?d/LCXE+TWHCs4dOJrfpoq3/w+IiBrkK3irNgn/wipultYepWKQtQfHcOzk?=
 =?iso-8859-1?Q?B2+mPo49sS0F5UjeEiUhGZHL8MCW+iPj1xLh3tzmQwkQjVHkyZdu2unDY2?=
 =?iso-8859-1?Q?Bulu7hJXxh06CgMhEBlrvlHBJ8ywH8G+s7/r0lDNBOB/46vDXoJXn9ANli?=
 =?iso-8859-1?Q?+RKi8aJ9EPHHHWWgEmsMP+iQ+tuFN7bh76/PocfEzVvxtnx/UtKHc7QWdv?=
 =?iso-8859-1?Q?m03I/kdaTgwLt/8pjVsTNg3nqdQbVWBkaU+E/v38DAabTwFa0gujcc0FHR?=
 =?iso-8859-1?Q?RZV+A1CLo+Ia8Ilz4nk5/uLAIPQ/Sc7gtG9Wu5NCMakNkXyoRUel6JUzMK?=
 =?iso-8859-1?Q?46h2lhRSIttrB7wb2tNSOR68298gamth/dqj+WR5NIGuHoj+CDbRsYNeNj?=
 =?iso-8859-1?Q?vaole0Rzu7AjSoBVcBJ7APTZFxv3IGXyIvnXiod+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fe7234-d1ab-4b16-4b56-08db812a327a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 09:44:03.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQnIUxYKmdRhduByfcatJRF1+UFQcpP22HVHd5wdCj9cIRc1T1ly7Jf20eQuBfPIoHAsepv896uYwFTE8LwYY1WQkEygMUWYVJOmM10AyKQ1mZXaQtIX60zOA6amXjdG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>

The 'enhance throughput flow' algorithm is used by default. So older
sections of the code are removed so as to always use this new algorithm.

Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
---
 .../net/wireless/microchip/wilc1000/sdio.c    | 103 ++----------------
 1 file changed, 10 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index a05bda7b9a3b..87948ba69a22 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -28,7 +28,6 @@ struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
 	bool isinit;
-	int has_thrpt_enh3;
 	u8 *cmd53_buf;
 };
=20
@@ -722,21 +721,12 @@ static int wilc_sdio_init(struct wilc *wilc, bool res=
ume)
 	 *      make sure can read back chip id correctly
 	 **/
 	if (!resume) {
-		int rev;
-
 		ret =3D wilc_sdio_read_reg(wilc, WILC_CHIPID, &chipid);
 		if (ret) {
 			dev_err(&func->dev, "Fail cmd read chip id...\n");
 			return ret;
 		}
 		dev_err(&func->dev, "chipid (%08x)\n", chipid);
-		rev =3D FIELD_GET(WILC_CHIP_REV_FIELD, chipid);
-		if (rev > FIELD_GET(WILC_CHIP_REV_FIELD, WILC_1000_BASE_ID_2A))
-			sdio_priv->has_thrpt_enh3 =3D 1;
-		else
-			sdio_priv->has_thrpt_enh3 =3D 0;
-		dev_info(&func->dev, "has_thrpt_enh3 =3D %d...\n",
-			 sdio_priv->has_thrpt_enh3);
 	}
=20
 	sdio_priv->isinit =3D true;
@@ -809,102 +799,29 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc=
, u32 val)
 	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
 	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
 	int ret;
-	int vmm_ctl;
-
-	if (sdio_priv->has_thrpt_enh3) {
-		u32 reg =3D 0;
-
-		if (sdio_priv->irq_gpio)
-			reg =3D val & (BIT(MAX_NUM_INT) - 1);
-
-		/* select VMM table 0 */
-		if (val & SEL_VMM_TBL0)
-			reg |=3D BIT(5);
-		/* select VMM table 1 */
-		if (val & SEL_VMM_TBL1)
-			reg |=3D BIT(6);
-		/* enable VMM */
-		if (val & EN_VMM)
-			reg |=3D BIT(7);
-		if (reg) {
-			struct sdio_cmd52 cmd;
-
-			cmd.read_write =3D 1;
-			cmd.function =3D 0;
-			cmd.raw =3D 0;
-			cmd.address =3D WILC_SDIO_IRQ_CLEAR_FLAG_REG;
-			cmd.data =3D reg;
-
-			ret =3D wilc_sdio_cmd52(wilc, &cmd);
-			if (ret) {
-				dev_err(&func->dev,
-					"Failed cmd52, set (%02x) data (%d) ...\n",
-					cmd.address, __LINE__);
-				return ret;
-			}
-		}
-		return 0;
-	}
-	if (sdio_priv->irq_gpio) {
-		/* has_thrpt_enh2 uses register 0xf8 to clear interrupts. */
-		/*
-		 * Cannot clear multiple interrupts.
-		 * Must clear each interrupt individually.
-		 */
-		u32 flags;
-		int i;
-
-		flags =3D val & (BIT(MAX_NUM_INT) - 1);
-		for (i =3D 0; i < NUM_INT_EXT && flags; i++) {
-			if (flags & BIT(i)) {
-				struct sdio_cmd52 cmd;
-
-				cmd.read_write =3D 1;
-				cmd.function =3D 0;
-				cmd.raw =3D 0;
-				cmd.address =3D WILC_SDIO_IRQ_CLEAR_FLAG_REG;
-				cmd.data =3D BIT(i);
-
-				ret =3D wilc_sdio_cmd52(wilc, &cmd);
-				if (ret) {
-					dev_err(&func->dev,
-						"Failed cmd52, set (%02x) data (%d) ...\n",
-						cmd.address, __LINE__);
-					return ret;
-				}
-				flags &=3D ~BIT(i);
-			}
-		}
+	u32 reg =3D 0;
=20
-		for (i =3D NUM_INT_EXT; i < MAX_NUM_INT && flags; i++) {
-			if (flags & BIT(i)) {
-				dev_err(&func->dev,
-					"Unexpected interrupt cleared %d...\n",
-					i);
-				flags &=3D ~BIT(i);
-			}
-		}
-	}
+	if (sdio_priv->irq_gpio)
+		reg =3D val & (BIT(MAX_NUM_INT) - 1);
=20
-	vmm_ctl =3D 0;
 	/* select VMM table 0 */
 	if (val & SEL_VMM_TBL0)
-		vmm_ctl |=3D BIT(0);
+		reg |=3D BIT(5);
 	/* select VMM table 1 */
 	if (val & SEL_VMM_TBL1)
-		vmm_ctl |=3D BIT(1);
+		reg |=3D BIT(6);
 	/* enable VMM */
 	if (val & EN_VMM)
-		vmm_ctl |=3D BIT(2);
-
-	if (vmm_ctl) {
+		reg |=3D BIT(7);
+	if (reg) {
 		struct sdio_cmd52 cmd;
=20
 		cmd.read_write =3D 1;
 		cmd.function =3D 0;
 		cmd.raw =3D 0;
-		cmd.address =3D WILC_SDIO_VMM_TBL_CTRL_REG;
-		cmd.data =3D vmm_ctl;
+		cmd.address =3D WILC_SDIO_IRQ_CLEAR_FLAG_REG;
+		cmd.data =3D reg;
+
 		ret =3D wilc_sdio_cmd52(wilc, &cmd);
 		if (ret) {
 			dev_err(&func->dev,
--=20
2.34.1
