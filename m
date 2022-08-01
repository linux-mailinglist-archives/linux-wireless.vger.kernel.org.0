Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3913586CA8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Aug 2022 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiHAOOE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Aug 2022 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiHAOOC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Aug 2022 10:14:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9711EEF5
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659363239; x=1690899239;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=HgVSpHNwn00iCMf93yXJy9iR0PIi2YVJjXz3o1KOboo=;
  b=2FbzbGOo3qAr+8g7ZjTIKYnLPpsoxmQ/GnDhL1BrGZiygQkcVdYKT+MH
   Rxjr7d3uKdUAGqvxsbOkVaEaLbl2ifpp7aW8j1IS70MkzNhUc0VUXiSl9
   jmU2yGod2BPZfwDXV+GIJSldm1Gpi8ts8KrvaTReTciwLlH79WxlfVsmg
   ziTe6Bq2aCK5L5M3ajiJPtCMCRi5HRwC1jR0b7sWa4QPjkFhK98S82jmc
   k0zOwrhQmXVmNqqimKrbp5qgUKr6UmuhCbIrDVJy2F2+Nzpf6E51xq1tI
   FEb8yJDgczUU1/IKbcYGZWmgyd9cfmIeoAyG+mF4y4n64sPQYRVJdJwxq
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="107036461"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 07:13:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 07:13:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 07:13:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie7g/hRNHbZ53r2dMKnJdtHuOgzC/AMDI8MfwcHC4vgHmbCpsnSsRsmY3Le10QX0C6ua56647GEQ02BT3vySB0+w6/TlhMsbu8VC5GBlZZVqhNJbySv4kLlfT7G73jl1UcuGqtgKyBEVocA3iNhY8F0ANjsaGBEnCVo+BhruypbnmmOLumlwjpNtfnzwdbibOhwkdqOS7/lHVBvjx7JF5KC/wmY5lQTnfk4pTZyo5bPCWqg+y9hUknY/NhMRK9yZb2LT8gkHoarQF8+vJ0DTS0g9C6Bk6WSvzFw1jZoZHRtJvFCQmj5HOafSoOZNwhTZF5KSakie+UcHlKe7d7vgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgVSpHNwn00iCMf93yXJy9iR0PIi2YVJjXz3o1KOboo=;
 b=L/W9UTDxO58g9hYeI/YNu13d7dFBQE5esAFZWc0rHlcsrBpqAD1qgf+8SfRfClSc4N/U0PlhK+RsmCoRSWYSVlHIQZmGqRF4yKMNENYl5g3ZNRipZPNsl2CzG5+8CHpAE0KRnDmxF6N3Wc4qmRzSFBKnzho8BPB/ftMWagEUmbwqzuPr3gYIdbe12QidEjfNNyzskMtSuzr1anU5JMD0bNpc+AeXT5Y0El8HPyV/WoxfnsCLB65EWVs2JVMvoFppL5kj39AgGKNJpz9PGT1+ibyyJerZflWPsSqzTCanwLSQjF4fGPHxh0AV+g4Z5OzLk35sUjcTOMJMug3ILRx2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgVSpHNwn00iCMf93yXJy9iR0PIi2YVJjXz3o1KOboo=;
 b=KoKIL3T6Vv05gna6qBee6+xQlj/7G/wt2w85qcARU+zn+dUVjpu8pF3zQjN/iEQK2/Kc7n4l/HOxhudz78WgsP3aeUrqKldraG4pRSQr5/sXW/iAD5yepoN5SX+aoiGOqs32z3lBoUD9VQOyqHmh4/Y05Xyc97bwhfhPJXFJQFI=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BN7PR11MB2675.namprd11.prod.outlook.com (2603:10b6:406:ab::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Mon, 1 Aug
 2022 14:13:56 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 14:13:56 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: wilc1000: fix spurious inline in
 wilc_handle_disconnect()
Thread-Topic: [PATCH wireless] wifi: wilc1000: fix spurious inline in
 wilc_handle_disconnect()
Thread-Index: AQHYpZaYp6RBnFTK+kW9Xxzh3zfGwa2aFrIA
Date:   Mon, 1 Aug 2022 14:13:56 +0000
Message-ID: <af73ba89-2a41-5da2-9418-6eb498f1e392@microchip.com>
References: <20220801110440.13144-1-kvalo@kernel.org>
In-Reply-To: <20220801110440.13144-1-kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 914aa558-5399-47eb-b377-08da73c81288
x-ms-traffictypediagnostic: BN7PR11MB2675:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMHB7nYByBlo37pDxKpgaCDl1C6+cdcoc1qPXbQUKWGLynHMltuD6r6fkkMkknJAVY/QRtHCFQcX+zLtZB/Qz50bZ5PWNC+KFLLPGi3M0oWQmXQKvkt+9XHWmwLSR8lFvcfFG0Em+mBvpwCgnmg74V5ucMbUXvsPJSfrnCLlgst9D1cQL4UQIh4925wE90GLei0KCKqZjaHz3+SDADT3w0GDJeT+tqjd4ABLSgZFuciLymt3Oy/LW3IzFLY3PkOucGNpQz1cyWnkT5kdDj18h5HTlZ+jIk9pk5ruiIy1GJKbeqXRwqEnopd+JIs6WJF2Tco/cH63+U1lEMU+/UrPH7Z5nKAxIyxn2fzCnSDUVtlhZ9Tu3CFrB63/Bo2dzlU33wlmEq7njtP7meUBVXIfWxtS3Km6oCckUQjwUzbzulZIvHfpRimAYDBDWv4IYPi8jw/1aJnoRV3S4rL5nJtK6TIJZL6z60QfEC2pv4MFSzYZRQiI+exZQvMT1irWNV+Gyxxaxcj3Ql5TtM+xmG0WeKOQo1Svx7n6Kl1U2mPNceUeFHEcrEpUAR/RQMytH2LmBAB1oN3xuu8w4LmvAA3vdKEML4JK2+sT9w777mfkhLglAV4Fwq5lUH6uEkQu0uTgTR4li9SdND6lHBsdTv4ea4ntzhV1OjXGVCiOlwcHpFs1/xUdxsztycUeqJMhnCiRAlutMoo396K0gWrO6f1OKR6YSzfoLfQT4sIlzyzcGfAEd1LzcZUrLm60DdtPOd5zyQYW8CoGcIiEmZvVlxyM8nWpbs4VZog/hLZprzKzcfddsxM0Lanw7DKiDb0D7kxd/031R5i1D7q8X8J1lhLkhTphosziEX+lpn+iTDLb/E23w7jzCDlUu/if9HyUpcpC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(39860400002)(396003)(8936002)(66946007)(91956017)(64756008)(66476007)(5660300002)(66446008)(186003)(66556008)(83380400001)(76116006)(8676002)(2906002)(38070700005)(31696002)(122000001)(6486002)(36756003)(316002)(6512007)(2616005)(86362001)(71200400001)(31686004)(41300700001)(6506007)(26005)(110136005)(53546011)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFFRckQ5aXVIejh6ZEttenF1ditTYTVleTFWblUzT0pwL0dZTTVET2lkcGVU?=
 =?utf-8?B?Qmt2T1JYelQrUFhxZE12aEF3cStVMzB0NFd5Q3dDU1czVjF4SXl3M2g1eHJs?=
 =?utf-8?B?ZlVUSTBLdzh4TDRJeG0rc1owRmpkbU1EZGV5TElWVGQ0WlJoY0tjSEczRTdi?=
 =?utf-8?B?RmVvM25rKzROWTNzTzJ3Vkg4N1A3WDUxcW9vZ3BqRE0veXRFMGcxVGFoUlRC?=
 =?utf-8?B?T1RibWlsRUsxdk1tK2pSRm1zMDBhVERPLy9RWGlqRDFzWFFGb1FOSWY3aFkr?=
 =?utf-8?B?K052UzBGemY1UWxvak1HUHVOeUpWMnlLOEV4SU8zQWZQZ2FnSFR1K3lCRjVo?=
 =?utf-8?B?dkVVRmV2UmYrdUZ1U21tMk9JY0Y5MlVVQmtJRTYreG80cjdyYzRmU01TMzgr?=
 =?utf-8?B?aDhYd2NScUs4c25xVFBudDVnY0x2SFh1cXh6Wjh4L3dDOW1rMW9tYnlQaTcr?=
 =?utf-8?B?NGxybkhNcm9wSWgvY01kU1VQR0plUy81K09KcEtxckFGTnFpK1JLczNEWDc1?=
 =?utf-8?B?dlNmSngrUit6enJic3B0bzY2Ymo3bHd6MXRlVnhtUUlFZ2hiWEh4WkZBK3dO?=
 =?utf-8?B?QlpvOU5rYnNVZ0VLUnlkdjd2UHplb2Q3ZlhVaGIrNUNtdmZGNzZJSUV3ZDlv?=
 =?utf-8?B?WStwbDVxeW80bzJ6RFdNYXJtSWUyZEZTU2RSMkRYOEgvdjZUZ2tGRldUaUJO?=
 =?utf-8?B?UlRBcCtYVEM2M0lqWWZlSVkzNXd3WldyOHBPWXhOK21MMkxYdkhZOXd1NEc1?=
 =?utf-8?B?UVhnSm5xdi83T2dyNnk3VlN5MmZnZUtZbzJKU3JlVXRLK2NTTzNFNTYxNW9n?=
 =?utf-8?B?cTFsdEJoU3RZcStEUjhhQWR0bjBSamVwenpqdnorSHdUbjBJU3MwWFlzM2hS?=
 =?utf-8?B?VmcvVVlZb00xRSs2V2FEYVdwMTZLOVQ2TzBsU2xpR2d0U3hPaDYyZ05pVGQ2?=
 =?utf-8?B?VmlNOWZSOHhIbDBZaDBLcVBJWk5kZjNzeFh4MjBub1M5L01qcnpJSUE5bzVD?=
 =?utf-8?B?MFpoRnRyL0JxTGpmS2c3eWZ1aWxVY3U1dHRHenJNTnB6eURwTU9KOE82c0tY?=
 =?utf-8?B?aG1PdE9LVERWZm9aZFBRYjA3NncyalRXSHdEc1RHczlxTW1qcnZIQ0tQc0Nh?=
 =?utf-8?B?My9lSTY2bitXejQ0U0psdTdTQnFBbmZMZkVGbWxGQVZiOWNRNno3Q2pTZlZu?=
 =?utf-8?B?TDBQbEx2NTVRWlVsTitsRU1KUStVTVJwM0libDJMQmZ2ZXBJTDVDSno2TWxW?=
 =?utf-8?B?ZTR1RGl3R1ArOE1URmdhejVCOGk3dyt4R0ZnZHRRU3FHUVo5VkpYMTNHLzRQ?=
 =?utf-8?B?UVdGMUVSSEpnSzBWMmpLQi82aU5ReXgzMHA5RkE1NDN0ZGJKU2FaTnBtL0ZI?=
 =?utf-8?B?UmFNQ1I1aTZ0aWxLZXhTcTFtNHNON0NWQ2NGbjFlcDZjREpYOFlydDByekgv?=
 =?utf-8?B?SDIzRDRUaG1rWm9xZkh3cEcvaGdyaEQxQkduMkZydCtGYVI2bEhqcEtHSVdU?=
 =?utf-8?B?TlVoNCtKOXJYSlNUZit0VDZCODJDQytrNVloV3laY21WWmpBN0wzR25SbTJB?=
 =?utf-8?B?c1FZdk03YnZGak5sVmxtNjkyaG93WW1DN0lkMkpwbVdZZ0l3dVhGblJJbVBt?=
 =?utf-8?B?ZmVsU1JXaG41Q1UvdHZ5N2JoaFVnRzY0L29kS0tocjNvTkxaKzRVeWFEWmlp?=
 =?utf-8?B?clNORVQ3M1ljeE01N1N2RjNKS2tFSDcxRnc1NWxHY3oydDVydWJ1Sk0yN211?=
 =?utf-8?B?bWdIbjJIc0RjbmhPT1VVV1E4VndhQmpKZnRwRTVleVEvQml2bjkxM2FzWlpx?=
 =?utf-8?B?b04vdUp4dVpnM3loTm9BcXdVd0N1NG9SeG8rc0Y1RHlJdklMbXkzL2JnOG5p?=
 =?utf-8?B?dWFLRjN3aE9KeVJ6dTNMam1Fck9pbDdsamRjK1o1eHh4cDJ0WjJzR0lEdTI0?=
 =?utf-8?B?UTZPYzkzSTNMQ01KOWhTWm9kK05KQjJUdHVKekcwOCthTlFiaEhRNysrOW9Q?=
 =?utf-8?B?SXBNMEQxbHQrL3JzMHlieUFXd3VUMXVYaDV4Y1EyU0pHUitUSWVid21RZ1VI?=
 =?utf-8?B?dzh6ZytCeit3QlhlSE54c2hMa1dpRWRZTHdDVXJJbGxXd2FCRXFKS1A4eHUr?=
 =?utf-8?Q?kx9NuP8sPqJb8gb6n29ZWnU3Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B55C9C30CB1F0428103E8BFEAC8B418@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914aa558-5399-47eb-b377-08da73c81288
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 14:13:56.7636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAozxyPTa/rxJTtxQacV8akkDDrYVgFw11UECxJIyJa+7Xc0fugqZPtPOWUTPYw33hwL1UGIvqp9MOfU885QFUIxJlIh7GuMnjuygSVXBos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2675
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMDEvMDgvMjIgMTY6MzQsIEthbGxlIFZhbG8gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBTcGFyc2Ugd2FybnM6DQo+DQo+IGRyaXZlcnMvbmV0L3dp
cmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuaDoyMTg6MzU6IGVycm9yOiBtYXJrZWQgaW5s
aW5lLCBidXQgd2l0aG91dCBhIGRlZmluaXRpb24NCj4NCj4gUmVtb3ZlIHRoZSBpbmxpbmUsIGl0
J3Mgbm90IG5lZWRlZC4NCj4NCkFja2VkLWJ5OiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNy
b2NoaXAuY29tPg0KDQoNCj4gUmVwb3J0ZWQtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuYyB8
IDIgKy0NCj4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvaGlmLmgg
fCAzICsrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL2hpZi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hp
Zi5jDQo+IGluZGV4IGI4OTUxOWFiOTIwNS4uZWIxZDFiYTNhNDQzIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvaGlmLmMNCj4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jDQo+IEBAIC02MzUsNyAr
NjM1LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGhvc3RfaW50X3BhcnNlX2Fzc29jX3Jlc3BfaW5m
byhzdHJ1Y3Qgd2lsY192aWYgKnZpZiwNCj4gICAgICAgICAgY29ubl9pbmZvLT5yZXFfaWVzX2xl
biA9IDA7DQo+ICAgfQ0KPg0KPiAtaW5saW5lIHZvaWQgd2lsY19oYW5kbGVfZGlzY29ubmVjdChz
dHJ1Y3Qgd2lsY192aWYgKnZpZikNCj4gK3ZvaWQgd2lsY19oYW5kbGVfZGlzY29ubmVjdChzdHJ1
Y3Qgd2lsY192aWYgKnZpZikNCj4gICB7DQo+ICAgICAgICAgIHN0cnVjdCBob3N0X2lmX2RydiAq
aGlmX2RydiA9IHZpZi0+aGlmX2RydjsNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9oaWYuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21p
Y3JvY2hpcC93aWxjMTAwMC9oaWYuaA0KPiBpbmRleCA2OWJhMWQ0NjllOWYuLmJhYTI4ODFmNDQ2
NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L2hpZi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9o
aWYuaA0KPiBAQCAtMjE1LDUgKzIxNSw2IEBAIHZvaWQgd2lsY19nbnJsX2FzeW5jX2luZm9fcmVj
ZWl2ZWQoc3RydWN0IHdpbGMgKndpbGMsIHU4ICpidWZmZXIsIHUzMiBsZW5ndGgpOw0KPiAgIHZv
aWQgKndpbGNfcGFyc2Vfam9pbl9ic3NfcGFyYW0oc3RydWN0IGNmZzgwMjExX2JzcyAqYnNzLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY2ZnODAyMTFfY3J5cHRv
X3NldHRpbmdzICpjcnlwdG8pOw0KPiAgIGludCB3aWxjX3NldF9kZWZhdWx0X21nbXRfa2V5X2lu
ZGV4KHN0cnVjdCB3aWxjX3ZpZiAqdmlmLCB1OCBpbmRleCk7DQo+IC1pbmxpbmUgdm9pZCB3aWxj
X2hhbmRsZV9kaXNjb25uZWN0KHN0cnVjdCB3aWxjX3ZpZiAqdmlmKTsNCj4gK3ZvaWQgd2lsY19o
YW5kbGVfZGlzY29ubmVjdChzdHJ1Y3Qgd2lsY192aWYgKnZpZik7DQo+ICsNCj4gICAjZW5kaWYN
Cj4NCj4gYmFzZS1jb21taXQ6IDYzNzU3MjI1YTkzMzUzYmMyY2U0NDk5YWY1NTAxZWFiZGJiZjIz
ZjkNCj4gLS0NCj4gMi4zMC4yDQo+DQoNCg==
