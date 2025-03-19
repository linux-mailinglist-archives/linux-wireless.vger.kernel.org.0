Return-Path: <linux-wireless+bounces-20538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E6A686AD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D78172AE0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F310F250C0C;
	Wed, 19 Mar 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="hiLkj/7S";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Gx9BA/Zf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618B2505A3;
	Wed, 19 Mar 2025 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372661; cv=fail; b=d0PEJWNnMiCbEHJkyCyPdNqROHnIer55csTXWn7HP2u4sLma222vmDsd+T/RgkGRal+eZgS1QWyNEF1D2FUvWZLmhHIbQBBseaEBIgAvkoJnPbj2iHooDp5YwUfc5aHUU9n6mjGDpClqwxYTYyZTJ0JzecNWGBIL5KNGDpy7au0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372661; c=relaxed/simple;
	bh=ADXfxL52osuemykbbfqB5KRLllrEad5ylY4+IP4wFO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjT1D81iFEttaB82URbRDcPW/FyjRvASB7aXhS1H6Et+ajZ9Opa7vV8eRibAsNrz1wzQZlhRe7UKrq8NfKLG8T4w3hXsZlgfmR+Uu8omynCjm7xNlUDPEJ+jmwLNlHC7yowZqDAW5/w5Fzjfx5ffNCNB/y1QoCjwxD6FgcNj4Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=hiLkj/7S; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=Gx9BA/Zf; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J5bDHQ021897;
	Wed, 19 Mar 2025 02:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=aXjKxSx2cNkIbDSYbXwSNkuMLRIgG69+ClMJ68S1dAI=; b=hiLkj/7STNlK
	lSBrDYFQCnKEwRkGuJHroOFh+MzOvz6IJymAFqCXpdzvGm0kBMjDaNSbEY8X/UTo
	QNmVQphlpdspc3v+RqCYD2u9pLQeT/rpz+ZScLQOe2k+LK+9nHHsbAmVGpbfnZEZ
	OrQPVpPAVlPUZtXNNCtcbyj1249CaBMjVmFiGT6Wbks38qfBaOjJ5f31IBWx/ENC
	6L43+Ir944zkq9MbeiF5vTIANf9LfKzkGPxkRtXCEmzmNmRTwE6LE76TKL/kqnda
	ge3V13gTbEYEe24jDJKywTD/o2kHCIfcJxDPbQloc6e3h3NXZbo0ikMYL/lm4bk+
	B5U4EXSXTw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 45f6uyjwsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 02:56:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR70QFUiqdeD0sqgZOes+ouW1qrfPAvX3EiIJNuEKISLXIL/j/P6hB+DXFlbyY9QX4iC0CBqzRqMPIWgOGYJjzYZ6vwjHpLGl9A+o98MDATESWcW2o9CkErjm/r0z+dwAIDS9Bsy1uFSwphOye2sNPLBj+UecyT8SQZS4vCVcC0ORh4bzVhwL3M8mL/0JIZ1gS79adt4oEVBgmXaOQlTe7j1E+01wF3wFAzJrwRFyboc2EKRkr21FhpQjuwoRvIPbuoN44AooAMvV2RlVBC6fBavyGiA1ZhB+aiHf3p5AX/EddZzDAA0WhAMk+yruOJQ6VzVgC6XdVY6TfHpY6qdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXjKxSx2cNkIbDSYbXwSNkuMLRIgG69+ClMJ68S1dAI=;
 b=cX4C9hxY+CUd7KvaUip6IjAllYGV5Af8ZrUjLaO0BHLGFjSBrXMkfhyrGomZLE7g0Vm8+qNsS6j4h8x+d9+KCtvIgnWt0T0SfE8SgwWUxg4VeSuHritqL/hMkWQKDzNcMrWYH0ByIq719Ce8Im4bRYNsJdYZcWbpdeTGowZUkePO/iUyPyoHxXrzqkpCWqwvM9oZTGdr1OMOxENL5Ye0w40MKpjeiOJSBhiTSK+npVbe8EKiH43WUOEm+/a7U45NWV3eIVxv/UYS92LWfDTnQF1Ruo6nQqOqYu8rzhA5vSNXt0w4/vA/NJmOa3bh7v9SJApsRtvxy+ys/1GToF7xbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXjKxSx2cNkIbDSYbXwSNkuMLRIgG69+ClMJ68S1dAI=;
 b=Gx9BA/ZfZIBf9d64iVU6CYRhYClMwjT7JDgm/ShXLISzFkPTzVpDpda7Y/NEpGfk1reAJzTAYBJdqL6xRX84P5tlhUOTotA7bnIABCRgicyv0SPGmvud7gyEAqZ99AfhiOuON+FpmLR4/fL225t+oXKXkM2rEkdno1kq3oIuSXY=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DS7PR11MB6038.namprd11.prod.outlook.com (2603:10b6:8:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Wed, 19 Mar 2025 07:56:14 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 07:56:14 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
        david@ixit.cz
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>,
        David Heidelberg <david@ixit.cz>
Subject:
 Re: [PATCH v3 4/5] dt-bindings: wireless: silabs,wfx: Use
 wireless-controller.yaml
Date: Wed, 19 Mar 2025 08:56:08 +0100
Message-ID: <1942969.CQOukoFCf9@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20250318-dt-bindings-network-class-v3-4-4d8d04ddfb61@ixit.cz>
References:
 <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
 <20250318-dt-bindings-network-class-v3-4-4d8d04ddfb61@ixit.cz>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PA7P264CA0183.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::15) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DS7PR11MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8baf1d-af62-4cbf-fca1-08dd66bb8575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?w/fJ9qJUyOy7QwrKCPeDaRbfLUd8ex9+MOI4A5wn7A1K4JzQkQRw44Td2G?=
 =?iso-8859-1?Q?O1pkr5vC8/JpRxvupAvmWYFrgV+TJXWOlqoL8ahqgv2esnDHMpxMWzCuHf?=
 =?iso-8859-1?Q?QRl3jMCkhpA1uBYIx+p2w/rfkNkOr0mAQo87h2VbY+lOzyhQou/2xuRS4K?=
 =?iso-8859-1?Q?d1Qk1LqRDdRKfWQ9zZbcyX5xBjcfIq9ZcDZ1b0jG9QwAj5C/8YZghyxW3M?=
 =?iso-8859-1?Q?qe6CBVO3+42Zt4AlgucWosJE3/5/1asx4Czr5mOFcbJNK24oXu1adO+aqm?=
 =?iso-8859-1?Q?2hlTEDXsdrud5mPk48KCNkcTd/1mWB1Lnic1bfnd551eYv2un/dJHfaNDU?=
 =?iso-8859-1?Q?mmY7N0jZV4mh5p648+QCjAkyBB/dGdSyT3qA/TwxtkvVtfi0qw98RmZHeF?=
 =?iso-8859-1?Q?GPW832B90y6EBOsxMsODYr0cEz+XCbD0JYmLReuPSV0SrNBA0C15k3z+dK?=
 =?iso-8859-1?Q?55Wc1l13xxEnIbHf11e76G9zaealDr1CwajXu6AcE4mhOKhIGw83sZAf+4?=
 =?iso-8859-1?Q?b5HfVSv8l+LIkGbbz/bCdYmWg5cr9qyJpaI8ug8BXf/2Fl7iRMQNN4Bqcb?=
 =?iso-8859-1?Q?qayj5RFoqfdKy6rZ7M/voEF0xHcJ3+Artjd4O4xfpskp9Zvi4cs9AXc6ED?=
 =?iso-8859-1?Q?s4ESjd3YCzVQWBl31Yt8w6FX7XwHjIf38+kNm8fN/X0kmGUoJIytDkd85y?=
 =?iso-8859-1?Q?qsLuEDNurR3PXLTeR4TxGSJq3T2vZR+tgCbCn0Gm8hkVzEVOyIqZZh4p/K?=
 =?iso-8859-1?Q?2AM4tN4onpLKvoTQ2pcZkxUUJWyEFq8op4EGGUPn/ZowEm2V1cXdU7Ju72?=
 =?iso-8859-1?Q?WJehBl3NJzBFj7AM0dueTVcWHtM7eaIy30kXeLj3rMVQQrUdcA6Yxyi+TG?=
 =?iso-8859-1?Q?tP6hZo+MDL7Hi0F9fSgmvvzCOd95elgtbkc0Yh5rHZpwSOfB1HKee3NYpO?=
 =?iso-8859-1?Q?/Suv3eNa9I5SWX4tpC/0dIun3/6aZNb4Dn9iXZ6xudvD2O2oUkr6kmwItu?=
 =?iso-8859-1?Q?ZxwboHBg73mwETpI3OdovO9ACMTiFye8DqwryWxyBFk39JvY7wvSEGRYVF?=
 =?iso-8859-1?Q?Ecwb89+qw3j4aSyRj7PseNM38YnL29yoVrpzTKjPGKUlHBpmeWcX9pkADi?=
 =?iso-8859-1?Q?NYRLqIF8Y74LCHfa5vBZd3fVNWunC5xl9gINRwuvK9eF37+41IOsomNKXn?=
 =?iso-8859-1?Q?n6sS/bGQUcon7jn8uG3Zuan1E0AJhf8lFBqNu9QmWz2w8whI69oaKOtwqG?=
 =?iso-8859-1?Q?+M+m0nGr0OJDcRcJ1xol7D/KvK5XxAuLFInmrQu5yyF5VrCrjmZQyfOcz/?=
 =?iso-8859-1?Q?TVoBwcO03jvkHT39ct6YTl4ikJv0Ddb+2pJJN0934hFeR2kmc/NwZ/8l7N?=
 =?iso-8859-1?Q?e4jo7hhZbP61yzbbtOR8yoE63BWJ8d75+rQJG4EUcUKcyqNvZ/3OfESOMZ?=
 =?iso-8859-1?Q?SW0ybHoYYbdSDq22blhOdYipfINBNWOVFI+yD1R9loS9/yH3MaiNCY2PhR?=
 =?iso-8859-1?Q?e5OBgi0mrQghCCVzcT7ddg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wxE/c4wr5RO3dyUaRk48RQ1oQ2VfJYvdjdLiIMBc/KIbbog+6KHKikkz7M?=
 =?iso-8859-1?Q?vXCbcDnGCthHP5fpORIqj+UAIb1sRSMH67Zv4+uciae8EpgbDf40ZDsbz8?=
 =?iso-8859-1?Q?/QMbn0/GRUEUmV6yLoGLBVzWDV7m4+eegsnBq23Us9b4p9N6LWXhprduHi?=
 =?iso-8859-1?Q?GrFwpfbO4vSBEHCBlVUxdo8nc2AwMc7W3L8nxTbaDMfFZInr7OWDPwClN7?=
 =?iso-8859-1?Q?RHeOyAXC+MGLxdy2vqvt/CVJLqUQZwuPNEdkLJw4mWc8YjO6GXlmEucP9C?=
 =?iso-8859-1?Q?R31FHMjQ12bYFZ7T2k+wJZjBtSS56O1BaMV31DSF7wU8bxvE0ctllh/tZ7?=
 =?iso-8859-1?Q?y5EGtyWqcgSK1wUoOxRnuBbGGLHb8kdURVpGx/evZOcBh2yLsGpDOyVku8?=
 =?iso-8859-1?Q?RgWF8+HWrmrFdmhsvkYpsBATLPncCAGkfxwE7CUqnX5awCSpdt5YwSa9fa?=
 =?iso-8859-1?Q?/kHwTJJesZY5bXedURxDlAYwSRetbiP0+pfsroK3y9MqR/vWo2lHdl2YK6?=
 =?iso-8859-1?Q?WsRg8Yh4gkb9lKQwvQFZmAmrL2RI7bjxJtivjP7FLQ/ACOThwek5hqI17w?=
 =?iso-8859-1?Q?8G3DNAxcS4WAn4KaNmvN6YpV15q7e/f7Ke6Ub5yNuwz9IB7TfgD569/EAt?=
 =?iso-8859-1?Q?jGN0GElAO2w48tgvVUS3/AeLxP0ZorazvWnyyB+M5+jOqSuFTcn5bzk9Km?=
 =?iso-8859-1?Q?LIPZGw93dN4igoZxbAP6gtF3JNo89st55lmsnFbIcBvwksSyItFIXYLDeE?=
 =?iso-8859-1?Q?oa3W9hgqgjUqCI5ii2vKTOqkHRhWRCRfRMV6gdnj1USOF/TBW9Zy3RI+pC?=
 =?iso-8859-1?Q?bmg4DWNfnG4OGZzCEydPAJWLte/j+abXJoc4drJq5bVApuDU/U5s/VX43w?=
 =?iso-8859-1?Q?M5BBvnZNLb2KJYIkDsblf+t0UV/N7UthgpPQc+PEjwLknhh8dzGHAzWFCd?=
 =?iso-8859-1?Q?Z96BxVygBLUi9sWUufmuYgsztjUh+oqYe5PObSVg/oKSzbAhgTB7pz3nXI?=
 =?iso-8859-1?Q?mHohryPSiMCKBUF5HuTycvQ5ko3/x3XIPOGej1ik17L3PUH622VIAJkO9b?=
 =?iso-8859-1?Q?GPPkpy6LYO5runKlNIfj9A0jf/pnFCCobhexOAZXaxGUj7f3Ir+kUYc6be?=
 =?iso-8859-1?Q?HD5mJbyPfaLa34SKvMDPWagVh0oxojz3RzR4YTYCDrumxumqsLiETymg2i?=
 =?iso-8859-1?Q?UBjQHINuEiLLbUUvaBnRmDm6hxveEeVI2ipD6BbcLeAHXuP+Jfq3E9N4a8?=
 =?iso-8859-1?Q?2jV7zzmSWYk9sL3t384VoZD/k9YdFLO/hFqI5DueT2VhRGJ3He2Kbn8IYW?=
 =?iso-8859-1?Q?b6hAV6wB4ByoXoezSAYXUaHBIP9ik2vYDugwvfgXk4j8v31/XUS/Qvq4LD?=
 =?iso-8859-1?Q?coTEK6TUpwbK+FGcnS1QocpKYUHqKXAIlvT0IVlKCGXa0PsZPRuI5Zgf3i?=
 =?iso-8859-1?Q?X+OEIx0g5VU6SyKg8tf5YRvrcafBLMzqmjvix2V8s0/s5fCK+HE+NstrOZ?=
 =?iso-8859-1?Q?Kb75+brX4nwbHaXJUtsJiGt6gaNprEwqqzNMV42mu6bdZ9CC8uT7p2AGhY?=
 =?iso-8859-1?Q?kokD2UYw5UucXjyHO4fU82DYeXV2hiq2ErANLfN0U/hNlnVlb/e087KEGJ?=
 =?iso-8859-1?Q?hL29nOzKF2gEM/2YaM8hwa6+mH2gsKY/sS?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8baf1d-af62-4cbf-fca1-08dd66bb8575
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 07:56:14.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+R8r2Sx+1qi//jFEz0N7Yw6mc5AetJxtlg3BPpSisTbxH6Swl9OM4TTvMEH42rEfgmM3egRgo1FcMbnljAodA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6038
X-Proofpoint-GUID: ijBlJtWkPx5M8bHmp4ghweWQ-CVhTnWw
X-Proofpoint-ORIG-GUID: ijBlJtWkPx5M8bHmp4ghweWQ-CVhTnWw
X-Authority-Analysis: v=2.4 cv=cqibk04i c=1 sm=1 tr=0 ts=67da78a0 cx=c_pps a=PK5aExQQjalka8oDlC/sVA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=LLPZWm0_0O8A:10 a=H5OGdu5hBBwA:10 a=i1IsUcr2s-wA:10 a=dOLNmq4gAAAA:8 a=2AEO0YjSAAAA:8 a=rRI8ZgsEhHcuGE3BFJUA:9 a=wPNLvfGTeEIA:10 a=_m6CO-mWuQdSFutSHjXj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_02,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=727
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503190054

On Tuesday 18 March 2025 20:56:47 CET David Heidelberg via B4 Relay wrote:
>=20
> From: Janne Grunau <j@jannau.net>
>=20
> Instead listing local-mac-address and mac-address properties, reference
> wireless-controller.yaml schema. The schema brings in constraints for the
> property checked during `make dtbs_check`.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
[...]

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller



