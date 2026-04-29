Return-Path: <linux-wireless+bounces-35588-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCAyLtjU8Wm3kgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35588-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:52:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978C49255A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE5FC301475C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FE2571C0;
	Wed, 29 Apr 2026 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h+RpaMqT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ROep1NQ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F733B97A
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456342; cv=none; b=hmkTMb+D/eJwlWk1WfbKviainZTmXgiP8Lxo/clzRi2j0zT4rOWPNJYT3gPRl8OOXJPBlAXNiFShs6U76OsdQESALZDbmO8LC/2ElIorc7IMrMzFvukaH9kGCIJhigHXwJZ0gsdwoGj0YvFWReZbCcBSHdbjCMi94rXVhPPlkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456342; c=relaxed/simple;
	bh=Pd+lZmOF5lYJkS7mOrQPDWXZq0WvA6OAZl87IW+HPPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnuO+CVEkP+wYiq/jyxDpB7y3j5CJg53Jav4J6mfZDCkUidk6DRg3nPwqhg7Oy6AcMA0K04RBxquPJwWH19GbuZXD4s9pt64GrP8zionWCy7LYgRI3y6BA0UQwc6u/VTYTTR3YKfnmJbbDNJIAUkBIap4lRMfkO453Ion92zI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h+RpaMqT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ROep1NQ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qEvN3066948
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hvh+8vnqhl3eI9dfiDX9TT8F7CSs+e0gJ3YIPyEvXHM=; b=h+RpaMqT/MsnAu83
	vk+n2+v49xYxaFAX7AZBCiBpwlZUTHx7qSlz90+HCCX81cgfulG3JYns6pt9EcRt
	Y8Ksw1e556GczKCXP9N9YWSlFILjMYqKKNgaCKpQPJfMVDAFoQwO3geG+l/zfaPG
	g8m5FHH63jpZ0Yu49DhzU25qnCTj/3lmhZYVnkSndibgHTPLG3Vl3LpEeqU5dnlR
	CHyR+wJ5xexNfepFhyejdw9eAtx4s12DkClIgYbRdaY1b8+iyPGIuhGxbiQdH3mL
	jx1/HffI43GTRwFOG4v/Ut51MO17Lnem90SFgQHURnvHgAzGSfsm8oZ0D3mLZFZT
	q/KLSg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sx9wrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:52:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so12890476a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777456338; x=1778061138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvh+8vnqhl3eI9dfiDX9TT8F7CSs+e0gJ3YIPyEvXHM=;
        b=ROep1NQ2xU8ctW/jZa68G12lIycHXjI9ONz0aKzbllNqWQd1HcvQ9U0/LOl1JkLz1k
         OioMgkIEdaNlmFSydEGuadtfwklBPtYLwUh7sqjYwiBKuGZjDoC7NVhmjkzr3fi3jYHr
         EwC+DkWSFBmby12fQXeFpk7FReiwk5O17wpge1ml78p1vcoZx8cgQq8p5g44GvjOY4FM
         MT6YYY8ecMA+1AkNYOpHD97pI2yPf4nISTuq/40f2qee0TdYaKoRLCj18cGOdQ6sd2qG
         gxHf/eGQiSO1K8kzzRByFqf5B1fNpzuAh45F8B32IMdCrKsWp754Xctzv9Hdj5E9LmWb
         R89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777456338; x=1778061138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvh+8vnqhl3eI9dfiDX9TT8F7CSs+e0gJ3YIPyEvXHM=;
        b=eLUFeJAWK5YP4UsGKf+CkY+KWwlYMHGrwD/718kv8DVwDWkSY2XkcJwOQzx7lx4pth
         CJFrSKtTOoxsd3pZtW8BRzL2at7R1CCdFCgIXGf2UvlMIk77pvbo/MhkTJa8X7Qc9w7F
         MjeU9xQmOQp/3WkXTHVPZzAXGMshR1OYKmp0o15oITZRWQ1z5GmXeUunlXuuc8qGU0OA
         /wbiOPSYTQLF83YeDuO+4UL9eXNvXPOD/ZbrHx14mPUTf3fQIN5V0BniDOufHgOuwYVy
         1nFcroiNJxO58bJHiPycr8DGuVsffe+naaiBEWB4D/M2m1BYoJjH2QLM1CZb7M9pr+IX
         ahaA==
X-Forwarded-Encrypted: i=1; AFNElJ9udKt6RlOlXVQfpiiPBaVxGms8R9V/z+FJjWAeZ8q5Rbzw0wCKWTWyL8Ip6LfE7TSW3EZrmVoQYk+MFVR0Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1vR+Zyu4NZdWn0468HejMhKxSOO6vpDPu8iOzF3/KEOU8asW
	W1z+iY/bdpAe9vkSkmC33LQbHnLspyeyDJ8e6vfBJe5Ue9he4zCkN1Dg6jAkOqAT3MMLjTEwlkr
	JMk4JLdtKk1Mz38+nh6Q3O4gNpGkxoDe/oDclof4utpcPVUcrFFNewWyN80OT5668DpAQOPTSkt
	CE4w==
X-Gm-Gg: AeBDievmYctwhOMwNQUW1M35br9tjSGm5n3jBn9OjEZ2k8/lN09NHy0mkGQAReMElGV
	UcNqoTsZC4CwBi5YqCuzjCHSMXJepPaI8PKM/gKRLgGunBa1V4gsxNHtHKj02jrRNEgZgsTbvNO
	21pNWw0JTRW+jN/ulYTWtfXxzXuu7td0sCvkTcwK/9v6y2B2npXmmOcWXBgd/PFd6Gfcc+anMtD
	jxh6SsG5W7G8bgjT/ILiQuH6Q2zOYXiv/ylruVfVouNKWLcXgaVG+CdkAcZGdeCB0G6ls1guAL0
	f0gjmMsITYDJWktAXfhFSunFgBJvtzR9PZ+2LjRw2+bkwWw8tJMQIimaCvXcVpkOOnIwvmK1Aj7
	HKm7tn/Kc4LmQci9y9Rn+l8nhOrd4CKr2g8Wen/xTh4WYBbLh+xWmUQieHl/b
X-Received: by 2002:a17:90b:562c:b0:359:d54:846f with SMTP id 98e67ed59e1d1-364a0b240a3mr3193496a91.7.1777456337927;
        Wed, 29 Apr 2026 02:52:17 -0700 (PDT)
X-Received: by 2002:a17:90b:562c:b0:359:d54:846f with SMTP id 98e67ed59e1d1-364a0b240a3mr3193470a91.7.1777456337382;
        Wed, 29 Apr 2026 02:52:17 -0700 (PDT)
Received: from [10.152.204.131] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd5e6cf4asm1510633a12.2.2026.04.29.02.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:52:17 -0700 (PDT)
Message-ID: <299f83be-748c-458c-be07-df6a0fe02f38@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:22:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath11k: fix monitor mode frame length by
 using correct descriptor size
To: Joshua Klinesmith <joshuaklinesmith@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org
References: <20260407024836.53871-1-joshuaklinesmith@gmail.com>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <20260407024836.53871-1-joshuaklinesmith@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VtWAp02VS5vC2djxAqBIZQCFJmETG8tE
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f1d4d3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=nzbe1GnBzjegX-K0-XkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5OSBTYWx0ZWRfXx8dlcoPHhl4I
 Tnj9XN4jVnjByl1lcbkers6DocDDgC+bFEh8QHxq6fK3oI+9lvdk0tVP7WxOP7kiuVjPbbt0TsR
 BWRh2D2JixI5zGrTA5RwfHkRI8EK0FaZQXGzvcOVaneP1d4BfOxkp59UviKjhZKB64PHAUQM07H
 CEivAsQgZIr5NQz87Fkb/PhKoP2t8SniC86jdM/kjZmMcKvbIWoSWDqUCfInaYpIcAEcUTsNv0G
 S5QZQgBD5olPB5N5Qym2qtTyYEd/5Wq5OBAMnCoyeneAVC+aIXfyZ4eL9hvZr61dDLwTKx4qOEC
 o6ill0r8mD8GFUZ2xAPPYUv77oQer37Ti7tdwK8s1c8cq3BX0UeS8R7Ti2H4bYtk951kT0APh1d
 jmxGtw5CblmsZBKl2cRETFaamtAyjAqYhXXMaiuWRvWg64rjbxDK3TqYYDaoocsp7npErt8gCyF
 9moMUPk6vOh4v/JzZGg==
X-Proofpoint-ORIG-GUID: VtWAp02VS5vC2djxAqBIZQCFJmETG8tE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290099
X-Rspamd-Queue-Id: 2978C49255A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35588-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/7/2026 8:18 AM, Joshua Klinesmith wrote:
> The monitor mode RX path in ath11k_dp_rx_mon_mpdu_pop() and
> ath11k_dp_rx_full_mon_mpdu_pop() uses sizeof(struct hal_rx_desc) to
> compute the packet buffer offset. This is the size of the union of all
> chip-specific descriptors (the maximum), not the actual descriptor size
> for the running chip. The later ath11k_dp_rx_msdus_set_payload() then
> strips only hw_params.hal_desc_sz bytes (the chip-specific size) from
> the front of the skb.
>
> On IPQ8074 and QCN9074, sizeof(struct hal_rx_desc) is 392 but
> hal_desc_sz is 384, leaving 8 extra bytes of descriptor data at the
> end of every monitor mode frame delivered to userspace. On WCN6855 the
> sizes happen to match so the bug is not visible.
>
> The same mismatch in ath11k_dp_mon_set_frag_len() causes incorrect
> fragment length calculation for multi-buffer MSDUs, under-counting
> intermediate fragments by 8 bytes and over-counting the last fragment.
>
> Fix by using ar->ab->hw_params.hal_desc_sz consistently in both
> monitor mpdu_pop functions and passing it through to set_frag_len.
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Link: https://github.com/openwrt/openwrt/issues/16183
> Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 27 ++++++++++++++-----------
>   1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 85defe11750d..c86ffc203f15 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -4511,10 +4511,11 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
>   	return 0;
>   }
>   
> -static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len)
> +static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len,
> +				       u32 hal_desc_sz)
>   {
> -	if (*total_len >= (DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc))) {
> -		*frag_len = DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc);
> +	if (*total_len >= (DP_RX_BUFFER_SIZE - hal_desc_sz)) {
> +		*frag_len = DP_RX_BUFFER_SIZE - hal_desc_sz;
>   		*total_len -= *frag_len;
>   	} else {
>   		*frag_len = *total_len;
> @@ -4658,19 +4659,19 @@ static u32 ath11k_dp_rx_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id,
>   
>   static void ath11k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
>   				      bool *is_frag, u32 *total_len,
> -				      u32 *frag_len, u32 *msdu_cnt)
> +				      u32 *frag_len, u32 *msdu_cnt,
> +				      u32 hal_desc_sz)
>   {
>   	if (info->msdu_flags & RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) {
>   		if (!*is_frag) {
>   			*total_len = info->msdu_len;
>   			*is_frag = true;
>   		}
> -		ath11k_dp_mon_set_frag_len(total_len,
> -					   frag_len);
> +		ath11k_dp_mon_set_frag_len(total_len, frag_len, hal_desc_sz);
>   	} else {
>   		if (*is_frag) {
> -			ath11k_dp_mon_set_frag_len(total_len,
> -						   frag_len);
> +			ath11k_dp_mon_set_frag_len(total_len, frag_len,
> +						   hal_desc_sz);
>   		} else {
>   			*frag_len = info->msdu_len;
>   		}
> @@ -4792,7 +4793,7 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>   
>   			rx_desc = (struct hal_rx_desc *)msdu->data;
>   
> -			rx_pkt_offset = sizeof(struct hal_rx_desc);
> +			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
>   			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
>   
>   			if (is_first_msdu) {
> @@ -4823,7 +4824,8 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>   			}
>   			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
>   						  &is_frag, &total_len,
> -						  &frag_len, &msdu_cnt);
> +						  &frag_len, &msdu_cnt,
> +						  rx_pkt_offset);
>   			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
>   
>   			ath11k_dp_pkt_set_pktlen(msdu, rx_buf_size);
> @@ -5424,7 +5426,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>   
>   			rx_desc = (struct hal_rx_desc *)msdu->data;
>   
> -			rx_pkt_offset = sizeof(struct hal_rx_desc);
> +			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
>   			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
>   
>   			if (is_first_msdu) {
> @@ -5439,7 +5441,8 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>   
>   			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
>   						  &is_frag, &total_len,
> -						  &frag_len, &msdu_cnt);
> +						  &frag_len, &msdu_cnt,
> +						  rx_pkt_offset);
>   
>   			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;

Thanks for fixing the offset handling in the monitor Rx path, but still 
there is another instance that still relies on sizeof(struct hal_rx_desc).

ath11k_dp_rx_h_ppdu(), which is also invoked from the monitor path, uses:

ath11k_dbg_dump(ab, ATH11K_DBG_DATA, NULL, "", rx_desc, sizeof(struct 
hal_rx_desc));

This should likewise be converted to use hw_params.hal_desc_sz to avoid 
dumping beyond the chip-specific descriptor size on platforms where they 
differ.


