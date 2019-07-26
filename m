Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89597765D7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfGZMc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 08:32:56 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:18634 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbfGZMc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 08:32:56 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QCVCGI005766;
        Fri, 26 Jul 2019 06:31:12 -0600
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2050.outbound.protection.outlook.com [104.47.32.50])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tywkqrf68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 06:31:12 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcNuH+Mp+ZcDuVQ5PzYoqxeOGMEBS8KlP1Hkumd2g33Gdbs/mssiE3RwavMyqZJphxtcvqRDCFF2Uwmmri0XQuOHj+MQONTJowLoIGVSOjvfyJjdKe3fCnibvxE6cHxyzuRJgsso6BmmA9P/uLqMUyavPdlctRazFWWyOCoiZnsL4AFt+HG2qlxGfaqyBbvCQAIkiCGS19W/jYAK5YHXj5IenSPfvd5H/Vtoten1oiM/c+Stm1F3hQEqWWwZZ9opg9dJnT8Th9KGI8gxXpMrHN6tG7TW5IbYAc5xjnrN/Tch4N+K7nC3dLbFPOvt0CxoCVmpmcNjZSMZvKgr9FVy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMOGV2YesA5GrGmVm21qTejannlbjAoY+i0q/TZq8I8=;
 b=BRs5wT+O4PnuAM8k4bHnGTEBkdj6KPer2dGYQ2q5b3eJB6l/Gw8nwQ/oRtUYX3cyOn84rxuBdofujUXczOFMpQYJfWvmSD6QFymObIvlKPWeUQL65X5+U5HMMQHA8mSzQRNUpwkHoqf+nZF2ZTdvlWpEqUi/3lnWy4dnD0CAXv006eZa1pALBwJ2bcrCkHbpaRdLWm2dF6O/A+eA22ldhJ2XMY8YMz5k/+UIqVY8UTNxuLhVCQCb4+mvXgifChWkn8PkavWkh1PhHioGWSlsQXAvLUcO+kMMOTEWgr9krevZaVOf1GXIfjLk/vFHFEHIHYtYK/1tfoiOJbr4OuJwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMOGV2YesA5GrGmVm21qTejannlbjAoY+i0q/TZq8I8=;
 b=B4banJ4P/IRWVZI+2YQ+C4Aa0sT/Xng4n2vSI3gZ3cVemrxWZt7lYgQHOBGup2CCMVd8NHcQkOr8Pzx4LvDq+udDal8bgxYQcQVHQS+XcPeM7g7CRdSFe+DwYuRQuIYY1/R3OjEYdq9Gvms7Ggvhty5JzLSVYAiZNt/RjJuH6go=
Received: from DM6PR05MB4377.namprd05.prod.outlook.com (20.176.74.153) by
 DM6PR05MB7033.namprd05.prod.outlook.com (52.132.248.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Fri, 26 Jul 2019 12:31:11 +0000
Received: from DM6PR05MB4377.namprd05.prod.outlook.com
 ([fe80::8979:613c:e733:6b87]) by DM6PR05MB4377.namprd05.prod.outlook.com
 ([fe80::8979:613c:e733:6b87%3]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 12:31:11 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com (52.135.235.159) by
 BYAPR05MB5317.namprd05.prod.outlook.com (20.177.127.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 12:30:48 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e]) by BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e%5]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 12:30:48 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [RFC PATCH v3 2/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Topic: [RFC PATCH v3 2/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVN0YVdcoRktgdq0CETrSEqiQijqbc5eEAgAAHdIA=
Date:   Fri, 26 Jul 2019 12:30:48 +0000
Message-ID: <20190726123042.sxot4xleaej2a4ev@bars>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
 <20190710173651.15770-3-sergey.matyukevich.os@quantenna.com>
 <92167a1803b9f90d231b080c9edfbf335c4685ed.camel@sipsolutions.net>
In-Reply-To: <92167a1803b9f90d231b080c9edfbf335c4685ed.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To BYAPR05MB4917.namprd05.prod.outlook.com
 (2603:10b6:a03:42::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71e1aeb-35f0-4942-be8a-08d711c5167f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5317;
x-ms-traffictypediagnostic: BYAPR05MB5317:|DM6PR05MB7033:
x-microsoft-antispam-prvs: <BYAPR05MB5317F96FC7F7B0B9E9FD1A06A3C00@BYAPR05MB5317.namprd05.prod.outlook.com>
x-moderation-data: 7/26/2019 12:31:08 PM
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39840400004)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(6506007)(386003)(2906002)(486006)(102836004)(6246003)(107886003)(68736007)(316002)(476003)(11346002)(446003)(14454004)(71200400001)(8936002)(86362001)(6916009)(558084003)(81156014)(5660300002)(81166006)(8676002)(64756008)(66946007)(66556008)(66476007)(6486002)(66446008)(54906003)(33716001)(1076003)(6436002)(229853002)(3846002)(256004)(6512007)(9686003)(305945005)(478600001)(186003)(66066001)(7736002)(4326008)(436003)(53936002)(99286004)(26005)(52116002)(76176011)(25786009)(71190400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB7033;H:DM6PR05MB4377.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eOC0htk/EPddHSvoh//94YhryxStYwY3Eh36bT/IC3LVDAuo49auHFsuHU+4IDLzzNvoZN1goNdztsOJyAvQDwK0cCYPIFxTq1Xwk/kKm7qJQMZ1vr9LQACwHVqEGiicl/hWDeXH0aTAazBrwnNt5Qo8TwaLdUnJicI98QCt7yD6ZfLvRqfTia2jt80TvDuXjP451PbTOR8f8VsGt6oyZybTmOYjxyCmDM8W1Ki3gdiooCv8xXumsD1PUePFQcZ5gkDWzAVNza9vgzpMtrVRTo3+3TwQ2+fEPfWuvsXGzmXwxDhyBYsoEolYlzaSZ5alP2IZpMmbz2ymr7e9yD/dw22Fd2Z0jHLxV7iYFborwXK9RpcRHjTgle8kYKP7Fn+w0FdO1H3g5EjYJdrJ3l4TQMAHrO9WqD7qObNCVqn52ug=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4F1F2EF7E7BE4479BD4FC940CAC7A07@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71e1aeb-35f0-4942-be8a-08d711c5167f
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_c5afe0c1-d08c-4406-841b-8ec63266ce98@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 12:31:11.0942
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB7033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=498 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260155
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Umm, regarding multi-BSSID, I'm clearly just not paying any attention
> ... sorry about that.
>=20
>=20
> This looks good to me, can you resend as just PATCH?

Sure, I will rebase on top of latest mac80211-next and resend.

Regards,
Sergey
