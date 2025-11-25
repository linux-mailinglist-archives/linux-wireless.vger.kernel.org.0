Return-Path: <linux-wireless+bounces-29326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE544C83FEB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5CB54E175E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83429B8D3;
	Tue, 25 Nov 2025 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EuCEHt0d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012053.outbound.protection.outlook.com [52.103.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72B18C332;
	Tue, 25 Nov 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059691; cv=fail; b=Taoq9I0kWEHUaqCxxErriV8zekJtJBaRZVoRVYvtx5IaKpMRvxayPYKEEqK4m9d82OCzHkHqEiJ2Mb1Q4BL0RToP+NCTa25fS5wYmguDxFUxNNnR5AitXlwA9zYibf27IOjMp6FU6Bzx1b5zbwRnf3Mo0XFk/QpX3MG0/gLtuKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059691; c=relaxed/simple;
	bh=TCe7MhNJOX/p9Lx+T/U98Nnd/c5BRrxKr2IBLbIf9jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6MCr4xRMBzyO4NmkufzMrgOYDXRVUoP/dKMHkSAthBJ/9bHcUrk16bEuV3G7f33ha0CWJ64LxQogdZzu37dEXSPFwwTSS4PBAlRrPY4vfBa41y8090OBfnT6yM0SiPkFVxCioGuZt8nzmEadhlzpPhKK2E37+dh0z0PEDgePkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EuCEHt0d; arc=fail smtp.client-ip=52.103.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXnNTDWwKT2sSbWHanCB8BALyz5zfmqnRd8s4Jq+dW7DZiXPxk4s1le+YhrEsv/dTBFPu7MAR2gmDT1IkuO8sKQqGMmiJULkM7KkyND5KUrF+tzi5f55jEpbystSnrZUr59Hf/Y1zmHo+pycey8sImtbm4gmBno496b4IkV7JIJmfDGD4l+tYIyAkPqLHbDTq9voAMBtL8l3wm+FB8e4iv+MBY8VpLkytjM1iFK2K4GCI5MH4e5qp4mCxQcxuM+fUREZVlnS1i7Z3xtl2fMtC+E0MXGiTUYt+Q96NKuXxnrB6Y+flG7yYaD9tazVQIl3VsO6ueNxdo+y5VFKfCdAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCe7MhNJOX/p9Lx+T/U98Nnd/c5BRrxKr2IBLbIf9jY=;
 b=kCHrrpGTpK60uvZUAGwWke/L1Dp8BWN06XU7DZhAHGfvnxcXqBPmtI7yAuS1SQAR+9GYWYfqUaASEs+zbwvqwjHDUB6R/aOz2t8EATVBNJSFC2qX7BdbbAyeJ93reei3ytfNOlrpgxiaQcEadupI/GCNd5lonYYqssQlmt5F8A5PpzZEX3hSW83XHChJjNtPDFpZVUbPKHD13PY3YXqnJSThSBRF9Vp8xdp3zqdhwpdyqbnvJ+IagfBCdAry1C1dH4qFe7T/ig4jhoLwiDRDC5QKKPOsPxtWjGrpGWi5PNGcQHM3qHFoTU+YgdtF6M919obvebgciBskeO57PtfofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCe7MhNJOX/p9Lx+T/U98Nnd/c5BRrxKr2IBLbIf9jY=;
 b=EuCEHt0dlr6LY40k1bxz9ICNA2AfPVZg06PCCXjCVGvKrYp3BBboD6hO5wDtM3vtil1XlPkIFYHbEts8gqRJ2YBrOpPK+cBrDEYfUDsIWdV9IX2d3mzEeiqCgfFXAYNo9FwrdVNNzM3TzaKkZ3ENj3mQwdtTvmuQBlkmxKJkeBNjjP+FxL/Tc3QYm+qkFC2Cifn2+V/BUwghbxlkT+4Qow063WbANlwDXzJjbJl9y1MOy1ux4hZkH7OH1CGdPbnx9RI1woOHo6XtTz2yN2qfqf/ipJPOFjk7I4Y4Q6Rrj8rucXJ2KEpZd9YgRSsZJwRzzOBHMXPnfaLqpeUj+hG3uQ==
Received: from SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 by SN7PR10MB6620.namprd10.prod.outlook.com (2603:10b6:806:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 08:34:46 +0000
Received: from SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4]) by SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4%3]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 08:34:46 +0000
From: Les Boys <lesboyspp43@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH rtw-next v2] realtek/rtlwifi: ensure unicast is reinitialized
 to false in each iteration
Thread-Topic: [PATCH rtw-next v2] realtek/rtlwifi: ensure unicast is
 reinitialized to false in each iteration
Thread-Index: AQHcXeYI1CS2ImAbA0K7UyMLvfR4FLUDEJ0l
Date: Tue, 25 Nov 2025 08:34:46 +0000
Message-ID:
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
References:
 <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
In-Reply-To:
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4460:EE_|SN7PR10MB6620:EE_
x-ms-office365-filtering-correlation-id: 4f6252ec-a7bb-455e-8294-08de2bfd7d75
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrOdfYgTvyROVxfCNZb2OzagJfUCREQhrtplppOc9GIajRTVTiDSQOapHB0IE++34IBjXMhU3xr4ef6GgLy4dkB+vODGgunDeM6OWWknhvdtqFNDP5SJIyikp82wVZrZR9ubb2vpe0PsGdNaFiP8t0pIOQ+Cg+NOTKOc/FYsCuCypWsrK9A/lubfxfoXSr0e9qC+fcdyY9/BnCMAxlLx/SR5PYgfu/9W36Cqii+duB6o3N0/HDJsKxZyDJJFoMwt6jTAf9W+R7snC8bx6VMopF3Aq93LaB/jI3aU0g1VMESbImD2qqHv8Miz/cRS7/5gFHo7NbSQrjvOZ2FBIvRvmNJT3+MKHa99TF/IAB/62e0Wpft0OaYKmpUJTRi2fzjSweWzqb+GzzjsspunzYXJMPOmnOjhFPzeidoWRi0TVdwQqR2IH1eFrZ1AdgXRdv/Cn3NaSF/0CjhTFKqPzMdz+pa2FkWwFPv8zGxNje/WqMeQJxSc6lSyHTuNnS42s4S+Q0PoKHBH4NHsU3+UW5x90l1dCtnp4mG594XENrckMj/R3tdnfIAshwqtG49qeOwWL/K8ZvFCdOE1ILV+6PBL9UdLA0R7Z7Xke8EQSPgnW5jJZXp8vGdewvQ0wTQdGS5+bSQSI1nLPLrwYXVCt2lSiBc6/rP0YW7aaoppaZTIoy2NQU+AuVeXZ7ZphfcC0rpL18d/rTz1uBe65tLsvZx3jDVrJS3mpMkpvf0Lp2Y2S4mMnkjXjSsBOQXoJfCeJ+LjrNU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|31061999003|7042599007|461199028|15030799006|15080799012|19110799012|8062599012|8060799015|440099028|3412199025|40105399003|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?MxxFFP8esuGrdwYbZzUtTX0tbyxVAlQzKfG9+2FsJev+mvxntMFV7p+ASF?=
 =?iso-8859-1?Q?4iznuWLDdTac9TlIZykpvYeGRLdBhS019HKmXgbJYk3A0XGx25gcJlncnY?=
 =?iso-8859-1?Q?mRaDzMuc9Rt7RreWCayNrnuiqQYEsVexZd+koLQWeZfAGoHrBZiQXLrX6j?=
 =?iso-8859-1?Q?Jzpfh7jJ6RpbSLAuDDhh+xq7i2byD63N7MWcofOWcPFTnaXV3r4Cn9qjGD?=
 =?iso-8859-1?Q?29za/NoXQXB1yF0YyU6MrpHN/qk5pMbBN2apGycm+iNqYH6OAP/uwtwjXz?=
 =?iso-8859-1?Q?g7HUu+wpU7jO6AkUbpd8SUYa2oLvDnUBJCwJ4RKsi08vwi36NovW6bimA+?=
 =?iso-8859-1?Q?EKpU27BX/v4g0CMLGuNpRTuJPMGNVlJ3G3T1d27m8DMS4vJHENiQENwfi1?=
 =?iso-8859-1?Q?HB/v06gAqmBRBRQ79q2JqA3ShiMB4Gd3zrfb3UHiPxGbTqninaC7uphpKO?=
 =?iso-8859-1?Q?h/hNj5RpE/CqsePhVWMN+LVguJCf5z3gJLQ58EzRR8qtoeXD3EsWIVr17n?=
 =?iso-8859-1?Q?zMby4pxKuIrRtSE7AXwPKl8g58NV9hk3+1Ykhe9F9irRjdQU3JHZV6s/uf?=
 =?iso-8859-1?Q?eF0cRkITxuLkznFxUPzn1UsVkbYJYW/2Ldd4UOQ1bntB+ztsVbVNSpUzsZ?=
 =?iso-8859-1?Q?XMNVrlId1Xw6PHhXeALGPL8dVM6vXAoSG14MkSpGrs2Q0+g0gIzUbwPbLz?=
 =?iso-8859-1?Q?ZXtcjT/8XsGTcDFU2rS8KOZT8qtbE3iY2SeW7vU12VMyQv1i6gKHJxB9ca?=
 =?iso-8859-1?Q?nnK4iuNdJqOC2ijiixEGgxp1hJIBLV+1jMqXtkV3DVYYnW+yLi6j1wbgTI?=
 =?iso-8859-1?Q?aamr7xMirtKLbbCR62h4yG4cK1IDrf016SE1dcC2LSO6F2X9c1ipBV4Msx?=
 =?iso-8859-1?Q?HiIwFqPxBbfmo/Xm903aGmnfKcxAy3pTXtiIwDZTgOI6QlJcpgoK1utOUF?=
 =?iso-8859-1?Q?IBPwCifQOBBvkx1c/ZMUe5OmEi8zP08gCuMHdvBZ6Xd5nIVNEmQ7WI2fg/?=
 =?iso-8859-1?Q?34DvuCH21um91g2CbFJS91ctXaEkh94YfJJAfJcAQjMITaRxsEV3PFw8z8?=
 =?iso-8859-1?Q?8pHVzauhoHzDdUDznZpH8u0+if23xZdFnBIPlPsz8cQF+AXgB1ZYoAX/Ul?=
 =?iso-8859-1?Q?6hEUT3FZK6aKrOF8a18dCDc0/D/mN59GE5HcO/9BHez0IV90uwWnXESynB?=
 =?iso-8859-1?Q?56coNEWAM4ZilsO8Clt+5PZB95ID9+Qlt2VvPxcYYj+hsDZJr944wzlv/s?=
 =?iso-8859-1?Q?rJlvugIqG75DrN6Hz13rEAOPEbSun6HrMZ+kaILYhI9diucqsxbzMAoAIv?=
 =?iso-8859-1?Q?Nl6uVtzRD8ICkz3s4oi+uoVDEw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cpbXJCRpfrFrYPoD3U8JYlHab/OwxJmO+OjfRdX9W37BxyNb3hZQTLI+zp?=
 =?iso-8859-1?Q?JLImqupnGhq3t4rdJbp58Kkl7FcBKt9WPqipmSp+NdPrVEWPWo2CWzZ1vd?=
 =?iso-8859-1?Q?HMPS0yqYl4SaqBtwvPNMxPNOjkS8LeQMGThjT7EOA8AaoJUZq9hO/Gnbj+?=
 =?iso-8859-1?Q?7n7fsi4T8qtJ6Zo4ghD3tJhPeeg+OpZY29VEifkUg+crE4WARHgiBLVrie?=
 =?iso-8859-1?Q?OXyr9ApWLSXfMJwKU9salBstQjCUhIZgp5qXGmC289VVvMHznMFD2G+1HY?=
 =?iso-8859-1?Q?h+7P5isZKF/ov7kdYNeVpCTDymZPbX67F813rkGivDiIodbRCLeaDcXkbt?=
 =?iso-8859-1?Q?d9fDkuxjsF9JvncHRiNxFUnkbo3y2OIBqXf6QL6CMmL2R7ZNSEoWgBQ98X?=
 =?iso-8859-1?Q?3SxylSlaIO0ptbTh3yJqiUd9gsb2RMS7eHNu8MG/CKsdsixN3eGgOTbey1?=
 =?iso-8859-1?Q?HL7YWYVgxVh0WxfK+QuQa6XVm4ZMyDh5LX+OCIDA/QIHFtALW6LebYrMGG?=
 =?iso-8859-1?Q?3n8kkwWoW/5yWZ3cXzBIeGaoMLm6o8Qq+b7eQ+2NOfWVGgg97tIZsIhtuR?=
 =?iso-8859-1?Q?xEa7CINotQbP6EWqQhik5L/zKiZmEKg5l5Fg5z6bYpnEam7LBMmKom9rRj?=
 =?iso-8859-1?Q?fefufF42OoWrIDNWkV2fR6FOzdhzA1b+XKEce1gtaVXkwJY7lN70qv3oi/?=
 =?iso-8859-1?Q?pFhzrERC7OdpKNW9kwRRd4v07S3TjpE2J6RYRTAZZo+563tWiedI9NlZiW?=
 =?iso-8859-1?Q?3wtFJpChD9JUYU6nfLluJqXRkYOz1xkthnL0v3nUvWnV+TNdhLm3hFyLrq?=
 =?iso-8859-1?Q?LnErZXmQQ0EdoBgjzKEIo1QgzZFigbF6abe3y67yBDdbGY7XmpEjqdAViO?=
 =?iso-8859-1?Q?e6uGrLgu+FkzSMZZTS8iLuNgSSIXe0i6naxx6hgd467Ny9cJp5p8YsIB0L?=
 =?iso-8859-1?Q?TiMF0zhbu8u8IuC6Y7BTw6qe84wXzI62QryTdFBxxRo+FwrgM80P9Zs6Lq?=
 =?iso-8859-1?Q?M7CPcjwaYPu/AQ5Ab/GH+0tPe4Hm4UhQCts+WGRzhxDfWSoBPp1FLcCpX8?=
 =?iso-8859-1?Q?qlx/xN3tB61voa8aI3A3rtbdmDQB2IP22ZFzmE931gpqCCWtKeFoSXkdKp?=
 =?iso-8859-1?Q?5GZxa/clGu1ZqZNA1+d9mYy5GOoMudT3QgXKAAOOhdQjWU7VxeAUZVBzqM?=
 =?iso-8859-1?Q?YXJdaWq4qJTL2XZCfxKprYJZBkwUBzlDsibzuuouMOMnlfKzH3J0A0Lama?=
 =?iso-8859-1?Q?2kVkxIqIFrOSHrf2XCnnWn9XQClqxUOVovyo2T+y4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4460.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6252ec-a7bb-455e-8294-08de2bfd7d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 08:34:46.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6620

Previously, the unicast variable was only initialized once during the=0A=
function execution. Therefore, if unicast was set to true in the (n-1)th=0A=
iteration, it would affect the nth iteration. This patch resolves the issue=
=0A=
by reinitializing unicast to false at the start of each iteration.=0A=
=0A=
CHANGE:=0A=
1. Fix indention=0A=
2. Use a better way recommanded by maintainer to solve original problem=0A=
3. Fix subject=0A=
4. Remove useless if and TODO comment=0A=
=0A=
(added CC this time)=0A=
=0A=
Signed-off-by: LBLaiSiNanHai <lesboyspp43@outlook.com>=0A=
---=0A=
=A0drivers/net/wireless/realtek/rtlwifi/pci.c | 11 ++++-------=0A=
=A01 file changed, 4 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wirel=
ess/realtek/rtlwifi/pci.c=0A=
index fe7140328..a07de6b57 100644=0A=
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c=0A=
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c=0A=
@@ -752,16 +752,13 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw=
 *hw)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcp=
y(IEEE80211_SKB_RXCB(skb), &rx_status,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 sizeof(rx_status));=0A=
=0A=
-=A0=A0=A0=A0=A0 unicast =3D false;=0A=
-=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (is_=
broadcast_ether_addr(hdr->addr1)) {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ;/*TODO*/=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else =
if (is_multicast_ether_addr(hdr->addr1)) {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ;/*TODO*/=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else =
{=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (is_=
unicast_ether_addr(hdr->addr1)) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 unicast =3D true;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 rtlpriv->stats.rxbytesunicast +=3D skb->len;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else =
{=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 unicast =3D false;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl_i=
s_special_data(hw, skb, false, true);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i=
eee80211_is_data(fc)) {=0A=
--=0A=
2.44.0=

