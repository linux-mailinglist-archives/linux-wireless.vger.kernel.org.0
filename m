Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD44415D6E1
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBNLwY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:24 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38153 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgBNLwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:24 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VejlnREsMaibfsPd9byep8m8rUuHUZKHajWpCY0PNatqhcgNqfgsjhQLlBlG4u8F+HC0UbtmD5
 s056LuLGH0DVOAfDSDLFbB9REThOhi0DUR03RxWq6KaOIw73BtEYdCGo5igvAb4lMXc/DsvmAs
 DCmlxB8SdNSnRRtR8Y6W5n3d/GHlbuCsv3YzgbUGLBvDx78vuqm3CDCm9sv+qZv3GJLcHUPM5+
 lfeFfGJCUmtt+ENxqvDW1Xis+6yPbuLqL0h4ZHlJiJpI3zTgbIW5VO9B/rrS4cyGcixhpfYVNu
 Ln8=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="2407498"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/62RKRkxSJxThalYSTQ0PkHYenEoB6XfG6lcBj1nrGd0qo51oE3jSmFfda1W/s3020rlrKBxe6sq2hIppRSSr2tAQSx4IOSc7cOX31cx8Ny2orysT8UuvcRb+v9n2IxtVjXXYitEkmp/mdcmEG5btx1ehTKJFCZReirQOFODtARzqcv9mKxPRlYpH1BR+ksuLVCWdoel9csjeylX17F/PbdjsQfquUEZJIWap+qZaSlt010aThuxOGrNjt10+MLLwSyxC0ZyvnPkS5/kVJ6WhrsC7qeaY3qLmU42ZakleK51p83csp6nxJEDm+3nk/XoRsAS9LLKb5/oo5FgBV1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZB9xt5EMqgliNQU4hwMcuTiop27heqZSAUa5xhfOPQ=;
 b=TIUoyKF1SYll3TAg0Uu2sOuA/l38HfeBs/IpPC1cX87ysF5GgajPRZz5f56pPKdqWPJF9LvezRdCa2CbloObtJtH7v7JV6RJ7AyJA3nrDaP6Ej1OpjFz1Fx+AKXbLg/96V0FpjB5NvZJi6lvhacLWpnKJE5+2qnTl6UC/+IVDEzt1yw6ng+F0WRHymLv/JVyJgGeWCGzJTH4fCC+TRfAy8p9XVMvkAC4F2nZCWG6Yt/NGr//mAHO08LeiZ7DOCiDYdn/9g8gOjydvnMUart0a/ZSutplwkuCnQ2jYazBgb1juPgbp+0zsVpZJvnTgfGcBpi7wK8NcAPbCb0+6TVq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZB9xt5EMqgliNQU4hwMcuTiop27heqZSAUa5xhfOPQ=;
 b=s8yrRqQ3SkN+tBzv91+UhKLm6h+Ko3EnE702aofC9PreemCOX11gGmMy8Ns3LLhwnxzY7fjO9t3zUJche+KSB4STdMcUkvaUPGTnHKJiVf2zYWazKQEy1HyqFrrFxud9FBmwsFcP7M3Etzmbg3LASa1T5ZuqpobtJG2e3lmEXKM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:16 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:16 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/8] staging: wilc1000: remove use of MAX_NUN_INT_THRPT_ENH2
 macro
Thread-Topic: [PATCH 2/8] staging: wilc1000: remove use of
 MAX_NUN_INT_THRPT_ENH2 macro
Thread-Index: AQHV4y00V2/iVypneE+qm9kUF2X10g==
Date:   Fri, 14 Feb 2020 11:52:16 +0000
Message-ID: <20200214172250.13026-3-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3487434-8847-45cc-e634-08d7b14456b0
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1652C0A72267EB421FB6ADE6E3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHIMfoATzo5zQRGe+U+puhQwET2ow8HouKEPpt6xA4mN/yjj0bLKuobISJxwJWeo6Bi85UNmsx66zsFPyKkL1+bRAdgORbIQQ0fVODdBTewnHq+tCSD6yvBieMRcRz0UkS9uDxY2OZs8Se2be+pRxgHdR65pmbv02TQBv0niE8xVkXwpDXTlTeQL1BRWjv7Nb88BOiZwNWcmhsaiPw8d1kvaV/bgejrVjaPDMZv+36wd681/eqhY0Bg/k+0hgrUY5TtGiv7XEiQfIkDsijwn9qT4WZv67LCgnOEG0zxnEeOOYLY5sCEW7ztIZjKCD6UT/Hw9GsgC4HVjJvEENRu+Kn+11R8123I3fKUVUSK5oyDoIjSBtz5wmDDvUewrX2+w2fGP0iqUYHq9F4m2IBQE1oDViCUntMYLaAkxiQJ12qruHGSzOqBgAbQX8VBRKFPj
x-ms-exchange-antispam-messagedata: x8DNRfJJAbUmf7f2K7dLyxhDHSF4wW4jIxNXG9OVr8Vh68SUMD0/fvi6MoxGAJnj0gaGWyKi1ePI/CD6Ka4t2EwEg95SeI1CRQNSKpCYfA3e7/jCRA1i2lbYwkT1qIyBs5qfCVqOollALQpvfe6HQg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3487434-8847-45cc-e634-08d7b14456b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:16.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTtMRU/X8rP/WZv1GwqSGY5Y0cL5fTVJe+W8qCDL+4u8MRJNYsG1Wby4SvQiOcSEp2VbnsJMSBoJR8R8YGarooeqwBaIaRtepwCyw79SV8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Make use of MAX_NUM_INT existing macro to handle the maximum supported
interrupts count and removed MAX_NUN_INT_THRPT_ENH2 macro.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/sdio.c | 20 +++-----------------
 drivers/staging/wilc1000/wlan.h |  2 +-
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index ca99335687c4..77ef84f9cc37 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -27,8 +27,6 @@ struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
 	int nint;
-/* Max num interrupts allowed in registers 0xf7, 0xf8 */
-#define MAX_NUN_INT_THRPT_ENH2 (5)
 	int has_thrpt_enh3;
 };
=20
@@ -818,8 +816,6 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *i=
nt_status)
 			tmp |=3D INT_3;
 		if (cmd.data & BIT(5))
 			tmp |=3D INT_4;
-		if (cmd.data & BIT(6))
-			tmp |=3D INT_5;
 		for (i =3D sdio_priv->nint; i < MAX_NUM_INT; i++) {
 			if ((tmp >> (IRG_FLAGS_OFFSET + i)) & 0x1) {
 				dev_err(&func->dev,
@@ -854,16 +850,11 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc,=
 u32 val)
 	int vmm_ctl;
=20
 	if (sdio_priv->has_thrpt_enh3) {
-		u32 reg;
+		u32 reg =3D 0;
=20
-		if (sdio_priv->irq_gpio) {
-			u32 flags;
+		if (sdio_priv->irq_gpio)
+			reg =3D val & (BIT(MAX_NUM_INT) - 1);
=20
-			flags =3D val & (BIT(MAX_NUN_INT_THRPT_ENH2) - 1);
-			reg =3D flags;
-		} else {
-			reg =3D 0;
-		}
 		/* select VMM table 0 */
 		if (val & SEL_VMM_TBL0)
 			reg |=3D BIT(5);
@@ -975,11 +966,6 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int n=
int)
 		dev_err(&func->dev, "Too many interrupts (%d)...\n", nint);
 		return -EINVAL;
 	}
-	if (nint > MAX_NUN_INT_THRPT_ENH2) {
-		dev_err(&func->dev,
-			"Cannot support more than 5 interrupts when has_thrpt_enh2=3D1.\n");
-		return -EINVAL;
-	}
=20
 	sdio_priv->nint =3D nint;
=20
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index d3e822c374eb..876b02e93a81 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -175,7 +175,7 @@
 #define INT_3			BIT(IRG_FLAGS_OFFSET + 3)
 #define INT_4			BIT(IRG_FLAGS_OFFSET + 4)
 #define INT_5			BIT(IRG_FLAGS_OFFSET + 5)
-#define MAX_NUM_INT		6
+#define MAX_NUM_INT		5
=20
 /*******************************************/
 /*        E0 and later Interrupt flags.    */
--=20
2.24.0
