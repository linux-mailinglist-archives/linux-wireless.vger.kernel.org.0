Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AB15D6E4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgBNLwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:25 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:42590 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgBNLwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:24 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 3L+dZ3C5tl2s9MBSYm3YU8Nj+bUbyzzWQ11HsEGZdp6N9x0uWltgMfmjG/0lmxPlIz2WYy/oEY
 eXB7ZQA8DleC36v7NV2kygMpqQTn8w5jsC1EaAoCnOyC8YrzFqKTC/VkSMkeAm8uMnS/qKlsFy
 EDa5l8EuX/8B7295aM9lZGldrQFQAgQc2O1rD/9+9N1XbGcAlM7WSftGwWVE2oqdX7Dm8NYo7C
 KeREkv3fmuSppEX6MJ7E2JDdWA3EGaf0SRBVdi1/s0n5k9kLYOXUU1uFE8lOxywCwTCE2Hpznz
 4OQ=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="65913231"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic8rgLe7FULVYkZswnqSILoakekcgY9I9IPXDyHlRJLx6PsfLRjkRaP+Ba5LLoX8fULugwYaHb9sHZI+RNt+YzFhB77uKmLzx82ltJ8z8vJKpHqrg2h+lza0gqVIDHhAhw3IVeFFFORBPxmtIhmdDAd4023/cD7f3JYk2rPkTCIpxSUUcvPfNqkjs+Zg9NeeRrJ41O6dVX+2p3kqBvxBLuk+pgCn4dkDZDdiBpjf7KNF1MS28NX2frG+zuKIgGcu84xUSmshHApIMtGroBHFFWSGH5iheMeDhriQC0ynwEHw+x9EML/P5Q+U7htt6mgo80Lo6uxgmGNeaDWLKhGnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtVr42Go0BYLzbFSjwNuCLwJedypOsoN7S1WRLUJvaY=;
 b=PCWrjlm8PzNofAtHzciZ7WQGL077u2Ep95QXfza8XP6YTAz3SfyhW5gOBd17qABbJRe+xrYkyfrIwU6TSMUAnEjLZLMp2Dc0/hHQ8f6D8DkaCKqUFd0DMN1qp4buxrjGf0FZ+6M8QOsAPS5yHKbGQyxGVW6AqqAjYuRCl998V51IRmQRWUi7DaXMuvHUenY5vFwQTSpS1h+DpAScMQitZO5fk7iYZ2XxvrMVH4SRKOfb9sQukgJliMHgrKzgOnpYvHWL63qpffvFTRSulqCul9or0xFh+szmsL+FT0cdx+V+cl0wAavTQ/vpQDTXiqEVmhLFV99KVSyLUjWJcrvCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtVr42Go0BYLzbFSjwNuCLwJedypOsoN7S1WRLUJvaY=;
 b=P+p9nHQdjf6apN86w/DR0di5ANmV8i/s/cztmL3FhgL4g+RZDeLZQK7H+TPPB9PWLHQN8Qm6ZyCgfvLG0KoSLX9qi4deeAi8YvQtP4DO85k75OdWDBQYyr2BT00HVb5xWKQTLW7MXFnKtv1b4EbefhMjcwtayQcxfrk25w5nvng=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:19 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/8] staging: wilc1000: make use of ALIGN macro
Thread-Topic: [PATCH 4/8] staging: wilc1000: make use of ALIGN macro
Thread-Index: AQHV4y01fyqHwhyg7Ee2FuDOZILgyA==
Date:   Fri, 14 Feb 2020 11:52:18 +0000
Message-ID: <20200214172250.13026-5-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31369809-175a-45bc-2f8d-08d7b1445818
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1652C0106BFF439FF57505A8E3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lQ9l//zY2k9uI5Bhj1wyFU/t5z/fSBQr3MsNTA8EuIPoNz8T68L+7oFSye9BoYOcewFxLaXnLqjZsDqJQVkcPCBLxIfrwSCk3l7SARpSIlEoT3kP1S4HCPpwTIknONEKcUcwNjS1+wRC2rDVk3frhY8g/aso7b5lS3pnctNF6mrxhlOCmBnbfbRl5RP7xqm9qAlR8S66mYffrqEahMsQtIdbrzlZd+agDRliBEO1YuJp0u6POmwb+ZwUKF2OYCmOu7jxDsv17VqolbrVz/lCdES622KBvmrL/1IkX9EtK/fUZyFwYCxjXPIpFLIeomtEsqQCXv7YSq191NhbAn1oQskNdk4w9LYPd1mHwk/LRaZy5GTDDcnKb3cO02b9tLvfcHwbhcLd7KTba13B27m7LypqgGkW4K0wlSQJHaUZhGq2gkmYrrWm44S6LgKQQa6
x-ms-exchange-antispam-messagedata: 2rEK5mOJpwXol8fCpKOy0sOcGsZWFKN8nPemKZVofUD7tKpzE1mIXMtJa18V52lp9nqPdTleL0ELWZty/4lqtwCdDNJ2Am4to8AC9kPzhpKcs7XyrS77WbCDODEMIYIhDoVvC+NP3PefL8P1/uVQ5Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31369809-175a-45bc-2f8d-08d7b1445818
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:18.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SF1LmBZuBoOivnTZAbsW+XXhU8GuQFF44TXV0o1EUzjazh048I0UMIxLIgTd2dJnKhKsPTSeWkKVpu2r/L90qGNb5iytUPIbuQU1K4/pJGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Make use of 'ALIGN' macro to align the size data value.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/sdio.c | 34 ++-------------------------------
 drivers/staging/wilc1000/wlan.c |  4 +---
 2 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 66706efc5711..212affc4b9c1 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -415,28 +415,12 @@ static int wilc_sdio_write(struct wilc *wilc, u32 add=
r, u8 *buf, u32 size)
=20
 	cmd.read_write =3D 1;
 	if (addr > 0) {
-		/**
-		 *      has to be word aligned...
-		 **/
-		if (size & 0x3) {
-			size +=3D 4;
-			size &=3D ~0x3;
-		}
-
 		/**
 		 *      func 0 access
 		 **/
 		cmd.function =3D 0;
 		cmd.address =3D 0x10f;
 	} else {
-		/**
-		 *      has to be word aligned...
-		 **/
-		if (size & 0x3) {
-			size +=3D 4;
-			size &=3D ~0x3;
-		}
-
 		/**
 		 *      func 1 access
 		 **/
@@ -444,6 +428,7 @@ static int wilc_sdio_write(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
 		cmd.address =3D 0;
 	}
=20
+	size =3D ALIGN(size, 4);
 	nblk =3D size / block_size;
 	nleft =3D size % block_size;
=20
@@ -551,28 +536,12 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr=
, u8 *buf, u32 size)
=20
 	cmd.read_write =3D 0;
 	if (addr > 0) {
-		/**
-		 *      has to be word aligned...
-		 **/
-		if (size & 0x3) {
-			size +=3D 4;
-			size &=3D ~0x3;
-		}
-
 		/**
 		 *      func 0 access
 		 **/
 		cmd.function =3D 0;
 		cmd.address =3D 0x10f;
 	} else {
-		/**
-		 *      has to be word aligned...
-		 **/
-		if (size & 0x3) {
-			size +=3D 4;
-			size &=3D ~0x3;
-		}
-
 		/**
 		 *      func 1 access
 		 **/
@@ -580,6 +549,7 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, =
u8 *buf, u32 size)
 		cmd.address =3D 0;
 	}
=20
+	size =3D ALIGN(size, 4);
 	nblk =3D size / block_size;
 	nleft =3D size % block_size;
=20
diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index 9dfabd1af4e7..db4ef175ccee 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -508,9 +508,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 			vmm_sz =3D HOST_HDR_OFFSET;
=20
 		vmm_sz +=3D tqe->buffer_size;
-
-		if (vmm_sz & 0x3)
-			vmm_sz =3D (vmm_sz + 4) & ~0x3;
+		vmm_sz =3D ALIGN(vmm_sz, 4);
=20
 		if ((sum + vmm_sz) > WILC_TX_BUFF_SIZE)
 			break;
--=20
2.24.0
