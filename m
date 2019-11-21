Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57661104AE4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 07:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUG7y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 01:59:54 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:32230 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbfKUG7y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 01:59:54 -0500
X-Greylist: delayed 1841 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Nov 2019 01:59:53 EST
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL6SNFS005671;
        Wed, 20 Nov 2019 23:29:11 -0700
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00183b01.pphosted.com with ESMTP id 2wad7bm3m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 23:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLkcupYWOWfb/O8rj5i8j1YtT4aBmUwsnYN2yu6yjshiqsLlxPoUGeI0HIc346ixK9649DfNtGNX3PJPQ75R/p+vVHzGCyWQi4+VyofQFpJBpcYtboXUBUPgQJ2TxCqW9rsJcA/5aJK7Z+krM7PBltax74/Dh29m2RjXiLrVs3bWMPfUDRy3QNMeT85BdJbvc6SYcyGNTCSmqyxKp4Xp+gmGZp8py8UgHYjfFE49YRQ+m3FtQTs9hreVeTyf+O7icT2bA/5WuAuqj/lb9Hd/pfZnHTs9nibnGZwb/zv7uIR0ioqyjpfFppAhHZqFmjUVzkBm7Or9X46THGI+Ojr3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5dgK0B6U15tF8I+byp+8F3hyve3r7d3yafLymmu5hY=;
 b=BdWwi7ng2ZdKg34Y1seyKJFSGeIicb2FjKuCVGOVMkq7fjnELJXXua/86f0t7WGsf2CNtoz5E1zmd1N9aqQ8KjX3iyUSVKB3YYjk2v/NAiEhrpIMJtYCxalxsCBMEUEtNOqbNC5GXB4QiRGCdC7A3SO0UnZZ8BA4zCSEv4sPN56fE5TjoMd7l00OEZijiiG4r3dpPxW4gpKjWZ7MipNVMEULOjvkGJHOemshk4LvBjEio1FCPM8nlY8Pf1Vg3IhW/A3R7EJaX353+feS01Bt51ACbK0TVmFisNcH6COM1jhR25h6E7X0NMnAO7k1eXO42e8uu6eZ64V6cRyHz8Cwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5dgK0B6U15tF8I+byp+8F3hyve3r7d3yafLymmu5hY=;
 b=UykOgiY5J6+lADx54dPhuWNeaDmT8iBmsv+SLf7haSy/kFaZu/YuTR4TF7ba0eLxTql2hICPGRVy4t97LMkiI1Mz04k0lS/jBKf+DgHTjrZs6RrMqpCWcx2nSZMvgz3lzTQFROw1OlVWHDWG3uIkZDc17IXPAUc3clUPJIZLycA=
Received: from BYAPR05MB5574.namprd05.prod.outlook.com (20.177.126.220) by
 BYAPR05MB4391.namprd05.prod.outlook.com (52.135.205.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Thu, 21 Nov 2019 06:29:10 +0000
Received: from BYAPR05MB5574.namprd05.prod.outlook.com
 ([fe80::cc03:5cd4:21e6:4c92]) by BYAPR05MB5574.namprd05.prod.outlook.com
 ([fe80::cc03:5cd4:21e6:4c92%3]) with mapi id 15.20.2474.015; Thu, 21 Nov 2019
 06:29:09 +0000
Received: from CY4PR05MB3608.namprd05.prod.outlook.com (10.171.244.31) by
 CY4PR05MB3255.namprd05.prod.outlook.com (10.172.160.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Thu, 21 Nov 2019 02:27:17 +0000
Received: from CY4PR05MB3608.namprd05.prod.outlook.com
 ([fe80::641f:22a2:618c:ff7f]) by CY4PR05MB3608.namprd05.prod.outlook.com
 ([fe80::641f:22a2:618c:ff7f%4]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 02:27:17 +0000
From:   Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andrey Shevchenko <ashevchenko@quantenna.com>
Subject: Re: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
Thread-Topic: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
Thread-Index: AQHUZTpbxq0LvcBgsU2PEW0QVFkG+KZyexGAgAf1SwCBGq1lAIACPiqA
Date:   Thu, 21 Nov 2019 02:27:17 +0000
Message-ID: <37ee7285-5856-6a77-3a29-92b86886c48c@quantenna.com>
References: <20181016102349.26544-1-sergey.matyukevich.os@quantenna.com>
 <20181016102349.26544-3-sergey.matyukevich.os@quantenna.com>
 <CAOiHx=nBWr4GNh61WV+SAY-++Z6es-HX3_pd70DB_N33bVK1tw@mail.gmail.com>
 <41b4f41f-37ae-ef5f-476c-eb616d6a3da1@quantenna.com>
 <CAOiHx=myYOAYPm0KwS3wP+sPLaQH9obUv0wbdteCx6REJPKQgw@mail.gmail.com>
In-Reply-To: <CAOiHx=myYOAYPm0KwS3wP+sPLaQH9obUv0wbdteCx6REJPKQgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::35) To CY4PR05MB3608.namprd05.prod.outlook.com
 (2603:10b6:910:50::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.131.200.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97e97198-00c4-4e02-06c5-08d76e2a53dd
x-ms-traffictypediagnostic: CY4PR05MB3255:|BYAPR05MB4391:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR05MB3255FDC5D360E04F3950BBF1B04E0@CY4PR05MB3255.namprd05.prod.outlook.com>
x-moderation-data: 11/21/2019 6:29:03 AM
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39850400004)(396003)(376002)(346002)(189003)(199004)(446003)(66476007)(66556008)(64756008)(14444005)(256004)(66446008)(102836004)(6246003)(25786009)(6116002)(86362001)(6506007)(386003)(66946007)(53546011)(76176011)(54906003)(52116002)(36756003)(6916009)(8676002)(4744005)(99286004)(8936002)(81166006)(2906002)(5660300002)(229853002)(31686004)(11346002)(2616005)(14454004)(6512007)(3846002)(71200400001)(71190400001)(81156014)(478600001)(305945005)(7736002)(31696002)(436003)(186003)(107886003)(26005)(316002)(4326008)(6436002)(6486002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4391;H:BYAPR05MB5574.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ISYCljR/0L6S3quHWzHUeR7GD3FHiaZIW/ISYbx1eUho+0g5OTvdgtF4qqxTWPxsCC/E4icpv0bK/bsZ6TEsbFEgm48ItGhsJ8x3NM+b+OKm71lYWsK1WIoOq3xGOEfMI/ISSnMJJIYO38JGrZfLAX7kzKmV6t8itVb8MubHDpEFwDqEyQA0BRoB3XsFst1rETEEFItbilpntxEsOZ6XSkMWZFGsRGp2uipaCe11CXpD/Mwdxm8mYBxjEMR6WUyv9MBYoHm3k8gXJkzARMZWrXBVXaJNsjnYqQgnehTkh2LRjyVmqMIOrOra8jqimklZOmAwy0PfnXyWC9dF0UR+iSAHYYZu4DV238+g+rGrMiowRVhx8f+3pdtOlj1QhImnqHf6L/owkNKewKn0qlOWoTXIUKsPaQ+eqMckANHWxL9ODszV3WLxB2ZD7cLnfLO
Content-Type: text/plain; charset="utf-8"
Content-ID: <96F6B80AD5FFD14684AAA683C3F8EC75@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e97198-00c4-4e02-06c5-08d76e2a53dd
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYDi+D9I2FtZGFMWv7Yz0lJK6ImCR6uDzRnC+VAo5xrStrFtQamOEC5IUfsuiKWfP4Vy8anjlljnbTBlafJqmUd+XHELnknbzOfH1lVFGaHIZcRZaFI8ZdYmj+FOW3RQIqZZxl+aaJWt7mYQFa9jJ2twOx/yr/DM05XZzB+Xqhmwdz2P0kF8XjrneoPgcWwzwmUGYxHbVjC7z0pJ/KTqjJCeM8kLu/fgYV1ShKw/+00=
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 06:29:09.8245
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4391
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTEvMTkvMTkgODoxMiBBTSwgSm9uYXMgR29yc2tpIHdyb3RlOg0KPiBBbnkgdXBkYXRlIG9u
IHRoaXM/IFRoZSBzdXBwb3J0IG5vdyBoYWQgaXRzIGZpcnN0IGFubml2ZXJzYXJ5LCBhbmQNCj4g
c3RpbGwgbm8gZmlybXdhcmUgYXZhaWxhYmxlIGZvciBpdC4NCj4gDQo+IE1heWJlIHlvdSBjb3Vs
ZCBwdXQgaXQgdXAgaW4gYSAodGVtcG9yYXJ5KSBkb3dubG9hZCBsb2NhdGlvbiBhdA0KPiBRdWFu
dGVubmEgdW50aWwgeW91IGdldCBhcm91bmQgdG8gdGhlIHNlY29uZCBhdHRlbXB0Pw0KDQpIaSBK
b25hcywgUXVhbnRlbm5hIHdhcyByZWNlbnRseSBhY3F1aXJlZCBieSBPTiBTZW1pY29uZHVjdG9y
IGFuZCB0aGlzIA0Kd2FzIHB1dCBvbiBob2xkIGR1cmluZyB0aGUgaW50ZWdyYXRpb24uIEkgaGF2
ZSBnb25lIGJhY2sgdG8gb3VyIGxlZ2FsIC8gDQpJVCBkZXBhcnRtZW50IHRvIHdvcmsgb24gdGhp
cyBhZ2Fpbi4NCg==
