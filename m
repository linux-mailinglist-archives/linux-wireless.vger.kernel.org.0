Return-Path: <linux-wireless+bounces-8381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D8D8D7717
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5881F21103
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E64EB23;
	Sun,  2 Jun 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uT2BGPXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2046.outbound.protection.outlook.com [40.92.89.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF884AEEA;
	Sun,  2 Jun 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717344815; cv=fail; b=sujelD5GeGX/1Cfm7H73p5RWJRzg5OA6qLzfzblYCxxbS0Vi4BblEBzUicXkAKSQ6kZaxXXaQPEqdcK34e+W813c31XeFE7moURbHwQsKC8i0LwpitS09I1/2bzVke/HWzofjUqLU0loL76VpT31SFc9+L31m9s+pNRrpWzrHGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717344815; c=relaxed/simple;
	bh=mjDoxKsP3WTmpqfBIZbNgtnHfvB287/Sjy/yhhXlE8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mf/kMPfAbN+T3T0jUQ2I1045/WJge0rd6UbTYle/3BdCg1OQsyvDDAZxy8uXFi1YGR1/Pf7MDAx0VOydA4yYZGrYLAq2ZtH1pG4W3P6/ipfkf9a62bUNZdwtbETTkasLBk5PgtmjutX9CUZsPSU9miVx1Va0msXItwTDi66W4GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uT2BGPXT; arc=fail smtp.client-ip=40.92.89.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcCj5fl8x1O2l8Cm87P29nxDCyPD7nQpOZpmgYY1aN4KdtUUyIuTdYehrmev1Z6Um47DWsHw04fg7SiStgeA+/xme6FDPUN1rEjJO5LXbBVeUAT84Q97hVpIGw2kfYFxdgx4acCP4yzzeZSva6e0yAaZfbjzXK7CjnwitptSqhduo9m13gJbjEV5YfIfZhJrnQPyhw1ZR1qs+qqqpjKW4WYkUU3oj3G/G6NAe7Y0aUm8VmyfshohF5JZobVWSEp8B6FpwrkEbduD+gp1XdywGOSddve5w6dXHqiezXtjDyhE2s1URsf0P1NN2nUJ3l1ckMWJKmMsf7NEXtt3Pd0Dvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3heqShnV9rcsVWKCOJahCr/q/jH5bAyJbwsMOKB7PUg=;
 b=BnsstJnsJ92ZYTdPyr1o9CqtDs5dEP7YoOxJECfQdLY6UTbivL2dxB8DqYLuyCnokcSfhZf9dOkNkL7sWEI6/Iy+lm6QyvEp02TxIqh57A/+Y17+U13d7hRA/OE67tn3KgLMs+johKGjxcEvYQ9hBkLO4gx66JTP4JZMDqo6HqgovxlDVmGRA5P383v229bQBWvnb/kW9z76UUlGZMyWBllO5c7kCFsbKkw9hhxWmSl3113yeTNJRuK7gTlMcQSrRdZUfjqHxHArryahiwoFVD8iKoHhvODOdoPOg7CqZvlSG64yc9gDAUcKijyvm+vA3lneUDCpbJEf9aCWDVfYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3heqShnV9rcsVWKCOJahCr/q/jH5bAyJbwsMOKB7PUg=;
 b=uT2BGPXTCKhP1I+i61l5CmGWS+iLFr3Rn4m09Qx/ENCas6ZfUBBnK7b8xeG7XS5irxlJUfxux4yTE6Wlhi01CWEQnJZeLBfE1porG5CblJlrePPpzDIYZUuNGLHFfwWcfybNAw/a+AXqfL0YWgXxFPIjjjf/JMiz4pJgoEeuHqW3biHGqHyENV6xHQcGAHZdmM53B9pBNARMMnryfqpF4bszxu2FSgsLDZST7kh6mU6Imsvjc0J2pXcnYPJDZGNhZw6eLHKb7bxeGhR2ZCgpooibAghp4HPux2Mb98OT/IBaZ+XludS/IaVMuur3aIT4afsU8b5FeH6c/M7MO372CA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5770.eurprd02.prod.outlook.com (2603:10a6:10:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Sun, 2 Jun
 2024 16:13:31 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 16:13:31 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Kalle Valo <kvalo@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/2] atmel: at76c50x: improve code robustness
Date: Sun,  2 Jun 2024 18:13:08 +0200
Message-ID:
 <AS8PR02MB7237E215724E0E76C6A50C698BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nFFslZofQzBzvzFCAlgS6ugklWOoWbUC]
X-ClientProxiedBy: MA4P292CA0012.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::9) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240602161310.5671-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fde4410-a189-4712-c0cd-08dc831ef1ca
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQDCnzYXbDrEqffj9TNTzq274zgD0ghQ6GNBjcM44VqSgrncecWltcTsxG9F+agAJYDXfQx7Gw+Ha9UWJqFVwC6OLiuHQKLkXpnC9+v2MSZU1Az8ZzWqTyW2nuNc0NmdrFhlsH7gLBup3c99BN9ld360rSaxVBF90ztgyuj6I+XsqPo1R5ASMuXEON2lx8vPYH3kVzExqTujOKwmA/yTn9OqRoWEaEmb4bhI7ij9SA768/V7pjF53nzY6ri6lJUI7uKTp/Ye8RA0j/V7zQHE+fgPTXigEhmkbDG0BIlE+92RF1SBH5MykSFS8o16o17mHsuwzMFBdn6Z16+kuvULak3BdZ0MmiLg0uUiqdoYuHYM1XSNa+0hscBP3rC4T7LUL05rkQGggnoavJGXbGd1wovap9uowDKgSJjDOPF3KfS18opUKhJlX7i744uiJ/95Qna4cZu2H5+l19mS1N+fxVrycLDA6zumfycsvYpiae/6/J39o02My3DY3XzfOhuz2nZOHEAO6vfptHHoFMXsbClNIbu9+gYKdjT0eonUuAGTBU4o4dyg0vvUvlzA5gObx1KgxBO0eOR9UH+qOxOfiWmfNq4n8+81G7Wz+rEvu+uue/tFOyPHyZxFkCDK34/rzQe4J+Vox5wpiUTguOMJkXo2vstYVQK8VwzET6Uimg52EgqREcC2rgD0gnDw/NUH9ihUh4Y4Vy3BPuhb2xL1uFcH//OrEbTxw9HEpoSrGoAkLX8a8VpF56BY9MuXXKDak7j/8bZ/0lcC+QtWRk32/1QB4KS4oWLuOmffjVXcOSuqvORD/7hCADJf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	9Frcwk+g6ZHSyttjCccOOzao9mUFeshS+SK96HYTA3YK3Jepb49VWTt+GGQ/UbtoDTnpXfeHl+iO1icONYNZ7ZX4ajAJfE7I+9mnYLokUy9TfIdEG+QUaioAVuxlJf50ZOTKRZytPl8OYa2euiuF8877wp0BFkhswVLsBPUzDetFChoqSyORJsQtBMmTnMODr8UIWWJt4PzKBHBqn3ZpVioh1wH7gyq4xSMdogIU/9lgO9ttMvIBnMtIENEfQOf9cbzu2Ser3yIC8k42nbfsQAD/Zb56QYyvajqB4r50BBLWderKmCCjJQ3aHeGzrXING1FjHSlv1rwifl7Nh6f215acm2p7c21msRjbuZuoUwfgyXMf/RTqPDUb8omJWYGMEeozkNHPdbWKpEW40QW9jWZo9+0iryBxOKUweuQwX037i8ekC9A3GoYxXz+wU61O+hi7mrSG3EfoniV4BI5iYyIRAFGhg8EaJ9MCwbz2f17XWI5LpBl8jZkjc381aEjUEbFQk+p7T7lUDrhHtRxaqcCdeGJuxJFBS0n6yGrAG58C/2ocea2+ShJcl0ByHYIFkyi5qwyGaIn1uaTLg6MPm/Q8iymANQB1zjj4M2k2OQosEAPpwp+4DF2C+91LUlc43fBdq55tsCpUgI7v4z0J6EWfSgfgJgN1aabDn4rLzn7qo449i+ibt0LonyPIf3x0skFDWRelEDXSVB3Gmz7KiA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wSexXu2AZxFo1+aWDjCqEpCdZ2MgCIboCRpbM0+Bv2W9Nycia/96mYR4ZAc2?=
 =?us-ascii?Q?W6DdJJzNPPlANKO8TchnVSPsu3+vfu1JllwlJXjJsgC4MmUml/L6A3S2JQEy?=
 =?us-ascii?Q?OyjNXejt0VD3mfA/6zC3qgYcOQWHLGNUDFcLBhRz4IaudeRrknsCPhXc1R9Y?=
 =?us-ascii?Q?8Ot2dR6lbB0q0P6+MkvQAIEyyickPtbYifK9E/n96/a7G1RAURcTlubVFYQf?=
 =?us-ascii?Q?Kr15aBokpBBnzzkp1zgaL3Dl2vNX3eU7ecIHQlGHhx7bj2+x/y/wRG/+oG6H?=
 =?us-ascii?Q?/qt6q9IyW60XbfzvVjcN46tjghqzbpAQ2ZVH+cmndwZv6AHldl3BVBn70L0H?=
 =?us-ascii?Q?Omhqfi9mJ2Ik79g0PlVuL2MhRTt1SRar2akv+hUUFoKDCSh6zKXbrfvAZz1o?=
 =?us-ascii?Q?ozKslU76PWz3ujN6434cvNhazx3uIMT0/iGL9nxzV/PiBSQc4NDPLzbHBjpf?=
 =?us-ascii?Q?ussYpxw2Ep53HtPG5BG0ij0gJg25/pwVP4gSDnHoJfE3RjAzJEBT1j5jV7aC?=
 =?us-ascii?Q?/oBITf0yZlLEo5WAKPPKuKMsewzw2vdI7CtD+v5oy8x8lhokCajzaqx0aStq?=
 =?us-ascii?Q?LL80Jlb9nxgMUDBZG0P62WGt0m3MJqC2PuautVbYMEJ+jevMXWRslGg5DmpP?=
 =?us-ascii?Q?MOcDLha2f4lthIDbg7imYC/o9pnq+V9dhB3cZ+vEXH2Z/eDc9BsoC4akF+s6?=
 =?us-ascii?Q?P7q714IW7scM6QM53uELbHnO33unUI/noYVD9KVTLQGdELSPLdlaHcxSIGGn?=
 =?us-ascii?Q?M0ib0tmWwD7ezfHwpv/01LBk96W/MhJ7tD1TqHJIo1EzQfoTb+mQ3hdZkU/g?=
 =?us-ascii?Q?pk72JiMoMIGsCDAUMrSgSDThcaeT/vZvePdZIuabVyyZ5DCUjulAGJFukddg?=
 =?us-ascii?Q?I2JRJudL1uwD35zWYJfKSWhxsiVBlqRIzM/Ki39WLDgK6kyOYaQ6fcfA3M9d?=
 =?us-ascii?Q?MifjjL5lVxgk9ahOJzLL8YXkUcLyKwYg443ydYaNwdG/0Q1agXFoZfMlGB8t?=
 =?us-ascii?Q?XVa0fleG4pvRziY5Pmo9fli/LaSAEneglHm+ieR541iAgDsb3QfkFuNXx705?=
 =?us-ascii?Q?ICiDxZUV3G6PGsLFUisEkPmofvixVwLgd6k5D2JE+OXtSq0m2KxJ9WBh3Ye2?=
 =?us-ascii?Q?W16lYaPICGaVopxoaBpHoeCVTyQhvlEh7EZ+9/LAariWEzlXpD1gnu7JqaJg?=
 =?us-ascii?Q?3Zc6Upfs7lVQ5daMuh166OKYNuCIMC+UcSwogGGH3ZpCOOId/SmPUyL0RAlU?=
 =?us-ascii?Q?dHKeawNl1a1PpeiRPohg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fde4410-a189-4712-c0cd-08dc831ef1ca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 16:13:31.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5770

Hi,

This series of patches attempts to improve the at76c50x code
robustness.

In the first patch, it is preferred to use sizeof(*pointer) instead
of sizeof(type) due to the type of the variable can change and one
needs not change the former (unlike the latter).

The second patch is an effort to get rid of all multiplications
from allocation functions in order to prevent integer overflows
[1][2]. As the "struct at76_command" ends in a flexible array the
preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count" in the
kmalloc() function.

At the same time, prepare for the coming implementation by GCC and
Clang of the __counted_by attribute. Flexible array members annotated
with __counted_by can have their accesses bounds-checked at run-time
via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
(for strcpy/memcpy-family functions).

This way, the code is more readable and safer.

Regards,
Erick

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
---
Erick Archer (2):
  atmel: at76c50x: use sizeof(*pointer) instead of sizeof(type)
  atmel: at76c50x: prefer struct_size over open coded arithmetic

 drivers/net/wireless/atmel/at76c50x-usb.c | 56 ++++++++++-------------
 drivers/net/wireless/atmel/at76c50x-usb.h |  2 +-
 2 files changed, 26 insertions(+), 32 deletions(-)

-- 
2.25.1


