Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7B74928C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jul 2023 02:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGFAXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jul 2023 20:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjGFAXq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jul 2023 20:23:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C119AD
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688603025; x=1720139025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EiP7bl9u/5Yput/4KQntZiqiR77zJRAhC8gwxNRw/UM=;
  b=dNuobFU+IIqI5XdGeDTWdFpaPkOoofB1LJU5JXzTmfFek7M/5T7gPprQ
   /AB14J1FFiw4+RTfoy/uYywZJBj3hqjKJOfxjrPxFFq1X78FeyITe5bbA
   akvt/LoZimRlPxxYsXlHINbR3Ycj23Cojl0qEncTeMZ6rd9MvaTBNctCi
   0AVuw4vu5sK0bsGgVZv/ClIKdd+YaHRjzhM5Ssv/2c8FIlnCcfjB9Vd2f
   QGSfwcS1QYljRH/AWGfKddAdxeaPZ2bHy01lKzmw8nlf92FRdvjZOUA8J
   hqa+kmihRXSF1wmajWgug4Uh6zumu9tDSyRqM2fGTqv2HGW2wOZPThtWj
   w==;
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="233948400"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2023 17:23:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Jul 2023 17:23:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Jul 2023 17:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/XMKLkPPbwMyojMcdULTRDsRBwMazqfsmj3r7QmTGAPyuoGYRduH0aKp6ciMoDWR6ZVs01ekWtKJg7XXwND8tSHqXndITqFHs8AMlWXc4AH39jtw0IF1Zf2lkAbg+v+I5yqpJKqlN77I4XbvQFJUIm1VAIFSeAdNZwNVXfN13+KPsFSGu7Id3r5G6jBbUL2M4Lc0FpmL+mGE/CyI7eG6zTga9k8fVBBs1h93Jo9N9SaIjm9BzemCEvMFRZ5amQYDBrPy4g7UGRMM3yqIxF1BxcvVcxH6Hf9WH8sysfkVVzR9Kr/EkRTeNorAXFaoJ/wTxXP8qFcguwRAMXUbWjvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiP7bl9u/5Yput/4KQntZiqiR77zJRAhC8gwxNRw/UM=;
 b=ifHUzE/LA63eJyO24ZBmOOPFnhnHok3Q9dtnMhQQbU6qNrUcQpFcvp0h3KwXVMp5tCPrXZxAImBRNrsKvGsOUwIGMw9OCjsniSBTCMvEwDkPIbjEYaam+UGVkHxOo8xdEPvKnqBdNbsYH2f/+mpPfDqV0WEWuf5mx6Lo0zn4nh0vyjMQ0PILgDTfxniDH8GO93PcvsUYU4GHVwBiaXGqti3a296CZQ3ymxNUJUNci4WExjx4S1JTck3Er1pLAtnWSdMBVQLR8Yzl9oL4vMGc/Mq50RlUVyVk9FfooakrKKd+yaFOWcJzsWGw4oKNB+7K5nFe9Z6BxLw3amf66gTEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiP7bl9u/5Yput/4KQntZiqiR77zJRAhC8gwxNRw/UM=;
 b=bBL5+S1S+KDOsrenipzetpEwBXWRC39VBDF+ikJ4ynep5YDR+xFIvwu6ahXHweXdViehj70hndws6+DD5FDf99X9qBNjBny/Ksbq50SprPu3QiiN1xoz01sbCCA2Giaq/j2w4tjYpnEc9006gd/2ffONi/GnwuKNSc1+G3kTnxg=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 6 Jul
 2023 00:23:38 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 00:23:38 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-firmware@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] linux-firmware: move wilc firmware to 'microchip/wilc'
Thread-Topic: [PATCH] linux-firmware: move wilc firmware to 'microchip/wilc'
Thread-Index: AQHZqvGGefcKnm2dVE+FaXjeU6nytK+r6lQA
Date:   Thu, 6 Jul 2023 00:23:37 +0000
Message-ID: <b14ed5af-2c4d-dca7-f580-54b258955978@microchip.com>
References: <20230630012333.1331143-1-ajay.kathat@microchip.com>
In-Reply-To: <20230630012333.1331143-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH7PR11MB8035:EE_
x-ms-office365-filtering-correlation-id: c92b915d-03a2-4a38-3095-08db7db73e42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTryFMUpXX6uh62ZsHd0u6Ij6EiIg4nY8qRz2XWhBpnaOi7PKzGRFEa6noNpL7CDQhfzuRz59ZJdYD7K/rDaBJL4FBTfjqQSLI8Xoxo5Ha0/P0uL892Idir9h6AjVZOS14daCq3qsW5+Qt0GNfyB9GxwqgkJksTZv4TRL2RR4fC5RGBvkcvQfkpDvyZwHis/MittI+BK+cEOKSK8oKuk+dG38RPVGS68iRfW9Lb7/ZFW8YIE3lZs1bp5tmJoncHhcfMhHjXz5fsJTgVmNrh9NKk4cAth/vERqU93LB9WCqJ6HKM1jF0qy2V7Lj1mDaxtkQ/mAqVDpDvOUNYzxT8SbVbEkiHHQFzGNucpZJiMnAN14xWzt9a5PjxrXk8N05IzmUWeOjumjvgVPiB9PPOk8AvgtJ6hrV9lQ5cCKQl5PnVFK+/yRGmK16n4XLmAti0b9w/AXSxhHYHd0WbIFKn4M3NNbWjwOpXdo+kfxNTFyFx4dVUuMzig6CLoG8GuGIm5MVbO0lbLkfDgzeZ6ZtZuSNA8QEg69Pf2vpKiPCwiQMzfEIamaT0N8lGXdqrzeGFdwtlLJsQUDpX7ckvD2jNqDeiL+fPBb7URl1cxADzQTRj59Eu9nM2WZWjkHCEegJRZUkqu76mmymGUofoBcM/eyocqeN9aF5/zEqB3GPvGFvU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(31686004)(54906003)(478600001)(6486002)(91956017)(76116006)(2616005)(36756003)(83380400001)(38070700005)(31696002)(71200400001)(86362001)(6512007)(66946007)(6506007)(41300700001)(966005)(107886003)(186003)(2906002)(5660300002)(8676002)(66446008)(122000001)(66556008)(38100700002)(64756008)(8936002)(53546011)(66476007)(6916009)(4326008)(26005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDlPYnNRakZ4cjg5Wk5OWHdBV2FLazhEeFRzbFVsaEFiRlZGWGFOVE1wOVhK?=
 =?utf-8?B?OWtaczc4UDZzZk1TVHkwYzN2YmNFMCtNMFJHaUhJNWJlVUVvUHpvWmVKbzNv?=
 =?utf-8?B?RG1DemYwYk9Pa0hma3BPNkZUTzZ0SXFENHYxRWUzK0QzNUtHRzFmK3N4b2tF?=
 =?utf-8?B?R0hBWFNLc1hOSDhpMGMwRXIwbUtFaWlLMmFQYUVUSDhxK2k2VGRzbTlCdjMr?=
 =?utf-8?B?bkNkTksrRmthUDU2SDVxT3ZXZEkyYmVtRVpoMXg0NWJjcHU0VzJ0eW0wZUp6?=
 =?utf-8?B?ZjE3WnNaSTNML3VJUkRJaEliOE14VVAyVU5ZcDJmWm8rNUN1RVpJQ2JVVmYw?=
 =?utf-8?B?cnBIeGQwOEd1RE9zdXBJYW9kSHVDMFhSbVBNZzIybTFkSlF1dnhQREJJM3ZP?=
 =?utf-8?B?dzl0UGxmVTBDVTRYRHp0T0lvUTUwUXZ4ekRaaFo2d3Myd3pRdzBHaEtUZG9K?=
 =?utf-8?B?SGRqUmI0YVBRQ3V0UGJoMlZ2YWlNdkFPZTlra2dmc0N3ckFQMi84ZEx5SHBo?=
 =?utf-8?B?ZUpoM1cwYkF3eDV5UjlHT04vM01Qbnlha1AyZ0NNOEJwYTYwN1RQOUovbis5?=
 =?utf-8?B?TlpyZnBNUk9RSGtnOUtGNGp4YysvRmxaOWQzTEVLNFc5VWoyT296T3pSa1Fi?=
 =?utf-8?B?RVRkM2RjSXVSam4vaFhLZWJxQlY0ZzF3QUpQY1Z5UFpyaUxzTkUvVlNTR3NY?=
 =?utf-8?B?UVpxb0FGQXd0Ui9NeHJmcTlLTTZpYlFtRzBKTXRWZThaMlFkK2xLb21ETE9t?=
 =?utf-8?B?QWhNRk0xNkRmZlZzcURUVlhxd2R2cjY2N2lCTlhsRG85eVFvQ0VLdnRuc0lO?=
 =?utf-8?B?Vm1iWmQraEZSYTFmT0NOQ0VGOEFJOTVOOUZCc1JJVFdKOHlONlFiTW1CRXdT?=
 =?utf-8?B?aC9RbE1PcEJUNjdERWJqenZjYmR1S3NkLzBQeUJDQXJSU0RNTkM1bVlIL3VU?=
 =?utf-8?B?cTk3WGFrMmI0SE1ScmJDS0VaZDg2L0RUQXVNUzVWZUMyL0tMaU56T1NrQnpi?=
 =?utf-8?B?cFZiVXhWTFFabTZiSnZIVDUyRXEzb25xN1lOS1lwYXNiaThGUWpGekU5RHVy?=
 =?utf-8?B?bTlXVWc0cUl0Y3gzOW5mMFF0NHErRzRnZitSTVlTYUdoYjRhK2dGNTBlTlJX?=
 =?utf-8?B?bU41QlM5anV5QTkwcEVDZ1ZiVDNRZWQxVzQzNks4VXNoYVIvdkhTL0k4cGZv?=
 =?utf-8?B?aEh6K2dHYk0rY1pwMktBTmJkUFplRDRlcGJrNW4wSmowL2t6WUp5djdtdGRy?=
 =?utf-8?B?ZDV2K0pNYzNkankyZExkMWI4cFRweEdWVmQ0VHpQczRMUFlnRUpkRjRJNzVm?=
 =?utf-8?B?RE41OXY3QWlhQ0xOZnV1cWo3U3pMQWk2UTlreWZhNUlDeDdMelVxcDI2MGlV?=
 =?utf-8?B?MTFnVVI3RXQwM21zTVF6b2RjNVhrNDk3aWFYd3lERnd0QnF2L3RMTVZEWEUw?=
 =?utf-8?B?TkFpUm1vNXB2cTh5ZVgvY0NQbjdFQzJGRWNuVjY1YUk0aE9PdEtldW01OUJR?=
 =?utf-8?B?QmJJei8yZ3hRdmFIdkVOSkpkSFhRbnJHMXd5MDJRcWNncS9qRGRuUTBrK1hH?=
 =?utf-8?B?Nkxzb1dOZVhmOHUvLzI1YWJ2dll2NmxSWTdsWkszYTNnSkJOcy9QTGNMeTI1?=
 =?utf-8?B?OWwzY0VKUFYxdlVqMyt4bmc3RjZwSENDV1QrdDl0SzlIZHZvUnNxSFRod2Jr?=
 =?utf-8?B?dTl2NXRwWnFZZDJ4ZHdFL1ljWXZXYlNQVWV3cng1TkE1NExRYlY4ZWhuZCsr?=
 =?utf-8?B?SnBGUkdsYlJraWZnNXJPdjNwTlpZdjR1akdZTThGT1pYdnhPYklmOWNaZHFW?=
 =?utf-8?B?UjcybTZzMTYwMW11dysrL0dRY3NIRThCSldQZ0VMV0tUeFk2QlNuMWlzOEYx?=
 =?utf-8?B?WjZrb0duQ0FOSTF1YlpXdUxZNXRITVovUGtmZyszUmpGaHIyMzN5dFV2a2hJ?=
 =?utf-8?B?NWg1TDJYRTQrd1YvUzVmMDRxNUJ2SXE1OWt1Uk1IRzVENXVYMEZsZnErK29q?=
 =?utf-8?B?UVAxK3lpOE1rcTV3Q3krdmhzbDZsMnI4azdWVWg2d1lsdldjekhIOXE3UFZ2?=
 =?utf-8?B?cFZ4U3NtZGxldlJ4cE1vbVlVMjJjNTFwY3ZLdmxSKzlBeEZFU1ExeFhCSnY2?=
 =?utf-8?Q?VzBIliqwdGoDjcL1/L5uHVIIq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D92C13DBFD10CB43BBE5836AA608C93F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92b915d-03a2-4a38-3095-08db7db73e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:23:37.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dC2bfaDxojGmXoVIB/tUjMATh8dBUkV1wTGtCkMHTCPseB8jmOPOO3tjoa2DC6Fe3S5ttb6XgLDM73eSfIxFWqB2Ds6TGV8L6aqnD5aUy3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

UGxlYXNlIGRvbid0IGFwcGx5IHRoaXMgcGF0Y2gsIHdoaWNoIGhhcyBwYXRoIGNoYW5nZSwgc2lu
Y2UgdGhlIGRyaXZlcg0KY2hhbmdlcyBhcmUgc3RpbGwgaW4gcmV2aWV3Lg0KDQpIZXJlIGlzIHRo
ZSBsaW5rIHRvIHRoZSBkcml2ZXIgcGF0Y2g6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC13aXJlbGVzcy81NTAwYTAwNy00ZTUyLWY4ZGMtMjUzNS0zYmFhN2RlY2ZlNTJAbWljcm9jaGlw
LmNvbS9ULyN0DQoNCk9uY2UgdGhlIGRyaXZlciBjaGFuZ2VzIGFyZSByZXZpZXdlZCBhbmQgYWNj
ZXB0ZWQsIEkgd2lsbCBzZW5kIHRoZQ0KdXBkYXRlZCBwYXRjaCBmb3IgdGhpcyBjaGFuZ2UuDQoN
Cg0KUmVnYXJkcywNCkFqYXkNCg0KT24gNi8yOS8yMyAxODoyMywgQWpheSBTaW5naCB3cm90ZToN
Cj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4gDQo+IE1v
dmUgdGhlIHdpbGMxMDAwIGZpcm13YXJlIGZyb20gJ2F0bWVsJyB0byAnbWljcm9jaGlwL3dpbGMn
IHBhdGguDQo+IFRoZSB1cGRhdGVkIHBhdGggbm90IG9ubHkgaGVscHMgdG8gYXZvaWQgY29uZnVz
aW9uIGZvciB1c2VycyBidXQgYWxzbyBiZQ0KPiB1c2VkIHRvIGtlZXAgbWljcm9jaGlwJ3Mgb3Ro
ZXIgd2lmaSBmaXJtd2FyZSBmaWxlcy4NCj4gDQo+IFRvIG1haW50YWluIGJhY2t3YXJkIGNvbXBh
dGFiaWx0eSwgdGhlIExpbmsgc3RhdGVtZW50IGlzIGFkZGVkIGZvciBleGlzdGluZw0KPiAnYXRt
ZWwnIHBhdGggZmlybXdhcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBamF5IFNpbmdoIDxhamF5
LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIFdIRU5DRSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKysrKysrKysrLQ0KPiAgLi4uL3dp
bGN9L3dpbGMxMDAwX3dpZmlfZmlybXdhcmUtMS5iaW4gICAgICAgICAgICAgIHwgQmluDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gIHJlbmFt
ZSB7YXRtZWwgPT4gbWljcm9jaGlwL3dpbGN9L3dpbGMxMDAwX3dpZmlfZmlybXdhcmUtMS5iaW4g
KDEwMCUpDQo+IA0KPiBkaWZmIC0tZ2l0IGEvV0hFTkNFIGIvV0hFTkNFDQo+IGluZGV4IGU2MzA5
ZWJhLi5mMzhiYzk4MCAxMDA2NDQNCj4gLS0tIGEvV0hFTkNFDQo+ICsrKyBiL1dIRU5DRQ0KPiBA
QCAtNTEzNiw3ICs1MTM2LDcgQEAgRmlsZTogYXRtZWwvd2lsYzEwMDBfZncuYmluDQo+ICBGaWxl
OiBhdG1lbC93aWxjMTAwMF9hcF9mdy5iaW4NCj4gIEZpbGU6IGF0bWVsL3dpbGMxMDAwX3AycF9m
dy5iaW4NCj4gIEZpbGU6IGF0bWVsL3dpbGMxMDAwX3dpZmlfZmlybXdhcmUuYmluDQo+IC1GaWxl
OiBhdG1lbC93aWxjMTAwMF93aWZpX2Zpcm13YXJlLTEuYmluDQo+ICtMaW5rOiBhdG1lbC93aWxj
MTAwMF93aWZpX2Zpcm13YXJlLTEuYmluIC0+IC4uL21pY3JvY2hpcC93aWxjL3dpbGMxMDAwX3dp
ZmlfZmlybXdhcmUtMS5iaW4NCj4gIFZlcnNpb246IDE2LjANCj4gDQo+ICBMaWNlbnNlOiBSZWRp
c3RyaWJ1dGFibGUuIFNlZSBMSUNFTlNFLmF0bWVsIGZvciBkZXRhaWxzDQo+IEBAIC02MzI0LDMg
KzYzMjQsMTIgQEAgVmVyc2lvbjogMTguOTkuMS5wMTU0LjQwDQo+ICBMaWNlbmNlOiBSZWRpc3Ry
aWJ1dGFibGUuIFNlZSBMSUNFTlNFLm54cCBmb3IgZGV0YWlscw0KPiANCj4gIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICsNCj4gK0RyaXZlcjogd2lsYyAtIE1pY3JvY2hpcCB3aXJlbGVzcyBkcml2ZXIN
Cj4gKw0KPiArRmlsZTogbWljcm9jaGlwL3dpbGMvd2lsYzEwMDBfd2lmaV9maXJtd2FyZS0xLmJp
bg0KPiArVmVyc2lvbjogMTYuMA0KPiArDQo+ICtMaWNlbmNlOiBSZWRpc3RyaWJ1dGFibGUuIFNl
ZSBMSUNFTkNFLm1pY3JvY2hpcCBmb3IgZGV0YWlscw0KPiArDQo+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiBkaWZmIC0tZ2l0IGEvYXRtZWwvd2lsYzEwMDBfd2lmaV9maXJtd2FyZS0xLmJpbiBiL21p
Y3JvY2hpcC93aWxjL3dpbGMxMDAwX3dpZmlfZmlybXdhcmUtMS5iaW4NCj4gc2ltaWxhcml0eSBp
bmRleCAxMDAlDQo+IHJlbmFtZSBmcm9tIGF0bWVsL3dpbGMxMDAwX3dpZmlfZmlybXdhcmUtMS5i
aW4NCj4gcmVuYW1lIHRvIG1pY3JvY2hpcC93aWxjL3dpbGMxMDAwX3dpZmlfZmlybXdhcmUtMS5i
aW4NCj4gLS0NCj4gMi4zNC4xDQoNCg==
