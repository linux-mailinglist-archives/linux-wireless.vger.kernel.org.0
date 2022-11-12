Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF2626C0F
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 22:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiKLVtB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 16:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLVs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 16:48:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CCD9FD0
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 13:48:51 -0800 (PST)
X-UUID: 93ef51afa66d400e8c183dd44d97dcc2-20221113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nNM6GVPphiRdKQGEdsENRuKmbyyBz+4P3eGE8lF4/rg=;
        b=KyWlhC0iRmNCQ+NjpF8qhL1pzW8k/iv/VnGggYyWdEq+iTiUTHQZ2pMbK1G41OmspPJKS/L99oWHt8AMX0EX9ht5+8o3ZVQUCMw55fPm6A4Wz2qiNQgFyEJIA1dtvrcbDLG9rCaZhUkm4jsHfJvvTxbPzdfz+H3fNyvB7M9Wzmc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:31856b6f-fabd-4d9e-93dc-b9def49d922c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.13,REQID:31856b6f-fabd-4d9e-93dc-b9def49d922c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:d12e911,CLOUDID:8e781886-088c-4756-8f76-577be701e693,B
        ulkID:221112201824LALFNGKO,BulkQuantity:10,Recheck:0,SF:28|17|19|48|102,TC
        :nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0
X-UUID: 93ef51afa66d400e8c183dd44d97dcc2-20221113
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1892680511; Sun, 13 Nov 2022 05:48:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 13 Nov 2022 05:48:47 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sun, 13 Nov 2022 05:48:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDLQdytjjNdBrBUWHVOyDT5NnZNVIRqFZN34mx82m1h6WirLHqOyQN/7qMLk4clA1p3xa5QgNtWpjF83sZqT6gy0NgFT2kYmX1OhH2z+MtO4okBkITvwDVzq3qaUjmYVRcQJvpjERV0QRzFNTSo80Lv1M3aiFyjMc5HTyVtIDsnQY48C0gU97z2/N0uxlmGxCxDQY9xTGDOm+H+gmiHFK7CMyzFLVcyDsD7x+H3yAgmQxylz1BSC5e7u3yV4SMGlf2/iiKNjGKByvK915/v54TYK0DzZhqmDs0PcJJnvevjHcuVbk/byX72w/GuZeboLs/s4iZ8URDI992rbxL6I5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNM6GVPphiRdKQGEdsENRuKmbyyBz+4P3eGE8lF4/rg=;
 b=PlQW0YTowjay+GIb5OxBXe4wPRUA2b2qYe1y8/mRyAZ0QTZqLDCrnRfgpiE+JHbROWT72PE8TUtkhtaOsLZ5+gPANkxNl8BFaCbdzLOOpzPgknaxRHltWtH1vwgzoa7+aOMoVIYBVlXtsnBUTjhvzE46dKasN6qnw+8JdIDM5HeIrDuE97/3IuGz1rFCAjsoKf/JPbQgkd09+Xl4bIe7ApSSXjVHVcRZUZjXp59W5bF8AJlEw4JPXvDW3r8lFgpO/8qVwrM5BV/EfA+JgtjGSqsZUwi+ZQtliV+cYEqH6LaZiDVucHLKGfRjrLGqAFAxPWnuwKALtX3EmSqy9mZATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNM6GVPphiRdKQGEdsENRuKmbyyBz+4P3eGE8lF4/rg=;
 b=CmL6oMdqQ1tSHLXaBkImQI5lg0RCcISWWoG60F7CLhVusEmz2kd9462/zFCc9gfhT9T1W6FDByy0sXwq2NG45I3/UEMloCfKHBLzNogP6f38RjiSdVx/P3Tjz3aZhieFfkYk29sAR6SSR3MfpIfDhAd67EHdmBoAngzvvXFUECg=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEZPR03MB6524.apcprd03.prod.outlook.com (2603:1096:101:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 21:48:44 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::3c4f:5697:636e:56e6]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::3c4f:5697:636e:56e6%4]) with mapi id 15.20.5791.026; Sat, 12 Nov 2022
 21:48:44 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH v3 2/4] wifi: mt76: mt7915: enable full system reset
 support
Thread-Topic: [PATCH v3 2/4] wifi: mt76: mt7915: enable full system reset
 support
Thread-Index: AQHY9pEEaXCMq3W620aaCa15wWWIka47dlQAgABdmoA=
Date:   Sat, 12 Nov 2022 21:48:43 +0000
Message-ID: <b0d68b4639164ebc73a78bb1fb6c7547c6cae4ff.camel@mediatek.com>
References: <3e6ef9fb1d2e09d415b4c489cc9c62134a05b3c1.1668024217.git.ryder.lee@mediatek.com>
         <e8f7b70d0d119234917bd79c16c41f79c222e8f8.1668024217.git.ryder.lee@mediatek.com>
         <Y2+PBWfEw+WtZXzC@lore-desk> <Y2/GNuBFkTP8a6qG@lore-desk>
In-Reply-To: <Y2/GNuBFkTP8a6qG@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEZPR03MB6524:EE_
x-ms-office365-filtering-correlation-id: dea59426-0db6-4149-8c0e-08dac4f7ab7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSAPaQyYdbxrvpabOZ953DZdNsg2C3nJb75Y9CK50ZfuMD202J9DhJmX/gUmMBC+RXoDV061YQpQSEt/6c6991SSeaiNIf20tfrchRD6RbO8iJbt+zmcxF/nncQo0CNZNKBuwUG9E1qnezZyzWnjGKsCftJCdWIy6TW9Md6zbpgVquWJgvv2PkR1l1yDD4GOdPOZJIdtyjYtrXTQnMJbEef7dnbu0cbuB5dugpoZg46m6GOspsE1cnAzCPNVS+sb7bvDXBA6toLCY1ale9Q28hXOowYHCzY147MKosgg9GK59oWYeo1yNw0G2b+EJIjS2JEK7qE5AJVUXRBWSBKA8+jFVr5B9DsPnUwPW2oxTteW2ULmQGEHQTT3PDklV/JQQYXQRLS2VUQ/7H4EKlOlmW0Ja5yqmbOcG8VL+HkzGp/WOGpRVlA84yvL5guBML0iNX3TamIuAeSqcmH33g2uumXKb316GCn+h5CyHHvBxNCGuY7nyupihu4Q4jWoPy21S0oUpjNbI8VrHkKtVLIEQfTzpPubeGTc8GwEPgNIbTwx2OnJI3ptSaE2qIKXr5d4ge7hC+OyxEoe5Fgh0+vMoaui2jZoeHWBaljRy+W2BSNVJ6s89f3G9mBhKk38TlqmxnygSXSWDQWYrGhXGd7J7k3s9vPHrCjLeBFquyQ2L8E+SdjpvlcEcgkcUnuD9fezp3PhD4gxOCW22Q37nDVRpzzovDUoEJa/9snaJd78qE5OXT/o0oyWnTtD3Ei9GHCQOqv5T93A/gHrsgGIveIfgjKcd7FQreU3vwFGfSAU6kWpqu8ToyHD9lGexvV2o8+v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(38070700005)(4326008)(2906002)(38100700002)(122000001)(4001150100001)(8676002)(91956017)(86362001)(6486002)(2616005)(186003)(6512007)(83380400001)(71200400001)(478600001)(26005)(6506007)(76116006)(41300700001)(66476007)(66946007)(64756008)(66446008)(107886003)(5660300002)(8936002)(6916009)(54906003)(66556008)(36756003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ujc5amtJZ0o1RlQvTVlmZzFNSWpla0FCZzd1dkpSMStNeWJUOUFRTUNGUys5?=
 =?utf-8?B?WWtGeWRTVjJONFJWSExBc1lsVkhUZHE2S2NkNG5Uc25DUXFNM0k1cnhhRUoy?=
 =?utf-8?B?WWIwUVlicnp3RGhDSEF5NXIzQlpkNjdzcFkrdGxkSDh5eDB1dkR0ZitxeVBV?=
 =?utf-8?B?bStUT3AyNUROK3NXS1puZ1A1L3RzR2RzQ1RFR0dCUmxjWENrVmV6ZnlvcW5L?=
 =?utf-8?B?NVB4ZGUvTEd3SU85WWQraVdJejBSM0djWEFMbFc1SEg0dnZaUUZCQlozUHNZ?=
 =?utf-8?B?c0ZsOGRidUNmTGYzUWRmNCs4bkxmeGs3elV2VllBS0lNM2E5b0d0TjlSZkZV?=
 =?utf-8?B?OXVMTUNnZjAxeFhQdW9hYVVpT1h4Nk10VlRWWER4V0dOWGVGMXhWR2dudDlP?=
 =?utf-8?B?SHp1MlFQK3NCamZjazNNY2xuNDNNNWQwNWhFc3FRWVVpSkQ1NS92Y01QSUlO?=
 =?utf-8?B?V0daSTcxUkwwd0JoM3FHWHdQbHpaNVdCVHVCVFl4YU1LTjBHVnlJVDVKdVYv?=
 =?utf-8?B?dXlWaDFDY3dKTW13VEZBUWl2K1dPWE1RMjNmYmZBSDlNN1dPOExjVjR3R3pF?=
 =?utf-8?B?RHh3ZkZUWXBuWng2VlExUE01T1R1a0VKSnhFY2hodlFpZFVlbTdodlVTdXRZ?=
 =?utf-8?B?TDI1eFczdnYzUFlteFc4R3JHOXRKSWJYbUVjNlYrN3ByenFwM3V6VzdtSDZz?=
 =?utf-8?B?dkRpSVVrdllZcE9USjJlQmxVMkZzaG12aWw0d1lDOTVhcno2dW05aEpwblRK?=
 =?utf-8?B?WVNYUVF0YXJ3SWJiZ2VJYWQxeFUvVXJvTlhoVnhUNkR3L3dwRTdVeWoyaWty?=
 =?utf-8?B?RlZ0WHk5akV4Q2tPbWVWSkk0aWorVWRwSmFGa1F5dGh5YVBITHZqV3k3ZmJY?=
 =?utf-8?B?N0JOQzZiWjNWcDlCQXA0ZEhuWm5PcXJVcW9rcE1xcHpjRTh0QlVzWjNUVjNy?=
 =?utf-8?B?OTFHMmxRcjhTN29ORkRhN3hlalpLZVhpMmdpNnhKSGE2OHlGN2d3UHFxWU13?=
 =?utf-8?B?RGw5LzFoUW9FcThCVnNjdjhrcUlFVW1ic1Bkb210bkZIS2k4aVB6SS9EcFhw?=
 =?utf-8?B?QVpwSGxjYWRGdFJySjBLSXhiOTdYQlhMZXdNUlhvMlRQY0FoZWl4U1FLNDRL?=
 =?utf-8?B?UTEzMWZIdytzSVZqc0ZibnR0VC9rTzlDY3lTQS9HcS9XdUdsUlJ5QzB3Q091?=
 =?utf-8?B?dmVBcmNlNkMxYlBZcVhiNXlkZGtYS21YbnBkUHhvWkFna2xReVA4SVVkL3RR?=
 =?utf-8?B?UEpIakU0dlg2MTRwck9uRi9ON1lWdlpRQ3VBZ3ZpZ1YrdlhkQThsUE80WWJa?=
 =?utf-8?B?R2UyVzQ5MkNmcjhvcDBObmthYnl6RFVuakxRQ2RVZlNYT0FENzZjSXBtQmN4?=
 =?utf-8?B?V2R5UmFBSU9IdHJ3SUZSZHNmbTVhVVVOYStCQUI4aVlXNFZ6ZnBXd3BINms4?=
 =?utf-8?B?blZYZHRDK0hVSlBJSWU2TmppYk5XTDlvQ0pRSGlpSHFlN0ZVeER6bFUrd2tG?=
 =?utf-8?B?VFhyN2lNbVg1cGt6Wld6TE1MUnhPdHRNTXltVzI0TkVLelFuK212Z1ZUK0RU?=
 =?utf-8?B?QnJhVkIwTWdPYm14S3NhcHhIU2tTN1I2YW9BK2JBQzhvd3dsZkNDb0ZyYmpT?=
 =?utf-8?B?SGtGUHoyTS8yUkVwZ2xDaklCTTRINE1sb0xqcmdZaUg2eXhWZHZVbnd2cnJq?=
 =?utf-8?B?MWNJVjRub0EwTlhoWndSdmttYkIwRU1mTjduNWZGU3UxSnJaK251SFZ6V2Mw?=
 =?utf-8?B?VTE4Q3o0RVh0aURlSkxOVTY5R25ZRjRPMFBJVHhNMllaWHF3QTB4eVBPSHd2?=
 =?utf-8?B?LzBKTEI1TGFqMUJMZkxHZDdlaTg1MUsxeCtZc3V4amhBZC9aUGxuN3diWHht?=
 =?utf-8?B?VzFRSlF1ZFJvU0VjR3JvYTlhd2pHcGFweUpteGNBdnVRN2pDMHcraU1kelpC?=
 =?utf-8?B?UlV3MXBIVzRnUGpSbGpvMHhLRFVtVFkwM3hqaENvUzlvSXpJQ2hpNjlmTGxu?=
 =?utf-8?B?YktLcWk4amJOdnUwTW9BUU9CVy91bHp5U3NEZWxlWTBBY3FCeGhTeVdJV2tX?=
 =?utf-8?B?bUdFRGx1R2xGNldVL2pVMlcvSmFSSVQwMWlZZ0djV0IzdWFkeHFQbEluSVRj?=
 =?utf-8?B?SkwvTEJTTUdrQjFnS0FNNEhaeFJPelkvZTVsMXczL2Z4cjY3d3ZZMy9KTW1O?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E82183540CCF1499F749A35B2D0E0A7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea59426-0db6-4149-8c0e-08dac4f7ab7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 21:48:43.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DK5Iss8fMfQ8k9qO4GgUZW2q6CtQSHnltbLEitwpSUZBndu0sSLEfg70bTEFeeKBfS6C2gAYkYQeU3qq5YX7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIyLTExLTEyIGF0IDE3OjEzICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+ID4gRnJvbTogQm8gSmlhbyA8Ym8uamlhb0BtZWRpYXRlay5jb20+DQo+ID4gPiANCj4g
PiA+IEFkZCBtdDc5MTVfcmVzZXQoKSBhbmQgcmVmYWN0b3IgbXQ3OTE1X21hY19yZXNldF93b3Jr
KCkgdG8NCj4gPiA+IHN1cHBvcnQNCj4gPiA+IGZ1bGwgc3lzdGVtIHJlY292ZXJ5Lg0KPiA+ID4g
DQo+ID4gPiBDby1kZXZlbG9wZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNv
bT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNv
bT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJvIEppYW8gPGJvLmppYW9AbWVkaWF0ZWsuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiBjaGFuZ2Ugc2luY2UgdjIgLSBjaGFuZ2UgZGV2X2luZm8gdG8gbWFr
ZSBpdCBlYXNpZXIgdG8gc2VlIHRoYXQNCj4gPiA+IGZpcm13YXJlIGNyYXNoZWQgd2hpbGUgbG9v
a2luZyBhdCBkbWVzZy4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jICB8ICAxMSArLQ0KPiA+ID4gIC4uLi9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMgICB8IDIxNA0KPiA+ID4gKysrKysrKysrKysrKysr
KystDQo+ID4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMg
IHwgIDE4ICstDQo+ID4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYyAgIHwgIDI0ICstDQo+ID4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9tbWlvLmMgIHwgICA3ICstDQo+ID4gPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L210NzkxNS5oICAgIHwgIDE1ICstDQo+ID4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9yZWdzLmggIHwgICA0ICsNCj4gPiA+ICA3IGZpbGVzIGNoYW5nZWQs
IDI2NyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0K
PiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMN
Cj4gPiA+IGluZGV4IDMyNGRiNTI5MWM4NS4uMWYzOWFhM2UzZjNkIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQo+ID4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMN
Cj4gPiA+IEBAIC0yNjIsOSArMjYyLDggQEAgc3RhdGljIHZvaWQgbXQ3OTE1X2xlZF9zZXRfYnJp
Z2h0bmVzcyhzdHJ1Y3QNCj4gPiA+IGxlZF9jbGFzc2RldiAqbGVkX2NkZXYsDQo+ID4gPiAgCQlt
dDc5MTVfbGVkX3NldF9jb25maWcobGVkX2NkZXYsIDB4ZmYsIDApOw0KPiA+ID4gIH0NCj4gPiA+
ICANCj4gPiA+IC1zdGF0aWMgdm9pZA0KPiA+ID4gLW10NzkxNV9pbml0X3R4cG93ZXIoc3RydWN0
IG10NzkxNV9kZXYgKmRldiwNCj4gPiA+IC0JCSAgICBzdHJ1Y3QgaWVlZTgwMjExX3N1cHBvcnRl
ZF9iYW5kICpzYmFuZCkNCj4gPiA+ICt2b2lkIG10NzkxNV9pbml0X3R4cG93ZXIoc3RydWN0IG10
NzkxNV9kZXYgKmRldiwNCj4gPiA+ICsJCQkgc3RydWN0IGllZWU4MDIxMV9zdXBwb3J0ZWRfYmFu
ZCAqc2JhbmQpDQo+ID4gPiAgew0KPiA+ID4gIAlpbnQgaSwgbl9jaGFpbnMgPSBod2VpZ2h0OChk
ZXYtPm1waHkuYW50ZW5uYV9tYXNrKTsNCj4gPiA+ICAJaW50IG5zc19kZWx0YSA9IG10NzZfdHhf
cG93ZXJfbnNzX2RlbHRhKG5fY2hhaW5zKTsNCj4gPiA+IEBAIC00NDYsNyArNDQ1LDcgQEAgbXQ3
OTE1X21hY19pbml0X2JhbmQoc3RydWN0IG10NzkxNV9kZXYgKmRldiwNCj4gPiA+IHU4IGJhbmQp
DQo+ID4gPiAgCW10NzZfY2xlYXIoZGV2LCBNVF9ETUFfRENSMChiYW5kKSwgTVRfRE1BX0RDUjBf
UlhEX0c1X0VOKTsNCj4gPiA+ICB9DQo+ID4gPiAgDQo+ID4gPiAtc3RhdGljIHZvaWQgbXQ3OTE1
X21hY19pbml0KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYpDQo+ID4gPiArdm9pZCBtdDc5MTVfbWFj
X2luaXQoc3RydWN0IG10NzkxNV9kZXYgKmRldikNCj4gPiA+ICB7DQo+ID4gPiAgCWludCBpOw0K
PiA+ID4gIAl1MzIgcnhfbGVuID0gaXNfbXQ3OTE1KCZkZXYtPm10NzYpID8gMHg0MDAgOiAweDY4
MDsNCj4gPiA+IEBAIC00NzYsNyArNDc1LDcgQEAgc3RhdGljIHZvaWQgbXQ3OTE1X21hY19pbml0
KHN0cnVjdCBtdDc5MTVfZGV2DQo+ID4gPiAqZGV2KQ0KPiA+ID4gIAl9DQo+ID4gPiAgfQ0KPiA+
ID4gIA0KPiA+ID4gLXN0YXRpYyBpbnQgbXQ3OTE1X3R4YmZfaW5pdChzdHJ1Y3QgbXQ3OTE1X2Rl
diAqZGV2KQ0KPiA+ID4gK2ludCBtdDc5MTVfdHhiZl9pbml0KHN0cnVjdCBtdDc5MTVfZGV2ICpk
ZXYpDQo+ID4gPiAgew0KPiA+ID4gIAlpbnQgcmV0Ow0KPiA+ID4gIA0KPiA+ID4gQEAgLTExMTcs
NiArMTExNiw4IEBAIGludCBtdDc5MTVfcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdA0KPiA+ID4gbXQ3
OTE1X2RldiAqZGV2KQ0KPiA+ID4gIAkJCWdvdG8gdW5yZWdfdGhlcm1hbDsNCj4gPiA+ICAJfQ0K
PiA+ID4gIA0KPiA+ID4gKwlkZXYtPnJlY292ZXJ5Lmh3X2luaXRfZG9uZSA9IHRydWU7DQo+ID4g
PiArDQo+ID4gPiAgCW10NzkxNV9pbml0X2RlYnVnZnMoJmRldi0+cGh5KTsNCj4gPiA+ICANCj4g
PiA+ICAJcmV0dXJuIDA7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCj4gPiA+IGluZGV4IDNiMTI1OWYxNGRlNi4uNjlj
ZTNiMzlhYTUzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jDQo+ID4gPiBAQCAtMTI2NSw3ICsxMjY1LDcgQEAgbXQ3
OTE1X3dhaXRfcmVzZXRfc3RhdGUoc3RydWN0IG10NzkxNV9kZXYNCj4gPiA+ICpkZXYsIHUzMiBz
dGF0ZSkNCj4gPiA+ICAJYm9vbCByZXQ7DQo+ID4gPiAgDQo+ID4gPiAgCXJldCA9IHdhaXRfZXZl
bnRfdGltZW91dChkZXYtPnJlc2V0X3dhaXQsDQo+ID4gPiAtCQkJCSAoUkVBRF9PTkNFKGRldi0+
cmVzZXRfc3RhdGUpICYgc3RhdGUpLA0KPiA+ID4gKwkJCQkgKFJFQURfT05DRShkZXYtPnJlY292
ZXJ5LnN0YXRlKSAmDQo+ID4gPiBzdGF0ZSksDQo+ID4gPiAgCQkJCSBNVDc5MTVfUkVTRVRfVElN
RU9VVCk7DQo+ID4gPiAgDQo+ID4gPiAgCVdBUk4oIXJldCwgIlRpbWVvdXQgd2FpdGluZyBmb3Ig
TUNVIHJlc2V0IHN0YXRlICV4XG4iLCBzdGF0ZSk7DQo+ID4gPiBAQCAtMTMyMCw2ICsxMzIwLDE3
MSBAQCB2b2lkIG10NzkxNV90eF90b2tlbl9wdXQoc3RydWN0DQo+ID4gPiBtdDc5MTVfZGV2ICpk
ZXYpDQo+ID4gPiAgCWlkcl9kZXN0cm95KCZkZXYtPm10NzYudG9rZW4pOw0KPiA+ID4gIH0NCj4g
PiA+ICANCj4gPiA+ICtzdGF0aWMgaW50DQo+ID4gPiArbXQ3OTE1X21hY19yZXN0YXJ0KHN0cnVj
dCBtdDc5MTVfZGV2ICpkZXYpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgbXQ3OTE1X3BoeSAq
cGh5MjsNCj4gPiA+ICsJc3RydWN0IG10NzZfcGh5ICpleHRfcGh5Ow0KPiA+ID4gKwlzdHJ1Y3Qg
bXQ3Nl9kZXYgKm1kZXYgPSAmZGV2LT5tdDc2Ow0KPiA+ID4gKwlpbnQgaSwgcmV0Ow0KPiA+ID4g
Kwl1MzIgaXJxX21hc2s7DQo+ID4gPiArDQo+ID4gPiArCWV4dF9waHkgPSBkZXYtPm10NzYucGh5
c1tNVF9CQU5EMV07DQo+ID4gPiArCXBoeTIgPSBleHRfcGh5ID8gZXh0X3BoeS0+cHJpdiA6IE5V
TEw7DQo+ID4gPiArDQo+ID4gPiArCWlmIChkZXYtPmhpZjIpIHsNCj4gPiA+ICsJCW10NzZfd3Io
ZGV2LCBNVF9JTlQxX01BU0tfQ1NSLCAweDApOw0KPiA+ID4gKwkJbXQ3Nl93cihkZXYsIE1UX0lO
VDFfU09VUkNFX0NTUiwgfjApOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCWlmIChkZXZf
aXNfcGNpKG1kZXYtPmRldikpIHsNCj4gPiA+ICsJCW10NzZfd3IoZGV2LCBNVF9QQ0lFX01BQ19J
TlRfRU5BQkxFLCAweDApOw0KPiA+ID4gKwkJaWYgKGRldi0+aGlmMikNCj4gPiA+ICsJCQltdDc2
X3dyKGRldiwgTVRfUENJRTFfTUFDX0lOVF9FTkFCTEUsIDB4MCk7DQo+ID4gPiArCX0NCj4gPiA+
ICsNCj4gPiA+ICsJc2V0X2JpdChNVDc2X1JFU0VULCAmZGV2LT5tcGh5LnN0YXRlKTsNCj4gPiA+
ICsJc2V0X2JpdChNVDc2X01DVV9SRVNFVCwgJmRldi0+bXBoeS5zdGF0ZSk7DQo+ID4gPiArCXdh
a2VfdXAoJmRldi0+bXQ3Ni5tY3Uud2FpdCk7DQo+ID4gPiArCWlmIChleHRfcGh5KSB7DQo+ID4g
PiArCQlzZXRfYml0KE1UNzZfUkVTRVQsICZleHRfcGh5LT5zdGF0ZSk7DQo+ID4gPiArCQlzZXRf
Yml0KE1UNzZfTUNVX1JFU0VULCAmZXh0X3BoeS0+c3RhdGUpOw0KPiA+ID4gKwl9DQo+ID4gPiAr
DQo+ID4gPiArCS8qIGxvY2svdW5sb2NrIGFsbCBxdWV1ZXMgdG8gZW5zdXJlIHRoYXQgbm8gdHgg
aXMgcGVuZGluZyAqLw0KPiA+ID4gKwltdDc2X3R4cV9zY2hlZHVsZV9hbGwoJmRldi0+bXBoeSk7
DQo+ID4gPiArCWlmIChleHRfcGh5KQ0KPiA+ID4gKwkJbXQ3Nl90eHFfc2NoZWR1bGVfYWxsKGV4
dF9waHkpOw0KPiA+ID4gKw0KPiA+ID4gKwkvKiBkaXNhYmxlIGFsbCB0eC9yeCBuYXBpICovDQo+
ID4gPiArCW10NzZfd29ya2VyX2Rpc2FibGUoJmRldi0+bXQ3Ni50eF93b3JrZXIpOw0KPiA+ID4g
KwltdDc2X2Zvcl9lYWNoX3FfcngobWRldiwgaSkgew0KPiA+ID4gKwkJaWYgKG1kZXYtPnFfcnhb
aV0ubmRlc2MpDQo+ID4gPiArCQkJbmFwaV9kaXNhYmxlKCZkZXYtPm10NzYubmFwaVtpXSk7DQo+
ID4gPiArCX0NCj4gPiA+ICsJbmFwaV9kaXNhYmxlKCZkZXYtPm10NzYudHhfbmFwaSk7DQo+ID4g
PiArDQo+ID4gPiArCS8qIHRva2VuIHJlaW5pdCAqLw0KPiA+ID4gKwltdDc5MTVfdHhfdG9rZW5f
cHV0KGRldik7DQo+ID4gPiArCWlkcl9pbml0KCZkZXYtPm10NzYudG9rZW4pOw0KPiA+ID4gKw0K
PiA+ID4gKwltdDc5MTVfZG1hX3Jlc2V0KGRldiwgdHJ1ZSk7DQo+ID4gPiArDQo+ID4gPiArCWxv
Y2FsX2JoX2Rpc2FibGUoKTsNCj4gPiA+ICsJbXQ3Nl9mb3JfZWFjaF9xX3J4KG1kZXYsIGkpIHsN
Cj4gPiA+ICsJCWlmIChtZGV2LT5xX3J4W2ldLm5kZXNjKSB7DQo+ID4gPiArCQkJbmFwaV9lbmFi
bGUoJmRldi0+bXQ3Ni5uYXBpW2ldKTsNCj4gPiA+ICsJCQluYXBpX3NjaGVkdWxlKCZkZXYtPm10
NzYubmFwaVtpXSk7DQo+ID4gPiArCQl9DQo+ID4gPiArCX0NCj4gPiA+ICsJbG9jYWxfYmhfZW5h
YmxlKCk7DQo+ID4gPiArCWNsZWFyX2JpdChNVDc2X01DVV9SRVNFVCwgJmRldi0+bXBoeS5zdGF0
ZSk7DQo+ID4gPiArCWNsZWFyX2JpdChNVDc2X1NUQVRFX01DVV9SVU5OSU5HLCAmZGV2LT5tcGh5
LnN0YXRlKTsNCj4gPiA+ICsNCj4gPiA+ICsJbXQ3Nl93cihkZXYsIE1UX0lOVF9NQVNLX0NTUiwg
ZGV2LT5tdDc2Lm1taW8uaXJxbWFzayk7DQo+ID4gPiArCW10NzZfd3IoZGV2LCBNVF9JTlRfU09V
UkNFX0NTUiwgfjApOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoZGV2LT5oaWYyKSB7DQo+ID4gPiAr
CQltdDc2X3dyKGRldiwgTVRfSU5UMV9NQVNLX0NTUiwgaXJxX21hc2spOw0KPiA+IA0KPiA+IGly
cV9tYXNrIGlzIHVzZWQgdW5pbml0aWFsaXplZCBoZXJlLg0KPiA+IE1vcmVvdmVyIGlzIG10Nzkx
NV9tYWNfcmVzdGFydCgpIGFuZCBmdWxsLXJlc2V0IGNvbXBhdGlibGUgd2l0aCB3ZWQNCj4gPiBz
dXBwb3J0Pw0KPiA+IGl0IHNlZW1zIGluIG10NzkxNV9kdWFsX2hpZl9zZXRfaXJxX21hc2soKSB3
ZSB0b29rIGEgZGlmZmVyZW50DQo+ID4gYXBwcm9hY2guDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4g
PiBMb3JlbnpvDQo+IA0KPiBzaG91bGQgd2UgZG8gc29tZXRoaW5nIHNpbWlsYXIgdG8gdGhlIHBh
dGNoIGJlbG93Pw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21hYy5jIA0KYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tYWMuYw0KPiBpbmRleCBjNzZjNWNjMzk4ZTkuLjljOTljMzAxNGE3OSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFj
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFj
LmMNCj4gQEAgLTEzODYsNyArMTM4Niw2IEBAIG10NzkxNV9tYWNfcmVzdGFydChzdHJ1Y3QgbXQ3
OTE1X2RldiAqZGV2KQ0KPiAgCXN0cnVjdCBtdDc2X3BoeSAqZXh0X3BoeTsNCj4gIAlzdHJ1Y3Qg
bXQ3Nl9kZXYgKm1kZXYgPSAmZGV2LT5tdDc2Ow0KPiAgCWludCBpLCByZXQ7DQo+IC0JdTMyIGly
cV9tYXNrOw0KPiAgDQo+ICAJZXh0X3BoeSA9IGRldi0+bXQ3Ni5waHlzW01UX0JBTkQxXTsNCj4g
IAlwaHkyID0gZXh0X3BoeSA/IGV4dF9waHktPnByaXYgOiBOVUxMOw0KPiBAQCAtMTQ0MCwxMSAr
MTQzOSwxNyBAQCBtdDc5MTVfbWFjX3Jlc3RhcnQoc3RydWN0IG10NzkxNV9kZXYgKmRldikNCj4g
IAljbGVhcl9iaXQoTVQ3Nl9NQ1VfUkVTRVQsICZkZXYtPm1waHkuc3RhdGUpOw0KPiAgCWNsZWFy
X2JpdChNVDc2X1NUQVRFX01DVV9SVU5OSU5HLCAmZGV2LT5tcGh5LnN0YXRlKTsNCj4gIA0KPiAt
CW10NzZfd3IoZGV2LCBNVF9JTlRfTUFTS19DU1IsIGRldi0+bXQ3Ni5tbWlvLmlycW1hc2spOw0K
PiAtCW10NzZfd3IoZGV2LCBNVF9JTlRfU09VUkNFX0NTUiwgfjApOw0KPiArCWlmIChtdGtfd2Vk
X2RldmljZV9hY3RpdmUoJm1kZXYtPm1taW8ud2VkKSkgew0KPiArCQltdGtfd2VkX2RldmljZV9p
cnFfc2V0X21hc2soJm1kZXYtPm1taW8ud2VkLA0KPiArCQkJCQkgICAgbWRldi0+bW1pby5pcnFt
YXNrKTsNCj4gKwkJbXRrX3dlZF9kZXZpY2VfaXJxX2dldCh3ZWQsIH4wKTsNCj4gKwl9IGVsc2Ug
ew0KPiArCQltdDc2X3dyKGRldiwgTVRfSU5UX01BU0tfQ1NSLCBtZGV2LT5tbWlvLmlycW1hc2sp
Ow0KPiArCQltdDc2X3dyKGRldiwgTVRfSU5UX1NPVVJDRV9DU1IsIH4wKTsNCj4gKwl9DQo+ICAN
Cj4gIAlpZiAoZGV2LT5oaWYyKSB7DQo+IC0JCW10NzZfd3IoZGV2LCBNVF9JTlQxX01BU0tfQ1NS
LCBpcnFfbWFzayk7DQo+ICsJCW10NzZfd3IoZGV2LCBNVF9JTlQxX01BU0tfQ1NSLCBkZXYtPm10
NzYubW1pby5pcnFtYXNrKTsNCj4gIAkJbXQ3Nl93cihkZXYsIE1UX0lOVDFfU09VUkNFX0NTUiwg
fjApOw0KDQpZZXMgd2Ugc2hvdWxkIHVzZSBkZXYtPm10NzYubW1pby5pcnFtYXNrLi4uc29tZWhv
dyB3ZSBhZGRlZCBpcnFfbWFzaw0KaGVyZS4gQEZlbGl4LCBjb3VsZCB5b3UgaGVscCB0byBmb2xk
IHRoaXM/DQoNCkFzIGZvciB3ZWRfZGV2aWNlIEkgdGhpbmsgd2UgbmVlZCBhbm90aGVyIHBhdGNo
IHRvIHN1cHBvciBpdHMgU0VSIGFzIGl0DQpuZWVkcyB0byB0YWtlIG10a19ldGggaW50byBhY2Nv
dW50LCBhbmQgYWN0dWFsbHkgdGhlcmUncyBhIHBhdGNoIGluDQpNVEsncyBnaXQwMSByZXBvLg0K
DQpSeWRlcg0K
