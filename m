Return-Path: <linux-wireless+bounces-29810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBF5CC47E3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71B4F302A1F7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E316A395;
	Tue, 16 Dec 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alumnux.com header.i=@alumnux.com header.b="YNid6Oow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020083.outbound.protection.outlook.com [52.101.225.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDB3A1E84;
	Tue, 16 Dec 2025 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896811; cv=fail; b=Em7zun1GN8cBsfelpbZzUvOBQq48+Qkamrm8bGQNIGgd7KTHfcUIBxJIuJp+xY813A7PYnnvfclc7qFBJ7pokw9NI0rH1wymKoG2Kztx76ZifLpshP2bWBeXU/xYm88Tzeen2kCIKJYuhZJuoMXR3zunSgWtTPMP2/c90XiN730=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896811; c=relaxed/simple;
	bh=6Lh5fAXpCmyRZ8O5TAPJSu0BDCLxM0Yid0gqVrLQNt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWINcogqbOovbEgWyQupBM1RIc8T2WtgXYMuK31zwcANc8ifIkg2mbdfoemqblRAmFa8TA4EsuHH2ZVtlaqQwCrUu0QQdW7jJG/0iLFY9R6UbU+OH/KCHO/NymkKr97kPt7gkOyh0K8Q/MWCaSJYcJOHOX14/9JaLinW/G3Cb40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alumnux.com; spf=pass smtp.mailfrom=alumnux.com; dkim=pass (1024-bit key) header.d=alumnux.com header.i=@alumnux.com header.b=YNid6Oow; arc=fail smtp.client-ip=52.101.225.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alumnux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alumnux.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1EGPxeRraEzB4KO6QvLRx0y2oTD/qe507NyeCxRg0nqB1bGSFOsWPCDn1s6d0VTY0aHHvvNkKfi27eS1ejQWV6Pi0OYUqR9vPXdrfB1gb1R6P8dqgiJPUeblqNL6/U0L3zJM2vn0YNKel+4NYNklktuqDk8OU3Zu7ttwXCP88jHWNcgNputJcrZ4CjrFKCQdosD84J0taolL3yoTpbENznC7SABOLmn8ssap532jzlXIUnN8iaV/u6jNMKtorlE1Yt1EWkgmbmOm7pJA774pvvOihikq6q43HNthoahnc7/p5rs+McMYjU/8eb6DED/j3S0pSjy3dKSPHQAfvwZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lh5fAXpCmyRZ8O5TAPJSu0BDCLxM0Yid0gqVrLQNt4=;
 b=YXz4anizmZiWjpedwR1Xw5wlu5E1u4mB8JYcOBLosu5wUXOA4nEnUva9o4/jm4R/bxtr28Dq/b83w4LefU769MapaXfRKM/RXSgShUmuUq7qZcxEN+IL4wzwkZRDI04xkLkmJDv2NgHl+jgx6Pjum7mGYLRKHbIfvq4MiQIvjkufTfAnaCYNmmQRE5LNFxtAEky30YZ1wFk48zmcMKurkHeDmGSSKm3FLakeZi99ZEjFwMTLKrgFGVP0PmHdJAlbPU3csIHgXVOf+gZxOl0RPRFwlR0Vy/0hd2E/XBxwUC0aw+zl63Hjiw+ejrDvZx2Smy0rIFCka7y3llcCKsrdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alumnux.com; dmarc=pass action=none header.from=alumnux.com;
 dkim=pass header.d=alumnux.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alumnux.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lh5fAXpCmyRZ8O5TAPJSu0BDCLxM0Yid0gqVrLQNt4=;
 b=YNid6OowSWUqveDCcpA/SL7TJLgeRQIgkXX8ZVXgnPUR34z/Dz33MLFGsdJtr11D2X1bt4dYImtBS7kJI0ycCR8aqKPMf1QnWHDQ79l0PE2eNglEKdQIF2CJHzecoPaYh4aYI3cFYOj8znqwz9B2rJQBk2CMcnZkocn2P5ZXrhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alumnux.com;
Received: from PNYPR01MB12336.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:311::12) by MA0PR01MB7905.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:8c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 14:53:25 +0000
Received: from PNYPR01MB12336.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fb02:f7ad:fc35:cd44]) by PNYPR01MB12336.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fb02:f7ad:fc35:cd44%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 14:53:24 +0000
From: Romit Chatterjee <romit@alumnux.com>
To: jeff.chen_1@nxp.com
Cc: briannorris@chromium.org,
	francesco@dolcini.it,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	Romit Chatterjee <romit@alumnux.com>
Subject: Re: [v8,00/22] wifi: nxpwifi: create nxpwifi to support
Date: Tue, 16 Dec 2025 20:22:51 +0530
Message-ID: <20251216145252.431-1-romit@alumnux.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0080.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::8) To PNYPR01MB12336.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:311::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB12336:EE_|MA0PR01MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: c5622ab1-f084-4910-1db1-08de3cb2dd4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Nvn6SrU0D2NJfExNfN5fC45azYsfdXviU9lhQ2IGaHi+0yLtZdtognrDVLi?=
 =?us-ascii?Q?8T68FUmbXyW0HMlCj4VezLzmojKwCz3tRJ6h08SsWq+qibfbGTgwO6Q1dSyk?=
 =?us-ascii?Q?UeqZyyUs7SZxyjXNDU/8dprwdeCz4GWwJhifoeQAZNqkt/WFc1aUBiZrT7Pe?=
 =?us-ascii?Q?dWJ9jHIriH/G/CtX8xKPoJlkNRyeHVpb+k27NUYAbjPmQo01dHJz5XrLxJze?=
 =?us-ascii?Q?4Nv+LQvOPzpp+NYsSWk5WtGTrMlIN3orODf+60L4Mmp984e77PMKktArJ5rE?=
 =?us-ascii?Q?eBNU0cKfXRjBkQVI/74zu/hid2RVX8/3JujvyJAqZy0rAp2wbMLnBjZmvtby?=
 =?us-ascii?Q?zXfT/p6qMfxDHa+wBztbRPhuxgT/3ueOYERU0tosHu56lGIp52KaIR4K2sxg?=
 =?us-ascii?Q?ogEy7AUK3i1gzUonJ2jxE3dkORrhjoQFLt4zjsCQ2U6XVxIFcLcmzyoS5f0C?=
 =?us-ascii?Q?Sa6i4NEBgriWcz9pN2B/B4gC+hJFulHY4kuBbkTWdo8MiNs7V1M5dE90D8LP?=
 =?us-ascii?Q?mztZIXXPh6mVSz0XYe/+btUb9vh80zFJ7uSnw2SAxlqHXWdovg7Qd1ASgxOR?=
 =?us-ascii?Q?6PMfRrN1zFxplfOOIPRgMyYNuEBuSuu4hu/E4I3aWbRzM7c3Gr0vsl/G/JNX?=
 =?us-ascii?Q?SKCjTEbajpvWUqB+9rgeKeKhEAA8fLFPAGjmA13U/IJP39sHeRPAlHj21p36?=
 =?us-ascii?Q?CNEPkBRcZnDBQcAoIBO5EFau8VVx+kPWM6uU5BrYOPR+6BAUTfi4cbLIdQmN?=
 =?us-ascii?Q?1ucJepXjJt9VyAIjXQk1gztYs3E0+zl0w37Js3zb6CetPUgmu0N2IxLdVxWN?=
 =?us-ascii?Q?JV6U3Qsw24ArgUKOL9dRqaAv0PfmYjYeNocZE8BYl5l5CJEfvkc4U6kXW1n+?=
 =?us-ascii?Q?GXhJnVokgxf2lMRiqwNe33wA7zLIPOpJrUO3Cfh74Bk7fe9S+b+kSjNn7xSA?=
 =?us-ascii?Q?WGAGfbxI5ulgjen494UCpl3a8pz7W8B1QiLPDof8xXsRMa2XWPHPHLOiImZt?=
 =?us-ascii?Q?+2OmKlomNLgBunT8CSy9eMAMs42wUmSFyPJQ22IPXCtiVqUuQuX/P8LKwZLP?=
 =?us-ascii?Q?YfDXJtW2VmZOKOoP3pSPvmhlEzt5fYU3Sy7yUgojvBDvQrq++Qsgz5rivRPC?=
 =?us-ascii?Q?PXM+mVnnpRfYL0mSw3mlVFsedrxxKPG+890ouugluY08txcTcI3udAzyS5rX?=
 =?us-ascii?Q?2y1WMsRWb4f8tqvXYDjuFE7U63dBwwJHZOpDaLx+HcYVqlfwS+Uc3YgkE0Da?=
 =?us-ascii?Q?jq1J/rgNNjRoVtNdQ+8kn2d4xtlNbJYDW+G5YejogASFcm4QfqiD/CDpW/Tb?=
 =?us-ascii?Q?MwCDZxK8QAO2HvBOKW9eRF8Ax7/rbWLfI/7PA37hJtu63v5NlGgbW/kyO1tI?=
 =?us-ascii?Q?OZ00u3jJhqvjR/7RPohlfkOuh6tj05AwLoMyiH7NzXZxiZhfk1Mb1EnjxNG7?=
 =?us-ascii?Q?X/s6/JPiJlxXJY7zMOJtYWzw+8arUfvZyAp+nrQpoGvyycQirZGwbChDFnup?=
 =?us-ascii?Q?+3oDSCEEy65udXnvN99C1VU0CnEhNugB0XHg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PNYPR01MB12336.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1EBUVoG8wvqPRTEpRLnFGzAUZCkwd7veo6Z4RqbUxqtxuOGE+92EuCQkdrz1?=
 =?us-ascii?Q?5qoIzqd5TwH4bvwhHkXOIU9Q7uVpxtR43AGmBgnpVIxlAQ0tQEJ/6pSpwKpR?=
 =?us-ascii?Q?p+Hu6o2NFdpgfZLmSWLUIRMb9i0YUOstSU+06L+tw6oPL6qMx5ijORaHr355?=
 =?us-ascii?Q?T5UCdj++dZCk0PwtSVOe2l9/2AgzpOO0Dv+S5QrkFQETj0vLF3wAKujR+uTX?=
 =?us-ascii?Q?yRTMeoVP933GozkY4DtrOQonzKRZPI5zQXw7wwjfVmOaanfggcIlDMqqXsqQ?=
 =?us-ascii?Q?4PN9xwJDvflEMmUd60Pvum9KXInoEAOZIbOHLv5u1KWjJ/u0MzUYhTn+ltql?=
 =?us-ascii?Q?goOOJ1Gb3BKTpP8gTsw8v3GCvWnkDG+VZkHz4X3ljHnreJ44Ht0SVLM2geLJ?=
 =?us-ascii?Q?REOs+yn5UodJs8dac9NfKTy8rB0mWnP1jDDNhHtvz+980Law0BtuDhtsT+P7?=
 =?us-ascii?Q?mzfOU4YvX/LAKVFGTrtUkJwskSBpsx3+tiUIR/g/c0eR5nBLHYQsH4ANYAgQ?=
 =?us-ascii?Q?5NW11AZS/Uslhp+vgWk9aQatrCQcnv1MKCxim4PywUq0U/cdX18+A9LTO0/Q?=
 =?us-ascii?Q?nA6QLsdx5+rmPNlgKa58MgzWmA6gGQcBzIpqxtuXyWQTJ+D8sWr54B0S5Slh?=
 =?us-ascii?Q?f2llLuMg6/bWMMEbjrMHVlsGSGuEeP2/sQMz3VCh/FAIna4PkVnusWjTwcaD?=
 =?us-ascii?Q?6MY4XVpoAcl89E11ZKikTDllvMtmX6W5MCbCib6PoNvE4sepUAdMIVEjzLYA?=
 =?us-ascii?Q?9ir2fMF6pcwJivaHDKG3RNODj4HIqj1ncDlgUTnXpkDVzFOFN3y+hKobtjWc?=
 =?us-ascii?Q?pm14Z6mJdJak1HeiTtbNJNX5t/bDqSl3w6+3VBY2kfza4ZPFmf5ytZbL/g/V?=
 =?us-ascii?Q?XglHVHvndLctvTZBLF+ojgoLJMXe3nIuHYmstSAima8T+tIFbRqK03DfwbAv?=
 =?us-ascii?Q?/1cOv2gNn+j9+zq8ZlF0ye92+azij02px189rxuojPhaums7M5UW2gAxJ5HA?=
 =?us-ascii?Q?hndZwb+DV5/uQ/+1/qBO7Q1aqqqd25P7s3ahKvxLAwcgeuk7qrgTg57/0vy9?=
 =?us-ascii?Q?gTRZFcxHoBvCh+BtGkTg8lGwb4S56xLdjjgCoKV2yJQXVGlEaxaELzJ7coHK?=
 =?us-ascii?Q?VSjLE+TzD01eykUvtQ3NPz3RDsEXDFvGCSKbobq+6QUZ3sQptE3OuRpVYDTN?=
 =?us-ascii?Q?W/W+0dCOS2b6tktscZkBNqQA+E2hE8tcnlUZX7S1XyPDKU2mc0Jhxlkv5cox?=
 =?us-ascii?Q?06lt+9e6qoW7wxVlRqWsb3LbIMLik45pkObmYK5Bh9aoSrOhvpLqjwINaflI?=
 =?us-ascii?Q?fh7ROxBBWglr51wtFok5Z2ABq+gwUuphY9eygQvW1IDBO9NH5KkOtWzimLeB?=
 =?us-ascii?Q?HNy7aRorI9FtPgQLGE1WrIZ+qib+ykZCraGYR4VbBeD1xamYeIkAE7uojLWl?=
 =?us-ascii?Q?Gs3EYFRQ3R4jfmGEq+5yXkygO+DZ9wyve2nyFcd6yQgScZanUaD7kvW+58yr?=
 =?us-ascii?Q?jDZ/WhHeqhducL5/eyYiYmFmC07Ez9iRGah/uOid+NgCJhlZ38/ZaHICblQD?=
 =?us-ascii?Q?xvihFu38neoLJ29DENqHRpiMbL28JHoZniTXSJHv?=
X-OriginatorOrg: alumnux.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5622ab1-f084-4910-1db1-08de3cb2dd4d
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB12336.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:53:24.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3fef5931-0c12-4eb9-b22f-ffd793ead03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+JTkVoWY1HT1E1ZFfrv22I0PlWCILXb3aEUXgnyzdqsym1SRvl5jRAzgN4e3n34GVqtzqpL+++272OAGnwJcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7905

Tested-by: Romit Chatterjee <romit@alumnux.com>


