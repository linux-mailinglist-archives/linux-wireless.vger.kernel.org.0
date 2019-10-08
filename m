Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB91CF3EC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 09:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfJHHeM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 03:34:12 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:29772 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730144AbfJHHeM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 03:34:12 -0400
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x987UoSv011764
        for <linux-wireless@vger.kernel.org>; Tue, 8 Oct 2019 01:34:10 -0600
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00183b01.pphosted.com with ESMTP id 2ver3a7myu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 01:34:10 -0600
Received: from m0048103.ppops.net (m0048103.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id x987V50i011847
        for <linux-wireless@vger.kernel.org>; Tue, 8 Oct 2019 01:34:10 -0600
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0b-00183b01.pphosted.com with ESMTP id 2ver3a7myt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 01:34:10 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niIQ7Ue06YBw/YPBRlFwaMiP1i7afRQrLrlLXLZevnMTIIY7+7kLkZZvw1nCHoF7TEyTcuJtIFBFfXgrQkT3SLTwaR0IxYoAEFZ1jJmQPbjGhBiH05Hroy1jdBWpfNHOSvYUGDsvhkNgI9gMSOHDzkNz3woUeyME25vq+K5UbfI8mZUz2uYgQ8/B4JzkUqUTFJt9Kc7GK9cr1Vih3DPpV5VQ64i5E34kV5VsyqRSwc7EpFs1aD7v9feYGlcqLf3OyUAOmeWYh7vd+V2kMTPGf486U3y8XmEnnHzKZDnJ565lEofJqFkjrWWjbaZEUQYT+UHS8xHuB9fHOKGRMr1NjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjeGwQXT2JrolYuwW5ZO9FOV2ph0S+v/fRvqcVCBL48=;
 b=DYSvYwZl2wCXdVNDmsz/AyTBKvlz5qFVwBUElZhi/7i3utjmujBoPK5mz4AeuNiB2L9r60SW8Vq03osIlPc7ftC3GIgN3QOWoSUB6gx94d9NVE3GqQMC7eUNddQlFVElYufuf1OG8oKZSFKmmsMIzBjF5AXoeCiV0Mfsulxd2aQqHfxFdpynmo7sa7lO/go/ssxkjcDSJ3hx43I17tLFUQVIXY2ALCsEY0wELdMQ1iqfpEqdKVxqYEjmMPthm887V/z7Q7k+CCDH7dSkq6SXBK5ux8l8wvSHuhDKmlgkQi5pfz1P92lg1vB1wNuqGq32MpW9vo3QxFNkSJZDeJtYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjeGwQXT2JrolYuwW5ZO9FOV2ph0S+v/fRvqcVCBL48=;
 b=mOHVdIFJuXLoH050qAv2749ElnxDdxcJajR0ytJNt4U+mpUKf0nc8TNdGVj9LeU0BAV6gcJ/3muzCTbrBtUM5hk6wyhJ2ICnPaytQw/h/R0fcHAgu9kDWYPFAPXPv3yOuCtNA2oR/WDZIELhBAiFTbEeAsERBSbJXMEIdhVKPDM=
Received: from BYAPR05MB6102.namprd05.prod.outlook.com (20.178.54.155) by
 BYAPR05MB5863.namprd05.prod.outlook.com (20.178.48.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.15; Tue, 8 Oct 2019 07:34:06 +0000
Received: from BYAPR05MB6102.namprd05.prod.outlook.com
 ([fe80::dd95:ae7:ec8c:7215]) by BYAPR05MB6102.namprd05.prod.outlook.com
 ([fe80::dd95:ae7:ec8c:7215%7]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 07:34:06 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5421.namprd05.prod.outlook.com (52.135.109.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 07:33:43 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::5e2:2496:7e6c:9ffe]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::5e2:2496:7e6c:9ffe%7]) with mapi id 15.20.2347.014; Tue, 8 Oct 2019
 07:33:43 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Ben Greear <greearb@candelatech.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: AX200 crash on udp upload, cannot restart
Thread-Topic: AX200 crash on udp upload, cannot restart
Thread-Index: AQHVeWK7lfLyaQmgIE6Wn0ukW5sSyqdQYpkA
Date:   Tue, 8 Oct 2019 07:33:43 +0000
Message-ID: <20191008073330.7nuwzwpwgzgjfswm@bars>
References: <08f29d02-2fcf-e779-6fc0-ea7a9d4e59b6@candelatech.com>
In-Reply-To: <08f29d02-2fcf-e779-6fc0-ea7a9d4e59b6@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e04afb91-d89b-4f85-2a4f-08d74bc1d885
x-ms-traffictypediagnostic: SN6PR05MB5421:|BYAPR05MB5863:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR05MB54213BF9EFEEE1B9DCFA27E6A39A0@SN6PR05MB5421.namprd05.prod.outlook.com>
x-moderation-data: 10/8/2019 7:34:03 AM
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39850400004)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(14454004)(102836004)(6486002)(9686003)(6512007)(186003)(26005)(76176011)(99286004)(5660300002)(6306002)(6436002)(386003)(229853002)(6116002)(1076003)(2906002)(4744005)(3846002)(86362001)(52116002)(6506007)(33716001)(436003)(8676002)(81156014)(81166006)(66066001)(4326008)(476003)(25786009)(8936002)(71200400001)(486006)(11346002)(71190400001)(316002)(446003)(6916009)(6246003)(256004)(966005)(66476007)(66556008)(64756008)(66946007)(305945005)(7736002)(66446008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5863;H:BYAPR05MB6102.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8lO11aqgb6CfiNT+AWmdZHrClOpydJ9EnSl5blAT2V6kkFFVYzZM3JU6VomoJaeF6I2uM3Dx9mt4fZzHKQo7lq/LBNakOe4N6Xzr8ocHUF+jm2hJPQI2oYDdEUTGMQh7jV6Z9NDFYwXX7JTRq6UeaAkrcg1/53pXF2Fmn3WW3KdYK/c+SqDI6XzZbmUzGmwMIEaNQCsSIZF9w6q/Q0tJ0pd1k0KdNVMxII+u8sM6tC/o2mO6pO1AWwOl5iW9RRxI8T/jCX4ACMoWlzPMCiaD1I881pUOimfZLoDWF3G/+Ld/Xyx7jJLRUQ0OIpr2/83+nAHS4cXYjOyGiKWs9xkcPp8JqAEAF/dPFPkdSJSIzCLtW9yX/NSErZelNqH/aHCItTw3Ovu6dlVJ7s28WTnHx3WYUVosMudI1/iWlt5y/Eiso7I0cWnSLUmtExOicMG9ZsKq8w+L8JsFGBUDc9ruA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <244CE1D79BAE3F48A081BB8FBF292285@namprd05.prod.outlook.com>
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04afb91-d89b-4f85-2a4f-08d74bc1d885
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1rDB5jmiEyCC1IDjsuxzOXedK4id+6HBZ34ra4yKzk6Yi9OtIzdr8c8qgVg1WLzXu2oVMQe+fpys1ZFf8v+8iHlScy0M6nH1M4mJmf88NLfj2i0ocBGiV507D4+cX7/KIjywtd8Oow6wn4uwEnrVHsNJwCiQxczfdP0vpRA7qs=
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 07:34:06.7411
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5863
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxscore=0 bulkscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=642 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=2 engine=8.12.0-1908290000
 definitions=main-1910080076
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> We have a system with several of the AX200 NICs in it, kernel is 5.2.14+.=
  We ran a udp upload=0A> test of 10Mbps across all radios, and after about=
 10 minutes one of the radios crashed and could=0A> not be restarted.  The =
others continued to run so far.=0A>=20=0A> I will open a bug in the kernel =
bug tracker.=0A=0AHello Ben,=0A=0AWe observed similar issues in our tests a=
s well. All the details=0Ahave been described in kernel bugzilla issue:=0Ah=
ttps://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.kernel.org_s=
how-5Fbug.cgi-3Fid-3D205061&d=3DDwIFAg&c=3DMHZppzMdXMt3JYjCV71UsQ&r=3DRFH8d=
grFzz0_hnNXpEl_u3TZqD-B6kYLzfvbDuCKw3U&m=3Dopeh64GEVevn0071vriL-kH2B_orc25y=
acBPa3YdgLI&s=3DCKuyBZ0VdAQocDiZGOIDyDC6GG9w4E7OikmGvzblazU&e=3D=20=0A=0ARe=
gards,=0ASergey=0A=
