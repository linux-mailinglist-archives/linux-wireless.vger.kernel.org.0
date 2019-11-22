Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD41079A2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKVUwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 15:52:10 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39603 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 15:52:09 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 2VsuERo88KvkSTiznPcmZxmLeiUpZXgTLDr68AqqV06oGz8D3tpgpWEt4kwDUcvSE1N7785QjH
 ahAP11HF4gbfOnm6dfDfqxiJUeYLRUf4AqcJSrIK1NB/JAqNDJjLew57rFysd8Caa37Vor2/lj
 u6me/SaCmlQ7SLRIzWwszTR2Y28h+QCYZKDwkvqoeWtwnxTIa2IwvaK5+dHa4EsT/BoVyXdk6w
 yKsbvE8J05Ef/gm/cFGyXeTcmbtdwXfTwqvQg4ar2F4o5ekHjJ14WpYCZvHXb37cIQeITRp6EY
 4r0=
X-IronPort-AV: E=Sophos;i="5.69,231,1571727600"; 
   d="scan'208";a="56399344"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2019 13:52:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 13:52:07 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 22 Nov 2019 13:52:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzhWYtL3BSIkHkwUI2UJwblh20zLkVaiycJf55dptNtQTAgUttN5paF9QsVslCmjkfxgxskSGUF8rlEZoxdDGiuub3HC5m8FqC31szpwFRqLwtOH/iquklOHobvdvZih6GbXdIT3RMAaWp9TxUnYfgPz/XBeAfl0rH8k6kFFuavN/jQUC3yMKSC3e7CKBOfPVre5QcwGlGhfIMeO+HS/AOoFVMEniwcxFI9QeDYpF7fq1Ph1SnkuMJPc6Pzh1UsEr6W+aCUvH7X3zQAoRNZTPNBs6qikvAF+zJDL7B2jOnhAi8PSqzjJhLJujrbMy0IQEhJjlK0dTceKtTrsseifNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+rJy+E+vyIjv5Zd8uCHQWY1b18mmojJR5+5sFKc3Hg=;
 b=ONfG61f6aGmU24uq9RG3aiT+BiKxpIUZBfQgeBEZco5vv5Fbvf+NkB3AhUuqpAsOzMpmdki7oYim03dCEZiUdXains577bhEWloplNwsA3vciytcniTAcX8JXFeN10KJU+GAVY6vLIYC4ij/eldTdlV8Y9xf+Vv65AU82gqBx2y6VJvy00xh7WrYGoO+QVrP6WoGpJ3d7i0gktqqj+cmPnA+B0exGcmPuGwOPQUb9U1W0KdqAA0yIPHv2AaB40nolmkDIPutTPZRH+lEMKihpSqyOkTmRs8a0ottpvn3pBGeJ3iAHjIbVLRm35Ztckh9IhEZ0jdDib/+4fyhrK9iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+rJy+E+vyIjv5Zd8uCHQWY1b18mmojJR5+5sFKc3Hg=;
 b=LUc1tTrIAjGHGaxccB3AKCby/VJc9kcjKtXL50Mr4XIALgYtTk2j94l+RZfxZvqI3i1uwBDhOs6iubm+mbNXvTdqCEZdyABhLKpsahXKbdYJ/yNNniNOCRLz1kF/HPtFRBxYVcBsnDo6SFzv1xhl8AZ1deNvLbWyt4tTJJZifzs=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.54.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Fri, 22 Nov 2019 20:52:05 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::fc6d:2ed:d470:fb56]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::fc6d:2ed:d470:fb56%8]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 20:52:05 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/4] staging: wilc1000: use GENMASK to extract wid type
Thread-Topic: [PATCH 4/4] staging: wilc1000: use GENMASK to extract wid type
Thread-Index: AQHVoXaykYuCp0pyik2Th735RqUfjg==
Date:   Fri, 22 Nov 2019 20:52:05 +0000
Message-ID: <20191122205153.30723-4-adham.abozaeid@microchip.com>
References: <20191122205153.30723-1-adham.abozaeid@microchip.com>
In-Reply-To: <20191122205153.30723-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e994b37-0009-4411-d9c2-08d76f8dd545
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB147264DCC36C305F2E2B93318D490@MWHPR11MB1472.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(316002)(66946007)(7736002)(8936002)(107886003)(81156014)(81166006)(186003)(66556008)(6486002)(26005)(66066001)(99286004)(6506007)(76176011)(5640700003)(4326008)(6436002)(52116002)(71190400001)(71200400001)(1076003)(5660300002)(14454004)(6916009)(11346002)(2501003)(102836004)(2906002)(386003)(6512007)(446003)(25786009)(54906003)(66446008)(50226002)(3846002)(36756003)(66476007)(256004)(64756008)(2351001)(2616005)(8676002)(6116002)(86362001)(478600001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1472;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FWu0gRWB+0H0WLGkwSO5PfGTgxa6FbIWP58F92tA9GWzdrKyqaQFW8/fR4?=
 =?iso-8859-1?Q?Qs64Rf6sy45oqjJWDYl9uOGzeKH/aqVdDYOvMkkt3X/Az1FOTSVFSLaumt?=
 =?iso-8859-1?Q?8iW0uVwwfUkprKrWD72FmEGBMKvF8j93MLljPfpDwvHDltkuGGCz9Iinuw?=
 =?iso-8859-1?Q?HIEMsqbpbTl0EK0Pg16ZElHUs3IDSOW+c8faZSJsieS2/pqy8HCUvfVGYV?=
 =?iso-8859-1?Q?bzuZwsKj6ploUzPQjwA/us0N39BlrtctcbCdswEKyCs8kKlIUVP+feowkg?=
 =?iso-8859-1?Q?u6vd542hO7ucryb/dMA19yGoVxGepTG1Ux3/mGlkJPcZgOZeZ6Ek4LEdgw?=
 =?iso-8859-1?Q?ooPmzSJ8CICDM3hR6jayazNxSgAF+fdYZ6WZPLrGHjPWbGn70csfGYNCSp?=
 =?iso-8859-1?Q?U8jTjbnsBpQqWybUYc907NZOoDZItqKqwN6TvFMzOd5OjK4fu57LMvsoqv?=
 =?iso-8859-1?Q?YHtY4jOYzWayOaaB/aoAV2M7YBIgYImzz0OKklOjlF9XqFTU4QY21OiFQI?=
 =?iso-8859-1?Q?NsPt4PxI5mn+FwSdPXVKvMpFMbhTVi1mEXeHw5FlVj2GpyJN8/LH3pZ2GL?=
 =?iso-8859-1?Q?WdIDKKoCrV0ci5ND1Y3sxUDoGPkgEaXdMB7WLIzYqiiFkrgexCqGdYay2s?=
 =?iso-8859-1?Q?crSo2+zxWyuXOynEtkbEH5fw4OYTwvIwz1MfN+SmTNonI+XQB/sLUYbyn9?=
 =?iso-8859-1?Q?+cyartXD+K+qfnJ/DgmUuVNCshmgn1OW40zzwJ8VtP4vYkGbEclWv8y/Zr?=
 =?iso-8859-1?Q?g4d8s2VR1fAdAMiHri+UFzKCrBVzVVSGbo7R/7FERltvpinPnzLVnrP1Vr?=
 =?iso-8859-1?Q?G9L4Bc79+sKf/0CX1mZVY8QYq6bMPrfBv2k3c2PY/gL1Me+3BMSW1yT1uH?=
 =?iso-8859-1?Q?gidD8GvW2ppdvlJ44ewMUpmCH/l67x83G0kjuM0HYuDtR8Ac0N7TYTFzmZ?=
 =?iso-8859-1?Q?+Ut432UFXuMgHpS8YMZfqq/lABpXdnaYk0dx/KvsoFafH4/XDgh9gkKoZh?=
 =?iso-8859-1?Q?mL0NlE4dxF1EagVWzozTrF80iD4vrCSVKRphO1d5FfJMdd4rRhU4uUFiMj?=
 =?iso-8859-1?Q?dEVoTsmWdwCbL9v552kdyT0Nz18ruKbj18KvRxrjHCBac27s8tBzCUgUSq?=
 =?iso-8859-1?Q?6NRIPvjdrvENJJAqm9nebx9tkJ2pFXyknJcAc1l9/lvao/VXio5DVdPyM2?=
 =?iso-8859-1?Q?TVOfusrO9Yii3nAG4oCZxLi8WKnLv72ed3hWRbzmczZxOGtWTJiaoUT4mf?=
 =?iso-8859-1?Q?owp7aIcC+pJa9qKhGpmCw9A6id2HKCtZ6QkLqndSYND9DqTl83VwATshVw?=
 =?iso-8859-1?Q?iD1ZwsJ7VAisBBosRzVJmil7CmzfF+a4gNcWTNZQyI/zVgGm1dnZ+OtGlg?=
 =?iso-8859-1?Q?5v6vZsDOT8tGozwq8RdQdP2q8hyk04FS8yVdZm15dtWStJ/zzh4yX+5iPQ?=
 =?iso-8859-1?Q?0Ol8Z8BXLYjTCtytFHCKPCnkHZXnqHLMg8m6PVVQ5eo4A/aLn5KVGg47y4?=
 =?iso-8859-1?Q?O9LS3JXvajkC90ZSaX0VRv7vMznEcqtMpiNEtxeDjQTYo2Zk4ewyvdjpxn?=
 =?iso-8859-1?Q?hASEdhG6r1suw+e1i7yc1taNXWnQgduJRR5wc4Wt3ymYHStpYvcfD0PMQo?=
 =?iso-8859-1?Q?0T6tCSf6F4PuLaL5a0LlnQMWHWi1gxEU2FWI29lW8B5PuOi55PyJ+ObqKo?=
 =?iso-8859-1?Q?Rkx78eWoAOrxjTBzYKU8/A4Je3gtMsV/Av/pQ/VqglVLa93GSx2a8rrPID?=
 =?iso-8859-1?Q?hiXUzJSRr0J5XOw3SF5NmiviEoT57Xao41iNVnpSWYXGzW5r3GLeCI1Bz9?=
 =?iso-8859-1?Q?D5qIE+Y9Tg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e994b37-0009-4411-d9c2-08d76f8dd545
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 20:52:05.7400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl/KMXhP/uAWritZtN3e8JaX1J28IbLKvwZShFEmLjMJOBDSS5WUUl5DuWWCPpS9NTH2HKkiX7FRB19TGRUjDtkDbQ4B6qfnevbR7EJyY9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Refactor code by make use of 'GENMASK' to extract the WID type from
buffer received from firmware.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wlan.h     | 1 +
 drivers/staging/wilc1000/wlan_cfg.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index 1f6957cf2e9c..44ae6ed6882c 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -197,6 +197,7 @@
 #define IS_MANAGMEMENT_CALLBACK	0x080
 #define IS_MGMT_STATUS_SUCCES	0x040
=20
+#define WILC_WID_TYPE		GENMASK(15, 12)
 /********************************************
  *
  *      Tx/Rx Queue Structure
diff --git a/drivers/staging/wilc1000/wlan_cfg.c b/drivers/staging/wilc1000=
/wlan_cfg.c
index 6f6b286788d1..2538435b82fd 100644
--- a/drivers/staging/wilc1000/wlan_cfg.c
+++ b/drivers/staging/wilc1000/wlan_cfg.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
=20
+#include <linux/bitfield.h>
 #include "wlan_if.h"
 #include "wlan.h"
 #include "wlan_cfg.h"
@@ -132,7 +133,6 @@ static int wilc_wlan_cfg_set_bin(u8 *frame, u32 offset,=
 u16 id, u8 *b, u32 size)
  *
  ********************************************/
=20
-#define GET_WID_TYPE(wid)		(((wid) >> 12) & 0x7)
 static void wilc_wlan_parse_response_frame(struct wilc *wl, u8 *info, int =
size)
 {
 	u16 wid;
@@ -142,7 +142,7 @@ static void wilc_wlan_parse_response_frame(struct wilc =
*wl, u8 *info, int size)
 		i =3D 0;
 		wid =3D get_unaligned_le16(info);
=20
-		switch (GET_WID_TYPE(wid)) {
+		switch (FIELD_GET(WILC_WID_TYPE, wid)) {
 		case WID_CHAR:
 			do {
 				if (wl->cfg.b[i].id =3D=3D WID_NIL)
@@ -244,7 +244,7 @@ static void wilc_wlan_parse_info_frame(struct wilc *wl,=
 u8 *info)
=20
 int wilc_wlan_cfg_set_wid(u8 *frame, u32 offset, u16 id, u8 *buf, int size=
)
 {
-	u8 type =3D (id >> 12) & 0xf;
+	u8 type =3D FIELD_GET(WILC_WID_TYPE, id);
 	int ret =3D 0;
=20
 	switch (type) {
@@ -290,7 +290,7 @@ int wilc_wlan_cfg_get_wid(u8 *frame, u32 offset, u16 id=
)
 int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer,
 			  u32 buffer_size)
 {
-	u32 type =3D (wid >> 12) & 0xf;
+	u8 type =3D FIELD_GET(WILC_WID_TYPE, wid);
 	int i, ret =3D 0;
=20
 	i =3D 0;
--=20
2.24.0

