Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF4167C24
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgBULa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Feb 2020 06:30:56 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:41831 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBULa4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Feb 2020 06:30:56 -0500
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
IronPort-SDR: AlwehkzjSqdMyyv2PrWR4jDQwODJvbdfYrqxncW2N44JQ5KfMy/3/htnYHaEgFffF9HqhlRK4j
 sAOF/SWff4vC7PQ8uO68EIDZ9eip4ny6ij7FuFTTybS6zLZdg4JDXx8W5U4z68Gj1/52PP49k+
 EzU4MyZQrRjMkZQouirF/7vT5ru30yWXmHZso6Rm6IdE35Fzq81e2pZBBQVJDHwp3xFOZXveVD
 lWUroJ06H6FWlOJ16dhNC2Jh2u/Ao2/Wsr7oBUJPiSkpTmkrbWbAwrxBn0Don63NwY0O41jM1r
 Qrg=
X-IronPort-AV: E=Sophos;i="5.70,468,1574146800"; 
   d="scan'208";a="69321499"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2020 04:30:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Feb 2020 04:30:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Feb 2020 04:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNaSUmz3WExfhU5D2n3bR/OEx/I6wV3smK/HlH+GHKA79wkgTJLfLpSK8DusUULEA+y2JipKTdxgpq/XUG9HcKnByufo7nvrzhNWhP67m5L3p4pylBxv6PeA1hFDtnAJAXj6CwYpLje+v33kiloQU+xrOWj7WtQlpe8IGMuoQwYlA/8CBWCMbWbqjuyTC1+QZkwxlEZEBK7OyzlSKFf/Ys8niClGEzu6iNASrzMeO0AW56xs7nCHKizpBJvZwULpnPPayvISg4wQVkghxxfKhMl+kq+PE4P2Nh1HgCg5IITyBWgWSwQr7i6z1u0Zn/isXlz+iWgvgPU/p7aK1za08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lLUkzgZhlDTHnk7grjsIT8e2/sAEFD0DHpKN3Y+85Q=;
 b=Cb2X3M2r+1SVsI0aP3Vr5kCFLtWpFN23aBkh2XapRp5pgPxeJC77GbPAaZHP5YUe4HrifXwPdntUurPxO74UrN7tpQH3lBdgy8LPj6TA2QhN/6Xw8/pss+gcx+onlpckovzduflh/DnMKYwTqZE7VWzxv6wcx8TB0HKIB6nLZjHY72rvJCOpWj6W140pvwaKx5iHVx6T/lV8XQsj2KnZy7igocAWFKI/y8Si71S2pwT0f8PVKM4bkTiOnyAUtIsTUYqYFyj4HiQryqF7+YMkcE1dNuQoqrp77D8OgVBBrueAoFF/DJkisedRJTggHzdyciiDL7WuopIcM42L9Is3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lLUkzgZhlDTHnk7grjsIT8e2/sAEFD0DHpKN3Y+85Q=;
 b=fYnOIxBJ7NV6PVU3XbpsPhWQ4JlFJJEjVCtyPsP+puHtc1RliaTwhc90skepHJ+6xDds3sbxuBiIJjcKo2Sj7qYu/HpUGPw6eKGVY1z1+JBEIHOaz+HUJ3Z791ASursZVC92OtTZfLhWtMlzcZR6ToidoUFygGluhFNJc98nFrE=
Received: from BY5PR11MB3989.namprd11.prod.outlook.com (2603:10b6:a03:191::17)
 by BY5PR11MB4151.namprd11.prod.outlook.com (2603:10b6:a03:18f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Fri, 21 Feb
 2020 11:30:21 +0000
Received: from BY5PR11MB3989.namprd11.prod.outlook.com
 ([fe80::c69:bf40:f4b7:e62f]) by BY5PR11MB3989.namprd11.prod.outlook.com
 ([fe80::c69:bf40:f4b7:e62f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 11:30:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] staging: wilc1000: avoid double unlocking of 'wilc->hif_cs'
 mutex
Thread-Topic: [PATCH] staging: wilc1000: avoid double unlocking of
 'wilc->hif_cs' mutex
Thread-Index: AQHV6KpMhXZfgCJaNUWE+Dn1HLC0EQ==
Date:   Fri, 21 Feb 2020 11:30:20 +0000
Message-ID: <20200221170120.15739-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [183.82.19.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01b38dd2-f54a-4b92-2a7e-08d7b6c16f7c
x-ms-traffictypediagnostic: BY5PR11MB4151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB415194C26FDEDD1FB7CF6247E3120@BY5PR11MB4151.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(2906002)(1076003)(6512007)(5660300002)(186003)(54906003)(316002)(26005)(6916009)(8936002)(6506007)(81166006)(66946007)(8676002)(81156014)(71200400001)(36756003)(91956017)(76116006)(64756008)(66556008)(66446008)(966005)(107886003)(66476007)(6486002)(86362001)(478600001)(4326008)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4151;H:BY5PR11MB3989.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /AKEum/G9Z5qpeox+C512OebnhdXKzYCkZiDg1Cn0x89iyKsNQ6hNOmCMFlfHmg4oB+tkHslquzETlH636XCVhIiAe9BhK0CGfMJW/p+5My9jHJlu7G859I5jgQomABt2aD8jKD5buI3YgY0fNy+BSDPPw9rF3hyG0okqctKSRZhtmPfcAHeq+YyjfhaY491JKp57Xeyzq4KSHdMrZtU8sXdibBrs1cKeQWZZcsXIQGLHiDIYSIUStahRHAcEmO0IkVi3T1jA3RZAKDYCPyZm76SFWPY0oYyKkl4WxusOEqbxipSrer+cGS+hrKTnAZvBAMw/HT6dt9ze9xWogoQqGnA2wlGQReF76ml+3XyTFforVw/2iOc+5+L6zBEEa8DspnhAaoIQdcpZuMzf6BkPw+tIsc1I8m82umMZBSbUD78WS9c1U1d+iAAIPTbxdFsGpjGssW7gAbbpNFCAWr2yOPQQskXxNMYRzVIUhHYbx2DK6JrLH2+9xECD3CnN3s0XuqO/b+yuP/Nxy+tI9lmBA==
x-ms-exchange-antispam-messagedata: x8FjZopKOX5drn3tIwcuJnYnInaNRgJdDpdkRMyGBTqmK/flxBuONdvWrE5jU3/BTqbfXWDBByDmfEPTBiQKt6wrzpHjLzu267iWtoxg5s+robDqgwaf4lvDabIRqwmz0/DUssovTrWA2qNc9CquiA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b38dd2-f54a-4b92-2a7e-08d7b6c16f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 11:30:21.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NNxcnfVzN6Z/ZeMRsgyBqU9tT+LtqVu8JrORidw7NtNotJO4CR1mhCHOzUfuUuntI6fM8FsFpDHO5gBXv4jVDjW9Uyu/foDJv351I5hRBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4151
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Possible double unlocking of 'wilc->hif_cs' mutex was identified by
smatch [1]. Removed the extra call to release_bus() in
wilc_wlan_handle_txq() which was missed in earlier commit fdc2ac1aafc6
("staging: wilc1000: support suspend/resume functionality").

[1]. https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/NO=
EVW7C3GV74EWXJO3XX6VT2NKVB2HMT/

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wlan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index f633c6b9f0a9..3aeca882f431 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -575,7 +575,6 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 				entries =3D FIELD_GET(WILC_VMM_ENTRY_COUNT, reg);
 				break;
 			}
-			release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 		} while (--timeout);
 		if (timeout <=3D 0) {
 			ret =3D func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x0);
--=20
2.24.0
