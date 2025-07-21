Return-Path: <linux-wireless+bounces-25714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D04B0BC87
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897C63BC0F6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14F279DB1;
	Mon, 21 Jul 2025 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SiHcwqBD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA362797A5;
	Mon, 21 Jul 2025 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079465; cv=fail; b=Hc8yK8syrOjCN9lxKv4AHkjiA2LFTnlhZS9gb363ViKTzBw7OUhNOIMCAPg22WcGdiZ5rTiN9b862oqDtgI3gMXwmOee8ROl1cWK2G4lUef+Q2hvQTE7w8XFN9qR1lFh35tYrvA15GapYP4CYjyfiDZsYxKu1cFQItoTQNpV6bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079465; c=relaxed/simple;
	bh=BMOxV+pKEW7qs+l7X2z0aZ2cKa4jyejDZ6GgEQb0JHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XltvuMOqL+NB5XmwFEccBM2aLG4vk163wYom2f8euYzgWJe/gqJo2bCrvHSFs4bKfXR3GX3JNVFP1N1dNP4kh+dg3Jnh79FY5KGS5qHQ5pZcE60diWQq3zeBSJawWSEfBYLe/qCi2qB77g8zhqChjHzggc5fhuMDw9P+A2XFT4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SiHcwqBD; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZtZ6xYIZm0KMD4ktpQdngM05bJn4D+M73qY9kmuf3RViSF2dPISvzM5LiG1ratkl93HPSxyCaoyGS2EUndKAWoo1F4eXNleHmJbtV1GhOhMI/kwFD6i6qEnKKtDf4yHWDRlk/V4uu1twVMh3bfl5O4AjIr93pmLct8YGn5clun26FRGjylt4zrmSeXq/c5hOzzbqEqOGs07d2l1kpTMhKc2KR15wTJ8I+qfpCLtdtnIBH86CQBanvXx0Awtr54+9vqaVDubvvmosa3VT5nobwdh9RiDU1ewIGb6/RjAQfvmeL5/29ute7N/zsDPlVxwpgZEFwzaDbyqqms12aWxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx353Q0sQaUQH9ojHqqzKHvzP7e/wQxCs95kZ7y3aBc=;
 b=TqCWrZmO4eFX8LGW60HXZx10xgg66TFx64/VqHJRb4JL4IMmxeaKQKLROfRTlO0VnK29GgNa09KDZCTPhUtT1GHQi2StWmL8whHx5PEJ6xXGAu4J9ECou9MNzcIyGn2bym+/aj3KsLDn0gnPPBY9T4scWumT8KTTO4HFU/D8Gt+Zh7/Kna8c65MRyJ4BthmXmfCE9nihAyjoqyg/ewExFc+ZMQLgGxNjOneEY0VZrNHB0whr4spMK1AVYI1mwukVQIsA2ljPnOpwFtEnOplpmk0/i9mHcbsMmy9d/uD8ADNAc3ZxVaCB7CYTY2v3qzzwFnkeqhaYiX811/d8NABfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx353Q0sQaUQH9ojHqqzKHvzP7e/wQxCs95kZ7y3aBc=;
 b=SiHcwqBDGEZuXCX9x6Vpcw0b3zp1Hi3a0DA+X38SzDu576TmyzEiGrnJiVfRCmPMFzqJBgINv0GPeWcBnS2H42kAtNlEFo9yrGbBiPKb1zI92qeqvV8E1Wo+pzvLerhWmDxAPimEUM5z3ln8hw31oN2iQ7sy1MiPEEXrhi1qez7dCUEI+EySE4Bc1pWxr8zhutDw1FuHktWMG3Cq7/DsteGyKZnFsxGft5qjQ6f1zqlWBXAG9zAC23ScCxXV058nN0VU8gYRCU4SjNASWHvtOopl9P00m5vONaB0LZQH+5tjtlYkXM683i15ijWDKH0rO5CvwE7GMi2vKFieXhj+dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DUZPR04MB9728.eurprd04.prod.outlook.com (2603:10a6:10:4e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:30:59 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:30:59 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	jeff.chen_1@nxp.com,
	brian.hsu@nxp.com
Subject: [PATCH v4 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Date: Mon, 21 Jul 2025 14:26:19 +0800
Message-Id: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|DUZPR04MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 043bf10f-ccb8-4a0d-e2d9-08ddc82027be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3EoiZjHm0gOEJXphTLL1dJ5WUqMXVnb+ij5qKt0Xiu2t4geJLZxkjrluxD6?=
 =?us-ascii?Q?x9rxlqpkEv1WrCRTavCCXGmMo0JpZad/I649zwwPRly9Fwq1p4AMKK3/zXjm?=
 =?us-ascii?Q?/Uzm2WvuJIUf4FmMsjbKjIoB2H759E5tO5I9srNW6VWh69ip1hGz3+lMepYh?=
 =?us-ascii?Q?PlWIjaN8PwF1k/bAteihg/LB586qKLTXz9H2+Rz8pJrXeoFwNLM2aqCMv3+5?=
 =?us-ascii?Q?9Tt9+QrnTX4QJY8Wv+TiGa5HmW6AKXX+LJZuZapj7K8iQppB27pI+Iq2AAvG?=
 =?us-ascii?Q?Mqi5B5rb+szO33GPSqUiNeos2UT1oHDNbcUcrvHFz0St7/AQf+qqkykNQPvp?=
 =?us-ascii?Q?yUBrh1uPwJIxEoh58sqAYDPUjNLEfhmXhs3Oq49veuhKjPMq9CPLgq6hAnVw?=
 =?us-ascii?Q?Yn3zR6z0Mg0AaI53Ok/zDr20FFY+x3qQBJl5xhvq1c1Vyy9IXOGSR8lG7ex7?=
 =?us-ascii?Q?Hyw/0yP/sFGq0myiMkRAWm6Vstk4wPqYYEGml6mV5/IfITouWbf7gEy+IoT8?=
 =?us-ascii?Q?Skc4Srb6fttMswpTtvYeUY6g343gmuYpwk2DwGsFxNYFHBnVCwnwk6h2tKN0?=
 =?us-ascii?Q?JP0yFah2+pCJt5vnOXFR0hpJcigFps0q83ukRL/xxfvBnBRa+dY4FKE90nKE?=
 =?us-ascii?Q?1MH/cWKon0Z1RLa9pr7ttjHCWTqQTkw2g4CLvxTYIHWu7dA8GDRkwQhOPjJw?=
 =?us-ascii?Q?NX3s8JpKCPdSabeAJkYcsZ/BxLeoeJ2V+y3uv8avxH1E+Th2mTunACXHOxCk?=
 =?us-ascii?Q?NdAOUiKRuf3iE39FSSzTzZFmSBcykmtUqWy673f+sUk0DLDuxSl/C0i5E7uM?=
 =?us-ascii?Q?DJG/+W5JCNbVGIKe4xdmWL2sUoiXmrhzJQWKeBZr0mhHTN9LCmQv55to5UPt?=
 =?us-ascii?Q?WVDtQo3h5N7imE0IG6yxeAEnmO/sXGFCdptmW913KnlinRG2PJTwmvCnQX+b?=
 =?us-ascii?Q?fZzflNzazL/M8wZFxO1y7MLmfEJ29nGge1Ea8qGgwFK+mIwn64nynFvRs920?=
 =?us-ascii?Q?SAWSMmZ5QN1djwa64jQOAwwL8i9ZZfwaxUIBrixOt/zF7LpECFRAlJxOfu69?=
 =?us-ascii?Q?8aUp7YIj+34Na3rEDOIexpXd+Ttu3uZu8FsOZ00W564G8xvdyuLR/U3kDqtv?=
 =?us-ascii?Q?FTDfZyJkgplNSvvGQfZ4uptHiq4WipQ0gzDK12GVL5BG+YDHoKiEl5KMEjHD?=
 =?us-ascii?Q?8D5MLNNqymW2cfKujxBsj4YItd3Frz9PFMkm2/6rC+f5SgfDMB3F14yplAa/?=
 =?us-ascii?Q?3fq3IOiY0llqxHlfdaFBxO1oSR5uz3P3bsrkcCgeezoulEdq3pp2aGUVfuDC?=
 =?us-ascii?Q?y6pSLOLz0bNVfzhheFhifNLu70HGQ6lzfIzW61P78brb5dg7SiXqTA9HjZrR?=
 =?us-ascii?Q?ma4c0ZuV4ES92ekw8vr2xzk1ZzdXW9SPFbR9aYdA0QzETarejqbG68jDekqj?=
 =?us-ascii?Q?KmNgqWxVU5DCnk6pcJliZTTgBKtQ/Ndiu5lUQJ5Ik4+8SagkfVQHh/7O2sGb?=
 =?us-ascii?Q?ZFofPtUqvePbKBs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9UKP5zR638LFaoG6NWZ1NJ4a4CPoxIOd55ckw6sIQ3DwkTai6KcSCAftEyjb?=
 =?us-ascii?Q?O9vfeRlZ7re8JbKNy4ZZF784/rs6VrX2BfJIu84TDBM8oPVSHYzViYttKrzb?=
 =?us-ascii?Q?qakCmS0F7X9m9pdzSFQ1j7otw0nAxFyffMGCqB/8QQ5BLZrGwpReOrCLdBdQ?=
 =?us-ascii?Q?jAjjO1Hq64O46oac8RLIJC/zzoPprowsefKTJz2dSziUeXtD+b91HO1lTBKN?=
 =?us-ascii?Q?yD0wKs1pDrPWmu+RCAp/K1uGPdDi/0wX8FyX6rffXTzONoksb/sVIO1+VC3I?=
 =?us-ascii?Q?3mPyh9LdfHFOWSnhiLTEj5WuMvQ5+Lhx99F6rlecVoHrsGcSi0ls8f38Jtwn?=
 =?us-ascii?Q?8CggfWKdeRzDpVBCBTSw+XflX23OCC8GEhFXmglkEBawfXS4qkP59lHfEqJY?=
 =?us-ascii?Q?lXshtEp4g3cr4rGYS56NgerOOAimntVjYplKecRTyR4XDD3pjImOuGgOWrlZ?=
 =?us-ascii?Q?hJ6si5qVEwLAlqb74Wa7s8jDGf3wQNx8TwvdxvsAFb0P03NLO43fUJvxnmZe?=
 =?us-ascii?Q?wAy/4NBPBMPLdH9sr4LLhY07c+sqDWQnlOj/AP4jdBARqLeDh7WxbweaoSRF?=
 =?us-ascii?Q?IWq4/LNc/e1UImjsAWqxhAMKDbO0n9vAuCAWHnyYawHPS8IQUukAqlrgwZJ7?=
 =?us-ascii?Q?NyzVDZ4csbPlcAmdczMU94l1WHsQP0mTFOU0CcQgZdOqOKpgtHbMl5XZdAV8?=
 =?us-ascii?Q?7HymN8XrNgbM2YcllYnARBIntqApNoK1uHv6C08PwXi7iNk6hiVugzwYwZJ7?=
 =?us-ascii?Q?soUYAkxO81YBm09Zngg8jYOW/eb37OpmWZPWLod0GKn0ltXMSEjQ7jndRQXo?=
 =?us-ascii?Q?wFFbAoh8+KDy9vtoIIoxx+MrJv3abd3oHoEaZkrmeGzJ2PSyK9kZcL+sVWyt?=
 =?us-ascii?Q?ghGACDl/TUz5PqvXC4hNdvoO/SLgxzwHAKDlRQHuFF4zhlZg4ROilAagnU17?=
 =?us-ascii?Q?YzviwdJmQYkM07b48yrSINsj/SOHNCB/McIvewLH9YRGoaBYwq32H7wR3VJl?=
 =?us-ascii?Q?9cNRt4G3/k1QU7J1O87rJgfrL/DxCLHT3txBWL2y786dPsk3WtbV6nSlzdPE?=
 =?us-ascii?Q?4PahBaujFClZWMO6G7263XY/yB6b8uie9e71/4dW409fc9Q41tMKR7/r8bji?=
 =?us-ascii?Q?06949dlyv11M5oId+WPsWJNsvNl2Bb0yPWXkYjYXmG8BF8/FW/bFvobQVqis?=
 =?us-ascii?Q?VAAfj47TycuRVjavrJyKG/Gv5Au9Hlpr0bIJYHA1+szol6DRbEpqqVqJb22n?=
 =?us-ascii?Q?+bEKkE68PvARTlR3+3j+x7sS54/MpdkxIa/hxa21hbLOanCPerE9sOaKQ0JH?=
 =?us-ascii?Q?UGzxzdPT1pVh6RMOW/A2eALyvXWymlNbxROX36/PcdFqj9wTnA76amZFgAD7?=
 =?us-ascii?Q?Mjg0KMpQoGoTTvfceI5DyhCF4UOwRnSuXxiPnvR8c7fWVsDwgEoGJE0tJnJn?=
 =?us-ascii?Q?gj+HP0wmecM9R8jqccb6ZluOIbzPd3KNAq2Yte4vUQgTxOBwyik9FFaCS6/z?=
 =?us-ascii?Q?okyQF2IhM6wLYYQWG9QXpHrT4keJ3laCHpn+e+ge1E00PP0WZCChjsBkElbX?=
 =?us-ascii?Q?z3IsIzd/so9UM3nuP2e4WMd3WkENE580r8lNwgdu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043bf10f-ccb8-4a0d-e2d9-08ddc82027be
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:30:59.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CiHRUzMH1rdDHCu/Z11rEVG88GDrUHSQvDNc4jbkLXT4fp0LO/4rX+ZuKp2AW1l1hcDHZ4/jlc1FymhDXGJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9728

This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP IW61x
chip family. These chips are tri-radio single-chip solutions with Wi-Fi 6
(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4. Communication with the
external host is via SDIO interface. The driver is tested on i.MX8M Mini 
EVK in both STA and AP mode.

This driver is not based on mac80211. It derives from mwifiex, but due to
significant differences in firmware architecture, host command interface,
and supported features, it was not feasible to extend mwifiex without risk
of regressions. Thus, a new driver is introduced. Future NXP Wi-Fi chipsets
will also be supported under `nxpwifi`.

The driver passes checkpatch. WPA2/WPA3 personal/enterprise is currently
handled in host via wpa_supplicant/hostapd.

v4 adds support for TWT, monitor mode, WPA3 Enterprise Suite-B, and various
fixes and improvements. See below for full changelog.

Data sheet is available at:
https://www.nxp.com/docs/en/data-sheet/IW612.pdf

Change history:

v4:
   - Added support for TWT (STA mode)
   - Added support for Monitor mode
   - Added support for WPA3 Enterprise Suite-B
   - Bug fix: In BGN/AN HT40 mode, throughput was 50% lower than expected
   - Bug fix: In STA 2.4G HE40 mode, throughput was 80% lower than expected
   - Use wiphy work instead of general workqueue for cfg80211 ops
   - Introduced RCU protection for ba, rx_reorder, and sta_lists
   - Used per-TID spinlock for tx_ba / rx_reorder lists to improve
     concurrency
   - Replaced mutex_lock with wiphy_lock
   - Reverted "use tasklet for Rx" (back to workqueue)
   - Refactored HE capability handling for better clarity and
     maintainability
   - Used standard kernel helpers for MAC address handling
   - Replaced proprietary nxpwifi_ieee80211 with standard ieee80211_mgmt
     structure
   - Used u32_get_bits() for VHT capability field access
   - Replaced LOW_PRIO_TID with TC_PRIO_BESTEFFORT for skb priority
   - Removed static WPA/RSN OUI table; now derived from cipher suite ID
   - Removed redundant helper functions: has_vendor_hdr() and has_ieee_hdr(

v3:
   - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
   - Extend driver verion string with hotfix number.
   - Remove Rx mlme work.
   - Remove all useless check of netif_carrier_ok().
   - Merge decl.h to cfg.h.
   - Remove unnecessary check for wiphy parameters setting.
   - Synchronize following commits from Mwifiex: 
     wifi: mwifiex: replace open-coded module_sdio_driver() 
     wifi: mwifiex: Fix interface type change 
     wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id() 
     wifi: mwifiex: increase max_num_akm_suites 
     wifi: mwifiex: duplicate static structs used in driver instances 
     wifi: mwifiex: keep mwifiex_cfg80211_ops constant 
     wifi: mwifiex: Fix uninitialized variable in 
                    mwifiex_cfg80211_authenticate() 
     wifi: mwifiex: remove unnecessary checks for valid priv 
     wifi: mwifiex: Fix memcpy() field-spanning write warning in
                    mwifiex_cmd_802_11_scan_ext() 
     wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq() 

v2:
   - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
   - Remove useless header file semaphore.h.
   - Use static variable for cookie.
   - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
   - Use error number for error code.
   - Remove unnecessary private ie definitions.
   - Remove mutex async_mutex and related code.
   - Remove unnecessary work queue.
   - Add the support for PSK SHA256.
   - Use tasklet for Rx.
   - Remove unused functions.
   - Remove compile warning.

Jeff Chen (22):
  wifi: nxpwifi: add 802.11n files
  wifi: nxpwifi: add 802.11ac files
  wifi: nxpwifi: add 802.11ax files
  wifi: nxpwifi: add 802.11h file
  wifi: nxpwifi: add WMM files
  wifi: nxpwifi: add scan.c
  wifi: nxpwifi: add join.c
  wifi: nxpwifi: add cfp.c
  wifi: nxpwifi: add configuration files
  wifi: nxpwifi: implement cfg80211 ops
  wifi: nxpwifi: add host command file
  wifi: nxpwifi: add command and event files
  wifi: nxpwifi: add data path files
  wifi: nxpwifi: add debugfs file
  wifi: nxpwifi: add ethtool.c
  wifi: nxpwifi: add utility files
  wifi: nxpwifi: add initialization file
  wifi: nxpwifi: add core files
  wifi: nxpwifi: add sdio bus driver files
  wifi: nxpwifi: modify sdio_ids.h
  wifi: nxpwifi: add makefile and kconfig files
  wifi: nxpwifi: modify MAINTAINERS file

 MAINTAINERS                                   |    9 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  289 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   32 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  590 +++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   72 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  346 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  895 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  167 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  275 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  938 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  984 ++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4067 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  475 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1284 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1230 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2401 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  501 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  684 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  911 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1718 +++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1850 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2805 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2656 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1319 ++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3449 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  868 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  250 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  208 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  358 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1234 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  490 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  506 ++
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1580 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  132 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 49 files changed, 37723 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

-- 
2.34.1


