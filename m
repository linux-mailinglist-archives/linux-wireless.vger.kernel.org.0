Return-Path: <linux-wireless+bounces-32150-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOTjJEDknWnpSQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32150-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:47:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3018AB5E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89992303FFC8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8E283FD4;
	Tue, 24 Feb 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JV8aDyt3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GnEqwQqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDC279DB4
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955241; cv=none; b=ffCRydtFa1FnuMFFan1ZJkubDeNnHJ7vsNXtZx5ZCxzpw/auLVmRuF+0iBoEfAoKeGERNTRpzYND71pDpiBP9ov7v6ptZOJueGhuWzCpGrUZdISTM9z360jp1k/KPmQC9Bxftoo51aT2LFEiXyn+uYp4CiAOpWPeVoPq7lBWy6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955241; c=relaxed/simple;
	bh=z0ItwqsOdvcPgYUZqxyg8KdF0cp+AjYiFUTDhmMNtS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubTV0KhzV0hSqgIQ1hSUtaStKfFf7LTjHcdmSv5sjqhwgt5Yen69/v53oFz/+7HG1YXL0OSVuGFh5UJWLSIOtDv7NdjT+1foXXYCNIDM2s7donu6yxM9LrnXIWeOmnuuQLfN3k9dR86r+k6kQxw452F+toJxhhFiTieZj62YQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JV8aDyt3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GnEqwQqH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OHj5MT2284637
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l5W/xhFkUfNx8sxqp/pOtgUG+MoKndkK7Z7db5cqgP4=; b=JV8aDyt38xYBlcp9
	6Gjp+6uBnIl4a+M3IcKdmesuUeHLxMoaZxZP6Dgx4K55ngrENKB6VeKyfXaHQN9M
	x4WDH3RFXTGHq0PH+MZMedKjgp8In0pUzCwMhkvQpqkGgCtYji4hoSEePpSC+0av
	DUH9IyTrqCelozBpzLHRDuE8xRJgjaPNDgT1Gy7I1czNEKK6qmi0q2W7vxxt2eMK
	aLTfJ5OfV5qC8brmeA2ZeQEkWdyxMHAG1augDIZqLXKQVcffb9EryHsAE4jaKgx4
	/Vx4el14JfnPN6H13qUF67qWiezw/Amk5p6gHgG55j5MhTrSxMQ9tdIkMzDDCzBS
	gGf93w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtx0c4ae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 17:47:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adad0625d1so37129725ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771955239; x=1772560039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5W/xhFkUfNx8sxqp/pOtgUG+MoKndkK7Z7db5cqgP4=;
        b=GnEqwQqHCwonnPtmp0SjyItyT2ziUAa8n3ac6eY74FSZ2E9L/aCm1fNyZidRxooN5Q
         bSAETWZpfzTHg2HMnNyb07zQA3XipwmWbYp9PHh7rOdHfHO8mwJlSwPbDxOGazknHeBR
         RZNDpdrO351JBnbera0gI3SAovhQezDeXp0mcZu54V6XSU0o9125NSxkea7Fye/o1kPT
         ME9gBuHwhpmcnnqOdHXVvR+fs8Pfl4krug1XFnt1OCnC99vLWkHGGX6gIxQMafm21Cg7
         NQfonj9l4zIzS7HoLqdOSr29ZIE0rUp3RvHKtITRVZ4FBrk2Io1QAUaWNPim9O5W2i6M
         ROCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955239; x=1772560039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5W/xhFkUfNx8sxqp/pOtgUG+MoKndkK7Z7db5cqgP4=;
        b=gRhU4d/+meUii627TnZAayLft+jjAMPjQgvDxRy6lx3jRqb78BzkTtufN74wNRAX6h
         WphpuuBR4W+i///L80HZeMddyyyujanF6DVZM/+nwNCH214rjhAENseWyJPoJSkHOQfX
         Z1+Ty9wEJxWcb0U+DMvqV1KiRNSWdfmGNrUdlc8nh0wQv1q67oggVucscJU1KCeb7k9E
         kT1iNv4aC6oijR90NZCo5bQDZSX2rs0BnhbVTo1KLqAJxG1vTJKUpWg8x5YVOtjUdcof
         sOZgE9WGApHDsDXKkuiQB9Xi+4jkTGpfEClDkNs6mxQDhaxJLA3IagKjoApxpY1kwnog
         BWtw==
X-Forwarded-Encrypted: i=1; AJvYcCVdE1tauWyuClrJl17k4rRMdDsDN3KtEav2nd9E1eZTnmGsoFvWHmTKNF2P16Qdaz52JZgw7WOfEHAVcd5ThA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBhcXlgDjT5h5bY8m7Bn5jzU7ZodmlL7hyW1WPAdzrVNbDtoc
	nLDr/b0rCYRalnETeX5lVjkoqBOQmbc4W/qufZjTwj5kLIMYF/jhwAlGiqCUc0HGZdItvN60aTK
	R7KFpKKlCa4eurYShU/M4ye0pSpnyDuXUq9DP17qTloXfee1AczPBrQBp8MRU/hJ/VqorYqrZOV
	Yxjg==
X-Gm-Gg: ATEYQzyPylj7Cf8HQIA5pjZizbLAPEr+GLK1liodPM3JpTGdQ+PE5kubIyyENpLU9bv
	BXaMILc8DqOJd9DNfhOEfzpqXeWU9SeDkk6gNQasmw8x8bqxcN7GjU/uEKKrBpNS6XSxmI0hfgU
	OI6T8/xOhYHcT954OYcCMEAXBkNp3JA7x0Waonbx9Y/4RQ3ppDXKjmFTcBvnDxrrfGifF3dYzP1
	Ya6dCFSGQOgYkLFgtwYmRTon731gRGuCulykt3KJ7S0qstB6JyxCiPZ2VkTaMrKRlgtBb/xdKKb
	2PJgwPANK0VYQiRewHtsSV6+zqwIYK81D2ZEyO5i11Oc81x4aBPJzkYnxS4OyWNa/KyN6/Oj0ND
	l1fUzdDYoIpOwXo5gdn1HTVOr7XYOhhvEouMe+N2kQWbP8MGMQUHu4vt6oHM=
X-Received: by 2002:a17:903:1246:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ad7454942fmr114173985ad.49.1771955239355;
        Tue, 24 Feb 2026 09:47:19 -0800 (PST)
X-Received: by 2002:a17:903:1246:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2ad7454942fmr114173745ad.49.1771955238746;
        Tue, 24 Feb 2026 09:47:18 -0800 (PST)
Received: from [192.168.1.11] ([122.167.98.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75035487sm112250695ad.74.2026.02.24.09.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 09:47:18 -0800 (PST)
Message-ID: <6197fae9-832c-4e48-b8fc-0b14cb44b5b0@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 23:17:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/8] wifi: mac80211: pass error station if non-STA
 transmit was requested
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
 <20260223133818.00346f27a7d3.I5ffe7bc0d4ccefca5c1e506d5d3d482e13989cda@changeid>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <20260223133818.00346f27a7d3.I5ffe7bc0d4ccefca5c1e506d5d3d482e13989cda@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: az3U2zTp8264scE9QrzXcPquKz7wef9Z
X-Authority-Analysis: v=2.4 cv=euvSD4pX c=1 sm=1 tr=0 ts=699de428 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=3qja58XoCTMbiOcPuMMiMg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=XRTL8D9JhnaTZ-QnUTwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: az3U2zTp8264scE9QrzXcPquKz7wef9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE1MCBTYWx0ZWRfXx4h7suEXEEnb
 gEYmCjzon5gMIgwIJgOGuJVerD1ji0thCy39aytj13x9AspCQRZyrpfpr1Nib+/vUKkExCMDW9z
 nwFgwPbz4n1i/BFZdHg6d5DB05Xg0TUAZZgX4257TUA119QFqudqFBEQbl0tuckF6c6tDcP5H+s
 y4pk8Q4h63kZyxtxdlkvRUKa1UgUilhrba5LmU8nNAlU4rE+pG1xXgSOeALJ271vC+xIicljO6G
 Zs4u/bg8uSckcfClYBz7lYDyGGBPlUMkS2yDA3gHZD8lrvC6ym7PN+l07M8HyHr0+OA0+nWyOOu
 1U4wi8t0cjhflikHW6fOtD/AAssjjXdkOUnroPlawjsG+SPolwuKWu2obQFNalydRTaDOKZMJav
 st5hjHrryCaq4eG7z61aLFlkgZUoOLWM8BSE/yDWeq3jPau7Wwj1BXczkju4ckyGVN8mSoiciNe
 NgyV7ZV6YXKJyR+b3Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32150-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramasamy.kaliappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7B3018AB5E
X-Rspamd-Action: no action



On 2/23/2026 6:08 PM, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> When cfg80211 requested a transmit without a station, pass an error
> station to ieee80211_tx_skb_tid instead of the correct one.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>   net/mac80211/offchannel.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
> index 0a8b4c5e8c12..24a55186b87f 100644
> --- a/net/mac80211/offchannel.c
> +++ b/net/mac80211/offchannel.c
> @@ -857,8 +857,10 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   			need_offchan = true;
>   
>   		rcu_read_lock();
> -		sta = sta_info_get_bss(sdata, mgmt->da);
> -		mlo_sta = sta && sta->sta.mlo;
> +		if (!params->no_sta) {
> +			sta = sta_info_get_bss(sdata, mgmt->da);
> +			mlo_sta = sta && sta->sta.mlo;
> +		}
>   
>   		if (!ieee80211_is_action(mgmt->frame_control) ||
>   		    mgmt->u.action.category == WLAN_CATEGORY_PUBLIC ||
> @@ -887,7 +889,8 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   		     local->ops->remain_on_channel &&
>   		     memcmp(sdata->vif.cfg.ap_addr, mgmt->bssid, ETH_ALEN))) {
>   			need_offchan = true;
> -		} else if (sdata->u.mgd.associated &&
> +		} else if (!params->no_sta &&
> +			   sdata->u.mgd.associated &&
>   			   ether_addr_equal(sdata->vif.cfg.ap_addr, mgmt->da)) {
>   			sta = sta_info_get_bss(sdata, mgmt->da);
>   			mlo_sta = sta && sta->sta.mlo;
> @@ -1026,7 +1029,9 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   	}
>   
>   	if (!need_offchan) {
> -		ieee80211_tx_skb_tid(sdata, skb, NULL, 7, link_id);
> +		ieee80211_tx_skb_tid(sdata, skb,
> +				     sta ? sta : ERR_PTR(-ENOENT),
Do we need to pass sta here? I didn't see sta actually being used in 
__ieee80211_tx_skb_tid_band().
> +				     7, link_id);
>   		ret = 0;
>   		goto out_unlock;
>   	}


Thanks,
Ramasamy

