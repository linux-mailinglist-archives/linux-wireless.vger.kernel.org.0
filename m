Return-Path: <linux-wireless+bounces-14340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E39AB9E5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 01:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9220DB21953
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 23:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671DB1CDFB9;
	Tue, 22 Oct 2024 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r9mirOaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2079.outbound.protection.outlook.com [40.92.90.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAF14B97E;
	Tue, 22 Oct 2024 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638763; cv=fail; b=CU3J0e0ripqsGwD+VT+/E7bi0+df7plaqnPXS6CMWYPxVItRjtk9SWB/nB0c7zTmFA9YNYsYmduSRFZ6rj9gHogKv8eRTJIGu0aA6jwdg6j2IJ9huASSsOq2bxF1xK1zCJrAXoFNWb4YxmqJlfKzszYXsH1Y8E7NGmGEIigVYRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638763; c=relaxed/simple;
	bh=ZApoo+pGKZ1LviksPd+pJ5mRfAVmH/ld94+kG1e+VyQ=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=RkacTqY5DsP+H38RRDXw/YigYdk+lRYN6gDNp752SCLDokaO0dZzYfko4jEFMfq76Tuw3rvFgUTarXtzcfvYwgDcZZnTpnXbgiSFQl4Gs3y3LRdbTkjmoH3uJadrBMT2uMN+v0pb87qKJgTB7iFOswJ0rv1OpMrXz6ACF/wlRN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r9mirOaQ; arc=fail smtp.client-ip=40.92.90.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOEo44HRllPfZhBQeuD1DmDJ8kqQ0DTh7UpkhP4zuSu4loP/bNlfkZyBJmhgMNhpJBNOiYfbTQt9hCNslPvJH+0k31mI9cSYXMea3q1bMnIVGUQH9udA6Odcoq5IPwOAqyIYloACzKNLSVEGoXmQROQ1vb7amzcF4KdiRKT0wDwKXMHroLGazWwrEEQYl+dlIKiWvYCO6qeiYheRKgyWELwVn5/mlbXfCzf78xNVi5IqiJbAO3ssCPCNfwDBkKrar0F6MLbycPRHnpAp2n63fefYXXgVgMywYifLhFW7H1XXyaaoYgMYG8vjREl8nVx1j0XW+yBR49K4Q+p0CBF4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ExJBn0MmayV+FLczOqZGc4SeBAgwaJF8ipPMcKU4FU=;
 b=p4cyKbQi2IRGeYbdGrasaWFd+q+nMWsnrI0HC2DuaY4vC6BGsUDGthbInGe/lvf3J/HSlBWcjO5RRL5pvvN3Wd9pa59lTy0XU23Bl/hzTsqkCx2J9ujHjDrqEBMM95ObmQO8Rx5wK5Cy+OC7NbMnaN4sJzUeKOXQLdNkG+NIphmX72yduDNPIaXyrIT+TieJjqqR4kFge/BdFnlUaz8wtQSj50tYLbfn9t/bcYqu0ayLRv604PHAQObtAickl80hffJZtii15NBpkvBkCedoS9BBDF36mDPqXS08OQF/WWnH/5V4VzoDzWP9hjVSFRbECqo1bJZjUMei/6W8QLvL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ExJBn0MmayV+FLczOqZGc4SeBAgwaJF8ipPMcKU4FU=;
 b=r9mirOaQSxC6aoX+G0Gba9IXUPWUCFNSI1JC8UWOkeoeAw3jXJsv+jtYg3BZtUqXBzcmtkB7Na9jlnmI+kCY09uMPf8Zlv+0zbf1HQ+tWogq9YC/xXJq/HLqwYdfKFUvPnVdfVCDRSq87r5qeeaPFQnk+zTrt6jNbW2KLlOiIUj8uFi2ACCamQIyk1sqvPlExotKhyGUNDF4kIoFNnj3m1f0DQtm4QWqvMTHuIYPwmadRIYUFW3149WQrjGvkMGrkQnns00K0Syq096gkGGVIVvbfXt3WUxs6B0C7XIslqXG8he/7maDtyf1Z3Xbt7kqs5GlQtShYIvNY+Qwcp0lnQ==
Received: from AM8P194MB1185.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:245::9)
 by VI1P194MB2146.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 23:12:37 +0000
Received: from AM8P194MB1185.EURP194.PROD.OUTLOOK.COM
 ([fe80::c0f4:23da:8b07:c5ed]) by AM8P194MB1185.EURP194.PROD.OUTLOOK.COM
 ([fe80::c0f4:23da:8b07:c5ed%4]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 23:12:37 +0000
Message-ID:
 <AM8P194MB1185EC77BD9AC01F139F9B67DC4C2@AM8P194MB1185.EURP194.PROD.OUTLOOK.COM>
Date: Wed, 23 Oct 2024 01:12:35 +0200
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: johannes@sipsolutions.net, corbet@lwn.net,
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-doc@vger.kernel.org
From: =?UTF-8?Q?=C5=81ukasz_Kimber?= <lukaszkimber@outlook.com>
Subject: [PATCH] Fixed broken link to iw documentation page
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To AM8P194MB1185.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:245::9)
X-Microsoft-Original-Message-ID:
 <e560dcbd-ea27-40e8-b7a8-6b80467744c6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P194MB1185:EE_|VI1P194MB2146:EE_
X-MS-Office365-Filtering-Correlation-Id: 591f1e35-b625-4efd-e2ed-08dcf2ef04d6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|7092599003|6090799003|5072599009|19110799003|5062599005|8060799006|1602099012|10035399004|3412199025|440099028|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWlDemZTMklQYjhZZEw1aEdwNTRtK0ljRko1cWk1cHlWWWV0ZXZybDBjaVRJ?=
 =?utf-8?B?bW9tYzNEWXJPejFORmEzcUN4ZTVrT09Fc2lYaFlwWC90NlRNYUo0R2JaTVB0?=
 =?utf-8?B?N2ZlY3FVTjJERE8xNldzQi9VNVNaUjJZZXZNMUNqMzV2NHpIZEd1YTEwcFph?=
 =?utf-8?B?eWhWemNzdnVKRHBtSE91TjREWGFoazduWWw5L2JuWTdKZUJRTkYvL3BOMmxF?=
 =?utf-8?B?SjhYRC9temNLVGV4NEVMNHdFejFmdjFPZzZ5RDR4d2pMaWRvUnQ4US9XN255?=
 =?utf-8?B?RWt3T2ZoSTVJZ0grN2x3YmFZc21YMURGUGMyRUh4RTFXOFg1Sy83RlI2c1Ey?=
 =?utf-8?B?dmczQ1ViT2x3WldsZXp4TTRMNk1nV1N4cm9QMjI5Ym5NR3laTnA1SS85WkxS?=
 =?utf-8?B?eFF6UHloMEorcXNnTG5oY2VjU0IvZ29HVkJybUtobGhRSzRROGR3ZG13UWZk?=
 =?utf-8?B?Y0JNNThuQnQwamlkZG1wdmZzd1dtL3NxbENoSXJLTVdyR3ZoYXorcSsvYUt1?=
 =?utf-8?B?V3RHanRyRTF0TmpyMUkrS29Vemlrc2lKcFNjeEExbWJhai9hNy9xLzFUaUpO?=
 =?utf-8?B?TU0vYmVCOVB1U3dDNkZPeHpFdWdZZnE0RlFVTDRJaEZjeUdaUExuOFFLQ1ZG?=
 =?utf-8?B?eCsvM3dBT3hKYTcyYWV4aXRMU0p0Tk1SUjBTZGlhNUtBMFVOWjM1cTF3WFdG?=
 =?utf-8?B?dmN6dHczdGNqN1A1dE1oVXBvV013djExU3YxNW5oMUwwOWlMTjV3NnBoOExu?=
 =?utf-8?B?cHZTL21YVWFRRDg3Mit4bGFKWkpWaG9jVEhVZjRoZWpueC82V0FsSTU0eVRp?=
 =?utf-8?B?c0lVd1l0Q0krQTJDVWNFQ0lEUEdKRnJ4TWJuOHJvUTBsd2VTZytIb3hPbkh3?=
 =?utf-8?B?dG5UOVkrZ2RmMFhzdkM1anZrMFpDS2JWSjVQL1QvOStSZkNFaXFrRk1Pbisz?=
 =?utf-8?B?RXNzY1pPbi9mTWd0OXBsRmhTVCtyVkcrbHdSZFMxb0JMMUNiN3g1cFFqbjVw?=
 =?utf-8?B?ZmlTUCtwMTlrZzgrZmdoLzRRSXEwR1pPWHMrZVJYaFJYVG9VVHlyWVZmR3V5?=
 =?utf-8?B?NWFkb0ROYTNXNFFDd1FyVmxqTktsK1RLTmRGMWs3dVlaQzlsWGVLbjNzbFFQ?=
 =?utf-8?B?elR3dmMzMkR0cFNmWXdyK3RoUUZJcVk5bys4VEx6c0NYTGxuaHF0Y0xiOWFh?=
 =?utf-8?B?c2gvdzV6WnNkUDE5Q2I4M2h4SFRNU1ZZcGs4QTNKeHM5eDE0NHRveDI5Tlpx?=
 =?utf-8?B?WFc3NkFGdWRzZDFESFppMWVCcmlIYVVrMGhYN0R5RkZ4VDZpTHFhUzFuc1p5?=
 =?utf-8?Q?N6kZ2EYD+i51s=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllVaDhoTjlSVVBqVzZyNmhqYmt0Sk1FSnM3WEJQYVhwZWFibnp0QzJEa0tL?=
 =?utf-8?B?ZGc4MU1NVnR4NVVqOUd5Wng2WnpaSGtxRThKalBKcmhMZTRES2kxdUM0c1Ay?=
 =?utf-8?B?SDM5V2JlbDVKQ0xZKzF3YTVNeW5zSzJON3ZIaGNIZnQ2YmJJWXE5dUk1Y2pJ?=
 =?utf-8?B?UzYzY2NqRW93N2c3Mk4zMEN3VVRMcDJsZWowTDhkcElDNU1pU1dyVXlqMWVu?=
 =?utf-8?B?YlJKeFFxSXhkRm13b3N6ZUk4dm9Sd1FwZGtCM3VBb2hCcXdrcTU2c0RxMVZZ?=
 =?utf-8?B?VTdSMXA5TWhBejk1RXRxU1JrdkNyeGYxNURINGZwVUpHaEtIUVlBRy9wNlZZ?=
 =?utf-8?B?TFVlemdTM214Yk5XaWxBalFYT1VFdm9kakpXWEVFblFLaWEyeHFjTXJCRlI1?=
 =?utf-8?B?cGh2b0ErWnNHTXVQR3JPaExtZTR3VUI5TDZCN1NMUEl6MDhQNFUzclNneDBj?=
 =?utf-8?B?MEtKZU5HL3BPQ3hVTSs4R0FIdnY0R3JBbVdsMkFRRlBIYUoyOGVFaFlpSEkv?=
 =?utf-8?B?Qy9kcHl0aEtWMzRib1RIZnFkdDB0aFhYK1NFZjd0bWRLZ3Y1cDRvZ0gwQlE4?=
 =?utf-8?B?QzBmMHgvM0JrZjN0Q2loV3ZzUDZRUzdwb3Y3MXdiMEF1ZHdUWWdlMlFtYnFI?=
 =?utf-8?B?SDZXdWptbFhwZmkreDRJajN4K3k4Q1BTOG1qemMydzZjUnBJWDVxZkgyaExv?=
 =?utf-8?B?ZTB6VDQwNGVRTWhISEx3UHluRHBRQWJnOUw2NFdYTUFaMmlkVGRwMHhhcVhS?=
 =?utf-8?B?bzFmeVhCUGxxck5DU00yc01pbXFPZVJzZXlDQU5sd2REZXFXUkFTdHhBU2Ri?=
 =?utf-8?B?R1VmNytJRXlnYmQ4cmN1bnBJL0pPTFdvWDhUeFRRdEpEa3ZJWlkvdUF1Qlor?=
 =?utf-8?B?UEtUa3BnYk1TSHpTV1QvK3MyVWtodVoxSW5Sc2hRaTlzMFZrak1FV0NpWGtW?=
 =?utf-8?B?MG9RNkJzTG5Va1FXZEtLU0xTYTdzN3VXOUg4TnhndG5nZ1dDWWExcml2M09F?=
 =?utf-8?B?aDVlaTcxbEV1dTB3UERhYzlaRlZtd01IN2RUUGkvaEhwcnhwQmxDQUJvSHNU?=
 =?utf-8?B?SjhHMW9KZU4rVGxqZ2FsWG5rMFIyRDhZMkhZczhtZlE4V202ejdzNGZTTmNM?=
 =?utf-8?B?S2puM1lWQlUrT3ZDWEt1M0Y1Sk55ZjUwV29LcFlHY3ZjNW54QXY4SzJjRk1K?=
 =?utf-8?B?KzFEQ2pUb2FKaCtCc29NZUZtZjVnZkVJbmNZenJkRFhGcmtGM0hVOWttL3Ju?=
 =?utf-8?B?NXJBS0YrQnJHd0k1L1V3dHl4RHFUV1NjS2RmWEpKRDIwcm4xWFBjZmhYZ3BJ?=
 =?utf-8?B?V1JZS0M5RXZZL2drM1NySzFpdUxEVkwvQnIzUFBENmxxcWwyR29VYTZQU2h3?=
 =?utf-8?B?b3ljRHdDMXU5OG1ocGVPY3NHUkxObmhXUGgyc1RmNUgvZnNjLzAwb1VSNXV5?=
 =?utf-8?B?OGE1ZEtMcnhJMVo3bzRRV29vRE5DVnVpb1lRQVBabWppYUVwTXg4YW90M2k3?=
 =?utf-8?B?c0IvbmdzMThySzBmRndzRm5iakZESFFzSnpQamozd0VXekdIdVVXd0l6dDdq?=
 =?utf-8?B?VXNHT1FLZnRXRmUzVjkxbUF2UUVuQktLVEdCVDB1QzBVNkZacHhOc2hQK2xP?=
 =?utf-8?B?NjBlUnZuZndEdGpCZFFQUTZZUWpuMHdVT1ZBVFVkU0kwVURicHlYR3NoTUEv?=
 =?utf-8?B?RjhVVmYraGNsMjFkN1pSREdLUnM4aXY5ckh3OVVhaWE4WVB5aWRuektKZ2p4?=
 =?utf-8?Q?/vzI+cQkIRk0xMZyZ4dqs6zdWKzj23VfiGwTvvM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591f1e35-b625-4efd-e2ed-08dcf2ef04d6
X-MS-Exchange-CrossTenant-AuthSource: AM8P194MB1185.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 23:12:37.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P194MB2146

Fixed broken links that I found while browsing Linux wireless regulatory 
documentation.

Signed-off-by: Lukasz Kimber <lukaszkimber@outlook.com>

---
  Documentation/networking/regulatory.rst | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/regulatory.rst 
b/Documentation/networking/regulatory.rst
index 3163650c242f..78d8e5001020 100644
--- a/Documentation/networking/regulatory.rst
+++ b/Documentation/networking/regulatory.rst
@@ -9,7 +9,7 @@ regulatory infrastructure works.

  More up to date information can be obtained at the project's web page:

-https://wireless.wiki.kernel.org/en/developers/Regulatory
+https://wireless.wiki.kernel.org/en/developers/regulatory.html

  Keeping regulatory domains in userspace
  ---------------------------------------
@@ -37,7 +37,7 @@ expected regulatory domains will be respected by the 
kernel.
  A currently available userspace agent which can accomplish this
  is CRDA - central regulatory domain agent. Its documented here:

-https://wireless.wiki.kernel.org/en/developers/Regulatory/CRDA
+https://wireless.wiki.kernel.org/en/developers/regulatory/crda.html

  Essentially the kernel will send a udev event when it knows
  it needs a new regulatory domain. A udev rule can be put in place
@@ -58,7 +58,7 @@ Who asks for regulatory domains?

  Users can use iw:

-https://wireless.wiki.kernel.org/en/users/documentation/iw
+https://wireless.wiki.kernel.org/en/users/documentation/iw.html

  An example::

-- 
2.44.0



