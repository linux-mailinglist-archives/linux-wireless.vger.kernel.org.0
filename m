Return-Path: <linux-wireless+bounces-29528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7ABCA6515
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 08:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A8830D897B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 07:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90402FBDFE;
	Fri,  5 Dec 2025 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PxMVzMIO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5962F83BC;
	Fri,  5 Dec 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917910; cv=fail; b=FySG9Pxdrm4PQci+Ek/gONReIfBCgDvz4eBMFkzrKRIQz14NuMGU5jM+QIj0QRYeoIyhP0J6FC0bxUqeBUbhGxaENoiHbn21HJXSavYbsquw7DLqRbBuBpiJQDSJKybYUP8q9uq5sSZ5WKLAAcvtOKgiQEc7OOqGwkwFJGFH0c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917910; c=relaxed/simple;
	bh=7UjSC1SoGuV+tPsL0kD/Dlczdfaw7Dh1FT6EL1Sdgg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0ezGL57cpMtRrE4lhW0cTRexYUKRkUIwVceUcw3GqazUE7GV370znRuLUdKjCGakmRko0gs9YUR+Q4GwSWAAF/dTt3GAyB0LCGNTC6xo7ZDruqKTLI3gzU06MUnKqENQz3DUhW4Hpo9TOrRnUCVqxsr+1A35gJYAZHb6JL0TBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PxMVzMIO; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwK+ip54J6DaT0J9XqqorscVpyNe39auiME/5Jo0pdLFya4JDqePenff4EPUpC4TqYY6hSCnz00dxihTOGX1H8M4AHZrHUT2EvljWNUHWg2hiuuqhtFL5lmFUufC2TUxnXRCTjs6TAswy9bEoGfGJUDKPw/nS7AkO6q3XcviC2gxzsP4uAzD6lbrc/0Y5s+TqXKCc223PM+cMyVo5MhT+bUp1LBRlrzXDbWnX/pcBkKLBr1Yq8qnYJQf6stLbUk/kSbZUfQGkk4sTXFdsG6rv0+kQswb4C0n30/rm1pSFHVc1OtfPLKPAkmuVh2peykzGmWI3BELZJ1dpDTcnR6Bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyyh8RzuiR3fuax8S5AuYR2IAy0nsZHXoHgKbSAAxOc=;
 b=EI9ASS4joFoWi8i9mdLW4NA0vhz1ar7wUZevUmLzbhqaZsLu4Bm1oH7hsmJOc5NUp0xPMosZbHV3DV2/lbcP9Dxa+KIn1DL5sp8ARZlF7YOBXKVXLbEICxhdCuRPiIZaGDw399JOXGfbgHs76if/DRgCzxMvGVCsRERtnhmwF9f9j5m/WXD9/7f5L1idg04AuTpy48ZEdcmjv6KFXNskqTA1u3+8b87HbPowC/ybWEpx2XZPsx11SqXLgURngjSLWJnDs0pxoLix613XO9gOypcm46OS1r1baLH72ckKejifA6sGSzDs4uFWqgsCr/zJOf2lPGuHSOPPZrreZGClxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyyh8RzuiR3fuax8S5AuYR2IAy0nsZHXoHgKbSAAxOc=;
 b=PxMVzMIOTL15cMG9qmVMdnOUsy+SwHZNf6Wvv4i8wFV57pZvW7y4YQ87DvYJHWmrVasSrkefIRkf/mnOjrZZxyVuh/fUMvQQrRcl1dT6HRG+Ffz3O1kKYzAPhaKhdkCJZZVfq3zd+lIJ30Fk/HXRyPxzd21CiYyaCn924+kq5HvDYB7g/+U5d/VBISNQDahvqZgFkA6vjL7wfcde5jTsg5e8FwTSnJRsdHOYG7agvMSOOT8majokq41bU3DlFsH1i4hqV3tGWxafKcqkdpErNghym+zYOFk/Mc/T/bUY8LlfhFhmoZWzyLXq3HsVvjdMJj/6IRMobg7I5hOD/pGDlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:58:03 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:58:03 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 20/22] wifi: nxpwifi: add NXP vendor and IW61x device IDs to sdio_ids.h
Date: Fri,  5 Dec 2025 14:55:43 +0800
Message-Id: <20251205065545.3325032-21-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ece51a7-a39d-42ef-f4f4-08de33cba256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YokeS35dgZ0g6J+861OjrmnLShcL4RqXJFb1CtEQDve9bTAEZC5AZ32Er/Na?=
 =?us-ascii?Q?ep7fujUicndKNv78jjWP5p0RBrMIqczCI61nO897sqJEbxYPcchW5E36HDvB?=
 =?us-ascii?Q?6V6HSbVVTHckCT8ZAo7PRSv5v/6X+iKdCWq3kVY9gSJt0V/hbzcgGNqolzTZ?=
 =?us-ascii?Q?B+UQN7xdVBPZNDUU0oUIsjpUAmXP4DV6BkRQzCAK9PxStFmPJoM3JE2NGqpl?=
 =?us-ascii?Q?D1Cl/7lcwGgl+XBCEixlbDbV4Rvoi7tqD5jiWULTLwRlsIr8WPrjxpn2aJks?=
 =?us-ascii?Q?1FTd1QOJ8ZLShpL507wjPTVAOS4qOvqMsnEj4+aeSDDDfTxJqtGSZ16JdoI9?=
 =?us-ascii?Q?544myRqAJTDErUkSb39jZnremJaO1h90jWUEinviEafmInLXv64q0ab637hw?=
 =?us-ascii?Q?4yp26c/IPgPv20ZiqdZu/XG76UYk3soWiMsYpBzwo8TXfYzfShQ+XWXR0ES3?=
 =?us-ascii?Q?SDoE0gues7e4XsVOHezs5lUHIHXOmOZ6X1rEc/Gg8j+8NQbY+oCkFhxgmuaF?=
 =?us-ascii?Q?ucOUGvMHqaUxP5tqEvNnrHLF3VZrfpGcQ5bNjVvPB7g/Y3VStWwDt+7l4zA6?=
 =?us-ascii?Q?thywngndp1jzH0+vxf45WSK8vNw1t4eG9w6fA+6dyhFMGUySrZy63YvXFJy8?=
 =?us-ascii?Q?/frRNviJgrPAzdlPd2xp+B7Px3Ni4CyeJLemc2x093C6JcVv7F0VeWMXj3ZU?=
 =?us-ascii?Q?jb287DN6JftY3lLAMS+MfRU/3YmkreICSPSpreDdahQdxOXg1pOP7az286dV?=
 =?us-ascii?Q?DJJNeeeqq1jsu8puCeDRUnu4yVOZCGlHGmogR3fSFpcsx5FbPBw2E+ewtXk4?=
 =?us-ascii?Q?RGTHh0gsR9qGT4ToalFHv9PV+fnu7Rv7vexWATEakhvQZgNIbF2p6tP51A4g?=
 =?us-ascii?Q?5yOGj7eUKAIdmNDwL69DGJtrHve6wd37xJFzh85anE7KZJsMkrCelw0udQpa?=
 =?us-ascii?Q?ej5trEdgNkJF7sKDA6ArFgpnZ4XfXUNRuZxICq6Y+lcACP42Ao+8sinQl2Bu?=
 =?us-ascii?Q?ypNRfaxlSBKwHMwn81Bn0FzcrHkFNtaUblPMDLwYOETGnJvv65ZNRNt9Fz3/?=
 =?us-ascii?Q?7xirWfG62/I362QJ4Uh6iwHM+z4y088leSJAFRCwhPgzRGiCo2W+M90oFRY0?=
 =?us-ascii?Q?BJ4eINBaN4V6Cke1HbmAJtqJMDkr4pRSTGLkdl4XIdqkVe2h8nR+WLgCSI1Y?=
 =?us-ascii?Q?J71AaJFCrZPP6z4A7aMEdey5Bw1A8AEIrvr4DreYO4+RrC4hQllz2dqFSFwh?=
 =?us-ascii?Q?9CtJp9J3kh2krLVLffZWxz6UvjKMhnxN2JhYmisGnaAeLbdQ4gwwbPiADe1G?=
 =?us-ascii?Q?VlhpfPK5k/Zjyh8C6yQMsucXkWOiv9fAiT53s9x1VQGXgEdADXDKuQCop9KB?=
 =?us-ascii?Q?+TRAETeukoInP6MC/iHgWE3zTU5L+hN5OZ4GfqxFdEW+cPM6W5Co6lJBCZBp?=
 =?us-ascii?Q?u/v1WK+bLwi8w3+7jKlBLV/H+nA/tXm182Hw6lBnSroIOdRCcdxzkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rm/lLpxZPFpXX8/TJU285ENI0CwS5o+x6R+gCoThKeJgalRkBUe152M0dPOk?=
 =?us-ascii?Q?AzIwAl631pxuWv9XnIgBfEykijgIyjbJT1LB6mfv/U8yfuIhJEd0OBBUn7/j?=
 =?us-ascii?Q?B3JYpML7cV3akMSvr+6I7KvBa6IH/CqJPMvv8myGW0941avBlwF5rHm+7bNp?=
 =?us-ascii?Q?SQ647yMWjQgvWfpo7TX2vMGPXlLrWsSzntS+ZFqfwVXqtqML+LzFXt9SwL1N?=
 =?us-ascii?Q?P5Si6KgvtYR9z2Q/XRtx4OoCRyQaieG6nDJngJ9waPKqEjbB6x46M0F5CwMI?=
 =?us-ascii?Q?Ez4cN5tfIZ9oii4XA7G1VwAjGhks9FI4TuHfCAx7szSooU3OnaVq66ZyOfw4?=
 =?us-ascii?Q?DhlYO/e6Rkars9sTDQKkGOoehRBdTLOjylr8/hA++hor1r0UOoE0vIUlWF2m?=
 =?us-ascii?Q?SC0B8r9XEC03isv5OiPuy+5sBQvEmvVKdgpmvlvvp/geuCdURNs28EMK2EmW?=
 =?us-ascii?Q?IxH2LBKoQRpZ+MBpCm+Ftvst9V/perJrVB16JUuoa4F2aFSy4eX0NLWUnjIQ?=
 =?us-ascii?Q?QTZCCiJoBjqlkPfu706hCs7wkDUcGldURb7AJgQyNRJobVIYT+GGf1b9I/+v?=
 =?us-ascii?Q?vQlmEEmPz/u8rdSYBAb3C5G0U+kLP2ICKhlJc5wrxYVuPVhka2yIsskWhQTI?=
 =?us-ascii?Q?odSNfS8AHklakvgrdLCQl9fzMrrQpMBpwNa0qXQS9oUTXjPNZgIiqvaNZgO0?=
 =?us-ascii?Q?gzT6iRlLoGl+iJ0mx7zePBGYmrOm1vAMZuThGCsQEhQSGrLwwX/Dl7ZjTBcd?=
 =?us-ascii?Q?aeKGcaSXQdWhugOs1r0BM1aqSNiLlVR/l0qBoQQAn/x7qV8D8lvE60L4kATh?=
 =?us-ascii?Q?/Ra34W5TszqUAR1+ivVvwMNu3UwGecBn2MJpymT46EKAWKNFJFhXzgGbIFSx?=
 =?us-ascii?Q?oqza2Chx/Z8yh/n7+eSSyQ2flYLsqbqKjevnq7pTN5aj0JZDxh+Waz+od2U7?=
 =?us-ascii?Q?2cYrjyLW8AfGjTjHTtRxXxJwydJPpDkS17nLiz1GJhIRY83T5oMiEDopQ/HI?=
 =?us-ascii?Q?yafluu2IZZfF+j4J6sJiPrP8x4LiDnmK0bGObf3O+8gh6Adi3+msIWp8QCKP?=
 =?us-ascii?Q?pc/cKO2IOgZbdVFC543Y/r3djbZx8dxTFtRpH1co51QUA1sExeYJ0qJ2Q89n?=
 =?us-ascii?Q?UzwIMH+zMaXQo5OHcE4rgQZUdfQQiDTwkvYP91artvMhncbiw2BT8OlWceOZ?=
 =?us-ascii?Q?MW69T3L6YuTX3QdO+mOlrb7f17ir/AuMbl4Iqbc+czfgwXbICNyDvwIRooks?=
 =?us-ascii?Q?TJIWFzLIjI4DElb83vqlY0sVw9Yk6eBN0DM/MREm8AOgykYo9g9ycwBrNgcT?=
 =?us-ascii?Q?/My0WIFwBc588bi8wnc7oa/fREEEmpjGxLb0FBXHhf+MMrpwH/o1rGkL9Nbq?=
 =?us-ascii?Q?t+HGR4oN2odsDSHG4weq5XFoOFL6i6HTvfixXubkNX1wZuu7Rq0d3KMi5iMG?=
 =?us-ascii?Q?3K3nvXMhcUEd+CHoA4NbQeUJ5ipP1V/psKuId/u2q6Dqitg/N/Wa293qmd26?=
 =?us-ascii?Q?PxkQExmFl8FJf0fmGWDDBgNprL2ESs27XoxFZN8YZ8iyz5NLhG7arNDCvGvi?=
 =?us-ascii?Q?XbY7GiHvg96/j3+aEQxCvt8lmTfSfp7KDhj5F0G+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ece51a7-a39d-42ef-f4f4-08de33cba256
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:58:03.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j02ZPrBl4NsCYRf4ikNaKi/QJWcHtLo9fk/EMynD0zfR8QC0cmZFwKKLFX09bkLCBt7W2TEWIVfQZMXPKW0kZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

Register NXP's SDIO vendor ID (0x0471) and IW61x device ID (0x0205)
in the global SDIO ID list. This allows the nxpwifi SDIO driver to
match and bind to supported NXP Wi-Fi chips via the SDIO bus.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 .../bindings/net/wireless/nxp,iw61x.yaml      | 85 +++++++++++++++++++
 include/linux/mmc/sdio_ids.h                  |  3 +
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/nxp,iw61x.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/nxp,iw61x.yaml b/Documentation/devicetree/bindings/net/wireless/nxp,iw61x.yaml
new file mode 100644
index 000000000000..358714796868
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/nxp,iw61x.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/nxp,iw61x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP IW61x SDIO devices
+
+maintainers:
+  - Jeff Chen <jeff.chen_1@nxp.com>
+
+description:
+  This node provides properties for describing the NXP SDIO wireless device.
+  The node is expected to be specified as a child node to the SDIO controller that
+  connects the device to the system.
+
+properties:
+  compatible:
+    enum:
+      - nxp,iw612
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  nxp,caldata-txpwrlimit-2g:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for the 2GHz band.
+    maxItems: 566
+
+  nxp,caldata-txpwrlimit-5g-sub0:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 0 in the 5GHz band.
+    maxItems: 502
+
+  nxp,caldata-txpwrlimit-5g-sub1:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 1 in the 5GHz band.
+    maxItems: 688
+
+  nxp,caldata-txpwrlimit-5g-sub2:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 2 in the 5GHz band.
+    maxItems: 750
+
+  nxp,caldata-txpwrlimit-5g-sub3:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 3 in the 5GHz band.
+    maxItems: 502
+
+  nxp,wakeup-pin:
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@1 {
+            compatible = "nxp,iw612";
+            reg = <1>;
+            interrupt-parent = <&pio>;
+            interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
+            nxp,wakeup-pin = <3>;
+        };
+    };
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..39ac2b612e4a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -116,6 +116,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1


