Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F054E653D2A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 09:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiLVIv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 03:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiLVIv0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 03:51:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8645EE0D
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 00:51:19 -0800 (PST)
X-UUID: 4f685733bd0441768185b5a7a1af9f9f-20221222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=99g4eLgpL4CXEB/tixaI61IF3J+SEcQXLepGPRBeaZs=;
        b=hf8+N2nWMtwnWh/0ZT5hLOYRBitNXcx4TKh1JHHsPMQDV4VHpJEd570amHbc5N6mdVykLeDoXV7n/c0KnCpvScTlKRao6u9k9/Pcc2xGXa7/Tb8b4VoBU6wA+wX3CsfbB+UmdcatMLE01QkYrVWyB23iM5iIyFqtdQh2nQLlSjI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a48c412d-b35e-485a-9695-79d71aa0dfc2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:81067f52-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4f685733bd0441768185b5a7a1af9f9f-20221222
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1732595429; Thu, 22 Dec 2022 16:51:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 22 Dec 2022 16:51:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Dec 2022 16:51:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muMD89bxCOog6lTKGyZsYqhA8jm5ZskW+S2f3FtdZmSt3LvmAst8QvtgdR+AL4B70VnU+IFzxGgdmj7QBxqglAwSMZafSk/1uY5vDShOHDjEzDH5AGQ7vw5QBbwqvVKKWr5uXOgZ8pyhO+ShVX2Bg/kJAxSkvHU8TlBuwGn7N4hpB59PVA6yFNtWLULBps7fXsT/m+Yuy+emPyiP5PhOXG4CyvwA0E/Z07zR6ONQdwynsvfyHlfgm93krsv8UTK7lBXIs/aTQq6q1EajAMyp/JYN+bhME8Ma2Jhn5BRtiExaeIFfQd2B/qAw5qS0V3kMNCF4w28fAMBtMYeefCecQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99g4eLgpL4CXEB/tixaI61IF3J+SEcQXLepGPRBeaZs=;
 b=JACQb+AcgtpRJ3dIf7ordJk4xm7vOSjxjpXdpiVimWloP1KuKo4PjBl2LX25x2s8Zl/W5xQU2peeosErNxTGKasroV1UcyrhvfeWr51lk3p5oDRvevS87wi9W3cKys+9VTAhCD9IlRuZagACo01Lb00zk8ByzYMAxLi8pQMnLxCOOXwGT3RDQ9r90RFqxYtJsmhDYa9rqOKLlL2xPqS0Ct/1JT1+Ovr/OCQg2hkfPA0YutxOInG/3Idw8PAngKXJepPWaygFsvaIfk69Cdskx0PWIo5cd/LDmxkBRV0Ht5yysRhHBy4nFGAtTEEtnfBRfC7olt6RCOeulPkYIhTR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99g4eLgpL4CXEB/tixaI61IF3J+SEcQXLepGPRBeaZs=;
 b=Xv1d/XVEXSzgB30Vb7MjfG5IZcBWsJJWvqiEjN/c/lr3SDOujd0+prqhwTC209aP7FNLTNK7a3+HHe3QeQ8gnS7GQyMVOLtLBLcZst0tqq36zNhlFPcwhFXFjeAyS2UKYHrmHqjemQy6NBOjv/1COoU+TyYlfHxrOV1c11VbjU4=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by SEYPR03MB6673.apcprd03.prod.outlook.com (2603:1096:101:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 08:51:10 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec%7]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 08:51:10 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Topic: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Index: AQHZE2UYm26GeWDuU0a5b6k/XQDcva50+UQAgAE64oCAAfJmgIAASTAAgAAGzwCAAC9VgIAA+GYA
Date:   Thu, 22 Dec 2022 08:51:10 +0000
Message-ID: <6de89564e1deb0b641b2a5039b23909f4647425e.camel@mediatek.com>
References: <3940cc5ccb4b17d51b5176e722daef0d1af66d6a.camel@mediatek.com>
         <B2689D6F-E04E-4E9B-9244-4E5069DC464D@nbd.name>
         <Y6NKHY7euhifm0kI@lore-desk>
In-Reply-To: <Y6NKHY7euhifm0kI@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|SEYPR03MB6673:EE_
x-ms-office365-filtering-correlation-id: 3515d14a-ddac-442d-5c13-08dae3f9ac45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kgYg8e9mh9LV2pbKNU0RFwIcvp2th5s7IDaE/8f1HnVR5E4w7D14jaKdDMU1/6IF9P3JiqHcnB5v0kRlnRTfo0no3aKgzroqAzMMhft3Rvoop+gW6+K6AHWKeCvaFijaUkf6YgJ4F8IKnQYfCz0gFdXevY+aRP8hRlodD/nfu5zfF4QUAblWgPP94dnKK1IlVoyVcN5jvLQ1lHu3TS0mVGeTAainTOxKArNY2ckm76u1/DaYds8znKoSBiHToFRLGCTmWZtEWPNmGfO1Y5VwATENWHtw+jL1i0yMjI+OvIP67aCZ17bl7zZUtRzpuEkKaWywi6x7HQC5qryxBK/LsJgNCAdJ2jcb+qAD7McKRWaMS7/wRgbJ+qoKIGTdpMDZVjCKcFijsf3xg9X9zSkJmXpkGCiONwdXXzNVhMuLuQdREuoJmu4a3GqgCt50yybsaMUr71who2+DbTRAXsYpAxinLM7NNV8mx8KCJo6b+SxKTte1uT6raSob8xpaQaQ6icnwlyZ5ihsemtw9FEHa08OMbJWQdTZeP+Baq8jiabiHdUxaEfX2bdi29psNrK0sSilneHqwt/Qa/3Z59W2T74YoEQXD13oJ9/glTV7hArUFjNVI+3gHEoYsfFipgyAi9xBqZK4lzVpWgB9fA0OibZKQzWtOR7xGwvpXwUSGSm8B1VRqWsdDqrtuwkF1/yS19SVSPKu8MFwCLbyQO5V1pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199015)(6512007)(85182001)(36756003)(478600001)(26005)(76116006)(41300700001)(2616005)(4326008)(66476007)(71200400001)(86362001)(83380400001)(8936002)(4001150100001)(91956017)(5660300002)(186003)(64756008)(66446008)(66946007)(66556008)(110136005)(122000001)(316002)(38070700005)(2906002)(6506007)(54906003)(6486002)(8676002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS96QkNvQk5kb1IzZmFvT043Y25obUlLbmJpTHp0citOQ0pTcDhoS01pTVdT?=
 =?utf-8?B?a2xFdUl4dzhGM1phWmdlR295Q1Y5aVZUQUpsR1lGV3R0em5PNjBZclFrZElt?=
 =?utf-8?B?S0pLNWtQNUJIUThMNCtiZzd0YUhMbnFzaXREZUhPeVVlT3ZoWWlvU3p0UWNa?=
 =?utf-8?B?aGdBbTlQdzhvVFN5aDlhdTdkQllBWjdyMFpWNDBhcE5rejlUOENTaEF6ak1h?=
 =?utf-8?B?eUV6R3ZLSkhJWElNZTZ4MkxraUVVdFVNbWNPN2VyWkhseDExVHJjWno4Y3Jn?=
 =?utf-8?B?NHNPRnBla3NCMWFPYkxiUHBPQUFXN3VvL21udUxvdENmUHFYeUZYY2VmM25V?=
 =?utf-8?B?K0xVTTcxSTJsMmhnMDZGbFl4Z0thUlYrRW9FTTV4QlowS1VZRThiUVE1Z3g4?=
 =?utf-8?B?OWtVUW4xU1NSLzZwbVJYVzdnVGFpRFgwUmNqekJlc3ViWkxoeEtWSGhUcVhl?=
 =?utf-8?B?Z2NiRE5KNXN3M1F5eGtGRFU1eHlvMTV3NldZZ1dCSzBrZUhtZnMxTzU0SlBa?=
 =?utf-8?B?M0p0YU5vNHBSMzBCZjdLSzhXd0dSRjFYR09HenVOTDBmMGdQYm1yYzhjU0E1?=
 =?utf-8?B?S3FQRnRxWExkL0dDQjl5LzFiRVVVWjEzOEQ2bjdJbHNsSGxHdEJsYmthT01T?=
 =?utf-8?B?cXI0ZnRFQVU3QTNoM0c3TlNWSEdxeWZmWHByNStnazJqdmdtcUxjTFdaUmwr?=
 =?utf-8?B?bm1zdDJGVkFVTGlmNkJIZWg3SG1yakU3QlVuNXlyMW01ZlhxQ3pBZWI4dGUv?=
 =?utf-8?B?cUZhdTFvVmo3U0lZTE9GK2RnUTNaUkx6TkhocG1tK1JnVm9rcDNWZjQzVzh4?=
 =?utf-8?B?MlNndTVab0ZCTW5HdG03eXFJcitiSFZreGRaR0Q5ZHkwV2hxRldHOWJRTkx1?=
 =?utf-8?B?WGN0OWE3M0tucjZOcEJxOVd6T05KMmh6bkVPeWdncmNrQmc0SjRDR21oVWhj?=
 =?utf-8?B?a3pTVE03VWdqYUNNR2NrMGxLN1hJYkZJVTRLT3c5TzgrbTBYemNVTGZBU21B?=
 =?utf-8?B?Q1Q5alVXYWVxNkhUY2JvU2tjUEUvZ1pFTmJGS3FEdzBwR1FxZEZSbzZTdTlL?=
 =?utf-8?B?RS9XS2o5UTByTHdiK0JLOVRFZFZVaFQyY0NmanZGYkZueFlkMEFkeWZaUnYz?=
 =?utf-8?B?S3lOenUzTWlIUWcrVnN2K25jdUwxTEpseDB1VkVrQzUyVmdXd243MytLOWVs?=
 =?utf-8?B?R0NMTkdKWEtZbVEwdGltZ0Jhc3NjcHlmdHBqZjViY2E1MUFYYXNsMUN1dU4y?=
 =?utf-8?B?M2VySHBjRUNucW8zZ1BRY2tqemhqcmg4UEE5QXorRmMybno1ZTVMU05FNzM5?=
 =?utf-8?B?QnI0M04vV25EMlNsUXNQaVBaWmluQndzb3Y4R240d2dQQUR6SG9tdFNQdXlu?=
 =?utf-8?B?TFBvc2kra0l5SzdudGF2OEpXMU5QeTRMWEpqRG5PUnZwZ2dpakhPUmkzRGM3?=
 =?utf-8?B?SUNFeEVNdHYyZnI5NG5iZ2RJNHNtdnNkV3RldHJFWlFzam0zVjV6OVJRTmN3?=
 =?utf-8?B?QzdsUEhWUUZ2dWcyYm5xWlVPSUlnVlRRakF0QXI5dXBRWHlnWVgwaFVSaFlw?=
 =?utf-8?B?QWtleGVzbmJkUlZ3QndTTTlzS0FNZENEZ05GS1pJeDdFK1EzeW5wcjdKWS9M?=
 =?utf-8?B?d3U0d1NlRUNvcVgzd1FYNjBlSVFVcTl5Q1NCLzNQRCs0WGZVejBXRkRaOURH?=
 =?utf-8?B?T3FVajV2cUtFSkZiOWVjVnpSa2V2N1lIMFM5VE8zL0I3ODdXMTBqaXNYM1NE?=
 =?utf-8?B?Ukd1cWJvc0NvN0ZIWFJ1cjBLL2F5WmRyY3RYNWkvbTVKWnhMYUZuZmlOZ2F0?=
 =?utf-8?B?a2kzbUdRV2Y1M0w3MmorN2xkdTdRUFRXa296WTNGb1pXeUJmeFlUTXJtTFkx?=
 =?utf-8?B?VWZzMkJvb0JTMlFhb3JCdHFaMWVBNkUrYnB2VVhCZFVGTTUvMDlwZ3NsZGwr?=
 =?utf-8?B?WE1lZHZqQ0VzRTBtMWkyODBuYjZFblljRmtZWDdpeVlyQkJMRXNqQW1HRWZI?=
 =?utf-8?B?N1hPOUFTZFJwWnlmRzJJU2s4dUYvYnVLNjFjcy9wRitOYTdqcG9ZTG0vQmIz?=
 =?utf-8?B?SGJraXVaUUxKc2NTVk50ZENWdVdxbk5tREFiQmFUZzI4QVloZUpJNjZ0SUE2?=
 =?utf-8?B?dnJoalBkV0F3S1Ntd1J5cWpOaTI0S01lZ2VEVU52ZHhQTlg5NUUvcVB4V3pC?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC4910BB72B0114ABCE492C907EE53AB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3515d14a-ddac-442d-5c13-08dae3f9ac45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 08:51:10.2310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFRD4r9dOgMqlyIvdl7U2NaeSkvxSs5Ao6zkcZgsh1hGjUos4jiE7aEzMiXE1vZ4vYrn+VlzYEtQhN8XmFlEJemE9MCSzG19tcTZ0znnihk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6673
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTIxIGF0IDE5OjAyICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiBPbiBEZWMgMjEsIEZlbGl4IEZpZXRrYXUgd3JvdGU6DQo+ID4gSGkgU3VqdWFuLA0KPiA+
IA0KPiA+ID4gWWVzLCBpdCBpcyBzbyBleHBlbnNpdmUsIGJ1dCBpZiBubyBtZW1jb3B5LCBpdCB3
aWxsIGNhc3VlIG1lbW9yeQ0KPiA+ID4gZnJhZ21lbnRhdGlvbiAod2UgaGl0IHRoaXMgaXNzdWUg
aW4gaW50ZXJuYWwgU1FDKS4NCj4gPiA+IA0KPiA+ID4gYXMgd2Uga25vdywgd2VkIG5lZWRzIHRv
IGV4Y2hhbmdlIHJ4IHBrdChiZWxvbmdzIHRvIHdlZCByeCBidWZmZXINCj4gPiA+IG1hbmFnZXIp
IHdpdGggd2lmaSBkcml2ZXIoZG1hIHJ4IGRhdGEgcXVldWUpIGJ5IGV4Y2hhbmdpbmcgd2ZkbWEN
Cj4gPiA+IGRtYWQNCj4gPiA+IHRvIGVuc3VyZSB0aGUgZnJlZSB3ZWQgcnggYnVmZmVyLg0KPiA+
ID4gDQo+ID4gPiBpdCBpcyBwb3NzaWFibGUgdGhhdCBhIGxhcmdlIG51bWJlciBvZiBidWZmZXIg
aGFzIGJlZW4gZXhjaGFuZ2VkDQo+ID4gPiB0byB3ZWQNCj4gPiA+IGFuZCBjYW4gbm90IGNvbWUg
YmFjayB0byB3bGFuIGRyaXZlci4gU28sIHRoZSBtZW1vcnkgZnJvbSB0aGUNCj4gPiA+IHNhbWUg
MzJLDQo+ID4gPiBwYWdlIGNhY2hlIGlzIHVuYWJsZSB0byBiZSByZWxlYXNlZCwgYW5kIGl0IHdp
bGwgYmUgZmFpbGVkIGF0DQo+ID4gPiBwYWdlX2ZyYWdfYWxsb2MgaW4gbXQ3Nl9kbWFfcnhfZmls
bC4NCj4gPiA+IA0KPiA+ID4gQW55IGlkZWFzIGJ1dCBtZW1jb3B5Pw0KPiA+IA0KPiA+IEEgc2lt
cGxlIHNvbHV0aW9uIHdvdWxkIGJlIHRvIHNpbXBseSBhbGxvY2F0ZSBzaW5nbGUgcGFnZXMsIG9y
DQo+ID4gaGFsZi1wYWdlIGZyYWdtZW50cy4NCj4gPiANCj4gPiAtIEZlbGl4DQo+ID4gDQo+IA0K
PiBBIHNpbXBsZSBhcHByb2FjaCB3b3VsZCBiZSBhbGxvY2F0aW5nIGEgc2luZ2xlIHBhZ2UgZm9y
IGVhY2ggcngNCj4gYnVmZmVyLg0KPiANCj4gQFN1anVhbjogY2FuIHlvdSBwbGVhc2UgZG91Ymxl
IGNoZWNrIGlmIGl0IGlzIG9rIGZyb20gcGVyZm9ybWFuY2UgYW5kDQo+IG1lbW9yeQ0KPiAJIGZy
YWdtZW50YXRpb24gcG9pbnQgb2Ygdmlldz8gSWYgbm90IEkgZ3Vlc3Mgd2UgY2FuIHRyeSB0bw0K
PiBvcHRpbWl6ZSBpdA0KPiAJIGFuZCBhbGxvY2F0ZSBtdWx0aXBsZSBidWZmZXJzIGluIHRoZSBz
YW1lIHBhZ2UgdHdlZWtpbmcgcGFnZQ0KPiByZWZjb3VudC4NCj4gDQo+ICh0aGlzIHBhdGNoIG11
c3QgYmUgYXBwbGllZCBvbiB0b3Agb2YgRmVsaXgncyBkbWEgZml4KS4NCj4gDQoNCkFsbG9jYXRp
bmcgc2luZ2xlIHBhZ2UgZm9yIGVhY2ggcnggYnVmZmVyIGF2b2lkcyBtZW1vcnkgZnJhZ21lbnRh
dGlvbiwNCmJ1dCBpdCBhbHdheXMgdXNlcyA0SyBmb3Igb25lIHJ4IHBrdCB3aGljaCBvbmx5IG5l
ZWRzIDJLLCByaWdodD8NCg0KSSBndWVzcyBwZXJmb3JtYW5jZSB3b3VsZCBiZSB3b3JzZSB3aXRo
b3V0IHBhZ2UgY2FjaGUuDQpXZSBoYXZlIHRlc3RlZCBvbiB0aGUgbXRrIHByaXZhdGUgZHJpdmVy
LCA3JSBkcm9wIGluIHRocm91Z2hwdXQgd2hlbg0Kc2V0dGluZyB0aGUgNEsgcGFnZSBjYWNoZSBj
b21wYXJlZCB0byB0aGUgMzJLIHBhZ2UgY2FjaGUuDQphbmQgMTAlIGRyb3Agd2hlbiB1c2Ugc2xh
YiB0byBhbGxvY2F0ZSBidWZmZXIuDQoNCkEgc2luZ2xlIHBhZ2UgcGVyIHJ4IGJ1ZmZlciBtYXkg
Y2F1c2UgYSB0aHJvdWdocHV0IGRyb3Agb2Ygb3ZlciA3JSBhbmQNCndhc3RlIG1lbW9yeSwgd2hh
dCBkbyB5b3UgdGhpbms/DQoNClJlZ2FyZHMsDQpTdWp1YW4NCg0KPiBSZWdhcmRzLA0KPiBMb3Jl
bnpvDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9kbWEuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCj4g
aW5kZXggMjhhN2ZlMDY0MzEzLi4xZDllNTgwOTc3ZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9kbWEuYw0KPiBAQCAtNTgwLDYgKzU4MCwyMCBAQCBtdDc2X2Rt
YV90eF9xdWV1ZV9za2Ioc3RydWN0IG10NzZfZGV2ICpkZXYsDQo+IHN0cnVjdCBtdDc2X3F1ZXVl
ICpxLA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkICoNCj4gK210
NzZfZG1hX2dldF9yeF9idWYoc3RydWN0IG10NzZfcXVldWUgKnEpDQo+ICt7DQo+ICsJaWYgKChx
LT5mbGFncyAmIE1UX1FGTEFHX1dFRCkgJiYNCj4gKwkgICAgRklFTERfR0VUKE1UX1FGTEFHX1dF
RF9UWVBFLCBxLT5mbGFncykgPT0gTVQ3Nl9XRURfUV9SWCkgew0KPiArCQkvKiBXRUQgUlggcXVl
dWUgKi8NCj4gKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBkZXZfYWxsb2NfcGFnZSgpOw0KPiArDQo+
ICsJCXJldHVybiBwYWdlID8gcGFnZV9hZGRyZXNzKHBhZ2UpIDogTlVMTDsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXR1cm4gcGFnZV9mcmFnX2FsbG9jKCZxLT5yeF9wYWdlLCBxLT5idWZfc2l6ZSwgR0ZQ
X0FUT01JQyk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQNCj4gIG10NzZfZG1hX3J4X2ZpbGwo
c3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdCBtdDc2X3F1ZXVlICpxKQ0KPiAgew0KPiBAQCAt
NTk2LDcgKzYxMCw3IEBAIG10NzZfZG1hX3J4X2ZpbGwoc3RydWN0IG10NzZfZGV2ICpkZXYsIHN0
cnVjdA0KPiBtdDc2X3F1ZXVlICpxKQ0KPiAgCQlzdHJ1Y3QgbXQ3Nl9xdWV1ZV9idWYgcWJ1ZjsN
Cj4gIAkJdm9pZCAqYnVmID0gTlVMTDsNCj4gIA0KPiAtCQlidWYgPSBwYWdlX2ZyYWdfYWxsb2Mo
JnEtPnJ4X3BhZ2UsIHEtPmJ1Zl9zaXplLA0KPiBHRlBfQVRPTUlDKTsNCj4gKwkJYnVmID0gbXQ3
Nl9kbWFfZ2V0X3J4X2J1ZihxKTsNCj4gIAkJaWYgKCFidWYpDQo+ICAJCQlicmVhazsNCj4gIA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bW1pby5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbW1p
by5jDQo+IGluZGV4IDFhMmU0ZGY4ZDFiNS4uMjkyNGU3MWU0ZmJlIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tbWlvLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbW1pby5jDQo+IEBAIC01
OTQsMTMgKzU5NCw5IEBAIHN0YXRpYyB2b2lkDQo+IG10NzkxNV9tbWlvX3dlZF9vZmZsb2FkX2Rp
c2FibGUoc3RydWN0IG10a193ZWRfZGV2aWNlICp3ZWQpDQo+ICBzdGF0aWMgdm9pZCBtdDc5MTVf
bW1pb193ZWRfcmVsZWFzZV9yeF9idWYoc3RydWN0IG10a193ZWRfZGV2aWNlDQo+ICp3ZWQpDQo+
ICB7DQo+ICAJc3RydWN0IG10NzkxNV9kZXYgKmRldjsNCj4gLQl1MzIgbGVuZ3RoOw0KPiAgCWlu
dCBpOw0KPiAgDQo+ICAJZGV2ID0gY29udGFpbmVyX29mKHdlZCwgc3RydWN0IG10NzkxNV9kZXYs
IG10NzYubW1pby53ZWQpOw0KPiAtCWxlbmd0aCA9IFNLQl9EQVRBX0FMSUdOKE5FVF9TS0JfUEFE
ICsgd2VkLT53bGFuLnJ4X3NpemUgKw0KPiAtCQkJCXNpemVvZihzdHJ1Y3Qgc2tiX3NoYXJlZF9p
bmZvKSk7DQo+IC0NCj4gIAlmb3IgKGkgPSAwOyBpIDwgZGV2LT5tdDc2LnJ4X3Rva2VuX3NpemU7
IGkrKykgew0KPiAgCQlzdHJ1Y3QgbXQ3Nl90eHdpX2NhY2hlICp0Ow0KPiAgDQo+IEBAIC02MTAs
NyArNjA2LDcgQEAgc3RhdGljIHZvaWQgbXQ3OTE1X21taW9fd2VkX3JlbGVhc2VfcnhfYnVmKHN0
cnVjdA0KPiBtdGtfd2VkX2RldmljZSAqd2VkKQ0KPiAgDQo+ICAJCWRtYV91bm1hcF9zaW5nbGUo
ZGV2LT5tdDc2LmRtYV9kZXYsIHQtPmRtYV9hZGRyLA0KPiAgCQkJCSB3ZWQtPndsYW4ucnhfc2l6
ZSwgRE1BX0ZST01fREVWSUNFKTsNCj4gLQkJX19mcmVlX3BhZ2VzKHZpcnRfdG9fcGFnZSh0LT5w
dHIpLCBnZXRfb3JkZXIobGVuZ3RoKSk7DQo+ICsJCWZyZWVfcGFnZSh2aXJ0X3RvX3BhZ2UodC0+
cHRyKSk7DQo+ICAJCXQtPnB0ciA9IE5VTEw7DQo+ICANCj4gIAkJbXQ3Nl9wdXRfcnh3aSgmZGV2
LT5tdDc2LCB0KTsNCj4gQEAgLTYyMSwxMyArNjE3LDkgQEAgc3RhdGljIHUzMiBtdDc5MTVfbW1p
b193ZWRfaW5pdF9yeF9idWYoc3RydWN0DQo+IG10a193ZWRfZGV2aWNlICp3ZWQsIGludCBzaXpl
KQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfcnhibV9kZXNjICpkZXNjID0gd2VkLT5yeF9idWZfcmlu
Zy5kZXNjOw0KPiAgCXN0cnVjdCBtdDc5MTVfZGV2ICpkZXY7DQo+IC0JdTMyIGxlbmd0aDsNCj4g
IAlpbnQgaTsNCj4gIA0KPiAgCWRldiA9IGNvbnRhaW5lcl9vZih3ZWQsIHN0cnVjdCBtdDc5MTVf
ZGV2LCBtdDc2Lm1taW8ud2VkKTsNCj4gLQlsZW5ndGggPSBTS0JfREFUQV9BTElHTihORVRfU0tC
X1BBRCArIHdlZC0+d2xhbi5yeF9zaXplICsNCj4gLQkJCQlzaXplb2Yoc3RydWN0IHNrYl9zaGFy
ZWRfaW5mbykpOw0KPiAtDQo+ICAJZm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykgew0KPiAgCQlz
dHJ1Y3QgbXQ3Nl90eHdpX2NhY2hlICp0ID0gbXQ3Nl9nZXRfcnh3aSgmZGV2LT5tdDc2KTsNCj4g
IAkJZG1hX2FkZHJfdCBwaHlfYWRkcjsNCj4gQEAgLTYzNSw3ICs2MjcsNyBAQCBzdGF0aWMgdTMy
IG10NzkxNV9tbWlvX3dlZF9pbml0X3J4X2J1ZihzdHJ1Y3QNCj4gbXRrX3dlZF9kZXZpY2UgKndl
ZCwgaW50IHNpemUpDQo+ICAJCWludCB0b2tlbjsNCj4gIAkJdm9pZCAqcHRyOw0KPiAgDQo+IC0J
CXBhZ2UgPSBfX2Rldl9hbGxvY19wYWdlcyhHRlBfS0VSTkVMLA0KPiBnZXRfb3JkZXIobGVuZ3Ro
KSk7DQo+ICsJCXBhZ2UgPSBfX2Rldl9hbGxvY19wYWdlKEdGUF9LRVJORUwpOw0KPiAgCQlpZiAo
IXBhZ2UpDQo+ICAJCQlnb3RvIHVubWFwOw0KPiAgDQo+IEBAIC02NDQsNyArNjM2LDcgQEAgc3Rh
dGljIHUzMiBtdDc5MTVfbW1pb193ZWRfaW5pdF9yeF9idWYoc3RydWN0DQo+IG10a193ZWRfZGV2
aWNlICp3ZWQsIGludCBzaXplKQ0KPiAgCQkJCQkgIHdlZC0+d2xhbi5yeF9zaXplLA0KPiAgCQkJ
CQkgIERNQV9UT19ERVZJQ0UpOw0KPiAgCQlpZiAodW5saWtlbHkoZG1hX21hcHBpbmdfZXJyb3Io
ZGV2LT5tdDc2LmRldiwNCj4gcGh5X2FkZHIpKSkgew0KPiAtCQkJX19mcmVlX3BhZ2VzKHBhZ2Us
IGdldF9vcmRlcihsZW5ndGgpKTsNCj4gKwkJCWZyZWVfcGFnZShwYWdlKTsNCj4gIAkJCWdvdG8g
dW5tYXA7DQo+ICAJCX0NCj4gIA0KPiBAQCAtNjUzLDcgKzY0NSw3IEBAIHN0YXRpYyB1MzIgbXQ3
OTE1X21taW9fd2VkX2luaXRfcnhfYnVmKHN0cnVjdA0KPiBtdGtfd2VkX2RldmljZSAqd2VkLCBp
bnQgc2l6ZSkNCj4gIAkJaWYgKHRva2VuIDwgMCkgew0KPiAgCQkJZG1hX3VubWFwX3NpbmdsZShk
ZXYtPm10NzYuZG1hX2RldiwgcGh5X2FkZHIsDQo+ICAJCQkJCSB3ZWQtPndsYW4ucnhfc2l6ZSwN
Cj4gRE1BX1RPX0RFVklDRSk7DQo+IC0JCQlfX2ZyZWVfcGFnZXMocGFnZSwgZ2V0X29yZGVyKGxl
bmd0aCkpOw0KPiArCQkJZnJlZV9wYWdlKHBhZ2UpOw0KPiAgCQkJZ290byB1bm1hcDsNCj4gIAkJ
fQ0KPiAgDQo=
