Return-Path: <linux-wireless+bounces-25009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2607AFDD58
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08061BC7AB2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4219E806;
	Wed,  9 Jul 2025 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lzg5+Vm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11C1459F7;
	Wed,  9 Jul 2025 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027776; cv=fail; b=oZJGdC7chLx41aBVMoVp06+39+25m8LFah38HmQelXr9bMl1m++CtxY+u2abCFqdTU8QGbHYk3pD7NaCSJQDlTs9oIjl0wOsCCDjA+L1QCV08i/8Bogq3bo8kaidZYpqDqx4IkJQuhPQ2zG7zpqfEOONnSnJY3P5wPUEex1cBj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027776; c=relaxed/simple;
	bh=pYIMzHDMltfZEc8CNInYclvhe/7NGQU13xQqycFc1IQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oJM3caIImUzqcCglZFnVYeX8Pl4AvztMgrjyg7mAUeseGRis+7zDa5JOj8WsHX5IDgdRGbE0LQmw1DUOVdc2IhHJ5thRwOusQUlM/yfsl3Uk/OcDYrr9UudHhGAaQjQ6zOwpiELrFDV1cTIzrvuw91vb3VxLo/GxyUk8hiSk8sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lzg5+Vm2; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvaq4gRdYPVZyOPIaS1JDxIc9ABtbuiEUFplxbP9BcRZjFS+682tyAY/mUmRUkQjiaYefieqRUCmc8Z9sFKcLTbIvSMlMBPetNMhnGKrSAqGmpvu8oBK4cvQCOn/GACX99hqGsF2TPvxNU1A9KBOehwcdvEhllDnR6puV4tgsiU1O9nejGMoAwXCr5Pevk7ZZ/Ay0bU/WFdfSvAPKFauUulklJ2zy19UVs6vxS7JtkiMyiAE9dbPpYSZcGBaa/8Mo+RVsW3bZFIuf9ojq54a9HGbAS7Lo0reVIMAPyhM85h8bAJMjYaqH7ZmeiI1KTwYrUbyi8N3w5WUoFls2ua4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVUh5mvshvpSYjUbfWxqJmucQsLz4xeX625qVq2SfI4=;
 b=Uubt125lCUzwwPe8Kc76TnVL76i8EydPkn0C12wbrNiCYLLnoH5KOkgSFsuuSvCyGd/jFH4onzJLVylhGIqvnlQYuG8XcAYtc8oIW17SvSIS1rRjitLrS/IHaHwhegiY0FBGLhYvrf7/zDuSsoHi1UtFr7xHZaSKoEjdGUEni/8KfoooBmfu3E4bT1xNrDJkyGAYrmqtJDrJH6UHA3upGdFx7dfHOCNPkoy6rral3Je+I5HDvSSFe/eL70nK2Zj2W+T7lQPIU6nj7Ns25neMocLlnoVC2PixGCIoKkdjxfcO9rgdbwseppkb9sA8Sqa21kMdnyYVD8ScwiZ4KIBwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVUh5mvshvpSYjUbfWxqJmucQsLz4xeX625qVq2SfI4=;
 b=lzg5+Vm2Bq8KOndwBdepChhbNFX18HXTfwQ3h7Hgweg0ICSayZBs9hBhQ/TQSgnq8TZC8l18Hpp4HNY5hTD15myqaUKdst2hR3jr2GHN1PLqVPiAISbodrONQ8jYx93yXNrlBn07B9Fbchts57enVVsoXgX+L53CQgC3it6PKUrNvbBs0auyOwG1osdhUhDrm/to9dF/KeikWnUmVRLnz2mBm3ZfX0wPKiknTE43Fzbyey+8oL1JMtGSiyigPbEBBhKtZSkCr1m41T65Jf/O26Il5OWPwn8/reLbnyLoYgfdHeM7WScf/teWmEG8YZNRYhql01+F2JgVMoOEcHeOqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:22:46 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:22:46 +0000
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
	GR-Linux-NIC-Dev@marvell.com (maintainer:QLOGIC QLCNIC (1/10)Gb ETHERNET DRIVER),
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
	Kory Maincent <kory.maincent@bootlin.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Lucas Sanchez Sagrado <lucsansag@gmail.com>,
	Philipp Hahn <phahn-oss@avm.de>,
	Eric Biggers <ebiggers@google.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Kalle Valo <kvalo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	David Lin <yu-hao.lin@nxp.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org (open list:CAVIUM LIQUIDIO NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list),
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
	linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS)
Subject: [PATCH 00/12] net: Use min()/max() to improve code
Date: Wed,  9 Jul 2025 10:21:28 +0800
Message-Id: <20250709022210.304030-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 394ec863-1869-41bc-6490-08ddbe8f7dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3zHp+K0wwMYRaqupYVJqIKeUucVB3CDMGPfDQ++eJfHfNXtiogRoQoCe/HI/?=
 =?us-ascii?Q?hYCHJRcqveHBjGXBqEeXXRReBsNZ71B3cNILwkYq1n5E7XBWHlQhaQfStql2?=
 =?us-ascii?Q?Q+lTbL/DkNc6/W3MbsgwpDStPJ7qyVP7UzbibzNknjWREKqH1VrIncINJHTG?=
 =?us-ascii?Q?jruOIeL6YiY4zlakDrhhf8tJHH8xbgEJ1n575Mb6MdUtWyQ50QUu670TkjiL?=
 =?us-ascii?Q?oI9FAQTcXriQapNqzWOnA6PgnBW5bgIC2MS1rSt6bkWt6HUz7CihdElOtxi1?=
 =?us-ascii?Q?8vPIjam0IJAlT68Z3CzSXARoFaoEsnYT9lMG7bu08XWcnUUIZtLivlfQbZ7l?=
 =?us-ascii?Q?q3VknF1riJT9zZJx+xO3bhZGuYeZAR6NOmugM0D0EFCe6Sc4MdckjtpcmDrB?=
 =?us-ascii?Q?bpN9gLxTNi315deuwhBxDfS+BdU95CpfUXJ9Uik0cyTeUj0l7Av3KDN/YSIK?=
 =?us-ascii?Q?Z4F3Sc+aD1LsOVkW/fV8smq6nxKspT90kxKPxlsrfGKixQ+7qtwHGsJ2Dw55?=
 =?us-ascii?Q?Nff/S7cdDXy9WfaiEvFaGWYycnOsS9M7LYNfD2hj8c//fkXxwqNJFGWxLl5e?=
 =?us-ascii?Q?HfAsUce6kbY8jPvzRCzCDNMjafb+ss6WvcqmZ8bpzJ1GWPwpoLZxaMmImmXO?=
 =?us-ascii?Q?dF2htm5dw3lq9At/qzM0LrJVL6NpiKRBB5V8xcQet2dRgSZfQEsEnG5KUOTT?=
 =?us-ascii?Q?a/zWcEoQcCo038KlhqRuDRIrztVkRmyJWbs4CDEFt42pj8ITcKH1rpluUdfW?=
 =?us-ascii?Q?HxcYuYF/OllSelqxyayeGCfFCXJnN8vPxrpETpQ3oN+6veuqOan7xfk+v7b2?=
 =?us-ascii?Q?qrfVdqAQmDBapm5dEo41Ka4dLr8oIRUog/gvqUDPnXN6UNSBV3O3sZM4rTzA?=
 =?us-ascii?Q?2QEEVlSG9kVdOnVcw6i6VaS+8iKz/SctIwo6lc+StF4yAenI1LqjZVjCD4AB?=
 =?us-ascii?Q?FM17j2hVUxv6Ty3DZZWy/9Sj/e44i5dv27XWX7hF+09M3anbh/1BQuZM4VKY?=
 =?us-ascii?Q?e/l8j5fh79hPCTiTiTR1cE6Q60gB4KV+bxv7PV/2etCSxa5knPckFSHAMxbG?=
 =?us-ascii?Q?0l8h+tIY3WbQ1sUJhcUtDm0pEoqpY7b66EqpvArT4W5RRODlfhU82xFLJvL8?=
 =?us-ascii?Q?QMQLfpu/9CNJJmWs4GBfimK6tLrcVTnUw+zesQM8h3DLR+aMqX52o9RdHb2T?=
 =?us-ascii?Q?Sn0vqyYlU9hdXXbgwO+I6+7H1HfXJ/+kYe4eID3Ak68DU3bbZpQrGfvQzCtq?=
 =?us-ascii?Q?3zgO08D65s6C2QldbruT+WHePDUC5Llj5WZTcPn6VvgbKQLI8/1R9yy/sZAX?=
 =?us-ascii?Q?xiEJB0f1lu/xpE4TFxR5IEPoQkaR5FomlCI/CfFw10nEfRw1IN7Fre0EpXzn?=
 =?us-ascii?Q?o+IaAi7c9Hg5afhCHlhKHUpYdqqqG5cvJnhF16CFiQjK8T1hZffOoKflMXXE?=
 =?us-ascii?Q?qtgHErocvUQ1D9cvSK+OCg1fRR7aDxRtwI6HsxtYWRW0b6DDROWtjJ5gWbRo?=
 =?us-ascii?Q?p6+IsFZoYclLNAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSER9PAvQ9ez672RHgCsAL5XUdT9rrfD1UTMfp38+MqSFJ+Pp8mpEMVPG0k9?=
 =?us-ascii?Q?nYNptiW9GTD/oCdxREyUNE0icEOFWL0N3g8jAYdst3M15fVmG8xdX+P5SgUI?=
 =?us-ascii?Q?F6ViFYJoNQA1yOet3SRt9NA5BEACV80XAkICAyOtkScXcY3rVwE151Y1WX3c?=
 =?us-ascii?Q?OF7UD2Z9ktFPvFx5heRvMW/JyqsLGDS+6qUAxRAmt0bhIvKnXryUPiV7vgmc?=
 =?us-ascii?Q?WPjOBI8lC/lqJ7poBkdWxzHG3EXANim4kD3GPEVol8eof5dNpDqd2HjswJAk?=
 =?us-ascii?Q?K77QA3pkK43lDsGQNFMrkskzzKSc+yejI0tuxf1rvSRXGvb8y+/j2jxNSizr?=
 =?us-ascii?Q?0quPCN3+N2AUiDXsGIaqSbde4fWuv1h9YS2wzugk6HCA38n/EsKwk7T3jE/D?=
 =?us-ascii?Q?Bo82xGdHwZv9BbnY7qYfkc5YNSnmg8HIaQCwZdC8oolQCJOvsxXkuhTu6FDX?=
 =?us-ascii?Q?jCMscZXJ3w8G5hzrsCKosHGE8WX6EtQxHBizkZBUbTGnWsxtyKOIWKmcfl4Y?=
 =?us-ascii?Q?7ZzMdYM4ntteXxwwlHS264mFZIV4tVmRu5SuX/nl5kcJVGwAUnQMFmVxipta?=
 =?us-ascii?Q?EnuADMhFLoCUkrBgxF5p8so/n4s5L2tq7nOGTNjh5MGrlNygNov+0dIi5Sdu?=
 =?us-ascii?Q?2YSCZ9UsoEvDtV7oPR6Npc8z18q7lq/+S+PLOHjUDATlw1WPNvN7b+U0DylO?=
 =?us-ascii?Q?PvBJ51gCh182pvPhfriZ60jkgNPTNrJK9lOj3ekliD9G3Y72Ok2ujVzLA1XY?=
 =?us-ascii?Q?AW+/c6a4eqRT9kJJwQB6+eYjbblsUR7j3+w7YKIXrFbukeQH2iAL3UUtGdKd?=
 =?us-ascii?Q?GZpRw+O839aLOiQiCoqVtCCBBjUhv/0bpNA07ikcLSeBAuj3a/6JjQGCHDzi?=
 =?us-ascii?Q?5XQEFTCbPU8Og0LJTz0lwUTE8VvXtezndyko3PnLbXWf4+bDSKD8hHont4Y2?=
 =?us-ascii?Q?SWv92HJyNo1A7on9S1t6C6l+MMUEvJdFfDZsCvNcmAmJdBLQU+kDOxQ4PyBH?=
 =?us-ascii?Q?HOLO4wF+OLUvKI4EoxOGJALFKlsvIojXcY92qMZczvuN+L733JB14rRGrrQ9?=
 =?us-ascii?Q?R+R+KaxBd2BBsK13O/1E+V8q/V/FSfRSY42DgkkMgOs4DH0ZyjigMm7khDc2?=
 =?us-ascii?Q?1vDt9E2Esc34rWflhbPDobtqPUNSQux3lE2vnB8b98JY2HPyKiIlIsdCieB3?=
 =?us-ascii?Q?bLbW0bYr3OXaWqEPvZIM/4jvDZ+s8YdTmgBRcsUT3S8nEufgvEUrAcCJXTpT?=
 =?us-ascii?Q?0dZ4rApvgFnqlMUMXDPWSiqk+p72Wm8LATkNDsI6f25OQNKL/MtCOAubj4gg?=
 =?us-ascii?Q?B/LrFwGiHPMf+DNmyF4zYqD/f8BK4rDXc3hp/OJOdoXEns6+Pe4GqnBX4ZnI?=
 =?us-ascii?Q?ML3sUPB5ArZ/n42OCecDpkP7jzesDiZF5Y/m8GMm39DIDbChT5DwjYbswpMt?=
 =?us-ascii?Q?YesONN5yqQslQNZDmJEp1QNBQ2jH4G7+mw/krYo6uTisz3WM/aOWW0H+g/HY?=
 =?us-ascii?Q?myBvgGIqlle6cPY9yHHn9EniyooUNvzKZDkNNknGV5stw+CwWcpO3R1TuMYM?=
 =?us-ascii?Q?6pcdCMS6KuQnOC1a6FIdfgXBfC84znqbyeowwsW8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394ec863-1869-41bc-6490-08ddbe8f7dde
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:22:46.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZZLw9T428S9xqoveS0ZjoL/MiWTMFfU07/AqxLEFEBET4e/MHzuXeomjNY2qLP/CEMHN/THbtls3PQOz4FAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

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


