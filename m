Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7E375497
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEFNVT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 09:21:19 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com ([40.107.4.96]:7687
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233373AbhEFNVR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 09:21:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVPzJMeLeLymkgik4F/vp1Ij1IWlNMUiP2jvS4q6g6A+qk68hhWuVlhFDecXyt5gaNaUwb6n4ACDZeX68eznk6D3m+G99OiI+J6yE73po3ZL1HAZQXqQU4wJLgnnSf6YbeYLmKeK1Tbloe5FcR9yJ+Hq35u9UrblUccScCue0qIngkkYy/lYyW1jA17VyB6LdnD71rQ1XIJMnOXW6FWk6Wntm3kbQUHbF9Sr1UUPQvxb14cLOe0EJvU042FffPObCl09g6p9Ko1jEmdqvHKqrKeKWSALbrryTP5wSmcFiFsjBF8T94kcHCnPf5niisVn3jMW1XLmyULoxk2m9r5TjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lewEenWLO8Zmn2QapUJK4lFm1McL1vhuhuStddHt1w=;
 b=UhIlkGGQVaKn+vAIyqGhNZah1qoy2S67sRDxYYAEF1LSnaqseMvUdFbyHZQUe0nOSZ+aD4MJdhMcLfHMKg9AnZzOMqgT7L89o2hUczeyvpAfLcE9NeBOu2JmCUAw11arY/GiCto5DBjbTnUB9sqXp4SC2oqw8lWfn8/5Lk4FM4YTo2+JnSCz981wrxe8cD1LEx0j0PNcs0GogXviYLEidvE+4LBKMPuuLWHKGCk158N0fkJSzL36KpAe2iqvzTdoCsZvWYIQrO0g4v5h+ZeekRMxMwBGpjNyJW8LIyl6vIauO0L2uepjMCnNwYQAHqIUdFSYwXDHejILLEsJkWEDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lewEenWLO8Zmn2QapUJK4lFm1McL1vhuhuStddHt1w=;
 b=i/kQ6ZzOXWUsA96QfVJp1zHRcOvT4y7RMDnKX4ROyhLGDlxBNR1iSsfniDh1zTMLm6XX+Iv/MmLNL9EON5LR0Kh3ksO7X4HGfmF+OpHm9p1hZyUDZGmrPjSBD2elR7hKJ9zWkCvnNZyG2fJxJmy+lE6D0Nlry1BvnWup/K9Y8xk=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR03MB5135.eurprd03.prod.outlook.com (2603:10a6:803:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 13:20:15 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::ddd3:cf29:124a:ef1e%4]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 13:20:15 +0000
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
Subject: [PATCH 2/2] brcmfmac: correctly report average RSSI in station info
Thread-Topic: [PATCH 2/2] brcmfmac: correctly report average RSSI in station
 info
Thread-Index: AQHXQnqLOmBXf+QmGkezfIsJga6FZw==
Date:   Thu, 6 May 2021 13:20:12 +0000
Message-ID: <20210506132010.3964484-2-alsi@bang-olufsen.dk>
References: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
In-Reply-To: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bang-olufsen.dk;
x-originating-ip: [193.89.194.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d193f3ee-3fe4-4f59-c717-08d91091b00e
x-ms-traffictypediagnostic: VI1PR03MB5135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR03MB5135284C0A28A2CDD14B0BF783589@VI1PR03MB5135.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/vEfCUUSsEmPS6tiY3sZeXueZlhRPHgzxv+ccrFYa7U2LBi0d9EXf6p2zxPBvPe8htbHXyzbtA3XbVmtcSf0kjamur0AVa+2V+l+WSG1gvEkBpPar68qCU6bzC09Sc3gTjRGhOX/0A1bSr1vXli1DBz9bGZ+8l9Wnu+71NLVlGzGv2cYAXitvxHCPvrOaZtRdt5MAcAlLba5WfDptBOS6Uk/VvM3VzPHGiEfqUfaKZuRFron6KNsNCCzdd4yoelf/5Tbl93pPKq1mBsfFtqBJuTQQPxTsUe3tVvofoomkh4y75lxbJmbC2cnxXBiiogEREnhLufDFYO2GCt5pgCNX+Z5iZRxJ6jQwvgb364Hs6vKPFsqRhfbdIIXTr2/VvT0fPhv++5vXXvvQNaNBAzvzbMcOgtwY3iuaukwt9BXRXKPxLP7KE1uMg+6jgJuOPm6rePCm1ZTCQbMl8lyDtC920ttLWeAcCIKa2Eex1/I5rELihVRYZ50E+oZBjuS2nS6yc2/jzNTQI/Afq4Tg7x0EFzpzFXffyQ/o6I68Ek9GVP68ajaa1sL1jNnYW60lvyMuaTfUYhzcqnHW8rNYlPNcI/8xeY8YxUo5JSEO7E60g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(376002)(346002)(396003)(110136005)(4326008)(107886003)(186003)(1076003)(66476007)(6506007)(85202003)(2906002)(478600001)(64756008)(54906003)(83380400001)(76116006)(316002)(6666004)(66946007)(66556008)(66446008)(36756003)(6486002)(5660300002)(71200400001)(122000001)(2616005)(8936002)(86362001)(6512007)(8676002)(8976002)(85182001)(38100700002)(7416002)(91956017)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eEdYZDllSDV3SmZpaW9yNHhGOTB6bDFiQjl2cTBFRndrUmJhbTdWbEtMcGl2?=
 =?utf-8?B?T1JYK1pvZzRuOGpINWZETlB4d0dTMGJpMDZsUTNYMVQxWHJaREs0NDN6aEEv?=
 =?utf-8?B?Wmo5ZDFxcC9RYmFyNzdoa1BnVkZEZUl0eWVtZmhKN0pXM1Y4d0VkSXFqZVdy?=
 =?utf-8?B?Z21CV2tYdTFzU29uMVNxY0hYdFJaN1BIL1RQM1A0Y04rcWxMTEROck9FUDRW?=
 =?utf-8?B?clNOWTFYYm9JVy9NV08yZjltb3RqNWZ0K0JVOWpyT2JLc29XRWV2TlErWFlS?=
 =?utf-8?B?MVMxci9pVzE1SHp6YllsK1YxZm9ZUDlHdWhzTE9RdVkzTDdZdnB4QTNOTm9p?=
 =?utf-8?B?UlZrcUVpU3lrUURKMFZoNytsMHA3UGtaQUZEQTJWMXNxL3dtWTA0QUZMejNj?=
 =?utf-8?B?cGJFZ3ZYRi9URi9xeXVGbGF4ZDBTb2EzOVZ4eG9WaExCbWNwelo4Z284YmE2?=
 =?utf-8?B?aFRXRWlRdXNWUS9iTEs5MktEaFFzdzFUMC9GRXpFOVV2MkwvRzRRQTBFdXJ4?=
 =?utf-8?B?MVEySEdkcHVzTmFYcTBWd0E1aHh3Rlp6dnlwTFo5eFBlRUtEMkVJRWlTNndL?=
 =?utf-8?B?T0dhOE0zL2oybmczeGhXeUtNd2pMNk1JeGl0Q2NYdHlyam4vKzRXWVo3QUV5?=
 =?utf-8?B?MVdySnczV2h3NzBlMzdkS21yVFBBRUFlc0Q2Q0tadmxOc09JMjNEdDQ3bkpE?=
 =?utf-8?B?Q0p6RFJuc2lyQVkzRFRTaFp6V2IvbWh5RU1xaDFtZWpCOE5vQnNjM3c2bG9x?=
 =?utf-8?B?SEJpRGZ1MlQ3MnZKR3VTZjUvWUtiMGVxV0t0dmhPT1QvQUY0U09VTXdFNWlK?=
 =?utf-8?B?azViQjhSY290cXdCQWl0Z05QS0QzdVF6RnpxTnA1WkFnc21ObHBtVGd5Tk9M?=
 =?utf-8?B?b3BXV1N6UE56ZDlGbUZ6Z1BNKzBmZkpBamFBQjRpR0k2dHJqWmorNFJFMFNz?=
 =?utf-8?B?RkFFdFlmUW5rMW5FWU5XZ0htdzUvVkZTQnpyZ1VxWXBlbEw2OVQ4Zlh3ckd0?=
 =?utf-8?B?R2YvT3kwKzRSLzVUaDhkaWdkT1Z5dlZyWDErdUNPK2JtQUo1SFFOd21zUjRk?=
 =?utf-8?B?akRzaW5GN1RiZUp5Zm1tNEhpNDNycjVZUFAyb3ZMalRhTlVxM2VVZTE4QzJ5?=
 =?utf-8?B?SytOYnBxdnV6aUFraktmckNpTUJ5TG41YmVGL3o4K1E0N2Q0M3Y5M05QdXFJ?=
 =?utf-8?B?WlFiWWJaMlBQOGF3UTI0dzNzOVhLNGVydFlJUWk1elk0djltM2lGTEJ6b243?=
 =?utf-8?B?clk1bTFkQkgyQjhXN0E2ellJSFQrUjllUzA4bkFJd1VFa1ZrWXlXOVMvUm9M?=
 =?utf-8?B?aHJJMlVVL0ZGTXVzOHEyZmY3MWM3ZEhkZHY2eFQ5czRZRk15RDZIUWZrRTNz?=
 =?utf-8?B?WTlsdGdzTmZKbStMU0VnZHg0SVhrN2QwVnl2T3JnK3RxclFBa2QvVFZvUU5U?=
 =?utf-8?B?N2dHNnd3V2w3R21IU0h5NGhJeE56SlBOYzFtbnR3WWdqbzNsV0tRKzV3K2lp?=
 =?utf-8?B?ZklNSmpEV0VObmx3TURKNzh4STNINTBwc3YzdEpRZFlGeUtyZkxaWEtqd3Uw?=
 =?utf-8?B?SHFwdUlRdEI0ditWMUpHNXFob1JMbit1Myt0d1c4bmZxTlNRazdGTW1GVEpF?=
 =?utf-8?B?NFp0SUZaaTdXNVNZL3JtNE9XaVk2bENRcGJzVzRHSUREdU9uMVFvUVJSNkRX?=
 =?utf-8?B?VVl3Ri96TU4rYitjYVNZN1pydVZ5bHRxaVhLSDY2SUZiTUI0M0wzTVlPaUs1?=
 =?utf-8?Q?huBhrQk9GbdK2d/Zke3a/vw5nk7zhNhqzSzy20B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F64A0F5C3DCEFA47A2C81D2D45336144@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d193f3ee-3fe4-4f59-c717-08d91091b00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 13:20:13.0033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kHpkuqDMnCnkJs4b/iJBuk8J2ObMNNUDzyGHGsUZkwrWdUhKf7hmVeO1TTBdr5kZcAD8vwUAPyg+/rCWuPKZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB5135
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIHJ4X2xhc3Rwa3RfcnNzaSBmaWVsZCBwcm92aWRlZCBieSB0aGUgZmlybXdhcmUgaXMgc3Vp
dGFibGUgZm9yDQpOTDgwMjExX1NUQV9JTkZPX3tTSUdOQUwsQ0hBSU5fU0lHTkFMfSwgd2hpbGUg
dGhlIHJzc2kgZmllbGQgaXMgYW4NCmF2ZXJhZ2UuIEZpeCB1cCB0aGUgYXNzaWdubWVudHMgYW5k
IHNldCB0aGUgY29ycmVjdCBTVEFfSU5GTyBiaXRzLiBUaGlzDQpsZXRzIHVzZXJzcGFjZSBrbm93
IHRoYXQgdGhlIGF2ZXJhZ2UgUlNTSSBpcyBwYXJ0IG9mIHRoZSBzdGF0aW9uIGluZm8uDQoNClNp
Z25lZC1vZmYtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4NCkZpeGVz
OiBjYWUzNTVkYzkwZGIgKCJicmNtZm1hYzogQWRkIFJTU0kgaW5mb3JtYXRpb24gdG8gZ2V0X3N0
YXRpb24uIikNCi0tLQ0KIC4uLi9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEu
YyAgICB8IDM2ICsrKysrKysrKystLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jDQppbmRleCBh
ZmE3NWNiODMyMjEuLmQ4ODIyYTAxZDI3NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jDQorKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYw0KQEAg
LTI3NjcsOCArMjc2Nyw5IEBAIGJyY21mX2NmZzgwMjExX2dldF9zdGF0aW9uKHN0cnVjdCB3aXBo
eSAqd2lwaHksIHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LA0KIAlzdHJ1Y3QgYnJjbWZfc3RhX2lu
Zm9fbGUgc3RhX2luZm9fbGU7DQogCXUzMiBzdGFfZmxhZ3M7DQogCXUzMiBpc190ZGxzX3BlZXI7
DQotCXMzMiB0b3RhbF9yc3NpOw0KLQlzMzIgY291bnRfcnNzaTsNCisJczMyIHRvdGFsX3Jzc2lf
YXZnID0gMDsNCisJczMyIHRvdGFsX3Jzc2kgPSAwOw0KKwlzMzIgY291bnRfcnNzaSA9IDA7DQog
CWludCByc3NpOw0KIAl1MzIgaTsNCiANCkBAIC0yODM0LDI0ICsyODM1LDI3IEBAIGJyY21mX2Nm
ZzgwMjExX2dldF9zdGF0aW9uKHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0cnVjdCBuZXRfZGV2aWNl
ICpuZGV2LA0KIAkJCXNpbmZvLT5maWxsZWQgfD0gQklUX1VMTChOTDgwMjExX1NUQV9JTkZPX1JY
X0JZVEVTKTsNCiAJCQlzaW5mby0+cnhfYnl0ZXMgPSBsZTY0X3RvX2NwdShzdGFfaW5mb19sZS5y
eF90b3RfYnl0ZXMpOw0KIAkJfQ0KLQkJdG90YWxfcnNzaSA9IDA7DQotCQljb3VudF9yc3NpID0g
MDsNCiAJCWZvciAoaSA9IDA7IGkgPCBCUkNNRl9BTlRfTUFYOyBpKyspIHsNCi0JCQlpZiAoc3Rh
X2luZm9fbGUucnNzaVtpXSkgew0KLQkJCQlzaW5mby0+Y2hhaW5zIHw9IEJJVChjb3VudF9yc3Np
KTsNCi0JCQkJc2luZm8tPmNoYWluX3NpZ25hbF9hdmdbY291bnRfcnNzaV0gPQ0KLQkJCQkJc3Rh
X2luZm9fbGUucnNzaVtpXTsNCi0JCQkJc2luZm8tPmNoYWluX3NpZ25hbFtjb3VudF9yc3NpXSA9
DQotCQkJCQlzdGFfaW5mb19sZS5yc3NpW2ldOw0KLQkJCQl0b3RhbF9yc3NpICs9IHN0YV9pbmZv
X2xlLnJzc2lbaV07DQotCQkJCWNvdW50X3Jzc2krKzsNCi0JCQl9DQorCQkJaWYgKHN0YV9pbmZv
X2xlLnJzc2lbaV0gPT0gMCB8fA0KKwkJCSAgICBzdGFfaW5mb19sZS5yeF9sYXN0cGt0X3Jzc2lb
aV0gPT0gMCkNCisJCQkJY29udGludWU7DQorCQkJc2luZm8tPmNoYWlucyB8PSBCSVQoY291bnRf
cnNzaSk7DQorCQkJc2luZm8tPmNoYWluX3NpZ25hbFtjb3VudF9yc3NpXSA9DQorCQkJCXN0YV9p
bmZvX2xlLnJ4X2xhc3Rwa3RfcnNzaVtpXTsNCisJCQlzaW5mby0+Y2hhaW5fc2lnbmFsX2F2Z1tj
b3VudF9yc3NpXSA9DQorCQkJCXN0YV9pbmZvX2xlLnJzc2lbaV07DQorCQkJdG90YWxfcnNzaSAr
PSBzdGFfaW5mb19sZS5yeF9sYXN0cGt0X3Jzc2lbaV07DQorCQkJdG90YWxfcnNzaV9hdmcgKz0g
c3RhX2luZm9fbGUucnNzaVtpXTsNCisJCQljb3VudF9yc3NpKys7DQogCQl9DQogCQlpZiAoY291
bnRfcnNzaSkgew0KLQkJCXNpbmZvLT5maWxsZWQgfD0gQklUX1VMTChOTDgwMjExX1NUQV9JTkZP
X0NIQUlOX1NJR05BTCk7DQogCQkJc2luZm8tPmZpbGxlZCB8PSBCSVRfVUxMKE5MODAyMTFfU1RB
X0lORk9fU0lHTkFMKTsNCi0JCQl0b3RhbF9yc3NpIC89IGNvdW50X3Jzc2k7DQotCQkJc2luZm8t
PnNpZ25hbCA9IHRvdGFsX3Jzc2k7DQorCQkJc2luZm8tPmZpbGxlZCB8PSBCSVRfVUxMKE5MODAy
MTFfU1RBX0lORk9fU0lHTkFMX0FWRyk7DQorCQkJc2luZm8tPmZpbGxlZCB8PSBCSVRfVUxMKE5M
ODAyMTFfU1RBX0lORk9fQ0hBSU5fU0lHTkFMKTsNCisJCQlzaW5mby0+ZmlsbGVkIHw9DQorCQkJ
CUJJVF9VTEwoTkw4MDIxMV9TVEFfSU5GT19DSEFJTl9TSUdOQUxfQVZHKTsNCisJCQlzaW5mby0+
c2lnbmFsID0gdG90YWxfcnNzaSAvIGNvdW50X3Jzc2k7DQorCQkJc2luZm8tPnNpZ25hbF9hdmcg
PSB0b3RhbF9yc3NpX2F2ZyAvIGNvdW50X3Jzc2k7DQogCQl9IGVsc2UgaWYgKHRlc3RfYml0KEJS
Q01GX1ZJRl9TVEFUVVNfQ09OTkVDVEVELA0KIAkJCSZpZnAtPnZpZi0+c21lX3N0YXRlKSkgew0K
IAkJCW1lbXNldCgmc2NiX3ZhbCwgMCwgc2l6ZW9mKHNjYl92YWwpKTsNCi0tIA0KMi4zMS4xDQo=
