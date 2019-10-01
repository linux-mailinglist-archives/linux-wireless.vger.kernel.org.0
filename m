Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85A9C2F6F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbfJAJBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:01:06 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:1500 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729787AbfJAJBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:01:05 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x918Z44b025541;
        Tue, 1 Oct 2019 02:43:09 -0600
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0b-00183b01.pphosted.com with ESMTP id 2va21v6571-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 02:43:09 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JydDjwMoghFFJXRwFELDrpjYYisyTVuoC24xg51uQI3DpbCXickY6+IqU5n2R7bjUXLyya2juqig6AkhmQLaP91gAvHc6EybwMZe3H6xbodJvIaZ3ni0vvSaSlOf5DRtZZsB2rNyqRfG3m4H12NJzfLgjyrLp0Rk3bXRetNnMeTsptR5tBOgMYDHKq4BodrrRgeEwa93dujvssLHUaza++bz2AOFWHSbpBVNSWk20uHYd7zkjw9oKXDMJuQIqZ2tK5Jlc8nSAH+VU8WgAkjSkcN6n3zxJP6jH10Pvfxz6NqZhh+ihfsikUL0X75kLm0QqWelzhQkWOLP4PJJ+Xo/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qao0zju945rFvnsm7EnMMiILMBD52gX2L5PyOJ97cCM=;
 b=Q0KY1O2SHFh5lOTjZwI3Pce5beSdiPBTF6sneK8Z70e8GJ2mgZYtz5Z8SnHFB3pXhMgGfPtEdEj/8UCLdTKjFeCi0HXb0q3Jtofq6LEr/9Pl+L24+psj1eoj3H/3qqcMSsLP+YUCcbpDTBHA0EvsdDxME+wEMG11CGZ+tJES0iETJ8CkHON6PnYo+9iXhf+v8F6PNHCQ/jrufYeKPlrK37rb+Q9kJcU5nSiiRbaZoXPOBnPAr9lBTm30g1A+rfkab2hCb9bHmfkyMgTF63Emet3t7NGIRlNk62hFqshZVfhSk1bX1947VMt/205KN5i7ESCZeeIZqT69xOR66yWljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qao0zju945rFvnsm7EnMMiILMBD52gX2L5PyOJ97cCM=;
 b=K7YfcLXHuKNyiUGBBHknvRGt4J7k4whfT02k1xBo1i3DqTDNAxPbQsMyccT1S6pSHu0tKZIvUGBUK7z5iBEl5pqZQvHenMyYQtXotgJnKQj6ucvsWT0JSEK0cQxREn24Yb7r+8BrRjZfbfkkK0MThwp6BfPszw4fqhgwC/0Mwo4=
Received: from DM6PR05MB5401.namprd05.prod.outlook.com (20.176.121.13) by
 DM6PR05MB5484.namprd05.prod.outlook.com (20.176.122.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Tue, 1 Oct 2019 08:43:07 +0000
Received: from DM6PR05MB5401.namprd05.prod.outlook.com
 ([fe80::15b0:e893:b566:c917]) by DM6PR05MB5401.namprd05.prod.outlook.com
 ([fe80::15b0:e893:b566:c917%5]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 08:43:07 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4640.namprd05.prod.outlook.com (52.135.114.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Tue, 1 Oct 2019 08:42:36 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::50aa:7669:7bfb:33b4]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::50aa:7669:7bfb:33b4%6]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 08:42:36 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Luca Coelho <luca@coelho.fi>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: ax200ngw firmware crash: where to report
Thread-Topic: ax200ngw firmware crash: where to report
Thread-Index: AQHVeDQsrDoM/xEIeku23VKMgu4moQ==
Date:   Tue, 1 Oct 2019 08:42:36 +0000
Message-ID: <20191001084229.6tzdzxt53qgtehts@bars>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faadde78-2a47-4b3e-c8e1-08d7464b4f0c
x-ms-traffictypediagnostic: SN6PR05MB4640:|DM6PR05MB5484:
x-microsoft-antispam-prvs: <SN6PR05MB46402784C7F9B8CF30DEE84AA39D0@SN6PR05MB4640.namprd05.prod.outlook.com>
x-moderation-data: 10/1/2019 8:43:05 AM
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(396003)(366004)(136003)(39850400004)(346002)(199004)(189003)(6116002)(3846002)(7736002)(4326008)(5660300002)(4744005)(1076003)(66476007)(66556008)(66946007)(64756008)(66446008)(25786009)(476003)(486006)(436003)(478600001)(14454004)(2906002)(8936002)(8676002)(81156014)(81166006)(99286004)(52116002)(6486002)(6436002)(26005)(9686003)(186003)(6512007)(6506007)(386003)(102836004)(305945005)(6916009)(66066001)(71200400001)(71190400001)(86362001)(256004)(316002)(54906003)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB5484;H:DM6PR05MB5401.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVpuGTtGLu3BUfVwbhYhho0m0cB5AP5jVEMMK3f1wbFPsf3evodh+MsV5ST1uz/Q87dCzq7ua+it/aB86hJQ19kssbLF+uOCJlLK2xFX1Nygn23bTrTBupnNyVuOkY58zUhu9KDhub239L/ZcgigjA0XTuqzpYncDbK5kPv2x/Z7npIxbvCcvTLo1NyxNs2Sr1gyA0iKmHIhNkP6A0xyJLmW9Duy/tByC6M6at9gcgPdaap7v0B5x0z1bYvfAlNHPQT7UCjBOho+pqYvProdkjJNdfKpFpeWYrQinxBErNZVOjaQD+/sM27i4MCKyKBPSJvTGf63BfzTIUIyBguzKOuKjwLyHquKFNMFoJ241Y4oJlZ1mhv7laHpM25oWmsQZyqi12caasvOzftYtRklExBUWM8uuGd0bfQk0bcHEo0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79C21FDF95842C43A0EDF95698F9A56A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faadde78-2a47-4b3e-c8e1-08d7464b4f0c
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHPqTQdbx3EXs4ZhkUyr7Ul8aD5CMNZPiecFW1q2zdWv8G5NvOttSiDiwEAJLMwBN9slQfRw8aCvKBuHRCC6QKNYVzT1c62mzWQtukwCiMrOgDoCbBNVZXvxOimqG1yfGxtfx521vtheVyAvItne/6loyO6arPmFhfNoSjlAvdw=
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 08:43:07.8589
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5484
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_04:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes,

We are using AX1650x (200NGW) wireless card as a client for 11ax
testing. Firmware version is 48.4fa0041f.0. Simple iperf UDP UL
test on 100 Mbps works fine, but on 120 Mbps firmware crashes.

I would like to support bug report for this behavior. Looking
to wireless wiki, bug reports should be submitted to Linux
kernel bugzilla, adding linuxwifi@intel.com to recipients.
Is this procedure still up-to-date ?

Regards,
Sergey

