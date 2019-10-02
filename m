Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDD4C8B22
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfJBO0C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 10:26:02 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56254 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbfJBO0B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 10:26:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92EOYD3027675;
        Wed, 2 Oct 2019 07:25:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=chcAiA24UPFBHp8xFxdkFhcCoZoXKeIj0ypR+7V39VI=;
 b=eztaknN/TOeqtqzo97zEXHGNm1/s8empjr6vnnZkrG0QX+Msxp5Vb/jDJ9AQQldcg1e8
 nqGSHZTSGNNxJDDz1vYzOSdkzTKx60rKGMeh+crqVAXRNpCDi6CaqUVD+re+Qwk/8RJA
 4o/oX31qGtcQCcc3xUQrFdsD6FFnvqIWzh0BEMMke4QeS95qGu887i0QazwyjgSm25EH
 rAiCp8rlqOo+zYVLOqXwuNsWu78OAlLXD/Ygh/nYjaH3ByYcLOHPpF25AXKfUxGVncRA
 f3JNrtfjga8u4uPjv83gLuYgP8rAQooSMk+oq89SSWE4VUgLV9bueHFDY8db6Xe5fXMv tA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vcjbn290b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 07:25:55 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 2 Oct
 2019 07:25:54 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Oct 2019 07:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBz7AlrrlHy5OwZMANDTdokTlVI/LE4gW9JaXT0pFsSp5sazJeejho/THGjIhhoB1pkYsQytbis/O4qYYq2ZCjTEG795Um7Ju/XIvdWysQMgZI1kfGvQWuUuPo3rsQ7pIfv8HpJgtxUYTNku8dosk//1/h8FmQEPAeEk723s6PvElFc8pJOfvPAu/Dz0MxSMuzBGU16JqQffRDhlH9W71dtQICGVyf6rMmE1FJA6/wxft09q2CueSLt8Nfpv1kmRWvl30sH+GGra27fzn1D5n97hrC/Jpy69UX4VRtYAvIXJ3jDVBxFUCJZywoN2aoVt+xMwbIQ/5eYUW8xy1PoeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chcAiA24UPFBHp8xFxdkFhcCoZoXKeIj0ypR+7V39VI=;
 b=HNapBEiGRi973aYu82FOX+rgGlsbFG5jMZ11Nrd57sTD2tRLFJ+661rueEJ/1yQZbj8D1WPN2jEZxxmWxoEFXJRIAt7jdyMeDPVx8qJSwepVuYE9rroMIkkPWfJQh0JEjzQDlWbt+N2+Pe+XkBLYsZAdp0RR/hgxiuz/8vybbmyo9Yfx3x+fL6lWtl6EhVGw6Pz8zQcq140AYYIRIGT4XQffS713O1PwYNtLLgA7I+oZaRtLC3Vap8yNp/iUAMzc6CSibf4+Ixxry54aPkkFjZQjHikEjX8oJRYDjx8+wgxheM3VWUl1OdequZQQ9i4QM65BH7P5DZk2BbKWtkLvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chcAiA24UPFBHp8xFxdkFhcCoZoXKeIj0ypR+7V39VI=;
 b=e19X7iwXwm+MomsS8Zg5ByCzfW3g+jR5/K4frm3cXQp/N0xrAeV+yRTSKE1jJawAFSQFTDvmcSUsx1GdpfH9TyXBKhkZxhqAZRkeBKU4J3+5Ws981yYl1vKSDsaitAX0J7BzeNgWVZrHhEw23+WKk1oybCMf0Uhw75drV+YXAGM=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3149.namprd18.prod.outlook.com (10.255.236.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Wed, 2 Oct 2019 14:25:53 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::cf1:1b59:ac77:5828]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::cf1:1b59:ac77:5828%7]) with mapi id 15.20.2305.017; Wed, 2 Oct 2019
 14:25:53 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: RE: [EXT] Re: [PATCH] mwifiex: avoid deleting uninitialized timer
 during USB cleanup
Thread-Topic: [EXT] Re: [PATCH] mwifiex: avoid deleting uninitialized timer
 during USB cleanup
Thread-Index: AQHVITclVlRHwuKWQkGkD8XYjyf/L6aaW0EAgK2u2DA=
Date:   Wed, 2 Oct 2019 14:25:53 +0000
Message-ID: <MN2PR18MB2637A80D365B8B68E8216CA0A09C0@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <1560354873-17182-1-git-send-email-gbhat@marvell.com>
 <20190614011648.GA121099@google.com>
In-Reply-To: <20190614011648.GA121099@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.17.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72ee15ac-a247-4474-f18e-08d747446e87
x-ms-traffictypediagnostic: MN2PR18MB3149:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB314956B499515CC9418F3300A09C0@MN2PR18MB3149.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(25786009)(74316002)(64756008)(256004)(14444005)(76116006)(66946007)(86362001)(71190400001)(99286004)(71200400001)(7736002)(305945005)(76176011)(4326008)(6246003)(478600001)(33656002)(7696005)(186003)(55236004)(26005)(476003)(14454004)(102836004)(11346002)(446003)(486006)(6506007)(3846002)(6116002)(81156014)(81166006)(8936002)(229853002)(8676002)(2906002)(55016002)(52536014)(9686003)(54906003)(6916009)(5660300002)(66476007)(316002)(66556008)(6436002)(66066001)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3149;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgKuyCKFqtcVGy3XCDVz3kStL4ccIUw+/qWEkxpXZ16nYEooRWX0ZtrdOQ4Ckle0zrVvRqGIxT/EHhnyh0kC9mF+ZxTt2CRSmnSFYth8d2QiFZJbTrjQXNN2907hxF3xetNMFE5E54d5CkNoVfamDln/lSxFbSM5xygXDH/tV/bmOg6UAkLQdEaLuuH5TTu+DWJV1Zi0GCVVHySuXD/n4KForx21PtvfNbthNxlZENZe5PH0iJhSDwxWkbDiaHhmSghqBc8kPjAVo/31VsYrtT26vKnU9r6hkNsLuHvFKaDdzi6VqxU/N+5mc78Tmnas3xymhmaRSDPWWZNsBjFch/jFK8xWqs7/PiG4mRzl3H+ehfCb1ezRyUJO+dG2sB+ze0GAEAhClVc5NpzoFE3JzQjXF7fqNKPZGob1tQmGFBI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ee15ac-a247-4474-f18e-08d747446e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 14:25:53.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHHBuFWlSP4tIPEcohOBxavjAcg43xsmP5TR23HXlffw4/J2OIJjI7xXTn/mF0UuSZCGncB5ENmtUZ3bld0hlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3149
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_06:2019-10-01,2019-10-02 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,

Sorry for delayed response;

> > @@ -1348,6 +1348,8 @@ static void mwifiex_usb_cleanup_tx_aggr(struct
> > mwifiex_adapter *adapter)
> >
> >  	for (idx =3D 0; idx < MWIFIEX_TX_DATA_PORT; idx++) {
> >  		port =3D &card->port[idx];
> > +		if (!port->tx_data_ep)
> > +			continue;
>=20
> It's not clear to me what this is about. Are you sure you're not just cle=
aning
> stuff up in the wrong order?
OK;=20
>=20
> >  		if (adapter->bus_aggr.enable)
> >  			while ((skb_tmp =3D
> >  				skb_dequeue(&port->tx_aggr.aggr_list)))
>=20
> ...
>=20
> > @@ -1584,7 +1580,29 @@ static void
> mwifiex_usb_submit_rem_rx_urbs(struct mwifiex_adapter *adapter)
> >  	return 0;
> >  }
> >
> > +static int mwifiex_init_usb(struct mwifiex_adapter *adapter) {
> > +	struct usb_card_rec *card =3D (struct usb_card_rec *)adapter->card;
> > +	int ret =3D 0;
> > +
> > +	if (card->usb_boot_state =3D=3D USB8XXX_FW_DNLD)
> > +		return 0;
>=20
> This looks wrong. You don't want to skip your basic initialization just b=
ecause
> firmware isn't loaded yet. In fact, init_if() always gets called before F=
W init,
> so haven't you basically stubbed out this function most of the time?

I think, we are not skipping the basic initialization:
original flow:
PID_1: mwifiex_usb_probe  >>> "do driver initialization" >>> "download the =
firmware"
PID_2: mwifiex_usb_probe  >>> "do driver initialization" >>> "do interface =
initialization" >>> "do firmware initialization"
new flow:
PID_1: mwifiex_usb_probe  >>> "do driver initialization" >>> "download the =
firmware"
PID_2: mwifiex_usb_probe  >>> "do interface initialization" >>> "do driver =
initialization"  >>> "do firmware initialization"

>=20
> I guess the question is: is this step supposed to go before, or after fir=
mware
> initilization? Based on that answer, we can make an appropriate patch.

It was before firmware initialization, in the existing driver( and the new =
change also follows this);

>=20
> (The original code does this after FW initialization, and now you're only=
 sort
> of moving it before.)

I don't think so; as per the above flow, things which we moved to init_if()=
 were previously done in mwifiex_usb_dnld_fw(),
just before it return(for PID_2); FW initialization (mwifiex_init_fw()) hap=
pens after that;

Regards,
Ganapathi
