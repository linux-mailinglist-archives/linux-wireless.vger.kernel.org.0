Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F6105398
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 14:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUNx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 08:53:56 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:8302 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbfKUNx4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 08:53:56 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALDrtSM002401
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 06:53:55 -0700
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
        by mx0b-00183b01.pphosted.com with ESMTP id 2wad7bn9j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 06:53:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQBU1+z11MyKv3C6hoyda554rqf146vz6/P3ZCgUqEUxwnn8m+03etrJjNUojPySsN0Ve0A6hGEAny5ZwrpGYFSzeoOe4mWEEPwGN9fbtm+ja2ftdSL3NJIO1J9+pHckaSMPREsC7KOXSbY26m/nb0zv6yJdSWwgqwxidFhGASHqc20GEMucAZM3PLTfqKMrPXWTS+FfE/sHd8tJ0uFKuYQBncIbKKeao5v+HcHXvMvk9QCbci4un6z4G5qnKVHLNZo1F6he8cfyrmCaPhcbrlh/8/3MkW8lArVXiQiG6t/iKe7ThgL/mTj8rRDUKIM2JJhOH8Wi8W1A6HHQEGaYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFs+kloQiDXruONenYUBBZUhshQN8SA7BTMQoDEUOcs=;
 b=Yx9jCceRXCNjGRGJffwObtE7pN0zUagCI5ZlbLLh0oYeaEdnshtusGJ2G1LDqOsa9MhkxJZGL57+dwReYdlZdBJPV+wJbMo3BRi7myO0n7sAvlBX7GL11ssOMepgcKlrezoUyneQitIY9ODdJpf8gCblF/auCPo0lWGVPotZfI/hTiiL61TAEgumFibkWb0yzIqVZ8lpi0vO7LDDHVUaEr2nIco6d42pS/XNq25m6LuLZkjOqxyEALJ4aVH2/9mL56nRZxQIpAIM3C22SmbBwuXrlZNuRHchYRgYI23ysjtYTugVobELciuz5JHn5vGkg2PTE2wcoQe02v7jCokRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFs+kloQiDXruONenYUBBZUhshQN8SA7BTMQoDEUOcs=;
 b=Ayd8ky2Qf6260yTKZInksM42vXO7HTnEtLFpj84i+9Hrj7F5+E+8XMGol/90PlksEtJ5ytOc9Gn6a+cm/v8mc2YVEvQ+u6z4zv9/akK9SrWoKV9g3HDw+l50UCTdpsIRNIXK3AD4QZ7Q0WVwho60eTG8GNqeXh3QZCuMHg9ydfU=
Received: from DM5PR05MB3531.namprd05.prod.outlook.com (10.174.191.22) by
 DM5PR05MB3354.namprd05.prod.outlook.com (10.174.191.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Thu, 21 Nov 2019 13:53:53 +0000
Received: from DM5PR05MB3531.namprd05.prod.outlook.com
 ([fe80::c4be:8e71:f4fa:577b]) by DM5PR05MB3531.namprd05.prod.outlook.com
 ([fe80::c4be:8e71:f4fa:577b%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:53:52 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4270.namprd05.prod.outlook.com (52.135.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 13:53:31 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:53:31 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 0/2] qtnfmac: add support for the new revision of qsr10g chip
Thread-Topic: [PATCH 0/2] qtnfmac: add support for the new revision of qsr10g
 chip
Thread-Index: AQHVoHMOFOVpIstaXEa6TPexCDqNBw==
Date:   Thu, 21 Nov 2019 13:53:30 +0000
Message-ID: <20191121135324.21715-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:a03:60::32) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ae283cb-fb3d-4a71-6efd-08d76e8a3118
x-ms-traffictypediagnostic: SN6PR05MB4270:|DM5PR05MB3354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB4270CF8D6D740231E60D0B43A34E0@SN6PR05MB4270.namprd05.prod.outlook.com>
x-moderation-data: 11/21/2019 1:53:50 PM
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39850400004)(346002)(366004)(199004)(189003)(86362001)(71190400001)(66946007)(71200400001)(5640700003)(66066001)(256004)(8936002)(1076003)(14444005)(5660300002)(4744005)(2501003)(3846002)(6116002)(103116003)(2351001)(50226002)(54906003)(66476007)(66446008)(64756008)(66556008)(316002)(186003)(8676002)(107886003)(6512007)(14454004)(7736002)(436003)(102836004)(36756003)(81166006)(81156014)(478600001)(4326008)(6486002)(25786009)(6506007)(386003)(305945005)(6436002)(52116002)(99286004)(6916009)(26005)(2616005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR05MB3354;H:DM5PR05MB3531.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXq7VGmb+CjUI/ccyyfiMEsWxArVZQn++xO/dnV8/te5crWeEvWmoXwmQDa53TQ4SNLJJavV57XEvbgGZ38VzNeRzK1TrF92dKtwqNXZZhaxjMdXxQxv7cE160SIY2iXC5WOhrn/sMivyIGk/i3vzRZ+qOWVcAu7UHl4+0ODAD9S4NEvBzvmKXbdnkHsssc5QGL6k/MOC5pwNd3EgVDzQI8iL5eKTBpeE7+iAn+5LdXRkdxOoOBFqJ+pes4imujojAatIXBQooj9YPTYQrTl3pm7XaCvpnVGjmeB3I0wss2ASaE1obv76W8MMMpOP/9RHElKSGgdImt4TaYBEhZb8VSOpEeUZnpZi7sqpogSj8nM7louzbTc++NqteSg3CZ/2NK++WR85PMARnuqhmOz1IwaKXadAP+hSdFaVtJ0MwDGItQFO8wVv+0SmUv2e1Tr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae283cb-fb3d-4a71-6efd-08d76e8a3118
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vh/LoCyQo9lo00Y1nVCMBgQ+679Rk74Xq6xWv5vlsieczdmqjA34Ev0gS5uOVqLHzzuB95m6i+feO7mBDl3y2hJ9jbRfsRbpFPNdZ3IbaJtqAF8YIIXTZ+M70gakI66+wyssuy7c3C/k1y3V4faBaMxLMSVRJe7uFK7WUkytjh0QROYash74GFGwQsecAg6vesBT3ztd/imvH5Uw3nvUdgSHQWBhHNOvWGV83qoD15Y=
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 13:53:53.0137
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3354
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=735 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911210126
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Kalle and all,

Here are two patches adding support for the new revision of QSR10g chip.
Major change from the driver perspective is a PCIe data path update.

Sergey Matyukevich (2):
  qtnfmac: refactor data path to prepare for the next QSR10G chip revision
  qtnfmac: add support for the new revision of QSR10g chip

 drivers/net/wireless/quantenna/qtnfmac/bus.h       |   3 +-
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |   4 +-
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   | 629 ++++++++++++++++-=
----
 .../quantenna/qtnfmac/pcie/pearl_pcie_ipc.h        |   3 +
 .../quantenna/qtnfmac/pcie/pearl_pcie_regs.h       |  33 +-
 .../net/wireless/quantenna/qtnfmac/qtn_hw_ids.h    |   1 +
 drivers/net/wireless/quantenna/qtnfmac/util.c      |   2 +
 7 files changed, 517 insertions(+), 158 deletions(-)

--=20
2.11.0

