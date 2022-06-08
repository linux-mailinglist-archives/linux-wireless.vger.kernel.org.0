Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D85428A6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiFHH5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiFHH4D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 03:56:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF51DFC42
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654673124; x=1686209124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fQEKhOl8roE1UTSs6fEu08LU4ifJdUci8LKvgUUKYAY=;
  b=pWJ8c37J8PYqsMSU98bSHdZHu7fdwwLt7PXZrRAXed0oFHpLZ1FBV/NZ
   YyN/s9MzSn0Seq6xaAVp2FZ9oztCKznx+YC9A6247JLiViCS6wFXFyCpW
   bxi8Qs5iWUfh6H45wQJpDU1JtqdpaJivQKnb1Hycq3APlCFsvV6HRYyBW
   UIpBOqf9Iig9ZvIDrln/2vZakj4o7SolHLsKNjNFkxUoK0Sp6oNudJ/+a
   iLQ1uwkE77CRyr64fVwd6RDTq3qhRt2AsT7j9p27IBAkj0SC1aXVmdRdP
   yaitvMn8RI20K3jdJYdGsONBiuIUAv+HdhngTyDSQni+usla9ER6Dz1HU
   w==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="159346446"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 00:24:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 00:24:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 8 Jun 2022 00:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFO3iRNKx/f9mPqmIpdfG4nQLL1MEkQ9MK2DVOPOQK0A9SV15r879u+wRxcrbwSWLA6T6aEEhsdOazAlLCywQD7AGuYUKee5p4l/xt1HTrrbaAFK9Slp2eDvYhCPJ/AsNGi+wInNdXiNXxqF8JK1g+DHqVWDnalrlAyWP86Es/UWpYmg7RResIAPeNm5uhxFfPhgS5E73uk4tV4KOSW21gyeG1hYR+jD+m7Dg2/z8rE7OsDU5qYhDMtmNp8ptISgu4NMh6UwQ0qNoS2FLvbiuof8tWg2GD2063IClXJV4RUpJcolHLnRabYVH59cHnuf6GW5Dx6BsZOdVhOXCqTdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQEKhOl8roE1UTSs6fEu08LU4ifJdUci8LKvgUUKYAY=;
 b=H2CT/kO3mOt9kDvHDk0temDQom4l9vjsL6eRTuTUKz0nNvxW/13D9vyBZEgb59QU3XD7j/PVO4KK7lC7Qkl2wlk6Ks1qWc6AqIAUXmRhKGwNvCgAYUVhB9c6CNVDEHFV4scIdQNFQL7DYAgG5+uETWhl941/mrjMU6BXoezOzAOrF945NW9Tn4+/ES5f98z3PwcASV06xF+hg4t3z61fbDJ9tkYziurCCXaetpVJJTbsMkT85craw7U/nrbREVpdMt1az6/agefV/SR8ys3HuWX8HjOT+USOeK/2fdqqpNHFloHNifVwvUnBuf4yhEWMR0Z6fqfyGlCJJ6YNuN0ljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQEKhOl8roE1UTSs6fEu08LU4ifJdUci8LKvgUUKYAY=;
 b=e4A4fgKqAmyytdVeRzpBOd2X5RRHJ+hY7tEdzXgMijE8myPxOuYv/7zZKZgmJELyZH5wEV0JxmRUiJLv801LtQNszzBAq92ByyHdnxvpKz9Do+6x8FZJN0DPppSYpsXYte9oWsAo0XYg0V3ERPc7VssfVdSOMaYZ7RNDT0wCaCw=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BYAPR11MB3847.namprd11.prod.outlook.com (2603:10b6:a03:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 07:24:31 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%9]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 07:24:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <jwboyer@kernel.org>
CC:     <linux-firmware@kernel.org>, <linux-wireless@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] linux-firmware: wilc1000: update WILC1000 firmware to
 v15.6
Thread-Topic: [PATCH] linux-firmware: wilc1000: update WILC1000 firmware to
 v15.6
Thread-Index: AQHYekG8c+WsYUSZD0iQSsN0a3rxt61D4U+AgAE7xIA=
Date:   Wed, 8 Jun 2022 07:24:31 +0000
Message-ID: <1fdfbbee-22c9-3abe-8d65-cc4a48e0fea8@microchip.com>
References: <20220607073929.32170-1-ajay.kathat@microchip.com>
 <CA+5PVA5uU_i9Cm4OQg75acLWe7v5GZvdSbCzWF_D0bXMnn-bnA@mail.gmail.com>
In-Reply-To: <CA+5PVA5uU_i9Cm4OQg75acLWe7v5GZvdSbCzWF_D0bXMnn-bnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100dc84b-3197-4127-c578-08da491fee37
x-ms-traffictypediagnostic: BYAPR11MB3847:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3847D4C7FD53DD781826DB5EE3A49@BYAPR11MB3847.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hhgrRZdTGeLlyFIu2wvFraAdeEevl70JhTV//5GWheIW74Un73OhzkLEyQJp9Y+3RYkRcDz2RBz5MA7kjrYGVV1xAC9e+G31/zNPO0u+rPPjPW9etwjyAAuLwKydIg5jfSuGVNfjOwnjdCe1ogjDYxzs5Z4f6WAOfkV3op31Avzlm4eeILQV8KdhpheYvv0CXxwaZMdZJdDn7OojgD0h/hkGZNgB5cMwKHMgcJxx0EshiHPfkzuO/LvPAGsy+H2A+5gnDNIBittTcpPz7U5xd6BO+blL+uRvt8/jdY+DRo0HBTVzUW/V0/2FL2seQGzX6SG5HDJzk6QP/s69r336+LKiK9T3Ti1/b34F+ACh5HyKr3AegTMtwdu3MWY/3OrmNKzTJSqwXEXj4VFvl7VzR6lb9kOsDNFkMAPXL3N1Yu9wZkIhjRUf8EdPXsi21x3KQRZT9DBNEMrCBw+ULPAbIIcTqltcyxwCMA7jxqafdzOb/L42bAtFJMX+T32G1MiWh2n3IiefLrbsCswIPic8wJOsSGquJ3I1DbnFig7colPHEDHds/O9n3W4QqXtRikOU86sTJ6iDKMfzAYFUM9D430UGIJl26pogyz5VDiLMdjcPNNKGJbVq4fZux2Q6+GtR0US2kabT2UBoWZXjnb1OWQ+GsGqXqIDTUZ/nNQ2vKF2C6HC55LbFJgw/eneR/EUoWs0ygPaCbP3hFmpEpfK2wuggeZKOgBIzjYYKvz3m1HGVOWlPlRYLn3ZT5HyLby55JwJ5iZHuRXKfqP9Fq3+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(316002)(26005)(8676002)(6506007)(4744005)(5660300002)(53546011)(38100700002)(64756008)(15650500001)(107886003)(31696002)(86362001)(186003)(66556008)(8936002)(6512007)(66946007)(66476007)(91956017)(76116006)(31686004)(2906002)(2616005)(66446008)(83380400001)(55236004)(4326008)(54906003)(122000001)(38070700005)(36756003)(71200400001)(6916009)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXpRVmJXaG5kdHFuZVBrWEs3RGpKMnY0VWphT0pYbFE0NW9aSTRJOTE0eW9l?=
 =?utf-8?B?ZjZadlV4WCtwZ1dHQi9kRjdUaUxIV3RkdkFRam9jNGR1bTVxYlM3a3dwWE5B?=
 =?utf-8?B?TjM3NXF0ZE01Z0QveGcySngzcWVPOWdkMXZqSi9jWWFDNUphVGVSZHFOUUxl?=
 =?utf-8?B?TDdhRVVab05vaWcxOGxyY3VCcDdJMklqRi9iU2NEZlFPOVovdGVrSDQ0WUQv?=
 =?utf-8?B?bHV3a2FjdmZnOGR6OWtJWmtpbThhVFlTK25xdDlQTVdtTG10WExsbG1nUTV1?=
 =?utf-8?B?RFVWa3dFTGZLNUhMRS9KdzFFNytSdFlxWmJobUg2QU41cHdNSS94Y1J2enQx?=
 =?utf-8?B?VGFybDQ3WTVqS05QeEZYVE5aYnNGTWtPSndWOUU1aHd2RFg0QWJXS2sxQlNH?=
 =?utf-8?B?TXY4TDdhQ3hKdWF4R2Y3QitNMitUNmc4QjlOc01xVUN3R0M0b2M3U3o0Z3Zv?=
 =?utf-8?B?RDN2SEtiYWZTRWZJN3AyVkFySnQ3YU1FRkNVTDUxcVh1dW81ZFFIQmFva0hk?=
 =?utf-8?B?anBmb3UyZTg0bGtycHovRHN3dnZzTy8wckZkVXRzSnNzK202cTk4NTl4MC9B?=
 =?utf-8?B?dW5QQXl0WXBPOEpFaDE1KzRZek9WdituL1VjeFdBc2RJYnkyNHlPSGNKTkJB?=
 =?utf-8?B?ajcwSzNYS3ljK3M2dnBIRkkwbE5FbCs5MjVyZjBIeVAyRE1GTXBnVzl4dk82?=
 =?utf-8?B?dnAwWEJYYkhtMG1ZOXRHRkxKQkpIYjBWS2ptMC9icFg2WXhUSytBRTZLaVc0?=
 =?utf-8?B?a1Q1QVo4VVFOQlNGSFdvd2dLRis0Umhlb3AxbEtaMFdZV216ek1nZWIxVlRT?=
 =?utf-8?B?L0xlb0F5bk81V0VCNnNHdzgzTVBsRmRvaXdwaXFvY0N5ZjZTMERXOFE5WDVT?=
 =?utf-8?B?cS96V1lycTNIZmtJd1VJSWV1WkZZejVyN0tNcFhadHE5cUZ2Ulg5R3dhTGQ0?=
 =?utf-8?B?ZndVbEloZEVrUHNxelROWE1oUWdWYnlYenB4ZHNMNzZEQmh0dHh3aWE3a0NQ?=
 =?utf-8?B?WUZ1bEVPT0I4QytrWDFzcFhrd1pXNHUzN2VPd3hOU1hXNlZKZ0hpVjhzMzZa?=
 =?utf-8?B?dXlqZnVFeTNBdkFJTW92WGNBdjZXdExCVXJsQWtLYUFnbUJLRThRZ0JXQ3hm?=
 =?utf-8?B?QStab2lLUzJlYlZsMm9UNUdBQTUzRElDM0tGZTNhUS82OXAzR21xeHlNYmlk?=
 =?utf-8?B?ZUtsblg2bFQzSkEyYTc1eG9Lalhxa2U2c1dTZnBTSnNCUWJXZDBab0FGOUtH?=
 =?utf-8?B?dTRtWmlLMld3cDFweFBKVnI4TCs2bCtJZmtMWEZaVlIvTWthUVJBL1UwaXhJ?=
 =?utf-8?B?U09nSTlUUDN1Q2c1TmZIQ0lkYTR1QU11K0FtVzFRM2dHZnJLWFo4WHltR08x?=
 =?utf-8?B?akdWc0dkZ0tlLzZ5TUpjUjkvNStvWWhDcjBjSnBSdEhnejJnTkVhTmNvc29n?=
 =?utf-8?B?Zk8zQm5ETng2UUhqOW1BUVdzaTZOVHU5Qm1PSzRLdnBjcjd5bitNb2hRMGRF?=
 =?utf-8?B?YWM3QUIwZ2R0R2l6Vk0xS05ZUEtDd1F5Z3ducHo5akgwTGRzenFHMDhaWXZu?=
 =?utf-8?B?Y1FOZ21RK3V1OGtmWU5seFh4ZFNxZUNrWVhWZGxRNUprZ1FsdkhzSzdzdDlN?=
 =?utf-8?B?K3pocE82bHVaQ1dDdks5MnVEMnZHcEJBOGYrN3RmdFdiU0cydmFUaklmRmtO?=
 =?utf-8?B?VXV0eG16bDZSVFVWeklpbUdWSkIydnJoMmE0dXJIaHU5eFRhTWNKbUFKRWF6?=
 =?utf-8?B?WDd4ZkkyNWlmMmZ6eFJGVjc1R2FhclZweDJxdGdHVU9TdTF5SkNkdktNRzZi?=
 =?utf-8?B?OXRsN28rVk1QelUxNURvMXQwVWlrRkdNcGlwdlRGa1haQTJiYytPREtGV29l?=
 =?utf-8?B?bWl3TS93UU1PWnZWZGsrL0x5K21QWU5TcHZObEp5ZDR5UkIzdWlFODdJVjJ3?=
 =?utf-8?B?UUk2bmp5NkY5UlQ5S1g1ZmF1WGhoak9YUkowMnBNY0Jqa0M4bWlWd3FJTWRk?=
 =?utf-8?B?Uit0dU1hQkpUd0NDOU5oNXFoQ3hHOG1VaUdSTkRNOVAvcWFZYjEwUlp0SHlx?=
 =?utf-8?B?YnNDaG1vQnhJSW1pa0poMmo0alBCMXYzV0NLSUxhZWJGck4rUUJPM1lLWnRw?=
 =?utf-8?B?WCsxbHVMVXN0WU1JbnQ2WjF2dVdHRmtpUjZwdzhseW5jTlNJQ3JkdXZqWHpK?=
 =?utf-8?B?ZlVhL2tNWUk1ZDU2VmJSbkxiOVVhbHpXMXUrUnRIT0IwdzMyMGJHY2J4OUZE?=
 =?utf-8?B?M1gwZXNUQ0tHa1FJWldvU3JBL1pRd2ZsZmZGQmtPWFQ0ejVzVmlvZnlMT1JZ?=
 =?utf-8?B?THJrOVVkc2ZXUXc4emRnUUtSazl6WE5RUk5QbmhtU1JwY3V4Y0ZxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C2EDCED3725484FB79EEC16BF2210AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100dc84b-3197-4127-c578-08da491fee37
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 07:24:31.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cg/JiqBx3JyZ2nv6006Z4v743Y/Vqsfat7Dq7j0R5ipuZyauUyzVWbqG+EgPRR/0urpk+XPxMCP7+7L9KfP8a0PLKo1Hkvwn0ZhcBUe1sps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3847
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMDcvMDYvMjIgMTg6MDQsIEpvc2ggQm95ZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBUdWUsIEp1biA3LCAyMDIyIGF0IDM6MzkgQU08QWph
eS5LYXRoYXRAbWljcm9jaGlwLmNvbT4gIHdyb3RlOg0KPj4gRnJvbTogQWpheSBTaW5naDxhamF5
LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoaXMgcGF0Y2ggdXBkYXRlcyB0aGUgZmly
bXdhcmUgdmVyc2lvbiBmb3IgV0lMQzEwMDANCj4+DQo+PiBGVyB2ZXJzaW9uOiAxNS42DQo+IElm
IHlvdSdyZSBidW1waW5nIHRoZSB2ZXJzaW9uLCBzaG91bGRuJ3QgeW91IGNoYW5nZSB0aGlzIGlu
IFdIRU5DRSBhcyB3ZWxsPw0KPg0KWWVzLCBJIG1pc3NlZCB0byBpbmNsdWRlIHRoZSBXSEVOQ0Ug
Y2hhbmdlLiBJIHdpbGwgc2VuZCB0aGUgdXBkYXRlZCB2MiANCnBhdGNoIGJ5IGluY2x1ZGluZyB0
aGUgY2hhbmdlLg0KDQoNClJlZ2FyZHMsDQpBamF5DQoNCg==
