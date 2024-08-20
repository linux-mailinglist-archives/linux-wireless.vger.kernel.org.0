Return-Path: <linux-wireless+bounces-11704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53BF958918
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79592282B23
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3F46B91;
	Tue, 20 Aug 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pjsq6K73"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A2191476;
	Tue, 20 Aug 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163727; cv=fail; b=hLz7AzljKTNDq6FP1fxewjYw9GfvV5EiSCCpK6aEB6Qw67lJjd/texa9ZMS7mGkwc5d2rtQLKO8BIrV5OY2ScYRFZQ8kzPUl4vX7C1yTTO5D6xnIuRIld8sDHQbIyfxh8Q1RRv1IPmNPG902JSOgU2ep9UhijGPWd2bCX4TX0y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163727; c=relaxed/simple;
	bh=hpZh9h1y2szZppJaZmJzZsu4en1NWLPcjq33NBB5c9g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VYrd8/ICpcE4MM3H3N/ekbgUvbxetLsVr4axIH64xzhHr46enfMc3Hti8GjfV5rsB0hl6YeMnQgBAHSPN6emdCW8JZv/Ly2dkpmgkyeeRuMlO5PO/bJgQD3qAcOk2Or5w/ysD5Ij8cHgAaGa+zpscYKPEzK8+6CUgyy8d0cOX6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pjsq6K73; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb2d+5j1i6TCkODNVCPOcIBpKiOicpZPmw9h4d3dT8uR4qoRvUUhRvJY6VctJeRySLBeqC1pJp+/qQX3GCHbCDg/SFr+lCR2gNCpD/Hq0keBO7T0frMES7+ofgb+TAmavT0e/SiDLGOciVBef3r0HoNZlolqXyzCeu3B5moC6Bboo1jchmv6FDT5dYTGpUv/Eo5tynoyQGyE2d0KbTaF8zfPVrOfMefCkrWpyB+Bj9oWHx4XPyJdiQo8oQ0TGf1VmUT3NjxRIbMh+bhARqP3wkDwsLOj+Dc8Ps+lZjYC68IOuseOS5alP8Ua6VhkFbbhBJvQ7AIKBZem8TOs55KkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ty132pww1tqqI0mlq7bYxe67A059DGGMH8JUYGratY=;
 b=kvoOGQoxJpy1t2Wn5TScbHPCkb1Vy3rqEB4dj/uagvuz2+0uLzCxD28JxMNPUUqp2XYiR0V1kvz4s9ftRJs//uOYID9+9l3AxNpeo0wEflcr8WVw+LQnaAsndDhkshaJhDiBtK1XaX7gVppZ4XqPZw26ZPXYK/W5eRFHfo+qzQ2nLhlBE0DuhjnVtiZoUKuOQ5+KBxsGmevJ89Fie3I8NcUlDNjW+PfM6yfEiLLt8+t8y/e5d/yZi8P8YwV8oUqx1J6mT0QnhjBdtjiv1iLiPU4nKx3ZTc4ldDSxtshy5wvdQIOJ1Kx8nomIZWNxgKyYqNCNWyC7G8XCpO15rz6MyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ty132pww1tqqI0mlq7bYxe67A059DGGMH8JUYGratY=;
 b=Pjsq6K73WKI2wuae8ahS5EKO6CnwUwJdZMj9qXaDhk4NIADwUVMCCum8jjpVvxxiFe7Z0+783Z7yCxn6JTdHBSEcylYLvUcWHAxeGr5hFQN/b7NxssaCbqqTMmnIJTXnbvb3OqKwuiK/8LVeFsv8hpkPi1lHq1Zq7daqOd3Q4JN9mGM5dm65zr7Z6jfMdTPNfNmmo6JyvFETlARtd6k2oHQOZTbTvEqMh1/+1VDNLa8KShLbPCxL3JVC7W+sihKoGK2hZdC9494C5S/nVBq28etNbObOg/sYl50qQtXnJMJaFAbrtJY95Z7lafJwMjz3dTCkQLxlS/MMiDX4FofXXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:22:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:22:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format
Date: Tue, 20 Aug 2024 10:21:42 -0400
Message-Id: <20240820142143.443151-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8b8944-1450-462c-0d67-08dcc123755a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s1nk965p59HMXPddKwE36qgfe0RkyR4SGw3ruAZglBYa5a99iRJX0n/FPpie?=
 =?us-ascii?Q?cg2usnVoXePegzPnlqDXdqMWLBYE5eGkg5mEgn17+mPOmmdV7yZKJySlQEGx?=
 =?us-ascii?Q?XYxsUYbHUAC3qaiIy+uSbDF9HigKlXEXbBDsQkS4bvpVT82LEcB7LRlcsX2k?=
 =?us-ascii?Q?T/NGsJhl9QIQRxWJtu4hCPpI5PKhKUfbHNK1FJs2SMRjhQ3SDnsltxgo6ZO7?=
 =?us-ascii?Q?/sw/KE3ZxH+pizLcojQks75dqbbT+cBRdXfBaTx45jn9zwbYieN9Qz/AlTlh?=
 =?us-ascii?Q?OPekA4c5hQz4iT3VRmCFqtwIkjSbKwiY82Z5pcC8DMcvYl5kzvHbp5HTBPG7?=
 =?us-ascii?Q?noRSKkaEi8+qX+u1Sbzbv8iLwhPnHZn3ZpnxlysyeF3QQJNY6FFj2CURjb7N?=
 =?us-ascii?Q?dTrPbv7ubywuhtbPUwRSKfqDFkeQuj0rYj1Hbbpt7zjl14U4MrvBVLEniUt+?=
 =?us-ascii?Q?WDInUflJQyARvXKHTLfdnP3g+MCRqpBiAil8+VwNji+BAPfY+uX5ImrVf7bJ?=
 =?us-ascii?Q?kE1Zq9Jg76fwYxEAxiTQbfX1q41RdwubLaqW8k1umMXPQkbWyYUj61LvyavL?=
 =?us-ascii?Q?uh18qKNSphTwd/g5YT1MkLSO8kgn3FS7KBJlyCr3Oh0q8YdPYXksukduYjPN?=
 =?us-ascii?Q?ol4BIOqSjNTngjZnVxHAKKMiv0+/PbBRPsUgRkAAFJVbAy4kBUAYCeAYKDmZ?=
 =?us-ascii?Q?G68TANbs4yhi+sLK0BgD/zP9q7xipZ0Lkw43bsOYaQyFnibrVA49JRSBUSKi?=
 =?us-ascii?Q?ImEZ+ULEF6VWyfEMXmKO+e8uclMf6odcjX1M5jXMn2d9u5wtBs30lzmqXk9p?=
 =?us-ascii?Q?OaJuuFGerqTgJYs078eqzd2B+oPXx1M74JZ0yLYcPljkXih/TVZiN4wSiNuj?=
 =?us-ascii?Q?9Sj2iIbPMe1UKob0ZT9R1jw7rN/KaKhW9bvHIkb2gJi95lNUwReuVSgTWJp1?=
 =?us-ascii?Q?KfOlD2UY6/wPMfHMF2eobZAdWv5aZ0aIfQs75C/KRNiXzoZ7mE424fOwWsiE?=
 =?us-ascii?Q?2BZZv/NPEv/V20wQacNawcAjHvISAqxHQj5GNceq9sfmQzsQZj+AqKf2uii+?=
 =?us-ascii?Q?nOivDhGF11WCMLDnZESIv5Ar5mJPGsHqfBnDqBnOgQppeC7TBPcfE/yQivWT?=
 =?us-ascii?Q?3RYZ2zQgHyp+aTUmQ8hMfGYi00pu6+iJC5mYrlAUUSvBMvW+/unpdp9jb46M?=
 =?us-ascii?Q?TvFtNSMqQR+EMGvNxHcn961dOc1LC3f4o6ZTexo6TcfmgThn4fAQyxEgkWcr?=
 =?us-ascii?Q?lBNJXKzUMmMuDeKdHS6UBQmfxQpFxOumqFotOJ1A2CTVT72Z/pEBNH7CEFWT?=
 =?us-ascii?Q?NQbbSJA21Pf7QT/DVWpQtMgF+spV2bQsKPqH23Vhlr1GTcILglN3Pn+0eYbC?=
 =?us-ascii?Q?TmubXVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D3hXWefhqhAPU9q0v4oAa5NlrhAjfV9Xmfcci3otWMzMTpNDgS2/vHPcYe/P?=
 =?us-ascii?Q?IpSpl3I5xr+94sdBcFe5/MZb1gNYCC/b8StjBWSKsM6HCgJ1EnYsQ/nMt36b?=
 =?us-ascii?Q?MYxvVwkO5G0sTTfX/GAj5MkEvwyP4h/D2Fvtb9Ygrwa1f3Y426yp3mwv3ysV?=
 =?us-ascii?Q?B8tE3iHtMQ4MjKUv3uhaqvpaWN6u5o02vas+5oGHR90PDjo6/VQPbHH4zVyi?=
 =?us-ascii?Q?weyLDqk0moScDmh/lpk2Wl/+xg6nlTwGUsn7BYroRpgiwazCh8mosw9ixdjz?=
 =?us-ascii?Q?e9+kiDXYOPW6aVLR4kjuL7oivXPoT5RaIhnzWzSjhGdEHr5pORbkredo51+4?=
 =?us-ascii?Q?SY5hFOgiCrvnhhpGie3iMVA6yPjtzYfY1Crb4QiMIdmXwAt5IkNIX5te06DM?=
 =?us-ascii?Q?hsLvZUuGIldDmYVLvU41qt+KQ3lybz4k7Fjp7gzHb0hPIR2uqXydQkrW5nvS?=
 =?us-ascii?Q?JFEg9mtnHzWbfoq+FowqW2Z97BYKuIM6LbwBcE762bqPcuvSd3BogjTyqSzm?=
 =?us-ascii?Q?myWpxN7OnV7N3hYEUDJUG8VXCrcacjfLCssWjPdSeT3XW2tEJ1+fA8JHg5fP?=
 =?us-ascii?Q?mdSe4jTTCNIiuA7oyuq06pYcsRdHoFiik1vcxpmAAKfnbDwzOjnzeb/caOuU?=
 =?us-ascii?Q?Z2Ouck1HumI/auBG+ecRU4cu1ep7HLWuokNAoLpYUhWmwC+wrZnHGTFc6PqY?=
 =?us-ascii?Q?TPpEmKxIHGmG/JIeO1dAh1bfIjjdA+ej+kcG1V6boEXsPx919QobbVZp+9xR?=
 =?us-ascii?Q?4LVOcklxTN79VyU5tyj38uAS1DkiGbeI1hVldmIqYcxVke6TJ9aUo++Syo6r?=
 =?us-ascii?Q?VqSN9ozAM3a/DlF5+JYEN1iBmiWs1nGgG/RIEpUoC5UZkv2D3hnM84573WmY?=
 =?us-ascii?Q?l5aqC6gQIOmqU9V+G4xF8vf0u5y50AvnSSdvlwNNTM5jv3qxIdRP6mvm1vmd?=
 =?us-ascii?Q?e+ttUBqdMH3ERBMgpicOvbTAQgOZ6aMM7RSMILJTk6gtB6kaDgYLd1A1vwjI?=
 =?us-ascii?Q?l03LJY8hy6ZWTO/0/pgYJOwIhLOgX2KdB5Igv9xg6HF0UWpp5w1MU7egyATU?=
 =?us-ascii?Q?Bj/8buc8ce/yVVKSGdKxZXyVjfXlwo7JCxZV11rTGsSjFReXfE1Ir9kHNksv?=
 =?us-ascii?Q?703XZGm8SOYJgPpqdo7B+6eVKjjuSOOd4cwXzDY/gR+/wcb6GfqcATUWF5/1?=
 =?us-ascii?Q?i3f9LpTIvHemFKtFoc7wALT24BJwC6oDD9U6DolzPH3MJP/F/Jivt6qbKaVL?=
 =?us-ascii?Q?wg0Zs6z7BWQNT3baKxW0Jbh5cZEjoRIGPB5yBFUmpdomO5e6pi6/ubjoJoPT?=
 =?us-ascii?Q?cw16lRZeBdKYot9V+1Md1pD1jtpf9lCZx5uxpR7KZRb3ScCuwDg2uBeP06W8?=
 =?us-ascii?Q?oqdkcl9Fl1kzgL9u5Eh9ZRFWYfILbC7SQjVvkfuqySubqCDqYP/iezPqMZGq?=
 =?us-ascii?Q?Am1SgC38PR7QB6fRvLsS7QsAU11vE2lAjcbkLFMDdbMnb6OlMsq3hC536u4k?=
 =?us-ascii?Q?0e82mP8egkw56cE7u2P0IRzrDHO/7xGmdzln3DO0mX6WW2LmYLcDNoE9y5cj?=
 =?us-ascii?Q?NWonf+s6ZyXjRlqGQao=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8b8944-1450-462c-0d67-08dcc123755a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:22:01.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sarmALmr6BMi12GmS5P88K2jVGNYky8y5+QwKHBX59wCzJqAXm7jcqW2SGWWKziXDBblAvG8q5kMwWT8meM2Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

Convert binding doc marvel-8xxx.txt to yaml format.
Additional change:
- Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
- Remove mmc related property in example.
- Add wakeup-source property.
- Remove vmmc-supply and mmc-pwrseq.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
failed to match any schema with compatible: ['marvell,sd8997']

Acked-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- Add Rob review tag
- Add brian ack tag
- remove extra .

Change from v1 to v2
- Add Brian Norris <briannorris@chromium.org as maintainer
- Remove vmmc-supply and mmc-pwrseq
- Add wakeup-source
- rename to marvell,sd8787.yaml by using one compatible string, suggestted
by conor dooley at other binding doc convert review
---
 .../bindings/net/wireless/marvell,sd8787.yaml | 93 +++++++++++++++++++
 .../bindings/net/wireless/marvell-8xxx.txt    | 70 --------------
 2 files changed, 93 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
new file mode 100644
index 0000000000000..1715b22e0dcf8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/marvell,sd8787.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
+
+maintainers:
+  - Brian Norris <briannorris@chromium.org>
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This node provides properties for describing the Marvell SDIO/PCIE wireless device.
+  The node is expected to be specified as a child node to the SDIO/PCIE controller that
+  connects the device to the system.
+
+properties:
+  compatible:
+    enum:
+      - marvell,sd8787
+      - marvell,sd8897
+      - marvell,sd8978
+      - marvell,sd8997
+      - nxp,iw416
+      - pci11ab,2b42
+      - pci1b4b,2b42
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  marvell,caldata-txpwrlimit-2g:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for the 2GHz band.
+    maxItems: 566
+
+  marvell,caldata-txpwrlimit-5g-sub0:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 0 in the 5GHz band.
+    maxItems: 502
+
+  marvell,caldata-txpwrlimit-5g-sub1:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 1 in the 5GHz band.
+    maxItems: 688
+
+  marvell,caldata-txpwrlimit-5g-sub2:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 2 in the 5GHz band.
+    maxItems: 750
+
+  marvell,caldata-txpwrlimit-5g-sub3:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 3 in the 5GHz band.
+    maxItems: 502
+
+  marvell,wakeup-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Provides the pin number for the wakeup pin from the device's point of
+      view. The wakeup pin is used for the device to wake the host system
+      from sleep. This property is only necessary if the wakeup pin is
+      wired in a non-standard way, such that the default pin assignments
+      are invalid.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         wifi@1 {
+             compatible = "marvell,sd8897";
+             reg = <1>;
+             interrupt-parent = <&pio>;
+             interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
+             marvell,wakeup-pin = <3>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
deleted file mode 100644
index cdc303caf5f45..0000000000000
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
-------
-
-This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
-The node is expected to be specified as a child node to the SDIO/PCIE controller that
-connects the device to the system.
-
-Required properties:
-
-  - compatible : should be one of the following:
-	* "marvell,sd8787"
-	* "marvell,sd8897"
-	* "marvell,sd8978"
-	* "marvell,sd8997"
-	* "nxp,iw416"
-	* "pci11ab,2b42"
-	* "pci1b4b,2b42"
-
-Optional properties:
-
-  - marvell,caldata* : A series of properties with marvell,caldata prefix,
-		      represent calibration data downloaded to the device during
-		      initialization. This is an array of unsigned 8-bit values.
-		      the properties should follow below property name and
-		      corresponding array length:
-	"marvell,caldata-txpwrlimit-2g" (length = 566).
-	"marvell,caldata-txpwrlimit-5g-sub0" (length = 502).
-	"marvell,caldata-txpwrlimit-5g-sub1" (length = 688).
-	"marvell,caldata-txpwrlimit-5g-sub2" (length = 750).
-	"marvell,caldata-txpwrlimit-5g-sub3" (length = 502).
-  - marvell,wakeup-pin : a wakeup pin number of wifi chip which will be configured
-		      to firmware. Firmware will wakeup the host using this pin
-		      during suspend/resume.
-  - interrupts : interrupt pin number to the cpu. driver will request an irq based on
-		 this interrupt number. during system suspend, the irq will be enabled
-		 so that the wifi chip can wakeup host platform under certain condition.
-		 during system resume, the irq will be disabled to make sure
-		 unnecessary interrupt is not received.
-  - vmmc-supply: a phandle of a regulator, supplying VCC to the card
-  - mmc-pwrseq:  phandle to the MMC power sequence node. See "mmc-pwrseq-*"
-		 for documentation of MMC power sequence bindings.
-
-Example:
-
-Tx power limit calibration data is configured in below example.
-The calibration data is an array of unsigned values, the length
-can vary between hw versions.
-IRQ pin 38 is used as system wakeup source interrupt. wakeup pin 3 is configured
-so that firmware can wakeup host using this device side pin.
-
-&mmc3 {
-	vmmc-supply = <&wlan_en_reg>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	cap-power-off-card;
-	keep-power-in-suspend;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	mwifiex: wifi@1 {
-		compatible = "marvell,sd8897";
-		reg = <1>;
-		interrupt-parent = <&pio>;
-		interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
-
-		marvell,caldata_00_txpwrlimit_2g_cfg_set = /bits/ 8 <
-	0x01 0x00 0x06 0x00 0x08 0x02 0x89 0x01>;
-		marvell,wakeup-pin = <3>;
-	};
-};
-- 
2.34.1


