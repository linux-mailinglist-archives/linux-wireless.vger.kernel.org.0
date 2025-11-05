Return-Path: <linux-wireless+bounces-28600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22090C353CA
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B3018881DE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB7313E05;
	Wed,  5 Nov 2025 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dFnUG8kN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB66313523;
	Wed,  5 Nov 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339821; cv=fail; b=XfKw636ZyE+btH6WlGeU9HBUVbEpgageHiNNJOXBHpiDbO45tNvmlKCgfQynQqsrzrTvgozvTj3GTVps07MD7JsgWsAKGEXByvEUcYgkBU6AEv4h8knY6Lc7nU4obpnRBJr/+ZX9TMHhX+84pb6bVqG4oAOnVTRohfsnnUx1z88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339821; c=relaxed/simple;
	bh=Y1NdDb4qGSmbC7ts0KQC7twI8QTLpFnSMZ6nCEwefd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uKQjwpJlVitv5QNBA3J3EH2ZabNKAONomjP3dBhlVg1mFZSJq84RFeNzE45oNmaZPLkUW+AjpX/v4GRmfa3FNbW0QsKTaPmCiCVLjuRWSgI8uhlMFQ9+iMGuFKO1xMyZ2XiNJVnZrCcM0AP158dyRgsKm505xS6i/q7zxUZnTsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dFnUG8kN; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIcPH5ku2DLIJKvn/n2g7YHKW2dwY6tDLYWVruFSw6eP9KsgnTf1z7ZgM8G7xZJQirqTEtAuf9CsEMp4cx9Fcs8R0vzHSDGQm/hkc1/jgTk+ZxUi9DqkpQkS4c7mab33nfZdAmPwDJqt0F3kMuNrVfl4WsgTy07Efl/Ol4Z1lgpTQXZ1Vq3wHOWZrhIJnxu3s9h6gNXgjyWsKv4Y3rB9L/DRy63q7HbYrzjRDY0XcQUZO+cPC0uxwSLRr96jpznc/WmJQPht2khdZvFFmJaZPODKF5dexl1aWaQVaSta+lhyjWEYEH10IaTGHHKFoT2GCYzzUlmHXrTPuE0dqSEqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1uSZPwBTUA2sUG/Ev8P3xcBd20riCqqIz5HduU7pWo=;
 b=XM+zSTOjm4UCVE/aOJg93l9TwuUBshkIdGbPAanhiTq1L+jyd8qulGLqL9gTOabglPljTlwBbizue6gOAAZCPIIkKxoGAs0Ky7uZvMvYT9icQkY7Z5jZEDYebhgfTUHCfEFdO5QkxVnqeBUqe6GCu08RFD9mHTQMLPaLJpjsBwm2du2b46+ckIUvGlEwlGadzCPTn7JWMhpQLoJ5XrVvu9kvLnHypzPIAfKo5bPBCTpprZ8SugPVM3Mjua2S5FeDQrjzStVeLcuEPTxvue6el+50vzN38IyqSV8uvAlAW0ypY0PsvPmeDNie7BmfooqHOnQStQrlgz5m10Ghw1q3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1uSZPwBTUA2sUG/Ev8P3xcBd20riCqqIz5HduU7pWo=;
 b=dFnUG8kNGwzmY39rpJiR0w98o2wjS9mX+jxDJmp3MlkooV+qxJoU49A2pSWM3g+iBPOo/1ji+N6SWVjtQ8PHkPGQ/AeE/kA0EjA0Fqty+VKWU5ynPOZCU/Xp/DKeG24h275NyUhZquepKJpMWAB9jEHP4N9B3zF7cn3fJtOgobBhsK8ngB5s7TtBDhXkTWTxZOp1/Xm0l1rEBD9HNcHTLjMklh57Mh0e8d5qsmbjHvvagL6ppgc9QwaxgT6mBtOnWMjHiJTAXWi3iows7r/nG2fyFS2tOAD2dEmsR4dW3v1KLHTVc2UGJTGqrxVSfF6PC56OGfle3FpacgaALfIuug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 10:50:07 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:50:07 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 22/22] wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
Date: Wed,  5 Nov 2025 18:47:44 +0800
Message-Id: <20251105104744.2401992-23-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB10770:EE_
X-MS-Office365-Filtering-Correlation-Id: 1315c82e-3ef2-4b00-2e9f-08de1c591565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOrdivULU0I2BDZZSChGDx3I9IfsUW0df6u1axjdz5Jz1C9gUzPePMbeyjqq?=
 =?us-ascii?Q?o4Au9enfcfwumf7DXreLNbeFr5pK3IWia/6pK3G5vbj9Q/ZitnvyOj1mzwUa?=
 =?us-ascii?Q?c8bbFO7mY7wHIqtXabKdcblhF2Hm9GY56v3nnPEu/F3VKUn42Pwy5oYEeIgD?=
 =?us-ascii?Q?7ELtZ4o6478Ii15H0ooMC8xpjlU4uONfjaefqNHnvnnsh+sAIuPT+DDwxWkG?=
 =?us-ascii?Q?ryjyXtj47UkOojBQuEaXeH78oFYLp5XN8y0pxiz9/ZQxPwbU6Vk5eFWIPnGt?=
 =?us-ascii?Q?iLtbJv9MSHIXppph+3S9IJjesfsZt7UDoP1+zuFkvyGIbqoL5NmFcaiEhVTK?=
 =?us-ascii?Q?ppCAciGbGxkngjkjJeVUxSd0dbP2r829dABEZWdrqPxGTocq1F5Q73FS585a?=
 =?us-ascii?Q?RyOMKOLeZBeZWf1yM406u+rLBLedtEfqALfI42h79o+5ZUjlTPLEkbbI7Oz2?=
 =?us-ascii?Q?n1vp+qnfiwmOyNzsAkOHBFaZdZyvLeVU57uDmBDHeMcZl91oSWTKL7hHVQtJ?=
 =?us-ascii?Q?0vYhOR+C1QPSwh5b7cp8pjh+jV63Mmnk1YWw7h3M9GFMJCXTa1s4hrJXRzLk?=
 =?us-ascii?Q?obxj/oYQnIZWYyDuKu/oKEiHkgNCLfIZn3Z78AuzJhbVYV9a5guMSzMbO1qK?=
 =?us-ascii?Q?f0o4KbOwUwOBvxMnhnQnvxmxo9zlarnlvSdxCV46nOqvqtHPkSqpKSwniMWs?=
 =?us-ascii?Q?pOV2/Qt86wkO2rPYdEd2nTyD4+PMS3H6d8Y3C92fxy3ZO6AP7Ncj4FS161EI?=
 =?us-ascii?Q?7RulB/eO16NDqeUlSvc13PSMQ7MdfGhKzRCHWpRd1lCulKfVvIx4uD+UOuIL?=
 =?us-ascii?Q?yjvyf/pBNfA5uLwfXJIrGsUVPbHsEbKPyAb359dDFKOXB6n4xTV4NgniITL7?=
 =?us-ascii?Q?5e5lNtzPVpZdMzOD4cy878/HMwrAOnpWVhMFTOkdTCnw/wzZhPGu/DVrV89s?=
 =?us-ascii?Q?V1MY/GzDcAZwCN4l+3jb6iMbdHamSOgZEmxtbQUczWfAeyp17pkt/D1Ii3HN?=
 =?us-ascii?Q?1stRAkmZCHBzrR47zn3f5ls9B9VRQGxDa5tlFi6c1BUfeYNOw4rLdDk6zvxF?=
 =?us-ascii?Q?toabyuxQ2kPVPdmoCkMxHu68Nwd92JJlPR7LyEji9hzKCztyibEadl1BSl9n?=
 =?us-ascii?Q?tRwbG8JvDVReRAzppWbeG4OSfFbWPI1yucIz/98djnXFSObVerQ8w3ersN4P?=
 =?us-ascii?Q?5KDNgDL7sHoqeDmBua9L4Z5zKhrFM8k4KF15Lskj5kxXIQ6jSTMDYj5gQR18?=
 =?us-ascii?Q?kxUUD+QXV5MCljaLZWnqRN+Q7dS+VknetjuXfYnqZyi9o+y7kS+utCg7AuVo?=
 =?us-ascii?Q?ubsNfGwleKwWUOja3YtUz+TOpDi1xi/6Y/vjn03+k8vibios//JnrTHvOQPr?=
 =?us-ascii?Q?4kaiLh8szqtP0l3wJnjvUh+zj5iYL7WlH3wAbZQdWo5YCcqmOBAiX+ZOGfYe?=
 =?us-ascii?Q?wIauZdHGyzVgJQ/Sq/sRwtV661BKfjnqRsXfwOLV5x+Soy/MjQaWktzr4t1e?=
 =?us-ascii?Q?bhqVFJoVCWofqp0VGSv/iyCZncZ+GtOXy/2l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9Targq/I1GGi7CRvt7mEvl6kpkqWsVd36LH+fvsomLX8xCPCIshhK4WYGHn?=
 =?us-ascii?Q?0xfGoyk49zUkM1oHxoq6m31awiH+Zw3x6DdttZPyZ5iTE88rzhDaIRUX2YTD?=
 =?us-ascii?Q?4Eht3tfgvMNQk1cZ5HFasvV1FwK4elQszbWmQrOUtuAOI35iwauM6ntUNND6?=
 =?us-ascii?Q?pRvWJRE1bbffdxq+hXYYcvrDAkW/pmQanxul17I4euhfhfy409E0puRUmxeF?=
 =?us-ascii?Q?VFH9olaleZfXjBKiHrbLPComdEkgOq8xka0Hy4RBJ7lYFfr+0hrUVdAmzd6l?=
 =?us-ascii?Q?tMaI3Cs+23Dd3duAI71kOcCg0bvlayk2Pq4qKrQVSp7keNcwvVdsgVj0Z9oi?=
 =?us-ascii?Q?eIB6bD53RAqS9EYF1IX1NXhtRafj/3zyQ1ZwLuanW00aRAifyD7cNHWgI0xI?=
 =?us-ascii?Q?UyEuICUzH7xhRepNdB33OiRgEr33rX0ayNva6ETl0uFuLBC3NWwt/icB23m7?=
 =?us-ascii?Q?CCdpkd/OqKbmW0xJW5OY6PlMn28VzH7i+2K0hlVRDXBbizF6szKCKAYOPy4Q?=
 =?us-ascii?Q?0jGNynjDWad27WT95IwxAm3qttRajA5P79PTCwHEQsdx3c1aHZu/LyMUJeN9?=
 =?us-ascii?Q?LibDUKKI+LTqQ6dYHJAyLWU8jwu92rRpAkARZPeSgHnOMzTNacSVfwO6DvwS?=
 =?us-ascii?Q?0nonSaSMKgoFFjjG9ac3ICIbvVWyqL/VPTk9nThWtKYYyqZeOyQhnxiP16H/?=
 =?us-ascii?Q?DrZXnuLBnBcR3wW/PLUTFataNNy4wY/T7p+SbPeGUXkaeTziheRQEaNg9Dll?=
 =?us-ascii?Q?pIJlWbEZ5Pyw5+7gelzDlS8lxn02KVH77fuS62dzZPB88xZ9dOmcoer9ahHp?=
 =?us-ascii?Q?kTTvSL4Ux5q/FbJUEaOJTZuyIs7VydxadMaWViTBIYCUzPCD8XKrux1Fp2qQ?=
 =?us-ascii?Q?pnAdfLWhm/HlEMqLRkzX3RWMwJe6MY3B4PlDOg+IhmJFA+I/xfm2W9uEpbse?=
 =?us-ascii?Q?3GguBkkb5o3PPDXcmY5KznLP8CyV8u1czGBAHhFNCnCFHVW5q3jmE+SEmZOM?=
 =?us-ascii?Q?6ht0aXGsRVqZv21bCi27SQAzuj8dHb3d7GVa+Ob4M7pRrUdM4GqlF4E1dnFA?=
 =?us-ascii?Q?ZyDXgf59llMm+gIEqsKrhP6RKTQXXZArNr3N1pnv/N3LNjZXX1ijoThFaLlz?=
 =?us-ascii?Q?t+/vQyhpQ0sxhGTrwkd6fpRredoDUl2pn/0QDRJ4TMNouZiQogWLkLcMGdGg?=
 =?us-ascii?Q?1f7fFYwdoyDtr7vNLrmeIfWq67nF4NW6VNi5qVuR9ELMZay5LvlHiHU5UfgI?=
 =?us-ascii?Q?buwrnofJEeqqPG8xrCUDoI3yfRd6iRQm0GySiebPK9ue9M0Ktrf6t4rS8rOH?=
 =?us-ascii?Q?sk9PygjTRp6jePakslMbgS40uOkJXnYcrIUFOsoMGrfrxd6RHINiWD+ugFPx?=
 =?us-ascii?Q?6e5ejByTYgaZT0Bb7Gl3MHYi4mzlt1qsMA++AHe3W2fQJAvX/en/PBnasmuH?=
 =?us-ascii?Q?Qi+Ut8bRgEMAF0larM7OCcmRNeMXjc94mudu070MMW/6xsvNTAvFFI5YYLa/?=
 =?us-ascii?Q?JgR67kc2cX36YAHusLWUeZYM1M17clliByjYzuDfFUGym28VvKlY2J5ke2aD?=
 =?us-ascii?Q?t7VC+ENRBZE5Lw3ILOXpL+u9jPYKICrucM0QQAxf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1315c82e-3ef2-4b00-2e9f-08de1c591565
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:50:07.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVJKLWiuf2T0kRTxte58fSgJVj03UM61ZVPi6K97y5lrBHY1nSVpGuXleIvouzMnbRawhbsrFSPT5NeBCkv+XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10770

Add a new section to the MAINTAINERS file for the nxpwifi driver,
including primary maintainer, reviewers, mailing list, and file path
patterns. This ensures proper tracking, patch routing, and community
visibility for the NXP Wi-Fi SDIO driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab7e8746299..980f154b2a37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18637,6 +18637,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
 F:	drivers/regulator/pf530x-regulator.c
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	Jeff Chen <jeff.chen_1@nxp.com>
+R:	Francesco Dolcini <francesco@dolcini.it>
+R:	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


