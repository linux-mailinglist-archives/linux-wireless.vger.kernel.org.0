Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECE6F226A
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 04:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjD2CeL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 22:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjD2CeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 22:34:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A412696
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 19:34:00 -0700 (PDT)
X-UUID: 493ead5ae63611edb20a276fd37b9834-20230429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=GJxXkESDwpCWA74AsMp4MoTaFjzA8h2hGBrvmFqBIdc=;
        b=Dk0M+6ZStfN8cQdilAsuqIzs/r3aeUnwSwChEeW7b+HcBuvWXoeUhOGII+tgxqzCzgRhGG5N+nhW5UFjw+x/ExP3AwF59xmmmHnhpcBG+TOSGdEgQNTt6ssnD2RsiHu/CWRD2C0i8ZIgGqi7CEXjOzWJGN86AH/TbCD/RBaTkUI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:961ee333-04f2-4e66-9f10-48ef3364ff99,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.22,REQID:961ee333-04f2-4e66-9f10-48ef3364ff99,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:120426c,CLOUDID:c30d3f30-6935-4eab-a959-f84f8da15543,B
        ulkID:2304290606270YF0NFYF,BulkQuantity:3,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 493ead5ae63611edb20a276fd37b9834-20230429
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 645947164; Sat, 29 Apr 2023 10:33:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Apr 2023 10:33:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Apr 2023 10:33:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4f66smzybyoXh399hzo2acljp0X/QcV/HBnTnPp1/chTcszdnwRVtK7iFQEc6HxNjJBftBQRnlupcIgpyxpVC1PIeoNtob56dOYpcQSdRFB97YupyfkVYXBY+rFf6wUJyjAzkBEB5zRVmFvL7WiNKthhhFhofpxwj1zI/ub48b6nKAycLvmpGOFt5auiuVCDQ0Ve9fjpZgbI+u/PybwB8/9w92tTxNy12ks4zarvRzFPcxKBYFX7qVKfnnQfPARySNZhQ3M3p0ThIHZlX1Pg2cDgzKWHG6NIuFIPyRQZFyOA2+ONY/rHUpslps2VQoiFwxTVXaRtl4dVxZ0wwlKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJxXkESDwpCWA74AsMp4MoTaFjzA8h2hGBrvmFqBIdc=;
 b=ac0DQ0QSdMUS4YTfV9ClRBwsC3/YlLQn/Qd30dQarlorMHmJHAEhsWIhiLNEcYfIz5C5gGkV8E4upFx6wLYtFV1srfYzInmPg4x9v+NTqRQxEdTBzJ5pFZ8Y2TKVofM4eL2cKyHk9MNmm4px67Op81KnGT7WarmNNHSGr/4D+Aq6BTij0MEQKOc1+Rfdr0EE6MLmk4phgmtpoVr0wAV9a/i3JP/8S+jvI8Om4+Kta+XjDBklh4/3sM8OQYXQ2zx9XrJPfuKenA3BDgebPwhTlMxS0S1GJgc4TXo1tigCW65Rp/Q9eK+GnQqzagbHXuC2lusyaI4tyYuuJr8Mwq684Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJxXkESDwpCWA74AsMp4MoTaFjzA8h2hGBrvmFqBIdc=;
 b=Wj4I3rr8WGh1XhGSt8nlVVFq1PkCBefEQ82ni+nZJLVqEmAhQuNzx1xj1Beh3/mfzcrrILSTkOQUR7qM1y+PapImcN2qUiUu/t0TOfBlwwlgjpR/sImN+5SMww8oKlg0p/3R9/XoVXe9oXhlisPdxxkHT6f7CTLu/1xPkdQXS24=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by PUZPR03MB6967.apcprd03.prod.outlook.com (2603:1096:301:f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Sat, 29 Apr
 2023 02:33:50 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086%3]) with mapi id 15.20.6340.025; Sat, 29 Apr 2023
 02:33:50 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "greearb@candelatech.com" <greearb@candelatech.com>
Subject: Re: [PATCH 5/6] wifi: mt76: mt7915: Improve monitor-mode flags
 settings.
Thread-Topic: [PATCH 5/6] wifi: mt76: mt7915: Improve monitor-mode flags
 settings.
Thread-Index: AQHZehMP3rthvbnXEUifcdISDI/pwK9BQiiAgAAFBACAAEq7AA==
Date:   Sat, 29 Apr 2023 02:33:49 +0000
Message-ID: <0fdbb82a50d69e39f150d49d3003ab1087954e8b.camel@mediatek.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
         <20230428205000.2647945-5-greearb@candelatech.com>
         <b57553ac83ab6ad3c6b998e99a2cd63eb3acfb24.camel@mediatek.com>
         <8d448f52-01f6-6a5a-2599-b0539404b29e@candelatech.com>
In-Reply-To: <8d448f52-01f6-6a5a-2599-b0539404b29e@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|PUZPR03MB6967:EE_
x-ms-office365-filtering-correlation-id: 827667df-ef20-4195-e5ca-08db485a2a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgZaCPC5pl5tsy5JpCYdsATeBfALC+f8nTl55DugxC0XxMAKXJGl4WFCFinVROg7hPRtOLuxWycCjhZWansQWSWACsCLNdqupVLJ62voBvmDRHwUDVFqoQmTHkQaKfHQx8/h49pZRo8Z9/Ysrb8DQiSa7UjqzGcyritjWSOC/3NtyPniDK/X0swWjzLqncaTNR6mWeH3sCGnxBFU/uP8UhiPWHp49ZmN0bxnr8bKCZD5YTpsDo1ufmKTf+lJhXTkauwMxPPx8yrPTUZ/M+5ziirA1HQRYl4vfMPR5yUNtiPU/2BFS2Dwz43BG3OGGG6EsdVyIooR2IriI0lhcB7sq4fxrZiS1LzMpshXK35n90cjXjgHRNYHL4L90WIKGTHtC0e1uetJvj9fI2b/OdyKd8NeofJzJzkY8ccLTk+2K5ZJgOr329aWz65xGkgwLLxbRS0lwdqZafgziockWyGi1tlZnZ7G8krSKlyYZpcLHPjGE7TIcTsjC/LHp/tOMJkMKqmCJuLI73ezy6o1R5jxiVdsF21Av/poV5MmHsq18In8hSbxTgJVlUbYnnLM19kzA4zugYIDVeNaLXodMqfO3hYk8sXagsFEXVbq9X3UzfUx3f9q9C656rGVZsS4gUP4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(5660300002)(8936002)(316002)(8676002)(41300700001)(122000001)(66476007)(38100700002)(66556008)(76116006)(66946007)(83380400001)(2906002)(64756008)(66446008)(186003)(2616005)(38070700005)(6486002)(110136005)(86362001)(36756003)(71200400001)(478600001)(6506007)(53546011)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1NPY3hOb0QxbS9wajMraGl2dVpYRWxFTGl4QzQxVDVXNnk3RWJYZG9MelVF?=
 =?utf-8?B?TDZwZFZkamFLWjYvYlA5eXAxOWNZRnFDVUZFTklqUmxsRzBkOXU0WEgwY285?=
 =?utf-8?B?MVE0L3g4Nk92T0ZEeDZhUzNkRUJwdk9scnIyd2p2SXJsTGdPODFGSGFlUU1S?=
 =?utf-8?B?MTFCUFRCc1ZuWjFsek9NTHo4MnRFdVNLUVVxM3JZQ1kvUTVmT0pmOXJvZExn?=
 =?utf-8?B?dzdHZzJqa05WTjNqNDdVaVB4a2pqcUlvVGF6T0NCeXdjU3FwNTlPcngzSy9m?=
 =?utf-8?B?VjdnT3hROUpoS3RTQmNYUGlXeVFxYnFSYXJ3ZmlYOGF0UFp1QitvUHF6anVP?=
 =?utf-8?B?eXBCYklEdml6UFI1dUg0aUNjdStxWDZvN3NQa29hN2xRZzc2aUhaZVZnR21Q?=
 =?utf-8?B?Qk9rUldNNWZqaFpBM3ZoZ3N0RjQ1cWZjRC9mVk0va1Zxc1FTbkNoVVh2SzFQ?=
 =?utf-8?B?QzM3UWRHVXltZmVIRGQzNVQ5aSszQjdQRGxzYlRUZnE3N05Mdit4OERiWUk1?=
 =?utf-8?B?dS91c05Oamc5b2x2ckkzL05KUWlReXNyR3Exd2V6OVJLcUJvS2xjeExLcFVn?=
 =?utf-8?B?K0NEbW1HbFB1clpjL0xraDBJbWRnVGRmRlNtSFhIYTBxL3VSREo1UCt3Z1JZ?=
 =?utf-8?B?bDZ3ZmV4UUdMNGpwWVRyY3VOb2lZMW1uWGtEdkhmNEVVK09zd09UK0JHMWdU?=
 =?utf-8?B?bGRoZUxpZEw2N0NNQWcxaDVsbVFDL0RLQUpmYUpURjR5ekpncGt3UlRmaThR?=
 =?utf-8?B?cHRXSjg4QVpjY1Y3T0hYelNmZXNEdmFlUHJacW5HbXVxSzZZeG8reVlLU1JH?=
 =?utf-8?B?YVpxTDdRSEZwTFI3TkxQa1A4ZmNBMXJXTGY4QnYxT2lsbjdYaTVSZWs3NnF2?=
 =?utf-8?B?NnpFSEJseEJiQUZGRmJsdklZeE8rdmxETjdLZjRqK0lPUTB4MzBacFRiY1h6?=
 =?utf-8?B?ME5rbE1kUC9kWi9WT0lzU0JyVlZsZmVSVWdQdXROYk1oNkZ6WDVWTHptT1Ns?=
 =?utf-8?B?VTh0K0dPQ1VUaXVjTFpHK3U0MWxxQ0E3b0dNQWlUWVFXaEo5WkRDdS9qK1gr?=
 =?utf-8?B?d1ZBbkdYQWVmR1VlMTM0WWNJaklHNk9jcXJDbGZVVXRTSWtiVXp3MTRLL0li?=
 =?utf-8?B?bEpYL2ZuTnlHeVFVdHBnZEtHclRrYzVQSDA2VjBPTlpNRThYZVNZQUFqdDJC?=
 =?utf-8?B?YkhEVFNkNDlXOUNuQ2xPN203KytUbkRrTmhwYy9qOTlKS3VpY1NRVENDR2Vt?=
 =?utf-8?B?TldzZ1ZFMS81N1ZBOHVlcEpDK0JMbWZsVU9ySndRKzFPTkZ1Q2NaWnFKSDRr?=
 =?utf-8?B?dG5MNEQ0TTVNMWlJeWtOVXlidUtZbWNJT1EydDRmQXdKNGN4RS9wdmhIb1V1?=
 =?utf-8?B?cFRESzdiYm9YK0JLa0YzdVRYMUhWeFgzempYUGNMV3hPQUdPLzgyamlMa0hB?=
 =?utf-8?B?d0EvYTVEWGVuS0JBU0lPYkFzMDBhMTZuaHpFRU1yTDdPVjhnV1V0aDRJaHFD?=
 =?utf-8?B?TG5ZTy9kRU93MTZWK0l3RmN1Q3pXdkhmR1hENEpITUw0dWltZHBWZWJObTFJ?=
 =?utf-8?B?ZVJCd3FtVzJDajVpUW1NMWl0RmJjUFNkUDNtdEcwWnRCRXlsb2NSa0hqQjE5?=
 =?utf-8?B?VzVUNGx4TkQ1MytjM3BLeGQ0MHdwR3p0U1ZUblhrWkx6SDFRSWlEMnY2allL?=
 =?utf-8?B?aE5JYks5a2VHMEd1MzJqRFZNbG5sc0swOUlCTzhVMXRPb25rV3BNem5HQUxQ?=
 =?utf-8?B?aHAveHN2dWp6MHJZZEptWGJoQUFLbWFzdlR0M21HZEJFenhLbHdoYTRIMXFz?=
 =?utf-8?B?N2RyalN5MFJzQlhiK3lOMXJMRFJ1dFBKcmV0UTZiNFBSWHZQZ2J0R2tOQi9p?=
 =?utf-8?B?eUlIdVFSYWlkQmw0MGZqMys4TVNqNEpWd1VxaVEzeWhmMGdQeFRhMDM0ZXdh?=
 =?utf-8?B?ci9FQW5IckpuWXdFWmM5bUJScE5nV0VZaFRJT251b2N0eFZXME5Fb09PMm1I?=
 =?utf-8?B?VHRiMDZZSDVjWmFodE1EZDNzTWcwQTdONk0vd3V0RXUwWWIzSEVPUlFCOXRY?=
 =?utf-8?B?SlhMSFk0czJ6Yk5INjU3NXJaSk9xTnVvUWNSVzRzYU4zd2dWSmthVkFoR241?=
 =?utf-8?B?M0pMM0ZXeHFSd0ZWbUtQMG01UUI0dEhiTWhnK29pUmJMSWN1dTBSOUdoTTd5?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <535338EA012C224D845798D45FBBA546@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827667df-ef20-4195-e5ca-08db485a2a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2023 02:33:49.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abqn9de5QMJ/UoY5GJBlgjLXCUpP2t7Z1p+L7U8knzeHIzHOYHdYLjmMQbqChmGcef2ysGEUTOb9gHO4koNTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6967
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTI4IGF0IDE1OjA2IC0wNzAwLCBCZW4gR3JlZWFyIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IE9uIDQvMjgvMjMgMTQ6NDgsIFJ5ZGVyIExlZSB3cm90ZToNCj4gPiBPbiBG
cmksIDIwMjMtMDQtMjggYXQgMTM6NDkgLTA3MDAsIGdyZWVhcmJAY2FuZGVsYXRlY2guY29tIHdy
b3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEZyb206IEJl
biBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiA+ID4gDQo+ID4gPiBUaGlzIGVu
YWJsZXMgY2FwdHVyaW5nIG1vcmUgZnJhbWVzLCBhbmQgbm93IHdoZW4gdGhlIHJ4NSBncm91cA0K
PiA+ID4gb3B0aW9uIGlzIGFsc28gZW5hYmxlZCBmb3Igcngtc3RhdHVzLCB3aXJlc2hhcmsgc2hv
d3MgSEUtVFJJRw0KPiA+ID4gYXMgd2VsbCBhcyBIRS1NVSBmcmFtZXMuDQo+ID4gPiANCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFp
bi5jICB8IDI2DQo+ID4gPiArKysrKysrKysrKysrKysrKy0tDQo+ID4gPiAgIC4uLi9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvcmVncy5oICB8IDE2ICsrKysrKysrKysrKw0KPiA+
ID4gICAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tYWluLmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWFpbi5jDQo+ID4gPiBpbmRleCA2NGMxNGZjMzAzYTIuLjU1YWVkM2M2ZDNi
ZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21haW4uYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWFpbi5jDQo+ID4gPiBAQCAtNTYyLDYgKzU2MiwxMiBAQCBzdGF0aWMgdm9p
ZCBfX210NzkxNV9jb25maWd1cmVfZmlsdGVyKHN0cnVjdA0KPiA+ID4gaWVlZTgwMjExX2h3ICpo
dywNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBNVF9XRl9SRkNSMV9EUk9QX0JGX1BP
TEwgfA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfQkEg
fA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfQ0ZFTkQg
fA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUjFfRFJPUF9QU19CRlJQ
T0wgfA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUjFfRFJPUF9QU19O
RFBBIHwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1IxX0RST1BfTk8y
TUVfVEYgfA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUjFfRFJPUF9O
T05fTVVCQVJfVEYgfA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUjFf
RFJPUF9SWFNfQlJQIHwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1Ix
X0RST1BfVEZfQkZSUCB8DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZD
UjFfRFJPUF9DRkFDSzsNCj4gPiA+ICAgICAgICAgIHUzMiBmbGFncyA9IDA7DQo+ID4gPiAgICAg
ICAgICBib29sIGlzX3Byb21pc2MgPSAqdG90YWxfZmxhZ3MgJiBGSUZfQ09OVFJPTCB8fCBwaHkt
DQo+ID4gPiA+IG1vbml0b3JfdmlmIHx8DQo+ID4gPiANCj4gPiA+IEBAIC01ODcsNyArNTkzLDkg
QEAgc3RhdGljIHZvaWQgX19tdDc5MTVfY29uZmlndXJlX2ZpbHRlcihzdHJ1Y3QNCj4gPiA+IGll
ZWU4MDIxMV9odyAqaHcsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0Zf
UkZDUl9EUk9QX0JDQVNUIHwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNVF9X
Rl9SRkNSX0RST1BfRFVQTElDQVRFIHwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBNVF9XRl9SRkNSX0RST1BfQTJfQlNTSUQgfA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgTVRfV0ZfUkZDUl9EUk9QX1VOV0FOVEVEX0NUTCB8DQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICBNVF9XRl9SRkNSX0RST1BfVU5XQU5URURfQ1RMIHwgLyogMA0KPiA+ID4g
bWVhbnMNCj4gPiA+IGRyb3AgKi8NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIE1U
X1dGX1JGQ1JfSU5EX0ZJTFRFUl9FTl9PRl8zMV8yM19CSVQNCj4gPiA+IHwNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgIE1UX1dGX1JGQ1JfRFJPUF9ESUZGQlNTSURNR1RfQ1RSTCB8
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUl9EUk9QX1NUQkNf
TVVMVEkpOw0KPiA+ID4gDQo+ID4gPiAgICAgICAgICBwaHktPnJ4ZmlsdGVyIHw9IE1UX1dGX1JG
Q1JfRFJPUF9PVEhFUl9VQzsNCj4gPiA+IEBAIC02MDIsOCArNjEwLDIyIEBAIHN0YXRpYyB2b2lk
IF9fbXQ3OTE1X2NvbmZpZ3VyZV9maWx0ZXIoc3RydWN0DQo+ID4gPiBpZWVlODAyMTFfaHcgKmh3
LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVRfV0ZfUkZDUl9EUk9QX1JU
UyB8DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNVF9XRl9SRkNSX0RST1Bf
Q1RMX1JTViB8DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNVF9XRl9SRkNS
X0RST1BfTkRQQSk7DQo+ID4gPiAtICAgICAgIGlmIChpc19wcm9taXNjKQ0KPiA+ID4gKyAgICAg
ICBpZiAoaXNfcHJvbWlzYykgew0KPiA+ID4gICAgICAgICAgICAgICAgICBwaHktPnJ4ZmlsdGVy
ICY9IH5NVF9XRl9SRkNSX0RST1BfT1RIRVJfVUM7DQo+ID4gPiArICAgICAgICAgICAgICAgcGh5
LT5yeGZpbHRlciB8PQ0KPiA+ID4gTVRfV0ZfUkZDUl9JTkRfRklMVEVSX0VOX09GXzMxXzIzX0JJ
VDsNCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoZmxhZ3MgJiBGSUZfQ09OVFJPTCkgew0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcGh5LT5yeGZpbHRlciB8PQ0KPiA+ID4gTVRfV0Zf
UkZDUl9EUk9QX1VOV0FOVEVEX0NUTDsgLyogMSBtZWFucyByZWNlaXZlICovDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBwaHktPnJ4ZmlsdGVyIHw9DQo+ID4gPiBNVF9XRl9SRkNSX1NF
Q09ORF9CQ05fRU47DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBwaHktPnJ4ZmlsdGVy
IHw9DQo+ID4gPiBNVF9XRl9SRkNSX1JYX01HTVRfRlJBTUVfQ1RSTDsNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHBoeS0+cnhmaWx0ZXIgfD0NCj4gPiA+IE1UX1dGX1JGQ1JfUlhfU0FN
RUJTU0lEUFJPUkVTUF9DVFJMOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcGh5LT5y
eGZpbHRlciB8PQ0KPiA+ID4gTVRfV0ZfUkZDUl9SWF9ESUZGQlNTSURQUk9SRVNQX0NUUkw7DQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBwaHktPnJ4ZmlsdGVyIHw9DQo+ID4gPiBNVF9X
Rl9SRkNSX1JYX1NBTUVCU1NJREJDTl9DVFJMOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcGh5LT5yeGZpbHRlciB8PQ0KPiA+ID4gTVRfV0ZfUkZDUl9SWF9TQU1FQlNTSUROVUxMX0NU
Ukw7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBwaHktPnJ4ZmlsdGVyIHw9DQo+ID4g
PiBNVF9XRl9SRkNSX1JYX0RJRkZCU1NJRE5VTExfQ1RSTDsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHBoeS0+cnhmaWx0ZXIgJj0NCj4gPiA+IH4oTVRfV0ZfUkZDUl9EUk9QX0RJRkZC
U1NJRE1HVF9DVFJMKTsNCj4gPiANCj4gPiBGSUZfQ09OVFJPTDogcGFzcyBjb250cm9sIGZyYW1l
LiBIb3dldmVyLCBtYW55IG9mIHRoZXNlIGFyZSBub3QNCj4gPiBjb250cm9sDQo+ID4gZnJhbWVz
LiBJIHRoaW5rIHdlIHNob3VsZCBtb3ZlIG1vbml0b3IgZGVkaWNhdGVkIG1pc2MgcGFydHMgdG8N
Cj4gPiBJRUVFODAyMTFfQ09ORl9DSEFOR0VfTU9OSVRPUiBtdDc5MTVfc2V0X21vbml0b3IgYW5k
IGxlYXZlIHRoaXMNCj4gPiBmdW5jdGlvbiBhcy1pcyAuLi4gYXMgbXkgcmVwbHkgaW4gWzIvNl0u
DQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIHJ4ZmlsdGVyIGFuZCByZWxhdGVk
IHBoeSBmaWVsZHMgc2hvdWxkDQo+IHRha2UgYWxsIHNldHRpbmdzIGFuZCB2ZGV2cyBpbnRvIGFj
Y291bnQuDQo+IFNvIGlmIG1vbml0b3IgbW9kZSBpcyBlbmFibGVkLCBhbmQgYW5vdGhlciBzdGEv
YXAgdmRldiBleGlzdHMsIGFuZA0KPiBzb21lb25lIHRha2VzIGFueSBhY3Rpb24gdGhhdCBjYXVz
ZXMNCj4gdGhlIHN0YWNrIHRvIGNhbGwgdGhlIHNldF9maWx0ZXIoKSBsb2dpYyBvbiB0aGUgc3Rh
L3ZkZXYsIHRoZW4NCj4gc2V0X2ZpbHRlciBtdXN0IGtub3cgYWJvdXQgdGhlIG1vbml0b3IgcG9y
dCB0bw0KPiBkbyB0aGUgcmlnaHQgdGhpbmcuICBUaGlzIGlzIHdoeSBtdDc5MTVfY29uZmlndXJl
X2ZpbHRlciBzaG91bGQNCj4gaGFuZGxlIGV2ZXJ5dGhpbmcgYW5kIGJlIGF3YXJlIG9mDQo+IG1v
bml0b3IgcG9ydCBleGlzdGluZyBvciBub3QuDQo+IA0KDQpUaGlzIGRlcGVuZHMgb24gd2hhdCB3
ZSBlbmQgdXAgZG9pbmcgd2l0aCBtaXhlZCBtb2Rlcy4gSU1PLCBtb25pdG9yDQptb2RlIHNob3Vs
ZCBiZSBpbiB0aGUgZHJpdmVyJ3Mgc2VhdC4gSGVuY2Ugd2Ugc2V0L2NsZWFyIHBoeS0+cnhmaWx0
ZXINCm9yIHNwZWNpZmljIHJlZ2lzdGVycyBhZGR0aW9uYWxseSB2aWEgSUVFRTgwMjExX0NPTkZf
Q0hBTkdFX01PTklUT1IgYXMNCndlIGFscmVheSBkaWQgZm9yIE1UX1dGX1JGQ1JfRFJPUF9PVEhF
Ul9VUywgcmlnaHQ/DQoNClJ5ZGVyDQo=
