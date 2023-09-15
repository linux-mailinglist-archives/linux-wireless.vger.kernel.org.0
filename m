Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC487A2415
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjIORAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjIOQ7x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 12:59:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B4C2721
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694797180; x=1726333180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K1J0XBlk5tRMO3ONOnq6yLr60JBblsgGR81zW74yKDI=;
  b=uR/Sk2y+eWb5EgUz4w0JJzLwl20CcLLHflB3vmAAadoviiROAhNF083v
   9Z45Ie0xVHAA1z9CEtS2wE7Ay2BL8nb5c9V22Qnx71PnQFycM7eWo3J/7
   9UNsEJuk02LF5Z1NvsyupVUNB4DNs2tnbkJq3nu823XnOD4zYwSnJhkPN
   xoj3KcHuASzbeoJoL+tLLLVi0PAB82Cf2z9mnbaVdYxvwlpFfA/OtHKc7
   H4pfl+ME+KKUCWL00eVxMPD4ZCR1shs7GUdzylbKHWju5JVROsxzmFkpG
   NQ+jU8RHWQLXBsUE7NleTPnrK/GIqWhk0SgPHMKHlMp3g8Gq8QmDkYBEm
   w==;
X-CSE-ConnectionGUID: i38QrDgMQeCxhDGZhEdofQ==
X-CSE-MsgGUID: 0Bc6T9+wRvKAIl+xpzdvpw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="4780809"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 09:59:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 09:59:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 15 Sep 2023 09:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqxoQWeh7FkFY4+n83Mz44YMUIqTLNmZdfAt2oNgTPjWKc7X+Bhz5a+PK3aN0heNuGtj+XoTiipZlaXAE7/wJrqYWHPau1vNmqZ0EcDEkh5mXoebIlmXGXaQ5FoaAvhWW23LT9zeg8y+RtYpJNJsujPGpjpIQlm9SaTeyuPQilSjhLKPpvgT+BcYIYHZq/IaD6iDElv+7yReywAj+4GrPA9G8zTiCAZosU+MotTfRm5/E8WToVGcBXnTQaMZGX3e8qaNrlkuSch++fqZnjGONmrWadLTzfoasBoYP2KpuyL4oDvdxEhDoMN4oEhRCrlaNF55m9Q8yVsqpGCXtpLI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1J0XBlk5tRMO3ONOnq6yLr60JBblsgGR81zW74yKDI=;
 b=W35+q9//oF8dQ1TLse1m17tEfkv40wDvn1ITSPqJA+h/nE6OiUJSW7ggfzwgEywmLxT6o5u0PBEK3jA4kQELlzSCzyv0kUtnqNee/s0V3+6kNDqXB3wLzt1B6llSxonNX4vfLU05X6w1lRlYujfzzYJVfmm53uJuUKmWLbQV2B5/JkUwblBUvBXyuSOFQWesExzk6WkYXCsX/yGAIGWFbIjhNrQWzCxM4EI3tnIIjppFc9Feef4EPsJZyBeksZkPTHewpgQckjiWn2d34cYxuqKB992n84gBVg+S0Du/Wwspx4uxMUdGuwBrzdV6leiJwqXj9Gz1THA9geAAC6KgsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1J0XBlk5tRMO3ONOnq6yLr60JBblsgGR81zW74yKDI=;
 b=uk6LLLwXpS9CY1OsIeBP42AKa4w3kohGfVnd/BW7ceduvRhBs+StePgtlPVZ6Fg02ISoMGc/GabwkIFkW+4umM4Yxoxp7xFBtbUqiNNY/UK+nAZrWMX4RTnDRaQsUE88gGceeUhV6vDCQD7pt30uSYZJ9gax2XFSyTgNkH+YysI=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 16:59:31 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:59:31 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2] wifi: wilc1000: Added back-off algorithm to balance tx
 queue packets.
Thread-Topic: [PATCH v2] wifi: wilc1000: Added back-off algorithm to balance
 tx queue packets.
Thread-Index: AQHZ0F3puINh0wZcnkmNIQcR+TJOHq/3wtpcgBfc+FaAARk+0IALki0A
Date:   Fri, 15 Sep 2023 16:59:31 +0000
Message-ID: <ef028e36-64cf-4048-8be7-dd73777991f1@microchip.com>
References: <20230816162259.33342-1-prasurjya.rohansaikia@microchip.com>
 <871qfuvwzd.fsf@kernel.org>
 <DM4PR11MB633677755A94860F2E1B6449F4EEA@DM4PR11MB6336.namprd11.prod.outlook.com>
 <87cyytm61p.fsf@kernel.org>
In-Reply-To: <87cyytm61p.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|IA0PR11MB7696:EE_
x-ms-office365-filtering-correlation-id: c27aac8a-0a00-4d4b-4173-08dbb60d2160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mr5C2L0ge37VzAeDw7u91PY45ZxrQyIlk/O/NhI39I1ZFt45A0vC+o9Umn05QKRLhwXDAvSbeOXN6eiyMNaC+CBhDIEYIc/I7c4RIFvDM7P8GYn/gYNrb9iBMa+FOatObuzhPef54OMX7Y7WX4WksjjepUyoh4zNUXsS2mktiWZAIgi8ObkTwHmNr01gHaJ8+zOkajx0XLG8oKmegnN9m2H+yOAgK5lc2Uip02OBFbDuw7KjudTWBfIcI5PzSooTUrnzuKTcdh8F2k6xHyvaQ4pN5ORJEHhnd+qQrFPERlmlP3GpHfXJ+yBZdMILpnzeAlYo/KRM9VXbsCOMb51OJVyK1Hr62y85WaV1O+8iq0nxFoR9juw1pSFjtGXN6fAHiz1l2M9X7543687YKSwBPeMLFYt8weJdIz0bj98Lb9Z11zNI4rL+19fWbGVztSxa5WGabcr6+UGlJsavLX2VX29503jmSAFW2v4JN1MU3didDNmZrNBIE2PzBedvZZBB0KIEDK0F+p4FiCBS5CZsZGkgxeFq8/8ucUYMagDC7zhMzxnFEJWaynxg0GOb/W8Yja20XeC1lYekX2ptL2coYHnP4/yVxp9jRKU9fAe4KysszJ39ybrHVn60Bn5XPV5dTbhuXh/IrJl4+4bh3sY8lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199024)(1800799009)(186009)(4326008)(31686004)(122000001)(6486002)(53546011)(6506007)(71200400001)(86362001)(36756003)(38100700002)(38070700005)(31696002)(316002)(107886003)(478600001)(2616005)(66476007)(83380400001)(8936002)(66446008)(6512007)(91956017)(76116006)(6916009)(2906002)(41300700001)(5660300002)(8676002)(26005)(66946007)(66556008)(54906003)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE5ib1hpaU9zakFrNytMcDE5aGZLU3o4eXd2RUVBTWRZTmpXbE16QWRjT1gr?=
 =?utf-8?B?WC8rb0xOcGtvZmJMcUpUZ1JWaHdFSHZONjlTcFI4ZCs4WWwyN01VKzF3aEla?=
 =?utf-8?B?OU0xcEZzOVVTQisvZjFucnNJREZubTIxZ2MvWlJmcWlVSkFZa2lrVDdGTlN5?=
 =?utf-8?B?WCtRNjh1L3NYRWpOaXpHTW04QW5pbFNsejU1VGZNbktNSVl5aVJDWEIxN0x1?=
 =?utf-8?B?VmxDOUJYc0grZWlJRzFHYlFnRHVUR1VnUVZFZXFuOCtrZUxLK1ErWWJ0MlFV?=
 =?utf-8?B?cHVISmFIMDJ2TlV1b25JdWloZUwyVmZCeXpXdlVZTXlYbmF2aTcwVStUNFpk?=
 =?utf-8?B?NFFiVmJFaWhoVm0ybWxZUW9vekVyWWYrT1N6dTRXY0FTQmJBTkU4eHNSUGRj?=
 =?utf-8?B?OU1zSWFJUUFNYWl0cmZRS290cnJqUVBxc1BUc0k2SEgvd3pNOS9BWENaaVkw?=
 =?utf-8?B?SStRcVdLWms0czhQY2VMWFh5RnpLOEY5Ym44T2l0RDJuN3BWb2czVW00aFow?=
 =?utf-8?B?WkV3Sk1WQ3YwL0lwb1NiQ1dsYTAybGtkNlc5ak5YZnFLdzJXSEVNbmpuZmNi?=
 =?utf-8?B?ZnZONGRWT21lNEkvL0JKV1VHdFgzQ2l1RCszYW4wRS9EWEVDS2Q1QmlJS3VF?=
 =?utf-8?B?SlVNWUF3NngzbXU4QVVoWGhsT0lJQUh3dDNjTWpaZGhTblhyWjMrZTZoamVl?=
 =?utf-8?B?WkVHajRWeDI1Y1RaTGpRbWZhanU0OEZLTXI2S3lPZjhKZXBjUGRhZE5MRkhx?=
 =?utf-8?B?T0FpcktBK2M1K2o5VlJ1ZmFLL21YMFVyaDF1OHc1S3c0VDBIcThkY3lETkVj?=
 =?utf-8?B?dENsejAxWER4b012VHg2OW9WOEJXd0hrL2NIcEkrUGxBRGRjaUtrZVNjamlB?=
 =?utf-8?B?aWoxVDQzbzBuTzVicElHZEtGQnpuQVJ0Z3JtUklUaFVicGRnc0cyU2VXOVla?=
 =?utf-8?B?dW9BMEpZNm9NUjYyOWZlRUl0RU51Z0dER0pGcU5wRFNHa0lXRU1hRHB2bTY0?=
 =?utf-8?B?NS9Fank5MHNHOWxyeGJFdEpaejR1aGp1L1NlTGpEU0ZKSGhHeG9UL2xJOXQ1?=
 =?utf-8?B?MCt6dUx5RlhDNFFIUmNIZktLODVlRVlSUkt1WVhWUmdQUngvM05zVUdOWWtr?=
 =?utf-8?B?Mmg4dVp2N1Q0bU1ldDBzNXQ1L0hDMFJwZXNLZlk5YjkrMXNoWFk0c3JTa2Yv?=
 =?utf-8?B?MjRtdU43a1BxRXJGK3ljVVZOQWplNVZreWpXSmVzWCtlZWVZSXgxYkYwaWFM?=
 =?utf-8?B?RmVpTmVxb2tJK3BKUEk3VzBnc2lyejJEUlNZYkJ4NDA4ZThRdmNPZEpkbE13?=
 =?utf-8?B?SStZeDA1VVlEOGYvKzJJejI1cTNMODZoNENOWnJpQzVla2dabDhHeFpKZm40?=
 =?utf-8?B?WWtDT0tBNkk4c1ZJMFNwWWFJenhSRElGNFBPc3BHZW5LTnk0emJuRWRzOGVG?=
 =?utf-8?B?aG5UOXdOc3hibDdmcmVRb243NXRLcjF4T210cXNyeVFQNWtBbFgwUVFtY2c4?=
 =?utf-8?B?dTJhdzJMa1BtRXcrSjBlSzhsSmEyU1orN3JZU2diS2xDU0c0Nlh6SU5rOTBP?=
 =?utf-8?B?cFVkNFJZazYvMituYXQ3aG1DbnJweEE3TzQ5YjBsZDdhMkJjbjNPOFcyS3FJ?=
 =?utf-8?B?eDBFT01aZERuNUpMQnU0a09hRk9MUE9pK0Y4eTV4QTlOcWpiVDREYUNLdTlx?=
 =?utf-8?B?ZFZHelVYd2NEWnpYaVlmR29ZWVhDVHRORHZZbVFTS1FUTUFtNHJRNUE0Ukxl?=
 =?utf-8?B?b2hUcU1aNWpaSzVNd0N4NXhUUENLbks1bHAwRXFNQkg2WHJWM3FjZGhuYVVv?=
 =?utf-8?B?alozYzFXT1plbnFrYS9mMnVLRThZTXpIb0pFN0NhaFZLeGdMZWs4WXQzTEoz?=
 =?utf-8?B?KzViKzdENDNnblBrdkxyQmNaeFg5NFd5dkVIWVhUck5UYlRFcE10ZFU4SEh6?=
 =?utf-8?B?Wll0SnFXUDQwZGtsS1ZQekdveEVMYUYvdXhYREhnaWI0UmxRZHhxQmhPdDJp?=
 =?utf-8?B?NXcxeXY5REVXWk50K0EyeUtqMlh5dy92YWlYNU00MXczbDJ2WDVubTN2L2R0?=
 =?utf-8?B?S09GM0JrY2lhYXNZdklPV2F6WVN1N3lyNnA4blRSVFZ5R2pGeEJnR3JOdjhJ?=
 =?utf-8?B?OGpFNk9qK2w2UjNXRk84V2ExZjhZNmNGUUlNa1NGMUJBNlRiaWxjYi9hMHVF?=
 =?utf-8?Q?wVh5e5dgVKUVab3rxKGu7oo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31111126D3D61A4C976FCB51C58BA32D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27aac8a-0a00-4d4b-4173-08dbb60d2160
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 16:59:31.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmTrb8ZIzHfU7e4s9Wwz6D3+KgSo5vRJsq0vvSvAQmE8niTOS+Li2hcbtT91Hx8pSeb7uhr2CyF52S/LiYCVIJ4empVOCYz+BgCDyriersW4vjjr29+JU/lRiU+6qiZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDkvOC8yMyAxMzo0OCwgS2FsbGUgVmFsbyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiA8UHJhc3VyanlhLlJvaGFuc2Fpa2lhQG1pY3JvY2hp
cC5jb20+IHdyaXRlczoNCj4gDQo+PiA8UHJhc3VyanlhLlJvaGFuc2Fpa2lhQG1pY3JvY2hpcC5j
b20+IHdyaXRlczoNCj4+DQo+Pj4gRnJvbTogUHJhc3VyanlhIFJvaGFuIFNhaWtpYSA8cHJhc3Vy
anlhLnJvaGFuc2Fpa2lhQG1pY3JvY2hpcC5jb20+DQo+Pj4NCj4+PiBBZGRlZCBhbiBhbGdvcml0
aG0gdG8gYmFja29mZiB0aGUgVHggVGFzayB3aGVuIGxvdyBtZW1vcnkgc2NlbmFyaW8gaXMNCj4+
PiB0cmlnZ2VyZWQgYXQgZmlybXdhcmUuIER1cmluZyBoaWdoIGRhdGEgdHJhbnNmZXIgZnJvbSBo
b3N0LCB0aGUgZmlybXdhcmUNCj4+PiBydW5zIG91dCBvZiBWTU0gbWVtb3J5LCB3aGljaCBpcyB1
c2VkIHRvIGhvbGQgdGhlIGZyYW1lcyBmcm9tIHRoZSBob3N0Lg0KPj4+IFNvIGFkZGVkIGZsb3cg
Y29udHJvbCB0byBkZWxheSB0aGUgdHJhbnNtaXQgZnJvbSBob3N0IHNpZGUgd2hlbiB0aGVyZSBp
cw0KPj4+IG5vdCBlbm91Z2ggc3BhY2UgdG8gYWNjb21vZGF0ZSBmcmFtZXMgaW4gZmlybXdhcmUg
c2lkZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFByYXN1cmp5YSBSb2hhbiBTYWlraWEgPHBy
YXN1cmp5YS5yb2hhbnNhaWtpYUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFsuLi5dDQo+Pg0KPj4+
IC0gICAgICAgICAgICAgfSB3aGlsZSAocmV0ID09IFdJTENfVk1NX0VOVFJZX0ZVTExfUkVUUlkg
JiYgIXdsLT5jbG9zZSk7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgIT0gV0lM
Q19WTU1fRU5UUllfRlVMTF9SRVRSWSkNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgLyogQmFjayBvZmYgZnJvbSBzZW5k
aW5nIHBhY2tldHMgZm9yIHNvbWUgdGltZS4NCj4+PiArICAgICAgICAgICAgICAgICAgICAgICog
c2NoZWR1bGVfdGltZW91dCB3aWxsIGFsbG93IFJYIHRhc2sgdG8gcnVuIGFuZCBmcmVlDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAqIGJ1ZmZlcnMuIFNldHRpbmcgc3RhdGUgdG8gVEFTS19J
TlRFUlJVUFRJQkxFIHdpbGwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICogcHV0IHRoZSB0
aHJlYWQgYmFjayB0byBDUFUgcnVubmluZyBxdWV1ZSB3aGVuIGl0J3MNCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICogc2lnbmFsZWQgZXZlbiBpZiAndGltZW91dCcgaXNuJ3QgZWxhcHNlZC4g
VGhpcyBnaXZlcw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgKiBmYXN0ZXIgY2hhbmNlIGZv
ciByZXNlcnZlZCBTSyBidWZmZXJzIHRvIGJlIGZyZWVkDQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAqLw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICBzZXRfY3VycmVudF9zdGF0ZShUQVNL
X0lOVEVSUlVQVElCTEUpOw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICBzY2hlZHVsZV90aW1l
b3V0KG1zZWNzX3RvX2ppZmZpZXMNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAoVFhfQkFDS09GRl9XRUlHSFRfTVMpKTsNCj4+PiArICAgICAgICAgICAgIH0gd2hp
bGUgKCF3bC0+Y2xvc2UpOw0KPj4NCj4+IFdoeSBub3QgbXNsZWVwX2ludGVycnVwdGlibGUoKT8N
Cj4+DQo+PiBUaGFua3MgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24uIEhvd2V2ZXIsIEkgZGVjaWRl
ZCB0byBwcm9jZWVkIHdpdGgNCj4+IHNjaGVkdWxlX3RpbWVvdXRfaW50ZXJydXB0aWJsZSgpIGFm
dGVyIHRlc3RpbmcgYW5kIEkgd2lsbCByZXN1Ym1pdCB0aGUgcGF0Y2guDQo+IA0KPiBZb3UgbmVl
ZCB0byBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gdGhhbiB0aGF0Lg0KPiANCj4gUGxlYXNlIHF1
b3RlIHlvdXIgZW1haWxzIHByb3Blcmx5IGFuZCBkb24ndCBzZW5kIEhUTUwgZW1haWxzLCBvdXIg
bGlzdHMNCj4gYXV0b21hdGljYWxsIGRyb3AgYWxsIEhUTUwgbWFpbC4NCg0KT2hoLCBzb21laG93
IHRoaXMgY29uZmlndXJhdGlvbiB3YXMgbWlzc2VkIG91dC4gSSBoYXZlIG5vdyB1cGRhdGVkIHRo
ZQ0KZW1haWwgY2xpZW50IGNvbmZpZ3VyYXRpb24uDQoNCkFsc28sIGFwb2xvZ2llcyBJIGRpZG4n
dCBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gZWFybGllci4gVGhlcmUgYXJlIG5vDQpzcGVjaWZp
YyByZWFzb25zIHRvIHVzZSBzY2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGlibGUoKS4gU2luY2UN
CnNjaGVkdWxlX3RpbWVvdXRfaW50ZXJydXB0aWJsZSgpIHdyYXBwZWQgdGhlIHNhbWUgZnVuY3Rp
b25hbGl0eSwNCkkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhbnkgaXNzdWUgaWYgd2UgdXNlIG1zbGVl
cF9pbnRlcnJ1cHRpYmxlKCkgaW5zdGVhZA0KYXMgaXQgYWxzbyBwcm92aWRlcyB0aGUgc2FtZSBm
dW5jdGlvbmFsaXR5Lg0KDQpJIGhhdmUgdGVzdGVkIHdpdGggbXNsZWVwX2ludGVycnJ1cHRpYmxl
KCkgYW5kIGl0cyB3b3JraW5nIGZpbmUgdG9vLiBTbywNCkknbGwgYmUgc3VibWl0dGluZyBhIHBh
dGNoIHVzaW5nIGl0Lg==
