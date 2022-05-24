Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0102B5329FE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiEXMGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 08:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiEXMG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 08:06:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5DB13FB6
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653393986; x=1684929986;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=odeIMyRM/MeJ6/NrTOUkM7IkOttnM6ngr8bg966M+0M=;
  b=xwac0JfAEU3lcawSwAHZ+r4wJ0jLT4jaPljTU5aZlqxbqG1pLJtoO7DL
   U9qC6UvuUeZTOcZF0XxULObeedSUI8us9eA2ZTTeqOpBogdLoUbfjD6f2
   +9RHpgN1PS/fagSHLfCgc0PO25pK9YpA+ErpGNVOLCLu5isEIdZDjbLyW
   0fS3oV/yc3DZiyIAtse8Tl/g2WuAC2o6ci2EdnPTqLLOryUofbODwJoLF
   dw1p2wnqguqxKCmcisv9sFKeDhyTae10hL0spkwsOtDsVjoS/GlTF5cbQ
   4NnjHBHxIvuVDtNSY56vvNVjRo5T7bgh54KS5uBE73s3EM/vICb5U6yc9
   w==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="174813198"
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
 b=hnAIntz1IMHPoTq3W7uBps8ieE/+H6I5PVv77wS87bAMoWIFzMjLkIKsIQaJDS/uGnm3EC+D01Cs26GaFMpTidN/sxmDn+yp6kYsJAH1V/BOUZ+L++9HWVCJQ17d2D3CAbVJPOecISh40tmP1Oa29/HNvp5yuQc4HuyQa6PWRuzzg+1JnKFWqgokUv0YnYmmhuetuawYZDXRncakOZBVyJIF8kaPWkR37dd1IMJOArqJrfrWu7rGeQLLgwTFpEptJhTQJXaLj0J8KMlhMPCOBKOg/SwjbDPhMzJibOc/fqmbyIwtCinVUak1s+0KaPMWNCXEeq7/Dv0v1lLexrHysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuzuXEBwgX88iu5rDvWvQin8cRwv3ihbnYSJdAVkO5g=;
 b=hHiHGhPMZosgjJBQKvgnkB1dCSYjdGu0c9gu/Pzxy6CC2ZIgBd5LG1/iQET3pWc/6nytpuO7lJRiKG7CYA3vqL2RMn8CP66LGRWyExFD/LiUBvGrlIIuT09ToSfSJ9QbEKNBaY2rvuNGIWgniRxZ7eucfFipCma9P5hbdmG4h1JdYdGgmGsSnRmInE5DabzvP/URKkHiVVPEg/xWxt88xsd7P+ILPUI1DU45m9r2Ljcl6w2Pype7J66mKUMFySW0K++XeH6nQhI6OZeaOZ6GDGFJ7vnkfXpFvzt1qcMID7K1GGCXfcy9Izipm19kr7Bl0Y7GDdDJncF2cJA2V9b5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuzuXEBwgX88iu5rDvWvQin8cRwv3ihbnYSJdAVkO5g=;
 b=lsLhOgXYZY+8EgT2UZx1ddN6xZUaFlNE7l0xSNkYjdYghAxqhICKHvSTc8whR6WRT7zLIFKJfChBg+Rvc6ZNljHeuzLqJ6790bMl9IOvKAOj0JLQoGfmX9c6s/6rXEO4bVogIc7Nf8KRpCW5lCNkyxa9BEnvh88fU0xUwiWkW4U=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH0PR11MB5412.namprd11.prod.outlook.com (2603:10b6:610:d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 12:06:19 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 12:06:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Topic: [PATCH v3 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Index: AQHYb2atM/50sN/76EaQWN5Ft5lV2g==
Date:   Tue, 24 May 2022 12:06:19 +0000
Message-ID: <20220524120606.9675-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8fd5642-7702-4399-17bd-08da3d7dd001
x-ms-traffictypediagnostic: CH0PR11MB5412:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5412600942CB122CAA8E5B2DE3D79@CH0PR11MB5412.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNNWrOqsKX5LapahpzoC6irOGYHDMpBJKhMgGYFdgBfE8friepx1Zdb/ofVqm7Uasi8CsGK34sTZX1QDN3uGsrKMEuas0oscuReCovOXN75KpHOczx56fRviP4IwnnfA0A1Pcwe3rfHr4ZQLe3v5vVo7ykaD08E0BH4ZAZ27tilHJe8VMV2fixRozHmEHiFQQCXC5y4kuVGV2dFUXHM8l9q3NMab+5SpB65fDIObNftTjdPftWAc0oUPJFGlkB5qmeIg/fQ5lDW0T2OkqvBplYl7Ya17+vgFWEVwUFzngQq2zM0z3zfkvfysLO236/6T3s1ThDFrdIljX/Q3afZe3UyITIuICWC31MMESCNquOUwgKqC8+wUKYJyYfOU/Npzw6akpoJ+dMH7ts2BRmPPsC25Jo7aYYEo0+shQqxlN1NT3XhsRPnpNfo8nG2ypqzHG+h0RNfQRQIN0nL83+YF9BIxsKAoQ6oyF8oew4b3w2If9DpSxzOxuvrwXZReTVjyvnKNlKonmypnf7tBe9M5MjuI4f7vwA/EAqz++PG44AsYNPPc/3929f24WDaq+1Ea8fY8rzmaDxnAsSStQhkd0ajOpjaWiN6qgnmFUAviddlHGllEac9SZ/0d9F3DlHmaqLz5izZrJFTKK7gHo5h07ntQfZ+WbpJ7/3S6kPQ5WLso5s3gIIWdAkD0F2IwPINqdM/6hd5L2mQ2y9zEyMi3FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(83380400001)(2906002)(8936002)(1076003)(2616005)(6486002)(5660300002)(86362001)(508600001)(26005)(107886003)(38100700002)(38070700005)(36756003)(316002)(122000001)(8676002)(4326008)(6512007)(66946007)(66476007)(6506007)(186003)(66446008)(76116006)(91956017)(64756008)(71200400001)(66556008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cec2utwFbtCjUsoJSdWsZ+UWPZlPXTVKB45i0kkw8Lv57IlhXMRk7cU0Tl?=
 =?iso-8859-1?Q?GnyEJbp9qmaN9fi0JBK7TEzhyMi037XFtP5iXsbv9dHvbTsX5gK/fttmt8?=
 =?iso-8859-1?Q?jSLcnDlv6Hh4RG4E4bAFRM1nym8u42gGAJGdhshfLUUwrY+r2PjbHHQIz7?=
 =?iso-8859-1?Q?oFHF5Sg/PhPYG8/MJF7OczWtui3tTsOXR6pf5MDta4R3aBCoERGLBXcN+s?=
 =?iso-8859-1?Q?ytF+jWeRG7SFkylJVw6IYBh0bNQtd0zzunhHJ6YT8O9ONZUXE/wTgw6dxZ?=
 =?iso-8859-1?Q?SKehiKa2JRVtVYMmcwWFMGt7ZJ+/AMiPnETtzay08L53wXYVoFo34UAEtO?=
 =?iso-8859-1?Q?SDj5Bl9kE4qoAWCVMr/vlA4fGVo/2hDWruMkSXir/mI6P4mAEQK0gKstkT?=
 =?iso-8859-1?Q?ipjIiRHZSI0D6MZAXk+i/7NSWMLSmcaGxXKTrAegLO1am0cnhkYgCl+v/P?=
 =?iso-8859-1?Q?qCLYWaUjGBeGm5nj72ktBYRSe6nP88hvZIu5VssQFo/opeS84vPSq/frbu?=
 =?iso-8859-1?Q?EKtE7PzOjY35TffifMYof/tRL9wFTmzLbh2E3BWHCTWh7u3LZA4H8vJFn+?=
 =?iso-8859-1?Q?gkpof3h1fH8rnFBNna5ZfxBgNODvXiIKwO0KVD7xHHqL0UmVFLuDH/qkQH?=
 =?iso-8859-1?Q?tP/s6fAuhH/kB7JcrLwMfHm0rUOcB4mm3o3hdJ6pt4XmtpAMKT3j8L9g/C?=
 =?iso-8859-1?Q?UMmxpFIQNWyfYygxaRnGWlnlXDgjffjIMAsPRITHH2i2drFslEpmpkuDoG?=
 =?iso-8859-1?Q?uilbGl8oinveLr2jUHbfZ/85WHAwtLhiOadgpwIZzSlkVAETZDTRAZ5KB/?=
 =?iso-8859-1?Q?jZCsSf9iVygupvLcPD/yAUKrS0WeSe7bvRC1/qv1SFlYvh/TGKcJpYwsnQ?=
 =?iso-8859-1?Q?5zsHb5IpEkuFnrRNitIU1nqFp37IAgXOnizS5WbawDZI439/qr7yuKa/sF?=
 =?iso-8859-1?Q?yfeGbjOButmOtfHGQ9CY2sISRpBT6l7jHSnlwrnvHOdlBOp1NTMvY8TOf7?=
 =?iso-8859-1?Q?9Yf1O/c9lQke34Jp9Zd4Alhhbi/ogRFG/IJALo1E5B3rcB8e0Oe/4xFy5W?=
 =?iso-8859-1?Q?XanL+CT1V+S0xT+mRZjXEwpuLUXY9N5AA8hgfh76bnas/QLBujg+KihXPF?=
 =?iso-8859-1?Q?JtpINlnnNQPzEZhe4P6ScZi1UD4GQvdfeYM/rntZzJk9i1N2KARYv7Hdpr?=
 =?iso-8859-1?Q?VZ8VTYwJflmWRY5TFeCDGpa1sft7yfXbdegQsvb0cWVf9hbW8nlFMiU6n6?=
 =?iso-8859-1?Q?KVqQ9DduP0SbsD458YVip31CzlI+Kc1l1Zq3A7IOhHTGkzOvUu6rIHeiFP?=
 =?iso-8859-1?Q?pxyo+euYuHzxqjIg1H+sDfPx2Y7/g7m/dOAsdER0yZlDBYIFXs8iaVfYQH?=
 =?iso-8859-1?Q?nlDl9AmHIXmT5S3arC65RJm1a1E9U/sL0fyswNHYgk43ilNNcwGY6qou39?=
 =?iso-8859-1?Q?VruPbmHTwpAISQgFaKHpWCYuZHETa3E54xjyPmVJoCp9PoVRYwKVMquiUm?=
 =?iso-8859-1?Q?QIBiE+PwvCGF5n1iqENjjAVwpeuvhZFJi97SPeaGnQ3yM/+tAV+MPwvlFh?=
 =?iso-8859-1?Q?gLlAZDIk9EgDVTudeRQidBcnAMYueMatHZImzIkoFnjC34vYeoyn+0rIOZ?=
 =?iso-8859-1?Q?DDKuHtssTBDNe/CzdXVPMVfxz6rP15o+88tU7ek+YMKHf2o83lyLM28R4j?=
 =?iso-8859-1?Q?ydx+NBMgF+BdkwQMU9Q77GTnDvQRRVp4uorUPupggz1L+mY/TFgDFp/X5q?=
 =?iso-8859-1?Q?iFRtwo+yLC8CLwl+faFfXg2JwxRdGVo5RiAo5iG9/KEbdsrndX8eXECQYm?=
 =?iso-8859-1?Q?pO+td+Y4ZNHkLz9hFPHuVGOSc1ki3VX8HxV92y4k+DT5ghD96ctB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fd5642-7702-4399-17bd-08da3d7dd001
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 12:06:19.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6eU3P5sM/OAJe5AU7wgi3l44KpMeTZnAqpgmdsyYWNFd6dWrjD3CbiXbrXE8Skv8nYxVUxov3aveB64D9rjXsyT0vai20pn1cvjC4kbXx0=
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

For power-up sequence, WILC expects RESET set to high 5ms after making
chip_en(enable) so corrected chip power-up sequence by making RESET high.
For Power-Down sequence, the correct sequence make RESET and CHIP_EN low
without any extra delay.

Fixes: ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver=
")
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---

 v2: No changes

 v3: add "Fixes" tag in commit description
=20
 drivers/net/wireless/microchip/wilc1000/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 18420e954402..2ae8dd3411ac 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -191,11 +191,11 @@ static void wilc_wlan_power(struct wilc *wilc, bool o=
n)
 		/* assert ENABLE: */
 		gpiod_set_value(gpios->enable, 1);
 		mdelay(5);
-		/* deassert RESET: */
-		gpiod_set_value(gpios->reset, 0);
-	} else {
 		/* assert RESET: */
 		gpiod_set_value(gpios->reset, 1);
+	} else {
+		/* deassert RESET: */
+		gpiod_set_value(gpios->reset, 0);
 		/* deassert ENABLE: */
 		gpiod_set_value(gpios->enable, 0);
 	}
--=20
2.25.1
