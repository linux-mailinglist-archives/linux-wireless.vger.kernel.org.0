Return-Path: <linux-wireless+bounces-34245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMwQE/slzGnHPgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:52:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A4F370DEB
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 21:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 535BF300C3BD
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B03A63E3;
	Tue, 31 Mar 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="YgncOwPh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazolkn19012054.outbound.protection.outlook.com [52.103.35.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBA3E3D86
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986742; cv=fail; b=HlPK5yrK33Ylj2SVzFyJ/8J466tK5BsYLy1nq61ap6Nb1UOLQ80IN0nZNCcFifiKWHly6JEp28lNMW4mlm4mUkSQS/rfMWFvsLiMqQRTLXVxsJWI3pkDSGPnC5RPdL8C2+7qLJLh/HdtoLrpnCCl0RaF5bdsbo/lIhq2E2Wb7qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986742; c=relaxed/simple;
	bh=UsfGAGgsdv8tqCKqpTpxSMcHOdmDD5/bOkLAeYLJt98=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=nN02cx90POhitZpo4Jfp3CeTzc5IY2pGNzL7h6IIaDzyLHTBA4qlf3ODmS5/2Q/bAmOohU+fUngItRaVoKRCw7wKXQLIbmU8MFy4rGmb9SgzHh0tQOy6FG1ZkPkE7xbDW1tdUT0/bPpm/C2BT7LQPjZBO4Mt3hQAsywOxAj9BIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=YgncOwPh; arc=fail smtp.client-ip=52.103.35.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjs0XeLPhIfx0HB3Ym6AWieIfW9OxC0hneL9NcmcH+wCxxy7rxLxQDXilsLESPjvLudtgalc6TVygXMP1SePaitQATh1KDb07H0d/nx+xAAHp9ATPZ2SmjnFFIavxklTSAz/ctOwxXUArc71D0icMSRJ4F+xdUxtX8XTVUvOPXBwXsNCS+3ydxzCgTgJIVQRSo29avvxhSX0DENfx2HyJRBx0dWieib8LA2s+XU84kKuFfpevlRCRarCharG6vP7tC5aWIM5Ywas033wLbOxwLXPfbhF4DWo7Mxs9B3Jp/s06GwdQiYVe6MpScnq9UgH9b6DA+M8X5rXRRuP5noTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AudJIo8FvXEFk9OjUSi8pUKJb8LbkYLxAl6Al+CG3Q=;
 b=yHewPQDvC59EkZ88y7CzH+JpiHKcudcAjNqHzWfgftHsoFzkQs9gw6B/z7wQNRApeag5clK8FGzIjUuDL7/rsvLaEfbNFcYQxUahX+QeTUJWVox3SylRLcGs3qI4p4hEM+I+4nFLxff4M8vpkQryfJQSQZytk7Mb7FZ5+3E9ll59TBPVwGFRcRVSpUsvx9jLg40l56ulNMRPj7wY1/kjMDxHwvKc226q4vcppYJgknnI7VJOjSzoEAY+6SpHZfQHOlAWWK1nfxyFDw4dPm9l/ZEUlzk2XlEKzdpXiNOUafz5UO3FwDsa0OkcMtGLCOpOCYRdWHVUEF/qB1JeL7S8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AudJIo8FvXEFk9OjUSi8pUKJb8LbkYLxAl6Al+CG3Q=;
 b=YgncOwPhmTsFKH8KmVyqRf5Ttvu/x3uSKa8M+lAzAYvDQK0h1DHEwr0gGS3Gexe9GKvQV9q8arQGHQMZ3jdZdVpNCImrQiV740P+hNTPO1Xv+T0CrNesLYwndWtz+pbH2TAWFiaGGKALg5x7tlz6OlxHBYgbUKhWp4CPcQyoTci6zgAFj/j0+E79bWyQGkv2mL8/CPjX698C0lgoIMwRklAypscVjs329c/7dA+fU10d1x1kVcwgjS2qiQaAr5+BW3Ck68TBQ8MofBEMMGsuCjusYZ109c8YJM1z3SqHlNyRHolInL7QVPPeX+fj54oygtjegN8J4/IqZUoPxRtU3A==
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::9)
 by GV3P280MB0433.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 19:52:18 +0000
Received: from GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f]) by GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 ([fe80::6328:bea5:c218:593f%4]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 19:52:18 +0000
Message-ID:
 <GVYP280MB1518217E38C263874B46F7D69453A@GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM>
From: Masi Osmani <mas-i@hotmail.de>
To: Christian Lamparter <chunkeey@googlemail.com>
CC: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: [PATCH] carl9170: rx: discard spurious firmware response during probe init
Date: Tue, 31 Mar 2026 12:04:00 +0200
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:19b::9)
X-Microsoft-Original-Message-ID: <58d98be30cdabddf940f3541b9db144b@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1518:EE_|GV3P280MB0433:EE_
X-MS-Office365-Filtering-Correlation-Id: 677d41d2-ff94-4f1a-7a11-08de8f5f0398
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|12121999013|23021999003|5072599009|51005399006|6090799003|41001999006|5062599005|8060799015|15080799012|461199028|3412199025|440099028|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azdSVkNyVGVqV2ZKMkRuQ1VUSjUzcG1mYWJaVHFNbTQzUW9UdlNxOXFUQnhD?=
 =?utf-8?B?aUpxbDM1ck9kdmREcThmT2gzNTZjSS9qWU9JV25rRkNQcE44ekNwVks1bFNB?=
 =?utf-8?B?SnFTTklvT1N2UFl4QTBmR1BHdGtXUzVKRm9RMGNlZVQwdXk5Qkdvb2M1K2dD?=
 =?utf-8?B?MVU2eklubjBCbWRvc0YvL0J4cWlacmo1M3RvODN1MVN4MVVLQWtUZXBlWC8v?=
 =?utf-8?B?U2syY0lmNzBzcHdFRWh2NkVYNi9jR3pMdGdTZzVsVXJZeWlINUhSQjRxMDFO?=
 =?utf-8?B?TWxlTmxTSnV4cDlibStJMmRhUUdiT2M4cUh2ZkU0cUZmbGFVQzVTRDRjZzkv?=
 =?utf-8?B?bEtMQS9TN24vWjZZejgwdndqdUxTV3poUzJybXpmaTNLY2s3cWF0M3BlVHUz?=
 =?utf-8?B?ZFJiM2RwZHdOM2ZiQkg4QWw0NWQ4UEIwRkR5blhUQlBzZGFTd0ZOVVM0bHhV?=
 =?utf-8?B?OEgwUzFhQ1pGM2JGL2dLSUxYdEJOaDZtaHBXaWY5UC91aEk2TEttWmlmRzND?=
 =?utf-8?B?cjJoalNqb0lXMHkra2Vueko5V0Z3ODdveldEcm92aThnNG9INkQ2NHdaS1A5?=
 =?utf-8?B?WmlIeWNOTlZ3NFlUWXBobFI5bGtDVDdWMFVWNlFhUldpMEUyTERROFEzN2ZE?=
 =?utf-8?B?M3JTa0J2ZUdXQnU4RG9UNThEK2FTVCtKY0lIazc4aXRzSmU2RityaVdnOTQx?=
 =?utf-8?B?TE1mNGNxQlJzeGRzVmZRTW9iQ2tHTm5yOXJ5ZHhuRWZrTTJwbFdqc0RWWld3?=
 =?utf-8?B?cjBrTkNiWGc3blRFNnRWclZQSDJneGZ0ZjlRU1Zvd3ZBMGNETzJTVVNIZHNM?=
 =?utf-8?B?NllKSEtKenVyM1hQTWVlK3JzSjgwUndiR0xxV01qMnkwdVVEOFRBdU1xc25H?=
 =?utf-8?B?NkxsNkxpM3E4S043ak1FQk1FZWRhZWh1T2VlbW41ZFBvaFR0OEJnTi9vdkRY?=
 =?utf-8?B?VEIxd0F5R29hTUNuNFhMOVBabk9KNlphc3JDS0hERmJRTXZCRG1kWHNnZXRs?=
 =?utf-8?B?SUpSVnArZWdvakMvMjc1UXJCUElLekNPUmRYVnExU2ZLVXdpUFFSUEFKV0h5?=
 =?utf-8?B?UGlvV0xNS0Z4bXNiVzZMOG9XME5tclJud2p4M1VhUVMzSzM2MkY4SVJ4MzBL?=
 =?utf-8?B?c0VzWHVjTTMvNUtMZ21HbnFOOGFQME1NVTA3TG9KRTRRZVJHejVvbFpQOUZD?=
 =?utf-8?B?LzhReFAxUWNNdjhLbzhrWGMzMkE3YTZqVzhtT0ZwK2xsbUttdTlJQTdtZ1lw?=
 =?utf-8?B?alArVWhDYVJnb1l2RHMzS1ZUeTI3WnZsL2NyRTlJSmhFbis5VloxS2VjRksx?=
 =?utf-8?B?aFA2bTN6dkJtcXBmK3lCMVFHK1NsY3p5T1E1UzZDWDFpOG9qMkk3cUJYM1Fn?=
 =?utf-8?B?Z0xVeEx6WGVlWldJanhpaGVWQTRGWjMrUGlzajNjRW4zZ3R3SHUwdWZ2Y1Nz?=
 =?utf-8?Q?tV1CscQD?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzBRdjAzRTRadkFZN2JiWGZRN3c5d3U4MEtjOUtJdS9KT2JBUWJ0NVg5UXJo?=
 =?utf-8?B?Zi9VOW9SMDdTdVI5Y2d5d2lNaXJDVUw1RlBaQ29CanpWYXZVNjhHNGxES2xo?=
 =?utf-8?B?V1diR24rK2cwL251UElPR3V4RWdCWURJSTZWa3Q2WlVGU1N3SEw0elA2ODJZ?=
 =?utf-8?B?QmdaK01USmhabjFZS1I5bHFYcjZmSFlJQXFHMmovNjhJeWVtM0J6bThGYlQy?=
 =?utf-8?B?R0FRSEVuL3JFS1JqMVMyeUIxREdCRlN1dTMxbTdBWFdFbndDSU9ETG9IaERK?=
 =?utf-8?B?ampQOEJrZi9qVUN4VkZNeXhsU1JSVWZoUVNteThtTDhDR1NFTzFYRU5LbjNz?=
 =?utf-8?B?Q1JFaHczMWpTRVJLYktlUThVMU5MVUo4aEcxeW45N3RsZWV4T09NYVFIM0JH?=
 =?utf-8?B?dmthYmQwUFd5Mnh5bHNMVTdUMnJVTWgyRU1sTk1HZW1nbnhpdE0rTU03bHpl?=
 =?utf-8?B?NXd1eDNTeXkzRWRYSHNXZzhhNFRDL1VUdVEyM3dzb0ZaaFV0eDF4QzlHcmoz?=
 =?utf-8?B?VFZnV3BGdEpwbFhHMlVwVjQyeVY5NmhTSW5pdUpDN3Fua3FMaVVoQ0tuN3pt?=
 =?utf-8?B?YStxVEFBYkJmNHNMNDg1QUtKTHcrbU1rRkxCcExwN2htalNqbHBraVRPT1J2?=
 =?utf-8?B?Y0IvWjVEa0Y0Zzc1ZUtxTDlLMEpaWHBjMHFiZEZyZ1gwMXdHSkR4ZzNZKytW?=
 =?utf-8?B?UldYSTFFMU43R3V3OHk2R2NyTklvdmhVZ3pOVDVNdldtZ2EzVzhVS1JWQ3Y4?=
 =?utf-8?B?REpkWGUyaERCTkZoUjNvK1pzTmxiTlA2VUdTWGcwQ2ZkeDdEL1RQeGZ3b1RF?=
 =?utf-8?B?ZXVlS1pUWEJwWHo4U1lPVnZTQmg2ZTJNSXg3dUJpZnRjMmU5aFB4TnMrVjV4?=
 =?utf-8?B?VkhBOE9CUVdoYUZYL1RqU0RNbEViMEJ6YXZGM3NOMmR4U1NxdmhxeXFhdkY3?=
 =?utf-8?B?R0ZwNmNtU1VZQ2RETVJxRGtCRTdSSWZwS2ZMOUJOOXl4ZTFzM3plU0RBK2lh?=
 =?utf-8?B?NWNvUGNUYzlXN1F0UWYxdnc5dzRwWlYwcmRxcHUzRkN2cHlCOFRSeWpzTmRs?=
 =?utf-8?B?Q2U3ZU1GNElacldzSzJBUzFMTEFDOVY3bEk4bEJMbkJpVTJPRlN0dXRnSnll?=
 =?utf-8?B?TzRWSTBEVkJmUlArMW1PSWw5SU1uV0lqd0x2M293SU9INXUxTzhzMW9pRXhQ?=
 =?utf-8?B?YWthbUJHeXB2c0xWQmVKK1M3TFJLeThpUkx6cXYwNWszZkFEbEQ2b3ArMmhN?=
 =?utf-8?B?cTJLUnkvUVhpUHFOdXlra2h1WWtVZ2RtOGZ2OEhaLzRnL1l2RlFoNHFVL2Q1?=
 =?utf-8?B?YzVYVWV2ZUR2Y3dPUTN4ZzVnVlBkZEd5UzM4Um1YWDg0ZWllQkllbkE4bW1m?=
 =?utf-8?B?WkpKMjk4alhLWE9MWExpT09kbmg0Ni9WMU5tVFdITDZQN2JabGg5ZzBVZGZp?=
 =?utf-8?B?UEJtL0Rhb3MzNFdqQks0cWhLY0dFdzIwM3A3cUpzRnZTSGJ5ZnBYcVh3K0tH?=
 =?utf-8?B?cHZNZkhKZG5NTkRsSWZBVUMrN2ZQSk42V0Jidkp1UnBSdXpmOWt0VjhFQUk4?=
 =?utf-8?B?ak1kbW9KMTBXMTV2WVMwZWY0YWtFaHE5dnBwOW1ReG5WZXJVZ2pPdE9QeCtm?=
 =?utf-8?B?SlRGeUFzU1J1cWRyYkxLLy9vb2JUU01JYzJYTWR6ZDFPdHRtMDc1RnNjbDlQ?=
 =?utf-8?B?Tlo3N094UThnVXJUdk9GbDZEbkQwMUNHa251VzdGUXVOL3lJYjBZN0I2bzB2?=
 =?utf-8?B?NFNRY2FwVkYrL3JxWWJtanBTeWUyZXZia1JCS2FoVkQzUEZ3YnlxM3FsQlZU?=
 =?utf-8?B?TlBnMmxqMWcxN1dXZStzY2l0dzE3TlVYdHJWaURDZTYwS1BCeUVudW1HQlJI?=
 =?utf-8?Q?pXANCkRlVrpCS?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-10872.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 677d41d2-ff94-4f1a-7a11-08de8f5f0398
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1518.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:52:18.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0433
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[HOTMAIL.DE:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34245-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[hotmail.de];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mas-i@hotmail.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[HOTMAIL.DE:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41A4F370DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The AR9170 SH-2 processor retains its internal command queue state
across USB disconnect/reconnect when power is not fully cut (dirty
disconnect).  On the next probe the firmware delivers the stale echo
test response from the previous session BEFORE the new echo test is
sent.  carl9170_cmd_callback() sees:

  ar->readlen == 0   (no command pending yet, cmd_seq still -2)
  response len == 4  (stale echo payload)

and logs:

  received invalid command response: got 4, instead of 0
  carl9170 cmd: 04 02 00 00 ef be ad de
  carl9170 rsp: 04 02 0e 00 ef be ad de
  restart device (9)

This cascades into probe failure -115.

BUG-015 (0015) drains the USB bulk IN endpoint before URBs are
attached, but cannot catch responses that arrive after URB submission
begins.  Add a second line of defence inside carl9170_cmd_callback():
when cmd_seq is still -2 (init phase, before the command sequence
counter is synchronised) a length mismatch is treated as a stale
response from a prior session and discarded at dev_dbg level without
triggering a restart.

Signed-off-by: Masi Osmani <mas-i@hotmail.de>
---
 drivers/net/wireless/ath/carl9170/rx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -142,6 +142,18 @@
 	 * So we only check if we provided enough space for the data.
 	 */
 	if (unlikely(ar->readlen != (len - 4))) {
+		if (ar->cmd_seq == -2) {
+			/*
+			 * Firmware retained a stale response from a previous
+			 * probe's echo test across USB reconnect (SH-2 retains
+			 * state if power is not fully cut).  The real echo test
+			 * has not been sent yet -- discard silently.
+			 */
+			dev_dbg(&ar->udev->dev,
+				"discarding stale init response (len %d)\n",
+				len - 4);
+			return;
+		}
 		dev_warn(&ar->udev->dev, "received invalid command response:"
 			 "got %d, instead of %d\n", len - 4, ar->readlen);
 		print_hex_dump_bytes("carl9170 cmd:", DUMP_PREFIX_OFFSET,

--
Regards,
Masi Osmani

