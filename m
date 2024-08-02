Return-Path: <linux-wireless+bounces-10849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B342594566F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 04:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFF51C22677
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 02:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E06E5FD;
	Fri,  2 Aug 2024 02:57:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F561FFA;
	Fri,  2 Aug 2024 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567465; cv=fail; b=I/JC7sAu42uWu5G2eo2Gyqiy+15mcJk0dGPfUaNzc1lOsq5rifWLgExhPaGZEoCI1l93jvRckAt4n/APAG3CmVOFlDIGgw8nnSWtiZY+HkSvLZE0zcmFfWSI/VtGMQbltAG10TIS6o5xJlz2RFA7M6o6g3jD4LBnu90xnOIF95c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567465; c=relaxed/simple;
	bh=GVTEwqkQQ/mPTllUAS6ubbQuZTJUz6o8kitGbrIiKE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTfAXrGOwWSfWIDvPGiFq5tJ8XlnRPs0lq/UsunaH719QW1lsj+WqYTlqaiTqV8CwYwj2jWmxXs6kXDYC6g8cktAHYEvNQIm6JC78vjC0GgG5CXzhAilpUKzg3kL1Dve0n13WJkxQdwsO7WlZnQUqPpoH01KWjV0VAAlCRTqgcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXgMtcavp8MnxqujSpC9y3gNZ71v7Xt0nrVDrRCkxDVb0qstI2mRixkPaFZaFRwzgPziV7gt0n6D3C5jGmlRWMBz8BERBAUBpM0m9D1IEiYdPX8W+Qw0NBgqc4p3xtQXoAYAqfMT+vYm75ByKC0SXXyblJxX63KEOTQsXsVvOK9ZN5522YHtvKn86Dl5ADLyWk762tsSSrfn+rFTnIyrbUVisfVRxyep1h5qXQkAcOOKTCDCDx8NUTDSQQ8sIMz8ODwOo14acPu391Mltwx29ZYiX3Zqu3Imj0bkMxUaeXS9zwQZqPjtycPW9SxtnYx8POZtscBN/wwRp0OYRP3uLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TnsJEftwBYRJiEemJReSfUR5plTkSfIwo0syi9FhOw=;
 b=Shh0JZlV9OHyBtMEYQ4NsvwVLtFp0M2CGyQCWmgGbuyzl73+10hoNtHbh63lqCaGLNXv0/20/EGkFQvFWaZr0ucXX75q/pns6l939Dt/27W1orYnAnzfSvylb1YJ+B8qco4pQwh89OPeuOtx2nQLFq+1MEUkAV2Q7L+soHQ9U4kOXO4MnsMNk127yp8o28v4XZBNx4/i7mWWnMS3KKE8PKE2UuR6A6MrRJvuE5lUSDBeDrdNDL9JddkjEjSns4tMiGHcWoLWTd57/mSsgpp6a90lPjtPia5h8APJTUT1l04wcnWsFbQjKeHSVh+Fy0ZctI27dBogoIaK/irTn+NDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7120.apcprd03.prod.outlook.com (2603:1096:101:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 02:57:41 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 02:57:41 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	arend.vanspriel@broadcom.com
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v7 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Fri,  2 Aug 2024 10:57:13 +0800
Message-Id: <20240802025715.2360456-4-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802025715.2360456-1-jacobe.zang@wesion.com>
References: <20240802025715.2360456-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c3d5e5-0b2b-436f-b128-08dcb29edfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7HuVLuBoWFxcEtQhWNlyeWVpT81UPEwLrWWPvoowZyOXLp68234U1UVAbBJK?=
 =?us-ascii?Q?s0y/p2xcuJEiouT4G74sYFy42PQf670oBxgQXTTHrdPf+TugPbfQvndRcPQq?=
 =?us-ascii?Q?KrTbw623t7HQK9PD1c9PHyfRQOz+yWxYlut2wA0WGGdUtYNC4pIpEkPfng4d?=
 =?us-ascii?Q?UI3YKAA1WwPZkEvpmff0o4mNJvfWNvPAaOh9rc07B+dSpXo+yGh9jBhkCqhY?=
 =?us-ascii?Q?tYm2hOodEX3fMP7kgzcR8iA0kuqRDlYsqnxWXvSQ0ZrRDWyY++Z0yq0NJDzh?=
 =?us-ascii?Q?bfdKO5tXwOf9bePV0BXhUE0gy4hS+T8zPQq0wRK3S+uCem9kgDZAFP9oqNsQ?=
 =?us-ascii?Q?KVItGzEOjZpQ4fIrBoEkDv3wsFMnPYagqwBwK4HEDb+4XxVa2bv9wlhUg5dT?=
 =?us-ascii?Q?qNNlbNQfjqpYxAge17gf9cMwqaCTAnkXHzyyXtZbDdxEe3seXCKnIlTDFjjf?=
 =?us-ascii?Q?J9xca51Sy4YngM6NyuaXxoV/4zzTIdKGP1eKT7p0dIjyPHOIeJAG36qezWDq?=
 =?us-ascii?Q?oJzJbmNsffCkRmsetnF2Z6vHbE5icyLtm0XGJBbVGImOoWVNq76pKIBdGjd+?=
 =?us-ascii?Q?qE5vvrf6IUEF8k2JakdGVdlyc+g/hwRmrDZj1wln8+u9tMsDbqKB1KgiJhhW?=
 =?us-ascii?Q?Ss0+QqbmPxftFvrX90R7MGfMgCokbueGzgQVEeJxYp+d5tzLHssJzFiSgHkC?=
 =?us-ascii?Q?KgHU8Kq4qBTlW00wQgB4GHAwJDV/D660rSGHLM79FcXxsE317Y8PYjIc7xuR?=
 =?us-ascii?Q?MheI/HJBwRXvQtGClkPe9VcqU5dliVSP+GdsQrfv4EL/BEyaNott3Sd+WaZz?=
 =?us-ascii?Q?Q712M2YN2pynzmDMMGcbJGtHic3qtK9STR6w8lV2b3nbFS+yLP6vYiBmO+GZ?=
 =?us-ascii?Q?mXUdnld1fjcPj/CY7Ast90g7BVqFLPAVZBavPxHGfBrZB9XpuutU1JscAmNJ?=
 =?us-ascii?Q?0bnM3MDnHKpD3hvGjVLalR/nOEip9my6ru4SvgE/rjT09FgUce3Y0HX1CL9q?=
 =?us-ascii?Q?BXi2dsLURTutEi3aenkvJoRfDNYhA3G/ME5XKP7nm1RWykk+q4wWPBPmFsMz?=
 =?us-ascii?Q?ZhoG/lnzzKPyZlKTKAZ8MMQZdtlsZ8OIoqGBd4njpl9QCshsom0EwL20sL25?=
 =?us-ascii?Q?HnSbmCQtkGtq1YIkEde2bDQkfdZKa8mHF4ELl47my+RwPLdf8DHtSvnXpa+z?=
 =?us-ascii?Q?sWj6NLzSvcDxc2RSSar8S5vNG+t+bMtEHbDMtblo15o+Z7Pyi+G1wfLN1ulR?=
 =?us-ascii?Q?MUV+Q+Ctf1ybRjTBRuE1TSN7YqpNd8hrHwHn7wY7lBaPIPAoYTaeQndGIHyD?=
 =?us-ascii?Q?T1vGYlLaDadSUjssQsQp4lnQjzvaC7O5+Ih6GMqUd7UZFtZPcWNHEAOUv+7o?=
 =?us-ascii?Q?NdGvPa7PdWjxERcWVGL+V1/B+ZOz1NwC/GScAPcvE+eYvVAQ0mqs0fRT3WKG?=
 =?us-ascii?Q?rXXHmZw2IuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPVkRU1bYPiiAZ3ngw3MCUsSw3r6IQxl8tFSdxXXoiimblhccD2a8jgNnDBZ?=
 =?us-ascii?Q?VnWOCUJwliiUm8mdQzVcabUVWx/oljb8bO+70RYHeDJkaKpr5o0tkatSZl1q?=
 =?us-ascii?Q?jp2FUuAW2lhgeJ94u98RRej8drQVAs766ndon3BrPXVdqDLUx4Gvj75IP071?=
 =?us-ascii?Q?9YBuXhDMukIFSnM1nA+rItWxTQPFAl70zyQusSzDgPSRim3ZM38tRRbMzjFi?=
 =?us-ascii?Q?zBPL7fDwpf9lP2t8RHnXYSwIujpsu0q4kqYTZ4ADcvYTywQuXnvwSG6MO3Xj?=
 =?us-ascii?Q?94TpmDbsZrpWoTGbw5+qfifxmvhEsq5Hdh7xSVPVEi89yDoJYoFUfun1wHIK?=
 =?us-ascii?Q?mt4IXtNeonWvPgTrCH8E7RU+RSZ/mUo2B0GXLB/uC3YRReLi1T++nCBUT3+2?=
 =?us-ascii?Q?ln9zfhEJQ5vbPs79l7b7O+pH/TkL7xM5rLCQSO3Q++S02HAecbLWzGwl3jC3?=
 =?us-ascii?Q?2QQQ8Br6QcF7yg1988SHApgHj+uZwGHgQgDtl78+hnk+pzS8cHWJAmdRqCfP?=
 =?us-ascii?Q?GJcyYTXZ2/L2fR+h9WaYxT0Wghn+037fOQ9Co+jEpMXOpD+yIAUprmLvfw3p?=
 =?us-ascii?Q?o8p2H9dWqKxiqQRP+NGoHngLf8tOVTZUlWUEaUEyAkKqERJDVRTwxfERSWwm?=
 =?us-ascii?Q?+umOQHth0OljbIvUlGBV7Mo9+g9AyBNjlFr+hEh6RNABT1Ua0PpyE0qQn0WB?=
 =?us-ascii?Q?CaCxXpZO22LkmNDHq7y9JpXeFWB7sIBIi46wUG7jklbXpbbjfADAUfa0MjwN?=
 =?us-ascii?Q?wlq3T+5e9O4eG1/q5HCSu1SCk5FL1RNC/YI64P8wYI9yMRJptsz0qxWbttiX?=
 =?us-ascii?Q?iPZWtgGIaz0xIHHO6rlY2gqSYu2ocq35ge5jzzoGpqUs2fDJfFFyQPm4tYdG?=
 =?us-ascii?Q?Q3bI4OmwzTZW6xTyYrONzbS2hu4EM0D50nqTSZ5CPvD+WZ1/XNkbYV+jvmux?=
 =?us-ascii?Q?ajVYiS3lwiMwB3085rjRfnEw539Ffs+LcI4dJeCAmWUC6ILZM6oJtTmc/h9M?=
 =?us-ascii?Q?mSqSZtt3+cL1v5REt3fNK7zBwOxTPfzVCEuJG5NlndHrTnjfXxyXjES8Y6lE?=
 =?us-ascii?Q?2YhWhhC+l4KTSgY++Y+Eb27iTlRIpHva9SyIZ3k0sOo99yU4FirDfN+WBTKs?=
 =?us-ascii?Q?3DLfCa4qOvVTyXH2kLiWheW4Rht1YahIDHsYhX6CtAQWIlZaUHL/0L58U4JI?=
 =?us-ascii?Q?nxPcVy/4KNUwQC7wEIrWD0TPUBvRlc16kjDw1KvwvS6CBrl+O4WpnonTP8pk?=
 =?us-ascii?Q?z7sgs6fFSHdTD7y5S1QKXTwfIJo8idEcBoB5YneMsqfEB5sqpnSMxPtuOnbT?=
 =?us-ascii?Q?Q+lQzMRUeAj61XdZLC7Z/Xd0237iA9B6VdFPKHWaMdHRBbpHYsyj1UpTEwPA?=
 =?us-ascii?Q?7L5/V9m/zTkMWNjpHG3RBmDePh4B+gla6tFMK7WFOHFnyKBcnqp4eIZNtUaB?=
 =?us-ascii?Q?EPPRSrCwPgM8/eTJ7D9pRDmCV78UAjpcdpmXOL149Tp6BUApBkGl5eqSet7U?=
 =?us-ascii?Q?i1KQOIqawuEIBDpvfc3Z8TCk4c8U5wifC3taSsdx2TG0F92yAempeoCZM7CS?=
 =?us-ascii?Q?oT3N/iNyQaHcQ+GCLTrZp9dM4SVBqGa+Nj8btSau?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c3d5e5-0b2b-436f-b128-08dcb29edfd0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 02:57:41.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvgwC8OGTeYSIVuicZo56wY3hPWwzpTLS+aFujSpANCAw2CMtEzWFkCjEjMojrfwu9QhjWRoLxEh2CisyxdG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7120

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
Change-Id: Id9ec7338a8e86ca8a404058d29af50dbc00df3b1
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..a3361ca25867d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,22 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		wifi: wifi@0,0 {
+			compatible = "brcm,bcm4329-fmac", "pci14e4,449d";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {
-- 
2.34.1


