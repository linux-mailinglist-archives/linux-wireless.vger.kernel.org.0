Return-Path: <linux-wireless+bounces-21604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E47A9081B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97DF3B2A00
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622452045B7;
	Wed, 16 Apr 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HftpTnM+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C711F193D;
	Wed, 16 Apr 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818972; cv=fail; b=m+4Gi3M3QyBDB+fwPwm2/QyUvErMVO5heD3Uftkhj4YSr/n1sQx25OaMhLGXZJ3pGDiWdiVKCKDDuQzw5ASJrbv7dzKqZ5T5YIbAy5DVa0UIfBDhQcS4TudGmpO55WOoq8BSOeUVb4UqlwdbnIG7cA725Bq/WID2h5BVs0sbVB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818972; c=relaxed/simple;
	bh=SRZ9ueEjHns7fDvPqN7N9+EqSRx7IbgvwZcbTZPrQNw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=meBM1JielA9ATMnxibTikGLsDHz5eTXld1n646Sf4rYUQS9/XTtpCVccdCCntLMA4XX4dSwAEj5Gd3Zh8b3nwey1YX3EaqW2mmknIiNMXhK8Xlk8wYaExSvXv4v2/eIj0fze5skxYghyk+bhKhY3JqCzktcWhFMZDKPAUTZ7bHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HftpTnM+; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4IY+mldLh/8G2FUX5NmsoyiwvGTyiAcw3AAubHkbjADUsR+xD3l28FHXMmbkg4V1unkODNmdq2X3i9rFcH5n7a6nuTcqpaY4jw/v99LEE2qry/MopfZEExgv1NYkeR+sYfu4sUd3SHa9UXjTG+7nXaF2x6WsIZsJeuCXce6m6l6iMu3MAeDQu6gLTHRcfftHGwlznFhKxWajausxYyIy9QXTkZ2Jwj4EqkyvVb35CwF5tqeh5rDvzSnak9VfDCIjIpKejn9x3hNEc1Tp6yw7jMV8D9S/gxsjOHVD8Weze5Ls8W/nPA3zPPe/6BOMJ4ipUIYx+uy/r6NPCsC/Jptew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIRGuObXU/TCN3nUC78PpMxMrsJvU3BvAJBwH4y/MAw=;
 b=mUR5ca7tgOZkv4pbGpWTusMd9HJ8RJoTiiOUwpCGpCh8bbFFB24hzKF27vV6MsgICDEwZ6JB1j5KznEagQOEDAmauEPgM4jtTPp8zDWwuDgaBIAYjsbeQEicSpN3VNQTUG+BYkS/5sjYvb3C7SbEjYhiqBRppPkSCG+dK6dqcWdTIXQ3wyzhUeNrbSQLxebzwKNdmXSjii5Und1kJOwJCAITswQgHCsQqc47UKenqjUIVaPAeSUxuiJtWVCGgkLn84MvjEE9FTT4FkN2a1bzcr2YNrsZxbTcuCRDiIgec5XSk8ekszdyQlozBcuYgaqrU6g9T/GClKOM5LyFEZWAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIRGuObXU/TCN3nUC78PpMxMrsJvU3BvAJBwH4y/MAw=;
 b=HftpTnM+Rcdfe9HogBJglljBCPjo4gA1p/KClFm37x9bBzRRQj/NdT7jAWcHDo+C6QgZ6kvoEjAmI3KVC57aNZhNG9ySZQ88gn4dl2ABtM109mGth9biT6Bj5pfcoZEmclED7GXU1SIqfMqqNMMpXK/rPrLUqHy2s7OChEP252lKXatL28G9sK16RJ8C/ha2Zr/jbDQ0IIyEe4l2YFzlK6eREiV0jzsKJSZ8kUwRU0NEowUEvyNE8Sk9dd0gYzd69Uexf0erP40GH57o1FI9bEGjrJBlmDTb79UDSIhHPlZLV+wxtdvVVy5YeE0kk4yW3QXgx8GVL8ncQDicjHFS9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by DB9PR04MB9307.eurprd04.prod.outlook.com (2603:10a6:10:36d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Wed, 16 Apr
 2025 15:56:07 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 15:56:07 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH] wifi: mwifiex: Use "scan_plans->iterations" for bgscan repeat count
Date: Wed, 16 Apr 2025 23:54:25 +0800
Message-Id: <20250416155425.4070888-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::13) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|DB9PR04MB9307:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e56b94-da53-4df5-3685-08dd7cff3327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tvUfAaI0+8nQ4PFdP437KRMuYKh9+a9zB8uDDwzAxY0BHtbbNrt4tXh/IRgd?=
 =?us-ascii?Q?bHel+K/TqXwElCevpNK63w8KugLXddTB4H8lzBWN7PF7f+Rr2jJ7koF3wy2G?=
 =?us-ascii?Q?IGnBvE2eom0zone/VwDlZhChbyWmyUDikgsg2cFDxf0fQ/CYTf+etjT1vHDU?=
 =?us-ascii?Q?DmCITlt5HfNdqQ2fNuU0vgL8OSPgwoUqbPyGmezYR3hKAd+ej4p3h9KSXS7U?=
 =?us-ascii?Q?dwuabmUycRR2zKleEPK3SNz6EytgKAr/nOgRWRVQHzEX2QK+YQyqRFtLTDNz?=
 =?us-ascii?Q?H7VbqYEBQcJNnnO6O4XZnYIApblbjD5Nx9GfDwdHGPG+oSAGdh0XW8eQJrlr?=
 =?us-ascii?Q?3zTTjilWfc3hULs7iXJhuU20Xv/rypB0rVZ+xWJD0cBj3hVdsdLz3dCmdn9T?=
 =?us-ascii?Q?/7fTx+0MoJNb6RqfX2dZhUThMSPputs8t3Xum+b1cWRLmWsZdY450yDcEBr8?=
 =?us-ascii?Q?ZQTt7fI3fkLZrucUSCxycUb5lOkiogx9AeDRk5Zp7Orykr7Mm1BwU7LyC8nw?=
 =?us-ascii?Q?UHvJIWDxbKDDWqLNCz/pBH7ENNlKgp7Orbp2Fsw81Kt7KOinLp5E0d42mQ0I?=
 =?us-ascii?Q?+HX5ZTegjBKTKayAYqYktvthrFcrVVURzahpvcHmvtbn8Dbsu9vdl9k0iHFo?=
 =?us-ascii?Q?p9ykQQ0knNqvjM0/o2H/EWjI8PxNjEASWvdvDfjeEic2ghXDUTm8b0QHu9A2?=
 =?us-ascii?Q?zJJsMvzHBbERD5IH5O0xxI1fqKG3OrkddZYSRq8S9Q+42ojO1MeSmPh3TUCm?=
 =?us-ascii?Q?CzjTUj6MQPfwO2V6MRoVCevMZq9lnUpAKfLvDjN0Vqk0XwQJwIXAyi+yFLgm?=
 =?us-ascii?Q?bv6zqX54bOPXB8BnzWqKY5XG5BFpLD8FbRWqUM/PQcmOcQiehipLjXJxM3Qh?=
 =?us-ascii?Q?AHeD4VBQZSLC3OZbtzxvJJfQpcZ+7Bxxk4mvlUWDlFSuW/33Ly1CqKNbBQC0?=
 =?us-ascii?Q?NSRAD4q2xERHaYywE/jwHBGJ2pkZOulrdaoPz2fR4Y+9piuA1xpBeCBSXYuP?=
 =?us-ascii?Q?Z0VefLhh77y4wiUAdUsBTEBOpR2HXIPPVhijXibQxOY0Xt4yHOoBV8piPBxM?=
 =?us-ascii?Q?DfYpoM3e5Qrmnk8jRija/d+r6BtJ2znX1e6cjhL3I5IrbKcUfDmGaqIJoZAn?=
 =?us-ascii?Q?pM+q0Im2F8aXEqs0sRVypTbOR0frxr9nyGXTgWpbuFHxjXAvewGpRIlaJfyE?=
 =?us-ascii?Q?kNpHDQ8x+ProGnFeDT8SCbumwoqL4XKHe2ImkSJWtL1r1INIF3dgJo4Z8K9B?=
 =?us-ascii?Q?J9hndqdpGf9LJ9rTEKJwQU7RD6epy7B15jFvOL8nnJ/vWKdn2yiR+xQi+By3?=
 =?us-ascii?Q?facvp+o8iD8EMDDLYd07LdbV1QExX8kr7hL6aZIa3ZC9HUVQd+UQmALKkmj6?=
 =?us-ascii?Q?2sgcuE2kot5ERvElXatlYt0DetLfUCBZVPo0hHKmpFjeb9JLMctCMQgBXiqI?=
 =?us-ascii?Q?jfYn8o5Z4H63XSeWDJE+YVh4cUfmEP1aJaGs8bDjfoQEBeVUelkz/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oovKlksBEIRONkb6eXkfrNEK6UOQjmFleF2sDC1phHb1O1QmyAtzG+03yP4y?=
 =?us-ascii?Q?J+ul3s0HLvk7ej6yofn0K+pF2vMZTDbTCYFBKp1sYSO1MQFLqV9d2Zi0/02b?=
 =?us-ascii?Q?26ngISO1pTUu1KbPEGtahhc6izyoeb8OeD80pUehBuytcsJlQmztZODe7MkM?=
 =?us-ascii?Q?snyxJMNJmM6CdRKaPfzCmky3zcl0XmAlAl/HacS/wMyQeW/GXpgSdf21PXRQ?=
 =?us-ascii?Q?U8sya4wcBixcun2QcnKuVh8Kd+LDPDlOxmHhq1MrtN+D/Gpgirab1BYn3wUE?=
 =?us-ascii?Q?bQWyLXCpp/np5Hq5sX7zVJfmKSK/pKB4n6l0vik/iXbqRR8s1bWyYvDVvnfU?=
 =?us-ascii?Q?96j77nMCDTL84FypPlnQGTq6khHHxOuhQ5k2nPNv9p9HKj7hEiYRQTvSmc7I?=
 =?us-ascii?Q?N/GF9Xv8+74LTkue0oWPc5uqsC+7krFXfxzN8ahINY1xWMvZA0ztkQnJk45G?=
 =?us-ascii?Q?PQRSUbFiPtJr5me71MT03tXHI2y5JMm3d3zOHNNAej2KRHBKq7uruxJ+ZCR4?=
 =?us-ascii?Q?iHB5p5PZGMcmga3kRYeI1ZBFd5C/k6xMidavQhrMjr0xj5p63qF6dLjL7AT7?=
 =?us-ascii?Q?KgARhfyStkvFmIih58DbskN+uRJpcH7YtQvREHr2TfbrP7r7THXUevcLFXnN?=
 =?us-ascii?Q?OoylkzFTj0KC+xIgBQMIA7vW3NGvqAtcZ6gW3rs69KfMy3XBgaEwYrnY0edK?=
 =?us-ascii?Q?L4RK80II83awatTql9KNGF+H/2V9Z/0udUC54a0O/tL6oEtenwepYWbZnPCB?=
 =?us-ascii?Q?pG27aFWXFT+Gs84yTpLo+zJLZvb7nadgL3E3znC0vQ266AmPwTsCwnvpEavw?=
 =?us-ascii?Q?eyCfN02n2NsQj6qmb1MqvVUCpeuqllXT3lGJdqlJvn4W1tP8q1Rhgp5gy+Su?=
 =?us-ascii?Q?EZv/RT9gvPLi1k3TiHE5/ehlQ41dwwhWCQN0i6gFppeXmDMAslUEiqiEbBLL?=
 =?us-ascii?Q?2asqWk+D/BfDYthCcHOmwdMw1vSJGrwvahGpwuYslmCw0b+h/cfgXvxAXt9a?=
 =?us-ascii?Q?v7ZGAgYvnsG4NwAeFFdW+9RWOcj3YqwxztKf2BcEN+5JT0fYijz7aQtbEx3M?=
 =?us-ascii?Q?Uw5XwY6C+y5WrxnPp86L2xg7iOHyxAy2qdxpn5cEg6QQt7wmwV/8eqw8AmDx?=
 =?us-ascii?Q?lP9tvi9JtWBwp8lXRcC7OcjHKaVH0Dwbv8ENUC9AoefSqtdW1SUPCK9tkQZ0?=
 =?us-ascii?Q?YkOmw5i7Yk9DtRR/zXVU4gxjNYT1ZtR4WvFJuvSYBQM+zoO+hz440S3VTSeG?=
 =?us-ascii?Q?hdZCSXj4E5vBW3lOLx/tWyPYDAHqBNd2h189oyDZSluG2Bl0fqfnNZ3Xotnp?=
 =?us-ascii?Q?6GtEa5gKnwW7yLOOf6FkOTixuqiIeC4NEM9cI1cfNTV1jFKB6O5EG+g8/T+3?=
 =?us-ascii?Q?jWo4LUFzuwfyA2vcGRHz/KT1NYA5mCGw0qbrWtCME+nIo7AttUE/wmRoPpYR?=
 =?us-ascii?Q?XJcmQCidh1lLTfFv6X20JkYMzrhJZ8KxSHv2QxK0fyIcFhg4MzDM+aDcADuZ?=
 =?us-ascii?Q?WvUCX6a3z5oMphlx+ZQbZ4a+DiYZ2eHWXO+/xnpoupatfOURs3TAk91KX0ch?=
 =?us-ascii?Q?Cfvrp0WhisQHnaSljMz5K1aBDyapxLjppG35fJ2s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e56b94-da53-4df5-3685-08dd7cff3327
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 15:56:07.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUx+3QLjmvy6RVN7tn8U+5DA7TqTUJVywzIK1qkYYe/PoBnD6tXZ20m0xt7mbwQO/Wsjn3cu8dRFogKsN33acw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9307

Updated the "mwifiex_cfg80211_sched_scan_start" function to assign
"bgscan_cfg->repeat_count" based on "scan_plans->iterations"
provided in the sched_scan settings instead of the default
"MWIFIEX_BGSCAN_REPEAT_COUNT". This change ensures that the repeat
count aligns with the iterations specified in the schedule scan
plans.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a099fdaafa45..be28c841c299 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2833,7 +2833,7 @@ mwifiex_cfg80211_sched_scan_start(struct wiphy *wiphy,
 				request->scan_plans->interval :
 				MWIFIEX_BGSCAN_INTERVAL;
 
-	bgscan_cfg->repeat_count = MWIFIEX_BGSCAN_REPEAT_COUNT;
+	bgscan_cfg->repeat_count = request->scan_plans->iterations;
 	bgscan_cfg->report_condition = MWIFIEX_BGSCAN_SSID_MATCH |
 				MWIFIEX_BGSCAN_WAIT_ALL_CHAN_DONE;
 	bgscan_cfg->bss_type = MWIFIEX_BSS_MODE_INFRA;

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.34.1


