Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFF69C442
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 03:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBTCzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Feb 2023 21:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBTCzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Feb 2023 21:55:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03164B764
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 18:55:45 -0800 (PST)
X-UUID: 0fcc1842b0ca11eda06fc9ecc4dadd91-20230220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4ylF5QaJBlyYXcrjfW3DlHQultRhSRUc/VtNCudF4vc=;
        b=ZxTsceDj3RcvyeMQ2fXl8fscxF1acTE+r70LLpIIYB4QS0rcIcoowcuv2TXViEhNjl7WbhopB8GjwZdMBC88cto+++dEvEDhfuNs2YlXYxDYKWsefE0N11OrmCH+guGhxqpv8v1wxpcqEefY04nifONpYaFKhA2MfgxutlO8XGs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:cb460d1a-649d-46bd-8de1-d9eb6c08262b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:f1b3f0b0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 0fcc1842b0ca11eda06fc9ecc4dadd91-20230220
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 573703076; Mon, 20 Feb 2023 10:55:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 20 Feb 2023 10:55:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 20 Feb 2023 10:55:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VykdNJWNR/V/Y75FiVXu5VZ7y5NHIgCYxLO1WcX+PNtkrWa6EyDmGpbFPrRLfQ0yYwa33rFij8hZrdL40Rvm3wo15Oao5Ig6n7CRLxso2q411Q/PoP0tZEJ2m6X8Yrxime4Y6MBl0i0nyTLFtvWEpzXdu7fqKUi6Cvit3fR5phoSRr983t4qKiGHvSYRrjMAWz7Ft8Z3kAxPfGhiWTM9V4d7ktxi11GInvMQOrtxCns89wFbYJXMv1eUkWLNzndbhqlnV7aq/jAmyR2F3WyhPQod6PAJL9xJX1jGTWOXc+WPQOZek49uCR4RaMpCbUE6JhuvEKuiVJ/ueD4VB0jOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ylF5QaJBlyYXcrjfW3DlHQultRhSRUc/VtNCudF4vc=;
 b=gwSuvwliWkTKw14F+jRACNr0C/emhYJtboimKmCkZL3ANImTVPhViWd/1xDL9RyZi99uUuJ42fxLcW1ONbW7oCQmb90bEMnKE229dPGhnBad/DH2vtcuLWQjchxky4guouqNkOzeBfFNsCWJFi8kRNoAfzXYByEmVBRFPzo8slFkC3jwUjLQBigRVrpzH8Swbisag+rCaBZKAPgEbVF8axlth5eqCBTvad2ZjCH071IiOwhLB8MVz7ejGyLMz6UnzPJsAFhWZEZdNLSJHaXZMQGbEyzjM5+z5IH/hD1/KzPT9yWZCqoPXufkl79v+nnE7gbsNJnu7xrViTHW5HF9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ylF5QaJBlyYXcrjfW3DlHQultRhSRUc/VtNCudF4vc=;
 b=MQz8HYUYi1kK3PX7S/KlWlKBMlsqwKFb8sNm06E25FbCHiI8va9FDm9ZDYWI9a/sDfYyKYfQGVCVi+ToOEDGnp6jUwZFDFEITCnWu9lNQGEex26YktsjzPFOoCqD1TaRmpBfIiNhD/ETDz5b1X4SByoiCh2ctAiJN6C9ylQ5/5Y=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by KL1PR03MB6256.apcprd03.prod.outlook.com (2603:1096:820:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 02:55:38 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%9]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 02:55:36 +0000
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
Thread-Index: AQHZQvhNg/XMHPbh9UaJA+rO7kUbpq7TbbAAgAALzICAAALQgIAAAn+AgAOo34A=
Date:   Mon, 20 Feb 2023 02:55:36 +0000
Message-ID: <c05a8b20b5d4429b1c42ef2398ff2bf760bd7eae.camel@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
         <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
         <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
         <fb3ab2d925fdeae2e7cc778419c1476102b9f85f.camel@sipsolutions.net>
         <56190740441a6740e9edf761ab2167edc51f20c3.camel@mediatek.com>
In-Reply-To: <56190740441a6740e9edf761ab2167edc51f20c3.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|KL1PR03MB6256:EE_
x-ms-office365-filtering-correlation-id: 3d579c0e-ffe7-4480-5ce8-08db12edf12a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PNJbD9aTnLVr54VsoRVbod8tJCSlYlPGf/ZfETuQn2E4y8jPnQLwIO+97b6fxpLhK3oGhgVmc4CrV2JqARSYx9QdTH8qxxn3+c/aozwYU4U4yZq7h8+ajs4SQnjFavnv/4JQFFo1GvZb45SnRKVFmxWImgrN0pJcYf00562K+KRrPDAXC7ArAUaqDO1uFq/bA9NMt2F6P74Q2KB529UwCJRmbA4NzKyeewNx2lUEa/Ukbz8SJ6NeqwRmRCOvfXorMMO9IlGmA1zW5ydarIximAvoq7vG7Vaje5joUC2bQI31W83/9JPce+pEHiZJNwymJlt37ieqI6mT9pDHywcMov8fFNXXBZB5a/Vg4yVxUctS2B2HEWECsBHkQ40tMvecemqNykchLsu9RVI2xAcQAiGyBYlKkUCapLEtV1ZogDY9QMYlKKROqLv6qp3u4iUJOuVRfYMEg0kViyIIEghlE1ds/eOAS+km9x8MfKPhYzfH+SHR7Ln2pA4bXYqwcd+9dd0l38wouqYdbyElrrq3F/M6gG7zO5UfED9SQiW6NTB0/9rJsh9PTTf3pNIkHL5Ouxdx/a7TdyND97ZJTH6Bk4z3jdLi8B1GNa9nvsAbWVAd5XKwSyxMfNNN8ZGE5T8JzwxhYVmonAJ9BYP3Vwx+xulycVEZTDR2wKR9uvVx0gc2T1a75tu0cehYHkjJdK4uzrlKDdRDhSeO4O984lYI/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199018)(107886003)(26005)(186003)(6486002)(2616005)(71200400001)(316002)(6512007)(83380400001)(478600001)(64756008)(6506007)(66476007)(76116006)(38100700002)(6916009)(4326008)(8676002)(66556008)(41300700001)(122000001)(66946007)(66446008)(8936002)(5660300002)(54906003)(2906002)(36756003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3JuSzFkSGxDRWVyeC9jenpaZ2RIVkZuOHZpNSsxRHVTT1VRTnRobkFoT0lC?=
 =?utf-8?B?c1djblZhSFNCeHFic2hJeEdUZ05MaTQrbWdQZFFTUFJXcW5vdXZ0aXMxUEc0?=
 =?utf-8?B?SEpyNWJweVNxM1NNWi9Gci9GTWtwN0pXa0tqR05BM1dMSnRTbVpxVEtKU01N?=
 =?utf-8?B?ZU9qVHFoZGUzcmZqMDJDczFpTlVJMm1QaDJmSEZjSGNoN3BNeTZsSFlEV1lU?=
 =?utf-8?B?Z21Dd2VwanUwUGZCNVFUTVp0MVhwNTVKMWRxcE10N3pkQ1FYeE9qQjg3SkYr?=
 =?utf-8?B?Vm9kV2FncDNmRTZDUHdXait0bUtTOVU5WVZQZitJWm5WZHNMWGFvTVlaNHdh?=
 =?utf-8?B?SHBTcUt6OVZiajB1VW1rNUxJWnJVM1A4WkpLQlN2eFRxWjd3TG1wOFpzdUw1?=
 =?utf-8?B?RXF1Y1pINUpvalFyNzlaWXZQd3FYRU80cDJEVDZpRG1sUHJXM0pEbzUyMmtM?=
 =?utf-8?B?anNaNm5NQzM1ZndtOVhmRklBck1kRHZuTTlYWDJiZ1Z5Y3ZjMjNBUThqQ2pU?=
 =?utf-8?B?ejhhaTZ1K0Z4NS9nQ1c1TmJsLzZjMkk2Mm5oTkFndmNzdndBTzZFeDlVbUt3?=
 =?utf-8?B?OS9oeVJzbjM3NFBlNTRicjBMbU9Qb21uOFlPZTFGenhxSWNHb0llM0ZaT0pX?=
 =?utf-8?B?dGVjZllIODczUmxiMTl6YlV1K2RrNXhvZmQzUW50S01BM0I1NGtTaGl6bUhY?=
 =?utf-8?B?R0dJN09JTmFVNGtkL1o3SWdSZ1lmNGhRK2JBb3hKNVVKd0R5U2FENkg3WlJl?=
 =?utf-8?B?UzVnV0ZxZmdGOHFvTjg0RERqeDFlSDNPbjdiSmhRSmFGUkJpclZwLzUvSlZM?=
 =?utf-8?B?SWwvN1l3Tks0R1hOZkpxK09hQ2JMalhUL0JzTjl5QnBwUmJFOU1KcFJGQ2RJ?=
 =?utf-8?B?Z0lvMEMvYVhNMW10aDVjYTl5dWZ6RlBjV3c0ZEdZMTN1Vm8xWE9VcGlSaUJP?=
 =?utf-8?B?MzNxYWVHVHJpTFVBREdSV3hYeHRJeWJLMVNuQktRTUc4ME5nTEZPUDRZdlJB?=
 =?utf-8?B?R1BqOXRyMHk1Y0tnbncyaGJwcDRMVXJ0aVd1ZGpjb1pNT3NxTTNPK05iaGlj?=
 =?utf-8?B?Qmx2cFZVNlRXaGgySCtOSDNzZUJsdGF2Vkg0WlRYSjZIc1lBaGkxWkppSy9r?=
 =?utf-8?B?WkJNd3FFVnR2eE1DSEpEKzYzVlBpcGdaWEkyMnovdVRKL2FEQnFxZWZzMzZ1?=
 =?utf-8?B?c29SMGVkdGdMTDFXZzljNjhJME10anpHcVhvVzIzaXZIOWNIanNJb2E5Z2Ir?=
 =?utf-8?B?c0xWdGpXeGN3Y1NuL1hLSzZLcXpuaU1JU0tKREU2MHlnMnFReVJqM3dzVXFs?=
 =?utf-8?B?Qy9LNW9SejlBeXl3SlJoYmZBOFBWd2lyNGp6VUc0YkJHdWV2V1RrUmI0d0to?=
 =?utf-8?B?bDZwUjFVZlYxbXlKdE80R0pseFVNZDVqMjMrdlljVERlRG9ocW9GVzBvdDh0?=
 =?utf-8?B?UVJzWnZDdGtrb04rRVhlVi9uR3B6ZFg5ZFVFYjV1M0c3Z1FvWnVXWFVib3U3?=
 =?utf-8?B?b0hSd09PUWQ3S3F3VDF1VzdWUU5ZQ0RtMGFGUmhHZ1habjlmanNLSVUxS0JG?=
 =?utf-8?B?RjE0RnZNTmIyakNxbzcvck5DSGxta3RjSUp5bXRaazFRdk5IWFhwL3ZwMXln?=
 =?utf-8?B?WU5TSkpZbnJJQktPM0s0MHpySkJ5SWhhckpLcS9Uc3hkVlRubHFZdUlJZkhR?=
 =?utf-8?B?cjhrTWQydWRoczBHWmlZUktDS3R5eFYrOWY3Rjh0Wk5RZWFBZzluUXZhZGVB?=
 =?utf-8?B?bXVOTDdRZlpNdWlYMDNucFFqVENEdVlOclAzYTNwVjhyeUs4ZEROL0tnRjBw?=
 =?utf-8?B?SmNMcXUwM2xON2ZUYWc0WEg1L2wxcmZZTDNyVEJ1TjAzSGd6b0luai8vSG0r?=
 =?utf-8?B?M2JEaUhkcW1FM09pWTV5NXpRWVA2NjhOMzlvK1hVS3krb3FzNkk2d2sySHNN?=
 =?utf-8?B?aTdCUlMwSkhoOE5VYWtidXFDNFY1dnp4enlBSFk2VFAwanMwZnljYlBtUWUr?=
 =?utf-8?B?bnVOZHNTQ3RwMmdURldEMEk2VDhGY1MrcVZGZXNJRFQ0QjdDU25LWGpsTWdi?=
 =?utf-8?B?UHVmZTd5Z3RaT3hOamNiWDJicnd3WWkyNlg1SE0xbTN0emdaVWlYOVVnQTdO?=
 =?utf-8?B?cjdJM1MvTUtoZ1pkNFEzT01mRitlQUdGMTNsclp6bWVmRHVkSzkrZTlkQmtu?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38EC9A33EBB9D14BBE96D708CE658300@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d579c0e-ffe7-4480-5ce8-08db12edf12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 02:55:36.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1o9bM4pZoct9LifJTIRTyYA8K8Pai/JekR+LWTn/mmN+ZVjLDq6DhxuXRvZrO2kRrsULfALjC5k+DLyIc4StQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTE3IGF0IDE5OjAyICswMDAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IE9u
IEZyaSwgMjAyMy0wMi0xNyBhdCAxOTo1MyArMDEwMCwgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4g
PiBPbiBGcmksIDIwMjMtMDItMTcgYXQgMTg6NDMgKzAwMDAsIFJ5ZGVyIExlZSB3cm90ZToNCj4g
PiA+IE9uIEZyaSwgMjAyMy0wMi0xNyBhdCAxOTowMSArMDEwMCwgSm9oYW5uZXMgQmVyZyB3cm90
ZToNCj4gPiA+ID4gT24gU2F0LCAyMDIzLTAyLTE4IGF0IDAxOjUwICswODAwLCBSeWRlciBMZWUg
d3JvdGU6DQo+ID4gPiA+ID4gVGhpcyBhbGxvd3MgbG93IGxldmVsIGRyaXZlcnMgdG8gcmVmcmVz
aCB0aGUgdHggYWdnIHNlc3Npb24NCj4gPiA+ID4gPiB0aW1lciwNCj4gPiA+ID4gPiBiYXNlZCBv
bg0KPiA+ID4gPiA+IHF1ZXJ5aW5nIHN0YXRzIGZyb20gdGhlIGZpcm13YXJlIHVzdWFsbHkuIEVz
cGVjaWFsbHkgZm9yIHNvbWUNCj4gPiA+ID4gPiBtdDc2DQo+ID4gPiA+ID4gZGV2aWNlcw0KPiA+
ID4gPiA+IHN1cHBvcnQgLm5ldF9maWxsX2ZvcndhcmRfcGF0aCB3b3VsZCBieXBhc3MgbWFjODAy
MTEsIHdoaWNoDQo+ID4gPiA+ID4gbGVhZHMNCj4gPiA+ID4gPiB0byB0eCBCQQ0KPiA+ID4gPiA+
IHNlc3Npb24gdGltZW91dCBmb3IgY2VydGFpbiBjbGllbnRzLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gRG9lcyBpdCBldmVuIG1hdHRlcj8gV2UgY291bGQganVzdCByZXF1ZXN0IHNl
c3Npb25zIHdpdGhvdXQgYQ0KPiA+ID4gPiB0aW1lb3V0DQo+ID4gPiA+IGluDQo+ID4gPiA+IHRo
ZSBmaXJzdCBwbGFjZS4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgd2UncmUgYWxy
ZWFkeS4gT3VyIG1haW4gaXNzdWUgaXMgcGVyZm9ybWFuY2UgcGVyaW9kaWNhbGx5DQo+ID4gPiBk
cm9wcw0KPiA+ID4gZXZlcnkgZmV3IHNlY29uZHMgd2hlbiAubmV0X2ZpbGxfZm9yd2FyZF9wYXRo
IGlzIGVuYWJsZWQuDQo+ID4gPiBXaXJlbGVzcw0KPiA+ID4gY2xpZW50IGhhdmUgbm9ybWFsIDUw
MCsgTWIvcyBpcGVyZjMgZG93bmxvYWQgc3BlZWQgZm9yIHNldmVyYWwNCj4gPiA+IHNlY29uZHMu
DQo+ID4gPiBUaGVuIGl0IGRyb3BzIGxlc3MgdGhhbiAxMDAgTWIvcyBmb3Igc2V2ZXJhbCBzZWNv
bmRzLiBUaGVuDQo+ID4gPiBldmVyeXRoaW5nDQo+ID4gPiByZXBlYXRzLiBJc3N1ZSBvY2N1cnMg
b25seSBvbiBjZXJ0YWluIGNsaWVudHMuIChpLmUuIEludGVsIGNhcmRzDQo+ID4gPiBBWDIwMCwN
Cj4gPiA+IEFYMTY3NSwgQWR2YW5jZWQtTiA2MjM1IGluIFdpbjExKQ0KPiA+ID4gDQo+ID4gDQo+
ID4gU3RyYW5nZS4gQnV0IGhvdyBkb2VzIHRoaXMgcGF0Y2ggZG8gYW55dGhpbmcgYWJvdXQgaXQs
IHRoYXQgc2hvdWxkDQo+ID4gYmUNCj4gPiBjb21wbGV0ZWx5IGNsaWVudCBhZ25vc3RpYz8NCj4g
PiANCj4gPiANCj4gDQo+IFNpbmNlIHRoZXJlJ3Mgbm8gYW55IGtlZXAgYWxpdmUgcGFja2V0IGJl
aW5nIHJlY2VpdmVkIGJ5IGhvc3Qgc3RhY2ssDQo+IGxlYWRzIHRvIG1hYzgwMjExIGRlc3Ryb3J5
IEJBIHNlc2lvbi4NCj4gDQoNCk1vcmUgc3BlY2lmaWNhbGx5LCB0aGUgQkEgc2Vzc2lvbiByZWxp
ZXMgb24gY2xpZW50IHNpZGUncyBUeCBkYXRhIHRvDQptYWludGFpbiAuLi4gYnV0IHRoZSBwb2lu
dCBpcyBtYWM4MDIxMSBjYW4ndCBnZXQgYW55IGRhdGEgYWZ0ZXINCi5uZXRfZmlsbF9mb3J3YXJk
X3BhdGggYmVpbmcgZW5hYmxlZCAoSFcgcGF0aCkuIFNvLCB3ZSBuZWVkIGEgd2F5IHRvDQpub3Rp
ZnkgbWFjODAyMTEgdG8gcmVmcmVzaCBsYXN0X3R4Li4uIEkgdGhpbmsgbXkgcGF0Y2ggaXMgbmVl
ZGVkIGZvcg0KdGhhdCBjYXNlLg0KDQpSeWRlcg0K
