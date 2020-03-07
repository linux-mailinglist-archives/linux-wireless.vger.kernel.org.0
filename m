Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5299817CD09
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2020 09:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgCGIze (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Mar 2020 03:55:34 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:31347 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCGIze (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Mar 2020 03:55:34 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ukKVGbj52NZLT3D5fZX05oYbBD8u6hbH3AO6HfH+k6xwFeU8CBzekcEAZ02j94MhbFDBNtTaYJ
 ZTRqwa1MLEh0szgD3TMyaOuKaxpBNQX+4ph20e5KygWLt6Fi4NPL9IX5m7Y97ryl6LgkvUOnkE
 bw5qSdIquNt0VVwgYWidrCUhpSJ+0jaq1bE2Z+45072ckAVakPUgrp1nCVty/6oDp4Jt4MG3fB
 PTnFuj53Hfxr+0t1Z/xdJ4Bh0MQag7vNK2wzT5WQua3K6rTlO+GciRg1C0NLEmupmhrlcH3VQe
 rKA=
X-IronPort-AV: E=Sophos;i="5.70,525,1574146800"; 
   d="scan'208";a="71169247"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2020 01:55:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 7 Mar 2020 01:55:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 7 Mar 2020 01:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCbH8olpRMz0Be+Iw5EkHjTCi2w47pkRx9s41qUSMhbShGUW8oEyUtVDtLPn2WLthx4/KyWOcpHHNpZ26NUJFOgIjzZlLE40Ntps8TZ6rlKaW24t9ZEvH6SxzOdknosRazEbPGnacEFqDnVFnhg2vXqnel0hAZ43Xg7byEVWiQbNMfOOxTTmACbbLnfY00Tb1fX0x1HT2/fp/d+OZGoQ0tRItVod+2nRHb4hPrRqzRKV23klDnMtsc5LDJ/T0vLWX9RdVD+GY4XCI24UYsAoJJHymNJJI7D+wACpFdI5RYchbnqxATMOaJC9KeWudGfKgYgOBn6s8TU2fl4q497fqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVM+Gi5j5G6Kb7R96S8HRpvYQtrEpmFlHPHqmkIimGM=;
 b=U36M1u0X/TlcO5Y5vrIhdWc830V82LjB7IUPLJGXQIlMZnwUjErGCbTJDDHWhRsg0K79+1BXT5RaYz2zpGuvX9d5m7fDtVO/rf0FcHkl4ev+bzqjMyrMM509uFURk3WEYGvL73tVbpEojTT6W+2bsyDZBkPzHH2rkYf5pCs44BQQmscG2+KByQIh72vMDNDDsVHJf4UEljrwJXE0J3gf4T05UxS5FnizdVLYlnNZLDDeqLE8hser2DWVdRa1gqTtl/WkfXy2v78LNC2IK32s6L15OJJYssURqx0aBLy72vsdGugfRtlZBPW1d7W3ZG37pjanTU7rhQx/g44bkkK6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVM+Gi5j5G6Kb7R96S8HRpvYQtrEpmFlHPHqmkIimGM=;
 b=frHqcSzQO6joTPglzeiKzyEp1089QnaNKHiX1beubY3Y7lZuMWNuRDCY7sn/vYrqaxsvTh5VEbImIWnfqQEVfZ41X/v3HkUjW9JLWtMtENfkSL7YgEBY0IEPiZviD323KvB78LIbUtOpRZJ9itBb+PzTCQbntxsGVKVI7XaugtQ=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1601.namprd11.prod.outlook.com (2603:10b6:405:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Sat, 7 Mar
 2020 08:55:31 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd%6]) with mapi id 15.20.2793.013; Sat, 7 Mar 2020
 08:55:30 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <johannes@sipsolutions.net>, <robh@kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 2/3] staging: wilc1000: modified 'clock-names' and
 'compatible' property
Thread-Topic: [PATCH v2 2/3] staging: wilc1000: modified 'clock-names' and
 'compatible' property
Thread-Index: AQHV9F4m8ruX887ZGkGOIwVNaJO76A==
Date:   Sat, 7 Mar 2020 08:55:29 +0000
Message-ID: <20200307085523.7320-3-ajay.kathat@microchip.com>
References: <20200307085523.7320-1-ajay.kathat@microchip.com>
In-Reply-To: <20200307085523.7320-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.205.217.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0b60371-867d-4326-5c77-08d7c2754a11
x-ms-traffictypediagnostic: BN6PR11MB1601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16019CD2BEBCDF90E4E2A2BDE3E00@BN6PR11MB1601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(76116006)(66446008)(66946007)(91956017)(66556008)(5660300002)(64756008)(66476007)(36756003)(71200400001)(478600001)(6486002)(6506007)(2616005)(54906003)(4326008)(26005)(107886003)(86362001)(316002)(6512007)(1076003)(81156014)(81166006)(8936002)(186003)(6916009)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1601;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nm4zC/ld3ZbXD7Mhz6ByxnJOUrFZl8GZAZf2jekfscLyzKWGx7HRTztxGqIudvWrdsWJL1hqAIWiR3sAdoqG+oOCt31RCAR6BHSl1zvXIb4uIc/SuJJKXDu3biiQLHHM/6QKG2rYY6xeBtyYunmrtoWobZiiISQtNEfWABIKmbzHaGRJWwDc/zbUYrfngeEabFJ7gfJvc+cjsBG9Y63Csnda1IXuO+a/vaQUN/0M8HkYL6pV3y8wpL7UTahoijfeDgXHADdft7BJYT5xD3cx2522mf+EYZc1R2lC+YjoX41vvmFE14mQBl+2uBjAkf6G1qD7QZhSiE4+FhpvzqjasvqxPMZTOoEApmO2UvL31cgpcDxKV+fHkyES8ueUthdYTYpyCAGDYEJG7pTilMa/5VFwKAzBPjqrMoC0c2CRQyC3iLLKCELj8MkWm73h1lsC
x-ms-exchange-antispam-messagedata: WYrSa363oOEuvyXQ/gMdh1kSHskY5WHiQqpC06oZELg2YX5sj1O4ofI/snXcdbVmiiDG/aSMALCf2c9aiivBbxrrh39k7iRDcyl/LjwTUNyfFqejsbi0wUB2iEdbUJ5ZP5fBHuMyfMnAXQ2sKaeP/Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b60371-867d-4326-5c77-08d7c2754a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 08:55:30.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOeXT1VG6s/os/C/Mtei79HN1ZTufIPYr9KRgb+v66SOIbc3SRUyBzx1bVKCtJdNJd2PftW89lkFBV/WYm4eUs/MUcBo+qXlw0W7zFHqRos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1601
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Modified the 'clock-names' property by removing '_clk' from its name and
remove '_spi/sdio' from 'compatible' string.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/sdio.c | 4 ++--
 drivers/staging/wilc1000/spi.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 44b426874c1b..36eb589263bf 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -150,7 +150,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	wilc->bus_data =3D sdio_priv;
 	wilc->dev =3D &func->dev;
=20
-	wilc->rtc_clk =3D devm_clk_get(&func->card->dev, "rtc_clk");
+	wilc->rtc_clk =3D devm_clk_get(&func->card->dev, "rtc");
 	if (PTR_ERR_OR_ZERO(wilc->rtc_clk) =3D=3D -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 	else if (!IS_ERR(wilc->rtc_clk))
@@ -997,7 +997,7 @@ static int wilc_sdio_resume(struct device *dev)
 }
=20
 static const struct of_device_id wilc_of_match[] =3D {
-	{ .compatible =3D "microchip,wilc1000-sdio", },
+	{ .compatible =3D "microchip,wilc1000", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, wilc_of_match);
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 852f318a86f0..d77582c55326 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -189,7 +189,7 @@ static int wilc_bus_remove(struct spi_device *spi)
 }
=20
 static const struct of_device_id wilc_of_match[] =3D {
-	{ .compatible =3D "microchip,wilc1000-spi", },
+	{ .compatible =3D "microchip,wilc1000", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, wilc_of_match);
--=20
2.24.0
