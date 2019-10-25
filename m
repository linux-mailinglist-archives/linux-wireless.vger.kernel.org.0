Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05341E411F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 03:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfJYBjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 21:39:45 -0400
Received: from mail-eopbgr1310047.outbound.protection.outlook.com ([40.107.131.47]:38240
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389101AbfJYBjp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 21:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTakur7MRl7gaamoEFzbka0W6kENfg24yY4wWST4rNLgk802suZpUa6nxXLt4wh3JHSIscje6svralfl7vipd7VRSc1bX2Qj5swd/vwlBb6u6uOgq17EPEKGJYpWZEceEkpWIFDhMGrqS9aOgQGTu8raZl1Zpu6w+PIJFzrCr4rRlfEmwddi3o7Vb6WTCLib1fD42E9XnEyMwVFDrwqfP+VH2seEhXk2wMkglHJ8AAiPZ1H7GocUcxbvn4v5AQTZyI81oHfi1todnDd/8hXl1+OewiNtAMSBpXLHgkjWw/UjAvvqFmGFIHzOMVDbUHyUm8taG3M4Z/qxYSUo9A7m6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ekeqnocrcbc5M3c/bGfJ2Yxvcw81NBvyAUFlf3Je/g=;
 b=kWoB0xu/ELasItLiQj3wf+qFk5gqAqvzAW7yr0WZDN/GKOVRdEKDzWVft+d2Ja4FkW5YqNiFbU8F8lrmwRgREcVK8mdI1FnNMDGK1G5FdkbjoPzIiBvv7RmZei7nheuQAslEw4rIZ6e1tqvO1l45H0+0KYWE8Pe7E578j9bLUNtCSD6qJToBCifJLh2e/AJ+rIwPvt4BQv12OZwFO6Lue+MGWjQHBE+0/8sU8A/QH3jctpHFSFj08snJuXJKd0YPwNONfsaSUrU7vxj3Pn3V/sLg6mOgLqPsMKCXm44LuiAVwUgLepsOkAAUwRGkMeVwt2WKp/z/SlclpYjpCsyHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ekeqnocrcbc5M3c/bGfJ2Yxvcw81NBvyAUFlf3Je/g=;
 b=YgE18lIz5EQS7I2729Uvfe8DN02jbhiuAAIwiwalzEF4BnA71PW2zVDeIJlpGeJgdGpisdmDNsTstBU4PkpBnzW+sgzb8K8kcoxAAeYDYhwfZrqcDLbU4Au4nzEn9RHcUoI732JyOrsPSF+iR7S6nneS40zcB2aAXNjj5z0zuM8=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3126.apcprd01.prod.exchangelabs.com (20.178.134.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 25 Oct 2019 01:39:34 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2367.027; Fri, 25 Oct 2019
 01:39:34 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Replacement of Supercomputer @ Home in Singapore Due to Motherboard
 Malfunction
Thread-Topic: Replacement of Supercomputer @ Home in Singapore Due to
 Motherboard Malfunction
Thread-Index: AdWK1QgGfsO7JEi/T42JjnlFm2udoA==
Date:   Fri, 25 Oct 2019 01:39:34 +0000
Message-ID: <SG2PR01MB214167850A8E4638A228E0AE87650@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:1ef3:d923:25a:c4b4:68f8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44ea17e3-2669-45e2-f5ff-08d758ec3064
x-ms-traffictypediagnostic: SG2PR01MB3126:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB3126E264D66F573AF278E4DE87650@SG2PR01MB3126.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39830400003)(189003)(199004)(66556008)(8676002)(66476007)(64756008)(81166006)(74316002)(66946007)(2501003)(86362001)(102836004)(33656002)(81156014)(316002)(6506007)(7696005)(6306002)(99286004)(6916009)(66446008)(5660300002)(6436002)(5640700003)(46003)(4326008)(76116006)(486006)(8936002)(2906002)(476003)(256004)(2351001)(14444005)(25786009)(107886003)(9686003)(6116002)(55016002)(7736002)(71190400001)(71200400001)(966005)(508600001)(52536014)(186003)(14454004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3126;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inUFGb8w9jDHLm1D6fsuq5idH/sapxN/aJhzBg4hNLohPh7kp/AFpjsTMpLOi6grPATbt9yX+eB95BAXtpTPSVE30EMpywEILmRzCYNoFFx9SHgBth/nWTYx1P/nmffoeJWEaVSi1ijRS7nE6mfMlcc6K/rPCncp4QP5agno8T71OmQmJmrGgXJfA4tMWN2hjCQQsPp1B8kd6UUlxMRNU2Vo9fDo1X8IzeyhLQryVw2ruMUahCVhKxzurZyu12Nh4hPSUC1nzU6v6Yh08J8Io46CzSiaQKpirOwOd5ECGxmmCQ8F5R9dpuHpuBPrPno3QDKxmEZLiJHVtjrDyOqleQzjrtpu2N443aOtV762vk4dWa02+mIviLss/110QxvUAD5I+1CL9WloRmPu6URmVaVGolhJj/DgibhtibZge743Xm3XtndVlCrZIawOzuhA04tmfojIMoG7aab2ddBviITS+0KlT1aWgxb+dViGdp8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea17e3-2669-45e2-f5ff-08d758ec3064
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 01:39:34.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CddBBTDR6VCUkZgX6g7PanaTUWLnvWvl+YWJLeH+CTzOl5mX3LbDO89Oda4pC8r3WI9InTOxis1dSamR98aZjtBeZKcqfcCZmh9ISkpG4d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3126
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Subject: Replacement of Supercomputer @ Home in Singapore Due to Motherboar=
d Malfunction

Good day from Singapore,

Section A: Old Supercomputer Bought on 30 August 2015
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

I had bought the following computer components on 30 August 2015 (confirmed=
 date), which is slightly more than 4 years ago.

[1] 5th Generation Intel Core i7-5820K 3.3 GHz 15 MB LGA2011(V3) (140W) SGD=
$530

[2] MSI X99A SLI Krait Edition USB3.1 LGA2011-3 DDR4 MAINBOARD SGD$439

[3] Kingston PC4-2133 8 GB DDR4 DIMM (KVR21N15D8/8) SGD$90

[4] ANDYSON AG-SERIES 650W 80PLUS SILVER (5YRS) SGD$95

[5] Coolermaster Hyper 103 CPU Cooler SGD$68

Grand Total: SGD$1,222.00 (on 30 Aug 2015)

Section B: Malfunction of MSI X99A SLI Krait Edition Motherboard on 23 Oct =
2019 Wed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Symptoms:

When power is supplied, there are LED lights on the motherboard. However, t=
he power supply unit fan, casing fan, CPU fan, and GPU fan keeps spinning u=
p and down repeatedly forever. The RESET LED on the motherboard also turns =
on and off repeatedly forever.

Troubleshooting Steps:

1. Removed all existing DDR4 memory sticks on the motherboard. Insert brand=
 new G.SKILL DDR4 memory stick. Symptoms persist.

2. Use another known working power supply unit. Symptoms persist.

Conclusion:=20

The MSI X99A SLI Krait Edition motherboard, which has been in service with =
me for slightly more than 4 years, is now dead.

Credits: Troubleshooting is performed by a computer shop in 4th story of Si=
m Lim Square in Singapore, because I don't have the necessary spare parts t=
o troubleshoot. Troubleshooting fee is SGD$30. Plus Grab fare from my home =
to Sim Lim Square is SGD$20.

Section C: Buying Brand New AMD Ryzen 3 3200G processor, Gigabyte B450M DS3=
H SOC motherboard and Transcend 2666 MHz 8 GB DDR4 DIMM on 23 Oct 2019 Wed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

On 23 Oct 2019 Wednesday, I bought the following *replacement* computer com=
ponents.

[1] Gigabyte B450M DS3H SOC AM4 ATX DDR4 MAINBOARD SGD$113

[2] AMD Ryzen 3 3200G 3.6 GHZ AMD (VEGA 8 GRAPHICS) SGD$138

[3] Transcend 2666 MHZ 8 GB DDR4 DIMM JM2666HLB-8G SGD$58 (bought on 24 Oct=
 2019)

Notes: My previous 1X Kingston DDR4-2133, 2X Crucial DDR4-2133 and 1X Cruci=
al DDR4-2400 memory sticks are not compatible with the new motherboard, acc=
ording to the computer shop. I am reusing the MSI GeForce GTX1650 4 GB GDD5=
 GPU video card and other peripherals in my computer casing.

Grand Total: SGD$309 (on 24 Oct 2019)

Conclusion: Windows 10 Home Edition 64-bit version 1903 is working beautifu=
lly without needing to reinstall the operating system after a complete over=
haul of supercomputer hardware.

Remarks:=20

For the past 13 years after graduation from National University of Singapor=
e (NUS) with a Bachelor's degree (Second Class Lower Honours) in mechanical=
 engineering, I have NEVER had a stable and permanent job because I am a TA=
RGETED INDIVIDUAL (TI). A Targeted Individual is a person who is persecuted=
, targeted, and marked by the [Singapore] Government. Covertly and subtlely=
, the Singapore Government does not allow me to have a stable and permanent=
 job earning high PMET salaries like $8000 or $9000 a month. For the past 1=
3 years after graduation from NUS, I was *frequently* fired/terminated from=
 employment or forced to resign. I am always *struggling* to find part time=
/temporary jobs earning $7-$8 per hour. As a result, I do not have much per=
sonal savings. When another Singaporean flaunted he has $354,000 in his ban=
k account, I only have less than $1000 in my bank account. I can also recal=
l that The Straits Times reported that a Singaporean housewife was cheated =
of some $700,000 some time ago. When my home supercomputer failed, I can on=
ly buy the cheapest AMD Ryzen 3 processor and the cheapest AMD Socket AM4 m=
otherboard. Singaporean Mr. Turritopsis Dohrnii Teo En Ming is the poorest =
university graduate in the world! I SIMPLY LOVE TO FLAUNT MY POVERTY!

POSTED WORLD WIDE.


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

