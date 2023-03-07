Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968346ADD25
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Mar 2023 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCGLUu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 06:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCGLUq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 06:20:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9132137
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 03:20:38 -0800 (PST)
X-UUID: 1288f5d4bcda11ed945fc101203acc17-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SmeusUdgrwuLF4uJplHk8JMaWvzdrGWgXiFN4+3MVqE=;
        b=cqWfKuhuKIvoTWEcu9nDqXzhcsgFV+GvPyaenVsmIzWoNxL1lLzVWUUjlQRTSss+elNIEupNpCV1wT5YodNol07KWk9djICVBgd0jII8R1XyZyaUExdGtvyWrhelj4AoXvfZo9mGBFudnhTpuN6/+IXJoOPJFPA6w7lVZRqBT3I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:ca5e3d59-8af7-4ff7-a30c-35adf1d7ef20,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:1a2208f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 1288f5d4bcda11ed945fc101203acc17-20230307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 465176923; Tue, 07 Mar 2023 19:20:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 19:20:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 19:20:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laKauabv9izP/ruTGzv7q1bB+cG55BP6sHorx+2wsKi/BLeZvJapk1KSk3rySMpW3OIcu6bS2cL+Mc57xzuSmrvvY5lu7LU3ET7WSeOcKzYNpeMaTTzVcGKXsOhU8sEVfJZxDP8JZpz6VTZdK7kTj5LB0QuNRJ5jUIbIA62+Z25SZ0bf7plg/8Iahsn5gS5PRDnSyNEaxmfUlntOLZSpTGAgUnETn9aZHGaXoiJZQzrqUZyQZqPNf44nSsRO1rU76ZNbXHhxzvA6qg1yn88fmZe7o34IIkpJ/J+KMHTwKJwSBNA26ioMyNe3m1fkEp/qMHrscNRQIBBUVRj121YiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmeusUdgrwuLF4uJplHk8JMaWvzdrGWgXiFN4+3MVqE=;
 b=SHbmNEU8pBVoFg0RBrQbqbnFFi+XCGnIP2d9W23EpXNiwONsRdOQJ89Ur3EfPNV2WrB18LLhrWGhvaVWLVeLZsTTmN1vV82vbkgKyTcalJQvOeO2jtRu0HlgEj/frOzW0Qlt6CtjOzVd3jQZvx1qHU/liUj96vbK1seO8SbDBaMlCSoP1wJP3BrEOYOe5+JcATA4aSHL5/9GY1xsGiWrqVy6TcrIk4DCl6gWlIVlUsNWBQjxHbRp8AsZn3UH5VFVBN2wOmw/tyWAIbdkTVZMGUyC0ZTQ3hDhv9K/bpwbM3/PoVW58FKPykNYwSN3Qotbzan+Xt6ZJP9LaMOO8gGtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmeusUdgrwuLF4uJplHk8JMaWvzdrGWgXiFN4+3MVqE=;
 b=syQv1AnzdG5gl9lSlPpvUcfIasoPhjHY5iJgUhrzzDY9XDH3CZLXIk8D57puccx+CT7t5RsIxyIksDYWNvQtx8IL2U1lkUitPRm9uVIDV5/uT1hiPNeOJycXDzmv6VWULMYIlNV9Y38ZN3/r04DEkwATmsZPA32lrqam2QxCoS0=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 SI2PR03MB5514.apcprd03.prod.outlook.com (2603:1096:4:125::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 11:20:29 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::ed9f:404b:ce93:ac80]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::ed9f:404b:ce93:ac80%8]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 11:20:28 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "pkshih@realtek.com" <pkshih@realtek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
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
Subject: Re: [PATCH] wifi: mt76: mt7921: use driver flags rather than mac80211
 flags to mcu
Thread-Topic: [PATCH] wifi: mt76: mt7921: use driver flags rather than
 mac80211 flags to mcu
Thread-Index: AQHZTnC21mQ565FYFEGRYJ9YoXR/J67uhoMAgACqPoA=
Date:   Tue, 7 Mar 2023 11:20:28 +0000
Message-ID: <7a0951092dbfa2d5bfaab27c9b83f5df002c57c8.camel@mediatek.com>
References: <fce2160648ed8a83248e8998cf76bbe05de0e8a0.1677912476.git.deren.wu@mediatek.com>
         <4df66aae6e6046d1ba207de47247a21b@realtek.com>
In-Reply-To: <4df66aae6e6046d1ba207de47247a21b@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|SI2PR03MB5514:EE_
x-ms-office365-filtering-correlation-id: 30b96f6f-aad4-48ec-024e-08db1efdf4d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VXh4F8JHXsNPB/D6ERfRKvRdL2wJz1fQTNLtYrkYEnBsGqUZfgsRrQFBEWJvuwXlOHU3EGf+0mqVgSMIfy5NpygM11eXjgtQRzEvIsY6IQNce9YvGpb0LHecCgmBNqIP3Qr76KoKDWZcx61Daz2C/+qzSbY8P2wLd8W7zun3+hMUo8miXZf5i3ktCodhl8fcqGFSGvHCZ91HawuEMiZOXRkerR93A5rMjjgzUCNRdm8pDD3aNlBCZnTxFGz+4PohSOFbaQhYKLzOtSaf5q4xsKW+CAAPPxBE1sSWFof8ZJYBjhSnoQ+24ddOCLBlgTvol8FjGQP1iHQB9ZE4FQLgBTM7BzV6+mFVtomYbeL9B3SmNM2m4KVZYeIfiJ5A/DjaOnGdMdArXzJXvfTfoHJoG4tm+l4Gy20WtPo9D4HYbI64eaiwwBnhent8KlVb9CNMERqH6UN66DCHLBTiPDMqUk4q1umagIDG/WRZ78UVzTi0bJVmJmD3QVYPr78HIYnB2q7V6FqMtZS+inVS1FphjhtozIXuJzDU4KfWeHjMMnHCuaGJVsqey2uKHJMS3jOJcGNKGKfKPeN6t9CzT9TPTdFk7Zj+51sJEWFXpK4chytbsVpOvYPlyjzTw/iRvwgmdTbEW61aea6eCNyW0ZFxa8+PXPzVVRL3xHPW3S+8cm9HJg7UWdyAVjkt1+L/7+w6VuFwYof7HXvpUNGpClIK/L1zuNzPZubcqkCX1ZLilU7vgkuIa1ws8R9DyYyoqRE9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199018)(6506007)(53546011)(6486002)(36756003)(85182001)(38070700005)(83380400001)(86362001)(38100700002)(122000001)(6512007)(2616005)(26005)(41300700001)(186003)(66556008)(66476007)(66946007)(8676002)(64756008)(76116006)(4326008)(2906002)(5660300002)(8936002)(66446008)(54906003)(478600001)(71200400001)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TllwTDM3MjlXYTN1SlF6WmczZUljalhlNEM2K0k1YUtUb2lvWFkvcmp4anI5?=
 =?utf-8?B?eGw3dk53MitTMWppL1dyRFZ5N24yQ1VuZ3hpcjFFQnVteUJ1Qml2ZWJvN1ZZ?=
 =?utf-8?B?UUZUZmtwY29ETklXZ0orZEtSck1FQUhDNHczYVlmVU56VEN5czdtdTh1UElj?=
 =?utf-8?B?YTkzOFVyRDdZRFdlSGN0blo1VDk2RzRRV09EcGlScGxhcVJyZGU1cXJnWXhB?=
 =?utf-8?B?L1Mvb3ZZMU1WN0NvQ1h6MnNpZVl5U0N4b25QRFhpdVJ1N0t2TGNVQTViWXRv?=
 =?utf-8?B?UmlMVzR0cXFaYlRNbjBQUGVnY2g0bVJTdzAzN1p0Uk1URkIxQUdGY1hSUUdP?=
 =?utf-8?B?VDZPR2xBTnVLZzBjN09MZSswWHhRVkpwZnhNaFdGbjdVTURGRWVLcTh4dGd0?=
 =?utf-8?B?YUhLMWhqck5tUCswUTBzMlRnUWtUMnQ3VXVIcE5TM2MrZlJBSytDd1JtSC9r?=
 =?utf-8?B?YUVYdHp3alRQejRVWVNCVW4xSG8vZHJLSWZ0ZGlnU0xRM3kyNEF2S1JGREUy?=
 =?utf-8?B?L0lrRGlhc3RqZzh0eWhiTCtHVGVtc3hLUlZzSk8rTmJLQ3poU0NJU29QckJk?=
 =?utf-8?B?YjBxdGZRcWJzTkp4cGczQ05Wck5CNmlKaXRDdTJTcm1zVkpSUGV0WEphZEZI?=
 =?utf-8?B?ZzFSdllEcTNpM1MrL29LRlBOOFJuWEZQMUpTUlVGMEFqRURuSkxJSHA4ZXlj?=
 =?utf-8?B?bUt4YVVya1NHRTBpQkpCaC9pV3hJVmZUa3RYNHc3cTlqOTRXYmRCZ0tDQkNa?=
 =?utf-8?B?bFNCRFVlek94WE9uWVJTZkdVdE5meElmVTFHMHhjdHpmT0hPZFNyN1ZqOFk3?=
 =?utf-8?B?WnFPVlk3RFUyYnBHVDRIU0xKWUs2OStuQnFIZzlWMXlrYnJjY1QzSFNPYzMy?=
 =?utf-8?B?REVvR3VxOGZHNmlHUTN4OXY0ZVJuMXY2SU1idkdXRW90QkhyQlFpM0dzUnVY?=
 =?utf-8?B?c1dPY3hzbFljTE4zMWNEL3VhRGhMUEdzQ0srQlphK2tVWHZONVc1ZkdFWmdN?=
 =?utf-8?B?MUJqbFp6OUZadFBqRE5FUExyeW9VTDZ4UjJFWEtlNVVaZTg3djZKNk5jUWRh?=
 =?utf-8?B?WVRDanZ0NXNzQ1lRK3MvRHZWZFV3S1NvbDJqdmZjY2Q2Q1lGNHduajB2UnNl?=
 =?utf-8?B?S2NQUHh5NVFLRTdOb212cUl0ZVhsSzVqeXZ3RjdZMjdpYjFVS1JkaWQ5VlV6?=
 =?utf-8?B?UnlQb09CTmpqQTFya0J2eU9iTVA4ZHJVMjNsT1VzTlpLQnQ2aFN0OWRjY2h5?=
 =?utf-8?B?Q0JwV2xLOEF4aTROcnYwbFRVSkpiSlJiRXRSVWZuQ3ZRVGxxSE5JSUh4bE5u?=
 =?utf-8?B?Zmo2T0V4bDcrd2N6bWtYVWFoMHEzZEhiVE5iUmJCUENYNVlNWmV1VzUwRVVS?=
 =?utf-8?B?M2J2cWVHUEpmS1ZKbUNtcjdaNFJWSFpNU2IzNjREWkRzZG5DckppWmZXRlkx?=
 =?utf-8?B?QjdtaGdKNnVzaWxoYjFVcUVMemdJeFJWSloxUW4wODFZRWFITFpYQTF2cCtZ?=
 =?utf-8?B?SGJWMlBXNVh6YWNtaERqN1ZEQm9tVzJINWMwVnVPMmJHNXpwSVJ2eWdyWjZw?=
 =?utf-8?B?N2w4Vi9NZGJMNmUrWjBOWDZyY29CMVNvM2piSWFqUEV0OTVySUM0UlNJZHFP?=
 =?utf-8?B?RHNSdGtPaFlQSm5NMENnd0tVQWFpRTB1Z1VGandwRWJtUkpxdi9uWS9sSFhl?=
 =?utf-8?B?cUFtQmJFNXc3M3o5WHNTUm1nRGdWQVdwa3MwWDZRTjBFL2FpL2ptUUpTTC8w?=
 =?utf-8?B?aXQ3Uyt4UXg1Z1QyMGpaa2JPa3djbjhSbC9BcDM4aG1lcENXZmdjV0NVZ1ho?=
 =?utf-8?B?NWU1RmdhRzlrZ2FLRUNRcTQ0a1FGRHdObjVGK1ZRaUdJNHdSOHM3T2YyMVdM?=
 =?utf-8?B?M3JuN2pXMDN5Mnh4SEJNMEtRRk9DeG94QXorS0k5WUtVOGtacExHWGpmK3Vs?=
 =?utf-8?B?RlZmbWZlRnJodkhHRlpzVWhjcG94dXZSTVZNcW5ZaEFJYms3bDc5R2l6QmEv?=
 =?utf-8?B?dmRqZ2k5eHdTUjUydjFnSGxHKzVFRitEdndUYTMvL1lKRkgxNUxsYlFJOVVk?=
 =?utf-8?B?azhtTmduR1U2SFBmdmc0aHQ2S2U1UCszSGFIUURwQ1lMMXk2RnFZNUFsN3Fo?=
 =?utf-8?B?SjA5UDRjTjg2MnY0QjBRRkhyTFVNSFZidXB6ZkVJYnJvV3lPb2ZIU1NkUzFT?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF165C465381734996B16936F65133E4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b96f6f-aad4-48ec-024e-08db1efdf4d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 11:20:28.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I12FRfWsGB8GWn2+ZsIRduZ9iRbbvgrG6K7zbUGRuWx2COOrGIifrtJxu14Tuv1jw0M4p/Azcd4K8aiYzI8srg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTA3IGF0IDAxOjExICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBEZXJlbiBXdSA8ZGVyZW4u
d3VAbWVkaWF0ZWsuY29tPg0KPiA+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCA0LCAyMDIzIDQ6MTAg
UE0NCj4gPiBUbzogRmVsaXggRmlldGthdSA8bmJkQG5iZC5uYW1lPjsgTG9yZW56byBCaWFuY29u
aSA8DQo+ID4gbG9yZW56b0BrZXJuZWwub3JnPg0KPiA+IENjOiBTZWFuIFdhbmcgPHNlYW4ud2Fu
Z0BtZWRpYXRlay5jb20+OyBTb3VsIEh1YW5nIDwNCj4gPiBTb3VsLkh1YW5nQG1lZGlhdGVrLmNv
bT47IFlOIENoZW4NCj4gPiA8WU4uQ2hlbkBtZWRpYXRlay5jb20+OyBMZW9uIFllbiA8TGVvbi5Z
ZW5AbWVkaWF0ZWsuY29tPjsgRXJpYy1TWQ0KPiA+IENoYW5nIDxFcmljLVNZLkNoYW5nQG1lZGlh
dGVrLmNvbT47DQo+ID4gRGVyZW4gV3UgPERlcmVuLld1QG1lZGlhdGVrLmNvbT47IEtNIExpbiA8
a20ubGluQG1lZGlhdGVrLmNvbT47DQo+ID4gUm9iaW4gQ2hpdSA8cm9iaW4uY2hpdUBtZWRpYXRl
ay5jb20+OyBDSA0KPiA+IFllaCA8Y2gueWVoQG1lZGlhdGVrLmNvbT47IFBvc2ggU3VuIDxwb3No
LnN1bkBtZWRpYXRlay5jb20+OyBTdGVsbGENCj4gPiBDaGFuZyA8U3RlbGxhLkNoYW5nQG1lZGlh
dGVrLmNvbT47DQo+ID4gRXZlbHluIFRzYWkgPGV2ZWx5bi50c2FpQG1lZGlhdGVrLmNvbT47IFJ5
ZGVyIExlZSA8DQo+ID4gcnlkZXIubGVlQG1lZGlhdGVrLmNvbT47IFNoYXluZSBDaGVuDQo+ID4g
PHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT47IGxpbnV4LXdpcmVsZXNzIDwNCj4gPiBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1tZWRpYXRlaw0KPiA+IDxsaW51eC1tZWRp
YXRla0BsaXN0cy5pbmZyYWRlYWQub3JnPjsgTmVpbCBDaGVuIDwNCj4gPiB5bi5jaGVuQG1lZGlh
dGVrLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IG10NzY6IG10NzkyMTogdXNlIGRy
aXZlciBmbGFncyByYXRoZXIgdGhhbg0KPiA+IG1hYzgwMjExIGZsYWdzIHRvIG1jdQ0KPiA+IA0K
PiA+IEZyb206IE5laWwgQ2hlbiA8eW4uY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gRklG
XyogZmxhZ3MgZnJvbSBtYWM4MDIxMSBpcyBub3QgQUJJLiBtdDc5MjEgc2hvdWxkIG5vdCBwYXNz
IGl0DQo+ID4gaW50byBtY3UNCj4gPiBkaXJlY3RseS4gUmVtYXAgRklGXyogdG8gZHJpdmVyIGRl
ZmluZWQgZmxhZ3MgYXMgbWN1IGNvbW1hbmQgaW5wdXQuDQo+ID4gDQo+ID4gRml4ZXM6IGMyMjJm
NzdmZDQyMSAoIndpZmk6IG10NzY6IG10NzkyMTogZml4IHJ4IGZpbHRlciBpbmNvcnJlY3QNCj4g
PiBieSBkcnYvZncgaW5jb25zaXN0ZW50IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWlsIENoZW4g
PHluLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gTWlzcyB5b3VyIHMtby1iLCBEZXJlbj8NCg0K
VGhhbmtzLCBJIGZvcmdvdCBhZGRpbmcgdGhlIHRhZy4gTGV0IG1lIHBvc3QgdjIuIDopDQoNCg==
