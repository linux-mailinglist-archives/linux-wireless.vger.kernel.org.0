Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE96519FB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 05:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiLTE0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 23:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTE0s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 23:26:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2421261F
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 20:26:40 -0800 (PST)
X-UUID: db1f512a12304614a71b7bbcc9e30366-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xwTnHxu1cSzOidBNxikLbbDeA72ntLcxTunjLbAmp08=;
        b=KQci5edLo4xPkeG89YEOjRnH/NfiBgyKpg4gm/3IQT0p1MZ7IsMMSAmZoM4KPkpc+71/TocfRaZ4SPV43BuG+sGQv6I5Omnvn42SMVc+YW/Xbwqs8JhYKEN/MhKOYnweVtD9FTezufP3KrxvLVjB/GnSHVIpJiXAhyc8UhT/2nM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:33c012be-b4da-45c1-8652-f5e5c0d50542,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:33c012be-b4da-45c1-8652-f5e5c0d50542,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:70b53d52-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2212201226376CLDN05S,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: db1f512a12304614a71b7bbcc9e30366-20221220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1436655350; Tue, 20 Dec 2022 12:26:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Dec 2022 12:26:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 20 Dec 2022 12:26:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo60v83meZQYk356/VklOMXv2/bJSrUV7g12UZJYBb+1xTpSERZtaDTSoSe4CMEoSZbnznjBhjEqDK4pqBNpBNQdxpUO20bJi/zuu9Y1Pggi8J1lIQynAbdqglCsgUChjiaf8s0w1njtUnHhWgl2+dlIEGRFaW9IRkDWdPDNLAcmDjbKPtn2cTFzfkYunG8bBlDEvp0hFbu8/Z3GwpSLFMskgHc++ne5SIUe7luD/owTBBYPtCEedK0c8P1d8C+nCWkMWeOvO+YuDWBNOBmfd6I7pPYnrFiboC/Nsxa0HraFe787QAdWgI5BAuuJPIOfx4I0gHfrc6b8oG0CPLCIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwTnHxu1cSzOidBNxikLbbDeA72ntLcxTunjLbAmp08=;
 b=Jz2VHG/h9tVjIncEoxwtF6zkPp9ttc1786hm53jWSAr+BFRHCnj1d6xsmAqQuxVKtqwFJWVYB/HzqhVZtoPYQhLRB6MdMJlFmsBFqtxZq8VUwQ+h4Z5cj2MVhwxmHnOGO0oI1DUvwzfCvLEHqX50/WhGNDSzpm9bIIkvAIAO7XZbx0B866MWww+Z1M3jeItuI1dxF7ZPJjN5cwlZvbGWT+0ZJFZEbh1h9fTIoPm/4bGXhZIuk9Kn4bnT8r4vAFD9J1OGXkySjBAr65ZT2nt3NxHaQh28lBZ512NEl9bHqOEAgR4+umGyrKzP3D889SuFWfFFjC5LBhdgdsQDjGp8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwTnHxu1cSzOidBNxikLbbDeA72ntLcxTunjLbAmp08=;
 b=F2prERaHmWzh1opCfzNIIDh1UIHZ8mEya2WrsDpBlbhoZ663NhaKkr8lAn5hMmAaM60VH+2UzVoCd3hE0nFdO8U/8CyNc7f0vLcc5jCPWxhnbd9O1VlnAJkbqeT1RPwD8lAroxFwqCfYu6B3xXIVETHj0+821B4LTYj3KP5XQRU=
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com (2603:1096:803:42::12)
 by KL1PR0302MB5298.apcprd03.prod.outlook.com (2603:1096:820:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 04:26:32 +0000
Received: from PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec]) by PS1PR03MB3461.apcprd03.prod.outlook.com
 ([fe80::ea45:323a:2086:43ec%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 04:26:32 +0000
From:   =?utf-8?B?U3VqdWFuIENoZW4gKOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?SGFpdGFvIFNoYW5nICjlsJrmtbfmtpsp?= 
        <haitao.shang@mediatek.com>
Subject: Re: [PATCH,v2] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Topic: [PATCH,v2] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Index: AQHZBJsSgs4JUAwTZkiAm8/HCvdXcK5li14AgAWXSoA=
Date:   Tue, 20 Dec 2022 04:26:32 +0000
Message-ID: <6a6d2c7c99306790ebfafbfe3223405d0d726a95.camel@mediatek.com>
References: <e603722d58079af98c57a3dc117274d824d1d832.1669798063.git.sujuan.chen@mediatek.com>
         <c4f01e3e-4ae6-3d60-4fd0-b8d8bc5f4573@nbd.name>
In-Reply-To: <c4f01e3e-4ae6-3d60-4fd0-b8d8bc5f4573@nbd.name>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3461:EE_|KL1PR0302MB5298:EE_
x-ms-office365-filtering-correlation-id: cc4a5336-27ad-41c5-4790-08dae2425f87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AIGucMkWKHT3buPNXNsYMIOkRCxerrqWCII2WVecfjsUtzZnszCZQ9fGkA0bkcYDZqnTzQT6iJNxpRdWD22XDlnndB+CfcgEOvqpSwlB2+iM2px+XOg5O17Y/aYja/D9mUC9w/Qr/+gsEUjq2nGeWkXu6yJR3xr+9yg2XReiMGGbSU+BF0bvLDVZaUm2imMG52g4jecGluW3mwE8sie+6ep4S/e2QOvmwMeWMAhx/Fy2ruGwO81C78vXGknp2CGfdJG6EU6f+LvKpSeXF/+B/4z5lfKpq6c9i2b4bRiwf9NSU1hBoyIG7wkaNcL7pI1JZLCSHJb6+o5/a3RJLrS2DFf5T/O+fiNHkOFfmkvi/vzo7dGpDdSWniPGLhSmiY1fk9gia2IqwS3lNU066vMl3yJtd1Zfml3Lf2kx3759b7ViRaC92ZRVZLAu62ltbj2CNgSQZH+7GJEBhcu0Y06XUIgAslQLHK+vr3SvqUFkA+jzxbovG8bzjJTWEuEK1jEvmcDrJWGyTD5PPrj5cbM7mM3gMZdpHXah5BUBLq74eNPfSJSfju0ldwaFvtxQD6JufJnwy5qA6VSuyGVHHLYFmDWNON9JuFKFomUmcsS5g1t7Syiv7FqIRER3wZmLkrrPdr8dnhpmwHX0JrQSOO1zQEkt/W7+POHBzENa1bwV82wE9FpEEP5ed5Hl8vgqu41adVa/aoEXnZimkHCZNftUuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3461.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(85182001)(36756003)(38070700005)(86362001)(6916009)(478600001)(54906003)(316002)(66446008)(71200400001)(66476007)(41300700001)(66946007)(8676002)(4326008)(76116006)(91956017)(66556008)(5660300002)(8936002)(107886003)(64756008)(2906002)(6486002)(26005)(38100700002)(122000001)(6506007)(53546011)(186003)(83380400001)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXpIL1duNUdTTVdxenZKL0puYXJvY2xwYXZBaHgxSUp4WVNMNmhqNS9lK21I?=
 =?utf-8?B?VDNaRzZ3QnlPbmgxYUZobWRuMFN0WUFxS2dNV2RPNGZZdFVLRHAzZlcvcGpG?=
 =?utf-8?B?ajhQS1EwQTVWblFYNjRNNGxwTXNNN1psOFVyK1dKNWhocDQweG5FNStyNm1v?=
 =?utf-8?B?Ulhwb1d5Rm8yZ0phSjJtQ1RJUXhIQi83bG9OeFZVWmtZeGljUDJXZzNmUFN2?=
 =?utf-8?B?aEFvSG82L0NVMzlPNlJCZDd1VzhwTkdoTUN3enpvdG9rYTdxejgzRmVvK1p0?=
 =?utf-8?B?b3g3UGVWcXpyVkZ3S2Jqd0czZmR5Z1VLeWZNUFplajJPVWd5U2dQaVY3b3Ex?=
 =?utf-8?B?YjNIVGhia21vektpV242VFhmNjJ2RlJTajdXcDBHd0pVZ3JHdUlqVjF1ODVD?=
 =?utf-8?B?NjFnT0hNdFU5SVJyQ0g5VHZaTHZuV1dZUmptL0x4STdrWmx5SFBtVnF2UUQy?=
 =?utf-8?B?WkdwRHY5NU42Kzg3MER1VWZvbzh1blc4cnRuK0FHdzcrMGJVVWYvQkRGaCtv?=
 =?utf-8?B?TWdRSTE3a1lmZGtseHZvcU1ZbjNSQnVXOGo2ckYzT2ZTSHd0MFJkL0JKSDdr?=
 =?utf-8?B?UXFmbzdhNllSRStJRDF3MXhhc25Nb1IzUTlqZ25oTW5MTzFISUVQa21SVDJt?=
 =?utf-8?B?UitaZjZXOHlDT2VmTnJ5R1BwaC9LaGlCSHg3clEzSHdlOVpSWmhZV2dvTjho?=
 =?utf-8?B?S25INDd6cmhtMHpqcEt0dkdJM0x1QzBiT1JNcnBaeEtlSktzQjRjYWhWcW5G?=
 =?utf-8?B?NTZXR3FqdDNERlNYdHpnbUhQSmFBQXUrT3AyMFVmR1dpVUFERzhzREphRW01?=
 =?utf-8?B?MnlSNHdKb2RpeEpGazlPQld1UFEzWHpUMHdTU2ZTRlhrbTlyODdKbnJMZVgv?=
 =?utf-8?B?Y3VndFFKdkdDZWhhQ056SXl3Q2czeUx0RWdvT3FIUEhDTVBKNm9MdC9UQ3Fy?=
 =?utf-8?B?WDE3NzNIS2RNQlY4RG5zU295eVk4R2tPMm0vUVJuY0cxRzdwOXFrTzZsVG1I?=
 =?utf-8?B?MWI3K09UVnJiQW1RL2xCeGFzTVEybjVPbHE5aWk4SmpScHlmWmRmci9LOXFS?=
 =?utf-8?B?a1c5aWVyWU4wYm1nUU96bk9zb1lyZHhzOXFDY0xNbXByZlp1S1lQK09mL2NX?=
 =?utf-8?B?RGRjVkc4N2JDTWt1UzQvZml1RmgyVWJRTVBuZTI1ak52cmM0Umt6K256QVNX?=
 =?utf-8?B?L3U2eGRUTmk2dTlBMmJmamlVcnNnVnVaN3RkY2trT08rSUgwZ0JENXdjL1BY?=
 =?utf-8?B?SGd1SjlWcGJIa0ZiemcwMGtiYjBYSks0REpqRGhyb29MbzUrOXQ0dDJPT2hu?=
 =?utf-8?B?UUhFVkxyWk8yYjB6R3RyOW1RR2hrL04wWlZ0dWtiNTJwZFMvSHFUSGFxaDM3?=
 =?utf-8?B?ejlZMEh0cG41VDZ1b3hBRzRrNGRkUjU3UFFwajdneFg1aEFoMW94Y3U1V3pk?=
 =?utf-8?B?dXZZSXB3UkJvQmJjRi9lalMxSU1NTWZVVXkvVzRXQTczcGpEY2dDaEZUank3?=
 =?utf-8?B?M0tPOFVEeVhXSzk1c0NaNDdTL0xPU2JUam1mZEQ0dGY2YWpoT2lmMkJwcGda?=
 =?utf-8?B?ajNzcDNrVkVWMm1kUEpROWxSSnRuclh1STdJYTNYeENrNlhMOUJXNUp2Ylpj?=
 =?utf-8?B?T3RlZTREanFWVTcwNW5manM3R1p3VklhWGhORE9xYVFCU3dSK2xVcjNhbGQ1?=
 =?utf-8?B?V1owM2xRTFZPVHVKT25XSDdmOFRHVC9YV011SUV6SzlQdllWTlRTWXNReS82?=
 =?utf-8?B?VFh5MHI3NVY1K1loQzhlOTE5bU1VUmNNa1FBZkdUL01TSW9WUEZ1RmJWbFIr?=
 =?utf-8?B?K2VQYTl6Qnh3Uk5lTHVDMHhhQ3FxWGVuZjZ0eFF2VkRIOFo2bFppU2cyaHlW?=
 =?utf-8?B?QTZxU2xqZWZVWFJIdkpkelVPNEpXSXc1ckVaTVJzNDV4N25ZS0ZIbTJ3VjZK?=
 =?utf-8?B?VmVySjlXTm9uY3dUU0piNTgvU3duU3Z4U1F2S1NaUnpvNFhLOVhCTXRyZzlU?=
 =?utf-8?B?N2grcUxrZXl6QThTOEh0MTIwbHVUYVNoK3ozaDFXUFZFZElVUjRSc3BFd0s3?=
 =?utf-8?B?Q0E1SFArVVIyV2U4bFBLeGlkYXVNK29kQVl5b0l4cmx4bG5xSTRQbjVWOEMy?=
 =?utf-8?B?WDg2TDhFeGhvbk16QjlCWituWU5KT3pMdzhhcSt3ZXg2TVZYaitiSEtQTEIw?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD84E11B5917D946B283D4EFD5B72F77@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3461.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a5336-27ad-41c5-4790-08dae2425f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 04:26:32.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAT2CjLCjZJ47URtyEzXRZFtv0lzVKUabxPv2vgdkBMCAoSUzUyOWSe45r1j7cPHRIQsyfkCoOpgwVHVPFucgyrAUVt9atZ8N0f8zZiW2RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5298
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDEzOjMyICswMTAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAzMC4xMS4yMiAxMDoxOCwgU3VqdWFuIENoZW4gd3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQg
V0VEIG9ubHkgc3VwcG9ydHMgMjU2IHdjaWQsIHdoZXJlYXMgbXQ3OTg2IGNhbiBzdXBwb3J0DQo+
ID4gdXAgdG8gNTEyIGVudHJpZXMsDQo+ID4gc28gZmlybXdhcmUgcHJvdmlkZXMgYSBydWxlIHRv
IGdldCBzdGFfaW5mbyBieSBEQSB3aGVuIHdjaWQgaXMgc2V0DQo+ID4gdG8gMHgzZmYgYnkgdHhk
Lg0KPiA+IEFsc28sIFdFRCBwcm92aWRlcyBhIHJlZ2lzdGVyIHRvIG92ZXJ3cml0ZSB0eGQgd2Np
ZCwgdGhhdCBpcywNCj4gPiB3Y2lkWzk6OF0gY2FuDQo+ID4gYmUgb3ZlcndyaXR0ZW4gYnkgMHgz
IGFuZCB3Y2lkWzc6MF0gaXMgc2V0IHRvIDB4ZmYgYnkgaG9zdCBkcml2ZXIuDQo+ID4gDQo+ID4g
SG93ZXZlciwgZmlybXdhcmUgaXMgdW5hYmxlIHRvIGdldCBzdGFfaW5mbyBmcm9tIERBIGFzIERB
ICE9IFJBIGZvcg0KPiA+IDRhZGRyIGNhc2VzLA0KPiA+IHNvIGZpcm13YXJlIGFuZCB3aWZpIGhv
c3QgZHJpdmVyIGJvdGggdXNlIHdjaWQgKDI1NiAtIDI3MSkgYW5kICg3NjgNCj4gPiB+IDc4MykN
Cj4gPiBmb3Igc3luYyB1cCB0byBnZXQgY29ycmVjdCBzdGFfaW5mbw0KPiA+IA0KPiA+IFRlc3Rl
ZC1ieTogU3VqdWFuIENoZW4gPHN1anVhbi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiBDby1kZXZl
bG9wZWQtYnk6IEJvIEppYW8gPGJvLmppYW9AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEJvIEppYW8gPGJvLmppYW9AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1
anVhbiBDaGVuIDxzdWp1YW4uY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjI6DQo+
ID4gICAtIGRyb3AgZHVwbGljYXRlIHNldHRpbmdzDQo+ID4gICAtIHJlZHVjZSB0aGUgcGF0Y2gg
c2l6ZSBieSByZWRlZmluaW5nIG10NzZfd2NpZF9hbGxvYw0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmggICAgIHwgIDYgKysrDQo+ID4gICAu
Li4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYyAgfCAyNCArKysrKysr
KystLQ0KPiA+ICAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYyAg
IHwgMTMgKysrKystDQo+ID4gICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21jdS5oICAgfCAgMSArDQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L3V0aWwuYyAgICAgfCA0MA0KPiA+ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvdXRpbC5oICAgICB8ICA3ICsrKy0NCj4gPiAgIDYg
ZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
YWluLmMNCj4gPiBpbmRleCBjNDBiNjA5OGYxOWEuLjQ2YTllNGYwMzk2ZSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMN
Cj4gPiBAQCAtMTExNSw2ICsxMTIyLDEzIEBAIHN0YXRpYyB2b2lkIG10NzkxNV9zdGFfc2V0XzRh
ZGRyKHN0cnVjdA0KPiA+IGllZWU4MDIxMV9odyAqaHcsDQo+ID4gICAJZWxzZQ0KPiA+ICAgCQlj
bGVhcl9iaXQoTVRfV0NJRF9GTEFHXzRBRERSLCAmbXN0YS0+d2NpZC5mbGFncyk7DQo+ID4gICAN
Cj4gPiArCWlmIChtdGtfd2VkX2RldmljZV9hY3RpdmUoJmRldi0+bXQ3Ni5tbWlvLndlZCkgJiYN
Cj4gPiArCSAgICAhaXNfbXQ3OTE1KCZkZXYtPm10NzYpKSB7DQo+ID4gKwkJbXQ3OTE1X3N0YV9y
ZW1vdmUoaHcsIHZpZiwgc3RhKTsNCj4gPiArCQltdDc2X3N0YV9wcmVfcmN1X3JlbW92ZShodywg
dmlmLCBzdGEpOw0KPiA+ICsJCW10NzkxNV9zdGFfYWRkKGh3LCB2aWYsIHN0YSk7DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICAgCW10NzZfY29ubmFjX21jdV93dGJsX3VwZGF0ZV9oZHJfdHJhbnMoJmRl
di0+bXQ3NiwgdmlmLCBzdGEpOw0KPiA+ICAgfQ0KPiA+ICAgDQo+IA0KPiBJIHN1c3BlY3QgdGhh
dCB0aGlzIG1heSBhIGJpdCByYWN5IGlmIHRoZXJlIGlzIGNvbmN1cnJlbnQgdHgNCj4gYWN0aXZp
dHkgDQo+IChlLmcuIGZvciBFQVAgYXV0aCkuIE5vdCBzdXJlIGlmIHRoaXMgY291bGQgY2F1c2Ug
cHJvYmxlbXMgZm9yIHRoZSANCj4gZmlybXdhcmUgb3Igb3RoZXIga2luZHMgb2YgYnVncy4NCj4g
DQo+IFdoaWxlIG15IGlkZWEgbWF5IG5lZWQgc29tZSByZXdvcmsgb2YgdGhlIGV4aXN0aW5nIGZ1
bmN0aW9ucywgSSB0aGluaw0KPiBhIA0KPiBiZXR0ZXIgZmxvdyB3b3VsZCBiZToNCj4gDQo+IDEu
IG10NzZfc3RhX3ByZV9yY3VfcmVtb3ZlDQo+IDIuIHNhdmUgb2xkIHdjaWQNCj4gMy4gbXQ3OTE1
X3N0YV9hZGQNCj4gNC4gc3luY2hyb25pemVfcmN1KCkNCj4gNS4gcmVtb3ZlIGZpcm13YXJlIHN0
YXRlIGZvciBvbGQgd2NpZCBlbnRyeQ0KPiANCkhpIEZlbGl4LA0KDQpDYW4gd2UgbW9kaWZ5IGl0
IGxpa2UgdGhpczoNCg0KMS4gcHJlX3N0YSA9IGt6YWxsb2Moc2l6ZW9mKCpzdGEpICsgc2l6ZW9m
KCptc3RhKSwgR0ZQX0tFUk5FTCk7DQoyLiBtdDc2X3N0YV9wcmVfcmN1X3JlbW92ZQ0KMy4gbWVt
bW92ZShvbGRfc3RhLCBzdGEsIHNpemVvZigqc3RhKSArIHNpemVvZigqbXN0YSkpDQo0LiBtdDc5
MTVfc3RhX2FkZA0KNS4gc3luY2hyb25pemVfcmN1KCkNCjYuIG10NzkxNV9zdGFfcmVtb3ZlKGh3
LCB2aWYsIHByZV9zdGEpDQo3LiBrZnJlZShwcmVfc3RhKQ0KDQp3ZSBjYW4gcmV1c2UgbXQ3OTE1
X3N0YV9yZW1vdmUgYW5kIGtlZXAgdGhlIHN0YSBpbmZvIGZvciANCm10NzkxNV9tY3VfYWRkX3N0
YS4NCg0KaWYgc2F2ZSBvbGQgd2NpZCBvbmx5LCB3ZSBuZWVkIHRvIHJld29yayBfX210NzZfc3Rh
X3JlbW92ZSBhbmQNCm10NzkxNV9tY3VfYWRkX3N0YSBmdW5jdGlvbnMgYnkgYWRkIHdjaWQgYXMg
cGFyYW1ldGVyLg0KX19tdDc2X3N0YV9yZW1vdmUgaXMgcmVxdWlyZWQgdG8gZGVsZXRlIGEgd2Np
ZCwgcmlnaHQ/DQoNCi1zdWp1YW4NCg0KPiAtIEZlbGl4DQo=
