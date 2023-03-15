Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8646BACEE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 11:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCOKDh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjCOKDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F65DDBC3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 03:01:47 -0700 (PDT)
X-UUID: 60fcd6f6c31811eda06fc9ecc4dadd91-20230315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lgXTx4enF6WTuFopDZLWu9/TzGywfS0OHVqcSFKv44g=;
        b=r0rQAhHXvRcT4nFW+bWTSpa2MqziYGrSZIGwb92BFyfg0eJj85XsqTJxiCTQW/QHtAHmAA3gbpYNyxrwa+oxzPk/tiAnmhK9tCSRR8T++S1Ay55Tw6F38NLGIQFzLTBh3oKFRJw/QGQXE0/ii/cS/8R79B/MtYINAx4YITElYtI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:7a8bab7d-9b45-4bdd-90fb-12eb5e6c9f96,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.21,REQID:7a8bab7d-9b45-4bdd-90fb-12eb5e6c9f96,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:83295aa,CLOUDID:ce2054b3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230315180140PI36BI18,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 60fcd6f6c31811eda06fc9ecc4dadd91-20230315
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 808549654; Wed, 15 Mar 2023 18:01:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 15 Mar 2023 18:01:38 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 15 Mar 2023 18:01:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1ENwpmhmyj2j4i0sptOTCIdjD+g9jc5yj6lcoq2Fk3pvbo4HwyGYl2L4uefZGyLIO9dKkyQBxtgnBy8v908aeL93kx5y8TVXDsxM2IC9x5kZRkQLrMFzd4ZDdRLC0ZV0PgxhTm4gHItiXVAYDCtTRsqNQoecHxAH/nOzS+k+YuNrqKcczv9IbhxWO5Mz4c9IlX+6XI12XRS5Rz45L32W0TAk4egUF/vQY2RxwjoQp8zka5r7gBo7nNFYRwhj3o1PcGjNrsZYoImQmLe4HX+kwjfNPNHCGlO8Y9fVSoaiG94903GglptFRXbR28HRKBHKSrVQ98XakZHUAw6uj15cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgXTx4enF6WTuFopDZLWu9/TzGywfS0OHVqcSFKv44g=;
 b=WEGis0jYGbTx02J6ZdSMPQU8k54Nerxpymn+VNfkf5ntKZY7SYwp30JGbuVcm/H2uTDw32dGFtn10lKaKNRkiBYfQpSDkRaoQ0nqaOuKR1Mxu20maL6+8KTCYCpU9+zISD525uoEimDsnA5lCjiD2Piwp6UyMhDnkgZbqcAAJ+bMccofFEipLoonwFpA2EtC+4bvzWvMAuxGZMnuM0HAKIjFwIUgZR+zFHdErRFl5hanlAZWaKtOAoZOGJBJJTrC/qzd3AKweijkZu2fzG4f7MucqqRq9efxQR95ATNXqFb6VAPl0Wr6cZXo88GpotIsjISPox8c6wQiyf39B8BDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgXTx4enF6WTuFopDZLWu9/TzGywfS0OHVqcSFKv44g=;
 b=eDQtt2v75xdcyxaRM5ib0wKd8RN00mPYawrzx56HLU3Ak1hFY7BMNsfhdCCsw0o6ZXdBcpmEqqkvbsA4cJEUFARs4hnQ/IaHqDdAjDq0n2k9KOOUZ8WG7jWoLCajZ3ztgiTXU+PmuHKMfkJezuwnhrJ2kC6HAt8V2QEhb2FHkro=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 10:01:36 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::a826:a86e:abc3:e552]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::a826:a86e:abc3:e552%6]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 10:01:36 +0000
From:   =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?= 
        <Michael-cy.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?= 
        <Michael-cy.Lee@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
Thread-Topic: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
Thread-Index: AQHZFeW7Ufe4GFzX60OkXD2JlsAcjK6kFeeAgFZLJwCAAARYgIAADRSAgAADGACAAajigA==
Date:   Wed, 15 Mar 2023 10:01:36 +0000
Message-ID: <629361853628dd817d9c3b3dffcc515216805d04.camel@mediatek.com>
References: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
         <277f8db1f790931aaac0f94ba0ea69efcb6ba3ac.camel@sipsolutions.net>
         <70f19f86043750c8f164c316496a8690709fc062.camel@mediatek.com>
         <386c21d475215c95966bbac6b0853e2715081789.camel@sipsolutions.net>
         <c9a31a6c06fe7a48df1d7871ac563b6f71cd4436.camel@mediatek.com>
         <6528ceb761b7be9862dfc5e404031e832f086cb3.camel@sipsolutions.net>
In-Reply-To: <6528ceb761b7be9862dfc5e404031e832f086cb3.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|TYZPR03MB7153:EE_
x-ms-office365-filtering-correlation-id: abe2c99c-e3af-46a8-4617-08db253c4357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5UyMfghgkfSGfM1aoa+ApAn9/RCaz0SJ33MbaQ8nOjj46Aa2imURXvciWYHLkJDIpPug6mXrpy9uRsYgLw77Qce+gcQgfKdd05hkVvaq8N/ECChIFumwjCy+clI4/VPi5tfKnlkQ5Y8UpZsv5dGpCPjbMLnIMOTyLn8QfB61SXtYjqXi2gD9kt8ZtFVGUU92pp1A1m7HMMbQyiZM3otdh407zY6cQscNqFCR2oH2H91sutOqfZ41TxvFuKvWbgXk7j5Mz2RYr7ZLugaob6AoOzjSSK/DeUIrUGobPCBxZtjIUXKSBqaCh5HzfgI9s9mrVStjLC7b/fY0KNKJxtoJ2CB/By0PEBYEnfiYW+bAhNhFlbLayNnCuERmN/p6uPvFeEmS9UTHgHSYFJz9e5sQwga7uAfIf2m7srOYKYilWCTdBqQot5vAFDceAkJSVc9m0QuLH8eskpGZsAz54BJimJOu6RQX6hWPL4JssUiVF5hy2+GC1g6X7renVc5JX7mIPiPwxQWFxV30NiH4Iyg4uptDHiqmwSUahWGCtJXaYpdndozRc+dg0aEe2OSlthh2YEfxHiX2kw8PFRSiE0CEXJyX80Z/70H+WJnE+eT1kxv2WtGayF18gyrDKnEbKussHaYbSnDLElZn1FR9+hUGg4SI6awQM9xFcpbwTtds0dF/+8mrBEzI8/yvs7DJrZE5889EBfU2poG0ixoX6AYbZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199018)(86362001)(38070700005)(85182001)(38100700002)(36756003)(122000001)(8936002)(2906002)(41300700001)(5660300002)(316002)(4326008)(6506007)(26005)(83380400001)(6512007)(110136005)(186003)(54906003)(2616005)(8676002)(66446008)(66476007)(66946007)(91956017)(6486002)(107886003)(64756008)(478600001)(71200400001)(66556008)(76116006)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blgwcnEzSEVmL0xtckxDNFhzd1FqZTRaQ05LazE2Z0o1YTRwL241MzZtN3hN?=
 =?utf-8?B?ekVQakdqYnljMkpFcWRFQjJPVTY4VHAvZ0RyT1hZWkVXYWdwN3d0ZEx4Y285?=
 =?utf-8?B?M3hGdE1hK2ZtUWVHL3VxbmpLOUR6cUFGbk5jcmJQR2pvME16N3pqTnhKTTFU?=
 =?utf-8?B?QlV0YTRMN2NpMVh2VEMxSWJtMFlkZnpsamdidlE5bm5lY3hVQytmckNsTVQr?=
 =?utf-8?B?MXJ0UnhQTS9mejRSeGdoWjhKNDNJSDgvYzNjajRIdnBrb0xGbmhUNUhHRWdn?=
 =?utf-8?B?TXB6T0l5OXA3NXlkU1p3WHo2a2Jhc1hTYXJUYnpoR3UzazRZYlZ6cndoQU0w?=
 =?utf-8?B?a0xhWVNxZ0V3dVVFejdiWkFBRWd3TGNrOTl4WXNwMERFZVl1VzR4Wk5scUZM?=
 =?utf-8?B?emxHWVc3ZUZFNCtOeDRtRzlzY3poaUdZWnptUlRNV2l6bnRpWkFJeStmcThZ?=
 =?utf-8?B?N2p6elJRWnZmYkNzME9WUXZUbWVJcmN4R0VMTUVxTGFGM0pUOWRLKzNMNWYy?=
 =?utf-8?B?ZjBSdTBHWTB4cjdxVUU4U2p1Z29XenVIYzh2WlhDdk5PVThEbjB6YXJ0b3Zn?=
 =?utf-8?B?ZTN3YS80bitKZm85Y0lNM3BxY0NIVzN4d1h1ZGd6cmFDN3MzQWYyRW81MEcw?=
 =?utf-8?B?SGpteVJxS2E4RWk5Q3FxYmo2U3pwcWVvUGloaDRKUHRxRHN5ZVdZSDdpZGRU?=
 =?utf-8?B?R0dSczc0bytuZjN3R3BYSlc2eGR4N1A3UWVuUkRic3JGeXFlNk56Nk1ZVWUx?=
 =?utf-8?B?ZEZKVTZRZXdlQlIxcmVCdEIzREViZFpBYSthekdFYmxzR2gxQ09UVm5Bb2U5?=
 =?utf-8?B?Um9hbHk2bzdCQnpYa2lQREw1MzVOK3RROTB3RDZxWXBwcnVWS0Z5cmlKdVRx?=
 =?utf-8?B?Ri9mUmdIajlHLzIyVWZvalVVZVpmUHQwN2NPOHZqQi9WVm1kZTVHSkdGSmVn?=
 =?utf-8?B?QVhUakxCMWdSdnJqcndyRk5CZlhkeFo1M1FsSGFDdVVyNjRaNEZoMHh1bnFq?=
 =?utf-8?B?K2ZHQkl1WXp3Zi9MaTNhaU9TZjQvTjF5Znh0MDljWk5YQXV2N2hGeGJGL2N3?=
 =?utf-8?B?eXpOdk14Vm4vdVdvNS84c21uZDVaTzJ2blVuU2lid2V0TzhnOGhrSXB4N3VV?=
 =?utf-8?B?YVE5V1c3dmlmd3ZMcU9oK3EzSGRoeGR3YUVQNk1pbVZ0MGl6WFZpMjBwLzQy?=
 =?utf-8?B?a09Cekl2RXNZbk51NTg3QndQa3pZazVrMHZKU3NVS3BCSktIc2thQXdOaWZy?=
 =?utf-8?B?K1pYSWs4WDNraFFOUWZ3SWQzTW9XcHM0Umt0MCtjbFFFYllnQXJWWWxvdFFJ?=
 =?utf-8?B?YkFIbllMNlRDTDcveVZkL2Jtd05zdTNCUWFpamJzL0lxQTdqUldYbGNWOERZ?=
 =?utf-8?B?cFgrbit0SkdvZjFaZHdRT1dIbGEyQXUyWXgxQWpUQ2hMWlBOZDVsSVYxOW9n?=
 =?utf-8?B?QTgyMkI2ZytQZVhScCtXVVUzSTNFN0pOQWZ0SzcyTzF5Vi9sS29DRHhNK1Jq?=
 =?utf-8?B?dER6Wm5BWitBakYzZUdmS0lEYmMzQnNpd0tRZHlEUGhvMlFuZVpoQWpjaTdS?=
 =?utf-8?B?NlJJT285NHJCeW1MUVMxRmRNNGZQTHVsREk0RXYyTlJnVHFJRkFSeldLTmt4?=
 =?utf-8?B?eG9ZOUVDKzhLaFdJdDIrYk5CajNtb0NUU2FZV252d21zUlB4M1ZtM2d2S1BP?=
 =?utf-8?B?RzZ3eGpsT2w0UDJ3VytQUzFEUFgrbWx3RzV1Q2o4NEFjc2tkV3JlM2JyNXdn?=
 =?utf-8?B?TGk2eGtsYnhiK2pxK0M4NUpmUXZ6cXBreGlldFJuWWg5cGNKbmlKdWFlaGVL?=
 =?utf-8?B?cnd5SjRvNHNVaUZRZzhSTklxK2dLaGlpK29UaGZqOFdrdEdCeDR0aG1UUzFG?=
 =?utf-8?B?Q3g4YkhJeHR3Qi9lM21ncjFxN1JBOCtYV2k3VUp6SlhGUFVWdXYyNk5LbWwx?=
 =?utf-8?B?ditPRmRhN3VCcnZJZmZFL2VjNjd3U2cvR05Hcmg4YXlKd3M3c0xkcnBWS3Vv?=
 =?utf-8?B?UFZEV3htRWFpRkVsOExpckhJbFQxaURSemR4WHhTanRKSzZjb2RYZ3FsbWhw?=
 =?utf-8?B?K2dqbGxOa0lvWnV5cGZmS2h5WkhiVnN0blZLV1RtbUMxYmNBODB5MDFuRmhM?=
 =?utf-8?B?aG8wNUNZd1RJM2VIb2RCK0M2N2o5dG1oK2ZVcUtCREtCbVpCU0IzMGY5M3g3?=
 =?utf-8?Q?1S8ZVPtWeXQmJwtkBEM8Qu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <305203BF1226194085853DA2CACF2974@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe2c99c-e3af-46a8-4617-08db253c4357
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 10:01:36.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vype3kKIZdEnzbNw2Qwx1/MZZIqXsY+T9XDQQus/shcyl854o1jOo6rqGjg8jSp3Pn1TDFVjMBlGc9OUE1rmshu5eozyH2UCFPoUzPL3or8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksIA0KDQpPbiBUdWUsIDIwMjMtMDMtMTQgYXQgMDk6NDAgKzAxMDAsIEpvaGFubmVzIEJlcmcg
d3JvdGU6DQo+IEhpLA0KPiANCj4gPiBJdCBtYXR0ZXJzIGJlY2F1c2UgRXh0ZW5kZXIncyBTVEEg
aW50ZXJmYWNlJ3MgaWZtZ2QtPmZsYWdzIGlzDQo+ID4gY2hhbmdlZA0KPiA+IGR1cmluZyBiYW5k
d2lkdGggZG93bmdyYWRpbmcgYW5kIHJlbWFpbnMgY2hhbmdlZCB0byB0aGUgbmV4dA0KPiA+IGFz
c29jaWF0aW9uLg0KPiANCj4gT0sgYnV0IHRoZW4gX3RoYXRfIHNlZW1zIGxpa2UgdGhlIHByb2Js
ZW0gaGVyZSwgbm8/DQoNClJpZ2h0Lg0KDQo+IA0KPiA+IFNpbmNlIHRoZXJlIGlzIG5vIHdheSB0
byByZXNldCBpZm1nZC0+ZmxhZ3MgYWZ0ZXIgYmFuZHdpZHRoDQo+ID4gZG93bmdyYWRpbmcsIHdl
IGNoZWNrIHRoZSBjb250cm9sIGNoYW5uZWwgYmVmb3JlIGRvd25ncmFkaW5nIHRoZQ0KPiA+IGJh
bmR3aWR0aC4gSWYgdGhlIGNvbnRyb2wgY2hhbm5lbHMgYXJlIGRpZmZlcmVudCwgd2UgZGlyZWN0
bHkgZmFpbA0KPiA+IHRoZQ0KPiA+IGFzc29jaWF0aW9uLg0KPiA+IA0KPiANCj4gUmlnaHQsIGJ1
dCB3aGF0IGlmIHlvdSBoYWQgYW4gYXNzb2NpYXRpb24gdG8gc29tZSBvdGhlciBBUCwgb3IgdHdv
DQo+IGNoYW5jdHhlcyB3ZXJlIGFsbG93ZWQsIG9yIHNvbWV0aGluZyBlbHNlPw0KDQpJbiBvdXIg
c2NlbmFyaW8sIGlmIHR3byBjaGFuY3R4cyB3ZXJlIGFsbG93ZWQsDQppZWVlODAyMTFfbGlua191
c2VfY2hhbm5lbCB3b3VsZCBub3QgcmV0dXJuIG5vbi16ZXJvLCBhbmQgdGhlDQphc3NvY2lhdGlv
biBzaG91bGQgc3VjY2VlZC4NCg0KQW5kIGlmIEV4dGVuZGVyJ3MgU1RBIGludGVyZmFjZSBoYWQg
YW4gYXNzb2NpYXRpb24gd2l0aCBzb21lIG90aGVyIEFQLA0KaXQgd291bGQgZmlyc3QgZGUtYXV0
aGVudGljYXRlIHdpdGggdGhhdCBBUCwgdGhlbiBzY2FuIGFuZCBhc3NvY2lhdGUNCndpdGggYW5v
dGhlciBuZXcgQVAuIFRoZSBzYW1lIGlzc3VlIHN0aWxsIGhhcHBlbnMgaW4gdGhpcyBjYXNlLg0K
DQpUbyBkZWFsIHdpdGggb3RoZXIgY2FzZXMsIHRoZSBuZXcgZnVuY3Rpb24NCmllZWU4MDIxMV9j
aGVja19zYW1lX2N0cmxfY2hhbm5lbCBpdGVyYXRlcyB0aHJvdWdoIGllZWU4MDIxMV9sb2NhbCdz
DQpjaGFuY3R4X2xpc3QgdG8gZmluZCBhIGNoYW5jdHggd2l0aCB0aGUgc2FtZSBjZmc4MDIxMV9j
aGFuX2RlZiBhcw0KUm9vdEFQLg0KDQo+IA0KPiBJIGZlZWwgd2Ugc2hvdWxkIHByb2JhYmx5IGlu
c3RlYWQganVzdCByZXNldCB0aGVzZSBpZm1nZC0+ZmxhZ3MNCj4gYmVmb3JlDQo+IGFzc29jaWF0
aW9uLCBvciBzbz8NCg0KWWVzLCBpdCBtaWdodCBhbHNvIGJlIGEgc29sdXRpb24uDQoNCj4gDQo+
IGpvaGFubmVzDQoNCg0KQmVzdCwgDQpNaWNoYWVsDQo=
