Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4461034D9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 08:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfKTHLV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 02:11:21 -0500
Received: from mx3.watchguard.com ([63.251.166.21]:17095 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKTHLU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 02:11:20 -0500
Received: from PRDITOMBX02.wgti.net (172.24.2.22) by PRDITOMBX02.wgti.net
 (172.24.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Tue, 19 Nov
 2019 23:11:19 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (172.24.2.15) by
 owa.watchguard.com (172.24.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3 via Frontend
 Transport; Tue, 19 Nov 2019 23:11:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgNc3w1k9na5O4xq4R3O3iiUeY5Ee+CT7vf74o1aLXPuz8gY9h7kN1gtYr58gW82AGjy/BqV5wft/m6o1aQDMzOFyBCeffyuAEEeWf3chREtI3MXzREpe2wjOSN12Epq8VheSpuf9yjV4kVIEVJdZj9+5rng332SrZ4QJzJzjZAs2ggVj8lo9kdQ7BOZO2TM/Bbv780tLWCLmWQ8RGnTrIKQ0XFeuF8QUnU+A35xx1KvaMd4V6vPWJfmgExK/daFU6mr7H9TiMdgiSqzpbsFpWnVPGcI1IHhC2rshnXzNUuBP0Xn9iRH4SdSJUVvm2WtW5UhM3OTDm7U4/9Nls7cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXaVEEf3wZXyIM8CDXTQY2nN/cwl2LjVYMw1Cw9P1jk=;
 b=AfLtaMKuyBoSD1ZhwpmyljEZB8jqZL4D+vbacg5sStremDRnZyhZOm49kVZRSL6BHvmQfC5qx1qcUUi7Gcy2JmcvIZJmsAvW3E1kiQ+LyHGmO7T61oomjXxILswq8dhg7g2d3yk6K6XYMO5ssMdo//18pWwBcRcwYc63NbgsLEhepCou9nDJRaK8Iff1konSlzGD85NPFuA07e/uxln8H/Yrh+E/yFu1jCANwRIYhVkLapzTHQUvca7Ns6OYmqtiX6590gf0OBTDq5s+10Vz1R3kOzdn1f4zt2DDVlosXFOvIAmL4fxXlLgqRBn+sS6zibFx4Szd6wGQmMxybhUV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXaVEEf3wZXyIM8CDXTQY2nN/cwl2LjVYMw1Cw9P1jk=;
 b=ghF4osj4wcbhDXcGnPqSaFnFBLLW7KOIRs+dRUIuG2M8Jh8IwQpTSwTftwmTYYe/SbZf8r5p/KdMc/nZYAk90pT4W6jNYQun4fWfk6S2MMtTbbfS1PTYEd3v0cfx84XVfmupBQLfGBYlAB6JX821agdIVhvRZaRUfshX5HFNrrk=
Received: from DM6PR10MB2873.namprd10.prod.outlook.com (20.177.216.210) by
 DM6PR10MB3499.namprd10.prod.outlook.com (20.179.54.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 07:11:16 +0000
Received: from DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326]) by DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 07:11:15 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Ming Chen <ming032217@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v4] mac80211: Drop the packets whose source or destination
 mac address is empty
Thread-Topic: [PATCH v4] mac80211: Drop the packets whose source or
 destination mac address is empty
Thread-Index: AQHVnEROQmNFleZyvEa38z2h3bxkd6eQzzuAgAFCJbCAADEy/YABYXFA
Date:   Wed, 20 Nov 2019 07:11:15 +0000
Message-ID: <DM6PR10MB28737A877FC6425A3FE10CB69A4F0@DM6PR10MB2873.namprd10.prod.outlook.com>
References: <20191116060833.45752-1-ming.chen@watchguard.com>
        <87blt9ctd4.fsf@toke.dk>
        <DM6PR10MB2873E994ABFB1798B36CE49B9A4C0@DM6PR10MB2873.namprd10.prod.outlook.com>
 <0101016e8309e9b1-7bb90226-11bb-4b89-8236-952999e578a8-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016e8309e9b1-7bb90226-11bb-4b89-8236-952999e578a8-000000@us-west-2.amazonses.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [76.14.72.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1bc2678-42f4-4fab-e7c0-08d76d88d561
x-ms-traffictypediagnostic: DM6PR10MB3499:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR10MB3499864607128320B4A0650B9A4F0@DM6PR10MB3499.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39850400004)(52314003)(13464003)(189003)(199004)(7736002)(6436002)(74316002)(229853002)(81166006)(81156014)(305945005)(6916009)(6116002)(8936002)(6246003)(4326008)(66446008)(64756008)(66556008)(76116006)(66946007)(9686003)(6306002)(55016002)(2906002)(66476007)(3846002)(54906003)(52536014)(86362001)(5660300002)(486006)(11346002)(476003)(7696005)(446003)(71200400001)(71190400001)(66066001)(8676002)(256004)(66574012)(76176011)(316002)(53546011)(6506007)(99286004)(478600001)(966005)(26005)(25786009)(33656002)(102836004)(14454004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR10MB3499;H:DM6PR10MB2873.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: or16H//+PtsgNtzCCtZclXwBmJf56d2QpVZI3rOQ+NZqO8aEbA1fWXMVMQGKHde7BivA2aa2DYI3loMFzkMpnZSVnr3LYfjNYgYQqvpGZ/qsAggtwKikGyHMT1Uke8++UUrDnfBHKzgXFwC04DWlWIl5L+zLKXIv10KSskCa5Xzi9kbMEkQELi84F+bkaLabnkJPvVxk3naC7hdZUAfDg/WE2WkI0mklo3xB91akidbgRy24HUqzBozx3mbfrAj/+swiiVQhdh/2TFoxXoB3MNxFBlTxB34bBVkDCKxB/E/p162OzKINfTABAFgouul6i2upe39qBH/EO+gimcxSfVsMyOpFBDmJeJdOYrf3M0nNPitl+UFAugmEcfLmd60unYEkkLU4qVUEjuz6d3lF+Oc441NwlrhOSl2ytHrjgN8vnTHx6N+/lHYaXVUl40fCfNoubaYWVfD8npWTfkY3KBQ8HJzCSBnplpYF9fTG6sQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc2678-42f4-4fab-e7c0-08d76d88d561
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 07:11:15.7628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L02OQmOoNSlZycMFxVq+4meFCtIlRZ9Yj9+anHkyJO6W1BMBwHbXB85uEdyt44M+rUcaatdQq3rqcRe8K7H4XkAQCvHPSKDAF1MHxuKs5rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3499
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Tuesday, November 19, 2019 1:42 AM
> To: Ming Chen <Ming.Chen@watchguard.com>
> Cc: Toke H=F8iland-J=F8rgensen <toke@redhat.com>; Ming Chen
> <ming032217@gmail.com>; Johannes Berg <johannes@sipsolutions.net>;
> linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v4] mac80211: Drop the packets whose source or
> destination mac address is empty
>=20
> Ming Chen <Ming.Chen@watchguard.com> writes:
>=20
> >> > Dropping this kind of error packet before it goes into the driver,
> >> > should be the right direction.
> >>
> >> So I still wonder why this happens from higher up in the stack. If
> >> there's a legitimate reason, maybe dropping the packet is not the
> >> right thing? And if there is *no* legitimate reason, maybe the packet
> >> should be dropped higher up in the stack instead?
> >>
> >> What kind of packets does this happen with?
> >
> > [Ming Chen] It should an ARP packet. I can see this kind of packet
> > before ARP table is complete. If so, how about dropping it in the
> > function of ieee80211_subif_start_xmit?
>=20
> The question here is why are you seeing this but nobody else? Are you usi=
ng
> some special protocol, do you have some changes in the kernel which cause
> this or what could explain this behaviour?
>=20
[Ming Chen] I am not very familiar with the ARP processing in Linux Kernel,=
 but I am sure I can see=20
this kind of packets coming from the upper stack. I talked with the guys of=
 this area of my company today,=20
and they told me we didn't make any change on the ARP relevant processing. =
=20
From my perspective, I think dropping this kind of packets is more or less =
reasonable.=20
Anyway, I will make more investigation on how this kind of packets come int=
o the driver. Thanks
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches
