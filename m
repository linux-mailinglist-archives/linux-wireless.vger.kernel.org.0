Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F74B22EB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 11:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbiBKKPM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 05:15:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBKKPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 05:15:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2E7B38
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 02:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644574511; x=1676110511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5IfsZpTDZXNNe8iT0SDgZqLfNLXKQs+Kq304oUJXfxI=;
  b=lfctvoc5i6l4d/9rYvQB/SOzRZ5qJyFMknJizvNk0dVr03jnCBWZaa3Y
   ZwHbHYso0rv1cDGO6Rl9hozDhVpdrsBqWgwwPI6MZzH2cSc95Tk5bUO0L
   0rLDAHN+HujwYhfW2hYPrFJLOpEWOvn0rLyJ7uKXf/Oq/VkKN+FCtc65e
   +mDdSCoUKpgxiaYXiPDNyXM7agCkOG3jgMFqkXWx5Nf2q+aReHiXqEoef
   8BHYceaC+pZjvglwdM06JgTq2RsK7k27KbiRF7o6DkpGd3A54JLvRPiCR
   I48V478R5MGzNWZdFvYa2pvlyQ3Yjwvb5J6HhEFC27Vh5NIs0H5GpRriN
   w==;
IronPort-SDR: ql4/BkhEnUMcksB9D0HQ1Hq6K6P/A3Oifl7Tmrh1DLiSAJEC5swKvp5LSD2H+axkyd5KHADUvi
 Na2/FxG9h4vFn/541qwQ1NqhM/Axjaotl7YACj/hb3tN35rGcVfpLBWp6vGo3G/+w3LbqKtROw
 Pk56Z2RkxbuhrSHJi4dSseTf4KaP+4lQgCZDK/LVbwXICmDBOnAUqquglHnB9/sfgPtUr5uvqd
 yOeW8U627CiupRFErB8yMeg6yo0P8ud1Hmf9VLx8ZpfcGWNSJ1F2YFxetbXSKSGZ93YsmFP2MT
 FHFWMrWciJ1CjJQY/PJu+9BA
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="85412075"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 03:15:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 03:15:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 11 Feb 2022 03:15:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbkJxEBGtTW/T689TStLQQMyOUtDzaHx1KzJU1iSuPr3jMDWla0/GAyG0NdiqxhHLpH4ehb1vnmwnx8Loef33jnyzWJaKdRA+wuBpxQq2W3MHZNzaWOioo2UkcvTfMxXuEPlIJYaKM50U1u26OHjDrL4f80rcR38KrqVd+Edc0Cr+7r4iFJKnmizw1qGkkahzTOmUokDFDEkSjFBMs1GdYAdirzSsfToslisrjQBmXleAGOSqgCBq4EQMj3dQCy1O0KhhxPLgNiCM7yXvtaW34KAAKa5FErhr/0O01r7n02R2+lFZU3xO3XybAYb0/SoaZu+WV2nWuu9wn0LKU6wcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IfsZpTDZXNNe8iT0SDgZqLfNLXKQs+Kq304oUJXfxI=;
 b=MFFpZVw7HF+PfXKYr4xeyVRuKoalJQ7G7xEW/f1BzUHKb+Y8fOg++dMclzN/MHW7AdRlZyWG7De2a8OgHxiKaDDVIb2IvL7yzFcd5fOjODx6Bb+bZiMNkTTrQXZ7OKzqxK9XYzciaYH7I2hkujQOIvt8pOgp0TOwNHBlWGLGBH0itYJ7vMQQ48ExKyjS9pW1EkB06V2/f7mZp0YOBltKC0q8QxA4YI+dP219OdC8A6Md9WYWbq1QkpXZ8y57xFaG+aC7C88b8uU2GqnGM6dWcn1Ta9ecIYT58C+uoue013UbESm2icBqX7vHiExEaL81ZtWEosY+FCt+k65QjwcQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IfsZpTDZXNNe8iT0SDgZqLfNLXKQs+Kq304oUJXfxI=;
 b=Tco8sz60/emEdojhrGt87YKe+j5UmA6B9z9wp673+Fn6oGSQoA35NssAx1hdZq9wuUBSrG8tIEGnS29opN7Bqs0fxIN0Ha45xxKQY8gjEVyBMbGX31ujF0niAnVEYqaydbknv2yrsOWMyB9TG9xXH5YZ/r1qOTgS5YXKK6KUHwM=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by BYAPR11MB2567.namprd11.prod.outlook.com (2603:10b6:a02:c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 11 Feb
 2022 10:15:07 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d%6]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 10:15:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <marex@denx.de>, <cniedermaier@dh-electronics.com>,
        <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <ageisreiter@dh-electronics.com>
Subject: Re: Possible bug on wilc1000 [Klartext]
Thread-Topic: Possible bug on wilc1000 [Klartext]
Thread-Index: AdgdBYpowDRGmRhhS4ylc9cEzwODUwAvQHEAACUMdlAAEMyaAAAAOC2AACVbRYA=
Date:   Fri, 11 Feb 2022 10:15:07 +0000
Message-ID: <10841d61-e939-6703-e195-c382ca6cebc2@microchip.com>
References: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
 <97d9da81-f15b-33dd-a66e-9f6dbe2c3b0c@microchip.com>
 <14d8dbd0f9de4bcdb50bd1983b2e4f31@dh-electronics.com>
 <74d9191d-7bf6-2beb-2d3b-700b6a355f68@microchip.com>
 <786b6ca3-1377-fc3d-8c74-d6625a9b4ee4@denx.de>
In-Reply-To: <786b6ca3-1377-fc3d-8c74-d6625a9b4ee4@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d364176e-31c2-4781-5b67-08d9ed4760e6
x-ms-traffictypediagnostic: BYAPR11MB2567:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2567724A001B70C35C1C3751E3309@BYAPR11MB2567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OIx/KeRa46YFRl/Xke3HWMYzGl1Zx0gkBTkDfDKSpDgE2nSKR17gX69OFruzctYHUwi8cPEweSwjjvc857Cd1E0igz2kGoFUPvcOOZk0Ob736Q4mDqymjPL9RD/Wh/gtPU/EEdJzWXqSvg4A+Qtrd2/YoB+mdk3N9dNuvzXwUSEEXQ7m4L5p5CxFIcIPNKvO0U+RjYuWKhXNr7Pf1nlgglZtqLzihPF8bTOCrZyvMMSYhC++YypVemSK4BM8zTFijoHWjjkILd8FsEnjUm9ievL7EzEZK/s8v3VQ10+s9nSbXH0B+M8p8PeMkvBpt63IpwfoPV+Lp+xxCYXtCMu/Iz9kmEFe2sOhoSGhYJ3f4xEeS4/2LLvwe92+bgAAVs/j7B8TgoIbYrMqQLHUt9LmueyVHDcEjkl25Iz9Ts6MXujJKWndEtjXnv8xT1JrlA2ppJa7eTF2k55HhYgaHxZeCBWWbQOKU0/aJUVVWaxtCTUdWAPPktxEXm29GEeegDs74GiS7kb0ZRZnR9zOCpzJ/DX2xL6hUamwf0TDmv/7JaZSDHxoKIVmvOgnq2C6LOZ+ri6aSeswhcWOb6M/nEhOqpX5SPnZfsUUT4IPNj0C2knzzciaxZsYsLivnkbevq9g9SZ/MaLUrk2uNiFxBk9X6WZnGTox4Pysl0PVYNzlmGIej7jJsDQZEnAjE1lI9gSvpELVjcK70C+XyY56z/LOKo5WCedl6pN8e1LrF6eF6zq+JKQfouTvRqPKD/qcvC6+spDHuqp9VJF1Kj2rIZhKAs2veU82NXObfX4zxAtfarjS2GfGa7rKrsz+oLSHCIxu/5o5HWocDy9hlBiqajXIHohzr54NYRX2NGaDh4JXBd8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2906002)(26005)(86362001)(71200400001)(31696002)(508600001)(110136005)(36756003)(31686004)(316002)(54906003)(4326008)(8676002)(8936002)(91956017)(76116006)(38070700005)(6512007)(2616005)(122000001)(5660300002)(64756008)(66476007)(6486002)(6506007)(55236004)(53546011)(83380400001)(66446008)(38100700002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z013QksycUJxRzVRVXFyOFV4T1RTOFdrUVdKT0kzNnRQajNBTzdmb2lpd0RY?=
 =?utf-8?B?Q0xiYVJQSEpjdzhic3pudGluUndEODhUeFg2MDhwVGtPTVpNcmFRcVJYSlM2?=
 =?utf-8?B?YVJUelFpV0RNTHZFYVJpeXhmTWxPa2pRemh2SDBySWdweTdxcEtsTFg2MFpD?=
 =?utf-8?B?OHZaUGRYcUF3MjJYelVWNWRUR2xsTVJKdkp5TDE5enNmN2s3TzVUOXpXczNB?=
 =?utf-8?B?eDRKdGJaVnBiMjhJZUxGMDRjSlhBMjlCaE5sbHMzanQzb3p0a3RmdHpRUmFN?=
 =?utf-8?B?eEpOY2hQR3ZTR1c2Ti8wUU54NmxybVFhenNhYUZoNk03bGg4eGN4U2hJWFA1?=
 =?utf-8?B?TkQxWHdRUnUxOUJGbGx1cXA2WE9KOS9hSW5OTXNjT1JmdkdoK05nUk5GWnJN?=
 =?utf-8?B?RnBPNk1DTmVlb0pnVXhHd0gvZTJpUUZ5VWZ2S2dsY3VzZ1c2VDFMTTh3czh1?=
 =?utf-8?B?STY3eE5yTnFWaW9Ncmd2NHZIN29oVlNwM2oyQWFHK0RheDVBaGZldFBnczZP?=
 =?utf-8?B?UmJHTmNVMEFMYjduelBJMENiZGFzU2MzR1hLaitzTkdaVzlBT3JPZDI3U081?=
 =?utf-8?B?cHB1RlpCNjRXWGpXWXg4TGI3QmROSDNUSkdMSlM3Tm9sbk5jOWJnL3l1WlV6?=
 =?utf-8?B?Y2ZPT3dxL0Mrc29xc2Y4c0YzT1ViRXhJZUtUUHh6UEhYK3NGZDdzRFhMTkpV?=
 =?utf-8?B?SUpwcTBGMWRHaTl0alBnMndzVGdwTG81TDVlQ1ljL3drR3JWejdZc2pmWC82?=
 =?utf-8?B?MW93NTJCY1dzVndheVRLVzVkTTFLdVBTWDgwVDh0S1JleWJibzZGQWpORERV?=
 =?utf-8?B?YTBTdzhxYll4SXJKS1B5MGZYbXc0b2JaTGUwbmpaVSs0R2NERjBDdXFndlZ3?=
 =?utf-8?B?Nlo3ZE01aExGM2p1aTJTOWZTb2dvMEZnTDVFSTZDdkZRNEVlcHBpTVdqN0Ns?=
 =?utf-8?B?UUQ4Zm9TSkx1NUNTWXo5TkRiMXNPdkVraGV3QmZNRnhJTVNEc1IxN3N3L3lo?=
 =?utf-8?B?Zks3K212RGJVODhsWFhUZjNsM2toR2M0V1BUNTRhYk5CTmRQTmI5ckIwckdO?=
 =?utf-8?B?a3UrSUNJT0x0S2gxdHp5MUltSnBYcXpSaUFMNkJNdWJ5Wkt2WmZzbVFFSnJz?=
 =?utf-8?B?N2lrcjJPQTZ0dDlOZFdPd21rS3JQOWlRVzhGUnVFcFhmc2g0aWhoMUx6RG5Y?=
 =?utf-8?B?dDJJUWl2ZmRiK3hFbDdwcVh4V3ZXK2puMjJTVmMzNkJNWDFpZVh4N2xFR2hk?=
 =?utf-8?B?clIrcWg4ZVNQRXZ0Wndkd0dnYlRNcGpUMHAzeVpkdTVpSjRZREh1UWhFK21v?=
 =?utf-8?B?b2I1b2IzaWFpNXNWZ2V3SXQ3d05jd2YvcjNiVHpxNlFFWDBCemw3QUllcmJj?=
 =?utf-8?B?RHd1aUx5cENhckRweThZY3FqRmlHTVhYMkJEZjZUeEFualhRWXI0ZHhCRVBx?=
 =?utf-8?B?L1dRSm4vd2MwMGplU1EvYkJvNittMU5nSU92a1g5bXVLZVZ2eUR5OEcwcDU0?=
 =?utf-8?B?RWZwZEpkd0lmWGVWbW02d0pKRGdIRy9rQlNyb0VPZmcxL3Q4Mk1pSHArSGNK?=
 =?utf-8?B?TldjSDBpQmF1UVNKSEl4TWlSYWRLQWs1eVY0T1p3dU1iM05IV1dQYWo0dVpx?=
 =?utf-8?B?UjNUejRhb0RBN2hqNlRMZ1NRc3MyL0RleUM1RVBOMjYyWGdSZW14M2xPSnc3?=
 =?utf-8?B?bCtlSUN0czZzR2F2Q2l2SG9HQ2grY0wyT1pqcFRJNkdCa2U4M3loL0g0K0w3?=
 =?utf-8?B?bW5WckNIRzBzVUlRSXd1REdDYTRsTlY0T1pKK2w1SldhdzlDWjVzN1RzUXNF?=
 =?utf-8?B?bFc1QzVUOVArbjRlcnVFZ3pNc3dKYTZFbisxa0M0dE9JMVhaWlIrY0hRbkRI?=
 =?utf-8?B?ZVhIdlZnZUVPdnhnb1JPQ1A0ZUw5N0pVRUVLSzB5SW5CcXk5UGwwK1ZXS0dR?=
 =?utf-8?B?ZDhXNHpLM2hCYTFucmdrMThJR3JEZHFvaVI5THlSb1RwVEFpZVhkUmo3R3V6?=
 =?utf-8?B?L1ZiK0pUN01tQ2U5cytLaUxqcXhROTZjamRmVzVuRVVCR3I2MUZhd0g1RVJi?=
 =?utf-8?B?c0JwcUw0R2JRbGJvZmtVS2NQQk1aVm1xNlVWS2RaaCsvQnBWNjNEeWpaV01G?=
 =?utf-8?B?dEdxMXRLRzJhV1Z3bjR5SHRUZGtOTFppZ2JGM3hyTkdhWDBtVTVTcVAwTkdI?=
 =?utf-8?B?UUxlUEd0TGNjeG5Jb00vRXlHRWtkWVhMT1Q4VzZpcStzUXRBWUVXUDdYbkRP?=
 =?utf-8?B?RjNEZTRITUhnc1NNbTMyZ28ySGR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1E9034ED77F89468A5D886CEC8B41DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d364176e-31c2-4781-5b67-08d9ed4760e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:15:07.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbJArGQvT4RXKohNpmsF0E23uALvcDLiDA3rSoMCKjiltWPP6+M6yEQ2JEych4Jd73RiZJgS0mmTJoIXHNraZzlZTo1iWOSE3gVEDTGBDgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2567
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTAvMDIvMjIgMjE6NTUsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPg0KPiBPbiAyLzEwLzIyIDE3
OjE5LCBBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPg0KPiBIaSwNCj4NCj4+IE9u
IDEwLzAyLzIyIDE0OjEwLCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+Pj4gRnJvbTog
QWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbSBbbWFpbHRvOkFqYXkuS2F0aGF0QG1pY3JvY2hpcC5j
b21dDQo+Pj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA5LCAyMDIyIDM6MzcgUE0NCj4+Pj4g
T24gMDgvMDIvMjIgMjE6NTYsIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+Pj4+IEhl
bGxvLA0KPj4+Pj4NCj4+Pj4+IEkgdGVzdGVkIHRoZSB3aXJlbGVzcyBjaGlwIHdpbGMxMDAwIHdp
dGggdGhlIDUuMTYuNSBLZXJuZWwgYW5kIHRoZSANCj4+Pj4+IGZpcm13YXJlIHYxNS40LjENCj4+
Pj4+IChodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9maXJt
d2FyZS9saW51eC1maXJtd2FyZS5naXQvdHJlZS9hdG1lbC93aWxjMTAwMF93aWZpX2Zpcm13YXJl
LTEuYmluKSANCj4+Pj4+DQo+Pj4+PiBvbiBhbiBpLk1YNiBRVUFEIHdpdGggaXBlcmYzOg0KPj4+
Pj4NCj4+Pj4+ICMgaXBlcmYzIC1jIElQX0FERFIgLVAgMTYgLXQgMA0KPj4+Pj4NCj4+Pj4+IEFm
dGVyIGEgd2hpbGUgdGhlIHRlc3QgZ2V0cyBzdHVjayBhbmQgSSBnb3QgdGhlIGZvbGxvd2luZyBr
ZXJuZWwgDQo+Pj4+PiBtZXNzYWdlczoNCj4+Pj4+IG1tYzA6IFRpbWVvdXQgd2FpdGluZyBmb3Ig
aGFyZHdhcmUgaW50ZXJydXB0Lg0KPj4+Pj4gbW1jMDogc2RoY2k6ID09PT09PT09PT09PSBTREhD
SSBSRUdJU1RFUiBEVU1QID09PT09PT09PT09DQo+Pj4+PiBtbWMwOiBzZGhjaTogU3lzIGFkZHI6
wqAgMHgxMzhmMDIwMCB8IFZlcnNpb246wqAgMHgwMDAwMDAwMg0KPj4+Pj4gbW1jMDogc2RoY2k6
IEJsayBzaXplOsKgIDB4MDAwMDAxNTggfCBCbGsgY250OsKgIDB4MDAwMDAwMDENCj4+Pj4+IG1t
YzA6IHNkaGNpOiBBcmd1bWVudDrCoCAweDE0MDAwMTU4IHwgVHJuIG1vZGU6IDB4MDAwMDAwMTMN
Cj4+Pj4+IG1tYzA6IHNkaGNpOiBQcmVzZW50OsKgwqAgMHgwMWQ4OGEwYSB8IEhvc3QgY3RsOiAw
eDAwMDAwMDEzDQo+Pj4+PiBtbWMwOiBzZGhjaTogUG93ZXI6wqDCoMKgwqAgMHgwMDAwMDAwMiB8
IEJsayBnYXA6wqAgMHgwMDAwMDA4MA0KPj4+Pj4gbW1jMDogc2RoY2k6IFdha2UtdXA6wqDCoCAw
eDAwMDAwMDA4IHwgQ2xvY2s6wqDCoMKgIDB4MDAwMDAwOWYNCj4+Pj4+IG1tYzA6IHNkaGNpOiBU
aW1lb3V0OsKgwqAgMHgwMDAwMDA4ZiB8IEludCBzdGF0OiAweDAwMDAwMDAwDQo+Pj4+PiBtbWMw
OiBzZGhjaTogSW50IGVuYWI6wqAgMHgxMDdmMTAwYiB8IFNpZyBlbmFiOiAweDEwN2YxMDBiDQo+
Pj4+PiBtbWMwOiBzZGhjaTogQUNtZCBzdGF0OiAweDAwMDAwMDAwIHwgU2xvdCBpbnQ6IDB4MDAw
MDAwMDMNCj4+Pj4+IG1tYzA6IHNkaGNpOiBDYXBzOsKgwqDCoMKgwqAgMHgwN2ViMDAwMCB8IENh
cHNfMTrCoMKgIDB4MDAwMGEwMDANCj4+Pj4+IG1tYzA6IHNkaGNpOiBDbWQ6wqDCoMKgwqDCoMKg
IDB4MDAwMDM1M2EgfCBNYXggY3VycjogMHgwMGZmZmZmZg0KPj4+Pj4gbW1jMDogc2RoY2k6IFJl
c3BbMF06wqDCoCAweDAwMDAxMDAwIHwgUmVzcFsxXTrCoCAweDAwMDAwMDAwDQo+Pj4+PiBtbWMw
OiBzZGhjaTogUmVzcFsyXTrCoMKgIDB4MDAwMDAwMDAgfCBSZXNwWzNdOsKgIDB4MDAwMDAwMDAN
Cj4+Pj4+IG1tYzA6IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDANCj4+Pj4+IG1tYzA6IHNk
aGNpOiBBRE1BIEVycjrCoCAweDAwMDAwMDA3IHwgQURNQSBQdHI6IDB4NGMwNDEyMDANCj4+Pj4+
IG1tYzA6IHNkaGNpLWVzZGhjLWlteDogPT09PT09PT09IEVTREhDIElNWCBERUJVRyBTVEFUVVMg
RFVNUCANCj4+Pj4+ID09PT09PT09PQ0KPj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBjbWQg
ZGVidWcgc3RhdHVzOsKgIDB4MjEwMA0KPj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBkYXRh
IGRlYnVnIHN0YXR1czrCoCAweDIyMDANCj4+Pj4+IG1tYzA6IHNkaGNpLWVzZGhjLWlteDogdHJh
bnMgZGVidWcgc3RhdHVzOsKgIDB4MjMwMA0KPj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBk
bWEgZGVidWcgc3RhdHVzOsKgIDB4MjQwMg0KPj4+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBh
ZG1hIGRlYnVnIHN0YXR1czrCoCAweDI1YjQNCj4+Pj4+IG1tYzA6IHNkaGNpLWVzZGhjLWlteDog
ZmlmbyBkZWJ1ZyBzdGF0dXM6wqAgMHgyNjEwDQo+Pj4+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6
IGFzeW5jIGZpZm8gZGVidWcgc3RhdHVzOsKgIDB4Mjc1MQ0KPj4+Pj4gbW1jMDogc2RoY2k6ID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+Pj4+PiB3aWxjMTAw
MF9zZGlvIG1tYzA6MDAwMToxOiB3aWxjX3NkaW9fY21kNTMuLmZhaWxlZCwgZXJyKC0xMTApDQo+
Pj4+PiB3aWxjMTAwMF9zZGlvIG1tYzA6MDAwMToxOiBGYWlsZWQgY21kNTMgWzBdLCBieXRlcyBy
ZWFkLi4uDQo+Pj4+Pg0KPj4+Pj4gSSB0cmllZCB0byByZWR1Y2UgdGhlIGNsb2NrIHNwZWVkIHRv
IDIwTUh6IGluIHRoZSBkZXZpY2V0cmVlIHdpdGgNCj4+Pj4+IG1heC1mcmVxdWVuY3kgPSA8MjAw
MDAwMDA+Ow0KPj4+Pj4gYnV0IHRoZSBwcm9ibGVtIHRoZW4gYWxzbyBvY2N1cnMuDQo+Pj4+Pg0K
Pj4+Pj4gSXMgdGhpcyBhIHBvc3NpYmxlIGJ1Zz8NCj4+Pj4+DQo+Pj4+Pg0KPj4+IEhpIEFqYXks
DQo+Pj4gVGhhbmtzIGZvciB0aGUgYW5zd2VyLg0KPj4+DQo+Pj4+IFRoZSBidXMgZXJyb3Igc2Vl
bXMgdG8gYmUgc3BlY2lmaWMgdG8gdGhlIGhvc3QgZHVyaW5nIHRoZSBTRElPIA0KPj4+PiB0cmFu
c2Zlci4NCj4+Pj4gSG93IGxvbmcgZG9lcyBpdCB0YWtlIHRvIHJlcHJvZHVjZSBpdD8gRG9lcyB0
aGUgaXNzdWUgYWxzbyBoYXBwZW4NCj4+Pj4gd2l0aG91dCAiLVAgMTYiIGlQZXJmMyBvcHRpb24/
DQo+Pj4gSXQgdGFrZXMgYWJvdXQgMTBzIChzb21ldGhpbmcgYSBiaXQgbG9uZ2VyKSB0aWxsIEkg
Z290IHRoaXMga2VybmVsIA0KPj4+IGVycm9yDQo+Pj4gbWVzc2FnZXMgYW5kIGl0IGRvZXNuJ3Qg
bWF0dGVyIGlmIEkgdXNlIGl0IHdpdGggIi1QIDE2IiBvciB3aXRob3V0Lg0KPj4NCj4+DQo+PiBJ
IGRpZCBub3Qgb2JzZXJ2ZSB0aGUgaXNzdWUgd2l0aCBteSBzZXR1cChTQU1BNUQ0IFhQTEFJTkVE
ICsgV0lMQzEwMDANCj4+IFNESU8pIHdoZW4gdGVzdGVkIGlQZXJmIGZvciBhIGxvbmdlciBkdXJh
dGlvbih+MTAwMHNlYykuIEkgc3VzcGVjdCB0aGUNCj4+IGlzc3VlIGNvdWxkIGJlIHJlbGF0ZWQg
dG8gdGhlIFNESENJIGhvc3QgY29udHJvbGxlci4NCj4+IFRyeSB0byBkZWJ1ZyB0aGUgaG9zdCBj
b250cm9sbGVyIHNpZGUgZm9yIHRoZSBwb3NzaWJsZSBjYXVzZSBvZiB0aW1lb3V0Lg0KPg0KPiBJ
dCBzZWVtcyB0aGUgdGltZW91dCBoYXBwZW5zIGJlY2F1c2UgdGhlIGNhcmQgZmFpbHMgdG8gcmVz
cG9uZCB0byBTRElPDQo+IGNvbW1hbmQgNTMsIHJpZ2h0ID8NCj4NCg0KWWVzLCB0aGUgdGltZW91
dCBjb3VsZCBiZSBmb3IgYW55IHJlYXNvbiBsaWtlIGVpdGhlciB0aGUgQ01ENTMgaGFzIG5vdCAN
CnJlYWNoZWQgdG8gY2hpcCBvciByZXNwb25zZSBub3QgcmVjZWl2ZWQgY29ycmVjdGx5IGF0IGhv
c3QgZW5kLg0KDQo+IElzIHRoZXJlIHNvbWUgZXJyb3IgbG9nZ2luZy90cmFjaW5nIGZ1bmN0aW9u
YWxpdHkgaW4gdGhlIFdJTEMxMDAwDQo+IGZpcm13YXJlIHdoaWNoIGNhbiBwcm92aWRlIGZ1cnRo
ZXIgaW5mb3JtYXRpb24gd2h5IHRoZSBjYXJkIGRpZCBub3QNCj4gcmVzcG9uZCA/DQoNCg0KV0lM
QzEwMDAgU0QgbW9kdWxlIGhhcyBVQVJUIHNlcmlhbCBkZWJ1ZyBwb3J0IGZvciBmaXJtd2FyZSBs
b2dzIGJ1dCBJIA0KZG9uJ3QgdGhpbmsgaXQgd291bGQgYmUgdXNlZnVsIGhlcmUgYmVjYXVzZSBp
dCBuZWVkcyB0byBiZSBkZWJ1Zy9wcm9iZSANCmF0IFNESU8gYnVzIGxldmVsLg0KDQo+IENvdWxk
IGl0IGJlIHRoZSBjYXJkIHN1ZmZlcmVkIHNvbWUgc29ydCBvZiBGSUZPIG92ZXJmbG93ID8gVGhl
IE1YNlEgaXMgYQ0KPiBiaXQgbW9yZSBwZXJmb3JtYW50IHRoYW4gdGhlIENBNyAoSSB0aGluaz8p
IFNBTUE1RDQsIHNvIG1heWJlIHRoYXQgcGxheXMNCj4gc29tZSByb2xlID8NCg0KQXMgSSB1bmRl
cnN0YW5kLCB0aGUgaXNzdWUgaXMgb2JzZXJ2ZWQgd2l0aCBiYXNpYyBpUGVyZiB0ZXN0aW5nKGxl
c3MgDQp0aHJvdWdocHV0KSBzbyBub3Qgc3VyZSBpZiB0aGUgaG9zdCBwZXJmb3JtYW5jZSB3aWxs
IGhhdmUgc3VjaCBhbiANCmltcGFjdC4gSUlSQyBmZXcgb2YgdGhlIGN1c3RvbWVycyBhcmUgdXNp
bmcgdGhlIHNhbWUgaG9zdChpLk1YNikgdGhvdWdoIA0KSSBhbSBub3Qgc3VyZSBpZiBpdCdzIG92
ZXIgU1BJIG9yIFNESU8gYnVzLiBUaWxsIG5vdywgSSBoYXZlIG5vdCBjb21lIA0KYWNyb3NzIHN1
Y2ggbGltaXRhdGlvbnMgd2l0aCB0aGUgc3BlY2lmaWMgaG9zdC4NCg0KUmVnYXJkcywNCkFqYXkN
Cg0K
