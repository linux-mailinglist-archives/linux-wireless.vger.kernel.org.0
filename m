Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C463B6E8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 02:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiK2BLu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 20:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiK2BLt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 20:11:49 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C93C6F2
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 17:11:42 -0800 (PST)
X-UUID: 8a89663745274a17bf15908c40623091-20221129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jYxrxGHDWEGXHuFyu8Jxz8pIqOcTJ/VozjDafYuoovA=;
        b=aRjJLASJkzeoSL59FtRF5xvyvC13ZkoAg8ACtOR+vJjVCp3/z+Ytw5+DHyUPPfPtnqwzeQKgwXbnYVXqqyklcHFH+cQOV1ctPwC/+KykjA1EBXFwl6uHn9o8k2olJ31ENu6gNUy6H7W8hKETwzu9dcFvrkQ5YSifOhihfL9A//U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:52050576-c45d-44d5-b184-11bd0c3a188f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:df591230-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8a89663745274a17bf15908c40623091-20221129
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1618732963; Tue, 29 Nov 2022 09:11:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 29 Nov 2022 09:11:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 29 Nov 2022 09:11:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2OQWFPJeHXImPC2BaFRv68VN+D52KKkaSuMRJxDXBeBp22d5U2rXoSeGCA+8uzhbBDn4bsDMEI5vPy/xqE9pU5qjLmmyt5Di331GtV58Nc5K/U9C3byqTvXQDv3kUyq+JZGEkEpHjoVSYY3Byvjf36y8SSxNeiYtAqZXfKEeGiICgADdX4PPTqfMFArnMgD+WFftRTAxpGVLjmjM0WbTHZ9kVvFFKwQEsmAMgdY05P+WaXy+AfTTpeF4/Tl8p7JUq8wAOK5x9qcHEkXJJjByjvDWQJt0E/HKR6qDWAfQvAanxTo9sdutA/YvbjN2RBUznUJwHR1Nrk3VJv/62yJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYxrxGHDWEGXHuFyu8Jxz8pIqOcTJ/VozjDafYuoovA=;
 b=enqixKCa++ZSmxe7MTb2M+axbI3IiufqbkpYrQuGYusnquyrQQa6qBQvqPQDtzw7Rnsn5mQHX2n2MnLP5eTVpSvmFHwfvIRozIGqG4ljaXq2kwmnYs5sBQ2JGerdp+8Ted4mL/XV+Sgno/DGEbkO52OUhDEKBwQZH9RJzOCXm2kDCx4sPk56I9+3RWEBtNkX8WNiA7lXA0A1Bxrj+UWEOn1Rky2WQKP8Mdo5rCYcOlKpBwq9Hyk5w0CvzY+ZDnpemOs92P6NPZYaNZMYFS8GpVAW3O+eCyzY/m2Xcfju/IQWL+JjtY+g+qHaRG4jXa4Jc31fObgz/atEGC59K0b8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYxrxGHDWEGXHuFyu8Jxz8pIqOcTJ/VozjDafYuoovA=;
 b=JbfGWiBfh7pGiJCJF8WdUS3Dq9fUhjnBPZDq0QOZ/G1J91J2eyXPqh11LQt3sWAjN4PyjZuOL3UWDBbVB2djE2kek0NwY2jfVn/0h1RSo+0qbE3lsF7w8krzD3AGRQYEMNIaPc0t0xp/LxbjzjM4TesqrTNoHQ6mylmrIxDY9a4=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 TY0PR03MB6385.apcprd03.prod.outlook.com (2603:1096:400:134::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 01:11:33 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::68ac:ad8a:b244:2fa9%5]) with mapi id 15.20.5857.021; Tue, 29 Nov 2022
 01:11:32 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
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
Subject: Re: [PATCH] wifi: mt76: mt7921e: introduce reboot notifier support
Thread-Topic: [PATCH] wifi: mt76: mt7921e: introduce reboot notifier support
Thread-Index: AQHZAKCq5BE0RCMb00KUOtkK/GtZJa5UFcCAgAEIA4A=
Date:   Tue, 29 Nov 2022 01:11:32 +0000
Message-ID: <dc2ee8517043831471f22324493acaac201196da.camel@mediatek.com>
References: <28482de35c4f1589dcf96b662a48bc558fe46e8f.1669361180.git.deren.wu@mediatek.com>
         <14f4381a-d424-f84a-bc85-f4b25e6f1641@nbd.name>
In-Reply-To: <14f4381a-d424-f84a-bc85-f4b25e6f1641@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|TY0PR03MB6385:EE_
x-ms-office365-filtering-correlation-id: c102485d-06ec-4156-2597-08dad1a6a725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWbT32IscWz2+xmtHfHAVb//cVpGqAlcTexcuBpeT1SoQSPLy1X/bmMgOwl9tIwJrpL7J4c+Np5wm0uzvdfYqJMCxO32LXsrFyyqkUDxzPd1OjIrQjy2+ATY+MACzPAA8TUrW7sHIyydN06fAdfTZP6tgBEFFLkrzlAbjwuK68/alxpbgJSE41FG+BFnuBHnW7WzonJo7A/IMo6qnhvJIlnQUEp89NnyYZYMwQ0ozsxwYKo3hclMbh5tKAJqjsCOig4bPM0OhN80HG3vGuQQytAz4cX0YeN7YFYlWTitjBdIXVI3vkZexCPDuA4itOL38pg8fo4Dy8dKyBrMv5+nWxRKf8Le8Zxrh4/I797bnH6f94/cFPVSSnUct87+AnN9DD9QAzs/LH041U0LZPP4DAa44eW0CJvqd29Y7JziAXHbf7IPPsIjcFwaPk1rC8L/O2KfsoH+qEOCExyZpNJyal6RsLRAgglhGYBCBE27v9wsX2zQVC6CpD0B144vFCjJHtS4HcZjJKSpenKzzR8RmPx424/IF4Xf4y7HqcnR71P1sl5os895YZpUkFDf5UWhWMnNLIKlOWyyrvmZwmKJotDAiamVvwxGBK/ug2RP5O/BEgXcZ9y6CQEyezzxko+BCILtDq0xxuuqft4wD0roxW5nMJSa6gPSKzSD/eYfVj6H/a8SmHA2yAoZvlQXUVt22DQsKfYLpm1tSvRJxInYkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(36756003)(122000001)(85182001)(53546011)(71200400001)(6512007)(478600001)(6506007)(26005)(6486002)(38100700002)(91956017)(66476007)(8676002)(76116006)(41300700001)(66556008)(64756008)(66446008)(66946007)(86362001)(4326008)(316002)(4001150100001)(4744005)(38070700005)(110136005)(54906003)(8936002)(5660300002)(186003)(2616005)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0drT1BZSExGUzQ2RWpCcU45Tm5zMHdYUXl4OHFxQVA0Tis1aEFWR3ZFQVlI?=
 =?utf-8?B?ZHk4NEJqLzhkOWUxaU53Q2M4TEZhekN6STFIWjExdU5mUlIrT3dzTTlSbkcz?=
 =?utf-8?B?ZkRUNzJIMTZacjlUdzRrNXZOQWFrenl6R0d3SEVBZHRVQm5ndk1TY3VMWHlo?=
 =?utf-8?B?RndXbDQyYWtQd3QxWEdUdWp1U20yYmhMckUza1A5VnRzUDhwMTAza0hZd2J6?=
 =?utf-8?B?ZlorR1NZUmQ4L1F0VzdMMVlnc3pSZVVJcFBWbEF0SHFoTGlONE41bHBWZFRJ?=
 =?utf-8?B?QlBEQzFCdmRqN21PLzBCS1RZM3ltNnp0RUlMRFdYb25EemRxRFM5cjJWcVM3?=
 =?utf-8?B?UUFoYWM2Z3dQNzBGQlNjZTBWNXY0eEozU056U012WVUzZnhrUW90eDErU3Qv?=
 =?utf-8?B?NTNmcEsrSGx1NmFibWZqME1LUkNGM3lETEtTWVU4K0ZnN2s4aVlVOFhRQ2x4?=
 =?utf-8?B?N29jWkxyZFhHSy9JU2M2dGkyVTQxRjBLNkpGT1FEYVVSQVN6RGFqNmt2cDFP?=
 =?utf-8?B?TGFTc1kxR3piUm1lZHZpelVET3J2bWI3dWdvZHE2VWtxaVFHZXhoRWxUVjRi?=
 =?utf-8?B?aE9sZFVCRUV5S1FHeHZYanJWKzg3MzJOZWJobk1GeGw1eXlwb3JtOW1hQVho?=
 =?utf-8?B?MWQwcWRTcGRYZFlhM2Uzd1puVm8vaW90V3pOTDQrVDVCTTNGVG9wRWlYbGdu?=
 =?utf-8?B?M0pEVFNzVFA1SXIwdXFob3FVSnMyZzl2UzI2c2gweFFKUUtQcEZ4ZVdQUi9v?=
 =?utf-8?B?UjdGSGc0bEtzSTQ4Q3JKbXhMZlpGcE1pTXQ2dHNLd1pDcGV3TWt4b3VuMmxa?=
 =?utf-8?B?VjJpc3U1K241c1hBN0VEU0Zia3BDR3BMU05zYVJPUlh1OVgxblpWU0NWUVhv?=
 =?utf-8?B?cEpQNTRpT3B6ZjVYNGQyZUtadmhSRUZueHdBU2VxUnI3aStPdCs1WGt5Wjgx?=
 =?utf-8?B?TG5KZVNaNjJ6ODNnVHhQeTE0Zmd3anBlMHFjcmlVTUd2ODR0M0ZsQWZUTGI1?=
 =?utf-8?B?dHQwS0hSQXFhVFBIdmVxa1Bsazk5ck4vR0J4K1hVNjhWaExVeWhCV1dESERW?=
 =?utf-8?B?UGhGNFBnUlEyNXdDVE1JTDRFRDhlemhpSlZWcjgwcU5KdGg0Y2sySnNrclhL?=
 =?utf-8?B?dXVvM1gzTGFOMC9EY2FaUTNnTy9vWU9raUp3ZnpRTThIeDFhcHFjYmpWaHJK?=
 =?utf-8?B?UzJSRnhvZ3FoLyt1UjJBeUlOTEl5dWtxTyt0RjNiYnZGTE8rckhKUitCNVd5?=
 =?utf-8?B?SWJtQjRmQkZNT3V4K014LzE3ZlNiUkxxYjVnaS9IMzJQZ3lSYUdXZ1V1Wm1p?=
 =?utf-8?B?cHRmSU8xQnJTKzJvSXJRenpLaG9jT2YvdkZOa1JqUjB0NHFGSVZSQW92N1cv?=
 =?utf-8?B?YlpWUTBQUExPVmFOQ3hsc1gyQkpJSlltdk1tZGFvVmM1Z1FGOTgzS2hnNmw0?=
 =?utf-8?B?UWJ1d2srUy9wSHBJN3RoSkYyTnpMUnBGcVYvME1hdkNMT0JiUERxZkl4NTdk?=
 =?utf-8?B?Q3N6di9sNFFCdmFDRzJOWnBEQWNqcVpGem1oWWRqWHRSTSs2WjNydENWWUs1?=
 =?utf-8?B?U0t2MmxTK3JZVjI0N0hHZUhIckt0S2o5RUFsV1Y2VnQ2NEh6emNqenpnWW5J?=
 =?utf-8?B?OEUrTDNYeWt3eDF6SWZXd1U5MktkczRyODVYOFh2OVlxMHh3Y3owU1llOFZL?=
 =?utf-8?B?aFk1VHRVZHJGdSt4d1c5cWFWVVpHR0gxVm1ZWnk5ZklQNlpTYXhxaXhRYkhp?=
 =?utf-8?B?bVVnTVkrVHZleFpNZDNiVTRucFZDbm9CYUVZaEZxRExqT2RPTG5TL2VkZU1Z?=
 =?utf-8?B?SW1mdVZHUHdNZHZjNllseFY1ZWRFRW1wK1F4YXpYMTRQOEJpYkJleHRrVyty?=
 =?utf-8?B?LzZIOEF6aGVhVUc5OE94YzJOWG1JTi9aTjBkUlRISGFmc3ZPZmhYVDNvMVZi?=
 =?utf-8?B?RHVUK0o0MzRXdUNFeEpBMi9UODBNZnFBcmhBSi9UVXMzemdNcGw3QzJqQitr?=
 =?utf-8?B?NlIvZnF2WURCenprSUJHYmM5Vy9ydzFJMURuRlJpczY1ank0SFhnbUVDVTIv?=
 =?utf-8?B?dWp4K0daMnMzNkFFMWRpS1h6VWpOSDB5MzlQcGhCcG9pSnlsQnFPUE9WdmRE?=
 =?utf-8?B?SHAxcmsvejFGSldyRzNrdmt3aHEyTHBuTE9MditobUpUdHpnUTU4R1ZHcnEz?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <204F2AE672E67947BA97800D5065CBFD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c102485d-06ec-4156-2597-08dad1a6a725
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 01:11:32.5040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puzKOQiLwKesf/LxEfKNLZMX0wxv0b3l2H2hakH27GqMi8cZZxnDKReXwsr+6VLARtVjqzLNmHGda+p3OEcvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRmVsaXgNCg0KT24gTW9uLCAyMDIyLTExLTI4IGF0IDEwOjI2ICswMTAwLCBGZWxpeCBGaWV0
a2F1IHdyb3RlOg0KPiBPbiAyNS4xMS4yMiAwODozNiwgRGVyZW4gV3Ugd3JvdGU6DQo+ID4gRnJv
bTogTGVvbiBZZW4gPExlb24uWWVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBTb21lIGNvbWJp
bmF0aW9ucyBvZiBob3N0cyBjYW5ubm90IGRldGVjdCBtdDc5MjFlIGFmdGVyIHJlYm9vdC4gVGhl
DQo+ID4gaW50ZXJvcGVyYWJpbGl0eSBpc3N1ZSBpcyBjYXVzZWQgYnkgdGhlIHN0YXR1cyBtaXNt
YXRjaCBiZXR3ZWVuDQo+ID4gaG9zdA0KPiA+IGFuZCBjaGlwIGZ3LiBJbiBzdWNoIGNhc2VzLCB0
aGUgZHJpdmVyIHNob3VsZCBzdG9wIGNoaXAgYWN0aXZpdGllcw0KPiA+IGFuZCByZXNldCBjaGlw
IHRvIGRlZmF1bHQgc3RhdGUgYmVmb3JlIHJlYm9vdC4NCj4gPiANCj4gPiBDby1kZXZlbG9wZWQt
Ynk6IERlcmVuIFd1IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RGVyZW4gV3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9u
IFllbiA8TGVvbi5ZZW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhpcyBkb2Vzbid0IGp1c3QgYWZm
ZWN0IG10NzkyMS4gVGhlcmUgYXJlIHNvbWUgcGxhdGZvcm1zIHdoZXJlDQo+IHNpbWlsYXIgDQo+
IGlzc3VlcyBoYXZlIGJlZW4gcmVwb3J0ZWQgd2l0aCBtdDc5MTUgb3IgbXQ3NjE1Lg0KPiBJIHRo
aW5rIHdlIHNob3VsZCBtb3ZlIHNvbWUgcGFydHMgb2YgdGhpcyB0byBtdDc2IChhbmQgbXQ3Ni1j
b25uYWMpDQo+IGNvcmUuDQo+IA0KPiAtIEZlbGl4DQo+IA0KU3VyZSwgSSB3aWxsIHBvc3QgbXQ3
NiBhcmNoICsgbXQ3OTIxZSBpbXBsZW1lbnQgaW4gdjIuDQoNClJlZ2FyZHMsDQpEZXJlbg0K
