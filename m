Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D05CF28
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfGBMLU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 08:11:20 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:51774 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725835AbfGBMLU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 08:11:20 -0400
X-Greylist: delayed 1069 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 08:11:19 EDT
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62BorZl004030;
        Tue, 2 Jul 2019 05:51:47 -0600
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tfykegv0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 05:51:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgl4VQ7jWJt5raYhF5PvaJ5HJXnmOwYZCHlM+s/d++Y=;
 b=hoEknoaX71Ucy8AY/K5C2A97hDVDGnwmYLwh3sLgsynpDZnxJReFI5+kEbX3H8B3SAXHzGzsSx38hNEAQpflG06aS9uEe+Ga/4GlCMm/XVTtCfWQGZU3VGgBCKYsdMgkVzLpbUiXlOOaa5aQ8ZsZetTlQfdJQxjaCcEFcJfGdZg=
Received: from DM6PR05MB6635.namprd05.prod.outlook.com (20.179.53.78) by
 DM6PR05MB4747.namprd05.prod.outlook.com (20.176.109.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.9; Tue, 2 Jul 2019 11:51:42 +0000
Received: from DM6PR05MB6635.namprd05.prod.outlook.com
 ([fe80::1133:5bc5:28f5:9c0d]) by DM6PR05MB6635.namprd05.prod.outlook.com
 ([fe80::1133:5bc5:28f5:9c0d%3]) with mapi id 15.20.2052.010; Tue, 2 Jul 2019
 11:51:42 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4925.namprd05.prod.outlook.com (52.135.117.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Tue, 2 Jul 2019 11:50:11 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2052.010; Tue, 2 Jul 2019
 11:50:11 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [RFC PATCH] cfg80211: fix duplicated scan entries after channel
 switch
Thread-Topic: [RFC PATCH] cfg80211: fix duplicated scan entries after channel
 switch
Thread-Index: AQHVIdor2pKU2TPLDEKkmFBmH5mjfqaxOswAgAYaFAA=
Date:   Tue, 2 Jul 2019 11:50:11 +0000
Message-ID: <20190702115005.ulcfohbi4mkwpt2c@bars>
References: <20190613112128.834-1-sergey.matyukevich.os@quantenna.com>
 <7c8b3493cd2c48beae5a12e23964c8d3ca181d04.camel@sipsolutions.net>
In-Reply-To: <7c8b3493cd2c48beae5a12e23964c8d3ca181d04.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8457ee54-a1c9-4126-0996-08d6fee36ffe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB4925;
x-ms-traffictypediagnostic: SN6PR05MB4925:|DM6PR05MB4747:
x-microsoft-antispam-prvs: <SN6PR05MB49259A9BAB342DEB45B00020A3F80@SN6PR05MB4925.namprd05.prod.outlook.com>
x-moderation-data: 7/2/2019 11:51:40 AM
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(39850400004)(396003)(136003)(366004)(189003)(199004)(8676002)(229853002)(6116002)(3846002)(25786009)(6512007)(8936002)(6486002)(66066001)(9686003)(4326008)(14454004)(5660300002)(186003)(54906003)(33716001)(66946007)(66446008)(6916009)(73956011)(6436002)(66556008)(64756008)(66476007)(68736007)(6246003)(316002)(99286004)(256004)(86362001)(52116002)(107886003)(53936002)(76176011)(1076003)(446003)(11346002)(14444005)(305945005)(26005)(478600001)(436003)(81156014)(81166006)(71200400001)(71190400001)(476003)(486006)(2906002)(7736002)(6506007)(386003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4747;H:DM6PR05MB6635.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7SzuajNibhq+SZoY7km7tnlPrivpgvgSRej6t6kDt5/lS68ZVTM4ajjyUw5c1Zxt16WrL6LuAsYdogawV57x0HdoOnUDtr13u5ZAWmSx7CM9eSUTVUofZvHmQYs9tJmpIwbFXZ23VPoCAQPl1qzlO1Rzv+Zk43xTgEyt0kTXbh2UTuXIXhqeRFtOGT3ipNh7j2jkVCLTrArCD5JRYIDlm6AQCFJ1Ii64W6njd7i3VrhWaO3I93rD5/LOfdNilmFa7XZC4Le3QdDJVDtz1Sy8ANoqlZPATYFBqcPyeq7ZydOHU1qXdm10C2PR8kNLuOsNWuRPTVFq1/RmiggpwR1zStjvNsm1PKnMckwidJA9waXub47+YAK1mmcxUqk+EyvIrCp+XmBkM+ikR32rwk9jVjbjfZNc/wbsYwnWXEPN9nA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7794D03EC0D0C742935C5CAE1D549307@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8457ee54-a1c9-4126-0996-08d6fee36ffe
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_0b5d01ae-5fea-45aa-b314-5cf59dfd2dd5@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 11:51:42.8648
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4747
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020136
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

...

> > To summarize, if BSS channel needs to be updated, then bss_tree should
> > be rebuilt in order to put updated BSS entry into a proper location.
>=20
> Good catch!
>=20
> > This commit suggests the following straightforward solution:
> > - if new entry has been already created for BSS after channel switch,
> >   then remove it completely
>=20
> Shouldn't we prefer the new entry?
>=20
> OTOH, the old entry will likely have a "hold", so it doesn't get removed
> while we're connected ... and the driver etc. might be referencing it.
> So I guess the old entry should be updated with info from the newer one?
>=20
> > Finally, next scan operation will find BSS entry in expected location
> > in rb_tree. So all the IEs, including HT/VHT operation IEs,
> > will be properly updated.
>=20
> Right. Although if it was there before, then it already has been updated
> in a sense... But I guess it's a corner case to even get there?
>=20
> > 1. Tested using iwlwifi and qtnfmac drivers, looks good
>=20
> Great.
>=20
> > 2. Alternative approach: remove old BSS entry and keep new a one
> > This approach may have certain benefits for mac80211 drivers.
> > For instance, in this case HT/VHT operation IEs are going to be
> > valid from the start, no need to wait for the next scan.
>=20
> > However the following procedure for replacing current_bss, protected
> > by wdev->mtx and rdev->bss_lock locks, seems to be insufficient:
> >=20
> >   bss_ref_get(rdev, new);
> >   cfg80211_hold_bss(new);
> >   wdev->current_bss =3D new;
> >=20
> >   cfg80211_unhold_bss(old);
> >   bss_ref_put(rdev, old);
> >   __cfg80211_unlink_bss(rdev, old);
> >=20
> > When testing this alternative approach using iwlwifi driver,
> > occasional general protection fault crashes have been observed
> > on ieee80211_rx_mgmt_beacon/ieee80211_bss_info_update code paths.
> > So far I haven't yet root caused them.
>=20
> At the very least you'd also have to update ifmgd->associated in
> mac80211, and that's basically not really possible? Well, I guess we
> could change the channel switch API to return the new one or something.
>=20
> I guess the better thing would be to go update the old entry with the
> new one's data, before killing the new one.
>=20
> Not sure it's worth the extra complexity though.

Hello Johannes,

Thanks for review! Summarizing your comments, here are the options
and some of their highlights:

1. replace old entry with the new entry
   - no easy way to update ifmgd->associated w/o rework of mac80211 csa

2. keep old entry, remove new entry
   - this is what suggested RFC patch does
   - works, but update of current_bss entry after csa may be delayed

3. keep old entry, update it using data from new entry, then remove new ent=
ry
   - this looks like a better approach

Unless I am missing something, the last option can be implemented on top of
the current RFC patch w/o extra complexity. The required bss entry update i=
s
what cfg80211_bss_update function does when bss in question already exists.
So it should be possible to reuse that code.

I will post RFC patch v2 after more testing for both mac80211 and
fullmac cases.

Regards,
Sergey
