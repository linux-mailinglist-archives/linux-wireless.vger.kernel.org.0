Return-Path: <linux-wireless+bounces-9363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837E911D2E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3971C21C2B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535C16D4C3;
	Fri, 21 Jun 2024 07:45:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FE16D31E;
	Fri, 21 Jun 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955934; cv=fail; b=OxPZ3E+zOqLx/S+EuHowT4EezRGc42X71u+WuCKx5YgW6NZpEn+ON8qNJDuaqHzag4it413Jvp2Pz+m6/FsoDFXSBwDWHvM4xap7nd5+UDkDlKONIS2kCL0l7fhCTM+IoFzRRKe9zGDxExeQ/lu3I0FRuOTUwAkUrVmRLdZrEwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955934; c=relaxed/simple;
	bh=0G0KYRZLlOBVxQpWmNiLWJYqmDzZk+ozymfIoNaPh38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bXfF2U19VAfL7r5M9P7nSasS9iNAcB6qBtiQmaJj1t1VZ9Q/9h0JZn8kpLJYhSlGoZmL6yLEszNSdm1xljeerqIm68irH68KAYdxe6si+YwcgWFe7s8VgxRlBLqqxqVAD2ar4mfJ3g2GVCRRsQjIGY3IrMH0Hd1u9DNKcov3fXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=newnGffG8+c/PHC/YxTbJj4ZB/dSWVuAmjE7a2M4PG6DtrUZGEXmJTJ0BT14IuI1h1ijt0ietak3dWsekkErHxcZIYENrJGtQ4fqHq4gS9VPd7gnsFEI1qTQVOI+guwOIFSUInEMVNL7nS9TCwPNFaIDv41faunLl3fqOEt8e44ZSVm7q6byOiVNMR29lRB+HQrRe7sxXEGET8h3HDsfsDxVh06HGTm9uWk+EtPnlztFgxzSFn2UqD8NMt1wqyPkLUPdYAKI6Rtn6SZ/5BdcdWAF1KiwRDtbGTib9+axfiNuF/fEfa3Tv+N8vvL/OWg2IMxt7Diui2kqklJDOoNByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnfkCtfmZHFYitto3clFnOdWv6+nJs71fGghNGHAl/8=;
 b=LvmDxwQcTrSdRGZbsjP09tyqC4sBMFDxVOZ+KNgjpHwQDcI6umcVzQOMN4LYM7NknG38yyieuk0QFTUjTuBK6N6Ozpv+MsDIGOQjXeWcrxsNaeNVn9t1o6bePoQv9w1+JgRyV7vpjxRcWNEBhot4bdANTiIbEKoIA/3B9UYMM8LATr8z/bt88YWZseghJ4605sqv+rEGBFKC/3WM3XXz1tZtXGqVg9xyLVsO1RJzuM7pvoKWBIGfJaX+MMXfQJqE3gTO1usLmX7EfkR2v2UhhtGWu81oxTq3rL8Wgq5A8xpthw/PBL5SC3pI6TqesI21BQRYngjVQ6N6i+3gNAlqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7043.apcprd03.prod.outlook.com (2603:1096:301:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 07:45:20 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Fri, 21 Jun 2024
 07:45:20 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "duoming@zju.edu.cn"
	<duoming@zju.edu.cn>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"megi@xff.cz" <megi@xff.cz>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, Nick Xie
	<nick@khadas.com>, "efectn@protonmail.com" <efectn@protonmail.com>,
	"jagan@edgeble.ai" <jagan@edgeble.ai>, "dsimic@manjaro.org"
	<dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] net: wireless: brcmfmac: Add optional 32k clock
 enable support
Thread-Topic: [PATCH v1 2/3] net: wireless: brcmfmac: Add optional 32k clock
 enable support
Thread-Index: AQHawrWiuAGxh4zirkWecOsl4aArsrHQN+OAgAE7PgaAAEjuAIAAGYyI
Date: Fri, 21 Jun 2024 07:45:20 +0000
Message-ID:
 <TYZPR03MB7001C517C5BDC8967DECECD880C92@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
 <20240620020015.4021696-3-jacobe.zang@wesion.com>
 <b8b89ef7-2e92-4e1a-9609-6b0fd6d64d7e@kernel.org>
 <TYZPR03MB700143E13635364FF5A316D080C92@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <4533403d-11b1-4f73-b57d-3079be1e300f@kernel.org>
In-Reply-To: <4533403d-11b1-4f73-b57d-3079be1e300f@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|PUZPR03MB7043:EE_
x-ms-office365-filtering-correlation-id: 924f5771-a69b-41bf-75ce-08dc91c619c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XkE1jPy8m+89F2M/w5ecjOVp8IdCzbvHjy+AvrF7A9BX4OiZnaRgF4hv7G?=
 =?iso-8859-1?Q?FGy6IY6vI9fGXe/ERkcG8CCbUvKRzEwJZ+BkRq+xqlmiFbNqOxdtwc1taN?=
 =?iso-8859-1?Q?GKZN3m8OSXw9+CdeVDnk4dmvkH7o+nZKCYaMpR/ARPaXLrHMtuTtnIZEcy?=
 =?iso-8859-1?Q?FCvDZgV8viTlBYBOSO4h6jH+Ez0M/rHs/nqnZ73tVJ1tKeyXSnYI9MZpwt?=
 =?iso-8859-1?Q?u3msxk1FAszOLvjNWOVFPhyvUaL6GO9gWNqSJTR7S8lTl2aYItZVHaH08y?=
 =?iso-8859-1?Q?d8UDvHn8n5S7j2vvNQ9SYL++hfsq2oYXuXVDQr/2OLe3bCRkJkMH48MKF/?=
 =?iso-8859-1?Q?P7Rhsf7P1woal02FWE73zpANaG6Au7JyVWVAolKoLfVJfSKS//tvJezcWI?=
 =?iso-8859-1?Q?yBhM4xPoO5B/wwAhZTaOhtioxmxzPQSnxqJ4SdXzi8DPnQE76yJbXFIvel?=
 =?iso-8859-1?Q?P9pjXNWt5+EbiEco8jeZ3QZnqL6H3F1R5Sj+fj1FLt0TtOT5Snn702Skfu?=
 =?iso-8859-1?Q?JcDE0Fv6GEkDGp/Vq5k0AqPnLf1udWHsWuhFflpUNIgE3zXGXOYK7BY1rT?=
 =?iso-8859-1?Q?6QMb0DDOMxjh/hXghBRvwqcUdi7Es0FaqNwWKylB9OXu3l7uXhrTuz1PcH?=
 =?iso-8859-1?Q?HHT08xTa9/RJ/YY5DTyuea4U35NK9/LB7E5GXXYfX3t5SSze3SW90DgFKM?=
 =?iso-8859-1?Q?8kuvlIaUoiFiNOh4EqU7cNGvkNm4bgl3grJXBO1uqrkEycsJrHbDLlWVr2?=
 =?iso-8859-1?Q?p0VolBzoWI4rVrqHJPrwER4gIbeK5HGYZInkdrCt4FhhmJXbbWO2LdDE8G?=
 =?iso-8859-1?Q?tgcxjRHSPRhvX+qQE4uqG6Pgrbx+aTrwGoRADrz6lZVnLmEYpcCng6LQNi?=
 =?iso-8859-1?Q?qzaxKJl+oIu47PYtQW9YeH8IiAphaAjv2XKepsN3JbNCiwBDOY24NFa7KN?=
 =?iso-8859-1?Q?YeIdPrbRxjp2OflBxVBAOk9ieEsZCylEFlZhmDjFA2/xLnmH1vIjvH9nGv?=
 =?iso-8859-1?Q?WguAiOZtvkwWo7d7+MiS+qvjqhHkLfstWOJcruDgKu5Pbm/g6iuCmlGxKI?=
 =?iso-8859-1?Q?mVB7B0Nsb1yMKPkohQKMk6x5nYTdCQdobrfw81wz56Agamy4F/ZKIoF31M?=
 =?iso-8859-1?Q?aXNc+G5kHYmm8VKn0aOGu9LGbWVmys8wHQFuygMwO5hFAfIm8xTD2fga4r?=
 =?iso-8859-1?Q?xvUY9D38cI6gzKK0p51dACZ3y0JCe6XOXo7919/ipF817ZM7Td3Al2EPVk?=
 =?iso-8859-1?Q?WM71Bjz7vw2gawN/8MLGcz2mnVLsmqTE4tARvyYsgx5wn++2o/I/yC4kRD?=
 =?iso-8859-1?Q?+9DHAEUokxA8M04Kjr/07RpDhax1u+Xki4QGJkcQPTSD6JGyfDIKD3p6DL?=
 =?iso-8859-1?Q?SezlRA5NwP2FJWQor9OjqtPOB/Rou9GU6yxZLKYntTg2MC7UanjAY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NTzVa5t85nqBshggJBVS+T9ztQmSbzTXqlnDclwkylDGfr7FkBy6/V9G2N?=
 =?iso-8859-1?Q?D0go9aTHtiw1WhbWeWfv+dkMg4gbdOe5GKxMPbIvIKUplm3BU999Uwc+/N?=
 =?iso-8859-1?Q?TRxq3XMSfQ9Wmhbo70ecaH9hle4d8mFDdaEb/lGKRb3rvTS531CjmLOY/j?=
 =?iso-8859-1?Q?e/gPNqQXOFCYTbhQGV8t3lAlkxsTS+AxvnUFAg7521pPKJMd/c0yEshI3B?=
 =?iso-8859-1?Q?WToDSDDMa9AWSXLCRc/fRjnwyqxi3gsmE7LGBV8ohGEYm5jkuDCiw4cIsC?=
 =?iso-8859-1?Q?NoxPsxok4+VGMrLrDKBpIpxsuS//s+SRXVdnFcfhW8Ty3m+FfbvGZuIhxJ?=
 =?iso-8859-1?Q?YW16BJxryJd+zvs6+Y5jjvqtzRrYNo0ZxklbO3pwFRInXtX77M/FtR6VwA?=
 =?iso-8859-1?Q?OgtwaH90a9Stb3gaNMLg8lLCoZMCu/H1ZwdD0VTjN2LtunOCttccL4axCN?=
 =?iso-8859-1?Q?JiQ1rxB6pyz1ZM1V8Ey6nnjpeo7BkXlYn9UuLl0KzHllHcj+hN0NWW+VGv?=
 =?iso-8859-1?Q?Eb441LqO/B6Ei0PzA+e+DI+gFQL1tiaqCwoaO5aYtXz2nRUQJEPzaGJAsM?=
 =?iso-8859-1?Q?c0oVlnG99Blkqws9M1iws/CTkfVNR3Sdz4kO/D7aQ5R6cvxVrs/ep/lcg0?=
 =?iso-8859-1?Q?sPoHZXAgzCEQPOMrAzH/LVHsi3I0vqEA/kAfhqb1uMph32NLNVysDGoaRj?=
 =?iso-8859-1?Q?Qx8K2RHmTTraQmMX1yDDrmbnE0c7m227xy+Zo1ociPh/xExN/0X2OYVvWZ?=
 =?iso-8859-1?Q?hLyASGmodsq7dTC62as/iMvg0W1Yl5ezAPQ203DHq//R8XRTpj19NwP1+f?=
 =?iso-8859-1?Q?HuR4fz5UN128+v0Zi3j/yFbDpA64h9fJc53D9DvUkfPiOwwM+45MPqbmNm?=
 =?iso-8859-1?Q?ab0eMca/TXX+WS8zQfxq1MR6peLXHs0Rf3IzPgbuCRXNDShnNlUaVxC7Qd?=
 =?iso-8859-1?Q?Ye6VDALkcIcvk4hIVsesBLN6GGlJq3iHgBTMu8qPauWoU3PuuZHWFbkFJR?=
 =?iso-8859-1?Q?W2i+sSH/nT1ZJHmI7XR1TfGVi6dxul1ASUia7wXqNKdpq2UFB9o7et8VPF?=
 =?iso-8859-1?Q?MJgQ7BY+On5dQQtg/0p9gCWOVkbCDBEpsD4qt4oj0n/9MEJaA9PVCxQQ+n?=
 =?iso-8859-1?Q?A2o/1QAh1Sv5B+HtCiLLII8BFmAmrUBQ9L6aEQcwy50p02KRXwRJrKiPWg?=
 =?iso-8859-1?Q?AaMsc9cz2TvSbTyH07Ku2vlOcNQB0omZpRdzuCn1k1Y1QZo3+ljey0ANbY?=
 =?iso-8859-1?Q?BfbYvg232AY6+laBlw/6iuoNyL0q6AFE53CqQfqz8sUkOu8pCtCJXRt1ba?=
 =?iso-8859-1?Q?R27yj1Uwz7afFOgp7FBbt0DIwsEa2/AKp2FK3Ht14U8FdAuMmAgfr/MxrG?=
 =?iso-8859-1?Q?ubRehVGOb8rpZmijZvT5bQf3I28IYxXGbd/yVl5VYhs2hQlwvTMYfUJLFn?=
 =?iso-8859-1?Q?yRcq3eC8TQU5VRW+MyAzf6jGIEnTo8xIsHWKhiqld2tPpJrfBJK67sdZ9l?=
 =?iso-8859-1?Q?QmqJDWt0l7sMXuubopadmZdSl4Hb81GokRPSBwx86uxKf1tfNL8jiRjRq/?=
 =?iso-8859-1?Q?JpH3/ZtoXZX5O4jljmgo2dbTqXExooG+TBV/BIFe4dpNs6is2jhFc0UVKz?=
 =?iso-8859-1?Q?25NNHOZJTPXgiB4//defiW5M+1XO4rrnn7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924f5771-a69b-41bf-75ce-08dc91c619c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 07:45:20.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTgFiS1L56xDznF87454f2963goIhe3RroL8ziDFr+DOpYOvb7Xri6Ssh2p4hIouC6yhZwCToIlFdbeKVN8BVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7043

> That's DTS, not binding. I ask about Devicetree binding.=0A=
=0A=
Ok... I have grep in all dts files and can't find wifi node which is under =
pcie node has clock. So should I add an example in the yaml file? =0A=
=0A=
Just like:=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fm=
ac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.=
yaml=0A=
index e564f20d8f415..2d9f8de447659 100644=0A=
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml=
=0A=
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml=
=0A=
@@ -153,3 +153,19 @@ examples:=0A=
         brcm,ccode-map =3D "JP-JP-78", "US-Q2-86";=0A=
       };=0A=
     };=0A=
+  - |=0A=
+    pcie@0,0 {=0A=
+                 reg =3D <0x400000 0 0 0 0>;=0A=
+                 #address-cells =3D <3>;=0A=
+                 #size-cells =3D <2>;=0A=
+                 ranges;=0A=
+                 device_type =3D "pci";=0A=
+                 bus-range =3D <0x40 0x4f>;=0A=
+=0A=
+                 wifi: wifi@0,0 {=0A=
+                         compatible =3D "pci14e4,449d";=0A=
+                         reg =3D <0x410000 0 0 0 0>;=0A=
+                         clocks =3D <&hym8563>;=0A=
+                         clock-names =3D "32k";=0A=
+                 };=0A=
+         };=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

