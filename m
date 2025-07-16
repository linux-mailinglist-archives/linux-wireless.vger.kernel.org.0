Return-Path: <linux-wireless+bounces-25527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60169B07038
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB7B504F09
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE08292B20;
	Wed, 16 Jul 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="TFMwmJKT";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="mmsMnPl4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E6291C06;
	Wed, 16 Jul 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653899; cv=fail; b=H+5tlswbrijJqRdzKMbZVLz8YW1xkZBlwiBmZlu/D3Qsw5B1415zLekj4OScbursZqU5M273ywKq3+SKNKO3bHeNJjZo4YWrs9jO2wf0m0wbARytXtrBUayJroSA8an9twrwA3Km9ct+EzuAgdE6JPUHfWjOujRz2AZkEngJySo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653899; c=relaxed/simple;
	bh=LW2xbtUzjDmxzPJU4Shce+QIvXUxE14EQ3Gcascx9xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqFcouuos/9Z1sQvE7UchL9WSnPTR7I2B/ZjykB4G3gPPqpTvI0w+Uk+18A3DZNr9DWQwgMG6uP2JB/mqb2mli4KctpbYRg0b4GO2t5x29rzUa/i/mbqana1CPqrs9MwryyTmPeHYurQH+UOJlAFGowTf/9HXg+MPy1Ow4bUsac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=TFMwmJKT; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=mmsMnPl4; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G5t3Uk2228410;
	Wed, 16 Jul 2025 09:51:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	WMixVzblsg7zo/PyBGVFv4L2PCWzV4jtjoeKM6QmVOQ=; b=TFMwmJKTlt5C20br
	ZdlmHUD3IpvruR/TB3FbCHq4U0rjFMK6KG/rjcK9I/jz0ZGMaoOoZI9JG24uw6VB
	FG4EysKFlFoMFbmmWJ9+qbG2r73WFQIamO7QvFv21zNAfPpZsKKs8Hq+US2G3i73
	RmrnGxvHt9MImer1L8ZhVd+In1TDEkawY7oZsCR8X2YXmylzsCbOSMQ8XItZRXMV
	isPJTApOp8riAlS4V/UBx3xV2+PzTKSPGRYHOzXt+FEWcvKH62BR6Rn/W+CPI+eS
	nkoi0S0ngSdL0HuR3coz87J/GK1dd6/jiwyzrOjdF4Neigv+xE7jAjriav5fDwUw
	7TWT2A==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2120.outbound.protection.outlook.com [40.107.104.120])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47ut22b7ne-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:23 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1SuzfC+JuzBQlxGi+2HMMJkVCB628y5UsBf4kyGNxknVcX6MPCJuFsJXq6SY+jd/LOF7BQknZcWH2zNd7oVxGykn84c5iMCm+aTG5+m4kdgiBatzUPB8z9bOPBadX1Mh8oBHkxS3HMIuaOfyf+Op/xoKa2uQ1yU+rBPifTgXxipj+msGnGIphhS9Xqf7kbkKgFakc8aOLQiLjJOx7/vFBKvcAzO6xOPAxF9PbcmkEp0JCzFiJ0L8naj5zp6WCWNNhJlxmjvG/Ct7vh4rOYPvXa6RnIp42mJTfP3NBAg4Z86CYImH6czBSdq/1rYlpV42N1leG0442wFKqbr7Ij7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMixVzblsg7zo/PyBGVFv4L2PCWzV4jtjoeKM6QmVOQ=;
 b=k0WsJudhU0t14ScRv4zyNwbEhJoWCf8RI+V/TDMSyQvz+5NjH5eN7U42zzdQNwoUkLpewa2NVwpjZjijCyl3oJw2O+3l6W9dq4l9ppvqdZ+IjMgZIC7tr1MCqJp0jPkgrY9yccpclpWx0lwQnlaCw0O6Kyzy4XryXmqNvDqyy3qXXR9rz0tpHCqU+4r7MFDGsfkvTyqLMPQUppSjoR9cbjL5iXTmEfmrHkSndTGU5kNQW7D9Hg/sFg1Zef7vqTTBMUAj/GV9JZSl9rsRJfQhr+UNV9XlALcskhdSuG1NaRheo09j3hnXD24BtYbPT+4VmdguBCsp7l7TUUgzXzLK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMixVzblsg7zo/PyBGVFv4L2PCWzV4jtjoeKM6QmVOQ=;
 b=mmsMnPl49nw5jHdRTl7olQo155HV0XJ+xNBvYcKJlZjjLiuBeP+Yw4tbbFd/MAFpM/+rwRtR0qgHWnAovrKckIU3dM6bOSmxWIG8SrbL0Cs9QbfSIiNno9QtAb7WUTs/DyzUzc4AYoO2+gtbbP28BSKy5gq8Q2j11NqoqYoEm0M=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:21 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:21 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 07/11] wifi: ath12k: fix endianness handling in QMI bdf download
Date: Wed, 16 Jul 2025 09:50:56 +0200
Message-Id: <20250716075100.1447352-8-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::32) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 694ea6e1-f573-4887-98cb-08ddc43d8df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EzJ0XDtCS0OHpCgmL7Y9uDELQ26Uy1UcG0c3X1HoDeBa4pgG1/vd8oeYBA2n?=
 =?us-ascii?Q?Gts8i/UDWqGi4SRLnLE2klY4ApVetb0AnsvvHB1iKTrkIvVoKZNpGMIsaJd/?=
 =?us-ascii?Q?53XL/9rSG5+xpr7G/YGP7DarrMRKjr4J3gjNoe95cYHIr6o5tncxz78ZaMyN?=
 =?us-ascii?Q?SNYh1m5xtMXqm9eznYz/+MeQvZZaC4+GaUF6Njy+Uv9R0d/2f0QMQrhb8YPW?=
 =?us-ascii?Q?E3pEZ+lO3Sr6UBOKr70Q6Gbv+KK0yJ05XbkwJZUyn96tOGSyqHpyuQKogjDb?=
 =?us-ascii?Q?iTDGAmVXZlOIyNKuhASL/MPrqrwxLusbCdakwdZh2SIQpEZi89O3srKK5ALY?=
 =?us-ascii?Q?TPYdYPxLHn30tI+J+CsHPr/oYJ+nqVJ7onM0/EAIdDwrdOdHWDfZFOtoebyP?=
 =?us-ascii?Q?Cvg5R962POb33633fGj4m8P8gwzB6HL657h+Ryjf8UGre/ARWl0o/xdqmuGX?=
 =?us-ascii?Q?QoWPBtTBbJDgdQ2b28ie/F8L9rRLhwN7qK7QmrZyQJbrf1Zvjh0zgHh2Pd/C?=
 =?us-ascii?Q?7B2sFbiP6LOCaMuSZGDmt66cjATT6TcCuAigW/0Lp7vHVqxNeFMEkS+KG3UF?=
 =?us-ascii?Q?JpTMfvlGL5YJ5XqRMxeeJzai2c5V+xprrLjM9pI4wrwwm4KRCH5SDbPcy4AJ?=
 =?us-ascii?Q?r8aXG4bPXMP48ex5C5k0WOr7DbX6UtdU1FtJAaEE+hrfbd4b4jZTW32hEahW?=
 =?us-ascii?Q?uKUDKqR5kfGppdmeA9FyEdHa6nAk8iOGBI6j/iDtY47lmOh/eX3DygyDTeBU?=
 =?us-ascii?Q?LWS61ke/dPNTQKe0eQOScfjiModBd2xuy9FB6MUwKKbyPS7XK6fJ0ttYXlpu?=
 =?us-ascii?Q?H3wO2DUPNsbm8FxLB72CDrhgeyHafKRhXyPbQnyD1M8zJ07eCOs+6s48MOAC?=
 =?us-ascii?Q?cB+k80ZK2XEvOssRUwgx14iwBp2mzuPzKrRNJeNRjjskP7tv1EyjECFfmb5K?=
 =?us-ascii?Q?trcsdV61iBvcFEXWpiPP+SmlMbpZQgOiUKiLSvAp5bzSXsy4w5wuHMqQmoP0?=
 =?us-ascii?Q?6O6QyKmANbeWWmi2pR7FCA9umUkLzrnwRjQA4FQ/IjLGUjSs+8p/b5mbDaFp?=
 =?us-ascii?Q?HHqRly8e9A5Ku3PTyodddBn9ws4l+3pGi7HMfdodtyuG/0hPV31uqpodFo8E?=
 =?us-ascii?Q?uSOw682L2GNs5LwXl0F9Hc1R2RRn5+A7TaUGte8l1vror6hFbACw8aKkLZ6x?=
 =?us-ascii?Q?9Ni0V0Gn3QlOW/Cz2cGZuuDQ+XmcTJD/VHTFCjm+06sctTtVHWM9rPz8pR7i?=
 =?us-ascii?Q?QX6vkeqsxD/D06DLgfKrWhNZVKTzPvFkX+zKYn+wajgIrXvAqYheqMxVZaU7?=
 =?us-ascii?Q?SsoUJ6rqUCG2OaJu7wGJvs81BREMr6iIyQLfFca5XBbN1dHpjpQPZKaAiWPM?=
 =?us-ascii?Q?pxkG2Kqme/OARtv2jVMr/fA2V+RhlSmWjtd5sJvs/ioKU7kpla+H4bUCM/YG?=
 =?us-ascii?Q?jtOMMy56Dos=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0X6ipMKg4nwIVFHieLCFb9tHz/Y1LKDldZBSy03/DjgSKhfNtPkuMHhbzT2?=
 =?us-ascii?Q?IVI6WxoUk+rJCw1WS5CFsBEONIuxSsUh0Y5J43YBcrB1+iHr55R67IeqKmE5?=
 =?us-ascii?Q?5VD2TVI8+RT+/DUi+I0Heaswr1UNW6BsXuzeGfq0f/O58MJPQXMOda25I5Qb?=
 =?us-ascii?Q?BIIgzRV068iuMRw6/HhKS7zbr2aFJLmA2igeaUdjPTjcnRVczBx5b76r6Qqs?=
 =?us-ascii?Q?DcUIo+/Z6v2S+AkrfcZ2+C4MokrVTemb9GyQX+QzMVx6DfXDqUWPAS/Xzhh+?=
 =?us-ascii?Q?fdefszepYEdnSb4NXkAOSg2zVPZdWpI45Mi80DEY0HzVfziIYTiMkUXQ+C/k?=
 =?us-ascii?Q?jt1CYGCEky0FBZm4XLsu2ru7Y8hy7mZ6YnEdKG4fJQJkT4tX+K3SpTpGGJe2?=
 =?us-ascii?Q?G8fSQzPAl+8dZUJx5oQZ3gFurCdeYdHZw/7sNSk8ZXM+U7HbCralqPFj60IN?=
 =?us-ascii?Q?27vfGyHkTRhoyymIANOoAqzXI6Z2XJ935g9DQsRVuJ9NjL7vdA0t6NEosyME?=
 =?us-ascii?Q?Ju/B5OBikNLV7TwlLxgWCFngYuV2el0LkpxpJhIg9OV2aOuaI/711o5Fo32d?=
 =?us-ascii?Q?1HergqhLKhp8+SV1rYdk+F3gpGVzr94LmoVbijtzFonZ7fCv51ahPXCdD+xP?=
 =?us-ascii?Q?hRutub4j16it+wpE/hWFjXeHJi/dYTsv1EQ4RdUU1NBpJTphlAiva3AtdP5k?=
 =?us-ascii?Q?cnrPPA0K/SdnHNOAXzVy/6x8m8NleJubIZoPdLkzHkPv2s/V3nQEyzYF9F3u?=
 =?us-ascii?Q?WtjG7zNMNIdWtY5UD3AiwURO4GUSVrxUx2qadrH5A9s/DWfLIyqKsV3I+GqC?=
 =?us-ascii?Q?PvpCz/5L4qiVL/LH5SrJvbqny+q9L71idw2fni36G+eNwAMOxFQ+hZtGg7Uo?=
 =?us-ascii?Q?T6l8k+yCWln5HpDh0zACiPcpoQpqcVGnplvj71mtEx4hnglO3zNardlEM+GV?=
 =?us-ascii?Q?0ToI4iOJiHBoBsj4VPJfnWp1wSLG7TbrQeukhnozJnUHit+YlQwYoE+usniw?=
 =?us-ascii?Q?n+noGNGI9pBo6gT/meyXaK0DLB/bWqw0nV582FvQVwZ2zQiwUrGFG+o9DvtZ?=
 =?us-ascii?Q?GZkN9cyDLjuMjiaUL5H0uiPk68PUouj/xIItjNXC1R9LSnl06A0+Io0/im8j?=
 =?us-ascii?Q?ZCGnCEFCyM8QRo71qUjtvKmBBIPdethUJatWQwVCfvFfT2OsbcW6Vjp9YZK5?=
 =?us-ascii?Q?H1iKUdcC33jPCAoneRHiMLYMQDueAv15cBu1qLMecol9B7Ogm9/2TNXmLBL4?=
 =?us-ascii?Q?fu3EOaGbI+mHeSHYMKmLKemZpFHnAKxt/9oMBypTJ4lTaO8Obw1dlkbszfuX?=
 =?us-ascii?Q?fSOsJxkd3W1hd50zBZnTdluLwyhTuOO6cbnuoUuRcvpICI823DkjDPOm1EWq?=
 =?us-ascii?Q?ehX2K5x7mQRkzZlCi3u2LthWztp5qMa3CbiHz8Vh5L7JYZQuoCKXWEPXZgQM?=
 =?us-ascii?Q?+bUJupJWENrSyxHjsWZZSCQeigj++AWKuwtqK50Nsr9K41h9AqcmxqZeGGgT?=
 =?us-ascii?Q?XCNFwDDZhOlzf3N8I9r62+QltLhos5CeLxFPBxrUD/pQ1gxXoAHrCPH582B6?=
 =?us-ascii?Q?iqhLqp1U2aahUgF9T6qDQgYIPdYoxUnhxC21pNhQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0g2mDc92xF0snj2lv9jIOFuy/jWXCZx6NDL44PJjf1aGby1AnvzHzN/Ehu8I/ZhQh0Hq4320OWS+ScCD04/OzWWZLFI2xdKFwoxEJbg5+Ooykp7VGsXI+j8FOtKOKDuRr49VprSFJl1H2g2TaaY4jLi0BrlQTKYgkl7z5vZedYJr9F/StgtYhpH4NiH0ZsZl62GSyaMJ35jdI5Nfue6WujNoiaptt8oo+z0QkWG8tU1SKXAh4UbjXsE5sMEqa8ztwZHAtZTbDzqFiq7TROd3OXGFkLCP1S4uIAcI5rTXpR6prtAfIwQchXnmc8N2jenv6g93u79ozzRXtsfyV5QWVumKqqeB15gOOsDpTjkux5ni4t2wyYsNJChcnh5r+PLu2+i2KmxSj1rBV2wXPd1QZKmJhAZYjYhTada9C6+f2zmn1hAqSyAmOlmW/Azd8CIRHPjF/oFil1Ro+u6FKk1yJERqLDptvR9/OTFzg55GEEAceb5OWj1JEs9IJSOcBYoq/AIrto/Kq/xqc75WV6wtrf5NZdyBXr2uzKzqCGYg89RSON1H01Pkq02cUDm26rG83C+eXgLUuyvjgW8ciK+Rk3UgQa1Z/B2/DzRkttD+C4/D2+6t71aK+93K5GCizKUR
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694ea6e1-f573-4887-98cb-08ddc43d8df8
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:21.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlCVP9S5H6irvgQjKGMMYe1L4uN0m5+n/JdCHFxvHOuoyBMvHQR/6wVhGPwgFAen4VuYe/ClNq9x9ajt173z/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB1853
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: GVXP192MB1853.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDExNiBTYWx0ZWRfX1LMyYy23hFkY
 ujzqSfBdp6yIlObnvJROHa1LbtZjlQBdJ70nNNwnrCLb4vQ45JyxXZAvtVyS1LJjjoScXJHFJsD
 ipRfw8c9zt0iVFnOfQb9dRkPuY4NMg1I/ObTVn+O8m+1wQ5K4AKq66PzmmjoTDloIe72Ohdic8C
 EeqmDHrxbQQMtL4coawzEGgZz8XKetkAiUVrJ2l3MNQk7hd43aHetnrcZqMynOi7qYtJy1iISAw
 9JfcM1hN//V5xz5k4ZSokLSoUBmA7I9vsBMFi0KJqW2z9y+63aKaSZsKusw69R2mTX+0eHDGbe9
 YvFfGy4GO7LzJjzl4cjSo3/5TXs37DFmUsJC5N/3Uk+JDiZ33mDD5Pz0vjEj8CEut0leLKXlOrn
 NqPcZ7jG
X-Proofpoint-GUID: Ggpl5zNpcuCr_2QSWO9hHy8dH8PcWbIB
X-Proofpoint-ORIG-GUID: Ggpl5zNpcuCr_2QSWO9hHy8dH8PcWbIB
X-Authority-Analysis: v=2.4 cv=NOrV+16g c=1 sm=1 tr=0 ts=687759fc cx=c_pps
 a=1T+Jk3iLsGfRLyt5uBfG9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=J49g4d0EefnLm9aTGK4A:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI board data file download request message. Add
missing byte swaps wherever this structure is accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 18 +++++++++---------
 drivers/net/wireless/ath/ath12k/qmi.h |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 0bcfb9281d01..d18ffb86f7bc 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2934,9 +2934,9 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 	while (remaining) {
 		req->valid = 1;
 		req->file_id_valid = 1;
-		req->file_id = ab->qmi.target.board_id;
+		req->file_id = cpu_to_le32(ab->qmi.target.board_id);
 		req->total_size_valid = 1;
-		req->total_size = remaining;
+		req->total_size = cpu_to_le32(remaining);
 		req->seg_id_valid = 1;
 		req->data_valid = 1;
 		req->bdf_type = type;
@@ -2945,18 +2945,18 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 		req->end = 0;
 
 		if (remaining > QMI_WLANFW_MAX_DATA_SIZE_V01) {
-			req->data_len = QMI_WLANFW_MAX_DATA_SIZE_V01;
+			req->data_len = cpu_to_le32(QMI_WLANFW_MAX_DATA_SIZE_V01);
 		} else {
-			req->data_len = remaining;
+			req->data_len = cpu_to_le32(remaining);
 			req->end = 1;
 		}
 
 		if (type == ATH12K_QMI_FILE_TYPE_EEPROM) {
 			req->data_valid = 0;
 			req->end = 1;
-			req->data_len = ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE;
+			req->data_len = cpu_to_le32(ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE);
 		} else {
-			memcpy(req->data, temp, req->data_len);
+			memcpy(req->data, temp, le32_to_cpu(req->data_len));
 		}
 
 		ret = qmi_txn_init(&ab->qmi.handle, &txn,
@@ -2991,9 +2991,9 @@ static int ath12k_qmi_load_file_target_mem(struct ath12k_base *ab,
 		if (type == ATH12K_QMI_FILE_TYPE_EEPROM) {
 			remaining = 0;
 		} else {
-			remaining -= req->data_len;
-			temp += req->data_len;
-			req->seg_id++;
+			remaining -= le32_to_cpu(req->data_len);
+			temp += le32_to_cpu(req->data_len);
+			req->seg_id += cpu_to_le32(1);
 			ath12k_dbg(ab, ATH12K_DBG_QMI,
 				   "qmi bdf download request remaining %i\n",
 				   remaining);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 114324157e84..a48850ec0296 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -504,13 +504,13 @@ struct qmi_wlanfw_cap_req_msg_v01 {
 struct qmi_wlanfw_bdf_download_req_msg_v01 {
 	u8 valid;
 	u8 file_id_valid;
-	enum qmi_wlanfw_cal_temp_id_enum_v01 file_id;
+	__le32 file_id;
 	u8 total_size_valid;
-	u32 total_size;
+	__le32 total_size;
 	u8 seg_id_valid;
-	u32 seg_id;
+	__le32 seg_id;
 	u8 data_valid;
-	u32 data_len;
+	__le32 data_len;
 	u8 data[QMI_WLANFW_MAX_DATA_SIZE_V01];
 	u8 end_valid;
 	u8 end;
-- 
2.34.1


