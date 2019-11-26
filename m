Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6321E1099BB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 08:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfKZHyR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 02:54:17 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:27492 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfKZHyQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 02:54:16 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQ7pHh0000350;
        Tue, 26 Nov 2019 00:54:14 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0a-00183b01.pphosted.com with ESMTP id 2wf0g7scxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 00:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcia2orGQ0FxBnqbkg3GzswbhS4erVkohiK7ljwr3+b1oYXoSVJoFuPGpM1/LVUd2sLfpU0psJ8CDLtBkM4ILpjPpjod0VYuWmHmkwrMTGBrERE4zbrtUJFqjc++AfBSh+OeN2EmP9qs47HjBhCvPtmaeckS/VsSiYGKKbQcBbFo3TNHFEOP4U2r4+GGPLG2EhzkNnxDXt2URWc1yaYG6Iji1AyGcyiR9B/3D2Ei1cpjOO+fun0GXt5c/5p7zmIK4AOy7mG5IBW4fVmWywcu2LHh/5zfbsdwkxmyctozl+mQy7zgmih7fnLRpfgwTUyL+vT0DXCVgERTlBC6PTcMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU4bVJ3qjGe0ujFaAznhn+h9NWpJYWkWuEq4Bvuzycc=;
 b=acnsJjIfzFoPk9ItdZMbpdRzr5oCpr0KyGRTifbocx5AyWSTrVl3NYduvrlJfgm1jr+HXvDn82iBEbTZKoyLdMgc+ZTAVijfas7gyjcD1DaxfTZTxxbsys9bYKHGxXZixShZCrFbJDYSW5+4CDXyMJNAJocyIEM0eBcF1XoR4ABqypeE+G0UoFhTL1eaCoM8luFhop18tq3hn+4smMHICWvrQNuo8aURq+wi9hf1y+nY6O2EmOlw2hpSzFhx7B/mOjnNHJx++/JbnqzNnGs9itdXEvBj3tDwg20r/Kg9c8SBxXngvfDQx7xLa+zMG++tvknRyq/f1xAtUEBf/K1NkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU4bVJ3qjGe0ujFaAznhn+h9NWpJYWkWuEq4Bvuzycc=;
 b=hSE9e5fJaeaH+EoOQdyvwUp23XhH7FpaeZxZmvlBItBr3hHO5Waw8MT6q3MRG1n70unY5ngWZYobFiKPiJt53tK6vDoDkVdMuY62yAVfYbFCW5tecoPyPIidJyklPCFPl/kh+1nwdlqeTzow7evDabm/7qAlngcP4PreckeyJKU=
Received: from DM6PR05MB4075.namprd05.prod.outlook.com (20.176.66.159) by
 DM6PR05MB4043.namprd05.prod.outlook.com (20.176.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.12; Tue, 26 Nov 2019 07:54:13 +0000
Received: from DM6PR05MB4075.namprd05.prod.outlook.com
 ([fe80::4521:d313:f8c1:f217]) by DM6PR05MB4075.namprd05.prod.outlook.com
 ([fe80::4521:d313:f8c1:f217%4]) with mapi id 15.20.2495.014; Tue, 26 Nov 2019
 07:54:13 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB3935.namprd05.prod.outlook.com (52.132.127.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 26 Nov 2019 07:51:58 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2495.014; Tue, 26 Nov 2019
 07:51:58 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g
 chip
Thread-Topic: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g
 chip
Thread-Index: AQHVoHMR0ukm5y7dAE2j+TmxTB5e3KeWD/sJgAcL2QA=
Date:   Tue, 26 Nov 2019 07:51:57 +0000
Message-ID: <20191126075150.e2rrz3jqx627l3g2@bars>
References: <20191121135324.21715-1-sergey.matyukevich.os@quantenna.com>
 <20191121135324.21715-3-sergey.matyukevich.os@quantenna.com>
 <0101016e8f9afb9b-7e5241a3-3145-45dd-a178-8f4c9d5ff83e-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016e8f9afb9b-7e5241a3-3145-45dd-a178-8f4c9d5ff83e-000000@us-west-2.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52b3f80a-68e6-4272-5aef-08d772458312
x-ms-traffictypediagnostic: SN6PR05MB3935:|DM6PR05MB4043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB39358DA634761160EE73CA3DA3450@SN6PR05MB3935.namprd05.prod.outlook.com>
x-moderation-data: 11/26/2019 7:54:10 AM
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(366004)(376002)(39850400004)(136003)(189003)(199004)(478600001)(256004)(4326008)(6436002)(71200400001)(71190400001)(186003)(54906003)(66946007)(66446008)(316002)(386003)(6506007)(14454004)(26005)(102836004)(436003)(66556008)(446003)(11346002)(76176011)(66066001)(64756008)(6916009)(52116002)(99286004)(66476007)(6116002)(2906002)(5660300002)(3846002)(8936002)(81156014)(81166006)(86362001)(6512007)(229853002)(8676002)(6486002)(25786009)(6246003)(1076003)(107886003)(33716001)(9686003)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4043;H:DM6PR05MB4075.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2gJVGGDLb8PmzvBSELQAk7QqmdF3kATz5lk74tN78ceqpJfU+l2obLKRo55eoHw77kMxzyyTr9utQ41bhZGU/y4LhbgbXVH6DustESIIFOQK96EJoJRjtpkb2sdKvSJeKQgCZQiygtK6hBf7VXKNT3XzIZ+k1XAyElDn4gopAgcT65XdS8EVgwVu0rT4PnYqYKBY2rMOxbMGtfzyRGvmm5Q9ylKpCqGkvez2DLNqU8pt9R7H5fqYYEvUkCP2deevzLDCQhPrBoAS4V3ausL1a0U65aBPYGszsuJpIDwZm4bTBqHbLFU1+DneAluCe5dM40t2STc3ytktAo+rl3s8QYU/m7mXRAPyvn1dAK1LiFKsNQcsGzU4OGyQ+ooCseF+uyncK2QxD1Qp+IkTJf/oXgTKC1PFI8YmTtmlCnLiIJCZ3Qe/LcsRMdLao0fS9h8
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EBA2FA48B870B4282A0C055CBCFE829@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b3f80a-68e6-4272-5aef-08d772458312
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ow2TJl5oGPSTXOJ1GR1aqt+xSEMiFLiKpVv0sCWDK+rvZOdbh/Xisv6+W20foCxdpVt0kZw/OntMZjuBulXmUm3vM5eZ4AFU8/dToOFBrUpR/iFKMGkgXCRv0XgHjCaAYusx9+Mdt0ACNnxvcykzj4EMr4YlK+/SkcDonFK33A5hQriykJKDEUeSGC6HFw0bQ1y0/MX1JAPEi+nmM1/gfQ==
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 07:54:13.0449
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4043
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_01:2019-11-21,2019-11-26 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > Add support for the new minor revision of QSR10g chip. Major changes fr=
om
> > the driver perspective include PCIe data path modifications. Setup is n=
ow
> > more complicated, but finally more things have been offloaded to hardwa=
re.
> > As a result, less driver boilerplate operations are needed after Tx/Rx
> > descriptors queues have been configured. Besides, restrictions on
> > descriptors queue lengths have been relaxed.
> >
> > Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
>=20
> What about the firmware, is that available for this new revision?

Hello Kalle,

There are two drivers: pearl_qtnfmac for QSR10G and topaz_qtnfmac for
QSR1000. Firmware for QSR1000 chips has a higher priority since those
devices have been in production for quite a while now and there are
multiple products available. From the engineering perspective we are
ready to release firmware and SDK for QSR1000/QSR2000 devices. Now we
are waiting for the ACK from legal team. This was delayed by the
acquisition of Quantenna by On Semiconductor. =20

As for the latest QSR10G chips, we are not yet ready to release SDK.
The main reason is that platform is under active development.

Regards,
Sergey
