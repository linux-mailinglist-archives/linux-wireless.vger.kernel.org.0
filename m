Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5F92F2DAE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 12:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbhALLO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jan 2021 06:14:29 -0500
Received: from mail-eopbgr80093.outbound.protection.outlook.com ([40.107.8.93]:18055
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbhALLO2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jan 2021 06:14:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1HSUqIyPRmBsUSzOVpx362CjYnJm223MFNUf8RSFljRBqDRaiWt1jTHQIb4+01xuM0HqpsM4LctY7G2SZ1rdFnznnjHzSdMWJx0X+vSVxldgEa9N1OFkbFYmtlXCtcAcAT3ABMD/wECEdIQ+hGxaIddGi/IcULdZbj0f9lYtAdOTH2xZk7EF1Wr4rG9FzI7ngPg9/sZp3HJMx/9Jnnenwezy6gOXp96OD9E2m/BQfCAcTjoKmr+eDxZ3vcx5402lEfpN+5M1LMDQJ07yBTmfuudEsvhyJJiaaMMEeAdwZeAHJjstB7Vll099xqCV1umhgTYQjNQIENcfALwEx9dsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWSfuLfkp25kqqbVgK/7rZ3wIGmZDtoPqlvg1YyMt/c=;
 b=Vj1itMTdcReF/T/B5wiGm5j7KDkrjXXC49idqwO0fHcaAnAtUXo4wYXEBmWk7Im09PAuBwe71bzU+IzXF5nJW1DhKZBcOdVwFvl+StWBQofKZZ67mR+MD4k4EVQOtIQzWrrSDMSD+bDqnOQpzf2U0b903yzLVzoYxyIz4R/kFgXp6LYctW6k+KFCow19BqrvEGaY7NjSJ2Y1zK1mwRwQ6aNnz5/6zJsAbpGVZ+oEE4257dSPMruXhvfYD6k/gGimDOItP/qWS+b0z5YBV4XlFVTb8O7ahsLkuni28ptEzY4dlGgEBepS3QET0y7nISNVD9R/465UsJnAMw0M2soYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWSfuLfkp25kqqbVgK/7rZ3wIGmZDtoPqlvg1YyMt/c=;
 b=JXqbo8efISjjCgg1eTmIzP+6YbFPjZet1i8hFSuLWx+huvVlyCgfNHATFX+h8jPBJffeN0CsZfcVnbNcpqYmDoH1ayZWvoTzHrxXpnZWOmf9UvkDmYKDhub5qBkqT59yauXcp4WpfXpeAIp3UfUptWHysFlf6uznlLK2+jQGomg=
Received: from DB6PR03MB3158.eurprd03.prod.outlook.com (2603:10a6:6:38::10) by
 DB6PR0302MB2648.eurprd03.prod.outlook.com (2603:10a6:4:b4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Tue, 12 Jan 2021 11:13:37 +0000
Received: from DB6PR03MB3158.eurprd03.prod.outlook.com
 ([fe80::d4d4:985d:22d5:8ca6]) by DB6PR03MB3158.eurprd03.prod.outlook.com
 ([fe80::d4d4:985d:22d5:8ca6%4]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 11:13:37 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] brcmfmac: add support for CQM RSSI notifications
Thread-Topic: [PATCH] brcmfmac: add support for CQM RSSI notifications
Thread-Index: AQHW6NP56plH53ydIkSxb2hpUB/rTA==
Date:   Tue, 12 Jan 2021 11:13:36 +0000
Message-ID: <20210112111253.4176340-1-alsi@bang-olufsen.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.29.2
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bang-olufsen.dk;
x-originating-ip: [193.89.194.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 067c758a-42d7-4b18-bc6b-08d8b6eb1ba8
x-ms-traffictypediagnostic: DB6PR0302MB2648:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0302MB264816BC40093D50DE015D5B83AA0@DB6PR0302MB2648.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQ20/1EJV6FFrASvNZKYUBpnP2lNSGG8PihHHmh/IE8GQBzWloxtJL1GLmTuOu2O+HYXn0gq9RJUXy/N0nfsne2ybvt8MEOhY+g9wS1MHzg8/7/7E2eLReN4+ffjUDyeOwfDPSBXZm4qlopF350xBJWYpwTuIywJYafT6gRMkirodEp1AmPu+8E9Z008k0wMWGYHh84+bvxf+jriZftbWzySjY5Jw8P0BOL29jbWnAAdc+LXZpBciJ59OSsfwzvKiri1moAkE4Hn+o33MfOKSuB6bIz/umeFz/dWBkMPI8zATjcmZzb+8mDtW1dAoRLTIVp/LdVUPCwpRyYjAcmHGZFj0Pbkx2QXnyoZjoBzsICQXCAgiOzsWUZmuDoX+8LR0PK2CuD9MHaU/ESVc8oZdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3158.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(8976002)(85202003)(6512007)(1076003)(4326008)(36756003)(66574015)(2616005)(478600001)(8936002)(7416002)(316002)(86362001)(26005)(186003)(6486002)(85182001)(2906002)(71200400001)(83380400001)(66476007)(66946007)(8676002)(91956017)(6506007)(54906003)(5660300002)(66556008)(64756008)(110136005)(76116006)(66446008)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a1lORHQ0R3drZkVLL2JqV1JYczAvYjU2MkZ0SE9pQkRNR29OUFlrc2xhTVVm?=
 =?utf-8?B?RENLSUFnUHVFdTFyQU9hTXRLZU1KdHUyZmxoaHl0NDBDeEVtank0TlF6VDgr?=
 =?utf-8?B?Ylc5K3NxcTcrYnZpdm1XTW9GL2RRZDRpWXY5cFhBR3pLU1ZUb1lkUmp2Ylps?=
 =?utf-8?B?ajVsamF6VkJjeEFLUUR6T1JIdG5PamdrVnlNZmVTVnBDWDNOVXZzeHBCMGE0?=
 =?utf-8?B?Y1VXU3p0UFBNeVBtUnVLQnlFZHpoSSt2VGZybFZiSnpwR3locTN6ZU5oSGE0?=
 =?utf-8?B?TUtlMVA0K1o3cTNBWjArWFhIMlFycVZFSzBTRnNvcG9RSm5DaDV5WGNrUXdE?=
 =?utf-8?B?R2NsMVU0ajNNa25CSHBsNFp2YTg4YW9LdUZwVHczSmFrekhaS2k0RnA1eS9w?=
 =?utf-8?B?YUFkdmhzbG0zQlpoWkpTa1ROQzRhV0VpRVJyUlBldnBPNGJZSWRFZU5iVFd5?=
 =?utf-8?B?OFFDcmJXR29WMWNYeU1Ba3RyNThSaW5ZcWg1QnVyQjN5ZlVTVk5LSzIxWklz?=
 =?utf-8?B?bDQ2a1UwM2NudFgzVFltdFlRTi9oUExWZEhmcXlVSGhXSFVKMWZFN1N4cVQx?=
 =?utf-8?B?ZWU1eTdCZTlXSzF4dEdNVHZINmFuQVBXV0poYTk3cmYzUTlIRTBJQTk5QjFx?=
 =?utf-8?B?aHZFSkZPZGRCV1ZVY3Nlb29oSGlkZVFuNmI3aDlmRC9wSUlGOFlCZnU2SUVR?=
 =?utf-8?B?RnZqOGZJWkhqSkxsTEQxWXgwaVovbEdub3d4UDM1YzF0ZlFOd0JwUlNDbnQr?=
 =?utf-8?B?RnkxSFhRaVdlNTBKdDl2N1FFQnZQaEJNNlNON1kxNXlTZjc3a1NHaXczUFZu?=
 =?utf-8?B?R0lEb1A5Rzh1amtoY3dhODNiUXR4dWxvRTBqdTdKL1NiWFA4N3ByOWhiYll0?=
 =?utf-8?B?dlVITk1sYWNNTUMrTEtoYUsrdXROM2hubStXeGxrZGptempWZXRvK2FpVjNN?=
 =?utf-8?B?S0ttKzMxSGdKTmV2UGdGOW9idUxGZng1VDcrM2YzNnd0YzIyRlUwcTFPMmZU?=
 =?utf-8?B?ekYwcTVhSHBNOFBxZ1VXKzY4MFg3d25sYkZvbDBzR0ZoclJISitKL0xEK2h3?=
 =?utf-8?B?dnlMeUtrS0Q3STVxd20wWmRTVUhiNXpUdnU2cUpramROWkxZd29xZWdQTnVO?=
 =?utf-8?B?YVZXVWhPbnpPSkwyc1l1Y0J2V2w3TmRmU0pVaUhWZnFORE9vS0hNV3d3Q1pU?=
 =?utf-8?B?eWVGeEN4ZVhHa0tidzVvMEtxaWxtUmhRZVd4cjNIaVBMaUIwV0hzZEZGR2Fk?=
 =?utf-8?B?RUNEZGprcFVucGhRUFFwaWJCNmNiK1JYYVE4YUhzekRYWGdjd0NjUkNyNWFS?=
 =?utf-8?Q?DoSb/RMnI8vJX20COpS/7inpdNufqPHQ4D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C30CE048823164E81B6483FD0FB9989@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3158.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067c758a-42d7-4b18-bc6b-08d8b6eb1ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 11:13:36.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNVzK43YG1QsWeczvMAO1Ajg9Bg1VkfN6WZX3w/E6zmrtumBE77qxzmWHXTpyyi+G365fRUnSGEW2p0QzeW8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2648
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIENRTSBSU1NJIG1lYXN1cmVtZW50IHJlcG9ydGluZyBhbmQgYWR2ZXJ0
aXNlIHRoZQ0KTkw4MDIxMV9FWFRfRkVBVFVSRV9DUU1fUlNTSV9MSVNUIGZlYXR1cmUuIFRoaXMg
ZW5hYmxlcyBhIHVzZXJzcGFjZQ0Kc3VwcGxpY2FudCBzdWNoIGFzIGl3ZCB0byBiZSBub3RpZmll
ZCBvZiBjaGFuZ2VzIGluIHRoZSBSU1NJIGZvciByb2FtaW5nDQphbmQgc2lnbmFsIG1vbml0b3Jp
bmcgcHVycG9zZXMuDQoNClNpZ25lZC1vZmYtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmct
b2x1ZnNlbi5kaz4NCi0tLQ0KIC4uLi9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAy
MTEuYyAgICB8IDgyICsrKysrKysrKysrKysrKysrKysNCiAuLi4vYnJvYWRjb20vYnJjbTgwMjEx
L2JyY21mbWFjL2NmZzgwMjExLmggICAgfCAgNiArKw0KIC4uLi9icm9hZGNvbS9icmNtODAyMTEv
YnJjbWZtYWMvZndpbF90eXBlcy5oICB8IDI4ICsrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDEx
NiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9h
ZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jDQppbmRleCAwZWU0MjFmMzBh
YTIuLjIxYjUzYmQyN2Y3ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2Fk
Y29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuYw0KQEAgLTUxOTYsNiAr
NTE5Niw0MSBAQCBicmNtZl9jZmc4MDIxMV9tZ210X3R4KHN0cnVjdCB3aXBoeSAqd2lwaHksIHN0
cnVjdCB3aXJlbGVzc19kZXYgKndkZXYsDQogCXJldHVybiBlcnI7DQogfQ0KIA0KK3N0YXRpYyBp
bnQgYnJjbWZfY2ZnODAyMTFfc2V0X2NxbV9yc3NpX3JhbmdlX2NvbmZpZyhzdHJ1Y3Qgd2lwaHkg
KndpcGh5LA0KKwkJCQkJCSAgICBzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwNCisJCQkJCQkgICAg
czMyIHJzc2lfbG93LCBzMzIgcnNzaV9oaWdoKQ0KK3sNCisJc3RydWN0IGJyY21mX2NmZzgwMjEx
X3ZpZiAqdmlmOw0KKwlzdHJ1Y3QgYnJjbWZfaWYgKmlmcDsNCisJaW50IGVyciA9IDA7DQorDQor
CWJyY21mX2RiZyhUUkFDRSwgImxvdz0lZCBoaWdoPSVkIiwgcnNzaV9sb3csIHJzc2lfaGlnaCk7
DQorDQorCWlmcCA9IG5ldGRldl9wcml2KG5kZXYpOw0KKwl2aWYgPSBpZnAtPnZpZjsNCisNCisJ
aWYgKHJzc2lfbG93ICE9IHZpZi0+Y3FtX3Jzc2lfbG93IHx8IHJzc2lfaGlnaCAhPSB2aWYtPmNx
bV9yc3NpX2hpZ2gpIHsNCisJCXN0cnVjdCBicmNtZl9yc3NpX2V2ZW50X2xlIGNvbmZpZyA9IHsN
CisJCQkucmF0ZV9saW1pdF9tc2VjID0gY3B1X3RvX2xlMzIoMCksDQorCQkJLnJzc2lfbGV2ZWxf
bnVtID0gMiwNCisJCQkucnNzaV9sZXZlbHMgPSB7DQorCQkJCW1heF90KHMzMiwgcnNzaV9sb3cs
IFM4X01JTiksDQorCQkJCW1pbl90KHMzMiwgcnNzaV9oaWdoLCBTOF9NQVgpLA0KKwkJCX0sDQor
CQl9Ow0KKw0KKwkJZXJyID0gYnJjbWZfZmlsX2lvdmFyX2RhdGFfc2V0KGlmcCwgInJzc2lfZXZl
bnQiLCAmY29uZmlnLA0KKwkJCQkJICAgICAgIHNpemVvZihjb25maWcpKTsNCisJCWlmIChlcnIp
IHsNCisJCQllcnIgPSAtRUlOVkFMOw0KKwkJfSBlbHNlIHsNCisJCQl2aWYtPmNxbV9yc3NpX2xv
dyA9IHJzc2lfbG93Ow0KKwkJCXZpZi0+Y3FtX3Jzc2lfaGlnaCA9IHJzc2lfaGlnaDsNCisJCX0N
CisJfQ0KKw0KKwlyZXR1cm4gZXJyOw0KK30NCiANCiBzdGF0aWMgaW50DQogYnJjbWZfY2ZnODAy
MTFfY2FuY2VsX3JlbWFpbl9vbl9jaGFubmVsKHN0cnVjdCB3aXBoeSAqd2lwaHksDQpAQCAtNTUw
Miw2ICs1NTM3LDcgQEAgc3RhdGljIHN0cnVjdCBjZmc4MDIxMV9vcHMgYnJjbWZfY2ZnODAyMTFf
b3BzID0gew0KIAkudXBkYXRlX21nbXRfZnJhbWVfcmVnaXN0cmF0aW9ucyA9DQogCQlicmNtZl9j
Zmc4MDIxMV91cGRhdGVfbWdtdF9mcmFtZV9yZWdpc3RyYXRpb25zLA0KIAkubWdtdF90eCA9IGJy
Y21mX2NmZzgwMjExX21nbXRfdHgsDQorCS5zZXRfY3FtX3Jzc2lfcmFuZ2VfY29uZmlnID0gYnJj
bWZfY2ZnODAyMTFfc2V0X2NxbV9yc3NpX3JhbmdlX2NvbmZpZywNCiAJLnJlbWFpbl9vbl9jaGFu
bmVsID0gYnJjbWZfcDJwX3JlbWFpbl9vbl9jaGFubmVsLA0KIAkuY2FuY2VsX3JlbWFpbl9vbl9j
aGFubmVsID0gYnJjbWZfY2ZnODAyMTFfY2FuY2VsX3JlbWFpbl9vbl9jaGFubmVsLA0KIAkuZ2V0
X2NoYW5uZWwgPSBicmNtZl9jZmc4MDIxMV9nZXRfY2hhbm5lbCwNCkBAIC02MTM3LDYgKzYxNzMs
NDkgQEAgYnJjbWZfbm90aWZ5X21pY19zdGF0dXMoc3RydWN0IGJyY21mX2lmICppZnAsDQogCXJl
dHVybiAwOw0KIH0NCiANCitzdGF0aWMgczMyIGJyY21mX25vdGlmeV9yc3NpKHN0cnVjdCBicmNt
Zl9pZiAqaWZwLA0KKwkJCSAgICAgY29uc3Qgc3RydWN0IGJyY21mX2V2ZW50X21zZyAqZSwgdm9p
ZCAqZGF0YSkNCit7DQorCXN0cnVjdCBicmNtZl9jZmc4MDIxMV92aWYgKnZpZiA9IGlmcC0+dmlm
Ow0KKwlzdHJ1Y3QgYnJjbWZfcnNzaV9iZSAqaW5mbyA9IGRhdGE7DQorCXMzMiByc3NpLCBzbnIs
IG5vaXNlOw0KKwlzMzIgbG93LCBoaWdoLCBsYXN0Ow0KKw0KKwlpZiAoZS0+ZGF0YWxlbiA8IHNp
emVvZigqaW5mbykpIHsNCisJCWJyY21mX2VycigiaW5zdWZmaWNpZW50IFJTU0kgZXZlbnQgZGF0
YVxuIik7DQorCQlyZXR1cm4gMDsNCisJfQ0KKw0KKwlyc3NpID0gYmUzMl90b19jcHUoaW5mby0+
cnNzaSk7DQorCXNuciA9IGJlMzJfdG9fY3B1KGluZm8tPnNucik7DQorCW5vaXNlID0gYmUzMl90
b19jcHUoaW5mby0+bm9pc2UpOw0KKw0KKwlsb3cgPSB2aWYtPmNxbV9yc3NpX2xvdzsNCisJaGln
aCA9IHZpZi0+Y3FtX3Jzc2lfaGlnaDsNCisJbGFzdCA9IHZpZi0+Y3FtX3Jzc2lfbGFzdDsNCisN
CisJYnJjbWZfZGJnKFRSQUNFLCAicnNzaT0lZCBzbnI9JWQgbm9pc2U9JWQgbG93PSVkIGhpZ2g9
JWQgbGFzdD0lZFxuIiwNCisJCSAgcnNzaSwgc25yLCBub2lzZSwgbG93LCBoaWdoLCBsYXN0KTsN
CisNCisJaWYgKHJzc2kgIT0gbGFzdCkgew0KKwkJdmlmLT5jcW1fcnNzaV9sYXN0ID0gcnNzaTsN
CisNCisJCWlmIChyc3NpIDw9IGxvdyB8fCByc3NpID09IDApIHsNCisJCQlicmNtZl9kYmcoSU5G
TywgIkxPVyByc3NpPSVkXG4iLCByc3NpKTsNCisJCQljZmc4MDIxMV9jcW1fcnNzaV9ub3RpZnko
aWZwLT5uZGV2LA0KKwkJCQkJCSBOTDgwMjExX0NRTV9SU1NJX1RIUkVTSE9MRF9FVkVOVF9MT1cs
DQorCQkJCQkJIHJzc2ksIEdGUF9LRVJORUwpOw0KKwkJfSBlbHNlIGlmIChyc3NpID4gaGlnaCkg
ew0KKwkJCWJyY21mX2RiZyhJTkZPLCAiSElHSCByc3NpPSVkXG4iLCByc3NpKTsNCisJCQljZmc4
MDIxMV9jcW1fcnNzaV9ub3RpZnkoaWZwLT5uZGV2LA0KKwkJCQkJCSBOTDgwMjExX0NRTV9SU1NJ
X1RIUkVTSE9MRF9FVkVOVF9ISUdILA0KKwkJCQkJCSByc3NpLCBHRlBfS0VSTkVMKTsNCisJCX0N
CisJfQ0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIHMzMiBicmNtZl9ub3RpZnlfdmlm
X2V2ZW50KHN0cnVjdCBicmNtZl9pZiAqaWZwLA0KIAkJCQkgIGNvbnN0IHN0cnVjdCBicmNtZl9l
dmVudF9tc2cgKmUsIHZvaWQgKmRhdGEpDQogew0KQEAgLTYyMzUsNiArNjMxNCw3IEBAIHN0YXRp
YyB2b2lkIGJyY21mX3JlZ2lzdGVyX2V2ZW50X2hhbmRsZXJzKHN0cnVjdCBicmNtZl9jZmc4MDIx
MV9pbmZvICpjZmcpDQogCQkJICAgIGJyY21mX3AycF9ub3RpZnlfYWN0aW9uX3R4X2NvbXBsZXRl
KTsNCiAJYnJjbWZfZndlaF9yZWdpc3RlcihjZmctPnB1YiwgQlJDTUZfRV9QU0tfU1VQLA0KIAkJ
CSAgICBicmNtZl9ub3RpZnlfY29ubmVjdF9zdGF0dXMpOw0KKwlicmNtZl9md2VoX3JlZ2lzdGVy
KGNmZy0+cHViLCBCUkNNRl9FX1JTU0ksIGJyY21mX25vdGlmeV9yc3NpKTsNCiB9DQogDQogc3Rh
dGljIHZvaWQgYnJjbWZfZGVpbml0X3ByaXZfbWVtKHN0cnVjdCBicmNtZl9jZmc4MDIxMV9pbmZv
ICpjZmcpDQpAQCAtNzE2OSw2ICs3MjQ5LDggQEAgc3RhdGljIGludCBicmNtZl9zZXR1cF93aXBo
eShzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBzdHJ1Y3QgYnJjbWZfaWYgKmlmcCkNCiAJCXdpcGh5X2V4
dF9mZWF0dXJlX3NldCh3aXBoeSwNCiAJCQkJICAgICAgTkw4MDIxMV9FWFRfRkVBVFVSRV9ERlNf
T0ZGTE9BRCk7DQogDQorCXdpcGh5X2V4dF9mZWF0dXJlX3NldCh3aXBoeSwgTkw4MDIxMV9FWFRf
RkVBVFVSRV9DUU1fUlNTSV9MSVNUKTsNCisNCiAJd2lwaHlfcmVhZF9vZl9mcmVxX2xpbWl0cyh3
aXBoeSk7DQogDQogCXJldHVybiAwOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5oIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmgNCmluZGV4IDE3ODE3
Y2RiNWRlMi4uZTkwYTMwODA4YzIyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
YnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmgNCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5oDQpAQCAtMjEz
LDYgKzIxMyw5IEBAIHN0cnVjdCB2aWZfc2F2ZWRfaWUgew0KICAqIEBsaXN0OiBsaW5rZWQgbGlz
dC4NCiAgKiBAbWdtdF9yeF9yZWc6IHJlZ2lzdGVyZWQgcnggbWdtdCBmcmFtZSB0eXBlcy4NCiAg
KiBAbWJzczogTXVsdGlwbGUgQlNTIHR5cGUsIHNldCBpZiBub3QgZmlyc3QgQVAgKG5vdCByZWxl
dmFudCBmb3IgUDJQKS4NCisgKiBAY3FtX3Jzc2lfbG93OiBMb3dlciBSU1NJIGxpbWl0IGZvciBD
UU0gbW9uaXRvcmluZw0KKyAqIEBjcW1fcnNzaV9oaWdoOiBVcHBlciBSU1NJIGxpbWl0IGZvciBD
UU0gbW9uaXRvcmluZw0KKyAqIEBjcW1fcnNzaV9sYXN0OiBMYXN0IFJTU0kgcmVhZGluZyBmb3Ig
Q1FNIG1vbml0b3JpbmcNCiAgKi8NCiBzdHJ1Y3QgYnJjbWZfY2ZnODAyMTFfdmlmIHsNCiAJc3Ry
dWN0IGJyY21mX2lmICppZnA7DQpAQCAtMjI0LDYgKzIyNyw5IEBAIHN0cnVjdCBicmNtZl9jZmc4
MDIxMV92aWYgew0KIAl1MTYgbWdtdF9yeF9yZWc7DQogCWJvb2wgbWJzczsNCiAJaW50IGlzXzEx
ZDsNCisJczMyIGNxbV9yc3NpX2xvdzsNCisJczMyIGNxbV9yc3NpX2hpZ2g7DQorCXMzMiBjcW1f
cnNzaV9sYXN0Ow0KIH07DQogDQogLyogYXNzb2NpYXRpb24gaW5mb3JtICovDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2Z3aWxf
dHlwZXMuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1h
Yy9md2lsX3R5cGVzLmgNCmluZGV4IDJlMzFjYzEwYzE5NS4uZmYyZWY1NTdmMGVhIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2Z3
aWxfdHlwZXMuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjEx
L2JyY21mbWFjL2Z3aWxfdHlwZXMuaA0KQEAgLTc1Miw2ICs3NTIsMzQgQEAgc3RydWN0IGJyY21m
X2Fzc29jbGlzdF9sZSB7DQogCXU4IG1hY1tCUkNNRl9NQVhfQVNTT0NMSVNUXVtFVEhfQUxFTl07
DQogfTsNCiANCisvKioNCisgKiBzdHJ1Y3QgYnJjbWZfcnNzaV9iZSAtIFJTU0kgdGhyZXNob2xk
IGV2ZW50IGZvcm1hdA0KKyAqDQorICogQHJzc2k6IHJlY2VpdmUgc2lnbmFsIHN0cmVuZ3RoIChp
biBkQm0pDQorICogQHNucjogc2lnbmFsLW5vaXNlIHJhdGlvDQorICogQG5vaXNlOiBub2lzZSAo
aW4gZEJtKQ0KKyAqLw0KK3N0cnVjdCBicmNtZl9yc3NpX2JlIHsNCisJX19iZTMyIHJzc2k7DQor
CV9fYmUzMiBzbnI7DQorCV9fYmUzMiBub2lzZTsNCit9Ow0KKw0KKyNkZWZpbmUgQlJDTUZfTUFY
X1JTU0lfTEVWRUxTIDgNCisNCisvKioNCisgKiBzdHJ1Y3QgYnJjbV9yc3NpX2V2ZW50X2xlIC0g
cnNzaV9ldmVudCBJT1ZBUiBmb3JtYXQNCisgKg0KKyAqIEByYXRlX2xpbWl0X21zZWM6IFJTU0kg
ZXZlbnQgcmF0ZSBsaW1pdA0KKyAqIEByc3NpX2xldmVsX251bTogbnVtYmVyIG9mIHN1cHBsaWVk
IFJTU0kgbGV2ZWxzDQorICogQHJzc2lfbGV2ZWxzOiBSU1NJIGxldmVscyBpbiBhc2NlbmRpbmcg
b3JkZXINCisgKi8NCitzdHJ1Y3QgYnJjbWZfcnNzaV9ldmVudF9sZSB7DQorCV9fbGUzMiByYXRl
X2xpbWl0X21zZWM7DQorCXM4IHJzc2lfbGV2ZWxfbnVtOw0KKwlzOCByc3NpX2xldmVsc1tCUkNN
Rl9NQVhfUlNTSV9MRVZFTFNdOw0KK307DQorDQogLyoqDQogICogc3RydWN0IGJyY21mX3dvd2xf
d2FrZWluZF9sZSAtIFdha2V1cCBpbmRpY2F0b3JzDQogICoJTm90ZTogbm90ZSBib3RoIGZpZWxk
cyBjb250YWluIHNhbWUgaW5mb3JtYXRpb24uDQotLSANCjIuMjkuMg0K
