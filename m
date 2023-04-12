Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349476DE883
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 02:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDLAdO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 20:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLAdN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 20:33:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A11A4
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681259590; x=1712795590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9q+H080LlJsgx4kT99vcreGsYD7xwJYK7X9kc7nM5sg=;
  b=G/X5iGd0fqxXFvUH5Tk3QmfZUWZjgWHtfqL3pmUkLSkSQsh+gde4xdDF
   pHnAISzv4AhPRrJNm2mJlsG3mOCpy0IPWNlcdA4672ojs90OMIJnCVYRF
   KbQx7euwvpqHlmISq763icPCEf00ot5ShSNFtjmHaWkulXiKeSIc1pTBc
   lKrpJADW94kbCU85sW9Kp9e9AMbMCHBhiGFEYGtnsAc6Wzo6ZMTr9fECm
   w8E/2ochwXIk3T2dtzzq+xmGY96LfqUfsBmKMbxxPjdfRI1qo37KcG+Fq
   4JBbs3B4j+B511Uu7LJwiNPn7t/JSQzBw9LkdSsCD2ijcTDh4HHiPGj9W
   g==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="scan'208";a="209143688"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 17:33:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 17:33:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 17:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSXDd3kwNbf6yUQFIGwKBcaCC9pLRkHsjkVgU4Pm0kiPAY7M7gF1ZGvkDzjs9o7A/1pmSHsQ9gHPy1z5bWOkJczKN/q28PIwgkIp0kpmUpb1el8DrrYwXkFmldubAfN5VLLcIDGAtI49M46eJLTDkQTaiLGkfn84rXtUDc24VUNufmGbvzCq4WbSZ9M+zlJSX3ksi6h770tyKYMo84dPu+3iHTR/c84BxY4/27iid4kMdPnoL17QSZg171Xc9TPzpC+bDTH47dxQz9x7MqmhNulHYKtR7PXAHogxsHpyNTvUnuNwO7CTdaAM6anmedO0DoJCRNIVIkJ9sQj891rXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q+H080LlJsgx4kT99vcreGsYD7xwJYK7X9kc7nM5sg=;
 b=Q/NNEIB4QoGaiEGoEInuQKhTu7/GYAAOSKn/opoNZeNufjIj1sL6bN7yXmuOEqzFMdKr7NtDr7IKd4HEfuHNuPIt5fyBnz5/LWmY7vWmwv1hGmu5a2C0af2+t6Qc2i+BlUD3FlwMsL3M0pvTdx0kwaaubnEyPVnGU3FnlE6KLc7LpDcJLjCdxSs2y0csyGr7teTVYk+NxANMnejtCUuA1lvV7DNSL2tn7Eiu06kRHWvjJM2IXgJx1FMaMVdwHSCnoIrhGUrlWpFuT05Sedce3VvQy4okqQKcWcExkpvadT+Ue0Imw0WUaNcASWuzIvj0Jno8FABXdr5lirsicTsqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q+H080LlJsgx4kT99vcreGsYD7xwJYK7X9kc7nM5sg=;
 b=UvliD97nDUDJ6npiDmQdKgn0V7aFTWfyqVYvzclCzBVpLSz2Y+7UT9/58WE12AY9xJ3e2yjVVIR4a8asFtlPtYkmEUo3mgritRbyPxS0Cyrr8ela9PcNp5y7XkrPHCeSMI98LO1MWpFPX+aaIrBMgxHt8OboRSXQp5krXhQ/SmI=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 00:33:06 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 00:33:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: Re: wilc1000: AP mode issue
Thread-Topic: wilc1000: AP mode issue
Thread-Index: AQHZbLnhJZ4VSZXgk0Wrqq7u9w+rJq8m0zwA
Date:   Wed, 12 Apr 2023 00:33:06 +0000
Message-ID: <bdd4f49a-213a-bf55-1c29-d74e56221795@microchip.com>
References: <e4cece9076cc9a5a4e4dbfa258a828eaec97e1af.camel@egauge.net>
In-Reply-To: <e4cece9076cc9a5a4e4dbfa258a828eaec97e1af.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SA0PR11MB4669:EE_
x-ms-office365-filtering-correlation-id: dce9f287-952e-40e0-e0dd-08db3aed7c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owBL/yMXryfVsU5U/jsBERYs/Co5YqYOjgmqLvYtxZUlze8VAncn5m9NJGAI21Z/7SHB/EQ72wjTcftARWhUdD5SmTRGb3rSALNoXxeXAe5aovDpXLcFY2tzMtb61yY+5Qqm7cGYOu58PQ8kEEps7Pw4+zIdfX4XKCM/+mpPpe1eL0eOdY7QA0lYcgMuiPZ6iZE3OjwMMOnNgmBFZd+TaXlepqMNr05ltGSmMo0MhDj1LeaPpxO0YqRxkGbHKy0RocgcZ1QFY+7ncH3z/Ha/wEnJQfwdd5ZC4h+n+CK0Mu6174r/e7ldfNVyK08k9kmSpZoR9wSNkZTLfN8Bn+315QXqLxJyE1ZHDx+fE5I5Zl0fBYukWOxAlpOw/9TzEgsrxZ6lb1TDFGOoB9I0xMmcTjppjkOwDfwVpF8sa4R619OqkjF+GABJVVn33YvBeadM7uv8n9e68c//Bckmipn1dALyDjK6WjrvgqIXSrZuI/Zr8nsQbAQlBjmAy9SiP5E3aRpkOtgZjFXtQ/N+o0hBIVY0QQntpSxyoW0lrYKRqYJh2d4Bgl644E//AtLHTS2kOV5A3mGFYgnCmcouZ+uC5ohl6npah6bTs1Tr+5UdnxKl/aDNFsdLtlOOvJRGaOimtq1iX4ETzl7Sq+uw0W9ClllWkPPJQR7Eepj1YgMPPSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(4744005)(186003)(86362001)(4326008)(6916009)(41300700001)(66446008)(64756008)(53546011)(316002)(6512007)(31696002)(6506007)(26005)(71200400001)(6486002)(966005)(83380400001)(31686004)(2616005)(478600001)(36756003)(38070700005)(38100700002)(8936002)(8676002)(2906002)(66946007)(66476007)(66556008)(76116006)(122000001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVMwd1g1YzArYnZBeSthOWJNelJLTWtFY0dZcjBnbFlReld6Vm1sSDNuODVY?=
 =?utf-8?B?cHYyc29mTU9CRzZXL2I0TEJ5SFJOZFlPMDFaaFdScUkvQm1JV2FLSWM0TzBl?=
 =?utf-8?B?OCtDSkUxb3pOTUZRZTA4UHdrdkdRdmZJblVYU2Zpd2xOOG9rRkx3WEh6N0RJ?=
 =?utf-8?B?VXZ4dW5Nblp3QzRHZTlvZldXWXZoRStPRll0bi9EMXE1UHkxNG1TUXBxSXdr?=
 =?utf-8?B?a3NwTVM5K1ArVUZlQ0VONFZyZVNBVnFlRnBaSDMyQXpIM2hsMy9MdS9GTkNI?=
 =?utf-8?B?TVRrV21uMWtsOXI0NWJFMnRLUFdYdGg5K2xBTmtDSlZXZXhPOERBNzR3cldO?=
 =?utf-8?B?UmF0cGdMSzNuWVZ3ckFvOTFCTFdHWmRkc2hlbzhPN21vdFVvdkVIOThzOEY1?=
 =?utf-8?B?WEd3VkFVSG5IMDRjeG4vVXMwbG04aEJYSEs0V2V5WWN0M0ZkWjRDRVZTOEw3?=
 =?utf-8?B?cFdzMENKbGllSlBla2U1WTdiM1hQREJldjU4WTlVR1F6QW1iaW9FcGg4aHJF?=
 =?utf-8?B?REM0YTZwSzE3WFlENHF5Ui9KZzl0YlAvV01JTnZ2bTBRSnhmZEtaamZNb0RP?=
 =?utf-8?B?V3ZvYVAwc1dmODA2b01jcjVhbCttU0RaL0FkZkgrbG0vQzRRZ2xyM09vMXRF?=
 =?utf-8?B?RmVLcDJOVHh0NVdkT2V3U2RDNDlyKzBIZml0bjRUdkNoM0hXZ3E0d3d5MUoz?=
 =?utf-8?B?ek41aUxXRFFVWGR2b1ZWTkxOUHJVekQvVVJYbmtzaDVOc2tvMm42RTVoMnEz?=
 =?utf-8?B?RFRROE1OSzFIdTZNazZudXRtaFBEaXV0ak1aclV5SkZEWEFvRE81TXIvZVVX?=
 =?utf-8?B?bXJ6WmwyT2R1Z2N1R3NNV3JjTGhnMUx4aXlDa3luL1Arc0xjQTVhcG54NXF5?=
 =?utf-8?B?NUN6ZTNkUjNzZ0QwMmpITks2RUFEODBibE9pdXFhUFJjWng1d0syN2VEM2tP?=
 =?utf-8?B?Nk5rUzdpbmNaMjZGWkluVTVuTUwwMGxRRFMrbktZYXF4MSs5K1U4akNQbDNQ?=
 =?utf-8?B?RjkxQXlvek8rVGlUZHllVU9UZDNpVHZqSU9zUWpaQ3ovQmtZZEhIRGt0clVv?=
 =?utf-8?B?elVVS3RNK1NCYXUySk0ySG5lNWFVNms5Nno2dEkzRWJ6MEtmUnd6a01YeFo3?=
 =?utf-8?B?MTBKQ01XNGFRZXlNZEx6NHVYRVJDSityYTdFM2ZqY0xvelRZKzdUaEtidnZU?=
 =?utf-8?B?ZWY3cTNmNWZ6OTk4cHdiY284aXFSU2dPanZ4aXdWTW5wb085cktBZkNyeXdv?=
 =?utf-8?B?NWJNcWlOR0t6WGtTSGt3WHBvRU5ORVlaVGw3RXdDY0F1YmtIYnd4UzNqTjYx?=
 =?utf-8?B?UFZhSzZENGowREtnRXZEYkIyTGRydlg1NWRTRVpWSVJiOU1UcTRLMmJpRFRV?=
 =?utf-8?B?Zk42Z1g4Y0NWZm1yQnNPdkxPUXEvUGVWbm5JMVJLZ1pHS3EyUzMva2RXSmVI?=
 =?utf-8?B?UTlOcndGNE9aWjZiYVhBaWhmc1lldUtLM3lmSGEzQ1g4Q0ZKUWFZNG1Xa3li?=
 =?utf-8?B?ZlN1eDF6NllGYTFJNEhEYklyZ2kyRlVCc0Q0UGZVZ1J3QVAxUjY2YWcrdlJI?=
 =?utf-8?B?VkN0djRLbUFVRUhVTURRU0ptV2Q2cWJyS2Jad2FmL0E4WUpXbXhHQnNWS0k3?=
 =?utf-8?B?VDh4WXE3Mk9qY0NUeFhlYlFkeFlvQWZwdXpidytMNzQ0a0ZhekxIMkc1K2ZX?=
 =?utf-8?B?a09lKzExZm9jczdlQjlmalVyUlA1cU1zUmdUWkVMb3h5YkRTMmNXZ0FOZ0cr?=
 =?utf-8?B?WTNwMTRPZkh5SXlxcHYxR2ZKb2hyM0tZa1NtKzZvVU0wY2hHOVpvYzlhVTRj?=
 =?utf-8?B?bnZ2NGVpa0QreUNEQTJhclByTVFGbGx2Z2pET1VHdWJxOEpFREIxTEVlWWE0?=
 =?utf-8?B?aGpnS1A4bm5tdE1zZ2FWbG95UWo1YURlSFJPWXRjMXJoenErU0licmlrRzJa?=
 =?utf-8?B?dUtsb1l2Ym1HVkNWNUJWKzNZMmtRK0tHRFJ1MlYrV0owWFowRm5nOFg3bUlk?=
 =?utf-8?B?UVhqaC9JeE1OVW15YTd1UkdLL3h1L09vamp4aEwvaFZQWnRFL3BxckJSUWdk?=
 =?utf-8?B?eFBkS1kxYjRGUS9qN25uSG1UbnByOG9mY1ZSeVFBSVlHOGN2eEpCYTBoSFNU?=
 =?utf-8?Q?2dxnRRAE//3ni+exKEHqZ+Scq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2338083C5E000645B177C91121C8D637@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce9f287-952e-40e0-e0dd-08db3aed7c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 00:33:06.9167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRQ/wopL9vLsQHEhlyyUmsVF+cx7fPif1G6IzOOCttivJ+Q3wmUuebnMpAJY5TQbkwbPsse08PL/w34DmWhct1IW4LNERF4htuZk/tmaQAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIDQvMTEvMjMgMTQ6MDgsIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFqYXksDQo+IA0K
PiBJJ20ganVzdCBzdGFydGluZyB0byBpbnZlc3RpZ2F0ZSBhbiBpc3N1ZSB3aXRoIHRoZSB3aWxj
MTAwMCBkcml2ZXIgdGhhdCBvY2N1cnMNCj4gd2hlbiBpdCBpcyBvcGVyYXRpbmcgYXMgYW4gYWNj
ZXNzIHBvaW50LiAgSSBjYW1lIGFjcm9zcyB0aGlzIHRocmVhZDoNCg0KV2hhdCBpcyB0aGUgaXNz
dWUgb2JzZXJ2ZWQgd2l0aCB0aGUgQVAgbW9kZS4NCg0KPiANCj4gICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC13aXJlbGVzcy84N3Bta215bGV4LmZzZkBrZXJuZWwub3JnLw0KPiANCj4g
YW5kIHdhcyB3b25kZXJpbmcgaWYgdGhlcmUgaGFzIGJlZW4gcHJvZ3Jlc3MgdG93YXJkcyBjb252
ZXJ0aW5nIHRoZSBkcml2ZXIgdG8NCj4gdXNlIHRoZSBubDgwMjExLWJhc2VkIFRYL1JYIGludGVy
ZmFjZS4gIElmIHNvLCBpcyB0aGlzIHNvbWV0aGluZyB0aGF0J3MNCj4gYXZhaWxhYmxlIHNvbWV3
aGVyZSBvciBjb3VsZCBiZSBzaGFyZWQ/DQo+IA0KDQpJIGhhdmVuJ3Qgc3RhcnRlZCB3b3JraW5n
IG9uIHRoaXMgcGFydCB5ZXQuIEFmdGVyIGNvbXBsZXRpbmcgZmV3IHBlbmRpbmcNCm9uZ29pbmcg
cGF0Y2hlcy4gSSB3aWxsIGxvb2sgaW50byB0aGlzLg0KDQoNClJlZ2FyZHMsDQpBamF5DQoNCg==
