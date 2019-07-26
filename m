Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C901776340
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfGZKOL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 06:14:11 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:5074 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbfGZKOL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 06:14:11 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QAAYBD024646;
        Fri, 26 Jul 2019 04:12:25 -0600
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2054.outbound.protection.outlook.com [104.47.49.54])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tywkqr7vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 04:12:25 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFxEDSF1wtwAA5c5fvQpIWlN3bT1jV0ddohm6zVnSybxq6O7BoUdRCewMown1u/7VA0Jv4gkCpgQt8ebAd3bffO8Uu8VvYOwYy1hYA3BRq0gQiPE8O/YARxcPnReXupLyUySzr3dQHCKbyZf8WIPfdrue/XduIcfrKK43U5eeYP7kkxtowooL1QDZZ9MOdLALFNuqLR3V5JgYXHTA+BOjthWRXoPBElXNc4/DBlgYb5KWy0YkuZCycIZ/bGpfyE93uIcC2F4NejVfZhzisqourlp3P7lwVjXQ6+KEkEZMpbP+2/0eGdpLpfoV2SqdQBH5hezTeN75gyw8Tt9J6kMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fF5hycn5QzrXNxU9kSupxFrlZRFbEg18TPKIjKfB2Y=;
 b=Udal4kr+vTEhUj20MEfviSF8f0kAO/kIO1zI7nMUn8V3hONvH0qt3ylhl8DoNe7hqBzqPboG3mWXntHVyFa30o+4uRVqb/3nOR+R3JJQlCYTILIk/tcMEuDIpf6GTcpWcq3ehqjmBvi11g6X7txiaZNAja0x9ngCk6Qyly/IwU+pbN3HHO0HIYArXtZiOb+JM72mQXz/zu/eEzbznK3hRSk4llHfG/uk9t+HtSQmCukWgKANiaz8UwrW2Crw7aecWpLvfbfnxWQVYsuN7CeSWX3728W0TQpunduSlWZmvhy0eGdLYpy7odNXuPqltyej0SiwkHNT9pXDcTxUcu9uAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fF5hycn5QzrXNxU9kSupxFrlZRFbEg18TPKIjKfB2Y=;
 b=kPYp4w51Xf5jEaT2pxN+DdINDfW9TbpaI3UrWrvFlYDpUobr4q4VVif27a7djuRrz9jgvognmMnq3KSKhAhAmVKj3hiwxUhmoYgEG42F6NzxOuPkVUCr0QiB44fAhQugBCzDcwyuysxWntcdm8TcKIBGxZMsEqJ/pywpTBXNwK4=
Received: from DM5PR0501MB3701.namprd05.prod.outlook.com (10.167.106.19) by
 DM5PR0501MB3832.namprd05.prod.outlook.com (10.167.108.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.6; Fri, 26 Jul 2019 10:12:24 +0000
Received: from DM5PR0501MB3701.namprd05.prod.outlook.com
 ([fe80::2d26:399c:f829:a236]) by DM5PR0501MB3701.namprd05.prod.outlook.com
 ([fe80::2d26:399c:f829:a236%7]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 10:12:23 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com (52.135.235.159) by
 BYAPR05MB6360.namprd05.prod.outlook.com (20.178.232.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.6; Fri, 26 Jul 2019 10:11:56 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e]) by BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e%5]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 10:11:56 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Topic: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVN0YTcguWGm31CkW9q/08y0KK9qbGtPyAgAA2vwD//9FRgIAARmoAgBWXnoCAACt1gA==
Date:   Fri, 26 Jul 2019 10:11:56 +0000
Message-ID: <20190726101150.lykay6apgzvsb4ov@bars>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
 <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
 <20190712092716.ywnkns473s5rtoku@bars>
 <43055be7b2d7ff0f8dbadd19443fc73f30f93bb6.camel@sipsolutions.net>
 <20190712105212.clf77zne6i4gh5ti@bars>
 <2efa83ab8120e29d1eb1be8295d59568b4eacc9a.camel@sipsolutions.net>
In-Reply-To: <2efa83ab8120e29d1eb1be8295d59568b4eacc9a.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To BYAPR05MB4917.namprd05.prod.outlook.com
 (2603:10b6:a03:42::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c1b236-b7cb-4d34-088c-08d711b1b047
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6360;
x-ms-traffictypediagnostic: BYAPR05MB6360:|DM5PR0501MB3832:
x-microsoft-antispam-prvs: <BYAPR05MB6360C8C4175E3EDDA2504147A3C00@BYAPR05MB6360.namprd05.prod.outlook.com>
x-moderation-data: 7/26/2019 10:12:17 AM
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(346002)(376002)(396003)(39850400004)(199004)(189003)(2906002)(102836004)(25786009)(6486002)(14444005)(305945005)(66556008)(64756008)(6512007)(66946007)(7736002)(9686003)(76176011)(229853002)(66476007)(186003)(6916009)(52116002)(107886003)(66446008)(256004)(386003)(26005)(1076003)(71190400001)(446003)(5660300002)(53936002)(71200400001)(99286004)(476003)(436003)(6436002)(486006)(54906003)(33716001)(478600001)(66066001)(6506007)(6116002)(6246003)(4326008)(14454004)(3846002)(8676002)(316002)(68736007)(86362001)(81166006)(8936002)(11346002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0501MB3832;H:DM5PR0501MB3701.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /pm4OA9VqeDGFNIPOmw9KvqaOQiN7dg76+Lq/xrz53MvWdPS8IP2ieYi609brkjM5mRYbsUkpKeTcYaKyhJcsfMVzZD9Cqsv01339lO3JKcBD1LZW5jwXpU1ALciu32SYPPY7Q1wapklEIwpwGxDFdLwnQJcZ/9AghoZf6YoMFf7HPZmprhfa6S8RTM6gTfIGgDHug/xJs7pAVvXDRTB7/XjTpzCAEM+DOch/a7huiH3pkma90lFLzKjYyHFX/0WFuRRc+wqRLX8sYR0ryv+jFJENWsVko1+KZny8aMoyR718gRg7Qk8AT/YtcmYuOHN4iYFKLHkoAuk4MFtx0v88fuYoO4dIMzyRSyZ9P6xMhznjFrX4FbCT7sh616oGfziiVZj2LD9n/gveEEBJzeXWjUFEJWY7PLYstTdWFFCIkc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07C6903C7DA80F4B836938DBBABB8181@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c1b236-b7cb-4d34-088c-08d711b1b047
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_efbec78e-7337-42bc-9801-f87113ab0c8c@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 10:12:23.9576
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260131
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

> > > Right, it will be updated on RX. But then if we chanswitch, we would
> > > probably (mac80211 using a pointer to the non-transmitting BSS) updat=
e
> > > only one of the nontransmitting BSSes?
> > >=20
> > > Just saying that maybe we need to be careful there - or your wording
> > > might be incorrect. We might end up updating a *nontransmitting* BSS,
> > > and then its transmitting/other non-tx ones only later?
> >=20
> > Hmmm... I am not sure we are on the same page here. Could you please
> > clarify your concerns here ?
>=20
> I'm trying to say we might have this:
>=20
> cfg80211
>  * transmitting BSS 0
>    - nontx BSS 1
>    - nontx BSS 2
>    - nontx BSS 3
> mac80211
>  * ifmgd->associated (and cfg80211's wdev->current_bss?) =3D nontx BSS 2

Yes, this is the use-case that I tried to address in the last revision
of the patch. Suggested approach is similar to what is done for normal
case:
- to keep this hierarchy updating channels and location in rb-tree
- remove newly added hierarchy of the same transmitting BSS on the new
  channel

Note that here we update/remove not only transmitting BSSs, but their
nontx BSS hierarchies as well.

>=20
>=20
> Now, things like the channel information etc. will always be identical
> between the 4 BSSes, by definition.
>=20
> However, if you chanswitch and mac80211 just lets cfg80211 know about
> the current_bss, then you may end up in a situation where the channel
> information is no longer the same, which is very surprising.
>=20
>=20
> > The normal (non multi-BSSID) BSS usecase seem to be clear: keep old and
> > remove new (if any), since it is not easy to update ifmgd->associated.
>=20
> Right.
>=20
> > Now let me take another look at the usecase when STA is connected to
> > a transmitting or non-transmitting BSS of a multi-BSS AP. At the moment
> > suggested code does the following. If STA is connected to the non-trans=
mitting
> > BSS, then we switch to its transmitting BSS, instead of working with
> > current_bss directly.
>=20
> We switch? Where? Maybe I missed that.

If you take a look at the top of new cfg80211_update_assoc_bss_entry
function:

+       /* use transmitting bss */
+       if (cbss->pub.transmitted_bss)
+               cbss =3D container_of(cbss->pub.transmitted_bss,
+                                   struct cfg80211_internal_bss,
+                                   pub);

> > So we look for the new entry (with new channel) of the transmitting BSS=
.
> > If it exists, then we remove it and _all_ of its non-transmitting BSSs.
> > Finally, we update channel and location in rb-tree of the existing (old=
)
> > transmitting BSS as well as _all_ of its non-transmitting entries.
>=20
> That would indeed address the scenario I was thinking of ...

Ok! Let me know if you have any other concerns or questions.

Actually one of the major concerns is the lack of testing for the 'multi-BS=
SID'
scenario. I verified the 'normal' scenario using both mac80211 (iwlwifi) an=
d
FullMAC (qtnfmac) cards. But at the moment I don't have any mac80211 card
supporting multi-BSSID.

Regards,
Sergey
