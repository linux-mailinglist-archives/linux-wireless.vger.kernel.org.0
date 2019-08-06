Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB382FC3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfHFKdz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 06:33:55 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:4566 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfHFKdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 06:33:55 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bAGoN2ZHBPTuwdbRDaz1TgXTa494PCfIxM5L+QBLQciZdIpzMbIDmRtWw5S7ZTc6YZRPcZ4j0P
 WoJgYw87gS16NjGnylkKckjHIKbhs38M8nXetDBG/CJqP3Tug4Ek3Qqmvfm74y5esmvQFeoSVf
 2jkvxOloviefzIUWSWRYDKm5Ew7wboZ2+HAWKcxFsHWBaR8yj++aXchWS4gEci4Zfg7h5XKnrH
 6zzPBo94X27tAdTbPL1IGc7+JNEPmTXibThuYVq30Hdo9oQOyPD5PjXCnv+Onwbty05/pVvK+Y
 wsg=
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="42559287"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2019 03:33:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Aug 2019 03:33:53 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 6 Aug 2019 03:33:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXpQaw1VCWKCm/eNyyq4PwaaB6NHPl/6YcRE/EMrebCbsZOnqgm3TT28gL5xNKZ1ofrNT+4nS+QGbFGnubD3f4FSzu89tNOI0zhX4mTV/Jv2myO6xGl4DsQOhbPrfbb0P1NiXsfmZ2eAND7Ex3NiO5CGtOqGes+d6LuxtIK7QUPxfrqPGxBw4mP1JopPSCC/uuV/NHDLQtq3L5lfq/75LftjEHm/0IFb/TaeYrrbpk4rrNyLUhjQ79ELYwrCy3mwbN+/WFDgZHzdHjI2fMa64Lbb7zs/WeCRtobjVQ/FPwDAZJkchGJ7Y3cpdLGpHPDePkjxDs6/vy+RtI6nOlZVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jni6o8RWKclPK/b2X/jGV37QLijXCtT4atfvD8J4Bh8=;
 b=bg2TzZzSl3ObusNSucc/C9IbYZATLWQYcEtd3qLZB4PKaivd3h9izQ/YVBiRI89dL789mtmmld8udpnEjCE6uk/6jMNspOcXErrIXYiqlcIjQAzPnTbonfAzWwFI+xqWToSihTxnQFYgIl4mcMDl9skE6FRRemAi1kCGDS1iMy0bgBsAcAAWMNaPNhN02dtmRMxB4LP3RVszLMt81O+D/NaVsYGrXG3Co8ZiVtzQn8O2AQMj00DaDH/3hjQm+OcSI70bALQziUCpWMbKOyEHolof7vrIEIjKW25yL58bbYo95We35pfPZB84t2AJE5v8MeCcTw2WIHe7juWHvK8dYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jni6o8RWKclPK/b2X/jGV37QLijXCtT4atfvD8J4Bh8=;
 b=trDpXg3o57G/+QxfqoRNaUZPmqLcWnYqUStF+ncyrWJbvlLDJoEiX0FFHONfgBpezA8m6fDeXKId7W3uAKeQGA8FwJbnVEPjb+iN5eD/6uLUMJBuploFJ7uJPgET99xqYfXYcshBKKRSS2tBSiuYIGCI5WmqITDNvT5tJ4lrbz4=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1876.namprd11.prod.outlook.com (10.175.97.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.19; Tue, 6 Aug 2019 10:33:49 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::c0de:189e:f619:e8f6]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::c0de:189e:f619:e8f6%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 10:33:49 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] staging: wilc1000: use helper API to pack data for firmware
Thread-Topic: [PATCH] staging: wilc1000: use helper API to pack data for
 firmware
Thread-Index: AQHVTEJvBVE9t6fytUuMPscd1kdv/g==
Date:   Tue, 6 Aug 2019 10:33:49 +0000
Message-ID: <20190806103325.14063-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::33) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [27.59.51.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5ad4bdf-4d24-4247-44a0-08d71a59913c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1876;
x-ms-traffictypediagnostic: BN6PR11MB1876:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB187684F6B4C16E79FDECA7D1E3D50@BN6PR11MB1876.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(966005)(6512007)(107886003)(6306002)(14454004)(68736007)(256004)(486006)(99286004)(476003)(2616005)(71200400001)(71190400001)(25786009)(86362001)(2351001)(4326008)(26005)(478600001)(66066001)(66446008)(316002)(64756008)(6506007)(386003)(1076003)(2501003)(54906003)(102836004)(5660300002)(52116002)(6436002)(6486002)(5640700003)(186003)(6916009)(36756003)(81166006)(81156014)(53936002)(66476007)(8936002)(3846002)(8676002)(66556008)(66946007)(50226002)(6116002)(7736002)(305945005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1876;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2EOcHtRQtezvXuIVFh7wsOCTGUq58jc9RqV0HqnjALzkorIbQ+CRMVvirBx8mvSYK9zzycmubl/DtSQU83NFVxJ++zHHlNI282FRIb5Zt13dFdMOHnfyvdjv/0iRljzq8I/bijAIMBFOCSPYmihEefOKP7aWvhzswiZhKgiVHqp+u5y11EI8tBnEJ74Pui4KO3flgxgbIremzG0WfYQglFH7S+sk1DQ08cI/k/0hgYrOy70pHBke0J8Zmx7RTy+PX+tVK0hHPQbu1j7LClR6qAQPOiMyfyKo8Rshhto1qc3cfdfsFK8Lg/vw1PKSYr4XljxS7jYGAZL4qf7e16Dl31uk8yF0xvI5nP6/4G6LsQqxTbchn/AmUMih2ESclCiOVbM5qaOhWvUvyvZmiXOrCGbKHUsC0ji3Di0gK5zQbeE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ad4bdf-4d24-4247-44a0-08d71a59913c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 10:33:49.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1876
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

As discussed in [1] use put_unaligned_le16() & put_unaligned_le32()
helper to pack the data before sending to firmware.

[1]. https://lore.kernel.org/linux-wireless/86bc79ccd379497d56bade79ec8f717=
603110ef7.camel@sipsolutions.net/

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wilc_wlan_cfg.c | 74 ++++++------------------
 1 file changed, 18 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wlan_cfg.c b/drivers/staging/wil=
c1000/wilc_wlan_cfg.c
index f4144f93e4a9..3f53807cee0f 100644
--- a/drivers/staging/wilc1000/wilc_wlan_cfg.c
+++ b/drivers/staging/wilc1000/wilc_wlan_cfg.c
@@ -52,57 +52,35 @@ static const struct wilc_cfg_str g_cfg_str[] =3D {
=20
 static int wilc_wlan_cfg_set_byte(u8 *frame, u32 offset, u16 id, u8 val8)
 {
-	u8 *buf;
-
 	if ((offset + 4) >=3D WILC_MAX_CFG_FRAME_SIZE)
 		return 0;
=20
-	buf =3D &frame[offset];
-
-	buf[0] =3D (u8)id;
-	buf[1] =3D (u8)(id >> 8);
-	buf[2] =3D 1;
-	buf[3] =3D 0;
-	buf[4] =3D val8;
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(1, &frame[offset + 2]);
+	frame[offset + 4] =3D val8;
 	return 5;
 }
=20
 static int wilc_wlan_cfg_set_hword(u8 *frame, u32 offset, u16 id, u16 val1=
6)
 {
-	u8 *buf;
-
 	if ((offset + 5) >=3D WILC_MAX_CFG_FRAME_SIZE)
 		return 0;
=20
-	buf =3D &frame[offset];
-
-	buf[0] =3D (u8)id;
-	buf[1] =3D (u8)(id >> 8);
-	buf[2] =3D 2;
-	buf[3] =3D 0;
-	buf[4] =3D (u8)val16;
-	buf[5] =3D (u8)(val16 >> 8);
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(2, &frame[offset + 2]);
+	put_unaligned_le16(val16, &frame[offset + 4]);
=20
 	return 6;
 }
=20
 static int wilc_wlan_cfg_set_word(u8 *frame, u32 offset, u16 id, u32 val32=
)
 {
-	u8 *buf;
-
 	if ((offset + 7) >=3D WILC_MAX_CFG_FRAME_SIZE)
 		return 0;
=20
-	buf =3D &frame[offset];
-
-	buf[0] =3D (u8)id;
-	buf[1] =3D (u8)(id >> 8);
-	buf[2] =3D 4;
-	buf[3] =3D 0;
-	buf[4] =3D (u8)val32;
-	buf[5] =3D (u8)(val32 >> 8);
-	buf[6] =3D (u8)(val32 >> 16);
-	buf[7] =3D (u8)(val32 >> 24);
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(4, &frame[offset + 2]);
+	put_unaligned_le32(val32, &frame[offset + 4]);
=20
 	return 8;
 }
@@ -110,46 +88,35 @@ static int wilc_wlan_cfg_set_word(u8 *frame, u32 offse=
t, u16 id, u32 val32)
 static int wilc_wlan_cfg_set_str(u8 *frame, u32 offset, u16 id, u8 *str,
 				 u32 size)
 {
-	u8 *buf;
-
 	if ((offset + size + 4) >=3D WILC_MAX_CFG_FRAME_SIZE)
 		return 0;
=20
-	buf =3D &frame[offset];
-
-	buf[0] =3D (u8)id;
-	buf[1] =3D (u8)(id >> 8);
-	buf[2] =3D (u8)size;
-	buf[3] =3D (u8)(size >> 8);
-
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(size, &frame[offset + 2]);
 	if (str && size !=3D 0)
-		memcpy(&buf[4], str, size);
+		memcpy(&frame[offset + 4], str, size);
=20
 	return (size + 4);
 }
=20
 static int wilc_wlan_cfg_set_bin(u8 *frame, u32 offset, u16 id, u8 *b, u32=
 size)
 {
-	u8 *buf;
 	u32 i;
 	u8 checksum =3D 0;
=20
 	if ((offset + size + 5) >=3D WILC_MAX_CFG_FRAME_SIZE)
 		return 0;
=20
-	buf =3D &frame[offset];
-	buf[0] =3D (u8)id;
-	buf[1] =3D (u8)(id >> 8);
-	buf[2] =3D (u8)size;
-	buf[3] =3D (u8)(size >> 8);
+	put_unaligned_le16(id, &frame[offset]);
+	put_unaligned_le16(size, &frame[offset + 2]);
=20
 	if ((b) && size !=3D 0) {
-		memcpy(&buf[4], b, size);
+		memcpy(&frame[offset + 4], b, size);
 		for (i =3D 0; i < size; i++)
-			checksum +=3D buf[i + 4];
+			checksum +=3D frame[offset + i + 4];
 	}
=20
-	buf[size + 4] =3D checksum;
+	frame[offset + size + 4] =3D checksum;
=20
 	return (size + 5);
 }
@@ -307,15 +274,10 @@ int wilc_wlan_cfg_set_wid(u8 *frame, u32 offset, u16 =
id, u8 *buf, int size)
=20
 int wilc_wlan_cfg_get_wid(u8 *frame, u32 offset, u16 id)
 {
-	u8 *buf;
-
 	if ((offset + 2) >=3D WILC_MAX_CFG_FRAME_SIZE)
 		return 0;
=20
-	buf =3D &frame[offset];
-
-	buf[0] =3D (u8)id;
-	buf[1] =3D (u8)(id >> 8);
+	put_unaligned_le16(id, &frame[offset]);
=20
 	return 2;
 }
--=20
2.22.0

