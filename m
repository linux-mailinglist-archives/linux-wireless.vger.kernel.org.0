Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8DFEAEB
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 07:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfKPGXX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 01:23:23 -0500
Received: from mx3.watchguard.com ([63.251.166.21]:39300 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfKPGXW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 01:23:22 -0500
Received: from PRDITOMBX02.wgti.net (172.24.2.22) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Fri, 15 Nov
 2019 22:23:20 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (172.24.2.15) by
 owa.watchguard.com (172.24.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3 via Frontend
 Transport; Fri, 15 Nov 2019 22:23:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6/pa6mqY4HqhXtg8qFc4OunVZfxp6rAChn+icQeFc1E7kjoTLdkcntAFs9zH+FHFQaXVriF7kWrbDD3+ORpHUQKAuVfSuTB3wvid8+uJoYkTjd+5HQMT0ybX7CRU0v8sYZeVYKlL3c/JtBAVj99gqbb2BfZ1q3NubtmjPpPAQRXpih4Fxzz73f8+bRPRxvID6E71aQK/INOyQPpuQPddPrcPIEiccv4AB1DAmAok05A+aKuqEJ+n8AZ16Yu8nHzIan0ldIkqCTT/zekgyhHFOYl2gXjdELCTJ2+nucpTXP/ON9xa8C+ZRKbHFlikBKARklRxtdp1+TfSri2GgG+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L8QWZPqS4uIDjzHwWKELVh/jzSOyYJczsOLnskxJIU=;
 b=M4Ue8/MI2hm8eTR7mYZ7TrMyrHR2WAm+N3YGSJ+2MCT4YbmwakLq/5BkbJUqr1kNqZNrjDRoVSFxzNNLptRHLUT+EdNlQ0FB4NUFldQD0eD+ZXuVRtxC83HAn/NGcxRuLDD9rKyemK5/KnlKQjWxj2+iJgfmOulxFz2FQbFvQksW07/awM/uARmx3QUspWX4xk5zGE8fUwYH9NoDdF8R08ne+QKSgPa1os3Le/9OW84NPTSEIDu6+KALvlvF39E5IkzSFPuQ2ODl1BprpTKqZAlIrnDN9qBUoSzWPVZL/KY2cG5awkaa1OfOWMEGShyFIA6tICaYlzL+jh0kpNVPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L8QWZPqS4uIDjzHwWKELVh/jzSOyYJczsOLnskxJIU=;
 b=YML5ss53i4H7oKPs+EvTm/HiAzx0RcYY/mPHvg+SG3N/3hHZl9lIBNebZfFDr+0JkAwxIWNX3IDq1e7KmdRmZpkocktSziCe8sMRXAR3kwt611Hf0T+bhnDtQru5+GdwwCARq7NGwuYTYB87FMHvOnAs0IWMHJ9LufrBdNenCzE=
Received: from DM6PR10MB2873.namprd10.prod.outlook.com (20.177.216.210) by
 DM6PR10MB3529.namprd10.prod.outlook.com (20.179.68.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sat, 16 Nov 2019 06:23:19 +0000
Received: from DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326]) by DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326%7]) with mapi id 15.20.2451.029; Sat, 16 Nov 2019
 06:23:18 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Ming Chen <ming032217@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3] mac80211: Drop the packets whose source or destination
 mac address is empty
Thread-Topic: [PATCH v3] mac80211: Drop the packets whose source or
 destination mac address is empty
Thread-Index: AQHVm4qy2IvYpqnIhkal+43ocTkSQaeMErkAgAE/H2A=
Date:   Sat, 16 Nov 2019 06:23:18 +0000
Message-ID: <DM6PR10MB287371E29EA6E72C8EC4B7A79A730@DM6PR10MB2873.namprd10.prod.outlook.com>
References: <20191115075942.120943-1-ming.chen@watchguard.com>
 <87sgmpmm7z.fsf@toke.dk>
In-Reply-To: <87sgmpmm7z.fsf@toke.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [64.94.121.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfc754f8-75b2-4640-dca2-08d76a5d78f5
x-ms-traffictypediagnostic: DM6PR10MB3529:
x-microsoft-antispam-prvs: <DM6PR10MB3529DDE2DC4D2D7095E280819A730@DM6PR10MB3529.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(51914003)(54534003)(13464003)(110136005)(316002)(102836004)(6436002)(99286004)(66066001)(52536014)(26005)(2906002)(3846002)(66946007)(6506007)(53546011)(66476007)(64756008)(66446008)(6116002)(8936002)(66556008)(55016002)(76116006)(9686003)(25786009)(86362001)(6246003)(74316002)(76176011)(486006)(71200400001)(4326008)(33656002)(476003)(71190400001)(5660300002)(229853002)(186003)(7696005)(478600001)(256004)(7736002)(14454004)(305945005)(11346002)(81156014)(8676002)(81166006)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR10MB3529;H:DM6PR10MB2873.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FM1cS0fM2VtqGyn+wQbn5K7CDvThtXO8xCnGO/dQKB87AYKkk94vrFSbAx4jkVSEF7g5Uy6AMFica3tmxbE9n295vDiE2TqPIRpvuPay3u/0uBHPfZRZlHFv17VqY5qufvDa7X38VQlniGcFJ95iSsiNE7chMqPjmlY9qnDIsGWHSx70QzlrXpmijSY+iQqnmistn9D3cDolJKNHCRjBlk2XWOaUDDYCrSnOp+o/9/+sRjP2kxFTyv8YuRUQXQHNA4plGQD6sq+cfMZvgyGU6m8k+KsYGE//x6jmGw/zgG8pDGjum7L7vUuNoVSnbro89/xhD7dcWC+rvo3utKbn4UWNDOdEsk7yVz3okGTbOi5cfF51WNxim2RfnVYQPJhvR2VQ5wsl2r8zUEUvy3bB1eV0kuK+xmGAvsc2WIGGQo0xYPk51OxBIWNUyTi+qjS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc754f8-75b2-4640-dca2-08d76a5d78f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2019 06:23:18.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaMR3r1gkRfDfqnrWNp7JfdHPhTR8l0JnH6wILyE9haIVIZwvgfWs19X8Z/S6HxU3PvoNss8sbNc0ZISnbaSZKD3Flc692cyxOMporyvU9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3529
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Toke,

Thanks for the review.=20

Please see my inline comments.


Ming

> -----Original Message-----
> From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> Sent: Friday, November 15, 2019 3:08 AM
> To: Ming Chen <ming032217@gmail.com>; Johannes Berg
> <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org; Ming Chen
> <Ming.Chen@watchguard.com>
> Subject: Re: [PATCH v3] mac80211: Drop the packets whose source or
> destination mac address is empty
>=20
> Ming Chen <ming032217@gmail.com> writes:
>=20
> > We occasionally found ath9k could receive some packets from Linux IP
> > stack with empty source and destination mac address,
>=20
> How does that happen?
[Ming Chen] To be honest, I not quite sure how it happen. When the radio wo=
rks as a wireless client,=20
I cloud occasionally reproduce this issue by disabling DHCP and configure a=
 static IP for wireless client, and also try to ping to its gateway without=
 break. My kernel version is 4.14.
>=20
> > which will result in the driver cannot find the station node in TX
> > complete. And thus, the driver will complete this buffer but without
> > updating the block ack window.
>=20
> If it can't find the station, how is the packet transmitted (and affectin=
g the BA
> window) in the first place?
[Ming Chen] Please see the new changelog of version 4.
>=20
> -Toke

