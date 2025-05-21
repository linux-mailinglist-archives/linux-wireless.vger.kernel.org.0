Return-Path: <linux-wireless+bounces-23247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08F9ABFF09
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 23:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DD09E5396
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF71E835B;
	Wed, 21 May 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lFRQvaq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6E1624CE
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863539; cv=none; b=RIkS3oUQjUyvIk850yFXevIGv+rd4Pt9lo+i/luJ5fAMECDtNx9rpDPh98iE28zs+PnYyr0HkRL3tBzfvCjh8IakMGV8b90bVNmW+MLrjyPJWNfAXh540N+5CseM/kov78sJivOi/aroMJpyDlgzmZ2DK4LEqqdsEG8IWziPcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863539; c=relaxed/simple;
	bh=y1RZZ2EJv10Ynu+csBeKKRfGgEMYwLAZLA/Et6oJvLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RxsYT5JjrdQAhJQ0hsN3TPkb/rUl6wTjbD3cLNYqT+qS18vV78g/3U8fsQmz1ZlrAnm/+9gvh2aqGfPZsuy5BvwTE9R3RUNcz7okYtgdhVzLF82H//EkZACjbdsGTSD9QD8rH5tswxTX5cm/AQCxhWOOujK1Kn0D6wfHnSEEf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lFRQvaq9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LJgw3m025025;
	Wed, 21 May 2025 21:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R1Z32RllxbUKuIbL9LvRcxRwJygw/y4QtcfDtXHpIpM=; b=lFRQvaq96a4gPFpJ
	FC0MheLfWbeE2bTgcS69pr3KW1qKdeK99ZvoQheIrv9qSHCSAPuLSgF2AK7DF1p2
	EBFqbebbn9bDTnBKqF7mFi688FG7JTV1g2ZQOpequU1yVFpfAZopkHROBazEDLLE
	gO3si4x0SUFFdc1mO8MKlWfHDobnln215qOrgo4bv3zIm06fxV2ZP2eVFkpOEWW+
	Tn4gF2Fy5M9RdSPv7pIzQOrQvi3AsmmvWck7Aytf2Fjjq6aGEc1R4pV2Oa8EYpnw
	Z96ehS+LozmAyVIQDe8SmkUtFIUvf5U+BUIUMt9K38OyIerV5j6WWlvouC0J7ABO
	g8ZYBA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6v82y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 21:38:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LLcgln004519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 21:38:42 GMT
Received: from [10.227.105.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 14:38:41 -0700
Message-ID: <c21146ef-3cf6-4d8e-a32d-8479e4d96f3b@quicinc.com>
Date: Wed, 21 May 2025 14:38:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 8/9] wifi: ath12k: add support for 160 MHz bandwidth
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-9-quic_pradeepc@quicinc.com>
 <DA08F3TG062A.151WKWWF5OPL0@gmail.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <DA08F3TG062A.151WKWWF5OPL0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TJvUE4Kj7QXixkhm7Oq0vi-3piDk4L4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIxNSBTYWx0ZWRfX+F+dYzgvoK19
 +aLYWIdfHcCjVytLhCNVI1LMP18Zx+nhGKqENLpHrtyLF0OViWEFmSpr0zqG//MSYkdMnK5m30s
 ipLKFEeKNQ5h0EF072CruMGpJsq0JIzOFCvSTl5+r7Za+ANAZwyzJLoj34kr4wTN97q4QIKueEl
 ffcggjTJrr04thY2iBT+5IQNivQdVOVWbhSTwIlczNfNTuB0K6SW0nJjqYzp9d+BB6cPBJQ0h/t
 Acs2e5fWYLd2SPX4RMzse6GYxw9LKgLtU3MD3YPs1O46JGABSy1lZe00pM9c5TnMTdOl6Eqc//N
 BPJWQDMQVg015RQfHNPQglwLyUwE5WKNQSQaOTvTI7kEZL+5wFVus2mZyTVi6W0SzEW0c4AWG08
 95QlDPWtHe/15AwhiVJGYlTPvLi+kZEMRgwbrYIAoWwvWthz/OnmOVcb2vJv5UJ/AA/DlLOf
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682e47ec cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=B5O5ry5ejk7m3CeyslEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TJvUE4Kj7QXixkhm7Oq0vi-3piDk4L4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210215



On 5/19/2025 8:11 AM, Nicolas Escande wrote:
> On Fri Apr 18, 2025 at 7:48 PM CEST, Pradeep Kumar Chitrapu wrote:
>> Add support to configure maximum NSS in 160 MHz bandwidth.
>> Firmware advertises support for handling NSS ratio information
>> as a part of service ready ext event using nss_ratio_enabled
>> flag. Save this information in ath12k_pdev_cap to calculate
>> NSS ratio.
>>
>> Additionally, reorder the code by moving
>> ath12k_peer_assoc_h_phymode() before ath12k_peer_assoc_h_vht()
>> to ensure that arg->peer_phymode correctly reflects the bandwidth
>> in the max NSS calculation.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> [...]
> 
> Hello,
> 
> With this patch set we sometimes see the following warning shortly followed by a
> firmware crash on QCN9274 running WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> [  242.416516] ------------[ cut here ]------------
> [  242.423608] WARNING: CPU: 2 PID: 1427 at drivers/net/wireless/ath/ath12k/mac.c:3224 ath12k_peer_assoc_h_phymode+0xd4/0x800 [ath12k]
> [  242.428475] Modules linked in: dvb_usb_af9035 dvb_usb_dib0700 dib0070 dib7000m dibx000_common at24 ath12k qmi_helpers nf_nat_sip nf_conntrack_sip dwc3_qcom nf_nat_pptp nf_conntrack_pptp ipq_lpass
> [  242.444176] CPU: 2 UID: 0 PID: 1427 Comm: memcheck-arm64- Not tainted 6.13.0-02013-gd424b7b9a373-dirty #140
> [  242.466407] Hardware name: XXX (DT)
> [  242.476124] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  242.480639] pc : ath12k_peer_assoc_h_phymode+0xd4/0x800 [ath12k]
> [  242.487584] lr : ath12k_peer_assoc_h_phymode+0x540/0x800 [ath12k]
> [  242.493834] sp : ffffffc08588b4b0
> [  242.499820] x29: ffffffc08588b4b0 x28: 0000000000000008 x27: ffffff802781bb60
> [  242.503123] x26: ffffff802cfa9af0 x25: ffffff802781bb60 x24: ffffff8016f38be0
> [  242.510241] x23: ffffff802cfa9fb0 x22: ffffff802781bce0 x21: ffffff802d50dc00
> [  242.517360] x20: ffffff8016f38be0 x19: ffffff802781bce0 x18: ffffffffffffffff
> [  242.524477] x17: 30363120726f6620 x16: 6f666e6920797469 x15: 6c69626170616320
> [  242.531595] x14: 5948502054485620 x13: 0000000000000001 x12: 0000000000000060
> [  242.538714] x11: ffffffc08126c6b0 x10: 0000000000000274 x9 : ffffffc08010468c
> [  242.545832] x8 : 00000000ffffdfff x7 : 00000000ffffe000 x6 : 0000000000000001
> [  242.552949] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [  242.560067] x2 : ffffff80bff6de70 x1 : ffffff80bff640c8 x0 : 0000000000000021
> [  242.567186] Call trace:
> [  242.574299]  ath12k_peer_assoc_h_phymode+0xd4/0x800 [ath12k] (P)
> [  242.576560]  ath12k_peer_assoc_prepare+0x5d4/0x1608 [ath12k]
> [  242.582809]  ath12k_mac_op_sta_state+0x1f4/0x1100 [ath12k]
> [  242.588451]  drv_sta_state+0xa0/0x5e0
> [  242.593745]  _sta_info_move_state+0x20c/0x4b8
> [  242.597477]  sta_info_move_state+0x18/0x28
> [  242.601817]  sta_apply_auth_flags.isra.0+0x190/0x1c0
> [  242.605812]  sta_apply_parameters+0x240/0x5e0
> [  242.610933]  ieee80211_change_station+0x164/0x200
> [  242.615187]  nl80211_set_station+0x3bc/0x520
> [  242.619874]  genl_family_rcv_msg_doit+0xbc/0x128
> [  242.624215]  genl_rcv_msg+0x1c0/0x260
> [  242.628815]  netlink_rcv_skb+0x40/0x100
> [  242.632373]  genl_rcv+0x3c/0x60
> [  242.636018]  netlink_unicast+0x2d8/0x338
> [  242.639144]  netlink_sendmsg+0x158/0x398
> [  242.643311]  ____sys_sendmsg+0x104/0x290
> [  242.647217]  ___sys_sendmsg+0x70/0xa0
> [  242.651123]  __sys_sendmsg+0x64/0xb0
> [  242.654682]  __arm64_sys_sendmsg+0x28/0x38
> [  242.658329]  do_el0_svc+0x70/0x100
> [  242.662234]  el0_svc+0x18/0x60
> [  242.665619]  el0t_64_sync_handler+0x104/0x130
> [  242.668659]  el0t_64_sync+0x154/0x158
> [  242.673086] ---[ end trace 0000000000000000 ]---
> 
> It's probably there since v1 of thies series but I just finally got to the
> bottom of this now and I've tracked it down to the following hunk:
> 
>> @@ -2822,11 +2883,12 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
>>   						    struct ieee80211_link_sta *link_sta)
>>   {
>>   	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
>> -		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
>> +		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
>> +		    IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
>>   			return MODE_11AC_VHT160;
>>   
>>   		/* not sure if this is a valid case? */
>> -		return MODE_11AC_VHT160;
>> +		return MODE_UNKNOWN;
>>   	}
>>   
>>   	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_80)
> 
> Which led me to understand that a sta that supports both VHT 160 and 80+80 ie
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ will end up with a phy mode
> MODE_UNKNOWN send to the firmware. Which I guess is the reason of the crash.
> 
> I understand that VHT 80+80 is not supported by this chipset, but shouldn't we
> just allow the sta to connect using VHT 160 right ? Something like this maybe ?
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 048d62a48c88..d3a87af076e7 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -3041,7 +3041,7 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(struct ath12k *ar,
>   						    struct ieee80211_link_sta *link_sta)
>   {
>   	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_160) {
> -		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
> +		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK |
>   		    IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
>   			return MODE_11AC_VHT160;
Thanks Nicolas,

I believe IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ mean only 
80PLUS80 not both 160 and 80PLUS80 and STA must set 
IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ flags for indicating 160 MHz 
support. Please correct me if my understanding is correct. However I 
agree that we must allow STA to connect irrespective of which flag STA 
sets as long as bandwidth is 160MHz. I see ath10k and ath11k also allows 
this by setting default phymode of MODE_11AC_VHT160 for BW 
==IEEE80211_STA_RX_BW_160 case.
I will make this change in next revision.
Thanks
Pradeep

