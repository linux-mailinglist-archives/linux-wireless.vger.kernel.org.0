Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E540E3E7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbhIPQw4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:52:56 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:37580 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345767AbhIPQut (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631810969; x=1663346969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=miBKW1A5kOwkQr7QlttDiag02LSAl+Fz8dEu7GmQ9uU=;
  b=KefbXw0qdXU1/ZDJLIhOpcxZ2tqrV90eWcL8w0GotP1jlJJvw33JbHjb
   VwuYc0zBV+OoAqJ/hcdqYcJ5HzpuY2gsTS1CO4jo0utVspInOz4zvhttJ
   bk6iokRWD8vnemxXMu16JQT7NnMu1EGj3dX0NnrjyDzyr5D8T4hanPdgK
   hR3GHGynd2L3SLogCsfstEROCYdYlDTKDAGtT3wstXai1nbPCxScEMzws
   JM8iT3pChAyeARnM2C9GGxfRfOvtob5j0eNTj6K7k+amqhT/yI4mz7Ijr
   BMsZcSF/KSKZWMU8N1MhRLtmr8zu8nvZtOkQmn+Fe5oOepf4GpP808AuQ
   g==;
IronPort-SDR: Zp6qmoYmYNPtP9PvgBnp+UQD9H2z0eNM0mEtoD8qah0T2lnniM/mqCRCq54V0Jn3cH/o6eLlru
 eApoB5m85hxuOMmO5+TXoog60RpfWUAkK4CsdY/uwJWPJgfuxa7Q2p5uf48HSdx0qFMJsmeu52
 mmWOYL/4WgGGOaRgH+YLUHsh5yHEoxXeGU8w04intCL+yhRz/qiz/iCqrlHFLemZqH5+iexIu5
 t8usPnRRyEMlL/pfAXga6jzCNUtwZuVZ2xLSGrnUwmRvey6+YE/RTW9ZBo2JvvUlU5hRKQM8Sy
 x5/H+6qccLpLFk22hQZRFztp
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="69561226"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK60g2oISJkIjj+XTp4uXuCSm7X/+ioUsLtrq8kj5bKX3mm1ri+oL+LzzR3kK+BT5IpUunEuaGTYiHftZu44JXEJlgOC8I17MgCXwJVQhkf/dnv1MR/AXWRaRnWBO5YSsd7dnLmJacrth6kSUR5NhYxe8f/v2n2oiEX/j1UVy7JwoEON+DuNnjaRZpGduXa67SG/CfvC43/5mZFShV/cvqMMG0k9JoktYD4El46jR1WcWckEdArNzGnMU3KAZDircEmqjFOdlNacpqC60eM6kERw5bXhspmYzU92gXVGcvqPBOvfIwL1fx2MXDpNSS4vQeM5kMQTu6IKG2pbXF8usw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J3+YB5R7EWngunUqS4whTk1DeznLp+z39fq6UZ/pxTA=;
 b=JFwa8XggQ/pmPsD3bSZSQz7AFnjLWODQDX290irDSWhrclgRbL9N2eRUTy44z1zXTNcsJ/G+I8uHeFlRxsRPk+RxMW7cZWHo2hLQDUf/UYaS+zZmpceV8TImUnp+OW0GXtSgfgN3ofJhl5cP+OX0cxXgt3y+Zs1FXJVxIcQj9eVVMiI1Q3/mKJiCE2IRgW2tVRsbLA+Qd60orp+ZEOONVDfgsEHIisV1QSBSPTj+zGcC9OwbYq+vBF6XEsufoTVGWR52Zuhg7tfQDBN3TIBYc2bmDjqXLf7VhjbM8Cm3NVD3cgnQfPckdzIBvMCRgT8mLF3I4e+S7VZVzZyrA15naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3+YB5R7EWngunUqS4whTk1DeznLp+z39fq6UZ/pxTA=;
 b=p+xWUdFPe1e6nMOczHKLIdwVJ5Ucij2piiEFNEMbII9aK6jicS/jCJx3JexholJJePn+LjAbpX3+L37gCH3SK4BBuS8uBlsZdbKVhKfeB2enjsHi8TAL8w+fR9C09rIvR1JQ2RwMOY4f0kkBJExS8s+hV9kb3Kd0wtgmCfdDdy8=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:21 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 08/11] wilc1000: invoke chip reset register before firmware
 download
Thread-Topic: [PATCH v2 08/11] wilc1000: invoke chip reset register before
 firmware download
Thread-Index: AQHXqxrM6R4v6RJsvkKwKgX3Znnhxg==
Date:   Thu, 16 Sep 2021 16:49:21 +0000
Message-ID: <20210916164902.74629-9-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 5fb51ea4-c96c-4518-7aa1-08d97931eec5
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB519769F239D2C09EF3B5E6E4E3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZWj1aKk8aKXtlSWX+52T08kHi9xSkSOS37C8j+mz15kM0bp8sVMXTqbcDAoMsIIqIKQcFXGssyYwXMV1euiqSL2v2xYzbhTdJEVixqriu34+QMxmDtjxy3UZvEQ2DbNaYBrvgucYjZZCiyBb6lr7IBW+ofYb40cObakgyoOqeFHuNgiARh5TRVV6tAOvLIfnVE1XjflY9JheZkj+H/zp3wL7YCn4+v6Od3NNG/zpyokOyC8ylMOkKpN9BQHQ4WHxV328D5ruDztz5KERSr5CHL8sENSkYfIWCa74WVS0BAzu/gOdo8J330ljJnNKQ6B4BJ2uXInn5XcnCbJ9MdXy2ctogIMTkfM3nwKDHB05JcjqBHSTLZ7bBvvXYC/7HtbW7Zrfu6uUQonJLM1tXd9MahuB5hYV0PvHVdWFNGf2hZTI/ztZZhSmTeStG1gBnCkyhINCKYjtxJL4qA2VKBzj7VYd2fcBcMkpp23IaaUY98BMY/1TwggNajrfKY3mJu3As5kXJkqUpx/7iv0aAZo32mL/y2/v7trcrQ7s0LNRdfrZpym2Q9/ZcVdlSgcIJKN8OBGCdfRpWgCQZ/roLJvj6VGSieLIeEah/8ACHmY6ZGhkr2HsqyKYTUS8g4gvzDjSBqJ6JHx2G0VnPkzjLNzllcZI8HJYyPoUGD6a0J/Bwcv9ryDo30Asj61s6NCQmbuEvjDc359oO65Sju44zk3bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PfPAiLygq9hxFAo4fgTRTIRPUEBd3L2dr+ycuTM8lnNFxmyH6+SrG81yRM?=
 =?iso-8859-1?Q?/15ouinVNVxJPAVItl0bTHJmeL+zV8BgYEU/n5D0xInr4bXv2CqcDcRbTH?=
 =?iso-8859-1?Q?b1JmuQwpEyCTFDoHNb2uiPKCpKcAHZjtvgBBKjU2gL2iars55ZmCfyXre5?=
 =?iso-8859-1?Q?JSXWU8azUU/v4zeRiOA8n8eLcOVh1JTTHKx7v7O+Hto18E1/nj5CIgUT6Y?=
 =?iso-8859-1?Q?V9ItvFPPeXP4gFbmIHydNT5+qI72N5viqoDbDO7nPfqVw0lnaFQUX4JwGd?=
 =?iso-8859-1?Q?mnppSqJ82kmsBkv/8TVjts421EIxBBbEE2nbbk7rfaOaDTni4pknu1FScH?=
 =?iso-8859-1?Q?6D2Oe0vsEQTAzK4xfTrkdNe4Ple7RDOZOYRth965B4XZZWL0yB9covAvJs?=
 =?iso-8859-1?Q?phpExe+Bp2TLIcIWWUgKkI2wksBiYtXg1xkZZYsYjKVYXWqOm8OzhyHOeO?=
 =?iso-8859-1?Q?Zy5ZO6bb5F6pZDxu/OgkCe/S9tZk52iR+02v+CEQO2zvemp4Ku4/OlrqF+?=
 =?iso-8859-1?Q?mFGcG5gSrkBztCT6pSO8/cq1V1ZgmKNtK/OevpHW+gLiWR0a2REHM0NmoT?=
 =?iso-8859-1?Q?YbooCRJ3Lq6pOtB3SXphX+7vOyf7e07SF7Yc1unGD39dvtJw7V31ckOP5W?=
 =?iso-8859-1?Q?if16+2S+Xb8LiBB20VS2F5GAwVvlxyx4MvTR8imzINdT09NAtFTB8tiIQY?=
 =?iso-8859-1?Q?Lf47PL5eI8SyFlPact9RYw8ppyHUkxT6Ud5MC/Bvg99P/czzZadWcZFkP7?=
 =?iso-8859-1?Q?N+FhyNuTuTX8KiIzNG/oVPydtai55vSVPojn1NWRu2GXpG2VGzlCZWo6G1?=
 =?iso-8859-1?Q?5MSX+VRba63mOvvUHQ4M6VJ4AL6vqCBN5FVW23dMkH3FNrzBJ4m/iN/86y?=
 =?iso-8859-1?Q?v6vEnms1hfo4OFrZX9yKYOjgWTmUyNbvvYJw/j1YNSnSBtaZcLOLQfOdxI?=
 =?iso-8859-1?Q?QDoqN8IZmd9I5s6aiW/XCYBYk3gAlUmTw2cFEXcA5hXAzCK0q4f0b/owS/?=
 =?iso-8859-1?Q?xGA+iOmvM+c+3Ks4MPqSYP0l8hm0SzRSKzO4kPUzJnJNP+0Dxu0vHmuUur?=
 =?iso-8859-1?Q?7p+uopMftDFmv2ZQ4rqYJcDA//+6oWiWDH2P0QpoQCuo2CPG/MXHbitRwh?=
 =?iso-8859-1?Q?jiDr61fZ9FZzLuhy3+PF2NJcTgiJcIQhi4HPa6eAKmHhlEC1Q51u6bzD17?=
 =?iso-8859-1?Q?OfFGGbQjiRfjtUMc0/qoT1VC+EERF6xkymTFjSEuI+3xvv+skFkf43Es7Q?=
 =?iso-8859-1?Q?g4q5+mXfDj3A+nIIQ1oxw2dyZ+1PqfCEZkVX/PSf7WlegbXV3cZXK4I6Oa?=
 =?iso-8859-1?Q?Wg5yNSEFXJuwtolRPDujI2x/cdguODOrNU9mPoV1M6cBmEynN7WkgWUIiX?=
 =?iso-8859-1?Q?mqDbASW/tH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb51ea4-c96c-4518-7aa1-08d97931eec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:21.4768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24GHZcIhPQUoKVeQJrEFZaV5iBGdPSfPctHqWqp6Br6T+0ilZZehJFouc0YMingj2g5bBpLerQibkhVYJzfso6mjbRJSpDGl3H/fRiX6GXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Add the chip reset command to initialize the WILC chip before downloading
the firmware. Also, put the chip in wake-up mode so it is ready to receive
the firmware binary from the host.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/wlan.c    | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index f9256c1bad45..de5287cd8652 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1080,6 +1080,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, co=
nst u8 *buffer,
 	u32 addr, size, size2, blksz;
 	u8 *dma_buffer;
 	int ret =3D 0;
+	u32 reg =3D 0;
=20
 	blksz =3D BIT(12);
=20
@@ -1088,10 +1089,22 @@ int wilc_wlan_firmware_download(struct wilc *wilc, =
const u8 *buffer,
 		return -EIO;
=20
 	offset =3D 0;
+	pr_debug("%s: Downloading firmware size =3D %d\n", __func__, buffer_size)=
;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	reg &=3D ~BIT(10);
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	if (reg & BIT(10))
+		pr_err("%s: Failed to reset\n", __func__);
+
+	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
 	do {
 		addr =3D get_unaligned_le32(&buffer[offset]);
 		size =3D get_unaligned_le32(&buffer[offset + 4]);
-		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+		acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 		offset +=3D 8;
 		while (((int)size) && (offset < buffer_size)) {
 			if (size <=3D blksz)
@@ -1109,10 +1122,13 @@ int wilc_wlan_firmware_download(struct wilc *wilc, =
const u8 *buffer,
 			offset +=3D size2;
 			size -=3D size2;
 		}
-		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
=20
-		if (ret)
+		if (ret) {
+			pr_err("%s Bus error\n", __func__);
 			goto fail;
+		}
+		pr_debug("%s Offset =3D %d\n", __func__, offset);
 	} while (offset < buffer_size);
=20
 fail:
--=20
2.25.1
