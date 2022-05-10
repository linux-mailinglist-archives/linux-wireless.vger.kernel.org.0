Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC98A521180
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiEJJ7W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiEJJ7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 05:59:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238B2A1FE2
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652176522; x=1683712522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5GUIJ7HnWpcUIUMCLcNpPsM3cAIKkApT8I/ighUSObM=;
  b=hc+SPbMgFKahqPfL8FBQFPD+am61QagmhOqcYUmg0TdwLym74tyDHldT
   FeiYz6RWV4+aC7vlLn6t280NucV8EUiQ6cH4k9fxWq+I+V6sUXrrrKUDb
   7a9QH61MdsgChqA+KVHGt19v3SbVhIMPbWqsDsuHaYdi8IsJ2hmf8zcjl
   /kLHPB5zDGx1Iv5VNYlGJUoCSwqqwzO044hout+p206OmJ4sBCqwHsrC/
   rk439bU0HexzpUpZiYgD/1Qs9WLC5B6Vr7oxmv8PS8oS/kkOQdSSWQLZ5
   wBKUv+wmkVnghNTuk8jH6gbNcEF/RNY5fIPnRWdZckCfr9xl6i9ttWvTM
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="155419836"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2022 02:55:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 10 May 2022 02:55:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 10 May 2022 02:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWwuuePLm17mJz3RV/FHDSI4abX3cy8YE8rn7z/sTiwxaTypNTpEIpelOJZ69zwd2nU5nfz7DStqxn0uwf3mn9bt4TlV6xZ6BzJ0awFdT6SsA2cGrgPYOWKvZOwmT1GjyK5ZfBL1eYBKaypHc5JN1+MBhmQX4o+ie9ygohyuUvhk7ip138FYNJRQwkmnAA+90mbZx57NBZ2CmlgdPUpQGK++dAEUMVlZhf3HeY0rTvsdfNPbCqoP5BcJ/Aq7RZH6FvmS9OOTTgY2inBN9ZdeS2np8Kq0SkfBVejeJVnU9eXaWKdETgpIKzLdrQ0UXNNaSsZOS2r5LHq7V6nFbDQeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GUIJ7HnWpcUIUMCLcNpPsM3cAIKkApT8I/ighUSObM=;
 b=JxCr45srsfJhcrBOh8vuzKFdCl4JR2HJdem/lLFQk4sjqKJlh/UC0D8mIV8XLIcyev0EutIyrhCb0+NOugyxqny1hmpgeLNZcMFoERN2tyk4ivGpAuvoJaB8xnkgrjpzGfxwPvPq3nDHYGOXBqhhsXAWH6lhq9vguG4ea82wU8TnZPizoF/FIYLNHev0UeFfNtkMhJztgw4hPmpZij0tCWDZqD7ZQYHdc4SPA0gDZ60F15+JbnQYzaG2JZcvQs1mKaFik3TSeWHVomBJTiGfoLGjvKRp+2fW6smNW6QbeoyabY8HmM06Sah89PdOyb9Zip5wW7GG0+oFWrQDGatnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GUIJ7HnWpcUIUMCLcNpPsM3cAIKkApT8I/ighUSObM=;
 b=SrjxCTLOReMwMBvI+6w/tzcUOani0uWN9/JNZLDKvkcUzOqV0sUWgBDy79xlmnerluFgm77VmlSyuyCp1lVEqK4rG9L8Ckg7w1HjM4AEXjf5pvmYHhAYu9RQqcONAmndQhtfwV6XU52hhax1qOXHn10scfH6Ps6qGQpL68lsxlE=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Tue, 10 May 2022 09:55:16 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:55:16 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <johannes@sipsolutions.net>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH 3/5] wilc1000: fix crash observed in AP mode with
 cfg80211_register_netdevice()
Thread-Topic: [PATCH 3/5] wilc1000: fix crash observed in AP mode with
 cfg80211_register_netdevice()
Thread-Index: AQHYX9K5kogwjz9cOUmXVoMCp0LCg60WdowqgAAhD4CAAGMxAIAA7aUA
Date:   Tue, 10 May 2022 09:55:16 +0000
Message-ID: <112580fc-4394-f6f2-2b85-b385ba4714b2@microchip.com>
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
 <20220504161924.2146601-3-ajay.kathat@microchip.com>
 <87pmkmylex.fsf@kernel.org>
 <aeafb6e2-d294-475b-1c43-1f90bf8d5114@microchip.com>
 <57cb3e2f1ba75aec472ca5cfdcd8fc3c7ffffeb0.camel@sipsolutions.net>
In-Reply-To: <57cb3e2f1ba75aec472ca5cfdcd8fc3c7ffffeb0.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b61e50f-cdd1-422d-87c6-08da326b2f7f
x-ms-traffictypediagnostic: DM8PR11MB5637:EE_
x-microsoft-antispam-prvs: <DM8PR11MB563737949FABDC93AA58757FE3C99@DM8PR11MB5637.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yl3D4JmP8aLocYUDvlhDO28lw4OfHt+FjvOelD+GrG53/+cxanEXr/BwYu0hJ8pHKxcz/n14WrnZfNngGtw9q2cVQ3VvA/fEWphCe0nETGhv1LacrhYSxHH/2aZ8Q0ApTN95nAsQoQ4tlj6gf9VTZKODbDi9B8nO8O8N9rPSef3fLQC24ZnKD2D2Ac2Ysylt91NXHkLv3Hta6rBTDCBlasrSVqmcjHmVR77ndkh1rUrH/uNlNVIbj41oE2RqZzLJIRxwslzk0l6dJamcdvHZ8M7scvdxtiQvP3Z/A8j4t5PLyPRgp+RBmLlqYsdS0MwVmQBSuXdq2Gd+XlAi4oA07jdX6QO3Or6FoR5xvhWW9D8xymexbaAOkqCtDBJA1okeB090Io+O7D17KqSMSxCtjNviox1kZNjaqNvvHrTnXAIuL7RK4J1JFCIEKkKvdSN0f3IVP80XHpEK1CLNVlMRRGJcjNQm0JsuAFtnjQrZKd37vtMz3foJGYRM+kfoK8ixhh8eId+UZ99FlvSS0O+CA6G1B5u/o9n1Ntc+SGucl9OgIo6/k+0/vDsallEg63ZF2NiwXH0vmHETvSF7fboMA7uPBHPdHvOWBeXuLnga05SRKbL8CPdG9sLaOgG1N+pwHd5xuR/Q4Ccy0prmF0qLqlnZsr9rv38pCy4S49wDn4S/pK2gzn0vw7P2y7pKX4pj4Vszf57qlyje8fffsDSoTKwMbI26HcDcnAzXiHGAfSUirlr8bgSi1UC+59zt4OWNevAvY8IJyteBtQ7Tyf9f8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(2616005)(38100700002)(91956017)(53546011)(5660300002)(36756003)(8936002)(31686004)(6506007)(38070700005)(107886003)(110136005)(66556008)(64756008)(66446008)(6512007)(6486002)(508600001)(316002)(66476007)(76116006)(66946007)(31696002)(54906003)(8676002)(4326008)(71200400001)(2906002)(186003)(86362001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdCZExiY2FUKzFsU05wcmJodFl3ZzcySE5lRldXODA2UHNOdmhNVWdVMW8v?=
 =?utf-8?B?NUFteHJ1aytCS01CUXNqZmc2UlhxV1RJd3BVd1ZKdUlzRGNIQjh6Vi9iOS9i?=
 =?utf-8?B?WHRzekI0S3ZlSmcvK3QwemtzOWd0MitJWFhITUxIUitCY0FUQjl5SmdQVXl5?=
 =?utf-8?B?MUpaK0pCTkhsRW5kYmc0MnZ5b0cxVndDNWc0K0NiOEc5ZGJsZFA1THp6NGo5?=
 =?utf-8?B?MEt3VVJIc05IME5aVGlXN3BEMW1saHl2NHNoN3NHY1BhcWFCU0NKeGh4MW9M?=
 =?utf-8?B?SUlCbEFmRkorWVpJYnR3d2FMdDlJV1Y3RDNNUzAvNUxpTlBEWUFhcGc5T0NT?=
 =?utf-8?B?TzdXQTR5VlpoSTZZUkNreGYrNEVOdldoZ1hzWnBRR2hNWGdlV2N0emRFaUE5?=
 =?utf-8?B?Z3M0ajRiUmtWNWZKSXNHeFhFd0djOEgvL3Blem9RK1BEQ21uVXF1NUdkeGxE?=
 =?utf-8?B?TFNOVW1ic1RCU2xjNi9Qb3grcG5wYVd3aTcyYXU2aE5WZytUc0NabUsrM2Rv?=
 =?utf-8?B?RHhIU2ZaelNqZTlwcGxjd3JmUVFsRG40SGpPQUdnRXI4MENQRXI4MGFVM2dC?=
 =?utf-8?B?TWRNNjR2Vks5elhRWk4rdGZhaDZRbjdZUHNadEd0eTNIRzNnbkpRUisvRHMr?=
 =?utf-8?B?QzJVTGNlaW5pazI0Y2o4ZWlGZCtHUzRhaytoUWsvbDY5NVNwakZMSVM3M3k4?=
 =?utf-8?B?VlhSNmR4TnlYMGVNQ1duZUNCcTJ5d01YMlZXTnJVYnhsb1VUS0NIejVrNEZD?=
 =?utf-8?B?ZGpKUWc0bGlLaFRrY3dQVDR5YWdhS2sxMkl0Y3Ayby9uY043a3dSTUl0M3ZC?=
 =?utf-8?B?S2MxK3JFWFlVMEw0QjVhTjd5MnZmSHV2cEprRW43bmNDTkZzWTQwaUZueEJi?=
 =?utf-8?B?d3BmZ1MvM2ZtU08rZG9YZ3RvbHNleFN3TzhoTS9VN0Z1dVhnR2RLczJSRExV?=
 =?utf-8?B?OHVYeWgzYTJMelNVcmx1S3dTQlpaZmVxQktFcXhEQWc2dFN4WGM0RTlxY0t4?=
 =?utf-8?B?YitDd1dwZ0xCVHNnRTZ4UmF2T21NeDMyTDVnbWtjYXF5TkFaNHp5N0Y0YXdl?=
 =?utf-8?B?Qjkxd2FDa3V4MzFBU0duYTY4T1l1R2Vtci9iM1QxaWdpVHgwUnVwMGRBWXUw?=
 =?utf-8?B?UWRVYkVIMWt0T1NuRG5MNFRuWGc0Y2ZBYUdRS3N2VlFUeWYrVHRLS0VhUlBG?=
 =?utf-8?B?eUpvUHVKYVNiZno2SWs1ZnlWbEtDaTZKMnh5dUE2clF3QlRRc1FHRmw5aFFh?=
 =?utf-8?B?SWJVUTZuUTZHaDRxN3hWVndBS2Mwd1RYcCsrM2hRRFlleE5ycy9YNzdhby9Z?=
 =?utf-8?B?RVJJVVQzaDAyMGFPNnhMZFJYUkN5Z2pWdFl3UFV1VDRIeUttcHd5U0NPc2Iv?=
 =?utf-8?B?MHlhTUZ0cG1WZEJtemU3ZTRkOGJndUNTRU1BU29BekVNS0VmZlJOaFovNWgy?=
 =?utf-8?B?eG9yNVlUNkFudlh4R0xJRnRrNzVzYVVnSDJNdUdnL05vdGMvZ005NWNCeW1H?=
 =?utf-8?B?ZzIzbk5xMUk5QUtRLy8vTnJybjFveG9rRXRwdThpQzJZYVFNcG9PU2kwblEz?=
 =?utf-8?B?dk92ZDZsY3hXU1hXUXZUN2FGTFJzQnpQZUFVVCtPaXF3d1NDSW96bzU2QWs5?=
 =?utf-8?B?dWJKSGVWMnozdWd0bHFQa1NOK2k1ZXp3b1ZWZmU0bHVDS1VqVStQNW5zMXY4?=
 =?utf-8?B?NVNYaVhOS3BOWWVNR0h5ay9GRlJ2dnRQMGlCZlVvMzgvdkpLb1JsYU81blNK?=
 =?utf-8?B?UHloR0hzUWI4enVkbmlBZUtlZnFLSXNKUzYxTHM1b0N3QmxWaFdNVzNGbndT?=
 =?utf-8?B?UDdicE1PUWRVcU9zWXZSWE4xOGlPSTE1Yk5lQnJGWk5qQzNFQ212VWlub3A4?=
 =?utf-8?B?Zlk0QnJ4UmREejV4RmJNb05sbmltY0p6MXhEQ2Jwd3JwREpvWkRsenJyQ2RV?=
 =?utf-8?B?cDFLb01zaUM0dHBtbUpZaFpEUmFVMXc4ZTU5N1dMbGpidktwMHdpQ2VNOWZE?=
 =?utf-8?B?Vk8yaHl6SFc0RTV5UDNNUDRqeW5tVGREREdxYjJJOVlrWTlsUTFCSUtYUHlX?=
 =?utf-8?B?TGVCUW00UW9CYzBZQWswZkZKeVpZWDZESE1GVStKbVpJb01TUkRyVExGZjhY?=
 =?utf-8?B?eEkyS2EvREtLRzhlMWVLQ3JNVnFoTi83NHFTZXJkNG5JWGZWalVuSG8yUHdC?=
 =?utf-8?B?dVhqdU9YN0JWZnFqRHhMeTFjV3VaWmlSc0F4MlRlRnFiMVBQWjQzRzgwWlMy?=
 =?utf-8?B?YjJHdVArUGdIYUxXYnpmeU8wdk5TaUl5clVDbnlsYTR0RUE4UUlSTlZxOEtj?=
 =?utf-8?B?UmxqOG9rRkQ2MWV1bGJWOVMyY2J6SGo3VG9ENjNKbzNQY1pwT08wMWF4M0xB?=
 =?utf-8?Q?cFtlUK2m+4jQ0IUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7D9B557E4551C47A8013D398379E210@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b61e50f-cdd1-422d-87c6-08da326b2f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 09:55:16.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jN7+oWS6L2ertzisRyQjd58PSJn4vmty1GpmoDLkcU1yt6u+6Rm5dMy+icP248wAZtf/jW2VxBjU12K8At4E/ZCJpLMPIloZRplr6qZCBrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTAvMDUvMjIgMDE6MTQsIEpvaGFubmVzIEJlcmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBNb24sIDIwMjItMDUtMDkgYXQgMTM6NDkgKzAw
MDAsIEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBBcyBJIHVuZGVyc3RhbmQs
IGluIFdJTEMgImllZWU4MDIxMV9wdHIiIGlzIHVzZWQgZm9yIHRoZSBzdGF0aW9uL0FQDQo+PiBp
bnRlcmZhY2UgYnV0IG5vdCB0byBjb25maWd1cmUgdGhlIG1vbml0b3IgaW50ZXJmYWNlIHdoaWNo
IGdldHMNCj4+IGFkZGl0aW9uYWxseSBhZGRlZCBpbiBBUCBtb2RlLiBJbiBBUCBtb2RlLCBmb3Ig
YW4gaW50ZXJmYWNlKCB3bGFuMCApLCBhbg0KPj4gYWRkaXRpb25hbCBtb25pdG9yIGludGVyZmFj
ZSggbW9uLndsYW4wICkgZ2V0cyBjcmVhdGVkLiBBIG5ldGRldmljZSBpcw0KPj4gcmVnaXN0ZXIg
Zm9yIG1vbml0b3IgaW50ZXJmYWNlKG1vbi53bGFuMCkgdG8gdHJhbnNtaXQvcmVjZWl2ZSBmcmFt
ZXMNCj4+IGZyb20vdG8gaG9zdGFwZC4gVGhhdCBpbnRlcmZhY2UgZG9lc24ndCBleHBsaWNpdGx5
IHNldCB1cA0KPj4gJ2llZWU4MDIxMV9wdHInIGJlY2F1c2UgdGhlIG9yaWdpbmFsIGludGVyZmFj
ZSh3bGFuMCkgdXNlcyBpdCwgc28gdXNpbmcNCj4+ICJjZmc4MDIxMV9yZWdpc3Rlci91bnJlZ2lz
dGVyIiBBUEkncyBmb3IgbW9uLndsYW4wIGludGVyZmFjZXMgZmFpbHMuDQo+IEJ0dywgdGhpcyBw
cm9iYWJseSBzaG91bGQganVzdCBiZSByZW1vdmVkIGluIGZhdm91ciBvZiB1c2luZyB0aGUgbmw4
MDIxMQ0KPiBiYXNlZCBBUElzIGZvciBob3N0YXBkIC4uLg0KPg0KPiBCdXQgSSB0aGluayBhcyBh
IHF1aWNrIGJ1Z2ZpeCBnb2VzIHRoaXMgaXMgZmluZSwgYnV0IGl0J2QgYmUgYmV0dGVyIHRvDQo+
IHJlbW92ZSB0aGlzIGFuZCBlaXRoZXIgYWxsb3cgaG9zdGFwZCB0byBjcmVhdGUgdGhlIGludGVy
ZmFjZSB3aXRoIHRoZQ0KPiBwcm9wZXIgaWVlZTgwMjExX3B0ciwgb3IgdG8ganVzdCB1c2UgdGhl
IG5sODAyMTEtYmFzZWQgVFgvUlguDQoNCg0KVGhhbmtzIEpvaGFubmVzLiBZZXMsIHRoaXMgcGF0
Y2ggd291bGQgaGVscCB0byBtYWtlIHRoZSBBUCBtb2RlIHdvcmsuDQpJIHdpbGwgY2hlY2sgb24g
dXNpbmcgbmw4MDIxMSBiYXNlZCBBUElzIGZvciBob3N0YXBkIGJ1dCBtaWdodCB0YWtlIHNvbWUg
DQp0aW1lIHRvIGNoYW5nZS4NCg0KUmVnYXJkcywNCkFqYXkNCg0K
