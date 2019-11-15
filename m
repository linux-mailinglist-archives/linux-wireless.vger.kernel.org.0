Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A3FD78F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 09:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfKOIFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 03:05:11 -0500
Received: from mx3.watchguard.com ([63.251.166.21]:40361 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfKOIFK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 03:05:10 -0500
Received: from PRDITOMBX02.wgti.net (172.24.2.22) by PRDITOMBX02.wgti.net
 (172.24.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Fri, 15 Nov
 2019 00:05:09 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (172.24.2.15) by
 owa.watchguard.com (172.24.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1531.3 via Frontend
 Transport; Fri, 15 Nov 2019 00:05:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRNWh6EWL2wz6rxFlwyF+Db8qyASxnsJIVYoXGyXtZ+vEn3wIdzYZ0LY9TCk+SBx7BsGha9CksH99/e1vyT1GgrxdWmF2diqahwy8K5vsPdZvb+Q1cT1PjH8zD15lJdkXMV9hTbSosA5ucc9n1U9EoIvC52V76wVFFliLFJtwq104i1jv1duM0tLI/5n9PVa3Zt2fRy2E40JdGm0Yc6vfCXNtIE8mWlTBC7/E5vbSV0yqqf5GQ/aFscVcRefQZVcnGL9Tt5YK6kZVvPNo+CrI0jI88iOWQEYhvs+1dXhPCUVoiFQ+uc86U7ggI4XS3qp3U5a8Cjut1yv64Ho69T32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMzRc53QEyt+uGj4k2ys/73qsZP1tzz0j3csMdlhIDQ=;
 b=PXX2AsR79sLWuTmrZr+1eFQLDl91hrMyH/ANce0x+TCedMRSNlflxuRJ3rXT0em5zNXI0LNRyHX8OTzJg7FBKK08TkQ8m78Yjn4dHmvsMqlauZS4sFCydEaECuWB7gKZkstUNUNOmrOdL9tgGWMA89pZUizVUMq7Vm18L59OG1qdOj+xa9D5aBIX1DwF80onmHamySPUzxFmmq6uB4PQEYtfuo7rrACQJETNJliU1Pkv94/37jjqOrBwgKuGGHRJMj7U+ntGJ/RDe6rdbyvwKA483I1Fl8YMYuptofup0v6Y4naImzYTEjAVk11oL/AYnZFxdbCH7WB8w3fO+mkFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMzRc53QEyt+uGj4k2ys/73qsZP1tzz0j3csMdlhIDQ=;
 b=p8aIFnZb+jcQ/qTDVDZmVCDgVCjz2JRee/qbi1YNGm8VYg+krZdcm1dFQAsbQjsOgYGdUzhScJz1SqKJtkBcfYW6Wfh/TV1CKwQuo3EqPi2KFtk3bkn/OuN7/sDDnHPykSQz+oGFEUepMLauIT9HOBRt7sqfnh2G3Hfp9HO/Hbo=
Received: from DM6PR10MB2873.namprd10.prod.outlook.com (20.177.216.210) by
 DM6PR10MB2892.namprd10.prod.outlook.com (20.177.217.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 08:05:08 +0000
Received: from DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326]) by DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326%7]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 08:05:08 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Ming Chen <ming032217@gmail.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] mac80211: Drop the packets whose source or destination
 mac address is empty
Thread-Topic: [PATCH v2] mac80211: Drop the packets whose source or
 destination mac address is empty
Thread-Index: AQHVmyXJVNlh75ruok+MqCU7xk6BaaeL0sHegAAMm7A=
Date:   Fri, 15 Nov 2019 08:05:08 +0000
Message-ID: <DM6PR10MB28732321777DF1E1BCB04A259A700@DM6PR10MB2873.namprd10.prod.outlook.com>
References: <20191114195712.101568-1-ming.chen@watchguard.com>
 <87r229boey.fsf@tynnyri.adurom.net>
In-Reply-To: <87r229boey.fsf@tynnyri.adurom.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [64.94.121.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1834920e-d36a-4840-7ba9-08d769a28800
x-ms-traffictypediagnostic: DM6PR10MB2892:
x-microsoft-antispam-prvs: <DM6PR10MB289245547392BD144E085EB09A700@DM6PR10MB2892.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(346002)(39850400004)(54534003)(13464003)(199004)(189003)(81166006)(256004)(99286004)(7736002)(4326008)(76176011)(7696005)(26005)(52536014)(186003)(110136005)(102836004)(5660300002)(446003)(33656002)(54906003)(6116002)(3846002)(76116006)(11346002)(86362001)(66066001)(476003)(25786009)(478600001)(66946007)(6436002)(316002)(66476007)(64756008)(66556008)(486006)(66446008)(229853002)(6306002)(9686003)(55016002)(2906002)(6246003)(71200400001)(71190400001)(966005)(53546011)(6506007)(14454004)(8936002)(74316002)(8676002)(81156014)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR10MB2892;H:DM6PR10MB2873.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSbOjN0cZbRTLduKQrFONOFLclTZC6QalhSlOuS0fw3dnz8RSJ2XX+78LdcxKYULVFjVCyaFmfl/cuc/CL0tJhAnc2gKPN1jIHmS+lWiAN6xnzPy0BJw/9Ju0BccCe27am1xhYoRiphZQ33TtPqMAexJwAa/DY9IPGDITX1d2Fk7GJEFoax8R5uy2CPoHCYtZbzzCnN3ejHcZquu70MjcK/v/M9N2zxwvfEdKo87TspD4lCgg3IEDy5Ov7TdP02ciUdJqoyQx4jDC4OP1FX1sjzdQM+CfLgJ+IIkbVSB7Nn1r4bDzFL2PyELvYiILIO2GauG+dJxmEYPwDxB1R8tcprkj7viAKo7ZubTxQLunqKTcQ3X+8tAYNURb4KWkHy+3861HaSBaiHhBNuzRmgwcaGZqVJ6Iw40MpuaBfBIFnF5U+txaPQapEsjknp6Mv+6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1834920e-d36a-4840-7ba9-08d769a28800
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 08:05:08.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiPXrK7OFCzWmW41V2LvVHyROczF5ZKHol2nss1Ge9nRSGAr9nng+AHoKmQdbUGqRLiSXnV8nVfzN24vWGPilFSVQf0XquVAiSYeJefhc0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2892
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for your careful review, Kalle.

I updated v3 with regards to your comments.


Ming

-----Original Message-----
From: Kalle Valo <kvalo@codeaurora.org>=20
Sent: Thursday, November 14, 2019 11:16 PM
To: Ming Chen <ming032217@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.o=
rg; Ming Chen <Ming.Chen@watchguard.com>
Subject: Re: [PATCH v2] mac80211: Drop the packets whose source or destinat=
ion mac address is empty

Ming Chen <ming032217@gmail.com> writes:

> We occasionally found ath9k could receive some packets from Linux IP=20
> stack with empty source and destination mac address,which will result=20
> in the driver cannot find the station node in TX complete. And thus,=20
> the driver will complete this buffer but without updating the block ack w=
indow.
>
> To fix this issue, we should drop this kind of error packet before it=20
> goes into the driver.

The s-o-b line should be here, before the "---" line.

> ---
>
> According to review feedback, use the is_zero_ether_addr to check if=20
> the mac address is empty.

Very good that you added the changelog, but to make it more obvious you cou=
ld, for example, mark the changelog like this:

---

v3:

Fix s-o-b location

v2:

According to review feedback, use the is_zero_ether_addr to check if the ma=
c address is empty.

--
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
