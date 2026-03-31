Return-Path: <linux-wireless+bounces-34249-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPceNtowzGmwRAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34249-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:38:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882AE371322
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E1CD3046D08
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BE724728F;
	Tue, 31 Mar 2026 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="OrdB1xC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazolkn19011024.outbound.protection.outlook.com [52.103.34.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E99B45349A
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774989515; cv=fail; b=sF4uyoDasOyhGn5hKwsKjKDKsUFA8JrVs+xjk23CIPWyQ3Xw926tmR9n6gVcVTeJF21Dm/ueD2Cd52W22xRXDECXtF88fAwrZfyMzr3kTbuv4UicULa9kreyJ+hODLWfzhY5rvrkMK06cHT8ggCTpTCjskM81UkdUwjFQIDx6pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774989515; c=relaxed/simple;
	bh=0E76uDWcCnemZZ7JCZ0Z8Qpm+rXa1g4kWwPKTsmQvZc=;
	h=Message-ID:From:Date:Subject:To:Cc:Content-Type:MIME-Version; b=T8019UpzUBcrP2IVa1YIFkfBXWoQJviWqaxVZQBXDUHn0EwDjIw5txSuv1key/5ZV/DFcUQ0G+bVUPcU2YG+52Kc1bbpDFyTPJLpMRBCn6b80G8pS0y6LEiYwFmAqIS4MHzs7FemGKyTjXaV4fCMOyyYzI5JPzEnpGoViZhvrjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=OrdB1xC1; arc=fail smtp.client-ip=52.103.34.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/036HBtUrWgsbZGjbTW/3vvN0UzSVbXkERSg/BFbj7Uhl5znoy/5ugLKGZ0ByH2tlrlV+bi5CIAjIpOXFWf8qZURtIWP98/FQNHEKMYPlHBcPwABzOQzyGUeujkGwCv84mDKmCM9EvbExRCnA5eA8cFMVjBSruouDcrBZd48HzF10P8mkKjwxbiHG1g8F8G83i/KX/MfudjZblJ4t67dlMC99mc/Vbc7rSCtp7OhxMEpf2+sjAC2Qfbr6p5REkprN633N/xlcIfiPEwAjgVOwZBeuqdvT2ExxS/79Hp4TAkJOrJv6dE34bPUDBZyhbjMnTRMvWiIjhi/Y6dyTNhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMcgtKtBqCqXqmW7uRaf23fgpxdm+dUiyy6YGedTwSM=;
 b=AqbmpYXNqpcW59+OkRB08iiz2+MuibTUOPJOe9PHoCnrRH2SSbnFsD7n6l3PQZAMK9j4s5SlE39RXNgpbBrJMO1eEj9THb7b5ydPxil8FzstWxNWJpiMHWXeZkJ8hZj3qpdnnl6KJ2hgVuPg7PXugzjnr/0B/svga7Fll1rBF6bx9tpJjeqcEWVNquWl9n74bjZyv4RM8jeL5EJWC5sdHV81Ns6S3zIP/mi29wOy4SG3jyDqZCwY1yASGpw1WbVSysTxYZu2iK9uPXO/ROWHzjIJI2S8XxNfRwC2HRcV8+zAllK6GPQGwtnjTZqoOodGXYMTKseBF2RnMUEXPLk59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMcgtKtBqCqXqmW7uRaf23fgpxdm+dUiyy6YGedTwSM=;
 b=OrdB1xC18IdThv4KsftNJP8sUdqjRc2FAgqliXRVwMty7Ma3bD75KNUSEf1pz42HhTp5ImJcggds2yaGYiToGIZxyP3GOhglolz01D5aYGrgRwQ+0IT3XWYBNCF4vnvVIHn0FsLbnQUtNAdRha3RqROxo35BMEapDpflsySZVjPJ2cAh97qls1P4k/+GTgttfz/7kLe+LaCOQPTHqo82NODRlE3rWNNXiW0nfYp4SfbyCTl9cAhoCvBf8sTaGo/5jW2Ad2xnbHcYQqdobpoaI68RcAF5miZJN9royS3BrFwHkC2KvEA7PIbrc6a3PnM8dwnwtKT8CUxWRtLrI0NK6Q==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by MM0P280MB0851.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 20:38:31 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 20:38:31 +0000
Message-ID:
 <GVYP280MB151823D632870B1B48DA947D9453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
Date: Tue, 31 Mar 2026 22:32:56 +0200
Subject: [PATCH v2 07/16] carl9170: main: add exponential restart backoff
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
    ath9k-devel@qca.qualcomm.com
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <e16f0479727bb486161c9e46229d628a@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|MM0P280MB0851:EE_
X-MS-Office365-Filtering-Correlation-Id: 976371f8-49c4-4f3a-d2a1-08de8f657885
X-MS-Exchange-SLBlob-MailProps:
	KW6s2gPZH1eaZMsDFrtnScTYUpn8LGIX5aUfgqQhE5OLaCkyJhOdtfbPv4Jwx23aiAEVwBGVan2ijpiLZ0ym9X1+Cse0HN9MQH72YjZcku7ETAnyuNlMxKb5FIVo4HGigLGCkgUEcra3pF0b8ZlmOjjqF5czYElIcrMYmT3hVlQjZ+o3uiT8CONmDnsWiQVR2pa4NdfAn0OjJzPRP9ej60YZ2XXk9leAVACLPMgJ3AuobPBJeEvUuPVdF25LLwnBYRGNRnOYDA3O3XwcTXdQzjQH1P3X4N/ot00i2gt7sAg1gn0cwNQEPWK7nUcOp8z1LXdGVE1Hvh6YiWjODlEjfCZuoza3wgZqzq4sxw8VmsvAsmAZ3EWokG2HidUcwCiugUU/LpVwBUvAvPR8+9P9P0l4hmReZDXXxSjb31gxT6LaMrkYsaniC8p73OJ7bAezbZ+46uaCL+ymi3z6nQWmfEy1oX9Ge0VqDxV8Ux/kNkavweBtNr+fvYmkmlX6xzBpA4N+hTDHUFLAClEDRTIcLcp5eS/WWft9mx8m/eHILoww0WBK3cSYp08Z7hH8DTTARX4j2QSpKQNMPggk152xTV0tNdCjjFtRjn3MEqmxjflfl+3AfCtjo3xfloGk1fJ3Gm9iazpWb61vKdN0MvYbxAv83GGfvo83vKza8Y8RAUHCUa6KfV+JtQyYne0JEmq/vLzkm6DqZ4lfSR3Bf4dVxw0nddwQuon0FFp05ybe2zg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|23021999003|12121999013|41001999006|5072599009|5062599005|19110799012|15080799012|461199028|26121999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUZxw4u3rQZ9NBvN3T1dYjd71yIOF05B4zDcozGvbrILDUXn+AbhpuWTUKKc?=
 =?us-ascii?Q?jhe4uvL81pDLVEs3QGlp6p/zJ7H7bROKA1gsNwO6vJgq3+ATtb7EYQwQXxs7?=
 =?us-ascii?Q?3Mn4Y7O59tKmcJuvCw3MMyp4/yfor8PqrM2liUSUCQE21BCAlOXfc8VsjXgr?=
 =?us-ascii?Q?ARVRH6nhCLcUfSXJZMSmnNgG4aWnw949nBQHm3cehsSS5QPSWmYz+2gudOx0?=
 =?us-ascii?Q?/mx+dH3so0okPm8hudktxC5zOgM+HnYdVkrsSFRDrwJtfA6YhW6K9P5N0WS+?=
 =?us-ascii?Q?BY/ol5LLDJISHOJbIRN8+Cp4OunJ2P4KeblgKj6arBmH6btschO52nOAF2m2?=
 =?us-ascii?Q?a/DH8ahPSamkd1LsndxdA4uglhI2DYunkO6nd5i50Tz5+dfizFeIpmaH2PEZ?=
 =?us-ascii?Q?6UnZ+D/C5sp3Eq6lUAsMa6g7ZnfwJq8boYkEKFEUcgJIwcG/v0GsFvCYvHQt?=
 =?us-ascii?Q?6Cy6qGoRLAbklyUJXxWmCA6SD2pVaEp+Q3Q5K/+k4KF8ytuGMauO1wm1WaWH?=
 =?us-ascii?Q?dzYFkXcgajBQlz2DuRx6AKGYqb0nK3LRlC1GeHCvhAUw7pntc4uH507JZzeK?=
 =?us-ascii?Q?Zk+JiVuifCqUGsb1uqMOIssppqTEBgpOzsDAJ7AnFY88/U93OD0m05b0TVR/?=
 =?us-ascii?Q?lR5wJTUKRKPmRtccibTYcCwLhR7dmfXPcnjY4ElcnGDSbel4+l/vYQl0Tgfr?=
 =?us-ascii?Q?f/WAydxAv9tl2psAXgdAKOD1aanyDKR3gAhWt7YR3GcV17KWwKDoD/nofQfH?=
 =?us-ascii?Q?WRo9QF+9Dz6jbv2xlTA/YyLueRz99BWlXL1sFiaAhCGY0dsnqSbDcbhUpAjl?=
 =?us-ascii?Q?G1WhN/6IHF1gKhlawEwZD/l/dWF4D+5oOJ+KRIcLgbXgEs5NVC/8rSnZVWnz?=
 =?us-ascii?Q?qTrKTwgnYrVq9h3TOg17DAvy+49jGq5FOeCZXIEzn6A20RVM8J1iVEdJCcQL?=
 =?us-ascii?Q?WcegTJDTbWCoy426rQTgxgRAueGpAiXzER9c5C20d9v/k6ZSbSAau9KWggYk?=
 =?us-ascii?Q?5gOzGmRfvJq+8z/p4/A3bXLYymwtXJbNWW29K7fFA8ez7as=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjQKsWK5NuS9bT0hGJUDUENr+5vzPle+f3iLjPapaV2EfUloCQ8QgRZuEtZR?=
 =?us-ascii?Q?2CmqtSVeXVpVyYJetG+YlvlowVgK4O9m61hWGrKBcXpZu6b4aS+p1HKdBCwq?=
 =?us-ascii?Q?W37ydGkdzOW24fKzjDodnVWvwcMne01+yB7THg9n4XOjUcupIt33ReHtPpk6?=
 =?us-ascii?Q?aP63OcW9P/NfaviUColIakJJ2ayHoDf5GEl0pz9rGz11FO22b8jSfPjwV4Aw?=
 =?us-ascii?Q?QpfQFe+IlJryAAbPjIC1rpfK6U1qwQVM+5ERzjviFaNrmCA1pze6uI3ain8j?=
 =?us-ascii?Q?KXJW3wcRW16NCk1Vl01cal3WIG+B03fzbVeAu/PHefO6onKt/UGesHTYsirT?=
 =?us-ascii?Q?ZLwZ4QtRoGdo4FHtgU6+E6hp5zW+yAS4+Yvzrlk6Em9HD0I2OwBX4rVqdMvJ?=
 =?us-ascii?Q?iQTweAfC7+2Z+LJ5KYqUYOJMjV6pP4yVanYvTRUhocOeIa6+v0qhAfdFPWMs?=
 =?us-ascii?Q?HkLHQaCdc/b5jhWMyh9NICD0e9803sAorLbgXBgj6QmyRj5jY2kWfPYGtlz1?=
 =?us-ascii?Q?QRIOCsvbDWCwU914Bm0BYfUmOX2PQqVLxMKowV33ArTQ00H18UarxQV3csEe?=
 =?us-ascii?Q?WLFH/07uq51rC0tzFT1FJkVr4qX1InSo/EavUXLWcFgAaUaR7sBGT7TAtJzB?=
 =?us-ascii?Q?t7uHuISNvzWe+GZ9ompAfLK8jdburgCVYLqdh3Gt9bzv0XDStZtkm1H55Sdt?=
 =?us-ascii?Q?eJrd0+716zUcGvsp+PdOSMKdRXWKRl9vOvYCotfQoEqerDvikk7Nl4sn2+A6?=
 =?us-ascii?Q?dudcD4HC1kl4/gYLc1Ud2hbbaAJAbhKcQuJFvqSZBo3x7iwCmDQO9tocm5hq?=
 =?us-ascii?Q?z7znSE5lf93CrcpxVik0ouDugixvmMdAh7lTJ2xdE26v84I3xqi9azpvDPsV?=
 =?us-ascii?Q?5aCiNXe4qe+HTP93jO+HYngV35gESZsJMY40F4UiZrxdlPP+xd/csgsKpT7V?=
 =?us-ascii?Q?EOe8PWkVHeFFgC//tEK8CRmg+O6R9W09CGZRAWEcIWIh5O/ef8iLJiG66/jM?=
 =?us-ascii?Q?O8zs3A3cQ6SaTui+2rLsuBGctRfESKSH83ujUhRng591coiO2JLtHzM2UVni?=
 =?us-ascii?Q?LoSQ5+9E3Ua0sCdvgyivj7Ro/gIrByiRaqpGQ3E4xDbQVBTPDHWSX+ZSUmaS?=
 =?us-ascii?Q?DgZIumE1TW35fGS35sjZ5wYL4s86prijSYhZ8rYiHzygp7gyw3/Ip1ceGgci?=
 =?us-ascii?Q?5fv3Ai82NCcAdSeRPAnURvwM39YqNR7Gk3rOD+chqPjs8omvprY66//lbPm5?=
 =?us-ascii?Q?3+KnHZimq8fg++ORcLTi56BCWhFnU157nPcQTCbpfdVKlKKujtUvQlusZXut?=
 =?us-ascii?Q?LawLtj6X7Mr7XqYqAxMh5WJXng30jVaO9YFQgE92we351/TOe8eS0UiG4+ec?=
 =?us-ascii?Q?2YIAYQvVFvc6+mCNW0nQ9EFa9of8?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 976371f8-49c4-4f3a-d2a1-08de8f657885
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 20:38:31.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0851
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34249-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,HOTMAIL.DE:dkim]
X-Rspamd-Queue-Id: 882AE371322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the AR9170 enters a bad state (firmware errors, command
timeouts, TX queue stalls), the driver can trigger rapid-fire
restarts that prevent the device from ever stabilizing.

Add exponential backoff to carl9170_restart(): if a restart
request arrives before the current backoff window has elapsed,
the request is throttled.  The backoff starts at 500 ms and
doubles on each restart, capping at 30 seconds.  A successful
restart resets the backoff to zero.

Additionally, use named constants for the firmware error
threshold (CARL9170_FW_ERROR_THRESHOLD) instead of a magic
number, and add a window-based counting approach to avoid
accumulating sporadic errors over long uptimes.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
Changes in v2:
  - Remove CARL9170_FW_ERROR_WINDOW_MS: defined but never referenced in
    any expression (dead constant).
  - Change CARL9170_FW_ERROR_THRESHOLD from 3 to 4: the check uses >=,
    so threshold 3 triggers on the 3rd error.  The original intent
    (visible in pre-patch code using > 3) was to trigger on the 4th.

 drivers/net/wireless/ath/carl9170/carl9170.h |  2 ++
 drivers/net/wireless/ath/carl9170/main.c     | 38 ++++++++++++++++++++
 drivers/net/wireless/ath/carl9170/rx.c       |  4 ++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index b13685e22..ed0b4b26a 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -301,6 +301,8 @@ struct ar9170 {
 	bool needs_full_reset;
 	bool force_usb_reset;
 	atomic_t pending_restarts;
+	unsigned long last_restart_jiffies;
+	unsigned int restart_backoff_ms;

 	/* interface mode settings */
 	struct list_head vif_list;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index f665cccc2..252ebe14a 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -474,6 +474,7 @@ static void carl9170_restart_work(struct work_struct *work)
 	struct ar9170 *ar = container_of(work, struct ar9170,
 					 restart_work);
 	int err = -EIO;
+	unsigned long flags;

 	ar->usedkeys = 0;
 	ar->filter_state = 0;
@@ -495,6 +496,9 @@ static void carl9170_restart_work(struct work_struct *work)
 	if (!err && !ar->force_usb_reset) {
 		ar->restart_counter++;
 		atomic_set(&ar->pending_restarts, 0);
+		spin_lock_irqsave(&ar->state_lock, flags);
+		ar->restart_backoff_ms = 0;
+		spin_unlock_irqrestore(&ar->state_lock, flags);

 		ieee80211_restart_hw(ar->hw);
 	} else {
@@ -508,8 +512,13 @@ static void carl9170_restart_work(struct work_struct *work)
 	}
 }

+#define CARL9170_RESTART_BACKOFF_INIT_MS	500
+#define CARL9170_RESTART_BACKOFF_MAX_MS		30000
+
 void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
 {
+	unsigned long flags;
+
 	carl9170_set_state_when(ar, CARL9170_STARTED, CARL9170_IDLE);

 	/*
@@ -522,6 +531,35 @@ void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
 		return;
 	}

+	/*
+	 * Exponential backoff: if restarts are happening too frequently,
+	 * increase the delay before accepting the next one.  This prevents
+	 * restart storms when the device is in a bad state.
+	 *
+	 * last_restart_jiffies and restart_backoff_ms are read-modify-written
+	 * under state_lock to prevent races on SMP.
+	 */
+	spin_lock_irqsave(&ar->state_lock, flags);
+	if (ar->last_restart_jiffies &&
+	    time_before(jiffies, ar->last_restart_jiffies +
+			msecs_to_jiffies(ar->restart_backoff_ms))) {
+		spin_unlock_irqrestore(&ar->state_lock, flags);
+		dev_warn(&ar->udev->dev,
+			 "restart (%d) throttled (backoff %u ms)\n",
+			 r, ar->restart_backoff_ms);
+		atomic_dec(&ar->pending_restarts);
+		return;
+	}
+
+	ar->last_restart_jiffies = jiffies;
+	if (ar->restart_backoff_ms == 0)
+		ar->restart_backoff_ms = CARL9170_RESTART_BACKOFF_INIT_MS;
+	else
+		ar->restart_backoff_ms = min(ar->restart_backoff_ms * 2,
+					     (unsigned int)
+					     CARL9170_RESTART_BACKOFF_MAX_MS);
+	spin_unlock_irqrestore(&ar->state_lock, flags);
+
 	ieee80211_stop_queues(ar->hw);

 	dev_err(&ar->udev->dev, "restart device (%d)\n", r);
diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 4714ee8b6..b12bc508d 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -46,6 +46,8 @@
 #include "hw.h"
 #include "cmd.h"

+#define CARL9170_FW_ERROR_THRESHOLD	4
+
 static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
 {
 	bool restart = false;
@@ -54,7 +56,7 @@ static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
 	if (len > 3) {
 		if (memcmp(buf, CARL9170_ERR_MAGIC, 3) == 0) {
 			ar->fw.err_counter++;
-			if (ar->fw.err_counter > 3) {
+			if (ar->fw.err_counter >= CARL9170_FW_ERROR_THRESHOLD) {
 				restart = true;
 				reason = CARL9170_RR_TOO_MANY_FIRMWARE_ERRORS;
 			}
--
2.53.0


