Return-Path: <linux-wireless+bounces-10440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73458939729
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 01:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198CC1F22101
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75E381A4;
	Mon, 22 Jul 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BgljlqoC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590317BCD
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692539; cv=none; b=Sm4n1dsadaCvZ4hlrJMltSs90QQDAvDdMb+5WYJOZOAlbL7xV6dKVznmfQJLM76zvAEGDcQ/2khyFs/6D4oKWV2GeW/AOC6AA+iA3/MibUjqZakSMkf3/bsDEsjNgWUUPHi+KWg+/AvgYwuhSaaN8BNMoS6OGy7bkFdBYmkCQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692539; c=relaxed/simple;
	bh=4ZksJHBBlgiyyqsfYiIa8dQarz0PKoYHhKCcP11gD90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t9Ezwwz8GI7VkBc79AmFntq9soZMxHXcw3yc0qSljZIxxMcrEoW/TfhfgRoc7nJr1tUOrY+aTYpUJ9WW8oSNjIud6nLqNsI3RfkCLXuYV3+Ecwm6L+UwUKaxS6FG3irtoPTa4NSDJiC6JVwgmDhH2tMw3qJ2sKPVlcbIBmjRqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BgljlqoC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MN7aOP000501;
	Mon, 22 Jul 2024 23:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IR9rMEYaL9m/+8vajLloZbrKGZKzChbQXGwKLaZZOa8=; b=BgljlqoCko9p5TQx
	af5YEV1UqSr3qf6SCRgYawzkWp7z/5w2NpdaEQQcmIoLTXJ0SoCrPvV7LHpFK3+S
	CXZyHNBC+dlarl/t39S6W1u+VAPXL0Bt0z3fGpHOUcUudONE5oyvwIhcZEXRFwOR
	xlMopkrZKxqA5lC+OxU5U8SO9C2Hb9ZIdFdbImtt+a8OV53QstEM5eZbw2VNzMtx
	MUFlKEY8CAqZ+2llaVQ6Aurb0PkCls//BULi4+FHECgAPFpBsXA31SKgwqpBIBMi
	F/VSSDcNpp06BbcmPe9lYGKD2WutdkyTqAZfryciCYPTQyQ3WzhIk2xwP7L/rmG2
	CM2hiQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g46s54da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 23:55:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46MNtXXe005808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 23:55:33 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 16:55:33 -0700
Message-ID: <9812b341-6a74-41fe-8d09-43e514107e20@quicinc.com>
Date: Mon, 22 Jul 2024 16:55:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix reusing outside iterator in
 ath12k_wow_vif_set_wakeups()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240722033332.6273-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240722033332.6273-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 36J3TJ_RHlaluNhJejhzsqqjELXJpsQf
X-Proofpoint-ORIG-GUID: 36J3TJ_RHlaluNhJejhzsqqjELXJpsQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_17,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220178

On 7/21/2024 8:33 PM, Baochen Qiang wrote:
> Smatch throws below warning:
> 
> 	drivers/net/wireless/ath/ath12k/wow.c:434 ath12k_wow_vif_set_wakeups()
> 	warn: reusing outside iterator: 'i'
> 
> 	drivers/net/wireless/ath/ath12k/wow.c
> 	    411         default:
> 	    412                 break;
> 	    413         }
> 	    414
> 	    415         for (i = 0; i < wowlan->n_patterns; i++) {
> 	                            ^^^^^^^^^^^^^^^^^^^^^^
> 	Here we loop until ->n_patterns
> 
> 	    416                 const struct cfg80211_pkt_pattern *eth_pattern = &patterns[i];
> 	    417                 struct ath12k_pkt_pattern new_pattern = {};
> 	    418
> 	    419                 if (WARN_ON(eth_pattern->pattern_len > WOW_MAX_PATTERN_SIZE))
> 	    420                         return -EINVAL;
> 	    421
> 	    422                 if (ar->ab->wow.wmi_conf_rx_decap_mode ==
> 	    423                     ATH12K_HW_TXRX_NATIVE_WIFI) {
> 	    424                         ath12k_wow_convert_8023_to_80211(ar, eth_pattern,
> 	    425                                                          &new_pattern);
> 	    426
> 	    427                         if (WARN_ON(new_pattern.pattern_len > WOW_MAX_PATTERN_SIZE))
> 	    428                                 return -EINVAL;
> 	    429                 } else {
> 	    430                         memcpy(new_pattern.pattern, eth_pattern->pattern,
> 	    431                                eth_pattern->pattern_len);
> 	    432
> 	    433                         /* convert bitmask to bytemask */
> 	--> 434                         for (i = 0; i < eth_pattern->pattern_len; i++)
> 	    435                                 if (eth_pattern->mask[i / 8] & BIT(i % 8))
> 	    436                                         new_pattern.bytemask[i] = 0xff;
> 
> 	This loop re-uses i and the loop ends with i == eth_pattern->pattern_len.
> 	This looks like a bug.
> 
> Change to use a new iterator 'j' for the inner loop to fix it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/d4975b95-9c43-45af-a0ab-80253f18c7f2@stanley.mountain/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



