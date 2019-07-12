Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259A566B22
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 12:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfGLKyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 06:54:33 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:31424 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbfGLKyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 06:54:32 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CAoNiG019426;
        Fri, 12 Jul 2019 04:52:47 -0600
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tpjpvrv5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 04:52:47 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPOMHndhg9uQ6l0JkcsqVtcs8el/ZNO/hsyUkQcaJOBFEZuO7Cq2YzWmd7LuFL06LQCOw/i1LkGTIJpGac+hVXAfOlgj8Ck73NWwzHp2KPqxrKaLeg7Mcg5LYEKbUtFVvKQV7qRMwPRVPU+Ie2xQtBSp1syRd0mbBwUJEtZtnTqXl1xeqOyXz9P9b6VvhbWANKs0D7bDbViaO/5Dhfmvq6dqUKUtYGhIm6JP52irNH3UUKP0N3jhEY9RjvBDGVnj8JsVpKdDLsW3xtMrsDHqzGYb1XJCzWyKBMIlqcgOECx/J86YqX5g7/5R4MSszRASVLIc5HRRuCTYDXdS7HaaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqr09wf//Z/aSPHOU3UehOh/U9z7OE4UzAkuQXPs2MQ=;
 b=HDCcOwVabdlXbiobApyp3C1vbT+CaVcDgIhEaE8HF5dvDITWJp7Q/CSLOyI7We2k/2qg4Z5pUOUroY6T0HIKx9ZF3MCwL4DIa0cydyCSTahSCfOhXh5/HJRL9tI/jIY4R7ZkmCD2VbjLCUULcZOVs01KNYUITAOy55H6GlgCTG6SYGcQtQL5VNmTUcyAYcmOuhKarKde0Wycm/51N7SHcqAHwBlKRtw5d4m5VOdRiZEqnfMP3JsJNzmCIrr/QRQTrNNQAWV9F3rmFW2bDy+Efl9ZFMbDt7GhnWvbLhIouB7XhU+KW23nJf7V6Nx1OqLB7702lX7kj3kP9t1I+ktyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqr09wf//Z/aSPHOU3UehOh/U9z7OE4UzAkuQXPs2MQ=;
 b=RbgWMPIxr7v5QfIWWNniFzS7GNCfz0E7pBewaYHnDK6NwhAbMk1L0WTUJJjwd7t3XsdXVZYfG0X3N4+5UZkcGWTcYac1trzpc8fRD0OaAW+cLNL2KlMnCaFTgkeAScZsmqNg4Xo4yDQH/gTJDxXbwjPaIMABf0HFPpBV04nd5P8=
Received: from BL0PR05MB4818.namprd05.prod.outlook.com (52.132.15.24) by
 BL0PR05MB5346.namprd05.prod.outlook.com (10.167.233.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 10:52:45 +0000
Received: from BL0PR05MB4818.namprd05.prod.outlook.com
 ([fe80::f05d:c598:a805:bd37]) by BL0PR05MB4818.namprd05.prod.outlook.com
 ([fe80::f05d:c598:a805:bd37%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 10:52:45 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5871.namprd05.prod.outlook.com (20.177.255.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.7; Fri, 12 Jul 2019 10:52:19 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 10:52:18 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Topic: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVN0YTcguWGm31CkW9q/08y0KK9qbGtPyAgAA2vwD//9FRgIAAFCGA
Date:   Fri, 12 Jul 2019 10:52:18 +0000
Message-ID: <20190712105212.clf77zne6i4gh5ti@bars>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
 <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
 <20190712092716.ywnkns473s5rtoku@bars>
 <43055be7b2d7ff0f8dbadd19443fc73f30f93bb6.camel@sipsolutions.net>
In-Reply-To: <43055be7b2d7ff0f8dbadd19443fc73f30f93bb6.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 280d7133-3798-44c8-013e-08d706b7027c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB5871;
x-ms-traffictypediagnostic: SN6PR05MB5871:|BL0PR05MB5346:
x-microsoft-antispam-prvs: <SN6PR05MB58715D0A25612133B2228552A3F20@SN6PR05MB5871.namprd05.prod.outlook.com>
x-moderation-data: 7/12/2019 10:52:42 AM
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39850400004)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(6506007)(66066001)(8936002)(107886003)(486006)(8676002)(66446008)(64756008)(26005)(66476007)(66556008)(102836004)(5024004)(52116002)(86362001)(256004)(5660300002)(386003)(478600001)(6246003)(54906003)(6512007)(9686003)(33716001)(316002)(14444005)(14454004)(81166006)(81156014)(66946007)(3846002)(4326008)(6116002)(25786009)(436003)(6486002)(71200400001)(71190400001)(305945005)(99286004)(446003)(1076003)(11346002)(6916009)(186003)(53936002)(6436002)(7736002)(2906002)(229853002)(68736007)(76176011)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5346;H:BL0PR05MB4818.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5E0mkHh0CYiPYb8n3apGn9d9BlTBcg4dnZ4VABJSQYidsqpLIeKo/d0CaLQJzcS8EuDj/XDb6rkX5aI5Q1J3FAz69ivb1Fu59fQiBNV1D1ZOD4oDBrcA2ueVLp8rlBpfvAp8lybDPJ5QOaaTCoS9L9ZLq9P5yeV65gA1FHJggSbswTadv0mZAk+P9vqjkIsCdLTfrIPjJc9LwVMr1HcKSOmpDEB42wbBrT2VRll9e//RoLI19YZPm1dqnt1MqzqFhUgCqkvhEE0nd+5Nd2ssYid1oHhH/6Awfs8dY5xR2UjhnODSWlzo6BAJn1ynKOkwvsrs0WXCT1Bf8xBMr5wmbaxR6tFo6O00qvJ7XIrJ8DKpF8FPAZ2H4cwlp7i3m1EsZNO7bOTcq3Lnba1dRdpT4COsJ+hDGQNZCz2pLSCeRh8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F49F0C6880A5A34A9954B5E3D05AB865@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280d7133-3798-44c8-013e-08d706b7027c
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_d7bcd9ec-3c5b-4d3a-8f46-243797972e50@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 10:52:45.0112
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5346
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > > [External Email]: This email arrived from an external source - Please=
 exercise caution when opening any attachments or clicking on links.
>=20
> Heh, you have a not so fun email system that rewrites mails ...

:(
=20
> > > > Suggested approach to handle non-transmitting BSS entries is simpli=
fied in the
> > > > following sense. If new entries have been already created after cha=
nnel switch,
> > > > only transmitting bss will be updated using IEs of new entry for th=
e same
> > > > transmitting bss. Non-transmitting bss entries will be updated as s=
oon as
> > > > new mgmt frames are received. Updating non-transmitting bss entries=
 seems
> > > > too expensive: nested nontrans_list traversing is needed since we c=
an not
> > > > rely on the same order of old and new non-transmitting entries.
> > >=20
> > > That sounds like a reasonable trade-off. I do wonder though what happ=
ens
> > > if we're connected to a non-transmitting BSS?
> >=20
> > Well, here I rely upon the assumption that CSA IEs of non-transmitting =
BSS
> > are handled correctly by mac80211 or any FullMAC firmware. And if we ar=
e
> > connected to non-transmitting BSS rather than transmitting one, the
> > following code in the beginning of new cfg80211_update_assoc_bss_entry
> > function is supposed to care about this use-case:
>=20
> Right, it will be updated on RX. But then if we chanswitch, we would
> probably (mac80211 using a pointer to the non-transmitting BSS) update
> only one of the nontransmitting BSSes?
>=20
> Just saying that maybe we need to be careful there - or your wording
> might be incorrect. We might end up updating a *nontransmitting* BSS,
> and then its transmitting/other non-tx ones only later?

Hmmm... I am not sure we are on the same page here. Could you please
clarify your concerns here ?

The normal (non multi-BSSID) BSS usecase seem to be clear: keep old and
remove new (if any), since it is not easy to update ifmgd->associated.

Now let me take another look at the usecase when STA is connected to
a transmitting or non-transmitting BSS of a multi-BSS AP. At the moment
suggested code does the following. If STA is connected to the non-transmitt=
ing
BSS, then we switch to its transmitting BSS, instead of working with
current_bss directly.

So we look for the new entry (with new channel) of the transmitting BSS.
If it exists, then we remove it and _all_ of its non-transmitting BSSs.
Finally, we update channel and location in rb-tree of the existing (old)
transmitting BSS as well as _all_ of its non-transmitting entries.

Regards,
Sergey
