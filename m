Return-Path: <linux-wireless+bounces-17471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05CA101E7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 09:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA01B169E49
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067482343B6;
	Tue, 14 Jan 2025 08:20:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38103233547;
	Tue, 14 Jan 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842851; cv=fail; b=q7+jUn2MVB/49G3pT3oSe2nOk4FjxsRKjnopIjC2w3GY6+ICgSfRroBZ3sTDw8geOwxptGjByexRLbiWimXTtZjWcXI8ReOaOnfjIdyCRyzfCr5pWdiYvFKIcGXtCnAXx6LLvfx1BADaCvkoaymCBu0oLKVyym7wEcyu72y0Daw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842851; c=relaxed/simple;
	bh=lyKTVTGO3YTLhsApEaGE6Z7BzSNKDysdBUsoH3iwdQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PITIkKH34sbFp3sdDHSyA4JDmNbLvquWpfYCV7FIEh0w5uiRMEY48UZW7YTMAq+S66mX0ad4GF8lgLlGXzoHtTrP/xkkMgDiY1CWEYgCDg0cC/Y5U44jeImANiFs6hCcCZ3B4IAhznBe+gkT+0R3CTv8t2T12n8lkqz03QaCQwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E8F1h0029883;
	Tue, 14 Jan 2025 08:20:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 443fm8arpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 08:20:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnXZgBTzelqWR1FjgJS+TRJeLTsBijRV0snvpXOAdFj+BTAmjLdVQY0cbLT0DW7SdTCBwUOTji+HdXMXbcmOVKvJAa6FiIF5RnxlC5LxB9prNexRI3ir9nxJGNtEZdwKMeISx02QOS6bsqkPaIkLI8gV7DQizRA9bux2Nz0Db1ielKZ771UNIUOM+Cz/V/Rcbiy5hgexYerBhvOfWwAjoRRg5oO9wG5p9eOTkLg8L7nEYZ5WJrkD5vyk0NIieqp41LFRFyr3SWky5EaptYxpO+C5TPrlfAYqztNzIqLMSnDE4tjm/Qb0JvVAKM03BM4ra/kync2mlFcEigl7ppEeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEss8ZqHmrV0HohtG2H8UkvwLHE7lPP/cpHC6M865RA=;
 b=Xo9IZ1+V7d1XhSG3VCJlFpVqk4yhP1WWbAqXfw9qcDRxhdMtPy1sxCYLkYNDGFhwQxBsm9DdVg7KzJWUsbVPcvmTQuXbhDI2mZRWzlfV41Wpvia9GlLPArBtEV1k72t7zRrUirX/Jq5riNdS1kYunQs7AbXjJl3iyqUrcASM7wbxsk3auQlRaNiKAmaXu+cRxwZaA9I2mTeHzCZ46PzMYyw4PIBRxc9Zs0Xjf+oBYx/vn5ECW70HorQziCo4125018xC8JCL5kTFC0zMud3v7QZn48cXia38b7ZmrAvAQjyzkb/KUL9OLLN0fm+SXl09FOvTbL5ZK+kZODaZ8Mqbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 08:18:54 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 08:18:54 +0000
Date: Tue, 14 Jan 2025 09:18:47 +0100
From: Marcel Hamer <marcel.hamer@windriver.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] brcmfmac: NULL pointer dereference on tx statistic
 update
Message-ID: <Z4Yd515dhZApbxPz@windriver.com>
References: <20250110134502.824722-1-marcel.hamer@windriver.com>
 <4020e574-be5d-43e4-9c04-1e5a708e70c6@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4020e574-be5d-43e4-9c04-1e5a708e70c6@broadcom.com>
X-ClientProxiedBy: GV3P280CA0110.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::17) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|PH7PR11MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cb6619-80b3-4a1b-d3a5-08dd3474154d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YiEi3e6ac5+OH9qudOX2gcKRTjYjY/fy2PN6ZaQgg2fbPbAqYjaxaDP5OuC5?=
 =?us-ascii?Q?YA0TweohX/1SaQCh6B3fjkY28LHSBJcF/6gF7m0QZogWx4mJ+YnZYv0OVWsN?=
 =?us-ascii?Q?67blN9Mabgzb1tW69cZ2emJTLYulkgM4Y/F26PfpgG2EV02xqRqbIIevCJYt?=
 =?us-ascii?Q?5F0ciIFgFSNerfQZe+MYaXudd5ahtNggidiQ0Nd0AVlPAIoNv+T9vRqTrTQh?=
 =?us-ascii?Q?SQJEWl94UGCVB7oEpy9MCHsmOo7XLsG4LdL5o3HLNIiNeZ66Ah8j+sO9Hz/0?=
 =?us-ascii?Q?YIbH3CjRMv8eY6UlHC25S1AhKLEjUhqJC1FRfpTCIdYlv4UFWt3OnHtGi2or?=
 =?us-ascii?Q?+ezgvH5tUBvuOQ4exmNEOiY6ZNqu4EeXh9kekKq7uePxjD7bAue1376U/1r5?=
 =?us-ascii?Q?jZwS9Ia/XqGeLpvgA55hg7mowhhdGmQcbE96UUzt7WcvOpwfY5flvK996urk?=
 =?us-ascii?Q?gQjuDWLJiEwT/8YUpWm9x9B6IcPuiYuW28EOgC5eN3YA5meKt1juhmHzCgTI?=
 =?us-ascii?Q?99/VwSVQV7l5vinA2HT1BHOe9HVImOS1KETyraHDRJEkYQsCVJJVcKli6DaG?=
 =?us-ascii?Q?0Psr+9QCNTYcW0wuiRVvpSCkS9miDJwEXb1RWf2FchdygQeyfdlr5ELRQOxE?=
 =?us-ascii?Q?66KGhdDZm/TouYGDZb0pyRkS3TydmMp8ZzKQB+vic2ZyKMVj0or08G8RH6jh?=
 =?us-ascii?Q?c5vbgqXy9fqTLkO+wpPJRrxynUsTpUwh4Xb476URBe6FlCxpvO3xnDWjXIru?=
 =?us-ascii?Q?GpK5p0X29d07ZfpuY5osAkTeO3gMc0tOPaYEGdITyBmxUVFn85pkgGhoJ3kP?=
 =?us-ascii?Q?BT1+hT8/w4R/MJc4URG9woMnerGMC9mkuZ4kk9iU+CRQFR+s2nPf0UWfKP9S?=
 =?us-ascii?Q?ikU+F44+kIAZalY8R64tyhLaA2iPnT5NgrdFYWnI0Utc+PYyUEykR1TpX7Fr?=
 =?us-ascii?Q?nzaydpFYahL0RoiY0guC2ipXcWEgufLq8id+W9C48hb0/jrHMaCT3wYxKzOV?=
 =?us-ascii?Q?1ZJ2kw6Vw0qSHUfRMqGsKWgVqDpfwh2EaGO7IZ3KTh1NgZM5XQmuRKT3jeSl?=
 =?us-ascii?Q?lpEG8PL2SdczBt3J7SCTC0YGOqZs9JFoS9tW5xfBRHwNV43974UvMzSEVrws?=
 =?us-ascii?Q?lo3j7Y/buCyq+srP0iqxqbaqPttH10A/EysiM/R+holw9NtAtEAvQL7tKtW6?=
 =?us-ascii?Q?kLhidHu3FY+LmMCJ5gI3SGfdijxBJPwK8FjpkowUdHP40lQ7n4cohcVp7qcX?=
 =?us-ascii?Q?4rm4+S7+jAFdtJBiGbIEkyVkMDtYP0+X1pxNOPYUhBrJ+jyQsR5UsUkGF2Tb?=
 =?us-ascii?Q?jGlpVHKywrSdGdfq5iPgezjJIB8TLC1aJ3OvOL9IvazgmxAkfKWbvqnIcCXR?=
 =?us-ascii?Q?CDGzmPAGDMnWdItdViIsnwjY/USz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckQjJ4SKpIblApAI+ddYdPbcXTKo/CWGKCsQvaYGOHVJwuP0l0UlumzZe3Q4?=
 =?us-ascii?Q?AytbsigvjP5cGsghr9hP5LZpCWsGiz1PuHwn4pN/+xAzZO8mWnyXeLfXPe1V?=
 =?us-ascii?Q?f/MG9t+hwo2q92iIF6kESsfogIQ4JKlfiZtXsCKvO16ChNkdHyegq456MpO+?=
 =?us-ascii?Q?ricFFFIyExt+xgGx38adP1gbqptZobR3+RlFnIaTO1FMkaop5m0oscRRi43G?=
 =?us-ascii?Q?GAtkLBMknmxhHqYxp8y9t/E7gDSyrCsR8xBDDEyHgTIRh1H1OmJWSk6c7OUT?=
 =?us-ascii?Q?VLYYu0//fdm1roUwGC/Q83lLR2mS1oN71oD40ABFnsZcjmgPufBsR2jmz81b?=
 =?us-ascii?Q?fiwRUwso2RMmAeTrN80Oeb1OIribKXPNY3MjWyaYefEikfT4FkwboXSM090t?=
 =?us-ascii?Q?eUuNojdy5jeBfIJ62WSQ1Ci7N7gLufoBfuBdCHAoyflYxbstZsLo9ueyi6m3?=
 =?us-ascii?Q?GBvwVN9rRpSWenfcRD00RPuTdurL2g/fgUP4x2NGGXAq9s4rMe5sboEebMHY?=
 =?us-ascii?Q?gl+U2b+OnhD9TXMfV4/Lk/e8we9aUArX6tBZgO4MNvPcJAdh8URgWx49uMLo?=
 =?us-ascii?Q?zSqK5AP1YbKhwpXbsRibpoauVaDGxUvQexTB810LjyOlnDL6m+2pr/U/8sPT?=
 =?us-ascii?Q?bAnvwzfzoWoTeZpanXdHp66LxJpzRKEwL1TjKUvAL5Sr73AilFE3OmiXf2Zj?=
 =?us-ascii?Q?ZRjC0QfGHlg9TzSG5Y3EDkZueZY2+lh4vDjdOBqDaI0sh+Yn3NTvQnGl3321?=
 =?us-ascii?Q?MI5gzAJ5SLURy3hdNOY5/ZKQFFGtzWLR6NSPDk1JP4H7o13gWTI/ev1EM/bu?=
 =?us-ascii?Q?tssdxzoZm+r+yHh8FO/dTTFRALqfPJd39GbisnVsleileePQNzvVODyL39wR?=
 =?us-ascii?Q?gjPyKPOrgPYwoI+w0EarC6amWVFKt68jcbYLHwlQMx5BTW1FgaWp/N4sPjoH?=
 =?us-ascii?Q?p7kxH6CT+JRfEaEdom8cRqndNvduN/EIK0sPxx56pm4hFnx+/3eYhANlhw1U?=
 =?us-ascii?Q?KDbWSyEq8MSEgHm7kaTvv8+X0NqiwpYZllxpl9Bj7/l3qpCAeEmSjEVDt58H?=
 =?us-ascii?Q?9xr+4VuwYTn02JUhLXa1ta/YV6+IY81DE8fazr/wsMukBOXJz0U77HoDLkVT?=
 =?us-ascii?Q?J2RMAqbstMuUUAFqGC8Y1LvFK1sHLsvoRHF23rPQVgEz+lb4/N6EQgnbNgzu?=
 =?us-ascii?Q?PwaCou6OZ6mVcmbxn6VcJ0Ssdui4eiHJNU3+VUZ76sv7RfVaBQmqwfr3laIg?=
 =?us-ascii?Q?JwOxEQ45gtHlK8ZPTZZCrPliqqFtHgV315PUAIuy9zSXCV+yE1kx/8VkYtDU?=
 =?us-ascii?Q?SP18nUJ0GLFaWImXeqbGJMjiZiwTCBypeZh+EoYyI4rmExLhTbREx36dmuYt?=
 =?us-ascii?Q?ZOetSzi8dbSx1ekR1wQzS1A5nywGcSeSV4zgi4V9tRpgTD8w1nORu9I5ih14?=
 =?us-ascii?Q?9oH4bn8S9SaQhFzIFmP3EBY1qTqsmzLLax/GzrB4eCW4sVe2NzMh9AQPiVC8?=
 =?us-ascii?Q?JeUHjUhBzlmvgyWTKqchAhLFb+aOuPjKebFjhzewGDopiFpvF803+qOHQgs0?=
 =?us-ascii?Q?50XMoS4eGdSqK1izNivgq7zyOzk/M0kqytlscklLjwKM/JpSMjq+7XccVoV0?=
 =?us-ascii?Q?BiK34SiVQ945/z+VGTtkt1ygD5cxZOjwEyZAGfz9rdfQPh1+Eb3nxOI/ghr1?=
 =?us-ascii?Q?69ZiOA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cb6619-80b3-4a1b-d3a5-08dd3474154d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 08:18:54.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BaAAOcZ71jFBybnLEfOlv+5zv+SS//12zmOgJC5IUL9SOEqfgs/Bysf81oJbUIPpc+qz1JQ/k8gdEKkk+6sS6dItlRUhzM0F8pFs7bOExg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-Authority-Analysis: v=2.4 cv=Mtmo63ae c=1 sm=1 tr=0 ts=67861e51 cx=c_pps a=uuboLt+qr3MZZMeqEnD08g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=nyReEFDZQmCFEhiLzyQA:9 a=CjuIK1q_8ugA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 2OomTKThjdNT0NV3-CMyKBzYXsZYiUom
X-Proofpoint-GUID: 2OomTKThjdNT0NV3-CMyKBzYXsZYiUom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_01,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2501140068

Hello,

On Mon, Jan 13, 2025 at 08:28:33PM +0100, Arend van Spriel wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On 1/10/2025 2:45 PM, Marcel Hamer wrote:
> > On removal of the device or unloading of the kernel module a potential
> > NULL pointer dereference occurs.
> > 
> > The following sequence deletes the interface:
> > 
> >    brcmf_detach()
> >      brcmf_remove_interface()
> >        brcmf_del_if()
> > 
> > Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
> > BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
> > 
> > After brcmf_remove_interface() call the brcmf_proto_detach() function is
> > called providing the following sequence:
> > 
> >    brcmf_detach()
> >      brcmf_proto_detach()
> >        brcmf_proto_msgbuf_detach()
> >          brcmf_flowring_detach()
> >            brcmf_msgbuf_delete_flowring()
> >              brcmf_msgbuf_remove_flowring()
> >                brcmf_flowring_delete()
> >                  brcmf_get_ifp()
> >                  brcmf_txfinalize()
> > 
> > Since brcmf_get_ip() can and actually will return NULL in this case the
> > call to brcmf_txfinalize() will result in a NULL pointer dereference
> > inside brcmf_txfinalize() when trying to update
> > ifp->ndev->stats.tx_errors.
> > 
> > This will only happen if a flowring still has an skb.
> > 
> > Although the NULL pointer dereference has only been seen when trying to update
> > the tx statistic, all other uses of the ifp pointer have been guarded as well.
> 
> Here my suggestion to make it a bit more simple...
> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> > Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
> > ---
> > v1 -> v2: guard all uses of the ifp pointer inside brcmf_txfinalize()
> > ---
> >   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > index c3a57e30c855..791757a3ec13 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > @@ -543,13 +543,13 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
> 
> Instead of checking ifp below you can simply do following here and be
> done with it:
> 
>        if (!ifp) {
>                brcmu_pkt_buf_free_skb(txp);
>                return;
>        }
>

Thank you for the suggestion and review. I considered that when doing my changes
and then thought it would be more efficient to only check the validity of ifp
when ifp is actually used. To skip checking it on each call to this function,
since it seems unlikely ifp will be used on each and every call.

Before I create a patch with your suggested changes, I just wanted to check if
you think it would be better to just wrap the two existing if statements in a
new if statement in that case, something like this:

if (ifp) {
    ...
    if (type == ETH_P_PAE) {
    ...
    }

    if (!success)
        ifp->ndev->stats.tx_errors++;
}

And then keep a single call to brcmu_pkt_buf_free_skb(txp) at the end of the
function.
 
> >       eh = (struct ethhdr *)(txp->data);
> >       type = ntohs(eh->h_proto);
> > 
> > -     if (type == ETH_P_PAE) {
> > +     if (type == ETH_P_PAE && ifp) {
> >               atomic_dec(&ifp->pend_8021x_cnt);
> >               if (waitqueue_active(&ifp->pend_8021x_wait))
> >                       wake_up(&ifp->pend_8021x_wait);
> >       }
> > 
> > -     if (!success)
> > +     if (!success && ifp)
> >               ifp->ndev->stats.tx_errors++;
> > 
> >       brcmu_pkt_buf_free_skb(txp);
> 

Kind regards,

Marcel

