Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9127B557811
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiFWKom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiFWKom (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 06:44:42 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F34888E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1655981081; x=1656585881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aUi8h4oR90gRpQHEO8ZH1oNO9NXX3W4wk1FLm+KtM2E=;
  b=ojIPnVHHvLq4XULxwD/UCAG/UKAnL1uUl8jU+ekcSjiLCbL7maKlWVf6
   qnlhycRGuZTd9i258KqPptqOiLFn1295rW4Plq9DUwMNbVkR3AWRW55Xu
   Uz4Ko2qqlR5MQxn7SfGdUyZQZ/zN/3U/YB2rtW38RaKNBZSVzCHfhPBlW
   k=;
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHmY1TjagWsg8sv7/hffzEGDkV83ec4zOFllNf8o/dci1yeAIEYeG7hczq45OVD9q8QFA8mlWWn4gwwjNryTj98qZ+CistHPM+5ABoR3yjwkzWpPDUtaLZjUazfbhym5AY/iZkYl1lwVjPuqOVlW7A8KonW9nHRafB3L9T5KKV/LDawiLaVIR+ixJtEnBFvHVkovZasNzBZu91gQeN3CWOPpaDgq180Ey50UEML9+AVAfGMS5v02sQ93+Rc8MAj9cTwR39SF1D2qJN7zUqKvt+gxx6THY6bopQNqFxUptnHriGdtt3w1rdrAxuTon+NaH5IY+fHi5l6wD/CKZJy+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUi8h4oR90gRpQHEO8ZH1oNO9NXX3W4wk1FLm+KtM2E=;
 b=KO6dH5pjfaPqJ9wcEGUTKRVS4FRUxCBj3XkwIRjGPEMfFXCGoqJrDtUQbD9jg5SmpqBTDoiyoKj2kQjSM7PJFP6F/725CSDun6adWYoZSIkpMIb0Yb5NirB/mDdIATEdq/UcG70uYnbdl3lEo3xYM8Dhv8Mi4uTjac1Q/CsxYeo1pzSMTPhgn33Nm5OQHdSMbuD7yvAv4mRUKjNlUXN9Z59Z2ODkgbAhS+HKIzSgEK+XKIyDJUHnQAY3icbOM9v+mBVdz+unmkEjngjo/lp0l8MpFPuO//PvvHK1oMwGfFd163HVV95klWEAqWVya5EQiDVzGz214UpmtBRYLO+5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM8PR02MB8215.namprd02.prod.outlook.com (2603:10b6:8:e::5) by
 CY4PR02MB2309.namprd02.prod.outlook.com (2603:10b6:903:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.17; Thu, 23 Jun 2022 10:44:37 +0000
Received: from DM8PR02MB8215.namprd02.prod.outlook.com
 ([fe80::f86c:2978:e1ad:4af7]) by DM8PR02MB8215.namprd02.prod.outlook.com
 ([fe80::f86c:2978:e1ad:4af7%8]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:44:37 +0000
From:   "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>
To:     Hamdi Issam <ih@simonwunderlich.de>,
        "akolli@codeaurora.org" <akolli@codeaurora.org>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "periyasa@codeaurora.org" <periyasa@codeaurora.org>
Subject: RE: [PATCH 06/11] ath11k: add static window support for register
 access
Thread-Topic: [PATCH 06/11] ath11k: add static window support for register
 access
Thread-Index: AQHYQsPqIOJqflXP3E6VjFpoUOVnPa1dVuNQ
Date:   Thu, 23 Jun 2022 10:44:37 +0000
Message-ID: <DM8PR02MB82150455D841CB5FC744DCC5F6B59@DM8PR02MB8215.namprd02.prod.outlook.com>
References: <1612946530-28504-7-git-send-email-akolli@codeaurora.org>
 <4c708ea3-d027-aa01-e157-17a29889ac44@simonwunderlich.de>
In-Reply-To: <4c708ea3-d027-aa01-e157-17a29889ac44@simonwunderlich.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 285c4a6a-5642-4b4e-12ab-08da55055e85
x-ms-traffictypediagnostic: CY4PR02MB2309:EE_
x-microsoft-antispam-prvs: <CY4PR02MB23099A18BF2D55595C9F7DA28AB59@CY4PR02MB2309.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: diKk6y3VQJKBdeDEsBRggtNAf0Zur1lzak0hPXsnGVzRLcrYC9gXTVvU6n7leRfGdC8ZkAO9HYGacRijLoerqdCrNg1qIwFRGeiTqWL2hWpZfI3gKJUH67io7HzDCgVZ4EHvviulmzuKPZtEOPaNC2NF5f92NpakoDf5sNy2j+ZmkvBMTK0cs10YoA+KBA7TaOHVi6mpA9R5AFSYle3Q05AMmytNMAerB0z84uPO6mvkWh8tUff3dyw43fNbtYKJO0tN8iG/TVSojqvp3yKjX+GmTyisveB/y6phcY7qrVSodyop2ilht9tFrHr73Rj0g4wRpc5RFAYHWNIvu8hQDrYXW/w3fKfPmPJ8xeEGwnc7/mDIhM03LHlsZs1boWr0npYAojp8PIwQbED35onaWkyIeVienvklCUKtDmvMecIGd5CW/sbF6CnOWKStgO9V+gqzaN5B1FjT0bvo4Z9TIXoUyA6TQ8tFaZMB6/MlbrdoQl1EfViyGf0FlwMxUg5wbZVOlqlqN/Xm/J1/JCNta5uG5XEzC2y/ALMD9nUw2iSIZQngVJYTMo5BfJsouJDthUyaJ1G1bm7LG0Z1c0rK5SmfjJuCvf7T/X8i+OAVulItN/CqNT39TenbQwIOi0wryfVYKDc0/XmgKq8Y1TwtzisCrltE2OwUuIbID1cWLggZGOK5UbUWDC9d9MYrB3JEMzZxgO2vuxt60jRj/HrNQxgyNB6ND8fl1sMZywVOSLkgnFtxoZdBHseajfEUzGRFWzOBDGBlW5nCVQFfTkDW5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8215.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(84040400005)(478600001)(5660300002)(7696005)(41300700001)(6506007)(54906003)(38070700005)(53546011)(38100700002)(316002)(110136005)(55016003)(9686003)(86362001)(52536014)(66946007)(66476007)(4326008)(83380400001)(66446008)(71200400001)(186003)(64756008)(66556008)(122000001)(26005)(2906002)(33656002)(76116006)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWw2OEt5TVU1R1A0ZS9NVWZ6dVRBVzJ6cGxoZU9NZEhKcnY1S3RZZmt3TFE3?=
 =?utf-8?B?MjJpbnI1a3RWRU0yZUpwM1VQTTYxU2hhMjFBUWl4QXlLNmxxQW43dWNMcmxT?=
 =?utf-8?B?ZnVpQTZsL3N0YXMxUVVsK3NaQnZhYVVpYVhKN3FyejVkK1ZLQjY0Nm9JazN5?=
 =?utf-8?B?T3I0czh5ckZjTHJoUFpuWmRUZTlEUERHdXhLaUM3MG1zcldvSThyQXd6a0Nz?=
 =?utf-8?B?R1Z4eFV4eVd4ZzQ3ZWM3eTRyTDQ1WkxFWHVzNkJtVEk5SUMzbXIxVFZhUjE4?=
 =?utf-8?B?N2kyenVYclEyVTk1QXFsUko3Q0JRNngydjV2VEhDMnJya3d1QUNDR05Hc2s0?=
 =?utf-8?B?WEN1djFKZElMUVJWQXREclY2U3AxRmIybEJGNk9LbnN4d1NOTzF5SG5DZ0NM?=
 =?utf-8?B?cDZKdmdNbW9HeGdDSnl2RUVwamJFRU9ueG90REE5N2FmeExJNDdVbHZQMG9W?=
 =?utf-8?B?ejJhQVB6UEk5VWRXM0d6RGY0azF5djVtY1kwcWR3UW5yQ0ovSE9pTUhRZ0VD?=
 =?utf-8?B?U1g0U1RhQjVGeldrWUxLdFlXdTB1TmRnS0pTd1ExRWxqNWppZzdzeGhqdUx6?=
 =?utf-8?B?ZEk0ZnZsb2N3MmU3V1YyRDdWZzQwdXM5dTIwMzdtWXppbXIwSjlHQnM3R3Jm?=
 =?utf-8?B?ZE5hYUdZbXhWUVVCSkxSamN1Z0RYYjV5Mms3OEJTemhuOWVHTEtERnl4Rzkz?=
 =?utf-8?B?WkRnT2NGTnZ6NHFmQ3p0WnRuL1MrRlNvV1R3a3lmVjRNVkhBVzF1K1hPVFJZ?=
 =?utf-8?B?TWNjNzJzdE5QRUlYQ3JjQUVHL0xLVjZTUnF5RGdYcWlleStRT25HL3dWYU9L?=
 =?utf-8?B?R1pnbW1lc3hUNHpHd1ozZUhGWjRjamxtaFU2QWJWVHRiS3ppMis4OVZ2dEVN?=
 =?utf-8?B?blVjb1dNNWc5WnFxclpISnFRR2U5MlBORWIyS2VXOVNwelFJV3VSZzFwZ0E5?=
 =?utf-8?B?Nm1MNTZ0NS84YXZPenNWL3F3ZUxIendra3FGWExkRjV4ZmVkRHFCNStDMHdY?=
 =?utf-8?B?Ymt0WDk1TS9IN3JIcERaRUg5VUxENTFxM0Fta3ZSek15VjlQa3VYNFUxUzcy?=
 =?utf-8?B?Z296eGZ0ZmxkWXgrdGpTVklMcytUZzl0ZUw5WUc2cXQ3UVZPR2JPYkJ4Q3ds?=
 =?utf-8?B?OVdPMzBzUmVkTEVOT1Bqd2JUbU82SmNmTk1zazI4RmZ6cks0eGNSUHoyczhl?=
 =?utf-8?B?amJJRnY2VFRHRHZQTTAvVjduRXpaV0RjNFpHNExza1NKQlRkNHZJd2Z6M01C?=
 =?utf-8?B?Y0NBMzUxbGxzOGZiK1BCRDkycDB1Y25GS1EwWjFVZERpa0I2QS9jNmRjeElV?=
 =?utf-8?B?eHFvNzROTFZCQWlma3FRV2FQaWRscktja3MyN3RHQ2JjSmxpdmVlRWVCZ0VS?=
 =?utf-8?B?TW1iYUNleVV6SEFMN0MvOHNLN3Z6aS9PaDVuNldEMndmaldXaWczbW9GV053?=
 =?utf-8?B?TjAwSk1KYW1pemtsNmZlZVcyS1dDNFBIY1BCUk9NVDdoVE1qUUxOVHMzZ0xp?=
 =?utf-8?B?aVdGVG5obnNBdmM0QU5FN3dQR2h4SVp3VW8zUVJORkFhaTVQWnJYSkNtN1lz?=
 =?utf-8?B?M1VDRDF2WHkvL3JFSnI4RnVzaXA4Qjg0akxHZ2J3WWd4RGpscmFyaDZNYmU2?=
 =?utf-8?B?a010RU94c3BjRmwzWEQrN2NkV3d1QXhFbXpOSGJOMzkydlErdzBDa1BCbi9B?=
 =?utf-8?B?R3NnZzBLK3F6STdSako5OWFZZHJYL1I5NkJ6dW9uODZtNjFVZ3I4S1hCdzJS?=
 =?utf-8?B?TkxlR0pUQ0lQZEYwdGw2Mnc5akFycjNrZHJ1d1ZwQ051MThHcy9pUVpZKzdk?=
 =?utf-8?B?RUdUVXljQ2dGaFg0OHdIUGVDVXZQRnprdjNUWmZPK2IxNlhUWHgzaE1pT0kz?=
 =?utf-8?B?OEJmNlhhMmlkTDlmSHplQnN5Uzk5OXpaZGkvY3RSMjZJcitLVHdrWW9JU0NZ?=
 =?utf-8?B?OExSb21SL2xkQzdRV2w3SDBmRUF0a3FxUEZhd3hEcnQySGRDUkhJa0VyR0hO?=
 =?utf-8?B?ZmVEU09qUTdPU1pjVy9aSENBbFRJNEx4UXZveEUrM0lZeUNucUlid1FpbE51?=
 =?utf-8?B?Y1ZkWnY4TXdoRGc5WWNxdytDMVkrd0VaVWZYZVlDcnNWd1ozMjEvWkQwY2l0?=
 =?utf-8?Q?be0L4XQT6YHhDd1NoPtU731aT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8215.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285c4a6a-5642-4b4e-12ab-08da55055e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 10:44:37.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bz3z60OpJlDsSaNOeI++pbk+4/h59mWZY5NPpOLXRQfDNDsFiMD4rCL3oVnSn8w1kLdHNP5eAxVmmXwiIcg2W2m8a823fV5MyjEN2gZam9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2309
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSGFtZGkgSXNzYW0sDQoNClRpbWVyIHZhbHVlcyBhcmUgZmFsbHMgdW5kZXIgdGhlIGZpcnN0
IHdpbmRvdyBzbG90IChkeW5hbWljIHdpbmRvdyBzZWxlY3Rpb24pLiBJdCBpcyBlcXVpdmFsZW50
IHRvIHRoZSDigJxzdGF0aWMgbWFwIGZhbHNl4oCdIGNhc2Ugb25seS4NCkl0IHNob3VsZCB3b3Jr
IHNpbmNlIHlvdSBhZ3JlZWQgdGhhdCBpdCBpcyB3b3JraW5nIHdoZW4gZGlzYWJsZWQg4oCcc3Rh
dGljX3dpbmRvd19tYXDigJ0gaW4gaHcgcGFyYW1zLg0KDQpCYXNlZCBvbiB0aGUgYW5hbHlzaXMg
aW4gdGhlIGJhc2UgcGF0Y2gg4oCcW1BBVENIIDA2LzExXSBhdGgxMWs6IGFkZCBzdGF0aWMgd2lu
ZG93IHN1cHBvcnQgZm9yIHJlZ2lzdGVyIGFjY2Vzc+KAnSwgaXQgc2hvdWxkIHdvcmsuIExhdGVz
dCBjb2RlIGlzIG1vZGlmaWVkIG9uIHRoZSBwY2lfcmVhZC93cml0ZSBjb2RlIGZsb3cuDQpBcmUg
eW91IGZhY2luZyBpc3N1ZSBpbiB0aGUgbGF0ZXN0IGNvZGUgYmFzZSA/DQoNClRoYW5rcywNCkth
cnRoaWtleWFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFtZGkg
SXNzYW0gPGloQHNpbW9ud3VuZGVybGljaC5kZT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAyOCwg
MjAyMiAxMDoxNCBQTQ0KPiBUbzogYWtvbGxpQGNvZGVhdXJvcmEub3JnDQo+IENjOiBhdGgxMWtA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiBw
ZXJpeWFzYUBjb2RlYXVyb3JhLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA2LzExXSBhdGgx
MWs6IGFkZCBzdGF0aWMgd2luZG93IHN1cHBvcnQgZm9yIHJlZ2lzdGVyDQo+IGFjY2Vzcw0KPiAN
Cj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29t
bS4gUGxlYXNlIGJlIHdhcnkNCj4gb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8g
bm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBIZWxsbywNCj4gDQo+IEkgd2FzIHRyeWluZyB0byBy
ZWFkIHZhbHVlcyBvZiB0aW1lcnMgZnJvbSBzb21lIG9mZnNldHMgb24gdGhlIFFDTjkwNzQsIGJ1
dCBJDQo+IGdldCBldmVyeSB0aW1lIGFuIGludmFsaWQgdmFsdWVzICgweGZmZmZmZmZmKToNCj4g
VGhpcyBpcyBleGFtcGxlIG9mIG15IGNvZGU6DQo+IA0KPiAjZGVmaW5lIFFDTjkwMDBfV0xBT05f
R0xPQkFMX0NPVU5URVJfQ1RSTDMgICAgICAweDFGODAxMTgNCj4gI2RlZmluZSBRQ045MDAwX1dM
QU9OX0dMT0JBTF9DT1VOVEVSX0NUUkw0ICAgICAgMHgxRjgwMTFDDQo+ICNkZWZpbmUgUUNOOTAw
MF9XTEFPTl9HTE9CQUxfQ09VTlRFUl9DVFJMNSAgICAgIDB4MUY4MDEyMA0KPiANCj4gI2RlZmlu
ZSBRQ045MDAwX1RJTUVfU1lOQ19FTkFCTEUgICAgICAgICAgICAgICAgMHg4MDAwMDAwMA0KPiAj
ZGVmaW5lIFFDTjkwMDBfVElNRV9TWU5DX0NMRUFSICAgICAgICAgICAgICAgICAweDANCj4gLg0K
PiAuDQo+IC4NCj4gYXRoMTFrX3BjaV93cml0ZTMyKGFiLCBRQ045MDAwX1dMQU9OX0dMT0JBTF9D
T1VOVEVSX0NUUkw1LA0KPiBRQ045MDAwX1RJTUVfU1lOQ19DTEVBUik7DQo+IGF0aDExa19wY2lf
d3JpdGUzMihhYiwgUUNOOTAwMF9XTEFPTl9HTE9CQUxfQ09VTlRFUl9DVFJMNSwNCj4gUUNOOTAw
MF9USU1FX1NZTkNfRU5BQkxFKTsNCj4gbG93ID0gYXRoMTFrX3BjaV9yZWFkMzIoYWIsIFFDTjkw
MDBfV0xBT05fR0xPQkFMX0NPVU5URVJfQ1RSTDMpOw0KPiBoaWdoID0gYXRoMTFrX3BjaV9yZWFk
MzIoYWIsDQo+IFFDTjkwMDBfV0xBT05fR0xPQkFMX0NPVU5URVJfQ1RSTDQpOw0KPiAuDQo+IC4N
Cj4gDQo+IFRoZSBsb3cgYW5kIHRoZSBoaWdoIHBhcmFtZXRlcnMgYWx3YXlzIGVxdWFsIHRvICIw
eGZmZmZmZmZmIi4NCj4gDQo+IFdoZW4gSSBtYWRlIHNvbWUgZGVidWdnaW5nLiBJIGZvdW5kIHRo
YXQgdGhlIGlzc3VlIGlzIHJlbGF0ZWQgdG8NCj4gInN0YXRpY193aW5kb3dfbWFwIiBkZXZlbG9w
ZWQgaW4gdGhlIGNvbW1pdA0KPiAiNDgwYTczNjEwYzk1NTExZTQyZmI3ZDAzNTliNTIzZjY2ODgz
ZTUxYTogYXRoMTFrOiBhZGQgc3RhdGljIHdpbmRvdw0KPiBzdXBwb3J0IGZvciByZWdpc3RlciBh
Y2Nlc3MiIGFuZCBlbmFibGVkIGZvciBRQ045MDc0IGluIHRoaXMgY29tbWl0DQo+ICI0ZTgwOTQ2
MTk3YTgzYTYxMTVlMzA4MzM0NjE4NDQ5Yjc3Njk2ZDZhOiBhdGgxMWs6IGFkZCBxY245MDc0IHBj
aQ0KPiBkZXZpY2Ugc3VwcG9ydCIuDQo+IFdoZW4gSSBkaXNhYmxlZCB0aGUgInN0YXRpY193aW5k
b3dfbWFwIg0KPiAoYWItPmJ1c19wYXJhbXMuc3RhdGljX3dpbmRvd19tYXAgPSBmYWxzZTspIGZv
ciBRQ045MDc0LCBpbiB0aGF0IGNhc2UgSQ0KPiB3YXMgYWJsZSB0byBnZXQgdGhlIGNvcnJlY3Qg
dmFsdWVzLg0KPiBTbyBpdCBzZWVtcyB0aGF0IHRoZXJlJ3MgYW4gaXNzdWUgb2YgcmVhZGluZyBz
b21lIHJlZyB3aGVuDQo+IHN0YXRpY193aW5kb3dfbWFwIGlzIGVuYWJsZWQuDQo+IEkgbmVlZCB5
b3VyIGhlbHAgdG8gc29sdmUgdGhpcyBpc3N1ZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IElzc2FtDQoN
Cg==
