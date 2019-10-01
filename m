Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C733AC2F44
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 10:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfJAIvd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 04:51:33 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:4578 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727361AbfJAIvd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 04:51:33 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2019 04:51:32 EDT
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x918WscZ027063;
        Tue, 1 Oct 2019 02:49:47 -0600
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by mx0b-00183b01.pphosted.com with ESMTP id 2va2rbxb0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 02:49:47 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV/31+hdlX5g0D0EDXXp97QhDpD22Axq6FGiQYhyMl8L0KWM7agB+USR750bBcp/A0BxRh3UgB/KTmkozPTPLXuCB0r5Z4YSC0W0pxK9MyMwYrbzv2dRmcoNECfjEl62CYjx7D1zB21VVLcN+Oph/yu2AUttynPw7SjSoX/K+TDlVbg2SH/9LHULFqEkbnQGEYAuVUk7Z04xrPAH/yBLoLdgnCBk/P3JVpBVZhdEHtsZ1bgAvGqJpu1WQaPsvsS7PojI1qRHZJaqjmISt/DnkkYqQlTaaWwtxqGz1Pt3LaoDhypsId2fTkaIc6cme/eAEv64yHp6uqCIMn06D9+76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm32evXCDY43pw5FodjpVk0d925+rSgh6X3hFL4/KTo=;
 b=EPjgVN3uW4iY6emiT0T/tPE/iHa1fEGXjdlq9NDDKMHcP8Kitv43/ChJLZMzFgbXBVEsjAJmQ8UytuHJO/2ymcNSs1hQbEc7nNmTMqe+PBnjiplgDtjXHo23Hr1gCkivvz0526XBBozp44mB6Fx080P0fwxhuba4Zg0641oXXNUEEUURRzoOwyXExLzggHWqCUtRFUGqthr5eAoWJ5n+Jw4O1PWuiLqU5AmHxYzxmdqpfy5PtbYJDXKusmI0mVxaxLslXPezZOYItEhDPHFaj6gZVqzKf5D60Z3FLPxWMzGbOYNutlrndy2sY+pnYnjKPYi4DabQufX/xRO6QQo41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm32evXCDY43pw5FodjpVk0d925+rSgh6X3hFL4/KTo=;
 b=DBDTGCl5mj5tIe7yBDHazzNhCE8ULbAUDb+Qn5WoM1hMmPgodGcGxmep5nf5Sk908LwWSdkWQWlNoOlx0tVqcsKg1mzeXKhcaF20bry7zsQcV/yIdeJFs8le0lkmr2UmCRwBrflUZtEXT7mL8wrGJVDBsk6VlHohGI/zLsCZnBc=
Received: from MWHPR05MB3248.namprd05.prod.outlook.com (10.173.230.11) by
 MWHSPR00MB194.namprd05.prod.outlook.com (10.169.236.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Tue, 1 Oct 2019 08:49:45 +0000
Received: from MWHPR05MB3248.namprd05.prod.outlook.com
 ([fe80::a9b6:2c95:ad1c:26a3]) by MWHPR05MB3248.namprd05.prod.outlook.com
 ([fe80::a9b6:2c95:ad1c:26a3%9]) with mapi id 15.20.2327.009; Tue, 1 Oct 2019
 08:49:45 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5168.namprd05.prod.outlook.com (20.177.249.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.10; Tue, 1 Oct 2019 08:49:24 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::50aa:7669:7bfb:33b4]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::50aa:7669:7bfb:33b4%6]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 08:49:23 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Luca Coelho <luca@coelho.fi>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: ax200ngw firmware crash: where to report
Thread-Topic: ax200ngw firmware crash: where to report
Thread-Index: AQHVeDQpRCXa6ncMx0unXZ6J0lUvOKdFeM2AgAABAwA=
Date:   Tue, 1 Oct 2019 08:49:23 +0000
Message-ID: <20191001084917.trmqjwum24fsw23t@bars>
References: <20191001084229.6tzdzxt53qgtehts@bars>
 <a382a59b34a35ddb2006b5820b3de5b8669d4b44.camel@coelho.fi>
In-Reply-To: <a382a59b34a35ddb2006b5820b3de5b8669d4b44.camel@coelho.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:a03:54::16) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37e3820f-fdde-46dc-1c91-08d7464c4212
x-ms-traffictypediagnostic: SN6PR05MB5168:|MWHSPR00MB194:
x-microsoft-antispam-prvs: <SN6PR05MB5168A8DC77A2151FDBCDD8C7A39D0@SN6PR05MB5168.namprd05.prod.outlook.com>
x-moderation-data: 10/1/2019 8:49:42 AM
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39850400004)(376002)(366004)(136003)(346002)(199004)(189003)(66446008)(64756008)(86362001)(52116002)(386003)(66556008)(26005)(6506007)(8676002)(66476007)(102836004)(81166006)(81156014)(66066001)(66946007)(316002)(99286004)(33716001)(76176011)(305945005)(54906003)(7736002)(5024004)(14444005)(256004)(186003)(71190400001)(71200400001)(2906002)(476003)(229853002)(446003)(6486002)(486006)(4326008)(478600001)(6436002)(8936002)(6116002)(25786009)(9686003)(6512007)(11346002)(5660300002)(14454004)(4744005)(6916009)(6246003)(1076003)(3846002)(436003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHSPR00MB194;H:MWHPR05MB3248.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fc6DGQNLYKtdC2VV//AFku8C6H2FirV6HctA6Xot/agxyPsZvRwEHNDAwLkt9YrjFjhu47chyoa/w4IxaTXNkHb60GbhO4TtjfjkfNQMUcnPDY34Mtxnh9TEox4hvU+5u7b6/KKzPG7MnMVo8e6oabMTJY/zEMn20MZ2WaSNaEUoTJUxIzReXR3fO8HQYq2Yl0ohSuUtLQtjapuU1TqWKWQ3N4yy97SJq3sLotH8/5LdKsdlSDX/w9RTGo/zlfvwcMM3kEW6NyKucpPlNRbDyzq34iqjjVgQnwaKcPRKRYvGtJIVtXvGdbEHzdKhnCp6j/jLRvEDg0E7NvExGguYXX0AYzl6g0wxZKezQ97LxRJ+tpUm3LITCEjpTKeJhK/dq7py1Mc2spXbSl8juKxCMh06/x1/P1B7Fj7k9dzdNA0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A96AF51F9CE86B4D83ED361A8C246962@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e3820f-fdde-46dc-1c91-08d7464c4212
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roI9C5EU2wQfOaPgPOvXB2NE+PgLkBfwUGhIg7Pk8QuCvaIwGApLx1qaTCL2S9dTK4NdJt+vGq6Yde3DTX2tXUVNaeX76A6twG82o353haYk2PYgNIiyH7q+EFtk4z4B9jV8LrzcYbSuN0midbBWGL8TPCSbGX9/XGTvaKHwdtCS4wym3Tlb0Ye4eNKaK1IGJU9cJ+c7vukgfvMA4okNlHSVCL/PYH7Dow3h9ag0y94=
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 08:49:45.6731
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB194
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_04:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > Hello Johannes,
> >=20
> > We are using AX1650x (200NGW) wireless card as a client for 11ax
> > testing. Firmware version is 48.4fa0041f.0. Simple iperf UDP UL
> > test on 100 Mbps works fine, but on 120 Mbps firmware crashes.
> >=20
> > I would like to support bug report for this behavior. Looking
> > to wireless wiki, bug reports should be submitted to Linux
> > kernel bugzilla, adding linuxwifi@intel.com to recipients.
> > Is this procedure still up-to-date ?
>=20
> Hi Sergey,
>=20
> Yes, please submit an bug report in bugzilla.  And don't forget to
> attach dmesg logs.
>=20
> --
> Cheers,
> Luca.

Hi Luca,

Thanks for your confirmation. We will submit the issue and attach dmesg.

Regards,
Sergey
