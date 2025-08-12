Return-Path: <linux-wireless+bounces-26317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC631B2290C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9555017DF3D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7D284674;
	Tue, 12 Aug 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Vlv8ehpK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013024.outbound.protection.outlook.com [52.101.127.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA4284665;
	Tue, 12 Aug 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005600; cv=fail; b=iJUP9scNJJ5GIktXUX7QkAQ+xq0rg7SUxIc2/ux/YWopfy/xMOzA8IOaCooMz2B/XOfqA8lrWT/Om+jidy7jWrI5vjcpioVeJzNOGnogeeNRYn662G5HGV/lLpdHR4+wCJjDKQThhZWCcuc0tjoeKX8fHIPwx/fG0OJ/Y8mWYIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005600; c=relaxed/simple;
	bh=HL5P+7YdpEnK/ZhPvaUypOP2LR1n95K9IY6dTAPe/U0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D328yxyD/VpnQwhOJ4Oa7g4gy2zSWWcSpXfJ7pkPeTJTGRl51YLL5rEI24yCo2qDoUZgOixxP7DIXPZQbAbfkpzhMHRoo1I7o2vX0z0Bpow0IkUbsRhL1G23hOw+o2p0HnDn3jnraNSCn98PNtRojzTGT2gQIn7QinJc/dCo02k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Vlv8ehpK; arc=fail smtp.client-ip=52.101.127.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajq4j2FU537zIPYdwQ9CfXGsmqsGJ/ZUYrwsRsb12WquFETrmE/MIWOVGwrgnWffKc+dtt+Moa/uRQjggt9g5u2MeiXmtxMKfomyUBv3G2xwmA5YtVpFRSNY1UCe7fZeC71G3nK9BHSsmlwN5fHdZOYL4own7wfx6pyf+fH7k2NJ7n+zOMKgCpep0SBUg+44KhqjcbezXfmVrJjhkTKDXhxPSDKggMf3/fP0rHUcCCRlyJ5J1QBBO2Lbxi2Y+XhCsGxfB9CKtZTvaElMlDo3+fJCf7wjAf1FOzCdY5dY3AoVb6zJ7nPEyRYw+IrxVQGlQmJzdwzX1D2TFgeHRnyH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mkPYbyX8ZkXtrhmv1nKrsytudjWL2VFpSRKOirK8VA=;
 b=vwD2HY0VuFwYV+noK0fegG5Zyz62WHilM+kvxR0/88l78bDBpJw34gHq33zvFoa8IZzgCTM+YASYnA30wdusLWCL6mjFdo2wPxl0oYn8Goe5HqyKdC1gWHs1bJTP4VpQ7RaHhEjLiSWBUXGhKXFXG142uCRrBzG4W7q2R4TEW1XWxz4oUWNjKj7aXr8n1r+zVGVo8IHmek87daizIUL9G5DsR8yvPamrqrds47gLXYKFXcGFKRIe8N7AFy6xOErRbWlSMGjeVFLqDDmEz7H1IqECEpWfiq3JXH8qS9Nudvj0V5QE3nW4jUeQT3b0xGnNcgzLKeZ74O+ZvIbJa01qsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mkPYbyX8ZkXtrhmv1nKrsytudjWL2VFpSRKOirK8VA=;
 b=Vlv8ehpKKFBcoX5i8N0148trb6aYKptvtyfLSTZYJhIrThMLRW0NtPd256csI+nY/nX0CHw9GH/1KGoefmV85UAju5q7kUqnsQbIkFbfwI5ngW+1qoey6gBvg+g742PYXF9rW5sc68g1GUNtWrjXKY6p+YWr0IYTjsLMxY1yAes3FbKz4J7SVBzhryzxxmKHHwIEgu749ju7tKcuBVEI8zjVOePHdR5GyjtQz3h/i8bRf6hyboXYUDbJTCkuFlbgmPk/Ul9Jtx4bfbLZIy1942WnbZ+v/JR9RxSMNHTV6DOwUHPhDc7x8z77cl36Ex4Hl6xR1JrertP5a6H1IF9lcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5040.apcprd06.prod.outlook.com (2603:1096:101:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 13:33:15 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:33:15 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	linux-wireless@vger.kernel.org (open list:MARVELL MWIFIEX WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Date: Tue, 12 Aug 2025 21:32:18 +0800
Message-Id: <20250812133226.258318-6-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812133226.258318-1-rongqianfeng@vivo.com>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:404:56::17) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d47e9e-b459-4b07-7c9d-08ddd9a4ca8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7eIB1a0qK2Dsb+RReHQL6HPvtP30BlweUTr49dGVaSHs9Z/pBQc4LHVP1A1F?=
 =?us-ascii?Q?ILAE451G2YGhNnffIRxoDt2s1vBeW0GtFMSLz8H+csII/J4FY1zG6m7IjyKW?=
 =?us-ascii?Q?tlTcGvI2MfvBJwZyjfGGda/LfyoXq50ezRfRQyyyTrHzXzm32Le6JsUQByZ8?=
 =?us-ascii?Q?r6Ih0dY9Ca0JOxU9TZI4uYt88WIyJSvwYOCJeUBbhezrqgk9n3SzYhUmDSQu?=
 =?us-ascii?Q?/tU2DP5avFocEcZz3pl+wPPvrxKM/Lq9KX4z6uT3+86tsFJ2LqlcdKVQiiXE?=
 =?us-ascii?Q?jrka0MKAJSCv6bQ6VoHxu7HpJQPWBd6Uqt9OladaljxC0cZNTcPnl1i8O7kD?=
 =?us-ascii?Q?vxdHyqE86I3pxEp+UUtsAbFaoKTfrQ6+VYGy/nyVlpNsebOQwXDrUznOBYDW?=
 =?us-ascii?Q?HNbEuT8ziiLAlhiEteR7YXvkRLpSCPWKYnNgCDKEx3Eqoru5Su6M1Lz/kEUJ?=
 =?us-ascii?Q?ee2JBSS8Je5FYnetxhDuVDsEAB86h/jGVple0/hINDA3sreyo6PJxpewZXXb?=
 =?us-ascii?Q?IG/aRurQMZfQ25NHu80V04KqFMonHu6ERkIiPMrQELmImlqVLyn42BnWWJSD?=
 =?us-ascii?Q?ddmbvvzjocbLVMpRQyS32/yL3llI1bmx1GY4YXt4R+rPxx52wl3pSEv0r8qV?=
 =?us-ascii?Q?AGloBLtHP86GHrZSLDVJ2kA3Bwr94ciKS0FmW+//aV5pUEzulqglvXM/y+sU?=
 =?us-ascii?Q?b4kArCNgjuNy8xETDCgTWmJRK7aYaKcgxWfx5hwJ4ewlJzcRL7q3g+T5UhQG?=
 =?us-ascii?Q?ZO/LPrLkf4kVJhx9vTRROQoWbF9Mc5DHGzJID5yl8o2GibwdDxGLzSXEJfhK?=
 =?us-ascii?Q?Sp4DGFr98Ws4Sy1JkiYu/8CH3KwXSdBZcIW9w6G/P8BV9SxxJoFvoUqJo7mJ?=
 =?us-ascii?Q?PSS/bksXq96RPkYFcMnvrMhzvYYr92h1c6xxaGbR14nOSs+JKdWhk3eNRw4Q?=
 =?us-ascii?Q?GtYJnNG/vUyF1VlCR338SeAJEBL0b0hF/8R8Ot5UIjDwg6DctW8tVPv1Tv+n?=
 =?us-ascii?Q?lEyolhDGx0C6qAQaH8XDoSQJJM/BsKIKhVHmO/x+aX8mmv1wA/U/edQywqhy?=
 =?us-ascii?Q?66mmYSywo6jMp1EDkOYhimtJe56DijSZqWQeGNItTy045xoI5xmHFY5YzAEI?=
 =?us-ascii?Q?xcsDDo9YgSgC6LvOby0B79m9iOEA2f2VNOlCjlvX+vWqDQrWCSMHjP4WXEX0?=
 =?us-ascii?Q?HIPcBINAtMwJ9iO7aTaO+Dprb8TpE9Dk7x3GMu0FrF/B/MZVWfyGemWFJYrA?=
 =?us-ascii?Q?kEUQy9Y0RbPBTfL0iA14vZeO3le/us0wiBMI9c4o9Xornyyguf/if+Ox+FUF?=
 =?us-ascii?Q?r+pBkHmuS++nxTCSBY2HOArlJ8wP3O1wqpI6POGI+XYhRPxI1mO3sTB4otH/?=
 =?us-ascii?Q?P7t+QeTkUVwDTPVYRv8vcpmpRjV701wYyxhaWnM4WcmROKh93Qvg9RKuc8qY?=
 =?us-ascii?Q?g2QPYJquZUPE7OVt0znL/6GszMw32VTto1YYAhyjnKPHNqsY/zScYOUXmIyn?=
 =?us-ascii?Q?xmY08s2iCJz1QHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GliKpfidqX8z70gqmUVGURN2OtLUlyJVySYz9s9aI6N2kzsNmLAeGVgyZl+j?=
 =?us-ascii?Q?+QDVbU4WBnnFxLf2dABQl66slG/Mx80dNSURZS4DxpPpDuVcksRZ04JuX4Z0?=
 =?us-ascii?Q?+09vXUMY8k7x1OyUa7cMhNrLBcKg8sv0cRkfEl0z/BPwI3NaBG9Gb7EqwkCn?=
 =?us-ascii?Q?6tALAzdLq02xvn1F6HWz5jjMqwf1B8Ehc7hLRCHICmotpTGuU6vkCg5aXy6I?=
 =?us-ascii?Q?oPlNfW/FZ+0FOEoFlN+FM0JCGnQoRYUwVj+TaYIv08WKr3zWD931ZPc6cZbj?=
 =?us-ascii?Q?wtmpWKVwLQBVSa2zu4dEikkXT9Z2AIC/i6uWV7CfnBVeOmTN+ejIzzekzg8l?=
 =?us-ascii?Q?gFBXgg/30BPKhq42zzyYu9pAsB7azK9+SdsZm/Rs6npYwC+SPbfY3haVzOQH?=
 =?us-ascii?Q?tNTgccFWFqOXZ/tagIobfzQ3KS36TzCxa6bkhnfONaibZRAe6Z1OYTgnxoqV?=
 =?us-ascii?Q?08PU4OpWppJzSiR6YSbpvX/q/ZoVCEPVyhg2yHdVGzCYGnc/jWvCTeNBDysB?=
 =?us-ascii?Q?7U8BB89UiOmb3SItL6n/q95HQ771pwGBO8yptVB8CIMLCqmvzkXFLNYY9sxd?=
 =?us-ascii?Q?Qp/Ho2YyX54sP8lrISFIY3/iYyf3w1IMt5Kxrp/myKhRzsZy6Ea1UrcKzwrp?=
 =?us-ascii?Q?5U1Wqxw3Y5FJu/CHh6Hn/O9QZFiHiyNNwfa720mB/q6IxMqr1WDBbKHL6Z0P?=
 =?us-ascii?Q?PWF8qUH2QfokgHAyTKBy0R5GEt4u9y0WcyhOHRhDNLJSwLPw595ilK0RWRzo?=
 =?us-ascii?Q?71yWAaQ6iTpSbiDHZ2cBKiLWmGdxuIC1aPtqShcbWQi0CVccTr8j7ED1A5Nq?=
 =?us-ascii?Q?rE4pf0Vk5IH3claA56rvvzEtMSiWHO5FJDj5f6WWdX1O9rAphNSMlEJ4Lfgb?=
 =?us-ascii?Q?/52ocm/LrfJAVzcr7euDBU5CVVMfq7n0ri8KgDHWLDsdyddp6gsv9aeejnIT?=
 =?us-ascii?Q?qvZHc6NduusmmUl6ADessFk8HzTG2j9oMCTZgSS0P4mBUKMQS+gsh1bIFimR?=
 =?us-ascii?Q?1EWBtDEybhrU/OiUobFu/2ATvy8joEUqN5UTW+2ZI7bHhelCT7t8omn22Esr?=
 =?us-ascii?Q?Dwp03qFAIZ82+2u4WNtO8SEUG7jfunoOZU6T5h5mi84rYyoQps5XKnFdJxsO?=
 =?us-ascii?Q?XxSR/Y6HeCzX+ixexDmVN52F3uwIzQYvUqsBmdLOHIBbP2kfdjugf1ZUk2fH?=
 =?us-ascii?Q?oFYQeNq/khRjifEfhC5/8mCVuJBwVXWThnIZlayjSgeQibqQvVL1P6gB0N7Y?=
 =?us-ascii?Q?tsAXFnIjOaZ4ZSkkw4/6IwLYet5vSfye6nQSoC7VZksPAGNNVJ7jjcKLSKjW?=
 =?us-ascii?Q?KHUPOnVwds6fqgNAOYQbebTyjqcp7jmH7nj+vbXE9Rq+SoySbpG6lkX1dmTv?=
 =?us-ascii?Q?eFgMBLws5tFdzrrv7sUe9FvWJ4LFPYMUZlmkP21dwLsR8UPQ8sNNKVWyg3Vh?=
 =?us-ascii?Q?VXkv/+oeY0uqjK+RqytPINC+Ci41YKr+wZ1tgDYK/hqbuA+UcKoXnfmhEEs8?=
 =?us-ascii?Q?yoqeyxeZAOu/DyQ1KQ6F60JrBMU9t/z7yDw2R50EKWhn0B5EjyUS0zBL8hew?=
 =?us-ascii?Q?7EqC2E0IJiYbCYzCiEPRVCF17YP1HHk5xKuztfwr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d47e9e-b459-4b07-7c9d-08ddd9a4ca8e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:33:15.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjAZqQRJMKyT52cPnYn5ZBnhvNCOGQseZCGCAcEQ7stXRGT1yD8ssyaqt2e0FYEBd3vowzBQbREjiMJEZdUa1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5040

Remove array_size() calls and replace vmalloc() with vmalloc_array() to
simplify the code.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 3498743d5ec0..fb4183ff02a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
 	 * additional active scan request for hidden SSIDs on passive channels.
 	 */
 	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
-	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
-						 adapter->num_in_chan_stats));
+	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
+					    sizeof(*adapter->chan_stats));
 
 	if (!adapter->chan_stats)
 		return -ENOMEM;
-- 
2.34.1


