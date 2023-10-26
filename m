Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388827D7B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 05:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJZD6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 23:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZD6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 23:58:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C1B9
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 20:58:14 -0700 (PDT)
X-UUID: e0f23aa873b311eea33bb35ae8d461a2-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RPT0EXN7nvboOT3LBws0pbVLp0Zn+Cje+eDlY5WRttI=;
        b=ReWYkizcw+ghHF7qEp7VSLVd66WNExjcBtIpF7o790ZtiOM7QRo8E4E+1sm6/tOmWEO0iOjCEJwa9djSXf9YHOvwfNtL+QFqJGXVQxHOQTkkwcGn51ow/Cu7MtgkwzD6HUx1Jjk4K+9pTPTDQzpguieoN+Wntpu7DZHzHDmSEe4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f0fe5d9d-9071-4dce-8d90-5f82bdd06cec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:746ded28-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e0f23aa873b311eea33bb35ae8d461a2-20231026
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2126469563; Thu, 26 Oct 2023 11:58:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 11:58:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 11:58:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBUaa1XpQW0uV52fjY3KJkpIYXPdD/MSp7bBLl/lSdcpwPphYNsiNg+GG/hO8Ac6sU+F9caEkWNfhyVYP/S9JiennGTRecmDVXEJ6zM3e0O2XLr1An8QObkuFVjQd/jsWfPsAG6gMh+SP67ZnIlEnL3mX3pdq9p9L1PRq0BN03PQh7YM9crnefjpz2k3zPMGHh+KFbKxTvkYDVnTN2MWqJXNboPBV7l0QhWODXyYqvJuJp416s3OVriPIPaysbtNPjhnvDkrYC4Y8rCkqjvvRtS8p6X3NAmGxN0so16gk9UN4YUslCvwwKlCdHZyyb7yOmhbtcXlj9AAqXMXdGSC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPT0EXN7nvboOT3LBws0pbVLp0Zn+Cje+eDlY5WRttI=;
 b=AzaAicQjGxWVzFUxmBKhgJa8jTdSaGFYkvYlWZtSMi0lFBYfmzXOIlH74/YrCT7aUGYaB6YmEEtSUZ64GergK9tQxfiJpdxhSYnnyo/p6o2z+b2Gg4ojyJM+g2QpHpqJdJxauZLYVTJ5js1ySUFpqP0tFUjNIh3RTE8z62lakJjCo7E05F6qJzX/fPSZcY53JhRhB7WSDdZNilSx7aEkKNlXlSSqX95PlVdlkxHjUNJ+8Yb+6rc219duMoizDjJ9ssPVKsohoOIp2PfSUROWXomTbhf1dQRMlO1aOpEjmMWWnhvLcxdhPNJa3b8fSKKj/jGvzQMGGbJgRAryIIVj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPT0EXN7nvboOT3LBws0pbVLp0Zn+Cje+eDlY5WRttI=;
 b=h1Ohd23FIyyA925CuhFVhz1tq0sqCzNEtC5tKuAK2Hz7tt5DMDjA4hAG2igJkjlHWQFGFa4sPhNYk1fx7XCMHFttxN4VVpjBk6wsT84Z30xI692x8tIE8Z8jdEVZIbE/PuC+TtvWedLrY9WW8Pr5qaDXjVC8J6M/y63BC4ur0bI=
Received: from KL1PR03MB6199.apcprd03.prod.outlook.com (2603:1096:820:83::12)
 by PUZPR03MB5849.apcprd03.prod.outlook.com (2603:1096:301:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 03:58:07 +0000
Received: from KL1PR03MB6199.apcprd03.prod.outlook.com
 ([fe80::be2e:d78d:fe7d:1a0]) by KL1PR03MB6199.apcprd03.prod.outlook.com
 ([fe80::be2e:d78d:fe7d:1a0%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 03:58:07 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "greearb@candelatech.com" <greearb@candelatech.com>
CC:     =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= 
        <Mingyen.Hsieh@mediatek.com>
Subject: Re: Regression wireless-next: mt7921: update the channel usage when
 the regd domain changed
Thread-Topic: Regression wireless-next: mt7921: update the channel usage when
 the regd domain changed
Thread-Index: AQHaB75QuY+HY7yxA06RDJcuBh2PULBbccMA
Date:   Thu, 26 Oct 2023 03:58:07 +0000
Message-ID: <e0afaea7118b742d695fc0ef19e04ff0cb6a902f.camel@mediatek.com>
References: <2fb78387-d226-3193-8ca7-90040561b9ad@candelatech.com>
In-Reply-To: <2fb78387-d226-3193-8ca7-90040561b9ad@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6199:EE_|PUZPR03MB5849:EE_
x-ms-office365-filtering-correlation-id: 687d8ad4-f2db-4b5d-7753-08dbd5d7c329
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjWy8tQPy7pNOsMp6zUOYDBgfooONp65FmL+nBWT4/h/XauUcbqEhp/mmiqT1ro0gB+j2cJ/3c+LLXBOciV96+8S/uBlbn6HGFXiNBm3uupCckJ75JYFZ9hbl36W8jTHfBzrFvjocoMWJBxMZzP+kAe7QCOHYiwsDZx8L7xIR9aUEFPlN0kVkg+5GV7sPONhz1bKptyriKY76uFnd6Ns9uyM3TmNNmPAQix5Gh8RGpeCArlrobDX78rjrpMpvlFqxrYShxurLuOC7e40FB0NnrmOs6BBuPXyANiDTXFFMqyCI00EGi0RuAsU0T6otuLoQ7pPk2ViiDsfCGGejiGojjC0HCYhldfkZ6SVWUex832IkRGfs69X35PhxP1SGzbdR9nMHaIktnfqiH76S8Oxslsba+PbevxnB9RZplyDqoTGc1YWAHttZv38Y2dluJwkUFefSNBuaUCmv2Fi1X0WJ/PYkToaBvxUGVBZp2OtWneP5vtSrYTkETZ3h+Q1noNgGFRiibjLGN3JYL0A9lRzZVW2q6YUnm//ChJNsqBLwAUQ1nhNzt65QXBRUZSeoXiPb3m/KdXRW0Iun96fsViDtIxp1EBxotIJ9lVbUAvXRNJCK1FIQPfewK0IwXeSqFt6D/6u+CWTwa7mniGbSjObqrQ+Y1HSOIeHghFHStYwkvk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38070700009)(107886003)(2616005)(91956017)(110136005)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(316002)(26005)(122000001)(478600001)(6486002)(6506007)(71200400001)(6512007)(41300700001)(38100700002)(15650500001)(4001150100001)(86362001)(2906002)(5660300002)(36756003)(4326008)(83380400001)(85182001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDRRb3d5UXBhTGZ6bW9pOUpEaEJFZ1ZLVURQSHVYQkN4d0kvL0tkdWVYSEtZ?=
 =?utf-8?B?ZUF1N2Y5MVJFNUNrTnZpMEZsOVFzeUwzOTUrS2lCOVIybENWMzVUY1FGdjRx?=
 =?utf-8?B?djI3a0NjZlNQVDZ4UldENzRJc1I4SHZLeW4ybmhoaFhzUExKdWptMVZjRnJI?=
 =?utf-8?B?bTZpcmhtV0NiWnk1bXZ2RCtqZFRSa3FCRy9PekRQNnEzUDJ6RHhlY3lScnRP?=
 =?utf-8?B?VUxjYmVLcTV1K1lIZE9lak1DWHZsWVZ3U3JPbDEzTlJvNDJCbFFtTVhzdnJ5?=
 =?utf-8?B?Wm5kKy92amYyMm4rakkrTHlkaHd1eVlWbWpqaTliRjVITDQvcVpMaUxHVXdo?=
 =?utf-8?B?aU5VamlmZ0xGV3FLME1mdUpHM3VMNnpPT0FBMUJCY0FBelNVeDFoaFljclI5?=
 =?utf-8?B?TlhWeHhqbTdaYXM2QWVaRzk5V1Q2d04rVmRGYWJ3enJURmNRamZJZ2hHT0tF?=
 =?utf-8?B?YzJIVytvbnN4aXlSRGNYSml4VUk2dWJvZ2M5UFk3a1hZdC9qQWtGZXpCMlI3?=
 =?utf-8?B?SVg0b0xGQlIvYU1DS2haTHBTNzBUajZwV2pnQ2lHRGZsbk5Ybkt0QnU1RFU3?=
 =?utf-8?B?dld3M216NTNIR0lKRG8zMGRPYkUzUVlmMDdpUHBKMzJCYnlpamV6d3cwcDhJ?=
 =?utf-8?B?Y01nd1R3TFNIelQ3S0NLOE9SSDRXbkRQZFhIV1k0elhIZ0pnVlgwcTRPelUx?=
 =?utf-8?B?b2Nhby9WeDFyM01aMXUySVJ5Wm9VQ3doSzU0RzZpM0lMSVZxd3Q2Y2RLdDFv?=
 =?utf-8?B?ZmhzOGIvKzQzbi9OSS9ubkhER0d3MXlMTSt5L21zQUVCYkN2QjMzVnBOYjJl?=
 =?utf-8?B?ZEo2NC9MelJmNXFOQ25hWlhOelV6UFVPNEtlMjhXYVZCZnpzSUlzb1V5S29F?=
 =?utf-8?B?WWRhKzN0UndiQWN0aFlsTlBPTWNVTnYzQnNsMlZQWEZ1VTVNL3BwNmkxTUlz?=
 =?utf-8?B?TGFQbXFBUmVkS04xanFlZHJ1RmlMZXpCTi9iSU5aYzYzbW9lVGNBK3BPTXZ3?=
 =?utf-8?B?dVI3VXBzUUhmQzhqR2dVYzhhUHBtc0VmTllPT1FKWGhIb3h3eFRLNHZMSTVL?=
 =?utf-8?B?Y1hmU25velpSd1ovNFpDdmpqU3RZT0FKV0hoNXVCREhrWTdmZ0R6c3pUbkoy?=
 =?utf-8?B?QXlaajVoTnlYOHA1bHJTdytkSWRyaXdvSGF1Y1NnR3BkZTF0ZkhXVGhJK0Nr?=
 =?utf-8?B?VEpEMjZ3REU1ajlWWFFMd1llMHRoQVVYYnkrYjZhYVBpdWducjBWbWdyNG5z?=
 =?utf-8?B?RXg0d3JrdEROUGx3RlJKN0NtZHZnSmFpZUY3ZW9aWEVIaU1rTTV2Nkdnb0NH?=
 =?utf-8?B?SmJSbjAwc2FFL0t0T1VQeVBrbTd1RTBzMWdMK1kybndSdCtiOVQ5VDFqL0da?=
 =?utf-8?B?S00yQ1MrVGRwV1VIU2x5Tm81cXpoK2RUQUxjUndaaEgwRlFTQzk5eGRCRWRK?=
 =?utf-8?B?N0JBMjJmdXg2QitsNkJJNVpZTFp1dkhnSXNLU0VNK0g0czJHdmM5czZwMW9z?=
 =?utf-8?B?SzFSa3hIVlJjem1rWkhsWHl0Tnk5ZDRVOXMzUGtsZ3FXNEd2dG1od25WUXEr?=
 =?utf-8?B?dlo3V1pSSzArRE93TW80encrY1hHaTJ0ZkdQN1dvZmxpTGg2VCtncWxXb2pS?=
 =?utf-8?B?T0ZPNW90SkhxSCtwQkdTeEtwWVZpanIraHhUUXZQWUdqb0RWa2lIWEo0d0NR?=
 =?utf-8?B?RHcyYThEbHNaMmc1NDZXNHIrZktjWG5JTCtUYk93dnJndzNHZlVTVHBsQWlB?=
 =?utf-8?B?YWVXZFQrQWtmdWlmQXFZMVltTk9yRWtHcjdsOWE5d1ZHcFFOb0V1Q04rRWdn?=
 =?utf-8?B?VTNNZ0t4REhsSVhkWk5QdCtpMDJCOUp5djcvN3pIN2JGSWQwK2EzRFBveDlY?=
 =?utf-8?B?VHNVZDI2WVJNQ1VVWjRlcnl5YUZ0SmJOa0s0SEV1c1hJSUdhS2hYWUdPbGtC?=
 =?utf-8?B?bmVUdGEzWW9Tdlljb3Y2SS9OUVllMm41WjRYWmlZNkNnR3lEekcrZ1A3K0pi?=
 =?utf-8?B?WUpMbGVUdnhaeWNWRHZhYWovQUF0OTZrTmFieGZEeURWZWd4dkR0YW5DQUNy?=
 =?utf-8?B?UWlGRGlXcFVVN3VTT2t6TEQyaVZ0S1UrSzlFeVIxd1lHNlp2UWFiSFdWRUk0?=
 =?utf-8?B?dm5YeUFCRHF4dTE2Q0pTRmR3Z2lvNXY2RnZyeERoZU5HM0c4NzhxRlRmRGQr?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <463B663F653AC346A145DE0435D5FD66@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687d8ad4-f2db-4b5d-7753-08dbd5d7c329
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 03:58:07.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqCg14FMaU5pv3kZFYiWOUjIHrY4jRck+Wup6w3eW4c8MNVDQu3ZSW5bgJOj9xNwZki5HNgBbY2shOtOhPqDgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQmVuLA0KDQpPbiBXZWQsIDIwMjMtMTAtMjUgYXQgMDk6MDUgLTA3MDAsIEJlbiBHcmVlYXIg
d3JvdGU6DQo+IEkgbm90aWNlZCBtdDc5MjIgcmFkaW9zIHdvdWxkIG5vIGxvbmdlciBlbmFibGUg
NmUgYmFuZCBpbiB3aXJlbGVzcy0NCj4gbmV4dC4NCj4gDQo+IE15IHRlc3Qgc3lzdGVtIGhhcyBJ
bnRlbCByYWRpb3MgYW5kIG10NzkyMiByYWRpb3MgaW4gaXQuICBJIGJpc2VjdGVkDQo+IHRvIHRo
ZSBjb21taXQNCj4gYmVsb3cuICBJdCBsb29rcyBsaWtlIHRoYXQgcGF0Y2ggY2FuIGRpc2FibGUg
NmUgYmFzZWQgb24gcmVnZG9tDQo+IGNoYW5nZSwgYnV0IGNhbm5vdA0KPiBlbmFibGUgNmUgYWdh
aW4gaW4gY2FzZSByZWdkb20gY2hhbmdlcyBiYWNrIHRvIHNvbWV0aGluZyB0aGF0DQo+IHN1cHBv
cnRzIDZlLg0KPiANCj4gSW50ZWwgdHJpLWJhbmQgcmFkaW9zIGRpc2FibGUgNmUgYnkgZGVmYXVs
dCwgdGhlbiBlbmFibGUgaXQgYWZ0ZXINCj4gc2Nhbm5pbmcNCj4gVVMgcmVnZG9tIGJlYWNvbnMu
ICBNYXliZSB0aGF0IHJlZ2RvbSBjaGFuZ2luZyBieSBJbnRlbCBoZWxwcyBicmVhaw0KPiB0aGUg
bXQ3OTIyDQo+IHdpdGggdGhlIGJlbG93IHBhdGNoIGFwcGxpZWQ/DQoNClRoYW5rcyBmb3IgdGhl
IHJlcG9ydC4gVGhlcmUgaXMgYSBjYXBhYmlsaXR5IGNoZWNrIG1pc3NlZC4gQ291bGQgeW91DQpw
bGVhZSBoZWxwIHRvIGNoZWNrIHRoaXMgcGF0Y2g/IExldCdzIG1ha2Ugc3VyZSB5b3UgcnVuIGlu
dG8gdGhlIHNhbWUNCnByb2JsZW0uDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMNCmIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5jDQppbmRleCA1NWJhYWM3MDg2MGIuLmE3MzhlYTk1MTEw
ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIx
L2luaXQuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEv
aW5pdC5jDQpAQCAtNjksNiArNjksOSBAQCBtdDc5MjFfcmVnZF9jaGFubmVsX3VwZGF0ZShzdHJ1
Y3Qgd2lwaHkgKndpcGh5LA0Kc3RydWN0IG10NzkyeF9kZXYgKmRldikNCiAgICAgICAgc3RydWN0
IGllZWU4MDIxMV9jaGFubmVsICpjaDsNCiAgICAgICAgaW50IGksIGNmcmVxOw0KDQorICAgICAg
IGlmICghKGRldi0+cGh5LmNoaXBfY2FwICYgTVQ3OTJ4X0NISVBfQ0FQX0NMQ19FVlRfRU4pKQ0K
KyAgICAgICAgICAgICAgIGRldi0+cGh5LmNsY19jaGFuX2NvbmYgPSAweGZmOw0KKw0KICAgICAg
ICBucCA9IG10NzZfZmluZF9wb3dlcl9saW1pdHNfbm9kZShtZGV2KTsNCg0KICAgICAgICBzYmFu
ZCA9IHdpcGh5LT5iYW5kc1tOTDgwMjExX0JBTkRfNUdIWl07DQoNClRoYW5rcywNCkRlcmVuDQoN
Cj4gDQo+IGNvbW1pdCAwOTM4MmQ4Zjg2NDFiYzEyZmZmYzQxYTkzZWI5YjM3YmUwZTY1M2MwDQo+
IEF1dGhvcjogTWluZyBZZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiBE
YXRlOiAgIFNhdCBTZXAgMzAgMTA6MjU6MDkgMjAyMyArMDgwMA0KPiANCj4gICAgICB3aWZpOiBt
dDc2OiBtdDc5MjE6IHVwZGF0ZSB0aGUgY2hhbm5lbCB1c2FnZSB3aGVuIHRoZSByZWdkDQo+IGRv
bWFpbiBjaGFuZ2VkDQo+IA0KPiAgICAgIFRoZSA1LjkvNkdIeiBjaGFubmVsIGxpY2Vuc2Ugb2Yg
YSBjZXJ0YWluIHBsYXRmb3JtIGRldmljZSBoYXMNCj4gYmVlbg0KPiAgICAgIHJlZ3VsYXRlZCBp
biB2YXJpb3VzIGNvdW50cmllcy4gVGhhdCBtYXkgYmUgZGlmZmVyZW5jZSB3aXRoDQo+IHN0YW5k
YXJkDQo+ICAgICAgTGl1bnggcmVndWxhdG9yeSBkb21haW4gc2V0dGluZ3MuIEluIHRoaXMgY2Fz
ZSwgd2hlbg0KPiAucmVnX25vdGlmaWVyKCkNCj4gICAgICBjYWxsZWQgZm9yIHJlZ3VsYXRvcnkg
Y2hhbmdlLCBtdDc5MnggY2hpcHNldCBzaG91bGQgdXBkYXRlIHRoZQ0KPiBjaGFubmVsDQo+ICAg
ICAgdXNhZ2UgYmFzZWQgb24gY2xjIG9yIGR0cyBjb25maWd1cmF0aW9ucy4NCj4gDQo+ICAgICAg
Q2hhbm5lbCB3b3VsZCBiZSBkaXNhYmxlZCBieSBmb2xsb3dpbmcgY2FzZXMuDQo+ICAgICAgKiBj
bGMgcmVwb3J0IHRoZSBwYXJ0aWN1bGFyIFVOSUkteCBpcyBkaXNhYmxlZC4NCj4gICAgICAqIGR0
cyBlbmFibGVkIGFuZCB0aGUgY2hhbm5lbCBpcyBub3QgY29uZmlndXJlZC4NCj4gDQo+ICAgICAg
U2lnbmVkLW9mZi1ieTogTWluZyBZZW4gSHNpZWggPG1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29t
Pg0KPiAgICAgIENvLWRldmVsb3BlZC1ieTogRGVyZW4gV3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNv
bT4NCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBEZXJlbiBXdSA8ZGVyZW4ud3VAbWVkaWF0ZWsuY29t
Pg0KPiAgICAgIFNpZ25lZC1vZmYtYnk6IEZlbGl4IEZpZXRrYXUgPG5iZEBuYmQubmFtZT4NCj4g
DQo+IFRoYW5rcywNCj4gQmVuDQo+IA0K
