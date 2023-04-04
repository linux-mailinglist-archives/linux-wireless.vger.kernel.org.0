Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4396D55CE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 03:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDDBU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 21:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDDBU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 21:20:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450231FCD
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680571254; x=1712107254;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4pGjF7KKi55GxH6jbX1n9kEq7swdRRanrYGW9oeIod8=;
  b=biIZlH5lKLjiNKuKDHucKY0kHYaXN9UrBCHQyvpqXSGKTmTER4t9/jo/
   ctE7+bWd8dWgCff+G9JjcbPvUff2YGjWLkaCWSMbPEW+t4ZO2nQjmVUOc
   WWQnaa5cTkAOvkkCsP037H+IA1w2Mu32iVFu1KxIxADRELMnPC33YIMSK
   XvTvBzgBjR3Sd6ex4oNXJ5jSYnk98k4Tllr2wFPVAkjPSmpuuCAcH5/x6
   AIqCLe4VmdH/eSL/SX1ASt2wN9zVHDgzW3hV8qdLTjGUTB2m3t7kTrjo7
   /F1Wj4CZCJvqqE7avLftgTfiR9CqRaTcRqSnaKT7IoHCkJY/HgC1dVDWV
   A==;
X-IronPort-AV: E=Sophos;i="5.98,316,1673938800"; 
   d="scan'208";a="204827357"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2023 18:20:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 18:20:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Apr 2023 18:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3fPwXNJkvbHcpY+ANBsN9QbLvfPYB3PEH7XSX7ULPuo4feY7ACkxKCf6Ae1z6qu4ddh0vUqr+aW6brG/t1KFuazRNtMjamNS23kny+PLw5XG6oqjR6i2iiKgek18JCMYJ/jvtcBqHMwHTLeeJF8yUHcCRwJDtmD5vAv3bMkWuNjosOkJj5foqWDTv8jXS2a0aAJpSG99MvSDu4oIOObdFRbAL6J4Gu9ffsyL+ruKd+/MB5jSEDHNEWwTN+vHFAkMUT5zmrWYhRKU3xP5M2We16gVq4VjOeJ8sQVLLr6e/wVBjXwn3MfhUgiUzM5wNXuzmrdT3DHtMf5MiFUR4SUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0TV6AQkA0c6xNw2sfytvFNOBkAZc7gvDriBxK1N62Q=;
 b=XOb+Bfnw5ASAZCuB2h/uuG1OiKVgLSLjjdXY0BBNToCsMR0VxYgDczI6lVEkoNJIehnakkf+wKgtXclC7Elie8SnLG5ypgGLqGcglWe3GlBMgR91O+cUCBn3FlgqxPiqO2GVt6kxbQ2NnvvMhqOifFLfGKZS1c9BbDj76n7sD5VZ+yG9dm34SNX7oLuXAdNRd7c+C2pDSgeMdZFEi7kKsjgfk8VdpA7/uIuoxLAfNXJTwl9/RkRsvBPZP+K8VaaGzI9QCgVBot7iPA+dm9WulctbgQUnaG1WNPpXDNcQj81ihGT75VWce2y0kPMqf1Oo1TAxsrrLejQN7VuR/7Qn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0TV6AQkA0c6xNw2sfytvFNOBkAZc7gvDriBxK1N62Q=;
 b=kPERsYa1IIJlDWU/nwb6Z1NgPY5vu3V/E/Y2Jvw6tfeucjrX0G1Ji+pZtcXfs2IT4OIphPLpxQibRaMxq+6Gtw2scAuc7BveLNng29dO5NN3gsefrUCwDf+4tuWag89DE0oXtpc+S7lthCyiNL4jqyXREfy1G6ZG2pc3gMZ3XUA=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 01:20:50 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510%6]) with mapi id 15.20.6178.038; Tue, 4 Apr 2023
 01:20:50 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>, <mwalle@kernel.org>
Subject: [PATCH] wifi: wilc1000: fix kernel oops during interface down during
 background scan
Thread-Topic: [PATCH] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Index: AQHZZpOxdxNIPScHF0Gh2r71RWeobA==
Date:   Tue, 4 Apr 2023 01:20:50 +0000
Message-ID: <20230404012010.15261-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|MW3PR11MB4572:EE_
x-ms-office365-filtering-correlation-id: c81b66e0-0ce3-4f21-ccee-08db34aad388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cHHvkDxLKU8Ht3jZYZeDXkoBqFs1e6Gd2uqm/01u/E+CY+RyL/udfooChvumF7H/ADpLwbm8OeA6zzEg1OwM4XIKXJvRHYNXpnZuvpIJURp4HidWmB+L4DisFt9IRAOa3+ru7QrWchARqNTzRsM65ePBAtu6zqbxuaxZxJICrCJawD8ZSS39Qds5l2PmZC2/+vTfFWo4VtoX0SOoksdnsvUERHPWtGVnESIgA1b5gZvOlDHeWufw9L/62jwij9CUJgu9gWPS2BOKWNCZglxgecAmKX0gz3V6NQx0pmuUU3emekXRy0G1uv6SALGKNPNT4KJa6BXFxt66Duou1yzUny2d3m5kDJ4qTPap2RDoAfA7p0xkyc45yVWnns0FNnGg5QJl6/NHf1h6iG8ka1ZhOVP8lwHd2OTfwUFCD20VIRfaAnzLnQpgEr799LSTJPbASpGOAlnJaDIpW5ikdA93wYfvPTxO777ynbTQGOADq2H3F8wlz1aZV1lLcEIinagNik1guYTC3oVz34oW/GeqDM8Yn9j+R/JteJumW79O+e191cq6kcx8bd2XDD8j2n0/ww+CtaoJ7F6WB9glpOiC/PFCsi0gY9Vq2sO4sV8c1lE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(54906003)(478600001)(83380400001)(86362001)(1076003)(6486002)(26005)(6506007)(71200400001)(966005)(76116006)(66476007)(66946007)(66556008)(66446008)(316002)(6512007)(2616005)(4326008)(186003)(6916009)(64756008)(41300700001)(122000001)(38100700002)(2906002)(38070700005)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tsAKE0JaHSunb0cs7NnobFyPEMoVihQOj4W0g1R2j2mcY645cIxVR6X0Hj?=
 =?iso-8859-1?Q?nrcl1+2hFtk4LsqOsFP9Mj0JPL9gL3eCz3Qw/hX3E+P2gO4T77o4Cto2Gp?=
 =?iso-8859-1?Q?77yQ/KAxOiSeJuZySKsRjfgbwD2bbk1RU5dc4NppiEQASaBNgH7aCtAKTm?=
 =?iso-8859-1?Q?tW5+kLVZWgFeENhttIjZZ0UIJ6I7aURLbTC8CtRKK3wcemJfMVh/ZHcZ3z?=
 =?iso-8859-1?Q?OhEbWaJ4g62/7r2r//qmskRqninB7NesQxq9prU5euAX7BcdgPGIDWKu1r?=
 =?iso-8859-1?Q?Miz+IqPeK7ErRWWq3zI3wveShr2DkPjVlGbUMP676K8vyto6Byho4fcyfP?=
 =?iso-8859-1?Q?VbJV9uKfdUQAxN0TZivymoELvDvjcqrdSnM8OHtpGXNspxJkiWZFE0t3UF?=
 =?iso-8859-1?Q?dlWj6Iw1MP4l3seHB+aHMfWEucNAM8lQKDtILAxe88RCTYYZeMixas2rIB?=
 =?iso-8859-1?Q?Q8+/RcTvsKFlixYZufWYVEmeOz6aBjS8mO0HTt75uQwq1TV4UZDwprZMeB?=
 =?iso-8859-1?Q?Zp7V128AH8FCWJanixSUcysRxv7B1uuU+I6jdYDiEjPSbkEFjXZUYpoets?=
 =?iso-8859-1?Q?02RxNxzhoFDxTIPY5yWDd5qqMEGIWsnVNYSdDV1kdwCP9A7ylSDbJsRcz/?=
 =?iso-8859-1?Q?OpIVduMkHrSOkwF0CxpYXlM8xjNg5Go0nFM1jXW7fL6Ku/cMnN2EFvcxoY?=
 =?iso-8859-1?Q?MA/9zlYwX8+GUA5/6g1kGpNtZVcpYmzEa++uslkaemrpBh7n1QuNipmCMA?=
 =?iso-8859-1?Q?KEvwNzRyqL7A1h9qenpWMX0gMNATda9Ugjd40JWPdhb4IREFAjAF8+wP3I?=
 =?iso-8859-1?Q?DIxFATZ1A2xRdiILxRN9GY5VZ392ySFnwiA6cJ1p3za/BXh8OOL2STDDdA?=
 =?iso-8859-1?Q?i6cspyP9Co1Inb8i6anBWTRaSFm7GcQdrGE1/BZqeubpPOdjqFxCALjEEU?=
 =?iso-8859-1?Q?LbCiQFt00RFdKmz2oYQjcXsftN8AGxkHGS61Yp3Ds6Wet1n7ny7EIJhnKH?=
 =?iso-8859-1?Q?zDo7sii3aCC9K1Ysw+E+EHxH5kRCqRFsYaI0kMHdU1VI6FQlpOiPo6fTnh?=
 =?iso-8859-1?Q?mbKFeQgPdc8SYcHBc8RDgWhnw6zDzYa3QyUXMjbEoUfuggLofItKtuifvQ?=
 =?iso-8859-1?Q?6NlWdrHmUEOkQ8ZFOMOesZeQYD9+b7Rh4wjmYLqAjQQUVAFpcUl9Zuc2ED?=
 =?iso-8859-1?Q?9CNcNf/NZeiHoxBPok0VkOgb1InkItm4g/yWDBbIDlTGfMQ3nwcnuXLecJ?=
 =?iso-8859-1?Q?UQO5sjv9bp6z3FWfc7wh7snAdgfLfiI1B9QqjEioTBdTg+T3MssCQguQrg?=
 =?iso-8859-1?Q?lnGwjAxdo0ItP4EUJhzI1yI5GBO6xVoGzJLDHnFTBCpnl+IFQjnZmiY+2L?=
 =?iso-8859-1?Q?JH11RW4WWMQqi/iQ0qP2YeZFjk6+XNhCDXKi6/rC2iB10E0MNLtyFQ1Zip?=
 =?iso-8859-1?Q?jGm32aXKMYEY0lrZZXVY9Xd7Nl7rj8grYQrpeNKaEA8hxCYmxZQG35jC1o?=
 =?iso-8859-1?Q?DL6bYVorAtcj/TOYhygYvQsKD8GRfSGgL5bzAd8mJIL8rK+BI1IwxBV4uD?=
 =?iso-8859-1?Q?Aoc+PagJGSQbMyuF+po0lEA8t3KIMoU7MTXrXPOmbM3Buc98uVxtMmQRsb?=
 =?iso-8859-1?Q?tx+BdJpazEJnmtQ8TtfHSuQ7L9zaFR61BXjfidDKFNGMFlLda2im8/hw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81b66e0-0ce3-4f21-ccee-08db34aad388
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 01:20:50.0631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pmq8WPcWxWMkhqDLS+4S7fWKaJ9ncUHDWHdcwgLvsfJR4s/x4qbK143+RoZwtQFxVQ2xdF1ecAl4edz2gdh6UezbsXI9ddUzI7Rbb7hMQ4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix for kernel crash observed with following test procedure [1]:
  while true;
    do ifconfig wlan0 up;
    iw dev wlan0 scan &
    ifconfig wlan0 down;
  done

During the above test procedure, the scan results are received from firmwar=
e
for 'iw scan' command gets queued even when the interface is going down. It
was causing the kernel oops when dereferencing the freed pointers.

For synchronization, 'mac_close()' calls flush_workqueue() to block its
execution till all pending work is completed. Afterwards 'wilc->close' flag
which is set before the flush_workqueue() should avoid adding new work.
Added 'wilc->close' check in wilc_handle_isr() which is common for
SPI/SDIO bus to ignore the interrupts from firmware that inturns adds the
work since the interface is getting closed.

1. https://lore.kernel.org/linux-wireless/20221024135407.7udo3dwl3mqyv2yj@0=
002.3ffe.de/

Reported-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 9 +++------
 drivers/net/wireless/microchip/wilc1000/wlan.c   | 3 +++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..40edee10a81f 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -38,11 +38,6 @@ static irqreturn_t isr_bh_routine(int irq, void *userdat=
a)
 {
 	struct wilc *wilc =3D userdata;

-	if (wilc->close) {
-		pr_err("Can't handle BH interrupt\n");
-		return IRQ_HANDLED;
-	}
-
 	wilc_handle_isr(wilc);

 	return IRQ_HANDLED;
@@ -781,13 +776,15 @@ static int wilc_mac_close(struct net_device *ndev)
 	if (vif->ndev) {
 		netif_stop_queue(vif->ndev);

+		if (wl->open_ifcs =3D=3D 0)
+			wl->close =3D 1;
+
 		wilc_handle_disconnect(vif);
 		wilc_deinit_host_int(vif->ndev);
 	}

 	if (wl->open_ifcs =3D=3D 0) {
 		netdev_dbg(ndev, "Deinitializing wilc1000\n");
-		wl->close =3D 1;
 		wilc_wlan_deinitialize(ndev);
 	}

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 58bbf50081e4..700cb657be00 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1066,6 +1066,9 @@ void wilc_handle_isr(struct wilc *wilc)
 {
 	u32 int_status;

+	if (wilc->close)
+		return;
+
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	wilc->hif_func->hif_read_int(wilc, &int_status);

--
2.34.1
