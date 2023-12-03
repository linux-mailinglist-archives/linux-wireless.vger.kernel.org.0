Return-Path: <linux-wireless+bounces-337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B630B8025A2
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 17:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78E61C2034E
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57115AC6;
	Sun,  3 Dec 2023 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WL8NKe8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B7E5
	for <linux-wireless@vger.kernel.org>; Sun,  3 Dec 2023 08:48:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3GS8VC007312;
	Sun, 3 Dec 2023 16:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=okWswveAVUclgrdavDa4bn6zAYkXmdJL9NJoykb3t+A=;
 b=WL8NKe8DyH2Du/UrYkOeIIRz0HmuAnfo0RRSZXwxRtOY0aBX6TEGO0gpqia26oYwMvjc
 r2EVQO21nd5Eyozf7yeRafAj0aKgY6gApz9n26LDWPi5spvtE+/OOG9+j2+ps78TMc2/
 emaUpCJbc0ARsfKCTweMTtfBM3+sFEe8ELaQuPcXCIHe0RVvM57v456zoUQriXA+3H4+
 +i+uMEKNXlpd7eTYFl4sK31RVEYNIw55LzKFhSZ5mUwJHhmO+fc4BBtEbEAsHyqIctco
 0QfZ8hyOaHjhV06n1VHOO0voKLnZ3dRPJjSs4jA1+zXNBjLf2kWM6MD7xVIbG4Lp0Qcf VA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqwrvsyjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Dec 2023 16:48:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B3GmOxX025486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 3 Dec 2023 16:48:24 GMT
Received: from [10.110.89.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Dec
 2023 08:48:24 -0800
Message-ID: <f31decec-f6a1-472b-8e35-001bbf18b668@quicinc.com>
Date: Sun, 3 Dec 2023 08:48:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] wifi: mac80211: Modify type of "changed" variable.
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <gregory.greenman@intel.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Anjaneyulu
	<pagadala.yesu.anjaneyulu@intel.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
 <20230604120651.10354a05eaf1.If19359262fe2728dd523ea6d7c3aa7dc50940411@changeid>
 <4baf4dcd-26e5-47d6-bb17-4e23ccc8c12d@quicinc.com>
In-Reply-To: <4baf4dcd-26e5-47d6-bb17-4e23ccc8c12d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OqRgLoGy6h_3m_TLt2CDHk2umCSIF25K
X-Proofpoint-GUID: OqRgLoGy6h_3m_TLt2CDHk2umCSIF25K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=631
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312030133

On 12/2/2023 9:56 AM, Jeff Johnson wrote:
> On 6/4/2023 2:11 AM, gregory.greenman@intel.com wrote:
>> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>>
>> Currently, enum ieee80211_bss_change has more than 32 flags.
>> Change the type of the corresponding variables from u32 to u64.
>>
>> Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>> ---
>>  net/mac80211/cfg.c         | 79 ++++++++++++++++++--------------------
>>  net/mac80211/chan.c        |  4 +-
>>  net/mac80211/ibss.c        | 16 ++++----
>>  net/mac80211/ieee80211_i.h | 14 ++++---
>>  net/mac80211/iface.c       |  4 +-
>>  net/mac80211/main.c        |  4 +-
>>  net/mac80211/mesh.c        | 30 ++++++++-------
>>  net/mac80211/mesh.h        | 19 ++++-----
>>  net/mac80211/mesh_plink.c  | 37 +++++++++---------
>>  net/mac80211/mesh_ps.c     |  7 ++--
>>  net/mac80211/mlme.c        | 12 +++---
>>  net/mac80211/ocb.c         |  4 +-
>>  12 files changed, 119 insertions(+), 111 deletions(-)
> 
> We are finally at the point where we are testing mesh and this patch is
> breaking mesh on 32-bit systems. There seems to be a fundamental issue
> with both the original code and the revised code where bitop operations
> are being used on bitmaps which have not been defined and sized with
> DECLARE_BITMAP.
> 
> Note the bitops all use unsigned long * for the bitmap pointer, and
> hence it seems important that all the bitmaps being used with these
> operations use that same underlying type.
> 
> The specific code that is causing us issues is in
> ieee80211_mbss_info_change_notify():
> 	for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
> 		set_bit(bit, ifmsh->mbss_changed);
> 
> Here in the current code changed is u64 and ifmsh->mbss_changed is
> unsigned long and hence processing a bit > 32 writes outside
> ifmsh->mbss_changed on a 32-bit system.
> 
> At a minimum struct ieee80211_if_mesh::mbss_changed needs to be properly
> sized.
> 
> We have validated what I consider to be a quick and dirty change which
> modifies struct ieee80211_if_mesh::mbss_changed from unsigned long to u64.
> 
> Do you want that change?
> 
> Or do you want to propose an encompassing solution that correctly uses
> unsigned long * and DECLARE_BOTMAP
> 
> 
> /jeff
> 
> 

Apologies for reporting an issue that has already been (somewhat) fixed
by 6e48ebffc2db ("wifi: mac80211: fix mesh id corruption on 32 bit
systems"). Issue was found internally in a backported kernel and that
fix was not present.

But note that fix did not use DECLARE_BITMAP which I still think is the
right thing to do everywhere we are using bitops.

/jeff

