Return-Path: <linux-wireless+bounces-17604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C51A13AD2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 14:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD09C3A1F0A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70741DE4CB;
	Thu, 16 Jan 2025 13:23:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C91DE2AD;
	Thu, 16 Jan 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033791; cv=fail; b=cGHInI9163lIL8SaHWbBC6rSauFEkDDgQZrS10rmQLI8SrE8vtPkV9p8jI1FfRRq6FXK94qbyUFSUrxYxmPH6ik6tWHE/AkaWRNyLdQg+gAmtBmJaeDnpXb30uWBW6KQWGSvvPW0D5XvvO0zP33Yd+haLIiAvVet2Z1z4H2bqxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033791; c=relaxed/simple;
	bh=pwgeoD7DI1UOyZIJe9RUuPzY960UD4OljxfyjaS+Y8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l/ezxwEb1a046EX8XlToRtcZ1tXu90gb/i52Rmhic1yfs5i8noNEvu7oOVtzwcIJF91QBDycEhSuXhYhpDkdjP8XpcbjRGr1aIlgsIpGYbq2CaAUlNPceedbPDoPR5OjC/4NVMmXbFYaOQuOLVKyhQs9PHhhhIYzLyXilscLb6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GCq0bc012560;
	Thu, 16 Jan 2025 13:22:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 443dv15n6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 13:22:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8Y/av2I8O5aO8S+7pyGpxV70iEO8jxC1X6y3v3fu5W4H64+sGkoGIlRueOVPdBLto8OLSJbFLLEQW4/raQbfVjWQtG8nwZZ5V/mHDXRnL9kroVPj1RhHVnMI/S2kabDRKTLA+x37XWpDULUagqA5cNKWN+zJagW2Yb1H1VGaHGbLj4GF+HiTiHsmjDzOgJc3kLVvuWqW6/kGt2fbrGDEvKMPYotHCsZtwAUvmHzUHNgzllliSKAOqlslO85MvrFSAjzXKZvLGzJq/7TaMfyr1Znar3Q46UhLwfevjzV386FxxALAKsLL7Z/nOZ0gelbt+5KoeiecD/9fAoe2k8K7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCzOdL/vUDDorHgerhTmrQFQZGN0apcNd8DnlGXeRBw=;
 b=iBrElEpfIu00hIk+sfruUls03ioI3m1Ja5aSRD5y9n9ikY6QW5DutSZYPPjBMfnm6DaJtgtbxvJsIny9LfNZvYfwk2z10+M7SOOYZGg0JcF/N0xUhtgpozVHYsdZltQIoFT48I6HPDEXZNU0uJCy56SeRd2smJFZwvkeMKhLqEnRM/RMbQRk6azOKU2GxA2Ph5HJH3Px6Iem98D7056kJDN/klpIVWJ23OYaWTYbhIqMu6ZhqADtfXypgRiq9VW/+W3lSDZzTAy6dm86UiaptepL6Rcip2DaaKy3kcA/8/mP9WMkEPE0LXWdLTB/j+/SCy1sUZ7NU8oWB0DxpeTp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 13:22:52 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd%5]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 13:22:52 +0000
From: Marcel Hamer <marcel.hamer@windriver.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Marcel Hamer <marcel.hamer@windriver.com>, stable@vger.kernel.org
Subject: [PATCH v3] wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()
Date: Thu, 16 Jan 2025 14:22:40 +0100
Message-Id: <20250116132240.731039-1-marcel.hamer@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0039.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::8)
 To CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|MW4PR11MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d3d707-a254-4c2d-3fda-08dd3630e0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W5xoM3Z2uMrFT++BSEumVhfW/qTPD+W1RloaoNmhR5dhYrfAlURC86+phjyl?=
 =?us-ascii?Q?RlWRfeGhfYl4DjaEVV+fBtyQLzoteecKnd5o+Ma2wfEAVQpPYNCrDk+8/21l?=
 =?us-ascii?Q?ONe47nHbFcb8seApe9AcbQ8o0bLse1hy8ZUqDiTQf9DY/0g02loTgPMldVOZ?=
 =?us-ascii?Q?FWTtofnIxQE4yyHaTL5QBc/AA90Zeg3imrDWWFTmNorS0X0Q7ikEyypPMgwm?=
 =?us-ascii?Q?ciFaBybYfpkeqzc2Fw5pidzv5pdMSKww6YfUwe7WPYZmUVA42btCitbSwRnf?=
 =?us-ascii?Q?RcDvPR2FA73XSHTrcU6qcIsgoa8RyQ4P/f2kED9YP4NrkzjObyuQnVE2Z3rC?=
 =?us-ascii?Q?oYV3Z48WKbIBkbRPKEGZjvhrfjdw4OjoO8Qvd8Qua1tJWuIw7AD1LI+eqFFB?=
 =?us-ascii?Q?5k3Zxn1Nh4LC7G9ahD9fLiOuyuUII9vRrIAmgtuKy+u4iphOmxo112OelC8T?=
 =?us-ascii?Q?swS6CMqYrJZecaRVYzrhhiPQ/Cqwyz5CnlbtwIl8twY4hxrP9zE2mmCI0fjC?=
 =?us-ascii?Q?9ge8HD349SovbNAw9bl9Likb7MzUScWMaAXFwgsrLSBwk8YHEmJTe6wEoSD1?=
 =?us-ascii?Q?284Vx1eueAhTNG/cq7F7pKC+5pmugyj+PFjADc8QN+12vzSK8AU141fr8Oyl?=
 =?us-ascii?Q?4w+22xYZu4l/Xe6IvNHwkJPoekFtIOHOKptvdUEsJPzd3k60wjT8jn0CTyKL?=
 =?us-ascii?Q?6RMmcRZBHVsqanwCu+3l5wUUWvyeK+ZkNjLh6Mw0Fa/KiBJsQhGDDI6PbhtK?=
 =?us-ascii?Q?um4KLtvg+PoCxyYdpGRBxXw/2SCKkrsZ2L2T2N+G34e2yDJGA1KyEuo4T1nG?=
 =?us-ascii?Q?hk6/MegTX8wmWPGaElugk2vhpAGtLb1i/XSEy58q+knpGbK3xENtGWK+gGvh?=
 =?us-ascii?Q?DzYNeiBb9gMXe5uiR6nVpfdpavfwmWYJ1FTuF3Ndyd9B3YZpCRrZFbJ/NWsw?=
 =?us-ascii?Q?nimJ9KvMz6wpp3SReKk30om1bcR8OwtA24tcKLFghbRYRM/bczLsydH57RIf?=
 =?us-ascii?Q?8RTIC+Fac4EK5h9xubDse3R1ZJTkir2+sPy2ci46TKoFpqWUX4GZfbPhlE/j?=
 =?us-ascii?Q?J6JE0lF22KSznHr3NUGI0FFP6rGzffMIfWhRatYGoS5OAOV3r4ehHEYUdHO9?=
 =?us-ascii?Q?EmyddyZ8QrU8zpMmhRz+vku8lw/4eHpc0xbi9kIhuhmwdWu5ncEOS4dAD+po?=
 =?us-ascii?Q?DLMOT9q3xyuXXa2y+NRdzrYk4N4dL3xcZm8crlOIRpIdHB1seke1ghNRrman?=
 =?us-ascii?Q?IXLmy4KP4n8JvxhBWCatGoKPZLgnJFnKuN5Ig82aDgZosdhdzH9YmJW/VQtR?=
 =?us-ascii?Q?s6u3wd3/HjScmBtFVO5cHhKOCxwMBLg6Cttr38reyaS25lJ1Pt6HP52FHQmo?=
 =?us-ascii?Q?m+CmqfLnOv+hQcsXHHNC+H0oMbEXPloje0iDAwNeMPd/+hURbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/uEbQZFVNo/68rudeqvKdMQyGdC89KhlzZBPAvBZrTN5XoE3Be8tiofx4Km?=
 =?us-ascii?Q?pAdpivtirKbcftOMIl6DbVrGzo2Y5n6FtwC1pdP1vLdCZGxEfeis5XH27uEN?=
 =?us-ascii?Q?ulp3J5/iwSOAt+OQSH1ceDiZiIMcPJhR748nG+AQmHEP0HAAcWswLpgkPAOj?=
 =?us-ascii?Q?I4LYxq7jQxoVGcxJ11QjkQmSn7vfER/wX71F/XJxmcSW2GY8tIaylSkLGfKy?=
 =?us-ascii?Q?83hDbaoXlvypS8tr7PsWx87f9ltEbRy9cUlN7PMCH2biApewiq44+3YzazLh?=
 =?us-ascii?Q?/aiRBUj6+VbV6Pn2v+0JjnuSeoR/PGCpMaeljRnaD7rrDTLGnwhOw2O1aSkC?=
 =?us-ascii?Q?gPirR+qTXtpwubNj4D2WOSoQzYjtHLtAMDvDbyu+JCYRMCL15VYQBgb5wDC0?=
 =?us-ascii?Q?cwXtS0bK+IBIQAAWHdJd0Exo1rwTNfrzeQjfVGqIVMM8kjvhGvdiMrlwl6uO?=
 =?us-ascii?Q?01TzRYfMY6L6x8Fol6iLbgj3m/HLZyPmlZX6/LCJt8E/y3qjNgTfkL3iFGkZ?=
 =?us-ascii?Q?au/HhU/YYv6SigasRN0GJuC4ae459aZ+Fc7Nlnzw0FyYNCBH4ZhesD/gEysj?=
 =?us-ascii?Q?SMBsQZv4sdYwmSc/usKSxainzX35KMkKi1q7QAx70G/Sa5ATrzwvrCwb+Jn9?=
 =?us-ascii?Q?VcdDMUAGEWoYGDA9fiW6U3HUrKGt86a4NkB55PIgzuiu5gJvlDDaD+7lZxVJ?=
 =?us-ascii?Q?BUoi+56f7BIHoHOPCjW7yhFtd6QtZVkZX1XdeJAoQUD26kSImUcWVU5iGZs6?=
 =?us-ascii?Q?aXwxTqEGjE+MAnuHWI0m1/1YrtUZx+0sRmjQg1GIdR38bQ80HAPUQmwiesfV?=
 =?us-ascii?Q?NRF8P75UgQvfKwkuotNl/hFE9ylIKAzYgiZvS5DijmabbXc0AYJw138Ov1J1?=
 =?us-ascii?Q?N4O1WloF3ff3bqDfh3yeTGyylfYF6bVpyE1wHvEtO5MRgsf9XKTKS+Tup0Vx?=
 =?us-ascii?Q?O56RC97PnBiwaTIramABeflFTGUEEPnekrfAZsXwkLVVkcTO4eue5qZhNojG?=
 =?us-ascii?Q?uJT/gLLL7HGvy1E15ujPIY0hEx5hDmM4o8YWgEGmGNQiYwdo62/2A67E1H3P?=
 =?us-ascii?Q?d0+kPjSwtVIGorNe/aLvpxfmEisCNXTKUTrzOhk+YbmkxifqElmAiCbBJn3W?=
 =?us-ascii?Q?xpI0izV1I9BcASDcTc9nQYPIvN5OY247Mw9Iux6+cciKc2dFDJ33Jo4SSQD8?=
 =?us-ascii?Q?DIqT1hKdWpaDfdH45Jk3UQNqarOe+Ng/CWSlzNz1xcjeIMLs0nMwDoQs/2Nf?=
 =?us-ascii?Q?RxaVkZUqCXmGQb9uHtHEJrjt34H8W4XGt9KVq7pL1h58yyO2m6hUc1GoK9w0?=
 =?us-ascii?Q?3ajYHtlT3k9xmBejciPPbc1e4M2vCbfyt/6GaL3lKm4qB8LHzJ7s7cojw83t?=
 =?us-ascii?Q?sqRQpCrYPtF5yOFj9+sBNJC3L1BQ9AUywa+oOEv0sCPbqZUqncZ7AbKunynC?=
 =?us-ascii?Q?a8JjUSGVTvjS9fE3ycTDmcOe91YpmVkPuVqi82XSHDfyEkQ+nA7469deped+?=
 =?us-ascii?Q?kAHv1UY5NSFpdBOlIKB/O2zGqCCtIfeb04SJNUUjf0HkxZ+hYq2FUNCYrN8B?=
 =?us-ascii?Q?Rs+c212Qb4G5jlPKHCi2SPIGP7a6QNF4CychV/vx/RJce/l9bdX9z8mbwicL?=
 =?us-ascii?Q?a/KlFDNqCYJ4EPkHud74YONB6zvbe9fCWnt5lHKNo7HsjmahqH9rILnfaLYz?=
 =?us-ascii?Q?8/TflQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d3d707-a254-4c2d-3fda-08dd3630e0fe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 13:22:52.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByJkE2Zk4jXOKJW48pYa493JV8gfpbrCDnZn6ZeK++J2g3hUUWIMStItmta9dCeummQpz9iP1wQ8HIBjAJ6p4Q/L3CF+9dAd4wsrMmh6/6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-Proofpoint-GUID: 3t6KKNLHFkbOIyYQaGonnzA1mWJw3kP5
X-Authority-Analysis: v=2.4 cv=N5zTF39B c=1 sm=1 tr=0 ts=6789082e cx=c_pps a=+hq7TYb7Jqj0EztKBnUMzg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=cs7uqfOSIHpNwF6wjosA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 3t6KKNLHFkbOIyYQaGonnzA1mWJw3kP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=51 mlxlogscore=734 clxscore=1015
 suspectscore=0 bulkscore=51 mlxscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2501160101

On removal of the device or unloading of the kernel module a potential NULL
pointer dereference occurs.

The following sequence deletes the interface:

  brcmf_detach()
    brcmf_remove_interface()
      brcmf_del_if()

Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.

After brcmf_remove_interface() call the brcmf_proto_detach() function is
called providing the following sequence:

  brcmf_detach()
    brcmf_proto_detach()
      brcmf_proto_msgbuf_detach()
        brcmf_flowring_detach()
          brcmf_msgbuf_delete_flowring()
            brcmf_msgbuf_remove_flowring()
              brcmf_flowring_delete()
                brcmf_get_ifp()
                brcmf_txfinalize()

Since brcmf_get_ip() can and actually will return NULL in this case the
call to brcmf_txfinalize() will result in a NULL pointer dereference inside
brcmf_txfinalize() when trying to update ifp->ndev->stats.tx_errors.

This will only happen if a flowring still has an skb.

Although the NULL pointer dereference has only been seen when trying to
update the tx statistic, all other uses of the ifp pointer have been
guarded as well with an early return if ifp is NULL.

Cc: stable@vger.kernel.org
Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
---
v3:
- after review return early from brcmf_txfinalize() if ifp is NULL 
- after review improve the subject line

v2: https://lore.kernel.org/linux-wireless/20250110134502.824722-1-marcel.hamer@windriver.com/
- guard all uses of the ifp pointer inside brcmf_txfinalize()

v1: https://lore.kernel.org/linux-wireless/20250109155201.3661298-1-marcel.hamer@windriver.com/
- initial version
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index c3a57e30c855..3d63010ae079 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -540,6 +540,11 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
 	struct ethhdr *eh;
 	u16 type;
 
+	if (!ifp) {
+		brcmu_pkt_buf_free_skb(txp);
+		return;
+	}
+
 	eh = (struct ethhdr *)(txp->data);
 	type = ntohs(eh->h_proto);
 
-- 
2.34.1


