Return-Path: <linux-wireless+bounces-28175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B2ABFC39C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42BA456533A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009834A795;
	Wed, 22 Oct 2025 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultratronik.de header.i=@ultratronik.de header.b="G/yH/+nI";
	dkim=pass (1024-bit key) header.d=ultratronik.de header.i=@ultratronik.de header.b="G/yH/+nI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023079.outbound.protection.outlook.com [40.107.159.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7C347BB5;
	Wed, 22 Oct 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.79
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140155; cv=fail; b=KkLodcjt/cgunLZFW696bBYB9bWK4J4UM5dpXGOhoYwURw8R57OHmjCPd+8f1EOvpJ1h4Gt5grQc9nhK805+Iuq+NMksvn/suJQ/xl4Oi2fugcHlkwGtqe3isbN+JGv5b2IdFYb4l4BpAf+bkafOFUQ3ByukG/lsD1+PNyUCaVM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140155; c=relaxed/simple;
	bh=ctNy9J3r1tiFH6rIBEN+ngkU8Ee0p3d1ISnHCLwc9Gs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kOZgPEMcfaCnsCi+Ag/ho0ZiFCvKLgMeI+IbO0DlXnarB15K7Z8PfWWJ07Va4owe/raTDSsnGbXSWlzDnPgFVCud4rLX1xOUxsC5q/8pmXfKHaooMhFT/qe4e5A8Bhydr6iNC+uQs7Hr7YTMOiHYOJ7OoHs7G1wS2SAszeAQRp4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultratronik.de; spf=pass smtp.mailfrom=ultratronik.de; dkim=pass (1024-bit key) header.d=ultratronik.de header.i=@ultratronik.de header.b=G/yH/+nI; dkim=pass (1024-bit key) header.d=ultratronik.de header.i=@ultratronik.de header.b=G/yH/+nI; arc=fail smtp.client-ip=40.107.159.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultratronik.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultratronik.de
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DEGkKt/1DgT2SuJjsEN6Te+ALnzaTaBJ0n3277wQPWl8s+usZ9cnGP4aNQAEQNDdh47Z1QYQ0Y1E2tH9nH6deNSwM17YfX77Qouxxm6xwOGw5mCF1o9YhP8+uRUSimdIxt+y7J0SnzEtz91yzYrKRM5wLJyNlghHf2Lj+nQfntUc+trW5VNl8wZ6kdg9cUi1R4DyQEhk2+lnyi8D4eCYmCtgwpUx0p6gZCj4QUTfDhWA3uCUL0DCmqD327xdxxdxXdqoi1Jsculu3We+4KcvwQQWhkYPnLn4A3og/qTExfV0auG1cpy/DhDdr6qlsQVYwhadgkaZojq7xGh6Poyv0g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctNy9J3r1tiFH6rIBEN+ngkU8Ee0p3d1ISnHCLwc9Gs=;
 b=QgpiWUCylg0OhT6HNLlbJ6zCH+ZsO79kpR2oaQ/TsQMHke1x5UHZ+h3Tt3ML5aT2pQcQvVyFMr123FVmdhTGAFVNNoqycWR/A6nnb4rqxd3S5xGOxz90IMvBltQ/n6RQVeo6b1IEnQQmPKU+UOrQaSneX0LBOSnkaTSTR78iyacNzlSv/LB9fMuOQSJwQ5HLsIXLoE+uuHphXAsM2ocEfOb2XFEVwYeV7260yG6uZCwyKy4H/1CTN3wbUropcNY6stSbRKkq2t12w/bTGZp9ciggRwacNFAyVyvGFG0+rYK0yjr/MXkeZS8t2tKyCJ85FTd2p1SM7ywWYm8OfffsrA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 20.113.192.118) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ultratronik.de;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=ultratronik.de;
 dkim=pass (signature was verified) header.d=ultratronik.de; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=ultratronik.de]
 dkim=[1,1,header.d=ultratronik.de] dmarc=[1,1,header.from=ultratronik.de])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultratronik.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctNy9J3r1tiFH6rIBEN+ngkU8Ee0p3d1ISnHCLwc9Gs=;
 b=G/yH/+nIBxxsbDMqLFC31rotN7S4uB0qituuEEcELiRdioo/VDL6HD57VAd/8o2UZVzv/h5848/MOW3CbaR5AtPAo0DkU8/DVfJ7uXb3L5P0n0bwuhKF3NfpdRiekl9H0a6xTHyL9EMiuYWqN4/1vpTGkmG6/qMGRF25YDLdnbA=
Received: from DUZPR01CA0249.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::10) by GVXPR04MB9804.eurprd04.prod.outlook.com
 (2603:10a6:150:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 13:35:45 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::3c) by DUZPR01CA0249.outlook.office365.com
 (2603:10a6:10:4b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 13:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.113.192.118)
 smtp.mailfrom=ultratronik.de; dkim=pass (signature was verified)
 header.d=ultratronik.de;dmarc=pass action=none header.from=ultratronik.de;
Received-SPF: Fail (protection.outlook.com: domain of ultratronik.de does not
 designate 20.113.192.118 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.113.192.118;
 helo=de2.smtp.exclaimer.net;
Received: from de2.smtp.exclaimer.net (20.113.192.118) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 13:35:44 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.65) by
	 de2.smtp.exclaimer.net (20.113.192.118) with Exclaimer Signature Manager
	 ESMTP Proxy de2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Wed, 22 Oct 2025 13:35:45
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12140492
X-ExclaimerImprintLatency: 1084702
X-ExclaimerImprintAction: 07ed55507d314121a96578246d0f667f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0HnrivslcTOKZRxT4dWTMmEstmzmR6GMGKB2JFt1lBORyYDkE/fyP5BB95LGwjxM3v2kdiXR8L/xJDdcXe0tl1mhSZ3oQ9YibhqiC+tQgzEiliAhuKTCI6RVhjGoCpxKdk1BZMCBzrCFlAjqK4frPWXexruIZ2jB1pBQJYwiU7mIzVpfi0LpSIvbYb9IoZLaIwaogt+vZkOmfL2fNtgDa8dbPdsMaQjuNglh/B8n8Ux8LyLH/OB8RV2zu0MohU7ydseIGb6aDG4kDhxgoMlzzywedZHQqTeT7PBuUAExHIU0lIwDMld3hGYg8kBZAT/4y3qFRNVFHSTe1m9AfKl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctNy9J3r1tiFH6rIBEN+ngkU8Ee0p3d1ISnHCLwc9Gs=;
 b=KPFlJOSGVzfl4t5pQDniK18jPUE0+0OhBYe363q8tGHaFdldVMvKbMiyusiBL0XLEX+v8aBESqu8sumYE2o8KC3NuEsosiFX3R4myHI4XocVZThbCTl821Bs2HF2A2pAxvAEqmwh6ddRcwbnsFqBjSMp82dsoM/eJ8GnWsLR79C4Va5wqJbh71wvD77VOrm5RJiSlw4eXdhZk+YhN0Umn3Ck0rh9Gf35Nqft72ALrRxwJM/W7TNtcIpK8anT+T/Tm2KFVijRPRoBxaIshuIKDabAuoY9Sq13BKNd63WyAlZbPCNN6qAsU2S1jvy/EzFaeVvAsf1S0yS1pqJMkKy+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ultratronik.de; dmarc=pass action=none
 header.from=ultratronik.de; dkim=pass header.d=ultratronik.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ultratronik.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctNy9J3r1tiFH6rIBEN+ngkU8Ee0p3d1ISnHCLwc9Gs=;
 b=G/yH/+nIBxxsbDMqLFC31rotN7S4uB0qituuEEcELiRdioo/VDL6HD57VAd/8o2UZVzv/h5848/MOW3CbaR5AtPAo0DkU8/DVfJ7uXb3L5P0n0bwuhKF3NfpdRiekl9H0a6xTHyL9EMiuYWqN4/1vpTGkmG6/qMGRF25YDLdnbA=
Received: from AM6PR04MB6136.eurprd04.prod.outlook.com (2603:10a6:20b:b9::17)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 22 Oct
 2025 13:35:40 +0000
Received: from AM6PR04MB6136.eurprd04.prod.outlook.com
 ([fe80::ad0:49f0:d824:99e]) by AM6PR04MB6136.eurprd04.prod.outlook.com
 ([fe80::ad0:49f0:d824:99e%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 13:35:39 +0000
From: Radenovic Goran <gradenovic@ultratronik.de>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Kranz Christian <ckranz@ultratronik.de>, Thoma Alexander
	<athoma@ultratronik.de>, "alexander_thoma@gmx.de" <alexander_thoma@gmx.de>
Subject: [REGRESSION] mac80211 crash in ieee80211_txq_purge() on i.MX8MP with
 rsi_91x (6.6.88, OK in 6.6.59)
Thread-Topic: [REGRESSION] mac80211 crash in ieee80211_txq_purge() on i.MX8MP
 with rsi_91x (6.6.88, OK in 6.6.59)
Thread-Index: AQHcQ1d7MuYs8Whs3k6O4vdnLMoRCQ==
Date: Wed, 22 Oct 2025 13:35:39 +0000
Message-ID:
 <AM6PR04MB613698263FB5DCC7CB79BE21A6F3A@AM6PR04MB6136.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ultratronik.de;
x-ms-traffictypediagnostic:
	AM6PR04MB6136:EE_|VE1PR04MB7344:EE_|DU2PEPF00028D05:EE_|GVXPR04MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e7e8b1-d386-4126-623c-08de116fe753
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?windows-1250?Q?O+l5yGPAdK1gMMnKmoAF16CrJsyweaIGEgLXavOJhucahsgKcriJAmI8?=
 =?windows-1250?Q?CAq3IU1JKEdd6azRCYknIcz4guywnOBWs2Hifse23S9yk6mSzVGdjtdw?=
 =?windows-1250?Q?JqrrS/1MA1blvkfZs6Gs2nX6SaBQQ33SR8S262W0Roq/v+MrZSiy2DYW?=
 =?windows-1250?Q?JeGWwl9TopC9RieUZzMIuP9XQP+G9HTB9OPkAQg31CBvtlT5zy6jzGdE?=
 =?windows-1250?Q?hmL3JuN/NQPR6n7/SEA5wAdt0wwZ0LR3e6IFTVuRiomp1jpoZ0qhVlKK?=
 =?windows-1250?Q?keuhRjqM0UtdEI7jUt5RRpCwo7TffKkbS5Y/BSMdEdPvu/WqANKiOIob?=
 =?windows-1250?Q?CM22qI3A8l7Wo1SAewG3bS/qHITT5elwYnaGS6EIAbInTHOz510H9r3P?=
 =?windows-1250?Q?qjlesqeSzDAFO+bVWbF9BniMjVU0JY06ttVmCfQ0mc76MNpoglKd2YNS?=
 =?windows-1250?Q?IZHzjeBjHOSKUc4HTn4OHS9A3SgQBqQXnc5T8nlXqTEC2Qg5D5XZu+GN?=
 =?windows-1250?Q?cpr6yIcktlkp2IysL4xY0M9KiAhB2ECFeiv7drnD+wSy0zQa76wUJInt?=
 =?windows-1250?Q?iq+WSwfqaMDikCZ/Hzc3IjFlaWTgzDCc/xViny9H/H4GZMIxo+PHCpx7?=
 =?windows-1250?Q?vlzUCc9WgfB9j5R4X4xiTrbW/LOv2+SfLAxvGkVWFjQn4KBqEJRGO18L?=
 =?windows-1250?Q?4pR11HsAE/2hPNQgsJpOUtg6V734/0t8c9lNbJf4rQ77vuJ/KfqdMFfM?=
 =?windows-1250?Q?iB6j0MIJBlwDmfvFOD5JnM2FdvUkhzplep1kwp8z1abDQvxB0QkKDPq+?=
 =?windows-1250?Q?WBXth/CLNyFtce19um7qhnir+pTaAv0+/nfY3rbEn2CtOEP/X/5HXCkj?=
 =?windows-1250?Q?TmUt8IjC2o6sQg0sbr9+EZocgM2/EOVuTmvP8rmIuMOcQKXHB+3W8aJI?=
 =?windows-1250?Q?k4BQD52xgfyOdGphcd+xNB8rGJg/Znqi8yoNqVgoNAqJXpEx/ti1mIla?=
 =?windows-1250?Q?KwqspZQD/y1K6Iu0pf/ai50S1anrtsFFVBqJF+ulBLx6pZMIjr1CBhNy?=
 =?windows-1250?Q?FxjMMA/2Y21ZHLPMgh/v1xoWaGFO9EjGOtce0EaNm2M+S6NQV9eX6VjV?=
 =?windows-1250?Q?IJPwvmeE+t6x9K2i9ja3ZKtVYpo9utWouODmdgjfE1AnXyVuhqwEGUMy?=
 =?windows-1250?Q?EZjk8wqDSFRULssV1y8fj1BxpCp/b06GB8NE+YAiYfKvhFQbSuMV4fa+?=
 =?windows-1250?Q?nA7A8R3uzMtjeMF3Mni0OTxCn3orUclNou9xUuVF7xSmasTirgr3H3HT?=
 =?windows-1250?Q?Pa+JZZ/JwgNOZbiR3JYZo/YTolgUIoeW+DD3ZKa5AabBmDCQBbVo9pZO?=
 =?windows-1250?Q?h3CA91cgLlOZAvJyptL/DQKWcYarLM8dLQUozOpc1z6edQuVCJte0Z2X?=
 =?windows-1250?Q?sojLhVY4fQI1UsgBDhekkJmTusyrON//8sIvF/ObZv0SyhAiMrsi1vqL?=
 =?windows-1250?Q?FQ/DFZ9eIue5mh1/rwJETTRW5zjHl2jpUiI9h2ocSi0zLgXm+qMhFaX+?=
 =?windows-1250?Q?jqlIYpLOvFqBr2PhPcV8DoNA2tr1SLgcduAxyQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	610db77f-8f6e-49f1-b81f-08de116fe41f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|376014|7416014|82310400026|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?windows-1250?Q?u3Vo9OuGNL7Do8UEHwAVZTqvAS0Vnxy0K6OBsKxb1l+mIX4P6TgiRPAV?=
 =?windows-1250?Q?l04QaMg0qCQYldsp9PimkIsnRhkdZZUuBd0INzqIlkBFxIpm3CgWFs+D?=
 =?windows-1250?Q?lmkxt6JoYG4sUgug80ZrZLGTULQku+5jyGoHdAnSz7UIAc679DTbbQ1R?=
 =?windows-1250?Q?NOCrFU434QQ25CjXooC4NgcWWaf+28UGPmBQSxr6BNTJVO/8USoLEU3s?=
 =?windows-1250?Q?W8HUEMN2rU2UVBI1kERENDe5BD0jRy8JIOPnoXsKjpNeuPSlErLycJh4?=
 =?windows-1250?Q?O/LA+ze53oHG5dOwcDJXIhADdRtcW6o7m26dzo9h3W4xJvLy24naXuu+?=
 =?windows-1250?Q?gr0I4A4wvkDVoPQR0e3cf1zorWeY/YugfEz2TF4MiuY6vkDfB/1/tuEm?=
 =?windows-1250?Q?pv5F1K9AmLL7gEXLVt23BR4pWPufRjSm8Rw3hTr81Yb+muRVGhR471Lo?=
 =?windows-1250?Q?GGR+1FYveyrJlpkQwcF1H5ug4GuBWk4xFTr7azOWkZt3FwCYLnIdjeQ2?=
 =?windows-1250?Q?1256dzqx6R4FF057d30j4hjvd2OGckqZ4wHT3G1Am2YtvyQj+59eGbSj?=
 =?windows-1250?Q?HIQF0ikZp9lOP/2xeRSgN22KvrmH2sh6A3YJBqmDoxfLZRNZbp6xL88N?=
 =?windows-1250?Q?z4ht7msmf11m75+aU4Ivu1417NLQNXnQc0cQtu2QuVXbSxQiYJf89WIR?=
 =?windows-1250?Q?PUAfL87nGkRlR0emKRscg8Q+TdZAvpkSpwEzkcLYBe7PXAzvUmItr/Bc?=
 =?windows-1250?Q?siEMML9RlnKNm7S/Ifv5PJKX53zYEX8oDD0rB+1/T0h5+eyrd09KvB8q?=
 =?windows-1250?Q?s2Ue8ZYEwP3zx4gIQP/PQ3hZQXu+Qxt5YgvuA4PmLQ3iaQRLmTnDMVDt?=
 =?windows-1250?Q?GZOpxazr+TZm79uONkXyXYf30sw7PIfd3h26/BGapUnhyybgY59TeIW1?=
 =?windows-1250?Q?DjuQaYw3GxqnRd8exQC2BVi7thXfjMsXa3u+ADTYDHVncwrw/dB0Xw1E?=
 =?windows-1250?Q?OvyOQKpnYMet1wSDcbmfZOaGF4nKKGFTNhqJ+SBvZi67dV3gfSMG5niQ?=
 =?windows-1250?Q?gVqBv1zLcHIAvWhKrkKyk43LHmJnns7kgEWz7PCep8MqAVsh5RTwmrT7?=
 =?windows-1250?Q?3FVde2S7bcdhxjMT/PC+P2rl6+wwN0FLfo/9otGigahH0WQvDnWNTgZM?=
 =?windows-1250?Q?Km3a0SQ1y7VCPGoCf88DqO3eemYGj6KB8/vkDz0if/EyL/cYHmHOGoem?=
 =?windows-1250?Q?rhRmKS+nIxgo6cBbAryew5nFf833dglzhqlucr6TZslxOtX2vGwdnhlZ?=
 =?windows-1250?Q?rFIvJ6apThXBV9P9KWhoNz3VsOZhGmPaAY3M5unqXjcxcQi+ZcBDfIl1?=
 =?windows-1250?Q?YFcSSvPXaTr+63khTYfWf6vK8cyO8mJIPEvvoAPnyk7byQfrIYXsL/BH?=
 =?windows-1250?Q?WO/fQ8ZTNFemp8E0yapRt+DyZyPyuWkD0DlV4aBwtYfY0jaEarYzzXZS?=
 =?windows-1250?Q?M+egoS6ERFACbiFzzjmyRJN/VuKYhazw6DuiR/6qr1SVspUWgk3//1pj?=
 =?windows-1250?Q?Uq+Ld1R58PQOp4R/db23lYM/bsjdQSKBmXo7htlhXR5dgAtZ+FGR+oHO?=
 =?windows-1250?Q?asBBmyzyJPdHIEuCwvXlEBUV?=
X-Forefront-Antispam-Report:
	CIP:20.113.192.118;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de2.smtp.exclaimer.net;PTR:de2.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(376014)(7416014)(82310400026)(14060799003)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: ultratronik.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:35:44.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e7e8b1-d386-4126-623c-08de116fe753
X-MS-Exchange-CrossTenant-Id: 57646541-9c81-45e2-b5e8-d65bf790773e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=57646541-9c81-45e2-b5e8-d65bf790773e;Ip=[20.113.192.118];Helo=[de2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9804

Hi, (sorry for previous e-mails, I am dealing with plain-text issue)=0A=
=0A=
I=92m seeing a reproducible kernel panic during Wi-Fi interface teardown on=
 =0A=
an NXP i.MX8M Plus based board when using the in-kernel rsi_91x (RS9116 =0A=
SDIO) driver with Linux 6.6.88. The same device and setup do not crash =0A=
on 6.6.59. The crash happens inside mac80211 while purging iTXQ on ip =0A=
link set wlan0 down.=0A=
This looks like a teardown race in the new ieee80211_txq_purge() path added=
 in=0A=
6.6.y after 6.6.59.=0A=
=0A=
Summary=0A=
=0A=
- Kernel: 6.6.88 (stable)=0A=
-=A0Good: 6.6.59 (stable)=0A=
-=A0Arch/SoC: arm64, NXP i.MX8MP=0A=
- Wi-Fi: Silicon Labs RS9116 (SDIO), in-tree rsi_91x driver=0A=
- mac80211/cfg80211: in-tree (no out-of-tree patches)=0A=
- Repro: ip link set wlan0 down while associated (e.g., after connecting wi=
th NetworkManager)=0A=
- Result: Oops in fq_flow_reset() called by ieee80211_txq_purge() in ieee80=
211_do_stop()=0A=
- Expected: interface shuts down cleanly without oops=0A=
=0A=
Crash (excerpt)=0A=
=0A=
Unable to handle kernel paging request at virtual address 000000000610e020=
=0A=
Internal error: Oops: 0000000096000004 [#1] SMP=0A=
CPU: 3 PID: 334 Comm: ip Not tainted 6.6.88-stable-standard #1=0A=
pc : fq_flow_reset.constprop.0+0x2c/0x130 [mac80211]=0A=
lr : ieee80211_txq_purge+0x68/0x1e0 [mac80211]=0A=
Call trace:=0A=
=A0 fq_flow_reset.constprop.0+0x2c/0x130 [mac80211]=0A=
=A0 ieee80211_txq_purge+0x68/0x1e0 [mac80211]=0A=
=A0 ieee80211_do_stop+0x50c/0xa38 [mac80211]=0A=
=A0 ieee80211_stop+0x50/0x190 [mac80211]=0A=
=A0 __dev_close_many+0xb4/0x158=0A=
=A0 __dev_change_flags+0x19c/0x2c8=0A=
=A0 dev_change_flags+0x28/0x78=0A=
=A0 do_setlink+0x288/0xf30=0A=
=A0 rtnl_newlink+0x54/0x88=0A=
...=0A=
=0A=
I can share full dmesg, .config, if needed.=0A=
=0A=
Reproducer=0A=
- Boot 6.6.88 on i.MX8MP with RS9116 (SDIO) using in-tree rsi_91x.=0A=
- Bring up Wi-Fi with NetworkManager (associate with any AP).=0A=
- Run ip link set wlan0 down.=0A=
- Kernel oops as above (panic shortly after).=0A=
=0A=
Notes / Control experiment=0A=
=A0=0A=
On a STM32MP157 based board with the same kernel (6.6.88) and RS9116 =0A=
SDIO, I cannot reproduce the crash=97teardown completes ok. This suggests a=
=0A=
timing-sensitive race rather than bad data or firmware.=0A=
On 6.6.59 (i.MX8MP) I also cannot reproduce=97so this appears to be a regre=
ssion between 6.6.59 and 6.6.88.=0A=
In net/mac80211/iface.c, newer 6.6.y contains:=0A=
=0A=
=A0 =A0 if (sdata->vif.txq)=0A=
=A0 =A0 =A0 =A0 ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.tx=
q));=0A=
=0A=
which was not present at the time we were running 6.6.59. The panic occurs =
on that purge path.=0A=
=0A=
Driver specifics (rsi_91x)=0A=
=A0=0A=
The in-tree rsi_91x advertises .wake_tx_queue =3D =0A=
ieee80211_handle_wake_tx_queue in ieee80211_ops but does not implement =0A=
its own iTXQ dequeue handler.=0A=
=A0=0A=
As a cross-check, the Silicon Labs vendor driver (recent release for =0A=
6.6, which uses its own queuing/teardown) does not crash on this =0A=
platform with the same kernel. That again points to an ordering/teardown=0A=
issue in the mac80211 iTXQ purge path interacting with in-tree rsi_91x.=0A=
=0A=
Hypothesis=0A=
=0A=
A teardown race: during .stop, mac80211 purges sdata->vif.txq while =0A=
something (either mac80211 helper or driver timing) still holds or races=0A=
with the iTXQ state, resulting in an invalid pointer deref in =0A=
fq_flow_reset(). The fact it is easy to hit on i.MX8MP and not on =0A=
STM32MP suggests a small timing window.=0A=
Even though rsi_91x doesn=92t call ieee80211_next_txq() itself, simply =0A=
enabling iTXQ in mac80211 (vif.txq exists) plus the purge call seems to =0A=
be enough to expose the race on this SoC.=0A=
=0A=
Best regards and thanks!=0A=
=0A=
Goran Ra=F0enovi=E6=0A=
=0A=
Ultratronik GmbH=0A=
Dornierstra=DFe 9=0A=
82205 Gilching=0A=
Germany=0A=
=0A=
www.ux-gruppe.de=0A=
=0A=
Gesch=E4ftsf=FChrer:=0A=
Dipl.-Kfm. Alexander Sorg, Dipl-Kfm. Alexander W. Jonke=0A=
Sitz der Gesellschaft: Gilching bei M=FCnchen=0A=
Registergericht M=FCnchen HRB 55584=0A=

