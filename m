Return-Path: <linux-wireless+bounces-26473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F365B2D76C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD41C219A8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B02DAFD8;
	Wed, 20 Aug 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gxyLZuwX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012055.outbound.protection.outlook.com [40.107.75.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6152D9EC8;
	Wed, 20 Aug 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680340; cv=fail; b=X2DAEgA+NBjrhrSpFM9GtADfANo8/YON1NOcpeAxkZJ9gCgjQOch19NFh73ZtIa301hWkPDCCWrGtYDoad8Nf5cN1HtjqDewKB9sZqUGE9WB9EZrLVdelZM8mBYYgrYc84AVy4aMSKF1iGPe1AmF4Od17Qr3/PTdiZB1hN6Zkwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680340; c=relaxed/simple;
	bh=sXR+qHHHf9JeNpovALy1VcizE1+Oy0A/BHvnz0Q7gX4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VcvhT8QSWI5SlgVbbcp9rAM/zmiT0QVy9nlQx7fBLWARupSIMzx4yFW1JLHgGtJfLF2PaZYFmSlS77eeGsUfTNiRO/leOeAbe97r7s5sn+naDnaaYnyaSfQdlD0PkDayhwIA9JvNuTzSt+k6yxQiBJ+E/DN/nPVrN6+yVr8UunA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gxyLZuwX; arc=fail smtp.client-ip=40.107.75.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fevVKNdSXBwO1q012vSMH+zXMQqLCdgpla5/2iFYdPNWsj0rSWI+VVXFHsZEWSxXJpk6oIpynKXI8p2GpXww/d3twz9BhR131FlPq2f+kZO1oONFt9QFsrsX8dsf0GvSbXJQ7DbTo8rV/5/QnS+gnXPNSaP03H5kEbX6wWNR/6NJaMRC0iEoAjBZNyk0sXDIau3pDPAPaZK+jOLbWmPsxnOdByC+BEOVnipL9dNjh82EOdEF7sogYdne2EiL6f83uk1qbKH6L+PCPXSV7uPRInRgLvCmWaPc19K0L6EpOuseh/dsyxcWTq+WmUFFyqHKThNtmUvcyauOOak4V9F5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qbPK8sMeB/TSejKDsxHVuGOhOjx5KiG1wNUimIwriI=;
 b=HJk4S7NoEtDD8RL01SqiKZ46pp2SgiGDmcJ0Wsl7eYW9Dy9q/DvJ5jE92c4dp2o30IemGKTpMSTjN+xouaV3z8C3WjGsumE6FnfuCfApeqyl3c0witFml+piVN76wIeIey2mHA0cdw5tDAOTJq/52fNkZ199ATPF+6duFoASa4vNVd5E5i5QFDiJoF+ufzcGs5CbXmhXsN0wLALnMQZ14LecwNQu09GF+LXyn8ttl7ReWQaw/lBB4yYLDg95bfcgsPkClIqZUOKbAtsL1gbqEA9puxSCElcwHpQ0SWSIYN0u0VK+w/PODElgJeUWPjg+K19A1JBmvtUxs+SdYjxEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qbPK8sMeB/TSejKDsxHVuGOhOjx5KiG1wNUimIwriI=;
 b=gxyLZuwX4vb4i7fSHi2TCT+mtdlriWvSBDzEjQTglJL7eXsNEV8zfzX7tiEiDJQDx94gBpAWpSY/RDEdea+8SLnuFius4KcHyWNJkNWI1RTZogHATjq0f2JNuOAu6k1qQUlbuY7oyAbE3LcLy79gTWy2KP6nq0ZuX+sxV2FLhn2HkgIiXi/LPLvk1eNnW9hQ9Kr06s67dj/+e/1llrb9F+qX4WhRoDnMNg76cnQWLZZxMkfWdSxBa0mwSQbnGkKGKh2dD3OpK4AC2DYBYOAZgMyFJmA6rFagHwlv0kOT7EK0jvAVYVvLyLgH0VabLGOtbQ/Pi+ZKnj9W2mf6dbV/fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEYPR06MB5230.apcprd06.prod.outlook.com (2603:1096:101:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:58:51 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 08:58:51 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] wifi: rt2x00: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 16:58:43 +0800
Message-Id: <20250820085843.397945-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEYPR06MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ac221d-b19d-4792-92d9-08dddfc7c8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DgNHPQu22wAUgM9+G+W67qAMlywRz/PzqafPyFHOx3uLY+e+njxZEXLR0eSv?=
 =?us-ascii?Q?IkCj0p2SdjglzGbqDWCqR5Ra/vs2O1xsh6Q9Am2UuEW8+hdvNnxs+UEDyPfZ?=
 =?us-ascii?Q?Phd8OplWTb/2UDfLIz4mON8YLd8Tnq2k8PnV0Rj4M4UhkAxluaZvLgHGMsFk?=
 =?us-ascii?Q?0riKQ7mFuE7FK/XseLHDJF4vM0vT5ixucqIsX7dVAjCZqOmqm/V5hsxJScdl?=
 =?us-ascii?Q?hXHt4VdOQc6EjKOi+H6hBYXLcoXTindqoytjTv9bCOul/Xi7P2TDcWVCs7ej?=
 =?us-ascii?Q?Fsh8SkDe1Vud1olKkxkfBIIoDlo2gBTEe4fl9GtDH4oK7+0nbfBQ5wBy59D4?=
 =?us-ascii?Q?TgEfj7/3dFhnpbwEonGT9VxiS4X5OWXaPFujVbpjyJbuPeO8k8W3TMJS27aB?=
 =?us-ascii?Q?EaAEOUqBGhIAznGVYqQBZJ21xsEIKHeiaFlQ4oEjAuNvyd1hc5oPaEw605zi?=
 =?us-ascii?Q?Tln16YWdj0N9+/WsCzn5xpKHPlSsmEy8iTsnD+RFovwOhXSFkmjcaZC1yuAB?=
 =?us-ascii?Q?zDkQ7exXPu1AXabVJuE05fg1+i9yat3QkTunx4bfULerDcni/HjKD81Ftcf9?=
 =?us-ascii?Q?795KwClvG/b4JrZMC4TCTWN+MfjtPrukLYzo/c0XwD3dQ0haBSGfBwcSKtme?=
 =?us-ascii?Q?M0tyANnhiWiflNG94o7XGuo2EyzbT1dVlV/V2uNLuZ8dg8u/OHpIbavHeTeP?=
 =?us-ascii?Q?OdXiXrujbN+k3o7XMx5qoTJHxModT+oCQ2kYUcV0vFLgK8Iuu/DdCyF/nir+?=
 =?us-ascii?Q?cqgXBpVLRN+8Fd3KJAWqhx+z0LjRmv2dqUE4sotkJEHDAoQKxKGOzpoDnPtK?=
 =?us-ascii?Q?Qz0UoeMIdtCYztEcZETMO5somu2yCUbT3pLDek9I+4Vssw/f/kjdcvouOahH?=
 =?us-ascii?Q?J8/RX2/SMZwPwtVmtLgu3meGLfOx7WpuRrZikQUHLZ1GK8KNYosXN2Kq+5Jo?=
 =?us-ascii?Q?vBIXXqNeQw3aZT8O7i4Y6kUwFdI1yEXIzDargjgGS/ZzVrWUAyqMXXzKATKA?=
 =?us-ascii?Q?FjrDHordSYhTc2zNM5hhHToHfm75TJYKMNxvef/K400m0RrYvMFDNyotkh9v?=
 =?us-ascii?Q?nWHK+HYIEFD9TXgKPAa9+IpwpPJsUSLcBo2hIFPmwl8yw//ynvGrSyJJ5n/w?=
 =?us-ascii?Q?p9Lxb8WlmzwkVIxA00r0SLmKude5jRFOq+nxM5A/anQqSksVRYDw+IX6r+3D?=
 =?us-ascii?Q?dwRrJmLzmjFNXbVe+cVzCORhxVNdjtOlEgEWiUYVEN7y7IRDMg6FTjn7KYCr?=
 =?us-ascii?Q?pdbIR1+wWpUHIKKfSTKY2iNMsL4RkccVlMeyUw40PiJwkZyWT0frQeqpWHRH?=
 =?us-ascii?Q?Zrd5AZz9FOjGbb0kej8U0Ssm4U4VadhFKf4MvZI87JhfTRSbswfYtifWTMfg?=
 =?us-ascii?Q?wKzPkp9ycuuoHKdiCuYASUPSVNCbct+qskliuIcKCCtG22M652rWKA4U+mq3?=
 =?us-ascii?Q?XqkBT0xPt9HJvF1qESzlDx5UF8blrL3Mo2zhSupiqzCFnz0z8rObBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yrxSLafz/Ad4TWnOYZTXcWzvsiVes8I7E3TyPxJsLrRyeUSqTd5+NvpotBai?=
 =?us-ascii?Q?K0mrbccJ+KYlk8C0uvd3SdHU3kGnY3MqUBkoV1TYNEZ4GDE5vGUxgY2rql/J?=
 =?us-ascii?Q?OLUwjAuj6Qpap69gCLRVR3WDxD/fl4elVB8X77YxroMxev7rCCb3SJGDwI39?=
 =?us-ascii?Q?wT1LpAotyPH06W49n8XwYGT2wRNCahNra758Yt1xrbj927f3OlxPstPvR1O5?=
 =?us-ascii?Q?YD/UqrUIa6WtFqdAGsmHzyY4oMRqfNfLu5UqL28zCSSRNTUiCtJwNpvkC0C7?=
 =?us-ascii?Q?GP81Z0sSvcODiCcTYwWm0g2r/HFfzlDy5aN5F17Dxtc8K7YMz7hMj4r5LkdW?=
 =?us-ascii?Q?SoD87oj8GyBgT38ebPdC93wWXIqrNZs6GfImHzASaLMtL5D2uwOGUrlc2vej?=
 =?us-ascii?Q?xv2hKGzoa9zqU3AKuMzRUcXpFFIUIQXs8S1CEWmLKS5ysO9SkDsuoZqrtkD+?=
 =?us-ascii?Q?Q3ytxDicflcdyUlwyP93+p1ZaygHpSj5bxA4Q/nZztX9nIhnOe9METj40y/Y?=
 =?us-ascii?Q?Pw/bbEzkV9gmbnRoGpj694r0CjF7f84N7wsagKN16iq06/LqYwQFBsib+pyP?=
 =?us-ascii?Q?y0tDpV2joR+dY/kvk++gATrQbXF/3wbF4XYblAEyQGv05dYkvMGxK8mg2+9T?=
 =?us-ascii?Q?y9fckg5iwSlD3KCTPLD1tAUT2EPpoT1/PHcv+NiJY6TiGXSgxgGCRMhOGEVb?=
 =?us-ascii?Q?49faMpy/hp6BXn6mBQUcR1EpHshZrcNjEZfPy8UoTfDBzvDZIz0vzKQz/mrW?=
 =?us-ascii?Q?v38oJ7/+MqQfCDwdlFbZHWD6viRtUymXLRHZb//bVkcu+EtxXV6310AcKRhD?=
 =?us-ascii?Q?il6u+KMrF9L9akf0sUMEspPpmqzxHLFp5pCT+45gq/6YE8BOSCe0q7z++vc5?=
 =?us-ascii?Q?hlMUv6u18x/3UQK3VqCaDWJkhxRD/F1AjYLOytiLIgE2fPM3OPwf67VT2GKb?=
 =?us-ascii?Q?tSWkPQ8AZsOKlRpiN0R32COcxTsbjarde2gJdnRHD0sBaw4PX9ezWk6U+I4G?=
 =?us-ascii?Q?h2ZH54uT/bUZYXYUNxUcbs9oeXSztVgQromXQB/D13bz7g4N7Bmwmqg1mjzO?=
 =?us-ascii?Q?j4db01TMpRHgxoTyTkqoQlhokHjhZFVmRGlpYTcQlnwbmHeY3WiL3UfzcdEb?=
 =?us-ascii?Q?7HZMkoCtEEzPhax5p/xZmz/uOD7AaKxP6vynXcwL5Ukdp80++UAXB/MMydIP?=
 =?us-ascii?Q?OThsGv7eHDuQEVb/+K55G0Vw9RQSAnSR1vXmO/3lq/5rkmTS8pyFOQilWqap?=
 =?us-ascii?Q?CUOP0oMwm01DtA4TEpgN1+7DE6as+qI8E/IrzxhSGdUuIKjWRWjMiGVCp6hd?=
 =?us-ascii?Q?tLZ+zZdgieylvJn9dq+zfvylg83a5gMpW/d5RK8zchy0G0VoOw6Z4HARAFNP?=
 =?us-ascii?Q?mH3J22SDYfwxO7qMozhppqu867MZBf8ymHAifb9gN8bTpaBWfkkHKiC+0ny6?=
 =?us-ascii?Q?QDYhmAUSVOwjsi8DDRmNANpInxTmfo7SOKWF8qneVvRdPwe6ZuzdGLKGmR3O?=
 =?us-ascii?Q?jIzjyEkvrkY+OHBvmnjHJrApEZn/0fwYu8OYEa2QvERHSNUIcUyRnz1wcBvi?=
 =?us-ascii?Q?eU4vY3W7WVCEDgVtmO1FWRoivvRxieV3BAOEqjPm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ac221d-b19d-4792-92d9-08dddfc7c8ae
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:58:51.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFKvYb1DobYtTv/0BhOqMaFxb4qBFbyR4KR/vNI0tlPg+smbjrx8WUirdnL5ytTNR7LIA5y9WEINRyBBjJ+0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5230

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 8f510a84e7f1..e5c99fc6509b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -289,7 +289,7 @@ static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops
 
 	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
 	if (!hw)
-		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate hardware");
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, hw);
 
-- 
2.34.1


