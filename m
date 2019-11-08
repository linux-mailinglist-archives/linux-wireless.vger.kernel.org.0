Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B55F4A30
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbfKHMH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 07:07:28 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:30534 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391877AbfKHMHV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 07:07:21 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8C57kA023002;
        Fri, 8 Nov 2019 05:05:36 -0700
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2056.outbound.protection.outlook.com [104.47.41.56])
        by mx0b-00183b01.pphosted.com with ESMTP id 2w41u0njwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 05:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5aQhd+EwxZXlW+HXhyiQonu4ErC4xiSfzPtLkAbUXjfBGOvmTo/rw20z9tzaUPj98CUqXuuUTa71vp22eOh7GS28+33MGd5Rhf2SDFaqMIKcQVG+ZVDOoV1mnzfwY13daacNmQp57AXyN2fNt4DnOwxpG4aFdy6g0DhoAbd9rUEkmuOSQOQfEI5Tp+tBnA35jDYvBfTU44bccFnuY2WvIb0WbJpQAC+km5Q+eHFNEJcce/IMYaFg2tBzObYTrGVPtljZiKJjIHc9bQNNxTKXEUyMZA4ZftTl3xsCmlzew/tkzL/t1bvvwZhLQi1TgzfHiMLSjxuSPYZHrfi9t77Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3UQI8ZWS2/avjt/CX90h55Q5sU/YPXSZKU8KVlHu7g=;
 b=Tj47dHUMDdD79aIBYnhGBs9HOuqTB2KlczzkeGkAr2BF7n0ZxCbajx/fkgD5L5aZhvsXC0JvmEF2mmhiQ79gzJC0AOjxXostgJHW5j+ln1K8+9GvVFGGu66cZKLkL87xazHBK0MxcVNwaXK+HVOLT06FUigS2lmTi38icOOMONnvC/KJu9nbJI96EZOrDMFVmmcrjNYsyi/6619d8WqYwrn3eA7HLFC6o1M9k6RgGCkL8LOdkF8orrJmBnjj6t/SaM8mPt472j8DO2YDbqVt3yL0OvCufRiSx9t56BR8VMSHyeH2H7Ofo4LzREVuC4duKk03L060jDTu0rovoxIpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3UQI8ZWS2/avjt/CX90h55Q5sU/YPXSZKU8KVlHu7g=;
 b=cJm89hJ8D5NJwgqkyu5nwE2TKk60OuQ5vubHG5UjjpUnM1GFUpZXU49FmJxi2G63IQZvFu5JAh0/kx/MXjdKeq24kLlQhT2vgMQ42wtiSlgrIC7GGg1pS/dex88tUN3tAR2FF9KVEi3oorHCGpBxrhrY6QOVZccvBZXz3TemQA0=
Received: from MWHPR0501MB3801.namprd05.prod.outlook.com (10.167.163.161) by
 MWHPR0501MB3835.namprd05.prod.outlook.com (10.167.173.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.13; Fri, 8 Nov 2019 12:05:34 +0000
Received: from MWHPR0501MB3801.namprd05.prod.outlook.com
 ([fe80::ed3f:8a5a:a8d5:1c71]) by MWHPR0501MB3801.namprd05.prod.outlook.com
 ([fe80::ed3f:8a5a:a8d5:1c71%6]) with mapi id 15.20.2430.020; Fri, 8 Nov 2019
 12:05:34 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5664.namprd05.prod.outlook.com (52.135.111.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.16; Fri, 8 Nov 2019 12:05:11 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.013; Fri, 8 Nov 2019
 12:05:10 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Tamizh chelvam <tamizhr@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
Thread-Topic: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
Thread-Index: AQHVk9Zp+IDFjvKhwUy86pHdyrrRoqeBOWSA///PyYCAACipgA==
Date:   Fri, 8 Nov 2019 12:05:10 +0000
Message-ID: <20191108120504.ptl25hacxcftb7tw@bars>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
 <20191108093207.uv4j44xpm2qvtsv5@bars>
 <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
In-Reply-To: <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::13) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 569990b5-028d-4a28-48e2-08d76443e77a
x-ms-traffictypediagnostic: SN6PR05MB5664:|MWHPR0501MB3835:
x-microsoft-antispam-prvs: <SN6PR05MB5664AA13EA6357E80D102B3EA37B0@SN6PR05MB5664.namprd05.prod.outlook.com>
x-moderation-data: 11/8/2019 12:05:31 PM
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(376002)(39850400004)(346002)(396003)(366004)(189003)(199004)(33716001)(436003)(6512007)(305945005)(71190400001)(7736002)(1076003)(5660300002)(229853002)(9686003)(6436002)(476003)(6916009)(256004)(6486002)(486006)(52116002)(11346002)(446003)(8676002)(6246003)(81166006)(8936002)(316002)(99286004)(26005)(14454004)(3846002)(6116002)(386003)(71200400001)(66066001)(76176011)(66556008)(25786009)(86362001)(6506007)(186003)(102836004)(66476007)(66946007)(4326008)(64756008)(478600001)(2906002)(54906003)(81156014)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0501MB3835;H:MWHPR0501MB3801.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCwTD+aEqSuouYtxQTPeK/p7ipvh6meg9Jtoj4y6jPNw6KY+YTsb2WA1ynacHCdzF3dVkeZmc3ncmlZ2Jhif1/piV58RkdOPN+O6yXpPtqQBgwfhI2pduZQW7aSb7q4s0dN/iNASK6G/T6SjTCNT/KAXpRI01qlJEdHZoxVXQkenkcq3xmMGPCTqid4Pko+hzC2wp6A6mzjxTTDM+UbkNL/QF34Qvdbz84j30TCOxpd2fbgVb0EfGMtCHb6j4AaEdtxRW0jnzPTT4GfTh4oFlr+SylRlrWeU+HXpLNlnr42MhpBtFZ0uM5aBPYKxqzmyFtyIdAucE8JCVrZztK8CLsj6cm7Y3CMUE3Ssn8n1fM7cIlXVZ06agJtJkNQ6BjDd1VL4+YP5mvPn+OfPDI9YYVlG/kw6D0v+vvynYz5vzCPmd+0hvPLZomOeSc9UYbF9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EC29C0B87002145B1B884546745DF0A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569990b5-028d-4a28-48e2-08d76443e77a
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjcNJ09RkDDaHHeYXm8XtWk+SevHUmyp8MEaz24EDGjNOevD06kDStk7knrjmtTCMYQQbnvfwiFLP9mB9wPCtnbLbixJf/iQzB5OQCmW6iscNwpl+7CmgyTRqUzAHSs2rLLHacywv1qI/JqPwwyu9KINGWYYIAMzgImtOA2+veo2qnsSYxHIG9oqe1WFQLOyM+jSBAW5TX9EmlGnG7HoHQ==
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 12:05:34.4991
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0501MB3835
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_03:2019-11-08,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911080120
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > - 'apply to all TIDs' usecase
> >   Currently, if peer is not specified, then configuration is applied to
> >   all the connected STAs. It is tempting to use some spare TID value
> >   to inform drivers that provided configuration should be applied to
> >   all TIDs of the specified STA or even to all TIDS and STAs. But that
> >   can not be left up to drivers since this value needs to be passed
> >   from userspace tools, e.g. from iw.
>=20
> I was *just* replying on exactly the same point over in patch 1 (not
> sent yet). It's actually not even clear to me that the configuration
> really would be applied to *all* STAs, it's sort of left open for the
> driver, afaict?
>=20
> But I agree with you that this is not a good thing.
>=20
> I don't think using a spare TID value is the right signalling, we can
> add another attribute? E.g. we could easily add
>=20
> 	NL80211_TID_CONFIG_ATTR_OVERRIDE
>=20
> and make that be
>=20
> @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribute, valid only if no STA
> 	is selected, if set indicates that the new configuration
> 	overrides all previous STA configurations, otherwise previous
> 	STA-specific configurations should be left untouched
>=20
> You also raise a good point wrt. "all TIDs" - but then we should
> probably just remove NL80211_TID_CONFIG_ATTR_TID and add a new
> NL80211_TID_CONFIG_ATTR_TIDS as a bitmap? OTOH, it's not hard to just
> explicitly spell out all TIDs either, I guess, just makes the message a
> bit bigger.

The idea with bitmask for TIDs looks good. It eliminates the need for both
'all TIDs' define and additional attribute NL80211_TID_CONFIG_ATTR_OVERRIDE=
.
In fact, almost no changes are needed for the patch, mostly comments need
to be updated. Manual typing in iw will be less convenient, but I guess
this interface is not supposed to be used by humans after all...

Regards,
Sergey
