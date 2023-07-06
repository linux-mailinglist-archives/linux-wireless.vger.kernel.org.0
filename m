Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064E7749247
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jul 2023 02:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjGFANQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jul 2023 20:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFANP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jul 2023 20:13:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D09D19A9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Jul 2023 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688602394; x=1720138394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B1Mce9RHXCnuuLmTUl7h9KRAYwM8GCz7ycoAhr9EsbQ=;
  b=aDI3D1q6TootpY+heDKzZNwyzw+zqxO3ZSOL5/Rl3sSPxiNYTANkMvYE
   AnqJkHNNL+1jiECxcP2c+OFXSd8QUoUhJ+msavdbx64HNMzlX1MhY2OdA
   Oy7dKfyuNaaEO4YnppOz78ZBfcSo7CQD0iqdOG2i3JhtEF2Cf9CNHTPTT
   26LotXymCQHgwYNOrftcjCrKi6ToFSclmWVP29glkWwLUYpGDZ5MBMLIt
   q9FbzKJLk/afV6EutOdhg2tSWrhXNbWz8pHNE4kD120999P2XqHdz0ZWs
   DPKs+ijv8jMsiYc9ytzqmAmcaT9CV7bMkwerItthJne4O1hyNCk44heC5
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="160055926"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2023 17:13:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Jul 2023 17:12:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Jul 2023 17:12:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYZGI0AwzHgzTW+fPtnx29IbuX4j3Zk3N99B+dv0Ff3awu6LgLr03n+DBTc0hX/tLWLjlRtp0AGheDh1y1KTeO+fiGcvpSDfEtyDrz98k4hZSeysLrYoT5F36Ap/xBe61qSASFNoQS3RMAyf7p8htpPP1tKENyuLc5rsaLMusgZmFo/RPYhNFscfEVItN5/njQz0+0A51PEuQsNb4Q+1sOvuDcqByDZxTFHvIGnZy1AAZDP1T5b4aKQmSYm9LyqJMsZDYI6xHhOQimFBNznOjeNAQlhZxlgDnjzxB8dw5aGSXzbihlZh3kbjtkmCZty3A+rSWRYeTm8NGz4E1cRajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Mce9RHXCnuuLmTUl7h9KRAYwM8GCz7ycoAhr9EsbQ=;
 b=UvcvmtbgQLtpMuda8numWFl5H9CkvMPk9s+kCuhItLfaGMOF1LUZ2IaUCJcq2j5ktmFFxqwcEDQCyH7TP5S8nOx70z8lu2PGtuxf2Up747yXgG1vqUrMsG6tVtXRyMu7mOxx5ETElgCSy7Fkm47bNLwtVMU/Eo03e6UcZwVxKhPOJ03zxUaca4IGzwdDyW+Zu3VgCW4XBLjd3RBDSqhGUHp+H48/UVpoF1HS+4F0fmp3HduWGNKLSlp50fM5VMA1uTyucexyEUL/T5lXuKeMDNAMHLnIxcu9sH8vZKisDeNbHsF7ILbYDSqpFFDn+fJ50WvPzW+RnZpQ8kb3Ods38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Mce9RHXCnuuLmTUl7h9KRAYwM8GCz7ycoAhr9EsbQ=;
 b=GtO3SAGUi+b7kq5i+AeDenSCndfO7zWOqp6MU9XtGZRmuhU9JqyHICEDOa6f6a5i2UCF01Ff4ED+PfXQeKhMqfxO0s/7TDDfquEkB7mbktP2O2U1Laa3HP5L4UssOFPV4sD20kh28b1vyHcrBvL3fBZ/uyY6mAj3OoQ9ZkvjBPA=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 00:12:33 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::4d70:f7e3:a90b:bab5%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 00:12:32 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kuba@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Topic: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Index: AQHZqvFXCQeDDa3WmUeOqaeAVHEhOa+rsnMAgAA0yYA=
Date:   Thu, 6 Jul 2023 00:12:32 +0000
Message-ID: <5500a007-4e52-f8dc-2535-3baa7decfe52@microchip.com>
References: <20230630012136.1330784-1-ajay.kathat@microchip.com>
 <20230705140338.77896d11@kernel.org>
In-Reply-To: <20230705140338.77896d11@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DM4PR11MB6309:EE_
x-ms-office365-filtering-correlation-id: 06fa7a8c-102d-4c2a-34ff-08db7db5b1b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mGQwQhQk18i8uU1Uj7o5aWfnJYJSqt9ic1OviyogLGgNGWwIsTkyPsxoCTBMqsOAndiTqHDPQTnV893KCAeGrlodWs59rBq5XL98kD5aUTU1TVF/1lvPJtUv/ghc/QJNK1Yh+Q2pjry/d+XxVveHV3ulMhj49pqYBLbSdVLTpC2NyV8FMNnuOJTCpXoQLMTK2sO1oP7hNaCFQm9uuULWLLiGXfDmhbXZYZgMX+kk64O2mjsBsmimLZ2mTh6Ldu7zdR9UCqbJVw0lnz/UrZElis8jIG/qIPWIJ/9Mm1DzJ3+IEgFCnhvKWAyW2ufetEG9pV47Re4bKQXTt0gjy3KPSwhLDN30O/C2+ukUTm5bMrWONPYOoWFIWxJtigHFwhkakWJs9hgGYUMSLkVN7K5Mj+CkoGLV2mmqG64vseJvAxrY0z/G/IS8+7yCwDsGWO/Cafzn2+NvHVU2mxnnE3mFBUzsBSbsTSpD4s/PqO/okMYB8EwFhqDUzaQWqOPVUV2w4zOug4J/erIRdfpcitV92GGZTv2mkgH3/ZItbeSxHtOEr9M+E4RzM9uxFTpncioYxyTOrKiEjWJ1AkggHHnurx5ntdoUqKvCzhpGA/plw7uAjyxj4dqEkPgOiuQL1sIMTOeMYHCwiitWie3suAIBfdUnt155znFBVWLhop8+Ti6bPEn8uCtJPt7vCOpMbjZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(2906002)(36756003)(6506007)(71200400001)(31696002)(38070700005)(186003)(86362001)(107886003)(53546011)(26005)(38100700002)(83380400001)(2616005)(122000001)(6486002)(6512007)(54906003)(478600001)(316002)(4326008)(8936002)(31686004)(41300700001)(8676002)(5660300002)(66446008)(66556008)(76116006)(66946007)(66476007)(64756008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk9KUi8vKzBjUzFPdUo1RFJxSlNjMHFqRmpzelJxMkVKY01oaENnZWxhamlU?=
 =?utf-8?B?TXg3YzhnVm9UWklsbmkvUHI0QWd0WGRDSmRIZmZYbTU2YlQwbGhvcE52b3ZS?=
 =?utf-8?B?dWpXcUgzQXRSZUY4ZXpxWXN5R0FjRUord0dQRXBucHdVOXdqcStSUEVYQmE3?=
 =?utf-8?B?T1JoMDl5V3FKYWZoQ1FEc3JCN3JGNmZsTWpHYlVrQlhZR0YxS1ZXYjVvdmJ3?=
 =?utf-8?B?bzNoeHZ5OWtUMTB3d1M1Nkp4VFpQSlBsV1hRc0V3L3NuRVI1cVNmQ2NtOGt0?=
 =?utf-8?B?S0k4Z2F6UVJRVDNrVkVSbUc5RmVKQXY2a3B6Wnl1cGxhM2hzNWNiYmxaOEJu?=
 =?utf-8?B?MU9DbjhWOEZMODI2NUxpUDdaQW5JbWkrMDRGUDhxMkNrQndSU1M3WnN1eGtq?=
 =?utf-8?B?eVIweUxHQ3ovWU1XZXJES2ZvTitsaThhczhnMms3T1pJcjZYemNteW9FVWo4?=
 =?utf-8?B?WXpuUzE5ODM0OEJ3bUwwK2pNVXJSQ0tnNTFFZlYvYk91Vlk5TzBybDZjZDFC?=
 =?utf-8?B?OS91QUxYd2Q1Yk5uYmZXNk42S3lBbWF5d2R3MkI3UmhvTWJZZmY5ZUE2UWx2?=
 =?utf-8?B?NlVnY1o3UEVxNXZyYTlHanVWZisrOUU0bmRTK1RwSmJ5blZnUkFjQVUzYm5y?=
 =?utf-8?B?cm5DYzVQUmxGcEJzNEM3bTRiZElBM0hwRXMxOTNTeGNtNUFFRkVPd0FzaHoy?=
 =?utf-8?B?Ni9nMDZUa0lSeHJzK0VIR1Z1bHhYU2YrbXVZN1RGLzVQQ1Z0NEpLcEtwMWtV?=
 =?utf-8?B?YXdQUTdRZXNQeEtBUWM1UjNuSzZ0MEhsNzB4bU1BTkJXYnhCWjB1ZDVqeHRl?=
 =?utf-8?B?dEtTY2NvcmxxL1R1a2VsZzFjMXJaZFhYRTFGaEpRY1VoY205V0VoeWVEZ1dr?=
 =?utf-8?B?NWorS2E0cUpJV205OU91bjNUcTJLMzY5RHU4eXlwdUlBamVibTN5enNDclJL?=
 =?utf-8?B?c2hHd1JBZWdNcWl5SncwMUhtWU5qejgwYnFISExnSnB6U2cycDdtQkRCZ3dl?=
 =?utf-8?B?VHowUmlYL2JvSWlDN1Q2SnRQdUs3SUd6S2pBSXd6MG1RclE2NUhqajhJVHUw?=
 =?utf-8?B?WFY0eklNVWR3TWFGOUptUVByQmdxdFpwN0NjWUVJQ0lBVGdvU3BkcS9oOTFv?=
 =?utf-8?B?bytZL1lrUHhCNUZKdjJXNGVPRjRIZVhRQVJsMDVVMWVhK283aXdvc3pjUEhH?=
 =?utf-8?B?cTFack54QkNEN3dGU0JPQTY1dktWMzRCekJkSmpiZWZYT2d3L1ZRSWwyQUZZ?=
 =?utf-8?B?ZGppdkxJVzROa0VHV0xqK3BTNXAxa3NnNjJ1Q1hxK2JVWU9qaDJkdTlHQjZy?=
 =?utf-8?B?UVhnakZqc3JmQ0c5RTlna2NsYUY5TXBYTFhnNWdKaENZU2FuaWJyaHNwZ2RR?=
 =?utf-8?B?ZWdycUNkQVV2cW5EMk1UT3FNc2ZtRTFkcHRHTnVyaVMyMVBRakMydFdmQlQ4?=
 =?utf-8?B?bkErZElSdllmeWZFS05aMzZyeXNTRDdXcUNYMEhsQkxuZm5VejdocVBYRUVJ?=
 =?utf-8?B?alM4TkdHYXlJS0tpOFdaRHJHRUFnTk9CbmVhU0RlRHJacjQvcjdFM25zd0Z3?=
 =?utf-8?B?cVUwRlMrTVV3S2c4dmc4Rk9rU0RHd05PTXRQd3BhQXJ6b2VrSTQ4dWpqcmFG?=
 =?utf-8?B?UytPajRxRnh1VFZNWkIvSVRidlRFczhXRjEydVhlNDh3eHd2SmNGYXNjbUJC?=
 =?utf-8?B?a0VYRnp6aFlJSi9wTzc2Ym9CQzNQY1J4YlAwdXBqWmlCNFRwODdaeU9SeGNI?=
 =?utf-8?B?RGdqZlVmMGhwSzB4KzZQVkpOYWQ2T0UxZmxYTFowTTdTNGJNSy9GbUg4am8z?=
 =?utf-8?B?TTFrV2FJQ3VwangvMk9BamxSU0VIenV2cGU1cDE5aUV2L0VSRjVyR3J2VHVv?=
 =?utf-8?B?ZGQ2VFZhNVZiK1M1QXFoTGVHV2J3TUlLV0tOTGVuRTlVLzlSNk9pai9nK2tD?=
 =?utf-8?B?VFR6NnpRdmhCL0E4Rk4xNUF2L3RieW1vQUdjd2VqNmFjTElsSVBsTlhXQy90?=
 =?utf-8?B?RnFIaklaWmlwZklHaVZNa21PT1ZvZ1plT3N6OTR4eVR6ZmZpZ0NIVzdwT1Bm?=
 =?utf-8?B?K2xrVTliSlByMzVSL3hLb2lBMTFidkR4L0F1ZXRVcnczUHdLNTZ3UmJrMEo0?=
 =?utf-8?Q?eJdzBZj/fNJnK+JMREvQVaHNy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5EF180F5B487747A0F1DABC0EE94527@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fa7a8c-102d-4c2a-34ff-08db7db5b1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:12:32.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2K7nmJk2B5Qq8WHZ4R4vlp4tuIsSCtCahp95lqHCtt3JoVElY0QgXovS/HI2UeA/LjJ0Hqx3LRyRAnX9HMZ14qjJicU/WrGUB/ua3a0zsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiA3LzUvMjMgMTQ6MDMsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwgMzAgSnVuIDIwMjMgMDE6MjI6MzEg
KzAwMDAgQWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IFRvIGlubGluZSB0aGUg
bGludXgtZmlybXdhcmUgcGF0aCB3aXRoIGRyaXZlciwgdGhlIGZpcm13YXJlIHBhdGggaXMgY2hh
bmdlZA0KPj4gZnJvbSAnYXRtZWwnIHRvICdtaWNyb2NoaXAvd2lsYycuIFRoaXMgcGF0aCBjaGFu
Z2Ugd2lsbCBiZSBzdWJtaXR0ZWQgdG8NCj4+ICdsaW51eC1maXJtd2FyZScgYXMgd2VsbC4NCj4g
DQo+IEhvdyBhcmUgeW91IGdvaW5nIHRvIG1ha2UgdGhpcyBiYWNrd2FyZCBjb21wYXRpYmxlPw0K
PiBVc2VycyBhcmVuJ3QgcmVxdWlyZWQgdG8gdXBkYXRlIGxpbnV4LWZpcm13YXJlIGFuZCBrZXJu
ZWwgYXQgdGhlIHNhbWUNCj4gdGltZS4NCg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4N
Cg0KSSB0aGluaywgdGhlIGNoYW5nZXMgYXJlIG5vdCBmdWxseSBjb21wYXRpYmxlIGZvciB1cGdy
YWRpbmcgdGhlIGtlcm5lbA0KYW5kICdsaW51eC1maXJtd2FyZScgaW5kaXZpZHVhbGx5LiBBZnRl
ciB0aGUgZHJpdmVyIGNoYW5nZXMsIHRoZQ0KJ2xpbnV4LWZpcm13YXJlJyB1cGdyYWRlIGlzIG5l
Y2Vzc2FyeS4NCg0KVGhlIGtlcm5lbCBhbmQgJ2xpbnV4LWZpcm13YXJlJyBjYW4gYmUgdXBncmFk
ZWQgaW5kZXBlbmRlbnRseSwgc28gdHdvDQpjb21iaW5hdGlvbnMgYXJlIHBvc3NpYmxlIGZvciB0
aGUgdXBncmFkZS4NCg0KdXBkYXRlZCBkcml2ZXIgOiB1c2VzIG1vZGlmaWVkIHBhdGgobWljcm9j
aGlwL3dpbGMpIHRvIGxvYWQgRlcuDQp1cGRhdGVkICdsaW51eC1maXJtd2FyZSc6IEZXIGZpbGUg
aXMgYXQgbW9kaWZpZWQgcGF0aChtaWNyb2NoaXAvd2lsYykNCg0KMS4gdXBkYXRlZCBkcml2ZXIg
KyBvbGQgJ2xpbnV4LWZpcm13YXJlJyA6IGluY29tcGF0aWJsZQ0KICAtIFRoZSB1cGRhdGVkIGRy
aXZlciB3aWxsIGxvb2sgZm9yIEZXIGZpbGUgaW4gJy9taWNyb2NoaXAvd2lsYycgcGF0aA0Kd2hp
Y2ggaXMgbm90IHByZXNlbnQgaW4gb2xkZXIgJ2xpbnV4LWZpcm13YXJlJy4gVGhvdWdoIHRoZSBp
bnRlcmZhY2UNCmZvcm1hdCBpcyBjb21wYXRpYmxlLCB0aGUgZHJpdmVyIHdpbGwgZmFpbCB0byBs
b2FkIGl0IGJlY2F1c2UgdGhlIGZpbGUNCmlzIG5vdCBwcmVzZW50Lg0KDQoNCjIuIG9sZCBkcml2
ZXIgKyB1cGRhdGVkICdsaW51eC1maXJtd2FyZSc6IGNvbXBhdGlibGUNCiAgLSBBIGxpbmsgaXMg
Y3JlYXRlZCBmcm9tIG5ldyBwYXRoIHRvIG9sZCBGVyBwYXRoIHNvIHRoZSBvbGQgZHJpdmVyDQpz
aG91bGQgYmUgYWJsZSB0byBsb2FkIGZyb20gbGlua2VkIHBhdGguDQoNCkluIG9yZGVyIHRvIGFk
ZHJlc3Mgc2NlbmFyaW8jMSwgYSBmYWxsYmFjayBtZXRob2QgdGhhdCBsb2FkcyB0aGUgRlcgZnJv
bQ0KdGhlIG9sZGVyIHBhdGgoL2F0bWVsKSBjYW4gYmUgYWRkZWQgaW4gdGhlIGRyaXZlci4gSSB0
aGluayB0aGF0IGNoYW5nZQ0Kd2lsbCBtYWtlIGl0IGNvbXBhdGlibGUgZm9yIHNjZW5hcmlvIzEu
DQpQbGVhc2Ugc3VnZ2VzdCwgaWYgdGhlcmUgaXMgYSBnZW5lcmljL3JlY29tbWVuZGVkIGFwcHJv
YWNoIHRvIGhhbmRsZQ0KYmFja3dhcmQgY29tcGF0aWJpbGl0eSBmb3IgRlcgcGF0aCBjaGFuZ2Uu
DQoNClJlZ2FyZHMsDQpBamF5DQo=
