Return-Path: <linux-wireless+bounces-24946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BAAFCCCB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040A9188266F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC12DF3C6;
	Tue,  8 Jul 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jpJrdDg0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013033.outbound.protection.outlook.com [52.101.127.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD52DECC0;
	Tue,  8 Jul 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983053; cv=fail; b=rdDs2DG+hjjgxExs5Nsk1FU4UbDFmFfEr0kxvwzHcmxZ0n2vbyI8nWLPgWGVCZqzaCZGYwnHI6EBiG9cS2rtQppuDbCQTtJDvo4BscyIql70PS+5Ux9Ac8JGriIhEcB86XcUQGbjKJ7YjFrpyAKgCMU/+p037AswtM1o7E/fnPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983053; c=relaxed/simple;
	bh=pYIMzHDMltfZEc8CNInYclvhe/7NGQU13xQqycFc1IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LS7AxO7U1YPmwRt/pAs1lS5bZaoxJYBhj6qCKs72CYrvOtyd1r5l3aFIdnFD6S62hIUYfmDbtwcnFBQJsWDZU4/Lvv2JjQmQ5o7nRNfXLcqY+sFaSj8I2c1D+wgo82coLTp8Ogpd3rU1RejPCYlkKyVLkrQwDscxCa7dDH68ZU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jpJrdDg0; arc=fail smtp.client-ip=52.101.127.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGPyqGqxL4PQfdlp8k3fOY0J/i64K+Ng0sj5VgOEiztjvn5V5JYHt7eYTnuVfSeK8I+ViK9OMJbcKymOIWLNpg0M/SagAwqzroRyY5sHvj3OBl0RmIZlUya1Ot2lxf+SwZE5auZiuUFy+C6GGtWf7dMUiQm7AbldfCnouJjJSjpGoXkh39jZAmWsuO5CMhb1De8COzk/MCv7EDTM4uLsk0h165an3DNPgW/UlVD7wYD4FarV7Ykn15CIHkgCZyN0HtHSEE68drXr7EYFjRZ6dMblk7Zx/7dzYc8qyg3wnvV5W4WBGNmGejUbWHtTsrj6W6oT1TFMKpV8daeNbOxAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVUh5mvshvpSYjUbfWxqJmucQsLz4xeX625qVq2SfI4=;
 b=LsAYgg6+kmABjMFmGtvq/T5Bo5LJ/1XE0C3CBdcJyjAK2bTZmiQSGBwMM/tykB32C0L+3cLmr3AkYJwAyVKSAVeh3ZElYQ4cLrMkizlpXP5yiCyoipB7fce3GOj85/NCx8CqO4Fe0KR+9r4s7juYNXEkMho4O+vKkCswRtmr7aqwX0JDJ5lzC7ScgzJWvI/tTG9l0gcA/7kfpqViUCkFxWgmgpNOLQbiSdREZtx8Jtv6TYN/f4xbGUI5a5n70iqC7Y6rOnhvHGFvpROApmo56WKr2BHv0rqfdvWeT7DfzJHnLGzMWGSbCpakZpbV4wcAIsC2NcI5ntBjBC+vrAQwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVUh5mvshvpSYjUbfWxqJmucQsLz4xeX625qVq2SfI4=;
 b=jpJrdDg0Os6zjBhfx2eFufLduNRxa6RjGQ3nai6Mu8cX2Gbhg+NbDGCuSQYgpmoFHycdF97YLnp34HiTVuS5JH64vmaU2Ha4WL/dgxJ5JYfXMWsau2U1cVKT59fgxqalCWMx12Pj6IYgm4tNFDMyT3n935aWcNTekrA0I/wOvhPGSaMZdo/FaEc1V8CeYy0SQ3kQSZvBNJ+TjrZk6JblRsGMjVYhAkaTfgNau4iiVgbRQkzqra5cDvlAc+xdwyqhZ2PiGp+oBrAV7EWs51LmxCkNABtWGwfeB0C8ATcXT4vehfock5xZ9Od8JANojIlsyM3K6T3tCaUnqmmlyW20BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5210.apcprd06.prod.outlook.com (2603:1096:400:21c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Tue, 8 Jul 2025 13:57:27 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 8 Jul 2025
 13:57:27 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Louis Peens <louis.peens@corigine.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Benjamin=20Gro=C3=9Fe?= <ste3ls@gmail.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Lucas Sanchez Sagrado <lucsansag@gmail.com>,
	Philipp Hahn <phahn-oss@avm.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Eric Biggers <ebiggers@google.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ondrej Jirman <megi@xff.cz>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Kalle Valo <kvalo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	David Lin <yu-hao.lin@nxp.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: opensource.kernel@vivo.com
Subject: [PATCH 00/12] net: Use min()/max() to improve code
Date: Tue,  8 Jul 2025 21:55:50 +0800
Message-Id: <20250708135632.152673-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 83202283-e373-47c5-eea6-08ddbe275f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09pnjsXKMmELUh8HY4I6f3n1Tdi7041DCGYFeGTlC+5OKKVKOnnlBU6NYED3?=
 =?us-ascii?Q?u26Ld4ADSvdlkyvDGNTLEkAHF/WQ3u4Mflvz/h+LXXoUfi13sZQ/fZkOa2ae?=
 =?us-ascii?Q?WM+CKIjkvNBytvD/gBYSdgMXzMODM28j8Imc5NMHyJ2rS2qH4biH84cLwy4K?=
 =?us-ascii?Q?VBDgRzKfFp8i68J8a1FyEDj25ERh8wyB/o4NFr8LCbuK8unaOHHmEc2FFxyH?=
 =?us-ascii?Q?hhtpwMiqu1jDeOSRnmdPYXjVZDvdrbF+mZ137YOMK070XTWmNQEW0XNRv0Uh?=
 =?us-ascii?Q?/8/YXAgKKqsCU+/E61tJD5VHb8HBrrilW8n0e0+bw4GmQ+fPgHvDxpw1PWhF?=
 =?us-ascii?Q?h6b7bhMpevMB6hAlYzyXXjc/d8QGs5ehnviTzh0KE57iYB0iLzUOmFFz3Mb9?=
 =?us-ascii?Q?rr68TDk92BbDSrwVGHIIJPqjpsDvGfAnSDuKV83Ym3/S9Unwn3oqaLY45umL?=
 =?us-ascii?Q?48eQGgMmtQLflhXEWmFEb4jLmyuuo+3Q2bAvufAp5vMuQDNoUv9cmPDUygkb?=
 =?us-ascii?Q?VpYSRcnmPqBjev2Q+FZfUfeJhIq7TsLHAsz1UeqDHl7d1jFxJ5uDcBT4lRR5?=
 =?us-ascii?Q?2nDXviD5OxuCvjdxE2cShQ6x2uCfbbMVM6z+To67pJjM+8cFmnPc7dgxemlW?=
 =?us-ascii?Q?U0oqZdb4sq6bYjh3/gPxFry9H3BXZn/LavU0iXu95u9JTADDzeI3wSLihyd9?=
 =?us-ascii?Q?6+aoZhAyKyKRDoVt6RAlZDqoriDVozjOfHXSRtjSHuEGa9g0Rq3wjfgOD1Jn?=
 =?us-ascii?Q?NruyioLIpptvDnNnnm8j3POeV+iVD09oC/eoRR/nvdzmvEaJyHWw+n3Abbj6?=
 =?us-ascii?Q?FFE+c72vp3aj4U8t88dj4+UFZysbcxEo/nHCH1Dy3DMBLhqyyfPWmwRBu0pp?=
 =?us-ascii?Q?lrh5xOV+ZRU3Tt0tTzezbb6nFD4cpvhbVKtKW0Je59a/eOAVgWTlP5S9cb64?=
 =?us-ascii?Q?nzS8JmQ8gbGwXPNNMmBE8u5smYWBAJEG107YhiaanQSAOxeR/LkAT5UdX1CE?=
 =?us-ascii?Q?JipL7w7quKicbsl0ctkxVwLiuNjV6LVuXM75ldFFQajsogXfOURU21lezVO/?=
 =?us-ascii?Q?kyqSSL7ABqDZlY1O0NwlOLxlv0cXQ1qbE5a/Z2kOfPhUiPyzXN/7YrE5fxbo?=
 =?us-ascii?Q?qVvosj0QNmxVyMHV5eeP4gr4whVC+ck/ltM2qK68NHwZ3VS0fb60L2Wammzw?=
 =?us-ascii?Q?FZ/enEh7kV8TdTYJiadsGIFbAzxtUw/qhJSD2+6erBDXU5QyJxv8VrWJnbZb?=
 =?us-ascii?Q?PJyFDt0mxe32eRxTKWf7KGF8/Zfiq5UPMy6uA3tHE8p0gwug8dUhefOD+BJ6?=
 =?us-ascii?Q?a3a0yTdSYlmVX0uXzhD/OvTzMrGCa38L4IjYbogic1Sap/hRf0pEzupzyPex?=
 =?us-ascii?Q?K7acgzRVee/AzMfhzQZoaBIqvE5wIRU6J3Zeay6So1yorXDQU+0O4sIM2wYU?=
 =?us-ascii?Q?bVyMbI9cz2VCDnO+yyUEfGY93nBxai90bMSeKuv20BtXaQwx8HPznGdjpRqY?=
 =?us-ascii?Q?wRnGlxUh5YQImZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVlRgE4J2UeD+vBs+kf79rcq4/QWauvNOvcVDjlia9iyGPlcptautCxuEgaT?=
 =?us-ascii?Q?Ws4FwNlopWVjaB9LHqpwy8+iNmrJvO69qnR5mXqy0hhlGncquOjpEMW7DxDb?=
 =?us-ascii?Q?LXcj0/TTPmruQ3R7rZzLN9lQXuhMkNEX9EiAFpopSeZeC5RYFarTBew8df/p?=
 =?us-ascii?Q?+SQG4CC80MOgWUy/gMIuPorlXxUcvKLDHabRtaLFinu2RWrLN4sCDfLhQsNQ?=
 =?us-ascii?Q?bmqWgrPdsCXW7ksRgjn5RgqB64dHuBRrNoT30TkKVs97dZCioz67CMHJ2kQH?=
 =?us-ascii?Q?pC/nUzAIVq62zqg/U3qdmExLj6dmqrixf3hnWyRdtIzqo59SyXpWUTNTCTqr?=
 =?us-ascii?Q?tL6PBYe8D2td0sW7tHU7b6DgvCKW0O4UONyOTEMPCb8SH3mypxMEYWDnpSqr?=
 =?us-ascii?Q?MCX2RPD1+kSgzXkJLcaeaY/P8dwfxHg4bPo6iEBTMvV6IZkS2Nc7cfDLdHUs?=
 =?us-ascii?Q?rJaoeh8oFYtuTb3OcPRiEifyr9TKxElCZk0Zc8ezDQkRZ37xZ2OnYw+doGVu?=
 =?us-ascii?Q?j7cuw6gA1IK0lZIwkk3+Sho8vWwVYa4q94fjhdGKeH2E5HOz8oM+phTKMOaY?=
 =?us-ascii?Q?VSdSW+A1jJhlzrrm28GPztHUH+vSAi7C9tMRBQcK/ci9sTALRDLZnT/0LlqK?=
 =?us-ascii?Q?56Blj3tvP3RMWgd19RJZgkoyWqWvd2Zo3OZo8Ucmku4hdvgvYLNwHttBhdhh?=
 =?us-ascii?Q?fzJ+2XlE6PsJuqoqYS3C0MWBzCsXOSCW9UkD0/o59r7tVIuXuTEl13iO3rzh?=
 =?us-ascii?Q?6poPi91OYNdt4mLOoQV3p4Llu1ulOjX+Fz7ZHLfAvRhaJ9nsBLtDuy4HzUNV?=
 =?us-ascii?Q?b+Z7FlHPHlFidNdRYx/MKMBXTaB9Sfh+aNMybjzD4KeFIvD2Kl1UJ4HQxAez?=
 =?us-ascii?Q?dRJCfDa1v3o58i7R6eei22sMD+nBJbzI/piQQcXVwVKWImImDKH//P666nMC?=
 =?us-ascii?Q?cd4WTR5d7ADEyyxxsTj64shm+8svNchzu6936zTxh/vHGpZuRuwLR87tZq0r?=
 =?us-ascii?Q?/Ioj5gsSzThBubm5sd4Kremooa21MULPcaG/qHAawzj9pVAQoN34zAGPkUfP?=
 =?us-ascii?Q?uCTQNX55V0IDLgKJzRWItt+0M8WFzlPaIMxaNKBtxgK0y/vGOGg9b9CoTRjd?=
 =?us-ascii?Q?62h6vQ5YJD/YqacArtlgce/nBfsIHzfNwFU6FPNOzJs841hG0VzrPJBIV5FW?=
 =?us-ascii?Q?2ZTG8GfB5+vJWP48h6KzLV8DPUnnQI5cJxfYutCQWaOifW8lqY+jpoe658ZF?=
 =?us-ascii?Q?FBZLvVne89FMqyyZR1VUKlRdj6pJZKPeTcAy2QflZh9lfUuA8AlWGg5yBcdM?=
 =?us-ascii?Q?jHlkp68GAoNcs2JJyrcTwLds3H5CJ4J2b0wCzrm2H2g24S8L6hSPvWUg/zR/?=
 =?us-ascii?Q?yRwMr2UxA7uDS/nOot9ay1bT2F/uBb/0lAfFD7jqLOnWx7TupioB0kevRwkg?=
 =?us-ascii?Q?FYbevkqp3f+doRWTw9PU5L3uEWpBo9hLJ+sY1dZm2E0WOeuE8ojj4IFo0mrr?=
 =?us-ascii?Q?MiOqfhYGBTNdr9sz+IXWf2i9aw87YY565vcy3vbFqwDI3hCGWwXPleLjjcgC?=
 =?us-ascii?Q?aXXYOozMyErF4DoL6SYWpPpcLox+E+ciKR1Wb5OZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83202283-e373-47c5-eea6-08ddbe275f2a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:57:26.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmIdeFsQC2b62dIgBafDsduHIXiHibr/66JXHlRz8UMRu/5bQIdBNeH4ryl1zkzrsR1j5seVuJrgYlw0HYVtkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5210

Use min() to reduce the code and improve its readability.

No functional changes.

Qianfeng Rong (12):
  ethernet: liquidio: Use min() to improve code
  ethernet: cxgb4: Use min() to improve code
  ethernet: octeon_ep: Use min() to improve code
  ethernet: nfp: Use min()/max() to improve code
  ethernet: qlcnic: Use min() to improve code
  net: usb: Use min() to improve code
  wifi: ath5k: Use max() to improve code
  wifi: ath9k: Use max() to improve code
  wifi: brcm80211: Use min() to improve code
  wifi: mwifiex: Use max() to improve code
  wifi: wilc1000: Use min() to improve code
  wifi: rtlwifi: Use min()/max() to improve code

 .../ethernet/cavium/liquidio/octeon_console.c |  5 +----
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    |  5 +----
 .../marvell/octeon_ep/octep_pfvf_mbox.c       |  5 +----
 .../ethernet/netronome/nfp/nfp_netvf_main.c   | 13 ++++---------
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |  5 +----
 drivers/net/usb/r8152.c                       |  5 +----
 drivers/net/wireless/ath/ath5k/phy.c          | 12 +++---------
 drivers/net/wireless/ath/ath9k/dfs.c          |  5 +----
 .../broadcom/brcm80211/brcmfmac/usb.c         |  5 +----
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   |  6 ++----
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  6 ++----
 .../net/wireless/microchip/wilc1000/wlan.c    |  5 +----
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 19 +++----------------
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 17 +++--------------
 .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 15 +++------------
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   |  5 +----
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |  5 +----
 18 files changed, 31 insertions(+), 112 deletions(-)

-- 
2.34.1


