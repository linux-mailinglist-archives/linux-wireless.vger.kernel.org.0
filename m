Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172CC4B2434
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbiBKLXt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 06:23:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiBKLXs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 06:23:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895EBE5D
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644578627; x=1676114627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WD+4PYpMYRN+8sqXu1gahinKzAaS4PW64z08tiKNUJA=;
  b=QcXcvkrXAwLFH9JJXL762dhgnmGtAppxs52JtBifaa+LFRUUvYLoPtKA
   xuav8Ph8Mvz9j9WCagg6C1zejnx+XVLdZ9p8VfKAd2o8NYXbjrXM9oJiF
   0DyoTueUQ51fnx+2rilxnIG39ivo1HBXRBqb0XnIdxOXGf8aaUlAg9mUu
   mBzNbnvljiGvHrIxRTlzYFWkXTJygqBkZxmTiUnr7BaJHIO0x4q8q92yx
   uq3UEhduL3NK0rohyAIIdXCJ5wV/0Wt1PcoXsD5b950vgaZLWHfumcm/S
   Xg5a20adjrJZm2aSRoqoh3e9etzTT4Hedl8RuA63c0b4qbpuLztnIPaxO
   A==;
IronPort-SDR: dU4dv/EBHiltLeu7wOU/ZWPrFrtNGWwK/oTz+hGnwajTPKu8xwxDRwQ5eXOZ88CInaAjhBhJth
 XnXG99/SnJ2PjgTX202tKhAKKRM8TvQ4uSGtuOROo4Z6zJdwdTpuTKtwG2VKVxvP92CVLp4iIL
 ilb2nBGX1tk/95LQHR97K+99LEFI0Ywmu5yaKBUszFOtwdbPBKU3FRwrXpH8zX/ap2nA9DLYju
 uzJdjoBbG2EwqFyHJLSRvhZv2p4nXKo4B1Aq5DDy/l3hoxlvFGkof6FgNjKef5P8FP5sUHh7Vb
 RCSTfejzu6Dj5MT4sn3IR5hQ
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="161916241"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 04:23:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 04:23:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 04:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYwP1PGoqhswEPsMbtAkPKd27NpPtwb7+gbyzSUgki4zLQsbqGxHuHLhZOvbOyqekxo2pDVTiLUl8wLZgpCsTA6u1u514+ZXtpzduUc+zJkvBeyYTVm9Fbnpk0VGsCVAaXufnIzmVHpKF5ex5UHxe9o4IyyiPx1CIZBou3B/ItmUYb06B9ETsdmb2+k+c4LUyQ3O4aTlaW7+ghfwMNv7z++Ky8qWVzSrezeF8/sW8kOCfTMJiTxqz8SOo/oqXkqG3r2kynXreWKuDfPXF+9mY0KlMsjLVClMrDOwtyFcDQiBCRSOmP+WV3gUUo8pJlE20YTOBBsidJpyMsf85f867w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD+4PYpMYRN+8sqXu1gahinKzAaS4PW64z08tiKNUJA=;
 b=AMjP4POhacAoOa1MMgn043UMdJeODb5J/LaYMtmcHCd7i1fVy8QEplgkw0R6C1EObEMZ06b9fBvCIkIytnye5vyMRwPWk6ZVX71hINl1vYlZQKvCiIOpnuFBGzh7GA45kgyarLanTU/QibMduByVeo2Y2FCGyOPi7vHRw5b+YXLNKdLS4O1OtAJXdYTSqcx2Fe9M2psZFzLhQyz9uSFgHkz4iPENyszBWud2ejGglFkRPM/ZkOtHIiItyxEMJnHHA8DrH2aYFKmSUGe/xlYAAOjlLTw8abyRFyrCJnv5LBKVMbyM980R7OafX95T2VygXzG/t2VlYAHIrFI56Z5bDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD+4PYpMYRN+8sqXu1gahinKzAaS4PW64z08tiKNUJA=;
 b=ak3p6JvYoNiwQE9Cp0DtLu/oDIaQubgcn/XLOGz9sp/mnI3TE8elHsmXRJt0raPa8yylsHVk/sbruXf85fieekwKxKxQQK3lMAN7O9UPADI6SY+lMrb4sV7dgNey6ihWMo32lsQO1dxKYQ5QEVOSwiZdMOz1XcrA228XwrZSpiM=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CY4PR11MB1973.namprd11.prod.outlook.com (2603:10b6:903:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 11:23:32 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d%6]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 11:23:32 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <marex@denx.de>, <cniedermaier@dh-electronics.com>,
        <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <ageisreiter@dh-electronics.com>
Subject: Re: Possible bug on wilc1000 [Klartext]
Thread-Topic: Possible bug on wilc1000 [Klartext]
Thread-Index: AdgdBYpowDRGmRhhS4ylc9cEzwODUwAvQHEAACUMdlAAEMyaAAAAOC2AACVbRYAAAIGkgAAB4eeA
Date:   Fri, 11 Feb 2022 11:23:31 +0000
Message-ID: <3b5b6122-be42-571d-d957-d1ea3b4d9014@microchip.com>
References: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
 <97d9da81-f15b-33dd-a66e-9f6dbe2c3b0c@microchip.com>
 <14d8dbd0f9de4bcdb50bd1983b2e4f31@dh-electronics.com>
 <74d9191d-7bf6-2beb-2d3b-700b6a355f68@microchip.com>
 <786b6ca3-1377-fc3d-8c74-d6625a9b4ee4@denx.de>
 <10841d61-e939-6703-e195-c382ca6cebc2@microchip.com>
 <b58861b9-86c4-3319-a183-fab637f79e08@denx.de>
In-Reply-To: <b58861b9-86c4-3319-a183-fab637f79e08@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb1093f1-d471-4f20-e515-08d9ed50ef76
x-ms-traffictypediagnostic: CY4PR11MB1973:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1973C4E5996B9110692842C4E3309@CY4PR11MB1973.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gChOw9Wve+SrqnM11jojnnb+Nf45HbELtyRbkzBNSiGYHezwIU10mY3d7d47BbeBQQfMYV24jT+Olq8TjIC4zYJ1/HYQwW3u0YOefGGl6h3N9Yyv47bzoBr9/mILiZef6LrI0KQ35OBR8bn4oVXmO8/i7cjqHjHqwNTKxT6ap38+qqtbaduqHIpOLv9m4old+2Iwa1ZnRZVObptYvfKX4Se7XtQm+3ilkNCh9sl298oDuYoLhJc02MlGRNxalnMDmEQF1QogSf7G3aH6O/DPwB5IMwPwdxBYdEnPgUhjCMUdBYyNN3+rE8ZPNghW4pPRynBCvTlix/hC6sCYzCPgk9CjhBnyKGaim9EMzfg7W0rJqYb0Wt0fYn54IXw3Xbe4wYvjsFdoZtjE0bhlAzPfRAwC77WBcfjI5wbsmPKbHjlSIphA87jYMeCdlsjj/BbfYn2+F2dzLnhIH4YLbWa1HaqSfdZSx1Ad2lPpzX3C9BSUte7NUHP6ACLvbtD2//si6ThL9XrD2MSEhqvuVeKPWCpZ27Puvjb8L+EzB5QoZDcmU8yMnO/4ekgQvxzLig1MvbwKr9D8UBCzIzxeluGo3X2X1Nnv7nqR7vfzt9wJw4ucE/whkHb39Mb/yIfJ5zF/KyuHA8D3XUy4nBt92BqvcQ+94G0i/HegKUGNF9jcZjHJGXrpopRMltibbciM7uAZGLw+nQiQ3sPKhhGxB53nSYW0uPhlqHmX27ZuFtajsDUkxx8mjLm4rRTp0lPF0Qbqtbe/Xyo5hBt2LtVnNBkr/wa/+eGvjeJa2JcPcQfbPfBFtvV4j9gquuE5tdf6xo7rnhxlYEch6WcApe8kWXwILvkndrUjQBB4bsZLXIICBiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(122000001)(26005)(38100700002)(2906002)(66946007)(83380400001)(76116006)(38070700005)(316002)(31686004)(2616005)(86362001)(31696002)(186003)(508600001)(66446008)(71200400001)(53546011)(36756003)(8676002)(8936002)(5660300002)(64756008)(6512007)(91956017)(54906003)(110136005)(4326008)(66556008)(6506007)(66476007)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDk3c21PZ1RtdERWRmRQMythVVZhSWR1K3ZnZDRQQ0Q3bnBMcUZuRlhlZ2hl?=
 =?utf-8?B?d0JocUNwaVZGdi9FU0YvL2FWbHViTXpXT0NrbFU1NWZmMUZNYnFqblZKVUVE?=
 =?utf-8?B?bVZGa1d3VFV3RjBZRDE3cTlXTEJFY01VN0NYaFNiQXBUMXpFTVUvT2FWQWda?=
 =?utf-8?B?R2ZuWXhoVG5LODdiMDZDNTRnMFczQlVPdGJCVGIwSTR3NE9STTdqYyszQlRJ?=
 =?utf-8?B?YXdobm85SXpYRXhZQ3RlQWcrVjRqRHhXUEd5T0lya1RoSkFsZVllZTZ1L1cr?=
 =?utf-8?B?dVVNQk5qMDZmbFJKLzBjdVR5NkUxMTNUMEhrR3N3UCtGRTE5aWNGNTNtMko0?=
 =?utf-8?B?ZUgvL0loVlZaNEd0dmZudXBQU0tLakdNRHZCU0FzZ3QrSldDUVFtWnEyMmJU?=
 =?utf-8?B?WmoxRnU2dEpGNmZndURvRi9IemYrcFNLOUpkTC9VNjJyUnhicjFTbk9YeDhM?=
 =?utf-8?B?MjlpcldpRG9yaHk1Nmh0d21RS2lJSDl5aEQ4N3JaOVk5NURWWFN5T3JDd2NQ?=
 =?utf-8?B?dUowVU9heXkybGdvM01lZ2ZFY25XUkVSdTdCSWJGVmhEK1JXaFErMUl1ZnBy?=
 =?utf-8?B?MGpITjJCanJmUVJMNjl6WDY3aFlvYk9GMmRVNjdMRVp4Z3lpMXVibTNXdDN1?=
 =?utf-8?B?ejcxTisxU0Q1THJOaGx4d3dFYm53cXJZVmltTU54RmJ3a2RwNE9zc1Y2MTQ3?=
 =?utf-8?B?MW4yWWhocjNNcGxWTnk1eHIxWXZWYWZYblh5allaN1NDL2NDdFZ6VC96citz?=
 =?utf-8?B?WTgwNktwNVpTaHhON1BSMVp1RnRNbmpPSC90VjBRVjJZVnJPSEg3UTk1U3lu?=
 =?utf-8?B?S2VoRU01ZmFXaGRDR1JYanNmaHREZXRNVlRtV0NhUFZtS3JlVzd6aEdtZTcz?=
 =?utf-8?B?VmxpUTBjRGhwdVQ3aEJnNW4yZ2MvbjJNdDlRcUcxTmE4SGYwVm41UzloZnZi?=
 =?utf-8?B?ZW9IZGxheGFpalpzR01xRjUxSS9ldmpEZE5naUJWc3AxTHRrcmpNR1hzWXJO?=
 =?utf-8?B?NE0xalljNDBPMFZWZDRtWjM3L0FNUGdTcm00VllaZS9lU2ZBRGcySXExRWdm?=
 =?utf-8?B?Nk5lc1hMLzNCYWs3MDMzWTl6eXYrWWNqMTNnMHpQK3VFdmo2WkdEeW54emtl?=
 =?utf-8?B?NUI1bHF3bURUWlNQbXh6SUJzTzNkaXlYUHh1ZGxWelVTNEhCYXJTYTlNUVho?=
 =?utf-8?B?NmNlSklCQk14S1RhRWU1VlhFdVJkWFQzTjdqU0xQUGFoWEY4aGl6djZxbkM1?=
 =?utf-8?B?cUdlTXJPQjJLamVzeUcwVHJ1ZmNBc0VFK1Jqc0FBSnozeFlMcmlLNE0vTStR?=
 =?utf-8?B?eXJqTTNjWnNNT1ZPUXRCUXk1NVZ2WUYvOWxqK1dMRUROMS9CeVNpc2RIRkdz?=
 =?utf-8?B?Z0dKVnNVVlNpMDhmWHZITlVVMnRDSTd5Y2YrbUN2ZzNrTFBFNGg0M1kyUEtO?=
 =?utf-8?B?N245c05BL0tyalpKWmp1ZkRqbnJqSVRjVEI4dXJ6ayt6Q1Q1SzhvWm5lQWtn?=
 =?utf-8?B?cUswd1pIUlRQVEFoemg3WmhRMHNlKytzVlcwLzVMakxqb2xxVlhnbkNPZjRB?=
 =?utf-8?B?YnBiNjlNK1pvcnltZ014THNtYXdpbkxNOXBOYUtSL0NRMmlsVzBRRXowc051?=
 =?utf-8?B?d2h3dDY2UzIvWDVYYUdzOGZYeHJaOXp4TkFmWG90Y2VyZ1pMNXZhSE01Qnh0?=
 =?utf-8?B?RS85Vkk5Q2wwN0FpOHBzcmRyZ0R3OGNCNVMzaWJvRWE3Nzk4dmsyUWg2dkdx?=
 =?utf-8?B?SjArR2FqcHprK00rb2t0TzVLN3JlYUhrTGFIekVKZENDWXV3Um1YbU9LdUVk?=
 =?utf-8?B?NEwzL1pUenN6VmN3dFk2YmNDS2YrQWZ5M0UyNGFDclI2b0lXK0M0cmdweHB5?=
 =?utf-8?B?WXhXUklxVlVKWGQ5YjJ5MGxKWTZiL3FHRkRVTERydEFJelRzejMwTVRuaWIv?=
 =?utf-8?B?ZG40SGhDOXdLWFYxM1R1NmZUSXplSlo3ZDMxUm1obXpKU0U2bDEwNGdqZmpK?=
 =?utf-8?B?LzdPcmdqSG5CZEJUVlp5elJWMzRPOEEzbk1KVDNZcHUxQ0s1NGY1UGM4bzdO?=
 =?utf-8?B?VU1NclpHaDhuam9Ma0VxTUtyTHJNaW1vR09uUit0M3RmQXlIbTA2ZG0xc2or?=
 =?utf-8?B?TGZCOHBqcjBJbDYzZmVaMDh6aG82b1hpaEtyWHhsY0l2NU10amI5UnFheW5H?=
 =?utf-8?B?S2lIRGNjanpmdlA5VlNMbFcxYjljSW1ic1dtK01INHVsd3VxckJpbVc5VzFt?=
 =?utf-8?B?eGQzU3Y1Yis2V3ZKbzdKNDNiMnpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BDA981AD191E14B90093AE7FD29AF5D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1093f1-d471-4f20-e515-08d9ed50ef76
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 11:23:31.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQmB2X+E2L7EUwVWSYBNaaIn7AmZt5R7FYJ0d+Gy14s+jjRX1TE8FJBL2QB7pJpwQVgMFE+TXQE7Rgt6jkkp8fe65+aslUxE/02N+S9Y1XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1973
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTEvMDIvMjIgMTU6NTksIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IA0K
PiB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IE9uIDIvMTEvMjIgMTE6MTUsIEFqYXkuS2F0aGF0
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAxMC8wMi8yMiAyMTo1NSwgTWFyZWsgVmFzdXQg
d3JvdGU6DQo+Pj4NCj4+PiBPbiAyLzEwLzIyIDE3OjE5LCBBamF5LkthdGhhdEBtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPj4+DQo+Pj4gSGksDQo+Pj4NCj4+Pj4gT24gMTAvMDIvMjIgMTQ6MTAsIENo
cmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+Pj4+IEZyb206IEFqYXkuS2F0aGF0QG1pY3Jv
Y2hpcC5jb20gW21haWx0bzpBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tXQ0KPj4+Pj4gU2VudDog
V2VkbmVzZGF5LCBGZWJydWFyeSA5LCAyMDIyIDM6MzcgUE0NCj4+Pj4+PiBPbiAwOC8wMi8yMiAy
MTo1NiwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+Pj4+PiBIZWxsbywNCj4+Pj4+
Pj4NCj4+Pj4+Pj4gSSB0ZXN0ZWQgdGhlIHdpcmVsZXNzIGNoaXAgd2lsYzEwMDAgd2l0aCB0aGUg
NS4xNi41IEtlcm5lbCBhbmQgdGhlDQo+Pj4+Pj4+IGZpcm13YXJlIHYxNS40LjENCj4+Pj4+Pj4g
KGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Zpcm13YXJl
L2xpbnV4LWZpcm13YXJlLmdpdC90cmVlL2F0bWVsL3dpbGMxMDAwX3dpZmlfZmlybXdhcmUtMS5i
aW4pIA0KPj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+PiBvbiBhbiBpLk1YNiBRVUFEIHdpdGggaXBl
cmYzOg0KPj4+Pj4+Pg0KPj4+Pj4+PiAjIGlwZXJmMyAtYyBJUF9BRERSIC1QIDE2IC10IDANCj4+
Pj4+Pj4NCj4+Pj4+Pj4gQWZ0ZXIgYSB3aGlsZSB0aGUgdGVzdCBnZXRzIHN0dWNrIGFuZCBJIGdv
dCB0aGUgZm9sbG93aW5nIGtlcm5lbA0KPj4+Pj4+PiBtZXNzYWdlczoNCj4+Pj4+Pj4gbW1jMDog
VGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQuDQo+Pj4+Pj4+IG1tYzA6IHNk
aGNpOiA9PT09PT09PT09PT0gU0RIQ0kgUkVHSVNURVIgRFVNUCA9PT09PT09PT09PQ0KPj4+Pj4+
PiBtbWMwOiBzZGhjaTogU3lzIGFkZHI6wqAgMHgxMzhmMDIwMCB8IFZlcnNpb246IDB4MDAwMDAw
MDINCj4+Pj4+Pj4gbW1jMDogc2RoY2k6IEJsayBzaXplOsKgIDB4MDAwMDAxNTggfCBCbGsgY250
OiAweDAwMDAwMDAxDQo+Pj4+Pj4+IG1tYzA6IHNkaGNpOiBBcmd1bWVudDrCoCAweDE0MDAwMTU4
IHwgVHJuIG1vZGU6IDB4MDAwMDAwMTMNCj4+Pj4+Pj4gbW1jMDogc2RoY2k6IFByZXNlbnQ6wqDC
oCAweDAxZDg4YTBhIHwgSG9zdCBjdGw6IDB4MDAwMDAwMTMNCj4+Pj4+Pj4gbW1jMDogc2RoY2k6
IFBvd2VyOsKgwqDCoMKgIDB4MDAwMDAwMDIgfCBCbGsgZ2FwOiAweDAwMDAwMDgwDQo+Pj4+Pj4+
IG1tYzA6IHNkaGNpOiBXYWtlLXVwOsKgwqAgMHgwMDAwMDAwOCB8IENsb2NrOiAweDAwMDAwMDlm
DQo+Pj4+Pj4+IG1tYzA6IHNkaGNpOiBUaW1lb3V0OsKgwqAgMHgwMDAwMDA4ZiB8IEludCBzdGF0
OiAweDAwMDAwMDAwDQo+Pj4+Pj4+IG1tYzA6IHNkaGNpOiBJbnQgZW5hYjrCoCAweDEwN2YxMDBi
IHwgU2lnIGVuYWI6IDB4MTA3ZjEwMGINCj4+Pj4+Pj4gbW1jMDogc2RoY2k6IEFDbWQgc3RhdDog
MHgwMDAwMDAwMCB8IFNsb3QgaW50OiAweDAwMDAwMDAzDQo+Pj4+Pj4+IG1tYzA6IHNkaGNpOiBD
YXBzOsKgwqDCoMKgwqAgMHgwN2ViMDAwMCB8IENhcHNfMTogMHgwMDAwYTAwMA0KPj4+Pj4+PiBt
bWMwOiBzZGhjaTogQ21kOsKgwqDCoMKgwqDCoCAweDAwMDAzNTNhIHwgTWF4IGN1cnI6IDB4MDBm
ZmZmZmYNCj4+Pj4+Pj4gbW1jMDogc2RoY2k6IFJlc3BbMF06wqDCoCAweDAwMDAxMDAwIHwgUmVz
cFsxXTogMHgwMDAwMDAwMA0KPj4+Pj4+PiBtbWMwOiBzZGhjaTogUmVzcFsyXTrCoMKgIDB4MDAw
MDAwMDAgfCBSZXNwWzNdOiAweDAwMDAwMDAwDQo+Pj4+Pj4+IG1tYzA6IHNkaGNpOiBIb3N0IGN0
bDI6IDB4MDAwMDAwMDANCj4+Pj4+Pj4gbW1jMDogc2RoY2k6IEFETUEgRXJyOsKgIDB4MDAwMDAw
MDcgfCBBRE1BIFB0cjogMHg0YzA0MTIwMA0KPj4+Pj4+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6
ID09PT09PT09PSBFU0RIQyBJTVggREVCVUcgU1RBVFVTIERVTVANCj4+Pj4+Pj4gPT09PT09PT09
DQo+Pj4+Pj4+IG1tYzA6IHNkaGNpLWVzZGhjLWlteDogY21kIGRlYnVnIHN0YXR1czrCoCAweDIx
MDANCj4+Pj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBkYXRhIGRlYnVnIHN0YXR1czrCoCAw
eDIyMDANCj4+Pj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiB0cmFucyBkZWJ1ZyBzdGF0dXM6
wqAgMHgyMzAwDQo+Pj4+Pj4+IG1tYzA6IHNkaGNpLWVzZGhjLWlteDogZG1hIGRlYnVnIHN0YXR1
czrCoCAweDI0MDINCj4+Pj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBhZG1hIGRlYnVnIHN0
YXR1czrCoCAweDI1YjQNCj4+Pj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBmaWZvIGRlYnVn
IHN0YXR1czrCoCAweDI2MTANCj4+Pj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBhc3luYyBm
aWZvIGRlYnVnIHN0YXR1czogMHgyNzUxDQo+Pj4+Pj4+IG1tYzA6IHNkaGNpOiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4+Pj4+PiB3aWxjMTAwMF9zZGlv
IG1tYzA6MDAwMToxOiB3aWxjX3NkaW9fY21kNTMuLmZhaWxlZCwgZXJyKC0xMTApDQo+Pj4+Pj4+
IHdpbGMxMDAwX3NkaW8gbW1jMDowMDAxOjE6IEZhaWxlZCBjbWQ1MyBbMF0sIGJ5dGVzIHJlYWQu
Li4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSB0cmllZCB0byByZWR1Y2UgdGhlIGNsb2NrIHNwZWVkIHRv
IDIwTUh6IGluIHRoZSBkZXZpY2V0cmVlIHdpdGgNCj4+Pj4+Pj4gbWF4LWZyZXF1ZW5jeSA9IDwy
MDAwMDAwMD47DQo+Pj4+Pj4+IGJ1dCB0aGUgcHJvYmxlbSB0aGVuIGFsc28gb2NjdXJzLg0KPj4+
Pj4+Pg0KPj4+Pj4+PiBJcyB0aGlzIGEgcG9zc2libGUgYnVnPw0KPj4+Pj4+Pg0KPj4+Pj4+Pg0K
Pj4+Pj4gSGkgQWpheSwNCj4+Pj4+IFRoYW5rcyBmb3IgdGhlIGFuc3dlci4NCj4+Pj4+DQo+Pj4+
Pj4gVGhlIGJ1cyBlcnJvciBzZWVtcyB0byBiZSBzcGVjaWZpYyB0byB0aGUgaG9zdCBkdXJpbmcg
dGhlIFNESU8NCj4+Pj4+PiB0cmFuc2Zlci4NCj4+Pj4+PiBIb3cgbG9uZyBkb2VzIGl0IHRha2Ug
dG8gcmVwcm9kdWNlIGl0PyBEb2VzIHRoZSBpc3N1ZSBhbHNvIGhhcHBlbg0KPj4+Pj4+IHdpdGhv
dXQgIi1QIDE2IiBpUGVyZjMgb3B0aW9uPw0KPj4+Pj4gSXQgdGFrZXMgYWJvdXQgMTBzIChzb21l
dGhpbmcgYSBiaXQgbG9uZ2VyKSB0aWxsIEkgZ290IHRoaXMga2VybmVsDQo+Pj4+PiBlcnJvcg0K
Pj4+Pj4gbWVzc2FnZXMgYW5kIGl0IGRvZXNuJ3QgbWF0dGVyIGlmIEkgdXNlIGl0IHdpdGggIi1Q
IDE2IiBvciB3aXRob3V0Lg0KPj4+Pg0KPj4+Pg0KPj4+PiBJIGRpZCBub3Qgb2JzZXJ2ZSB0aGUg
aXNzdWUgd2l0aCBteSBzZXR1cChTQU1BNUQ0IFhQTEFJTkVEICsgV0lMQzEwMDANCj4+Pj4gU0RJ
Tykgd2hlbiB0ZXN0ZWQgaVBlcmYgZm9yIGEgbG9uZ2VyIGR1cmF0aW9uKH4xMDAwc2VjKS4gSSBz
dXNwZWN0IHRoZQ0KPj4+PiBpc3N1ZSBjb3VsZCBiZSByZWxhdGVkIHRvIHRoZSBTREhDSSBob3N0
IGNvbnRyb2xsZXIuDQo+Pj4+IFRyeSB0byBkZWJ1ZyB0aGUgaG9zdCBjb250cm9sbGVyIHNpZGUg
Zm9yIHRoZSBwb3NzaWJsZSBjYXVzZSBvZiANCj4+Pj4gdGltZW91dC4NCj4+Pg0KPj4+IEl0IHNl
ZW1zIHRoZSB0aW1lb3V0IGhhcHBlbnMgYmVjYXVzZSB0aGUgY2FyZCBmYWlscyB0byByZXNwb25k
IHRvIFNESU8NCj4+PiBjb21tYW5kIDUzLCByaWdodCA/DQo+Pj4NCj4+DQo+PiBZZXMsIHRoZSB0
aW1lb3V0IGNvdWxkIGJlIGZvciBhbnkgcmVhc29uIGxpa2UgZWl0aGVyIHRoZSBDTUQ1MyBoYXMg
bm90DQo+PiByZWFjaGVkIHRvIGNoaXAgb3IgcmVzcG9uc2Ugbm90IHJlY2VpdmVkIGNvcnJlY3Rs
eSBhdCBob3N0IGVuZC4NCj4NCj4gVGhlIHByb2JsZW0gaGFwcGVucyBzZWNvbmRzIG9yIHRlbnMg
b2Ygc2Vjb25kcyBpbnRvIHRoZSB0ZXN0LCBzbyB0aGVyZQ0KPiBtdXN0J3ZlIGJlZW4gQ01ENTMg
d2hpY2ggcmVhY2hlZCB0aGUgY2FyZCBiZWZvcmUgdGhlIHByb2JsZW0gb2NjdXJyZWQsDQo+IGFu
ZCB0aGVyZSBtdXN0IGhhdmUgYmVlbiBhIGxvdCBvZiB0aG9zZSBDTUQ1MyBiZWZvcmUgdGhlIHBy
b2JsZW0NCj4gaGFwcGVuZWQgdG9vLCBzaW5jZSBDTUQ1MyBzZWVtcyB0byBiZSBzb21lIGRhdGEg
dHJhbnNmZXIgQ01EID8NCj4NCj4+PiBJcyB0aGVyZSBzb21lIGVycm9yIGxvZ2dpbmcvdHJhY2lu
ZyBmdW5jdGlvbmFsaXR5IGluIHRoZSBXSUxDMTAwMA0KPj4+IGZpcm13YXJlIHdoaWNoIGNhbiBw
cm92aWRlIGZ1cnRoZXIgaW5mb3JtYXRpb24gd2h5IHRoZSBjYXJkIGRpZCBub3QNCj4+PiByZXNw
b25kID8NCj4+DQo+Pg0KPj4gV0lMQzEwMDAgU0QgbW9kdWxlIGhhcyBVQVJUIHNlcmlhbCBkZWJ1
ZyBwb3J0IGZvciBmaXJtd2FyZSBsb2dzIGJ1dCBJDQo+PiBkb24ndCB0aGluayBpdCB3b3VsZCBi
ZSB1c2VmdWwgaGVyZSBiZWNhdXNlIGl0IG5lZWRzIHRvIGJlIGRlYnVnL3Byb2JlDQo+PiBhdCBT
RElPIGJ1cyBsZXZlbC4NCj4NCj4gSXMgdGhlcmUgc29tZSBvdGhlciBraW5kIG9mIGxvZ2dpbmcg
d2hpY2ggY2FuIHRlbGwgdXMgbW9yZSBkZXRhaWxzIG9uDQo+IHdoZXJlIHRvIGxvb2sgZm9yIHRo
aXMgcHJvYmxlbSA/DQo+DQo+IE1heWJlIHdlIGNhbiB0cnkgbW9uaXRvcmluZyB0aGUgU0RJTyB0
cmFmZmljIHdpdGggZnRyYWNlID8NCj4NCj4gQW55IG90aGVyIG9wdGlvbnMsIHNob3J0IG9mIHRh
a2luZyB0aGUgaGFyZHdhcmUgYXBhcnQgPw0KPg0KPj4+IENvdWxkIGl0IGJlIHRoZSBjYXJkIHN1
ZmZlcmVkIHNvbWUgc29ydCBvZiBGSUZPIG92ZXJmbG93ID8gVGhlIE1YNlEgDQo+Pj4gaXMgYQ0K
Pj4+IGJpdCBtb3JlIHBlcmZvcm1hbnQgdGhhbiB0aGUgQ0E3IChJIHRoaW5rPykgU0FNQTVENCwg
c28gbWF5YmUgdGhhdCANCj4+PiBwbGF5cw0KPj4+IHNvbWUgcm9sZSA/DQo+Pg0KPj4gQXMgSSB1
bmRlcnN0YW5kLCB0aGUgaXNzdWUgaXMgb2JzZXJ2ZWQgd2l0aCBiYXNpYyBpUGVyZiB0ZXN0aW5n
KGxlc3MNCj4+IHRocm91Z2hwdXQpIHNvIG5vdCBzdXJlIGlmIHRoZSBob3N0IHBlcmZvcm1hbmNl
IHdpbGwgaGF2ZSBzdWNoIGFuDQo+PiBpbXBhY3QuIElJUkMgZmV3IG9mIHRoZSBjdXN0b21lcnMg
YXJlIHVzaW5nIHRoZSBzYW1lIGhvc3QoaS5NWDYpIHRob3VnaA0KPj4gSSBhbSBub3Qgc3VyZSBp
ZiBpdCdzIG92ZXIgU1BJIG9yIFNESU8gYnVzLiBUaWxsIG5vdywgSSBoYXZlIG5vdCBjb21lDQo+
PiBhY3Jvc3Mgc3VjaCBsaW1pdGF0aW9ucyB3aXRoIHRoZSBzcGVjaWZpYyBob3N0Lg0KPg0KPiBU
aGF0IGlwZXJmIC1QIDE2IGhhbW1lcnMgdGhlIGNoaXAgd2l0aCBhIGxvdCBvZiBzaG9ydCBwYWNr
ZXRzLCB0aGUNCj4gcHJvYmxlbSBkb2VzIG5vdCBvY2N1ciBkdXJpbmcgaXBlcmYzIC1QIDEgcnVu
IG9yIFVEUCBpcGVyZjMgcnVuICh0aGF0J3MNCj4gdGhlIG9uZSB3aXRoIGxvdyB0cmFmZmljKS4g
SGVyZSB0aGUgaW50ZXJmYWNlIGlzIHNhdHVyYXRlZCwgdGhhdCdzIHdoeSBJDQo+IHNwZWN1bGF0
ZSBzb21lIHNvcnQgb2YgRklGTyBvdmVycnVuIGlzIGhhcHBlbmluZy4NCj4NCg0KQnV0IGVhcmxp
ZXIgaXQgd2FzIG1lbnRpb25lZCB0aGF0IHRoZSBwcm9ibGVtIGRvZXNuJ3QgbWF0dGVyIHdpdGgg
b3IgDQp3aXRob3V0ICItUCIgb3B0aW9uLiBTbyBpdCBzZWVtcyB0aGUgaXNzdWUgaGFwcGVucyBk
dXJpbmcgc3RyZXNzIHRlc3QuDQoNCj4gSSBoYXZlIGFsc28gbm90aWNlZCB0aGVyZSBhcmUgc29t
ZSB3aWxjMTAwMCBkb3duc3RyZWFtIGRyaXZlcnMgd2l0aCBodWdlDQo+IHN0YWNrcyBvZiBwYXRj
aGVzLCBidXQgSSBuZXZlciByZWFsbHkgZmlndXJlZCBvdXQgd2hldGhlciB0aG9zZSBhcmUNCj4g
c3RpbGwgcmVsZXZhbnQgb3Igd2hldGhlciB0aGUgdXBzdHJlYW0gd2lsYzEwMDAgZHJpdmVyIGlz
IHBlcmZlY3RseQ0KPiBmaW5lLiBJIHdvdWxkIGxpa2UgdG8gYmVsaWV2ZSBpdCBpcyB0aGUgbGF0
ZXIsIGlzIGl0ID8NCg0KWWVzLCB3aWxjMTAwMCBtYWlubGluZSBkcml2ZXIgaGFzIGFsbCB0aGUg
cmVxdWlyZWQgY2hhbmdlcyBleGNlcHQgZmV3IA0KbWlub3IgYnVnIGZpeGVzIGFuZCBuZXcgZmVh
dHVyZXMgYnV0IG5vbmUgcmVsYXRlZCB0byB0aGlzIHNjZW5hcmlvLg0KDQoNClJlZ2FyZHMsDQpB
amF5DQoNCg==
