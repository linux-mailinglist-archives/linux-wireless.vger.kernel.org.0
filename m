Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEAC149FEA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 09:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgA0Ieq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 03:34:46 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:21822 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgA0Iep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 03:34:45 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8WrlG032095;
        Mon, 27 Jan 2020 01:34:43 -0700
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrhdauvqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 01:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNjkh3KU6xT7M+9SF4LkSfaTAKu+BPi/oKDRkZtlcul9RORW6a08koCPYxifQ6MphVvRNNQ7BjPK+4vWucoGGhsYU1Dsq1IGKJHZtV7yvQpSmL1Z3rpJWY+DQTnUVJgbI1rKh9IWFZOr7GXYHhRnMihfs8GzAFuMycDZ67TEJsX4hEqQMrevW8GunVRBJZ8z23xcB/Hgo/9bKrY43aw+U+HVDTYX5d/dfq+KV+anDM9X/EDepXMfHDpefaoqmypWBYCklc1dJteoRR3XaXvrzkC3lEHTICZeyO6olX9Z6yW70m4mw3aOkF4J2RD9UP5adheGNO4lHeisTKU2WEhsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmIxaClCXqbKf0OWKriORGM0x0OPXirjuMiFQE/obog=;
 b=VfGl365Hj90fjMtAbeztIurY/yiC9SFfFBTqXMiGfSs1JUGEp+uXLPPvbfht+icmJszs7k4TrzKzWboT7k0xQLBlvwuSgu4QuHx5kE+/fqIbdTcaDikUp13zbadRBKVEnaOySPIDcHVt4ADav+r2e6DjTDHpqiVNh6SUUh41gcD3szwl1tvH4KUfHSoI/g4pmm/Fn+7HdfOYemSUCSm1z+ygM/veY69HndJGStCC2iJxgqHMH1UdaftDRDNGOKuQX2iRQ+APMBh6+m96SXnLTUn4EwTsfJNYK/IpNHMSev+plYvl32WjUUqr9Ve6Mi5ghkcyCMo0OM2uvmcmRb86sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmIxaClCXqbKf0OWKriORGM0x0OPXirjuMiFQE/obog=;
 b=FHEKLUWhHEMsKxX2YjeSHkN49YI06ZtsTvtZgdtwKLPrfLQa7yghiQxWyNrUsN1kD46s29JmTyxGxF76ABgUkCJR3s1ZheNkSikE71AeNxCVz75GvXLnoFjfCva1CMTeIkKYMDovlqqzP+yS4gX/i9MX4OCoKJa1f6ntCNOw8fA=
Received: from DM6PR05MB4699.namprd05.prod.outlook.com (20.176.109.212) by
 DM6PR05MB5561.namprd05.prod.outlook.com (20.176.122.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Mon, 27 Jan 2020 08:34:41 +0000
Received: from DM6PR05MB4699.namprd05.prod.outlook.com
 ([fe80::6426:e842:87b0:de9c]) by DM6PR05MB4699.namprd05.prod.outlook.com
 ([fe80::6426:e842:87b0:de9c%4]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 08:34:41 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5504.namprd05.prod.outlook.com (52.135.110.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12; Mon, 27 Jan 2020 08:34:11 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 08:34:11 +0000
Received: from bars (195.182.157.78) by AM0PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:208:ab::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 08:34:10 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g
 chip
Thread-Topic: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g
 chip
Thread-Index: AQHVoHMR0ukm5y7dAE2j+TmxTB5e3KeWD/sJgAc+IQCAYUoPgA==
Date:   Mon, 27 Jan 2020 08:34:11 +0000
Message-ID: <20200127083404.jr6k2clfxgv7vxz7@bars>
References: <20191121135324.21715-1-sergey.matyukevich.os@quantenna.com>
 <20191121135324.21715-3-sergey.matyukevich.os@quantenna.com>
 <0101016e8f9afb9b-7e5241a3-3145-45dd-a178-8f4c9d5ff83e-000000@us-west-2.amazonses.com>
 <20191126075150.e2rrz3jqx627l3g2@bars>
In-Reply-To: <20191126075150.e2rrz3jqx627l3g2@bars>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0024.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::37) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 857e0356-9b1e-439a-bb83-08d7a303aed8
x-ms-traffictypediagnostic: SN6PR05MB5504:|DM6PR05MB5561:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5504988B4EE1B9A99FBBEAEAA30B0@SN6PR05MB5504.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 8:34:39 AM
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39830400003)(366004)(346002)(189003)(199004)(107886003)(54906003)(2906002)(5660300002)(9576002)(6496006)(55016002)(478600001)(4326008)(86362001)(9686003)(8676002)(52116002)(81166006)(1076003)(8936002)(956004)(81156014)(71200400001)(6916009)(64756008)(16526019)(66946007)(316002)(66556008)(66476007)(26005)(33716001)(66446008)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB5561;H:DM6PR05MB4699.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnExtZ0dUgKQcfCS58XvuIrlTiZkDkVMkGFcvioJJmE42l8Km4yzGR9+f96JZS5n7H0iCcZAbE4iLilQsc/f/97EqGZMre0vY+zVUdzSaBP6Tad8LiMYfjqVkEE4uZJzvaOb+in483ut/G97ZCQFjEiaNk4xopWdk7c40ndLOSkeaOZokuxGKCRbyoKkXAYtDjcpfmruwJsmaqxkFuSyV5r1Bn3M7+5iZAvbpU6ZTSVp5oip5kGPtLqQxNMCEItDA9qypQlrPrkh9Rew9ueXpR5Z8bdk6jAIH90v/DaUfzi4Y0QvKGjIDzou2XjmpHNjr/nvHiLaIYD18jGqd6rjV0TKMlKd0iPxL8IprWDB9axje3b65QCX43ddF0x2j6rBGfTZycVQN7G7NXYNXxjFlIWe0uqnOkRSf0NjuwN3YkO0TETen76ukQkE1YI2kKU3
x-ms-exchange-antispam-messagedata: 5jt6jHzx5IyzD/WzTe3ZQ6+dscRo4oJc0cvY9UzpxwzZr1P9DBVM/E3HrgMfKAgBiQdpz3ju/kVfa95SYsrv60pt7lPKFxqqP3ktfdD4fFAEp7cYtLe3MNalYQdZmJ2ULm+U6efRFYO6IY6WXPjSfg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06C2C9C066CFA94089107A56B1ADB156@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857e0356-9b1e-439a-bb83-08d7a303aed8
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VWdWKRu8spPOymN9IXtgaque4aCQr6Hmopke4r1xwZCK8mNs4XHBzpb/vheu+J5k+p18dru0bCfBlEkZqDBbW8fmloDPT9YPFLLc1rR+tS5JzP1ixR0xuduqaYrf6P7UBf6Gaf+QUgBTATNUTPWRIa3zktkm3VegDiDyu3ERVCC3MKEOtDunraevmAGM/0V2NcyAhw7YPmihTBw019vofambRtgd7ID1sfhbVWucuk=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 08:34:41.4608
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5561
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270074
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > > Add support for the new minor revision of QSR10g chip. Major changes =
from
> > > the driver perspective include PCIe data path modifications. Setup is=
 now
> > > more complicated, but finally more things have been offloaded to hard=
ware.
> > > As a result, less driver boilerplate operations are needed after Tx/R=
x
> > > descriptors queues have been configured. Besides, restrictions on
> > > descriptors queue lengths have been relaxed.
> > >
> > > Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.co=
m>
> >=20
> > What about the firmware, is that available for this new revision?
>=20
> Hello Kalle,
>=20
> There are two drivers: pearl_qtnfmac for QSR10G and topaz_qtnfmac for
> QSR1000. Firmware for QSR1000 chips has a higher priority since those
> devices have been in production for quite a while now and there are
> multiple products available. From the engineering perspective we are
> ready to release firmware and SDK for QSR1000/QSR2000 devices. Now we
> are waiting for the ACK from legal team. This was delayed by the
> acquisition of Quantenna by On Semiconductor. =20
>=20
> As for the latest QSR10G chips, we are not yet ready to release SDK.
> The main reason is that platform is under active development.

Hello Kalle,

I noticed that you marked these two patches as deferred in patchwork.
Is there anything else I have to do here ?

Regards,
Sergey
