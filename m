Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4FA4B6A96
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 12:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiBOLV7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 06:21:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiBOLV6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 06:21:58 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2128.outbound.protection.outlook.com [40.107.23.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDFAB443
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 03:21:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvRqX0dOeajE4XANHufKXMtwbvGDuasgdf8IZjMli1VvO4ViWiIMubpt/calFVTIdaxwvpKrNQiCNiB2mt0rGmcQJDIgp3d5ce7ehzce/7aGs69kVEyo3HFbtAI9evAs8d1hMNf4ak8zakLqVfb/JydMKmtxKVOlh0iClyGZLAFE8htNP+GMxsAUcbyRbTFfa0Mo1mFe7GL1REGtfhsTjcVeNPIV4bZYT36IIKcn99XkG6wqWZb/9IQ+728Lfs069TqVy+JwG1xIcPTd2bnSrjaIQbLgf15wmYACTQm7G13CbEJaoGSoeRGFOSlxTLyUokMwo+k+9zlwFEzz7GIxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNQN3P2H/lMfj3sKyk4nOH+wZqgcktVavfUvoGnoQY0=;
 b=mv1QHJ1gdpgssO92i2f1LZm/AnmwCfSEJ5S9sJG0TZNzvPjiWAqWKOK9n9Zxm0LvV4lif/XVB7TiFxpBz6PI1AM3IESLm8sv47sCAl1yxHgP+ydc8lPurYQ6a3B+S2dZaqgxDesArNSgWG84pYM/bLssLjguJO0bzFBXJn33r38Cl6ZZT4qiQlhJOFCEYNJLCQiJvlKaSMbFRJXNaj6rV6ytublmrjauoH4cLJpM9RMb96EHZIWf2599e0DJ4ubHBwLL6NVWFrJZZgfyalXMhpZU1Rh5Dksp0ieGWHKpgc2ge5XZBEQ3PEfWA1JSUsCtkV4vC96boOchSZm5BYCFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNQN3P2H/lMfj3sKyk4nOH+wZqgcktVavfUvoGnoQY0=;
 b=D/ORdMor6Eje6/Vl5IRfuRzEaq1RcV0B7xYOyI9dCHwK1mXBGx6XpYBCZGaFhPGMsf5iZ+ySGQhRocxRnnEO7b+qag+kniYRTMWXBke2FqoGEMtCdLDYCeo4ED8z6tgsKVJJFSUHHo0MMgBS6poIWE/zlRQLe2dmpcwf+YXnJek=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0319.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Tue, 15 Feb 2022 11:21:46 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fd38:a4c:c1e:4fe6]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fd38:a4c:c1e:4fe6%7]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 11:21:46 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "sharvari.harisangam@nxp.com" <sharvari.harisangam@nxp.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>
Subject: mwifiex_sdio_sd8997 and sdiouart8997 firmware
Thread-Topic: mwifiex_sdio_sd8997 and sdiouart8997 firmware
Thread-Index: AQHYIl43S5UHXeCEDUaYYj+bOze0HA==
Date:   Tue, 15 Feb 2022 11:21:46 +0000
Message-ID: <29ae891b8d244abe4f3681d040a068db83587697.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6adb8f3b-0ecb-4352-c42f-08d9f0755a73
x-ms-traffictypediagnostic: ZRAP278MB0319:EE_
x-microsoft-antispam-prvs: <ZRAP278MB03190A20ADACB1660F312ABCFB349@ZRAP278MB0319.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fC243FZf07p2eS97NIha4g0SywbFw2UZhEMiSANpp9jjPxaYP3i7V2HB8m6h9vS4rDKLw7qxE34ntNtfPZ0sRi2m4IaL3Cj2b6ajjZ4Wu2MciieyQo+YnSAiBeeUVX1wULM4GSycmnZlaUnAZJ1u8q2/ZmB9Y9jOnP9KgBOdXRpti259MMwUfR+mFjUhQUd8lTXQx9fqERjJv7G6hgpoG7XU6d4MPZUaDl9SzbrQwNqMNJD5/Da/VNdZLTA//pqOZTs65oHdwPpLGZpDUIGlCI4Z1V9C5jBQoER/kopg2MGQcLh2rIOo07JQTQomyJOGuGRFnACrbAp5il5sWKV1aq2/fjqjFuYTRIuktjJvGMhn8EiPvvBQfckhonAZcp5UBuKoL+YGhjl5FxnlDLysM6Iw/Oz+L99rd5aYqdDQsy7RpIlQAB7p8reobkS+hHOdToH5HxX8eMUV70XaLRohna+zCodkvHRZQr2TRSQfXSBYkzfPiuinCHb4AIBh4NA3FV4p3O4z7yIZUzHaupD+BnI0gX/w/EIWP9dUihThTL+zFdYR4l+SWBSZwM1n+HTvTqjoeQUjVu7U7kLXk60pZGTzzwrCPeY4LubIpXs/hvhGVjRRf18dgXpzpubv9NTeE4RHEX13GCl5qs1vUb1CHCsmjnfQhu43QwVJaZjOMYG/CZ1FRoriKHxwzKQxfsefoQpc+dLOlLeamEpRDN07paG56LxGOhdZ+nAeNR/wcsc6JAkjILUDBR/bQeDhe75JA8QQDsEl1BE/NdNn/oyad4+N2ld9rcP0TmANP00SU30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(8936002)(66556008)(83380400001)(8676002)(64756008)(66446008)(76116006)(5660300002)(4326008)(44832011)(4744005)(66476007)(2906002)(36756003)(6486002)(6916009)(38100700002)(6512007)(6506007)(508600001)(186003)(316002)(26005)(54906003)(38070700005)(2616005)(122000001)(71200400001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1VaQzNuMmhoMkpJRnlWeGtYUStFTHdTeFhYRTEwV1h2SkdjY0UrTEg3QkVp?=
 =?utf-8?B?N3RtOGhRTkFRM3hGVGdiVjZ1eERYaFByZjFURDRKN25Xcm04Z3VmNnlQOG5t?=
 =?utf-8?B?Z2pBT1k0cHJwTVlHVEtNRHN0bjAvYlFSdmU4bC9SLzVzY1p2ZzNxM0ZNejVN?=
 =?utf-8?B?WE5aald1eS9MSkVHN2ZJaWVDMndxUE14QmhVaXlUV0dZUm16N2t6Nmoyc3ZZ?=
 =?utf-8?B?ZXMwaGxDeGUveFpPVTViK3oxSHhnMjlya3hRSXNiZzZkSGVFdTJVcEgrbEdo?=
 =?utf-8?B?amsyQW9hZUk3S3IwTkVEUUlXM1BIZ0UzMkkzMUpPN0g4V0xGTXd4R1FjZlpw?=
 =?utf-8?B?QmxsZFZ4V092azZ2VWZCNlNZYVJhVnBTbzVROGpyTE5DMGxReExiczc5eGY3?=
 =?utf-8?B?alAyZGZaSTVNejdzU0tDRVhZRHpjSFR2aWRkdms2ZjhSSHpBbGNUdmF2czBj?=
 =?utf-8?B?QnVtU2hUWnZUcmcrZU1pM0tNY3czc2pZYWJYdkVaVnV5TTUwK1BkQkMzNkVE?=
 =?utf-8?B?dk82OU9wSEVRM3hreUlycnFSamRTTXczUmFtNGlIb2k2SzZMb2dnNUFFMUsx?=
 =?utf-8?B?cFc1cnFaUjdXTzV3OHFPMUZVQ1EzbjFSTWxnOStHVldvZnZ4SWRUWURESUhK?=
 =?utf-8?B?enRtakJLb1lPY2E4b282N2crMXc0VmpQVzR3ZkVYaFI3dWt1L0xReHQ3RlJp?=
 =?utf-8?B?YzhiRForaEFrN1R4d0JSRGJLRTlia1hPQmRCUFRCVERDQ1d4amxwaXgybzQ3?=
 =?utf-8?B?ZHk4TldxQUlQYXFCRUozckNRUEp3TjUwMks2UWdCOGJpem93L2VmMzgwQTg5?=
 =?utf-8?B?eExSeGFYcCtYNXhoK2pNSDBTZHBRNVpiYzk1UmhVbTdNWHBnSDJNU041cGhN?=
 =?utf-8?B?dEZtalE2MVNGem5UOVlNUkVLQlhzeFp3SU81VjlYeE1MU052bVZnbWdFcTl4?=
 =?utf-8?B?SytRYUc1OEhOaWxGZFR0MmRLQ0N6Ykh0YTRYYitvWG5iaU5YTDNCWlJaWWl0?=
 =?utf-8?B?RnkzVVpmcmp3K2lNb0xjekdXVmJCeGpiZzBhYzZtYVpLTnZFNjNEODBpV0U2?=
 =?utf-8?B?MGVVUW1PQXl2QzhkVktJd3dtYVRWOEdOMTRFaGE1NkM1ZGJBRGptQ2RDWjBD?=
 =?utf-8?B?cWhzdnJWb25VNmZDZ044WDgvZDUrMFNkR2h2NlE3WmpGK3hYK1BJM1V0Skc3?=
 =?utf-8?B?Q0I3bGhMMlZGb3NIQXJqY3pNRVZMc2VZMnczQ3l5S2hiUGx2NFJQSFVRNURF?=
 =?utf-8?B?aXZhQllHT0txb2pLR0prQ1ZqZk5BNVdwZU1aZHF5QThOdUdYU1VsNFQrWi9U?=
 =?utf-8?B?aitMcUFFV0wvaW41SnozY0VJV1pIT01kMC83TTNTeFl6MTFBeHFLTTJ1V2wr?=
 =?utf-8?B?SFR4bkxnU3Q0Nzl6ZGRNeFFlY1ZCQ2xNcUo4QktRUzA0dzM4dlQ0akFiSXJC?=
 =?utf-8?B?Ly9BdjBvYllCa2MrQlFCMklEa2RsWEE0eE1ZYkFRN2kzSUFLb0IvUHhwTEJL?=
 =?utf-8?B?aCtnRjJoc1ozQk5JeHdDQVQrOGZzcEFGMnh0L2VzdzdYcTRpNVlWY21SZDVu?=
 =?utf-8?B?TDlvcmRzdzVIUjJCOTkxSGdnNUJwcm9IMEZFL2lOU0ROVzEwRW83c1VIeVU1?=
 =?utf-8?B?L1BKZzFuMlRCYUpNT1RQNklWd1pGK2NBNnR3N2VGVW85di9RRmsvK211RjQx?=
 =?utf-8?B?eGFRNlBXbW9jUGg2ejFQMFRlaDBhWUt4ZGkwdFNqcklKMTdSQ0ROb0FMNmJZ?=
 =?utf-8?B?MGhrN0hiT0Z4a0lPMXpvYWE1Wm9jbXdURHpMbStmYTZZdGJlc3F4VzFNRUZD?=
 =?utf-8?B?VnhvNkdxV2NEQ20vcHRzb2J4cGFBUEE1eFFtZjVmK0F3Q1E4SWxWbXZtaHNM?=
 =?utf-8?B?ZUNwbmhxNXU2bEp2L3ZySnFOY2xEeXlibHFNZ0lKenVGNUJOMjVKWkRqU05x?=
 =?utf-8?B?MGs3c2h6VVgxR251eDBnN0RaMWdrS21WUkdEZjcycFVSQjRzVHFTa085OXdy?=
 =?utf-8?B?SG1DWXNDWjFqTml5dGxsTCs2Z2U0U1NIYTdGcGFRdTMyWFBzajBDc2xuUTNM?=
 =?utf-8?B?TXh0WHdlWllMNFl0eXR6bTZnQ1d2dlhVU2NkMEE3ZjdZenNmaEtNLzJnb1Z1?=
 =?utf-8?B?bzQxaElpTnJZbFpVcmZaWUtWdkZmcHhPM3JYWkRJUEdpbGVxU1VYM25PY2R1?=
 =?utf-8?B?dkVudW9KdnNtNTVBb1FmMlJRNFZCNysxbVZ6QnUyU210TTE3SDlRcEtoTGo0?=
 =?utf-8?Q?r07uYuGJn9Xs2nRv9HPQ4M5J/1JKEGz+EGFrfY3B3w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F898BB85B4AD9A488C213FC634C64455@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adb8f3b-0ecb-4352-c42f-08d9f0755a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 11:21:46.8699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2kY8eO/rqft3TLAg3QqGDUhrLY0VAlm41IZ8r+aWfxQyP+boSBDHbsh8HVEWIa0zBNN8TolaD0FrGIoPrSwOycvoF0+adeY3mc7IiVKtb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgdGhlcmUNCg0KSSBoYXZlIGEgcXVlc3Rpb24gY29uY2VybmluZyBmaXJtd2FyZSBsb2FkaW5n
IGZvciBtd2lmaWV4X3NkaW9fc2Q4OTk3LiBTbyBmYXIgdGhlIGRyaXZlciBoYXJkLWNvZGVzIGxv
YWRpbmcNCm1ydmwvc2RzZDg5OTdfY29tYm9fdjQuYmluLiBIb3dldmVyLCBvdXIgbGF0ZXN0IGhh
cmR3YXJlIGhhcyB0aGUgU0Q4OTk3IHN0cmFwcGVkIGZvciBzZGlvdWFydCBha2EgV2ktRmkgdXNp
bmcNClNESU8gYW5kIEJsdWV0b290aCB1c2luZyBzZXJpYWwgVUFSVC4gVGhlcmVmb3JlLCBpdCBh
bHNvIHJlcXVpcmVzIGEgZGlmZmVyZW50IGZpcm13YXJlDQpzZGlvdWFydDg5OTdfY29tYm9fdjQu
YmluIFsxXSBpbnN0ZWFkLiBXaGlsZSBJIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgZXZlcnl0aGluZyBv
biB0b3Agb2YgbGF0ZXN0IC1uZXh0IGJ5DQptYW51YWxseSByZS1uYW1pbmcgdGhhdCBmaXJtd2Fy
ZSBmaWxlIEkgd2FzIHdvbmRlcmluZyBob3cgZXhhY3RseSB0aGlzIGlzIHN1cHBvc2VkIHRvIHdv
cmsgd2l0aCBtd2lmaWV4LsKgDQoNCldvdWxkbid0IGl0IGJlIHBvc3NpYmxlIHRvIGRldGVjdCB0
aGUgc3RyYXBwaW5nIGFuZCBhdXRvbWF0aWNhbGx5IGxvYWQgdGhlIGNvcnJlY3QgZmlybXdhcmU/
DQoNCk9yIGhvdyBleGFjdGx5IGNvdWxkIHRoaXMgYmUgbWFkZSB0byB3b3JrPw0KDQpBbnkgc3Vn
Z2VzdGlvbnMgYXJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuIFRoYW5rcyENCg0KWzFdIGh0dHBzOi8v
Z2l0aHViLmNvbS9OWFAvaW14LWZpcm13YXJlL2Jsb2IvbGYtNS4xMC41Ml8yLjEuMC9ueHAvRndJ
bWFnZV84OTk3X1NEL3NkaW91YXJ0ODk5N19jb21ib192NC5iaW4NCg0KQ2hlZXJzDQoNCk1hcmNl
bA0K
