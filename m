Return-Path: <linux-wireless+bounces-9481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5270191449C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 10:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FC81C210E1
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D24CB2B;
	Mon, 24 Jun 2024 08:24:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025173EA72;
	Mon, 24 Jun 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217449; cv=fail; b=R7EcRr4t2Zn5GQ35+NZ+ieQVdwkNARrwZzQ/RQO+RtGTqNmYPAUOPNX4YOT7ykr0RAsT4Kzk2vfC8fwaXkACmR3q7y9M2J20VqiRFH+w+NZnVP/sNWJBfX18WVcfvO6t/+Z9j6p2GsgC3v1oGhTm6XJanOgGFgKPEAQd4KgAn1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217449; c=relaxed/simple;
	bh=VOdonuoOdrk4MKDZNNvt1Bf1SSzBOLzWDsZOWVaQUKg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RSk3V0oyfbOkDX3ur1dCU2kz0ZCAVRB/lQ/P6bhMsw+Wf1YZ5MsQ8IHFekybXlOMryR/enpQyFgJDrLcGQTQbCzJORUAqaQWM8//R9A+YOICIY7S7/hrQE6VOsLHGWHESuW4+n0fs5xrD1hGt6r427P53UdBHiq/XBjxnKjwBe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu+cuUNlbW5W/u4PDXm1a3VMYoSnEK7OTF5yO3sJPYmQ2YVnKchfJ203M3dyL9l7I9PW9065dolsWSJiw8vTd6lNfDTXA8hvp6fMMUeT/TD7SMXGgsb4lStvap+SD0eeYN1C0qqcjrY0Z4hTuIaP3rJyVXY2zhOtpFwauMy8iFp6tZmNgq5sXVwOGhRmaZMnI9w/KJXeSHnOic3N9IeYA2Gx5IMMQu/Y8+v0W+3bn3M19xj5tLPzNhreaM7Oy3yhMQHrxMQQM8/GJH69/pSzYrLof4O0rDiH/5MeLV5ONkrEam2tZjRAMrQN2TYSMG+viacSk3JmjHLPg6tSNMfqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juuH8EBk+Tic8J+hbt5CFfXz8AqP6gSIfPkz/EGfhv4=;
 b=FWQwGzlGM0x5DGqzqQwEluJjMCrL255aAxiF2iho8gdlwNdkspAZ3no+QBB6ZEbhEOIjshPj9+rf4mtmC/dTO7lppiLtlOWNwgqU1D3y1HPgOKnxj9ENl84ab4EHHduyRezJhMg13t6+FYHQj7EIY0Zyi2vxBsY/2VU+grUWq+WbTa8pU2ice2KXeR3Rawzo8AvyO9G+xky//8kCytK8p3N60xnhh+zVy7cE8rSJpHi04MpuPiBjhLln4m5Tn+cbOTFnajYUImrK7ZNKz3yGb3Eg+PjAaFe6pB6oOCXRFZYjPdOCoZscMnErkvsLH9tg6TVAtean0HMXysjr3M2Nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by OSQPR03MB8600.apcprd03.prod.outlook.com (2603:1096:604:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 24 Jun
 2024 08:24:04 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:24:04 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	megi@xff.cz,
	robh@kernel.org,
	efectn@protonmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nick@khadas.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 0/5] Add AP6275P wireless support
Date: Mon, 24 Jun 2024 16:19:01 +0800
Message-Id: <20240624081906.1399447-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|OSQPR03MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 107295d6-c369-4a1f-0154-08dc94270232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?teDlZdTw37l6+Ns/2o/8VA+e/b40AcZZ+gkA23iJA7CDW4zDpYkYQJjcoqSL?=
 =?us-ascii?Q?6fD3g1kSf2A0c/MOAhEw5wez2uyqdHtX+YwfcX+iZ7A0SL8MyukVd7d691LK?=
 =?us-ascii?Q?aVNnN3RG2/ME0WTl+Q4eidwHSCRsQx55KSbXNGmTA6J0LCbj6c/QvJ26/SDa?=
 =?us-ascii?Q?Xj9E55ivSq9mfMVgu+wpxqKz9xOknCqV4AiswICHsJSvjEA4oy8a5vpEtuxn?=
 =?us-ascii?Q?1x2MyDTpuuIM2noEO+1sySueZBSveaJB35pPPYiZ7wcD/h7c1Vq4MgQ58Nvg?=
 =?us-ascii?Q?RB9qA4roRT/8TCoOP8hMbQ/nDbwuxEs+p4fZY+Bssum1RCUvr52v/qYaKkDU?=
 =?us-ascii?Q?+7CcpyjUDC6esqR8/A4CSysY3T0klw6ayqBStppU6MuZYYKVAj6tTnAq9UPg?=
 =?us-ascii?Q?uIMknpA+PsP6hfyIcGPrUIySzFdSpENFgM6KoDLHVKl72WrckOi+K/W1S52y?=
 =?us-ascii?Q?Jjx365t9G7vdTLLRZojf5e+0fQisRa3bMgVRxTu0Dv96dIiIP97DHoqT7ozp?=
 =?us-ascii?Q?NaO+jQgMNJEm0rNDBEqVSB8XRWNLYraAwXZXozNVLxziE0oi9ibPUnrivGtf?=
 =?us-ascii?Q?SKJKnzKBIfeWDKZyDDvQ44tbYBJDYTRfl+0ARFYJto1j2i1K/AblaBaQw9Sr?=
 =?us-ascii?Q?Br+4af/W4U9sp4Bz44qHjLNH5JQb0MID/qzhBpS6He4EFiJh5A+gaByC0ksq?=
 =?us-ascii?Q?cNbM4fqiQ0QzHsK1Y36TWYXWSS74DhARZ/aol3JG6C/JFZZu7RTfe7/oiE5z?=
 =?us-ascii?Q?AbZjoYOEaQE49CTwnbvuPocGHXzLkRctEdRbAsAlpwGXH8xtV8YHaBoO60kk?=
 =?us-ascii?Q?q6IzsQr+EJ2Q3frerCq92O6JHWvZicLHbnH5hwK6oC/hLtKlbNQYQeJoHF1U?=
 =?us-ascii?Q?bUaWf+qb38WSfy0CjHNAcx5ipC9NCS9jhzA/qP3jMug3EP0z4q/7bVFdFnLi?=
 =?us-ascii?Q?0iblNUembwbPcgLjMI3MJFmsNjmVgeKxXN2Z1UhVlJwak4BgHUdxnfEI8CEb?=
 =?us-ascii?Q?COGRK7G4ZmJrJTNdfFhtioDRPa3B6AZ9mTb12AEYtp7k2ILa5njFfRz52/EL?=
 =?us-ascii?Q?Sg2YA4FMB4gJmQJjYLhfWRr1mvhELsbmdZQ39B2iZyvjsk3bQpNItTBZWKGZ?=
 =?us-ascii?Q?w7Am/dSsNnv3NOyZRQ/SFW/duqg4Zed4FaEttKMgEnhNn3zSavOJE/JDMlcP?=
 =?us-ascii?Q?jfXYaba8eab6k2Pk7bqsMexlhYppUiDUdwjr/hGI1s7eljfBr6eZOAxvZtYl?=
 =?us-ascii?Q?FuLjrtxh2j49vc7kkqiHFnP2wjjpRhxMjgP6UGo4+HW0q74M5eU/XLTtjHwe?=
 =?us-ascii?Q?HGKeo0mqA+IsfWJ9iFeJtrGh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8imPsVDQlyY3wUJWHH/ZtGUMWO9CHl2hM3YDutZKaLqrf7RB1VOSvvoQVke?=
 =?us-ascii?Q?4GCOHzkyQ5NgyZZhavY3WniGYN2y3Cg60VAFGyyXZmsUKeyQHtlBfot6p004?=
 =?us-ascii?Q?Nn0h6ZwE43808VhPVZjn/+J1bwsaR4NlXAtas59FgrTEXCPC09cf1Iuqt/K7?=
 =?us-ascii?Q?W5hem4C9F6OOqBScwJSpONgIiqXZZT7zX4BIqXXiquLmF7c/SvkLApG5OL2A?=
 =?us-ascii?Q?AQyAuJxiSxzbiSj15gD89kUuHGhE1RpkJvUtng1za9Xjraup43YVbqxrnIVA?=
 =?us-ascii?Q?5oUjhizK9gw5aPpu4t7XMRalfJBAJ7GfEjofH/IaiWhvR74zuM8Qvdqz+f3B?=
 =?us-ascii?Q?9rkJ23zoWD4vnqspHIfVfh+26GaSmqm2KS4EJxJuS/8LNTkEG83nshpmqx9N?=
 =?us-ascii?Q?uKxSE8jGbv/MP4JZg+Nqb8izqWm3GbcVJBerof785PGnLJ6GPaFyE527/bB1?=
 =?us-ascii?Q?KCuZXfNcE67JdztdUET65k8K2umASeXdQEa3/io9rln6tnG9X1iumXcEF+mw?=
 =?us-ascii?Q?IifhRxpnaelE9WPJz818ciQt27ojmwBoXQ7el57s2KpuXBobRvw1d46P9Hgk?=
 =?us-ascii?Q?jJ5LxAXzHgXNglNHQBthOKO2f/WA6BEBsj+Z15Npyp0JJjgslg133VH7XUWE?=
 =?us-ascii?Q?Y4cPTd5VHkqmOZ8lL9rlkqZEKtCEZG+dwrc6Rj/Pu+50ZjeYAvw56DxDywd6?=
 =?us-ascii?Q?APmTUYl5mYdaZSzw4Stbmv0EVAoNzlM6eHpKJa025Ho9B0Jt1X5BeXTDMbIR?=
 =?us-ascii?Q?TsYWBDOrOivL2eZ0ALozE1z7z+LUSFD0LEjOE+Qo4upeMFvzwKhQDaEo2xZN?=
 =?us-ascii?Q?kK3ARoB3QHXJLCZ3oQGRsNYjM4BZOXdFyKVlWz/NrsLiq6T/w3sNkvbgB+n2?=
 =?us-ascii?Q?PgubSsn6T83mghuZPO48iJdKN2PyGHHRw/5V4mboEwIVPa8e04UWM3IBURsQ?=
 =?us-ascii?Q?Ra56hTTGRHzisTwF89jFRoOKblcv+gLCqZo6y9hsB+IktZ8DyR3k39gTpz/O?=
 =?us-ascii?Q?TxOmVy83CuUytj+M3gHvFadw5PPf037YOp3WeVS3xdSO13ddIGgPHXm3tVx0?=
 =?us-ascii?Q?cwRZMWyxL4IIpzUuLYTj776wSAhX9/8wmB43Hz6Tj9Wqyey+qXnJ/B6eolNi?=
 =?us-ascii?Q?jVGMEC1wW7NOIZ5SYTeU3BgICFd0zD8sdg5P8Jgy0SyWAxiZ/NDAWQ/PDLk3?=
 =?us-ascii?Q?70/455MzVb4bWCoKnUyCcnoMfUOQwxzRYYyvbowcEhrPf82k4yQAABvRWGx5?=
 =?us-ascii?Q?DbJY+zRQRXQeTFU+ZlG9SmhSh/oj4/A1+jyvt6JhWvfA5SVVBG2H7DZ8Vcm1?=
 =?us-ascii?Q?QrE7OltcFd1e38UUne8dabGmx/rz598QJNhcWfiQ9ckOgSi4lgRL+FWD6JVI?=
 =?us-ascii?Q?rSLWcE5DMyBiEfS0FzpAu4x8lsEx2d+ba+jzKcohe58pybiV5DYoYXgesvjb?=
 =?us-ascii?Q?3yO0OtQsZ+p9HLwj6aiFkZ2aHwa7WLjnW+jXHiGbzP2cuF1WBhw1ReRzWETC?=
 =?us-ascii?Q?328ZK/D8Re8NWHBOisL8YVE/wj0WWtCqNl057oELhH7Lia4E6CXVf3/VKDhf?=
 =?us-ascii?Q?npS+/W5XQEVsAN74LoBWhSLffM8BDnqIpLqayVP+?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107295d6-c369-4a1f-0154-08dc94270232
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:24:04.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZnNziaWusU6gYyaOrco5uChT/HppKa3swgKajHa12BTYnqxlczCsJxu12Jm2tWiFK031ma2hng14HQOqRCEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8600

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock 
for Wi-Fi module and extend the hardware IDs table in the brcmfmac 
driver for it to attach.

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

Jacobe Zang (5):
  arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
  net: wireless: brcmfmac: Add optional 32k clock enable support
  net: wireless: brcmfmac: Add support for AP6275P
  dt-bindings: net: wireless: brcm4329-fmac: add clock description.
  dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml | 10 ++++++++++
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c  | 15 ++++++++++++++-
 .../broadcom/brcm80211/include/brcm_hw_ids.h     |  2 ++
 4 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.34.1


