Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3624F18DD
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354046AbiDDPxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378171AbiDDPws (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 11:52:48 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6DF42487
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1649087450; x=1649692250;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=MyeQ96gkURJanb7UbLT3dJgVLDlU+VJiKFqW6ceaCu4=;
  b=mZdnuQ8UvnuDWgThrHQqjwXrsSLfCtTrxgWo1EO7KDz+SHs4yJHGIHMU
   TPDxETs8yCvjxjvmEdSu/ib2JZMmcwyXiqvQbGJrRQWwxvemIweJUoFxZ
   341EPPzOiqIC7Un65fC4v/T5h7zQ3DrSFgXsQOdFVqVc0sqTRUIRKOLBI
   Q=;
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 15:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq1L8LgW/8EdI1VMjlK2mRpE0m0LesoKK359cpNOS15WqlALRFg9uJpIiTH/02Ly40mK87ZPZ44u0yv5mE1HBl5i70G4wltEgf3vY+k4X0ixJ1Hsh9F7P1KHqGunerD/Dg9fcaZAEBs4TGv6D9JZ7Abrf9OGcTIUo7OfO3uJo+jaWSFCoiQDWl73jRh4tuZZf9LQzuRRChXTHfQn/bDzwGPfWrYhB8A9fbrj1J/i8/8HZz4Hoz8R1oejcV+WpAfsuhmvjInMxwh/F2mBveNM/1Tq+VQD33BfqMNvkQ3dRlQipilfNOvvz5Fc+W+yz30Y+v0ZOHym4aJxVvStOlTNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyeQ96gkURJanb7UbLT3dJgVLDlU+VJiKFqW6ceaCu4=;
 b=CO9OeBF7OBWa5MbfseCNm0gNpnpV3lF0jp34yR+u3pP5Ib2HLHOnTZ5J+VkthhiewGnxqqlJfMIldA0dUvGuTecz8QEDTtjG2vHeGf6A6ukfkNFtYKF6rgON1Of3D0OXdrLJLOUkWB6W2ap6Vzi+sqai/Tvp3K58G72tsmWybCsrRY+BpsJ96wFDZRp0aK/zgBRRg3/7eL3Ya+tOtr29TPFOshRafEwAsPkSn1i/PxK7haDQ95F5twXCzSwTIZi1Od9KKLkWW7LpQn1iLZCXHabR6pDb/KfOR0TnRTjQ2VGRuiLZh39iRWcs3zAZlTaAYMFpH9SrG1i0VUQfoa7hnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by BN6PR02MB2516.namprd02.prod.outlook.com (2603:10b6:404:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 15:50:48 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::e5a3:e283:efc7:a889]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::e5a3:e283:efc7:a889%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 15:50:48 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC v2] mac80211: prepare sta handling for MLO support
Thread-Topic: [RFC v2] mac80211: prepare sta handling for MLO support
Thread-Index: AQHYQ2ShGJYmZDfjMUStBmBUa2Mr6azfx1IAgAAjhgCAAANLAIAAAf0w
Date:   Mon, 4 Apr 2022 15:50:48 +0000
Message-ID: <SN6PR02MB43347C8B21DA6B7F3D6F0A92F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1648555198-8065-1-git-send-email-quic_srirrama@quicinc.com>
         <467e7f83270a9b1f8e2b32f27b48607e2c2ff480.camel@sipsolutions.net>
         <SN6PR02MB433476576476A9AA7EAF3F95F7E59@SN6PR02MB4334.namprd02.prod.outlook.com>
 <f73b62ea7f04899db5e49c9722e99ba31172f787.camel@sipsolutions.net>
In-Reply-To: <f73b62ea7f04899db5e49c9722e99ba31172f787.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc663359-2486-4e6c-3723-08da1652e372
x-ms-traffictypediagnostic: BN6PR02MB2516:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR02MB2516330B97ED16F4A58921208BE59@BN6PR02MB2516.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hq8TftwpQN/zOofxKFC0xmLG9Bjo5UQ3Kh6/5pqgWtIsqVKvCgl9Zd01X1eGzOvD4rMXq8+qgIRtuW6F/twXtYh3An1kEiCVhib9Sn8uiqB5iViQjrycunSH6FZm0HpHffjr+41gikPGr5PfDtkQGLVKvCf7p1GJsSnIDBL8h0NVj1YYXmHkDzaw1VkTLKX60QWfp8h/R6xxccPLVHmyRRu5HPP0ppfNkke4ntjYuiVINY1qXPXWgAGLuptb7mPpjvyERgfhSqFONdaaYgqtqH0UF2AnXYzPjtrbMe3tSpO7MYdVey++XabAp5yB7xd3S5vmEmKgATX6Vjit3Ly6fJXStXRKeUJq+S1gQ9c+RVyIaDvR581DriqNQSRhom8JEcn8+Qoq0XiZFtM2xdCBqWPzsp0nbm2fWtFTvobVxGAbPOsXju30bMRoZmD2RseSZvTeTqx3zhajSapDYWHfgCfDgDOuz6KAxofPtgnLg0bKN4YrtI1OhHxqDvyFWoF5RL9PlHyFM2DXp8ACl5cqApgxKEMlu3Vmf9iEPrZpxTajZwJ3LvaQj0qN4Nj4eLXlBo1fpLhx87xBVWuhFngyvJPov8rSOrSK9Tz0yzm+EaiHLZSFjYSiy1POOJ3PIxl9Tv3wp5U6HhJlTw8a5mlt6j0JgtHq9zkM/nZg/nkZEaDXR+EO+qth05eLszUp3y+cmAFLBlySX68NXN7ZaozNpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(38070700005)(66556008)(110136005)(64756008)(66946007)(71200400001)(66476007)(66446008)(8676002)(76116006)(316002)(86362001)(6506007)(55016003)(38100700002)(5660300002)(9686003)(122000001)(8936002)(52536014)(33656002)(4744005)(2906002)(7696005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlBBUmgrOHh6ZFZqYlJoY2hTRlBFaFJoN0s2QmJFbWR5Z3ozODVrS21uWVVp?=
 =?utf-8?B?b0IrNFpvTTkvZWRndldSYVliSW1WN24weDJjR2dJaUJxdDhWRnlxNmZmWUpH?=
 =?utf-8?B?N2hkR3NTaVdHSzRpaHl3MDJ1V1BNRUpoSUV6a1F1bHBHcUhsTjQyOVNPNERa?=
 =?utf-8?B?V1Z1c3lHckRhTUh2R3RWUG9FUzlEaDgyQ3U4SThRditEeEU2T2hGMjllOGtG?=
 =?utf-8?B?VU5iVFhJNEpXQ2s5ZWN3S0pVRVNacVJ3dFQvUWZqc1g4L0l3UVRIYXpQdzFQ?=
 =?utf-8?B?cVFTWC9XSkdrVlF4cXY0RisyUnVIYTdiYjEvdk5ERlROQ3JSTHBsbllrTVBD?=
 =?utf-8?B?czJJaDIrNEtCRnVOOHpSWmhZSUJjZWFsVHQ2QmxLTy9xWTl6ejd1ZllHeDc5?=
 =?utf-8?B?OU96TGhXZFp4WEJjVGpCM3MwQWNnYTIrVDZIcCtFQWtvT2Eza0FWeGEyRmRX?=
 =?utf-8?B?Yk1nT3A3Z1p0d1Q3VWxlWjhDalpENUpyWXZ2Rk5IYWl2MGxnZHVlenBYRFJP?=
 =?utf-8?B?MklOWUNKRFdPSVdDQTlyOHF5R2thTnFEMmFUTVIvNm5CTVJWT3g1SjR5S25E?=
 =?utf-8?B?cFRCaTlDcy9CVXJRS3RiaTFBTTYrS2MzclFWaitQY1JNTmkzaHUrNHFKLzBo?=
 =?utf-8?B?VUhDamZWaCtoN0VJcVlUUFdibHdHVkJ6Umo2ME1SOExveUZ3TnIwYWRxaU4w?=
 =?utf-8?B?WFpuMk9mMjA0ZWR0WjVHZnBaQ2ZWMmFoMGsxZ2NxOHpWNk9PcWNzelFER3JO?=
 =?utf-8?B?QlNvZE5Yb2xiR0RBWjZJL2tOMHgwMWtMWitGNWNiUnd5d1llUE51Z21BeXov?=
 =?utf-8?B?U1czbElEVTJKTDA4dkQvMHp0VWNaNGlncjcraGtrcEl0MW8wY3V0UG1Sd05P?=
 =?utf-8?B?aDJneEgwK3JDeElVQnRwemh5cGpDTzJKMzRHRUxxTjd0VVY2Q3BIcVhPVFpt?=
 =?utf-8?B?RVFxM21kbHUvQXQ1TlZZeVZydFhEMkFaL21wZzVMcTQxdW8wbCtBeTU0NUVk?=
 =?utf-8?B?Tnc3cWp3Y2IreGNvdy9ZU3JWOXJudGtsc0J2RTBOdTBnTjJGMExLRVZ1dUxu?=
 =?utf-8?B?Z1RrVThoMmpoWFVhaklhV2RTTGZSakhhMkVXZDloQXBRWCsyeTZjV3FrdG1x?=
 =?utf-8?B?enMzNGxVdzBlZFZvUjBkeEZRN2QyVWpzc05Hdi9MSlBlR200OGZSZXZyVVJx?=
 =?utf-8?B?NUg1Q3U1VEtqdGdtczZseXMxSjNZa25LN3RBVGFrQTVXZXFvZG5HOFRCa1g4?=
 =?utf-8?B?UmRtbkNjTVJ2OXpieFhWcDJhMit2VXdIc0UyT2tqOVpMWHg2SytmdmR1WDhv?=
 =?utf-8?B?QUVFUlp3UkJTbWU0OEd2KzFCVDUvVzBkcWpEM0YrVElYbmRPclcxUm13RG1O?=
 =?utf-8?B?cFJ4ZHQ0U1F1TXk3SU5ObzRIYTByc2lLRVJVczZlTUNwdThUQ0t5QUlnSzNF?=
 =?utf-8?B?dzhiRzIzVG4xK0VzOWxjdmNXRXJYZ2dzSjdISWRIZHZwcTM4Y1l1R2ZXWkFJ?=
 =?utf-8?B?aFNHZlZHZEVSS29hSHdZMmYxWjhxSzZCOHVYRGRVZEJ1RzZOeUdBVXlmQXpl?=
 =?utf-8?B?MjdzU0g0WmZ3SThMZzd0UVRYcHJKTFhJNzBKVHY1OEpNN3BSczlYYkZJaUJV?=
 =?utf-8?B?MzZYWTN1aEd2YUxvbEtBOVowN2EwUzBqZmZVUEVQQXl1T2FqUVZOZjhCa1pW?=
 =?utf-8?B?T2hLd2pGZWJMVHNXcjVvU1pWeFJJNzZ6R2o3akNjSDlvd2VUWDZrazJ1aDNY?=
 =?utf-8?B?L1FMTStuUzI1QTZtZ20wck9QODYwVnErc3Ixcy9EUHdXL3p0aDEzNHpFSm90?=
 =?utf-8?B?L2M4VG5OcFMrc3oraVJWODlwMngzQlpsTmkrVnM2MVFRem96Z0RnZncxWWVh?=
 =?utf-8?B?QWdNdEFhZUJBUHBzRm00OURWVDZYeExnUC9xSkJFaW1EV1lVNzQ2QUFUNDA0?=
 =?utf-8?B?anZKeWRndUs0QVp1Mk41MkZ0UDZSSzNQR2VqdVlkUlk4VWphS0p6WjhLN2hD?=
 =?utf-8?B?Tk9CdmF0d0M1bStIb0VwU0dTWkVLZ3UwajB6MndTdUxnYkdiU2JMZlRqc1Nw?=
 =?utf-8?B?SklYUGZOWGZYZmt0UFRxQ2J2N09yS1E2MmZkR1phNitMQ1YzTW9XeVJqTmQz?=
 =?utf-8?B?ZndhbERsaWkzNGE1ZG9iK1lZUmZ5SEhyS3pIeHV5K1RwWGh6dEJiQ1BYZHNJ?=
 =?utf-8?B?K0NhQUlrZ3pRM21EbEdNQ1J1aEpCODcxTVdFbE9Kbm5hZjRvdjRrdHpOVVdK?=
 =?utf-8?B?Z3RYNmtidWdKL2psb1hYUGJ3a2o4V3hGVHg2UmpGNUYvVGFrR2tyODVxSDRt?=
 =?utf-8?B?bHVLT3ZCS3Q2RWJPT3hETkQraVFuejBxVGNMVVZVTHhGcTBpbUFGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc663359-2486-4e6c-3723-08da1652e372
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 15:50:48.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUMsIIauFsrnUNHVKe9PiE/X4bKgy1Clo+L3tbums5a0bnYAyFkCcFwnJS7fFDSWic7DbvZxw2ZE0np8inFjREs9Q1wARdigCmZNW/NPZZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2516
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiA+IEhpIEpvaGFubmVzLA0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgdGhpcyBsb29rcyBmaW5lIC0g
d2FudCB0byBzZW5kIGl0IGFzIGEgUEFUQ0g/IEkgdGhpbmsgSSdsbA0KPiA+ID4ganVzdCBhcHBs
eSB0aGUgc3BhdGNoIGRpcmVjdGx5Lg0KPiA+IFN1cmUsIExldCBtZSBzZW5kIG91dCBhIFBBVENI
IHNob3J0bHkuDQo+ID4gPg0KPiA+ID4gSWYgdGhlcmUncyBhbnkgbmVlZGVkIGZpeHVwcyBiZXlv
bmQgdGhlIHNwYXRjaCB0aGF0IG1pZ2h0IGJlIGdvb2QgdG8ga25vdw0KPiB0b28uDQo+ID4gU28s
IGluIHRoaXMgcGF0Y2ggKG1hYzgwMjExKSBJIGhhZCB0byBtYW51YWxseSBmaXggY291cGxlIG9m
IGNoYW5nZXMgYXJvdW5kDQo+IEFERF9TVEFfU1RBVFMsIFRSQUNFX0VWRU5UIG1hY3Jvcy4NCj4g
Pg0KPiA+IEluIGRyaXZlcnMsIG9ubHkgYmVsb3cgY2hhbmdlIHdhcyByZXF1aXJlZCBpbiBhZGRp
dGlvbi4NCj4gPg0KPiANCj4gTmljZSEgU28gaWYgeW91IGluY2x1ZGUgYWxsIHRoZSBtYW51YWwg
Yml0cywgeW91IGNhbiBhbHNvIGxlYXZlIG91dA0KPiBtYWM4MDIxMSBjaGFuZ2VzIGZyb20gdGhl
IHNwYXRjaCBpZiB5b3UgbGlrZSwgSSdsbCBqdXN0IHJ1biB0aGUgc3BhdGNoIHdoZW4NCj4gYXBw
bHlpbmcgaXQgc28gd2UgaGF2ZSBpdCBvbiB0aGUgZXhhY3QgdHJlZSBzbmFwc2hvdC4NCkkganVz
dCBzZW50IG91dCB0aGUgcGF0Y2ggdmVyc2lvbiwgSSdsbCBzZW5kIHYyIHdpdGggb25seSB0aGUg
bWFudWFsIG1hYzgwMjExIGNoYW5nZXMsIHNvIHJ1bm5pbmcgdGhlIHNwYXRjaCBvbiB0b3Agc2hv
dWxkIGhlbHAgY29tcGlsZSBzZWFtbGVzc2x5Lg0KDQpUaGFua3MsDQpTcmlyYW0uUg0KPiANCj4g
am9oYW5uZXMNCg==
