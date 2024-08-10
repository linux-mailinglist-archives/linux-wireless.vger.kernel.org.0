Return-Path: <linux-wireless+bounces-11237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A794DA68
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 05:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE482283A18
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 03:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687813C67F;
	Sat, 10 Aug 2024 03:52:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B513A865;
	Sat, 10 Aug 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261924; cv=fail; b=YST8qvUxcqQup3smuBr5+heVTzroK5T6SToEPUDwGH98ojjmG68QQ88IRMQTGsvR8W8q69iXqPI3P0HgGX3GsKUcjcv0WJuVOAi5o/coAIr1sGqmUDREmLtNWMhQ+PlEYAGK/U5TIrM8/cV6qaTT4+eD7nX0aY+rwIytvMNqbGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261924; c=relaxed/simple;
	bh=2VnM3Xke/V+FBPoCBZ6dXFpkeLfGCL5kEesF20cliAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rKyBmqOckSdZfYZ6St65vKyJ4cbRZemIoWRvXcmzlJt7yses9DG0IcHdWhaAnmI6/1G5BZ30H9qfCm5GJ3c3BAyHklLeq+QgR389duOLC6KPGotaAeq09c2XuhKm2D+Cts7oUFMAf1gWAljSG9Lgmn9iEzdlEd2vPpqtQJOqRdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KazpCY/IrrswBxrcwXv9MFXf8NTDxTJgsaYiKIZIWCZMlmxd8yeCFoRrrISFuuCbNgnV8WCH0kt+nTuF8of8PMDw+kaBBzVnkU4Abpklar1smAewH3YSjAqVIj7H8myCjuMR9siFZrSKr+5V4+AiWEKQPkfHeKD31K3zOzWcj8ENlb94dyOtzYK+/f7WbXDVTDeObImNshctgWXwrUSAxB0pI4YzUuMddiZYgvjht5cFE4/Ns5WS2nsfGArIiKhedh0/IEEarVurMy51D8VJc8/OZASB9wqgdAGo1AF0wjXxgauGmw7xhrZXkwO7cGsJ8N1semGKUsCWspxOh6afng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ZCKui3FOaZbR8MmUilWzOmfwqy4Ji7tdvVIJh0aaI=;
 b=mSyO9RUXG9ZHa5GwYAMUrtK6NPOx2A2O82gCd41ROPugfdpSss9WYX+xf4L+Cm6kr7gsHFuCmrmP7eEoF/SNM0pIHxij22FpmSkIsj+FBvvxyH9KSQteaw5O73RgPK+bxBZlCwOqYfnvDwWM1vRpvK3OkeJ7wjDX3NOnQrQ12XopDuP6c2YFaVqLCt+487u+BbEUtNi4gtUoZVtgM+Z9BsRYhlJ1ydNuVBkjJ/K04Nxe1PlH2UnUI2bqZTgTsE9rG68WdhBzKR8jsKy78OqlQL5gnEdHgybpM7N3dxyZNBqd6CbTG+hmT7gAvy8c5d3fxdTMTqNDBYp5B1eq5vltEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB8564.apcprd03.prod.outlook.com (2603:1096:405:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 03:51:59 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 03:51:59 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	arend.vanspriel@broadcom.com
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Sat, 10 Aug 2024 11:51:37 +0800
Message-Id: <20240810035141.439024-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810035141.439024-1-jacobe.zang@wesion.com>
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:404:14::32) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: ae357065-76bc-49b8-8a30-08dcb8efc916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lqXfTUZngmKx7QoHO2DNecOxkWwn9UX4CfDSQN4A5dC2tr6IGLWCOU602DQU?=
 =?us-ascii?Q?7ObQYdfWpFTTmGIDepxOYJ+kBcfw8W1qJjfcADSBIIYRva1sxd0m3h4Qofeg?=
 =?us-ascii?Q?q85cB43X8OcmAQdkHbth7awudBUJklds4gWlj/ZsraKjZAJa8bA1Gu49tpci?=
 =?us-ascii?Q?DVTDIkAdkG7aw4sDjYwHyWrErj9RbeRM84PJQIfEo7L0OM1LZj5Xnux6Hcbj?=
 =?us-ascii?Q?7rvqO32wgrye3476zGbSb6TwzpqEYdCPVr3dztUWNYK0iE5pHVsUn/hE0WWT?=
 =?us-ascii?Q?/yXXkBXWdDb7JyCjz+7KDbBMYERWnrKE+1SHBYH0xYRAsIUrPlI+QVo/We/a?=
 =?us-ascii?Q?KhTacD/TmwffP9EQXct4lXWu1iTSK+DsPh6z2LyMyLJRytiASAFCIFAzx3Mg?=
 =?us-ascii?Q?YtXp7blxm9teZ2bMAQjuWgTPhVxdjewcj006T7hFnQ1nuNifIigcY/mQVu14?=
 =?us-ascii?Q?9QuMPM8LU1Es/3XPLfgHPIWaoGGHgu3/qkLyNv6nhY86r8DLhkdle/72tZUX?=
 =?us-ascii?Q?gTmAKa17DiGu2MdI5LJ9Nce6hrGu6w8HBecb/q9nXdFB+iOpWG5N/Yt0p9t/?=
 =?us-ascii?Q?BT8IVO4av0KgQShRPikFALNtd3qkGq4ugWnVsC1ZkS5uMjgzgk0FPd1sG8B2?=
 =?us-ascii?Q?Zme+rSrJ9eTEAJwG+Bb9c52ZqHWSMWJKcpbwlbqbWIHnV3OFa2WbubLyPaRm?=
 =?us-ascii?Q?MfrJRHsFDcAQ3VFmJtU5C2T6mAtM/4COu4BQUJsDf0nVOgaLWKQPSUAN9qMt?=
 =?us-ascii?Q?t25gPKsHxs+BWD12gfo+cC7q7dOtGSvR+gEqx9nrxA5wC63driQboe8UVOBV?=
 =?us-ascii?Q?aD2woGVO+m7/Vdz9xzlR8CPkYpAjT4rHb3cGWtiqC/5jBCpE/OftAdjxsug4?=
 =?us-ascii?Q?/ACqjOPa4A/DrGgK6WUmodBc3rIW1f6yAwUudX74OsMJetStNkh4IvbDlF55?=
 =?us-ascii?Q?Mwb0Zec08OPK8Dw71Dx6QMJfVGj/nyzRjnx6FQkmDdTCt26pLzK6hQA2ThsI?=
 =?us-ascii?Q?5PDo15yKZ/a9WL84lNeBlzGNsD/NTITFhacvMa/DY3JB8Vv+mOYObFnYlCOZ?=
 =?us-ascii?Q?xlwBEviwWSJ/upMX2xJrLoCNtjiy1YM4HdyINyafr3K7HN5/0vV34DVpz9FH?=
 =?us-ascii?Q?v/IADSRQkpHJvvsNH+ZfESpOinx7b3EGvJL0yeNXbE7tdPYPs71jRW6+xWX2?=
 =?us-ascii?Q?i/vU3T5PUD95bfgbxA3NedkKh7Xt29WEefvqhgAs8gOK787oT/jKbuMKkFXg?=
 =?us-ascii?Q?qRACnZoeH5o8iVv/dJafE3Xy4xyEuhILbsM9Xdfhi11+BcXqKuieZH8pIzRx?=
 =?us-ascii?Q?gu2oj4oxPAjeT6qJn8H9Teqt7AmBVO7YqdNx2thHJUuXanZ4PkZr/MIRvtI4?=
 =?us-ascii?Q?07ebCI7sWCosutDXjNKJS2k+A0Pp61Hmmmh4I6KXyatU7DIdXCHL9prxGZ6d?=
 =?us-ascii?Q?FXmULE6w5/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryZyUStan49huurNtyxg3HmlEB2n1S2NQUvgypMGab1FvViKnRoPWrlvXfUd?=
 =?us-ascii?Q?EYvYkCOOh3WOzQSU47+wF+zvnnIcecBR0U99T8OK3D0KFgTEdYgEetflbqs2?=
 =?us-ascii?Q?Pc+rgle4a9D511bfQCPhov+ohZxqHimgDDD2mOTHlEbq7sYqmfxUOgGSdVgq?=
 =?us-ascii?Q?U2hbLKh4dZGuADTZ/XoeyShDPaH53gsc1MuiVDOAj8BaTCyA5fYjLUnFAPrT?=
 =?us-ascii?Q?5QWsRyyCqcoL+aZbAS5GnELWs9P6GMdUer6LdjMUob2boK08Qaqjp3Q0LkSM?=
 =?us-ascii?Q?PzqT8Dc+Bz7KiKG5sKcjxUlfO8/c25OcqDzwx4L+8gk9Aj+SHOAh9bPSga4k?=
 =?us-ascii?Q?EMaunwXOV9Sms2sO12S2+O2Eq1/8DbdkI1TcQ+Tbhbb+uNQFW52Hcy1LT+XM?=
 =?us-ascii?Q?Q8SaLFV9Iyg1d2RJ0MrQofgpfkumpbpe2MErsFB3Mo0N9qPXOjQTrrJoaCSa?=
 =?us-ascii?Q?MsECLIu8CVwSYBn2oGVQWvb1q8xtCDchXaSfJ1F01WnVQkp/RSBFNqIqOX+F?=
 =?us-ascii?Q?HQIHoG1xa4msKQEY9ANb5brZdxLettUcItvfbneJ1M67ilmMHnWklvCxlIvn?=
 =?us-ascii?Q?zHJXgpWmrVXDR9emv6MncfeH1wzeMMvD7FnoJR4bD1Z9xGVb7bnJbpX0HtI4?=
 =?us-ascii?Q?4p0MZ698NmfnAeSPfqjZNMlH/RiFe2wLHZ6PSHHa+Hny5dZap+NdvAj3lrPL?=
 =?us-ascii?Q?NL21PGwX2IY+3GOzme1lB6xFjeuMvwrfQgnnnfyxj0tjf4m6zRXwMCQIfQRn?=
 =?us-ascii?Q?0jppsuTABj3Bq1jX6xwpOtYq5nU/57R+dJU17yxez/u6jzXzMAI3q7w+myPz?=
 =?us-ascii?Q?4nIis6psW/kUAtPLtfu53i218ciA7zyhu8VfhecgNNl58HYA5ai5tG+caeaW?=
 =?us-ascii?Q?vvKUzZvNu3O1bVdAIHmHJe2dGW9r8+Ge7jcUiDzIILsxPnWx0LyI9sTHeQaF?=
 =?us-ascii?Q?Ni+8mP24GkxBy/LBf9ZR6fIYPhXg/orhOfmWdzc7ID6QcLJYNLnSFMabg3nv?=
 =?us-ascii?Q?j9rb0+KGV79XZqnVRKMrDFzlocwTM7BjU6LrKPMAlXu2L3piNaC2yGbrzV9q?=
 =?us-ascii?Q?IAMyKBskz0pUZ8UBDbiMoCvcbrBBAkUnqSqfUlpSv2NJSVoiJh3YeuMQY1jP?=
 =?us-ascii?Q?a0TckrdCzbzczzaFiYyo0ssFVDzc6zuTCrCTvmCgTDYZl53Z+mgQ6nN0+EFB?=
 =?us-ascii?Q?R0Vz6awY/ArqWb9ZmOV2NtDozxoCnT98nZ67Wz7Vn+IYXXyLtBgP0irIrKVN?=
 =?us-ascii?Q?0MU7DpLwCB6o+cdxJhDQ6lu6M7DJg1sbjJmb+7QKuuWr1G3oOqLwc3N3QGUg?=
 =?us-ascii?Q?d0wq303T9MeKDYBNGDUybd0AJCe+pPVhlpvEFUIFTLJ7HOUofDZ74YL1SYVF?=
 =?us-ascii?Q?mVcqem6PoKUVjpnvq4MtBReJZVGb2sUFxSKLHTcxhTceSn0mrupq72TeSHHV?=
 =?us-ascii?Q?RXdHThar92qe6f1JpBNBGHohtKcOAPz8EXaZq95qxjLUGwXwAF90PCKMz5Sm?=
 =?us-ascii?Q?PVIILLCrH/OkuGc3HwayAtTTQt4pQz4n8SugGSpe5N7VqaphG63OEY7Ax3cs?=
 =?us-ascii?Q?Cw1IGsT3mdpSo1Ppz/wlz2HrkndojE0hKWX6/8F3?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae357065-76bc-49b8-8a30-08dcb8efc916
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 03:51:59.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfi93E/6yY3ucp8q079qPxdhH1j01snGjY7/i0ra4bbRyli+kGcHGZ0CVzqXNhQYCe4M400crXntp5tLjrfklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8564

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..2c2093c77ec9a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM43752
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


