Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC9A2C85
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 03:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfH3B5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 21:57:39 -0400
Received: from mail-eopbgr1310072.outbound.protection.outlook.com ([40.107.131.72]:8944
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbfH3B5i (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 21:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRPGt2fXl0d7b0MIG50ZbiOqRWxmYmcETkteKoOwflArHdiKkzqBg4Qtlc014FDySU4fidE4l4gZXf1pkqmOscr9LAKuU3Y/qRMrcKuxBKb+t7I9luZsa9REYhijRQ4KK5Up2bkyhDo+vipgHOTMNHQBse0c8ZB19fWaCJiyu3QwNevkt13/41OvotWmDkoiwf5eWgXtBUOGqvYN3s6VKNbjXioSEn49/Q97LO/4VFKMyswmK4qr7C5+CCZz+4V3rfXBDhjP7BHNHnJwQwpcCsL7htEeCbCemwaTAnpY4qeK9dGAUctq5fTQZe+bj4KEJv869AqZc/EIAz3Y7AEhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG6jMF8ZV6YJHw9fuNoOUvlvOCSg/Bi1lhBz5PFm0D0=;
 b=gnmwMgtGvVmMku0uBAeBpOlKzZSzmdfywsDeaJkb5YWZCw4bd9NxFJEFe/DLsiB6FlCw25IosBktyr8cEDDRCY76mTjkBRZ0oFFq/6rAztSEtBn38vKNodG694V9Xf9I3Hz7x2qflpZEqdkn5WchqIm2kA6EKl9JEl+FxSPOwILO3iEtDoUx+vAXaQFRAvvIDHhTlP/lqrmJzJcLuNibKDzpfrsCepgnKTF77VDt4xII0+KQIoe+AkMkn9lkzrBwY5vgCXinNok/aNZJSrWrj2mfE41KyiFLb9gi+2eEfcp0S9UQF84P2fBBrhkdKQMxgAb2m6zjhoe3I7oQi/YiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG6jMF8ZV6YJHw9fuNoOUvlvOCSg/Bi1lhBz5PFm0D0=;
 b=vBoTJ4zwgCFvr733kVeFRrNNoEnyDAIxSs773/bW4m9bORVMghmZ0LJOA6sW2EsFi6QwwADTSaY/qIyWmDWVuEnLl8wkxkdB/6q0OkIl2E8ROvuUGD3bQ9ZpA2rnPFPUdfzaNKeHOdxEkXhvCo66ol2YmJp7otcsujWe0vAUEOg=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2126.apcprd01.prod.exchangelabs.com (52.133.140.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 01:57:32 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::508e:ee77:4ba7:9278]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::508e:ee77:4ba7:9278%7]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 01:57:32 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts
Thread-Topic: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts
Thread-Index: AdVe1kLqBdG373PbS+CfAI+MnFRpGA==
Date:   Fri, 30 Aug 2019 01:57:32 +0000
Message-ID: <SG2PR01MB2141EBFE487DFA36C15739C787BD0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 425c1684-73b1-420a-e8b3-08d72ced6c16
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SG2PR01MB2126;
x-ms-traffictypediagnostic: SG2PR01MB2126:
x-ms-exchange-purlcount: 7
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB2126631437B1FBC1E129ACB887BD0@SG2PR01MB2126.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39830400003)(346002)(396003)(199004)(189003)(102836004)(476003)(25786009)(26005)(966005)(107886003)(2906002)(508600001)(316002)(66476007)(3846002)(486006)(14454004)(4326008)(14444005)(52536014)(74316002)(99286004)(6916009)(6506007)(6436002)(66946007)(66556008)(5640700003)(66066001)(55016002)(71200400001)(305945005)(256004)(9686003)(71190400001)(5660300002)(64756008)(186003)(81166006)(86362001)(81156014)(7736002)(53936002)(7696005)(2351001)(2501003)(6306002)(8936002)(6116002)(66446008)(8676002)(76116006)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2126;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5qlloSoVEhIIEKgnaWua9alg4S2OvgS1ixbabkIMYBBEZNfCfoDISuh0hRKl4PGkcOwDcwaOn6VNWaoEadS1QOsbHPzDVqA8leQmGD9iL5rXzYHB4BFBfojDo3Gy8SKNUes2SogOIDk9CBl4U33WI540E4FfPzBGqrzGpeKcGBa9wMU/6k6Od9kS9S2pEcSoU92MBeMm1wsnpX9tDfUni0OhQwBH4EdUR5ntY3sn5R/9U7sRlu2ThEJq3RrGo79BxBt3ULsl/kXxGv1bvSdFW1vJQlQdX2zjRHtZWPXHeGzOT7+QalHI5BXAtkLz2rH/k8a5A+fd/r3++/BVBe3udbqnvoNyXh435zBH1dYt53s4VPIAhgNbHas8Q4nGCJqQQv9XmaaotyNaeiox9twjckTTPfnOBPk9a7V1mVEt1TQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425c1684-73b1-420a-e8b3-08d72ced6c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 01:57:32.7547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwhpiCB/DzFEZtZUApNyn5Ezz2VgZFT5uxnm1Ri3MT85NtZwpsSuDZC9G7XERvVSylHRsuoTlIyzbcaBU14gTAgn46J0JnBG022W7CFu43I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2126
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts

In reverse chronological order:

[1] Petition to the Government of Taiwan for Refugee Status, 5th August 201=
9 Monday

Photo #1: At the building of the National Immigration Agency, Ministry of t=
he Interior, Taipei, Taiwan, 5th August 2019

Photo #2: Queue ticket at the National Immigration Agency, Ministry of the =
Interior, Taipei, Taiwan, 5th August 2019

Photo #3: Submission of documents/petition to the National Immigration Agen=
cy, Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photos #4 and #5: Acknowledgement of Receipt for the submission of document=
s/petition from the National Immigration Agency, Ministry of the Interior, =
Taipei, Taiwan, 5th August 2019

References:

(a) Petition to the Government of Taiwan for Refugee Status, 5th August 201=
9 Monday (Blogspot)

Link: https://tdtemcerts.blogspot.sg/2019/08/petition-to-government-of-taiw=
an-for.html

(b) Petition to the Government of Taiwan for Refugee Status, 5th August 201=
9 Monday (Wordpress)

Link: https://tdtemcerts.wordpress.com/2019/08/23/petition-to-the-governmen=
t-of-taiwan-for-refugee-status/

[2] Application for Refugee Status at the United Nations Refugee Agency, Ba=
ngkok, Thailand, 21st March 2017 Tuesday

References:

(a) [YOUTUBE] Vlog: The Road to Application for Refugee Status at UNHCR Ban=
gkok

Link: https://www.youtube.com/watch?v=3DutpuAa1eUNI

YouTube video Published on March 22nd, 2017




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

