Return-Path: <linux-wireless+bounces-32288-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNHYIwZ0oWkPtQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32288-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:37:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334561B6114
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B94B303DDE5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226437BE95;
	Fri, 27 Feb 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frT2HldC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GpmpJWvz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BA399013
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188676; cv=none; b=j4jd3N/QAKELwe8MBxZJQVoeVyi+Z3s118mqRcjKi60c4szZuTvSkVN5jwBVfa3Dj6TfIV2GK0a3e7uP+Ss0BbfA+XrFqs9xqCI/LDmsqm79a//V+DtZyO+suDnxZOcok0kJyqYmImSe18Mu647VlW94ZwEuJBQSGX9KGbmfTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188676; c=relaxed/simple;
	bh=NXKoq7/OI6Yz+fsPCKR4DsncvYgIeEkUUucXlCIaFZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDuwJ/qgGc6g+QWBw4ORcwao65czdjQq3rTUOBNp78suw6sFfh0hVxkagyR8rAx32qGmiR508Vuw2mKM7kCNjZ9gNmBAFe1+AVK838oAqjbKJCj/yPTozsHhwgsNgzaGRxFxuJ5uP6+DmwnVhv/dZMbMo1pljJD23DWkNjzXlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frT2HldC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GpmpJWvz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RA4R811874148
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r/r2l+vLJaAiK2DMkjrG1+OQCRw0snb2TJXSdrDhm7U=; b=frT2HldCTIgNFv9z
	J2gppiOeQkkFi5WjsDk9/x5OwKbLZqytcSVJzxa10M+Z5GDV3TSiSS57+/vFMCJP
	BAYoyLYJlpsWc+XQqxDxfpVhrEGgl6PCOX0n9G7+lcvX18x12WG6oGgvXNONNbcH
	ECjVwk+ecPPmXnbOHhS5l43i4qsDEPq3UTbi1JCIWzIo9jYHsapRgoqiwR0tFefi
	Tq4rYhIGiRHdYQ5aC5d6SrFZGk3GDVqnI42nu9rkA55KnwQRCK6x1HWoS7lS8eCB
	RBlr0WyMozHjzeI41aGCb0SwSrZbx3Ws5MSpWfUW+IzI9BrHEE4zdFK3Ng5p/6ad
	GI2ZIw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuyttmhu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:37:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70f137aa4aso1070441a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 02:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772188673; x=1772793473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/r2l+vLJaAiK2DMkjrG1+OQCRw0snb2TJXSdrDhm7U=;
        b=GpmpJWvzwMKZSaHifXhQS9fDfwJKDJb+clj1nRNTwkOO7JYPh37a8QSQTs+4IFczul
         o8JxqYE0TTSejoW2xDtot/lC4Oyq5Z0wXrlZYnBd5zPWgPH6+8g/UNswsvhtx4UUC74z
         +UKAgCbY4S58ibdbnJvgcVKUJ5MsTJNh8wxXP00HGSvXJApoarqPt3qSNYOJCWJDdDv9
         a4qx/jf5guJejEIuTzQeYi37vIcdJdY6CWgRO1F/eVvnHtnrYs+YA6CKpuFwrkOXd5AV
         Y0LKUfAwwcLLqxG4wqgZ7juMi+78vUo6G5n5yLcc+jmpCfpJVB+M3l9WzOSi3Q6pC2fH
         lQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188673; x=1772793473;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/r2l+vLJaAiK2DMkjrG1+OQCRw0snb2TJXSdrDhm7U=;
        b=alGm9MFLZNESz+AiZStEhAUrP/ktuw2sq5srTZF2o0ySfTAW9IVeskj68uxAxMGa33
         tFymKKT5463j5T1uhp8hpwaz+mTBMI9FW4BrZ2s/xfcdmGBNpE0nGtDyWb5VMuGsgYUj
         OzILR8dP80wOmT3JR+38VZjzltDO7yB2MHRyEaE+cedW+HaylXnnU2+sKbIQctr9J45g
         d9yfQ5kmoDkVHQKvFn8irzrabgGMHHUxRw2XUqVu/XKwgymltydCluRloRv7jLvOcdhL
         579eNsntlrSQfVriHWskr47B7BPwOpvn5yZ3rN1CtE0l/B/8QlShGQRRGgC1szVG7INB
         IH0A==
X-Gm-Message-State: AOJu0YyBVb/zW3w7p60Ql+8uPJjQ9ANGZu5geL728TYkvCRKB6y/Ua5w
	mRCfPwMXiG7KssVQpFjPy2uOjucE/zOXGy+gA6gG65WOIG14LKuKkGUvfQJgrPA63ijgenV/pB1
	ECSuBvD69cVCn5TFjdLDqzfilGfxPozpqA26HSp6cwTFVmTctWllqvVtbT04QdTjBh0PgUw==
X-Gm-Gg: ATEYQzwesNo3SYwCPsB2McSIuoJKr4jlX98v8w7hnP7y4RoUIn50mmM7oDliUnshBGf
	e63iKJXnQCBHR1aPERl90VFQLFJU9jB/2lxhdy5OzWSC3rCUCDkndKhEIfEM5u+pXdaUOqteJzQ
	X/QJPrDbNdlVF3LBFgiLlwl799k88+ToJOdjhVyQGD9w017NiIds5E3ImiN+QSLfqTeZe7om04z
	aijHtZAExaBgBuHZ1AgTybSwYDjqw3iAxrtblre9c6uTMCSpDawzE90s+XIjG0sTqNBiYNE7oqz
	ePd2T9cd0iVkFR6q4FeXZ6Xn7rR0XlqC+PeZPZHiZQsdDS4y/kfzv0zehHHUzQYnau0d9l1XLOy
	YtDNFKUIWYj2+28BA7GqXyU7HVqYHAMR2sdEuLjTf9o0k33oh6q9JgBUhoGjSWXcsRF7Mu4gNiX
	+t4vqr5WEIMN3arhu7bA==
X-Received: by 2002:a05:6a20:94cf:b0:394:3344:a6a3 with SMTP id adf61e73a8af0-395c3b1980cmr2246182637.57.1772188673123;
        Fri, 27 Feb 2026 02:37:53 -0800 (PST)
X-Received: by 2002:a05:6a20:94cf:b0:394:3344:a6a3 with SMTP id adf61e73a8af0-395c3b1980cmr2246164637.57.1772188672587;
        Fri, 27 Feb 2026 02:37:52 -0800 (PST)
Received: from [10.133.33.12] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa801704sm4440657a12.19.2026.02.27.02.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:37:52 -0800 (PST)
Message-ID: <00743cd4-c3e8-41c3-bb2d-1ce7ff5630c7@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 18:37:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix the assignment of logical link
 index
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
References: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bJIb4f+Z c=1 sm=1 tr=0 ts=69a17402 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=60smP4qnKYXzuQrFqocA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: ZlN-I1qkwRi4l1Ip9F-d-UVNtJXUZj6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MSBTYWx0ZWRfX4Un78Ov76cre
 3QbVvmq7bYD+gPPtEBELg6IYgr8Jo4MIGiWc9zTCKg6WKgGmxD9TjBBa2Nz/6U+HQC2pumS6yHe
 xOlj/jbx5ije0wcfyOYmtpPbQImldbnMzpoA3uJNPX7Ev7UjrtWqw124IMhYXKkZ4mfPq5CU0jF
 dY1HqDqAdUC7gTCvCXL/W48oi3TFDG7z8zYEVPskexPUN6GtVWKtdSgNcUrUA6TMue/wfrqq6WS
 iaRFI8m927fCUAYM38IZDq9MYyl9eFGPAxkfmEYHAknh9Ke85f96qlkjZZVkeFblNr4Vd7c5t60
 Q8vR6KJhljYfTNF2WcG8l6YYH/O5B8p+9TsOuyfNvZk2/qK99/25uFmwmLjAsbJ2EuD2PG4PJ/8
 OdcqumiZW6iqZGMSL3/y4qOlsdGH0cIxByniDwTtWRaf6jYIUqkJg8twFPkF9gmUjv0E/N6h6F5
 stR6U02IUYgEdUVeUpw==
X-Proofpoint-GUID: ZlN-I1qkwRi4l1Ip9F-d-UVNtJXUZj6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32288-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 334561B6114
X-Rspamd-Action: no action



On 2/26/2026 12:19 PM, Roopni Devanathan wrote:
> From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
> 
> Per-link logical index is assigned from the global counter,
> ahsta->num_peer. This logical index is sent to firmware during peer
> association. If there is a failure in creating a link station,
> ath12k_mac_free_unassign_link_sta() clears the link, but does not decrement
> the logical link index. This will result in a higher logical link index for
> the next link station created. Also, if there is a leak in logical link
> index as we assign the incremented num_peer, then the index can exceed the
> maximum valid value of 15.
> 
> As an example, let's say we have a 2 GHz + 5 GHz + 6 GHz MLO setup. So the
> logical link indices that they have are 0, 1 and 2, respectively. If the
> 5 GHz link is removed, logical link index 1 becomes available, and num_peer
> is not reduced to 2 and still remains at 3. If a new 5 GHz link is added
> later, it gets the index 3, instead of reusing link index 1. Also,
> num_peer is increased to 4, though only 3 links are present.
> 
> To resolve these, create a bitmap, free_logical_link_idx, that tracks the
> available logical link indices. When a link station is created, select the
> first free logical index and when a link station is removed, mark its
> logical link index as available by setting the bit.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  2 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 990934ec92fc..5498ff285102 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -522,7 +522,7 @@ struct ath12k_sta {
>  	u16 links_map;
>  	u8 assoc_link_id;
>  	u16 ml_peer_id;
> -	u8 num_peer;
> +	u16 free_logical_link_idx_map;
>  
>  	enum ieee80211_sta_state state;
>  };
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 68431a0e128e..db1b098b67d0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -6784,6 +6784,8 @@ static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
>  		return;
>  
>  	ahsta->links_map &= ~BIT(link_id);
> +	ahsta->free_logical_link_idx_map |= BIT(arsta->link_idx);
> +
>  	rcu_assign_pointer(ahsta->link[link_id], NULL);
>  	synchronize_rcu();
>  
> @@ -7102,6 +7104,7 @@ static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
>  	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
>  	struct ieee80211_link_sta *link_sta;
>  	struct ath12k_link_vif *arvif;
> +	int link_idx;
>  
>  	lockdep_assert_wiphy(ah->hw->wiphy);
>  
> @@ -7120,8 +7123,16 @@ static int ath12k_mac_assign_link_sta(struct ath12k_hw *ah,
>  
>  	ether_addr_copy(arsta->addr, link_sta->addr);
>  
> -	/* logical index of the link sta in order of creation */
> -	arsta->link_idx = ahsta->num_peer++;
> +	if (!ahsta->free_logical_link_idx_map)
> +		return -ENOSPC;
> +
> +	/*
> +	 * Allocate a logical link index by selecting the first available bit
> +	 * from the free logical index map
> +	 */
> +	link_idx = __ffs(ahsta->free_logical_link_idx_map);
> +	ahsta->free_logical_link_idx_map &= ~BIT(link_idx);
> +	arsta->link_idx = link_idx;
>  
>  	arsta->link_id = link_id;
>  	ahsta->links_map |= BIT(arsta->link_id);
> @@ -7630,6 +7641,7 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>  	if (old_state == IEEE80211_STA_NOTEXIST &&
>  	    new_state == IEEE80211_STA_NONE) {
>  		memset(ahsta, 0, sizeof(*ahsta));
> +		ahsta->free_logical_link_idx_map = U16_MAX;
>  
>  		arsta = &ahsta->deflink;
>  
> 
> base-commit: 62f9b9b19939138c34ce0ac1e5d4969d617ecbb6

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


