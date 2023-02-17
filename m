Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC67569B2CF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 20:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBQTCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQTCj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 14:02:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4C6185D
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 11:02:31 -0800 (PST)
X-UUID: 9f323952aef511eda06fc9ecc4dadd91-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JSdPPDqT5wkfUHJFPubibzlFej+hih854tqX2Wf9g7I=;
        b=sjUGtQDz1XtI8ruRQpfRs0COP4Xd/I0PC8b+mTdRUtyQGnBwgIcm+kNGFTGpDHDAVhO58OrACK3TJKJzRf2y6fEWHexLzmURQ/2pQ0LLX5Q2YG8XCMeA0bV09GHBDhgbgs8OFROCWdQ4jLtQPguVV++g6KulWoLSdWGl6bDM3zY=;
X-CID-CACHE: Type:Local,Time:202302180243+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:10c78447-04ee-49b2-ad19-95ef0f957005,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:f3c6cbb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 9f323952aef511eda06fc9ecc4dadd91-20230218
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2143362206; Sat, 18 Feb 2023 03:02:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 18 Feb 2023 03:02:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 18 Feb 2023 03:02:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKVwsG79WAbWlEj51C+48Is+8v14NUvulngnwMM92gTqVF30tURRbqSrIqpnVNffF+DpOZZo5vJon54HWIr0bd0NhStBX37GKc5Vt30zU9exObLHwXiGYQM/Puc+Mecp5m6DbaxrM7eobucVc8M2n3gAGf2eqUpvE4pS7btL2jSK5L7tsOD0exkXP4JUzaRfjspcIzCTrJoCM9DnRwV/mqLRi4dAA0XUMz3bfCS0aAqRtIAHYmWSv/ocE5Qt9ovfCqztHr+Hx5DyQCoJrpzVi3LWa9T8Z2WE6akM8tXLlZrdbEsvt2Hi5tU0Q5EF0Lg+aoAH0m4b/0JCl1sovh/PpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSdPPDqT5wkfUHJFPubibzlFej+hih854tqX2Wf9g7I=;
 b=Sg8G8MAEO115qVk9SaTbvsw0Yb/+o1YvKdXxkkIrqv4RdSDXUJsDooMXI5WCn/n7754v6iCKvZH+ram4Tm5RsrY45BjJNZwgdBK6q8Dxk4q66NAli/cHvOyp/m4O4buLkaGKEr+Q9kSn6CP986/ZBNI4QU17zdNT7Qpz2YAVRksS2yTIueoBG/3815URr6GzWTIyfRnnuUKQwHatNukeVqnIsy135+GPUIa8kV3vPMzNSputOptXDE5ZNyCxuCWBxGCqiCNyiVn20GXuio7FhKo2t+c1fPnJL7SkI877FIoM/HkrbH4Fl3ofo8lylchgzoFyf3pU3vBfaAI7w/UcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSdPPDqT5wkfUHJFPubibzlFej+hih854tqX2Wf9g7I=;
 b=thuMSI57p2clcB+snE4r8mbJBMOE23QFQc5ICmefYFoX2BrR9j0/qcOUQ3AUt3UF3SzxRZVwWgsfR+cnAKOeyqm1e4yuz8BuXHBi4CC+7FIGtUp1B3urMj3wSdwt2guETUoNdL55/diYLEmDPtt8b6GIZqNY2NkK6+ZD/9rGxIk=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEZPR03MB6960.apcprd03.prod.outlook.com (2603:1096:101:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 19:02:24 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::cdcc:fb2c:cc34:8360%9]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 19:02:24 +0000
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
Thread-Index: AQHZQvhNg/XMHPbh9UaJA+rO7kUbpq7TbbAAgAALzICAAALQgIAAAn+A
Date:   Fri, 17 Feb 2023 19:02:24 +0000
Message-ID: <56190740441a6740e9edf761ab2167edc51f20c3.camel@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
         <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
         <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
         <fb3ab2d925fdeae2e7cc778419c1476102b9f85f.camel@sipsolutions.net>
In-Reply-To: <fb3ab2d925fdeae2e7cc778419c1476102b9f85f.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEZPR03MB6960:EE_
x-ms-office365-filtering-correlation-id: 91eecb3c-aed9-4a85-1f27-08db1119813d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5CMMYRpXgBhEClBn8WtTbbinjpLocRNlwX2JF9Pp5E2YcoeRLvzxvqbkR4BmpGcttnIHOxJcHh46l+yaVIOzOpJdrY7ivFirX2p9Sto0dZ8UJf25VEipXU1n0BaIh3leV8Du2kKRcK06ZR31U0LM0KcNooX0Z1dYR0ObHTMS6BcwMXtU6H6lsvITnhX1s4bCpNhdNo2nckHPBYHFxP9+thsSasVcIeBYisZLkXGp6bFsoNwR68SHFSojXJnNcsNwVIqLzxpL+8WROmY+Mts4yNbucnIeNZdwzoiZk3P7WdJU03Gx1oSq2Z76saD2XJREkcnEm/REHgEp/vljeqCngebYm8Hcei66Ycwy11Z1D9gH9RxxX3wICnIiy6e6FgfFrNdm7rmByFm4bPlp5M/Ijc5352GDr7czuGr+Yt3/hnlYZTZkY7jZOso+DS2NoJGdZIAE6gT3Bet8o9XUEr62ObM5mrc1G8z91uwBbjl+Riz4fozb57+OxcuapYSFpoa5RryBn2pA3fRl3GTqYtSbTAnRJmoOmZtm24BLCmjUMrDg7s60yJsDoigVGoig4BRMD5MBNqXW3+3M6K629VbLdAZfsPagsb7RmqnbswgJYiCe6Su24DNuekBpwdVXLLWAH9ccPq1NfrFtWNrtNXsUE7CQBpRwWLGPg9Ux5bU2j62Mb543b0PRRFADw0jBs8lhkewl8HLDlzTdUYkbptJFdJ4QOmAJSLS3oppue37Du/5bZU55ZOreRK7GL6uK7oS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199018)(36756003)(26005)(478600001)(6486002)(83380400001)(38100700002)(86362001)(38070700005)(122000001)(107886003)(2616005)(6506007)(5660300002)(316002)(41300700001)(8936002)(54906003)(186003)(8676002)(71200400001)(64756008)(66446008)(66476007)(66556008)(76116006)(2906002)(66946007)(4326008)(6916009)(6512007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUtidTJrdGY3SnRNNE5ydUZIZDY4MGI0SEIyeUk2TFNiaVhpT3hsenMraGhQ?=
 =?utf-8?B?aUxtdnRpaDF0MXB3eEV4Z3NDQklUbWtuY0VaQVdZSWpSWTNhaFJZdkk2MjdO?=
 =?utf-8?B?S3lrdXF1bmNOUTFDeng4NWlRV0xDWWVqcE11U1ZXckY3YmhadnhyUkpGR28y?=
 =?utf-8?B?T0hBYmdNM0lnVGorRXNpZXU5TVg5TXdEN0E3Rlh6RTB6TDlXK2l6b0YxYkFF?=
 =?utf-8?B?MTVxeHhmYXZIaG54enNCRjI0cVNqMkNKZ0V3MkJ5WVVCdzhCSVk1T1R0ZWdR?=
 =?utf-8?B?clVXenVZRGVJSU1BMmlFWGtDZnpyZVpyU0FVbHphTUFMcVFraHU3K05DcGZO?=
 =?utf-8?B?TXREaW8vNk55RExzb1lTOEZGb0YxMkNpTnI3cmMzbTR5UlpwQUROUFVWWWx4?=
 =?utf-8?B?OUkvVHpBbU1pVEtKbEhxK1Y0My8xQ3hvY3BPR0FtU3RmMEg0RmU1WFhMcFRR?=
 =?utf-8?B?MFFwckR0RzJZdlNNU2ZNNVA4S1BtWDJNb3lTUS9WYlpzWFZDajBMMzdDVkIy?=
 =?utf-8?B?VkNjcW9VUGVRaU4zMS8xUE12bmZ0SzlYei82aFE2ODQ5Si80WmdCWEFkbklk?=
 =?utf-8?B?NTVETnpzeDhJTUE5ZDJQRGpERC9RbG43eEZRNnNGSnhtOFBuTmVBZ3BhZE41?=
 =?utf-8?B?VThYUFhXOFhKZW1MSHZCWmpvTFc3TFVtbGJzU295bjAwT0dONnhuUENwWVgw?=
 =?utf-8?B?MTFDRmVGeUtGcXFvb2tpZGRjZWp4M1IzS1ZIaVNWWTVwbEcwcEY2bEJtSjgy?=
 =?utf-8?B?ZG1VRjd0RzFRcXFaSS9nL1ZXWER1aXJ5c1A1OFlqUVVPZ3RXS0M1aU14cFhM?=
 =?utf-8?B?QVdadE94Smo2RWg3RVBod0xWWkZqdDJWZjRIbVNNRFZWcG12SXFPTlIza0s0?=
 =?utf-8?B?ZTdzSGZDM1k5ekFPS28yUm5MU1hnUEc2aG5FbnNmRkVWVGFpSGJsejlqMS9n?=
 =?utf-8?B?RUVxUXlicVRYV3NjZE93Uk9CcGNBMFFRY05XMGdyM0FpUllJMFJFTVFaTkJm?=
 =?utf-8?B?ZGhBSE9jUFFLWVE5YktDbm9ZV1U3OGhCZHRzVGVYYnlpMGZaVGZhZkVnQ2Na?=
 =?utf-8?B?YWFHTkFoSVUzUkxuZmtoeER3TnVFY2hQRXQ2Nnd3WmNBcVUrVGo0WGlhZFRz?=
 =?utf-8?B?a0JhdU8yRWtNaDVRUExFeFZCTVhxNXRUUU05QndZWDd0cmxicVpFQkpZTzJV?=
 =?utf-8?B?dVN2bldncFlNV1hjaUVVeS9Jbzk0V2U3Ry9lWE5JNE05U2lDMkswRmFoUnlT?=
 =?utf-8?B?aXcxYjVKend5VnJ6b3h1ck9HL2Iwa0VjMzk0bzJ5R3MveDlCblpwNHUzL0Fi?=
 =?utf-8?B?ckJoNnM0bm5qcW1VM3E4OTBhNzlJeFFrbUNqTUNMK0JjTWVETG9HT0UycjBC?=
 =?utf-8?B?QzNpc0l5RUdUeGNCNitBZlYrWVlHc1pDeG1CYS9KOTdEeGpZK0J2aTFZV1BQ?=
 =?utf-8?B?MHoxUFBEZ25HTVEyVjBkdzRoNmY0Rkp6MlBIdVUxUGdadzdDN2swWTdkOG1l?=
 =?utf-8?B?Tm1rSzd2MW80b2FLdEJ4aDdnNlcvZWVoZjNyZ1pjZDlzOTJiRzBRYlpFYXZP?=
 =?utf-8?B?RjVqT3Z2WU9XaXJUbFc0UzZrMzhLbXVGUExJME1vdTh2ZWdyQmVKRHdnREIw?=
 =?utf-8?B?aE15Zml2L2hPWkdURWFnQjVvRFNySktPc1BEejNQcVlqY0toaXBTYTVZRGMw?=
 =?utf-8?B?WWRrQjVpT3E2RmNHZlM2MkNkUUxYK1JCTjE3WWtXWXZMbnB3TVV3VmxaS1NJ?=
 =?utf-8?B?K2Rhb3c1bkVUMkZlYTFYOVpxYk1ad0duQmlWQnZrUTViV2ZZVkRVM2l0OEVB?=
 =?utf-8?B?RUNmU2RuT1k0L05tdDhnVXhvdFdLOW1kckcwazE3THRtd3BjajZrUmhxdFZt?=
 =?utf-8?B?V3p5U25kODN2dWE0TzdXanc5RjVLQ29uQXZiRndJSUR1NEZGcUJwcmg4c3R6?=
 =?utf-8?B?dnRqMjVNM3VSeWExMEUrbEgxbW9ld3ZSSkdZVUU3Y3hQdjVHd1Rzc20xQWJR?=
 =?utf-8?B?b1h0U05jS21URGxZYzgwNU5LZTdCN3o0bXBVODB1MmtaL3F5ZlRMZVdnZXoz?=
 =?utf-8?B?OWRPT0IzTWFyNDhOSXJ5OXRMbTQ3S3c5a3ZwZUxqSUEyQXo2NHRwN2UxaHBv?=
 =?utf-8?B?Wkd5cWFsVG9mbHBHQWNoaDNtcUd5RWwwbzZhSkRsTUI3QU5oT3ppQjlhVklN?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A96CD772A591C2489B39ADE526C4CF53@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91eecb3c-aed9-4a85-1f27-08db1119813d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 19:02:24.3022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qudPvtEYB6BeV9PPpOcKY5s4lui4gizKmR575QxDZVr/l5s/vWgQ5rdST7YW5ainfkoewomd23CLZP3nG1GkIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6960
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTE3IGF0IDE5OjUzICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBGcmksIDIwMjMtMDItMTcgYXQgMTg6NDMgKzAwMDAsIFJ5ZGVyIExlZSB3cm90ZToNCj4g
PiBPbiBGcmksIDIwMjMtMDItMTcgYXQgMTk6MDEgKzAxMDAsIEpvaGFubmVzIEJlcmcgd3JvdGU6
DQo+ID4gPiBPbiBTYXQsIDIwMjMtMDItMTggYXQgMDE6NTAgKzA4MDAsIFJ5ZGVyIExlZSB3cm90
ZToNCj4gPiA+ID4gVGhpcyBhbGxvd3MgbG93IGxldmVsIGRyaXZlcnMgdG8gcmVmcmVzaCB0aGUg
dHggYWdnIHNlc3Npb24NCj4gPiA+ID4gdGltZXIsDQo+ID4gPiA+IGJhc2VkIG9uDQo+ID4gPiA+
IHF1ZXJ5aW5nIHN0YXRzIGZyb20gdGhlIGZpcm13YXJlIHVzdWFsbHkuIEVzcGVjaWFsbHkgZm9y
IHNvbWUNCj4gPiA+ID4gbXQ3Ng0KPiA+ID4gPiBkZXZpY2VzDQo+ID4gPiA+IHN1cHBvcnQgLm5l
dF9maWxsX2ZvcndhcmRfcGF0aCB3b3VsZCBieXBhc3MgbWFjODAyMTEsIHdoaWNoDQo+ID4gPiA+
IGxlYWRzDQo+ID4gPiA+IHRvIHR4IEJBDQo+ID4gPiA+IHNlc3Npb24gdGltZW91dCBmb3IgY2Vy
dGFpbiBjbGllbnRzLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gRG9lcyBpdCBldmVuIG1hdHRl
cj8gV2UgY291bGQganVzdCByZXF1ZXN0IHNlc3Npb25zIHdpdGhvdXQgYQ0KPiA+ID4gdGltZW91
dA0KPiA+ID4gaW4NCj4gPiA+IHRoZSBmaXJzdCBwbGFjZS4NCj4gPiA+IA0KPiA+IA0KPiA+IEkg
dGhpbmsgd2UncmUgYWxyZWFkeS4gT3VyIG1haW4gaXNzdWUgaXMgcGVyZm9ybWFuY2UgcGVyaW9k
aWNhbGx5DQo+ID4gZHJvcHMNCj4gPiBldmVyeSBmZXcgc2Vjb25kcyB3aGVuIC5uZXRfZmlsbF9m
b3J3YXJkX3BhdGggaXMgZW5hYmxlZC4gV2lyZWxlc3MNCj4gPiBjbGllbnQgaGF2ZSBub3JtYWwg
NTAwKyBNYi9zIGlwZXJmMyBkb3dubG9hZCBzcGVlZCBmb3Igc2V2ZXJhbA0KPiA+IHNlY29uZHMu
DQo+ID4gVGhlbiBpdCBkcm9wcyBsZXNzIHRoYW4gMTAwIE1iL3MgZm9yIHNldmVyYWwgc2Vjb25k
cy4gVGhlbg0KPiA+IGV2ZXJ5dGhpbmcNCj4gPiByZXBlYXRzLiBJc3N1ZSBvY2N1cnMgb25seSBv
biBjZXJ0YWluIGNsaWVudHMuIChpLmUuIEludGVsIGNhcmRzDQo+ID4gQVgyMDAsDQo+ID4gQVgx
Njc1LCBBZHZhbmNlZC1OIDYyMzUgaW4gV2luMTEpDQo+ID4gDQo+IA0KPiBTdHJhbmdlLiBCdXQg
aG93IGRvZXMgdGhpcyBwYXRjaCBkbyBhbnl0aGluZyBhYm91dCBpdCwgdGhhdCBzaG91bGQgYmUN
Cj4gY29tcGxldGVseSBjbGllbnQgYWdub3N0aWM/DQo+IA0KPiANCg0KU2luY2UgdGhlcmUncyBu
byBhbnkga2VlcCBhbGl2ZSBwYWNrZXQgYmVpbmcgcmVjZWl2ZWQgYnkgaG9zdCBzdGFjaywNCmxl
YWRzIHRvIG1hYzgwMjExIGRlc3Ryb3J5IEJBIHNlc2lvbi4NCg0KQXgyMDAgc2VyaWVzIG5lZWRz
IHRvIHVwZGF0ZSB0aW1lciBmb3IgZWFjaCA1cyBwZXJpb2QgdG8gbWFpbnRhaW4gYmENCnNlc3Np
b24uIFdlIG9yaWdpbmFsbHkgZGlkIHRoaXMgdG8gd29ya2Fyb3VuZCBpc3N1ZSwgYnV0IG9idmlv
dWx5IHRoaXMNCmhhY2sgd2lsbCBub3QgYmUgYWNjZXB0ZWQgdXBzdHJlYW0sIHNpbmNlIGl0IGVm
ZmVjdGl2ZWx5IGNvbXBsZXRlbHkNCmRpc2FibGVzIHRoZSBzZXNzaW9uIGV4cGlyeSB0aW1lciB3
aXRob3V0IHJlbW92aW5nIHRoZSBjb2RlLg0KDQotLS0gYS9uZXQvbWFjODAyMTEvYWdnLXR4LmMN
CisrKyBiL25ldC9tYWM4MDIxMS9hZ2ctdHguYw0KQEAgLTU2OCwxMCArNTY4LDkgQEAgc3RhdGlj
IHZvaWQNCnN0YV90eF9hZ2dfc2Vzc2lvbl90aW1lcl9leHBpcmVkKHN0cnVjdCB0aW1lcl9saXN0
ICp0KQ0KIAl9DQogDQogCXRpbWVvdXQgPSB0aWRfdHgtPmxhc3RfdHggKyBUVV9UT19KSUZGSUVT
KHRpZF90eC0+dGltZW91dCk7DQotCWlmICh0aW1lX2lzX2FmdGVyX2ppZmZpZXModGltZW91dCkp
IHsNCi0JCW1vZF90aW1lcigmdGlkX3R4LT5zZXNzaW9uX3RpbWVyLCB0aW1lb3V0KTsNCi0JCXJl
dHVybjsNCi0JfQ0KKwkvKiByZW1vdmUgdGltZXJvdXQgaGFuZGxlIGZvciBheDIxMCBpbnRlcm9w
ZXJhYmlsaXR5IGlzc3VlICovDQorCW1vZF90aW1lcigmdGlkX3R4LT5zZXNzaW9uX3RpbWVyLCB0
aW1lb3V0KTsNCisJcmV0dXJuOw0KDQpJJ20gbm90IHN1cmUgaWYgdGhlcmUncyBhIGJldHRlciB3
YXkgdG8gZml4IHRoaXMgdGhvdWdoLg0KDQpSeWRlcg0K
