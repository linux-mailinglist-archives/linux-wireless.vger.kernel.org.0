Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDD72787
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 07:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGXFuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 01:50:06 -0400
Received: from mail-eopbgr1320077.outbound.protection.outlook.com ([40.107.132.77]:36480
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXFuG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 01:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQgJf47zgh4ueMMXOLXoNDttaO25su38rqQebsk191OghJdCowtpKfXGpJhtxuWKUdW+nWc5Co8xe3aTVkUemeSabQi3TBw6MRGHpAUIOfpnQ/C9WXgqZQfvRJDwg4NByJCqYmXOQxIV4ZJU3u4+z/d5VBKLYXZv5ukiXFprqQ6YBh1V40V9nE82wePV+OYhHT5gVoKeVOa4v4vB2aG/6PnqmCZHgtgSeL1bDGodrFM6QkKm1+U4bc5eZSVDvG5wgeoSyuZ79mfR8j1/CcERhNm+oeW8EuUV8ahDpPNNSfyC5y353EsXxTf55keoVCEH878/e98a3MWL7eWrA+6JZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S3rSJ0bCs+XT884l2x2TL4sFNyCBwWrAiWbxdH2Sxs=;
 b=FB6nAC3Ht1HITqidL4391/towBgoqY7FE4P46Q+PJw8n1HsPFk397rsFmWbvvvhZH+xOqOMPK2OiRANFz4xzm/7WXCSzCVykKFK+oXeKIgBk8Zmtad0klyNgdSWsAKDAccCHTTW8y5FRrRiNmH2XNwwC8oBFG8WbVTG3fl99+uetQ2jIw3BOj7FmRwwtfsEYMWtf18XriYMAkhKS0q8zXzH/klg8bgbVQO7+3PCjZ0TtTmkLJpsc7VcXDbSeEW4UwhhsSMccvHUhlSMsWoSNVLmSZzxGpKaov7NWPgFn2MsgjEoPKv/Pt0ABHYGieCOjuXoL5ktY/E8ITnPk+hFMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=teo-en-ming-corp.com;dmarc=pass action=none
 header.from=teo-en-ming-corp.com;dkim=pass
 header.d=teo-en-ming-corp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S3rSJ0bCs+XT884l2x2TL4sFNyCBwWrAiWbxdH2Sxs=;
 b=Xa4f3Fd01au5pxeI+Ss+QOpDlyPiV6I78k1V2CYBO1q7ZXI4pcXnql/+qw8wrpXDt3g87iakms9eApDCjTor4KgGLsOKqFRegKjN/MNowdD/4RaQ7eo/9zDp5J8GX+g1rCMN55CK0Rw5SANpJoEjtKfFLyx1dN9mUtumxfy7Rjw=
Received: from KU1PR01MB2134.apcprd01.prod.exchangelabs.com (10.170.174.138)
 by KU1PR01MB1879.apcprd01.prod.exchangelabs.com (52.133.201.148) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Wed, 24 Jul
 2019 05:41:00 +0000
Received: from KU1PR01MB2134.apcprd01.prod.exchangelabs.com
 ([fe80::7d19:b2d7:95fd:1820]) by KU1PR01MB2134.apcprd01.prod.exchangelabs.com
 ([fe80::7d19:b2d7:95fd:1820%3]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 05:41:00 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Great News: National Heart Center Singapore CT Coronary Calcium Score
 18 July 2019
Thread-Topic: Great News: National Heart Center Singapore CT Coronary Calcium
 Score 18 July 2019
Thread-Index: AdVB4lKBaFKtf2ELTVSfNLcewe47Kg==
Date:   Wed, 24 Jul 2019 05:40:59 +0000
Message-ID: <KU1PR01MB21343B2B55890660AEC1485287C60@KU1PR01MB2134.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dccd53c9-1f21-44f9-db8c-08d70ff98225
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:KU1PR01MB1879;
x-ms-traffictypediagnostic: KU1PR01MB1879:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <KU1PR01MB18796EFE3CF123C8F676036987C60@KU1PR01MB1879.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(81166006)(52536014)(3846002)(5660300002)(66446008)(7736002)(66476007)(6116002)(966005)(64756008)(66556008)(305945005)(76116006)(14444005)(256004)(7696005)(71190400001)(86362001)(66066001)(66946007)(8936002)(71200400001)(74316002)(99286004)(4326008)(107886003)(186003)(508600001)(8676002)(68736007)(6916009)(9686003)(55016002)(25786009)(2906002)(26005)(5640700003)(102836004)(6506007)(14454004)(2501003)(6436002)(2351001)(6306002)(53936002)(486006)(81156014)(316002)(476003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:KU1PR01MB1879;H:KU1PR01MB2134.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: euWpTeaT74PSm3GIaSFC++7n6pbtnl5wsQrEDw1OBuI7dXUJC27ldru0UiAN1D1hP1NAyQaw2K8OQMQzM4se38sKfHIZzryyMhhY/Kvt81oLBa4ldpn8p6scBUks/LXplF+VqfR/nuoPTG+DKGZZ/cELQdlrFAPqWPZqEm9e9eFTycFue5kB9kS1Fx00VuF/iducUYT6PNRpjiomjVa3KtO0gnpSAFIUgCKut67FH2cc9/K79EOG1XRYKwAN0yvCZxjEx5JsWucHHGncoskTEqbdhtpayVkoRPngh/3flZIWQXaJ+nbDv4o02ZbbWoYxxXWlrHs8Reu2Rpn7z5d3L5p0l9LsDeis0tfiEwC3aeOcG52XxPeI9wtYbv5KVzlrAai7r/3aB6d4ThKLqPr/XukydSEU2FRaZnt1CFA+KEo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccd53c9-1f21-44f9-db8c-08d70ff98225
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 05:40:59.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR01MB1879
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Subject: Great News: National Heart Center Singapore CT Coronary Calcium Sc=
ore 18 July 2019

Good day from Singapore,

This is good news for trillions and trillions of years to come!

1. My weight/mass is 123.5 kg (taken on 23 July 2019).

2. My height is 1.79 meters (taken on 23 July 2019).

3. My Body Mass Index (BMI) is 38.56 kg/m2 (as at 23 July 2019)

4. I have been living with random, intermittent, and chronic mild chest pai=
n for the past 10 years since the year 2009.

5. I have seen countless (lost count) doctors in Singapore over the past 10=
 years. The diagnoses were always atypical chest pain (ie. nothing to do wi=
th the heart). All the doctors I have seen did not think it is angina pecto=
ris.

6. I have done countless (lost count) cardiac tests in Singapore over the p=
ast 10 years, including electrocardiogram (ECG), treadmill stress test, MIB=
I heart perfusion test, and CT coronary angiogram. All the test results wer=
e either normal or perfect.

7. I have high cholesterol (hypercholesterolemia) for many years, according=
 to doctors.

8. My pulse rate is consistently around 100 beats per minute for many years=
.

9. Recently, I went for CT coronary calcium scoring at National Heart Cente=
r Singapore (NHCS) on 18 July 2019. The following is a transcript of the CT=
 coronary calcium scoring report obtained on 23 July 2019.

-----BEGIN NHCS CT Coronary Calcium Scoring Report 18 July 2019-----

National Heart Centre Singapore

Patient Results

Requested By: Chan Lihua Laura (Doctor)                          23-Jul-201=
9 05:54 PM

TURRITOPSIS DOHRNII TEO EN MING (ZHANG ENMING)                Sex: M      A=
ge: 41y    DOB: *****

MRN / Visit No.: ***** / H119042968E0003                        Locn: NHC-C=
ardiac Clinic B

18-Jul-2019 11:07              CT Coronary Calcium Scoring                 =
HCCT195011991718            Final

Additional Info	              Verified Date/Time: 18/07/2019 12:02         =
                            Final
                              Verified Person: Dr. Narayan Lath
                              Verified Section: NHC CT
                              Performed at : National Heart Centre Singapor=
e
                              Level 5, 5D, 5 Hospital Drive Singapore 16960=
9

CT Coronary Calcium                                                        =
                            Final
Scoring
   HISTORY
   to reassess risk profile
   TECHNIQUE
   Calcium Scan was prospectively gated. Images were reconstructed at 3.0 m=
m slice thickness.
   Assessment was done using Vitrea Calcium software and Agatston scoring s=
chema.
   REPORT
   Calcium Score: Agatston 0 , Volume score 0 mm3, LM 0 , RCA 0 , LAD 0 , L=
CX 0.
   The calcium score is between 0 th and 25 th percentile for [men between =
the ages=20
   of 40 and 44.
   Normal coronary origins.
   EXTRACARDIAC FINDINGS
   No incidental significant abnormalities in the included lungs or mediast=
inum.
   Report Indicator:   Normal
   Finalised by:        Narayan Lath, Senior Consultant, 12598I
   Finalised Date/Time: 18/07/2019 12:02
Report Link                                                                =
                            Final






Printed from: National Heart Centre Singapore                    End of Rep=
ort                         Page: 1 of 1

-----END NHCS CT Coronary Calcium Scoring Report 18 July 2019-----

For scanned image of the original CT coronary calcium scoring report from N=
ational Heart Center Singapore, please visit my RAID 1 mirroring redundant =
Blogger and Wordpress blogs at

https://tdtemcerts.blogspot.sg

https://tdtemcerts.wordpress.com

On how to interpret CT Coronary Calcium Score, please visit the website of =
the Radiological Society of North America, Inc. (RSNA) at

https://www.radiologyinfo.org/en/info.cfm?pg=3Dct_calscoring






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

