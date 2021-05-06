Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425B5375495
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhEFNVR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 09:21:17 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com ([40.107.4.96]:7687
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231993AbhEFNVQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 09:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q74uDxiOlzeiS/lkoYTZRSMugpnIGEBBExcRXKbxy4L0JNa/8xBgXQ3fbsVGHiN3uRt+gnC9Ha6slIgVhbFWkrwkFO0q3nd/HQg3lA1mp6Ft108rxoHRgSyneyx3t+z9fFg7l0L7Rf56I229hW9ISIpMgyNfMe4nj0j3lCTpMvpt/TlDhzGZ4hz/la3XwihsMOf+4Fm2KfbTOCl2P6kLYJraEfqCQFnvyKLreiaUlksGQ9SyAJ8BigNod1gc7mqASQQFM85IR+d6yQPbOOqlXJzdt8xsni+1zeOSSKb4u9C38+m0D4zYHD07ln9+3FPGZNRHKFwT7LwgaCnp0JUSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWgZkNYYiTe4RQ5OhyzEZiTQFltOOT1xvekU68a5EGA=;
 b=ekdNP5FrCxZhaX785N9myAx8Max4GOrb2P/SttXYkvdGQ/B/9kJ7EZvqO4GMwiSYSsgouX90aLzSWLoVX6moOYv+r6OQFwHhvNMXouV0Phhyt8r5igSGZzC7S0CNcGy5FefF6rWxZ4AynVdll/VJP6QawXZCKsx9dhsbzYF5qA5RkdKNAu4Fim4OwdcA4OTFe7WVuACb+KprwME88KAOnxpjNfxfYg/QCefbOB2fTqslw1W8nAbpwCJ4fwaGtr+XdHdX8Wn9i/eV6x/KyjUQ+b8SjdHbdSJWtbxQ1Fac4cUuQlf9njC7tG1DIkB+8oxMQwBq7pDqy6duzt7N6uFjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWgZkNYYiTe4RQ5OhyzEZiTQFltOOT1xvekU68a5EGA=;
 b=sxEsrLxoJ91n3iTASy3QUBvCHOLP58aZ0ho7gEcXbFgFVElip62vENvKXmDoAKRYOWzByUOCAW0Am2hBkvrkMecxvk7iG5kNESATxQvpknuGohzQJqPb5gYdcJJHtui+h6eAK+LRl8e2L8j05C2Drx+QMkV40ELcwVPwpmh8k/o=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR03MB5135.eurprd03.prod.outlook.com (2603:10a6:803:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 13:20:12 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e%4]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 13:20:12 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 1/2] brcmfmac: fix setting of station info chains bitmask
Thread-Topic: [PATCH 1/2] brcmfmac: fix setting of station info chains bitmask
Thread-Index: AQHXQnqLrkcIm6m/cUuFlqnvRe20bg==
Date:   Thu, 6 May 2021 13:20:12 +0000
Message-ID: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bang-olufsen.dk;
x-originating-ip: [193.89.194.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f1a74b5-3901-4856-7585-08d91091ae28
x-ms-traffictypediagnostic: VI1PR03MB5135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR03MB51350C06C3208370205446F183589@VI1PR03MB5135.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uPNSm+SmH40wG3mh5rEhHS537oXfRF8M980K6CiiIpVugS0aYWmR4JWkVEraLEjkN0wl1C8L18BKHmZBrYdpoK1zyC2h8eLva6Rr2o0nGmpLcwi9IscizQTbbp4h7GGTswUpdD1drJYv+dJbTS02gqTRgQ9A7iZB1JoN9Wkiud7rFEMBegtj5ZbyKSMLtU5XnTkumCNJlxpJdRK378TOzYcc1itSIuw+UItqZhWXuLXoTgBkfQry1sGBky7UbPXLozxPGwI723VVpWuMCGFqVgeh3kPwWoKcOLZ830AivyIYSDGEayebczJBsk3Y0jyUl+C9UQcVEyCEL8eyeIP5YWPvLSO0awGmW3fv7YVmHt/cQ08KXPhxF9gDkaKi1rUuwYty7H/TunW1pIFoBXg+RjYQ6hybuptBdrJ+XmCHG1clONDafUWAoaUnwwEvwK24GVmXd2IDjsy4BhRtM4hEFLzP2rjLLaRwRY31rIksGCnl8Mhvf6Eynan/rTN34/g6jrzOhpYSBYxA1PK0ZJM93ODO4hvmuPDSWD7NHq1zXMEbbhilzkqeqmMIZXYs5SKPWVLOZnkajW8I5rDh//hSaLybxVh6b6I+DDqDs43yBjE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(376002)(346002)(396003)(110136005)(4326008)(107886003)(186003)(1076003)(66476007)(6506007)(85202003)(2906002)(478600001)(64756008)(54906003)(83380400001)(76116006)(316002)(66946007)(66556008)(66446008)(36756003)(6486002)(5660300002)(71200400001)(122000001)(2616005)(8936002)(86362001)(6512007)(8676002)(8976002)(85182001)(38100700002)(7416002)(91956017)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MDhEbVQxdlMzeW9OQXQvYjVjdlp4dkIwUnhMeEc2SXB3ZGx0UXJZUGxOTGUv?=
 =?utf-8?B?azJrWllzcUVJcktoWUY3aHBXTDRYNzRXZTFMc2duQTJaYnlhYWhQSXVmRzBq?=
 =?utf-8?B?M3J1bHovMVhFZXd4SUdYQmw5NmxpVDRhTzVsdzhYdDdvV3JELzBHYlB5QzFZ?=
 =?utf-8?B?NU10TXlhaXExNDB0eS9IMDJ3UklLYlhsVjdGRFh6MTVKcEdOY1d5QzZwUXV4?=
 =?utf-8?B?Q21QWEI1MlNzNi9vVVB6MnlsMnIxcTlnTXExQjJaZnNON0l3TUlLQjNTSUlw?=
 =?utf-8?B?UkIxV1RxTTlpNUFlM0RiVXVLK2pJb3hiM2tjRWlGRGZJamcrUFFvTXFpcnlJ?=
 =?utf-8?B?d0NFRlBjb0dMWXJHSDZRL1lKK3ZqRWdmdFAvdXBITzNPeU0yMUMxOW5iazQy?=
 =?utf-8?B?b2NsOVFaYytidDRUUjMxVHdPT29rY0xDUExnTDJDTEJsREh0TnNrdjlWSHFG?=
 =?utf-8?B?YlR2ZGM2NXlSTGpCZzhvcCtuMDhEeVZxZmNwdnp4QWFvbDU1OG1pMnMwSzRJ?=
 =?utf-8?B?dC93Um9LRzV3cnYxVTBrbnMrbGp1a09pSWU2RStWYXJqVnNnNGJXV0VQa0pa?=
 =?utf-8?B?elVDVE5vRy9ZMkFkNEdGMGdnSGxKMmVidmgyaWJacy8ybDR1M3hpVndJNDRl?=
 =?utf-8?B?cUZWZDhja3Z5djFUOUpycXdyM3lOeldnYURFSUJ1RVcxWER6dUtMMDNrOFZi?=
 =?utf-8?B?aTlXb3pNc0lSdG1xZlhCTHRNYUhSV3l1REpHbFlXL0pmODBiZnJPZFhNTEhV?=
 =?utf-8?B?V3hMZ2ExR0JQc2kwMHc2UFNqdDlHa05taWNyRitqbXMwQmRRRFRldG5EZWJC?=
 =?utf-8?B?dkp2WFJXZXE2M3RHdW5UM3d0TEtLSitRYk9hUTV6YkU4T2ZiKzVEamFodVJa?=
 =?utf-8?B?THFabzJud2lsZlE3aDJadDRra2h4djdBNFBTMkRyMzBVUTVXYVcrSWdaSFFy?=
 =?utf-8?B?Z1V6cnUvL0oxRmltUENGdHZtZVlJeXVoRmVQY3pYeWl6YVJmekdXdG0zdjUx?=
 =?utf-8?B?WHcyWTdmbjY4VWJ3N1dKTlRlVDNndWlvWnQ0ejVoSWxmQlU1Q0NJdWRoNDdC?=
 =?utf-8?B?MHRVZVhpdkRnTzNlL0lBNmx2cWtkN01iWUMzaUFwTjh3SDdlOXRHUDlWbnhC?=
 =?utf-8?B?dDdabHhBcXJIL29qUVg2Y0tqaWpoZ2crZW14eDBxRzk5dzNXZjI0QTFCQzkr?=
 =?utf-8?B?aCtQL0t5Vm5nWDBsTkdGeE0rMStZMXVJMm56OHU2L25STnd1cGJtc25iTXJZ?=
 =?utf-8?B?L0tlUlA0cFk1K3dsWmhqMWdBK2QwUXVpSGViMGtKZDYvS0dzVkhhdzljZUFY?=
 =?utf-8?B?N1lEazJ2ajNWdFk3L3NIbjVhMERBRm5zclhFNFZlS2FKbVpUMVB6czFMc2w3?=
 =?utf-8?B?K1BNU2N2TEk5aVJGZlFsRlZJM3JkZHhpR2huZEorWFRGbUJVL0ZEVlNDT0dN?=
 =?utf-8?B?SEZXNXpoUnp3M2YvWXhsMGVjOUk0OHdjRmlEMmR5b2FzbmdEWHgxQTVVRG1u?=
 =?utf-8?B?TjFDSi9TZ2x6OUJDVW96MU1FaW9kMDloWjd6WmZuQktlQkJ4cmFQRy8xcmFW?=
 =?utf-8?B?R3ZZWHgzYkhkbUtJYzlHQklXRHRHYkZORzlBSThPMzJiOWt6UERBNkFIbkc2?=
 =?utf-8?B?YVpid1Z5NzB3ZjNzajBHeFBnRGI4Qjc0alhyT0UvaHNhQ1M4ejJBY0pab0Z6?=
 =?utf-8?B?SDVmTGxHdHNwTEpUK0RGM0g3cDM2WGsraWVmY01KMERlZk9VUVByMnRja09H?=
 =?utf-8?Q?UKZ1+inwIm8Xstt+SlqZDqEtnOpuMfTYSV+hxTN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C510F9715584341B640A205305C7BC2@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1a74b5-3901-4856-7585-08d91091ae28
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 13:20:12.6246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELxSER4DAhk64H+OJlFwRhcNydhCIJKSUhobWKdmt2sMAPuWYCSkgHAucJqLS56BYof4GkLqMgAjQlHnol21/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB5135
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIHNpbmZvLT5jaGFpbnMgZmllbGQgaXMgYSBiaXRtYXNrIGZvciBmaWxsZWQgdmFsdWVzIGlu
IGNoYWluX3NpZ25hbA0KYW5kIGNoYWluX3NpZ25hbF9hdmcsIG5vdCBhIGNvdW50LiBUcmVhdCBp
dCBhcyBzdWNoIHNvIHRoYXQgdGhlIGRyaXZlcg0KY2FuIHByb3Blcmx5IHJlcG9ydCBwZXItY2hh
aW4gUlNTSSBpbmZvcm1hdGlvbi4NCg0KQmVmb3JlIChNSU1PIG1vZGUpOg0KDQogICQgaXcgZGV2
IHdsYW4wIHN0YXRpb24gZHVtcA0KICAgICAgLi4uDQogICAgICBzaWduYWw6IC01MSBbLTUxXSBk
Qm0NCg0KQWZ0ZXIgKE1JTU8gbW9kZSk6DQoNCiAgJCBpdyBkZXYgd2xhbjAgc3RhdGlvbiBkdW1w
DQogICAgICAuLi4NCiAgICAgIHNpZ25hbDogLTUzIFstNTMsIC01NF0gZEJtDQoNClNpZ25lZC1v
ZmYtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4NCkZpeGVzOiBjYWUz
NTVkYzkwZGIgKCJicmNtZm1hYzogQWRkIFJTU0kgaW5mb3JtYXRpb24gdG8gZ2V0X3N0YXRpb24u
IikNCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1h
Yy9jZmc4MDIxMS5jIHwgMyArLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNv
bS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jy
b2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jDQppbmRleCBmNDQwNWQ3ODYxYjYu
LmFmYTc1Y2I4MzIyMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29t
L2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYw0KQEAgLTI4MzgsNiArMjgz
OCw3IEBAIGJyY21mX2NmZzgwMjExX2dldF9zdGF0aW9uKHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0
cnVjdCBuZXRfZGV2aWNlICpuZGV2LA0KIAkJY291bnRfcnNzaSA9IDA7DQogCQlmb3IgKGkgPSAw
OyBpIDwgQlJDTUZfQU5UX01BWDsgaSsrKSB7DQogCQkJaWYgKHN0YV9pbmZvX2xlLnJzc2lbaV0p
IHsNCisJCQkJc2luZm8tPmNoYWlucyB8PSBCSVQoY291bnRfcnNzaSk7DQogCQkJCXNpbmZvLT5j
aGFpbl9zaWduYWxfYXZnW2NvdW50X3Jzc2ldID0NCiAJCQkJCXN0YV9pbmZvX2xlLnJzc2lbaV07
DQogCQkJCXNpbmZvLT5jaGFpbl9zaWduYWxbY291bnRfcnNzaV0gPQ0KQEAgLTI4NDgsOCArMjg0
OSw2IEBAIGJyY21mX2NmZzgwMjExX2dldF9zdGF0aW9uKHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0
cnVjdCBuZXRfZGV2aWNlICpuZGV2LA0KIAkJfQ0KIAkJaWYgKGNvdW50X3Jzc2kpIHsNCiAJCQlz
aW5mby0+ZmlsbGVkIHw9IEJJVF9VTEwoTkw4MDIxMV9TVEFfSU5GT19DSEFJTl9TSUdOQUwpOw0K
LQkJCXNpbmZvLT5jaGFpbnMgPSBjb3VudF9yc3NpOw0KLQ0KIAkJCXNpbmZvLT5maWxsZWQgfD0g
QklUX1VMTChOTDgwMjExX1NUQV9JTkZPX1NJR05BTCk7DQogCQkJdG90YWxfcnNzaSAvPSBjb3Vu
dF9yc3NpOw0KIAkJCXNpbmZvLT5zaWduYWwgPSB0b3RhbF9yc3NpOw0KLS0gDQoyLjMxLjENCg==
