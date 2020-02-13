Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8615BF09
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 14:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgBMNRF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 08:17:05 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:39400 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729557AbgBMNRF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 08:17:05 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DDDDnu000530;
        Thu, 13 Feb 2020 06:17:01 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0a-00183b01.pphosted.com with ESMTP id 2y1ufxey1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 06:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmNU33Hhp5Ddq6wuf6jPMKza7LFUY40gtSDQL5sPAsuVmFWXaokkQrU0wLPfuXJl5l1fT+oI6mHX1F793uzEh6x1QQ5OVGfa4rqy45y3JGQzmA5tk/ZZFUesrYAe30c6rI9uOv7BfPBAZqnYfZ/8oa9Dnxy0didRTY4gtWSCdbVQtZ8AoW5J/XG2dyCedPR15LrNZl9LxmiSb/urB3CSFzR3YMbh8/GUNrseAKf3W2+qgD+qXG3KKZ0xCaKfopKzXh+dUWjd1iAVNBROa27JR1LubBlK5ZuwcoLkOLehUt/ILDdJSoQ8hwuXoSwagZOjYtEz0Whvom0tC4j4EAENMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMr8PgUwBmPdQkiiIe7OBNd7oHd8SYQxHPnHLaZMR3s=;
 b=ZsX3PuJrLaX8ezwO9gyov5ZHQj281aPwE6v77Ky1Df9bHAOoyti9EOmmfPcb4BTnqczLo2i6254e0ipjhtsYAhPWa8xdQMi23uvwM1fBmb4XoJWwVutdHdqrO5y6nr8Rjhq0n4VkljgQP1CzMTbDwtc4cfTO6HrveSG9XqYkEd59AMupVpdadcP61s7ykRozjfqJZwtxjcO1WofAOAnzU3uZX57UZ0GO2PhLiTPsjVcedKU04cMtxbEPeGiXQvwNS9poXsKo3CphgsnmKcEgn9rU76CEOiTfngWINzi+/1z5ja0rNvGu1K627Z17KjiwVmfCua872zGloi1cjmHB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMr8PgUwBmPdQkiiIe7OBNd7oHd8SYQxHPnHLaZMR3s=;
 b=pjaJ1ZdM9kVdwXM8nl5klDHqYCVdkCJH/iyXCI32YJP9P26xEKZyxu6vvYmxZviqDQ1g2/+2gyqfPYyms4vAVQX5DQqbNexHG60k4TfP9c36HjMH80Ge4RiF1V4lp9l3V5y44TP6Je3gF2DzNGL4ljMuI5F0pWd49OA9aQqFUZo=
Received: from SN4PR0501MB3822.namprd05.prod.outlook.com (10.167.141.33) by
 SN4PR0501MB3725.namprd05.prod.outlook.com (10.167.150.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 13:16:59 +0000
Received: from SN4PR0501MB3822.namprd05.prod.outlook.com
 ([fe80::71ce:3d1a:a816:a7b5]) by SN4PR0501MB3822.namprd05.prod.outlook.com
 ([fe80::71ce:3d1a:a816:a7b5%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 13:16:59 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5152.namprd05.prod.outlook.com (20.177.248.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.6; Thu, 13 Feb 2020 13:16:15 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 13:16:15 +0000
Received: from bars.quantenna.com (195.182.157.78) by LO2P265CA0472.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 13:16:13 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 0/2] cfg80211: minor updates for WPA3 OWE support
Thread-Topic: [PATCH 0/2] cfg80211: minor updates for WPA3 OWE support
Thread-Index: AQHV4m/EgktByQbQIUG5k5thXdlW9g==
Date:   Thu, 13 Feb 2020 13:16:14 +0000
Message-ID: <20200213131608.10541-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0472.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::28) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08a6c600-4d08-44be-3afb-08d7b086e71e
x-ms-traffictypediagnostic: SN6PR05MB5152:|SN4PR0501MB3725:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB51525D4DB3AE68A04167A60CA31A0@SN6PR05MB5152.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 1:16:56 PM
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39840400004)(366004)(396003)(376002)(346002)(199004)(189003)(7696005)(103116003)(5660300002)(4326008)(16526019)(107886003)(66446008)(36756003)(66476007)(64756008)(66556008)(2616005)(956004)(26005)(186003)(4744005)(66946007)(54906003)(52116002)(478600001)(81166006)(6916009)(6486002)(316002)(8936002)(86362001)(1076003)(2906002)(81156014)(8676002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0501MB3725;H:SN4PR0501MB3822.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12Ucd5Wr0eYUFJYBTqVV3U+wQhcZ47eTGCUO+SquChC/8//NSW2pd3s04LbE0lKsJ2ma6LvDrWWXCSrXHCX2J/LVW8Si5BXhhfttPiTBkN8Adn5evpvlqlLqj1uMYlyOlOjlmsypczpD0j6dD6kuXOKJWnxZ4wZbNTqVxZ9sMagbg5N1A0o5yuUqVcUB8wPWMAustjOTfQHAS+0PUrQfOZiweG8uXnD5oQ3zPRuZHwd9ha25W6rw6A01MY0BYcF3HBu1sLc+4LIXVzepUeW7kGLOJL4xgy5iZ9ZS0gcHHYXHK5ViTg19KDRW3Ow4NtMRRNGu2lzd/YgEeseNZDiiZojQnsnzGK9Czfy29lHjGc8LNpeSTuEuj3PuwuuFIjzLzvSftl78uqBJlwWhEdVHbx0iENvb1UUNOxrP8mInhbnrrMBXzv/RqhTvonEgXijH
x-ms-exchange-antispam-messagedata: DrOMW2eFUjtanp/dlMRGPhrXWt2OyMtEh7Sz41qvF2SzGm40ft5A7QIkjDXL030lasHgoSS8+E6xVu4WkL47Q6BSloecYT4dRipK5F9VTRzBkxCXOY0fccwhFpeCZelMP/g9Un4O/Db1buA13PQ74w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a6c600-4d08-44be-3afb-08d7b086e71e
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Icr3j1zez9Huvw3pMGlcjlSm8NbTv/6LxWWkWTEA4S9qK5znNP5aLLFDQjVNs5BowXE+Z1S0FCMKqm2uREz7YXgyEHV8nU/XElEKVx0JEtZXJmlKxnzhY+3R1HYVlIz3s0XM/hcEGtNicUkw0Bxq+/HRuxQuTVkDX4O0pq7iuL/P+HxHB2bLgUCdqw6O7emeudEgpnQtz2LEothrGtP3rOsdz1TISbOkKEawJ0kS4CE=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 13:16:59.3550
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0501MB3725
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes and all,

This patch series suggests a couple of minor changes related to WPA3 OWE.
One patch adds definition for OWE AKM suite. Another patch adds missing
validation policy for NL80211_ATTR_STATUS_CODE.

Validation policy patch fixes hostapd OWE offload for SME-enabled drivers.

Regards,
Sergey

Sergey Matyukevich (2):
  cfg80211: add missing policy for NL80211_ATTR_STATUS_CODE
  ieee80211: add WPA3 OWE AKM suite selector

 include/linux/ieee80211.h | 1 +
 net/wireless/nl80211.c    | 1 +
 2 files changed, 2 insertions(+)

--=20
2.11.0

