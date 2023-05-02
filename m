Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CB6F3C47
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 05:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjEBDQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 23:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBDQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 23:16:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0284F30D6
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 20:16:27 -0700 (PDT)
X-UUID: b56133dce89711edb20a276fd37b9834-20230502
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WVNk/ABpp5S/y0Yy3Urrg0e8eEymhWz2Arce/1H5DJ8=;
        b=XD25jCJsRv198uksysq3Vkm7cXRd3CIrsDS2vZ3f3iM1gjF4mHXsPT5f7BbAgtD1g6Sihf+Zkdof+3vbh4Amt6B0c9JKrjQP/yrXh4jyK5Cs9eW7+ndXIOGy9GLVoRBcVLjh8dKmPYB0jsxwPlSwLxCYtM+B39QQ/3JqiojwKKw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:a996fae4-c901-42f1-b81b-c3c17e4a5805,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:d6157330-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b56133dce89711edb20a276fd37b9834-20230502
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1211792287; Tue, 02 May 2023 11:16:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 2 May 2023 11:16:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 2 May 2023 11:16:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNfQekUE0pEYUIpv+i2ih1FBs6HLqDavjf/8SPrwNFpNldo2VzbwdWGcxSSc2/lcigNBxmjz02UWpxkwjDjvo1CPab1wMFqePxFOCzMIFDrDfaQX76Y6ND38JUu6cwebtioS1Ip+9rlf+T30J29XIENuheQ+lW+G0itfv04IpYsBieYghznfDm7hnK1NNH7JKuiA+k9OE+RqcM6hltP7FoJXIRSQR5ZEefpaXw/LNuX5rx0Y+TAnnggyzRA2CJM2nyHgopHjqqM56EqHvHCT33GOtrkv3sOLEhenLhUtk0HMsjfHl2oWmlL8HhvGYCzBX8jLbemH3sbChzwCwUBAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVNk/ABpp5S/y0Yy3Urrg0e8eEymhWz2Arce/1H5DJ8=;
 b=Ygd+ISgE62jqjUB8IO1NEjGIcV4azE0t42/kWj0ULrhE3Yboa9C5afeAsQaIVyhbSmpY/iO2mN7kYKIzy65hqcchbjaNfUXQ2wVEqdGME4vL+EOPkxjDlrg8C4yhrC0eW71ai5O3ZPaYAXh4vAqRht5VW3SnqBbHbRqiYlEqSIFURBrCOGbFcEKyvjEVTcJzrZXvdpzNYajF4GaJTQsMmqbxRJs5kX1DjdylSZXtmfj4PEmqq8R67i/XRUXoO1dQAe4YMdh573rQEsNgK8zow28OK/1JMaeMsfcoAKJPXUNq7P092BXH6ZSkpTLjFOjEyjimLBnXdWNSUqWNlmukkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVNk/ABpp5S/y0Yy3Urrg0e8eEymhWz2Arce/1H5DJ8=;
 b=Jvuk8xgRlE0hPmcA0mRZ5+9d/cKDCSyOWg7W7V3AQxN66fp2tBtrHfj2c1AYBg26V1g0qgwpjmMoGRRZ5A2VZNwoksrpVi/iuIaxKbH9ln5ifqBGZtwPON9F+EkFRpa65+ZYiRb81x3dRY3iYFYNxEk7dh8aPXK6znNE0RKzrH8=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by TYSPR03MB7650.apcprd03.prod.outlook.com (2603:1096:400:42f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 03:16:16 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086%3]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 03:16:16 +0000
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
Subject: Re: [PATCH v3 1/2] wifi: mt76: mt7996: enable BSS_CHANGED_MU_GROUPS
 support
Thread-Topic: [PATCH v3 1/2] wifi: mt76: mt7996: enable BSS_CHANGED_MU_GROUPS
 support
Thread-Index: AQHZfKOeti73SF3nakiXXCnHXCiAUK9GT6GA
Date:   Tue, 2 May 2023 03:16:16 +0000
Message-ID: <5f8fb97a7201f7149355fc05e07f0f4038cfe81d.camel@mediatek.com>
References: <0a7809914a0c480ed4761158142e3c7d2f41ca76.1682971025.git.ryder.lee@mediatek.com>
In-Reply-To: <0a7809914a0c480ed4761158142e3c7d2f41ca76.1682971025.git.ryder.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|TYSPR03MB7650:EE_
x-ms-office365-filtering-correlation-id: 645e9a3d-237e-4258-19fb-08db4abb9767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDj3xuU0uamciQVCg/FLY8KyJAHhRsiUVhmxhS86tocJUDaLtCjP9O8FjXivQemqgL8tjXZcYLTlu0hrbiptMQDLyOXfW8uOB5qmmKq5NaAJuttnm7niclJxC4agQm8hpWQgQAROOw+wwDtNedY8pwFemjBcDu5PPJfKoIXxkfxiuq87dgThL4wO6NaqdscM9aAX3s70iC5LgpPh5nay5PbV2pSp+LzRqIcpV56SUeP8wMiNe633BspDnifF4w4K0vcxO0bFUWvx7HpiFgdTVGALFPJQKtNDA9ZfNEKU7jueVkoIxxjn5Q5ePwDiWznpl67La9a7o0df/10XTGBUJQ+djWRhGFny/F4kxPI8FHpsMgGLjzD69cYTa+C+WgVGIu9qnYGZReQzBVMfNj8y8tSt7ELu9zcvq9Bw/NkhJn5px/b340Yc/O0gFTXMrmvMoXIsuNPFungBDMSZu6HBlmshY5udbpZXvuJTmi7CqcI07Cw0R+z/K25VQb2fc0++CtDBokPmpAD6u2vY23ss3NtYVs41luUJsUOaux/83b+ow9OvvGW4KiyIrjKqmbYjL2I4Tnt6ioFu1sWSGt8qe9FSK70Ox5I6o45GPunWj3hw5bhAb4Fw9aVt+iudAy3mgvDHvIpT6DqXfEpHGjsmKpaSFvoy13FdVCQVLHMSN9I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(54906003)(478600001)(110136005)(2616005)(6506007)(107886003)(6512007)(186003)(36756003)(26005)(38070700005)(122000001)(86362001)(38100700002)(71200400001)(6486002)(316002)(8936002)(4744005)(8676002)(66476007)(76116006)(66446008)(66556008)(66946007)(4326008)(5660300002)(41300700001)(2906002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hpMlhnbVowUG81TGs3bktWNWgrMzlvVFlHQmlpQ1drcDg2dlpLektoTVZ1?=
 =?utf-8?B?RzA0WlZYSk5VdGJ5SGtZdmdkemtZSW5POWFEY2JxQklwUHRvNEJnNyttN3g2?=
 =?utf-8?B?cmc4bnBXTnF6alNhVEI1K21mVGg2clhMUEZaYWcybzVOV2R2NkRnbURYQ1Vx?=
 =?utf-8?B?anZFUEFEdVJWZCtrcnVYb3JrR3ljeXpaSVFlMEJ1OFREY3R1VUVmcG9zVnBB?=
 =?utf-8?B?V3R2cUFMa0FyNE1kVTEvY0UzVFVvdTY0TmkxNDk2MklHWldoREx0MVpRRVd0?=
 =?utf-8?B?NDJVVW1obnVtSWFzdWNRaWliTHdDZ2EzaXRmdU5WWFRCcElNR2E3bkdhTmx5?=
 =?utf-8?B?MkErNkxkT2xWWS9oOFZlZkZFSUhDTFRUbHQ0YTJtcUZ5ZDhUbFozVnpUV3pW?=
 =?utf-8?B?MTFYK25BdFlGK082ckFQY2pUU3Bad0VqelE5a0RPdzlWL1FUd0IzWjVLNjJj?=
 =?utf-8?B?QlN4ajhuL0IyZ3pvSlJLZ1BTK3VWbVFlU04zeXp3UVBlTVhHMEtZOWlUSkx5?=
 =?utf-8?B?RDBsVkJFUVlUdHgwclJmVFlYZ3NJSUQ5TUFMOHVwbExtOE0ySG55Qk1Yd0FC?=
 =?utf-8?B?SEtzd1BvV1g0WndBTFpuME9sWGsyMDNiQXRsYWgrSm9RQkxVSEpoTFNFU2JU?=
 =?utf-8?B?TEk0UUZBRFZtWlQxdHJBbFBzVXFIZE1qcGs0aEdpOWNydlJnN2V5V3JreEtN?=
 =?utf-8?B?NjNKbVZtY014MWV6ZUI0TFh6WDRTK2FTd1hQTU4vY2dLZGwvWElaek9FY1ZU?=
 =?utf-8?B?T1FYQkZsUHorSWdmQWJTNHJZUGZydU1mSHZ3b1JyeldIa2RJaDdNdSt4QUpv?=
 =?utf-8?B?WkJrMXE5V1lZbEVqTXdtblE3RnRkTkNkeXk5NDVEbXNqdHVqRnFjYnVrQ0p3?=
 =?utf-8?B?WFVWVWh3aTlzejREK1Fzb3B5QWNBaUxuQmdSSG9FTVpjRm5kMTZlN0w4L3ox?=
 =?utf-8?B?SWl0RzV1NXpMblF5USt1N3lIM2JVMGZBazVUVmppTzJJUW85RUFSQTJhNmtL?=
 =?utf-8?B?UGZDKzhOSkJHazEwRVk5dFNQRmRXeGwyRGlYaWdESGNlcnZYUnhIOGgzV1U0?=
 =?utf-8?B?NjdtSnZvVFBLQVF1cGRNaGRTVUNQSWNrcGNaUjlqdFNlc2NmSGRyMmd5amt1?=
 =?utf-8?B?L05GOXpWT1BRaHpTa05hODdyZ1paYUg4M1F0Y0NHRjQwMHpCbC9YMEcxN1Q4?=
 =?utf-8?B?eFVNd3REOU5mdEQwTTNGSkRJR1VIZXFCdWRuMHF4aXpIN0tQeTBMRWRwL1Q5?=
 =?utf-8?B?TmVCb0l6RGoxMkVHUGxLb0kydXhtcE91UHFxK05HWUFlaDlxRUVGdUxDSTUx?=
 =?utf-8?B?MStnbEZEdWhRZEpDL1BjK0N6clludzBQbnUxTWkrK3N0SWE1NEpzTk9hemI4?=
 =?utf-8?B?ZDNGdkR1VVNZUjc4RmN4aTgwNEdhY1pkUzFlL2ltdy81R25HV1hES1RLMW9Z?=
 =?utf-8?B?MUpOeGtmNmQ3anlqZlcvTVB1R1lOUmFMTUVLOHNPS1RkOWtKb0gweGxaK3RS?=
 =?utf-8?B?eXozZUNCMG8zdWdFSFc2YU45NGIyTmVNRHFtVVNCK1VpdkZLOHFJYnlEZ2tU?=
 =?utf-8?B?VW8vTDcrZGk1UzJlZkZyOE5keVE5YWJTRWhxMllCTzdISW5BRCsxTG5mQmV3?=
 =?utf-8?B?TGJLNTFZTlFhdHJTSDQyS013N29TcVowWHUza0Q4OVZJSGE4U21aZldsbnYv?=
 =?utf-8?B?bzFNQ2pvVTIrOFM2TWZhK0RReS9JOGpabDl3bmhCWUZKdmJKTWhmc0V1UU5s?=
 =?utf-8?B?dWlpVjNKTGI5OVk3SW5KR2VxTmJoQWsvTk9jRlpTcHJ6c3dRdGpJS01mek1m?=
 =?utf-8?B?d1hZRWZVNzJUOE1jQTV0M1VrM2pHYnJMNWJqQ1FoN3VVVzZlYTIrNWhhT3Uw?=
 =?utf-8?B?ck9vL0pwbm1hZWZYMktpa1FhV1ZqVXIrakp0REs4QlZVOXhtUlYyYlBDekRV?=
 =?utf-8?B?SDJqWHYzUVdjVmxHY0JOcFZtb2R3RW5OTHVBSEtZVThBem10ZmJFNWlwelBs?=
 =?utf-8?B?cUJrOURNVSs1RFU2UEovT29QaE9FanE0M2w4aWJWTzhlckErTUc2Qk41SExa?=
 =?utf-8?B?eHl1Tlp3QVBtUzI0QUZDNHlabUZ3RkxPT3o3YkRYRWcwdElSNnBwNkdRRGZI?=
 =?utf-8?B?ZE8rdXVxaWVsb3NCcnZJRnNpTnVRbkM3V2d1L2ljT2h0YzAwU1U2QldqWXdh?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2916C9232738C54D942378E2E471F780@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645e9a3d-237e-4258-19fb-08db4abb9767
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 03:16:16.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByBco4OnZl8ngR6MF/p+f0NzC8mdFsq5+/Pag7KA5lJWxI8yJ8uiwwUJAGihMg0JLMI8HKn5vvrKE/64nN0F2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7650
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTAyIGF0IDExOjEwICswODAwLCBSeWRlciBMZWUgd3JvdGU6DQo+IFRo
ZSBHcm91cCBJRCBNYW5hZ2VtZW50IGZyYW1lIGlzIGFuIEFjdGlvbiBmcmFtZSBvZiBjYXRlZ29y
eSBWSFQuDQo+IEl0IGlzIHRyYW5zbWl0dGVkIGJ5IHRoZSBBUCB0byBhc3NpZ24gb3IgY2hhbmdl
IHRoZSB1c2VyIHBvc2l0aW9uDQo+IG9mIGEgU1RBIGZvciBvbmUgb3IgbW9yZSBncm91cCBJRHMu
DQo+IA0KPiBBbHNvLCBzbmlmZmVyIGNhbiB1c2UgYSBnaXZlbiBncm91cCBpZCB0byBtb25pdG9y
IFNUQSB0aGF0IGJlbG9uZ3MNCj4gdG8gdGhhdCBncm91cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IA0KDQpUaGlzIHNl
cmllcyBzaGFsbCBiZSB2MS4gRm9yZ290IHRvIGNoYW5nZSBzY3JpcHQuDQoNClJ5ZGVyDQo=
