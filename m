Return-Path: <linux-wireless+bounces-19097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079EA39741
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D064169182
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926922F166;
	Tue, 18 Feb 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GukoeIkN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5222E40A
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871575; cv=none; b=cfyAyaMEpei0kogwsBHOjIcmzaIQW/Iaf448SC5GUEAG5ZPmaR9VY6j9JzjzqdqecFmCDIWEAPfXJdLc+vN+amdoiIAqx5wXeo0ciqK6qlmEuQpgwtMbg4IaTeIy5AGjvfqmGKIg5i8A9ibFAEUOmeDh2cJOt2Z/1VNvGI+ittM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871575; c=relaxed/simple;
	bh=nroSZLFnBcYNxLfLC2e65u4r8G48Yxqdimswv1HgsCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HXcRyqmOQ7dmdWZO2/yHsf5UqXKXE0lVcNYdO2OlxbPtNVLHjVrpUzUGNO3tOyrCM54kG0pBJxn/v4YD49RQYBOhS64FCrT9+CGcvOX9tL9Ep9aFmgOc8SRQeltUgwGLIJRsHQcWZnIWTBhAREnbHZSEBTvf4ZaQcmrxZIdcFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GukoeIkN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I2hBoV003007;
	Tue, 18 Feb 2025 09:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CjbiGCSL/gwyQwfjRzEyZ/fRqUDIw/RiQV7sx5O8kjs=; b=GukoeIkNsptKcAQi
	Q+sO7x28cZqUcCg3uqRqjrY+F4Do3m8LzL6ZccvozD8NwoSipawoud8fVrdkZKuH
	UFbmXKALcBs1BGPg5EZ6g1RA1DcON7ECQ2kjceyK781WKGGALm9iNmqviMMwdp15
	RPIKSHwON7O0QV5tokOU20SwdszmHqxBZovlHbqhrHflPai4MYgVnXWKTb94Ll6H
	I4r0tmtMlzalIctAqqBgAfZxuiNjE3Vo/TdSP9WZ7cWYjEvcqQQTlKvBe90nvUy/
	H9SuKbkIqCUuoBuL/JBGqPh7PDR8JJanDY6g52p/Mw2qKzMrI+cZ1iwkccOpZ2rB
	DBdojA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7tvcsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 09:39:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51I9dSgm028576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 09:39:28 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Feb
 2025 01:39:26 -0800
Message-ID: <cc715114-4e3b-619a-49dc-a4878075e1dc@quicinc.com>
Date: Tue, 18 Feb 2025 15:09:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] wifi: mac80211: Drop cooked monitor support
To: Alexander Wetzel <Alexander@wetzel-home.de>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>
References: <20250204111352.7004-1-Alexander@wetzel-home.de>
 <20250204111352.7004-2-Alexander@wetzel-home.de>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20250204111352.7004-2-Alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zQx4FfIPzOYwdhUPrEiQHxXv4OyVfKmP
X-Proofpoint-ORIG-GUID: zQx4FfIPzOYwdhUPrEiQHxXv4OyVfKmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180074



On 2/4/2025 4:43 PM, Alexander Wetzel wrote:
> Hostapd switched from cooked monitor interfaces to nl80211 Dec 2011.
> Drop support for the outdated cooked monitor interfaces and fix
> creating the virtual monitor interfaces in the following cases:
> 
>   1) We have one non-monitor and one monitor interface with
>      %MONITOR_FLAG_ACTIVE enabled and then delete the non-monitor
>      interface.
> 
>   2) We only have monitor interfaces enabled on resume while at least one
>      has %MONITOR_FLAG_ACTIVE set.
> 
> Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
> ---
> Checkpatch is kind of unhappy here:
>   ERROR: Macros with complex values should be enclosed in parentheses
>   #285: FILE: net/mac80211/main.c:1747:
>   +#define V(x)   #x,
> 
> I don't see how to get rid of that error and more or less accidentially
> moved the line when cleaning up.
> 
> Since the code is from commit baa951a1c177 ("mac80211: use the new drop
> reasons infrastructure") from 2023 I assume it's one of the rare cases
> where we can ignore an error?
> ---
>   include/net/dropreason.h   |   6 --
>   net/mac80211/cfg.c         |   9 +-
>   net/mac80211/drop.h        |  21 ++--
>   net/mac80211/ieee80211_i.h |  11 +--
>   net/mac80211/iface.c       |  50 ++++------
>   net/mac80211/main.c        |  16 +--
>   net/mac80211/rx.c          | 194 ++++++++++---------------------------
>   net/mac80211/status.c      |  34 +------
>   net/mac80211/tx.c          |   2 +-
>   9 files changed, 94 insertions(+), 249 deletions(-)
> 

...

> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 0ea7e77860b7..7d3ebfcb8c2b 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c

...

> @@ -1326,27 +1323,24 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
>   		}
>   		break;
>   	case NL80211_IFTYPE_MONITOR:
> -		if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) {
> -			local->cooked_mntrs++;
> -			break;
> -		}
> -
>   		if ((sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) ||
>   		    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
>   			res = drv_add_interface(local, sdata);
>   			if (res)
>   				goto err_stop;
> -		} else if (local->monitors == 0 && local->open_count == 0) {
> -			res = ieee80211_add_virtual_monitor(local);
> -			if (res)
> -				goto err_stop;
> -		}
> +		} else {
> +			if (local->monitors == 0 && local->open_count == 0) {
> +				res = ieee80211_add_virtual_monitor(local);
> +				if (res)
> +					goto err_stop;
> +			}
> +			local->monitors++;
>   
> -		/* must be before the call to ieee80211_configure_filter */
> -		local->monitors++;

Regression on NO_VIRTUAL_MONITOR support drivers.

Here local->monitors increment not done for NO_VIRTUAL_MONITOR.
Which causing packet drop in Rx path (code snip below)

net/mac80211/rx.c: ieee80211_rx_monitor()

if (!local->monitors || (status->flag & RX_FLAG_SKIP_MONITOR)) {
	if (only_monitor) {
		dev_kfree_skb(origskb);
		return NULL;
	}

	return ieee80211_clean_skb(origskb, present_fcs_len,
				   rtap_space);
}
	

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

