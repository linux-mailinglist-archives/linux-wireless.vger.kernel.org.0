Return-Path: <linux-wireless+bounces-17327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9BA0925C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9B218815E2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA03205505;
	Fri, 10 Jan 2025 13:45:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35A2063C9;
	Fri, 10 Jan 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516739; cv=fail; b=pQ9IjuGG0ITXgHDAUoPYoFO+QW6zUlbByqVkn7fcLU4LnIETHNLA3j7O8LZ57TotF5dsQ/+jJf1/PmTMcmUfGa8HxWVNhhG1MlzyKDIyTpVKXpmcVYDBIYdxgM+Z40qJEnRMqL/8bSqGuJnJLs1L8GpSVqgV5SxdQPMv7r2sZIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516739; c=relaxed/simple;
	bh=HU/QaKn+SdwQg3EYNKfDxV4y1SHj8A6bIRgdhpPZ/YU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AhxQUj/lpp9lGlTBeCpDL1/phG+yE9y9NL2DcDYu4PW6AcPBEADxmXiJaifOMu54q7GNPVDBaHk0B7WFhpdWrz+m67ElYs4Hm11ksdm02GwLps+3AJod+FrkqwowPDJ+cbYwsPgst+ogM8XxaKF0u2IcEmx0nJ9TozaKhMIyVF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ABtnYF007768;
	Fri, 10 Jan 2025 05:45:27 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 441fphu22q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJwZxJ++ysP/9mqAv0ahoCHZMj28J/rOsb6evlsiBIH4IhW8O5kbf7ah9SxBN6RxN86hXGWWhXdGGF1Mfwsqf3aRAq8adxI2ROz0Q9RM0aoB//ha3njxiWXofsD2ywJXVB69a5Ss1RAQHkU21LumH8D7IHtz3AyHMBtnUW27s7mmfWcfvA3mp0GXY8yfIhAlFneD13lFYYJnfGyTLAEApjRz98TGDaFTwjG2KjvTP1SB1nSH42SYeXvqZaU/qmFB9kTSW0irD6ySVMmOAW+ziXu4MuhD+MnlnoaWtkRmqOXdHlsRxxBtBVcP+SvePHKzfwrwfT/D5HbFC5r9yh6Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bediUMjHYPycub/yP1T9RtwMPePloHt1tpKwjpXiHSA=;
 b=Qrt9m2SqHGNLKZBFWmrbv/BVEzXOOi8wFl2RiP/OEbHwYKhaSt7pA+LtYeBNmzuG0SvmtwLKUmoo2tznjvgTtiA7jwE0mVXm6dB34KyLBRScLjSIV0NHhWKkbS9KGL2ByIGOcVBbaCIBBTo1ammK5VlFitRLxjcRWFvu0YZ35VXNoFKAiqQab7APFzs5F3S87TjpfINKQCIiZWJcvBNo+dOlsSZ/Mmm2VHxmFDQ/Tx4/taxGLlpBwKhRmhQBrXsD+xvp7q7aHebJV+0eNPysMuqREe7FcwQDSztPt4d82IjZVT2Wpp/2ldTktRHAPfsQYtVlhPzANtZhJm7unPPGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 13:45:22 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::9629:5ec0:f779:4bd%5]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 13:45:22 +0000
From: Marcel Hamer <marcel.hamer@windriver.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Marcel Hamer <marcel.hamer@windriver.com>, stable@vger.kernel.org
Subject: [PATCH v2] brcmfmac: NULL pointer dereference on tx statistic update
Date: Fri, 10 Jan 2025 14:45:02 +0100
Message-Id: <20250110134502.824722-1-marcel.hamer@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5617:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 474fc371-146c-4093-18ec-08dd317d073a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ksLEMNcJNsfVg6qE7/UTDi13vCdoJj6NHZYGn68G1H8lPYp7vHAWhRAX/Ho?=
 =?us-ascii?Q?4dWUqwQEOD02DbIX03Que5p7j+T4DsQJMoH2zaqWdYtfZ2cmkiotd+EI6Xhx?=
 =?us-ascii?Q?bOQ9T/COf9j3xzqxwIZO7reI703qr48tHH++C2kZ8SkxoNilrgC6BosKJV9W?=
 =?us-ascii?Q?pIkTW88eI9lwKsf6Z6SIPINH3SFggnwWPfER5eM6bbQfLAJ4FNm7i3sn1Moh?=
 =?us-ascii?Q?kgR5IGDTSSE49lcGfltQWRgH50+HX4kirUk2Y5w7wE82tfyQDVt3MXWvq9wp?=
 =?us-ascii?Q?A0p9WXmnGNa3UhnX3PoHN8vAuZQJGHobMIp0pXNYYLDHnlgbO1p+du8EZkHo?=
 =?us-ascii?Q?BwI04SFPjOlFXGPu0O1+mbvnd+nCyIrRfCMNy1UwlsPqHLZFR5JvCBscOXPu?=
 =?us-ascii?Q?wq/WhObfcS7pqsmtdnADR0uCxVVhAp/q9eQMyYSsEmvxEF7CdI4q9QxYdfS3?=
 =?us-ascii?Q?x/3UHaByX2t7g3EV9iUUkA96mgtvoDub1mRR3RafReSpRXFpEiH2tvD2n4C3?=
 =?us-ascii?Q?g2EvAKkD0xqXeYJyx7SqZLXawNS6Y6BuZsKX4kTVTYeJ0rtmBHsfE7WoEm5a?=
 =?us-ascii?Q?c2Zo/4G6zB0CPv/VFtKSfW/II5V/NTYNT/9S70M7Jq4t8IyTeYX4Nj1GU1I0?=
 =?us-ascii?Q?+3mrUtcOG64qgeWsy15RIIKEdXYXPiTo9fwRdGA71i25Y6TonZQL6pKDx1u1?=
 =?us-ascii?Q?Se5g0FvLW8LoE/EL8DXveOxTSoi6HkXTqjkrxl+ZzB1ViLcK3rYhIOU6Krsg?=
 =?us-ascii?Q?w5zBUo2blcMlnAoCQfUGpkwuWBAcuQTXgHrt8e3peYkCgeiwOSZdm5sEu86B?=
 =?us-ascii?Q?4aUOr9x/Y+Ese5Oa+rXE5RgFyD7dNrnKB4oURqSy5zY81JeqWPbHVTZQoMXS?=
 =?us-ascii?Q?COm9FuMG3oWY0Zeb+ZW2QueuWkyCKv2TYQlFsEmP17npS9U8UvfMUWe2xi64?=
 =?us-ascii?Q?trEcK9Yzc1hDo0QOWUgiwtnirPvHTcBFeXeKJjU3uZonvAWZIl40/wgP0npG?=
 =?us-ascii?Q?hs0g7jK31K29NSHVTgNrRAejA6oVwhFqF4IB8pZ9KPIyuY6qvTMT7gW6rKc7?=
 =?us-ascii?Q?jsTTcyxSQc+8dfIdJNtIZ3s343cFFRoXJIYO7ApIVHSUnnWXiCgjOMyTsJS4?=
 =?us-ascii?Q?NSMdveeJzM2edMqCG6/LmFGr/sZTszlqMEYQOSWIbJ2l4UL/WAMc0OBJUxgF?=
 =?us-ascii?Q?yu0rFhnmAtluS27HK2Lfo4E6t94NBu/q0l6fvRUlfWzeD2NodmlhWSLAl5S6?=
 =?us-ascii?Q?cLjGy1mx8bLVfkfrWLqu7mjbTQJQWtXlsovJXfHrAE6yDXl37IY3v8TueGPw?=
 =?us-ascii?Q?S+H8oiMlSr/DG+q8TjtuskOONtcRwltN+86KFVCVFwWtAAeBA2v4webbKVvK?=
 =?us-ascii?Q?rE/NL3W96pwDBpoddTNHCywUkruS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5617.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YeYu0qSL8YieVUWnX4f3JMVMVOaEI2FfKxLYSjXoVnC6Dd4refj8of5RQIcV?=
 =?us-ascii?Q?/JQ9qm3qY3QAwTHSICW8DNfvRkG7Z6teocK3zr7wgRx9m7JX4ZaBVrksCM46?=
 =?us-ascii?Q?7XGF8QjTuruZ/FtwrHzrGVj8qfAZwG2Gt9GInaed+1IR1vCd9x86dqqyxu3i?=
 =?us-ascii?Q?c00E65v0rsUlg3w6U3eaXTx6vLv8ZrrfKXQLo7LtDeat6DfgDz1S8dUih/zF?=
 =?us-ascii?Q?3P8bIUUc88mN3gSen2BaaapKbYb5SXFCj/rTJWrRLk9ewzRPqDc8lVHxTie5?=
 =?us-ascii?Q?jBvN0HCOuAXQHtMxamC9Cfm2RMkS0d1dA85cU2QpsDSuVvoqWJourjuWorDz?=
 =?us-ascii?Q?a7WrqUPSIXeLOoMHLNS5BpmmneKWDn1Yp+GgyIi+Y9+M7h9vNjLaTQAUNk5N?=
 =?us-ascii?Q?wtsXGrfX3FqW8hkcSIQT/+ArC1sciBzr+wN3v3GhZxMf3/4HokQOFoOHO/0W?=
 =?us-ascii?Q?6q9lstCToxQ4inuFuQCGI8J8BWh8h00CkFLELhMCOm8mPrD/L+e79n4JPeVz?=
 =?us-ascii?Q?8f4ISSQfGzaZtG2nV04hxBlXn7W0klpEV3nwSgDKMcbfK9AZhUZaOVyttNpF?=
 =?us-ascii?Q?gdvmUb+TQwWZDDEbI1oRb1ghO0iLWX/hdfzUut7/oRQIgUGVhgU8k5QiDlnG?=
 =?us-ascii?Q?toIWggkCVF3uf/7+xq767eV94g+6Cj4MeY4ypfxnGEUjVRw4oXl+Dd2OTqjE?=
 =?us-ascii?Q?jT5XpHvwDJZqoXccXxo73m8W+F88gIZYZCDMrVgjnpwzEpf2RRIhbBOphkyk?=
 =?us-ascii?Q?qOyE/MWArHjP8cCHoUObS3yMeXvRqTzQTMkpsjsNBMVLAfpoy6ZGYII8UVG5?=
 =?us-ascii?Q?u/nlRaBauaI7i9eK7AYOqY7LEbpOiyJfzj33C2jQghQbgPqQTisM+YVuqibw?=
 =?us-ascii?Q?KkoVJv3GV1qH5DBZa2aWyXIuPdO5e8KlYkJP6H3kdATjh28xGYr7VL+HbmRd?=
 =?us-ascii?Q?7iodZbcVhSA2hTZ+SS7Ce60VI8TKAMTMdhQHupYgQ/peuQiRy9ajubA5DFu7?=
 =?us-ascii?Q?7xNdMNGPKqeRJ/ODelNFrUVaL+iQ5qub2adUDv6QeJ882tX2B2YtGWejdckg?=
 =?us-ascii?Q?nustMHyB9+LDjkNrByCfRTwQ8WK0n7EuWzn7bsvoB1Z2jWGgoEQvjYvbxkee?=
 =?us-ascii?Q?Egi4J4Ih0hLcncT7FRKbqj1nbjJHnPPC1gNCqJ8+5yAdp40HKAnWLjVCDrD7?=
 =?us-ascii?Q?kXvB594nNGqTPMrqupJG/v/w9QrdSX5BTeJuAsiEQ/dEDKpsy2x5fkM/OUwj?=
 =?us-ascii?Q?SwORAjbqHwfFNFPDViGN/Z02Pr2SolQdH4ycL6TNpkfUy8QHFaP8Ezb2qITv?=
 =?us-ascii?Q?j1GkMmaqYH+bxhiAzQRRq/ZmNBzDreFKq7xUKhGQA4EVlvujH6bTQrXuiPjS?=
 =?us-ascii?Q?yzFFncx6IrVSPgfHGNPgNeEybD9ZFjhFmIkUyE4pg041TjZLjRMlGm0jrzRP?=
 =?us-ascii?Q?GZsBJ50He4zR8oiBnItjqWewx4LeI3rX0Vuddb5lCVe59LkuunE0YouRqs8W?=
 =?us-ascii?Q?OjfECWKZ/PrjQrtgsKG2sErql7xXpZF3FnGrEmhbJs9ZmJO4kya8C+gFmm4U?=
 =?us-ascii?Q?hEBdbs7bsDiIC3mnz+C33l6ANzzuPrQETRidSEKOmzu93x/VUZV1splJLH3l?=
 =?us-ascii?Q?dvnDxy9C2Zo1gFd0YMD/C2h3elS9RpZd5d0c9u7RLMFJmNHWlvEaUtKC+gTC?=
 =?us-ascii?Q?d8uHxw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474fc371-146c-4093-18ec-08dd317d073a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 13:45:22.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LysEq6NmL2aPzT3ay3Q2kg+pNxmVlt10uXDDfHCDY60m/CydOyiGg/MJCOOA94a7dtATvw7sXSi50xxD39vXNaIxdVo6mMuHgnV7wHrxUak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-Proofpoint-ORIG-GUID: w9JOjbKTjELv0x3vgt7m6oHfK1xx8e3n
X-Authority-Analysis: v=2.4 cv=Oa1iDgTY c=1 sm=1 tr=0 ts=67812477 cx=c_pps a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=XyqbVMalFaQxG41joXIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: w9JOjbKTjELv0x3vgt7m6oHfK1xx8e3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_06,2025-01-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=25
 lowpriorityscore=25 phishscore=0 mlxscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxlogscore=742 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2501100108

On removal of the device or unloading of the kernel module a potential
NULL pointer dereference occurs.

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
call to brcmf_txfinalize() will result in a NULL pointer dereference
inside brcmf_txfinalize() when trying to update
ifp->ndev->stats.tx_errors.

This will only happen if a flowring still has an skb.

Although the NULL pointer dereference has only been seen when trying to update
the tx statistic, all other uses of the ifp pointer have been guarded as well.

Cc: stable@vger.kernel.org
Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
---
v1 -> v2: guard all uses of the ifp pointer inside brcmf_txfinalize()
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index c3a57e30c855..791757a3ec13 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -543,13 +543,13 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
 	eh = (struct ethhdr *)(txp->data);
 	type = ntohs(eh->h_proto);
 
-	if (type == ETH_P_PAE) {
+	if (type == ETH_P_PAE && ifp) {
 		atomic_dec(&ifp->pend_8021x_cnt);
 		if (waitqueue_active(&ifp->pend_8021x_wait))
 			wake_up(&ifp->pend_8021x_wait);
 	}
 
-	if (!success)
+	if (!success && ifp)
 		ifp->ndev->stats.tx_errors++;
 
 	brcmu_pkt_buf_free_skb(txp);
-- 
2.34.1


