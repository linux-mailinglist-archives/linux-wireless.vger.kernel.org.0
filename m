Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5AFB215
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 15:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKMOEj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 09:04:39 -0500
Received: from mail-eopbgr1320080.outbound.protection.outlook.com ([40.107.132.80]:16704
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMOEj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 09:04:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njZK21zkbnK4VxKx838k6rvtd5HHp2AAfskq0ldjtzq2UOyZw963/gPnHI4JfIPh28bSTMjNoiBZGn3Zk7MOiF4BfHzEPAJMCZmzTZ33epmLPlU485MmhIJWp18e2Tkr/9NnIzggsQsshVWYyygXnrF/ysr6RyWMzDvvyqt1GfMV2bb86UmBhlCc0r/9FlEbqhHUOT6+F40+dDhL1t571kjeF5Qs2I7V0B6S4wl2Ox+7YU9607U+98unWngEkUAX+N0+M/1r8T7OIIITiOrJdmqTjpz33Sfm8xxQOC5FtZB8sZF5PxchNcUkKUd5iGiTT7e1PryNQ1LdZHIXD6znig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nHEsLaw1Cz9+X1pVruDRkVipWsrR4oCuWZw9ccmmc=;
 b=BmXNd5YP8cgQBlMO4kjvbHEScDlnydx2yGHecuydqt+au+MMx9Ec5CFZWgtiWZsMZC5FGG3xHadm0i4i8KZ7NYdZRFnJIu1cer7717uRYml272j1RaFO0RA4TO10ZibxZg/8mlCztrSDM32LDdI/2UxVWCDVuJNCqKA7g66KF3IFMoI5LEl3pCieWNHED9PGzVvfsxigZudzdI8cGrfvwXy3K08qmFzhMmRywbqmHtY3DGzt03MTBYugAcwKIU9I8mgQ5Zr2Hc5qg7pGZMTqbBeF9kBlvqj26keQrr8jxMFwmdkMHj+YEIOvXG92kwDhtPaiKK/FC8IvegupA9M+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nHEsLaw1Cz9+X1pVruDRkVipWsrR4oCuWZw9ccmmc=;
 b=QXoZZ+xNreonJ2QzvrKsIMRAYoocky3VF3N0zwKCNatNccqMOQ/gze9SpYLDHox6kXuaEPKJIYAiAbmxfZj/q8tWtGkgTFOC3iYor1XdkQfqWyUtCx86j3lYmqvqRJ3y2ojcDrjD0bjhRs53O3Ps3q3TY24g21yGVldS/Pbse28=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3288.apcprd01.prod.exchangelabs.com (20.178.154.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 14:04:32 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a%2]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 14:04:32 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged me to
 try applying for refugee status/political asylum in several countries
Thread-Topic: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged
 me to try applying for refugee status/political asylum in several countries
Thread-Index: AdWaK0Fo5VDpFzeNTVWMVIU8hVyZUQ==
Date:   Wed, 13 Nov 2019 14:04:31 +0000
Message-ID: <SG2PR01MB214109287D386039EB5C080B87760@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:9162:51ee:7860:8489]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb5c1542-3ac1-4abf-7e4c-08d768426835
x-ms-traffictypediagnostic: SG2PR01MB3288:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB3288B6682BAFEEA79CA04EDF87760@SG2PR01MB3288.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(346002)(376002)(396003)(136003)(39830400003)(199004)(189003)(6916009)(8936002)(52536014)(5660300002)(966005)(486006)(476003)(74316002)(305945005)(86362001)(508600001)(25786009)(5640700003)(107886003)(6436002)(2501003)(9686003)(6306002)(14454004)(55016002)(7736002)(33656002)(256004)(14444005)(71200400001)(6116002)(2906002)(316002)(71190400001)(186003)(2351001)(76116006)(7696005)(99286004)(81156014)(81166006)(4326008)(46003)(66476007)(66946007)(66556008)(64756008)(66446008)(6506007)(102836004)(8676002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3288;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXkTy3t/9/qUvuoNzu9utmN9czP3f8XmRz13uOFNOUgmZQPwh7V4tV1pU69UNzKaVM2cwlWHPB4Zm3Ku4ddyUYpSjzliifk16IFJbqDaB8l+zKGwD24+CcEqjCT9YMx4Qf2WAYF9jFrDFh0/H/SQ7CGf1d2sAzhQTEoUOU7BU2HQLEXTSULfBqKaU72I3Ri9sCF29CQIWl0bI8XER6x3rdk5pQgUXvV5mNG+DNrY4M9422Hz1kGQehhajqMyRDKlzw08WWkcT4SXE2/d4BPxIdRnN5nNEuL8rKqT0l3AHFJH7DdjsQrSvVaoYCTc82jOWMkNHppBlt27izVv1Ap2nffGVL0tA9rKiV6DcfHyt83z/baoPrImKNXzarAXgSEW2A0rxnmfAqfuL/bYJs6j9iKOvwRClsCglTNI+PsJrgmTizq2YcxTO8k0KPT6D8/4xfnZYn32squ1TehuKfcH0e7JvgUPCIIIoKnVfgksFCg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5c1542-3ac1-4abf-7e4c-08d768426835
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:04:31.9752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaisrZYqC7FD1iAGc3sgZaC3iaPA33zIR/aSssjsmEK0k38E8C8uBUtJt2D/EbuBJK944L/9e/GuxOUCosQJHF8Dulx2KHgg7/ny5+nJKYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3288
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Subject: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged me=
 to try applying for refugee status/political asylum in several countries

I have a chance encounter with Singapore Democratic Party leader Dr. Chee S=
oon Juan along the street at Toa Payoh Lorong 4 on 13 November 2019 Wednesd=
ay at about 3:00 PM Singapore Time. I was on my way home after a 3-hour par=
t time/temporary job from 11 AM to 2 PM Singapore Time when I bumped into D=
r. Chee. We had a short discussion. I briefly told Dr. Chee of my plight fo=
r the past 13 years, which has been told countless times in my RAID 1 mirro=
ring redundant Blogger and Wordpress Blogs, my autobiography first draft 11=
 November 2019 and my countless international posts. Dr. Chee advised and e=
ncouraged me to try applying for refugee status/political asylum in several=
 countries. We parted soon after.

Teo En Ming's Archives and Records Administration (TEMARA). Office of the G=
rand Historian. Records made on 13 November 2019 Wednesday Singapore Time.

-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

