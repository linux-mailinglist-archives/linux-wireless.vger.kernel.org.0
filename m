Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7636F2001
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 23:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjD1VRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 17:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjD1VRp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 17:17:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B311FF7
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 14:17:41 -0700 (PDT)
X-UUID: 18bb4926e60a11edb20a276fd37b9834-20230429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=77jg18AJ8uXs/HQ80ayToYvE83IPDCm3ZE3lYl1+btM=;
        b=fRUHjf1sYEWvolwMKChfcV4Wt0cCVIM6XhXKE8BmOdh2q0Ge4vaG7xAb/xtXXzohB6tH0p3BMxD4rZgas6oyUO4XVLYBa6jQcyuVeRSrTirQ0y6aSylRwQpgw0TuxDwLiPqkkKKHXCFxLTb3XWlbnSJBsv4hcOLBxT2km312dnI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c16aa7d0-80cc-498f-b893-b34e831b6f31,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.22,REQID:c16aa7d0-80cc-498f-b893-b34e831b6f31,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:120426c,CLOUDID:3479416a-2f20-4998-991c-3b78627e4938,B
        ulkID:2304290517372ZUR1TVN,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 18bb4926e60a11edb20a276fd37b9834-20230429
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2126787317; Sat, 29 Apr 2023 05:17:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Sat, 29 Apr 2023 05:17:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sat, 29 Apr 2023 05:17:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwwxy8RdhlHaVQI7O0XlC8C3u+hmJzK/o+dkaHk/+TeFpC+M52qTr9zRWkBkvI/3oo0mxbwA8gC8LkQBJ9m/EkjWaHOS34KaCp0EdpaLNYaPKEcd9w02x/aSnZoSSZWdKO3OnHmE4yKZbpvUFYWY2vHWkihoKsiXGmR7T3NOj8Rrt0Mbhj93hv1HypudSU3tt68IyJkpiEzsbwjVXPUSR/YENilik4I4troc6B0aV1tyzeiXp6J6VXhXAXNz3dWxkZGCKD8jNfj1rrp/RHJXUahS6O+vZFH1VoD8c324uP0iYYENGewvZLf4I2qIgc9eEd66q8N3xuRyYHUG8ctJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77jg18AJ8uXs/HQ80ayToYvE83IPDCm3ZE3lYl1+btM=;
 b=eWYKB8rA/ffZ/yO3dqVD3mVSUEjsn7+D7wmbyRT+qKgIJeKW/V3yxiOp1gK4pE1A3d8O45UyDDWPK7zap/oL/aaJV7fX3+toHWp5oWDsYdPEyldX+SAMQOSlNvT8q6Lj1ZZSAQ/T+cFc71wg1yUnjf8LnulskBVpwUlQua3UG9o8a6FtbZ4jvPhxGwSTfNciVnMCLSGDNFb5FUZiR1iTR15Fajiil9CxwuD2TBdHWT4ufCnyOUa00Q4U8KhtmUJPAK3YJZNFmHlKAVIX4ImfQAx9mJp+FV3Wjlc+QJ0GVz7oTQtPwxnMZbSHH3PBi01EZl1Lz4AxZTed7rTVk5Q7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77jg18AJ8uXs/HQ80ayToYvE83IPDCm3ZE3lYl1+btM=;
 b=Pu5EMXlAL62FQi4IIVL1mF2qzkDGP+tHoYXK3jGTA2WgLKeX4ciGZqfKKJioh4o31mKEtuffiL+1ZPMfHsAzgvepLlK7ppUHPwytHGODZfhnU0u3qxombiriUzJBA8cUVRN5Q/cKwgztqb/ay5vdqVxGg76mUVlpO1q49ALisjU=
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com (2603:1096:400:14a::9)
 by SG2PR03MB6229.apcprd03.prod.outlook.com (2603:1096:4:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 21:17:32 +0000
Received: from TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086]) by TY0PR03MB6354.apcprd03.prod.outlook.com
 ([fe80::d6f0:880d:41c4:8086%3]) with mapi id 15.20.6340.025; Fri, 28 Apr 2023
 21:17:31 +0000
From:   Ryder Lee <Ryder.Lee@mediatek.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "greearb@candelatech.com" <greearb@candelatech.com>
Subject: Re: [PATCH 1/6] wifi: mt76: mt7915: Support vht mu-mimo sniffer
 feature.
Thread-Topic: [PATCH 1/6] wifi: mt76: mt7915: Support vht mu-mimo sniffer
 feature.
Thread-Index: AQHZehMPqg3Wm28JCEGt5B0hwlvI5a9BOYmA
Date:   Fri, 28 Apr 2023 21:17:31 +0000
Message-ID: <3d784f9d0b36c4147a37a090c213a58bdeed6401.camel@mediatek.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
In-Reply-To: <20230428205000.2647945-1-greearb@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6354:EE_|SG2PR03MB6229:EE_
x-ms-office365-filtering-correlation-id: 9fcd176f-9ca5-4288-bbc5-08db482dfa98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ruohWFiBavAG6hFpBW1zsk0ru0uFMx6T1GQSoFs476UGTQQdboDRwL5jqOjlVX634zPY+wafXGkqn6Fy2Z+gx2md+hU4x6mg3GOFPNbl92qny6uuaQwrKIGJpZFhqpq5PyKPIWAdvVzKrjsn7Bea8L95q5OwFLh0KWdT31NUJL3Dp+sbcPuFoxmWRlYk5CHfntoKJ4DmYcIeqMLfN9VfFsssDYFFVx95elBKLTUKiEeEOP2etEFKeDlx0ENsOz8i0PZxWRsQ/wULmGiHYymF0nXjdUacJFz3qx2OPRjVQCktY2/ktuaNq8gpob+TBl+GL4MdhBLU0YUH5YnGQgYygqwaESmLCa+U+Y/ScZynls8oxwAjG+Qk6BZSgcjH/tBeKGMS/nhVOu1rQZsb5VniRaIGB0cZkP1Yxik9euEAE2i4nnfrVcgMTx2KrwvP747X0bgvOmeeRnq/yb+Ej/jYcDYLWJAoleluBtSStfdDSrjiTVw+4r53WtXLqdTiFwY4Ox8ewXmD+bv7eEkL/l4G31eU3HiXZObd2DpZ/fhcv45iDuSuMVQ8ttgWvHCHK1UccjQZlgPIKah1Aj5U60V3OZi/5ys1TLvueUN9UNyTkGHb4+b+WgMP4YsKt96wDXvn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6354.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(478600001)(36756003)(8936002)(5660300002)(8676002)(71200400001)(26005)(66946007)(64756008)(2906002)(66556008)(76116006)(66446008)(66476007)(186003)(41300700001)(110136005)(316002)(122000001)(38070700005)(6512007)(6506007)(83380400001)(2616005)(86362001)(38100700002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHNHUldsVXZGNysvUlZrL1c4Y2ZHVXdhbTNQTlRMc0xSV3RkU051Q0dtTWYw?=
 =?utf-8?B?YzFEQ1Q2YmFTelVUUDZuQ2xnL3JRbEVSU0dlN2ZhOFFxc2h4QkxST2xEMjI4?=
 =?utf-8?B?dC9LZWszVXJGampPa24xdkR1Z3NMalk5bU52YW0zVU03U3hxUGgwQjQ3UXM0?=
 =?utf-8?B?anlwb2tqclVWS1lCbmZCWjg1emtNSGxGaE1Rcml4VTZlL2NFYks5RzhZcVNI?=
 =?utf-8?B?YUVBUGZ0S1gwdzVXQ3o0cER4aUZDOXUvTHR2Uk1WRzB2L0Z4OVpCUS9mSTN1?=
 =?utf-8?B?bWhSeGQxQXBIK2g0YnlpRXJqUmdibXRNSlJNdUE1a2tSWVdrN2Q4UWlXMXA3?=
 =?utf-8?B?RWgwbTFoYnFvaWx0Q0VSNHh4SUt5SnluM2VqT3lEdjkzaWdWUldnakJsaGtE?=
 =?utf-8?B?KzdFRTNvMDNpSlFUUUw0TURXakNjdzBseHNubjVqZEh3M01tVE01b2hGK2V1?=
 =?utf-8?B?WmRoemtGKzFBeXRFcXcyL3ZLa0FSVVBzSjJWdDBPUTZwaU5nV3NGcTgrQnJi?=
 =?utf-8?B?eHV2QkNERkdpMWJIc2txQndiOElkT3J2eFdZZUFMT3ZFRWh0S1RGdEVEc3VP?=
 =?utf-8?B?eVg2MUxiSEN4M0VUWkh0dERuMGQ4M0NRaWRvY0FhbGZNbER0Rmd1ampKQkZT?=
 =?utf-8?B?SXZSM3dSS3V5R0VQczR0dkQ4L3dYd2hpZnRsa1V1dTg5dm1hWkNnZlNhQlhr?=
 =?utf-8?B?K0hKWENEME9vZDU5aHN2ZlhkazRQWHg2QzZyY1FCNzlIZUlzby9NcHhIdDdX?=
 =?utf-8?B?V0ljNFBBKzVjTm8rWUhuM090SnFjT0huN0IrcEVSTFhFYUFlcm5reDZhODUr?=
 =?utf-8?B?Q1lYUDZOdnNHN0F5Qk1RdG1QUUJpRWJhOVlKdnFWU3FRVnFQS0hCOEJBaUR4?=
 =?utf-8?B?OGh2Z3dmZUZKNmlyR0FvcUxiZUFtRlkrdnVueFp1OEV0YmxDNmhZZ3FGYVdY?=
 =?utf-8?B?YVQ1ZWgyT3VYQ29mdjlzVHE0ak9LK3ByRUkwcDVHS0k5a0ZXeFQ1RW9xcFJR?=
 =?utf-8?B?dVE5S3p5SGI4emppcWlZL1JqZ3FyOUxBOUtCa1RzNkdpcUVmeEdVb0ZBTkkz?=
 =?utf-8?B?T1V3c0pITHVjWThmRXhKZFpZUmVBa25UQnZuSHRkMEVEMXEyTWE3dkFuOWxX?=
 =?utf-8?B?OEMwcENFK05pNXp5YmNxK0JMbjJ1ZXh4YVpsTFhHam15U2R3VGJMcXpubW1H?=
 =?utf-8?B?b2Rybk9pcG1PMGtVY0dlOVF0dFcvWmZTNHgxTXVQWnBONUluMUcrWUIrdCta?=
 =?utf-8?B?YkhTLy9HYkdpS05JR1dlRHJSc0pOWHdxRkEyMDF5cXUyMEl6UGRZZ1lURjZt?=
 =?utf-8?B?TXJIQy85TnJROWVaYVlFTkk4L1NqRmhNSW1tMTlreU9NTEtSWGtOQmdhQ0I3?=
 =?utf-8?B?cmRBNXlHVDNET0NUSnY2MSt5TVp0SHBVZTZ5Z21aSnRDVlVqUGdzZTF2RWJO?=
 =?utf-8?B?Nlczb051L1JycWlsUHNIcnpLNXkyT3dGV1lLWjVTcnJCeXQ1RTFBZzdLSVhj?=
 =?utf-8?B?OUcvTGYxbGg2VGZEQll6cFRoV2NZQTZ5M0g1Tk5UWjdRNDJjRFhoWXJVc3Nm?=
 =?utf-8?B?UXlDNyt4RU9sU3VqYkoxcnNsMVR1YlRjLy9xaHhhSHF5Q3NXNVQ3RzJ6Y0dR?=
 =?utf-8?B?VFExZmx6VkhuTmdZb1E1Y3pTMjVJTGhZTE54VlpNb1daTnhTbGVDdTBGVENU?=
 =?utf-8?B?dExwVHQ1bWNUL1NKTXlMemc0aWNHVkc1WUx2enc1OXBwS2JLRjdJc3lnZzY4?=
 =?utf-8?B?K2F5eUh4Z3NKc3VNWGw1bExKQVRQeFkzZXh6R2pNbW93TGZjMlBpTjN4a3pw?=
 =?utf-8?B?dklPT1BNRlEwUWViTHVoQ1dtbGZ4K08rbGxLWllSa3NZNDE4SzR6Ri9rNm1T?=
 =?utf-8?B?MEFGYWZRR3VOREpWS241bTVRdUs2RHhCMTBTYVVoRExkR1A0Y3dQV05WeWs2?=
 =?utf-8?B?MTBPV0dlY0ZLUk9BMS9Xd3FOL2pxSElPN3M0R3VwTVhQMTFjYVBFYmNOUm5O?=
 =?utf-8?B?UnlFT1ovRU9YRmU0ZFRsQmd4WTliK1J5aEZES1haUXpDcVBxTjN1T3VJTnl1?=
 =?utf-8?B?cmxnOG1HQVBTL3NQNTBZcVQzeFMrdGl3RzVyR1FBMmRGZ1RJaW44aWQreE9M?=
 =?utf-8?B?UzZkNVU1N3dsTWVSWklOMWoyWHpIQld1TEprb3JXRWMyNzZHalU5cDNweEQ5?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <201D7B75BD75464EB399895F6F972544@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6354.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcd176f-9ca5-4288-bbc5-08db482dfa98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 21:17:31.7781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZZeypPrLQzXjp4kteJjFS/38ij/UWugZQ8z1o8efooUj5SSpV9FaEjbHt2VAQVTR4LKVWD7nn5Wz2jLhH/oNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6229
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
bGF0ZWNoLmNvbT4NCj4gDQo+IFRoaXMgZmVhdHVyZSBhbGxvd3MgbWFjODAyMTEgdG8gdXBkYXRl
IHRoZSBkcml2ZXIgd2l0aCBtdS1taW1vDQo+IGdyb3VwIHRvIGFsbG93IHRoZSBtb25pdG9yIHBv
cnQgdG8gY2FwdHVyZSBNVS1NSU1PIChWSFQpIGZyYW1lcy4NCj4gDQo+IFRoZSBtdDc5MTUgZHJp
dmVyIGltcGxlbWVudGF0aW9uIHdpbGwgb25seSBlbmFibGUgdGhpcyBmZWF0dXJlDQo+IHdoZW4g
dGhlcmUgaXMgb25seSBhIG1vbml0b3IgdmRldi4gIEkgd2FzIGFmcmFpZCB0aGF0IGl0IHdvdWxk
IG1lc3MNCj4gdXAgYSBzdGEgKyBtb25pdG9yIHZkZXYgY29tYmluYXRpb24sIGZvciBpbnN0YW5j
ZS4NCj4gDQo+IE9yaWdpbmFsIGNvZGUgZnJvbSBSeWRlcg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmggICAgIHwgIDUgKysrDQo+ICAuLi4vbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYyAgfCAgMSArDQo+ICAuLi4vbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYyAgfCA0MQ0KPiArKysrKysrKysr
KysrKysrKysrDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3JlZ3Mu
aCAgfCAxMCArKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgN
Cj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KPiBpbmRleCA2
YjA3YjhmYWZlYzIuLmQ0YWU1M2Q4MGQwNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCj4gQEAgLTk0NSw2ICs5NDUsMTEgQEAgc3RhdGljIGlubGlu
ZSB1MTYgbXQ3Nl9yZXYoc3RydWN0IG10NzZfZGV2ICpkZXYpDQo+ICAgICAgICAgcmV0dXJuIGRl
di0+cmV2ICYgMHhmZmZmOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBpbmxpbmUgaW50IG10NzZfdmlm
X2NvdW50KHN0cnVjdCBtdDc2X2RldiAqZGV2KQ0KPiArew0KPiArICAgICAgIHJldHVybiBod2Vp
Z2h0X2xvbmcoZGV2LT52aWZfbWFzayk7DQo+ICt9DQo+ICsNCj4gICNkZWZpbmUgbXQ3Nnh4X2No
aXAoZGV2KSBtdDc2X2NoaXAoJigoZGV2KS0+bXQ3NikpDQo+ICAjZGVmaW5lIG10NzZ4eF9yZXYo
ZGV2KSBtdDc2X3JldigmKChkZXYpLT5tdDc2KSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCj4gYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCj4gaW5kZXggYWMyMDQ5ZjQ5
YmIzLi5iZWE3NTYxNTg3MmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCj4gQEAgLTM3MCw2ICszNzAsNyBAQCBtdDc5MTVf
aW5pdF93aXBoeShzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0KPiAgICAgICAgIHdpcGh5X2V4dF9m
ZWF0dXJlX3NldCh3aXBoeSwNCj4gTkw4MDIxMV9FWFRfRkVBVFVSRV9GSUxTX0RJU0NPVkVSWSk7
DQo+ICAgICAgICAgd2lwaHlfZXh0X2ZlYXR1cmVfc2V0KHdpcGh5LA0KPiBOTDgwMjExX0VYVF9G
RUFUVVJFX0FDS19TSUdOQUxfU1VQUE9SVCk7DQo+ICAgICAgICAgd2lwaHlfZXh0X2ZlYXR1cmVf
c2V0KHdpcGh5LA0KPiBOTDgwMjExX0VYVF9GRUFUVVJFX0NBTl9SRVBMQUNFX1BUSzApOw0KPiAr
ICAgICAgIHdpcGh5X2V4dF9mZWF0dXJlX3NldCh3aXBoeSwNCj4gTkw4MDIxMV9FWFRfRkVBVFVS
RV9NVV9NSU1PX0FJUl9TTklGRkVSKTsNCj4gDQo+ICAgICAgICAgaWYgKCFpc19tdDc5MTUoJmRl
di0+bXQ3NikpDQo+ICAgICAgICAgICAgICAgICB3aXBoeV9leHRfZmVhdHVyZV9zZXQod2lwaHks
DQo+IE5MODAyMTFfRVhUX0ZFQVRVUkVfU1RBX1RYX1BXUik7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4gYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4gaW5kZXggMWIzNjEx
OTljMDYxLi43NTY2ZGIwY2Y1MjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4gQEAgLTU5Miw2ICs1OTIsMzQgQEAgbXQ3
OTE1X3VwZGF0ZV9ic3NfY29sb3Ioc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQo+ICAgICAgICAg
fQ0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkDQo+ICttdDc5MTVfdXBkYXRlX211X2dyb3VwKHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZg0KPiAqdmlmLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpZWVlODAyMTFfYnNzX2NvbmYgKmluZm8pDQo+
ICt7DQo+ICsgICAgICAgc3RydWN0IG10NzkxNV9waHkgKnBoeSA9IG10NzkxNV9od19waHkoaHcp
Ow0KPiArICAgICAgIHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYgPSBtdDc5MTVfaHdfZGV2KGh3KTsN
Cj4gKyAgICAgICB1OCBpLCBiYW5kID0gcGh5LT5tdDc2LT5iYW5kX2lkeDsNCj4gKyAgICAgICB1
MzIgKm11Ow0KPiArDQo+ICsgICAgICAgbXUgPSAodTMyICopaW5mby0+bXVfZ3JvdXAubWVtYmVy
c2hpcDsNCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgV0xBTl9NRU1CRVJTSElQX0xFTiAvIHNp
emVvZigqbXUpOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChpc19tdDc5MTYoJmRldi0+
bXQ3NikpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG10NzZfd3IoZGV2LA0KPiBNVF9XRl9Q
SFlfUlhfR0lEX1RBQl9WTERfTVQ3OTE2KGJhbmQsIGkpLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG11W2ldKTsNCj4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgbXQ3Nl93cihkZXYsIE1UX1dGX1BIWV9SWF9HSURfVEFCX1ZMRChiYW5k
LA0KPiBpKSwgbXVbaV0pOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIG11ID0gKHUzMiAq
KWluZm8tPm11X2dyb3VwLnBvc2l0aW9uOw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBXTEFO
X1VTRVJfUE9TSVRJT05fTEVOIC8gc2l6ZW9mKCptdSk7IGkrKykgew0KPiArICAgICAgICAgICAg
ICAgaWYgKGlzX210NzkxNigmZGV2LT5tdDc2KSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
bXQ3Nl93cihkZXYsDQo+IE1UX1dGX1BIWV9SWF9HSURfVEFCX1BPU19NVDc5MTYoYmFuZCwgaSks
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXVbaV0pOw0KPiArICAgICAgICAg
ICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBtdDc2X3dyKGRldiwgTVRfV0Zf
UEhZX1JYX0dJRF9UQUJfUE9TKGJhbmQsDQo+IGkpLCBtdVtpXSk7DQo+ICsgICAgICAgfQ0KPiAr
fQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBtdDc5MTVfYnNzX2luZm9fY2hhbmdlZChzdHJ1Y3QgaWVl
ZTgwMjExX2h3ICpodywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGllZWU4MDIxMV9ic3NfY29uZiAqaW5mbywNCj4gQEAgLTY1MCw2ICs2Nzgs
MTkgQEAgc3RhdGljIHZvaWQgbXQ3OTE1X2Jzc19pbmZvX2NoYW5nZWQoc3RydWN0DQo+IGllZWU4
MDIxMV9odyAqaHcsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgQlNTX0NIQU5HRURfRklMU19E
SVNDT1ZFUlkpKQ0KPiAgICAgICAgICAgICAgICAgbXQ3OTE1X21jdV9hZGRfYmVhY29uKGh3LCB2
aWYsIGluZm8tPmVuYWJsZV9iZWFjb24sDQo+IGNoYW5nZWQpOw0KPiANCj4gKyAgICAgICBpZiAo
Y2hhbmdlZCAmIEJTU19DSEFOR0VEX01VX0dST1VQUykgew0KPiArICAgICAgICAgICAgICAgLyog
QXNzdW1wdGlvbiBpcyB0aGF0IGluIGNhc2Ugb2Ygbm9uLW1vbml0b3IgVkRFVg0KPiBleGlzdGlu
ZywgdGhlbg0KPiArICAgICAgICAgICAgICAgICogdGhhdCBkZXZpY2Ugc2hvdWxkIGNvbnRyb2wg
dGhlIG11LWdyb3VwIGRpcmVjdGx5Lg0KPiArICAgICAgICAgICAgICAgICovDQo+ICsgICAgICAg
ICAgICAgICBpbnQgdmlmX2NvdW50ID0gbXQ3Nl92aWZfY291bnQoJmRldi0+bXQ3Nik7DQo+ICsg
ICAgICAgICAgICAgICBpbnQgbWF4X29rID0gMDsNCg0KSSBkb24ndCB0aGluayB3ZSBuZWVkIGNo
ZWNrcyBoZXJlIGFzIHVzZXIgY2FuIGZ1bGx5IGhhbmRsZSB0aGlzIHdpdGgNCnRvZ2dsaW5nIGl3
IGNvbW1hbmQgLSBpdyBkZXYgbW9uMCBzZXQgbW9uaXRvciBtdW1pbW8tZ3JvdXBpZCA8R3JvdXAg
SUQ+DQoNCkFsc28sIHRoZSBHcm91cCBJRCBtZ210IGZyYW1lIGlzIHRyYW5zbWl0dGVkIGJ5IHRo
ZSBBUCB0byBhc3NpZ24gb3INCmNoYW5nZSB0aGUgdXNlciBwb3NpdGlvbiBvZiBhIFNUQSwgd2hp
Y2ggd2lsbCBub3RpZnkgdW5kZXJseWluZyBkcml2ZXINCm9mIGNoYW5nZXMuDQoNCj4gKyAgICAg
ICAgICAgICAgIGlmIChwaHktPm1vbml0b3JfdmlmKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBtYXhfb2sgPSAxOw0KPiArICAgICAgICAgICAgICAgaWYgKHZpZl9jb3VudCA8PSBtYXhfb2sp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG10NzkxNV91cGRhdGVfbXVfZ3JvdXAoaHcsIHZp
ZiwgaW5mbyk7DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZkZXYt
Pm10NzYubXV0ZXgpOw0KPiAgfQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3JlZ3MuaA0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L3JlZ3MuaA0KPiBpbmRleCBjOGU0NzhhNTUwODEuLjVlMDU3
Y2NlNWM5ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvcmVncy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L3JlZ3MuaA0KPiBAQCAtMTE4Myw2ICsxMTgzLDE2IEBAIGVudW0gb2Zmc19yZXYg
ew0KPiAgI2RlZmluZSBNVF9XRl9QSFlfQkFTRSAgICAgICAgICAgICAgICAgMHg4MzA4MDAwMA0K
PiAgI2RlZmluZSBNVF9XRl9QSFkob2ZzKSAgICAgICAgICAgICAgICAgKE1UX1dGX1BIWV9CQVNF
ICsgKG9mcykpDQo+IA0KPiArI2RlZmluZSBNVF9XRl9QSFlfUlhfR0lEX1RBQl9WTEQoX3BoeSwN
Cj4gaSkgICAgICAgICAgICAgIE1UX1dGX1BIWSgweDEwNTQgKyBcDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChpKQ0K
PiAqIDQgKyAoKF9waHkpIDw8IDE2KSkNCj4gKyNkZWZpbmUgTVRfV0ZfUEhZX1JYX0dJRF9UQUJf
VkxEX01UNzkxNihfcGh5LA0KPiBpKSAgICAgICBNVF9XRl9QSFkoMHgxMDU0ICsgXA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAoaSkNCj4gKiA0ICsgKChfcGh5KSA8PCAyMCkpDQo+ICsNCj4gKyNkZWZpbmUgTVRfV0Zf
UEhZX1JYX0dJRF9UQUJfUE9TKF9waHksDQo+IGkpICAgICAgICAgICAgICBNVF9XRl9QSFkoMHgx
MDVjICsgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAoaSkNCj4gKiA0ICsgKChfcGh5KSA8PCAxNikpDQo+ICsjZGVm
aW5lIE1UX1dGX1BIWV9SWF9HSURfVEFCX1BPU19NVDc5MTYoX3BoeSwNCj4gaSkgICAgICAgTVRf
V0ZfUEhZKDB4MTA1YyArIFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGkpDQo+ICogNCArICgoX3BoeSkgPDwgMjAp
KQ0KPiArDQo+ICAjZGVmaW5lIE1UX1dGX1BIWV9SWF9DVFJMMShfcGh5KSAgICAgICBNVF9XRl9Q
SFkoMHgyMDA0ICsgKChfcGh5KSA8PA0KPiAxNikpDQo+ICAjZGVmaW5lIE1UX1dGX1BIWV9SWF9D
VFJMMV9NVDc5MTYoX3BoeSkgICAgICAgIE1UX1dGX1BIWSgweDIwMDQgKw0KPiAoKF9waHkpIDw8
IDIwKSkNCj4gICNkZWZpbmUgTVRfV0ZfUEhZX1JYX0NUUkwxX0lQSV9FTiAgICAgIEdFTk1BU0so
MiwgMCkNCj4gLS0NCj4gMi40MC4wDQo+IA0K
