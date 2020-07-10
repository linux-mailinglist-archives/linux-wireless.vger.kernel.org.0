Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AEB21AE7A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 07:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgGJFW4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 01:22:56 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:1798 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgGJFS7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 01:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594358338; x=1625894338;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rYxzQy0cspwcSuJu/MRmXxavFN44a4qObx+dq/N0WZo=;
  b=qcB4Hc8fZ+Bec6i2ipzsBmF/H9vSsndDJreKcTmeA3oY2RNjbDyvJb+x
   1oP3oxINTqeu3qOq5ScHzryugAtFEq6A2hC6QlBwa39iAF1nzu0EHZHHg
   c5uoRn0ysjWwjEvlkx8eSfaUFatBXwzYYKodC6pbktTN30F1M/rZVXSSk
   kfH3YIXc9eyDoAKmRGGVgGhQF6+PMHT9wCB8ccakasiueCY/Ufp4btXyL
   REAIs5KSVhcBQzBHR3QsukE+5Cu4cVSNy7LyB9xovB824fwSOUcZ9rUqb
   C121o0tZmWfqH5VKVhiTez/R8g8Y1SR6E7E6qyrRmlmcHk8S+qkZO6UJ+
   g==;
IronPort-SDR: gWluvvcme1U7Wkx5z59w8EAELbkNOJwWei1T+fckrZ7uYZ1rA1tqDreFZE0cQFw4kKew0B4SXd
 OreSPSas0yN3/iMhqPiaTlu8mtyOzEmKX+mcwziJ2RpkpqsnfEyEpjNeUUrg1XyQnc/1GGUwsJ
 BTxa5UbPFsjBDRuuuQyd4B52Afy/jVuB2/bBsVRlDisOULn1TgohHdCSGzfeVDwbc3Q5iF1+h6
 RL9RVESFIQVmj/mhPM9Yi9mcauk4OFUfUZflZqRO0sGsxfLae5f0JSwIidAQT2Vktw9DuduJvt
 2eA=
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="18638117"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 22:18:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 22:18:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 22:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqbQbTJmxMUy1uOBPoUMxGLat9W06Adl5FvAPVMx/pMNGGd/eNQcCR0swWqxbpmpmcZwuQUJxgnaRqlyYTNC3S+U2LKSMyFQfVjBUjuZzINbmhKHfLtf0WTWiZ4Hpz6aBlz+mQm6CSmFPFIJFQhSU3oSseu17bkJDLXlkOD3rO7wy2Aua1OW7TIEXzZF3sJz9TOXWZ67UMujrDwIUfbw01uwpLGMBNXXlNTW7GG6TESzSWXCeKwCKhESVPvAvbkWeqv0rF2t1ZB3biQyBHScYETtNVuHoj2PInP6FyYdEIvLwvU3+L9MFe1kFND/UAOcoFe/RurdVFYP70NUT4EMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhe1JN2EMUGnDta2y1kvbHtxZe9ubcSDj6SJNbULBU4=;
 b=EnXVYK6nWpo2AB3jb4pnnpXoobW3NifLgrUnb6RO9gzhRCL/z6bi3fPmQqWtnloJJVRUWiTduUi/5q1/NBkmF4xMP+yRzqx2fb99QVQezBr8wjc6bXStBSnLQJ4scgbfJzasArV1Odj9XE5Edb/rxF4ILd1vP1Kk/QzrrbbjpFnsBuz2YI2b+7kyfQHhL5Oxf0zOP5wZGDfOWmPBVafbe8bxcWoP3GNqSKnE9ngLoaBn6ZVibSP1+n6+Iem6j7k5wps/AAPOsxtdrkTMJKlbDOVHJlo2DBdjdzojy8vhzOSif1RFRuVfusc1pEQyppSDgFt8xrgy6gjpN8MRGOU/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhe1JN2EMUGnDta2y1kvbHtxZe9ubcSDj6SJNbULBU4=;
 b=tkaMcu0VecbX1pPL4iMr/61PkTZnQLvR9yILyNaHFIIUmS1nsiuk9C+CUGvIc+2tYCgXdFoHdDkRHZG9aqJCYW2K6w1RkZe1Uj8PlCcsoWgIDAumGTAeE05tBEckRCfMged5SYOrky5sBook7Mxt3cHGSTK3E/MIy7DWiBvUH/w=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB4128.namprd11.prod.outlook.com (2603:10b6:208:139::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:18:29 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 05:18:28 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH wireless-drivers-next 0/5] wilc1000: udpated MAINTAINERS &
 minor pending patches
Thread-Topic: [PATCH wireless-drivers-next 0/5] wilc1000: udpated MAINTAINERS
 & minor pending patches
Thread-Index: AQHWVnmLnEVo8MbsXUi0lvxOLvHN0A==
Date:   Fri, 10 Jul 2020 05:18:28 +0000
Message-ID: <20200710051826.3267-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.205.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5685735-0f96-451d-c59f-08d82490ae39
x-ms-traffictypediagnostic: MN2PR11MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB41288D6A418FDF82270D40C4E3650@MN2PR11MB4128.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2etClnU/cWpl22tYCnG8R154nJ+cKosR3KDI0430BysCHcFZXpknFQBG5MbCwdw3YGgstsqH6gRJwBMNDBpDwWcnEPDb8ftf+FfI/h27CuAFtl/McmaplAZtm9ttqb56iQ+oqdf2/hIJ/JzpJtdc+r2WqE5iz14f2UsbvyuTSG2yTFa47Tda1G8sfNOmDKv+nl0lonG0G5lZrvAcbJEClcvjS267vWP9jgWDWwx0RCAWPDPGloVe+Y8dYd7HhdoCskxGVUoVGJcCr6Ro8xvkwNZmFGZc/QvGaZXY1p4MI76vV4q2x6YxL7ZozQHfiillZSy/lWJfbjseAKRfH/DPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(2616005)(4744005)(36756003)(186003)(6512007)(26005)(66446008)(66476007)(83380400001)(66556008)(8936002)(71200400001)(64756008)(8676002)(6486002)(2906002)(4326008)(478600001)(107886003)(86362001)(316002)(5660300002)(66946007)(54906003)(1076003)(76116006)(91956017)(6506007)(6916009)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Z/oh+E1ef7IVCyLQ5Q7qTm8ObkZK7YECSEc2Y5hsyjdr3Wifbb/zUZsSSwToEst3KaFnsSqTsS8IMmSdM/EVnvCmVubm4maxl7vS1vF9o49vQm00duLxfMTwra7bZwbF/QDmQ+egWC9pRUbIcB+19Yenoz3keJYFKU6W33jq3Q1SE52pDD9msj5kakJE9HMeFfrWFc5Q9NR3WS3SaBNbmsAPsJMFHeQg8dK3op82MUGKZuKrgMNqbumNuMIED5FLFro62D5mTnvL9kzJj+5zIfzGZo51IIJixH9GXT2yczl0PBrt8d2Sh3Fv8mLziTwLQizoZVYGxrSHkll84X6GIyuUSP8F3NpyFnVJXSmFyenhqrXYtmPX28VgosZRRKLPucgF+Po+Z7EIujdARvBxJYsribEWK/uwIv/JWRmEP0MeJpqQ3HK0ihfQvcVSLOeDpHORchH41VtjwB+K/rLEoOkTSKyWsIta4OGtjcj8SZA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5685735-0f96-451d-c59f-08d82490ae39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:18:28.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bsPBT2tdKXaTFdUhEnsKTUY18PatZqfh/Bi7OzuYjW94OcYHghIuhwQcMCN+5m9u4cBEhz4qOJvr7MxkRRCqalEApsMM2Ca/c2uE2Ft/hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4128
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

The patch series contains below changes:
 1. Updated MAINTAINERS file for WILC1000 driver.
 2. Fixes for gcc warnings found by kernel test build with different config=
uration.
 3. Use of single FW file for different WILC1000 revisions.
 4. Added API version number along with WILC1000 FW filename.

Ajay Singh (4):
  wilc1000: use strlcpy to avoid 'stringop-truncation' warning
  wilc1000: fix compiler warning for 'wowlan_support' unused variable
  wilc1000: use unified single wilc1000 FW binary
  wilc1000: use API version number info along with firmware filename

Nicolas Ferre (1):
  MAINTAINERS: net: wilc1000: Update entry

 MAINTAINERS                                   |  2 +-
 .../net/wireless/microchip/wilc1000/Makefile  |  3 --
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 ++
 drivers/net/wireless/microchip/wilc1000/mon.c |  3 +-
 .../net/wireless/microchip/wilc1000/netdev.c  | 29 ++++++++++++-------
 5 files changed, 22 insertions(+), 17 deletions(-)

--=20
2.24.0
