Return-Path: <linux-wireless+bounces-11506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC2953F4A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 04:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A9EB24A0D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6C768E7;
	Fri, 16 Aug 2024 02:06:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263316F076;
	Fri, 16 Aug 2024 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774017; cv=fail; b=dF7WIOCPzktzvkqjU89eNVYlJf5pLhdG9WGH1+TLlIZ4yAgsGDJtmMjmV5Q75364NEQjV/5NSO/Wmvv2hQWaEUfwWYi38QXn5OnvCg34zyWlmDOW51KhaiV1hSDHfw1HyCviDVjYirU5gBqpcgx4rJU6qZc+EIrrMWz7RiXouuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774017; c=relaxed/simple;
	bh=uyVPq0vuS+FMU0odfnlfw0F2eZnLPgwjnpAdPSqAp68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WeK3imb8jPyH7k24Uu0HQWKHO6DO+qH9cJGlsS8Z9qgmtxjmIsv6zfI9Upb0NNyUwJn/mFikVUFmS+1IRaVdqHxaPtilRgvJuKXdMWebvHLrrIz5EF/K3rGWEVLffPQhJmlbHgGE565suB2JBC5KdNlvTFJFHx/v+vIPnGkleHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vn3Smv2hncmlzyvKY90vWZoUcrx1ucsTppUpii0p/9v7JC9FBNOjzs43DHrUoldAGtTzoEYvvHHJeCkeJhu3J1t91eHRPReOqH+tXmcLev3NXnKYCR914Q1H9MAGfO5+qDU5OwPt+u+ZbiDg1xq36DKN/NdZVpSbC5zFwB8LpwUd2kUncslQ6qEbxDQd6/96gK/R9diiOcEVz/cG9ZbSGHiZuWQRihVDNUvN0Gfk37qogbno2efgexJHAWKcmgscjdpgDBxYcmVw774sJxNwF43y0U4zrZWO/SPBEHcjmWdbgvXYzdB+WXX+2B3YUWUfmAzpmZDO3FfrwrpDWMP3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iPX8WFIoQ4QXgUD/qR3fD/Finzms7t/FKq4XAi292c=;
 b=qjjeKEw+iXH5xwnioOCVYNqR9XTupaOvq4CaepXCcTMpUloyFnNJ3aFXOrEVsbJEjoELZocWhdWscBvhfFej5nXSYfxOnAyF6jTPm/Yyxq8R4a5uocVxmF1BEyY8PjBY7sZR8HVQyj5Z/U5dT3x/nE85fqFBiE538DHPVU4vl60jzngUi+bkZoopYL/HJ+a11WxnPQ7vxZ/pQ1B8shul4K4T+icr/AbUmpiZURuFINXEophxI4/4oxcFbzf1VhH7yZ0jl+bA38zO/AFPDSMCFAMY+OKhrNSbsaVVv7e4RqZBJRQvYhb1cU1AnLzWLzjP8Nv4Bavc5N/qEpAb+GCfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7444.apcprd03.prod.outlook.com (2603:1096:101:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 02:06:53 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:06:53 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	saikrishnag@marvell.com,
	megi@xff.cz,
	bhelgaas@google.com,
	duoming@zju.edu.cn,
	minipli@grsecurity.net,
	yajun.deng@linux.dev,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 2/4] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Fri, 16 Aug 2024 10:06:33 +0800
Message-Id: <20240816020635.1273911-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816020635.1273911-1-jacobe.zang@wesion.com>
References: <20240816020635.1273911-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: efab0547-a903-4002-d70f-08dcbd981920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uOgfq27T2ui2pI6cayt+DkM/CCghdaA1x3cqZEB6cl5PGg0WFhaAG//vefpp?=
 =?us-ascii?Q?SX3fEek0O0bZdILcXYpiQlHJeADkvW7uoDHWUsZEnWo6dbZaIY8jnvrYV7CL?=
 =?us-ascii?Q?N6mcrdudnsh1iLqIdxTRflwHNeZaWVIHCxxdOSzXRTGg7uJ7SWM+ZxjxdcY2?=
 =?us-ascii?Q?6ok1AIxBxdXXkgZ6CjAgYhqMenqoF5NoeHAI5EIse2sGrTkjLUAijXvVFnSi?=
 =?us-ascii?Q?gUKJhYQtEc6kLDFaxAwTmk7acKdtwElyApVU7ow0SKl7yNexxOSs2M4xYnOB?=
 =?us-ascii?Q?DkFMrWY42z+KP1HETYKZWK2pPZcXeoHOwcXLneFXcGyiTK0cAkzr5xZ2OU4a?=
 =?us-ascii?Q?d0jmZl04pHqMGA+72hxl33SlfndolzwLJ61raRkcOJurprkbWkEmnD6eloZv?=
 =?us-ascii?Q?W2yb/bnLHNlUV7nsTsUVBtnAutV6RalJ2oJWVAvT04zxOGOcRXA7Bt1ftn0e?=
 =?us-ascii?Q?U5GY4kYGukeHqO8a9i5cG2VtuhKo8ayqSopnT0PgoHaipQiM/RQRAubVCpOf?=
 =?us-ascii?Q?xA6VW8XIOffxOdWWWOckpu3YDI90AJWr2H6w2V0A1E4WH+sjl3tFL1PbMqIt?=
 =?us-ascii?Q?psaRjE1k8uC+muI+gZqDZtpGW2uck3PKXU7f3QAf3xfejnuVyOXSsyZ16U6G?=
 =?us-ascii?Q?wRTMjKyqcFlN5zANKgBnXmWPLFBMAGBdbq6KhkxzM9b9AreC+AWOgJmtHIM0?=
 =?us-ascii?Q?TQ9c2BBuLIGkBK1wBgtdEEclRapxeEnZAyknzHZA/Q2bjF75yn88TYYVb+E1?=
 =?us-ascii?Q?5nGcbDGaVnwuRmZdFpbdBq8ef9msLaYE4J8tMEhuttnXYcP0uyLttH7jijGl?=
 =?us-ascii?Q?rT51XA5tMptEMSUuM6qRU7vq7+jlPusuKYf2AhmyS8MbeMBwYhvVEZPzzgQg?=
 =?us-ascii?Q?NLfRMz9D2lH6qpyhKzJiWUpNtLnoXCzUC6ok/0IBwsWyd0fOL5D36Pa59T33?=
 =?us-ascii?Q?C94xAvkW+jSUYDZsFfG0kCn2fZGopcc7RUj9FJiXYhLBKxjGHARAAm2NTPtv?=
 =?us-ascii?Q?lsS+dy3Q1J4Cps8n9Es/GW0SWbX1JEeRz/EQPw1WuBmvCDgWCfLj4dn7js7J?=
 =?us-ascii?Q?amMBFRVQQOQ4qOy/lFWIznfwoeRt3qmLflQ9/Go6sexXEFFIqW8RNB1+Hz4G?=
 =?us-ascii?Q?/R/KxFwSbi+40NLXf/clpSGbJ+bHDMR+mC1SW94iQ/qkEOOBp31E2GOt8nL3?=
 =?us-ascii?Q?V0MxW30nXWVAvxkfwKJkKU8mL1xI1NUCdLCurSzc7T9JcfGS7hlySHHPkyLN?=
 =?us-ascii?Q?RqBODx79A5njDgNkHvSMynmgFwCKXVSM1WM97OISfuwc3FTWsNeNBl7yngSG?=
 =?us-ascii?Q?oXr/NHDLrVHsNsWiTLHs6oOEbPMqYGrecA/trcr1URK3lZz5IbBHurhZZ4aR?=
 =?us-ascii?Q?dAJF97cl6zMmBkeuNaeBMG5odGNL9QeS4KB2f/8IWTzvsnAwmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xa7m9eK0r2sJOBFZTdOfpNgktLgA+k4qi8X2W9bXACiGER005LdPA7RPC8GM?=
 =?us-ascii?Q?t5fGh2wQCd/u8vJgp/wQ9kMnU4HT6XzKcDt+V2q8I7fCoCzsRdhs9+FFMokG?=
 =?us-ascii?Q?6fQ3zc4R4lk4CH1Ms6uVr3pHL/xmNMyFrCMmWcsPJTfhuP+CgDygZ8KjLeel?=
 =?us-ascii?Q?6tCHXpfubU9+PGioknD9JjY9Z8sLrdxSBWuhIpwamzArp3UH5YGB/P0AT0T5?=
 =?us-ascii?Q?n0j63ro/D5GkrydtNeHNUUZ0/kIv8Kr/LHDhD2BEgV24Dvuw/SrOfFbpabK5?=
 =?us-ascii?Q?UjpKLSVSs+35wLJ8yv06Pg0nTWWW3VBaoMg65F6qDkedNDk0o7Oh7ECrDa0c?=
 =?us-ascii?Q?yl2w90ob9UOJK7tsYEkoJUi+dCOshwyrgf84KhinQ0HZhAK69fZEhT2SpzSG?=
 =?us-ascii?Q?eh1ixpAoW82PU0FYUToT0qF1etDUMYcIFIxcQTMH9GMbj7OOfsV1hcJKyocJ?=
 =?us-ascii?Q?Inggod8bRaUZ/bFSjmFFawaGghpgHRJmn4KPZkotQuQPGsnUvtV56dXMPkZi?=
 =?us-ascii?Q?9umU7P8MTuOQ4cMueCgTZaEzZvoFhGOjgS14N+t2qiazJvMvlpUUO2g7k8W5?=
 =?us-ascii?Q?bWqsE02Pxy2XfFugjW1+Qq8Zmyec7pdLtQElqwXBHsr+3SR6TRMDZUqWNODJ?=
 =?us-ascii?Q?rb8SAbRYhhLB3wgey4cGxX7CUCA1jR+kYgjiZWVlFaaYyz3Hk+Aul/7bnvNQ?=
 =?us-ascii?Q?S8CVwdgHuxVD5YvjTyOQKYXk+54BpgY6NrxJZ/QJ31RgxY+0zIhN1y6UUF+s?=
 =?us-ascii?Q?f9q2xD6Ji8hdyqiYJzRltgAt+qWv/7WuPERJtxVPXrWIvFf/xnxGVKFjlK3B?=
 =?us-ascii?Q?7bTSmsg7R1YhbdMDf7BE2fmoWKT3SjIrheW+Wby4oCje8zgD5EHKmTTt2gWc?=
 =?us-ascii?Q?cuQDef2m7VA74qeDMziUKFY2XNkOePtB+/lHPuggfvmZZAJinh1WFAdJcydh?=
 =?us-ascii?Q?DvPRVsv4+R++kCxjgPjre/A9/lsrtwoMnx6A8qj4Y5LpYM99sZGEGsO4CEkJ?=
 =?us-ascii?Q?vCCMUhmw8hCleRl5LHyuUKY+LpIEZIliCT5ch9Bfjlnizwmc1o60YuwbXEsw?=
 =?us-ascii?Q?/2xWNPA5ls9c4M0XxKUX3sIpicfgZlwCuNbrhdX+elT0th5Ft05z+TYk8Xl0?=
 =?us-ascii?Q?dT+wPRP683IYPN8YVJsv0XGg0Evqg0VoMBweJZP+KsE/cGqrUmn0Nrx+1gKF?=
 =?us-ascii?Q?2mE1W7lHw8GaLRA/WChQynwhOUsX5Oy7KbyEWZhXP6GrHlf+oJWc7ax4xY09?=
 =?us-ascii?Q?0UbO60ppK4IXCd1rzyyecGqQmFiqZe23qGawNT9Bi2JKbR/QFa8UlAPVCcvr?=
 =?us-ascii?Q?VwniG2cpiZY2X22qPy9jjITxltHMh/jk8z5/QyI9906Yg2O78yk2vFRBOnrD?=
 =?us-ascii?Q?yrGz1XoWQrif4doNH+KotjHxiKhsg5MtS6skEy7SeRNwYRgKFACgXcS39pMM?=
 =?us-ascii?Q?w2FKc/sfFXE3HQjhD438PJvBjInd6wnTEUWbXGdQNerKxlmPWf/bcWDEuQKK?=
 =?us-ascii?Q?wBaB/VYRBfcfIg1/FKDTsxQW9YQYButylw/pI2V11qNjFni/CaiLrCjNHXA1?=
 =?us-ascii?Q?O6bCM62SBOXuL9Y4mo4TUFxCso8Yi34q5EvB+89k?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efab0547-a903-4002-d70f-08dcbd981920
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:06:53.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4Lu95a5yb64woxvmMsPrjPQqQP+go/lbcIoi+cWqzdS3b99MXB4n01nAUuHz9LExASs3th1Hyf4YaTVmHCNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7444

Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
external low power clock input. In DTS the clock as an optional choice in
the absence of an internal clock.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..a3607d55ef367 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: External Low Power Clock input (32.768KHz)
+
+  clock-names:
+    items:
+      - const: lpo
+
 required:
   - compatible
   - reg
-- 
2.34.1


