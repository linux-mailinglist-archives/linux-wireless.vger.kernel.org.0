Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7883E6E3A49
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 18:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDPQfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDPQe6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 12:34:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E6F1727
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681662895; x=1713198895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AJysNz8c8B+ZPgrDtQLxnNHk7t4BFrxBW2H4Z4SS8wE=;
  b=2bVs6fx7MDB+6Sonc3tfSEHpWr6S/WHVPwfcPLkdL8pbD+5fh+3Ygs0y
   YVGqbhzr/JcA2cH0pN5QaHmJZ7APH+g4CRd9HaG1d0KNLZWM6/lP7fQ85
   IXSllGm6ajDeFGcQj+YeQkT3FEGb7XDxunw4xBtH9ifzYehIm/CUHuoeo
   G2jXdJ/i3N0aL1+hK0EWSHAKbehg1VGrqXj+PRvMFOJiWutb5AT21ootA
   rHvB7Jx0Gs4O4ePZHlYQfQGFGHaHBfilNkAG/Cbg3X0F2aeHxbVc0wErH
   ADdIfRJi4Rctx2L021E6idBlpMnGQ+i17ZghpLHZX5zFFCg5iFGqhpkrM
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,202,1677567600"; 
   d="scan'208";a="209758740"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Apr 2023 09:34:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 16 Apr 2023 09:34:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 16 Apr 2023 09:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBiYb8hW7KdGJSxe0Y6kJ0Y5aaXO78jQc+nIAwe9b/FKzCcyO9EuLcJiXny14tnM8KeovSCC4IzzawfzVwvGTc7xX2Z4x1UVc3hz+6WG75wVvBIxgpCKABZ+lsRIJ9Q00qEQMx2ipYGI64V47tVX5hxITK1pPBvoEkw97ZD4/hWpBFtTRlfIYMHRURbWIPCcG5divzSwVULuDWAlIRZkQoe3IYzdO7tWyu2pH+aEbk+J/+K+eE9M/mksuL/K4bdBktS8+OH7vXMGn/eRufYplowgmL1qadKA/rRqVGxLLzk92ItME1c5kBB68NO5KGXhz/Dq69DrlvUDEkUBvJd5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJysNz8c8B+ZPgrDtQLxnNHk7t4BFrxBW2H4Z4SS8wE=;
 b=CrGzZHOvqX3phnfwabCjapv39YU88x+qVnpOi4T/2USzLrRlq2BbB61BIO42jOLip97id/SgbAoKtq9BMgQwRKX1jpIYp+XnHF1VtvpwU55vndoQVx093CpA4y4lyIAV0THNCkn8Lrl56gJY2qziduOqjdJrsiDxkDLs1/wIpyaLYy1jIvtBO+JRk4SV4DAeYg1kgEptzyNpnVBbpT9u2kY0aZAOJemsgyXlctaOiO11D2Gm8zv4rF8pi3ePp+PLSTaFoZKCY1dtIpIC+AZBZryaIycVVywMI2/UUh91O1AHdKeuzWcQgdZA62elSDrxFnuhU8MsaGRF8htnUD7nQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJysNz8c8B+ZPgrDtQLxnNHk7t4BFrxBW2H4Z4SS8wE=;
 b=TDMApS2ZTX4HDfCb7GzLH9g3OTXT/2shLpHPTZlR6gg7cPrQeyKywFv1/q6w0YhHFHFSvu+aigVIalLGXgqCdN+OpHmKFgt8RS8gWz2CR2/LjIiwu9+IzGlvXlOOfiHxLr+c0uX+7PSRk3QKghW3YtQHHYspbFTOcg8pM0Jb6OA=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sun, 16 Apr
 2023 16:34:51 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%5]) with mapi id 15.20.6298.030; Sun, 16 Apr 2023
 16:34:51 +0000
From:   <Amisha.Patel@microchip.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
Thread-Topic: [PATCH] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
Thread-Index: AQHZZ+VFaoRux7AH/kad9DveyKpmhK8qyYEAgANpLYA=
Date:   Sun, 16 Apr 2023 16:34:51 +0000
Message-ID: <a8b53316-1fc9-e2ce-1503-b350418a4178@microchip.com>
References: <20230405173555.6041-1-amisha.patel@microchip.com>
 <168147531839.16522.15801459237923800344.kvalo@kernel.org>
In-Reply-To: <168147531839.16522.15801459237923800344.kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|PH8PR11MB8259:EE_
x-ms-office365-filtering-correlation-id: abebc217-45d0-4e13-cbd4-08db3e988069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzBV2sxjTvjiIw0ckZ73UuX6C31CbHKqmJnnw2aTsHTojWA6bFcKxPi7glTNKb35BcANQBHA1KXRrt0O6oVTYSU9wHzMHg+9yk2d2IU1UI3gW5mSzg6K3m82+BralSJbcMnkNczgwqn3DiDFI5aw1t2PHkfP9cMaXo+xOXVK07yu/bodVDJlaPzV9b2+QiIRFJQ7qq5TKVLcsvrFTwiQb8ukwprmw6cg61Jz+dLvwIyG7iM4UpxfJdPbQ8X9B/R5InqoOPf8XmYyqi94UMzVkfmfS6i/3JZYtESll5YVR+T5V/z39qOoyKs9mx6SkltLUZgeTx7o7o0mJSl1htsmAqYTN3FQCFXDF5AFZLSbSd6rmkuqcFfsSm48Ynez/b9iw1vf0y8Q1wUOwmNGAEtQT29J6Ezy4/OFR20kwKKfeWH0hBQH1ckSwLBx1ftfC9SlRYWNSkyF2SU2VzTi6BDGocnC9zEzYGeEduHkek78cE2Pw3u5RHFqi9p4Tr8zEqMmpUgTwPltqHUzH48XP6qSp7Clp94XwS8ZJOvCsL64hdV2dHAw/ShZpwjKPKB8FwBHESG/332KDEFPv/fnjSkDV1b8ePvXIWDSe5kvuXemMahtZNqWi4w37o9u6cj2lrzQdwrUAp9eKwJBF7ZIAqR60g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39850400004)(451199021)(2906002)(31686004)(8676002)(76116006)(8936002)(5660300002)(478600001)(91956017)(41300700001)(316002)(36756003)(64756008)(66946007)(66556008)(83380400001)(66476007)(66446008)(54906003)(4326008)(86362001)(71200400001)(966005)(38070700005)(38100700002)(6506007)(53546011)(122000001)(26005)(6512007)(107886003)(2616005)(6486002)(31696002)(186003)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFU3Mkh5SW1ZcjhkYzg2R1hzYldnQkh4VnpkcEZqUGtPN3F2Tk1MdEM3OU5y?=
 =?utf-8?B?dlNaNjY2ZjVvcDc2cFdxNGZORDNLNWkraG5ndzdRWFpxNVovb2V3aUlwNGpn?=
 =?utf-8?B?OHF6bEVoM202OFdsOWpCSzVPcXhYU2tpNE10MTlmTUhta1hrOGRZWU9OZHJq?=
 =?utf-8?B?MkhZRmU5dG54eTRGMnA0ZytWekQwVnUrRHN3bHdBR09XZldOU0k1TkZIczA4?=
 =?utf-8?B?YUxqcUhKbDJxaG5vN0pRMGltVkJpNGxxM2FhazNndlVyTWhiQ0hPNExBNGc2?=
 =?utf-8?B?MWgxSWYyYWxqek56RWE3Q0NQcHlCQXlQTTJVdHJ5cE5JOGxQUzM0Tm4xdWVQ?=
 =?utf-8?B?TkE5MkNGQjlBRitObE1YT0ptTlhqQ0JCWkQ0ODkxa2VPMitSdEEyWmNSZkN2?=
 =?utf-8?B?NlNQQlYyT0ZuTkgzNzJ1ZW1NUnRqY0xxa3RzMVdMcTR4OXZ1bHdjd1cxT0ZT?=
 =?utf-8?B?Q0RQRkJpUUd5SVB1TjRjVytsMDVxQUNYVXUweEpnT2NBWEJlVnFDd2tUYVBD?=
 =?utf-8?B?R0VVNUZCbGRFdzE3aTVqT2xyZnl0M2RLeDNRVFFJd3Rkc3J6ZzliWUYyWkVG?=
 =?utf-8?B?OUZDenN2MUF5Q2VySjJ2RlNYZEVRN3YwazFVc0pCTE13SGdiWDM5SXZjS01X?=
 =?utf-8?B?Z0x2QkRLajJBVFNwNTI3RTdJZ3UxS3pOSWViNUl2eDJDOXltalFGQWZkUTBV?=
 =?utf-8?B?UElkTStyRTU4R2hvRWwrUW04R0hEOHI1WjZjdHF6ZFNBTnRtZHdmOXlGN2Fm?=
 =?utf-8?B?aWFSR3FzellscTE4V0ZPUVpGVHd2Z3RnbTN2d0NnWjQ4UWFpVy9MRHBxK0la?=
 =?utf-8?B?a2ppYXl2U0lXbm1icUErQ2xqNUFLalp5cno5cEJDM2JRNFp1RDF3dTNsV1NH?=
 =?utf-8?B?RjRjQzUwbk9sbWpCTkV6T3hLdUVGektTdTc1b3gyV0ZMSUJnWHBiYk83RTZP?=
 =?utf-8?B?YmIvUTZUdG9MZnNSYmlYRzVPNWgzNFBOcS95RHdaVERDVzVKS3R1SGRaTFdD?=
 =?utf-8?B?ZlBJL0FIdzZiRU1mWTZFd3BMNE1tK2s2eHNmamduVTRrbjAyNktjQzJaYWsr?=
 =?utf-8?B?OUg4Sk5nWW9VcjR2RVFqLzJkRVVHdUhaeFdZajkrYXRlK1l1d2ZmQVVTRlh3?=
 =?utf-8?B?Z2hpZ25pN0hYeTBNbm9FK2U1RmRXZGp1ZDR3YWNnbG5NV2E0bGMyL1pnMi8w?=
 =?utf-8?B?MWJ1UjIwZ2Q5eHptZ2x6YURtZktzU3N0Sk1mVi9KcXdNVHFmUVlPSmcyMmNL?=
 =?utf-8?B?aE1vTVJWUWw0bXF6VGJDSXJtZjNyUUFHenNSZThnTVBrUnpVQkh2Mmw4OU1G?=
 =?utf-8?B?WUNZU2VMbkRrWFJ4MDRLdmd3dkZyUXNkVmxtd2duYXpTVnYzeHgvamhGejNZ?=
 =?utf-8?B?QjVkcHdpU25NTkNYREZZM1l3U0lTNlVQTmNhNWY4MFNPdUc3a2RRTDdlZlMz?=
 =?utf-8?B?WWxkS1U4QUZLbUFQbnNhWmVOVjdvUEtNeVNsd0hFUTl5UlRCSCtXVXFjaVVG?=
 =?utf-8?B?WmtmV3c3QVNlZ3RQS0lNMTNLUzc5YmdzR2J5Rmo1ak90QlU2bTBHWDVCM3Zr?=
 =?utf-8?B?eHJTbTJ6bFBvbkxkZDRkN2ovWUl0UDFFOEw1SmM4ME4yN1RYaFZ1NGZtTkt3?=
 =?utf-8?B?V3d0cHpvcUxkTnBFY2VGOWpPd0cyK2J0WWJHS1RTbGUxMzlHZ0lGSFpwT2ZJ?=
 =?utf-8?B?dmFmWkxjd28rMGY5WCtVWklxMHBjdVNmK1hTaDNRQTN2bGpENHU5SVZ2bFIr?=
 =?utf-8?B?VDBGTkRVTlJ5QldBTzFIWjlIcDd5eGY1a1NiVUJSYTJ1Y2EyeGkzNVg2NVc3?=
 =?utf-8?B?VURzbW5YLzZGQXBKcEJSakd4R2gyUURBUkUrMDMrUXRFOFFpa0VXNVoxZHR2?=
 =?utf-8?B?TmVjZmM0M00vemI0blA1WDM2YkpXZVRvanI2aXE2THA3VmZlTXBpWVJYbTU1?=
 =?utf-8?B?bEdxMGNHV0pIT0VESlp1akkzM1p3Wndlc2dKWVdzdEFrdjBCclB4Sk9UeE1m?=
 =?utf-8?B?bXlic3lWRDI5cHZpWEEzWE13OXdtVDVKSnZPU083bHlrZHBUR3dFWUlVbFh6?=
 =?utf-8?B?OHFQVkx6N1RvN3drTWlIMk9lTVB3enVmbTUwYXo3Nlpja2F3VHJ0T3d2Qk5E?=
 =?utf-8?B?RnNQczRHZEhiRGcwZVAyWng4V083QzZRaitaUFdqWkNTMUQrQTBkV3Btc3Vh?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B4C929328AC344698D4138C64BDEA5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abebc217-45d0-4e13-cbd4-08db3e988069
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2023 16:34:51.3157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPiOuZEY24w34KB+TNNxvQ+ehCE8wwwL5tOfY7VJzMZW1P+5w23kW9EVHbKREzrMKq7Gx/scJAp4eRJbFcVyLacMtqYYMXLeIBKosFEFXPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDQvMTQvMjMgMDg6MjgsIEthbGxlIFZhbG8gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gPEFtaXNoYS5QYXRlbEBtaWNyb2NoaXAuY29tPiB3
cm90ZToNCj4gDQo+PiBFbmFibGUgdGhlIFJTTiBmbGFnIHRvIHBhc3MgY2lwaGVyIHN1aXRlIGFu
ZCBBTUsgaW5mb3JtYXRpb24sIGV2ZW4gd2hlbg0KPj4gUlNOIGNhcGFiaWxpdGllcyBmaWVsZCBu
b3QgcHJlc2VudCAoYXMgaXQncyBvcHRpb25hbCkuDQo+Pg0KPj4gRml4ZXM6IGNkMjFkOTllNTk1
ZSAoIndpZmk6IHdpbGMxMDAwOiB2YWxpZGF0ZSBwYWlyd2lzZSBhbmQgYXV0aGVudGljYXRpb24g
c3VpdGUgb2Zmc2V0cyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbWlzaGEgUGF0ZWwgPGFtaXNoYS5w
YXRlbEBtaWNyb2NoaXAuY29tPg0KPiANCj4gVGhlIGNvbW1pdCBsb2cgc2hvdWxkIGFsd2F5cyBh
bnN3ZXIgdG8gIldoeT8iLiBXaGF0IGlzc3VlIGRvZXMgdGhpcyBmaXg/DQo+IA0KDQpNYW5kYXRv
cnkgV0ZBIHRlc3RjYXNlIA0KQ1RfU2VjdXJpdHlfV1BBMlBlcnNvbmFsX1NUQV9SU05FQm91bmRz
VmVyZmljYXRpb24tQWJzZW50UlNOQ2FwLCANCnBlcmZvcm1zIGJvdW5kcyB2ZXJpZmljYXRpb24g
b24gQmVhY29uIGFuZC9vciBQcm9iZSByZXNwb25zZSBmcmFtZXMuIEl0IA0KZmFpbGVkIGFuZCBv
YnNlcnZlZCB0aGUgcmVhc29uIHRvIGJlIGFic2VuY2Ugb2YgY2lwaGVyIHN1aXRlIGFuZCBBS00g
DQpzdWl0ZSBpbiBSU04gaW5mb3JtYXRpb24uIEVuYWJsZSB0aGUgUlNOIGZsYWcgYmVmb3JlIGV4
dHJhY3RpbmcgUlNOIA0KY2FwYWJpbGl0aWVzIGZpeGVzIHRoZSBpc3N1ZS4NCg0KSSdsbCByZXN1
Ym1pdCB0aGUgcGF0Y2ggdjIgd2l0aCBuZXcgY29tbWl0IGxvZy4NCg0KPiAtLQ0KPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyMzA0
MDUxNzM1NTUuNjA0MS0xLWFtaXNoYS5wYXRlbEBtaWNyb2NoaXAuY29tLw0KPiANCj4gaHR0cHM6
Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1
Ym1pdHRpbmdwYXRjaGVzDQo+IA==
