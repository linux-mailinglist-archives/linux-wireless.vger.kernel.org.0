Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B49A40E3F1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbhIPQxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:53:12 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:59215 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbhIPQvN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631810993; x=1663346993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bUJG6HfYErLAPTvisUhd26+hGAGT5I1kXFnDpjGJS/Y=;
  b=1gpzUhNUO9zqfsN9UumvPmg3Qb/UIxoC5RvygcDfxw7UTWU4zGErFgtr
   elDr5X+sHtjTsKaT6Yp7tPG6FHy56V0ZIu5k79uG4X2EsZsdVO2riPHmU
   rAtWr9xSt8Pq0d9/kRlrlrzn6AbCVqJSRor2tZkcf5Y8FkWTwHePpKU3x
   9ZOqL4joY/WoNJnVnbKje0UaIIM3A5/0vJz+m35WKSeDpqxommIRtaMFv
   KN/fJKNKrsIsqB0GtmcnsogSB9iN6sGAPQvE7Ucz10EPah3kqC8+KRDjE
   w8ecaeP87u4GuL8PXHn9qj/7LWyzxfeT/3lIFpj9ZfH9wognROmQlLe5D
   w==;
IronPort-SDR: KjAmJcEDN6gMTQYw/yka+gTkafp9iIjabZkbyN8eJRGQ8uC4F+s84QIz8FnwL6mMa431sU5fdF
 +sGHcFfIrFB1OCZ6DYyeQj26MjAKCv3cTinuJ6cGRoDxhjBUXgesjS/PnHYzgbJgSEHDQMzUdL
 sYlctqfwfaJw03IFGyruHwsEPoezGevcqH2u/OCO0lIrgYWrvAx7bimUXFruq6gjkkFPgUr1cp
 CNy4ebslMh3ssrQQEypjwwutKh9EdEaQeeiZQkiQ9xvroy2b7Y/W8jlpol+PLP7qJBzZUg/nTW
 wzDsX+zxe8NTTVqjHZEiUQbM
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="69561314"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1ZNu0g/slWVgr6n1CXB65P9CCywzCq4gYTP6Z8nvzZXCILAE1cDzDbnxwWj57af3PIvkgesZLuuIU78DJ3F26wjDk4JKNbDIORY9jdH528vwiwsZBE0d0ZlJLxQ70ho47g3Rn/gJ6tb5SlEy/dVJFPTiUu+yFKgrzYH/KN6uKWvvJHvextT5wdCZ9Y9SX8/Iv7IBvqzaZyPRfB5lL9/tzEerdkQk4b/sG74LC3SFMYjD717sy9sQ+SubNxseVA5wF/NPPIHMyEyQZWE9M/mYt7WpmD3RKeMuumNlcFeLWaWKf38dq57uZ0ZezCLuud7tmGu8kLkN2tKdOh/IK7ueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdaPuRJXaXa0/cbXr9Arvsn0WeqMoIfba2l8M3uP9y4=;
 b=merD9p6fx3pZ81IL8G3pzeSGeYXj+OFwF1uDM0OB/GDicjnw+ebDHxg0W58frxmxkO6noEyY9Pq+m2Ren0EZz0KcNlahOpJ8OpLcKFBZvjzcIGRK+pT8gxbRp/X2Xy9RKUVC+ouOa89SymRjabuWq1nApF+VHjFRn6ODv1DH3ui7HpF932mALdg5Uy+oPsPFpmjvz3P2cDKdN5SR6DzpOOARP3ZpzNlyTbbgxQIL/3KyeTVXUq4QJHU3+bZRWtjgEOPQ+YAvIPieNtGIWYVWfSeJbf9N67DFBtFCGhuCnBXCfQKnxdwz/3cfHgcuAlUb/9v3DJ0E9km3OXvsaTkjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdaPuRJXaXa0/cbXr9Arvsn0WeqMoIfba2l8M3uP9y4=;
 b=eHTWnMRVAKftfWbNgwOMCorjToDeGdfWiZLt5qdBOznywHaFaCOHR0gMjoqpUyEkh35O6DfFtUGup9YTFGDB+7TqImdTOGB67mYylS0PCO+4qKMZuuqTYHO4hIHnJIbiJyRSAjSzpLe2c6afj7VIZmaLivJAJ/IP3FEB57QyPR4=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB3990.namprd11.prod.outlook.com (2603:10b6:a03:18d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 16 Sep
 2021 16:49:34 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:34 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 11/11] wilc1000: increase config packets response wait
 timeout limit
Thread-Topic: [PATCH v2 11/11] wilc1000: increase config packets response wait
 timeout limit
Thread-Index: AQHXqxrNoiSicpseb0aRBOjPP5TBlA==
Date:   Thu, 16 Sep 2021 16:49:23 +0000
Message-ID: <20210916164902.74629-12-ajay.kathat@microchip.com>
References: <20210916164902.74629-1-ajay.kathat@microchip.com>
In-Reply-To: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3910a575-d0ca-4327-b858-08d97931f6ab
x-ms-traffictypediagnostic: BY5PR11MB3990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3990477BAC14C931FB08B0F2E3DC9@BY5PR11MB3990.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAexwYJqItgIh3cvmi3aqOJm15xd/gXHYWCego1TD0EY4P4qEPcKMIY9ntBvR4EsI3X9AJwXJ2deCkUXYVRHuwP9p3aRBtzizWKbSPM7v6DUQa32QA55rqk4rXUtBdaHHI6hsTbdCVf2gi3TSuwRpr+khAYC/xoZmWkRyk4+i6rFwG0sARJpIrAGbUKQvH9mI+zYWBpEH2WhUSEApN77qb/9eDFiMRqXXf5QSBjvO5rwHV+wmENapfjs7jUTfNz06p9A8rl8K6cVg2yYp67kyve0FG4b0Z0PuWZ/AONPU2YMKwHKUwX3dI3ajxuIfE8y46Mki+NNVrQYyjFgHlL8hqCzj5FFvAPvy2Q6dPicGK/X8YdaZN6NHcLr/vqNWBKM+i+Rs5qb6YRDB7r2ZRRZxij/lWed5T2NvYdW9NSfSwCUTgjvAHKlqRw8c6DlpORyYkMlPe8Or3XneadRlsv2HZa5jhNCRKstCCjK+fbP8ooFB9FnAtTpF4fDBHHwhxFXqHMewzfhn7VBJc1SoFqgk0dV37HOrxsKi4AZhhytTUjHgrXONpF4JXRL3835ILeWbHPcEUQxD9nQjH5k15urO8BwtX177Zz5q3ORiH3TEXqd15QlgStoyvwjjCs11Yb2anJdlCc6SWVXdxaLJeRrdU0L72zQOVQiozcKb13Rcu9Tc3l8HaE/PzZj85lsJXQ6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(64756008)(38070700005)(38100700002)(66476007)(6916009)(8936002)(76116006)(6506007)(71200400001)(66446008)(2906002)(4326008)(83380400001)(107886003)(6666004)(8676002)(66556008)(5660300002)(186003)(4744005)(66946007)(1076003)(122000001)(54906003)(316002)(508600001)(6486002)(6512007)(2616005)(86362001)(26005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2XqZkd7V1/QC0WIPjm0J2bo4lrZb1DxQLZ9D5j3kZDmOf/gVKZCfC1TpUs?=
 =?iso-8859-1?Q?gP6a2l9Z0jvsdPJ+R0AYts0D87CvTqUqrI2U9WrSNfUpdWmoSEuVsNjnwS?=
 =?iso-8859-1?Q?qWM1qodk1HQbHWXnTbeTY6hTZG5MzpLtCkxAPEYgu46E8u4WD5ord92J8X?=
 =?iso-8859-1?Q?gO+msFHBE5sbEtSu0KUJssvpZFLvo+v8wxMwNM6Er9U3y//EYsF5ZXOr91?=
 =?iso-8859-1?Q?Tj1gmuR/6xNCphg/EPneWirKTZY8o+g1beW7VAmyT8qrI/mdwNN9Nc0VWg?=
 =?iso-8859-1?Q?pZUuezVc9cJn7aFCzU1BU91FHEzfy3KGKdUqFmt7oaIIf1M4HSzMb3S5Q0?=
 =?iso-8859-1?Q?q5//BB94T4d094zdOBalRWcN+3ltkdeNe92mUc5XSDIpv5gMzRVhnUiMjh?=
 =?iso-8859-1?Q?mU4wTRwuor7x0X620bV+X8VrxTHJ/+mrXCITmjYklNwcKwZd1hRzpMG1K9?=
 =?iso-8859-1?Q?JnLQ32vAD+0feIELZaJ6GHmHl9hjI2UO20YLDbx7G2dSzDPcu0zpoThVJT?=
 =?iso-8859-1?Q?v02rp11omvyUzsotyWRTWp1CD+cZUGociyLrFs6PGZTOz3U8ssAnWRcwGC?=
 =?iso-8859-1?Q?4lDPAWzAh89PWO1Ec8Z1XQ+v6XZtRk263W/ht+ypc25ibm30menONTI0sP?=
 =?iso-8859-1?Q?i8WJfzgHXU6H7kauMJvkymc5SnrMqpx3fet50EHhd89MNNytnDOct/zWDi?=
 =?iso-8859-1?Q?7x/QgeEkGtwB7zYmJgGGxsge1DZYpDm0Ocfr45T4zUCvBaSum3MkoJPosn?=
 =?iso-8859-1?Q?JHFxzWdV7bBbCQ6d2vDenAQNAZDrS+7ZqAUuQ41Q2FkCo9ljaDbYAltqiD?=
 =?iso-8859-1?Q?PPqqe5rnD0ugjQqcpm7A6rXhfhwnEO2STYDZqDBuvNQxdSFaJq0/0W/9Gs?=
 =?iso-8859-1?Q?3ki85eCtSp5jqpp8IhAiofXC00q92RguzJgc+dV9f0FAKHx8kjlNrvjyCT?=
 =?iso-8859-1?Q?8qlmcW9akWAeOipTjLPkhkPs4TsVZBb7J/Je4ILGU/uDsTqlBVGW50tINb?=
 =?iso-8859-1?Q?IbWY+LwrESB1pXNvxVrKB8a+Blz4p76lvMwAdvj6L50pPee5LCdnBVahQR?=
 =?iso-8859-1?Q?kjzxBrknbFN79KWYF7ulFEdR8AfMbJeEPM9NqYw2P4apUtJgHXVWOowz3O?=
 =?iso-8859-1?Q?+zFsyFfhDAJdBTVH1zK61M684jrmgtRRPe5mvhhUCIy83eNcZfzUkp2c7s?=
 =?iso-8859-1?Q?2+4p3fETgbW4a5/mphlouXFKjAAq4ul9os2scrpcL6txMGHM+t+2Ykj0gZ?=
 =?iso-8859-1?Q?M/ugP3UQ08OyCpDPGvBu8QY8qrpFS4DlVIRl5tccBDDX6DIt59HQTWeuwk?=
 =?iso-8859-1?Q?IRat1jDXffBa31iAMEIG4Uhi8rvtIQnK1xZecyc7fN1fFeCYnp0FO37aCf?=
 =?iso-8859-1?Q?qMHXzTB/Ln?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3910a575-d0ca-4327-b858-08d97931f6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:23.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJhWhoaprWUZ7ACJ8kVDCGS6f7Ul4Py/CyDbAtl2gcLFr0tDArYe6FnDf2W5/O+pEGpVe8yNJFAZf4XKCpWTTa+qgLhWx3jc9/Cww28GH4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3990
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Increase the WID config packet response timeout to have extra wait time for
host to receive the response message from firmware. Sometimes the WID
config response was timed out because of host interrupt latency.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index 150648b2c872..13fde636aa0e 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -302,7 +302,7 @@
 #define ENABLE_RX_VMM		(SEL_VMM_TBL1 | EN_VMM)
 #define ENABLE_TX_VMM		(SEL_VMM_TBL0 | EN_VMM)
 /* time for expiring the completion of cfg packets */
-#define WILC_CFG_PKTS_TIMEOUT	msecs_to_jiffies(2000)
+#define WILC_CFG_PKTS_TIMEOUT	msecs_to_jiffies(3000)
=20
 #define IS_MANAGMEMENT		0x100
 #define IS_MANAGMEMENT_CALLBACK	0x080
--=20
2.25.1
