Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2C114A235
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0KrZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:47:25 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:42258 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbgA0KrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:47:25 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAgtPI020777
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:24 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrkum3urd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My5b8MWPgur56z7SlnFRejl2bShy0V9IafU3Eh7Ci/nOEWXMuR19ruVwVvkVfRbIziYAPtPuLh6HlC0dSb0Rn89sNS3WN5BRalvqcF0nHm2r96awSEY12ZMAkQvKvGq6fuCNHUWr7d0DDSNfqtKY49DXv3lqWYtIpsM4uhjRvSaPak3QDrTsgsraoyJSakll0CVbzgVE4f+YD+RxLL6tkja9wmBZwE5nrRikgEE4scl/GVDZGEXSMOCb32CuO6mon0ql0UCDhUj6JxFauRuonKpSXxpiTQ2b3e2hGUNeJ+R2+oy5Nw8dZHk4V2gTLeOR7Qz6oxRERNHW4ZwaqpD1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8Vx5AcClVX9MHdx+4NcJWC9TA/vFiRdEohjoSJwQl8=;
 b=N1OBTBNSVVtKT7UnhBTc1s/rPPhurXShJI//eEhwgTA0w9c0st1y/C9rrHjSH+2wBvi1aF1UKSGMhkrye3gTbwqAuPoGtJIUOuDaqfZbJsWL2Mzz67RUVzLI6uKZIcXQ6rPY63ElVJJtEJ9ujt/jpiRLqkRl1+OZk8tJbd+LD2SDdCifbcB7YrTCM+rCUa1oBGUw0mhGCF8ISYx0iWh/6443Z5M0yGqzfcNNDo24KIoQbwHsPjFsqeQZuY5HEQ/BVHxrdu4wr9QQEgGQn1JJYZAwil1rUfvL52I/9DWHgm2gOOMLaxB9I9XC2ESD+LJw7uQq0Uu5DwSyZPEPEgs1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8Vx5AcClVX9MHdx+4NcJWC9TA/vFiRdEohjoSJwQl8=;
 b=Ks/K+oRJFGoTRQ3w/Ku/5L41z+MiSM3NZav5fjpyubRoUjT9kQezpEb2y1EI7DrTZspL4jDmiXNvtBBqH16M57gS7uA2+hcnXE7aE0QJDt+bGVBWqnOQgyvc4zuJ2GFYJMNfsgbzDaUlWI/6ZU+rk5fAxPe0g72t7MSin07GKkE=
Received: from BY5PR05MB7122.namprd05.prod.outlook.com (52.132.253.150) by
 BN6SPR01MB0021.namprd05.prod.outlook.com (10.255.128.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12; Mon, 27 Jan 2020 10:47:21 +0000
Received: from BY5PR05MB7122.namprd05.prod.outlook.com
 ([fe80::18ae:e8d0:7595:722]) by BY5PR05MB7122.namprd05.prod.outlook.com
 ([fe80::18ae:e8d0:7595:722%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:47:21 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:43 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:43 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:41 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 00/10] qtnfmac: update firmware protocol
Thread-Topic: [PATCH 00/10] qtnfmac: update firmware protocol
Thread-Index: AQHV1P8Q27aiSkkzFUaFQq3QnQuftw==
Date:   Mon, 27 Jan 2020 10:46:42 +0000
Message-ID: <20200127104634.7248-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:7:67::28) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf1fa653-6b8d-4f3d-bc86-08d7a316327a
x-ms-traffictypediagnostic: SN6PR05MB5391:|BN6SPR01MB0021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5391FF27E3C3EA18B5666E68A30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:47:17 AM
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39830400003)(396003)(376002)(366004)(189003)(199004)(2906002)(6916009)(36756003)(478600001)(7696005)(107886003)(52116002)(4326008)(16526019)(103116003)(54906003)(186003)(316002)(6486002)(26005)(81156014)(8936002)(81166006)(8676002)(956004)(15650500001)(5660300002)(2616005)(1076003)(66946007)(66476007)(66446008)(64756008)(66556008)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6SPR01MB0021;H:BY5PR05MB7122.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBiAzOilJ1wlGsm4dOYIC/ESTds3OpIhYbw4VXU3DKnIRDJY3mCgYWp8wVtyi+Fk1B9HhdvhHvQvvCv/JcLUvn/T47/N4O13D0DQPmz9f4mxm2pt5b/X9Iz/tdvZf/IC8+hZOWq93zFjvZxZgUj3A615kIgMVvHrHgcd8AbU79LG+beoEiJnEvKXUtwLcajWe6SSWEjKVpiX42k/Dih6T9AaZpCe2HPkMcm8DPnHYxVoBpn2oYnmyEnGqORuK/wl/BwzbLweuUe5regDjdgOl0CMDl/a5Elj5+gI1qbK1hH5jRa62dfbrz7hB3tSh4M5nHx/qVHNNyA3ujiQ0i8cIibCL5upaeiE91AhliSEXMyk/5XwJHdG+MsDJx9qRVlG7efFXXcgyoFZ9B1wsXve8mBLcUTG34fT0EzfCmMZPek9DV37sod1sDAA1piFuGLy
x-ms-exchange-antispam-messagedata: AcGzUhgx0U+po31e6YtPlrvUcGgUe2/odeLFwtyuAXIrZIFpWW0yZ2QHZikCITlQ4qtYgFifYCZv4RfJiQVLq94IQ7x0mmm1uNNDpyCikPAeDCuVh1W8NWEc0lzEdwZ44nctTWiLFbDfSD+gxXkk0w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1fa653-6b8d-4f3d-bc86-08d7a316327a
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyMgCta7ZseJ/3hRXJYOyAHxCtf/N3m4ab8MZO/NVuk5dyh+Pk/Cz5K22LKjzpt4hghj3FkXlKH8dhCv6p5I4Fsd1pbSH/G1d/FN6mqyzAwuH8nwHN7GXkTB+faN/dvnT4HdAquggttlBKuNjz1HeKzwCJwB+AqAI3ghR5P6IZetseBo5KuqEKbcXN8QmZEXNlvVs+fLD4GdKBszEwpHIjam5EKl5olDqwFlqFIr2Lg=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:47:21.2508
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR01MB0021
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Kalle and all,

Here is a patch set with multiple changes and cleanups for firmware
communication protocol preceding release of firmware and sdk for
Topaz platform. Several patches introduce breaking changes to the
protocol in order to finally improve forward/backward compatibility
between firmware and driver in the future.

Major changes include the following bits:
- use MAJOR.MINOR firmware versioning
- improve alignment in firmware protocol
- simplify command flow: merge PHY and MAC init commands
- prepare for 6GHz: modify survey dump and channel switch commands

Regards,
Sergey

Igor Mitsyanko (9):
  qtnfmac: use MAJOR.MINOR format for firmware protocol
  qtnfmac: pass hardware capabilities in TLV element
  qtnfmac: merge PHY_PARAMS_GET into MAC_INFO
  qtnfmac: drop QTN_TLV_ID_NUM_IFACE_COMB TLV type
  qtnfmac: implement extendable channel survey dump
  qtnfmac: pass max scan SSIDs limit on per-radio basis
  qtnfmac: cleanup alignment in firmware communication protocol
  qtnfmac: update channel switch command to support 6GHz band
  qtnfmac: drop unnecessary TLVs from scan command

Sergey Matyukevich (1):
  qtnfmac: fix potential Spectre vulnerabilities

 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |  64 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  | 651 +++++++++--------=
----
 drivers/net/wireless/quantenna/qtnfmac/commands.h  |   4 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |  47 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h      |  26 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |  67 +--
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   |   2 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     | 329 ++++++++---
 .../net/wireless/quantenna/qtnfmac/qlink_util.h    |  45 +-
 9 files changed, 608 insertions(+), 627 deletions(-)

--=20
2.11.0

