Return-Path: <linux-wireless+bounces-31570-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH9qOtuMg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31570-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:15:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF8EB860
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BB1E301E51E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB23436378;
	Wed,  4 Feb 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G9D/zXhY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7D436373;
	Wed,  4 Feb 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228366; cv=fail; b=u/o1mPYdOoXUI/XZL+IeYdxBwk0vQYfD08TFlDlzWiAyyRTluZklm+/eGdq3NBkwJE6itwgbTzGqkhCLhUViR7IJvlfhlueZz/gE475VLPBvWdhLiv8lapn10uZ07UpfBQGf2ziH+gyKmcEDOxhTx2695+RlxHoGGvZihY8qjzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228366; c=relaxed/simple;
	bh=9eJCmduRaCTiTdZ4+1e7D2VE2W2yQKH3F4JK/mE1ZWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLONeo9wc0TqxFYhk53s/mmjN6ueU9/Cj+ZXZn8WZYX8glIuiO2Xr+tHQ5V8umG4/tEY2Vfw6XkEv5914Dj0lUhUqDX1Q7qXIgTCy+FM/MxclBoHIEAm1yp1lT/HOGbH68xM/XGxtVmC8qYp2ChQj18TXX+KaJKoUzbXt0O2mfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G9D/zXhY; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2kU7nkQUKLgo897h4PDamf9DwydOzW+3//qUv9IePgvTU/0qf1ylHppYzzHTnnmNGWZ1/6uBy/985SJ/jba3SSeQIB20HICQUxLbJy/RRQM5u06HPge9P8TKJuWGuC8Gx9+9i9rAaDe4xnDGJL6JvXn2zlFi/7CyWhVFSv1Rl/dd8acY+QV3ITTb6sQJ2cAQkn1E9JX1FEnh3bIa4WLcKtWbmdo9v6p4TAmWJPw7x2M3K/J2itpjWjPssSZUuKMf/9I8a0/xTy86Szl6aMhP4ZMH31ms83cyEv/qWhZ4BEMC3nW/2w367J5rWY08kbFqskVMcBR+89CC/pznJ4uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTRbrXRLrhpCjjK0Ju+yUfsytWF5c6IoeQXDLU90rc4=;
 b=dCRck8CE31vYzZoVkYGLNjTJBJJ4ey8KIZi1BCmcIffg4/DjJ2EPshWWHk8w1qGysETxGmFsJ6EiSnB/JoUkxPTePvAFofisAAACVYIpAuE+ymF7O6yoh7j9hwlnje1G2FAcIhinGG9Ho0oy0RD/eJIv4iZc2iNWW+boMaMBqb9PesdPjuBUzBqNBxeGtM6C+KrKuqljMT8tELZ8Hk5+w1X695sATpUAwQxo02mAy0FUTXUO4XMmpIef/+22p+zIkyFg3YwqAiMRFyHf7HLIxbN0UAR+6iomDxZDDF6oMK2Pcz1O10ODX3nqrn0SvjNP8e3JFlG8utGSvywdosNfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTRbrXRLrhpCjjK0Ju+yUfsytWF5c6IoeQXDLU90rc4=;
 b=G9D/zXhYP8IjSaa9MHDrqi/DBbwwINPyb8S+as6DekHKDyRaF/UDWmuyHP8xZ7J36/f0G8I/Cf2AtKC/HMHDq0zeNuMO9V6sDGroz5TYDyt1RTyVhYibpaNtG8y4DKIoV5+lDC43w3ttXAaiGnqmdtxi06mF11Gz9ZAztk6lm9ywxSZiMTykRrexYnnkbuWnXTQUVmxFccop35kFXe6lYm1jmVbZsGKJvNq9OJI6RYm5YrBKkDC5UEqt0Joualif++XRc13+jpyERM1pZJmuf8An2Ln4czOywbxLPdblkcfiFtSz6GXKuceQysMOfPyclQhJsPxlYj6JWHlts6wRCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV2PR04MB11980.eurprd04.prod.outlook.com (2603:10a6:150:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:06:03 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:06:03 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 21/21] wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
Date: Thu,  5 Feb 2026 02:03:58 +0800
Message-Id: <20260204180358.632281-22-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204180358.632281-1-jeff.chen_1@nxp.com>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GV2PR04MB11980:EE_
X-MS-Office365-Filtering-Correlation-Id: 602d1703-a1f0-4fdf-c4e5-08de64180f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5n6gnYQVXSbreUFVe+fezVizAxTbNqs6wdmlnXW8RtNFJB5KUdz7dv/bDId?=
 =?us-ascii?Q?GS+GDuweVYlJF4O9gYZGbzE8QR7iVvSsi/2c7dc7W0f9wve4DxfG7M69TIJz?=
 =?us-ascii?Q?bNX8jgJFMTOGtUTqw439SDwc+RWd3PNBFLbdN+JsU2S6OK9wbt9Ic1UhNj/r?=
 =?us-ascii?Q?0THHah5yJkvUAVqQe/kMJ72lSamDIXF6xzxncKcPoHF9AKF+v6Z6FOn2eCZj?=
 =?us-ascii?Q?Xz7KEG7VYM9cIaiklZ2xJ2oampL1keaOqJztMcwBylb5o6Q0SD8ieA1U+W4e?=
 =?us-ascii?Q?LDEsVRGeH917JJ16X8tEsk/cOfCRWMpKLuydLypVFdl0sIhfaoUmhwXpUaMR?=
 =?us-ascii?Q?Vnu3gd9yhkfw3Fm0wW/lTdTVnIGu8OuVL2/5KgSa0V1JMX7Bwc5EtcSDsHeZ?=
 =?us-ascii?Q?he/kzjE6MnnO3iUBrR4mL1EqmTqEk2N6d6HSKBA10oMwGLNHTzpug7fE+s4I?=
 =?us-ascii?Q?oZllMLuinQHo/3MtvVt5wpWrd20LVf/tfUvcTnpoQwl3DwkAMoNwR/jGxeEV?=
 =?us-ascii?Q?oeWHPQRmtefZ72r57/sjB3ulFuyOD/R+rjpQ4cIizMVYEbFJjQyyqh/qplFa?=
 =?us-ascii?Q?Wfv29/Czu6q9Mng2RDMcmJsac8ZAuAkDOox1VB2qSscYxOKwxgCpDkaU98oa?=
 =?us-ascii?Q?yR3GaszUpxGEasFmixhm2dDtTzkmK0qsLPxrNTfYp8WlyGVre3j+wVeSF5EA?=
 =?us-ascii?Q?rp4k8sIGz16Lcv6PuS73F1bxd388LJtjhcm+nwoOpv4HUwOdf6QfGcP0R8BF?=
 =?us-ascii?Q?Qgq8bRRoCFZo+TfARtCcEmQ1pIj6zKvE91N9b3tqLYjaBeSEDzrfQGnMyN5i?=
 =?us-ascii?Q?SnnmbyvGGthZp7+SMC0rwtOAXIg3grbwwN1QbvYaLd21PgE1CdOA5FFzH0Sa?=
 =?us-ascii?Q?wpkq3jotLJWJ6GV4T1aHC5PlUPRWgvvcz11ldGBv4Apx0+qE/sUcE7tXnfgX?=
 =?us-ascii?Q?I6r7QVvz8HW973QSIgN60WbKbsoyM/DRll5dDiKXiIsGsd0Ily7aBBet7B/v?=
 =?us-ascii?Q?+XRxtk9CMeLa9lKT91w2lRCmSo9v2sf5p4V9HqpcR2SAr6QRaLM/JlMK5geS?=
 =?us-ascii?Q?Hd2nx6rcUiXdPh765XBkfzteELrndo8NcXGYONmYDWgGvf9t1HUlb7HvApxk?=
 =?us-ascii?Q?OE9SpDlU6dJeLGcksDNLdJ+mqJ3Vr6GGZF0fNmXJpxPz5cF2YULhrOpdntwm?=
 =?us-ascii?Q?bpU8ZFO8ybNTlU/1AGOHbJX+AugSGFQr6yZQ/iI22cMUj9IVWzePqrCGtOVm?=
 =?us-ascii?Q?VNi6XRs0puBeq9chheRLWVGRSAlxZwLYP247fytymaahO0AGaV+7aBxM0Duh?=
 =?us-ascii?Q?Aoto6qo+K9fhpzhC/kS9PoinIL/AKpfORC868v2OF9/nTAuSbP47cbKkhl5d?=
 =?us-ascii?Q?WC/WdOrEBaqCGwAxj2aTw50rkXy9NjjaI92cv12G0LeczkPLwW7cW9oZ6wf9?=
 =?us-ascii?Q?mKfR1vHay2N7eFAFznTL70o13zha7+Z9jxfQWqBUXbR5DeHknPa+OBs7IMkz?=
 =?us-ascii?Q?4wt7edOPVCXke0CWPS81fi2tXpwGlRqlniZqAik8ElAcnXMxDEQotlPy3bLz?=
 =?us-ascii?Q?ORv0RwgoUIku0Vusw6VBRWKoGUpcSHdahBgHn2kbKww3W/YwA884W0lJFkdS?=
 =?us-ascii?Q?XBIdVa968ILrh9JbwJmtnD8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oAMIXQhRXCDWQaFbUZqUfL5zNx7tvvHhn4vSrtmfwKaaw1ssGBo1zZc3jjlQ?=
 =?us-ascii?Q?wSkHeR6TJszBHC4BD1LMVu4dhoGGdzhqvEgiQI+VRYP5q+CtPZk4rx0Ne1y/?=
 =?us-ascii?Q?opdgRphI1zy2ISA8TYGxzUHVibfOcrj9rZDIS7DGt8Sm44RMjGAMkooNdpr1?=
 =?us-ascii?Q?qydj1UsiGnTDMQBDg1IC8o8QtrrvGpczO73j7WWWKer7P/MQYDtooD8LPK3g?=
 =?us-ascii?Q?ilexr3iged3o2gz7dKpz2SjRIn3XBbXBjAqWHyhRiG61wTkcTQ88B6l8MqOI?=
 =?us-ascii?Q?nxpjUTA95/6kM6PZayP+JY0hHeJ2BbsV2LSNYmk2TZP9sAbCsrtvuMvIbKnU?=
 =?us-ascii?Q?bREC1/jrVSmqueBOVMd2tS6zly4sXJN/imT76MhvGUaKNzlJzotWQV4cQfxz?=
 =?us-ascii?Q?sskrJ7aGDzSA8czU4S0gV3boCwYtIGXQf0kcmRXqwsPsPtqkP5QAcD+qFYkI?=
 =?us-ascii?Q?/57LPjibkLZmR8V7U57zJ6T3ys4bUSH6WpH+QjEzxaKJgEw2dh0k5KG4Qz9M?=
 =?us-ascii?Q?uG6ff4GhZ3+Q1pclBkmc5/7QgQ4h4WPMHBsw9L3wu0eopzHyAbiDvEJKKJRw?=
 =?us-ascii?Q?4jnYNV8qne0OOnHRtiicNXNLpKgv59p2QXdkbporw+k2XyPjxmNnNkflIrbL?=
 =?us-ascii?Q?PvcoCoezEzebZN++b1B7kUhEJWSSUQnULtv/rbydIHUqqvO9E6QC2NCJd2Yu?=
 =?us-ascii?Q?0713i7hCNEHlS63LLaTAU7MGLoGM/PMd9Gp4+T9qUOXE3zuXZJ0/siCaY77k?=
 =?us-ascii?Q?dDxz9bYq0m08g0kiresXM2CKQZP9RbD0b1CBHoWQ2esEXm9DqFcNDg0PHP/H?=
 =?us-ascii?Q?Vu/LOpA/B/6lEq+GO4w2+CVZ48tMoAB8bQP4VnvonXUc7jFyXRM4xGeiQhWf?=
 =?us-ascii?Q?SeppEXmhd9+sVut3tbGPtR7lSXp+hy0ECR23x46+BdwI2ug8jcueJHMyFU12?=
 =?us-ascii?Q?Bc8oZyEkAL8o0lce3JRFDNb8J175DwDMsV+wdfpfGhS+QtfpM7rAb/KH89ph?=
 =?us-ascii?Q?zc4twArnIeLlg106wxDvImoB+HuVIbzpxhE1VArTmwU5IY26JEh07Yry0DPw?=
 =?us-ascii?Q?QQ9x1jxm+zZiQo93eIVNPcEjryEP8donWsz8P4gTFnM+ruM2lnOsJ70OxLoR?=
 =?us-ascii?Q?4oKSGQxSFSXQR6DBU53ptT+cfhurIo+BMwiMtyJhY798WlPrywLpKHonezzS?=
 =?us-ascii?Q?4IIH8RxiX0oHWkU6WiAZ7UdVCJPwLBC1Rf4NE+MVM0rpu6BTDxGEvv4t52M7?=
 =?us-ascii?Q?FiRIkHdh981v2QEWH7D/I1bO/qrC7hnuwaXesdZ8fZ3g0uXEXWY9m58uHWv3?=
 =?us-ascii?Q?B/2hAyNqQ+LsdEombWapYShL2jktQO5fBGteW7l5msHxGt/v5l0Ta1G4NxGE?=
 =?us-ascii?Q?P2xJ/oh/IffzJqhQiMzlr79LC1h/zzHI9snz/L11gp6zUaIopWQfmvDAsGBQ?=
 =?us-ascii?Q?5Zrer97PtJ1j0yC552uMeiPlzyrXbWKtvZNPQmN2/CY9ssEvKCjOySHd6bYC?=
 =?us-ascii?Q?pmu13goJgYC8H8F12AQDDMV+DBXCB+ToQSLpQpJnIHCptojcDLrM6EpuBBMH?=
 =?us-ascii?Q?fB7+QsQAYVmq3/CpWsRrIKvYtyBHqwKqkeZ7oDL1ilDoKFpJBxHke/96D/K3?=
 =?us-ascii?Q?cc6nEiz/d/tQ951j6eV+OtNkH/y6Bx4rC0Q2n4L2hWSF/umdS2OGL75vhvNd?=
 =?us-ascii?Q?GLq5af+jdrwzvnRDREP+o32RO5kkxsRH7yw22zm8j5RZvLYvxJJZLx838y/g?=
 =?us-ascii?Q?nj9kzbDyCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602d1703-a1f0-4fdf-c4e5-08de64180f3e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:06:03.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9eqiTTSZOG5g6gruwOtdCg0yIlx/Zb6hMZ6BJjRAPTk4Wz59gQyi+Am5Uddk+BwuS6FnDp/ydy2sPT3Fj06Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31570-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 90BF8EB860
X-Rspamd-Action: no action

Add a new section to the MAINTAINERS file for the nxpwifi driver,
including primary maintainer, reviewers, mailing list, and file path
patterns. This ensures proper tracking, patch routing, and community
visibility for the NXP Wi-Fi SDIO driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0caa8aee5840..d43fea4fe79c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18919,6 +18919,13 @@ F:	drivers/power/supply/pf1550-charger.c
 F:	drivers/regulator/pf1550-regulator.c
 F:	include/linux/mfd/pf1550.h
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	Jeff Chen <jeff.chen_1@nxp.com>
+R:	Francesco Dolcini <francesco@dolcini.it>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


