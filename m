Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6F60D57F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiJYU0X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJYU0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 16:26:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EBB86880
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666729579; x=1698265579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PcNKU/zNpo9DmV0lmuSpHazAZeJeYf9vsamLAzt3bDo=;
  b=MLd7usL9tU7Hx9kev5LxPiEbF1j+QxRC/RSQuZNptKOQG3u5tXGA9ipK
   1l/XFWc19ca4hDfbhKGCE508u34AcWTJz5lhxPOVekDr2MQh9eyUYRT8G
   Gj2VrzIikh1codv3li7VZH3DjlauEJjf9ffWY8dUN6rUVDgtZNmrycZVQ
   sqAFzOS2Y7JDYuo1u/Chx0TedK7wRzUXWSL9Ru92yb5z2SVRP6jnYq9xa
   8F+Xh5/Sn+/5Rx2rzB2DXZQjsywfdxyOKaStFSh0SD5prl46LMKzy5UgE
   A5jn3BHFe9tEIGCNASaIY+xcJG8Tl25+DFBUNhy8laluhPdWSK2nHoDoI
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="186275758"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 13:26:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 13:26:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 13:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgY9zWMCJ6DwbyZ13aMk9KgCTOjxu5TVGzshoWFCsDYr+37Qmdi6MxnPRbeKEhc7/V0uMEu3YTlLnrvH9Z+2acMG5CQSTgBQxr/XRQQwg3g7MYglCEmO7pESkRKtIvTlnuGMo3zLrRxIZ8BE/sFTbzBQMIFeireqxzeB8gwWe/KBTOmEL6AUaPdhFEXby3SvnqrW9QbUJ0eRgNDpmVflLItCMW9QYZsQ75oioCou/fLkG+F+qVm+7air+nj9EDvUUqRXf8y2hKVgv5MjW0sjwNP1722o5ilkhquuIpidRMcWGVneYFng66YS0Le8CAy8mbO34mjDINy7dEzwU1yHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcNKU/zNpo9DmV0lmuSpHazAZeJeYf9vsamLAzt3bDo=;
 b=nWGzFskHKH2AxAnqXTKBbbbxLKOImqPJmxX+87MV3EoVh2Qc2uv2x2ZY6y1SY96kDGYEjbQNIeAzKIBql3U23ZBWVyu0ji4oZLpT7kM3Mk4V2byO6vRHwXQuHJ1IxFzLibtsvGRO3r6XFnF6KCNTMJJpH5/6cAejD3pHumlMJApvbaAbufa2YxFUWaGVsFZKFOysvoUwgAxJclCqQowRev9kc2k/ImT7D/i73XLMjVdEiEd0BSNxwgnBi4Qv23T5Qpwlw6/s7IMmSuzQsKDbGbbGIW3R7qMmNmYuQBabXgT2k683guGO2oX9EARU8SzCd5N6+XVEAmOqraviqSpuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcNKU/zNpo9DmV0lmuSpHazAZeJeYf9vsamLAzt3bDo=;
 b=jFaccx9uq5lFsPck6KrNKA4K9IOcm7paZGYPB0b1SWLB7rrzj8TpyFnaPo8GyqxtGKs89nL5mmA2F13EKbB1yxbAD45aKRqo1SQXf3Kab73ujcvG4rfop+T6kioePV2HufhQwtRp/TSVwg0yL79F/X7vRZBvhRm/QhXG9b6Oer8=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CY8PR11MB7291.namprd11.prod.outlook.com (2603:10b6:930:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 20:26:10 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::1567:cd7b:9d1:faee]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::1567:cd7b:9d1:faee%9]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 20:26:10 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <mwalle@kernel.org>, <Claudiu.Beznea@microchip.com>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
Subject: Re: wilc1000 kernel crash
Thread-Topic: wilc1000 kernel crash
Thread-Index: AQHY57AoYhoLUWmb1kmazG1Rwau7ba4fkKkA
Date:   Tue, 25 Oct 2022 20:26:10 +0000
Message-ID: <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
References: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
In-Reply-To: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CY8PR11MB7291:EE_
x-ms-office365-filtering-correlation-id: e4664eaf-7e05-4901-8f35-08dab6c7279d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jSoimtx3QAeasjhm0gdQD7eQIFdGrxyzvG0Z9VujPTLgBVxdNqw161PC11VMFJOnSi4RSkmOZDl/lgRKaWNLUrEFfsQiP/xt5nACVvaO/CouZ5zSP0omC5/CIM1X2/mURpPdeGbwSwNXNQXFgBNWiUu43WJaRQB82BVA+Cm9Vqmio0+ztjXUa1XoxeOB2PyQGuZ+hlMndvhlOZGpQqZSFBzwcIpreTSBsi/lmm87Y+BECw7qhi1Vcc5VYqmtOMAub/K/EKiGvM7I/SiduYYzq8GN/o1mjHA4CMUCBZG7I0iyJUfioOO3098JgDqSuC4D0tIE2erwGqR9XaLxIzZCaJ3XdeNYMfQXMdHadxajDDm1Df2MPtrIqJfTtG0O6rtrmP8AVds3kCC6HYJG3xSJ/e9lmiMTDKu9zpHwaZUf/OEFis6KM6mi1LKsyO79azzHVepJZFVco/UybL/c7HE25bnfOvBpwzL+mtnQyjb4WqXagCLAF0XFfbwGs1+TCQQI3jwoMNC3A41Mhqzcj2GUN3wSYFFMLeSsr+Uz5mI/6W/3+BzTui3md6kRpVm5B/JkgWyCD2oK7Y4fhWFOtas9u7A6VwDvtq5u3kSBsKV78E8yYsSCX0m27hUmEemQ6aqjxaW98AW97fWGXNj1MNOucwn28vdlh99v136AJfpm4isj1DJCGJA18hB7/sKnmBBMI8az5EFnf9BJErJPNRjDgNWcIWK3YmGOh5eau4GLGKeqCnn+98sEwlfQLl/x7OZZpNW9XQ/CbNZSqLY7N4c7BFG2gtmbJkz6HoDvs2Hizron/kWmcrRHBVexmNtD5VGXOUA/abktvx6uawgsR9eKmW8kC8prtVcZQ77NOE73u4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(2616005)(83380400001)(186003)(38070700005)(7116003)(86362001)(38100700002)(31696002)(2906002)(41300700001)(8936002)(54906003)(5660300002)(478600001)(26005)(76116006)(55236004)(71200400001)(53546011)(6506007)(91956017)(4326008)(6486002)(8676002)(122000001)(66446008)(66556008)(66476007)(64756008)(110136005)(316002)(66946007)(6512007)(45080400002)(6636002)(31686004)(36756003)(334744004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWFCZnlyakRtK0JlQUc2Y0wrYWNidFlONFRMdUdzWWVwMGhuZ2dQTksxY3pK?=
 =?utf-8?B?TVI2MTdNSmxjWHJycGZXeCtpN1B2aFRNR0o3R3FudnVwOStVNHBIZW8wTWdK?=
 =?utf-8?B?c2lkNE13dVpQK2dQd0pEM1lndU9Nek02QWtwUHFnaEJPWVNZM2FLNW1nMURS?=
 =?utf-8?B?anh0anpHU3hRdmwvYkZMTGcrTGVmQk1XTDYzWURyQTZKT0g0bkg0Y04zOENE?=
 =?utf-8?B?aGRQOE9FTDYyVFVwRkN4SjA2Q3IyZWdsS1oxQytVTkorRmlWQXdQSmFFK2w0?=
 =?utf-8?B?b2NpWVdEWStLUDAxQzdLc2tXbUhmaHV6K00wK01UNUJOSnVnajl2dTdyZkFH?=
 =?utf-8?B?Y0hCY1A3TzJhVXNtTUJrSStuM0JrQXFBSWxYVjJoOExMWXBVUjM4dHBMc2l3?=
 =?utf-8?B?NlgvbDBJVlFsUHdEVUVzcFEzNG82VE5TcnhacExRbWZKYXpFME9rczc1SVZv?=
 =?utf-8?B?ZTMxSS80WllzRVhHMDlqRE1xREhwcWp6Vi9vZ0hJU045dDFRaysvMFZDZm5j?=
 =?utf-8?B?Y1FpRlduZCthS1pHL3l4Q2plaC9uSERiRFcrQW5aWnlEUG1FOWZiK2dSQjls?=
 =?utf-8?B?akZVNUVxK2VjN3cwaUphaWpFVEpxK0FEdXdWWlZTZ05LazQ4ZUYvTGYvLzhD?=
 =?utf-8?B?dXp3Wjd0ZzJCUGNQeWNxN2drOUhIdm03NVRVeWFVVXlZWWlqZlE5amNyd0dq?=
 =?utf-8?B?ME8vRVRYZk96SkZrYnVjRmVFUm9hWTJsR1REVHkzWEVWQ2NtT1dBbzlTVmRO?=
 =?utf-8?B?dk84Mkp4amVtTHNaQ001QlBsR1RXMjZLMWdYUCthMjRXTHFDeTNPL2ZlVjRS?=
 =?utf-8?B?VVBnODRMdU5pVEVDK3BWcFRFbFI4Q0RqQVhCOVJ1T1owNDBzSHdxRWxpaWV2?=
 =?utf-8?B?RUFoNVRIV2hMVmZaK0dXeC90YjBkUGxIQmVRKzFrMVpYbXFrTGFCa1NFZlFs?=
 =?utf-8?B?Vm1kTUFIOWxSMFpZYTZvWHNwUGRkU2pDYUxqUC81SU1NcVpkOWVlQjcyb096?=
 =?utf-8?B?dENXVDFkbHdjM1ZTR2JDYWc2dGRNVlQ2MXBXMEg1T05oZFN1WTU2Q2IrZjJ6?=
 =?utf-8?B?WkJtWC9vNWxPRnorMDhBOVp6UjlhTHZlR00xaEJIQWtVSzMvMWlLeGpQWW9M?=
 =?utf-8?B?aTdMZzYrYXJiaVMyM01XS2N5bzBTWk9YdjBwWXlUVFRHU2NDVGpkQTl0ektp?=
 =?utf-8?B?ckhob1J6SVpoTGJwV3pOdk1HVVNIa0s1L1NqM0hyNDh0Z1NWV01xWlNhenZT?=
 =?utf-8?B?WDRCYlV0Nloxb1lGL2ZCdHBNNVN4WmZQaXlkMk9uRWFHUG00YUNCTHVsREp5?=
 =?utf-8?B?T1Nxc056MXVWRWRaZ0xpRU8vVTZIZzgxTXMxYUVOM0kxTkorYmtVVldtTC9z?=
 =?utf-8?B?eTA4Z2g1Q0NUMDlldm1Eb252YUJmOXZ4OTZLTk1KeStFRVV2bHJ0MnV2SkRq?=
 =?utf-8?B?MzV5MlE1ckpmTU1wazZMQlZjN1ZGU29NZXJqSUJRMWZlcENmQThiUDNNSUQw?=
 =?utf-8?B?NmY4SThpcngvQ1Z2SGxwQ0htQ1dLRkQ0R1lJVmg0ZG1jMlcvNnJ5TjZzaFZU?=
 =?utf-8?B?VlMxUWVCU3dXa1hlM1lLdWdrMytrOXR1RFhnNW5rOVg5dFFNNHdueXZpNUFZ?=
 =?utf-8?B?WWM0TUdYOEhJOGVGdk43T2F3MncrVjFVU0dOekdrMngvM2RQRjd1OGg0TUdB?=
 =?utf-8?B?SWVxd3RaUjJsR2J0U291MmxRY2kwUnFnOTF0TFZ3RE1tb0UzMXFTK1RhSi83?=
 =?utf-8?B?dWlQRkp5ZXBJVW5pODNxNHdVeGJ0YnhzamFsYUxtRFVueDVCU204MElnbkc1?=
 =?utf-8?B?YVRqUTZ3eGZkcUkrRnh2TTJMT3BhcGtyeUpLQjI1TjgxLzdGWEdVK1pXQ1pY?=
 =?utf-8?B?RThEbW40d2FwbmdRMm10NDBMZjRrWlN1OTN2alpsZGx1TFE5cG5WeUN6YnFO?=
 =?utf-8?B?Mk8vaDhiOWxaMm96cWRlc25IWXNXNTlnN0VkVUxtNW03TGFsQ0hQenpUSk8r?=
 =?utf-8?B?enVpQ0lkVEEyT2dFV2ZGY0hIbFVrZGRVWDluTkVmU2RsczVNbGVYRmErNEox?=
 =?utf-8?B?eUdoRmhxQXg3eThHY2s5em5odEJlN0JyNzBjN3RISURqNDJpdmJKc1pWeHFM?=
 =?utf-8?Q?Fi+oEp38sdsUabSXYQSz9ENm8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F15A4FECDE7D4B49B523180274816229@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4664eaf-7e05-4901-8f35-08dab6c7279d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 20:26:10.5262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iA4xZJYVuEIjxWMIMdDq8oP/G/1qAVzpfopw6FnqiAOUZ8GMAztqmxq11KWQQpyGVRrA+3CGX7kXpW8S/oen9qNJEwJyk8FIKF2+HmYME38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7291
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTWljaGFlbCwNCg0KT24gMjQvMTAvMjIgMTk6MjQsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+
IEhpLA0KPg0KPiBJJ20gdXNpbmcgdGhlIFdJTEMxMDAwIHdpZmkgY2hpcCBpbiBTRElPIG1vZGUg
YW5kIHdpdGggTmV0d29ya01hbmFnZXINCj4gd2hpY2ggc2VlbXMgdG8gYmUgcHJvYmluZyB0aGUg
bmV0d29yayBpbiB0aGUgYmFja2dyb3VuZC4gV2hhdCBJIGFtDQo+IHNlZWluZyBpcyBhIGtlcm5l
bCBvb3BzIHdoaWxlIHByb2Nlc3NpbmcgdGhlIHdvcmtxdWV1ZS4NCj4NCj4gVGhpcyBpcyBvbiBh
IGtlcm5lbCA1LjE1Ljc0LCBidXQgaXQgYWxzbyBoYXBwZW5zIHdpdGggdGhlIGxhdGVzdCBuZXh0
LA0KPiBidXQgbm90IHRoYXQgb2Z0ZW4gLSBJIGd1ZXNzIGR1ZSB0byBhIGRpZmZlcmVudCB0aW1p
bmcuDQo+DQo+IE15IHJlZHVjZWQgc3RlcHMgdG8gcmVwcm9kdWNlIGFyZSB0aGUgZm9sbG93aW5n
Og0KPiAgICAkIHdoaWxlIHRydWU7IGRvIGlmY29uZmlnIHdsYW4wIHVwOyBpdyBkZXYgd2xhbjAg
c2NhbiAmIFwNCj4gICAgICAgIGlmY29uZmlnIHdsYW4wIGRvd247IGRvbmUNCg0KSXQgbG9va3Mg
bGlrZSBhIHRpbWluZyBpc3N1ZS4gRHVyaW5nIHRoZSBleGVjdXRpb24gb2YgYWJvdmUgc3RlcHMs
IEkgDQpvYnNlcnZlZCB0aGF0IG1vc3Qgb2YgdGhlIHRpbWUsIHRoZSBpbnRlcmZhY2UgZG93biBj
b21tYW5kIGlzIGV4ZWN1dGVkIA0KYmVmb3JlIHRoZSBzY2FuIGNvbW1hbmQuIEEgZmV3IHRpbWVz
LCB0aGUgc2NhbiBjb21tYW5kIGlzIGV4ZWN1dGVkIA0KYmV0d2VlbiBpbnRlcmZhY2UgdXAgYW5k
IGRvd24uDQoNCj4NCj4gQWZ0ZXIgYSB3aGlsZSBJJ2xsIGdldCB0aGUgZm9sbG93aW5nIHNwbGFz
aDoNCj4NCj4gWyAgNDg3Ljk1NTMyNl0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDAwDQo+IFsg
IDQ4Ny45NTUzNjNdIE1lbSBhYm9ydCBpbmZvOg0KPiBbICA0ODcuOTU1MzY2XSAgIEVTUiA9IDB4
OTYwMDAwMDQNCj4gWyAgNDg3Ljk1NTM3MF0gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwp
LCBJTCA9IDMyIGJpdHMNCj4gWyAgNDg3Ljk2NTkzOV0gRlcgbm90IHJlc3BvbmRpbmcNCj4gWyAg
NDg3Ljk3MTAzM10gICBTRVQgPSAwLCBGblYgPSAwDQo+IFsgIDQ4Ny45NzEwMzldICAgRUEgPSAw
LCBTMVBUVyA9IDANCj4gWyAgNDg3Ljk3MTA0M10gICBGU0MgPSAweDA0OiBsZXZlbCAwIHRyYW5z
bGF0aW9uIGZhdWx0DQo+IFsgIDQ4Ny45NzEwNDddIERhdGEgYWJvcnQgaW5mbzoNCj4gWyAgNDg3
Ljk3MTA1MF0gICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDA0DQo+IFsgIDQ4Ny45NzEwNTNdICAg
Q00gPSAwLCBXblIgPSAwDQo+IFsgIDQ4Ny45NzEwNTldIHVzZXIgcGd0YWJsZTogNGsgcGFnZXMs
IDQ4LWJpdCBWQXMsIHBnZHA9MDAwMDAwMDA0OTdiMDAwMA0KPiBbICA0ODcuOTcxMDY2XSBbMDAw
MDAwMDAwMDAwMDAwMF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIHA0ZD0wMDAwMDAwMDAwMDAwMDAw
DQo+IFsgIDQ4Ny45NzEwODVdIEludGVybmFsIGVycm9yOiBPb3BzOiA5NjAwMDAwNCBbIzFdIFNN
UA0KPiBbICA0ODcuOTcxMDk0XSBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gWyAgNDg3Ljk3MTEwNF0g
Q1BVOiAxIFBJRDogOSBDb21tOiBrd29ya2VyL3U4OjAgTm90IHRhaW50ZWQgNS4xNS43NC0wMDAx
My1nMmQ1ODk3Y2IxMmVmICMxMzANCj4gWyAgNDg3Ljk3MTExM10gSGFyZHdhcmUgbmFtZTogTlhQ
IGkuTVg4TU5hbm8gRERSM0wgRVZLIGJvYXJkIChEVCkNCj4gWyAgNDg3Ljk3MTEyMl0gV29ya3F1
ZXVlOiBXSUxDX3dxIGhhbmRsZV9yY3ZkX250d3JrX2luZm8NCj4gWyAgNDg4LjAzNTM3N10gd2ls
YzEwMDBfc2RpbyBtbWMxOjAwMDE6MTogY2hpcGlkICgwMDEwMDNhMCkNCj4gWyAgNDg3Ljk3MTA4
NV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6DQo+IFsgIDQ4OC4wNDExODBdIDk2MDAwMDA0IFsjMV0g
U01QDQo+IFsgIDQ4OC4wNDExODZdIHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1V
QU8gLVRDTyAtRElUIC1TU0JTIEJUWVBFPS0tKQ0KPiBbICA0ODguMDQxMTk2XSBwYyA6IGhhbmRs
ZV9yY3ZkX250d3JrX2luZm8rMHg3Yy8weGM0DQo+IFsgIDQ4OC4wNDEyMDhdIGxyIDogaGFuZGxl
X3JjdmRfbnR3cmtfaW5mbysweDcwLzB4YzQNCj4gWyAgNDg4LjA0OTEyOF0gd2lsYzEwMDBfc2Rp
byBtbWMxOjAwMDE6MTogaGFzX3RocnB0X2VuaDMgPSAxLi4uDQo+IFsgIDQ4OC4wNTcyNzNdIHNw
IDogZmZmZjgwMDAwYTIwYmQ3MA0KPiBbICA0ODguMDU3Mjc3XSB4Mjk6IGZmZmY4MDAwMGEyMGJk
NzAgeDI4OiAwMDAwMDAwMDAwMDAwMDAwIHgyNzogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICA0ODgu
MDU3Mjg5XSB4MjY6IGZmZmYwMDAwMDAxMTg0NzAgeDI1OiBmZmZmMDAwMDA1MDU5ZDA1IHgyNDog
ZmZmZjAwMDAwZGU5NGQzMA0KPiBbICA0ODguMDU3Mjk5XSB4MjM6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gWyAgNDg4LjA2MjY3MF0gd2lsYzEwMDBfc2RpbyBtbWMxOjAwMDE6MSB3bGFuMDogQ2hpcElE
IFsxMDAzYTBdIGxvYWRpbmcgZmlybXdhcmUgW2F0bWVsL3dpbGMxMDAwX3dpZmlfZmlybXdhcmUt
MS5iaW5dDQo+IFsgIDQ4OC4wNzA0MThdICB4MjI6IGZmZmYwMDAwMDUwNTlkMDAgeDIxOiAwMDAw
MDAwMDAwMDAwMDAwDQo+IFsgIDQ4OC4wNzA0MjhdIHgyMDogZmZmZjAwMDAwZGU5NGQwMCB4MTk6
IGZmZmYwMDAwMGRlOTRkMjggeDE4OiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgIDQ4OC4wNzA0NDBd
IHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMDAgeDE1OiBhNDI3MDAw
MGE0MDMwMDAxDQo+IFsgIDQ4OC4wNzA0NTBdIHgxNDogMDEwMTAyZjI1MDAwMThkZCB4MTM6IDAw
MThkZDAwMDAwMTAwMDIgeDEyOiAwNTQ2MDAwMDAwMDAwMDAwDQo+IFsgIDQ4OC4wNzA0NjFdIHgx
MTogMDAwMDAwMDAwMDAwMDAwMCB4MTA6IDAwMDAwMDAwMDAwMDAwMDAgeDkgOiBmZmZmODAwMDA4
YWQ5MmEwDQo+IFsgIDQ4OC4xNTA2NDRdIHg4IDogZmVmZWZlZmVmZWZlZmVmZiB4NyA6IDAwMDAw
MDAwMDAwMDAwMTggeDYgOiBmZmZmMDAwMDA2M2U4OGMwDQo+IFsgIDQ4OC4xNTc3OTldIHg1IDog
MDAwMDAwMDAwMDAwMDAwMCB4NCA6IDAwMDAwMDAwMDAwMDAwMDMgeDMgOiAwMDAwMDAwMDAwMDAw
MDAwDQo+IFsgIDQ4OC4xNjQ5NDddIHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6IDAwMDAwMDAw
MDAwMDAwMDEgeDAgOiAwMDAwMDAwMDAwMDAwMDAxDQo+IFsgIDQ4OC4xNzIwOTVdIENhbGwgdHJh
Y2U6DQo+IFsgIDQ4OC4xNzQ1NDhdICBoYW5kbGVfcmN2ZF9udHdya19pbmZvKzB4N2MvMHhjNA0K
PiBbICA0ODguMTc1NDAwXSBGVyBub3QgcmVzcG9uZGluZw0KPiBbICA0ODguMTc4OTI3XSAgcHJv
Y2Vzc19vbmVfd29yaysweDFlYy8weDQ4Yw0KPiBbICA0ODguMTc4OTQxXSAgd29ya2VyX3RocmVh
ZCsweDE3MC8weDU2NA0KPiBbICA0ODguMTc4OTQ4XSAga3RocmVhZCsweDEyOC8weDEzYw0KPiBb
ICA0ODguMTc4OTU5XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4gWyAgNDg4LjE4NTI4MF0g
Rlcgbm90IHJlc3BvbmRpbmcNCj4gWyAgNDg4LjE4NTk1OF0gQ29kZTogOTQxNWVhOGUgYjQwMDAw
NjAgMzk0MDA0MDEgMzUwMDAyMDEgKGY5NDAwMmEzKQ0KPiBbICA0ODguMTkyMDQyXSBGVyBub3Qg
cmVzcG9uZGluZw0KPiBbICA0ODguMTkyOTU3XSAtLS1bIGVuZCB0cmFjZSBmYTkxNWRjODQwY2Yw
MzU1IF0tLS0NCj4gWyAgNDg4LjE5OTcwMF0gRlcgbm90IHJlc3BvbmRpbmcNCj4gWyAgNDg4LjIw
NTYwMV0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIGV4Y2VwdGlvbg0K
PiBbICA0ODguMjA1NjA4XSBTTVA6IHN0b3BwaW5nIHNlY29uZGFyeSBDUFVzDQo+IFsgIDQ4OC4y
MDU2MzBdIEtlcm5lbCBPZmZzZXQ6IGRpc2FibGVkDQo+IFsgIDQ4OC4yMDU2MzRdIENQVSBmZWF0
dXJlczogMHgwMDAwMjAwMSwyMDAwMDg0Ng0KPiBbICA0ODguMjA1NjQyXSBNZW1vcnkgTGltaXQ6
IG5vbmUNCj4NCj4gSW4gaGFuZGxlX3JjdmRfbnR3cmtfaW5mbygpIHNjYW5fcmVxLT5zY2FuX3Jl
c3VsdCBpc24ndCB2YWxpZCBhbnltb3JlLA0KPiBhbHRob3VnaCBpdCBkb2Vzbid0IGNvbnRhaW4g
TlVMTC4gVGh1cyB0aGUgZHJpdmVyIGlzIGNhbGxpbmcgaW50byBhDQo+IGJvZ3VzIGZ1bmN0aW9u
IHBvaW50ZXIuIFRoZXJlIHNlZW1zIHRvIGJlIG5vIGxvY2tpbmcgYmV0d2VlbiB0aGUNCj4gYXN5
bmNocm9ub3VzIGNhbGxzIHdpdGhpbiB0aGUgd29ya3F1ZXVlICh3aWxjX2VucXVldWVfd29yaygp
KSBhbmQgd2hlbg0KPiB0aGUgaW50ZXJmYWNlIGlzIGRpc2FibGVkICh3aWxjX2RlaW5pdCgpKS4g
d2lsY19kZWluaXQoKSB3aWxsIGZyZWUgdGhlDQo+IGhvc3RfaWZfZHJ2IG9iamVjdCB3aGljaCBt
aWdodCBzdGlsbCBiZSB1c2VkIHdpdGhpbiB0aGUgd29ya3F1ZXVlDQo+IGNvbnRleHQuDQoNCg0K
UGxlYXNlIHRyeSB0aGUgYmVsb3cgY29kZSBjaGFuZ2VzIHdpdGggeW91ciB0ZXN0IHNldHVwIGVu
dmlyb25tZW50Lg0KDQoNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxj
MTAwMC9oaWYuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L2hpZi5jDQpAQCAtNDk1LDEyICs0OTUsMTggQEAgc3RhdGljIHZvaWQgaGFuZGxlX3JjdmRfbnR3
cmtfaW5mbyhzdHJ1Y3QgDQp3b3JrX3N0cnVjdCAqd29yaykNCiDCoHsNCiDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgaG9zdF9pZl9tc2cgKm1zZyA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgDQpo
b3N0X2lmX21zZywgd29yayk7DQogwqDCoMKgwqDCoMKgwqAgc3RydWN0IHdpbGNfcmN2ZF9uZXRf
aW5mbyAqcmN2ZF9pbmZvID0gJm1zZy0+Ym9keS5uZXRfaW5mbzsNCi3CoMKgwqDCoMKgwqAgc3Ry
dWN0IHdpbGNfdXNlcl9zY2FuX3JlcSAqc2Nhbl9yZXEgPSANCiZtc2ctPnZpZi0+aGlmX2Rydi0+
dXNyX3NjYW5fcmVxOw0KK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgaG9zdF9pZl9kcnYgKmhpZl9kcnYg
PSBtc2ctPnZpZi0+aGlmX2RydjsNCivCoMKgwqDCoMKgwqAgc3RydWN0IHdpbGNfdXNlcl9zY2Fu
X3JlcSAqc2Nhbl9yZXE7DQogwqDCoMKgwqDCoMKgwqAgY29uc3QgdTggKmNoX2VsbTsNCiDCoMKg
wqDCoMKgwqDCoCB1OCAqaWVzOw0KIMKgwqDCoMKgwqDCoMKgIGludCBpZXNfbGVuOw0KIMKgwqDC
oMKgwqDCoMKgIHNpemVfdCBvZmZzZXQ7DQoNCivCoMKgwqDCoMKgwqAgaWYgKCFoaWZfZHJ2IHx8
ICFoaWZfZHJ2LT51c3Jfc2Nhbl9yZXEuc2Nhbl9yZXN1bHQpDQorwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIGRvbmU7DQorDQorwqDCoMKgwqDCoMKgIHNjYW5fcmVxID0gJmhpZl9k
cnYtPnVzcl9zY2FuX3JlcTsNCisNCiDCoMKgwqDCoMKgwqDCoCBpZiAoaWVlZTgwMjExX2lzX3By
b2JlX3Jlc3AocmN2ZF9pbmZvLT5tZ210LT5mcmFtZV9jb250cm9sKSkNCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0ID0gb2Zmc2V0b2Yoc3RydWN0IGllZWU4MDIxMV9tZ210
LCANCnUucHJvYmVfcmVzcC52YXJpYWJsZSk7DQogwqDCoMKgwqDCoMKgwqAgZWxzZSBpZiAoaWVl
ZTgwMjExX2lzX2JlYWNvbihyY3ZkX2luZm8tPm1nbXQtPmZyYW1lX2NvbnRyb2wpKQ0KQEAgLTE1
NzQsNiArMTU4MCw5IEBAIHZvaWQgd2lsY19uZXR3b3JrX2luZm9fcmVjZWl2ZWQoc3RydWN0IHdp
bGMgKndpbGMsIA0KdTggKmJ1ZmZlciwgdTMyIGxlbmd0aCkNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuOw0KIMKgwqDCoMKgwqDCoMKgIH0NCg0KK8KgwqDCoMKgwqDCoCBp
ZiAoIWhpZl9kcnYtPnVzcl9zY2FuX3JlcS5zY2FuX3Jlc3VsdCkNCivCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybjsNCisNCiDCoMKgwqDCoMKgwqDCoCBtc2cgPSB3aWxjX2FsbG9j
X3dvcmsodmlmLCBoYW5kbGVfcmN2ZF9udHdya19pbmZvLCBmYWxzZSk7DQogwqDCoMKgwqDCoMKg
wqAgaWYgKElTX0VSUihtc2cpKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47DQoNClRoZSBhYm92ZSBjaGFuZ2VzIHNob3VsZCBhdm9pZCB0aGUga2VybmVsIGNyYXNoIGV4
Y2VwdGlvbi4NCg0KDQo+IEJUVywgaWdub3JlIHRoZSAiRlcgbm90IHJlcHNvbmRpbmciIGZvciBu
b3csIHRoYXQgc2VlbXMgdG8gYmUgYQ0KPiBkaWZmZXJlbnQgcHJvYmxlbS4NCg0KIkZXIG5vdCBy
ZXNwb25kaW5nIiBsb2cgaW5kaWNhdGVzIHRoZSBjaGlwIHNsZWVwIGNvbW1hbmQgZmFpbHVyZSBm
cm9tIA0KSG9zdCB0byB0aGUgRlcuIEl0J3MgYSB0ZW1wb3JhcnkgZmFpbHVyZSBsb2cgZm9yIHNw
ZWNpZmljIGNvbW1hbmQuIA0KRHVyaW5nIHRoZSBkZS1pbml0IHByb2Nlc3MsIHRoaXMgbG9ncyBp
cyBvZnRlbiBvYnNlcnZlZC4gSUlSQywgdGhlcmUgd2FzIA0KYSBjaGFuZ2UgaW4gdGhlIGxhdGVz
dCBkcml2ZXIgdGhhdCByZWR1Y2VkIGl0cyBmcmVxdWVuY3kgYnV0IEkgYW0gdW5hYmxlIA0KdG8g
cmVjYWxsIHRoZSBleGFjdCBjaGFuZ2UuDQoNClJlZ2FyZHMsDQpBamF5DQoNCg==
