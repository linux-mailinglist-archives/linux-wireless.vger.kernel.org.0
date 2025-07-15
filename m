Return-Path: <linux-wireless+bounces-25466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D65B059C5
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9DDD7A31E4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D8C2DA750;
	Tue, 15 Jul 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fl/3CTbZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012057.outbound.protection.outlook.com [40.107.75.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D63230BC8;
	Tue, 15 Jul 2025 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581862; cv=fail; b=pfOsDB7tTd33tFsbxrdvB+B8vci9LGsAD8YMEK3ky7COX7Q2wxuDZFxpEBePB7IKSfUG5pM1PwCJb8g8wPPWAzgLN5Vj3BItTmPOhaGz3Ffgq3h81oYpCzYZ6I37RqdvK2ToUgBfgZBWimwM5IRqbTJYRdw8lJNTHWcPJJOvIJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581862; c=relaxed/simple;
	bh=uXbhJiCgoT9EOrH2A1gObQS8BeTdSWh2lVStG/G5ybQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ghAhoK1Vm3zVXn61Qe8S2BOESkhlHJEgupVZjj3bI9AGZDE/01JggO8jW7Y+7FLtheFU89K84F5J0MPczlnuYreG5R8l0rU9gsRY4HX628NNH3swbqaZGOgTE8vysiDvGifaBHb/wDNNqc91DambljA5bELn9UZ83s1qryq542c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fl/3CTbZ; arc=fail smtp.client-ip=40.107.75.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1IwopWR+pgzIEMwN4hb6kwAq8g0NM35abtA/BU2zTp5mJ1/vblpmBVpJfjRmwqxjCz5f+xjoqOnC0BAXCC/CzBHyPHnjZgjFKY3Mig2Wb5S7XHzY+AKUfgQgw+v1Q+IEOfpb+Hpo1Se6YudufoaPAFP+w7ZtBXtbWFz4lEFXOUria44EXYgztVCxqhQDCpHGah2SBIA03lnpIY9CX/vym2wy52wzkKD8D3//e9CIUHZzkQk9FQIvHP473CmVVicoACGBFKjpH8lTVaEwODtoU4JI0J2j/2BJ8PwnLBEC+xy987anMyJXAAYlqfiri+BsQd3JWLy2maOh+ZYCmFEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7o+HHoj7SKLSWIretWnXilRuMB4fBonYiKVPq116Pg=;
 b=ZK62ifHrrCQ1JT6IozNhQLb12D5jbSURO+FLGYWsLvCHbDyWI8qvkxeWEf7+aHbZK+kckY1rVMPgUJ9pnDrgsGwqQrdgyS2Yvrl5BU9hDr7EizMKy6fhuWj92xODFno39toBSL0yVU4p8IKgDYHalwfxxvmkWI02vYKwdc7D/D2nmcuxixMKyk54wXG7Sax04LGW23GOg+pngSWbMKalGb/yBYJ+1ATNMfihhLazN90h1t4cZM4Us+IXM3JRddp/8xJNwLKGeArcC5m4is1zLuaFtfISKIWoffLQ1Tke/cX1xM8OpHh641Gi2xG/ISfx5gK4EM7SInJabBLvJiDnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7o+HHoj7SKLSWIretWnXilRuMB4fBonYiKVPq116Pg=;
 b=fl/3CTbZMgtCrVabwnQUq3sjRFWlJqhvKiaZUhcQL+SK2qqywfYgxfpY7Nl6FrOEc1pjhl2K/7xsT76Tna1A6wkoiK5dwghEwhn+lZIjuRglJUZmh0sPmN38SBdx7qvuIEN2DJ5MxOmZuldKtWbvJUio5aYK2PrNn0zgSZr+1GRifbRa+aN34YvrY83zBk1beKKHNxOV2NsLGaDn0TFRGjf77bNirsFbo6iUZgLIXJ6D1WyCdMdVWci6M2UDSoZ8ikuiQbA6vGEdajm5KzvYl6kSskBbAsajmXnKdJL4B7i+mddc/T2362Z5jlrpQ5rYNI9pvcSx3agHtd4NgjqS6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:17:36 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:17:36 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Lucas Sanchez Sagrado <lucsansag@gmail.com>,
	Philipp Hahn <phahn-oss@avm.de>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Hayes Wang <hayeswang@realtek.com>,
	Eric Biggers <ebiggers@google.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ondrej Jirman <megi@xff.cz>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	David Lin <yu-hao.lin@nxp.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Marek Vasut <marex@denx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS)
Subject: [PATCH v2 0/7] net: Use min()/max()/max_t() to improve code
Date: Tue, 15 Jul 2025 20:16:46 +0800
Message-Id: <20250715121721.266713-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cfcdb3-dae7-4c16-0abd-08ddc399956b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfdU4FZhxxonnCMJ1RcRDKpCbUTtQvoGZOKyB3v0gMEL1WWkjHh3GbpNUvGm?=
 =?us-ascii?Q?ZVcFWjwH9wvAgM/70Y0vsMd87Qjy7pKQtj2qb3sj+yDySBPDV0YRdKT+xOjN?=
 =?us-ascii?Q?HxbC185mgD39VaHViE2FtfqPACB1TGVf6kJmBNJOGV1Dq2BlBCvWOAOJUBTY?=
 =?us-ascii?Q?pPbTbCn9QOmcQ59nnzCMVGLkBGAL/VB6eYZJHbenmUGZmvJXsMfnr2C2m0me?=
 =?us-ascii?Q?CkKPJWoVI0AsHM0Uv4OG/su3BjImbO6DxAwnUY/I4b4Kb6o+/fGUTuRmbsoz?=
 =?us-ascii?Q?1nC2+7a9m4dU3MRZET65Liu+KDggtVTbvhEGW/cu0e7gcRSQgaQyQ/xUkBq6?=
 =?us-ascii?Q?0jZBZYovCUjJcQvKejnfv1hJzoJ2X87o3BK7T8EyhghLU9tPFiTMHu17BZuP?=
 =?us-ascii?Q?zzZ7doo0HE88XJaluTdqKwnMBkT7ffIFxSUq2/tvdER8WWCo+Mkwan09XKqv?=
 =?us-ascii?Q?aMhYFDTc8/OhAGECgRiGsfh3FkS2FIn5S9+coKaDSWYPAytaAyTDPaQTGpSk?=
 =?us-ascii?Q?mSYswwcqgJPVUdV6mVbe3k/GBNRBsgy+pKBbFXeUdmdMSHHL3PiFrnNxrGJ7?=
 =?us-ascii?Q?kzxfCI4m+2lvjKL4eG/02xVOGg8b7FSjA24eOUi+mdNAnc3eH8QWl/k7GWL0?=
 =?us-ascii?Q?jCF3/l1zYm2ZwvlsJpwJbzXnTDre6TQ5hhlMDuEaeD/kimCXQMKHMuKhqNrc?=
 =?us-ascii?Q?ZYeqgGYRz+FHVdBX+IdemkzX0YgzPviIx33Yqdg29oep+hsyZ+s1F3QVN2gA?=
 =?us-ascii?Q?qde3ytraWUq8iyKgUSohSsbRiymJ4mheR6qc/HhPktcHihLm1hmbslbzFewP?=
 =?us-ascii?Q?eBmEoEil8nDsiDKHiFvIg7lC45Aj7HeI0b4UgJinU9HzeR6kKA1Q/0WpRTi2?=
 =?us-ascii?Q?123ZeNEc6BeOtCrRVRqvS9HtQ1zjjwzO6t5M6bDnYg/k0UjQGjca2FVNjWhP?=
 =?us-ascii?Q?ALcyEPVDt/lEVKcNKzsr241GvU9i/OIzkt88q31WLVbeKq6SRWUyDm5oZxT6?=
 =?us-ascii?Q?pTT9FWDUeH35gvLXXJBTk+0caxwXoLClHdMfuzvdrZYgyc9NyG8duwwhgLxr?=
 =?us-ascii?Q?TwYTlkhsW+46xEoZq3iSdB+ZRfh5dc8T6BYuJIXpo5rpL9AlFWQ0j6RS4X4r?=
 =?us-ascii?Q?TGaD8NnambrqYRMtubgVu7ICg83VtpW/tIcZhwmwIQAtcSf1MIXpKCplsnf6?=
 =?us-ascii?Q?zPln5AzWeH+mwN3IISYSHmHrwxPpl6NGK9nrOQVpl1UlXr1p7pz0b0LKDPSf?=
 =?us-ascii?Q?9kn+iekfGpfUv7zLsODrvRDFdpRKcJcTpJvOIFLLescxQhJfDKu71+vmRTeE?=
 =?us-ascii?Q?KNj5vGhpUzHunSN5NTDrUepLE9VBPs/21X1OBblqR+kD0evuBST0Xs39gHZg?=
 =?us-ascii?Q?rhm+hFJqsHZd3SYyTY5q8kNv5EwHLs0fpPUxrh5Qi65yloRqPXyW8OMjzyOP?=
 =?us-ascii?Q?3UEp6TIrgQ66q4S8eqFekZY4v3TeY/zEE1NPmoI2w8OcaTcxGHd990LAHpox?=
 =?us-ascii?Q?wsZUziBgg8UQ/w4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFroBM2xmcgebBYxMA4i41n5EFeI0wLBUhqiBaW9P4nUQd9IqUHt4170+jbw?=
 =?us-ascii?Q?E3pMZOBFP8iyqYUKMjBuIpYFruYKYGN624/bUCTU8kZN/ALS9En280VObFOU?=
 =?us-ascii?Q?5OpSM7EQ5MivSEF/jegstljvhMHvH0e2YWdmc545zLBW39/Avs3Xh71vcnvT?=
 =?us-ascii?Q?r1iWu2GYl/hTVtja3aP2znUOys5kiVO60k54RnGSWLobN8caaneU+jozP51G?=
 =?us-ascii?Q?eXvMqnBzII5RmA74D5ahqZWEWIoXe5GoL1rP4miwVFc551V1U6UdicDSmIiz?=
 =?us-ascii?Q?CFxvt0rlARUMQUg7ONKirIKaJKjP7+acSbkt/fv9ep6uodNgxE9bLsTwkj2Q?=
 =?us-ascii?Q?UFQ03DFFN9KYy/ngjUETs91xFhHmHn6QzO5RSxZyZrc31pmkw1ex4XU3/u6X?=
 =?us-ascii?Q?QJWO0uf/K70dPxH/veaIIQLbnhuPXSx5aSFqWi9tkDEXIDTgOs+VVKXV4bne?=
 =?us-ascii?Q?IL98SLNEkJTZCuvn52vfq8mwhM4/+SoFT4M2jXxPZLq2Q7cYfItxDrqw9/Ek?=
 =?us-ascii?Q?ff6DKPy0U4DNVLBdKEG6fg9HbI/nN8A5cWxhWaDIz/8gkS2tAbDZmOOKGSqE?=
 =?us-ascii?Q?SWt1JsAvKloLLtzLcTQvrbDIRAmOC2ZJXtb++ceal/vD+4Zb+ViqMcuVM86t?=
 =?us-ascii?Q?LhOMjwo9TmaHNsgiRjFz/Z6+WB/kFWeo88nKK5mS11te9uJaZguvNu9tuF5M?=
 =?us-ascii?Q?9uc89w1axKJWnBkLMJpo5fqLGiIBu5+URFqsXdrTAA8FWW859pmGF+u+YqXq?=
 =?us-ascii?Q?mcPsstQ2o/4dKgkPy4eYbCRqFiqx3KKhOjSmuJ9OR7uAs7KdrkNlAhEOMQSa?=
 =?us-ascii?Q?mUHoae2H6U+y5j78xW/AwzFr+4STjn+Es/1HziAHEZXhVLrIu2vXsVOZjvg3?=
 =?us-ascii?Q?kH819lrP9Sn/m0VqpGAoLqM1DhLuyslR+fj8aUmdzpS/TeKKz5/NvEknleW/?=
 =?us-ascii?Q?C0jZneXlHI2YEQELTYYAy1nzFof9W0Ui6UALcuRsPlOkyXmilPPNXlqfxf9I?=
 =?us-ascii?Q?hec+1tT1sE3In1L/6XiM6dAS7CEz3MkcvjVQsn3MXIAs2A1dkw///74r1qLy?=
 =?us-ascii?Q?ZVoGXzkAeWynVmjq7w7b2Wtf5O7PvKmybgzDT+8Y0JIf556N/mIz6wz8aZ8S?=
 =?us-ascii?Q?WbwR2yCH4vs1yMtUAnuMdOdZ854/ut5oMrgttdp4AhNYDF6x0z9Wu86cvSrf?=
 =?us-ascii?Q?P5RKVOWCRG2XQy6q9/0XEehafB0P4aj8dAtompWyNZ6wWkzDkPpx482TBQRY?=
 =?us-ascii?Q?CvUExZMcdQhTFHlnvDrto262zNW77mKAKrEwpYUMRB8teIf+VC57Sizsu/AT?=
 =?us-ascii?Q?7bCGFOXJDcgfbOMUsaWEYwixvfPUgtXCCc5I7iodgc55Y3lIaGkBxTBPZbYP?=
 =?us-ascii?Q?9vKh+xcfzRQhex8xKw5E1mXHZCgm/OX4jUneqNhaaFDeMNmJ2pcssgBqiotd?=
 =?us-ascii?Q?b3sRC6gbAj/zvMLPf9PTWTSNWkTTVG6z0JbdO/saflPquB3jujlA1PZXL1TI?=
 =?us-ascii?Q?HwGfwfUOKTebGprhFdWloyf2ex2c5IVshA7rhtFBbgtPoUeiwGh8KjS3YT8J?=
 =?us-ascii?Q?Rrm7LTugGJsE2hDfbqI5g3Zvr3Jst9nn/w1lpck5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cfcdb3-dae7-4c16-0abd-08ddc399956b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:17:36.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guuZnhoP7KECYj8oag6b6HU6FzTmLlush2ksinnXjQmeLezf+RFnKADh15p9Z2kBoPGyJUzBnP5T2Y2WsJ8hOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use min()/max()/max_t() to reduce the code and improve its readability.

No functional changes.

Qianfeng Rong (7):
  net: usb: Use min() to improve code
  wifi: ath5k: Use max() to improve code
  wifi: ath9k: Use max() to improve code
  wifi: brcm80211: Use min() to improve code
  wifi: mwifiex: Use max_t() to improve code
  wifi: wilc1000: Use min() to improve code
  wifi: rtlwifi: Use min()/max() to improve code

 drivers/net/usb/r8152.c                       |  5 +----
 drivers/net/wireless/ath/ath5k/phy.c          | 12 +++---------
 drivers/net/wireless/ath/ath9k/dfs.c          |  5 +----
 .../broadcom/brcm80211/brcmfmac/usb.c         |  5 +----
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   |  6 ++----
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  7 +++----
 .../net/wireless/microchip/wilc1000/wlan.c    |  5 +----
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 19 +++----------------
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 17 +++--------------
 .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 15 +++------------
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |  5 +----
 13 files changed, 24 insertions(+), 87 deletions(-)

-- 
2.34.1


