Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02F5A6CF
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 00:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF1WTf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 18:19:35 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:3012 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbfF1WTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 18:19:35 -0400
X-Greylist: delayed 2346 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 18:19:34 EDT
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5SLZkX4014999;
        Fri, 28 Jun 2019 15:40:21 -0600
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by m0059812.ppops.net with ESMTP id 2tdm81gxyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 15:40:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rJ3NDKUsXlsTZfIMwWIsnSHW6rq5Om40cCdzRxBnws=;
 b=z99UsCoJqBGUYgtFy4a7vwHzYjBGn0xULS7z3qpLKFZacMOmLAf0QCSpjowLieDLDjYiknAOFfAldqZa22GOop3HGQtdyaQSPkPNUojBI4ayNH7CCXXgibjJfI8sSa6OhKhO5FYjBDlljkdqRpKEievY6smNzVF7i/I0b4YAg2I=
Received: from BYAPR05MB5909.namprd05.prod.outlook.com (20.178.50.154) by
 BYAPR05MB6200.namprd05.prod.outlook.com (20.178.55.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Fri, 28 Jun 2019 21:40:19 +0000
Received: from BYAPR05MB5909.namprd05.prod.outlook.com
 ([fe80::9855:ac9b:a07b:6452]) by BYAPR05MB5909.namprd05.prod.outlook.com
 ([fe80::9855:ac9b:a07b:6452%6]) with mapi id 15.20.2032.008; Fri, 28 Jun 2019
 21:40:19 +0000
Received: from CY4PR05MB3608.namprd05.prod.outlook.com (10.171.244.165) by
 CY4PR05MB3480.namprd05.prod.outlook.com (10.171.249.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.12; Fri, 28 Jun 2019 21:36:14 +0000
Received: from CY4PR05MB3608.namprd05.prod.outlook.com
 ([fe80::61f7:9dea:160:7dfa]) by CY4PR05MB3608.namprd05.prod.outlook.com
 ([fe80::61f7:9dea:160:7dfa%4]) with mapi id 15.20.2032.012; Fri, 28 Jun 2019
 21:36:14 +0000
From:   Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [RFC V2 7/8] cfg80211: ibss: use 11a mandatory rates for 6GHz
 band operation
Thread-Topic: [RFC V2 7/8] cfg80211: ibss: use 11a mandatory rates for 6GHz
 band operation
Thread-Index: AQHVK0gFMUR+dCs3ZkuYyp/V4wnyQKaxDY2AgACO5QA=
Date:   Fri, 28 Jun 2019 21:36:14 +0000
Message-ID: <118259ce-5d03-4b6e-f009-0a189c3da6a0@quantenna.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
 <1561461027-10793-8-git-send-email-arend.vanspriel@broadcom.com>
 <0e261a8a1200a7e55e94d8260ef8cfbaf03b2bd7.camel@sipsolutions.net>
In-Reply-To: <0e261a8a1200a7e55e94d8260ef8cfbaf03b2bd7.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To CY4PR05MB3608.namprd05.prod.outlook.com
 (2603:10b6:910:51::37)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.131.200.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f884af47-c2a5-4fe0-951c-08d6fc10a536
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR05MB3480;
x-ms-traffictypediagnostic: CY4PR05MB3480:|BYAPR05MB6200:
x-moderation-data: 6/28/2019 9:40:17 PM
x-microsoft-antispam-prvs: <BYAPR05MB6200293E8F521AD1B0BC8762B0FC0@BYAPR05MB6200.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:238;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(31686004)(76176011)(53546011)(66556008)(8936002)(66946007)(6512007)(99286004)(31696002)(4744005)(73956011)(66476007)(66446008)(3846002)(71200400001)(71190400001)(6436002)(110136005)(5660300002)(256004)(64756008)(486006)(102836004)(14454004)(8676002)(25786009)(66066001)(6486002)(2906002)(53936002)(386003)(6506007)(6116002)(305945005)(68736007)(186003)(229853002)(478600001)(6246003)(436003)(86362001)(316002)(2616005)(52116002)(81166006)(81156014)(446003)(11346002)(7736002)(36756003)(4326008)(26005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6200;H:BYAPR05MB5909.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UDrMwDVbxDE/Q1c9Lz9Bi9CTmOU+tte6n/ouHTfTauBA6L/AeBVH+/TrcWdIEwI8YRujVvBZrSoWlJ1DutvRUOkmpSQEPNqferal+yWjx/VQiW4G4igiXY0u2Tid8YujvUZIMQEjhKxUEc/hOsstQeUIbA8dlsLbbCBQRAEcVhmAY55ARmZVwfNnUopGOiUCCU5yCES2cL0LYwWKmT6BWrmbAe9LIRmV6sH0V9Up/2GUJT4vpXnecjPHoBvw2qhYq3j7pL41JlOKM0LPyXaQuhSniYNRIroe/8qjdWtoqZja65LG8WYk4ubQjiMp/Gi80/AEjijXSl337DXf2QBE6yZl1MYX5l/GkEJGny04BwUCJ7j6M95iQ6iJ2jKbRBwJOmJbQX+TBn1qk9OIIGrK7/XLkDpfzonrbZZAKslCKzU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02751D1F966CE348860961A2C8E17C7A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f884af47-c2a5-4fe0-951c-08d6fc10a536
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_25dfc1cf-b320-4423-8943-6be228551bc6@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 21:40:19.6074
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6200
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=824 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280246
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNi8yOC8xOSA2OjA0IEFNLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPj4gVGhlIGRlZmF1bHQg
bWFuZGF0b3J5IHJhdGVzLCBpZS4gd2hlbiBub3Qgc3BlY2lmaWVkIGJ5IHVzZXItc3BhY2UsIGlz
DQo+PiBkZXRlcm1pbmVkIGJ5IHRoZSBiYW5kLiBTZWxlY3QgMTFhIHJhdGVzZXQgZm9yIDZHSHog
YmFuZC4NCj4gSG1tLiBBZ2FpbiwgZGlkbid0IHlvdSBqdXN0IHNheSB0aGF0IDYgR0h6IGRpZG4n
dCBhbGxvdyBsZWdhY3kgcmF0ZXMsDQo+IGFuZCBzbyB0aGVzZSBzaG91bGRuJ3QgYmUgbWFuZGF0
b3J5Pw0KPiANCj4gam9oYW5uZXMNCj4gDQoNCkkgYmVsaWV2ZSA2R0h6IGFsbG93cyBvbmx5IEhF
IGFuZCBub24tSFQgcmF0ZXMgKGZvciBiZWFjb25zIGV0YykuDQo=
