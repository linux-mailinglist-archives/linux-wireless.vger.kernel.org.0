Return-Path: <linux-wireless+bounces-27471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D2B83524
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B2486FED
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5672D5C7A;
	Thu, 18 Sep 2025 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjhgWZC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32188189F5C
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180666; cv=none; b=ZYsEbCIrbRFu6DfXICdxijKLVIvyXEXCeIOL7y5Dx1goft+sTCsrrNYYvOveeX8HTspeSRVVxqZ+7qGNn3rj/b7S7uR4JZeOoVDQje38ZCfw2V+21G/QFubEnehvdfjAkHFsfvErMZFWbXKuNiohCNyUwryCC3xNLmNg2YBDLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180666; c=relaxed/simple;
	bh=zrN6vt1yK6qJKJX6+/IbvzhhDEu8ri4sAqkn4MfTC5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhyFAbLklhxDoC2CyjMKSTZm1Bk6m1W431Qzt/tvf7aCyEj2a9pCvRPE2Jml2nk1xOLmLhxglVcOgVre0RKU9tbsHUGYX/0ccE5iiEcNZtC+QtaR7qrO8w3BbxKCKzrV2MQ0PBaU002uE+AIZ+Fl8mkwPI3/6dRtUEPL1RZJ3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjhgWZC2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HNjx57003366
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MSjGDOxJVlv8lyqbxoa5TJlW0jL+p+ujSkvMtFycbHs=; b=cjhgWZC2Mzm9Pvtq
	0te6kbpZcfX90brLFp2wNJvYTosCAAs3xIJsWwH3u9C1ZA5DVv2SVw3Ejt4khKhA
	CLx7RHttEJhjW2+W92hsSWW5DLNOKBzaJ9D/ZSfT6qP83E981KkmZpAJ3u6hABFv
	11MoAr1MYzrCAxzievOQJEmNom3ilZ+kT4xmJ7G1sZBLvqbIy0bvAaCZXcMvZ+lu
	hcrbZwPKx9+nqareNvBT3wLRFOZvvUhiwY7J5DRR3X2kVYuMTtmWXIf8AIvy8yWu
	PX2oJfyiCyf/2ChDxDVYkZDRBoIFLNSi1NBDUHVQkCv4tCtbrsE3EjTTsR3rv1hd
	YREObA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgtxeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:31:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ca417fb41so6869185ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 00:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180662; x=1758785462;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSjGDOxJVlv8lyqbxoa5TJlW0jL+p+ujSkvMtFycbHs=;
        b=kXR5LnxKFa42eJPkERbHp7dv262ixDGIQ+aOeCvVKBGMW0K+G1vhBxg0zNnkx5O5ti
         T1Szj5J1vLwM4WbiueMX9iN7QozBK3BDnI2jLTs8cLdr23SUM8k3IMTDEm+TYWkbtyf0
         BpNHRow/BMtvHKHTrwqTpkvIAiLUcswdE+SzzrsCyjwDvVbtnOS5tGyql4uwPSFwEdkZ
         qHSH0Vve5QNIXxeEoJjjaX/3GxTHWYtDEgFOWzwp9dImzP1av7DuHX/Mt/gHJMhK0X6m
         G1kCJ3EqD0mzKh2EeJy8CcDHld68KlnYwh2GVLt3IHaOqnqEXImyO9P9vGu3UCORUxz7
         j92w==
X-Gm-Message-State: AOJu0YzAkwfxM/BQ20c4i6iT9OtLeMjf/BtFsKJzYchov8/Ac3fMhS2k
	2S7gBq9hzpZjbLgNz6AaR9kHMGeuzoZWoJ+oAUG0k3N56wW/9fHD7xlljRgHz3lim8zhD9QoJS7
	vvy7mYAhh+IB5qISC1b5y6ZOTsWJqYBjx1tmFkPGhmV+SO1D6UJVHEe+IAEAHQULTRgKOpg==
X-Gm-Gg: ASbGnctAhQ7RCmmVZlgkbh6S6F7HZwkXTkJHUB2892G5umhRsTop1dwMGgC+yM0z8Pe
	U6VHATcbdIT3SBp0wI63K3NXZ/sJw0U1TZ+HNgJ3QraWof4SO3N9kAJazlXVGCNrOMn+sgska9c
	+VEp6I6G8YlA8ew50D2UQnvpLnuEWwHGPQy1S7WGh41g2a28wb7xDs/G9BcDRm5XAfbtJ5h9Fit
	1BuBO9x2EhbdKb6t2vsR5miJVns9e48KIomVSzMdgb2oKfnnSHEVnnMEsQQvn/IoEMsThRY+njz
	DjrtZQuR8H8vgmw+To6/1wl79B9oq8z5qT1K8gm5ssvow4UprG/pKSUbkbFkwkR00a9Ifpsb6Z3
	fCXa6gDZZQUmb+zStGW5hevk5febpK8+6HhWH
X-Received: by 2002:a17:902:e94d:b0:24c:965a:f94d with SMTP id d9443c01a7336-26813cfd846mr59503785ad.46.1758180662358;
        Thu, 18 Sep 2025 00:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF6R0aGszZMJZu5EezdW7KvbKGGAQgOyOQqusY7oJkHBb0cO2tRgbEcai63GOpeXe32VmfCQ==
X-Received: by 2002:a17:902:e94d:b0:24c:965a:f94d with SMTP id d9443c01a7336-26813cfd846mr59503435ad.46.1758180661869;
        Thu, 18 Sep 2025 00:31:01 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368dc1sm16041485ad.152.2025.09.18.00.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:31:01 -0700 (PDT)
Message-ID: <9c3db505-760d-41a3-9d6b-f55504db6872@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 15:30:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/3] wifi: ath12k: enhance the
 WMI_PEER_STA_KICKOUT event with reasons and RSSI reporting
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <20250812111708.3686-2-maharaja.kennadyrajan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812111708.3686-2-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cY9A0WjRLq2RJtH9BYVJ1oph37c5SXCy
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cbb537 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eoNwnVE8TkJRRwwNz3IA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: cY9A0WjRLq2RJtH9BYVJ1oph37c5SXCy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfXw8wtuIWQ4pKG
 sGGCA09HOQHiqV1BowjoOa2uUAQ8dxxS439GJEi4NjPHGivGRsPy73M424pZkIKz2Nm0jyw6/mT
 LWoXhwgWN3VH8I9fFMTtq0sEK3rQuzI6Ljwyk9Qup/e0G8qP/XsK3X2WIv8GZZtT6nuE+zRZa88
 AM7hIxP+QdZjJnxzQD883++YSyHTOBiGqOTWhKpdgC8F98YtVssmy+OvnIxhzY8rFHHQi+6SryT
 4RLXPThqKic6pXkGOhzgLa7YHt7HG/nwIKJmH8lB+iKgDLFAmCkSeRUbjpuWUlrkHzRAcbHcU2r
 et4p1qYVRZJEdA7poW/XYkuDL3osctCGEIGh75X8DxF5T56vKaJOJb0M3/2PEJ5ohlRoA7JkcQF
 1DskMof6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128



On 8/12/2025 7:17 PM, Maharaja Kennadyrajan wrote:
> Enhance the WMI_PEER_STA_KICKOUT event by adding support for reporting the
> kickout reason and RSSI value. The reason code will be used in the
> following patches when the beacon miss handling is added.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c |  7 +++++--
>  drivers/net/wireless/ath/ath12k/wmi.h | 15 +++++++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index da85c28ec355..cb686c68987a 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -6461,6 +6461,8 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
>  	}
>  
>  	arg->mac_addr = ev->peer_macaddr.addr;
> +	arg->reason = le32_to_cpu(ev->reason);
> +	arg->rssi = le32_to_cpu(ev->rssi);
>  
>  	kfree(tb);
>  	return 0;
> @@ -7333,8 +7335,9 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
>  		goto exit;
>  	}
>  
> -	ath12k_dbg(ab, ATH12K_DBG_WMI, "peer sta kickout event %pM",
> -		   arg.mac_addr);
> +	ath12k_dbg(ab, ATH12K_DBG_WMI,
> +		   "peer sta kickout event %pM reason: %d rssi: %d\n",

nit:
no ':' needed for a debug print?

> +		   arg.mac_addr, arg.reason, arg.rssi);
>  
>  	ieee80211_report_low_ack(sta, 10);
>  
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index f3b0a6f57ec2..211812c62f91 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4548,12 +4548,27 @@ struct wmi_scan_event {
>  	__le32 tsf_timestamp;
>  } __packed;
>  
> +enum wmi_peer_sta_kickout_reason {
> +	WMI_PEER_STA_KICKOUT_REASON_UNSPECIFIED = 0,
> +	WMI_PEER_STA_KICKOUT_REASON_XRETRY = 1,
> +	WMI_PEER_STA_KICKOUT_REASON_INACTIVITY = 2,
> +	WMI_PEER_STA_KICKOUT_REASON_IBSS_DISCONNECT = 3,
> +	WMI_PEER_STA_KICKOUT_REASON_TDLS_DISCONNECT = 4,
> +	WMI_PEER_STA_KICKOUT_REASON_SA_QUERY_TIMEOUT = 5,
> +	WMI_PEER_STA_KICKOUT_REASON_ROAMING_EVENT = 6,
> +	WMI_PEER_STA_KICKOUT_REASON_PMF_ERROR = 7,
> +};
> +
>  struct wmi_peer_sta_kickout_arg {
>  	const u8 *mac_addr;
> +	enum wmi_peer_sta_kickout_reason reason;
> +	u32 rssi;
>  };
>  
>  struct wmi_peer_sta_kickout_event {
>  	struct ath12k_wmi_mac_addr_params peer_macaddr;
> +	__le32 reason;
> +	__le32 rssi;
>  } __packed;
>  
>  #define WMI_ROAM_REASON_MASK		GENMASK(3, 0)


