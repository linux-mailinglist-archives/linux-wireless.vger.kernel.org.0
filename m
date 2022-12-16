Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23B64E670
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 04:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLPDn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Dec 2022 22:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPDn6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Dec 2022 22:43:58 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3D40467
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 19:43:56 -0800 (PST)
X-UUID: 1f8b2aee6fbf4a2495e4aef858b59334-20221216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hUGKE6TnVCuHXvXeH5hk2O6xA63tR5rLcxhFiKisSxU=;
        b=kBkZtTMZGxfgeGrLT+Ppg/lC3W3ZQGITU7XQuyMjm+9NeRTFaxk4Q1LCzOpZOpQJFUWChbYBu/zhb3CRrvRgnDWn+uTLVkURzHwmazn1Frd9acLnTpow4NYAC/igjcYlJQuP5j9t4+7gkscHJBDtb5PQ43xLI2Jt6r8VGMzqrFo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:e40ab1ad-d7b8-4dec-a5ed-d583c7318cdf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:614accaf-9f02-4d44-9c44-6e4bb4e4f412,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1f8b2aee6fbf4a2495e4aef858b59334-20221216
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1750008165; Fri, 16 Dec 2022 11:43:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Dec 2022 11:43:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 16 Dec 2022 11:43:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laZH3YT1z2NE1TxmoN1vnCTyOwBx6Lsr9uDj3+hTI20D/QIIkZytATtXPlCuFKHXCyfxy6w5p0VcJXFOZArWowix1eltFcHEKg9h3Wpxgw4XCv/L5Ppsrs/qI6XCcmSbD10tqmOLnFp7y2JonORzw1mfr9xMyRBXDGT38b/N3CzW+xDfftx1mjFDmj62IlmuMVOd4CvmcaqpaakvwlbrHP2NwyXy+ipefW/BhyKD6QQLWVroyvEOTF6MsUfR6LGCOTaoVjCYKHEdSjqa6c0cMyZ3wYC60lBZHHhrv8m3U7JupLlIcJ6Lh791WkSYTy3IStQk3CPZYADp/x8qf6vXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUGKE6TnVCuHXvXeH5hk2O6xA63tR5rLcxhFiKisSxU=;
 b=BDkccoB/PHlz2knJj08qjPIW0YeIFoWpf0EVyuqLMX+oPSM/gKHfmhT+XnOwndfeUAnxRGMuA9YVz9hOAk13NlzeYj10+sOgkJzYXpFSiFucu2hglC6d+xmNHwK6YZM3hv7xUdDCx9PuSSfv0XbmmvRI0Vd6NoR+1+ci1vt0P9tyJU/SLTeUaqS8PWEF32rizCnGOhgqFCi7Mz0y7xr5UbyE6pmsgZrsTonKGV7ebkn/EkbG8Nw6AFCH3lIKo3rFS2sgYapVe5h5Glubg7oVRJ+RgayWjXtVq5uzSrorAm776Frp5drMpJvdhIVX9kT7pvlH/TTfDQL0sWfvTjOp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUGKE6TnVCuHXvXeH5hk2O6xA63tR5rLcxhFiKisSxU=;
 b=k510o74B4iGhTjweUCE4kGx91t0APtz3lsOvXFYIqr/Cp82KDIWnYShLsMHFC48DcHFLE48WoaRf3f9hNup4e8DxCIgiPOXosipmtvyGHkjFZcYNwVcTnuzCuEYd/yTD4hzpKf7zX630YEt7Ni7pE8EIME1kgGpjXQwSkUG3cdQ=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by KL1PR03MB5538.apcprd03.prod.outlook.com (2603:1096:820:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 03:43:44 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::658c:288d:5ce9:29f5]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::658c:288d:5ce9:29f5%9]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 03:43:44 +0000
From:   shayne.chen@mediatek.com
To:     "julian.calaby@gmail.com" <julian.calaby@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "Ryder Lee" <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7915: add chip id condition in
 mt7915_check_eeprom()
Thread-Topic: [PATCH] wifi: mt76: mt7915: add chip id condition in
 mt7915_check_eeprom()
Thread-Index: AQHZCx5l1Kdp9NOyi0KwD9ICU+3B/a5kn4EAgAtLaQA=
Date:   Fri, 16 Dec 2022 03:43:44 +0000
Message-ID: <b19ce0fa4e0b1b534709bc787015b405ea7a23c0.camel@mediatek.com>
References: <20221208160137.3855-1-shayne.chen@mediatek.com>
         <CAGRGNgWvT7e5DkTO96PaMazDae-wTe3ctBx8-n6EGhYxFPwCHQ@mail.gmail.com>
In-Reply-To: <CAGRGNgWvT7e5DkTO96PaMazDae-wTe3ctBx8-n6EGhYxFPwCHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|KL1PR03MB5538:EE_
x-ms-office365-filtering-correlation-id: 44974cab-e93d-4fe9-ea59-08dadf17bb3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPeTT+3JYXkuYghG4w2D0YBv8c1qbf6u20F9HW8dTQdULjjLtH07QIFxofdqAFwEaBPKoiQNBc9Kd2jHymcqnlEYM/ZFzvVtkE8XjmOrjqswEf7TtTgK0n21k+cjxdc1y2Uxala4vhsvP1XmGxSq+G4HFO7jnHiCJ1p21pX2xwk5IHEY2hgH0XQ74Q+Kgl1nNGWGWX5xTWUAlx427YzDQBVcZibGDcx2bcnyB4osv8mGN+J7MUG+PsK/CyrUZK9KqdoeB9wC4K7lyethTYLsNIrqwic64NqgKsIUQbW92YCRsIvUHW27WDSwdna8dvFsfvS4uGZcrFDuyetDY9j8e9qTrlHW2X6E4w7GUTReq9NaaEoakRv279/9I1/XJOIWtQDobQ5Y9xIcUJB2HxlT5r7ba6aQn3wcHyY3l5hYvHStQ76osssdYSUnvNve+yH1utuu/HeDYwzEtolFxzcvOQHHNG91gAaVYupb0mJ2rAL0IPp1rraiIfDn7PVYSctnOdEMuLZRyVmlLXLYOOHDngWD82gmUY7Dek67vTwxPAu6Gx5T8F1pmJ09ucYe8Wa5qmFptPAG/XIdSzEsVnrT/DNpXhOMxclpk5KI0/bFz609AIGbV0/v2b96pKHDpGTVOMhEq0u51Qv99OTKMfpTX1ye6Kbg0UMLmnGow5LAuPlnsnS5mR/UgSZGE2JnOMCG8WO/StGEFJIdJZu0RUvuh9kTZ+73EN+dZz9FnPX0pDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(41300700001)(71200400001)(122000001)(6486002)(478600001)(53546011)(6506007)(107886003)(91956017)(76116006)(316002)(85182001)(36756003)(26005)(66556008)(6512007)(5660300002)(66476007)(186003)(66446008)(64756008)(66946007)(8936002)(8676002)(4326008)(2906002)(38100700002)(2616005)(83380400001)(86362001)(54906003)(6916009)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUZHVnllUm02bFFkU2llb1l6YTUrbDVGUHlCREY2ZFZSWFh4UmMzdVVJL2ph?=
 =?utf-8?B?Yzh1M3dXa0lBSUpzRVU2Z0o2blVFSTA0NVo5Q2JjQlk1c05pYXFzRUJoQWZ6?=
 =?utf-8?B?SjA0OGFSTjJjc2FMa1NaWnN2WGdEa3BGUnBmNW5LTWtKdVFiVkhzTkhoV1d4?=
 =?utf-8?B?dDArWkJGRHNiL3JuZ1dKRG9vYkZzcWlxQjkzWkRzRGlBOE1zSW8wK05SalRO?=
 =?utf-8?B?bWdEWkdvWjNtOHJlYVpvQWoyTkpkTDdoSVEvNHJPLzkzMGxGUGpIYkIyRGFa?=
 =?utf-8?B?LzcxR2JyQ3dsYVVFb0VHV2hoRVB3UkZyTmRTYmpCczNSTThzbWU3c3FGa2lN?=
 =?utf-8?B?Z3dwaGc0STFNbzkxbGMyYUt6SFJrR1N5SHdab0I5ZUIyMzVSeUFPbVpQZnE2?=
 =?utf-8?B?SWdxSWY1RTJlRm9JWTYrTzNEZzFSb0NMZGZpRXBZUy9ZOGdTUURjMWhhTEVX?=
 =?utf-8?B?dU95bTR5T2I0K2N6ckxmR3ZoeHVpQWl3VG5hNWFQSzd1a0ZVOFg3K2dURmFo?=
 =?utf-8?B?bkVrOG9RbElNWmNnSjFSSTI4M0tXNWZxN3NOTUZKWEEvbzJGZnhUTHNPQU9a?=
 =?utf-8?B?NThvanVkSEkxYnIxZFBoZlhnYk9XaUdVbHFTTG5MZUY0RVNxVjdVTlRQdHhU?=
 =?utf-8?B?d0tYSWg4TU5ibGJPUFNJdEhaTzRKK1BaNWNUMWZwVjZnVUN3bUczQ3I0NHlG?=
 =?utf-8?B?OE1PV0VaQ0d5N0kzZ0g1V2tDVDROQndXcHE2WDlxL3Q5S0ZPQ01ZZ3ZoMzJH?=
 =?utf-8?B?WWwycFNzbVg3N2pYbHcwVExJK1RGTTlnOTZkeCs0M3ROMzU4d1NmUnliOWt5?=
 =?utf-8?B?emlmaW1FOG8yQkNCMzFCc1QzU0hJUnFHdTIwaHMvcWFhUWt5NCt1ek1mZ1Nu?=
 =?utf-8?B?T2dLT2p6VUJ3NEhpNW5Ncjc4WGE2Z0lRWS8rM3NZT2JEK0VGVXh1NVdZUC9E?=
 =?utf-8?B?RjZVWStNWXdzV2h4RjVsd0d2NGJkRlY1ZHh1aUhWREluazJ5dGZFbmhXVThx?=
 =?utf-8?B?OGY1YXhBQ3hOVGx1cjI0czg0czJNZnE5V2E0VHJXNm1maWpIM2VIUkRhamNy?=
 =?utf-8?B?UXo4dURjTjM0bWh6U3FwS1RUSmk0UVN2dkNENCsxcTNjQU1DRFFQWUlNaER4?=
 =?utf-8?B?RnlIa2R3Y3dad29UUEcxUWQrQitBRjNrL2lzNHE3Z1FQZDBSS1dEbmZtbUN6?=
 =?utf-8?B?TEU4UGp5Snd5ZWpoNzZnejFhS3I0SUc1dmpxcmtETFlPbG1LTmdldVBtK3hX?=
 =?utf-8?B?MWpLSFBuUHlIUU0ySzNWK1VUdSttWHI1bWpJbVRVTW92Wk1DMnhhdjhIMita?=
 =?utf-8?B?N3MvTjNXQkNIZjAvVldDNGpVY1NGOWUrTG1ETmVoblBqUmdjaDIyc3FoS1FS?=
 =?utf-8?B?VWhnK25PYmFGWUxOQ3R4MU9UVUNaUERHNXFwTFkvUzdMT3ZWVlIwREx5YlVQ?=
 =?utf-8?B?WktmbCtoVUd5S2FUa0JkMDdqMllKLzVzOWdYQys4b0piVmUwZFpEZzBlQU01?=
 =?utf-8?B?SFNPYTRMVk9XTVhpeXJNdVlzM2NhTmVhU0pqZDhpblZ3bmVCalZuaG5LVGV0?=
 =?utf-8?B?eVJTTGxJYkxaMUk2NjdsYno5R3EwZjM4WFB5OGdhU0JmNjgxczU3NlpUNjJ6?=
 =?utf-8?B?Ni9NRDJSckZuTVQ2dEtnOHVUeTZ3L2FlcVlHaldWVnZoUFBlaDVnSDcwSWt3?=
 =?utf-8?B?T1djYjFBbFZraG5IVXJ5cDBrem1GS0xKcmpvSE82ZmVDTjFBRTNJSkUwYVlm?=
 =?utf-8?B?VWdud3N1SDdEb29NZnRRY0ZERHNVaDhsMy9oUTR5ZlpYbnphUUZXS05ZaE5m?=
 =?utf-8?B?Z0U3aTZ0ZkQvTy9wU2dXSTFuWERHL0ZHQW1GaTFkazk5dk5XYjJuWTV4ZFlp?=
 =?utf-8?B?b3RwWnBqM2FYM091Uzg3TXI0TDJVUEF6UzZURmVJR3huYU1lNjdGd3MzanJu?=
 =?utf-8?B?UHRxQU1nTURIc1FuUFQ3VGFFb05rVTN5VTkzc05uUm5xUUlJajBjZXRiQUY4?=
 =?utf-8?B?eEZoTTdabnVSSGswbmdxd0wvS3pSeG5XQWRIc21uZEZzNVBJTzVNei9ZaEV6?=
 =?utf-8?B?ZDZwUDZkWldxSzA0T2lCVzJRUGVlYSsrclA3WGU1NVlSc2RSWVR2UmF4MmF3?=
 =?utf-8?B?SkhqakI4dTRONGtGTEZQblJCRWcwbzNYZkpIZXVhb0E2L2o4ekE1S1psM2dX?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B913AC0DFE848419C184F4847933272@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44974cab-e93d-4fe9-ea59-08dadf17bb3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 03:43:44.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReySNGvhgCBYB419+c0Mu14qS53s2ArFHiHsy9bL5IQZDEwqJ8OQS5K+DIF6L65XhC8i/DulP/BbEXIXRREjP3TJBkX4IsRx9/zgtmuVqhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5538
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDEwOjE0ICsxMTAwLCBKdWxpYW4gQ2FsYWJ5IHdyb3RlOg0K
PiBIaSBTaGF5bmUsDQo+IA0KPiBPbiBGcmksIERlYyA5LCAyMDIyIGF0IDM6MDYgQU0gU2hheW5l
IENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gV2hl
biBmbGFzaCBtb2RlIGlzIGVuYWJsZWQsIGFuZCB0aGUgZWVwcm9tIGRhdGEgaW4gdGhlIGZsYXNo
IGlzIG5vdA0KPiA+IGZvcg0KPiA+IHRoZSBjdXJyZW50IGNoaXBzZXQsIGl0J2xsIHN0aWxsIGJl
IGNoZWNrZWQgdmFsaWQsIGFuZCB0aGUgZGVmYXVsdA0KPiA+IGVlcHJvbSBiaW4gd29uJ3QgYmUg
bG9hZGVkLg0KPiA+IChlLmcuLCBtdDc5MTUgTklDIGluc2VydGVkIHdpdGggbXQ3OTE2IGVlcHJv
bSBkYXRhIGluIHRoZSBmbGFzaC4pDQo+ID4gDQo+ID4gRml4IHRoaXMga2luZCBvZiBjYXNlIGJ5
IGFkZGluZyBjaGlwIGlkIGludG8gY29uc2lkZXJhdGlvbiBpbg0KPiA+IG10NzkxNV9jaGVja19l
ZXByb20oKS4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogQ2hlbmctSmkgTGkgPGNoZW5nLWppLmxp
QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNo
ZW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9lZXByb20uYyB8IDEyICsrKysrLS0tLS0NCj4gPiAtLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9l
ZXByb20uYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
ZWVwcm9tLmMNCj4gPiBpbmRleCA1OTA2OWZiODY0MTQuLmUyMWFhMDNjODViMSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9lZXByb20u
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2Vl
cHJvbS5jDQo+ID4gQEAgLTMzLDE0ICszMywxMiBAQCBzdGF0aWMgaW50IG10NzkxNV9jaGVja19l
ZXByb20oc3RydWN0DQo+ID4gbXQ3OTE1X2RldiAqZGV2KQ0KPiA+ICAgICAgICAgdTggKmVlcHJv
bSA9IGRldi0+bXQ3Ni5lZXByb20uZGF0YTsNCj4gPiAgICAgICAgIHUxNiB2YWwgPSBnZXRfdW5h
bGlnbmVkX2xlMTYoZWVwcm9tKTsNCj4gPiANCj4gPiAtICAgICAgIHN3aXRjaCAodmFsKSB7DQo+
ID4gLSAgICAgICBjYXNlIDB4NzkxNToNCj4gPiAtICAgICAgIGNhc2UgMHg3OTE2Og0KPiA+IC0g
ICAgICAgY2FzZSAweDc5ODY6DQo+ID4gKyAgICAgICBpZiAoKGlzX210NzkxNSgmZGV2LT5tdDc2
KSAmJiB2YWwgPT0gMHg3OTE1KSB8fA0KPiA+ICsgICAgICAgICAgIChpc19tdDc5MTYoJmRldi0+
bXQ3NikgJiYgdmFsID09IDB4NzkxNikgfHwNCj4gPiArICAgICAgICAgICAoaXNfbXQ3OTg2KCZk
ZXYtPm10NzYpICYmIHZhbCA9PSAweDc5ODYpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gPiAtICAgICAgIGRlZmF1bHQ6DQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiA+IC0gICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiANCj4gSWYgdGhpcyByZXR1cm5lZCBhIGJvb2wsIHlvdSBjb3VsZCB3cml0ZSB0aGlzIGFzOg0K
PiANCj4gc3dpdGNoICh2YWwpIHsNCj4gICAgICAgICBjYXNlIDB4NzkxNToNCj4gICAgICAgICAg
ICAgICAgIHJldHVybiBpc19tdDc5MTUoJmRldi0+bXQ3Nik7DQo+IH0NCj4gDQo+IFRoYW5rcywN
Cj4gDQpIaSBKdWxpYW4sDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KVGhpcyBmdW5jdGlv
biByZXR1cm5zIDAgb24gc3VjY2VzcyBhbmQgLUVJTlZBTCBvbiBmYWlsLCBzbyBJJ2xsIGFkZCBh
DQptYWNybyB0byBjb252ZXJ0IHRoZSByZXR1cm4gdmFsdWUgaW4gdjIuDQoNClJlZ2FyZHMsDQpT
aGF5bmUNCg==

