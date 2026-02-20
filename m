Return-Path: <linux-wireless+bounces-32042-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHPGAtG1l2kf6wIAu9opvQ
	(envelope-from <linux-wireless+bounces-32042-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:16:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC71641D1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9653D3011F3D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 01:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1951D82866;
	Fri, 20 Feb 2026 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="had57Njx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="es0QPmqM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A313EBF10
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771550158; cv=none; b=NWEXHBBSSaR+eSA+dkrumDuMiZdilj4e1H/0R0wzPpWp3pyiMEb4SBOZhIDXEq/XJcborkOBQs9QgtOPtJq+o/VWmZYxNzIAOPpqxGVZYLanQE+5urTMxH0H9VVqrrcgAE3bO0lHWISxucgYj28spKPkVpW/T/VS5qiVKGXDxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771550158; c=relaxed/simple;
	bh=Oo1SJpGSzbomwGBsZaJNUe72hvepPhygoNpRi4ONjvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZQCvAJk/RD/0cPJYYzs5Oe7B0bDnfT22T/4X8wFE16umMi8Iv00WMIsPlK3G1vrFMrz4BBu6OFYe3YwwKGfgPnkczju4ZAV8/v62FmN7RfiTFuc9phrE4wbEwZQP4/8kqZK8kDxwqLZ5f4vdnC3TjF/QPzBxJ+fKP+IBRSuusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=had57Njx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=es0QPmqM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JNcWCr4070890
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	suW+KUoLGrQIdAJQ97q1SGoZFTTUi//DJeiXbPID1dc=; b=had57Njxi1v5dBH2
	xkijF7iEmRkujWz5Hstk+toesOwMdPh1AtisKsEio+CTIHAmmTEd7ADDUSWBpZwL
	+Pz5D/xodwWH2KFgfBng9tE4GhvpBK1ccxiB95bwKE4EUKXRmp92sRJvsQq1E2xe
	LEYkkll6TZwPPWaEtcGEiPMmF/Mjbr1Ofd6hl2mhcpU/kNQSNYBWd+WyaoTLCsdq
	VgqZrC2bgPSQkJcRG2vkzvmMIvrF51e1/kw5wDq3PFQjbhFnTOF21EWVpwH6z4wp
	mrSjPjv/9icfI6dmVnnbdrHLsInIIJRBmzc58eMu6gKDuvYBDa6anLfFgbt9jjmH
	pghuQw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdtjy39f3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:15:55 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12711ec96fbso42310691c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 17:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771550154; x=1772154954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=suW+KUoLGrQIdAJQ97q1SGoZFTTUi//DJeiXbPID1dc=;
        b=es0QPmqM+KcQHmfVutE45BFnBcb6mz77WIQ1PTjbxA+SFp+06HA5oiYaTxmI26/p0S
         sz9GQXceeziq+cCLIsTEyvRGoMlHGPRIMfG77gxoCh4AekTdciJ0UWslOXJJzF47YzD0
         59QTlVrX/McsWWhnAywZAEoKgvVzRqtBwdQtQgvuzbrYB+obH4Mnpv6lO5CucC3G+DuH
         0IGmLH1QwoyUQZkec3cgv84Xk7IwuKnRVK33xJafbMWhbN7VuzyQi4+rTeOJ5YnhZTZe
         45ti8edzTU9t04OzLUYbdaMoYwveok/EtTHZNK6zjVuGAHg5d0JSPPZ0H2EPmVz+4daf
         tcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771550154; x=1772154954;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suW+KUoLGrQIdAJQ97q1SGoZFTTUi//DJeiXbPID1dc=;
        b=Ap95TE+li26Ki58vWPbkhDTYC0WrSM8xSfovdcCnnfgnbAxg0JzPxXhcOgbJiKwobQ
         RG9+pWg/xdXNI+JrVd/OgIxbpGbu36cEadTNMZaMALEERq2SJ3Gx8gdIwxFywRw/xxow
         DgYn8FTzXAkYGmwSB9lX6CnQYgnzQZJJHHVYj4J7X1QFG5NlCl2dLBT0WojqGVF5DeU1
         RosCboiBq32uVZwRQ8zl5D7qii+EGzwOZDtC9G9gpxek29/xbZBpS6KvAtyv59GBoq/C
         SNBkyX7eyOoGuUy4o2V5Yzca6vpGEDScMKPKbDY2gNtSpNxp/lFPFgSuMh+zw/4pLqJY
         uqOw==
X-Forwarded-Encrypted: i=1; AJvYcCXYKDjWTEp2tvnGtuRdyFguvC/2UTe14aqBzufkOBhY1bYAxC/VabPQjSIUGEyF/pEL7M8oIEsQUMVqGut1lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMz7DxVLZIybG6Fpt7DjdznA/ciEgkIdgodWPL/d0DNBE/Ftoj
	cZD/1dir4RChJ1Y/VSiy2oIKySSJZexuWPcGQGLsMLNJE6nYEhrTS4syWrfJqNpvHjue39TRTz0
	/yetbhTqUZRACVzlflVYIDSwM5JjdM8yfKb4GzrInnBX0llJDDFOq49OkJ86pSZVJTo0l/Q==
X-Gm-Gg: AZuq6aKNwtOAhpSWunkKDM3eLSDwS7RVEMOxubdGTRCUpL7UJ66/PfpzXMggXUzyslK
	R1/PkvrsHVj6Yt2w8PT1uVxbyv6/f+bYUeO9MF4yKJj/YrsYxroIeqaWPS1DPjDHmNe5ncwzBPl
	4xCGYZOlXYTzA2G6g9XhoDAjJfd3U+kgaLmj9xO/DOf9pL1wVNwm1qFLefMHOndsTkiZcXY0mxU
	cTesRWJfAThdzDGLOdM8P84I06+fGFcfUqsth6zCAqaiFUH/eZ0FUY4BwdGYFWOvQE8KBIYG7ob
	mcDPdEA5M8yx6l2+impy25s9IkzRN3d0lDxWCKtrlPf8w8vTyLEfqFr4IG3qXkvXgbWMSiTNmX1
	7iJ150qh4I038BdDBpjhsZvPoeKfYgoOhmmdMTFrUDe3gxLGKtw/NNscY99XR2qpeEy1kYQDW9Y
	EAHYNCkRfW6rxVXA==
X-Received: by 2002:a05:7022:b81:b0:11a:3a1c:6c5c with SMTP id a92af1059eb24-12741b6346amr12361650c88.3.1771550154287;
        Thu, 19 Feb 2026 17:15:54 -0800 (PST)
X-Received: by 2002:a05:7022:b81:b0:11a:3a1c:6c5c with SMTP id a92af1059eb24-12741b6346amr12361636c88.3.1771550153708;
        Thu, 19 Feb 2026 17:15:53 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b62274sm30172408c88.3.2026.02.19.17.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 17:15:53 -0800 (PST)
Message-ID: <5b01594c-3ef1-4382-b12f-1de73fc5d4a7@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 17:15:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 wireless-next 02/15] wifi: cfg80211: remove unneeded
 call to cfg80211_leave
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
 <20260219114327.c43709c9d3af.I3179a28f237ea3b8ec368af720fbf77455a7763f@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260219114327.c43709c9d3af.I3179a28f237ea3b8ec368af720fbf77455a7763f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDAwOCBTYWx0ZWRfX+YH/P/buACgV
 DGCL/OysR8MDkpNyPz97sUMe/ZGtA+YYkNqx9qVDHIrv3mRCrOhVUHiOfgPWHCpcxtNuaszJE7J
 cjyvN3X/D+2UNfxiyCinPdiDTau5dIzZc2Am0ehWCT3lhnALYBRT9HyQ8us6nru4CewhaDNcXbx
 ZxE2DF0nOys0LlmqBF5ztGCOXwxWcn+hwc1bPqPcKn8OPp0KyER0EgWJvtnMXqf6y3RWjGgVWmX
 xNp4DGFn65JCI25P7qWls+674nDxlG7aia3t3YibGwYTfzTQTyfv1TdIMGdSCsgmccVQmI0v2ty
 +VQ3/oSXEftyyjl7kf66YXWghqcpgdsjiUbKYufXFHB9DUED5TOVQ2Bnwq9OeTzcJpXfRuWZ0Og
 3pnaR0Y9XDKur9H+6KP5sm/KVRCjG2rmaePy4Weslk9Fs98ZdGX3js1AGbAwyc19XPSWiWoCNkh
 EkWkryJ6hp16IwkB29g==
X-Proofpoint-GUID: qpFw-PQIzxwpsLXmW0pXIVSqyKMwvVs1
X-Authority-Analysis: v=2.4 cv=FoUIPmrq c=1 sm=1 tr=0 ts=6997b5cb cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=QyXUC8HyAAAA:8 a=ATp4JkX9iHyxX-m6MboA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: qpFw-PQIzxwpsLXmW0pXIVSqyKMwvVs1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200008
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32042-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 38CC71641D1
X-Rspamd-Action: no action

On 2/19/2026 1:47 AM, Miri Korenblit wrote:
> In cfg80211_destroy_ifaces, we first close all netdev wdevs, which will
> trigger a NETDEV_GOING_DOWN event that will call cfg80211_leave,
> and for non-netdev wdevs, we call cfg80211_remove_virtual_intf which
> calles cfg80211_unregister_wdev, which handles the "leaving" for those

nit: s/calles/calls/

> interfaces (i.e. stop_nan and stop_p2p_device)
> 
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>  net/wireless/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/wireless/core.c b/net/wireless/core.c
> index 9af85d655027..328d3036d21f 100644
> --- a/net/wireless/core.c
> +++ b/net/wireless/core.c
> @@ -349,7 +349,6 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
>  
>  			guard(wiphy)(&rdev->wiphy);
>  
> -			cfg80211_leave(rdev, wdev, -1);
>  			cfg80211_remove_virtual_intf(rdev, wdev);
>  		}
>  	}


