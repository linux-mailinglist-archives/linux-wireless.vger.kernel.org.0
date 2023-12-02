Return-Path: <linux-wireless+bounces-330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D840C801DFC
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 18:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66311C2084A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189011732;
	Sat,  2 Dec 2023 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nXRzlDHx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F2124
	for <linux-wireless@vger.kernel.org>; Sat,  2 Dec 2023 09:57:03 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B2HqS5o030319;
	Sat, 2 Dec 2023 17:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BIfJceskoLsy5hLUlIGsmaGOjXFcMo9WthZVhy8m7O8=;
 b=nXRzlDHxPLZ30p2lvDkLKyhoemiBtxiGagVNy1gXeDQgLQc8+Z4ZEqmOV0eZlrO8guS7
 6yma/WVlW/Or/PTl1evMaB4CUgmkeCjWr2DV388hHy66QSEGSEqOoWEI6GdSTW/L5HcN
 Y8HP5/hLjpyilQdeDvRg18Rf+4H3G6uZijwVYpmpCPEO67IPDO61+fiP+jOyoHX7xvFG
 GR4hOk0qMrpSNIq9yoyqkTFEGxs7ohIzJGLPAf3Kk1rDgm/VBYFw+tZJ7MJLG9sUO96e
 8XzTSBm8I09B/8i7JXD71J4vah4hcnUkU66uLrpIY9SHS10Wt/RKoIodTOsk399x0PFS nA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqsxw14jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Dec 2023 17:56:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B2Huv6f028252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Dec 2023 17:56:57 GMT
Received: from [10.110.26.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 2 Dec
 2023 09:56:56 -0800
Message-ID: <4baf4dcd-26e5-47d6-bb17-4e23ccc8c12d@quicinc.com>
Date: Sat, 2 Dec 2023 09:56:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] wifi: mac80211: Modify type of "changed" variable.
Content-Language: en-US
To: <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Anjaneyulu
	<pagadala.yesu.anjaneyulu@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
 <20230604120651.10354a05eaf1.If19359262fe2728dd523ea6d7c3aa7dc50940411@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230604120651.10354a05eaf1.If19359262fe2728dd523ea6d7c3aa7dc50940411@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IbNPOWa2ZZGqW4xbc0c1REfLISUZJo56
X-Proofpoint-GUID: IbNPOWa2ZZGqW4xbc0c1REfLISUZJo56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_16,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=498 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312020133

On 6/4/2023 2:11 AM, gregory.greenman@intel.com wrote:
> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> 
> Currently, enum ieee80211_bss_change has more than 32 flags.
> Change the type of the corresponding variables from u32 to u64.
> 
> Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> ---
>  net/mac80211/cfg.c         | 79 ++++++++++++++++++--------------------
>  net/mac80211/chan.c        |  4 +-
>  net/mac80211/ibss.c        | 16 ++++----
>  net/mac80211/ieee80211_i.h | 14 ++++---
>  net/mac80211/iface.c       |  4 +-
>  net/mac80211/main.c        |  4 +-
>  net/mac80211/mesh.c        | 30 ++++++++-------
>  net/mac80211/mesh.h        | 19 ++++-----
>  net/mac80211/mesh_plink.c  | 37 +++++++++---------
>  net/mac80211/mesh_ps.c     |  7 ++--
>  net/mac80211/mlme.c        | 12 +++---
>  net/mac80211/ocb.c         |  4 +-
>  12 files changed, 119 insertions(+), 111 deletions(-)

We are finally at the point where we are testing mesh and this patch is
breaking mesh on 32-bit systems. There seems to be a fundamental issue
with both the original code and the revised code where bitop operations
are being used on bitmaps which have not been defined and sized with
DECLARE_BITMAP.

Note the bitops all use unsigned long * for the bitmap pointer, and
hence it seems important that all the bitmaps being used with these
operations use that same underlying type.

The specific code that is causing us issues is in
ieee80211_mbss_info_change_notify():
	for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
		set_bit(bit, ifmsh->mbss_changed);

Here in the current code changed is u64 and ifmsh->mbss_changed is
unsigned long and hence processing a bit > 32 writes outside
ifmsh->mbss_changed on a 32-bit system.

At a minimum struct ieee80211_if_mesh::mbss_changed needs to be properly
sized.

We have validated what I consider to be a quick and dirty change which
modifies struct ieee80211_if_mesh::mbss_changed from unsigned long to u64.

Do you want that change?

Or do you want to propose an encompassing solution that correctly uses
unsigned long * and DECLARE_BOTMAP


/jeff


