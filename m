Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D266B9D5F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCNRrv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCNRrr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:47:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88531B3E03
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:47:40 -0700 (PDT)
X-UUID: 4eb1a680c29011eda06fc9ecc4dadd91-20230315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SWxKMfvpSRttD/51dSXqrYoIHNHjWvyoUa/7Q4YTxi0=;
        b=pcF1VWu7z22HHfqfjeQ4rmb1HW2l1FO1WWqs2DrfnyRkgrRUNUopSEN6Xo1ag9rrHRDtLfS3UT0SAdhvsZsfPg5pXo8KI7hDuw/t4qYpqKt2+kgyuhD6Pus6MTmtICxFhGvY4lDqQKeJCDwoMqksBQvwGuE+84WSUllnkAMp2XQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:5c601639-c8f2-46a6-8de1-24aad5c247a3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:805ac9f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4eb1a680c29011eda06fc9ecc4dadd91-20230315
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1836033486; Wed, 15 Mar 2023 01:47:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 15 Mar 2023 01:47:35 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 15 Mar 2023 01:47:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ7WQRdR9aHmtsGc2AV2Z4sT6ucgEAwq9/393+OzVnIuYh/x9OMj2AHmXPPZWr+fINS1xRW2j8ULWM8QZkPUzMuMJiIuM49JBdimDvZ02rOdOu8YlgUkkmIGw3UaR/oNOROE1wQEpdO8J7gKbBLVnB04kNf89q2Ij1mag6qM8W2ny8F/OiAMhpFsbxTKH9CQ/YB1t+EOjKzE648Riq4XNMLBx09RnBbu44Uof54dqRU5nMfvhOWSajKfdquC5198tstWlpCP4ZYQMQq/TVduryYa40Mqx9WQKUjaY+NysMnrVw8qVsplz4U9iYyPXlaaB43dcT9eiD6QEAX4lmXRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWxKMfvpSRttD/51dSXqrYoIHNHjWvyoUa/7Q4YTxi0=;
 b=OMthpy4+ES7Fj9zgsHkHs6DN3ftdRvJ8W1OFigZcPdvlsss0ddFU3AcQtDAROarobqavLdj16IJ9PFlZjSURIsi0iJllZdzvaL8BC0OpuVM6qRlwSnMCgKSpF+J0A1lh5Ac4p1UO4V29X1n0qcBwg2BaXn8ttUSklXlIboR/T7BrlvhMXRYbJHP6LBA4hraie1jZxKNTeiTnRthzgVXh1X2pERoWdgar3sA2No1sQd5HxY5jFc2JFYkEFpoz1dYNAKMEsm5tB/Mg9faXlvBgd7yA6O3ULQrs9GixdPXSEh5VTMrh0zv53JJcud1QvOM7SCqtloiM1MtC3e7BxVWVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWxKMfvpSRttD/51dSXqrYoIHNHjWvyoUa/7Q4YTxi0=;
 b=gCs9JgrI+Ug9g8ZYEWMPkp2QoHXQaa1QzXiPZ6CCI9IuhLsx+cWO73CNOg0Zz0vvAt8pOp0GGWfQOG2ZrNLvl4wHP6NC6QAtBaMIr02KgjGMdzq4DTxWTFdnfaxIGKSmcc8ErDrCDH5FLvRhWsnSBIu6S5I3Wvu9wh09Q2GB5lQ=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYZPR03MB5965.apcprd03.prod.outlook.com (2603:1096:400:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 17:47:33 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::6f0e:2512:2c4:a56]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::6f0e:2512:2c4:a56%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 17:47:33 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>
Subject: Re: [PATCH v2 2/2] wifi: mac80211: add LDPC related flags in
 ieee80211_bss_conf
Thread-Topic: [PATCH v2 2/2] wifi: mac80211: add LDPC related flags in
 ieee80211_bss_conf
Thread-Index: AQHZUNzeMxMxB7N930KSAXEX4RL3wa76mGCA
Date:   Tue, 14 Mar 2023 17:47:32 +0000
Message-ID: <dec1bb67025467efa3ffe06359f19cf03f81a1fb.camel@mediatek.com>
References: <8d9966c4c1e77cb1ade77d42bdc49905609192e9.1676628065.git.ryder.lee@mediatek.com>
         <1de696aaa34efd77a926eb657b8c0fda05aaa177.1676628065.git.ryder.lee@mediatek.com>
         <3e20bade92b97c7b441f18c7e12e12eaee519481.camel@sipsolutions.net>
In-Reply-To: <3e20bade92b97c7b441f18c7e12e12eaee519481.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYZPR03MB5965:EE_
x-ms-office365-filtering-correlation-id: 6c3cb651-5dd1-4c34-9e4c-08db24b4306e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kI37ooin3Xlzmc9whvsZdYYjopTBic1CHHe2k263v9ukQ2I1NOgHv53r+2A/ilE7AMYaYnVmgeuJrT/GusTSegxpYp44J5U9TOlmopXmfaE0OIaF4sNWmrxstNwDxLa+QZrE0Zhx7Ajy3iHcyXr2biV7UuHPXQJVQ5dSs2O7x0yp9jO2uZzaHVr5M14luZUTHiuWvFxRZymV+FZCbwb9wFo0zGixvIra95+tal9U9CXAcU1qpFe/KPTjZ69nOUxvYKp/Qk1dQ+mrOzomrAZJxucBYFy/8cE0fsDkDZwIBl5d7BjBuG2Rc1xlDV5JunIIprPjPOqRBBLVQd2CUuW+Hva5T6PeDG3qbQb/+gSjxqmOCVV6TsQWMeXe2RodokNugF1Ww0tG4pLl9U5wEBtp+cNmbY/MWqLegoGQddZpRzL81snUcsXkrIzeaY53a04p/DuQ9qRzwP4ow/1zaRsJWhVAnhOh3OBc5UVqS0UhAkj7zSkx0OmfiNxuupQQGvxrqF3bS1esi5A4lDU16xXxOoKzdaUNX5jP4MX6mxzmFWBtLATNpYOx8etU1Tu3QU74tc7JQaeBuG/PY7aD5K2TXC1ykgJhc6a6QFzZMO8O8xq9ghm6goctzDRfvJVUxNzfYbADgHAi/v4lvt8JjT04UbhX/tY+U6i3R1iZwVwGBpuvZXkxhUdwB6uBw74cZnHHh+iX6Mi3Nw0a0K/6csZdbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(2616005)(71200400001)(6486002)(54906003)(26005)(107886003)(6512007)(478600001)(6506007)(186003)(122000001)(86362001)(38100700002)(38070700005)(2906002)(4744005)(5660300002)(8936002)(36756003)(66446008)(66556008)(41300700001)(8676002)(64756008)(66946007)(4326008)(6916009)(316002)(91956017)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmRHd0pIanpHcVhFSlhPYTFoejgyYXlnUGZvVXlzUmJla0NKdzJMeGZKd3Ru?=
 =?utf-8?B?Z29veEhPTTVYWkYwQjVsamtHdWE4Zmg5cEhXWHc5QjA5eFB5QUpiRm56YlFI?=
 =?utf-8?B?bmxQeml1TWZIWWpBb1YyMGxxS0V6Q01TOHV1LzY3K1hJbzViMHFYOGNZMnFU?=
 =?utf-8?B?cUdqaDhaVGxQR2VxRmdPcWQvRjRkelNONkJxY244d1JhZTJtUWprRi9OM05W?=
 =?utf-8?B?V0tkY1dNMjRyTjRTYVVUSm5aYk1MRFBUVndLbG9lQjNYS1ovcXgxMWIrb0k1?=
 =?utf-8?B?SDdpWC80NmdGNm5qNW92N0Y0aFFaTnNIVU04UnZRZnE4ZkNhNjZPaFVjaWl3?=
 =?utf-8?B?U0pEdVd5ZkR5Z3VvbTY1SnNHMWdJQkpURFZzOU1wV0lOWEVFa0U0Nzl6TU8y?=
 =?utf-8?B?bXBRVG1ROFZjM0pYWUJiWnJYUVhLSGpvdFBvNWg3OUY4Y0MrNFRkU0JDdlBX?=
 =?utf-8?B?QTMxcTk2eElPUURUbnFYOUVwb0VCcjBWUkVBYkt1bTBUKzBQN2N0OC90Q2NX?=
 =?utf-8?B?ODdkYlZaTERCenJwL01yWUw5Y044ZTE4RzlQOHFxZ0R5M3NlQktNWXo1Qlo4?=
 =?utf-8?B?QnNzRDFjVnNNVDZ0KzZ0bFg3c05Rc0NCWWVaY3hBbmJKU2tEMVFPUlBqTWpI?=
 =?utf-8?B?TXZHaFM5RlNsNVlQMHhVSHZtNVNmMHVDZTY4WkdVV3d1Um5sZW9LdmxqRDAw?=
 =?utf-8?B?cmVVdy90dkFTREtYbFp4TVo5TWRBVVZIaGZWRlhyeW1tcGh2UVdMQkpLTWJp?=
 =?utf-8?B?SVE3cEpueTUxREJnUm94RkVJWWQxeE9vZDNiL1Y2Q1BUQnR0ekVFUWs3OTdV?=
 =?utf-8?B?UnJUbGNZeC9hNGFURE16YkpLVHVsOVNTZXFFVFkvMjdnK1YrcFlGY0hBRFN0?=
 =?utf-8?B?Q3Y1TXNTc285eUNzczVEKzVqUE8wL2kvNElvbWI0cVZZbVdBMVBxdUdzNEpI?=
 =?utf-8?B?UG5ZNklmQVFyRHIyeVVodlhleWFMQ0lHYndvZnNXOUxNak5MRkRUTVc1WEdn?=
 =?utf-8?B?TUNIQUJPbzRJclhTY2ttVDlsSUZCTWl2K2c0NzdOaTNvOEtxdTV1a3pOTG5i?=
 =?utf-8?B?TGZNblg2dlNpRmJSWEdKWWMzb29yWHg5cUdlSGNYQ0dzTGVCKzZNVWRDTngv?=
 =?utf-8?B?T0x0V1p2aGV4eDhzZHNtV1pGdW1VM0RVUllXZ3BPY1RhWVRCV0RCUUg4N1o4?=
 =?utf-8?B?TFBockFSTVVkZVAyaGZrRGVDVE5yTlErVTYweWh5emVTd0ZXVVdJckJIWk0y?=
 =?utf-8?B?RmNmUVJRNmdDSERKZ2dJNVEyMDhsU1JiZlVnU0FlRkdtMXpEOXlJZlJrMmNp?=
 =?utf-8?B?TlpmeVZoMXlaWURoWllqSFJVTmE4czEvWVFqbWk5VndmbHpnT1ovQTNSdEgz?=
 =?utf-8?B?RERMTTRyVEZDaFhvUDBIbU5FZFBhL2txeWdFR0I0bGxQajJhdHo0Z2pRQzM4?=
 =?utf-8?B?Mk90KzN4THd2VmJtYmV6VlpYaDNsb1VId2hZNnhNNFM3TnQ3M2FqamtiSU55?=
 =?utf-8?B?amJXUlZDaHB1U0l0ZFlvcngyUlZjNFI4cTNUS3VvbjVNTDNsMzRwZENGQ1JQ?=
 =?utf-8?B?Z3ZiVE5JR2hjaGtpa1FhalhUeGh6TVRiRXQwOWhOazZSOEJYcUw3dlRLQjNV?=
 =?utf-8?B?MWRqM3liUnJrdWlybkNxaVpPREhSdkhFL0p1NytKWFRUSDhjOXVhUHI2TkY5?=
 =?utf-8?B?TG84QmJGUEpNMmdFRjE4ZHFnNEFCaGdlSzhPcFlqNjl0Q0dkQ3Z3M0dyZWpX?=
 =?utf-8?B?Y0dnNUN4cnI4WUVnNWZScXVGdmtSSCt4QStQRTRUNGNaZElnTHNYQTU1ZFQy?=
 =?utf-8?B?dGtHMnV3WFY5aWkyNk5jbmtQZTZiSTNadjBtYnBJa2hLS0hGb25ZM0M3TUVr?=
 =?utf-8?B?SFg3anZGTVc1TE1iaHQ0Ri9JZFpncmN3c0hqV1UxbkZrbkN1MFVPSkVDNmN2?=
 =?utf-8?B?MU1jdjIzaklYMkN6ZCtuYllVUFV5c1BWVWFQQlhzYVc5WUxmbDhWemJHNlVZ?=
 =?utf-8?B?djdKWkdGa2xnaHdxQ2VPNGp1QmhhUGhCTUsvdnlhZWZNVVlVa01CeTZKdlc4?=
 =?utf-8?B?ZXBGaWptNlpIVkYrM2dyYXF2UTBVdjYvcHJIR1VhUW9HR1ZHVit1NS9mdG43?=
 =?utf-8?B?b1dCNG5NaHNQakEyWEpSbU02eUFtWm1YejZta0dldUhzMUd4OWlkQ1VHSmQx?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DABEFEEBDF2FA4CA379E0DF2A8D5D99@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3cb651-5dd1-4c34-9e4c-08db24b4306e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 17:47:32.8169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPjX3ZheUAHhrx+PInI0xW/64p2n9Yr5LsKwDXGLH4RERemVWF7J5pYhG9Owq77r+5mCRAHM5LLtBAeY21gfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5965
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTA3IGF0IDExOjA4ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBTYXQsIDIwMjMtMDItMTggYXQgMDE6NDkgKzA4MDAsIFJ5ZGVyIExlZSB3cm90ZToNCj4g
PiBUaGlzIGlzIHV0aWxpemVkIHRvIHBhc3MgTERQQyBjb25maWd1cmF0aW9ucyBmcm9tIHVzZXIg
c3BhY2UNCj4gPiAoaS5lLiBob3N0YXBkKSB0byBkcml2ZXIuDQo+ID4gDQo+IA0KPiBJJ20gYXBw
bHlpbmcgdGhpcywgYnV0IGNvdWxkIHlvdSBkbyBtZSBhIGZhdm91ciBhbmQgY2hlY2sgdGhhdCB3
ZQ0KPiByZWFsbHkNCj4gZG9uJ3QgbmVlZCB0byByZXNldCB0aGlzPyBXaGF0IGlmIHdlIGFkZGVk
IGEgcHJldmlvdXMgQlNTIHdpdGggZS5nLg0KPiBWSFQNCj4gYW5kIHRoZW4gcmVjb25maWd1cmUg
dGhlIGludGVyZmFjZSB0byB3L28gVkhUIGFuZCB0aGVuIHRoZSBzZXR0aW5ncw0KPiBtaWdodCBz
dGljaz8NCj4gDQo+IE1vcmUgZ2VuZXJhbGx5LCBpdCBtaWdodCBiZSB3b3J0aCBjaGVja2luZyBp
ZiB3ZSBjYW4ganVzdCBtZW1zZXQgdGhlDQo+IGVudGlyZSBic3NfY29uZiB0byAwPyBXZSBhbHJl
YWR5IGRvIHRoaXMgZm9yIGxpbmsgY29uZiB0b2RheSAoYWx3YXlzDQo+IHJlYWxsb2NhdGUgaXQp
IHNvIGl0IHNob3VsZCBiZSBPSz8gU2FtZSBhY3R1YWxseSBnb2VzIGZvciBjbGllbnQgbW9kZQ0K
PiBzbw0KPiBtYXliZSB3ZSBjYW4gZ2VuZXJhbGx5IGNsZWFuIHRoYXQgdXA/DQo+IA0KDQpJIGFn
cmVlLCBhbmQgbXlhYmUgdGhpcyBpcyBhIGxvbmcgc3RhbmRpbmcgaXNzdWUuIEkgdGhpbmsgd2Ug
bmVlZCBhDQpmcmVzaCBzdGFydCBmb3IgYnNzX2NvbmYuIA0KDQpJJ3ZlIHNlZW4gdGhpcyBjYXNl
Og0KaG9zdGFwZCB3b3VsZCBwYXNzIGZpbHNfaW50ZXJ2YWwgb25seSBpZiAocGFyYW0tPmZpbHNf
aW50ZXJ2YWwpLCBzbyBpZg0Kc29tZW9uZSB0cmllcyB0byBkaXNhYmxlIGl0IGJ5ICIwIiB3aGlj
aCBkb2Vzbid0IHdvcmsuIEtlcm5lbCBzaG91bGQNCnB0b3RlY3Qgc3VjaCBjYXNlLg0KDQpSeWRl
cg0K
