Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD47E6DE863
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 02:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDLAEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDLAEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 20:04:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E33A97
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681257882; x=1712793882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V8ofg5XMUc/RMNy9i5lyEhy1AvzIDx0V9qz2sE1t97k=;
  b=FoCwD8QBKGeKc/i6CHuV4CYtHtGRYoLrHCPq5s6RHS3qlnXSQqxxd6fz
   ecNY1jJ71+uhjeWYX5QG4ugF2tHwiP6wUFjhAPmELMd07riR5xRSXmjnw
   gRmhYf+2unP9jkzOetgv4Gd8UAdRgix+ig+SuS/824XP857H4Fes4s+aC
   SG4mAPtWt4uxD2UgMbR2Pv6nX1X6f6CMqVAFYP67mFcpZn0aR89UXjw6r
   cwiq47IsfIKYDP/0oOiuEPiZDrs8ZmYVdhrE9+uxN2MYcgPSEo/1oDY0X
   ilWOpjhLrVqiw33d1+W9Jv/rgDUYqHq1fXL9VvIH+N34Ad3SKuBgT9l/t
   w==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="scan'208";a="208693918"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 17:04:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 17:04:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 17:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck05raIVvymoyGlJ3Xusy61rfqRCkrQOnBAXD441zkOjna7CuwWQQKO2CA4fm4qHvhgRbx2yGhnR7tY5kUC5cZ4xutvGyjFjKgT+d0Q+GChaga51bVm+RezfAO5creEgFL3TQTodWM1lGuho15fFlzujdnwO7zDZXiR9lyH5ZwdIT299TTpflxXpjHOvrAwb8HIujCfHwjn5eNJZwjSBpAmEUDWMY0eSeSBV5v8Z3EPYo+STkrauVPb23WeEx5cehGVxMu7Yh3k1Q2BvmwqUilDXCiuTuz+G8RR7mK/TNi4FTboz/xysfaHaQjBFLweLCM7abrusLPJtuza5FuXv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8ofg5XMUc/RMNy9i5lyEhy1AvzIDx0V9qz2sE1t97k=;
 b=jKEPi09hG1Zmw0M867BwBXoYly7EsGIuBV3LWCz90t4rGwoUng4lWkFvVurttJdQApoStbAnupSCnT7Um4yGE+Yseqkk25cDUTSQ6nwgGMTevgnCXS0FgOrECLNrH+4LADdDy2YvPydwlMhEWHyd313/pv/2Xi5aJnV2Dh4HTEYsikTt7HOy3fg1CEHPhpS8Bti5EG4oFKXvjr/NRAzdiLR+aF4NFc9ihhOhIH6R5g2yX9dwmY4OH7jrGzSYBJMPoY4xLjZIfjMDlIT5k3ZjyBCHlWNn+rJ56Hp4dj9yrcFt3GZ/YnKp+zEkDV2mn/qoe9nxp+GdcGyVWJTHzKhpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8ofg5XMUc/RMNy9i5lyEhy1AvzIDx0V9qz2sE1t97k=;
 b=kFbf4MTNND0E0gIIoKM8utYglOzYa99VplXnmU1XHUmByr+vdtsfvzW7fnERE6k/sSrH4rgGZCM+KEb25SMnnxucCWiQkejYuxAvgomUQ4Ig3tRyLg7Y/97irmTB+cn/aK49meW/s+yOG3DtZf8fpZKtc3bNcTE4IJ722vFqN40=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 00:04:38 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 00:04:38 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <michael@walle.cc>, <johannes@sipsolutions.net>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <mwalle@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Topic: [PATCH] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Index: AQHZZpOxdxNIPScHF0Gh2r71RWeobK8cmbYAgAo93YA=
Date:   Wed, 12 Apr 2023 00:04:37 +0000
Message-ID: <eb5783d8-5235-0ecf-a0fb-b1b9b63376bb@microchip.com>
References: <20230404012010.15261-1-ajay.kathat@microchip.com>
 <f10d69fb17e03eb093d846d005d7496a@walle.cc>
In-Reply-To: <f10d69fb17e03eb093d846d005d7496a@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CH3PR11MB8315:EE_
x-ms-office365-filtering-correlation-id: 5a7423c9-7709-40fb-b66d-08db3ae98198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqdHHaEigBTvkU8IMqN6BeQYO0tDdvtVMx5ZO3IvQS8fr5r1ksB94fat50B2AxHKnKIx6pvHUKISCSil6Ru5mwzfTReHmuEx/fMqp8kXJ2WDyL7HAHD6A7M5MMHhA4WVbOZEhi0zbV1ZbuDyR4VFAFyxQRRQ2v7hxE2FUACkZDndxqL8/JuwP7rXocoKsMzHGfMRSTx1XfOaHlizb7dZGbBWnwJ3uaeJX0PeWGh4f3791Mjqdrq0mFudxt9sgm10Jn7I3Y5X08S0+P6bq1gn5tHQTdHY6YTU1zpx8ellnpNFOjtZllfHRlMNRBcD276nPMt9m4pFX2SdycIv47OzRS2fRVvTS6STuIWntOkRzntgLc0+8157nvfP24AP9PKNwIGYdo5HTiEYHoB2HfIFgMQePSj9UxcwpOrRgnW12uGMHTZ32s5/HDs8IIT53TxOp223ItzCjmJAZ9HZjvC40KH9a/R+xRwSCAGzovTBf3gGP00D9rEY76PshDkIfwm7HxsBJ4jGNaRbc0agggu0myILwsOa/uPFzq4k960vnM1LY2NYOzxDnXJ1gAxs4XM6weBKDQ7Z7qZlC08GoBlR8JXpDIQAJ2t2b4POl10DAv6H/KeVZxOcxXiA65ptphctmlro+Riocpo3Wpyc2dJX1atZ8fvr8zVpdt7S76lOfLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(8676002)(4326008)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(186003)(5660300002)(86362001)(83380400001)(41300700001)(110136005)(31686004)(316002)(71200400001)(8936002)(54906003)(2906002)(36756003)(26005)(478600001)(6506007)(6512007)(53546011)(6486002)(2616005)(38100700002)(38070700005)(966005)(122000001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3FHb0ljL3A2RXptWGJQOTh6OVNYbUJvNTU3aHNyYWdxQ2xRS1dBaHp1c0tm?=
 =?utf-8?B?bDJWUExtNFZTWDQwSU0wNGVYVjlQQ0UyMW15ck94NDE1alpMNWJYZjMydjRy?=
 =?utf-8?B?MXdkRDAwaVB4N0dUcVZWODRoaTRDb0hPTFpKYmxNdmxLUnVuay9PR3kzd1hr?=
 =?utf-8?B?UUt5YnVXRlNESUF4RlArOEg5MVQ5anF4MXRWdm5XdGlNaFk4bTN6dUZtZy9X?=
 =?utf-8?B?ZnhVWDhyTVlzSnVZbzRTNjVsY21XN3g5SlN3Sml1enptTEQwL2pwSkZicTVP?=
 =?utf-8?B?Znh1cGI1VFdTQXZBUzZqcGIzOFUyTzUwYWNFV3piSzIyay9PcXozdTFXQWlE?=
 =?utf-8?B?T2szdEhoOWl3SUtTYWxZdEI1UFAvSGNJdGpxTkoyU0JzRDNEWkwySHE2NFdl?=
 =?utf-8?B?UGN6c2hYWjM3UXNmc3hFNE8zcmFKSy9FZzRhZnUvZk1jdVQwVW1rSDFZWUtW?=
 =?utf-8?B?SGxTZWNwQTRZUkFCT056MHlsQ3NEbnRHTWVaU3BXTFF4OXZFOGpMTnFUUHRs?=
 =?utf-8?B?ek9lYmI3WDF6NGc0Nlc3ZWM2MVNFVXdMQWsrL2lRVU5leVZTR2FDZno5OUN5?=
 =?utf-8?B?UDErUTBXOFBhMXIybDJha0kvcnk0VDlXN2pkZmx0ZC9ydDRxRzkxVHpGYXpW?=
 =?utf-8?B?Q0RYWHZsUXc3R0ozblZucnc3TzFra2ZhOVY0cVU0cFNNSmk0UVRnbUt3TU80?=
 =?utf-8?B?QzJHd0JmTk9MbFVGeXhteU1MazYvMnd5RmcwNnNYb2IrV2JEVDg4UlE3Z2hj?=
 =?utf-8?B?ekQvdmRSVFhVVzQxdVhQblc0UkE4YVZNWGJCNE5wZWxndTZBcThFd2MrTW9z?=
 =?utf-8?B?WnljQ0ZnbHFlVkIwbG03d1ordlR4emJUSHRRRmh4aDZDUTFWQVBjNE0rbTJi?=
 =?utf-8?B?aWNRWGJRVWFxMHdPRVFsbGdYYjZOYWtUVjVkWkcvekM3VHNFM1diMWlMQUFD?=
 =?utf-8?B?RFRjZm5ka2svd2N0TkVLLzBIc0RzckY0NTJzcU1JVFQvRk95b3dQVE5vd1h0?=
 =?utf-8?B?a3hYd29CV2tkbDBsb2MySFNvcWRtbmZXMThhSjlVcWZTYzNYcDMvQXl1N0dB?=
 =?utf-8?B?d01WR20xQUdjVklwcjA4S0F5Q2pIZUZZdFhuVXkxenlRb3pGeEF0Q1I2cnlQ?=
 =?utf-8?B?TURXL3F0NzJndEE1V1NzK2Rycnl2VWZ4VWJuTVplYkx3anRNc3BwNFN2UTBj?=
 =?utf-8?B?V3NnKzhnNHdVRG96eUpJcktzYkc1M1Uxbk9Cbkk1a2l6dWxhdUtFc3ZlK0Rt?=
 =?utf-8?B?YW5RZWZPYW9jZEFybDJyaGZVT2xCMlRxR2FFTkRaa1J3cDF5UG50RVF5ZlIx?=
 =?utf-8?B?aVptZEJaaTM1Q3ZzMHlEYm9TTjFCZ3B3bkUxVVdLUUV5ZUJUTW1QWE5YRWF2?=
 =?utf-8?B?bUk2MkF6bEJjZjFGOVVWZllhWlgxek5rSXQ5aUdiU2dHYVErdjBObGErV0JO?=
 =?utf-8?B?dkR6VEgrVDVQRm9xdWsva21aT250NVdHUjZrZ1FUYXVoMXN6K2VhdDR3blho?=
 =?utf-8?B?aUUxd3BYZXhvWExleWs4ajVjekM4c0NoRmxjNUw2YlJzQ2ZTZ0c1M014NGpT?=
 =?utf-8?B?UWNZcmdaMjZZOXJPS3E4NDR2RGJLeEJhV3lhUDV5a0Z4SmRZMVRFM3NwV2I4?=
 =?utf-8?B?Vm4vOVlwNjFQWGQ4SVg2bkVaaFhzZVdQZzZSMDhneFk0Rm5qdTlpbkVNYnk0?=
 =?utf-8?B?L1RNOGtNZzdPOFpnNFVlN0MrU1d2T2FRSUJuSFJBM2VtQm5zbTFidFNHUVdE?=
 =?utf-8?B?TjAxWFc0NkxOaFJXNVEwK1BsKzVrOXVVNFMzL3ZPMW1uUitPcHRLT1o1MmVB?=
 =?utf-8?B?akk3NTUxWkNjZGxYL0JxMXVHQXZRV29XTUMvMThMbWVlT0pQNXJ3NGxiVFV5?=
 =?utf-8?B?Zm1ZdnAxdEZTNXRlcDNTTWRyOFBvWURUOTZ5enZrb29tSVd1QnhSSnp2c3F6?=
 =?utf-8?B?UFR1YUh1M09xSDZTYjU1eFljRWVVUTk3QzdDSy9yeVlheDRQNWx5UXpWbXF3?=
 =?utf-8?B?Qk5TaXZhYy9hS2FYeWxtWVBaOURPaS9UMnU2ZFpvR3YzV3JmSVBPSmZ3Nk1E?=
 =?utf-8?B?cWdvdUFNVnNockdQQjh3Tkp1VWlZSE5VMGpGMHczRnlhVjlEQnB5K3FrN0lx?=
 =?utf-8?Q?Auqp1HJvmEUC2rAyDr83vlI1c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B26070E319CE794799A316981114D556@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7423c9-7709-40fb-b66d-08db3ae98198
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 00:04:37.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JL7QZMiOwhGm95h2B8VWVhg8yDHiHehbilWetHVD1tglLPC91TVUucAWxPFGk7ejoPpcldYGDI+KHRvfmUKggCWWPhutmYq79U6YRuGc18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTWljaGFlbCwNCg0KT24gNC81LzIzIDA0OjQwLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93DQo+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KPiANCj4gWysg
d2lyZWxlc3MgYW5kIGNmZzgwMjExIG1haW50YWluZXJzIGJlY2F1c2UgSSdtIG5vdCBmYW1pbGlh
ciB3aXRoDQo+IGNmZzgwMjExIF0NCj4gDQo+PiBGaXggZm9yIGtlcm5lbCBjcmFzaCBvYnNlcnZl
ZCB3aXRoIGZvbGxvd2luZyB0ZXN0IHByb2NlZHVyZSBbMV06DQo+PiDCoCB3aGlsZSB0cnVlOw0K
Pj4gwqDCoMKgIGRvIGlmY29uZmlnIHdsYW4wIHVwOw0KPj4gwqDCoMKgIGl3IGRldiB3bGFuMCBz
Y2FuICYNCj4+IMKgwqDCoCBpZmNvbmZpZyB3bGFuMCBkb3duOw0KPj4gwqAgZG9uZQ0KPj4NCj4+
IER1cmluZyB0aGUgYWJvdmUgdGVzdCBwcm9jZWR1cmUsIHRoZSBzY2FuIHJlc3VsdHMgYXJlIHJl
Y2VpdmVkIGZyb20NCj4+IGZpcm13YXJlDQo+PiBmb3IgJ2l3IHNjYW4nIGNvbW1hbmQgZ2V0cyBx
dWV1ZWQgZXZlbiB3aGVuIHRoZSBpbnRlcmZhY2UgaXMgZ29pbmcNCj4+IGRvd24uIEl0DQo+PiB3
YXMgY2F1c2luZyB0aGUga2VybmVsIG9vcHMgd2hlbiBkZXJlZmVyZW5jaW5nIHRoZSBmcmVlZCBw
b2ludGVycy4NCj4+DQo+PiBGb3Igc3luY2hyb25pemF0aW9uLCAnbWFjX2Nsb3NlKCknIGNhbGxz
IGZsdXNoX3dvcmtxdWV1ZSgpIHRvIGJsb2NrIGl0cw0KPj4gZXhlY3V0aW9uIHRpbGwgYWxsIHBl
bmRpbmcgd29yayBpcyBjb21wbGV0ZWQuIEFmdGVyd2FyZHMgJ3dpbGMtPmNsb3NlJw0KPj4gZmxh
Zw0KPj4gd2hpY2ggaXMgc2V0IGJlZm9yZSB0aGUgZmx1c2hfd29ya3F1ZXVlKCkgc2hvdWxkIGF2
b2lkIGFkZGluZyBuZXcgd29yay4NCj4+IEFkZGVkICd3aWxjLT5jbG9zZScgY2hlY2sgaW4gd2ls
Y19oYW5kbGVfaXNyKCkgd2hpY2ggaXMgY29tbW9uIGZvcg0KPj4gU1BJL1NESU8gYnVzIHRvIGln
bm9yZSB0aGUgaW50ZXJydXB0cyBmcm9tIGZpcm13YXJlIHRoYXQgaW50dXJucyBhZGRzDQo+PiB0
aGUNCj4+IHdvcmsgc2luY2UgdGhlIGludGVyZmFjZSBpcyBnZXR0aW5nIGNsb3NlZC4NCj4gDQo+
IFdpdGggdGhpcyBwYXRjaCBJJ20gbm93IGdldHRpbmcNCj4gwqDCoCB3aWxjMTAwMF9zZGlvIG1t
YzA6MDAwMToxIHdsYW4wOiBGYWlsZWQgdG8gc2VuZCBzZXR1cCBtdWx0aWNhc3QNCj4gDQo+IHdo
ZW4geW91IGNsb3NlIHRoZSBpbnRlcmZhY2UuDQo+IA0KDQpUaGlzIGlzIGEgZmFsc2UgYWxhcm0u
IEkgd2lsbCBtb2RpZnkgdGhlIHBhdGNoIHRvIGlnbm9yZSB0aGlzIGRlYnVnDQptZXNzYWdlIHdo
ZW4gdGhlIG1hY19jbG9zZSgpIGlzIGluIHByb2dyZXNzLg0KDQo+Pg0KPj4gMS4NCj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjIxMDI0MTM1NDA3Ljd1ZG8zZHds
M21xeXYyeWpAMDAwMi4zZmZlLmRlLw0KPiANCj4gc2hvdWxkIGJlIExpbms6DQoNCk9rYXkNCg0K
PiANCj4+IFJlcG9ydGVkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+
IA0KPiBNaXNzaW5nIEZpeGVzOiB0YWcuIEluIHRoaXMgcmVnYXJkLCBtb3N0IG9mIHRoZSBwcmV2
aW91cyB3aWxjIGZpeGVzDQo+IHBhdGNoZXMNCj4gbWlzcyBhIHByb3BlciBGaXhlcyB0YWcgd2hp
Y2ggbWFrZXMgdGhlIHdpbGMxMDAwIHByZXR0eSB1bnVzYWJsZSBvbg0KPiBzdGFibGUNCj4ga2Vy
bmVscyBJTUhPIDovDQo+DQoNClN1cmUuIEkgd2lsbCBpbmNsdWRlIHRoZSBmaXhlcyB0YWcgaW4g
dXBkYXRlZCB2ZXJzaW9uLg0KDQo+PiAtLS0NCj4+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWlj
cm9jaGlwL3dpbGMxMDAwL25ldGRldi5jIHwgOSArKystLS0tLS0NCj4+IMKgZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW4uY8KgwqAgfCAzICsrKw0KPj4gwqAyIGZp
bGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5j
DQo+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuYw0K
Pj4gaW5kZXggZTlmNTlkZTMxYjBiLi40MGVkZWUxMGE4MWYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmMNCj4+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuYw0KPj4gQEAgLTM4
LDExICszOCw2IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBpc3JfYmhfcm91dGluZShpbnQgaXJxLCB2
b2lkDQo+PiAqdXNlcmRhdGEpDQo+PiDCoHsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IHdpbGMgKndp
bGMgPSB1c2VyZGF0YTsNCj4+DQo+PiAtwqDCoMKgwqAgaWYgKHdpbGMtPmNsb3NlKSB7DQo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiQ2FuJ3QgaGFuZGxlIEJIIGludGVycnVw
dFxuIik7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFfSEFORExFRDsN
Cj4+IC3CoMKgwqDCoCB9DQo+PiAtDQo+IA0KPiBUaGlzIGNoZWNrIGlzIHN0aWxsIGluIHRoZSB0
b3AgaGFsZiBvZiB0aGUgaW50ZXJydXB0IHByb2Nlc3NpbmcuDQo+IFNob3VsZG4ndCBpdCBiZSBy
ZW1vdmVkIHRoZXJlLCB0b28/IFRoYXQgd2F5IHlvdSBjYW4gZ2V0IHJpZCBvZg0KPiB0aGUgdG9w
IGhhbGYgZW50aXJlbHkgYW5kIGp1c3QgbGV0IHRoZSBpcnEgc3Vic3lzIHVzZSB0aGUgZGVmYXVs
dA0KPiB0b3AgaGFsZiBpbXBsZW1lbnRhdGlvbi4NCj4gDQoNClllYWgsIGl0IG1ha2VzIHNlbnNl
LiBJIHdpbGwgaW5jbHVkZSB0aGlzIGNoYW5nZSBpbiB0aGUgdXBkYXRlZCB2ZXJzaW9uLg0KDQo+
PiDCoMKgwqDCoMKgIHdpbGNfaGFuZGxlX2lzcih3aWxjKTsNCj4+DQo+PiDCoMKgwqDCoMKgIHJl
dHVybiBJUlFfSEFORExFRDsNCj4+IEBAIC03ODEsMTMgKzc3NiwxNSBAQCBzdGF0aWMgaW50IHdp
bGNfbWFjX2Nsb3NlKHN0cnVjdCBuZXRfZGV2aWNlDQo+PiAqbmRldikNCj4+IMKgwqDCoMKgwqAg
aWYgKHZpZi0+bmRldikgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV0aWZfc3Rv
cF9xdWV1ZSh2aWYtPm5kZXYpOw0KPj4NCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KHdsLT5vcGVuX2lmY3MgPT0gMCkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHdsLT5jbG9zZSA9IDE7DQo+IA0KPiBJZ25vcmluZyB0aGUgZmFjdCB0aGF0IHRo
aXMgaXNuJ3QgcHJvdGVjdGVkIHNvbWVob3cgYW5kIHRoYXQNCj4gdGhlcmUgaXMgbm8gd3JpdGUg
YmFycmllciAobWF5YmUgSSdtIG92ZXJ0aGlua2luZyB0aGlzIGFuZA0KPiBpdCBpc24ndCByZWFs
bHkgbmVlZGVkIGZvciBhbiAnaW50JyBmaWVsZCksIHRoaXMgYW5kIHlvdXINCj4gcmVhc29uaW5n
IHdpdGggdGhlIGZsdXNoX3dvcmtxdWV1ZSgpIHNvdW5kcyBsZWdpdC4NCj4gDQo+IEJ1dCBJJ20g
c3RpbGwgbm90IGNvbnZpbmNlZCBhIGxvY2sgaXMgbm90IHJlcXVpcmVkLg0KPiB3aWxjX3VzZXJf
c2Nhbl9yZXE6OnNjYW5fcmVzdWx0IGlzIGF0IGxlYXN0IHVwZGF0ZWQgaW4NCj4gd2lsY19kaXNj
b25uZWN0KCkgYW5kIHdpbGNfZGVpbml0KCkuDQo+IA0KPiB3aWxjX2Rpc2Nvbm5lY3QoKSBpcyBj
YWxsZWQgZnJvbSB0aGUgY2ZnODAyMTFfb3BzOjpkaXNjb25uZWN0DQo+IGNhbGxiYWNrLiB3aWxj
X2RlaW5pdCgpIGlzIGNhbGxlZCBmcm9tIG5ldF9kZXZpY2Vfb3BzOjpuZG9fc3RvcC4NCj4gSXMg
dGhlcmUgYW55IGxvY2sgd2hpY2ggcHJldmVudHMgYm90aCBmdW5jdGlvbnMgYmUgY2FsbGVkIGlu
DQo+IHBhcmFsbGVsPyB3bC0+Y2xvc2UgaXMgY2hlY2tlZCBpbiB0aGUgLmRpc2Nvbm5lY3Qgb3As
IGJ1dCBhcw0KPiBtZW50aW9uZWQgYWJvdmUsIGl0IGlzIG5vdCBwcm90ZWN0ZWQgYnkgYW55IGxv
Y2suDQoNClN1cmUsIEkgd2lsbCBwcmVwYXJlIGEgc2VwYXJhdGUgcGF0Y2ggdG8gaGFuZGxlIHRo
aXMuDQoNCj4gDQo+IC1taWNoYWVsDQo+IA0KPj4gKw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgd2lsY19oYW5kbGVfZGlzY29ubmVjdCh2aWYpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgd2lsY19kZWluaXRfaG9zdF9pbnQodmlmLT5uZGV2KTsNCj4+IMKgwqDCoMKgwqAg
fQ0KPj4NCj4+IMKgwqDCoMKgwqAgaWYgKHdsLT5vcGVuX2lmY3MgPT0gMCkgew0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV0ZGV2X2RiZyhuZGV2LCAiRGVpbml0aWFsaXppbmcgd2ls
YzEwMDBcbiIpOw0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3bC0+Y2xvc2UgPSAxOw0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2lsY193bGFuX2RlaW5pdGlhbGl6ZShuZGV2
KTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5jDQo+PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmMNCj4+IGluZGV4IDU4YmJmNTAwODFlNC4uNzAwY2I2
NTdiZTAwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL3dsYW4uYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL3dsYW4uYw0KPj4gQEAgLTEwNjYsNiArMTA2Niw5IEBAIHZvaWQgd2lsY19oYW5kbGVf
aXNyKHN0cnVjdCB3aWxjICp3aWxjKQ0KPj4gwqB7DQo+PiDCoMKgwqDCoMKgIHUzMiBpbnRfc3Rh
dHVzOw0KPj4NCj4+ICvCoMKgwqDCoCBpZiAod2lsYy0+Y2xvc2UpDQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybjsNCj4+ICsNCj4+IMKgwqDCoMKgwqAgYWNxdWlyZV9idXMod2ls
YywgV0lMQ19CVVNfQUNRVUlSRV9BTkRfV0FLRVVQKTsNCj4+IMKgwqDCoMKgwqAgd2lsYy0+aGlm
X2Z1bmMtPmhpZl9yZWFkX2ludCh3aWxjLCAmaW50X3N0YXR1cyk7DQo+Pg0KPj4gLS0gDQo+PiAy
LjM0LjENCg0K
