Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CEB722240
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjFEJd2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 05:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFEJdX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 05:33:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B82BD
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 02:33:14 -0700 (PDT)
X-UUID: fb6b586a038311ee9cb5633481061a41-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vnMhPhygyvb2yKmm28c6ufuQz7A/bb5a2zp0O1NDaQA=;
        b=cS+DbNz0yXzvOYbkotW5FnmwJ/eK3qh0kyKP8+7NMBmBhq3zcrGcS35giTsoEHLDVA7s+l8TV+wDE9qBE7lV7uZbJ7pqEQX5wejrS0QBS1SyTNLwtbpopIWh9S+3Q/SCpFy90uwKVKVh1K3iJrrpx1ir1AA0suOS5lwuRk7X+JM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ec7b4cfe-9dea-4a1c-bded-f46aaba047a8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:bcfc0e6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: fb6b586a038311ee9cb5633481061a41-20230605
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 658320678; Mon, 05 Jun 2023 17:33:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 17:33:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 17:33:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcSvjmVRQhPsAVesirz/wnQX6YAQBUWT3fkgKoXd4YzDptU2IdG7vy3VdqhvGf1f5t3h8LNmOem2aGdZVIi6UcLnMohKcw5SWXUDnf8nC1h/XQOMyBlsLAdorlb2Z1B6EQFQfkH+yduu7nuMxQ2VDM4Lg7rzJ+12A5VKLSwaBlEJ09O/QyWOWdE5gaqneWAjAoQ1U0qhPD6wdu+rBOAt6knZdQCha51LzGL4twMEVtVpGHryWResh4Qz/BalaNU0im6y8TCdxhVXzV4d3x8yT01WlMtwZT4zHb8+OnKxhaPZHsnGQ58AUChTc1pqMPutS8TR1zj5KE1M9bYpk7BGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnMhPhygyvb2yKmm28c6ufuQz7A/bb5a2zp0O1NDaQA=;
 b=XxrscrchRJSeKwE32qFrYPTaJ5CF13B4GulxSsIPg2bRJD1pH4bFDOsCshIS1571AnT+WsjHLnGYBQVmV5ahxei+PxvINPohBAych0Y9C6dWIKYrrjUMcqSjlW/GmX5qWwpyNE14kld7cZ8OkTvMZxICE1m7hOtr+KQHVUtnhB/USkT/VpAQmMjlToPINHD1sVhoZLyLkm1SeQhW1jGNDineECVnxuhoR51XjeAvCwVtbboJQn2R/TJ6PVUmlRkgVh1ktnSgHf8ITmZwfNSpCwnqP+0HtqtCEJMZwHgPFf+3nhcR2a6EWk5hhQgYSJvvbnlEMCikaUSGt72lXpuRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnMhPhygyvb2yKmm28c6ufuQz7A/bb5a2zp0O1NDaQA=;
 b=MrMI/thqZ7Kl+OChr6FRMAiYwKoVzxE0bOmdBJVC0zfA0u0AMMVRgbfW6yhrKP1SVuIM1qDvxvv8m6fuc9hgdFJ1oOcE2zZa+YPLmQ1nr606TkY1QCx7ACL4mdzxtNr3PjdImJxaboCQBqCMU4TAKn25RpoRj0eRFcqkVbwt1zc=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by TYSPR03MB7543.apcprd03.prod.outlook.com (2603:1096:400:410::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Mon, 5 Jun
 2023 09:33:05 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::662b:189f:a0dd:6734]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::662b:189f:a0dd:6734%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:33:05 +0000
From:   shayne.chen@mediatek.com
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        =?utf-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= 
        <Chui-hao.Chiu@mediatek.com>
Subject: Re: [PATCH v2 02/10] wifi: mt76: connac: add support for dsp firmware
 download
Thread-Topic: [PATCH v2 02/10] wifi: mt76: connac: add support for dsp
 firmware download
Thread-Index: AQHZl4ahLyQodEW8EUuxBFeOh5ILZq974yKAgAAPRQA=
Date:   Mon, 5 Jun 2023 09:33:05 +0000
Message-ID: <8bf15819e81358e4dbc747206e3048c96ef73cbc.camel@mediatek.com>
References: <20230605081947.12804-1-shayne.chen@mediatek.com>
         <20230605081947.12804-2-shayne.chen@mediatek.com>
         <ZH2fAWYfp2rdurwT@lore-desk>
In-Reply-To: <ZH2fAWYfp2rdurwT@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|TYSPR03MB7543:EE_
x-ms-office365-filtering-correlation-id: 3b49b196-abc8-4d9f-7368-08db65a7dd85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRRY6fkq2Vl77g5y7Y+S99gzx6JbsUjp01swEaCCdQV5+dDkF1ABJ/54ri8ixaT5f21P7lrPM7taDrWLhe+WdrU9HbAzgCjW2lq4YH+6QhuTBkm9G6Gg304oHjEZVXI1Zg9Y0th6h1pZ0bfajh96GUpnMHUg1xL4liQ3lZp6BJOXhybEKchk8MgiyLeiJNxHfFH9f6+YNyceLLb4rNLsFyKQfMctJkLKvBCs8yiemHrGwJCsgWiJJSAVp1YEUTuwhbWsIWTdornUB0TJ41V8c1o36mWHp/3uHfYDOSr8CJwnEEOVqyLN729v1gPfZ48FgsTrREzK4WlAMDnGOeAuKDjO48L+uejvF9v2y10244WEAtGdhuuoauKHT3LtkEOy47xwcK3KZKxYc4MJU9WpNOgnKyZqBx83pcKOQXZmBm6Isl9jeHB8+n300XA6ojV3BYObmlFps1E4cBZOD+5i7H6jd8XQjKMa0vpbzKHm5qUXMlK8z5iO5jIxi3FtoPKAPE4Q1cWp07KOFZJZDIWjYPLyB2/qCSIX79gl/jW97UnQY52T8aJ0GJp+3Vir+UdHkKK7YvxP+KcHQPD8gNOt8eIUVvlVK6bTFzcjGO/lWxAkjLZZ3+avQ7BPqZj43XFA8CtZT3Fv6IZC4tUFoscItA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(478600001)(2906002)(86362001)(8936002)(5660300002)(54906003)(83380400001)(38100700002)(71200400001)(38070700005)(91956017)(76116006)(41300700001)(66446008)(66476007)(4326008)(66556008)(6916009)(66946007)(316002)(64756008)(8676002)(6486002)(36756003)(85182001)(107886003)(122000001)(6506007)(186003)(26005)(6512007)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTAwZDk0QTRGUW9aWkxhN3QzRXpMSFJURzBuS2habXdKNjBwVVJGYUtvVVVz?=
 =?utf-8?B?ZlpMbmQxUTBBclBzVDBIZ2JKazBVV3k1RTltVXlWLzI0NG1CT0d5M2NoYkZO?=
 =?utf-8?B?aXdrazQ5SThCbUE2UUlHVzZ6WURUZnJyRlBUQVBPczZkOE56VkJTcU5UN0pR?=
 =?utf-8?B?L2FDY01CL00xakp2T2xDSTlEQjZwQXJ0MUJONlVRQkt3cmRsYVl1c2cwWGVo?=
 =?utf-8?B?czBRWWQ0RXN3Vkx0ZGVialFwc0U0YzF6eC9FSnpjcWJLb3J2eGZJN1FQRTV1?=
 =?utf-8?B?TEJGbnRvbGFZQ1gvVWU0QXlqRU96ZWVza09kNTUwNWJETWJFMzQzNGY4aWFy?=
 =?utf-8?B?ZzQrVUl2Y0VJS2N3eVNjUkF5Qys2dTUwcUlPcko3WlAvMjFMajFjYUtZeHdR?=
 =?utf-8?B?aWlMWHBVZkRTN1BEKytZOVVpcE13ckQvMy9uNDV1VGh6V21VWTRrbWZZa3lo?=
 =?utf-8?B?WmZocFpVdWUwOHE3ZlVuTkErRXZEaDB6R0JxSFZMcTJkdEpDZ2ZUYmVuTHVE?=
 =?utf-8?B?QmlzQnF0eHNlN0phMFE3aHVMMDBYT1BkVklVK0RJYzlVMFdrbk1lTlZYeW9K?=
 =?utf-8?B?alJFeWdjVTZLSlloN3B0NGZtREIwM2ZMWEx5RTZaL2hEbU9aSkpsQ3cvYk5J?=
 =?utf-8?B?Mm5OY3Z1MVdEeFREWjErZDFRYXoyR2RCNERJSlR5cURWQXJxWWlJUmV5Vm5H?=
 =?utf-8?B?a3Z3Syt1OGJaTkVQZnBGMjdPUzE5OFRZM3RuNVRmQnpxYTNCMG54SVpzb1NZ?=
 =?utf-8?B?a2FwR0tmZWRncjdTVzFWeDdDR2hUSnZ6dldJT3FIQ1VWeHFucnFwcURHWU43?=
 =?utf-8?B?Zzd5NWdIN2VJWjBjNWFHZS9yQ0lpMW9EYm1waTg4b2pFYkdFZlhDd21OdmFQ?=
 =?utf-8?B?MTZ5ZEJROUdwMnFsUTkvbytJMXdyR0taeG5pd2EvZ1dHT0l0TWo2dVpXUXEx?=
 =?utf-8?B?Q3pOZDZhenhRbzBpQXVLSzllbnk4ckJKeFdia1hPZTI4Q3FtQmRuRGJoaUdR?=
 =?utf-8?B?a1Z6K1NiSGNZY2g5eXZyMmxaa3FFbU9ycTdtOE5ZVXZNU0pEYTFIY0kvNGxP?=
 =?utf-8?B?TE5PeC9zN3lieTEwTEdBdGpDU2MzSU84d1haanh3UWZsK2dxeVBSTGRBWGRu?=
 =?utf-8?B?WFgxdS8yZWFuNUN6SDBSZEFGWDQ5RUxSU1cyNUg2OGtyV21SMjNmWXdOOFJs?=
 =?utf-8?B?ckpnTXBtdHhtRXUzaEVnTUQzSHdRNFl3V2xtQXl1bW9DL0s1SFlRS0NZVktN?=
 =?utf-8?B?VWNQQjZJLy9ERmxLYU9nN29ERjdtNlhDcFhiN0Rhcm5GTlhQNDU1TE5jZnVI?=
 =?utf-8?B?aERZMUNmQzMyU2xPS2RPUjhGK0NSWEk3V2htK0gycG1pTFdrU0RvRGRQdk9x?=
 =?utf-8?B?N2ZraGZiOVBEWlZ4THQ5cHhpRU9hV2g1YTRFdkpORnhES3oyeWg1ck40eHRZ?=
 =?utf-8?B?SllVS05XNmRYbVg0Z0tYNTFkbSsxUTYveWcxYlBBRGtJZTBqZzRTUHU2YmN6?=
 =?utf-8?B?Y2Z1M0ZUZ1JiMWw0NE5ZWmdzNFBBOGk4bmNxbnMvMGo0eWhYUTRjdWppdlda?=
 =?utf-8?B?andDRm5lQlNzZXRybjRXTHpMbmdWR3dSNElOenVaMWUwQmdGYlFLY0RySFdQ?=
 =?utf-8?B?ZnZ5WmVFWXlGN09EUmVOMUlnVnJhSWVmSTViTjZnRVpQWnhVdUt1Qmp6SHUr?=
 =?utf-8?B?RnA2ajBrbEVwcDBJSlRsZlplR3F4eEhoeVdJVjRiSkZvWTNxT2FIRDRKQnJV?=
 =?utf-8?B?MTJGQkE0eDA0Nnp0dmFyWjBnUXdoM2JkV2lqa2VNRXNFT2RqWVVJd1VwdWln?=
 =?utf-8?B?NWNXT2ZrNkRnWlN3ajNmeWVPSzlUM2pWNXNITUwwc216YXV4N3JkdXVaZUgx?=
 =?utf-8?B?bVVpSHhmeGJXNEJCenl2NmQ4c21FUFNTWjhjTEorV1p6US9zZHZNNUc3R0RP?=
 =?utf-8?B?NnlReXV1RzZSVWZ6MThZb2hQMnN5L0hGMW92YjlnM0tWa3JlNStpUGhsL2FV?=
 =?utf-8?B?SG4vTnMvNmJBY25uMWZDNzY0UEVmY2R6Vi8vZWFUd3Nma3MwWVdBb0RVUU9i?=
 =?utf-8?B?Yy9oOEpBNlQxdVQ0OFhNSXB2eW9PNGZmbi9uVTZWS3VBUkszckpIWG5Lells?=
 =?utf-8?B?Wk1lZWVEMldiS21OdkhaK3FLeHF4dlQxV3R0M3BsL0h4TGFuZk1kTE0wK0VX?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <185E6551D31FAF40A6272DEB73018B28@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b49b196-abc8-4d9f-7368-08db65a7dd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:33:05.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuJg6emCpFQGZPq9fmADvrCou73Z0eDqf/WBxDKXi2rZOqP2eQ196iE+8nOJM27ZFN5SrixpuYjzde5xqdCm/HvtU2pBqVjPjROOEF4P9Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7543
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDEwOjM4ICswMjAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IFBldGVyIENoaXUgPGNodWktaGFvLmNoaXVAbWVkaWF0ZWsuY29tPg0KPiA+
IA0KPiA+IEFkZCBGV19TVEFSVF9XT1JLSU5HX1BEQV9EU1AgZm9yIHRoZSBpbmRpY2F0aW9uIG9m
IHN0YXJ0aW5nIERTUA0KPiA+IGZpcm13YXJlIGRvd25sb2FkLCB3aGljaCBpcyBmb3IgcGh5LXJl
bGF0ZWQgY29udHJvbC4NCj4gPiBUaGUgZmlybXdhcmUgaXMgdHJhbnNwYXJlbnQgdG8gdGhlIGRy
aXZlciwgYnV0IGl0J3MgbmVjZXNzYXJ5IGZvcg0KPiA+IHRoZQ0KPiA+IGZpcm13YXJlIGRvd25s
b2FkIHByb2Nlc3MuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUu
Y2hlbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1o
YW8uY2hpdUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNo
YXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAgIC0gbWVyZ2Ug
dHdvIGNvbW1pdHM6DQo+ID4gICAgIC0gd2lmaTogbXQ3NjogY29ubmFjOiBhZGQgYSBzZXR0aW5n
IGJpdCBmb3IgZHNwIGZpcm13YXJlDQo+ID4gICAgIC0gd2lmaTogbXQ3NjogbXQ3OTk2OiBhZGQg
ZHNwIGZpcm13YXJlIGRvd25sb2FkDQo+ID4gICAtIG1vdmUgbWFpbiBjb2RlIGZvciBsb2FkaW5n
IHJhbSB0byBhIHJlZ3VsYXIgZnVuY3Rpb24NCj4gPiAtLS0NCj4gPiAgLi4uL3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmggIHwgIDEgKw0KPiA+ICAuLi4vbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L21jdS5jICAgfCA3MCArKysrKysrKystLS0tDQo+ID4g
LS0tLS0tDQo+ID4gIC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaCAg
ICB8ICA3ICsrDQo+ID4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvcGNp
LmMgICB8ICAxICsNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAzNiBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuaA0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuaA0KPiA+IGluZGV4IGNhMWNlOTdhNmQy
Zi4uNGEyMWMyMzdlYTZlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5oDQo+ID4gQEAgLTIyLDYgKzIyLDcg
QEANCj4gPiAgDQo+ID4gICNkZWZpbmUgRldfU1RBUlRfT1ZFUlJJREUJCUJJVCgwKQ0KPiA+ICAj
ZGVmaW5lIEZXX1NUQVJUX1dPUktJTkdfUERBX0NSNAlCSVQoMikNCj4gPiArI2RlZmluZSBGV19T
VEFSVF9XT1JLSU5HX1BEQV9EU1AJQklUKDMpDQo+ID4gIA0KPiA+ICAjZGVmaW5lIFBBVENIX1NF
Q19OT1RfU1VQUE9SVAkJR0VOTUFTSygzMSwgMCkNCj4gPiAgI2RlZmluZSBQQVRDSF9TRUNfVFlQ
RV9NQVNLCQlHRU5NQVNLKDE1LCAwKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gPiBpbmRleCA4OGUyZjlkMGU1MTMuLjI4
OTMwNjkzYTc1YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210Nzk5Ni9tY3UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTk2L21jdS5jDQo+ID4gQEAgLTIxNTUsNyArMjE1NSw3IEBAIHN0YXRpYyBp
bnQgbXQ3OTk2X2xvYWRfcGF0Y2goc3RydWN0DQo+ID4gbXQ3OTk2X2RldiAqZGV2KQ0KPiA+ICBz
dGF0aWMgaW50DQo+ID4gIG10Nzk5Nl9tY3Vfc2VuZF9yYW1fZmlybXdhcmUoc3RydWN0IG10Nzk5
Nl9kZXYgKmRldiwNCj4gPiAgCQkJICAgICBjb25zdCBzdHJ1Y3QgbXQ3OTk2X2Z3X3RyYWlsZXIg
KmhkciwNCj4gPiAtCQkJICAgICBjb25zdCB1OCAqZGF0YSwgYm9vbCBpc193YSkNCj4gPiArCQkJ
ICAgICBjb25zdCB1OCAqZGF0YSwgZW51bSBtdDc5OTZfcmFtX3R5cGUgdHlwZSkNCj4gPiAgew0K
PiA+ICAJaW50IGksIG9mZnNldCA9IDA7DQo+ID4gIAl1MzIgb3ZlcnJpZGUgPSAwLCBvcHRpb24g
PSAwOw0KPiA+IEBAIC0yMTY3LDggKzIxNjcsMTAgQEAgbXQ3OTk2X21jdV9zZW5kX3JhbV9maXJt
d2FyZShzdHJ1Y3QNCj4gPiBtdDc5OTZfZGV2ICpkZXYsDQo+ID4gIA0KPiA+ICAJCXJlZ2lvbiA9
IChjb25zdCBzdHJ1Y3QgbXQ3OTk2X2Z3X3JlZ2lvbiAqKSgoY29uc3QgdTgNCj4gPiAqKWhkciAt
DQo+ID4gIAkJCSAoaGRyLT5uX3JlZ2lvbiAtIGkpICogc2l6ZW9mKCpyZWdpb24pKTsNCj4gPiAr
CQkvKiBEU1AgYW5kIFdBIHVzZSBzYW1lIG1vZGUgKi8NCj4gPiAgCQltb2RlID0gbXQ3Nl9jb25u
YWNfbWN1X2dlbl9kbF9tb2RlKCZkZXYtPm10NzYsDQo+ID4gLQkJCQkJCSAgIHJlZ2lvbi0+ZmVh
dHVyZV9zZXQsIA0KPiA+IGlzX3dhKTsNCj4gPiArCQkJCQkJICAgcmVnaW9uLT5mZWF0dXJlX3Nl
dCwNCj4gPiArCQkJCQkJICAgdHlwZSAhPQ0KPiA+IE1UNzk5Nl9SQU1fVFlQRV9XTSk7DQo+ID4g
IAkJbGVuID0gbGUzMl90b19jcHUocmVnaW9uLT5sZW4pOw0KPiA+ICAJCWFkZHIgPSBsZTMyX3Rv
X2NwdShyZWdpb24tPmFkZHIpOw0KPiA+ICANCj4gPiBAQCAtMjE5NSwxOSArMjE5NywyMiBAQCBt
dDc5OTZfbWN1X3NlbmRfcmFtX2Zpcm13YXJlKHN0cnVjdA0KPiA+IG10Nzk5Nl9kZXYgKmRldiwN
Cj4gPiAgCWlmIChvdmVycmlkZSkNCj4gPiAgCQlvcHRpb24gfD0gRldfU1RBUlRfT1ZFUlJJREU7
DQo+ID4gIA0KPiA+IC0JaWYgKGlzX3dhKQ0KPiA+ICsJaWYgKHR5cGUgPT0gTVQ3OTk2X1JBTV9U
WVBFX1dBKQ0KPiA+ICAJCW9wdGlvbiB8PSBGV19TVEFSVF9XT1JLSU5HX1BEQV9DUjQ7DQo+ID4g
KwllbHNlIGlmICh0eXBlID09IE1UNzk5Nl9SQU1fVFlQRV9EU1ApDQo+ID4gKwkJb3B0aW9uIHw9
IEZXX1NUQVJUX1dPUktJTkdfUERBX0RTUDsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gbXQ3Nl9jb25u
YWNfbWN1X3N0YXJ0X2Zpcm13YXJlKCZkZXYtPm10NzYsIG92ZXJyaWRlLA0KPiA+IG9wdGlvbik7
DQo+ID4gIH0NCj4gPiAgDQo+ID4gLXN0YXRpYyBpbnQgbXQ3OTk2X2xvYWRfcmFtKHN0cnVjdCBt
dDc5OTZfZGV2ICpkZXYpDQo+ID4gK3N0YXRpYyBpbnQgX19tdDc5OTZfbG9hZF9yYW0oc3RydWN0
IG10Nzk5Nl9kZXYgKmRldiwgY29uc3QgY2hhcg0KPiA+ICpmd190eXBlLA0KPiA+ICsJCQkgICAg
IGNvbnN0IGNoYXIgKmZ3X2ZpbGUsIGVudW0gbXQ3OTk2X3JhbV90eXBlDQo+ID4gcmFtX3R5cGUp
DQo+ID4gIHsNCj4gPiAgCWNvbnN0IHN0cnVjdCBtdDc5OTZfZndfdHJhaWxlciAqaGRyOw0KPiA+
ICAJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdzsNCj4gPiAgCWludCByZXQ7DQo+ID4gIA0KPiA+
IC0JcmV0ID0gcmVxdWVzdF9maXJtd2FyZSgmZncsIE1UNzk5Nl9GSVJNV0FSRV9XTSwgZGV2LT5t
dDc2LmRldik7DQo+ID4gKwlyZXQgPSByZXF1ZXN0X2Zpcm13YXJlKCZmdywgZndfZmlsZSwgZGV2
LT5tdDc2LmRldik7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIA0K
PiA+IEBAIC0yMjE3LDQ4ICsyMjIyLDQxIEBAIHN0YXRpYyBpbnQgbXQ3OTk2X2xvYWRfcmFtKHN0
cnVjdA0KPiA+IG10Nzk5Nl9kZXYgKmRldikNCj4gPiAgCQlnb3RvIG91dDsNCj4gPiAgCX0NCj4g
PiAgDQo+ID4gLQloZHIgPSAoY29uc3Qgc3RydWN0IG10Nzk5Nl9md190cmFpbGVyICopKGZ3LT5k
YXRhICsgZnctPnNpemUgLQ0KPiA+IHNpemVvZigqaGRyKSk7DQo+ID4gLQ0KPiA+IC0JZGV2X2lu
Zm8oZGV2LT5tdDc2LmRldiwgIldNIEZpcm13YXJlIFZlcnNpb246ICUuMTBzLCBCdWlsZA0KPiA+
IFRpbWU6ICUuMTVzXG4iLA0KPiA+IC0JCSBoZHItPmZ3X3ZlciwgaGRyLT5idWlsZF9kYXRlKTsN
Cj4gPiArCWhkciA9IChjb25zdCB2b2lkICopKGZ3LT5kYXRhICsgZnctPnNpemUgLSBzaXplb2Yo
KmhkcikpOw0KPiA+ICsJZGV2X2luZm8oZGV2LT5tdDc2LmRldiwgIiVzIEZpcm13YXJlIFZlcnNp
b246ICUuMTBzLCBCdWlsZA0KPiA+IFRpbWU6ICUuMTVzXG4iLA0KPiA+ICsJCSBmd190eXBlLCBo
ZHItPmZ3X3ZlciwgaGRyLT5idWlsZF9kYXRlKTsNCj4gPiAgDQo+ID4gLQlyZXQgPSBtdDc5OTZf
bWN1X3NlbmRfcmFtX2Zpcm13YXJlKGRldiwgaGRyLCBmdy0+ZGF0YSwgZmFsc2UpOw0KPiA+ICsJ
cmV0ID0gbXQ3OTk2X21jdV9zZW5kX3JhbV9maXJtd2FyZShkZXYsIGhkciwgZnctPmRhdGEsDQo+
ID4gcmFtX3R5cGUpOw0KPiA+ICAJaWYgKHJldCkgew0KPiA+IC0JCWRldl9lcnIoZGV2LT5tdDc2
LmRldiwgIkZhaWxlZCB0byBzdGFydCBXTQ0KPiA+IGZpcm13YXJlXG4iKTsNCj4gPiArCQlkZXZf
ZXJyKGRldi0+bXQ3Ni5kZXYsICJGYWlsZWQgdG8gc3RhcnQgJXMgZmlybXdhcmVcbiIsDQo+ID4g
ZndfdHlwZSk7DQo+ID4gIAkJZ290byBvdXQ7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICtvdXQ6DQo+
ID4gIAlyZWxlYXNlX2Zpcm13YXJlKGZ3KTsNCj4gPiAgDQo+ID4gLQlyZXQgPSByZXF1ZXN0X2Zp
cm13YXJlKCZmdywgTVQ3OTk2X0ZJUk1XQVJFX1dBLCBkZXYtPm10NzYuZGV2KTsNCj4gPiAtCWlm
IChyZXQpDQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiAtDQo+ID4gLQlpZiAoIWZ3IHx8ICFmdy0+
ZGF0YSB8fCBmdy0+c2l6ZSA8IHNpemVvZigqaGRyKSkgew0KPiA+IC0JCWRldl9lcnIoZGV2LT5t
dDc2LmRldiwgIkludmFsaWQgZmlybXdhcmVcbiIpOw0KPiA+IC0JCXJldCA9IC1FSU5WQUw7DQo+
ID4gLQkJZ290byBvdXQ7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JaGRyID0gKGNvbnN0IHN0cnVj
dCBtdDc5OTZfZndfdHJhaWxlciAqKShmdy0+ZGF0YSArIGZ3LT5zaXplIC0NCj4gPiBzaXplb2Yo
KmhkcikpOw0KPiA+IC0NCj4gPiAtCWRldl9pbmZvKGRldi0+bXQ3Ni5kZXYsICJXQSBGaXJtd2Fy
ZSBWZXJzaW9uOiAlLjEwcywgQnVpbGQNCj4gPiBUaW1lOiAlLjE1c1xuIiwNCj4gPiAtCQkgaGRy
LT5md192ZXIsIGhkci0+YnVpbGRfZGF0ZSk7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+
ID4gIA0KPiA+IC0JcmV0ID0gbXQ3OTk2X21jdV9zZW5kX3JhbV9maXJtd2FyZShkZXYsIGhkciwg
ZnctPmRhdGEsIHRydWUpOw0KPiA+IC0JaWYgKHJldCkgew0KPiA+IC0JCWRldl9lcnIoZGV2LT5t
dDc2LmRldiwgIkZhaWxlZCB0byBzdGFydCBXQQ0KPiA+IGZpcm13YXJlXG4iKTsNCj4gPiAtCQln
b3RvIG91dDsNCj4gPiAtCX0NCj4gPiArc3RhdGljIGludCBtdDc5OTZfbG9hZF9yYW0oc3RydWN0
IG10Nzk5Nl9kZXYgKmRldikNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiAgDQo+ID4gLQlz
bnByaW50ZihkZXYtPm10NzYuaHctPndpcGh5LT5md192ZXJzaW9uLA0KPiA+IC0JCSBzaXplb2Yo
ZGV2LT5tdDc2Lmh3LT53aXBoeS0+ZndfdmVyc2lvbiksDQo+ID4gLQkJICIlLjEwcy0lLjE1cyIs
IGhkci0+ZndfdmVyLCBoZHItPmJ1aWxkX2RhdGUpOw0KPiANCj4gZG9pbmcgc28gd2UgZG8gbm90
IGFkdmVydGlzZSBmdyB2ZXJzaW9uIHRocm91Z2ggZXRodG9vbCBhcyBiZWZvcmUuDQo+IA0KPiA+
ICsjZGVmaW5lIExPQURfUkFNKF90eXBlKSBcDQo+ID4gKwlkbyB7CQkJCQkJCQkNCj4gPiBcDQo+
ID4gKwkJcmV0ID0gX19tdDc5OTZfbG9hZF9yYW0oZGV2LCAjX3R5cGUsCQkJDQo+ID4gXA0KPiA+
ICsJCQkJCU1UNzk5Nl9GSVJNV0FSRV8jI190eXBlLAlcDQo+ID4gKwkJCQkJTVQ3OTk2X1JBTV9U
WVBFXyMjX3R5cGUpOwlcDQo+ID4gKwkJaWYgKHJldCkJCQkJCQlcDQo+ID4gKwkJCXJldHVybiBy
ZXQ7CQkJCQlcDQo+ID4gKwl9IHdoaWxlICgwKQ0KPiA+ICANCj4gPiAtb3V0Og0KPiA+IC0JcmVs
ZWFzZV9maXJtd2FyZShmdyk7DQo+ID4gKwlMT0FEX1JBTShXTSk7DQo+ID4gKwlMT0FEX1JBTShE
U1ApOw0KPiA+ICsJTE9BRF9SQU0oV0EpOw0KPiANCj4gY2FuIHlvdSBwbGVhc2UgcnVuIHRoZSBm
dW5jdGlvbiBkaXJlY3RseSBpbnN0ZWFkIG9mIHVzaW5nIG1hY3Jvcz8NCj4gDQo+IFJlZ2FyZHMs
DQo+IExvcmVuem8NCg0KSGkgTG9yZW56bywNCg0KV2lsbCBhZGQgDQo+IA0KPiA+ICsjdW5kZWYg
TE9BRF9SQU0NCj4gPiAgDQo+ID4gLQlyZXR1cm4gcmV0Ow0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
IH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gPiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2L210Nzk5Ni5oDQo+ID4gaW5kZXggNGQ3ZGNi
OTVhNjIwLi43ZGZkYzczODQwNTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbXQ3OTk2LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzk5Ni9tdDc5OTYuaA0KPiA+IEBAIC0yOSw2ICsyOSw3
IEBADQo+ID4gIA0KPiA+ICAjZGVmaW5lIE1UNzk5Nl9GSVJNV0FSRV9XQQkJIm1lZGlhdGVrL210
Nzk5Ni9tdDc5OTZfd2EuYmluIg0KPiA+ICAjZGVmaW5lIE1UNzk5Nl9GSVJNV0FSRV9XTQkJIm1l
ZGlhdGVrL210Nzk5Ni9tdDc5OTZfd20uYmluIg0KPiA+ICsjZGVmaW5lIE1UNzk5Nl9GSVJNV0FS
RV9EU1AJCSJtZWRpYXRlay9tdDc5OTYvbXQ3OTk2DQo+ID4gX2RzcC5iaW4iDQo+ID4gICNkZWZp
bmUgTVQ3OTk2X1JPTV9QQVRDSAkJIm1lZGlhdGVrL210Nzk5Ni9tdDc5OTZfcm9tX3BhdA0KPiA+
IGNoLmJpbiINCj4gPiAgDQo+ID4gICNkZWZpbmUgTVQ3OTk2X0VFUFJPTV9ERUZBVUxUCQkibWVk
aWF0ZWsvbXQ3OTk2L210Nzk5Ng0KPiA+IF9lZXByb20uYmluIg0KPiA+IEBAIC01Miw2ICs1Mywx
MiBAQCBzdHJ1Y3QgbXQ3OTk2X3N0YTsNCj4gPiAgc3RydWN0IG10Nzk5Nl9kZnNfcHVsc2U7DQo+
ID4gIHN0cnVjdCBtdDc5OTZfZGZzX3BhdHRlcm47DQo+ID4gIA0KPiA+ICtlbnVtIG10Nzk5Nl9y
YW1fdHlwZSB7DQo+ID4gKwlNVDc5OTZfUkFNX1RZUEVfV00sDQo+ID4gKwlNVDc5OTZfUkFNX1RZ
UEVfV0EsDQo+ID4gKwlNVDc5OTZfUkFNX1RZUEVfRFNQLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAg
ZW51bSBtdDc5OTZfdHhxX2lkIHsNCj4gPiAgCU1UNzk5Nl9UWFFfRldETCA9IDE2LA0KPiA+ICAJ
TVQ3OTk2X1RYUV9NQ1VfV00sDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTk2L3BjaS5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210Nzk5Ni9wY2kuYw0KPiA+IGluZGV4IDY0YWVlM2ZiNTQ0NS4uYzUzMDEw
NTBmZjhiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTk2L3BjaS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5OTYvcGNpLmMNCj4gPiBAQCAtMjE5LDQgKzIxOSw1IEBAIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUocGNpLA0KPiA+IG10Nzk5Nl9wY2lfZGV2aWNlX3RhYmxlKTsNCj4gPiAgTU9EVUxFX0RF
VklDRV9UQUJMRShwY2ksIG10Nzk5Nl9oaWZfZGV2aWNlX3RhYmxlKTsNCj4gPiAgTU9EVUxFX0ZJ
Uk1XQVJFKE1UNzk5Nl9GSVJNV0FSRV9XQSk7DQo+ID4gIE1PRFVMRV9GSVJNV0FSRShNVDc5OTZf
RklSTVdBUkVfV00pOw0KPiA+ICtNT0RVTEVfRklSTVdBUkUoTVQ3OTk2X0ZJUk1XQVJFX0RTUCk7
DQo+ID4gIE1PRFVMRV9GSVJNV0FSRShNVDc5OTZfUk9NX1BBVENIKTsNCj4gPiAtLSANCj4gPiAy
LjM5LjINCj4gPiANCg==

