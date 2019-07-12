Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0B66397
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfGLB7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:35 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24969 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfGLB7e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:34 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: rARkY7DuTjL1qZwNJ6gj2SiAqUYjDgMjQ+cr0Tl5iaOBriDuWysHP7W+hu7rnkNZyAmjVHR+kV
 HHcE8IkYGN6aQMWguDQPz0xL4N11Tu95QA+//3VwQ7MoXF3Eo5YKwHvOiSAaj/dvtBvGiNPn4F
 CCWTub1Vx+BbvRix1JVtkb0ydsnSjTeVmX6nzSeG8BWpMU7WJT/Yxj+xB4n6XcyL+GOvixlhWG
 M1RcQw00vFkdEtu/Mtpmk4N/YFNR/e9YEOphH2aWCDIDLdbwgu8rajqz0FCqPsalrw3jUqtORb
 VmU=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="37967488"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jul 2019 18:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWWNmseZ9Yf7WxoaV9PuuDuob/j9xCkRMo9ZEz0EEuNxMSWzlA7QbODh3P68pJKb2skFc73V69hnwWbergS3t91770sQ5tC57EXzfVg3k1+Q/b014lcKVKPzOw/2Vjh+7FZW6gK8WqlNh5Dbs6fBy0BjY0Vfv100zpAqKpBKK0hru0HhGsEL0f00XsPTxJKTU2z/YKrXggSc1VlxEdIV0lip99Jpm+2iO5AyISLAu5pps+drJSWIesJtYHyyQPpFMKQ4sgUCkXer1SqccNkOrWIUJwEwkVV4CzWLKkb59KG4Wpt0brG8fW4f5qHJje3Iurzlgrsm5da60ewGrInMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4ImsrsjI5q3T6kpKzgUx+dAympGzzrCuc6cpgFOuTI=;
 b=E3UeJo3o+2ZFmaPMcVMA2TOvmApQ0QNoVLeH3oLmaMiPJXFz5mwwinmcvu3POi+XUbiRI+sESxfTBMrxmlI5niiuS73CRKZZpsLGrD2Eri309tVpWo9UN2mggaN6Cs2UJNuO+bCS5E6QIQ/6NirQRHppM0KYXaZe4vZyoxbLTj/GXCO7rJrMZbZrSM304kSB4oUssOT19L2yWJkUJXu1SFSZQXBKRXpxieSYmEwCIosHEHS89AX1KUMuyXXq1/uoYHksZSWNHAQXA32+OROmhdmME3wpaU7ePeBaaQG7MfymaB7bMhMnDmHVy4MiBi2NBy4PxzIk/hPX8jOEmLS/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4ImsrsjI5q3T6kpKzgUx+dAympGzzrCuc6cpgFOuTI=;
 b=xCJ0Ktm70ChZkJRNy4HHsG9pHhYRQExeoMzEFEkyyhk1o6KPM35aPL6coLoJ2FwniUoMXDJtH/zg6LXwUPyBWk8cTdtchk+LKqS+MxvcSoRZRpxclFCdlKTkvOXhS7sYorFn2MMr6Jr3f4akceFuTnxa4qbD2MeU2Ys6kCNRHl4=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:31 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 15/16] wilc1000: updated DT device binding for wilc1000
 device
Thread-Topic: [PATCH v2 15/16] wilc1000: updated DT device binding for
 wilc1000 device
Thread-Index: AQHVOFVxKWfKHJyJdE2vWK+8PTM7Yw==
Date:   Fri, 12 Jul 2019 01:59:31 +0000
Message-ID: <1562896697-8002-16-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7314833d-adea-43fb-d242-08d7066c942e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB142568D8B26A85C75BC7C456E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(5640700003)(107886003)(68736007)(99286004)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(3846002)(8936002)(305945005)(81166006)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lfK1pp7eWQNJd4+skp7DVObjsIRqpmI0yc1KoAdxcAA3Cahjl8FpSIsoRtn7bpPK5c8UaYTLG8CVJs4YxY8+/7djYzwlp+SSp3rUwS97iU16jIlv7lpvqW1zWTHxzlxhD2H3n+lC5mgy13Z1r+PszUjUsqZV8HSIA9gcusij/ddGRVdgs5OpKVBZQq5WnHhUZRRB4v7uDhVGxOEIu6QUKvIQNsVz5BTqZ4/zexfyEhC1CUeFG7rEeanjhqGP/Fi6UVHoTQ82BfVLM5IGpv8icpbLr7x2kY5BivBzd4E9lp1t/gqC8vEB7/rNYNW0NIWlcvO/wCm08V2HtaUfohPem89eRSOFA8EQVa217KGLn7Rg8KuuWNKyKlhrAGpJ8kJldXqis4fwg+p0+Y6k22U+SXNt1wZRMnoNkdtlktlLHZU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7314833d-adea-43fb-d242-08d7066c942e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:31.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved the device tree binding document from '/driver/staging/wilc1000/'
to '/Documentation/devicetree/bindings/net/wireless/' folder.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../devicetree/bindings/net/wireless}/microchip,wilc1000,sdio.txt         =
| 0
 .../devicetree/bindings/net/wireless}/microchip,wilc1000,spi.txt          =
| 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename {drivers/staging/wilc1000 =3D> Documentation/devicetree/bindings/ne=
t/wireless}/microchip,wilc1000,sdio.txt (100%)
 rename {drivers/staging/wilc1000 =3D> Documentation/devicetree/bindings/ne=
t/wireless}/microchip,wilc1000,spi.txt (100%)

diff --git a/drivers/staging/wilc1000/microchip,wilc1000,sdio.txt b/Documen=
tation/devicetree/bindings/net/wireless/microchip,wilc1000,sdio.txt
similarity index 100%
rename from drivers/staging/wilc1000/microchip,wilc1000,sdio.txt
rename to Documentation/devicetree/bindings/net/wireless/microchip,wilc1000=
,sdio.txt
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,spi.txt b/Document=
ation/devicetree/bindings/net/wireless/microchip,wilc1000,spi.txt
similarity index 100%
rename from drivers/staging/wilc1000/microchip,wilc1000,spi.txt
rename to Documentation/devicetree/bindings/net/wireless/microchip,wilc1000=
,spi.txt
--=20
2.7.4

