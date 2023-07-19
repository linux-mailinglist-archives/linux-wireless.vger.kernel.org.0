Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C604759AA9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGSQVf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGSQVe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 12:21:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59787172E
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689783693; x=1721319693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Js7dyd6lIFYUvCYUe9/0J8ZOkzwyXmtUkrcKu12oXso=;
  b=Y7SHfZ8G7V7FBo8ZD0i8DSeHEHkkb04JGbdUiDP9CtDecQRYI87hBROA
   kKsTJzTXLBC1eNJ51nNOpmRYsgS8PWIQC+dS53GGX4VRFycCU6sKAE94F
   T862cqU5SEDq0ELhB8cC6IusUt/koZPW9LdDoMSGkCpfiC5r3DdefuVji
   dND7QxPVcqZuGmmNtC9SgqPUlEIxBx+pjDqDlV2i0ruzYBSxXCGUn73ex
   RmlZvLLeZ1nAihAWSnKIf3ydehsIN9Jd8Tvjm0MVA0APRsyqZ2U7vtuRj
   T59DQdgGLdH1yHXLT1Ppm1yEJdDjmLK0bO+r4oSaRnNCJtggC1FRrUU5j
   w==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="162174004"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2023 09:21:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 19 Jul 2023 09:20:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 19 Jul 2023 09:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENViFBrUWIc08NyLSdwINZlFDzGl2SNptiaeGylMU5UTodJA3jTxw4LTi4T60EB8QnAcA6jE+bodZv4A9a9iPyBucLtYryztGMLEaUf0KlCJT7WusVDXCLeeqCPOX43FQRdsEKEEguXz2c8UNjIWV07+YswDBjfmcPjrVb+aBR8FQOB5zQR03NQmAbB59HqxIYIwJ/GxJoSlSjpFj88McnWm+ItGZiN2l65WE6KFYdiMBY1050t5HHRi1NRMhoEq5pTTVjZZa0ofbFViiDVCqXUs9oKTuGmgM804MKTf9R6rtvv0ydEySqmMAvNdC4ftl75wcbpy2tI8wpwgNquqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Js7dyd6lIFYUvCYUe9/0J8ZOkzwyXmtUkrcKu12oXso=;
 b=Y3joZetubnnjq7YgIrH/bQCnF/TNnqsgu1I3HwWaY9fVguV/I7aQ3n7npIYcvZyNCwGauQHIZg9LIEFqaC683U3UoHkXlbWiFEu4/dxBSPNzJfpj4dYnDkMedymEui6DdgaJnZPlIe0nnD5AEhv06BTxMIl1gxY4GfXZ/X0tmmYrgv89jIcxmHejLUWNj0Jb4ptwq1ULMQ5THePME4qcSAxXIcinc//DJ+ISrueIHziCUG/Bm5ZRUTUM6gKe0s07CNIrogxbTM3k38x4JQakAfAFz25s82m8iFdKDLn8r8K5zGT7+kNTwnwGpF89FHdQr69fUNHEkUhicbOO8/f1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js7dyd6lIFYUvCYUe9/0J8ZOkzwyXmtUkrcKu12oXso=;
 b=pxtYwg3pLUlosNn37v4VceevGHlFzkXFi/nd2NL9hgBr2n43Y1EYzFcrP9LAJ56vMqkW+QiZOS28csjt/IE8JIynf+OD2e1EDG0CPaXSB+VCG/XjFyyfmNfYvBlm0wMU/hXug9OR0T5GzJ9j6am5I5Z9EePYr03MEkCf1wbCO5k=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 16:20:57 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d2bc:dc06:50ad:3dbd]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d2bc:dc06:50ad:3dbd%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 16:20:57 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@kernel.org>, <kuba@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Topic: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
Thread-Index: AQHZqvFXCQeDDa3WmUeOqaeAVHEhOa+rsnMAgAA0yYCAAARKAIAVGMOUgAApP4A=
Date:   Wed, 19 Jul 2023 16:20:57 +0000
Message-ID: <4aef9340-7b03-43af-f211-c8e45f749e73@microchip.com>
References: <20230630012136.1330784-1-ajay.kathat@microchip.com>
 <20230705140338.77896d11@kernel.org>
 <5500a007-4e52-f8dc-2535-3baa7decfe52@microchip.com>
 <20230705172754.61ca21ae@kernel.org> <87cz0o2nm4.fsf@kernel.org>
In-Reply-To: <87cz0o2nm4.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: e79b0086-162a-4246-32e2-08db8874221e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBL+0qQjGE5QYLYRNvJo6CyVU9RwRrMwi/5bSnCqE4i8nQWp/hHXEYcTNDfO2MINOiI9x/kOHmoLO+smqOpoPrrYVguW9qeWD0MLnqlOgf3gkpLq+86VLfLr3NuNlEdWUO4pM+YQYPAXHXFzejy2aPKH80zmvnhpZaOkaBjiljKpEvPT+d36riSKEqZVdYcs4SkFqj14mIrPhsHY6on6cIKckbuKIDZid8khvjhkmqZo9xwtRAzz/eFolAjNPl+AZgON/RrUmxLy5xfXQw9ujm0YkBkPK9yp7qstlg02piO0+c6zeJPiMJo5pPeZpSqm+QWvzeUKe9OaG8ZY1YGKHJnvBcXnUksdo3c+eRBUekIeHOvVf5CzEZQkXH/775fPQ/UQI9WKEC94lIlDoJDODwRDWIKhdcg8XKoAnb4OdrskFtu52qSFi6NCepjdPAhp3xxNjRg/7wDyaCjKITPhTwk/CD8aLTejs4KCuTg7NjBw3c5wWf6PoVoU2fp+7AUDBiwpqz/7fgy8lM59SA+rRj+Pl7s6nhfxa5oh5LlLLGKYfKOyeyc2aTQgaVnjRfn/zHxqy02ClZNqaAyvXQMgf0lVjACNeOTrGFc+QhOmT0YLOla8VPYl4d8nQ2OG4JMUlcc6cG2gyEKnDlZoes9eDzEjhiOmpwjmNFZ4KvhgtJinKxJB7i/HE6U0bfEagnPb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(54906003)(110136005)(71200400001)(6486002)(122000001)(478600001)(36756003)(5660300002)(2906002)(8676002)(8936002)(86362001)(31696002)(38070700005)(66446008)(4326008)(66476007)(64756008)(38100700002)(76116006)(66946007)(66556008)(91956017)(41300700001)(316002)(2616005)(53546011)(6506007)(26005)(107886003)(186003)(6512007)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWZWZ05RVlpIVFpXblF3TDdoSytORmRlRU45YmpwbDNmZm9KSC9jZE5RdkVm?=
 =?utf-8?B?akxlQ3ZGeEc5N0FUZEV3Z1lhZSs2YVdHVEQ5a1pVb1AxN3Zuek9OSVdGazJq?=
 =?utf-8?B?b2Z5TFJvTlZsclVZTnozQzQrZ0tsQWdaem82RTJIREg1QnF6U29xSlV0RDdr?=
 =?utf-8?B?blNJV2VzYVhVdVYrWXdWZFRDUGVoMnYxUzVmblljOG02SWhGeFZRU0diMVVR?=
 =?utf-8?B?RC9aM3ZDSE9ObmlVMGJIVk85QW1Ebk53am1zYVRxTVNpMzU3a3NRWTdHSFhV?=
 =?utf-8?B?Z0c2THFHbnJZT1VtdzFhMTJIVFhJR3Z3Z2ZIVWtuMTZWTDg1RG1JdEtxeTlx?=
 =?utf-8?B?bS9VaEQrVEV1MmdKVFZQNTJILy96Wkw3K2NVM0xQTTFBenB6K3lIdUxpWkM1?=
 =?utf-8?B?UEkwalh3RHBsbDg0cWVOMTkvMmxaY04zWWRMZlp1dUtVSzV0eXVpV0wwMEo3?=
 =?utf-8?B?cnJNZzB1aFJIejJ5K04wcEpZM2l5VkoycTVIUW95YmZ1ZTBxRlM0ZTAvdGdD?=
 =?utf-8?B?dzd3Zml5Y0FSUFRPMzZUSjQrcVZhRHprRFZMSnk4N2pNVkx3ZjNxV2dTeTI5?=
 =?utf-8?B?RmZqNnhUcHFjanh2dTh3M3ZJWE9HTE4wN2o4aHFjZWFnYjBLd1lkYWN0ZFF3?=
 =?utf-8?B?VHlsNGtEZnpBdzc0M0hVeUErUkZiQTBsVUU1TTlRbGo4bTB0Mll3aWJhS0Mv?=
 =?utf-8?B?eHo0SmhKMklJeExUTHo1N0ZvN21CVUFzS2gyczZqV2R0UkZCa3YrVm9LVDVn?=
 =?utf-8?B?NzNKUUJldWZReHFHaGNaU1ZsSUhqNVJ3N25uSUN5ZzRTSUx0T29YTmZFbHZ2?=
 =?utf-8?B?Q2F1dlBtQy9rRHZmVGFtdHo3UjZsbnVaTVhvUTlvOGJaSjR6NkgxeW42TllY?=
 =?utf-8?B?c05VLzJ6RHJJSndPMmlwbXhNeVBXNkpwYWR4Z0NFTjFqT1dUNTNXNmZTYVVW?=
 =?utf-8?B?TXBWUmRkS0NrMHRXMXJUUlRXN04yMU9ZNnJCNSt2ZVNuSjFGUGoxOEhhOHhl?=
 =?utf-8?B?Z0dFVlBvZGlZZlQ1Z1I3V3FyWC9hdGRZQWJLbkd4Zlh2UzRCT0dqSVY1aFRN?=
 =?utf-8?B?QUhHdEc4QVpTZ0FYSFMvMjBmZkpEZHk5bmFpOEJkTC9CcDRHdmtyTGdHQU5E?=
 =?utf-8?B?eFNLNnhoYmVVRlgrNVl3ckcwSS8vb0dSMFR0RFVyY3FzOUNxM3BnZzQwSlJi?=
 =?utf-8?B?T0Z1OUFnbDVoYlE5VjNTRSswc0l5TkNhck14Yy82NWhjUktJWFBvZE9IN2x3?=
 =?utf-8?B?bGh2ekhBR2tZaVdLZDRYdkZrUEFhaTZxWmMyNVUxbU43b241alBBM1g2Z0RB?=
 =?utf-8?B?V3RHSm0yTFN4ZFBBNjNpZm1JdlpIbWxEZ0trOXBDRDhCcFFSdUNZTkNDcDd0?=
 =?utf-8?B?UlA3RHBwc2FEUGVFdWl0ZmdOZnRKVEZUOTg5Q2dBZW42VEpZZlRnNkQ0emhI?=
 =?utf-8?B?SHh1S1l6TERiUHNYNGlYeXhnZFpxaFRoUktUd25aVWlDaU9uS2gxL0N0Q3pv?=
 =?utf-8?B?THAwYUMrTTh4LzVtaE1JNzlVR2Q4QUhRdm81TFp6Sm1LUWpCNUhvODIyKzR5?=
 =?utf-8?B?eXJ5RVZPRitjSlJTdTNuS1Z0aWNYYmlaUFRHb0M1dW5keUIxN1N6bVMyWCs5?=
 =?utf-8?B?aXFaUGRJSlZDWFU4K04zSE9Sd0hYelg2aEp3WnR0UjRoSXFYbDNxd2VEVC9D?=
 =?utf-8?B?cG5JcnYwU0grWFlFWFdCOTMyT2prRUdpbTQrckp3ZHNiM2lzMjVCTEw5MHVT?=
 =?utf-8?B?THpuUnUxMi9sRXNoZnUxWFN2eC9ibnR0dXZXeE90a2toUWJmeGN4MVIwL1Jn?=
 =?utf-8?B?ZlJFMUh6NFZHZnp0aUFWUVZwanNLdHZFT1RLcnh0OTZzY2FVWDVBcHd3ckxI?=
 =?utf-8?B?UGpNdzhhVmhVZ0RmVHFVZHdXaS9JY25XTnFWNXNHM1lhQTQyWS84cUdNNUtK?=
 =?utf-8?B?c3BsUFdTVUtkdHJjYmlZT3dtK0tSeDh4Rkk2M1JxTHpydFFMOWxkOHdxYVpZ?=
 =?utf-8?B?bWtWQWNYeGFvRU1rK1pSWHE0S2djdHdkelFkZFpBOXRxRFVUbWtWQXIwRnY4?=
 =?utf-8?B?dXg2VFRZWnVrT21GUDd1MHdFUElIc0dDR3dETlRWbzQ1ckVqNHU1UzFTWWw0?=
 =?utf-8?Q?MDhJSGomVbfOXgNAmd6mK21Wj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B13C081739188C46A3EABF57D578D1FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79b0086-162a-4246-32e2-08db8874221e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 16:20:57.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sM3WNkoWVA78W5l9EebRNHFEmnItFOxRlukLawvGiqM7N91Ow9R/Sc6daaHUDnqCCjtlRPAUTYeaPdj8t2ScgrhfcuC7GgaNqib3Pr4od4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNy8xOS8yMyAwMzozNywgS2FsbGUgVmFsbyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPiB3
cml0ZXM6DQo+IA0KPj4+IEluIG9yZGVyIHRvIGFkZHJlc3Mgc2NlbmFyaW8jMSwgYSBmYWxsYmFj
ayBtZXRob2QgdGhhdCBsb2FkcyB0aGUgRlcgZnJvbQ0KPj4+IHRoZSBvbGRlciBwYXRoKC9hdG1l
bCkgY2FuIGJlIGFkZGVkIGluIHRoZSBkcml2ZXIuIEkgdGhpbmsgdGhhdCBjaGFuZ2UNCj4+PiB3
aWxsIG1ha2UgaXQgY29tcGF0aWJsZSBmb3Igc2NlbmFyaW8jMS4NCj4+PiBQbGVhc2Ugc3VnZ2Vz
dCwgaWYgdGhlcmUgaXMgYSBnZW5lcmljL3JlY29tbWVuZGVkIGFwcHJvYWNoIHRvIGhhbmRsZQ0K
Pj4+IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgZm9yIEZXIHBhdGggY2hhbmdlLg0KPj4NCj4+IEkn
bSBhZnJhaWQgeW91IG5lZWQgdG8gcmVxdWVzdCBmcm9tIGJvdGggbmV3IGFuZCBvbGQgcGF0Y2gg
Zm9yIHNvbWUNCj4+IHRpbWUuIFB1c2ggdGhlIGNoYW5nZSB0byBsaW51eC1maXJtd2FyZSwgYnV0
IG1ha2UgZHJpdmVyIGJlIGNvbXBhdGlibGUNCj4+IHdpdGggYm90aCBmb3IgbWF5YmUgdGhyZWUg
ZnVsbCByZWxlYXNlcz8gVGhlbiB0aGUgcmlzayBvZiBzb21lb25lIHN0aWxsDQo+PiBoYXZpbmcg
c3RhbGUgbGludXgtZmlybXdhcmUgZ29lcyBkb3duIHF1aXRlIGEgYml0Lg0KPiANCj4gSSB3b3Vs
ZCBzYXkgYXQgbGVhc3QgbWluaW11bSBvZiB0d28geWVhcnMsIHByZWZlcmFibHkgbW9yZSB0byBt
YWtlIGl0DQo+IHBvc3NpYmxlIHRvIHVwZ3JhZGUga2VybmVsIG9uIExUUyBkaXN0cm8gcmVsZWFz
ZXMuDQo+IA0KPj4gVEJIIHJlbmFtaW5nIEZXIHBhdGhzLCBtdWNoIGxpa2UgcmVuYW1pbmcgZHJp
dmVycyBpcyB1c3VhbGx5IG1vcmUgcmlzaw0KPj4gdGhhbiByZXdhcmQuDQo+IA0KPiBJIGFncmVl
LCBpdCdzIGp1c3QgZXh0cmEgd29yayB3aXRob3V0IG5vIGFjdHVhbGx5IGJlbmVmaXQuIE1heWJl
IGFuDQo+IGV4Y2VwdGlvbiBoZXJlIGlzIGl3bHdpZmksIHRoYXQgc2hvdWxkIGJlIGZpeGVkIGFz
IHRoYXQgY2x1dHRlcnMgdGhlIHRvcA0KPiBsZXZlbCBmaXJtd2FyZSBkaXJlY3Rvcnkgd2l0aCBk
b3plbnMgb2YgZmlsZXM6DQo+IA0KDQpEZWZpbml0ZWx5LCB0aGlzIGNoYW5nZSB3aWxsIG5vdCBo
YXZlIGFueSBmdW5jdGlvbmFsaXR5IGltcHJvdmVtZW50cy4gSXQNCndpbGwganVzdCBoZWxwIHRv
IG9yZ2FuaXplIHRoZSB3aWxjIGZpcm13YXJlIGRpcmVjdG9yeSBzdHJ1Y3R1cmUuDQoNCkN1cnJl
bnRseSwgb25seSB3aWxjMTAwMCBmaXJtd2FyZXMgYXJlIHByZXNlbnQgaW4gbGludXgtZmlybXdh
cmUgYnV0IHRoZQ0Kd29yayB0byBzdXBwb3J0IHdpbGMzMDAwIGFuZCB3aWxjJ3MgbmV4dC1nZW4g
ZGV2aWNlIGlzIGluIHByb2dyZXNzLiBUaGUNCmV4aXN0aW5nIHdpbGMgZHJpdmVyIHdpbGwgYmUg
ZXh0ZW5kZWQgYW5kIHRoZSBuZXcgZmlybXdhcmUgZmlsZXMgbmVlZHMNCnRvIGJlIGFkZGVkIHRv
IGxpbnV4LWZpcm13YXJlLiBBZnRlciB0aGlzIGNoYW5nZSwgdGhlIGFsbCBmaXJtd2FyZSdzIGNh
bg0Kb3JnYW5pemVkIHVuZGVyIHNhbWUgcm9vdCBkaXJlY3Rvcnkgc2luY2UgYWRkaW5nIGEgbmV3
IGRldmljZSBmaXJtd2FyZSdzDQp1bmRlciAnYXRtZWwnIGZvbGRlciBtYXkgbm90IG1ha2Ugc2Vu
c2UuDQoNCkFsdGVybmF0aXZlbHksIHRoZSBuZXcgZGV2aWNlIGZpcm13YXJlKGUuZyB3aWxjMzAw
MCkgY2FuIGJlIGFkZGVkIHRvDQonL21pY3JvY2hpcC93aWxjJyB3aXRob3V0IGNoYW5naW5nIHdp
bGMxMDAwIGZpcm13YXJlIHBhdGguIElzIHRoaXMNCmFwcHJvYWNoIG9rYXkuDQoNClJlZ2FyZHMs
DQpBamF5DQo=
