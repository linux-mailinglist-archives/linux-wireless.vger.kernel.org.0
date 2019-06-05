Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5183B35980
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2019 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfFEJQD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jun 2019 05:16:03 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33688 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726831AbfFEJQD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jun 2019 05:16:03 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x559Au50011101;
        Wed, 5 Jun 2019 02:16:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=bSNlKwRUWHQdeWlvsoHSg81ZXH/HDNKdNlg6eAHevvg=;
 b=W94VHWr2guDg+kRLYRmKD2o8RULThwQUU56qk2anEvEuBJ6AH93JY65yDz9ImM9oT/lx
 65bfjzCnR+uS0JU7gDSWSwBj/M38AzMVtNR7BBW3mKiEcKcmsarhbT0CFSy1FoDP7Cus
 /uz9xKVJrbdxemItAyAgwIdX27P2mxulsQMT2+Pq9aQO74JAsaXiaVi59wG6MwNlCMyn
 dmelrLua/nJB5u8kTwrGHGWnfL6u8MJRKQEPGswtVJRhSaIGvsLNMiGHvOMIVas1LXNU
 5n25UsektPQHbx7f5VqdDtgu5+6+nXCCqqi0YItTXohLH3NsVRpv3DvnSROziCplrrbr pA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sx3kg9h0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 02:16:00 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 5 Jun
 2019 02:15:58 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 5 Jun 2019 02:15:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSNlKwRUWHQdeWlvsoHSg81ZXH/HDNKdNlg6eAHevvg=;
 b=WHSzEdP/3zD5lWj3Yoe/HiboioNac0Ut2VoGVYp4zOOHsi7hpu2VPAQzWlsiUUvDc5Z2Oy826HTXfpHnTg4V3XemRkBsVmWCiqu6JgqepgNcN862ngeWL9Fx7MfpC5cWHxyzKzEoxp6ZjG76YYE4VoEjMkNcuVCv2DmJ4CKcKes=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3200.namprd18.prod.outlook.com (10.255.236.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 09:15:53 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8%7]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 09:15:53 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     Brian Norris <briannorris@chromium.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Doug Anderson" <dianders@chromium.org>
Subject: RE: [EXT] [PATCH 1/2] mwifiex: dispatch/rotate from reorder table
 atomically
Thread-Topic: [EXT] [PATCH 1/2] mwifiex: dispatch/rotate from reorder table
 atomically
Thread-Index: AQHVGxea/zVcujTz8UmrfbHXEE3O2aaMxlVQ
Date:   Wed, 5 Jun 2019 09:15:53 +0000
Message-ID: <MN2PR18MB26374464564D1F5A418CA98EA0160@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <20190604205323.200361-1-briannorris@chromium.org>
 <20190604205323.200361-2-briannorris@chromium.org>
In-Reply-To: <20190604205323.200361-2-briannorris@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.1.213.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c57cc2b-2c33-426f-e488-08d6e9966924
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3200;
x-ms-traffictypediagnostic: MN2PR18MB3200:
x-microsoft-antispam-prvs: <MN2PR18MB320090ED0999FE136002804AA0160@MN2PR18MB3200.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(11346002)(14444005)(446003)(476003)(486006)(256004)(186003)(66066001)(478600001)(86362001)(81166006)(8936002)(14454004)(8676002)(81156014)(316002)(26005)(7696005)(6506007)(3846002)(6116002)(76176011)(305945005)(102836004)(74316002)(9686003)(55016002)(7736002)(53936002)(66476007)(71190400001)(2906002)(52536014)(66556008)(76116006)(6436002)(229853002)(4326008)(5660300002)(54906003)(64756008)(66946007)(66446008)(110136005)(25786009)(68736007)(78486014)(4744005)(6246003)(33656002)(71200400001)(99286004)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3200;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eZmLFjSrFJ5TT/S0nkLbGWgJgfnxxJGfQWffe8xDSWNQ3x/TCHIEnxkJsBNQdrC1yO/VgfgI3jnN7IvR1T2mt4YtNxKzvLJL/3xeIGW0MYW41T0VmDyujGzttG+kTmMYjBZDSR8D7Jo4/hQyEEshZg4ouYbL0tnB0BipgvESmbbh0iW9+y3+kye3VeFUkGeZLi5YxdE7cJ/cNqNCqL+BdKgVkpt7KKwYNAPA9cQhktxCGCKQKnR3YjaNdRUg3f06Cl0oiwrW21x3MR1x8Q5S6aGfMs4RigSAwMhlTKea+SHmhDCRWiWNc5LbPVRo9RztREakH/wbEBFad19Gw136Z648ICIFkdgCmm+uWzy7XkiY5HxVBiYenEFCWRgViD1V7Z0ObC2llb+B0403ntjw6izY3PskAAb8UALpN6aiMHk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c57cc2b-2c33-426f-e488-08d6e9966924
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 09:15:53.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhat@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3200
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_06:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,

> (1) iterating / clearing the mwifiex reordering table
> (2) dispatching received packets to upper layers
>=20
> This makes it much harder to make lock recursion mistakes, as these two
> steps no longer need to hold the same locks.

Yes, this is clean;

>=20
> Testing: I've played with a variety of stress tests, including download s=
tress
> tests on the same APs which caught regressions with commit
> 5188d5453bc9 ("mwifiex: restructure rx_reorder_tbl_lock usage"). I've
> primarily tested on Marvell 8997 / PCIe, although I've given 8897 / SDIO =
a
> quick spin as well.
>=20

Thanks a lot for this; We will also run the tests locally; But, I find the =
change is good;

Acked-by: Ganapathi Bhat <gbhat@marvell.com>

Regards,
Ganapathi
