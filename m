Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE73968EC52
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBHKFX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 05:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBHKFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 05:05:08 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF623D8D
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 02:04:52 -0800 (PST)
X-UUID: 04d5b870a79811eda06fc9ecc4dadd91-20230208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iJj8JBfEbvZmUpgtrkdE/pXeXrojBcOEGbD5HlWJUv8=;
        b=CAl8YEm59BbRzDiI8W8Pv6jVjcCmH/bqCWqbBLlJ01GoUX4O9pRYD70CuvwEHqeB7xwqrSVHwI96NSQZcRN7QHmuKUy48r+8I1PqfikHNI/hnbQyydQh9RB+NW+p1nqbpQBcocs4h6aOnabsfV4mdcGuwzg3aFNTHkC2BfZjC8A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:a9a94176-09f9-4836-a75e-0a2baf9517b1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:1408ac56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 04d5b870a79811eda06fc9ecc4dadd91-20230208
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1497721493; Wed, 08 Feb 2023 18:04:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Feb 2023 18:04:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 8 Feb 2023 18:04:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zhjur5QZqKySEk1oU8tv3JmC0kN3zqk2SQYRuCNmW6r31EM5y1rz4UIz63Kg+t3apbCBNUkfUWu/eOTcnEruy7MOIX5n1TATgZlgZsaAL5jgrjMuylyX4+tDoKDy6G654zwM2wl71yIVxfDogYTT5aBAxKtPNI++XUVuljjK5s/wDAP5dzTPYb9tcuVyiLoTpCNN5po/jAcEhNPIDQHwIN9BTesRImCw+A9qFPYOLl5qqqM1cGrSMbINE9QIHEgmb358+RyNJlYjxJjMNF+dz3xjTSizpP/blKdpoSlVPfkwDskA00GPUcOs/xmhj+8qLr+bbnHFRkoZPoJf3WBErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJj8JBfEbvZmUpgtrkdE/pXeXrojBcOEGbD5HlWJUv8=;
 b=U6pMhh5DJX3laEm+uJnH5R0GM6uYkOM4a+2qsxhCEpihWLSAKP1UP20R/HAvc3EA/F6F6O57d10A/xA0dJBK1UKcMFxf+oKemOXSqSA650iDffOTXrPT4dTutrXvPyMaW1GMf4DCSmr5hKJPbWOgaDUmqovOsP8oZlEJLC4WtaaCdXa+aztm5yP9zUHlA/knZgCKiBqzloMrsApGum0pvmKm3uFCiPjGxghTdJdRBAeu6l/bfoGpCJwhsxtxzA8FNpRl8aUs28YtKAX4hsBAh1NijGcKej6ZpxCqiwVjHPd635ST+D8EZr2DsvV8DR7UQKvnXAae49A05V7EyYydEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJj8JBfEbvZmUpgtrkdE/pXeXrojBcOEGbD5HlWJUv8=;
 b=kdVeTws9lvdnQ8K3FApXFpGN99vijPt6Z5PYoMDvBIKMFDdde7G+tAFhP+LVM0PpQ9ACw2H5ufMYr2Pb8ZzhkQfJg9xglot3VYPvCCMHLskVIS1w8oWpVpC9fTsiPeVoOpD8uPkf85Koa2Viyu6qf/YucNnWgYpaMxgCD6fzHHM=
Received: from KL1PR03MB6199.apcprd03.prod.outlook.com (2603:1096:820:83::12)
 by SEYPR03MB7168.apcprd03.prod.outlook.com (2603:1096:101:d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 10:04:43 +0000
Received: from KL1PR03MB6199.apcprd03.prod.outlook.com
 ([fe80::5aaa:7801:16a0:6e82]) by KL1PR03MB6199.apcprd03.prod.outlook.com
 ([fe80::5aaa:7801:16a0:6e82%4]) with mapi id 15.20.6064.035; Wed, 8 Feb 2023
 10:04:43 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?WU4gQ2hlbiAo6Zmz5b2l5a+nKQ==?= <YN.Chen@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: support ww power config in dts node
Thread-Topic: [PATCH] wifi: mt76: support ww power config in dts node
Thread-Index: AQHZNxVZMpZERRurrUajBFRNqBpZh67E00q8gAAIC4A=
Date:   Wed, 8 Feb 2023 10:04:43 +0000
Message-ID: <56d3c87227c07caaa92b6b7d4e85b26e780b3a23.camel@mediatek.com>
References: <70b8acb74fef12b10a74501cccd20e0c12f3f134.1675348583.git.deren.wu@mediatek.com>
         <87cz6k7b59.fsf@kernel.org>
In-Reply-To: <87cz6k7b59.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6199:EE_|SEYPR03MB7168:EE_
x-ms-office365-filtering-correlation-id: be432aea-7ecf-433f-927a-08db09bbe68f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdW7ASriaHfSEjMhST/9SieOhldpZKZK31lWJGWfp0xFFXyvZ5EayoKcHYedjm0/hf0WRTjsfev6u7WCTWcLT7Hj7l1lN78y/8FSmrt3B91EcDQhW74kEOc2OhIzYe5uSX1FYuooo06ovUH70zl0dUuCzT1Q860Jf0/c2H2kYkmNSa/Ezfd9+DPJARxB5XoUt1Qb+xsKkpt6B4CxoL8UCYGGhQofHJjLhxiRdpxEHm9iZP0zrQ/h638emtiqm3QW+qDEIGmPIAnCEmbPY8ihbqrIBT/o4PfSZa8FNCAdp/n+/vOos5SsEMF9hwQnWY6qGsl/QlXaYN3AsDshsy/0J7HTE5Z7xMy6sVjstXkoRmLSGlFRX7z1iOT6TZz8WQfgejfxV6IKa55oo6bEFK5ErLFHC6iyUcTkk2TYqrEtWIAPnbmKkufsnuGNAV4gddDd8i0RAg53xAzgdvakTAnR3Y7nF0K53KK58saNPTfua6UTQw6BuK4/5p73MxcmLz4mIt2iFEnSlEjvSp752o9dVUs995rZM+RRDdwrw1vdmNyoNF+nCibhqoNpZn/UwEMIueBwL2UM+FtVwiAmZmDagx0hwibpltQBkJ5GohWcmilLsbm+61MbZTwaomRQDqjUDI05kosFWEDSKyVj+viqDkmVclpiG2W+b0WvbrfThzmUD0Mu5roFi221fiQpEa/HQfLg6qIZ1dSCN8GWZGMVaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199018)(5660300002)(8936002)(76116006)(66946007)(186003)(26005)(4744005)(6512007)(41300700001)(91956017)(38100700002)(86362001)(85182001)(6916009)(8676002)(4326008)(122000001)(64756008)(38070700005)(66446008)(66476007)(6506007)(66556008)(6486002)(2616005)(316002)(83380400001)(71200400001)(478600001)(36756003)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em81WDE2bC80YjBPTWNxZ1dwa2FGb1AyM01uNW9yZTg2UUF2Qk52UkJveU54?=
 =?utf-8?B?c0RpRndnTlQ4QVBTbHFHWU81R2QvNXBETUhGekZxNUcyQklyb2U5TDdSYXEr?=
 =?utf-8?B?Zm9Vb0dSMEJUMm1MZDRudFJoZHRQRzdEZ0paWG9lZjR0Q1BpK0VBSTRLZnNV?=
 =?utf-8?B?SHVaZ3RIZHN1UTZQb1lNZVZpQmI5YmE5OUxKRDRoeDNSZWZYSzlVKzdtTnFy?=
 =?utf-8?B?Z1R0OHNGSTBSZFlrZnJNWnhKOVRNTGxsNDB6YWNtN3RnOFpUMkxSU0RsbFFD?=
 =?utf-8?B?SmFrTFhKR2JPaHFEbDVadDNXY1NiSEFQb21wL1crS1VDbW1ET3g1VG12QWxK?=
 =?utf-8?B?TFFtdFhXYnhsZ1NZNmU3dXpzRXJCTmJ0NERad0R0NEtkdm9HVmkyOVdEU0dt?=
 =?utf-8?B?Q01JV2lmTlhQSkxJWVhrRWpkWVQ4Y1VzeDBxN0x0R1Bna0ExaWZYMDJxN0Fo?=
 =?utf-8?B?eTlHdHNiQW5jYkZRZHRodE5ESFF5NGFHNXFwUWtBRXhycVFCZ2tWek9TaEZX?=
 =?utf-8?B?OHdpaW92aVZhYjRYMDMvQkRZbXlEdkNLMUF6YWJKQkRaUVNkbjVDaE4yL3lx?=
 =?utf-8?B?OGZlMVlGOXNSV1pORXhKbWZGYlRvRytGOVBQcU5jSEo2M2dSZHNYV3RyRWQx?=
 =?utf-8?B?b3VKT0xhSkNlaGtoZXJiUkZYRlB4c1lCMmpaSlJ5REt3aWRTUkVkZXN2Y3Mv?=
 =?utf-8?B?MXVpbjZYVzBZWmt5QTYvcHB3MHZpTXd1cjUyVU8zS09xdGVVSDFJNVRFa3d1?=
 =?utf-8?B?bmtFQzVrZGdLY1JGU2txeDVDRnBBdVBnTDdwYTRsdWEranJOODc3VFJWZ2xu?=
 =?utf-8?B?U2d2UlRBMGtEZHFzM1F2ZXdINUtpU1phcTNsb1B3NDRQVk9jQXJQek96Y1Ux?=
 =?utf-8?B?WGNFeWxTME1jT3M1bjJqUUlMUW9GcG8vTUhhaDNyR0JYRnhvYnFvdGExbEtw?=
 =?utf-8?B?RGthUVhBSGRMazBjVE1ZT0VsZnQ1c2JvQVhER25aMjRoTWZIQStSeHQ3WVVI?=
 =?utf-8?B?eWxCdTBFaHEwVko2NTFxeFRMSEhrdjdwUFM1SmxhRWlta2JrS0xBMlRHZzk4?=
 =?utf-8?B?amV6YVZrTEpVcnAwczRnaWNsbCtLalpZK2U2UXQ4SndPekRBcWVDWC9raGtQ?=
 =?utf-8?B?b2N4TndLUVhNWUxEZXJ1Sjg3cU1SS1NPNUNiZE9JY1JrcGZBd092anRUTHpr?=
 =?utf-8?B?Ry9rQ1lFUkExcE5aN2R6UGFlM2RwelplWXBQa0lZc3FWNk5NR3U0bDgvT1lW?=
 =?utf-8?B?VnpoY1VERnRBRDIwb2RYT1ZSN0Q5cERCSGZwcmg5UjZHY0FWaUVSTStlQnlu?=
 =?utf-8?B?UldZanFhQmt0UXc4TUFHYXdTTFRBd09jV1AwVGcxSjdMcy94ZDFjQkYwTXdu?=
 =?utf-8?B?QWNLRENmcUZLYy9LQ2VtM0lVeTJZRlpGZUZUZDRpSmRmaW9FSFlSNG04aEh1?=
 =?utf-8?B?MnFUY3IwMjNJREMwUkpPSjdiMDQwV1I4dm1UZHI5YnozdGhxKzhRWlBjTDRG?=
 =?utf-8?B?c01EM0FwUDJJYldBSXJNZGM0K2JFSEc0NmhkNlREQ1cxMldLUGZCV0NJNENl?=
 =?utf-8?B?TG92bERCazBDcjhiUVhGQmZ6ZnV4MUM0bGcxYytsUnYrN3NVOFBCUHd1aDRE?=
 =?utf-8?B?Y0h1aEVsdXphbzh4K0t6elVETEUwejhoaktOVlFabm9uVVBsNndGTnhYcDlm?=
 =?utf-8?B?WTNBNWlEaWdXTmtVMGhPUnh1RUFNdmFZMy9IVFkvUDJNWWZFaFE5OEsxUGhw?=
 =?utf-8?B?d1pNY3B6dzZGbUFvblExcDV5QnhiMjR2VnhNSThaMW53S0luVmlnbUJyTncv?=
 =?utf-8?B?NzNiTytCNmFkMVAxeGpmK1pZeTg1TmNlRm52UTJKMXZFM3c2SGE1bDlyNDhT?=
 =?utf-8?B?Sm1HVGw1cjVGR0dKRVlvR0JiQXYxSGZEaUtRSU85MDZ6dSs4SitqMFZqYXNV?=
 =?utf-8?B?NTlJbW9wVjNsVENEVzJEQ1d6NTNYMXpVNEdVRXY1eUJBdVQ5NDJOSDJrNndP?=
 =?utf-8?B?YlBobVBScjh2V3VwcU9XSHo0QWM1NnNsOGViRnR0RVlvYUozL2h4VVlOTURr?=
 =?utf-8?B?L2dteng5RFI2NHhOTTRuWnVKWWQ5M3VMV25rNlhhdHZkREJReGVCS21nUi9z?=
 =?utf-8?B?VGJRT1FuZWVwTklmL29mUnVPdUJCNHoydnNPcWc0UEFIUTdyc3dGVnB4WStJ?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <054F2BB2BD3C274388BABFAE341913DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be432aea-7ecf-433f-927a-08db09bbe68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 10:04:43.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeHxZhmT84N/GuNS0GfX4+QTW4beTLAIevNuoF9fgYTrzhZekQqOUGkeEDrHOfFELfTXhTS03gzmU/ViesWxUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIFdlZCwgMjAyMy0wMi0wOCBhdCAxMTozNSArMDIwMCwgS2FsbGUgVmFs
byB3cm90ZToNCj4gRGVyZW4gV3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNvbT4gd3JpdGVzOg0KPiAN
Cj4gPiBzdXBwb3J0IG5ldyBub2RlIGZvciBXVyByZWd1bGF0b3J5IGRvbWFpbg0KPiANCj4gVGhl
IGNvbW1pdCBsb2cgZG9lc24ndCByZWFsbHkgZXhwbGFpbiBtdWNoLiBXaGF0IGRvZXMgdGhpcyBw
YXRjaCBkbw0KPiBleGFjdGx5Pw0KPiANCkluIFNUQSBtb2RlLCBpZiB0aGUgaG9zdCBzdGF5cyBp
biB3dyByZWd1bGF0b3J5IGRvYW1pbiAoIjAwIiksDQpOTDgwMjExX0RGU19VTlNFVCB3b3VsZCBi
ZSBzZXQgdG8gZHJpdmVyLiBJbiBzdWNoIGNhc2UsIG10NzYgY2Fubm90DQpmaW5kIG91dCB0aGUg
cHJvcGVyIGR0cyBub2RlIHRvIGxpbWl0IHBvd2VyIHNldHRpbmdzLiBXZSBhcHBseSB0aGlzDQpw
YXRjaCB0byBoYXZlIGEgcHJvcGVyIHBvd2VyIG1hcHBpbmcgZm9yIHd3IGRvbWFpbi4NCg0KUmVn
YXJkcywNCkRlcmVuDQo=
