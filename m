Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6737C3699AB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbhDWSab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3592 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbhDWSa2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202592; x=1650738592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S6AULILydVprhZ60aAOxzuDKn+3RyO50Oe2MNAOm5Bw=;
  b=TEzDqOriFXeSAZT2VT+PwrZZhkfY7iycsJNaQ5TkOQ67Xy9oyDxFTXoB
   lpdv/3er3LB4M8SfwBnUDJm6hQZ6cto5UnvBPA3BBUrLpeJ/XeSW929Xx
   Mcq0qq5JvS4ZNXGmGWAfHL9tXx9TThYDrI0++RLVVObWWyIe+ZR0jA63a
   j+Jm/J+qxqTjT8epLxitpLHeDlciB3Bp73q9wqyklySW8Mtc2P7fDOqOW
   h+TWRuKLZRxw3T2QlDBKOhjy+UAEI0+4nb6c0ocUBDPP0ryp+2yA3WgJP
   5QM0RpZytuRUX2JRys567sx/oV76KnT02zwVm66H/AY+5vTMwhznpeiS3
   A==;
IronPort-SDR: 8seebXZvxjaTIKb4ZtudqDIdzXSI8Iama+J9BalBlySkQqKhBBBtTTAOGee+k1i4a5sRqkDVLt
 CDjR7WCShRfq9X30v9KQV8wwsgJdXXYUdBy6SfKI2Rf4aDaY+QEsH7EergGpM9FkGI6Dwymyqo
 EQH/+9l6cgivJQXEtDYCqBVtZjX+l9IurnPn5azt4Ex2yQV/4OgZwjqXyXysPdpPzDvwp2B343
 2RiCbhR4poB2c2SOvvPwOThhHOBD8dNYe1Y4rAttRW1eizlD27btq6Jm0Ceccs5RKDxgw08fZL
 F5M=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="118174646"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 23 Apr 2021 11:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8yibjxErIMxGz/sfzDhJsco4U7g71RNvqi8fAfOnuDrVeO5Q5XjsNqp/FfunZw5gVTAaEfQWGnZr1bUBgxUlPSm6DpByf2IUH0ut56jqkZcU3o5tBCWTrH4rYyCGWr/yrsO833jd6U/ZGcAqna+nzc9sRaK2gFXnZgdXNEt0qc0hdNJc6uh++DHh+JxkUgzIMJhd9jXlSwAJA1eMlRPURvA2ksDGa3el7yXswnm7wxyA7K32yMsJJDGwRbQdJKrchm6ER2X69CsebT3nklPe/T+zrIn5/wHf5BjJNduTwzpxt7vTp02oTzPA734W69Ii1zTO5Wfta8X4NBsI5PTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmnVUDB5J2sOnmpgt1ij2uwNxGcIBPaz72bn9NM93kA=;
 b=TqzAQ9xjMiJtNbcQUL2T/vU4vFgF+PnmCwRkphbW+crKLNGKK780yFgG+hVbCJidXtrIGRAOJ7S1YDKHFEgpJaVA/ir12bP19qZVKJ52Ldcj9Rd8huweqBmI4IjYQvPbdmxOn334N8+P3Ontimh7dgUxH4Amf56rhFzdW25+DEc36vzfSa7hiGEXTkJi+s9an/KTeKEkv3iz5h+mPs0pINSAUUMDAFHF4Kzch2xiUjyNE+k4S7tpNvgM9fqRvytWFJB6d5uiMPIvr0wrrhQmsfkq7tycwHeKWPyoQs+lGU5tyHmXQE+DsF7Xp4iaWwhA4KCZqDAmqStcfftyfZu4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmnVUDB5J2sOnmpgt1ij2uwNxGcIBPaz72bn9NM93kA=;
 b=UDZdtETp3Eaiq1hHJdCov0gg7QBUgk12POqjUMswB0g0JNm0uoCMO0QjOqQBprHsRecB8GhBo6RprJJxRih2npskF+876pfkHacIzOgJSvru7V1sXOIDZ6b8jUHIgwBpyjICVLtz0lCKK//JLNJkeeNBuUcVsQQCAqTThSOj/1M=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:47 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:47 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 08/12] wilc1000: invoke chip reset register while FW download
Thread-Topic: [PATCH 08/12] wilc1000: invoke chip reset register while FW
 download
Thread-Index: AQHXOG6jlLzEUJ2GxEOXwEu7VmPRmA==
Date:   Fri, 23 Apr 2021 18:29:47 +0000
Message-ID: <20210423182925.5865-9-ajay.kathat@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8106f16c-ef96-4523-2fc0-08d90685c658
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33181B6B5FDD4B2534FB0BF2E3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /E8MChLCU/XG3d1Lso3J6l1tdt6iE9P7HcN1pe83H+wQxViHHHnb2jHd8EQeY9uSaSb3JfcFduMLvtTZRoLkfH2RDyuzNEoPZNQl5t1mgAqbEykYVFBL06ohcq2bnNqyaCGwfdCjRGRzaVH6GWVBuu75wTwX6TDf66BMdT7Ps6NP2J9CiH136hq+CSxdktKtyRkewaRVS9fvgX37FwWw3jqGLqO2x+QfUTpJLw1I16CvHfqVnteeq1NT/pgeDiYlaMb9iNNnoJBVt3A3VRrZWZ/5Mb08X90zRbOEKMq4/c/+fdc6pbup/omIgcA4PH/9uX9tM8KWglzbFLeM1jhpQt/GtcZVKs4pkZAYQfYfeHTlBLt61N729Oz7JnuIMqlwYocDJNUEpp9TDk1tH+6U7gSE9oLs3wwq5IFM5czf3HBeXTNg7zO4x9qIHhq3UCFdpXBC2h6cTavP2ICi05GyMrorW075H+UmTkVVIab50yiR9Fgz2BJXkuf5r85NUYTpDmVvg0x8Us1KhPM4430P1Rsqy3HZF2rssX5GZCZMaLBH6V/a1FeZOj77SFJlDHZdi6DIDMb8rZpWXJ7iq8pIDEV/ZCptOrmkFnbg9JlU3zE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?WrW22ydweTfsAf3yaetrcpMRFFfBZCxzpoeV/IC7iHKmDkC13XLCMECbJX?=
 =?iso-8859-1?Q?7YNbia475c/UQkNn/ldSX535WFxsfu5r1j2qnu+JGe8USR2jGRQRQV7q+j?=
 =?iso-8859-1?Q?jFxgV5ct2W9A9+cBLO3RUaOV4IT3Uo0fe6Alpwi2IBt5N5UFYIw91EOfwE?=
 =?iso-8859-1?Q?u61mjjUfkp5rzC2W9hzw7ehdtNS3kTtDaxtur1flOoMFbUxAVlZeckVr0O?=
 =?iso-8859-1?Q?LOKxY1fcn2b6kP1Sfd2fX04o/7ozgWBnls0Ok+WR9zE2GGpcQl5hRrHdHr?=
 =?iso-8859-1?Q?N212X/xYjty+fEYDxr2FVj+Q4loqubwXJIBkC6jX0J4gUeYSHKgoDWluiv?=
 =?iso-8859-1?Q?VblIiG1t0tvcuatgk+rQYoIVYfOAJ4PErDM8tIWu5CnvZ4Bv7iBgR6oty7?=
 =?iso-8859-1?Q?j8tSir1bDJOQ1B1dEg0GT58M7Hf/du8n8b0c4gTx07UYmSwT4AzYB9LpbE?=
 =?iso-8859-1?Q?NoeY7BdN1BcrG9nOKvK3QAH7RNwaNcX/jroSHylV0qnrLrEMAfeeh3gQ3V?=
 =?iso-8859-1?Q?VPzmkgZ2gg0hodNm8WfMCupnyLp3NQ52W5dg8a9lLqj5xdVasox0apAU+c?=
 =?iso-8859-1?Q?v7YWGhasascJFCvyXYiLfVGI5WetXQjNeW4y//76wUSdUFECCbzt0rcZyp?=
 =?iso-8859-1?Q?M0vqcZdcljm+xAhPYWSIlvM2gSgp62VtAE2ccfGWUriXxDN9WFw5o90WgW?=
 =?iso-8859-1?Q?DYjAgrDFcPvd/hJR3nRFD3yv4IQwaR76QG3c2C6YHJ1VnpjHQbxxQ/luRD?=
 =?iso-8859-1?Q?G2RRz6r8wk6HKT7Y6bA5BNtbC2C66e1KME7u8kOWh0gG9RKBiOtqZ3WwR9?=
 =?iso-8859-1?Q?VctthWJ67V2Kgr+Mn8k/XKotCd7R0dLV6cjIVg/n4kMBb1Bnrvl/NEj+vm?=
 =?iso-8859-1?Q?wjZgM75n2nGDlB0bc09SeMHeNAKasLwj2boJkzLHGYx3VjCLwcqjFc4cyl?=
 =?iso-8859-1?Q?yIDY0OdETwn425cbIEn65lTsOUl4BVrkNj44QOSpB0ub2GcrXHIWwTo2Mh?=
 =?iso-8859-1?Q?90OG7acpJCgfF8l4h0liluKukmb68b08tUN/wrUHNMpB2J0B5le7edV2KL?=
 =?iso-8859-1?Q?beDYkn0Buut+Mdt9ysCNqGFjzdcQrXSnCMK9Cchk/FJKp1XJntwmrX3aKR?=
 =?iso-8859-1?Q?dA854olxQ42HuVdvyx1fovl4HVPLvKHhqJI72gHmsp9JyyN6WahjSGVDtE?=
 =?iso-8859-1?Q?ki7CecJbYSEIDX2jptITRmzaOPSV0SilAiG4SM1gg8stmL2N5nE/QjZdMC?=
 =?iso-8859-1?Q?xJXa8I08yZ5Fa+MzQSiZjAheiYwwUXf33NBj9v6EhjZnbZxOV15/BXTpP/?=
 =?iso-8859-1?Q?7jna4E/uLri73xcREPwZbDemk6F+p0RaKTbTJOG6rIxeua7b7NksxJuEok?=
 =?iso-8859-1?Q?LLXx5SSkQBKAsjTe2dD0B0AspZTsIuSg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8106f16c-ef96-4523-2fc0-08d90685c658
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:47.6566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWrmlRPWeEhi1a1EX36tAK+CtQWERBpFpAr3k8nBza+SmLgfooXjCcRstaQt6rWPqRwwDa3xdn3SgLJbzIsDXubpNyffCqO396geY5iqUf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added chip-reset command before firmware download to initialize the
chip. Also configure chip in wake state, ready to accept the FW
binary.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/wlan.c    | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 9f0bb876975a..24e016a0dfa8 100644
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
+	pr_info("%s: Downloading firmware size =3D %d\n", __func__, buffer_size);
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
+		pr_info("%s Offset =3D %d\n", __func__, offset);
 	} while (offset < buffer_size);
=20
 fail:
--=20
2.24.0
