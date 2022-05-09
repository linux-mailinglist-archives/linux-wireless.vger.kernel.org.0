Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF851FEC3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiEINxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 09:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiEINxn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 09:53:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A51E2197
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652104187; x=1683640187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qFIAcSu+QVLPls8Ysi6R1Iiy1oPYuJ4BiX8qFTc8Urg=;
  b=cUTErBkL0B+2jCC2wRCMDReq/SU7mfnE4oplJEaYe6au9q9gixfoVJ4/
   9PJM1r0COV01DGu0WrV+MlpXrRVfpozdE/aLwuFg32FKUohtQuRdogAIP
   ob2TadbmSG0xzEdToXv79MtpuKEQ9vJjGohw69L388+zX5EqaonS7VWDt
   1QYakijBAn9eU4MCGasofSKnmkfngfYTadPKfuU95OaqOK88ooQdhIpg1
   7P3z2fSm0VnK1FRh7xIn/bw6FHx6+nieZjjfS+WLkinbMbCY+AZFwmO4d
   YJETQDKolVIrgUP1TNHVS/Tisunbvu8QoWpkkOIuwMPXgqloOJZ6SsRFW
   g==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="172511912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 06:49:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 06:49:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 06:49:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCEePIbbSgTnfczwIgUeBvgSEt6Mp6ri+q3Z+DJmYcsCepg0nL++4Rhk5NYegITkQTZ4Ujs8h26IQ4QHcOev+k80gALSY5oVDuZ0Jem70T2efybOxgelz+eXo5+NplGN6DzF9s86/U/nM+C6+onSgbk+3TBAQisTCXWrmRJLqAenSmDKmAd1V0LkkbMZ9VaqgavoU2RpW8av6NgPg25oUM3Q3NTutT7pggq4ilYU8wo8hzqz4FyPGUi8GL4w3xbPs7GHtukvDDtjTMeVtAJYyCNKI5A9V6KQ+YBTUYRFbCrP2YJajH4QPzGv2rzOiy79yElGwV6ds4eYEvFM0FVAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFIAcSu+QVLPls8Ysi6R1Iiy1oPYuJ4BiX8qFTc8Urg=;
 b=VtSVJEp6cq1pOIoPp+2JZL+6W0yRPu7hD5ISPFBlk+5Kyfn0Bhk56y1gYPFKtB3Ww4Urw3+MumCJbb/3YN+W6J3tC1urpQRO3BbUj/c1BW/KbgeWmXKR1NHVdpZ78S902b213Wz5yDKJrlXW5luuETsUHxGPguAIJoI0FMyY61ONYBD9udJFR8TTRLqQxwghcRZgaNfcdPMLxULREKck4jNg52YFQT+map41GNfUR3diB6ffbpdt2ji+uOTXQ0/eOu/qSkBkqLfzuBPKUgUZuuAUf8Re6cF+l++QsbuyJK/p3HjzVsfTh3WKAKHmZa5vY+U2Vnnqz4U3ZD9PAPoijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFIAcSu+QVLPls8Ysi6R1Iiy1oPYuJ4BiX8qFTc8Urg=;
 b=qlfJpVf0intTUr2T7j9AIyjxGsjtTkGvbvYxB3eNDfIjT6C+on8WCsOKc4GIC0ovdE31Ihx0L4MTDv7UFW0kjad4ae/hsMWN5wrpYmu/VkmH54oJ86B8xRoPCDIcYeOWWGg7rm+wUzoQp3UlZ1LwOMqI4fSKpmKx94Vwd1NbTKc=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB3951.namprd11.prod.outlook.com (2603:10b6:208:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 13:49:41 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d0fc:845b:ce0b:11fa%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 13:49:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH 3/5] wilc1000: fix crash observed in AP mode with
 cfg80211_register_netdevice()
Thread-Topic: [PATCH 3/5] wilc1000: fix crash observed in AP mode with
 cfg80211_register_netdevice()
Thread-Index: AQHYX9K5kogwjz9cOUmXVoMCp0LCg60WdowqgAAhD4A=
Date:   Mon, 9 May 2022 13:49:41 +0000
Message-ID: <aeafb6e2-d294-475b-1c43-1f90bf8d5114@microchip.com>
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
 <20220504161924.2146601-3-ajay.kathat@microchip.com>
 <87pmkmylex.fsf@kernel.org>
In-Reply-To: <87pmkmylex.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d0937f1-db12-4b84-8b64-08da31c2c46c
x-ms-traffictypediagnostic: MN2PR11MB3951:EE_
x-microsoft-antispam-prvs: <MN2PR11MB395198DAE60CB695F125ED93E3C69@MN2PR11MB3951.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80yPI3iejfkMwPS6RwcATcmly+ouPJSprhQ0IcpRSsp87OvUZbz0KpXXWM51VAiX4Uh6yxTOxvTP0MP29HahAUEQ8s15H08AqFQcW07y6m7i0cYTGKwx+GmHjvuyA3XtlP4TYCE9WOMsYTZOhiO3mjbMR+iHJmhvvh/+tTzyp8V872p4AMNJX8cWCuASyubWE9mYaihZUmjPcpNwBZEmNd8F7fMA7+m8T/c/TGS3+8dCAfX0uraPBc+5c980kG06Ts9j/SC6WefgWAsNsiu55tiGVDKvuDJ4cBgkAfoVS0T4GVQDLrzOsIskKjRSud0ic96FYMRNCppMfEobioUe90QmGNzrD5atSWwmYTQuc6csEhPCVR44IXampo9aYGcdj1UETrXnx1f8gdzluvq/b6172soZE1xA0yckDamGX0mkkzpZOROjrqTmfIzJf2M0wHgykg+9FlrmX2YgE2AePPRRrFXCJEqAnecOrN5HduXTGjBZRoAy9+xSGrKRbNbYhK55HtiG93/2xgXN/pP0bLYzHPdBhHto7785l2yfhH59K1DIA1oFJJTrOQpQLP2AeyUAe0XsjpJbjV91RUXW9fRe+enAs9Cm725CJsRBIG2srQH4gaIKPv+BMiiQEuXoBnY4ofsOHtWk+woCmHAXbWxZ6tYckvvawKQyLQO07fo+RAqbUbHYbRBtCC0eaWCCD/IkN7wtdnqc8/Ym6C8VVrUXBtubl7iFWrAkuKwT60BFSYBJmv7G4ArJ3nm0uLnyF6lBvzPW6+oz/rjCYEYw8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(5660300002)(36756003)(6512007)(2616005)(4326008)(6506007)(186003)(31686004)(53546011)(26005)(66946007)(8676002)(2906002)(54906003)(66476007)(6916009)(66446008)(76116006)(64756008)(66556008)(91956017)(71200400001)(38070700005)(122000001)(8936002)(6486002)(86362001)(508600001)(38100700002)(316002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmxpbUZpa0J1b0k4UVh2bVpYRTJvOUNObnpnNVgvcnliT055TVJCdy9ldzNp?=
 =?utf-8?B?TjMwTnV0S2NDNEtSbW4rMjdERWxubVk3eFRaL1FvejQ3eEFFY1ZydlcvcVFO?=
 =?utf-8?B?MkN5SjEyRzg5bWo1aGhjVEZXRU1Id2svWnFiSXNpaXVHcUNOYVJJOGJoM29i?=
 =?utf-8?B?WHdNNkFBbkpESUFabHNFYkU1aWxzMHk5VE5UNFg4N0s2ZXQ2WGp2YVN0RHAx?=
 =?utf-8?B?YUhsMzZncXoydVdrSXgzL1ZzNTg5ZXJnaFBRZDhuOVpIV2dKMTdHOE5nK1g5?=
 =?utf-8?B?ZGNWdEVtaWNSeUpZajFIMzZaWEhqSVd2V3RGTEt4TzRPMUlRTkpXSnB3ZzNt?=
 =?utf-8?B?aDl3em4vVnpwWm9WYUFmdm80cENqWFptcm1XdFpMQ2FtSHdSdWxjNVpWNDRT?=
 =?utf-8?B?UEdYWkFmbGp6VmQxN25USTNyVGpGQ2tPaWZHaUJZOWdqRnl2YmRnZHhsZWFz?=
 =?utf-8?B?QmdZaFdGS3d2anFhS1lkSWhQODErS3RENW1GZnZqdUlBN1VESzRJV0ZQc1g1?=
 =?utf-8?B?R1BiRmhuSnNrY0NUY2JUZDhEVDhlbjZ4OTMxYUR5c1NsTzR5cWEvaDkxamlM?=
 =?utf-8?B?V3dYR1BPclBpcm5Td2RzWXN1Y3pEY0VtK1RnTUs1V0pzRHZuMlJMR1Vod09w?=
 =?utf-8?B?TWpOVVdKQWdrZXl6TysyOURUQU9VdHU4SHJreHRVc0xrdFRxSy9TeWt2T29y?=
 =?utf-8?B?V3VOd0ZJbmxQNzJpK3ZMaUFYWHc2SHBweitaUjdxS0lnZk03ZmJra3dRTjZr?=
 =?utf-8?B?ZlFzeTZEbU1rSU1mazlHNXJNcGprMFVKcWwwaDJKN2MvcGZsVXRLa3N6a09y?=
 =?utf-8?B?UHdhdzkzdk1STjREOVVUemRGT2tuWENTbDA0V3hoZk10N2MydUJmZEx3bEZM?=
 =?utf-8?B?c1FHNHoyZHVXWjZ2OEMrUHcxUFl1RGF5ZU5QREY1QnpMV0JWcHE0d2diL0ti?=
 =?utf-8?B?T2d2emdoRUFTa2NtVkJLaDFoQ0xmbThQbWtrbHpJYkZNWUdRdGpHUGxuSU8w?=
 =?utf-8?B?NUNyTFFUbktPbi9BT3VZdnlwbmNqR1F0MFV0czV6ZnZIMlNOQ0piTlRGNWdJ?=
 =?utf-8?B?MnBVeDJFZzhPeVpqbkdXY3Q2R2Flemc4dFU4WXJ1UHV4NFRVNVpTTFg1a1NG?=
 =?utf-8?B?YnVMZWJWSUZhNUVxcGdRMndnVUZSemVMUTlTSDU4Wi9MWStXMEN5WmJSMXBs?=
 =?utf-8?B?ZmV0SUh6UXJ5Wmp5Ly84TVp6Mys4eEk5dEdLM3kwU0FRVld4ckZaQVVLY1Ru?=
 =?utf-8?B?NUV3VVQ4MGhuVzZUS1VoU0hvYWEwUWZTR1pNV2FjT3ZhYUFlem5UUmFSS1li?=
 =?utf-8?B?ZTExU05zOHJ4RGIrYmZZQXlmekV5d2lMUzdHT3lOZUl3UWZaejFHT0JHd0Vn?=
 =?utf-8?B?T3ZaZ0tia2ZWVG1Vc2RmYWFzNFhpY2ZuMVFYZWNrQVZEVE5uM2NnOUZ0M3Zr?=
 =?utf-8?B?UytwQ2RBZXRZUlFhSURRM1JWQWhIQVhZUGJOb21hT0xxMnZiYjVQZFphUzd2?=
 =?utf-8?B?REVPaFdJb21VanU5d1hOUzViNUxlMFU4bWJUZWNmaGFiWE0rK01vZWR6QW5p?=
 =?utf-8?B?UDYvbmUwbnQrNjkvNUhRa0RGNUZMUVQ0a1FqUGM3eUtaS2h6NlkvcGdQTmNr?=
 =?utf-8?B?U05rUHNzZU9KelZrUWE5SWhzSllNN0s2MjMwRVE3REdXOVZZMVZqUkswSWJJ?=
 =?utf-8?B?akNLTkFjaVFNQ3MraDJ4RjBDanFaL0JQMld1bFcyWjF1VnNEbzNUY1A2OWh5?=
 =?utf-8?B?OG01aG53TkVxaTUrT2VkZ0NXVU1GZkFqM3BxVGdDQ2tkWmtUSXdTRjM0SVgx?=
 =?utf-8?B?V21lakRFbHF0aElURndyWGpNdkVsbkNCZUFQWFhGY3ZSb2dUSjhjSnV5eVJC?=
 =?utf-8?B?OVdyVDM1Q0g0UUN5TTIzTGVQQjFyeDE4Q0R5c21vQXBYN1RBTUQ4SEN1QnFo?=
 =?utf-8?B?cHg3cXplMzhVWjV2WGFjWWdkNjcrdDJkU1JBeVFsMlA2RTljNDM1VGsvOTlC?=
 =?utf-8?B?VDRjbVZ4RHYvdWdlNFJIRnVudW1LKytOaUx3Ky91cnJVUVlsYWJHYTIzcC9R?=
 =?utf-8?B?SFRWbWRXZVNsVStRNUZMUEVZMWd6TmEzQiswbXRBdWUvQzMxSnk4OVlYNUo5?=
 =?utf-8?B?TnRhL3YvNkNGYXNDWDFoL2h6akY0bVFFcnRuMllhaWtOTG1SWHd1Uk1md2Z2?=
 =?utf-8?B?RTQzaHVNK1hNbytOayswWEo2MHlEZXFOb3J2czN5SkdhUm9CYUM2cVduaUhZ?=
 =?utf-8?B?VzA2OGdYSTRMVnRCaVFETjh3OTlBZ0dSN2Zoc21XbmtSVU1TUTlwOC9ZOHBR?=
 =?utf-8?B?ODE3Sm56L0lFdlZXUHV3M2duV1NnZndNNWVBbFphSmtGRm9YMUtCSkt4R2Fj?=
 =?utf-8?Q?Sml6mPsbRh5VWU7M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6FC4910F9F12247AA868E0F51B0E598@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0937f1-db12-4b84-8b64-08da31c2c46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 13:49:41.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vug+K4oRDON/WpienX+785voDDSQ6GZEzpC7iWAIwGukEpd/+Ko6UkOtyAz+74MdV6RvaCR8YHKqHRlGICR5dGJN+3KdwScKUYmR/8nfwes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3951
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiAwOS8wNS8yMiAxNzoyMCwgS2FsbGUgVmFsbyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IDxBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tPiB3cml0
ZXM6DQo+DQo+PiBGcm9tOiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0K
Pj4NCj4+IE1vbml0b3IobW9uLikgaW50ZXJmYWNlIGlzIHVzZWQgZm9yIGhhbmRsaW5nIHRoZSBB
UCBtb2RlIGFuZCAnaWVlZTgwMjExX3B0cicNCj4+IHJlZmVyZW5jZSBpcyBub3QgZ2V0dGluZyBz
ZXQgZm9yIGl0LiBMaWtlIGVhcmxpZXIgaW1wbGVtZW50YXRpb24sDQo+PiB1c2UgcmVnaXN0ZXJf
bmV0ZGV2aWNlKCkgaW5zdGVhZCBvZiBjZmc4MDIxMV9yZWdpc3Rlcl9uZXRkZXZpY2UoKSB3aGlj
aA0KPj4gZXhwZWN0cyB2YWxpZCAnaWVlZTgwMjExX3B0cicgcmVmZXJlbmNlIHRvIGF2b2lkIHRo
ZSBwb3NzaWJsZSBjcmFzaC4NCj4+DQo+PiBGaXhlczogMmZlOGVmMTA2MjM4ICgiY2ZnODAyMTE6
IGNoYW5nZSBuZXRkZXYgcmVnaXN0cmF0aW9uL3VucmVnaXN0cmF0aW9uIHNlbWFudGljcyIpDQo+
PiBTaWduZWQtb2ZmLWJ5OiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0K
PiBJcyB0aGVyZSBhIHJlYXNvbiB3aHkgd2lsYzEwMDAgZG9lcyBub3QgdXNlIGllZWU4MDExX3B0
cj8gQW5kIHdoYXQNCj4gZWFybGllciBpbXBsZW1lbnRhdGlvbiBhcmUgeW91IHJlZmVycmluZyB0
bz8NCg0KDQpBcyBJIHVuZGVyc3RhbmQsIGluIFdJTEMgImllZWU4MDIxMV9wdHIiIGlzIHVzZWQg
Zm9yIHRoZSBzdGF0aW9uL0FQIA0KaW50ZXJmYWNlIGJ1dCBub3QgdG8gY29uZmlndXJlIHRoZSBt
b25pdG9yIGludGVyZmFjZSB3aGljaCBnZXRzIA0KYWRkaXRpb25hbGx5IGFkZGVkIGluIEFQIG1v
ZGUuIEluIEFQIG1vZGUsIGZvciBhbiBpbnRlcmZhY2UoIHdsYW4wICksIGFuIA0KYWRkaXRpb25h
bCBtb25pdG9yIGludGVyZmFjZSggbW9uLndsYW4wICkgZ2V0cyBjcmVhdGVkLiBBIG5ldGRldmlj
ZSBpcyANCnJlZ2lzdGVyIGZvciBtb25pdG9yIGludGVyZmFjZShtb24ud2xhbjApIHRvIHRyYW5z
bWl0L3JlY2VpdmUgZnJhbWVzIA0KZnJvbS90byBob3N0YXBkLiBUaGF0IGludGVyZmFjZSBkb2Vz
bid0IGV4cGxpY2l0bHkgc2V0IHVwIA0KJ2llZWU4MDIxMV9wdHInIGJlY2F1c2UgdGhlIG9yaWdp
bmFsIGludGVyZmFjZSh3bGFuMCkgdXNlcyBpdCwgc28gdXNpbmcgDQoiY2ZnODAyMTFfcmVnaXN0
ZXIvdW5yZWdpc3RlciIgQVBJJ3MgZm9yIG1vbi53bGFuMCBpbnRlcmZhY2VzIGZhaWxzLg0KDQpG
b3IgQVAgbW9uaXRvciBpbnRlcmZhY2UsIHRoZSBlYXJsaWVyIGltcGxlbWVudGF0aW9uIHdhcyB1
c2luZyANCnJlZ2lzdGVyX25ldGRldmljZSgpL3VucmVnaXN0ZXJfbmV0ZGV2aWNlKCkgQVBJIHdo
aWNoIGRvZXNuJ3QgZGVwZW5kcyBvbiANCidpZWVlODAyMTFfcHRyJyBmb3IgbmV0ZGV2aWNlIHJl
Z2lzdHJhdGlvbiBzbyByZXRhaW5lZCB0aGUgcHJldmlvdXMgQVBJLg0KDQoNClJlZ2FyZHMsDQpB
amF5DQoNCg==
