Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098B6F2044
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 23:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbjD1Vse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjD1Vsd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 17:48:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B342D48
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 14:48:31 -0700 (PDT)
X-UUID: 68829758e60e11edb20a276fd37b9834-20230429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=OrCGT6OX0SIj4kaD+ZcIgWCQ5eCBqv8fDgTTzRv10yo=;
        b=WdJWZrRCDnxr25m5nVpTXvDIpBYZgUJXjyrhXXMbQfmBjOLR8xvHYx09BKeHAquwohFXPAMCK06ItrYSVhKxGqsM8EO39q7IBBc8aQIH8zuUVl9rE7TKubnqD9odXscYFTT2E8bTKKb6fXmaPcRY+4bhfTnOYILdrHMMpsg5Y5g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:9477721e-bb62-42a9-a061-03236cf82175,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:18b5416a-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 68829758e60e11edb20a276fd37b9834-20230429
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 998686859; Sat, 29 Apr 2023 05:48:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Apr 2023 05:48:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Apr 2023 05:48:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnuSl+G52Cdhr+/A09zM7XCAKRmZfUX2offB43qlL7PyMrB4A8nMawxrqKXDxhFS7pTZmxTFzxRybZAgUw09HeAFbkTC+MHS2Mwo2Zs86NXEQkRH33Kqy0Hug1tmMOifEnok90BStDy25HVZM4Ma/TVocB2GVzBohPLWlVvldnVmYtCsxrCBXsFZ+tlmG7YBlxRSGy0GET6C/+n6ItV3pHH3l+jzz0H+fqjPJbmdyKPfimnEZnOMg9/UGOoFiMQ5I+nfnSfeWyHfHOlGDL9UFk95GKr/9Nm04GJy9QuJ9FjKI2AcPeUPYZy0ibaS3K8PXpkDaRDFGb8qRAVx/uusOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrCGT6OX0SIj4kaD+ZcIgWCQ5eCBqv8fDgTTzRv10yo=;
 b=PzTjsFFe+oXJ4Kb0Tvv0zIRGH+s2NYj+Bt5Ecj3eVDf5FMrTndhJIoc128voiMBSGsYfiCclJdq08DBQHr0l7cyVdwC6hGd8oKRHHmCOaQofUniBbiF/qkV1BY+t2yiOhaqnkvGDNmEuqy3bYUBcfMQDLA5Zqd9MSIKTfsplRb5OqVLDeLd9XR4hELNZ+DEUGlRoQ6nucsRO1P/2Fk8wavLhsbOefUTK7RQlm2DthFc0UcEvtwNwbfZtlvxsc6jataRSUP7eGu/R2qCiS3DSImfxjM9w44pzGvxaeNrqgXLiCE2K5vvvMMo69lwXupWVlBHReMOJy0S8fcAosWVoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrCGT6OX0SIj4kaD+ZcIgWCQ5eCBqv8fDgTTzRv10yo=;
 b=kfptpZSfw9hYLGYXOF+mlltBUpRs6EbPQ1hqHRbi6EVUT8BT/YfheBj4InHv2BZnLZNUsthRKq2j/pVBPykCatqxshpHPBeGP+ovnpqhVPceZP5CHNNG1RA/iCbl7lXZaLHsA/FIBf0bIwXqwpRa9DPNMEDPYByW0Pv9ij4FrkI=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SEYPR03MB7143.apcprd03.prod.outlook.com (2603:1096:101:d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 21:48:24 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086%3]) with mapi id 15.20.6340.025; Fri, 28 Apr 2023
 21:48:24 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "greearb@candelatech.com" <greearb@candelatech.com>
Subject: Re: [PATCH 5/6] wifi: mt76: mt7915: Improve monitor-mode flags
 settings.
Thread-Topic: [PATCH 5/6] wifi: mt76: mt7915: Improve monitor-mode flags
 settings.
Thread-Index: AQHZehMP3rthvbnXEUifcdISDI/pwK9BQiiA
Date:   Fri, 28 Apr 2023 21:48:24 +0000
Message-ID: <b57553ac83ab6ad3c6b998e99a2cd63eb3acfb24.camel@mediatek.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
         <20230428205000.2647945-5-greearb@candelatech.com>
In-Reply-To: <20230428205000.2647945-5-greearb@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SEYPR03MB7143:EE_
x-ms-office365-filtering-correlation-id: ba4a303d-1123-41d7-d743-08db48324aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOXA/mi6xhXNT9DSZUz24N3j7a4WCZ0IxlJHYb0XdvjvNFU302u8ImCaoIUlgLpNBo7u5If8JF/wYX7+I0XwEFmMgS+olrA2KCa7uK7s+OBzAvfT7oHT3e9UiIZKSz7fuhWR26n2Bry+gPItqTLcPsSphKkSHypclcvpQog9+IzgB2HeULvyKBoT04mi9bFqUKGwVZldZr3LK39bX1QMyGLgH5X6i0MErplc3CoTO2wmd89KrIPL4WYohuazo9PqTdJov9fAv/m347MZYAK9e1k7IBBYJ0q8eHRvqA1R3G88zxmQLXRaqy+s/km1AxyxK3GAkOn58IiZ8vxfF7ucihSRlgvm6J3oOvKGDADw66L6X0WTdM+PCqs0pN+34Ou0Jdh9mWr5Pl7gWOcLspJadZGjuZqef3x9SkKltind6o6y+20OPlEBDyalC3ZK4mGahZl6r+j25kOSVogwQ61sAv06GEEUrHUkoImqWNykK8I0XiOUQ3XxgTCVONBFIN9Rm/5LFw+VPWDtK5YJBdir+WIqbdfLTfn7jGdHANFuggUAtHLva1H+l8MxlGGeUG14hHvvz49pWrwR0VV1hwjfBKZLcYLsahu6OJ8LNJho3bN9REMei7vZ3oL4ToCR6m8l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(86362001)(2616005)(38070700005)(66476007)(316002)(2906002)(83380400001)(66946007)(64756008)(66556008)(66446008)(76116006)(186003)(71200400001)(26005)(6512007)(6506007)(5660300002)(36756003)(6486002)(38100700002)(110136005)(8676002)(8936002)(122000001)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVdFcVVjd05aV2Z2UitqL3IwR2RnUUVIL2xCZWRmbGhiUWVvUUNZaGovS0FV?=
 =?utf-8?B?L1ZyZzNySTRTMFJhTTdMODNma3Vic2VSUEcxTmlKdWhoNlo3dWZHZzJ3dTlZ?=
 =?utf-8?B?ZWhYSVRXM29FVzZidzhnWUJEZnNTbkVtS0VDR3EwZ0loeC9pRnBtcU9yb01D?=
 =?utf-8?B?WHgrMFlWQ2tMU1FuYXU5WnhWcWIwN3oxeWowaDJwdnh0TXU2ZGlPb2tuaCtV?=
 =?utf-8?B?TWVUZ2wraFYvaHh1UE9jMTU5cVdtR0ZaNEJLUlRKNGdmdmJPMUs2R1JTaEVK?=
 =?utf-8?B?U1BMck90NFNLQUI4S0E1Qi8rdmNwa3dCa1Fjc2xNTHB2SXhjRXNNeUEwMlNG?=
 =?utf-8?B?bXRwVWlFZVNCZVN4MVArZ1hrZmY3ZlZnSFkvbDBKY3dHRTRoaHgvbkdVVzVI?=
 =?utf-8?B?NXhmL2NpNUk0d0hiamlnRGlGbjNLYmZaVjNBTkg2M1MvYWxQVmZwZ0t5Vzdi?=
 =?utf-8?B?YnZtcHhmRnp5V01idEdiVXlPSzFnekIwbmpBWk1GZW16eUtxTjQ4YVdSMlo0?=
 =?utf-8?B?K25kQVhVVUNPd3ZUVXZVT0dTSzVycGUwTXZ3YVlmdjh0VGNPZEhka1E1ODMr?=
 =?utf-8?B?V1R2K3NuOHUrT1MxVmdpMWlXdmhMSXRvV3B0SzRzVDRqZFdsNTFQTEpTUHVS?=
 =?utf-8?B?czJEZEYwWG9HQVhGckFuNjNLS2tYZmYwR0JTdFRpbklYN2VJZVljWWx0MjJC?=
 =?utf-8?B?QnRZRkU0aTE0ZE0vTEpUL0hzZVhreTB6MVhLTjd6Nml3UEc0V2JaZ0oyWU8r?=
 =?utf-8?B?d2dRMXEyOThmRS9NT2ExQitmV2Mvc2F6bUpseEJzRUx1alFyenZSQlYraUVs?=
 =?utf-8?B?YkFQaEgxZFVtMVlrbUFXeTg1bWw2ZkVRNEJiRVhUUUdpZWZJMnZISytKZ3hQ?=
 =?utf-8?B?QXF1WlV3dzNEenBIVmFkalJ1MUp3cXpJTzhvOGc1RVlWL0h6cFNPd0lBSXhD?=
 =?utf-8?B?SEh6Qmd0UVhCNVlJYWtYdkttV1drTFM3TzZ6RmtLVXNxSUlwZE9VVi9UZjMr?=
 =?utf-8?B?UDgwQS9FS0hpckx1RUVSZXVTaWJ2V3FoY1IrMy9ON2N5Ykh5aXJNSVRPMDda?=
 =?utf-8?B?MWZkSE5KbndyUERqcmFoZjMvN09OaS9yTVBOMGI1aCtEa0ZZU3d2U2sxYXdG?=
 =?utf-8?B?S0E4S0tWWUhHTjg2NTVsK3dSR0NzdUVHQ2NLRjVFSE53TGRobEJ4SkFrSzh1?=
 =?utf-8?B?REw5MC9YZkJNLzFsVUoxTmlaeUk3aDJUNVBZR2NHYVAwR0NjSXRJYlVqeU5O?=
 =?utf-8?B?YnJWNmhaZUwxZWNZUzNlQXJuSFc0UHhlTVlEdzBOaFQ0TE0zZERwdlpTNFBR?=
 =?utf-8?B?N2xsays4bzZWbURUaU91TEo1aTZsRzY3TEMyYnczTGduYzFoZTVDVUFWY0h2?=
 =?utf-8?B?NWgrVnhlQWxMdlJEelhaWHNUWG4wc1g0S2d5N1FwOURjRFQ5NW5QQitkVkI5?=
 =?utf-8?B?QkxYNmlXbGo5ZVEweUJILzA1WHlPa1M3UGl4YkZIK1RpTjVhdU1qNk0xbFFH?=
 =?utf-8?B?RnJ0TkpPNkJzQi9HTUJKaGlNTWdJS25CcDBzMm44V2hlcjRjbFlRRGlSRFlq?=
 =?utf-8?B?dWVUc1FENUJFOWVSM2lzNzFyT0thSDVhNTYzWWlPeW5IZW9Ka3RzQnEwRnBE?=
 =?utf-8?B?YUZVL3IzRFg2cnV2TkRRWVlmS1hzenN1REZaek5sUDRoM0lSankzS1hJNE9r?=
 =?utf-8?B?N3VXVi9xbnVNUDkydXBsc2EvQVk0L1NhMlBBRU5nbTQ0eVhNdVBrcmttanJj?=
 =?utf-8?B?VExWWkMwOVdNdGVoZGwzcmVhZFR1YUJzTzBHK1M5ODJuL3Z2Vlo2aUFKYTRQ?=
 =?utf-8?B?K3Z4TnpRM1U2dWZMRVdYLzgyT1JyaXZxcUpnOTgvVCsrTFpNUWFuSm5SUjln?=
 =?utf-8?B?NUpKWDNvem4wSFZUWVZhMkhWR0RGL056a1JwU3R3T1JGeTIxcUVYM2xCazdy?=
 =?utf-8?B?QmxSYlUvQmNpdnVZS0VzcVFwQTZodkwyMVR0cVE1TC9EMHVYdnV4QTNEZzJM?=
 =?utf-8?B?MklraHorVUlSSktGb041TVNvK1JTUnUxV01jd0pmek1CaTcycEVSSHp3WEs0?=
 =?utf-8?B?SnFoQ3ltcDBIcDh3YkxMNDBUUnB0UGF6Q0RnZGxMbG5neTNsbE5pTkF1a202?=
 =?utf-8?B?bWZOOGdXWk93bE0vQWlMTmRNZDVjUDdCeDlzdUtQVjVnZUdTUjAyWDNMK3dr?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B8067C5F760F741929CF4CCDFD8219D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4a303d-1123-41d7-d743-08db48324aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 21:48:24.0893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpDWF7Ep1mb9lsRmeHvUa3pgc+D4xGTGeHQ45yIB8I9bMgCDa9TsP4XL8b4KBj7Byjk9stdWPeeYzW5IdaWVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDEzOjQ5IC0wNzAwLCBncmVlYXJiQGNhbmRlbGF0ZWNoLmNv
bSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBGcm9tOiBCZW4gR3JlZWFyIDxncmVlYXJiQGNhbmRl
bGF0ZWNoLmNvbT4NCj4gDQo+IFRoaXMgZW5hYmxlcyBjYXB0dXJpbmcgbW9yZSBmcmFtZXMsIGFu
ZCBub3cgd2hlbiB0aGUgcng1IGdyb3VwDQo+IG9wdGlvbiBpcyBhbHNvIGVuYWJsZWQgZm9yIHJ4
LXN0YXR1cywgd2lyZXNoYXJrIHNob3dzIEhFLVRSSUcNCj4gYXMgd2VsbCBhcyBIRS1NVSBmcmFt
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZW4gR3JlZWFyIDxncmVlYXJiQGNhbmRlbGF0ZWNo
LmNvbT4NCj4gLS0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21h
aW4uYyAgfCAyNg0KPiArKysrKysrKysrKysrKysrKy0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L3JlZ3MuaCAgfCAxNiArKysrKysrKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4g
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4gaW5k
ZXggNjRjMTRmYzMwM2EyLi41NWFlZDNjNmQzYmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KPiArKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4gQEAgLTU2Miw2ICs1NjIs
MTIgQEAgc3RhdGljIHZvaWQgX19tdDc5MTVfY29uZmlndXJlX2ZpbHRlcihzdHJ1Y3QNCj4gaWVl
ZTgwMjExX2h3ICpodywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUjFfRFJP
UF9CRl9QT0xMIHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUjFfRFJPUF9C
QSB8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfQ0ZFTkQgfA0K
PiArICAgICAgICAgICAgICAgICAgICAgICBNVF9XRl9SRkNSMV9EUk9QX1BTX0JGUlBPTCB8DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfUFNfTkRQQSB8DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfTk8yTUVfVEYgfA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBNVF9XRl9SRkNSMV9EUk9QX05PTl9NVUJBUl9URiB8DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfUlhTX0JSUCB8DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfVEZfQkZSUCB8DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfQ0ZBQ0s7DQo+ICAgICAgICAgdTMyIGZs
YWdzID0gMDsNCj4gICAgICAgICBib29sIGlzX3Byb21pc2MgPSAqdG90YWxfZmxhZ3MgJiBGSUZf
Q09OVFJPTCB8fCBwaHktDQo+ID5tb25pdG9yX3ZpZiB8fA0KPiBAQCAtNTg3LDcgKzU5Myw5IEBA
IHN0YXRpYyB2b2lkIF9fbXQ3OTE1X2NvbmZpZ3VyZV9maWx0ZXIoc3RydWN0DQo+IGllZWU4MDIx
MV9odyAqaHcsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1JfRFJPUF9C
Q0FTVCB8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1JfRFJPUF9EVVBM
SUNBVEUgfA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBNVF9XRl9SRkNSX0RST1BfQTJf
QlNTSUQgfA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICBNVF9XRl9SRkNSX0RST1BfVU5X
QU5URURfQ1RMIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUl9EUk9Q
X1VOV0FOVEVEX0NUTCB8IC8qIDAgbWVhbnMNCj4gZHJvcCAqLw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICBNVF9XRl9SRkNSX0lORF9GSUxURVJfRU5fT0ZfMzFfMjNfQklUIHwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUl9EUk9QX0RJRkZCU1NJRE1HVF9DVFJM
IHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUl9EUk9QX1NUQkNfTVVM
VEkpOw0KPiANCj4gICAgICAgICBwaHktPnJ4ZmlsdGVyIHw9IE1UX1dGX1JGQ1JfRFJPUF9PVEhF
Ul9VQzsNCj4gQEAgLTYwMiw4ICs2MTAsMjIgQEAgc3RhdGljIHZvaWQgX19tdDc5MTVfY29uZmln
dXJlX2ZpbHRlcihzdHJ1Y3QNCj4gaWVlZTgwMjExX2h3ICpodywNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBNVF9XRl9SRkNSX0RST1BfUlRTIHwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBNVF9XRl9SRkNSX0RST1BfQ1RMX1JTViB8DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTVRfV0ZfUkZDUl9EUk9QX05EUEEpOw0KPiAtICAgICAgIGlmIChpc19wcm9t
aXNjKQ0KPiArICAgICAgIGlmIChpc19wcm9taXNjKSB7DQo+ICAgICAgICAgICAgICAgICBwaHkt
PnJ4ZmlsdGVyICY9IH5NVF9XRl9SRkNSX0RST1BfT1RIRVJfVUM7DQo+ICsgICAgICAgICAgICAg
ICBwaHktPnJ4ZmlsdGVyIHw9DQo+IE1UX1dGX1JGQ1JfSU5EX0ZJTFRFUl9FTl9PRl8zMV8yM19C
SVQ7DQo+ICsgICAgICAgICAgICAgICBpZiAoZmxhZ3MgJiBGSUZfQ09OVFJPTCkgew0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBwaHktPnJ4ZmlsdGVyIHw9DQo+IE1UX1dGX1JGQ1JfRFJPUF9V
TldBTlRFRF9DVEw7IC8qIDEgbWVhbnMgcmVjZWl2ZSAqLw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBwaHktPnJ4ZmlsdGVyIHw9IE1UX1dGX1JGQ1JfU0VDT05EX0JDTl9FTjsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcGh5LT5yeGZpbHRlciB8PQ0KPiBNVF9XRl9SRkNSX1JYX01HTVRf
RlJBTUVfQ1RSTDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcGh5LT5yeGZpbHRlciB8PQ0K
PiBNVF9XRl9SRkNSX1JYX1NBTUVCU1NJRFBST1JFU1BfQ1RSTDsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcGh5LT5yeGZpbHRlciB8PQ0KPiBNVF9XRl9SRkNSX1JYX0RJRkZCU1NJRFBST1JF
U1BfQ1RSTDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcGh5LT5yeGZpbHRlciB8PQ0KPiBN
VF9XRl9SRkNSX1JYX1NBTUVCU1NJREJDTl9DVFJMOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBwaHktPnJ4ZmlsdGVyIHw9DQo+IE1UX1dGX1JGQ1JfUlhfU0FNRUJTU0lETlVMTF9DVFJMOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICBwaHktPnJ4ZmlsdGVyIHw9DQo+IE1UX1dGX1JGQ1Jf
UlhfRElGRkJTU0lETlVMTF9DVFJMOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBwaHktPnJ4
ZmlsdGVyICY9DQo+IH4oTVRfV0ZfUkZDUl9EUk9QX0RJRkZCU1NJRE1HVF9DVFJMKTsNCg0KRklG
X0NPTlRST0w6IHBhc3MgY29udHJvbCBmcmFtZS4gSG93ZXZlciwgbWFueSBvZiB0aGVzZSBhcmUg
bm90IGNvbnRyb2wNCmZyYW1lcy4gSSB0aGluayB3ZSBzaG91bGQgbW92ZSBtb25pdG9yIGRlZGlj
YXRlZCBtaXNjIHBhcnRzIHRvDQpJRUVFODAyMTFfQ09ORl9DSEFOR0VfTU9OSVRPUiBtdDc5MTVf
c2V0X21vbml0b3IgYW5kIGxlYXZlIHRoaXMNCmZ1bmN0aW9uIGFzLWlzIC4uLiBhcyBteSByZXBs
eSBpbiBbMi82XS4NCj4gKyAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIHBoeS0+
cnhmaWx0ZXIgfD0gTVRfV0ZfUkZDUl9SWF9EQVRBX0ZSQU1FX0NUUkw7DQo=
