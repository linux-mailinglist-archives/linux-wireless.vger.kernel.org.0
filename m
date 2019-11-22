Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C691079A0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKVUwI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 15:52:08 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:44174 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUwI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 15:52:08 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ooSAMffm9sF5B6IsTSTfA2fcPSR6aAhoxAxpqDZNwVVKaGdkPQijN2NlKf7HirFnL7uYv9aoZ0
 TILchSW4SdzT8m6u8warF/77IFM+NkWDRNG/PnMyx8JAWRL9KQwqjjgf5ye0I0FmM5fikB8TIU
 4JqZ4slbSoL9ynUSFdllCkeNzQhwE73a0i/8iG39hNf0ZTIBKIAvn8Tyyo7xeECjYN62ZFsdWw
 KC6qA4B4UbX7o1z/W9uTYI09o6GFJ4d8wl0DoAZ9IgVxB3jxFCqeDyg6E1/JlB48sK9hfNHnQv
 WwM=
X-IronPort-AV: E=Sophos;i="5.69,231,1571727600"; 
   d="scan'208";a="57656084"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2019 13:52:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 13:52:06 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 13:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crseTMf8+iqIMiocaab22oH3pLuFdSXNm4V7bpaDiLQedxj/G7ONhotOJmKzViG8knGgczmaOIxtwSabVnKB3Dl+2mARR8wIxtITvo0rKqBf97V6tjNaD2JI8P+MroyRf+wH4DyPAx+mqcWII6YKhZXp41K3/+lSXA4sU6yhqGLYlY+LTRMbk3Nxz32jh2ipkuVXH0ynpVqugHHf+QRocuOYMygiuuHan5/xRi8CXXxukjfpfdV7oB8E+rSA1QiroMyKmFXtu4Ob42FBCkVFIOcegrayeecNmertuUVeC/rVb3tAi0s6JfvBMZb8y5xTb4s6S2PNHetb6g4ogW86Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j1ylFJs6JeAokkedwwu5FNaVN8NDtBAV57EQuWuIkQ=;
 b=iH4zIILLx/2+U5qpTfe9QX/pktI/+XU0GznOYq9dkM5N3/ZJb0uUniJ6h9S72pUvfj9JPOMy3caebfBqNowsDVxYXQ/IOZXD+zxZXQMtGM+EUcoG8tMNM61LNC1Ug0Czw73BMHQqbD/kThV88Osaa9LfhQ1g21umE8+OCmaaXLDoH3wvDJokJsHCyqB2DJshKrgUd5/jyFFr4ylFOw9+P39U8OsQToINIMKij2ysO+FaGQ7NDp+xJXYJfvZtSd6ay6nk0drTQ6aWsXriyYxhN4HpdWFHe9zR/QF1h3BI3pEUKQPfcFAUuZ8dEsyeHC0ib/l6eWfdF+JMkI6vWA9uSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j1ylFJs6JeAokkedwwu5FNaVN8NDtBAV57EQuWuIkQ=;
 b=DQFUxwD4ZlTD00SmcEQxtu/0OpMFIg3A5dhTa+CaW7YO/cItGaxB5Z6EpSdAw8C0K1aNL/jfx6OuKFG0hkVTeGGMDPT0XhA5dUegdcYKHj5o+WKNdceKygLqoqaO3fKU9fU8wJYaEQFaZ0qlnLSQ2MWrqn72A2RGh9l6/Dp10qc=
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
Subject: [PATCH 3/4] staging: wilc1000: use kernel provided struct cast to
 extract mac header
Thread-Topic: [PATCH 3/4] staging: wilc1000: use kernel provided struct cast
 to extract mac header
Thread-Index: AQHVoXayqAQs7Rt5U0akHYwi3cg+sg==
Date:   Fri, 22 Nov 2019 20:52:04 +0000
Message-ID: <20191122205153.30723-3-adham.abozaeid@microchip.com>
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
x-ms-office365-filtering-correlation-id: 78c4717b-a183-404f-ca98-08d76f8dd49b
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1472C7BE7DD9C9F67F5CDEDE8D490@MWHPR11MB1472.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(316002)(66946007)(7736002)(8936002)(107886003)(81156014)(81166006)(186003)(66556008)(6486002)(26005)(66066001)(99286004)(6506007)(76176011)(5640700003)(4326008)(6436002)(52116002)(71190400001)(71200400001)(1076003)(5660300002)(14454004)(6916009)(11346002)(2501003)(102836004)(2906002)(386003)(6512007)(446003)(25786009)(54906003)(66446008)(50226002)(3846002)(36756003)(66476007)(256004)(64756008)(2351001)(2616005)(8676002)(6116002)(86362001)(478600001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1472;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kmE8jhnWdM0I+DYIdf6gTbcbag9VteR428UTXW74wqjZomRWpFmGUhSlF7?=
 =?iso-8859-1?Q?VSYgzSahQdWjtx3xOH2TK8AGZvmGAs/whEAKNjHzornlOdSRlQ/hlK9WUL?=
 =?iso-8859-1?Q?icUEGHWD2A6RtgeeOpxfj0JCllqIbbqTv3vY6ZtTcjuCsps0C/YcbCL4Qm?=
 =?iso-8859-1?Q?+QUVvDjz+GNd0Hd+FY7GI7/lWH5bAtyF17Bm0wNbZrrvuvmGPDmlVjREYT?=
 =?iso-8859-1?Q?Ia5VsmYWJnlq9IV6hv1p32BbsfB/yXURpxys/dW12FKyGIjA5QTmJ7uoGI?=
 =?iso-8859-1?Q?9Pe6cvImKdwVpQcGy05qeW4nRkcsxlvHF2Xh2nDA8Lx8hlep6pZAXZkd9t?=
 =?iso-8859-1?Q?zjBzhVRjisWdj1NrGA8tjFAWlshQgJRT+iZnfWsH6G8kOWNlWcDZhNckay?=
 =?iso-8859-1?Q?taGsdn9k5z7H0dO8LbTEkVxMoA0ssyEzh8aT/f3KnWBXTRhD/X4T3ossOa?=
 =?iso-8859-1?Q?2sKHYMgMiZvXKAQaEa/Dw5eeaenmSFf5BZtaD3h+SwHDjYs+8WfevRZ1LJ?=
 =?iso-8859-1?Q?l5ntdAqXyBmComsbaYAh4wVQ4J9xN4PsQjvBDyNMYOavTvXsxwXUUPcQil?=
 =?iso-8859-1?Q?NOCwb91Wnbk0X5sF+kMRzHEct0sp0DBcViq4X0G1kKnjgy+TUZfFZu8O6b?=
 =?iso-8859-1?Q?tkCgvC2rJ1uMj+lM3D93pL26Tk4VvxfpNst8YIFYAM9mfCqtoTazE8qJmg?=
 =?iso-8859-1?Q?L3nkewWKvLGN21W64liEh3/P7EwoEe44qykyPkLy7ZwvtCXRUKMoWp59iH?=
 =?iso-8859-1?Q?b8+LyBFwKRLkgDL0Qg8DeXzxlNx+kbNvMPBJN+b703kRBdsyisaj59xb6u?=
 =?iso-8859-1?Q?y1rbUMKDd0ecwCHkMtIPLn5dUvkEciyDGakBhbFXI/9PtJXrT13Rp2BXkY?=
 =?iso-8859-1?Q?wofe5U1AMSPXPzjzgm8/V4WAD05t+M9uzHL6qzQiKq6Vl5fvZ8VBAjHwxh?=
 =?iso-8859-1?Q?4hvKKV1ZCVnPXaepau6eooDZGeImfQNZIHKiAKtgIT701W82/coArW9DCO?=
 =?iso-8859-1?Q?iq61fjKT9w8cRRzU74crLbR1gDV21LW4hMuo0ESxfdolLjG7jgofe6qyvn?=
 =?iso-8859-1?Q?JgvgIHkohduwnBwOPHH+gnEIDtxQt89/ySbhR/ymXsV6laxYJPsrEEcDZG?=
 =?iso-8859-1?Q?QORxNCjB9asdOI8rJSxUxSlo7o4L5AUkO6UmCmp30crGP2JcU58xJm9KAF?=
 =?iso-8859-1?Q?93vutMIru1uciW1eRyLdDpbYhGXi0efHkvWmnOgGRoXa4Cq4vN5NKahTzI?=
 =?iso-8859-1?Q?6R+3/fIvPKmmieUmXeBCDGg7mV42YPKqqLemBcvtPymTG/QLT1yTba8dXJ?=
 =?iso-8859-1?Q?xX/a6ZbUUG8Smu8mte2Kw8CQWLFDyKbG0OTJtYpWqH1gqTcpArojM6zQ3I?=
 =?iso-8859-1?Q?4VEBekQ42/a0GsUZkHMRrjH43jJR7CD6z+Cpi/+t/p0S0638H6YKvpq7Me?=
 =?iso-8859-1?Q?mAn++/LDl2AE8SRw1QBtv7tZUYFuB3AtkYKX7G3mwynBJy7TTerw0akvv8?=
 =?iso-8859-1?Q?Vzaf3Fmuew0isIFN5TlX6GoqYhOg6QctMnvAC+Top/ttFUppYRazoS/sUg?=
 =?iso-8859-1?Q?s6vRhKy/RgOVZbxKDE9d+f2jIMdNnbnsf6k8A4AaA90BSlPvh6aKKQB6wy?=
 =?iso-8859-1?Q?txlrqlYsrcUmXUaUDyT5einYwoiaV5DKmaGfO+vlscocbQq8tTJZbd0KnW?=
 =?iso-8859-1?Q?2Wiuzu2pI/7ilN6vpWQOGehV26H351BpetqtuqLahxLY9c3CCaJdDn6Tk9?=
 =?iso-8859-1?Q?QS+heiKFAaMxNWDU83VnTzJHDs21SK2Q/4crzHGceBj1YyCkwtRELu//84?=
 =?iso-8859-1?Q?2F+LO7JZMA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c4717b-a183-404f-ca98-08d76f8dd49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 20:52:04.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnbM+dzgnuxB/6CS0vWbRwe34qrd/SXzLp6EmCNt3GrlmhDjw6+lJ15k9WRblmduiZ+Gdyj09lwZ3kmuR56tNO7P/mL2D2hMdc+FrKMv8ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

To parse the mac header make use of *struct ieee80211_hdr* instead of
extracting individual fields separately using pointer operation.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/netdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000/n=
etdev.c
index d2c0b0f7cf63..3fd8e008f733 100644
--- a/drivers/staging/wilc1000/netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -96,21 +96,18 @@ void wilc_mac_indicate(struct wilc *wilc)
=20
 static struct net_device *get_if_handler(struct wilc *wilc, u8 *mac_header=
)
 {
-	u8 *bssid, *bssid1;
 	struct net_device *ndev =3D NULL;
 	struct wilc_vif *vif;
-
-	bssid =3D mac_header + 10;
-	bssid1 =3D mac_header + 4;
+	struct ieee80211_hdr *h =3D (struct ieee80211_hdr *)mac_header;
=20
 	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
 		if (vif->mode =3D=3D WILC_STATION_MODE)
-			if (ether_addr_equal_unaligned(bssid, vif->bssid)) {
+			if (ether_addr_equal_unaligned(h->addr2, vif->bssid)) {
 				ndev =3D vif->ndev;
 				goto out;
 			}
 		if (vif->mode =3D=3D WILC_AP_MODE)
-			if (ether_addr_equal_unaligned(bssid1, vif->bssid)) {
+			if (ether_addr_equal_unaligned(h->addr1, vif->bssid)) {
 				ndev =3D vif->ndev;
 				goto out;
 			}
--=20
2.24.0

