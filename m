Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31D15BD98
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgBMLVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:21:49 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:25956 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729428AbgBMLVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:21:49 -0500
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 01DBCOg5008852;
        Thu, 13 Feb 2020 04:21:45 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by m0059812.ppops.net with ESMTP id 2y1u3c661k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 04:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNwwIsALCHPcjRh2xdhnVzdywz99XRNbiuJzvk3SH5JB3OYERbp9NpKKJmpMrbte3dORtColFtsD+EAUmBLQhBbmNDjEcS8P4jYeysEU75gxcfh3743GxYNKjtSr7/s4aQTdYFrVcGalsgMmQ64NtIcMcbLUvKP2MIOsWSVG0EViYjG2SH7YhMLY4/OJUxMl/ioVg3LEDQVXxHP/iK1NY8rKARofPvghRaBMm3nUBu5eyEi7zd8oliX44CKnX4pFN3jFKmpvqXNHIvjv17Hkz0XpbtYsJOdYbbS03k2Mhg0JZMGtxyEXbwas6VVX0E4vLj5vCq0mq2pdJvXH2PbmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvqkRepDYgZpgr67tKOPX4lJw/QiyG06jRm0uy7YUUw=;
 b=JvTyuWg3KtjHUbsyQwBGTWFtM85Orxr7YUfJbKDGnjIwfqfHB9jMVlsFCbyny6EOPSe6uzbrkFRCIiaqQ7IcVG5QV203T0B8ZB8KP0hsWP2wRTxliXmcLU5JKzzLqJxF/LlYJ5D/+E2BvjXZIJIsDSo0INUZLCUnVxPHTNIxzCPhvNPpGRpBYaA+gZVwZBed7j+sz1C6nlUg1nGIYuUhTJULzIzH0K6OJ3YRGokNLoCSjyX4/yP1UfiMapN1QJ2LD9ts2QPXDEwgGZ7Q+mpKVhrvySodUdrFPBrWW/Z42AsPs8TXuxU7sDqr3wnMEbeLIWfhlVq6vdHK0tajPiLtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvqkRepDYgZpgr67tKOPX4lJw/QiyG06jRm0uy7YUUw=;
 b=flTWTBUbRQZnhZ3Ijs5TTYt3z87/nwi3T06LK0qHf9kTbroLzAiQ01VJ8FkF3dVcPOXwOXDlBKqcPaelRMIbAmZhve1+wRnQ06P78f8yNV8do1n6seI1H/ufgDUqCNedSbO6f5TMDo1NzVZu6jbIGhEDO7m8+yd3qtrsm4ptie8=
Received: from CH2PR05MB6966.namprd05.prod.outlook.com (10.186.148.95) by
 CH2PR05MB7143.namprd05.prod.outlook.com (10.186.149.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.12; Thu, 13 Feb 2020 11:21:43 +0000
Received: from CH2PR05MB6966.namprd05.prod.outlook.com
 ([fe80::888c:1ba:5ece:426d]) by CH2PR05MB6966.namprd05.prod.outlook.com
 ([fe80::888c:1ba:5ece:426d%2]) with mapi id 15.20.2750.000; Thu, 13 Feb 2020
 11:21:43 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5328.namprd05.prod.outlook.com (52.135.110.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.14; Thu, 13 Feb 2020 11:21:28 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:21:28 +0000
Received: from bars (195.182.157.78) by LO2P265CA0125.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 11:21:28 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Topic: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
Thread-Index: AQHV4kz2Q5s3fb8LT0S52R/D0emqZagY1umAgABT4QD//868AIAAAVGA
Date:   Thu, 13 Feb 2020 11:21:28 +0000
Message-ID: <20200213112123.elwoei3nnk5mzkht@bars>
References: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
 <20200213090657.28841-2-sergey.matyukevich.os@quantenna.com>
 <703b19463655cbb8a5ab9469caec5d3936dbe35d.camel@sipsolutions.net>
 <20200213111300.jgb3kkvwq6am3aj7@bars>
 <47ba092892a3762f42cac6f69a80622829e84827.camel@sipsolutions.net>
In-Reply-To: <47ba092892a3762f42cac6f69a80622829e84827.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0125.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::17) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 177eb728-b285-43c0-15ca-08d7b076ded2
x-ms-traffictypediagnostic: SN6PR05MB5328:|CH2PR05MB7143:
x-microsoft-antispam-prvs: <SN6PR05MB5328E4F3E4D8F7A018366F8CA31A0@SN6PR05MB5328.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:21:41 AM
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(376002)(396003)(136003)(366004)(199004)(189003)(316002)(9576002)(8676002)(2906002)(81156014)(26005)(66446008)(81166006)(1076003)(9686003)(6496006)(4326008)(16526019)(5660300002)(186003)(8936002)(86362001)(52116002)(66556008)(66476007)(956004)(478600001)(64756008)(33716001)(66946007)(55016002)(6916009)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR05MB7143;H:CH2PR05MB6966.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ZEADODPV1pTsc+RDx1YNcFikRnPTChaU+mfHP6/QgMv9HJB0MqhL9Bj++umKu7/hfV9Wa5e1vUAF9aYGuPCN7/3MZnydHAjkhkhS90WUnyLIklrmzN/5kCyw9iScugUulRxVPwR7IA0xQ+Fae9yafF6pQUAEMkgzGXpjvspB1gsE3qrARkjpxL14cRRAemKDqiL3R9KlaxC5fwPkbT1ygozZsdqUoWJVIYeJ5e+0tImOVaJS5+94VnRUz4VNiqIKj0rCriVt/MqwRPj1rAbC6CaDf96mbvioyIxEp+i97UFQaSbY4AoV1WQQaP7rP5pe2vR4vkBB8utYRE5nI7eMKtGrOdxKDIDJ42BNSRAj4LTGb2R5WW92kyrpZGdXY+eiyDXwuD4LTPxy3JUCjlx2rVILVSanXzmsNd4HXyI4a1bClswpp3GKP1ATlhMA9NK
x-ms-exchange-antispam-messagedata: isCO5dFyi6RJEdR4UfPAyOlC9T3fj4IWcKWZ3yfjRxE6cNKS5GlBLnuRAQmRoYVSAaya2XrczG8uHvIyLayD8/78c0TAIKMbTblfRJt+Y+P0ZXLJweJxXe+Tg9MMXZfRFRZRScDPG7e4+cMIrnWJJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B5E4ABAD805564684519471CDA6F19B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177eb728-b285-43c0-15ca-08d7b076ded2
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDyoxyxvpXxFmhpaa9aHSwboGVMFAowe7ZqL6TCBnbQrakIznt7CpnGa8XHp9qGjWvrvcNe7r+RIdk7OwqnSMmxAIrHzYRalq89qKaRRxAN9UPRJBeuo5yUhG4Kp6Hm38vBiVWKSzYblzIPbKLT/EN8NRwmtWeXB+xR2H22sZqO5z6Ty96tDV5vJ7Id4xYvGibxts+8TJjbjYUwdxukO3ilEoz7JrGicNhS0sZCtGjg=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:21:43.2767
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR05MB7143
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130089
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On Thu, 2020-02-13 at 11:13 +0000, Sergey Matyukevich wrote:
> > On Thu, Feb 13, 2020 at 10:12:47AM +0100, Johannes Berg wrote:
> > > [External Email]: This email arrived from an external source - Please=
 exercise caution when opening any attachments or clicking on links.
> > >=20
> > > On Thu, 2020-02-13 at 09:07 +0000, Sergey Matyukevich wrote:
> > > > Do not perform strict validation of UPDATE_OWE command.
> > > > Otherwise, kernel rejects command executed by hostapd.
> > >=20
> > > Can't we fix hostapd? I mean, it's a relatively new command, so why
> > > shouldn't we validate it strictly?
> >=20
> > That is why this patch is RFC: see cover email :)
>=20
> Ah, was on the phone and hadn't read that yet ...
>=20
> > Sure, I can fix hostapd instead. Could you point me at some good
> > starting point to look at ? Are there any user-space tools that
> > started to use strict validation ?
>=20
> It's not really opt-in or not, it's entirely a kernel choice.

I mean, I don't know what userspace is supposed to do in the case,
when kernel is doing strict validation. So I was asking about any
pointers to docs or userspace tools that already do netlink
machinery appropriately.

> > P.S.
> > If you are ok with the second patch, then could you just take it
> > from this series ? Or should I resubmit ?
>=20
> I can just take it.

Ok

Regards,
Sergey
