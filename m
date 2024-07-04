Return-Path: <linux-wireless+bounces-9972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28072926E0F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 05:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78DD282605
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC2182B2;
	Thu,  4 Jul 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MLIt50cS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF239457;
	Thu,  4 Jul 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720063822; cv=fail; b=VJk1V90WkNxmXQMW0QMG0oD09mNXJ+xzPxPeObaerQ4JUEmEXM/MU935dbPS11axKjQfN1DhcqViHTqY4xmhrDZg6CPEwpFR2a/Cn1NwLv74QD6dmeaI9XYtaOUR1JCF5W2HE4+1S3qGtkLdv9+5lU1b4d7aSmmK5k2XUkgyJEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720063822; c=relaxed/simple;
	bh=SGJzUcBDGitpweDnz6ELL1pazpr2UjjVpoK58yvVd28=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=khbYI51ubGoCV9JQUB/g5EkC2ZO4ekBgya2zcBMV2gUYB5Ih62Lr/z7tX3sniSCibYrN7hOZ8wgj7UoxMMdA/LnOhuJGEXskweUhuCVEuKE7R5q5J4QwBbfuUGSZLZ8IpF9vYqmygg+lPf1OX0O7s7wdLC+fBnSWW6NE5vPYtQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MLIt50cS; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liD4VqG9zdLfKT/sc0n9Hq/qsVvTFPSkEFLh1krI0ZOcWdRsww9lf1H2X3jhwa8nntfI/SBp3F+Tg87HvsRIbTBUVAyGfiRWzZGuehmYvv1h4O7Aenb9FoM57zr69y0wN0oUrY5XkvGu7hDCiz4vr+z1Rwv6QJL4aoxjzAqceNIt5aSsOlMxKk1cKKji9nulzDE/ta6dO6OXB/tsKGnN0O2l8jwPotQFKJHs0UcjBUtwZoNljY3NFwBlLcTLx3dYa3nBUXEl0jnNUtJ1qJDWQb8ul/dwREa/L5w2gPcZNUHHiN3mpghKtvFz3Llq+LsR0QTDfKJ9tXy69kNnwsKJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIy+5RgONiUjH+iVi0on3v78ggxjIp/uUCVctzTQaOE=;
 b=lK5w9AfKhOSztr4NDvUZuEiEv0MlqskDo0CA7wLN+IfuatCXBh7KB98YZSrCzsnDGTKX+hh+cfWedatw1YMvWjS0dTtiVdLGvdnZypXNlUAcYVycynXNHdTdTtQBNWt0UR52vIw+4Qkbrxi1zhepj5KVdE9obOI64/TYleRFshzhlCRbxnwgNjRtKb1ma5ywLwcfiu1u6SUXECeA+U+RZQb3T6itpj8NCNy2weFD/MFKiDAvzpEbF2JueDCkKsUYJo45XRtSk5UY2JnMAxMgMd+MJ2XAMVCU2q4ZTqUxN4QjG85Fz5n5s0Pyss2TKkfKjBX7F7n3cY8d99Wi9ocqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIy+5RgONiUjH+iVi0on3v78ggxjIp/uUCVctzTQaOE=;
 b=MLIt50cSx3z8QctJPCeR1LilGFzVsptbRhU5mZk752UYYLK/XtGQwqVHuusM9qjFql62+0bnZO0JULQG1+wT+MK5h1rZGFWVkt5MDAlb7sP4zrnav9muXNySUJGoz+Q1OBAp1oKiz/NmLyi9FgO9+mgf0kd/aUPSXchYv44wedw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 4 Jul
 2024 03:30:17 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7719.036; Thu, 4 Jul 2024
 03:30:17 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v11 0/2] wifi: mwifiex: add code to support host mlme
Date: Thu,  4 Jul 2024 11:29:59 +0800
Message-Id: <20240704033001.603419-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DB8PR04MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 67242a78-fba4-4c5e-dc69-08dc9bd99f9c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?NfohbiF/jyrp+zUeCM76Ht1elURVDOtewNhbFDkZ33Tl3P4I1QCBuRAJlMIm?=
 =?us-ascii?Q?k2bWdWLGU0hmUiUQ6eJAsbZAOndB38VTIO8tvqqHtpzIj0e1eR3+8IFmb6HP?=
 =?us-ascii?Q?fr0sH25bzY+VGA4PBcHXmdoD7e+/HkSq9QGOcsMUoLy586N8b6nNlba/slWK?=
 =?us-ascii?Q?jIIf8qAq9u/QFDQ0keRD+qxrrfaP55d/dLMofIKZTnnDYAOar+YSrnRLTFot?=
 =?us-ascii?Q?105YfeLXUt2Cp4BH857XgovIdKywQTCxzIt+6CW3PiHTkQSQb5Km+44h5qkO?=
 =?us-ascii?Q?lq69o+t3yeXlcS1cptzX5Lms+UJnliLYP5Gx8Y1HuLQ/bybD5vHGnKJZeZqH?=
 =?us-ascii?Q?xNtaolv0ogVgSaBipWlo4SQ+tgtg5n70WyHtFuvDP0ZcnU1iHV6PxmjFXO8J?=
 =?us-ascii?Q?IzlBnj5gyAeZwGt2LEfYU+3KkZvqs/v8TJ6T+yhk7JVq7kjPaYrrpDYCkZOH?=
 =?us-ascii?Q?YhpavKTlZGvFWKF91Z20xZhfKo1DnoAZIpaGvDU75JkSunQU9XC9V47lW4d4?=
 =?us-ascii?Q?IWsTZBzMMP+4UI+0yQmEit/mww7Qa45dhMpLG0YYs+Mq5MpCXWsoiZDfNu4B?=
 =?us-ascii?Q?JC7IrTrhTALHfJeBefNMhxt1jGvY7Z5+U7RtjG7jQJ401vTpnrb0d3d/XFrb?=
 =?us-ascii?Q?Wx44sWUa9WU0VBySN+TGGVpRwQnSm5uH2t2zhERZIU+dl2fXpRIJ+RRDgbLm?=
 =?us-ascii?Q?RZUV5DzFwyfywIqsdoKZRm9D9WKrWbMD/mYNfuMlWbHAsqJvtBa0A1xvtmPl?=
 =?us-ascii?Q?eeV/7iYz4yN4W8l94ZKd/YlZWjUFEGehEo9+MZF7fVudommaPr32Y60vmLwk?=
 =?us-ascii?Q?dZFEQssTYuW22XHI1sLNC4Av06qRKGDqTDnP6x9IZBIPZfZF5mSOo52y8iK/?=
 =?us-ascii?Q?l4LxM96/iztsO1y4Gp2YeiGPxm9JQ4eXgNX9rgqi08u+5djuQwy4lDlj1SEG?=
 =?us-ascii?Q?wAbHOlDeyRHxI+uYG75JExtaqQjxqJwURKIO5Gyv/d5ZSjvSfF0b6g/k+KKx?=
 =?us-ascii?Q?GfRDO3V4Odg9m8H0Y9JrSL4naafNis+IkM6K3OCxdhRujoEOaK88sX2P3dN7?=
 =?us-ascii?Q?Gpy3O9SD18tvnGvDZ9Td/lKAF3etotq4YywZPnJh1IGxER9E7BUharQ9vWTz?=
 =?us-ascii?Q?DHBMAzM7mAe7+z+yu2A3fdKvn/U33zNaRcQfC9vdweMy+DTW7LOUKmckQx8Z?=
 =?us-ascii?Q?4QqLPhXMogvgk5LsLmmgD2oZ2gEpzQo2T8gjuHSN4wHOVTS6dSVdg30CIlWg?=
 =?us-ascii?Q?yeKfT18rzApdk67T9Jd0MheceRRx8uyIzxyTo7cZXGzS4uovck8cwXWdWWrK?=
 =?us-ascii?Q?lq+85QpxKCJaQRgwdnccznkPqOVWrXxC/jmPR7QznUpKwkMXPm/rNnwjqQmx?=
 =?us-ascii?Q?SLVg70oKTpSV9g0qwNGWjYBENJxRp6cMedECBoI17Cp99ggCUA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?/kUaQ3R8v1LTvnF2BKXb3Dt5ZoUFz+sEhI+X/YVsfdKx8RCVUuRZlvreSdYX?=
 =?us-ascii?Q?KMrEfLXKS8L/KX34ekakNGWKhIGjWGA8EtVRP4MY79p0ZR8NdbUxtF39sTIq?=
 =?us-ascii?Q?+PIDQ+KwKe3o0tnB3LMAA8QGUK0V0DXFrwlZhpDoBH8BuAjPT/iOHxdbPoJv?=
 =?us-ascii?Q?cnDAq06maYuj5zG58MYeJl9vC6+APZjpxQGYbFmB3ZpcuMH+6gEQns8A45W6?=
 =?us-ascii?Q?P9TBJl1gRePDie5Vzs17y5x3BZt5DW6GACnDayo2xemqLhm9bxCI5/r2KZqX?=
 =?us-ascii?Q?yfIK0qI1jOCHweJKPPrSP11n1BwBx2HN9WJgFN33KyhjfqSEe53yOkc+028A?=
 =?us-ascii?Q?cbjyndo6YqDUbYCF8A180/1pZWmIxKgUVzob3DSdwBJ330nGLZdWxtUUzDiU?=
 =?us-ascii?Q?UOH8FQ0913/UuWr596ZTclJ3sVS7IqmqfV4oXY0kZaf9oWzHr3VQa2qqmJDv?=
 =?us-ascii?Q?Z8sGTJ1F3NhGcv9qF58js7bB2fMoTHz8WU/jSmU3RaAlxEhiCWc/30HxyHSv?=
 =?us-ascii?Q?pcjB+//GIxdDXCVC1Zn4vHEvt05R/1rz+XFG/F1OxNgk5y3ZU5IfaasnOXkn?=
 =?us-ascii?Q?zYWlexNwDFZA3aSS41blfE5htFzByOgVNMCRc74mg1ULHagjJdTd1oOMVeZq?=
 =?us-ascii?Q?Tc5Aprpqw4/W0P5MjZPfikU6WNhE9XghiqoS/BSrkgXDTu1V8lbiuZ4jvROn?=
 =?us-ascii?Q?YPtoRYITodH0aLDOQJ0Nlb/84jPvyun6s/DoiywT4Srb7Oy3w0dZSJPD32b1?=
 =?us-ascii?Q?yA/Ek1fxy8u3vy0LnU/Nx3XBU7Ec8NXW7X83xCQCerqBb5wk6ARFrEIO/Jvv?=
 =?us-ascii?Q?Az1lGcvhzzH2PhvHbl6oC2JLUjx0fUOo1lkYOsySfYsnqtdS5Xx4pNOZTRzm?=
 =?us-ascii?Q?NH3JeJIScAwHClqlG1TsE7+Mt7lYyMHZ/A4hvyuhtHxIiBTdH2+HRJhDwaQA?=
 =?us-ascii?Q?MX+9PFw4ndd5rsoFYFEdN5fXkW+x60basD4pmSNjjkJ12aM/NsYjGMPwXafs?=
 =?us-ascii?Q?G0ECNSWlQxWGguoeKZW5SD2jssV/KjciZYU5p1gmMloZ5OzFo+yrC5u9itZs?=
 =?us-ascii?Q?xPBbJm3etqXwQ0UkvC2hl8qSVhxmwOLhsvUePQuTD4G8cgnopDRHd7SXjPUS?=
 =?us-ascii?Q?JGHEL7Uum9DSUFsYY36qQW4LAO/R9iiDonEZqP+ZgOFA0yVVssUS6rwbZ4cB?=
 =?us-ascii?Q?3KDamsdTLrjpAI96H4xXamRqWe8HCO9cxi/Fd0fQwkO5mjOIYFnj3RRiAxMa?=
 =?us-ascii?Q?c5zqjAGCjiNwYrbTt+n6UOW2dhE0qEK+f6tmOys1NCz2PlEWtpxWwobWnvtH?=
 =?us-ascii?Q?fP0vzej/CQR3cYREL+tOhxd+B0cYeSXr6RZjoW71vszGxDSPEQABWhZIhjFg?=
 =?us-ascii?Q?PmkXGvjTjEgrNCvQoqaOGPpS5NaioXHQaoEMPyUYr++QXYq8PGIXfyHBM+cG?=
 =?us-ascii?Q?XkL/1fuPUrSTufxO/8HCTXUEXQc4zNb4bIyaPS3S5HZpS/CqSEG1h81WoZqo?=
 =?us-ascii?Q?FwBbjphlCeMb4gFrSm6S9le9Yq3czMpBqr7xEt7VDNWc4jDHdwlx3C7BsnII?=
 =?us-ascii?Q?C/vkFydh/HNVFYq+oPRpJq7fBbUvjOtcaqrvFL6f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67242a78-fba4-4c5e-dc69-08dc9bd99f9c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 03:30:16.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW8Vz2E6GOOKD5FB/r1u8w37lflQU6gbO5KG7OBz3/ZTW4CNhv86I+3LnQzwqVttndsYBCs7eujDaUExizgkFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7082

With host mlme:
Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD
Without host mlme:
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # 88W8997-SD

This series add host based MLME support to the mwifiex driver, this
enables WPA3 support in both client and AP mode.
To enable WPA3, a firmware with corresponding V2 Key API support is
required.
The feature is currently only enabled on NXP IW416 (SD8978), and it
was internally validated by NXP QA team. Other NXP Wi-Fi chips
supported in current mwifiex are not affected by this change.

v11:
   - add proper and useful comment for mwifiex_cfg80211_probe_client().
   - modify 'mwifiex_mgmt_stypes' to allow multi-adapters with different
     setting of host_mlme_enbaled.

v10:
   - Use eth_broadcast_addr() to set the broadcast address.
   - Add comment for constant used for the length of FW special 4 address
     management header.
   - Check host_mlme_enabled to decide if creating host_mlme_workqueue
     or not.
   - Use cpu_to_le16 instead of casting via (__force __le16).
   - Change the abbreviation "disasso" to "disassoc" of the printout message.

v9:
   - Remove redundent code.
   - Remove unnecessary goto target.

v8:
   - Separate 6/12 from patch v7.
     As it's a bug fix not part of host MLME feature.
   - Rearrnage MLME feature into 2 patches:
     a. Add host based MLME support for STA mode.
     b. Add host based MLME support for AP mode.

v7:
   - Fix regression: Downlink throughput degraded by 70% in AP mode.
   - Fix issue: On STAUT, kernel Oops occurs when there is no association
     response from AP.
   - Fix issue: On STAUT, if AP leaves abruptly and deauth is missing,
     STA can't connect to AP anymore.
   - Fix regression: STA can't connect to AP when host_mlme is disabled
     (impact all chips).
   - Address reviewer comments.

v6:
   - Correct mailing sequence.

v5:
   - Add host base MLME support to enable WPA3 functionalities for both
     STA and AP mode.
   - This feature (WPA3) required a firmware with corresponding Key API V2
     support.
   - QA validation and regression have been covered for IW416.
   - This feature (WPA3) is currently enabled and verified only for IW416.
   - Changelogs since patch V4:
     a. Add WPA3 support for AP mode.
     b. Bug fix: In WPA3 STA mode, deice gets disconnected from AP
        when group rekey occurs.
     c. Bug fix: STAUT doesn't send WMM IE in association request when
        associate to a WMM-AP.

v4:
   - Refine code segment per review comment.
   - Add API to check firmware encryption key command version when
     host_mlme is enabled.

v3:
   - Cleanup commit message.

v2:
   - Fix checkpatch error (pwe[1] -> pwe[0]).
   - Move module parameter 'host_mlme' to mwifiex_sdio_device structure.
     Default only enable for IW416.
   - Disable advertising NL80211_FEATURE_SAE if host_mlme is not enabled.

David Lin (2):
  wifi: mwifiex: add host mlme for client mode
  wifi: mwifiex: add host mlme for AP mode

 .../net/wireless/marvell/mwifiex/cfg80211.c   | 404 +++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  27 ++
 drivers/net/wireless/marvell/mwifiex/decl.h   |  23 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  54 +++
 drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  66 ++-
 drivers/net/wireless/marvell/mwifiex/main.c   |  62 +++
 drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
 18 files changed, 992 insertions(+), 17 deletions(-)


base-commit: 347bf38330c2971230d8206eb8b37ed36b54982d
-- 
2.34.1


