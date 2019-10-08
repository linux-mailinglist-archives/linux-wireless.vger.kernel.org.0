Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0BCFE88
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJHQIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 12:08:14 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:46878 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfJHQIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 12:08:14 -0400
X-Greylist: delayed 933 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 12:08:13 EDT
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x98FpXOk001143;
        Tue, 8 Oct 2019 09:52:04 -0600
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by m0059812.ppops.net with ESMTP id 2venqwtm09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 09:52:04 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0ZokT7nKLmmXiWynRpd9Av5u63SK0PRHvmvs5ougIkR8HYi3YnBcU/ZfWWlhxT6qOk9KWle2PsB0L/gk2KEhImWzvUp2oh3zDvLNpOp14oWVH54Quv1/SAjrfyk+HH0srCOMMA5WptkXziuVRoDXTZwxpixHtOfSsSrF4U+4m8AyimiV9nEQw6P3f8MdKCG+4rsyOBdzrh5U9Cm+gBUGbr5VU1FHeFkBDEjz4xsgdOEfa1uVRvPfgMWj6Rj3z5thFuLbW50p1a+pDe76jcHA8JwfYSyX2TZ8bTDwPOqR2BFDN/u4HmQOIuLlbCX+ZpFwf6IIrYGpz6YOSjm/6xEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QxiTdFrH8ZrQCYqAsPNiOOeUNS86sYtO1PENDAtA3M=;
 b=EcCw4id3vBDdsxd6qeq/fHmyZzbz+sKtACXdOaH1eKLpyAu1cZ/PEP0EBxC/K30msDZxTzzwnUxwHwdlrVSVaZrk7WdocQYt1aZ8ONRlZpuqx/ToMoL4ABW6Yq+OIjz+Vz8gtHUbLX++xm5RkJ4xXG/j9IjVDF9Dp7kccA5HQlNyvdP7JrcsfYHzLSKrdPX7wlvdqXJ3FI2f8nYquuuhXixtC89AD4XgYztqkNtMXuZ0i+IRAE6wU2VVkzVQM3GUMey1LKi8wCQkv/b0DkQebJhMNiTRVmv8/j4lvy0jYJfbiCUKakeWyM2kaxBsVx01+5FMiG1nhlO10Y4d+BNaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QxiTdFrH8ZrQCYqAsPNiOOeUNS86sYtO1PENDAtA3M=;
 b=Mdz8LM7cwugnhX2bQOPWlAtXewOFkuFcbdC0bl8FdgAAxFjzjzwWEBbz3haJ1c3QYfKqEkcgCsbeJ0QezeTo8vsrHlFFftfL9AZyWfTzJkp3pCct5VCpGA70kR1bR37fU8qsPCTSZ/8bgGj+kM/7lJGA/MxGYIQZoh55Dq2oKLE=
Received: from BL0PR05MB4980.namprd05.prod.outlook.com (20.177.240.95) by
 BL0PR05MB4755.namprd05.prod.outlook.com (20.177.145.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 15:52:01 +0000
Received: from BL0PR05MB4980.namprd05.prod.outlook.com
 ([fe80::d985:a815:2bb1:327b]) by BL0PR05MB4980.namprd05.prod.outlook.com
 ([fe80::d985:a815:2bb1:327b%3]) with mapi id 15.20.2347.013; Tue, 8 Oct 2019
 15:52:01 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5856.namprd05.prod.outlook.com (20.177.255.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.11; Tue, 8 Oct 2019 15:51:37 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::5e2:2496:7e6c:9ffe]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::5e2:2496:7e6c:9ffe%7]) with mapi id 15.20.2347.014; Tue, 8 Oct 2019
 15:51:37 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Luca Coelho <luca@coelho.fi>
CC:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: AX200 crash on udp upload, cannot restart
Thread-Topic: AX200 crash on udp upload, cannot restart
Thread-Index: AQHVeWK7lfLyaQmgIE6Wn0ukW5sSyqdQlOEA///UxQCAAAIegIAAgfkA
Date:   Tue, 8 Oct 2019 15:51:37 +0000
Message-ID: <20191008155131.tyeo27aj77ztigv7@bars>
References: <08f29d02-2fcf-e779-6fc0-ea7a9d4e59b6@candelatech.com>
 <20191008073330.7nuwzwpwgzgjfswm@bars>
 <df659853170ddf7a309c2f132eb749a35fbd8caf.camel@coelho.fi>
 <ac3ccd1eb498629b771645829ca080b642cffb36.camel@coelho.fi>
In-Reply-To: <ac3ccd1eb498629b771645829ca080b642cffb36.camel@coelho.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f499f2e-9169-4094-87c0-08d74c0766ed
x-ms-traffictypediagnostic: SN6PR05MB5856:|BL0PR05MB4755:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR05MB5856A7134A76BB7E93AC955AA39A0@SN6PR05MB5856.namprd05.prod.outlook.com>
x-moderation-data: 10/8/2019 3:52:00 PM
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(396003)(376002)(366004)(136003)(39850400004)(199004)(189003)(51914003)(6486002)(316002)(6916009)(6436002)(8676002)(86362001)(81156014)(5660300002)(81166006)(8936002)(14454004)(478600001)(25786009)(229853002)(1076003)(966005)(3846002)(6116002)(6306002)(6512007)(9686003)(2906002)(305945005)(7736002)(6246003)(4326008)(476003)(436003)(11346002)(486006)(446003)(33716001)(99286004)(64756008)(186003)(66946007)(66476007)(66556008)(71190400001)(71200400001)(66446008)(76176011)(14444005)(52116002)(256004)(26005)(386003)(6506007)(102836004)(54906003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4755;H:BL0PR05MB4980.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ke2F5ytvdL68BmD0nGij4WtppBgcr6k4iJeqS4hNTNX1yorG6bSscfZj6ZAy2CwUrcKNezzl2HzlISB9rleI9xAW9WyCZ/Mt6rMzU7Ryq8ZkiRCxCe5c0Dg0tYV5YrYMrUQ5XnvruA6oWmQyz9qi6XS+77cWhGJHgE3czGQ2aqIFN7EqcG0LqfwYGGS2+ylEQc5QxsR2gXjtFaTe72jy8ZUkAbBwm6ryK0wzxsPposiEW4T2L1wyDhhI7/L+19F41L3wiJQEtE4H8xt25CM2eEwFUX4XJH3oercLt5JDHPT/FbxVmSDlZ6J1sdXHb185lm83RpRyUA+BU8oZnfDpUD+kL/ATbdmq0Ibd0OudHkm8Lxl4JwqxiMYz5kaAvkR9LSr7r2tB+i6OtsTdIYK+tzC5NCxXKwASxuiB5f2zroTtHAZ3CgxhGXXLaaRR2CTNqzrOLvs7ROa+HN5jbMRl1w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA28AEDD70E2F74F93AB98C98513CA1F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f499f2e-9169-4094-87c0-08d74c0766ed
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3H8heL/qhEVOPQNQGflhjWK3urjtmBLbU8oFEvmXnwi1+rbcbw6ABinNEB66VGP1gnXgpdSXdchfH93djQMJizLJgGxg1Qz2GEw5H/DrG68VVFYpEmTa3992mM0MVnNE3OfiQ3Df9XcKcZdWzwbsQ==
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 15:52:01.7631
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4755
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_06:2019-10-08,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910080137
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > On Tue, 2019-10-08 at 07:33 +0000, Sergey Matyukevich wrote:
> > > > We have a system with several of the AX200 NICs in it, kernel is 5.=
2.14+.  We ran a udp upload
> > > > test of 10Mbps across all radios, and after about 10 minutes one of=
 the radios crashed and could
> > > > not be restarted.  The others continued to run so far.
> > > >=20
> > > > I will open a bug in the kernel bug tracker.
> > >=20
> > > Hello Ben,
> > >=20
> > > We observed similar issues in our tests as well. All the details
> > > have been described in kernel bugzilla issue:
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.kerne=
l.org_show-5Fbug.cgi-3Fid-3D205061&d=3DDwIFAg&c=3DMHZppzMdXMt3JYjCV71UsQ&r=
=3DRFH8dgrFzz0_hnNXpEl_u3TZqD-B6kYLzfvbDuCKw3U&m=3Dopeh64GEVevn0071vriL-kH2=
B_orc25yacBPa3YdgLI&s=3DCKuyBZ0VdAQocDiZGOIDyDC6GG9w4E7OikmGvzblazU&e=3D=20
> >=20
> > Thanks for the reports!
> >=20
> > Ben also added a bug in bugzilla[1], let's use that one for tracking
> > (I'll mark Sergey's as a duplicate).
> >=20
> > This is a know issue and our PHY team is already working on it
> > internally.  I don't have much more details at the moment, but I'll
> > update the bugzilla entry as soon as we know more.
>=20
> Actually the bug Sergey pointed out is not the same.  It's a different
> sysassert, 0x103C and it will be investigated separately.
=20
Hi Luca,

By the way, could you please clarify if current firmware for AX200
supports 160MHz band in 11ax ?

Regards,
Sergey
