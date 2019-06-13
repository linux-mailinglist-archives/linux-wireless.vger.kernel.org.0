Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF53444FE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392711AbfFMQk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:40:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56036 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730565AbfFMGzv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 02:55:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5D6kVHV001398;
        Wed, 12 Jun 2019 23:55:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=bPjE28SnkxkV8BA5OlTk+gmSwadGM2/GWOEuAYL1i6Q=;
 b=r+w5+RvDRQLf/NU4+sgx4dRu47xgnBhFKcoVfnsRrGMnW4r0B2DPu7+BoV2CMjNg0ju7
 j+jLSPBohBZmUdMKawhuHCSHAZwWF0UcC/r2Ywoa4cFYlv1P3f1CMU3sVzmgL6LKen1h
 jkqZHW7DM2U+DHUKUXlX0HOfLu5VL2MYp//B4twp0rLAXDEgYr/MpVsbxYlBsNEVNYc3
 qZtcLpTubXJ34twiYk1ODe0C8Xx7uj4eqjWeUswQvEkX+xSXXkfk/Oyv53K/gC3DwuLe
 g5hDymfcrEg1GOU0wEDL9bpXHSh/VyWbnnr5FKoX/Ksw/QhItce4aLGw9+yn3zmAV1sd kQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t3cpqs131-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 23:55:29 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 12 Jun
 2019 23:55:25 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 23:55:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPjE28SnkxkV8BA5OlTk+gmSwadGM2/GWOEuAYL1i6Q=;
 b=jKZmKvqqrRipuTYbQRWRRahaBdKJAwWRfPJMne7A6WrFavk6NusIxYb6XuUw7qkxnEGsdftqpfmjFp47FcnTF4wirqOuvQcewX53y/A+mDioCaF+bWNFFB8KswsjgFEA8f5n8mC9EnTlPJ4d8BmAVmOOgTL/WAXVPbyQMeT+DyA=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3118.namprd18.prod.outlook.com (10.255.86.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 13 Jun 2019 06:55:24 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 06:55:24 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [EXT] Re: mwifiex: update set_mac_address logic
Thread-Topic: [EXT] Re: mwifiex: update set_mac_address logic
Thread-Index: AQHU5G5hjQjjDj7Q502tl1FpVaYtlaYhB8K4gHiZDNA=
Date:   Thu, 13 Jun 2019 06:55:23 +0000
Message-ID: <MN2PR18MB26370061E95E43F826F4E53FA0EF0@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <CY4PR18MB123726E26A33B0E4F48E785FA0580@CY4PR18MB1237.namprd18.prod.outlook.com>
 <87pnqbxhra.fsf@purkki.adurom.net>
In-Reply-To: <87pnqbxhra.fsf@purkki.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.17.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32253751-3d2a-4c12-761d-08d6efcc1bf7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3118;
x-ms-traffictypediagnostic: MN2PR18MB3118:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB3118E10B1C10C1A336592D16A0EF0@MN2PR18MB3118.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6246003)(26005)(73956011)(7696005)(305945005)(6306002)(486006)(186003)(478600001)(55236004)(66946007)(33656002)(68736007)(6506007)(81156014)(81166006)(66476007)(966005)(54906003)(446003)(66446008)(99286004)(66556008)(76116006)(64756008)(102836004)(5660300002)(256004)(8936002)(8676002)(9686003)(76176011)(78486014)(71190400001)(6116002)(3846002)(25786009)(7736002)(6916009)(66066001)(316002)(71200400001)(4326008)(2906002)(6436002)(558084003)(11346002)(229853002)(74316002)(14454004)(55016002)(52536014)(86362001)(53936002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3118;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xBaJ3bfF2emIBtk17r7h8KdBYkZPCiVoBbwDnuV70MStwLUtzGkb1ikVtOj3U2yJFXLdEHvgNQe2eTzqNFMzxy0BFx3oQCTXRkwu1BuMk0bAm0RkkINf7pWenJLhck+kZp0xahZeo8aE0cF41PAomgRd9+w6AleSBfuLhHWGxdgkVo7Eqh4qZ1HDGBRIGlIYbof0I1ut+z/JLxZmJBhS/CbLizIgYcWJZ4GwPP915u1O8dWs+po6a9FhUkCfrUGRWN5/3xf+YX+v1sqr0WG5Sfm/TLb6EwRzCuyai0IhKeCTGE8BvbYQtI+bLxF0aOGuxkvTiCSo7RY72ldspl1ngvzecF42fPpVxvDr1I0YrVzoHlHTPpx+UHQP6ZFDN8S56mcfPSvgmcnBJtGyTr6wlKO6idaRu5JE1dlq2Y4QMa0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32253751-3d2a-4c12-761d-08d6efcc1bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 06:55:24.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhat@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3118
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_04:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I did resend the patch with 'git send-email': https://patchwork.kernel.org/=
patch/10990209/

Kindly review;

Thanks,
Ganapathi
