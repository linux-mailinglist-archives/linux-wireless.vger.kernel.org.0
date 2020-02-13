Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9115BDFC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgBMLq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:46:57 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:53316 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbgBMLq5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:46:57 -0500
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 01DBkM6j003291;
        Thu, 13 Feb 2020 04:46:50 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by m0059812.ppops.net with ESMTP id 2y1u3c67q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 04:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjSe4QF6kfxn1jyzkW4wENSYNYcOdrlcIEzTFo0W8cEJhlbPUqJ0UzVYSrYiILFF4x7sJ6bJ5wXwbTnykmtqsugWgEOZQaPme5dvgRPeIISx2jLzQJ3dPMtOHs+q+rX0FoPhXIsbUOHagROwUIPg78VkKuKU5XEnoC6SwQgh3MkeTdtnyVycwFj8QBhnwTbMM6tFSAhy4e1S4UhbzepuB/CNVD+A02tGvQgmD9mDhsOF2K/3wBFGUQay5xiYo9FBGRVDJCQxsJfu9EBsSo7CEf3E1VR5Z5VfiBubPKRthsodGfClFliF+jKD5r7sRY+RMwxOxe/1sZQY6rYsdJTMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0HDSzx8wjYiu7Iz3xqpGkh77vhazM4AhfhSyOjE55g=;
 b=E9lnsunRCz54PXnN5ROUe6b7lhD+zL1gwRWDLTByj91fv/nWI3dKzEUVWG84bfvPGecQok/mlBtHw6/B3cVKyMBI+4Okw+2r1GUx85p3M+iuezSCscH6uDIAbhD2M5smM1EcPLSPIto875ID3Ulb1llIUSzi8Z8xv50MelAxmRr3Nz1QzRWXYPHeNRiI6kQTIHoJPu0kJxO1ayzzrVTCUscwsiNVz0mm5iYSCTLUNUXiLNcPWmb9Hr4UiEnZkaiySUAmy9RX5q16pdmlvModC6qM/tBHXa7ERsfbIWPICvcczoxl7xBWIS6Z06ADGlO9FnCD6o1mIy260jFFma4TOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0HDSzx8wjYiu7Iz3xqpGkh77vhazM4AhfhSyOjE55g=;
 b=RrfJSf5jgFMbZhJC+Olzy+mhZTFb+O0qq9eeO6rlccQHCjS+XB5J6rDAAHfa9WdZJhXyEgCEshHnXUHvTu5izj8VPaTl6G4k5GjpIx23AjC0F/EPTVvewSXqkYr7mVqfabl4uULziXjPakm72utdjJAKdCBsCY+QQRXuv522vUc=
Received: from BYAPR05MB5574.namprd05.prod.outlook.com (20.177.126.220) by
 BYAPR05MB5239.namprd05.prod.outlook.com (20.177.231.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.19; Thu, 13 Feb 2020 11:46:48 +0000
Received: from BYAPR05MB5574.namprd05.prod.outlook.com
 ([fe80::5d1a:ae29:a6ee:33bc]) by BYAPR05MB5574.namprd05.prod.outlook.com
 ([fe80::5d1a:ae29:a6ee:33bc%6]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 11:46:48 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5597.namprd05.prod.outlook.com (52.135.111.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:43:34 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:43:33 +0000
Received: from bars (195.182.157.78) by LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:62::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 11:43:33 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Topic: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Index: AQHV4kz2Q5s3fb8LT0S52R/D0emqZagY1umAgABT4QD//868AIAAM5yA///PG4CAAATGAA==
Date:   Thu, 13 Feb 2020 11:43:33 +0000
Message-ID: <20200213114327.434cnjstf235av4y@bars>
References: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
 <20200213090657.28841-2-sergey.matyukevich.os@quantenna.com>
 <703b19463655cbb8a5ab9469caec5d3936dbe35d.camel@sipsolutions.net>
 <20200213111300.jgb3kkvwq6am3aj7@bars>
 <47ba092892a3762f42cac6f69a80622829e84827.camel@sipsolutions.net>
 <20200213112123.elwoei3nnk5mzkht@bars>
 <98f7590498a7173e933f70c85208735a13f51792.camel@sipsolutions.net>
In-Reply-To: <98f7590498a7173e933f70c85208735a13f51792.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40d9e09c-968a-4fea-ad71-08d7b079f492
x-ms-traffictypediagnostic: SN6PR05MB5597:|BYAPR05MB5239:
x-microsoft-antispam-prvs: <SN6PR05MB5597F370D0C15D84CD83A2CBA31A0@SN6PR05MB5597.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:43:48 AM
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39840400004)(199004)(189003)(9686003)(33716001)(4326008)(55016002)(1076003)(86362001)(81156014)(9576002)(8676002)(81166006)(478600001)(316002)(8936002)(26005)(2906002)(6496006)(6916009)(16526019)(5660300002)(956004)(186003)(66446008)(64756008)(66556008)(66476007)(52116002)(71200400001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5239;H:BYAPR05MB5574.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JPP0PyWGYmkulnu14KSfIb3B3Ef8Neul1pj9vs9U7Kw/wyTRghIq90KDzESeKZ43bvb+iH8NTh5+MH2/fWr3H4BaMFXaYx4eBtZS9uOguqU/14XT+fc0yNymsYrArte5W0DCcuKzADegA1ZXCfgBzHU38UFEvqU24RABbLgSSIFOhDha2ZPNeRPeWfavveM7s2DarRk0HELTBY/D0LMyJGnsUrGYt4S+mcilr0tu4q25QephSMbOJ3vloYa4fEbRGi7L4k17rN89lzOfbnDBeODSz+KEinUcGl0PZMKRCQ98Nd8jL9QirWNL0ZpIMWs7A5/DA+hog6qSvoYqIHqHc2RMp50bLL/MmsruP0weu/Rx1ooxMq/AVbjqxguVJxuMfPkSsHnOwtqiF4BDhQqOL3ewdKHl+pHR/tf9+JgQTHDBjjnSsn4xRVvcwxDKUsl
x-ms-exchange-antispam-messagedata: 92TualcNiMeWtfHQXUZyNV0xOQTlKdX2y0apb4Wf/yF/GGkpMjEZij/wance8Mzm68GeYW3K+WhTiIU82u4pQK7+CU6Jl3lSTe7FBPca1aKMmTx8GMR+ZkoWy4wFilC5NOKyAn69ba6PEZd0x6YiVg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A50A32D7204EDF4FB5F3FAEC73E0E960@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d9e09c-968a-4fea-ad71-08d7b079f492
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzQnHEs1WawPYt9/8tjsSUCRrjUx3LJsJg+UQzqA9qzrjCxQDPT4TNetsUQjgOihSjec/nYfeRWgevkchOlvi2DzKAb0PPiPeYALpHY8/VMCjEgUwDIIBdWkpD57ZtF36EuQsfZhC0JZdB8wEjYUHsKJOeTJm8KvJ7SBRgxHV4Wy2gF/oEK5sV+Ph2VklxmcBROP0cZD/KbZQfyiuyZCPSH1jHYmrv8nGDT0L89iXig=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:46:48.7411
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130094
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On Thu, 2020-02-13 at 11:21 +0000, Sergey Matyukevich wrote:
> > >=20
> > > > Sure, I can fix hostapd instead. Could you point me at some good
> > > > starting point to look at ? Are there any user-space tools that
> > > > started to use strict validation ?
> > >=20
> > > It's not really opt-in or not, it's entirely a kernel choice.
> >=20
> > I mean, I don't know what userspace is supposed to do in the case,
> > when kernel is doing strict validation. So I was asking about any
> > pointers to docs or userspace tools that already do netlink
> > machinery appropriately.
>=20
> Userspace is just supposed to create well-formed messages :-)
>=20
> But ... it really is a kernel bug. The nl80211_policy is missing an
> entry for NL80211_ATTR_STATUS_CODE, so for *strict* commands, it's
> assumed to not be supported. Need to add something like
>=20
> 	[NL80211_ATTR_STATUS_CODE] =3D { .type =3D NLA_U16, },
>=20
> to the nl80211_policy, or perhaps with a range indicating that 0 isn't
> valid or something.

Great. Thanks for explanation. Would you mind if I send a fix ?
Or now you have your own plans for this ?

Regards,
Sergey
