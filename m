Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B738269C483
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 04:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBTDf4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Feb 2023 22:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBTDfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Feb 2023 22:35:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F4C17A
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 19:35:48 -0800 (PST)
X-UUID: a6443d0eb0cf11ed945fc101203acc17-20230220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7Lj74L6P2CwlZDDzcwp2SvLbQLSmOKpx2KjbOyhddC8=;
        b=Swo6r3mtd/ANEBy3Bhirbh8S+toTI754mov+op5vHOiR5zTs7d7FLZQB1HfWgRln8ojLdIno6iefj60MnlJ61poUtYCQ245IXAZEUNo8aRR7QROvDaXU19rmiSxFDXogS/fcIGpkvGZnoVURKJfrnL8iRDrPNr2rE1NFyW05F38=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:34578a13-15df-4180-9640-76e4ac7ffb97,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:4b2cf2b0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: a6443d0eb0cf11ed945fc101203acc17-20230220
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 32434400; Mon, 20 Feb 2023 11:35:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 20 Feb 2023 11:35:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 20 Feb 2023 11:35:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYl7ldXJg7L+Fnkpzb6jvmkWBTUpMrybtJ+WZkUzl2poFWC9Wpo9uNlssWazIV4wNP/nVgwnvoaob6lA6DyIBNj//iica3Zai/gM1P2oKhhXPegLMjh1/w2WCgdlXHtClUxO33pdLhjcaYDSrMtbwV6QoLQoNwsKPOIoy/8aFL2ScaclOefJoDzz1NU8wFCiU2TSDPO1Im1wqJXFZFjWKl0nPNoP70Ff9ht+T1V8HDqoSlzJ1drUmaHWIoOtMGTvke+2D4YdxQvHdiSWfYbzSjq9EmYOAEdiZH3eJmiCc9C/nv/vjq9YRqs+5uKiPMOIeml1RZenkhl+AdPV/+FIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lj74L6P2CwlZDDzcwp2SvLbQLSmOKpx2KjbOyhddC8=;
 b=AeMRn6RSTyiJdHGwT1XSZVgGc/03ho1PVX+hwUziVehWXZ/h1uT80TRUvziA+o+QlMjTsNwuQ4dVQzmG0i764+kEEn/oqWmrwJtkPxLXE2tbRAREP7iqVu8o0n5/36SSmDCKKJJARZOm8DXB+uFghGzxcFrOvI2jPIIxvl9VkxCKNVTX6z/B2hm2bA3CDQDmx2dEnXDBS1Iq3tt4+1a1PqtS2fJcVRT8IGCGYOqYkssUuf7mwE3K6geO9neoN9rV4YGZHZ9cku2zYkH3b13IVHeOkdBaeUNNaFjfABRAcCg0NLTDc//ko9GP1YTPTM3GrWJvRGx/GKI7Ixf42pZ/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lj74L6P2CwlZDDzcwp2SvLbQLSmOKpx2KjbOyhddC8=;
 b=La2Y0YMdrTyPAWklt9ecePn2d8I3OtKCcRE+9tz8S5+Oso7vj+0xDmFfxDjm6e0TOssNAPx0qujklUQj/3ytUOArSIMl8U22QYIu/ApKtE6KchFwXxOgOwcm9PF7+/BYjnmywjqhfWZnA+YN2MpHUg/hmLJPC2NCYUzoarwInrM=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SG2PR03MB6229.apcprd03.prod.outlook.com (2603:1096:4:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Mon, 20 Feb
 2023 03:35:38 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%9]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 03:35:38 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
Thread-Topic: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
Thread-Index: AQHZQvhNg/XMHPbh9UaJA+rO7kUbpq7TbbAAgAALzICAAALQgIAAAn+AgAOo34CAAAswgA==
Date:   Mon, 20 Feb 2023 03:35:37 +0000
Message-ID: <ed37dd9cfba8d0ec7b50f932742156aaa57843e9.camel@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
         <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
         <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
         <fb3ab2d925fdeae2e7cc778419c1476102b9f85f.camel@sipsolutions.net>
         <56190740441a6740e9edf761ab2167edc51f20c3.camel@mediatek.com>
         <c05a8b20b5d4429b1c42ef2398ff2bf760bd7eae.camel@mediatek.com>
In-Reply-To: <c05a8b20b5d4429b1c42ef2398ff2bf760bd7eae.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SG2PR03MB6229:EE_
x-ms-office365-filtering-correlation-id: 93cb6874-6e31-418e-190b-08db12f3888f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /l5pYWKEW8eOfcHlzTHXfLnOXT12MJJ8ZB6QCR6J1DTOua7z9AwvIi9BpM82QbhdiSsdK+PWqv57Bvc+NXtrB4t6/6BvupFyGRH5957Txk9VaBYwoNiK7qaeQZA13Zzwaspfq5pBQfuMvOZDMlQ/Z55/D8DbYqTtBZGZ/vHDS8SsY6DGVMZTTVN0P8Mko5RWqL0EyUpG4zBek53H4Erbazw6J5a9G6qXjOzbNYtvf5QTL6/1/Hy+mv/DdSSUEqguwfgn1A61QvlELFvtUCEB6+rXaGevwHv/n1vPkQ5B9KXemsuF5oCL41/JvAK40mTThtVPjf0OKuD47bQHW+URgaZEYSjOtGaGImEbJPsvlsHtvvp+KhvxlO4+GDMvaYm7CMOHWThK81skOsIItEGKHkoFaRwgKudPpb9cMODK1IWl1p0cvp+9C6nTaC1T5IPZgtNBjMaq3E7sp3cgVgHnfyYGCkMwAHzYtrwYrAP0AdfoDQHj6h0gTiCJ+JU5/KPmWgxO/DEQN7n9XbeDrDWt+i3y869JjX2ZlN7fE7EbIOph4ib7YjxO8vBA5YhLKHgVBB1o57DHI6CYbG16S5PMkmbP5kd5bFKpm7RYk8SDVBpTueK3s8qf+JSs05x/6caOTX/4P4fIbFGiypAw4ykM9lTSj1DkEhZtJgysrpHTR5ds49k+h66ntCHiZIskw3vA0wV5+FKjljOFrcdILV/kpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199018)(2906002)(71200400001)(5660300002)(8936002)(6486002)(6512007)(38070700005)(4326008)(316002)(122000001)(66446008)(76116006)(8676002)(66556008)(91956017)(66946007)(6916009)(64756008)(36756003)(54906003)(66476007)(41300700001)(6506007)(478600001)(186003)(2616005)(38100700002)(26005)(107886003)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTg1NWhkMkc5RHQrWEhWeHljVE1sKzRpeGJvQUcvRVFvV2cvUjl5WUd1TVlQ?=
 =?utf-8?B?NHZEK29uR0Z5eDluT0x0MndVR01od0pDMXJhMnhISlVBZ0RSUmZiZmVUcSs1?=
 =?utf-8?B?Y014VW1YWTNLS3NDL2cwY0krYU9zYnZXV1NORGcyKytiNk5QajJrWFlMNnBw?=
 =?utf-8?B?ZWlLcnloVm8xL05BbnBzUWhnU1ptMU9Za3N0M3BudHpPWE5GZmNUZ0lvbjVx?=
 =?utf-8?B?UVR4eGNKemFmQUhubUJsdTRaanlaWDE4QTlkZURERFJzMXlTTUNqeERWRnVa?=
 =?utf-8?B?ZDE4NkIwaEdWZllsRWVXRjVVdUFsYSt6NVpnVVlCeGhldHdJNlV1TWNsay9q?=
 =?utf-8?B?TFpMbzlmV20xcml5aVkzU3JxbHF2dEszazl4TGVBUjl2SWhPOUdjTVp5UVlJ?=
 =?utf-8?B?cUhyam9CQzAzUGpEVUdpalYzZ3lkdUw2bERMekFoMXZRcWgwdzB4T2o0TlRp?=
 =?utf-8?B?aGQxTkFiM1B3ckdkRmpzUzd4NVhGYXhCd3QxV3pUQWNCa3lkRmtUYlNHVmRu?=
 =?utf-8?B?alJ6TnNpL1Vkdkp6TkFaTklCM1BLZkVmU0x0dnRLUTNCM2Q5ZmJzRlV6cVkv?=
 =?utf-8?B?aEQrZk9TMWMzeXhIN0Y3QzVncXFqaXBxMVF0NDVZZlpxQ0JKYkc5cVdmVTRP?=
 =?utf-8?B?bFJGN0ZLQXNBR3N3RlVScHJEN3R5L0M0R3ZtRkFJcTQ1WWpsb2J0bHpjSFN3?=
 =?utf-8?B?N0ZESVFadTFjMllScThTbFZpby8xQjRXY0o1bnF5UTdqMU5abFd6emh4NXl5?=
 =?utf-8?B?VGZsVW9UTG1QWXdKbklCTFhpVGFmdWErRjJQbXhJbG03K1pKZTFFdGtRK2E5?=
 =?utf-8?B?dklyYkpDMHRXWkNpbUVCbmhvYUpVL3lXRWs3aExvM2Rvay9mZlB4QXVqVklt?=
 =?utf-8?B?a2lTWFN4WjBINnNsVlRvRDNCUmRkeU81SStEcXM5ZVA5U0g4aklHMmExQndN?=
 =?utf-8?B?clp4UXppclpGVVYzbjJ1NlkwVDFhaDNiOTRwRWZEVDlIKzlUUkMxalVyMk5D?=
 =?utf-8?B?WDdBNCtjUmkyMGEyMmVYZS9xL25qT3VlUGVDenZ2RnVuTS96Y05tbU9yZ256?=
 =?utf-8?B?MmhxME5LQ25TemZJZDZVcXNXeFNTcGtyZDBJNStsbFk2aGFHNFk4K0o5TDN5?=
 =?utf-8?B?eml6SUxBVEk2TW40NFRqNkZYdHE3R2hQa3RVdnFrMzgyV3FBb3B0dlM2SWMr?=
 =?utf-8?B?akl6QXFUaEoxaUcwaDJ2OGhKN0NOUG1RNnZOLzI2SSsvVWR4WGFlMVpTalMw?=
 =?utf-8?B?SkdPZ0t6b2tOYzZrMVkwamtzWFZDaEpnTWJHWFVHVStwUHJOUW82WW9CUHVa?=
 =?utf-8?B?Uk44SUJLTi9mZUdCeUZLU3lXSjd2eDBSU2FjTzBHREl1L3hJNSs1RGZkTFNh?=
 =?utf-8?B?anhhMlU5UzRHWUIvK1NsY0hjZGlHMGEvOGtKOC9LUUkvbU9WZDhld3UySGdm?=
 =?utf-8?B?a0MvQlNJSUNPbFZoVkVwN0ZqN3paREdFdERLV3dNRnRjSFovcXpWWkkyUUNU?=
 =?utf-8?B?R1RaQ1g4K20zdEc1aFNqeWRFamNSdjV0K2UwRE4rNUg3ZjZaNklNT1FITXlm?=
 =?utf-8?B?cGd5VFRhL1hFN3l6TW92bVc0Y0tnOWNEWHl6OEUxeEVyL2pNUE5DMldsMmUw?=
 =?utf-8?B?M0kzSmNxY1MwcVlJVmROUFRJbHJXMk9hcjhDczNPRWNQRGVyQ3IwVEpINWUw?=
 =?utf-8?B?WUFQblo2YTBPSm5OOG5Tblc2czFjKzFyaUZpYUdBaFBWVXlwRi94MXUrSEtV?=
 =?utf-8?B?SVQyZ0UwN3hTZ1RXTDAxWnBEYjRNbWdzWitaWWNvZUJadXR6bUEvVEdRS3NV?=
 =?utf-8?B?Sm42K2NZL013M2Q0ZDJROVJucTQ0aDJRYk02NWp1WUE0Z2Q3YXhFNE1HaTNp?=
 =?utf-8?B?ZC8wYkNNaEh3T1FnVFBqQmFHb0ZKNXhMU1pLemlKZ2N2Q2JlVmd1MG9JMjNk?=
 =?utf-8?B?MVIySHlEbXcvVnNwaXBoSTVnb3BIRytRSjFFdVJCVUg2K1JPSUgxcjB2dGp0?=
 =?utf-8?B?TFhVZ3dqbmgwall0VmxIZkFKWW14VVYxUzZsVHQ1aXpHNWczSWEvLzRtRlcr?=
 =?utf-8?B?bGFUOHJnd2Jmak4zenFwWGl5bG9Ta2E1UjFib1ZvVWV0cHZnNG9HS1VqbnNl?=
 =?utf-8?B?QzNBeXVGeC9vN2NMTEtwcjlMSDkvbjJITVVKaVQ4OGNPR1hyQXc2a0pYSFJl?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D28BFC17860D6A4FB1C454AAC0E7C178@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cb6874-6e31-418e-190b-08db12f3888f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 03:35:38.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EziPxJeNlfVN7Gl1+p8uYk/P6Jaq7SwtSKRKG21q8OSV3DBfNgguXUDVKI+BeU5DMZ1WktNKKzyh6gQWkOzNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6229
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDAyOjU1ICswMDAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IE9u
IEZyaSwgMjAyMy0wMi0xNyBhdCAxOTowMiArMDAwMCwgUnlkZXIgTGVlIHdyb3RlOg0KPiA+IE9u
IEZyaSwgMjAyMy0wMi0xNyBhdCAxOTo1MyArMDEwMCwgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4g
PiA+IE9uIEZyaSwgMjAyMy0wMi0xNyBhdCAxODo0MyArMDAwMCwgUnlkZXIgTGVlIHdyb3RlOg0K
PiA+ID4gPiBPbiBGcmksIDIwMjMtMDItMTcgYXQgMTk6MDEgKzAxMDAsIEpvaGFubmVzIEJlcmcg
d3JvdGU6DQo+ID4gPiA+ID4gT24gU2F0LCAyMDIzLTAyLTE4IGF0IDAxOjUwICswODAwLCBSeWRl
ciBMZWUgd3JvdGU6DQo+ID4gPiA+ID4gPiBUaGlzIGFsbG93cyBsb3cgbGV2ZWwgZHJpdmVycyB0
byByZWZyZXNoIHRoZSB0eCBhZ2cgc2Vzc2lvbg0KPiA+ID4gPiA+ID4gdGltZXIsDQo+ID4gPiA+
ID4gPiBiYXNlZCBvbg0KPiA+ID4gPiA+ID4gcXVlcnlpbmcgc3RhdHMgZnJvbSB0aGUgZmlybXdh
cmUgdXN1YWxseS4gRXNwZWNpYWxseSBmb3INCj4gPiA+ID4gPiA+IHNvbWUNCj4gPiA+ID4gPiA+
IG10NzYNCj4gPiA+ID4gPiA+IGRldmljZXMNCj4gPiA+ID4gPiA+IHN1cHBvcnQgLm5ldF9maWxs
X2ZvcndhcmRfcGF0aCB3b3VsZCBieXBhc3MgbWFjODAyMTEsIHdoaWNoDQo+ID4gPiA+ID4gPiBs
ZWFkcw0KPiA+ID4gPiA+ID4gdG8gdHggQkENCj4gPiA+ID4gPiA+IHNlc3Npb24gdGltZW91dCBm
b3IgY2VydGFpbiBjbGllbnRzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
RG9lcyBpdCBldmVuIG1hdHRlcj8gV2UgY291bGQganVzdCByZXF1ZXN0IHNlc3Npb25zIHdpdGhv
dXQgYQ0KPiA+ID4gPiA+IHRpbWVvdXQNCj4gPiA+ID4gPiBpbg0KPiA+ID4gPiA+IHRoZSBmaXJz
dCBwbGFjZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgd2UncmUgYWxy
ZWFkeS4gT3VyIG1haW4gaXNzdWUgaXMgcGVyZm9ybWFuY2UNCj4gPiA+ID4gcGVyaW9kaWNhbGx5
DQo+ID4gPiA+IGRyb3BzDQo+ID4gPiA+IGV2ZXJ5IGZldyBzZWNvbmRzIHdoZW4gLm5ldF9maWxs
X2ZvcndhcmRfcGF0aCBpcyBlbmFibGVkLg0KPiA+ID4gPiBXaXJlbGVzcw0KPiA+ID4gPiBjbGll
bnQgaGF2ZSBub3JtYWwgNTAwKyBNYi9zIGlwZXJmMyBkb3dubG9hZCBzcGVlZCBmb3Igc2V2ZXJh
bA0KPiA+ID4gPiBzZWNvbmRzLg0KPiA+ID4gPiBUaGVuIGl0IGRyb3BzIGxlc3MgdGhhbiAxMDAg
TWIvcyBmb3Igc2V2ZXJhbCBzZWNvbmRzLiBUaGVuDQo+ID4gPiA+IGV2ZXJ5dGhpbmcNCj4gPiA+
ID4gcmVwZWF0cy4gSXNzdWUgb2NjdXJzIG9ubHkgb24gY2VydGFpbiBjbGllbnRzLiAoaS5lLiBJ
bnRlbA0KPiA+ID4gPiBjYXJkcw0KPiA+ID4gPiBBWDIwMCwNCj4gPiA+ID4gQVgxNjc1LCBBZHZh
bmNlZC1OIDYyMzUgaW4gV2luMTEpDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBTdHJhbmdlLiBC
dXQgaG93IGRvZXMgdGhpcyBwYXRjaCBkbyBhbnl0aGluZyBhYm91dCBpdCwgdGhhdA0KPiA+ID4g
c2hvdWxkDQo+ID4gPiBiZQ0KPiA+ID4gY29tcGxldGVseSBjbGllbnQgYWdub3N0aWM/DQo+ID4g
PiANCj4gPiA+IA0KPiA+IA0KPiA+IFNpbmNlIHRoZXJlJ3Mgbm8gYW55IGtlZXAgYWxpdmUgcGFj
a2V0IGJlaW5nIHJlY2VpdmVkIGJ5IGhvc3QNCj4gPiBzdGFjaywNCj4gPiBsZWFkcyB0byBtYWM4
MDIxMSBkZXN0cm9yeSBCQSBzZXNpb24uDQo+ID4gDQo+IA0KPiBNb3JlIHNwZWNpZmljYWxseSwg
dGhlIEJBIHNlc3Npb24gcmVsaWVzIG9uIGNsaWVudCBzaWRlJ3MgVHggZGF0YSB0bw0KDQpUeXBv
Li4uIEkgbWVhbiAqb3VyIHNpZGUqLiBTb21ldGhpbmcgbGlrZSB0aGlzDQoNCmllZWU4MDIxMV84
MDIzX3htaXQoKQ0KaWYgKHRpZF90eC0+dGltZW91dCkNCgl0aWRfdHgtPmxhc3RfdHggPSBqaWZm
aWVzOw0KUnlkZXINCg==
