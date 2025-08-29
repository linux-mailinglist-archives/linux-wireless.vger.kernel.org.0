Return-Path: <linux-wireless+bounces-26868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0770B3C261
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 20:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA477BC792
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC533CEAC;
	Fri, 29 Aug 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h8nNSSSq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC701FCFEF
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491773; cv=fail; b=HeoWeQf2lYJZuTcaPTx6qFi435EzdlSc+TIUPmViQtaAJOqMvLjwRZNTmQK4ae95F3QQgUxpbOV9Oam9hu1eO6cYZuNP9QGvaacSf5hq2qWlRBJX2yvZavq6KGun6HIAbns2fmJM2JYolx4Wq1Cd1Pk3I9mVJuy37M12VR4sFNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491773; c=relaxed/simple;
	bh=2gjw/U0mEXwflwSRewI1v36iMG2a7Spo/qwZwjiT95U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S2+IM+bCCCnLhHJ2B5fkKCRePzBdR3Vkj9bAmAGFgS8x9zwgmTWr7K7t9CDZYpjDp0pHLN8zgnIysYf7q3gUD1bRmiY+ZN/UFifXsSGBgpaVrHiNhpke4XZ5sXLNtGiv/EBgYnT5sRHn2UHn+B6roccI3cbAXoMYDCEX7/+SS34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h8nNSSSq; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC6DgfevyTuEg/gTAjCjr2pUpKl4hCRFSqP3pjrE8iVjU69UZ4a7zUmH0GhSNmzaaaPYE55Vr0+lZYve1IUAVfxUPg77EUHqp0AXp9TSa4pqknN1d2t3e0LpQ7PiPe3OU3By34P2pQHNZEI07JApDmxEcnNKfYL1hOQRUDwFmVm+XCtfGclVG5Rn4nDGOkydh7WvLNUH58eKOpk/qQt0fIPioDUozQeeLoBIXX2uVKiNkZrAaHuyIgEGn0MIBwsdZQXXsf3RXMqXUEUjitRR6A6CLUHGNlFaUOAwpWZJwPfREcWCgkeLNvtosr5D7t7D77hfxlnY6U6wYrVIdbMmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9nsalqnsVuFzDGaUGft+iLyHNHGWM5L6jeBmdLJfnY=;
 b=T1w+lEWtrVN7NJoJfVsZz/so3/Yn5GGSCGkkjmBAKMxzoDSGoO8d7SG3KXYORl4uUeHPxP379LdGSWJy6z62q/KARzuW0w5C+aQ2zhuaDcX8MMNdYAF2a1sPJMn1YLTXGBwdTkz7gH3wxdX4PKF3pTR2aagwhdO7qUVQfhisP3+ZzrzZMkz33ttZNyVgen/b4USyz8pWKwxWuMpQEc1NBJDkZyDz3Zvhe2c1/jtBN2TmfcqKUUU7E7Niw7/K8bFGfxt37BH1VBUi3s0KSX90+jHjjePvXra58TEFqdZ6RJ060Xg5/fpNxLc3xRY9gQCyW9kkJ0UlGSlwXKM8MOaJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9nsalqnsVuFzDGaUGft+iLyHNHGWM5L6jeBmdLJfnY=;
 b=h8nNSSSqw7wrWFu3+d7I7cbwscmEcUaewP4/yqBC9eQAAMYh+TcHn8aDrXqNEIyFWqMQdSf3w1wVDEAC3K7j0wFlYIRfJtr7FEZJ8Brnz1RuHjkzZHtQkl9bIkGkxGjMmhlfS7o8Z5YRyedvZGF6kThlxXNfZTd1qifWaU6WSt69KbrZTcpSSoVqoLGA13ngsTRv9OrTTnntZ3eRasVHhOGdcDX376sdqUBYaexY/rmRn0VaqgS2IaMmSAs3qlx4W/Bkcy1zhRm/9RMbayXFHCTFnJAGDe+EJe0M8MciL757Z5uHeEzGmL4EfbV1xZzzpW9MN+vvPtQaNufuaBcDWg==
Received: from DM8PR11MB5752.namprd11.prod.outlook.com (2603:10b6:8:13::15) by
 SA0PR11MB4655.namprd11.prod.outlook.com (2603:10b6:806:9d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.13; Fri, 29 Aug 2025 18:22:44 +0000
Received: from DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03]) by DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 18:22:44 +0000
From: <Ajay.Kathat@microchip.com>
To: <linux-wireless@vger.kernel.org>
CC: <Ajay.Kathat@microchip.com>, <dan.carpenter@linaro.org>
Subject: [PATCH] wifi: wilc1000: avoid buffer overflow in WID string
 configuration
Thread-Topic: [PATCH] wifi: wilc1000: avoid buffer overflow in WID string
 configuration
Thread-Index: AQHcGRHp1VGJn0dJb0+crwSfcWfS4A==
Date: Fri, 29 Aug 2025 18:22:44 +0000
Message-ID: <20250829182241.45150-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5752:EE_|SA0PR11MB4655:EE_
x-ms-office365-filtering-correlation-id: 6b4732ec-3e89-4d35-46a2-08dde7290c38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mvi2sjEYJoIBk+JxClUiAX8QZSnAUGfrCRGFn9WxrReJ0fxLoMCuo9cIjY?=
 =?iso-8859-1?Q?bDPqNlk6tYVJvkUDgijrZJFa6eCQz1FEj/4c/Wl51+qGFF4j5AxebOVWN0?=
 =?iso-8859-1?Q?3Gq01K9+VB54soXTkAxmOP+XxkgM2UB6CcjrJSXZW7tQ7DXX1/4ILgXaHX?=
 =?iso-8859-1?Q?xByKXk2VLrzfB5qrtQUuj7kPrRbQp2MH88nlxqD589ByfTaqg6/dRRB0jU?=
 =?iso-8859-1?Q?b9ZdBiXvUPp5ENvOT0dbVjheqW9e9PdBvx2OhtG+oe4/aidkRUsOWC7+fF?=
 =?iso-8859-1?Q?wiamMriGNTEJ5G10fX2eHoXbl7segb2ytEFvgGZHERdJw7uoh1JQZyOCX3?=
 =?iso-8859-1?Q?ALA4ZO0X2894ETAmMVwGmmq1/yd9/MzJ9E5CiJSD5FhL8Nh+hBBP77MzLh?=
 =?iso-8859-1?Q?o+7NSEkU2tmlji9acp6wFJUVdW4ZXMGOCGrZYUW92n2DQz5r/evJyTfrkX?=
 =?iso-8859-1?Q?MWbuASpi93vRZ9XrGPrrbWTBC1VyxEq3MbFvxWIoTzXeKrwjMbrK35FX35?=
 =?iso-8859-1?Q?FmnSPRLBE8RtD/W+jhMj9O8Y5nCe7fuTvs+AAH3tuvEaitbbDE1EDuVqN+?=
 =?iso-8859-1?Q?4JH4W20oOTuQuXj/TBURhb0QzS1zTYVJelkQHsD67aD8sS0XkYEXLGwa0E?=
 =?iso-8859-1?Q?LAbLwg9brgwUcgOLrgROn8gHCenZgKqCgEMY5NlY03z38k29ZkPwOny/ce?=
 =?iso-8859-1?Q?ItCQLA1SXqskomfP8fkuG0Tp39G4jEJKvu/S4FlY8bnk2K7J/KZFRNJTo7?=
 =?iso-8859-1?Q?VwpUUHTjZNE76AVOJsldtQx/lUeeMuOGdGhnG3cI9HPSFIEjkNNIZrHhI3?=
 =?iso-8859-1?Q?JaEvVbftyq9qXdpKIjtt/XIrhCLBr/iN6FD0xwSypVSB2DlRI9uwYDrJYM?=
 =?iso-8859-1?Q?Wtx9N+GeKGEQ9ElHCRwU+ou2R/7sSTK6l4BozNYc2YvEUSdClJz17gW9IN?=
 =?iso-8859-1?Q?tS7juyEgyljAwb1FAFgoMR/dRBr7KAoeHjkl+j0sAYT6RCWTX1p4lpcrt/?=
 =?iso-8859-1?Q?uf+VjZLvVI1a2hRr49+qe9zxOwyeKQbTL1A9JDYty8CS7xKn/+jqU4kHC4?=
 =?iso-8859-1?Q?8pFJ8EstsoCns4R0riSyrbO8/lnPZTP7kGEYhSpB9tCo23pX1KWgJcc6hk?=
 =?iso-8859-1?Q?BT7I7dUWjmRAeU/SjgThEjp4YRT4/pf6GASIs4cwyk+evnAGdCBEdjkdkG?=
 =?iso-8859-1?Q?Vygnwlah1OJmM+KsQPOBBvk4I+A+hfhZGTHGqj1TfCgp12BOOQZRS01ria?=
 =?iso-8859-1?Q?eFsyQcwxgm/dH0DtdaSyYCCPoc8hnSREiH2bF//lnYA8ET8FWgSEODGsIk?=
 =?iso-8859-1?Q?G34HDKbtdTXoF8sTr/zKrCdOkEOY8HfPDeU/1P9AdF57ooTgVNWbuuxpD+?=
 =?iso-8859-1?Q?N3P45RJ6PLhxMjvYYbA7q812QPTNWWAJwhB3ZnOrnQhkolUs/1Negyl1Fy?=
 =?iso-8859-1?Q?kp1jQv1MKBxPAD2y5S4FH+AfpOVPG2YMvmCNuQmS6Z7AityqqpAk/zA7Wz?=
 =?iso-8859-1?Q?X9rpVkjCqo587wEWbrbp1yA1Kgojs44eWAJrtbyj3ZfULlHnleOApayXh+?=
 =?iso-8859-1?Q?jM3dGYo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FTHpeSXMbkuvXXpzVMi9+FnNwRtprY69JchioVJ7J35Skw2GBPDt9o9IEN?=
 =?iso-8859-1?Q?NSlcgseMBrAB41LmKVPS8GJNkBWWfD12mNFR/9KcSf79kqM9tXxlV0sgsb?=
 =?iso-8859-1?Q?AmobydNG9h7zwVFzfaeRNH64UWsB3Tu6/0GcJzMnbhA9xfx37dKzTcrKfg?=
 =?iso-8859-1?Q?mcSfCaoOz+nHFPIYNLhiiah2LKMVWCAD7AHzeRPj/E/IPbq+OZ+ViGJ+0S?=
 =?iso-8859-1?Q?RCBAzqybXL5wjxtstVitp+GDD8dlMt8rCGCug0D7rQWjS4plZj1L+NbJGp?=
 =?iso-8859-1?Q?IXrGH1GrTy0ljeQV3y3ExztrsMCyxgFB3OL8Pzswu2bPn3imLaC5XDaA2i?=
 =?iso-8859-1?Q?HuDN74mDeTLqJLY+l5Zb/aKnoH9s+4f8u+LhxLbbqCUL+eX8CJrmy2XRyO?=
 =?iso-8859-1?Q?9zlEY0LqwSt5hOFaIkCf8mHTUqL35Bk2PSdMSrb49VkPrMFNVWUl5L/Dn0?=
 =?iso-8859-1?Q?8+8dhGSScL/BkFq8RHZ9+ocOWb/xBt22UNHts84t3CTJZCU63xomEniCd6?=
 =?iso-8859-1?Q?HE32Miuj76bstpZVXAsNF7HeAgSdY8bsWsLYCVz9fjyXadExxmFhAh0u0B?=
 =?iso-8859-1?Q?l9eb76wHyt47wxVS32CLgga8A6wQB7CxNmH9AbRoMAmrMrOOEc3S1AIGYq?=
 =?iso-8859-1?Q?CQku0OARwJXvljyjHGP6nQM8RkPUE95+5cHUTMlDylBe504VStk5/ZsG8b?=
 =?iso-8859-1?Q?+QEO2RLl+Jnodk8PlJ5gu6JKjB1bib0nsMOHtnad1fsSFZVQWxQdxstpJW?=
 =?iso-8859-1?Q?tUbg6/xmhg1SuqLOT9i5F638OPlRYDmU/ojUAeCLGRD+OooZk/LcxeTaPv?=
 =?iso-8859-1?Q?2ckWLW+4iyoqxewPrYPJDffTMbiYauYPmzJu7BQc0vucOBJRx4O9E8oUxW?=
 =?iso-8859-1?Q?U2uZI5P2MQmBz2RRYkSqRYOeJyihgmkJ0StEFD1EXzTKIlsqfJUF5KwDl1?=
 =?iso-8859-1?Q?mtIc6Np9kHam0LZHPM6t6M6fVh71USZtEHwsPKsYNgHnVRdkVtVFjEIB4K?=
 =?iso-8859-1?Q?5vcc+XWwVp06ivZGVh2l4Nvq7H/WiDuK00mMTx/UYES0jeeuNf2KMpgnJH?=
 =?iso-8859-1?Q?NtR0gIW4o+kwsqpwfREIeqGiwP0vii5SkAox6bFVqiZ2geSgqGjyarV58b?=
 =?iso-8859-1?Q?E+0+Lfo4bHpQ6hMoZQEtudKeQ9nIaY9Vn9gl2UmZUc96Svtmm3JC/Ov1mo?=
 =?iso-8859-1?Q?/J8MvCD1w1UPme2ToBOaWTQuwD52Vu0veZl3e0YeNiiI87c8brj5jlA29f?=
 =?iso-8859-1?Q?Yz/k+82zLpdKAzdfBQXce8hqL4W56VSfqCFBexc4/cb9o2RlwR+9B/Dz/k?=
 =?iso-8859-1?Q?pC8SQrQnwQzhOKmMUCc5cc6SRTvxg8jgo2xdaoJhAvp3FdBgQCUIsaNSEx?=
 =?iso-8859-1?Q?5ionC56JC6VlQTsxPOwAqN6F3bfvRwlj881nwqXLqtXOcMfbhz9ZyRMUpJ?=
 =?iso-8859-1?Q?gAA/JO0VoG0TfrGmTOssLnDUlp3/8Ddiruy4n9XJP7qX2al52WS1xZwpmV?=
 =?iso-8859-1?Q?DNwYErJoP/1rB95qR65rYFj4YwCo6WJQ5+WdxMUAuIn6dg0wT+MC/nDTLW?=
 =?iso-8859-1?Q?sZDjaMITTNCmLzvjPfA7vRtTOpEVBFhKK638Wn5RaCPf6+m579CHTsWKi8?=
 =?iso-8859-1?Q?pMTUHWsar08E/3yyS8PnIvYNu6J4EDmhjjT8ojD8qJouy41TxmlC06AQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4732ec-3e89-4d35-46a2-08dde7290c38
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 18:22:44.0889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQLvas7ImnJu7EUwYz4AvTKux4M/U1+gFOZ5vbiVM36ozRzbLHmBCADDRqeJQ+GNpwD/TiJ6aBJcf3sGcUc/fqp2Ahp1p7rPPUet7xN1io8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4655

Fix the following copy overflow warning identified by Smatch static checker=
.

 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c:184 wilc_wlan_parse_res=
ponse_frame()
        error: '__memcpy()' 'cfg->s[i]->str' copy overflow (512 vs 65537)

This patch introduces size check before accessing the memory buffer.
The checks are base on the WID type of received data from the firmware.
For WID string configuration, the size limit is determined by the maximum
element size in 'struct wilc_cfg_str_vals'. Therefore, WILC_MAX_CFG_STR_SIZ=
E
macro is added to configure this size.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/aLFbr9Yu9j_TQTey@stanley.mou=
ntain
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/wlan_cfg.c    | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.c
index 131388886acb..a9a16012f9f3 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
@@ -52,6 +52,7 @@ static const struct wilc_cfg_str g_cfg_str[] =3D {
 #define WILC_RESP_MSG_TYPE_NETWORK_INFO		'N'
 #define WILC_RESP_MSG_TYPE_SCAN_COMPLETE	'S'

+#define WILC_MAX_CFG_STR_SIZE			WILC_MAX_ASSOC_RESP_FRAME_SIZE
 /********************************************
  *
  *      Configuration Functions
@@ -147,44 +148,56 @@ static void wilc_wlan_parse_response_frame(struct wil=
c *wl, u8 *info, int size)

 		switch (FIELD_GET(WILC_WID_TYPE, wid)) {
 		case WID_CHAR:
+			len =3D 3;
+			if (len + 2  > size)
+				return;
+
 			while (cfg->b[i].id !=3D WID_NIL && cfg->b[i].id !=3D wid)
 				i++;

 			if (cfg->b[i].id =3D=3D wid)
 				cfg->b[i].val =3D info[4];

-			len =3D 3;
 			break;

 		case WID_SHORT:
+			len =3D 4;
+			if (len + 2  > size)
+				return;
+
 			while (cfg->hw[i].id !=3D WID_NIL && cfg->hw[i].id !=3D wid)
 				i++;

 			if (cfg->hw[i].id =3D=3D wid)
 				cfg->hw[i].val =3D get_unaligned_le16(&info[4]);

-			len =3D 4;
 			break;

 		case WID_INT:
+			len =3D 6;
+			if (len + 2  > size)
+				return;
+
 			while (cfg->w[i].id !=3D WID_NIL && cfg->w[i].id !=3D wid)
 				i++;

 			if (cfg->w[i].id =3D=3D wid)
 				cfg->w[i].val =3D get_unaligned_le32(&info[4]);

-			len =3D 6;
 			break;

 		case WID_STR:
+			len =3D 2 + get_unaligned_le16(&info[2]);
+			if (len > WILC_MAX_CFG_STR_SIZE || (len + 2  > size))
+				return;
+
 			while (cfg->s[i].id !=3D WID_NIL && cfg->s[i].id !=3D wid)
 				i++;

 			if (cfg->s[i].id =3D=3D wid)
 				memcpy(cfg->s[i].str, &info[2],
-				       get_unaligned_le16(&info[2]) + 2);
+				       len);

-			len =3D 2 + get_unaligned_le16(&info[2]);
 			break;

 		default:
--
2.34.1

