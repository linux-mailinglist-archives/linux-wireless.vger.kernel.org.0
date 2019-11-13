Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B34FAF52
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfKMLHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:37 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:47384 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727736AbfKMLHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:37 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADB5OX5007583
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:35 -0700
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2055.outbound.protection.outlook.com [104.47.32.55])
        by mx0b-00183b01.pphosted.com with ESMTP id 2w7psq3cv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aziaMFEEtP0hShr64/tdlPj2Mns+/uY7KndLMYUHE0Rc+RmF0DC23p6xX5UeOHloZcD97b7F+hiWosyPaCnYaLwCar63lAcKUj+NkeTqNCL4aZYRrRtbKJyBABJY8Yjmg2QIliQOgQH9sg8faOfmgbp5wi1i0qpHYFoFHwqIsy6zcpggS/JEC4YxljKNLRuC+eE3sNTGr1YTzlPVKiE32AoTpsJYXSgm3AAKlOPZ8cyFnnDSlMbqr3zEPQSr/P53/rHu626AQob4WyAl+HZDzNRf+TWi0SkD5HwL9POSExZ+MalQ0YL9Q3xjFlgLEK9UVrR987/dKeYJ7ef6cmECgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwC+4/7RyPB93myol9jC6Yihnj7U9Oaz9/ZmoVeaJcc=;
 b=BXp9BDkl9EiYwZwodvCRUyYnbR32JRO4klU0stZXOdXKSx0IU5mXpsa7cBe9sKX+djydYXkY7sPWD9pbl+6v7qGjLRsRDl7PeITNsHkKsLdo7Wf8cXyQba0JPqIVb77ibeDboFKMLMwBPx8EZPNN402HfhceQt4TesSNO0Ka2R2u21ihvRC63E5BZ6dUmrej9KcsjPGN5SEMRVDMsTo0U6lSzWmhrTbGPlH6XwnV6LIEU3ypGwb3PP5UCcqAceeAgneMmPqmBmCBPBXuEmED6+IHVLe3Lp6cKxxOnhaUwRvYD1wfwVzHkk+ISENtAD5DH/UbAg+9CGlAWz0msxXJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwC+4/7RyPB93myol9jC6Yihnj7U9Oaz9/ZmoVeaJcc=;
 b=AE9AHjW08y/b27FoSagSGC9PqjrtJ4dG/a4/rIs6cNDpnH0rLgBRzrXCVPxgoGoJ0ZzTODWTxC5b/5C0ZcK+KbN+xJ7ech8vDorIeHCi+tdgmFyFkTzMREEVQ0MeSFKs2OWPLx7xELBr32ASLs3yKLu9xb4XGAaIQLq/zh9Cilk=
Received: from DM6PR05MB4379.namprd05.prod.outlook.com (20.176.78.24) by
 DM6PR05MB4555.namprd05.prod.outlook.com (20.176.77.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15; Wed, 13 Nov 2019 11:07:33 +0000
Received: from DM6PR05MB4379.namprd05.prod.outlook.com
 ([fe80::f525:b90b:9c2c:e569]) by DM6PR05MB4379.namprd05.prod.outlook.com
 ([fe80::f525:b90b:9c2c:e569%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:07:33 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5789.namprd05.prod.outlook.com (20.178.7.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:06:46 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:06:45 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 0/7] qtnfmac: misc features and fixes
Thread-Topic: [PATCH 0/7] qtnfmac: misc features and fixes
Thread-Index: AQHVmhJvyvKKPrMNm0q+6X+jtQgTqA==
Date:   Wed, 13 Nov 2019 11:06:45 +0000
Message-ID: <20191113110639.9226-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a71df02-f90e-44c2-143d-08d76829922b
x-ms-traffictypediagnostic: SN6PR05MB5789:|DM6PR05MB4555:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB578926EBCAE77DF612D9E232A3760@SN6PR05MB5789.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:28 AM
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(39850400004)(376002)(396003)(199004)(189003)(186003)(36756003)(102836004)(25786009)(66476007)(26005)(1076003)(66446008)(103116003)(66556008)(316002)(3846002)(50226002)(6116002)(64756008)(5640700003)(436003)(99286004)(66066001)(66946007)(386003)(2351001)(2906002)(52116002)(54906003)(6506007)(6436002)(86362001)(14444005)(6512007)(2616005)(486006)(256004)(476003)(71190400001)(81156014)(478600001)(5660300002)(6916009)(14454004)(107886003)(8676002)(6486002)(2501003)(4326008)(7736002)(305945005)(8936002)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4555;H:DM6PR05MB4379.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: We8VoFdjRFzKgzozao2Rb+AJ9UCCuxVKoZJfWYdOLjyXFy3cKejzVKMTnNtSGRTxUh9yA/yJ8SuS/adGE4QWdHEcWYnU9pLDi6fto4hVm5rTm0lQeJ8tY992oVnHf2IxhsiJCnq0i5wAOO11YkKR6pG4SUF1DTRY6sLFNGEv9yTLGCKN47KwObNQyi5v+B+jJEoM7wppC1cc41RTD3C6cwdbEE5GVuHER2YnnG7ytu+35vWN2Lz2tb4Bj0iOjq/3AquJfM/+O1SpTbY2bYoP2ZrDyW9XVhV1OmvWU2FIGfzJS+F+7hCXvmPIQ7qJD43jtE6WktfcUgKcJXnkvSc0CtKRBVJKL4uxRel/waIs+SJSxSt/IJPhckjCpTPLipR4wkVfBsqm02wwFQZo4f8Gvd7XBDOIF8/RPsfgiTyuZJYP4QvoA/qcQDL3AeCRPzBz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a71df02-f90e-44c2-143d-08d76829922b
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75qItCgoi6de9CwwhXRMaWlQeUs9IN1eMf9l1uzuNxpS1V+YXkNpD/aCo7e/BnlHgt3mc8TvsuYEAD+JzyjOhgj9mxdbZQUAalQmM3GegkNOSHHWfbz/O1kHXPgJEHXIErFGWdDMHFf2q7h4mDt6BBJidznEIs11zItsPWtAmde/Fvz5L1/pxkgnnlAD5wv1pRzQikBY+VcBP/f2nSdHF3PTMJoiSgKJLVa0kQZKeR4=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:33.5303
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4555
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911130105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Kalle and all,

Here is the patch set with misc fixes and minor enhancements for
qtnfmac driver. The changes include the following major items:

- get_tx_power/set_tx_power cfg80211 callback
- report MIC failure events to wireless core
- fix for 'use after free' error reported by KASAN

Regards,
Sergey


Mikhail Karpenko (1):
  qtnfmac: add support for getting/setting transmit power

Sergey Matyukevich (6):
  qtnfmac: fix using skb after free
  qtnfmac: fix debugfs support for multiple cards
  qtnfmac: fix invalid channel information output
  qtnfmac: modify Rx descriptors queue setup
  qtnfmac: send EAPOL frames via control path
  qtnfmac: handle MIC failure event from firmware

 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  | 41 +++++++++++++
 drivers/net/wireless/quantenna/qtnfmac/commands.c  | 71 ++++++++++++++++++=
+++-
 drivers/net/wireless/quantenna/qtnfmac/commands.h  |  3 +
 drivers/net/wireless/quantenna/qtnfmac/core.c      | 23 ++++---
 drivers/net/wireless/quantenna/qtnfmac/core.h      |  1 -
 drivers/net/wireless/quantenna/qtnfmac/event.c     | 47 +++++++++++++-
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 12 ++--
 .../wireless/quantenna/qtnfmac/pcie/pcie_priv.h    |  4 +-
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   | 36 ++++++-----
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   | 28 +++++----
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     | 57 +++++++++++++++++
 11 files changed, 274 insertions(+), 49 deletions(-)

--=20
2.11.0

