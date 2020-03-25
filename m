Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D16192E7F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 17:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCYQnW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 12:43:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:39336 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCYQnV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 12:43:21 -0400
IronPort-SDR: sQZvq5uZVz/OoMHuLXf8Gpmq7Cr3qV41TCuQO7sMKN5j4lE8pVy45N94ddCXZzJjlJnkNc+VCF
 ae1I6Aod9594MUqQyS6nv5xhdyVLnR5Qq+NOnnFjuEwjMUXrY0fDwfJDKFgVnwM/VA0wHoGYGk
 S7R7VzrzOg6jmDZOA8M0ZR0pxXd0hWhTIgzMT5uhcIQNDH2zfzqRaAHiJVFmTaHhCmB/gkusaz
 M1EmtRhh8TeouIxUSdrQJzCRO/9MY238z+Szplh44mZcLkFf6F1od0vdVd8QcUpPriPDp7B931
 3ZQ=
X-IronPort-AV: E=Sophos;i="5.72,304,1580799600"; 
   d="scan'208";a="70239578"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Mar 2020 09:42:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Mar 2020 09:42:41 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 09:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO9ZqKF4KURE5zF6Bm2X5kn6rVKKI6tLM05dS/pBwTuIDwTdHXNQrde0XNxAt8oHU4ak9sJ4DFSk9ZmMy3nM6JbdtMfds26iJW3sfPn7g9hUEU2vBnsJ8+5asZXrMacYBMziIs7nzg6Ju79fMmiFQlfbNwByRSl4DcYaAkf4jXbIbOi8yRm7S0WCFS0PcG2Tyq958SYmukq4zvV3aVSxcrfPlIhx3LR3lyqLjwbj6YUS1Zl3MMQ5JxAxkNLDur1uq2L0gkTDhQbF4i76lZbzzxI7a9UufnniumOuVEL8fyrdwy2p5FW1np+nNji6VcNGH28+vI4CVSD8uEDOoEPkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT3CsVR4E9E+u/GrfhYjmpDfy8anWjoMFN9X0xSjmpg=;
 b=Y7kvRfRqj9XD6WamcO/BCkUY3myuwYV0+EcBDLg5OoKnVAoKrqswj/ELH4MiS5r44Uycsk8QFUlCXbctrSX1/9uaIxSVADeLRzi8p4y78FjNMDs84fHVVKB9YaisSKikX3hmZIuScoe9gfFS3riIEcoW3tvYmNpahWiuQNhRu0sYe6LWuIfw1FwsId+CGveTICufX525PD+TWX5QAaXuvWEjdAFki6L1sTr1K2Yj4Wu/B3OJ/x0/xwCi2RFI7iHTKTvRUnwNVJTybAPT/5HlkBFbr9Jt7rWemoDyDqrHwZdyvPnA7vZVwwlG36M5pNAhLcOAC2Y4RFtdQWtgAv+tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT3CsVR4E9E+u/GrfhYjmpDfy8anWjoMFN9X0xSjmpg=;
 b=c63CxU8XRUWLjAtBz9HpNdak1CtUKuBwtSOCGq2TcjVV/bwXtFyDkJCEK/3rb92nDiWBEOGKnh/kwN7AZ21ilJWrI6FECbcDJtuogRr01aGGBcM5lEz6Q79R6wJ+P+9vJF6LMliK/aufF3WSmedn0G/zZowlCb7xlvgGo77iask=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2597.namprd11.prod.outlook.com (2603:10b6:a02:c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 16:42:39 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 16:42:39 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <johannes@sipsolutions.net>, <robh@kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] staging: wilc1000: remove label from examples in DT binding
 documentation
Thread-Topic: [PATCH] staging: wilc1000: remove label from examples in DT
 binding documentation
Thread-Index: AQHWAsRltX69oPURgUSNLfUw6CPRaw==
Date:   Wed, 25 Mar 2020 16:42:39 +0000
Message-ID: <20200325164234.14146-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [49.205.216.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9270d9d6-79c6-416c-c331-08d7d0db87d6
x-ms-traffictypediagnostic: BYAPR11MB2597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25972B9827CC12AD979C403DE3CE0@BYAPR11MB2597.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(8676002)(966005)(6486002)(6512007)(6506007)(6916009)(2616005)(54906003)(1076003)(86362001)(66446008)(91956017)(36756003)(66946007)(2906002)(5660300002)(4326008)(81156014)(4744005)(478600001)(66476007)(66556008)(76116006)(186003)(26005)(8936002)(81166006)(71200400001)(64756008)(316002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2597;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0DNk+L/57aUVb0qT6WLgBblL1sbunZ3A9TIH9FrscSCP7Rlj/fldJqAOZ55a4/xL9iqLkijRN7cmAEYpHq7Vm52oytA0LGV8kwlx2WxuOwv7VNNt6oseG/GI5tlqfkNTdsO6tT8VI9qXEEXniIoegAMuxmKobsUtpXfv+SxNxVVLoSe18zZdUmPncsbcnos9uTOjM983lvHhNzvl/t2gP5gO/XSb1IB5bm/l0mx+k+Q95SdBSqa0dFFjE28MLpB5DuyB/2R1kTLNtQzcAnuX2E9QVWc/4cnlMRgUZRQjOOXiJbAqkkkS41t9Scj2F2rXZ2yBkhJuTysM974Q86e/uty5v16N5UVxLxAPNTRYeXBf+PDwQKY1Doc6nXWOa80BvNrHhKXknNumhuYENXwBykWlHeznhgvkZ5pW6xSEGkxbKmyqhkMbZyvA7t7+aLZQk8P3Dmz0xz6RCQmzJpOlZ5GzzRXH6FY4OtJOCsvoEb1CNzJlTLu9XHhfW7t1EL+8j2sCmF8Aa1VrVpkdkBgUw==
x-ms-exchange-antispam-messagedata: NpNdNS91no4Qh1LfGSv+EgewYpLlWLrPjj9jwGJ5U7zt3i0TGwv2BWh07NBTza1KaGRjZaFrTjpT+/e0rJj/IS3lDGjNc3pLOHwPtCKJ+aKmLI2plO4T8B2S3wCev7PnNl0kojSqxM3zH79sriC/fA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9270d9d6-79c6-416c-c331-08d7d0db87d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 16:42:39.0319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 392n9nzBZU/qFT9yYwE5qsHs5EoFPeD76mmsPR+8uvxZqNrWG0CtJSffd8AG9Qi8A6qGJvWRWc8eXUGe+CKXXzsggG4vN3ZRfdYHe59v398=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2597
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Remove labels and not relevant property from DT binding documentation
examples as suggested in [1].

1. https://patchwork.ozlabs.org/patch/1252837

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/microchip,wilc1000.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wilc1000/microchip,wilc1000.yaml b/drivers/sta=
ging/wilc1000/microchip,wilc1000.yaml
index bc6cc5d3f347..2c320eb2a8c4 100644
--- a/drivers/staging/wilc1000/microchip,wilc1000.yaml
+++ b/drivers/staging/wilc1000/microchip,wilc1000.yaml
@@ -36,10 +36,9 @@ required:
=20
 examples:
   - |
-    spi1: spi@fc018000 {
+    spi {
       #address-cells =3D <1>;
       #size-cells =3D <0>;
-      cs-gpios =3D <&pioB 21 0>;
       wifi@0 {
         compatible =3D "microchip,wilc1000";
         spi-max-frequency =3D <48000000>;
@@ -52,7 +51,7 @@ examples:
     };
=20
   - |
-    mmc1: mmc@fc000000 {
+    mmc {
       #address-cells =3D <1>;
       #size-cells =3D <0>;
       pinctrl-names =3D "default";
--=20
2.24.0
