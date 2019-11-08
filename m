Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0433F507F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 17:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKHQDs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 11:03:48 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:41740 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbfKHQDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 11:03:48 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8G0mVT032083;
        Fri, 8 Nov 2019 09:02:02 -0700
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-00183b01.pphosted.com with ESMTP id 2w41u0p045-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 09:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca6kJGLRWeGEfTEgPxSTFQ/U9+pwv2hgZjWmyRXrrIj8GV3j2r/SD6SG1NPX4Nr+Euhm4OgRXrnk+KhzHk/RqVmqrB68zGJRzG+jRtihRZySJHfnzh+gm3zh3vSnHdMD+Iel3bujAngD8B49/YlYoU/2b2UxUjKp4aUGlnm17x5vVzjXnv7QZqwSjeoqMWJjbR2h0Z+6QJQN5HJowDNEW7QH+xeVyvcedtS6S8/x1jBl86etrwL8FrijxaceAvX4edXMV/m26fLD2f2nVIJD3HM/DOH3PXJwByQVbaNvlVffLTn9NugRHTC96iZcmDxrs0mIpwUlisRNkQkBFJahUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP1yd8B2jVT34rglV3s4JPNYFrj3PL4Zk6d+rr5wrcs=;
 b=JJXRxGhkCXlAcLMMhgGVO0n6/hnkgW01FEb0n/0xSC+m8JwkR614ex2ROy3dwYJa40Cyl19n6IR7QYN6fEfS/c+rSSsyo/gT/gZTOR0uxaXLT5zxgjLmuHFnMmt6vYiEE/3OXmuhZohSxvoBzNuJstN465SMDEAwmYQyC1CAmF/YPW662M0qHTqIzb+umgpMTr4xnemN8LrKCb0UkTbha9M5BUN9CfQlCalicWmoLJWO/RlYk7Rwh7Kf7xzQJN5HGL0kgLZhsTNtyVb6wcPvqK1Bdg/SkaW8DFrBvUoNp1o+fpnfTkkjJm3wlNPp7LOz4J0u9jLEZP5ngfmBFl9o2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP1yd8B2jVT34rglV3s4JPNYFrj3PL4Zk6d+rr5wrcs=;
 b=cPL9Bb45GcnZaYYjOfDdfGxu/5sY56PVsyIxpaJLrYQCBJBoWE1G658QAI5T8L/qSH3SCK2fK//0NyRubwWE3OP3oecoYAedb+nu0g5xw/CcULlVTzACA+fqaHYbxhBybYvJnPvNWd2sRq0oSOtMK4zgS+3WHFC2mJ6ZYZdMKLI=
Received: from CY4PR05MB3077.namprd05.prod.outlook.com (10.172.161.8) by
 CY4PR05MB3461.namprd05.prod.outlook.com (10.171.248.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.16; Fri, 8 Nov 2019 16:01:59 +0000
Received: from CY4PR05MB3077.namprd05.prod.outlook.com
 ([fe80::1441:b107:8824:4d2f]) by CY4PR05MB3077.namprd05.prod.outlook.com
 ([fe80::1441:b107:8824:4d2f%10]) with mapi id 15.20.2430.014; Fri, 8 Nov 2019
 16:01:59 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5309.namprd05.prod.outlook.com (52.135.109.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.13; Fri, 8 Nov 2019 16:01:28 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.013; Fri, 8 Nov 2019
 16:01:27 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Tamizh chelvam <tamizhr@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
Thread-Topic: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
Thread-Index: AQHVk9Zp+IDFjvKhwUy86pHdyrrRoqeBOWSA///PyYCAAFrzAP//0eKAgAA92AA=
Date:   Fri, 8 Nov 2019 16:01:27 +0000
Message-ID: <20191108160121.tbatmqwx64aoqqai@bars>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
 <20191108093207.uv4j44xpm2qvtsv5@bars>
 <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
 <20191108120504.ptl25hacxcftb7tw@bars>
 <1c553c457024b295c7d0a6b118c3848eec28bcbd.camel@sipsolutions.net>
In-Reply-To: <1c553c457024b295c7d0a6b118c3848eec28bcbd.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc58208-9345-4cd7-98a2-08d76464e961
x-ms-traffictypediagnostic: SN6PR05MB5309:|CY4PR05MB3461:
x-microsoft-antispam-prvs: <SN6PR05MB5309048E0B0F204B4E620064A37B0@SN6PR05MB5309.namprd05.prod.outlook.com>
x-moderation-data: 11/8/2019 4:01:39 PM
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(366004)(136003)(396003)(346002)(39850400004)(199004)(189003)(33716001)(8936002)(386003)(6436002)(486006)(66066001)(71200400001)(81156014)(71190400001)(6506007)(476003)(6246003)(7736002)(256004)(6512007)(2906002)(316002)(54906003)(66946007)(446003)(11346002)(6486002)(9686003)(66446008)(436003)(66476007)(66556008)(64756008)(305945005)(26005)(14454004)(52116002)(86362001)(4326008)(99286004)(186003)(25786009)(102836004)(478600001)(6116002)(8676002)(1076003)(6916009)(81166006)(76176011)(3846002)(5660300002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR05MB3461;H:CY4PR05MB3077.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zAhjUGVnvY0//dm/o9NR87xJOgPqAW6mSMiepRE808K2urH5h9cDdp8DrQ2+JYwccrCGL2OXGqn27OR7QIRt3r2HSokMrS5Gmj2YbmAOzMq0xsKBTNjd0Zpj4WD9zo/zlZuZtuCCnPC7fxjGKcQ68S6HV7VzEZUfiD9sdECnOlHnIHomfkwEOfUY+ZMLvl3M7tzLRIUxnFaEL7x1M1XtVh2JgnoHFVwhKQ2l2VPKwOZGmSxLnuM8PfAmXzjAOOQm2k+fHN/lClsMKMgwA1eELrErDBiD4BP8DEgp6y2ZC6dEbOIPnznDOH9iVHBhfHM+vM3/FKBcJqnkxPfLqIJ5jUtMFvoBtTyvPua6Vpx+NIV/Uuhwpu2d7waBrvwrLPAfYlD5LmBTWz6SZ42lMp890L1zRu2zS1WNOA2NNSIO79O4mkZW6cpEYrnCYgWxiJN/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <668FE59510DBB34CA2D07D2E9C7A944E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc58208-9345-4cd7-98a2-08d76464e961
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HeIcXwlE9kocRJISGIR17bvIzQFyLYRyeLviwZKKvBD8chqNftfZA42wZON+M5b0njEeZs/LushrADnWJLkJO3mU9KGCFMqrvAgSk8viAHfw6H3+JV3QPCv9iI/X5t7eupCq4gqF03nQR9oT74YoYtorlB2EJ5y6DOIU1IafpjHSytVrBsd+q62YCtRsuN3B3htn+G1AtBgwky5aVTW+yrds/vKPBn6RLjpaOMxW5M=
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 16:01:59.8032
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3461
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_05:2019-11-08,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911080159
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > > @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribute, valid only if no S=
TA
> > > 	is selected, if set indicates that the new configuration
> > > 	overrides all previous STA configurations, otherwise previous
> > > 	STA-specific configurations should be left untouched
> > >=20
> > > You also raise a good point wrt. "all TIDs" - but then we should
> > > probably just remove NL80211_TID_CONFIG_ATTR_TID and add a new
> > > NL80211_TID_CONFIG_ATTR_TIDS as a bitmap? OTOH, it's not hard to just
> > > explicitly spell out all TIDs either, I guess, just makes the message=
 a
> > > bit bigger.
> >=20
> > The idea with bitmask for TIDs looks good. It eliminates the need for b=
oth
> > 'all TIDs' define and additional attribute NL80211_TID_CONFIG_ATTR_OVER=
RIDE.
>=20
> I think we still need NL80211_TID_CONFIG_ATTR_OVERRIDE in some way
> (maybe only as a flag attribute), since you could have
>=20
>  * change all stations (some subset of TIDs) *including* already
>    configured stations
>  * or *excluding* already configured stations

Hmmm... Logic is straightforwad without this flag:
- settings are applied to bitmasked TIDs of a single peer if address is spe=
cifed
- settings are applied to bitmasked TIDs of all the peers if no address is =
specified

It looks like you want to infer too much from a single flag. Why keep this =
logic in
cfg80211/mac80211/driver ?

> > In fact, almost no changes are needed for the patch, mostly comments ne=
ed
> > to be updated. Manual typing in iw will be less convenient, but I guess
> > this interface is not supposed to be used by humans after all...
>=20
> If that's a concern we can parse a list in iw, e.g. "0,1,2,3" instaed of
> "0xf", right?

Oh, right, it can be that simple. But this is by no means a concern.

Regards,
Sergey
