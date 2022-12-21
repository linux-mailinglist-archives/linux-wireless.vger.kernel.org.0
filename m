Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC36532A5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 15:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLUOsf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 09:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUOse (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 09:48:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF31A45E
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 06:48:31 -0800 (PST)
X-UUID: 8449e5aa312647dfbd66866473973f9c-20221221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LNq8lRfYasYgUUI1XoOXXNDV/ch+3+A/rhSdLhVHry4=;
        b=nw7ep2aJ6nLV/dPaduwTAhzN7OQ9ei5WeJVFDNnkTm0BcceUWVqj6szpEKgSaiYVW7bkMw1Zd7lL4SK3Ok2SE2sei5EOzcrNfX4Jqsn6yBCKg7/yrzUzCbK3WP3rMiudRNN0KRDpgVWPLwmsBtVJKsL5AKoTwRQk9d1KAxRL/EY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:bae4ad88-386e-4b1a-bcc9-be95a7cd3e8c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:9b10048a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8449e5aa312647dfbd66866473973f9c-20221221
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 528264144; Wed, 21 Dec 2022 22:48:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 21 Dec 2022 22:48:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 21 Dec 2022 22:48:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXJZtH5nuDcnQz+PRmkkoZ3/1SYsYDeo2Jj8uz0/+K9sk9isvakxPdChGJX7+uRrtuBH0UcUlmw5xqa90BKtyhGRTizLpnDgHEl8XMh1SqFXx68+77Zs2JzujysjLVfS0XaAmKDgb5/wgVife07cbpxoDfDM7gulrVaF1z/fPaTMN5pCnizwcNx8s3B51+nzxiKWGtU58mQXBfGu9yV8KuLIzhblJuzN0ZNMvUU8oIDFXhsgrxjv0Yd20w+njtZADQvb51UcHXfgbxVFfyseo94xtfDWyKTGKJNoLR8WPcARrv8c34tJ6aWic4hmIVXjs/0/VnSguNCFq+qDTyPFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNq8lRfYasYgUUI1XoOXXNDV/ch+3+A/rhSdLhVHry4=;
 b=SQ7U8gAID9f+Wz6hBTs3ibZMKJC7ZZ5AD6i9J9UJ70TMGyMufKdqBLSknefCweEvez0YYq80aUBKjaGPZcbkvo5OXMli7MsVYJPlaYQ5AFq4y/BeqnVFD2fMIl/4R5UtKqrmgeF9aWaSCeracbgjUBBP0fNv+TNTuZDks9j21GoQNTAyATQ1BYRePhlG3NF5z94F6aeOGWnVZ7lBuXZBwPhXNRgLJ3kxO92bhqSirdbixBZzgDgtig3Br7TsxdDUQ2VQFb8vLdG7Q4rKbwymzAg2+4z7E4sgIDS0plQdBWIiR3EKtIjJTHeP6qGO6I3QnvZsMOkHdFjxXrUA081Ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNq8lRfYasYgUUI1XoOXXNDV/ch+3+A/rhSdLhVHry4=;
 b=lWLc2fHVSefUSBd+s9NuohVfJPiJc/dRWuFSSufVzJFt4eEEMILMkm4O6Rr5lpgBKX/ZTaHxBIHxWA40dyP5+bhCp5yV6n2GdAKOxDP+ZwJaLTpXcfFW0h79+IwpRhD/1xWKyZ0aadfrQb62gcTWWnZOLg9OIhnkkaDH+59wsNk=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by SG2PR03MB6611.apcprd03.prod.outlook.com (2603:1096:4:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 14:48:20 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 14:48:20 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Topic: [PATCH v2] wifi: mt76: fix potential memory leakage
Thread-Index: AQHZE2UYm26GeWDuU0a5b6k/XQDcva50+UQAgAE64oCAAfJmgIAASTAA
Date:   Wed, 21 Dec 2022 14:48:19 +0000
Message-ID: <3940cc5ccb4b17d51b5176e722daef0d1af66d6a.camel@mediatek.com>
References: <0a218783098a6b1b90ff120c7182acee93dc8feb.1671423784.git.Bo.Jiao@mediatek.com>
         <Y6A1Et1yzcWnWhpy@lore-desk>
         <9d8aa92e3650128c94af91435a222c00ff2acb1c.camel@mediatek.com>
         <Y6LfTUoSZ8W/gJ0Y@lore-desk>
In-Reply-To: <Y6LfTUoSZ8W/gJ0Y@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|SG2PR03MB6611:EE_
x-ms-office365-filtering-correlation-id: bde30942-9b73-4e57-f006-08dae36266c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dKww4fN7dHztkjd6G8j1SQ/7KwdPgtHsbUAVtQD+dIXgePbXEUDSL6LaHWt86rlNDWYZaiJ0OkbWtG8Kwp6m7FIKik5QguqeWZY4sgN0Ny8HtVSzLCXg/W9QGjAYptkKZZnmnETK7IQg0BPjilX3HJGkbIUnfY/6Csh8LcBxJB5I9IrdftNa8/SzZ4OAMpthpgTV4Uu/TfChd3n98W1/RQejyQ4/D2zJCoc6yKAlpHaAWKlE1SqtTSKpw5pTylFM9bikPqzZVtDCS8OI6I7sXjA8lS5laCx+qSxuKMSOAHpZn+lBhGYSf91OmH6lN3K506eB78tVRbmmpse4XB46bV+YvL0tpO3nCdnRZUZGodt5k21PJgNo9MIfCUc94JW4X6WeZKUbNTIf8PQh05XPGog+kg1WyQnLqkDfZDNj+M8uDbjnYOk9fUVDX9VccuJlT2O7IsDyHLsGx88aTbDOtmdirlOlDvJry4FmvpZze2PyKLXMVm06yD8Baeym8N4r/1mHKVRvEURAu3kLTfXhgKjzAAD0n73N9MXeKsdKT1zSEMOLCMHFXFocbQZ/s5eEKMjvbpcyS5Hqp+VuW3L8grK/I21ZRcXLbnVe0KvGH7iuuRELY2XDYa2R1x5JXjVzJax8zD0eXn/k+mUAxbRWGdY5jFfbZChGy2hvrE+Q2mBzBSIJyJ2EnItGV0G0Un+YG94cW4y+/RxglqjAKHYjbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(8936002)(5660300002)(66476007)(6506007)(6916009)(66446008)(66556008)(8676002)(66946007)(64756008)(76116006)(4326008)(41300700001)(86362001)(478600001)(6512007)(38100700002)(54906003)(4001150100001)(91956017)(2906002)(2616005)(38070700005)(186003)(26005)(71200400001)(316002)(6486002)(85182001)(36756003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWduSm5NZVZoSnE2MG9ScEZibEFhejJUaldqS1hOcG1Gb0tNNGlOQUV1Z1lR?=
 =?utf-8?B?c1RYY1NKc3dhWHcxdWYxVWxyVjNNeUp5UW5vSENuYUVxdkt0REpxalVOdWNH?=
 =?utf-8?B?Mk1sWkRRRHNFOUZMU1l5MWtLMkw0NktOTzY0K0RVbDJ5OXdJaXM1NWxYQUxY?=
 =?utf-8?B?NkRLaU82NVlMYlJ2V0s2SW1QQnFvNGhyUlF3N3hnK2JveVNNaWMyVUdvQ3A3?=
 =?utf-8?B?VnRQWExGV0oyWmdxUkRlbkV3UXhKbjUvWldjeVVFOWZXQjMrNFBod0NYZ2dS?=
 =?utf-8?B?TWNrYndQMEFjbkF3NXVMb0NzRkJKcktsRmdWKzZnaUtZOFg4SkppalU0OUVY?=
 =?utf-8?B?dy93UWNzeVgxakZ4RUxTZlM2em1SUDVFaFk5WnZUNDRteWhvbHNzdnA1ZGhz?=
 =?utf-8?B?d2dpaG90QzRpend6ZjRGcEdNOVNSaXFpWlVPd0w3aHFoT0gxSm1WUTRQNHR2?=
 =?utf-8?B?NVMrSk9MRXpEeFVqaUhJU3ltTXM3TGdPQWFOVGlxUEdndkVvdFNYT0RkNHJv?=
 =?utf-8?B?bitKMUpxUGRXbVRwUE95WnQrV1RYS1lLRzB5VWR6RVhZaS9MUmdMRytWRDFE?=
 =?utf-8?B?S0JobTlZN2ovc3BjS2lnS2VRRXFZRFVkMW1IQ1ZYSTFrWHhhNW1oTTRZem5l?=
 =?utf-8?B?amd0WmNsU21TSHhtMW9NR05PcndzQ2U2REVDMDIxazhBYVpMc2RJOGVydFF5?=
 =?utf-8?B?a1A4bmM3ajJoZFQyVDRBbWxTQkRuTHdaSnhuaG9JZ0FJQ3R0cWV4RzE3cllI?=
 =?utf-8?B?ellnQVMvK1drTy9GYVVHbm1PVHhqTitzZjZ5TGdrWERpT3VsUDZmTVRQUVJV?=
 =?utf-8?B?dHNJN3NPZXg3ZWs4eEltTWhXVmJwekhLMzBIM1pOSWN0elR0dklMT1hWUHRJ?=
 =?utf-8?B?dSttZktaYXNzcHhseFBPdVR6TXdUWDhSMVB6eTVYSjNGTE5hK0w0WHdnTVR2?=
 =?utf-8?B?RVFLYnAySXh1WENmcHZDUkxhQzFMcDh5ekhxWXJoUGtSRE8yV3RIVE5PbXJ1?=
 =?utf-8?B?UUs3MTdTeW52YXhFU2txbHpMbFMrY1VXanBxVDB5SGJMdzA4bFRURlZqekk3?=
 =?utf-8?B?UGovRjNnOTZwVnFJb0kraDQzZnFzNVRxNlQrc2FWVHQ1S055QmxzUzFpY0xU?=
 =?utf-8?B?eGpOZWhQdU15ODRYR0lzblJXZjl5WjJlRFZhZ3NWOHRoVTR2NTJQaG8wdGpW?=
 =?utf-8?B?RDhLSzJpeVU5ek5RNFN2VFc1bUFpeHB6cG14bDA3RTR1Z0syYlc5UEIwNlRj?=
 =?utf-8?B?VVVMRXdJMW5sTnY0aTRHR0U2ZUFQK3IwSW9ReWhZWElkY2djVFF4anF3UWF5?=
 =?utf-8?B?QnYzQ3VkSENvUm4wTFc4Zm4xVlh1aUI0QVRrTG5kTDQ1MmZ4UWFKQnBKdHcx?=
 =?utf-8?B?cldYK3VCYVc1Y1orZWM4dmg3NkpMUHlkSThvRzNhT05vbDJUZnprNE5RT1R5?=
 =?utf-8?B?TXliL0t4UjRVSmtlNzlhUnJWSWQ5WkJOdEV4MVRtQS9LdW9MSmhkMWY3YUNB?=
 =?utf-8?B?YUFDbXpuK1RFdnk2OHhZL3o3blgyQW1kM3BUb3JQK00xa3k5WGxuUW1XMmov?=
 =?utf-8?B?VXhGV0lYU3RoZEoycXJreUxYdlIwdmZpOW41cWU3OHhrZ2lMUEtMeC8zZjdP?=
 =?utf-8?B?QVIwcDNEL2d1b0F0RWlKM29ycmhSZ09iaDBOdWNXOGtpZm1pYURQbmRtc0lQ?=
 =?utf-8?B?TW5sWVgxYnZlcWxhRU42UHNzYmVEcTEwOHZhaDlzMTh4RVJwVW8yUzdBK3N0?=
 =?utf-8?B?UWZPbVFJTFRmdGI4VC9NRi9YZTVWejVPamROdE9RUHFIc1luWUM5R2ZZV3hj?=
 =?utf-8?B?anpNQ2d3YzUxcFJLY0hJV0ord3l1SU9TcnN3Vk45TG1mZEJQVFB6VmQrbFgw?=
 =?utf-8?B?YnNGNm8vM2gvT21TZ244T0tsdzlhN1NEa2I0dUNad0JrOThQTlBLMzBxcmpp?=
 =?utf-8?B?MUhuUGh6YitnSGV2RFJwNTRHakRXT0hwcE5IOUdkYkZIVTlxcXArVStrbE4w?=
 =?utf-8?B?NGdtQkM1REZ1V2R1UUFqNzFOb3E3ZWZ4MEFmZ0QxOFJ0Y05VbWQ4dVlrSnpO?=
 =?utf-8?B?ZFZTN1JLSk1GZjVYdE83cnlndTJjN3JYdkVkMzJkVUQzV0dkVlhMci9pWG5F?=
 =?utf-8?B?OU4vZ0VhWVVMQUkwcVFidXRtREVUOW5NdVAvWStnSnYzRWhBUDRDUXo0N1JV?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C9B1A848BB6144CBFE453E4954B914F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde30942-9b73-4e57-f006-08dae36266c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 14:48:19.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNoOIo2r/Dft4bNMe7cXAvVR+AUSOhecP+gV92PJp7IlgEEdrxvkSLmovvpaD7diRKYXvk7XmDF/5rsi6lzpHosIOCoxtfUxk+1cOgtFO3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6611
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTIxIGF0IDExOjI2ICswMTAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IFsuLi5dDQo+IA0KPiA+IEhpIExvcmUsDQo+IA0KPiBIaSBTdWp1YW4sDQo+IA0KPiA+
IA0KPiA+IHdlIGxvdmUgeW91ciBwYXRjaCwgYnV0IHdlIGhhdmUgYW5vdGhlciBwYXRjaCB0byBh
dm9pZCBtZW1vcnkNCj4gPiBmcmFnbWVudGF0aW9uIGJ5IGR1cGxpY2F0aW5nIHRoZSByeCBza2Ig
YWZ0ZXIgbXQ3Nl9kbWFfZGVxdWV1ZSgpLg0KPiA+IGl0DQo+ID4gcmVxdWlyZXMgbXQ3Nl9nZXRf
cnh3aSgpIGJlIHBsYWNlZCBiZWZvcmUgcGFnZV9mcmFnX2FsbG9jKCkuDQo+ID4gDQo+ID4gdGhl
IGJlbG93IHBhdGNoKG5lZWQgcmViYXNlKSB3aWxsIGJlIHNlbnQgYWZ0ZXIgdGhlIGN1cnJlbnQg
cGF0Y2gNCj4gPiBpcw0KPiA+IGFjY2VwdGVkLg0KPiA+IA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L2RtYS5jDQo+ID4gQEAgLTM4Niw5ICszODYsMTEgQEAgbXQ3Nl9k
bWFfZ2V0X2J1ZihzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0DQo+ID4gbXQ3Nl9xdWV1ZSAq
cSwgaW50IGlkeCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTS0JfV0lU
SF9PVkVSSEVBRChxLT5idWZfc2l6ZSksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRE1BX0ZST01fREVWSUNFKTsNCj4gPiANCj4gPiAtICAgICAgICAgICAgICAgYnVmID0g
dC0+cHRyOw0KPiA+ICsgICAgICAgICAgICAgICBidWYgPSBwYWdlX2ZyYWdfYWxsb2MoJnEtPnJ4
X3BhZ2UsIHEtPmJ1Zl9zaXplLA0KPiA+IEdGUF9BVE9NSUMpOw0KPiA+ICsgICAgICAgICAgICAg
ICBpZiAoIWJ1ZikNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4g
PiArICAgICAgICAgICAgICAgbWVtY3B5KGJ1ZiwgdC0+cHRyLCBTS0JfV0lUSF9PVkVSSEVBRChx
LQ0KPiA+ID5idWZfc2l6ZSkpOw0KPiANCj4gV2UgdGhpcyBhcHByb2FjaCB3ZSBzdGlsbCBuZWVk
IHRvIGFsbG9jYXRlIHRoZSBidWZmZXIgKGluDQo+IG10NzZfZG1hX2dldF9idWYoKQ0KPiBpbnN0
ZWFkIG9mIG10NzZfZG1hX3J4X2ZpbGwoKSkgYnV0IHdlIG5lZWQgZXZlbiB0byBjb3B5IHRoZSBm
dWxsDQo+IGJ1ZmZlciB0aGF0DQo+IGNhbiBiZSBwcmV0dHkgZXhwZW5zaXZlIGluc3RlYWQgb2Yg
cmVseWluZyBvbiB0aGUgRE1BLCBzbyBJIHdvdWxkDQo+IGF2b2lkIHRoaXMNCj4gYXBwcm9hY2gu
DQo+IA0KDQpIaSBMb3JlLA0KDQpZZXMsIGl0IGlzIHNvIGV4cGVuc2l2ZSwgYnV0IGlmIG5vIG1l
bWNvcHksIGl0IHdpbGwgY2FzdWUgbWVtb3J5DQpmcmFnbWVudGF0aW9uICh3ZSBoaXQgdGhpcyBp
c3N1ZSBpbiBpbnRlcm5hbCBTUUMpLg0KDQphcyB3ZSBrbm93LCB3ZWQgbmVlZHMgdG8gZXhjaGFu
Z2UgcnggcGt0KGJlbG9uZ3MgdG8gd2VkIHJ4IGJ1ZmZlcg0KbWFuYWdlcikgd2l0aCB3aWZpIGRy
aXZlcihkbWEgcnggZGF0YSBxdWV1ZSkgYnkgZXhjaGFuZ2luZyB3ZmRtYSBkbWFkDQp0byBlbnN1
cmUgdGhlIGZyZWUgd2VkIHJ4IGJ1ZmZlci4NCg0KaXQgaXMgcG9zc2lhYmxlIHRoYXQgYSBsYXJn
ZSBudW1iZXIgb2YgYnVmZmVyIGhhcyBiZWVuIGV4Y2hhbmdlZCB0byB3ZWQNCmFuZCBjYW4gbm90
IGNvbWUgYmFjayB0byB3bGFuIGRyaXZlci4gU28sIHRoZSBtZW1vcnkgZnJvbSB0aGUgc2FtZSAz
MksNCnBhZ2UgY2FjaGUgaXMgdW5hYmxlIHRvIGJlIHJlbGVhc2VkLCBhbmQgaXQgd2lsbCBiZSBm
YWlsZWQgYXQNCnBhZ2VfZnJhZ19hbGxvYyBpbiBtdDc2X2RtYV9yeF9maWxsLg0KDQpBbnkgaWRl
YXMgYnV0IG1lbWNvcHnvvJ8NCg0KUmVnYXJkcywNClN1anVhbg0KDQo+IFJlZ2FyZHMsDQo+IExv
cmVuem8NCj4gDQo+ID4gICAgICAgICAgICAgICAgIHQtPmRtYV9hZGRyID0gMDsNCj4gPiAtICAg
ICAgICAgICAgICAgdC0+cHRyID0gTlVMTDsNCj4gPiANCj4gPiAgICAgICAgICAgICAgICAgbXQ3
Nl9wdXRfcnh3aShkZXYsIHQpOw0KPiA+IA0KPiA+IEBAIC01NjksNiArNTcxLDcgQEAgbXQ3Nl9k
bWFfcnhfZmlsbChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0DQo+ID4gbXQ3Nl9xdWV1ZSAq
cSkNCj4gPiAgICAgICAgIHdoaWxlIChxLT5xdWV1ZWQgPCBxLT5uZGVzYyAtIDEpIHsNCj4gPiAg
ICAgICAgICAgICAgICAgc3RydWN0IG10NzZfdHh3aV9jYWNoZSAqdCA9IE5VTEw7DQo+ID4gICAg
ICAgICAgICAgICAgIHN0cnVjdCBtdDc2X3F1ZXVlX2J1ZiBxYnVmOw0KPiA+ICsgICAgICAgICAg
ICAgICBib29sIHNraXBfYWxsb2MgPSBmYWxzZTsNCj4gPiAgICAgICAgICAgICAgICAgdm9pZCAq
YnVmID0gTlVMTDsNCj4gPiANCj4gPiAgICAgICAgICAgICAgICAgaWYgKChxLT5mbGFncyAmIE1U
X1FGTEFHX1dFRCkgJiYNCj4gPiBAQCAtNTc2LDExICs1NzksMTkgQEAgbXQ3Nl9kbWFfcnhfZmls
bChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0DQo+ID4gbXQ3Nl9xdWV1ZSAqcSkNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICB0ID0gbXQ3Nl9nZXRfcnh3aShkZXYpOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmICghdCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodC0+
cHRyKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBza2lwX2FsbG9jID0g
dHJ1ZTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1ZiA9IHQtPnB0cjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4g
PiANCj4gPiAtICAgICAgICAgICAgICAgYnVmID0gcGFnZV9mcmFnX2FsbG9jKCZxLT5yeF9wYWdl
LCBxLT5idWZfc2l6ZSwNCj4gPiBHRlBfQVRPTUlDKTsNCj4gPiAtICAgICAgICAgICAgICAgaWYg
KCFidWYpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAg
ICAgICAgIGlmICghc2tpcF9hbGxvYykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ1
ZiA9IHBhZ2VfZnJhZ19hbGxvYygmcS0+cnhfcGFnZSwgcS0NCj4gPiA+YnVmX3NpemUsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9BVE9NSUMp
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICghYnVmKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAN
Cj4gPiAgICAgICAgICAgICAgICAgYWRkciA9IGRtYV9tYXBfc2luZ2xlKGRldi0+ZG1hX2Rldiwg
YnVmLCBsZW4sDQo+ID4gRE1BX0ZST01fREVWSUNFKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYg
KHVubGlrZWx5KGRtYV9tYXBwaW5nX2Vycm9yKGRldi0+ZG1hX2RldiwNCj4gPiBhZGRyKSkpIHsN
Cj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+IA0KPiA+ID4gPiAtLSANCj4gPiA+ID4gMi4xOC4wDQo+
ID4gPiA+IA0K
