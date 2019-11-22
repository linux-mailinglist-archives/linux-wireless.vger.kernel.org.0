Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE0610718C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKVLlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 06:41:06 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:64048 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbfKVLlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 06:41:05 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMBe3NH023914;
        Fri, 22 Nov 2019 03:40:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1m9zP3otFGglQE5c6DgKJ7kjranlTb0taKOnU+W8TDI=;
 b=KuqF9pJVfl+7UdYzq843geWnc02dYETdFEMjdViOe07HEeD7syrQsumg2DVi+hi0QUm3
 1D2NK9bl0AuZg/WtX9hxO6XLDUi3YZ8kYQVRcwvi7w5S2uvPC6AtzC1TSAa04qvSD800
 nh/nHxcA9bTst4NBWk6OjLNjsD6ghbOcMVTrMLQ2LRU6u0aXSPN2ONRQvnsLihHk75wn
 S9j+1BswbcfyetNWNzWekX2mc7Y4vCHKQw5xBq/IDQCbO782s8jSuk1vEXpCYI/ARQNl
 BZU15kHMaZLfoC9vxYRPMKQx+4LWaYMQhPWJpopPpTur6JeNvfVEiIgYhuTpcLu5Qw7L Bg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wearf10nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 03:40:46 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 22 Nov
 2019 03:40:44 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Nov 2019 03:40:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFh11/HBs41KkNzE0gE/M5LAYasmWtiIwjlU1DNYtu502Od/I6Aw7v2DEwzaqqBHHL0QfKDGMvKH+7OmdYsL8WICo/6gi5d83Q2h238nGSwtDrHjmNxOMgDtXkjSm2W+h/VP5Jg3fkjUgStP/S6BrEAAFkn+W+2Do0tRoFPcbMqmeku3YtTvtbEif9hgDYW5oFhtbrR7uX2P6YXHWdN8+ZnFT2FKOT8NNo41nAU+JLBNMkxaByywE7esIH2GwxVgdU4rVGAwBAw6nkSU7Xq7WLTTFe5/w6dCzTytnnVdtWvv9Lxuv7zRkCD2YNmF/Jf2ah/A1d9D/ROlUx3NDjhmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m9zP3otFGglQE5c6DgKJ7kjranlTb0taKOnU+W8TDI=;
 b=ltKnMzOmgkNcVtL+jGvjCwo7njmA1i2tC/A+6TXHSLkqn9M0HqXSMviVdyciuy3x6NTcDySbMtpVR+2Z1JsNIz7vS8H6Ahbqq2RzUIR9JrThj3hcR1Xq7qb67uCvl5R9EURwEhC9B2Uya3Sdbkp+q4T7agjKt5kgw0LyO6wTTecakqfafWTdF/gbVGSwSattsLxW+Kvh1dl6hI8n8eCrsFfyQ/CE+V4zz5ube6P+kDWP+L0W6NqB4AwcJQITRVLzZ7Ao79VRR/GL4Y23Eon/W2HJC9deacPWRf18yJrN05oRKoYGNI/fGxClqf2q+kvDpqAd6SAsQW0k2Q6YBelEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m9zP3otFGglQE5c6DgKJ7kjranlTb0taKOnU+W8TDI=;
 b=i/i6Ui3QITb1ONIQmlLvpd2jBFYgjJzjrIRQsY6btrWCthTlnMqRepiB4bEbgzOpYgGswA9rZxCk8cefGx73FFlfyJdwcStUFDXHTF/euBEMsugx9Gem/pH2X0TbxQK+zPwJbk9g4Dd5X80eT0v5aJh9p9ORCYHBZat3ploa1H0=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3309.namprd18.prod.outlook.com (10.255.237.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 22 Nov 2019 11:40:40 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::30b6:853b:5db8:aa0a]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::30b6:853b:5db8:aa0a%7]) with mapi id 15.20.2451.029; Fri, 22 Nov 2019
 11:40:40 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        qize wang <wangqize888888888@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        amitkarwar <amitkarwar@gmail.com>,
        nishants <nishants@marvell.com>,
        huxinming820 <huxinming820@gmail.com>,
        kvalo <kvalo@codeaurora.org>, Greg KH <greg@kroah.com>,
        security <security@kernel.org>,
        linux-distros <linux-distros@vs.openwall.org>,
        Solar Designer <solar@openwall.com>
Subject: RE: [EXT] Re: [PATCH] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
Thread-Topic: [EXT] Re: [PATCH] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
Thread-Index: AQHVoSX1pZ1v8apZIkKXiiV43VGQA6eXDo3A
Date:   Fri, 22 Nov 2019 11:40:40 +0000
Message-ID: <MN2PR18MB26373BC0C0D63A7C3CE09FC4A0490@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
 <20191122111339.GH617@kadam>
In-Reply-To: <20191122111339.GH617@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.17.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c85f2eab-027e-49d7-77c4-08d76f40cd1c
x-ms-traffictypediagnostic: MN2PR18MB3309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3309F93CCBB38E7A619E6FFDA0490@MN2PR18MB3309.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(189003)(199004)(256004)(5660300002)(110136005)(6246003)(14454004)(4744005)(4326008)(86362001)(7696005)(55016002)(54906003)(7416002)(6506007)(229853002)(76176011)(8936002)(102836004)(26005)(6436002)(186003)(55236004)(52536014)(81166006)(81156014)(446003)(11346002)(8676002)(508600001)(25786009)(74316002)(2906002)(99286004)(7736002)(305945005)(316002)(66066001)(9686003)(71200400001)(71190400001)(6116002)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(33656002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3309;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjxKY0jV6xRU4TXBWGJRm9iD6O1O6yVwNyXM73DIqSKJr7Xcl5b+tlm/SySp67O0EYpfKKSIAfe8Z6yUsl0ehMKLP8LUX5LnJFGJ5eysKLg7tSEBb/4b4WQs4ncIJzoVHbv+BJ3qytGtxoRXuSeVR460RQePSqLzbVbMaM5zSH3hVZEf3TSHKFaQpUnjYVGMYS90ChfhQJMQpTnF8ifrH3cGh9TjIz1xmCAub2urcjY7pR3hwdavMZD3LtBD7ZPi8Ne8Nwx/H8h6f6ZrSpBgZyMJs3oDI8y3Zrh/xxdUTyRRlvMJLSj4Uus602aiTJFzmqdJXrqHMi65f7KgMu8Lh4E6CTCCsiQlOjJZOMjrbfXZT4I7050/sCxV/IhKjF1Okbefc6ss52Ak4dJ7d5qD9c/gEB/PannjxQQMKv7i/FThpDUWxnIJ16E5Y1WItVsC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c85f2eab-027e-49d7-77c4-08d76f40cd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 11:40:40.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9VqFcSTbKiKSsGoI+6Q9UPognC9CWhpKncrPXdmwQi5d7qWVt8wst4Os8l3+oxE3e4xeL4A7VBnJ4utzbQGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3309
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

> > +			/* copy the ie's value into ht_capb*/
> > +			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + 2,
>                                                                  ^^^^^^^
>=20
> I don't understand why we changed "pos" to "pos + 2".  Presumably there i=
s
> a reason, but it needs to explained in the commit message.

I think, we were doing wrong in the original code. We are supposed to use '=
pos + 2' itself, instead of just 'pos'. This is because, 'pos' is pointing =
to 'ieee_types_header', followed by the actual data and the destination do =
not start with (i.e. it do not contain) 'ieee_types_header'(ex: 'sta_ptr->t=
dls_cap.ht_oper').

Also, there are few places were the destination starts with 'ieee_types_hea=
der'(ex: 'sta_ptr->tdls_cap.extcap'), which need just 'pos'.

Regards,
Ganapathi

