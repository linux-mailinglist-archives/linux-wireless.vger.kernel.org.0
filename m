Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F09636A3E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 20:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiKWT4p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 14:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbiKWT4X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 14:56:23 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4ECB57
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 11:55:48 -0800 (PST)
X-UUID: e5e406f8dc744721abdc7fa7aacfebde-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Z1vO7+yR2dCvjLwUYYuKxEqOFGRLD1T3T9s8Ns77kvg=;
        b=jKplH1QffC4/xNYDSoOV/tJtnUsdi8YirYxG+YVQdfNgzVQFsLN75EdicI4DPv5+EFMhaKVTxonJnjm0U+mrFnhHp6gVzNAOPWQwZ8eg0EyWOGFBMZ3r/vp+W+6TJh9Oz0iKp+Uy2HLxWMXft0cpv7llOmZtrO9oHJgxcKW7dRk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:ee0419d6-1ec8-41e3-aa43-540d4a44d832,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.13,REQID:ee0419d6-1ec8-41e3-aa43-540d4a44d832,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:4dc80ddc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:2211240355453SW3I21X,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e5e406f8dc744721abdc7fa7aacfebde-20221124
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 836283677; Thu, 24 Nov 2022 03:55:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 24 Nov 2022 03:55:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 03:55:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAtmxNulQGB3DdBVRFoRqE6L7Gwqplq4AYu8kxFpKjokP9mWtxCuB2uDKYuzVoKEeextIwyIAQXiMpXPQ53V6NkkMtZYerZMyp6JhSr2SqB0Tn9rVoR8pmIxByoGE1G3GKZJtJ/9OSG4mHTxeXGSgokdhm6nLOW3LuOYfWYrDcOEN62yYbaw58WlRlOsdVeRu8JbKQzq/EHeiU70ZFjoAfKyuzLqIpnWjLpybId5IM1oNh4yGn3FKwAQdMQ4428x98lAFL0eWNvNWQU7Y8DTl1o3HUswGTPPIu8L5c2tqCPv3ze4QfqIPIPaeZiRwJYQvT3OCKq13Y1EAc06Mp0ldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1vO7+yR2dCvjLwUYYuKxEqOFGRLD1T3T9s8Ns77kvg=;
 b=BZP/8wD091X5/i3FvvEGm19VTrx7tjB1edgx1a88VkfZ2HLq1dFyIMLBJ88RzR/cRQxu/hjkylHAkp7OQjD5M92pZdnDT/WbbjGEV+DLcs3P/ly2Fxt/TdrEIJJ0A/JJC5s9XZ2Zzi+yox1xWtpKjU8h2klzq86Wj6QTJa0KybFxE4hQIEvtRw9ST95Nl12hI/Iw4MBh0pjVY+W0Y8wdVoKHBX7OtdSUjd1sBvl7Uix8PW8dst+AVeXNW5OkPPSd5hs99maDznbPC/RGjv6QxzJXokc2OB9GJ8XsDcNFg3G7ZjgFsKd/knKG0FOLtfImqPVY9QIV5ksUKBOl4QSjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1vO7+yR2dCvjLwUYYuKxEqOFGRLD1T3T9s8Ns77kvg=;
 b=lgZXjUqDk0m6d+trbjylsn9keZ+uUrlkmNvHtmFHOQ9IpB+vkCiDU3KQsK4m3i0ysQMfJ8r+NE0oXuKE7N+AwuddXb69wYrc+i3V+qUIK9ov9wI2P8z3nHO/1Ulzu5GehsVGfdzOUUiuDJ5vEPde5BcJgxNUqlA27z2uJv2rSHU=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SI2PR03MB5803.apcprd03.prod.outlook.com (2603:1096:4:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 19:55:38 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::3c4f:5697:636e:56e6]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::3c4f:5697:636e:56e6%3]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 19:55:38 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
CC:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH 2/2] wifi: mt76: mt7915: enable per bandwidth power limit
 support
Thread-Topic: [PATCH 2/2] wifi: mt76: mt7915: enable per bandwidth power limit
 support
Thread-Index: AQHY/3MU1MYnNywkV0icsCSeOCoQDa5M7DUA
Date:   Wed, 23 Nov 2022 19:55:38 +0000
Message-ID: <66734e5e335cb54eddda1eadee727c352b595486.camel@mediatek.com>
References: <9a67f1617249be2c73bb5900d2df971b682f8772.1669229848.git.ryder.lee@mediatek.com>
         <cd182c0f1234bae73a103889357bb84402fa8007.1669229848.git.ryder.lee@mediatek.com>
In-Reply-To: <cd182c0f1234bae73a103889357bb84402fa8007.1669229848.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SI2PR03MB5803:EE_
x-ms-office365-filtering-correlation-id: e49c0ce8-f110-49f3-57f2-08dacd8cb1a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtHlJZrHBU6GlcmsCxmoRrmTHiaqyz/jHow+cvACFcFvmDLARniRVwNjrTygPvryUBwwvpTxT3ZqngaozEO4kOqwbjqXzgqnKhu/9sSeKc0zCbVEQ4rJuxJHkAEgBpxAsfWTV2qXwmpLZMXPeI+eYz3JOU9CG7O39rf6ltNuJvFJfH/219Oss+ZCxyw9S1SDzVoV5yZ4jz6KmbbpcB0iRGr3md/CI/Pl8x1ARBhYxlEajIfV7btIjC+Jl2TG5lvOu5+KIM9YCg2HK+hpmlu8viIOBEdR6dHRJX3erq7BqVDu+0e9ZrXh8RtwMRLIUKsJWir/bjkDpUKLZjG9ccEqlCP8IdwsJhnR/jqpqzeEEGWTFnbPTwhrT6QLyHQjO5UEEr3rTbbs7jISPld6JNzJ3b68XjwXQ9NUV4WMKskKszkoFyn3whB4hIj2/2I8WjDdwUi8HN6gJLAZBvPlypSE+iGAUMMRr4lsAA2eqVEx8PhHLakCs3SIp5mcCu/C6iRmqWReBGLhbPiK7uhty/VU7uQpSC6XWSrDSDwldJ9h7lquzcaXdFyw6wEV456irwIz5+ku5r7GRg7InvKFHh+ilrsjf311bCRip1nS3Cn1Fdxf1hYUebwtVesYfmLK3O380uXiT/w6k2j/vubEEX1LRbv99aV2c53iE26yVBXkk6DG9w1IW/q4RgnVBhMN0WgHb2doObgwEfpKYkyIkpwiRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(2906002)(8936002)(4001150100001)(4744005)(2616005)(66946007)(41300700001)(54906003)(316002)(110136005)(83380400001)(66556008)(4326008)(66446008)(6486002)(66476007)(36756003)(76116006)(478600001)(8676002)(64756008)(26005)(186003)(6512007)(6506007)(91956017)(71200400001)(86362001)(5660300002)(107886003)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTM1anFRYTRicGZIdTBZSy9xSHIxb3kvbDMzL3NjNG43MENDQXhuTUpkNHI4?=
 =?utf-8?B?QmpVRUJKSVU3SzRNRXFqL2xacEU1TEVxc09DbXVMN0hJUS8vSTJiQnhDZFNR?=
 =?utf-8?B?SnlXa3J5ei9QeGdWVngvZzlQZlFBcWdqaUZOL3RZcXFNTC8zYUxLVDJTQ1hE?=
 =?utf-8?B?ZU05K3hBRmtTamhQRytnc0J0RWtVa3R2S0xiYVZEdm9SVzV6TFNuMkcvenFi?=
 =?utf-8?B?aEVOVFhEWEdWSjg1Q3RSdXpaV1JXN1FGUmY5U2xDYlBoaHZrUDl1OTh2NjMx?=
 =?utf-8?B?Vm1YdTVTaEN3dmhicXN0Z2RmSU4wUzNHbXBZTW8yZlVybkxyakdCVkQ2Ri9o?=
 =?utf-8?B?NnRDbTdYcnBaQ24rZ1NaYk44UUpLVlVBTmEvR1JzV2tETW9jNjVFcE1zMFlx?=
 =?utf-8?B?VXlWWkkwWGhSdHZkZ3ZxMGVYQzdhaHZUalpiYUttcGhDQUVYSk1IM3h3VWkv?=
 =?utf-8?B?VHRNcERBbjk5N3Z6OEVtSkRUY0JaTlJyZkVjUCtmZkFQM3FjZXlYaWRUcHIw?=
 =?utf-8?B?amdzOWY2b1BXNTcvd0M5dCs2LzVSb3d5ZERSME9CZlZmL1dMNEFSV2NSZTFp?=
 =?utf-8?B?SXdHWitwZFdEZ2V6K0xmRWt6dFVNMlhNRkdwU2Y1QllxSWwzSG05WExGSGl1?=
 =?utf-8?B?R3VmVmZRRHd4RndMUEk0NlJCZzRTUTFaY2kzVnVpNTMxV0ZKc25jbG1RMGta?=
 =?utf-8?B?cXp1WlZiRm1TOVBtdGRZZDhjSUh2STFqeTk1R2ZWVWV4UnA0RTB0V2RaK3Vm?=
 =?utf-8?B?dGFmSFNKL3FvV2xiUzdrckVjbWRZckxEeG9kWlBuKys5N3oya3RKZ1JjamJE?=
 =?utf-8?B?K3hTOWpoUnVaVnhGU1N1VG81ZmFMMFZiazNRL2liSzRqd2pqWjBROHZ4UXJZ?=
 =?utf-8?B?TGgyRXBEbXN3YnYra1ZpM1JoRXMxSHg2bEVnaVljL1dXYUJ2eG96VThJZlhz?=
 =?utf-8?B?WGs2T2xqK1dPR0xvN1JTSW5FWkdZOTdUK1luYzlQRkJ5OXp6amp6NVBIdTZr?=
 =?utf-8?B?TE9mNGxmSnNFZHo5YlJTVnl3cHVyMkZseEU0Q0doeVpaUTVwY3UrMFRUT2Zs?=
 =?utf-8?B?MUdrVldJRmJqdCswVG1oalVuZFBWVTBUT1JJUFRSSE1IWXpMZzhZZ213Tlhy?=
 =?utf-8?B?RmQ2VldPc3IvUVZLUURnSHRxeGlxTFRpem9lK1gydTlOSlAwVFlsQ2FiYzdk?=
 =?utf-8?B?RUNxdFhyNnFJRllMNW0rcnRXeXJPODBFcUo2SENTSXBUek10dzVTN2tGblF1?=
 =?utf-8?B?RUs0dUdCcVVya2ZEMUwydTMxZHZDRlphc24rc1dhSDBoaElyUHd2MDEwdnA1?=
 =?utf-8?B?ZGN5UmxuTmZEV245QnhOTi9NTVRVd25XWnFHSmpOS2JmOHB5QzQ1RmFOUjFE?=
 =?utf-8?B?TThPYjcvZS8xblpiNVJMQVp4NFVGdThoTzB4YTJXaVFtV2Q1NkZFdXNzOW1K?=
 =?utf-8?B?NmhSOStvRlRyVkFkRE5xMlFFeDFJQkczRFpUUGlHVUxSd3YyM2xoSVhpaWlj?=
 =?utf-8?B?NGVvTFlwQ1JOSFRFNTg2bGFJK2pRQkhud3pUWmRFYTNvUUs2MWdwNlZuaFhP?=
 =?utf-8?B?cjdzdGZpRm5JaE9tdGh4aUxVd25GY3ljaTJ3alQxOWVQRGxTYzlob2NFcGI1?=
 =?utf-8?B?Tnk1c0ZRbktoVmdhcFUrY3hIM3VFWFJxQWdBOTVObVlFWVp6bTBvWUVYdGRy?=
 =?utf-8?B?b0JsZ2xydzhxSDgydVJ4UUdEd0l2STFvbEduM0dSbE5KSm5ueGhidUJZbFlu?=
 =?utf-8?B?Y01sU3NrUTlmTVJCc1FZNDcyeHgreStOSjFSMjVWME5PRXNsd1Z4NUF1RHRU?=
 =?utf-8?B?K3hvdHNxemhJdytjNWJZNk4yL00wbGwzMS9jNWxWemdRczBHNWxUY2s4cmZu?=
 =?utf-8?B?c016UHZhakx4QldVd2x6RkgwNUVtQW9Sa3V0ckx1RzAxcFNOQnJjMVFTRFhz?=
 =?utf-8?B?bWdTbWVSR2EvempXR0QzRUxaNGxCVllwZlZ1TnI1ejJEaVQ4dHlrTzB0c0dU?=
 =?utf-8?B?YlN0bGpxWlhwZ2VPVWtTNWxTei9WdzFzNlNJZ3NRdDJvSmNCd1l1d0dIRGc0?=
 =?utf-8?B?aG1zS0FGOW10SCtYK296S0dYODB5UW82OVVaZCtGcUdudWp5R0ptZkF6WXkz?=
 =?utf-8?B?V2JTSzhleGQyQkVYUG05ZVhxanNNUW0xR0h1MEZSTklBenAzc3FjbUhCOFN6?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9064C5311CB6904BAD9017C51F70D90A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49c0ce8-f110-49f3-57f2-08dacd8cb1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 19:55:38.5749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTMOMAf3+2/cx9zxohKMMIUAM62wDyemN4IHCyAO5K01lEe3dCRObiE+aA2q4+txmjtjOr3pgcXbRXYWaiX+PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTI0IGF0IDAzOjM3ICswODAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IFRo
aXMgcG93ZXIgc2hvdWxkIG92ZXJyaWRlIHRoZSBwZXIgYmFuZHdpZHRoIG1heCBwb3dlciB0aGF0
IHRoZQ0KPiBkZXZpY2UgZW1pdHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5
ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgLi4uL3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L2RlYnVnZnMuYyAgIHwgMTk5ICsrKysrKysrKysrKysrKy0NCj4gLS0NCj4gIC4u
Li9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgICB8ICAgOSArLQ0KPiAg
Li4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaCAgIHwgICA3ICsNCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTgzIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KDQpQ
bGVhc2UgaWdub3JlIHRoaXMgb25lIGFzIEkgYWNjaWRlbnRhbGx5IHNlbnQgaXQgb3V0LiBXaWxs
IHBvc3QgYSB2Mi4NCg0KUnlkZXINCg==
