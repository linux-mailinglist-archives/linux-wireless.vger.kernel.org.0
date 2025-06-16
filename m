Return-Path: <linux-wireless+bounces-24157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD66ADB67E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9073AE1F6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A15259C9F;
	Mon, 16 Jun 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="ZvJcmuUD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023101.outbound.protection.outlook.com [40.107.162.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723A20C030
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090803; cv=fail; b=QCHH9H1F47S/jOOXIa+HJhTss5LcS767ggT035px7pCKyMHsUoVDExS+ZHohjcr5E2TRQdOclIlsMAgvIShJkmuvEKzWAoF6UvydMAAwKCH9M6jynTd6XS3QHGIfYSqpisFn6EZbvSIjP66tpA3/j+c3NtmVdWe1Khv502tQaw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090803; c=relaxed/simple;
	bh=BzBz1Nzm1haMZ8ACSfL+VjvhhrmL0KA59oeT17/v+Sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WdkeYU6AkSg2VxZoSuOLfu9j2O33fxcIQMprexKIw44zaHhbSn7oXXfbshziBynIiZ+/eMsv2vycDZu2t7ZN4lI2G6d3nt06CJFbGlMpG4jDunPqSxmk3S72z8SzwlTbkNJIuF0ydRus1VmMuCa5uMWMa5zPNU3o1DLfrtJrYno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuleuven.be; spf=pass smtp.mailfrom=kuleuven.be; dkim=pass (1024-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=ZvJcmuUD; arc=fail smtp.client-ip=40.107.162.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+cOHYPCiEVVDc2e+E6vlS38KWzkppiUC1BnDAQGoyi9HWWQj6cOADpIYq4CeaDGX0o6s0/K8DdGrKQHOtiI2iDL7hHcI6IYuI/vmf9Lt3reWq9Mkb9fpd2S6AhnYZHMvNv7CmLPfWfbeZNlwOvcbqOGSk4ooXhU2I/z06XbqitKN8uS8j9gNCxPsJvBCK1FruZyN4P0ZaPUZih+LOHw59iDR7B5OU+GVcy+PIUViu6Dv9TuFMsZeVRLaFH3aYj1tyRAATpHxM1bl2RD7NQ0D/RSVZyGda6Fs81Fb1eEyy24l3BzOBpHp2Zp75mjGuXgWzRK72Xd8I/XfLOV9W9iAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4RtAV9lb22ogPLezFTXWh9gpou+P5oxJvFV1CzCXnk=;
 b=uQtU6NaVvlR5bVffQeRkUYaNYNlR0zl9ReYq6D9+wPAhuhD+wxHcJd5oipTO98a12AyCaQj3lE8k+ONmQBMqeSmRFaqecxaVlM2bSe9PanwX/Vytcmy0TvxHyhVaeagTDzKjAdTdwRebjwBl9Et7VYXbuD4eI9+o4p3tTfsDiYkU7Cx+uBIwfFHK5fc3EBIfzgX3NHakomyrUaw0HtPDYwHVuCZhVgpOpaeo0Xt89+cFGodyK6cU6tImZ2O1loNkeyi2MT5BFZWp5NTw665luaMui6muk1IcoOOviXYlFDx+uDqfLLQP0SGOE1xX2WmDokX6vSE7EUBgnkIRzOQ86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4RtAV9lb22ogPLezFTXWh9gpou+P5oxJvFV1CzCXnk=;
 b=ZvJcmuUDw2z2LajvbueShf3DypMldoz1ppnhieXOZ+QSM9UTBIs2le1S/tu9Tl41ssWbOLSsnzs+86s53ilwKBLo8cqQjkbgAzfWknZaUNWub3bAMwQoUASQgDsdtV4r8YcgPGOfvs++ibjnNDGfmI/juJe3MnfXoledSbA/L+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from AS8PR08MB9768.eurprd08.prod.outlook.com (2603:10a6:20b:613::21)
 by VI0PR08MB10741.eurprd08.prod.outlook.com (2603:10a6:800:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 16:19:55 +0000
Received: from AS8PR08MB9768.eurprd08.prod.outlook.com
 ([fe80::2b46:d268:abe9:b0e9]) by AS8PR08MB9768.eurprd08.prod.outlook.com
 ([fe80::2b46:d268:abe9:b0e9%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:19:54 +0000
Message-ID: <f7729305-1345-405b-a5f9-671213057a16@kuleuven.be>
Date: Mon, 16 Jun 2025 18:19:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: prevent A-MSDU attacks in mesh networks
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
References: <20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be>
 <b62bf1d140eaebe6dbc75e83541fe45347c8e6bf.camel@sipsolutions.net>
Content-Language: en-US
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Autocrypt: addr=Mathy.Vanhoef@kuleuven.be; keydata=
 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
In-Reply-To: <b62bf1d140eaebe6dbc75e83541fe45347c8e6bf.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0079.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::20) To AS8PR08MB9768.eurprd08.prod.outlook.com
 (2603:10a6:20b:613::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB9768:EE_|VI0PR08MB10741:EE_
X-MS-Office365-Filtering-Correlation-Id: aea327d3-bee5-4394-d955-08ddacf1a105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmpySVo4R1A5a1A0dkNsOXl3bmhtK0t6aVZsVXlPMnlqcUgzM2J2Tldua0ow?=
 =?utf-8?B?eEc1cHpQUjNrc0xSNlFtdW5HbVg3azFFZFVSdnA3dG5zWGo3N3o5Sjk2QUth?=
 =?utf-8?B?QTVzQmRaSTlEQ2NxY1ZRK0dPTFFPQVVSbWFnb3hvRng0V1lkY1BRTUV6QU1U?=
 =?utf-8?B?aGI3YzVpSnZHTTZ1TElEYXB2RDJ0aGYyV011RE5iT1lMbk9ZeUJ5Rno5S2dt?=
 =?utf-8?B?aGR1akNXY0RYYkk5bVhyL0VRQVp0QjUyUFhQSkZUYlRYbDRocDdwS0svM2k1?=
 =?utf-8?B?MWExREQ1Mzd1OUpsYzlZN3lBaGllTnlDMU8rNWhhYjRwVXVOZWMxcm10M1pl?=
 =?utf-8?B?YnVzd29Cd045VWxHc3FNSUdOS1pOSHdpRXZVVXdodTJRekFxRFQ3NUpDOFJG?=
 =?utf-8?B?SWhwUytZZGYxNnJvNzVhclBkZm1kN2JmY1ltSTY1ais1b2RkdmZUMFhaZktq?=
 =?utf-8?B?SkdCaHNHQ09tVmVBUDl6WUd3N0JvQVArWTdRekl5eUVUQ3cvbS9IM3F3Q1c0?=
 =?utf-8?B?R1lQQytXNzZYSklvWUJ4RVBzR21jd01uQ084V3d5bjBjbUp5amMvYXJnTWo3?=
 =?utf-8?B?eklxTllBdGVXdE1rNkQ0N1NqSUhrNXRWQzZ3bjFoMGE1K2VZUlhVK1BaZmps?=
 =?utf-8?B?MUh5Mmt1OUpIc2NOZGtDdUplS3pieDJwYytIRUNyekZ0OFRaQkEwN2k4eDUx?=
 =?utf-8?B?d1NyK25NZXBwU1AreXVUaW5PUG9veGgzRmw0R25JL25jblF1bERLbUk0QWl5?=
 =?utf-8?B?QzNNeE1oK3lGZUxRTE83ZkFIQUJOZW93dDJRSGxBSlRFTDVBUE9ZaWRtZGN5?=
 =?utf-8?B?ZkVUZU41KzczRDJTZnhaVlNwK21jRVlITDJzeUZtS1RwbW1sUEs5bEZBN0tT?=
 =?utf-8?B?Z1pSUFR4SmZLZjg2L2wrMjFZTVVoS3JrdjByVWZHcWVxM1JXUm1CcDg0dGV4?=
 =?utf-8?B?NHpNTFZYMk9sZ0JRZGU1ZmpvVHJSRHRWY0cvOWlFL0trcGRUb3E3Y1IxVml2?=
 =?utf-8?B?Yys4TlRPUXFXdkI4T1N5dTZIK2ZBT2RtdmpKZ3NBVVRPc2lvZUxRdHUxa3NK?=
 =?utf-8?B?dVlRUWhHWjY0SkVWcjY5eU5rMWVIZjArYjRBRlhxRVU0NHpzSVdrQi9jNSt5?=
 =?utf-8?B?cFYrZUdDYXBLWG13eUlONXpMMWFpaGtlM2c0bFNwdUZkQVBGMmpRNDBhMkti?=
 =?utf-8?B?Q3Fza0J6bnhoSWR3aDJuV1lUd283T05YMEI0dnNrY0Jtc2xzWlhpQVZRZXdK?=
 =?utf-8?B?ejNRRlF4ZXBGMFpycThycFI4L3k3YkZRV0Y3NlZDcWs1a2pReFMvUkNQaVhC?=
 =?utf-8?B?cU1vZ0RkMFNrZ0JWVHlHVkdnRUx2ZGVUbFJNdzhDK3BaTnVEbnVQSTZ6L0Iw?=
 =?utf-8?B?cW9uWlhiT2UxWXlHeUxQWVNvYzM1Y2pjR3ZMODFuTFlOZjRnV1NqN00xb2Rj?=
 =?utf-8?B?NnRNZkRFUkxXcFEvNlg1cUk2bVhiTzJWeXo4RXR5ZHhPQzJUTUlXSEFjNVZh?=
 =?utf-8?B?RVQ4QlV6Zm5xblVJVURiUjRJR2pRN3hsc1BKVVI0eUFGMVhzdnFZVnowNUhu?=
 =?utf-8?B?YktoZDBzZUZWUFY2ajBtWWxTeTJ4UUQyOWpkZUtZdWpDUzEwSU5maGNuNGJQ?=
 =?utf-8?B?dkdMZFh6eWxoMnRTTEdjMnRPWWdCa2txUUVLUGFmNEgrN3laOTcvODNjNlp5?=
 =?utf-8?B?R1lHN21Za0JZeDJGZzRwYzhNR0ZPVHVzM0Vwc3FjN1YyMVRUYnRqaUU5S0hE?=
 =?utf-8?B?cTd1bDZ0eVk3TCt0eWRNODRFblNTdEFEOFZSK1M1N0NmYW9DajE4UTc0aTQ3?=
 =?utf-8?B?SjdQUzBlVDdDa0FDci90OFFuUkhLc2JrNGFJcmMvMXM5RVJGR1Y2bDdWSW5m?=
 =?utf-8?B?aEVXSXlqVms0RktKVC9mRWlkVzJSanNiY3FwRVowa0JpN0J3ZjVmTWVNbzNS?=
 =?utf-8?Q?UMXHK7Udm3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9768.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RndDWmlVc2tvVFlCQU5RN1R0cmUxc3hXWEtHeVk0VFltL0picVh5Ukh6TU1l?=
 =?utf-8?B?Y21Ebm9SaE8rRENzYXJhL2xxUC9XRXcweUtGYkVlZXk4MktYWlR0eEI3UDda?=
 =?utf-8?B?eTgrbzF5dFMvMzY4dUpaZm1tMUZCUEVOSUxjSE5HQ1VOaSt6VkZ6QVJuV0Zq?=
 =?utf-8?B?dUIyTGVTTHU2VjVFRnB4NnZGV0NSVmFFd1grdXduTzN3ZmYyM2ViZWZMRmRj?=
 =?utf-8?B?UzNvM2E1NGFqTzZuRXB3dXlmbjByTFJPcGVWYlJ3dW05eTdkMkhJR0FuVjJa?=
 =?utf-8?B?Wm9ObkJ3WVJKdjlNbXd2bTF3b0JGdGRJMUNjQitJUTB6eE9FVjJKZjRJdDRX?=
 =?utf-8?B?eGtVWUJtUElBaWNWOHJ6NnRzK0tOVzFPTTlpc1FPLzREZ003NzJrUVRKUHU3?=
 =?utf-8?B?bVJsK281MDZIQ1ZnUzdOTk5RSzVGWTlSd01LbVNaaUZ1N0tFclZva3hyVVlj?=
 =?utf-8?B?d1RrbFVJU2RCaUQzYU9mUGQ5SU5qK1ZvVUFwQUZjcEpVZlBkQmc0MC9ZWWsx?=
 =?utf-8?B?K2swSTVrRXhhSjd6N1NZbjNLOVhqK1NXeHBDSmxMZHRMN2RUaHBQQXRjb0dL?=
 =?utf-8?B?eEFDaFk3QUlsVXRVU3QvbSswbkFKbzZsOGRSckdRVkUrWUZWbjNuQW9JQmZJ?=
 =?utf-8?B?SVh5cVBDRlJxZDRzS0V5UUZ0WXBuNUhZNHhDUlFzdmcvN1lzY3M1S2RaS2di?=
 =?utf-8?B?Ky93OGpVbGtRVm13REFnQW9tSEhIVC92QzlmcFBxOFFqWGtmbUsyNXBHVVA3?=
 =?utf-8?B?c1FsSld1czdKTkZRbHppdE9qakN1bFJZaDZNQVFIT29Sd0pUU1dQeEZoZldN?=
 =?utf-8?B?TTZ6OG1BY1kyNExpbzJQMWY4ZHlVbXYxUVF0d0M5azF4WnZWME9nMTVkYk95?=
 =?utf-8?B?blR1Y1lzSFY3eTJyTHhLTDZlNlB1bjZJTTM1WUxTYWVFdUNFZi9LMFg2WjdW?=
 =?utf-8?B?dUZFcVNxaHREbXMwZGFTZHEwRzNqMEJiZFd6N05TaVZQcFdNam0vby9ld2NX?=
 =?utf-8?B?cEdwZFZWaTZYWXRIM0FhNFRIUDhEc2EvMTlIY2J4R3NnU3ozWFZqOUNwUlQx?=
 =?utf-8?B?bndmZVgyVGcrSDdJWU1ybjNkNjRpbW5xVVIwWDZ5d09ab1lYOWMvZHptRm5n?=
 =?utf-8?B?Q0xyUjNhaHhFd20wY09pb3RPOXVzQ3VhS0lWUUluVmRNQk8zV0FDWWsrOVda?=
 =?utf-8?B?cEQ1RTFnalU1Z2JCblpRVnhrWklHYnZoYkY2YUMxQ3hOS1BLMXl5WERMSjIz?=
 =?utf-8?B?OS8rSWR6WUcvOXVxOUd2UllUU1dEUUFkeG1oTit6VE1XaU84S3o3RUtsUndp?=
 =?utf-8?B?RXQwYXEyeWZZdk5lQ0FHWEozUC82NUM1UDMweWJJOGdrWkFIQk80eGk3ZjdK?=
 =?utf-8?B?cGRUQTZhbEdldW53ODNmclJOWnVFUU9FdHM2aUFyTHVoU2lHd0w1NzhQMHVz?=
 =?utf-8?B?ZUtLY0pHYTROdmRwNVhERU4rVG9VVUtFelg3bVBTbEd3dmhKZVdyNnI1cU5B?=
 =?utf-8?B?bGhQOFZCV0NWeStLYm5mZzVJZzNzVTdSbTRJTXZCNGJKN1RaZm5QVWMyZzhl?=
 =?utf-8?B?OXR4VzdnSHlPcXBCcjQ3TW5PZXlRb2ZsU3dhemhsTmFJU014TU5EdWZIdjhS?=
 =?utf-8?B?OHkvRUVscDBLV2hRQ1FYSlFMb3dEM3BqQzdZWmMvLzBhUDQ1VmJRR01mVEE5?=
 =?utf-8?B?SktCQlV2d1M1VGVjQW9iNVhXbm4rcXh2T3NDSHY2Wlg4U3JZdTErbld4QTRF?=
 =?utf-8?B?QmtCWnZMNm41R1JPOThmcHlweXcxMHJEN09kN05vZjJ1QU5UQmRsbVBqVENB?=
 =?utf-8?B?cXBnOE9LalhhbzB3QzdyWUF2d2t0bHlCZ096cGpMKytiOGErQzRrcE1xWGI4?=
 =?utf-8?B?enpxUzNTNmE1T1Y1c3luNzFrSHdxRzBUUGFYclBYVmdFMXhrcU5aT2dNWk9V?=
 =?utf-8?B?bEN3SlByTDA0MHFwTjNJLzdhM2ZvZ2pKZXIyclhQczVoZEtqcytlcnNYTDZ1?=
 =?utf-8?B?SEFjek1pZGhoS0ZQY3laSjR1cGdkUGNvczhtbmtiNFNPblhOUXBzWUx5K1BD?=
 =?utf-8?B?ZHFFa0NGakRSY01FM3NJU1E1QnpKQkFBVHZyZ2lOSUFkR2ErOTVEVVZHcGpo?=
 =?utf-8?B?WTZ1Y0M5YitNb0d4Uit6N3pCSHlhUEJkOEVXM0phL0dJUjFTdmMvVVU2Q1Iy?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: aea327d3-bee5-4394-d955-08ddacf1a105
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB9768.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:19:54.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBltR4EJw2CcY/cgfUTWPJUeMY3D2iHAM5SYwKCit/Pgv9qqROVEtHvFxnSwHiPWG/9qYa1zDRMP2SDtNciGGpa1FJKLVmuL1+Vynk75ZfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10741

On 6/16/25 13:27, Johannes Berg wrote:
> 
>> +static bool
>> +is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
>> +			    enum nl80211_iftype iftype)
>> +{
>> +	int offset;
>> +
>> +	/* Non-mesh case can be directly compared */
>> +	if (iftype != NL80211_IFTYPE_MESH_POINT)
>> +		return ether_addr_equal(eth->h_dest, rfc1042_header);
>> +
>> +	offset = __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);
> 
> This seems awkward? Not only was this calculated by the caller before:
> 
>                  if (iftype == NL80211_IFTYPE_MESH_POINT)
>                          mesh_len = __ieee80211_get_mesh_hdrlen(hdr.flags);
> 
> but also h_dest[0] is just taking advantage of the aliasing when we
> already had a union in the caller to avoid exactly that.

Here hdr.flags is not an alias of h_dest[0].

The caller is parsing the frame as an A-MSDU, and because of that, the 
caller assumes that the Mesh Control header starts after the A-MSDU 
subframe header, i.e., after the `struct ethhdr`.

The added function is_amsdu_aggregation_attack is instead treating the 
frame as if it were an MSDU, to detect if an attacker flipped the 
"is-AMSDU" flag of an MSDU frame. For mesh networks, the MSDU 
immediately starts with the Mesh Control header.

So the caller is passing the byte at offset 14 as argument to 
__ieee80211_get_mesh_hdrlen while the added function is passing the byte 
at offset 0 as an argument to __ieee80211_get_mesh_hdrlen.

> We could just pass 'mesh_len' or hdr.flags from the caller? I'd prefer
> mesh_len, and perhaps also changing the code to pass mesh_len to
> ieee80211_amsdu_subframe_length() instead of recalculating it, since
> it's not obvious (without looking into that) right now that we even
> check for the necessary length of the frame.
> 
>> +	if (offset == 6) {
>> +		/* Mesh case with empty address extension field */
>> +		return ether_addr_equal(eth->h_source, rfc1042_header);
>> +	} else if (offset + ETH_ALEN <= skb->len) {
> 
> And it looks like you didn't really understand that either, or am I
> completely confused? I don't see how this test could ever fail:

Those checks are largely irrelevant. The caller performs those length 
checks based on an A-MSDU while the added function parses the frame as 
an MSDU. This means the caller is checking a different (optional) Mesh 
Address Extension header length.

> We previously have
> 
>                  len = ieee80211_amsdu_subframe_length(&hdr.eth.h_proto, hdr.flags,
>                                                        mesh_control);
>                  subframe_len = sizeof(struct ethhdr) + len;
>                  padding = (4 - subframe_len) & 0x3;
> 
>                  /* the last MSDU has no padding */
>                  if (subframe_len > remaining)
>                          goto purge;
> 
> where 'len' includes __ieee80211_get_mesh_hdrlen() if the mesh_control
> is non-zero (where admittedly it's a bit messy to have different kinds
> of checks for mesh - iftype and mesh_control), so we definitely have a
> full ethhdr after the 'offset' you calculated?

Is there really a *guarantee* that mesh_control is non-zero? A 
misbehaving mesh client could still be sending frames such that
__ieee80211_rx_h_amsdu will set amsdu_mesh_control to zero, even though 
its iftype is a mesh client.

 From what I see, this code in the caller guarantees space for the 
following bytes:
- sizeof(struct ethhdr): 6+6+2 bytes A-MSDU subframe header
- ieee80211_amsdu_subframe_length: can return zero
- padding: presence of enough padding is not yet checked
That's 14 bytes that are guaranteed to be there when calling the 
function is_amsdu_aggregation_attack.

Note that the earlier check `if (copy_len > remaining)` actually 
guarantees 15 bytes to be present.

Then is_amsdu_aggregation_attack needs the following to be present:
- Mesh Control field and Mesh Address Extension field with a combined 
length equal to 'offset'
- The first 6 bytes of the LCC/SNAP header (when treating the frame as 
an MSDU)
When 'offset' is 6 this means we know there is enough space. But when 
offset > 6 there has to be a length check.

I'd actually be inclined to just always perform this length check for 
mesh clients in is_amsdu_aggregation_attack, since this function is 
parsing the frame as an MSDU instead, and because it's too easy to make 
a mistake in these length checks (either now or in the future, e.g., if 
the caller code ever changes).

> Or maybe it should just not be separated out into a new function, then
> it might be easier to see that indeed the length check isn't necessary,
> and also easier to reuse the mesh_len.

I'd still be inclined to keep it a different function. The new function 
is parsing the frame as an MSDU instead, to detect a possible attack. 
Perhaps a comment can be added that this function is now treating the 
frame as an MSDU instead.

> In fact, given that mesh_len==0 for non-mesh, doesn't that make the
> change at least theoretically simply collapse down to pulling 6 bytes at
> mesh_len offset and comparing those? In practice probably better to
> compare against the already-pulled bytes if mesh_len==0, but that'd also
> be simpler to understand as a check?

In non-mesh networks the check is indeed much easier. The existing code 
always assumed non-mesh networks and did a comparison against the 
already-pulled bytes. This comparison against the already-pulled bytes 
is still present at the start of is_amsdu_aggregation_attack

> I think we probably want some validation here with iftype mesh vs.
> mesh_control not being 0 and really now looking at this I wonder why I
> let Felix get away without an enum ... but we can fix all that
> separately.
> 
> johannes


