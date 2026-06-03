Return-Path: <linux-wireless+bounces-37337-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id riBAHaf5H2oBtgAAu9opvQ
	(envelope-from <linux-wireless+bounces-37337-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 11:53:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE0763655C
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 11:53:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pbGf5zSc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DmUSBo+j;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37337-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37337-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CD8130558A5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF59326924;
	Wed,  3 Jun 2026 09:51:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D42E285C
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 09:51:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480315; cv=none; b=e9M6VNfT4oYKMEAN4tOJh+YJmZXOH7/+oUCsJPGZtO+DapV4Z+z/piJZP4Qlnbb42YXWI130lYXCdcsxqDOk2Mc3HDYIeCwfDy2fzlYzBpeqSA6KMjqmK4JgQDY1w+FJQOn7QH2MNS+XOgzNXWPOQ5zU5UBsZXeNuH8Yzg4bDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480315; c=relaxed/simple;
	bh=M+pDtJBoTSctA7AHSdyRp+Bf9fGmvuYcVciPYLkiAmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlVzwOgHCddUFFqREWmV8zRrco3yVqMaKdJATrjGIa16Uz5lGi4muRYpyRP1mVgUlG+TCTjyj73qdMC1OrtQa48QJYzbJvBb1OxDcDxer1vC5Rm/7EtRor/FT69jCQz1KxRCoT+HWs7kd525O9M+JyQd6M8MagFaEs99CwmIkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pbGf5zSc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DmUSBo+j; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RMsW873766
	for <linux-wireless@vger.kernel.org>; Wed, 3 Jun 2026 09:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ehy5rIR0wvt+9iZI4jXsRc7tvAzbkv0HkPpbPzLuG1M=; b=pbGf5zScPjyyHDdy
	yaBNc13TKFA/2eGhvNnSH/hw4zenUn45mtjdC2NiafB3JTY77ijaEVivho9a/Qzf
	JIXuJjhCYqAMQerssc03wdBpDY7/wcuRv8ug5BelEh0HgI2iN0nEaTz70ZCTRjNs
	qQkL8MNS+vUf2/0AONjyiCBIyN1vIz88AcbaoVff8zh5Tf7sZoj3QOs/bzdmnov2
	cLk07tBCJ32cWcCXps0F8JcxYR8gDaoYtH8xinw0RdV0QrbFtOrnaLx9ZrKTfqDM
	qbWey8NeRGrjOclfWUDGSbU6lO/LtosYnF/IqKzDPxTvQUIhRD/E9hkMrm7f2tdf
	66Glrw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9jub4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2026 09:51:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8428419982eso746614b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2026 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780480313; x=1781085113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ehy5rIR0wvt+9iZI4jXsRc7tvAzbkv0HkPpbPzLuG1M=;
        b=DmUSBo+jaJ8JauIQ0Rihm5z6F/AtSUdkx+fC2eZlo9AtxLb3IRP3AsqE1zymypzg7l
         fA+QbLB98dKWeFUMEdLnvEU/ao3+1zBe8XCPxtPI71tuq69CKxox1L9QC5q9V1d837el
         JLHR1GHXh1Ypa7EyfDDK8fx+GKAJFac+cY4FdZOIDo/G0hSQlvKMzxa1JKcxx1ojTkjP
         yW5vWMbHTnmRKXsp3HQHEDbkr9qzNU7B3x/l02cDJE2XevQgY3F0gYfnPVlrWBgCd5zr
         2fDs/78DVchaJPrOgwMGqPTP5WdMcChoS33fdXgtacqeuD3aSC7XbaHrYcxv+puPIsFV
         wH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480313; x=1781085113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ehy5rIR0wvt+9iZI4jXsRc7tvAzbkv0HkPpbPzLuG1M=;
        b=BoZNUbLwYtkWA46wWzyeXrqrk2Gpy7zlPz9miKlGv0rIKLgujj6ayD6N5VGPYG8QP9
         Cfhhf0hPDjqNCzdVixYIZK8X0SF3FxJPpZJ5LV93cyiWyxZNNI7cy61bPgDw4s6sUuiI
         +wE0jFqRqlXF286pQ5kwPIv/CZR/hIFZm5qCdfsbJFBmeOej/Ixijdjwdg8MyVQjbE0y
         gkKeuW1NcCChGL8G+rbK8OGJ4pp+GqKHIY4+C+8cnkTNkJ9f6aR+MgcS0pyaVFgvNhIk
         mXGmAPf5dR6Dx96jIttq53C69YQQzNfY6dgmQucQoNnvUXhSSNzrb4+OkUXl512ucGau
         3mZg==
X-Forwarded-Encrypted: i=1; AFNElJ82PdmZzBrrwemtlLDdPoSug5FNcCMqWdssgQffQr92ED5sqjYUmruKS/O/NaRmC4JtaPtaAtLL+PSel9L8pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3aE+pAkkKH5RNAQ+aZXzx9V1y4s3pwA9DANmIcjwQ9KH3DUX
	pdh5xBuSxPDY5i6zsk2E6B+hcuPFo4WgZTQSzAS7nV9WXmMzYng74l7hOWrLLF2laR3aBeGktWR
	ILUBAwa5bKLaSmn10z2UUezV6EzNuB2iTdHzNl9eWs2S0v3YKGHP/S6ti5Wy2tEHVltiOpQ==
X-Gm-Gg: Acq92OG+3I4gdJBwWOEyO4uiByt0fqd1E60174Mahh1UswpS+7yNHrCEA9T4a2N25k6
	4842aKce17657aCz5wUAOIfZpKYvTIsIoqOqsXWVFE0duSLhtqAie1K2pZkBkVCnUXdC19D0yvH
	dCtvZhT854zqZUH0B3y138zfkAv9J9y37sE5zO7gMLKdQ2f3FXYZAlUfqm+A5QroJBEb37Y+tbd
	zFfU+3DK0TfMSsUKmUcALkwreM69m2djHW3z6BqdiIWKBjSKJ9/PgGb017rn6fQh9xovWyKtIwt
	MHGzy1i1vQAZb0VWsgALx2DmUVm7K4jDk+ZtgzAzbCDY5CtY/peZROzzXMmLCXIikLyDIVSkoqT
	Ji/t7WzmXetKYy+C6kp3rliEIpykNzdxglQVfG3qc0R1+zgJ3ZnY8b40FcrE=
X-Received: by 2002:a05:6a00:9094:b0:842:6fec:1296 with SMTP id d2e1a72fcca58-84284df0098mr3007240b3a.4.1780480312871;
        Wed, 03 Jun 2026 02:51:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:9094:b0:842:6fec:1296 with SMTP id d2e1a72fcca58-84284df0098mr3007216b3a.4.1780480312381;
        Wed, 03 Jun 2026 02:51:52 -0700 (PDT)
Received: from [10.152.205.195] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282910d1asm2477082b3a.56.2026.06.03.02.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 02:51:52 -0700 (PDT)
Message-ID: <6984020b-8ee8-49c7-a935-da733a867007@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 15:21:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 11/16] wifi: Update UHR PHY capabilities to
 D1.4
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
 <20260529102644.f146932b21e2.I12bad84157bf809fbe285b79420143b3c456d9d2@changeid>
Content-Language: en-US
From: Raja Mani <raja.mani@oss.qualcomm.com>
In-Reply-To: <20260529102644.f146932b21e2.I12bad84157bf809fbe285b79420143b3c456d9d2@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xourGtzJAPi05e7FN3UD6OVteDgTsXxI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NCBTYWx0ZWRfXw/9TrknmSVIp
 vuhrvO/FZfqHxCZMVvIG3pYuowEvUJEjoirFV21LzUUgg/HOevKmcT15xSP8R7ab9fs0sRjtC7j
 hSZcb15ogkYHjJcNqqE6kznjynfbplBHsyh2mz87nkKgGBioDb6HRRwJo3L2rWZL/2CJP+jcF2E
 sqG5rKwjL7Xg/tsAZuex2VjSTm1kuwq1Y3iRoOmxkjK5hc9xBIkTayCq95ZxR8CuMts4EPBEOt1
 wN9WVKEHPm8kFvoOHzx4a1bbJtTituSz/SZ6Ks97kLh+hnFK8mHxO2lwGKFb3B8HQ3vvqs6Gkkw
 s8SJTu02tN9sTsQUvAx/8Vm30igeSuvR/xWn67YWDl5zHzaopLAOS+7+ESvq4Fr7bf4cYAWmrMj
 NNDuOE9Eysk4Il6m+/SD023P4MCcnsIOZPV+SK/6evuseypXLRJz1e9BfZ0P/4/MG9YHPZeCB84
 yZHsojjGUef7F6SBndg==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a1ff939 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QyXUC8HyAAAA:8 a=cYmhZPkXndYRmSfcnCgA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: xourGtzJAPi05e7FN3UD6OVteDgTsXxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030094
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37337-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[raja.mani@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:johannes.berg@intel.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raja.mani@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE0763655C



On 5/29/2026 1:55 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are new capabilities in D1.4, and some reserved
> bits. Update the code accordingly.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 10 +++--
>   drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  4 +-
>   .../wireless/virtual/mac80211_hwsim_main.c    | 24 +++++------
>   include/linux/ieee80211-uhr.h                 | 40 ++++++++++++++-----
>   4 files changed, 49 insertions(+), 29 deletions(-)
> 

[..]

> diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
> index 71faf4a6825e..120993897490 100644
> --- a/include/linux/ieee80211-uhr.h
> +++ b/include/linux/ieee80211-uhr.h
> @@ -401,17 +401,39 @@ struct ieee80211_uhr_cap_mac {
>   	u8 mac_cap[5];
>   } __packed;
>   
> -#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x01
> -#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x02
> -#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x04
> -#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160	0x08
> -#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320	0x10
> -#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320	0x20
> -#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x40
> -#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x80
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x00000001
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x00000002
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x00000004
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160	0x00000008
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320	0x00000010
> +#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320	0x00000020
> +#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x00000040
> +#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x00000080

In D1.4, bit 6 is assigned to ELR TX, bit 7 is for ELR RX.

> +#define IEEE80211_UHR_PHY_CAP_PART_BW_DL_MUMIMO		0x00000100
> +#define IEEE80211_UHR_PHY_CAP_PART_BW_UL_MUMIMO		0x00000200
> +#define IEEE80211_UHR_PHY_CAP_MCS15			0x00000400
> +#define IEEE80211_UHR_PHY_CAP_2XLDPC_TX			0x00000800
> +#define IEEE80211_UHR_PHY_CAP_2XLDPC_RX			0x00001000
> +#define IEEE80211_UHR_PHY_CAP_UEQM_TX_MAX_NSS		0x00006000
> +#define IEEE80211_UHR_PHY_CAP_UEQM_RX_MAX_NSS		0x00018000
> +#define IEEE80211_UHR_PHY_CAP_CO_BF_JOINT_SOUNDING	0x00040000
> +#define IEEE80211_UHR_PHY_CAP_IM_TX			0x00080000
> +#define IEEE80211_UHR_PHY_CAP_IM_RX			0x00100000
> +#define IEEE80211_UHR_PHY_CAP_CO_SR_MODE_1		0x00200000
> +#define IEEE80211_UHR_PHY_CAP_CO_SR_MODE_2		0x00400000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_20_IN_PBW_20	0x00800000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_40_IN_PBW_40	0x01000000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_80_IN_PBW_80	0x02000000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_80_IN_PBW_160	0x04000000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_80_IN_PBW_320	0x08000000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_20_IN_PBW_GE80	0x10000000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_40_IN_PBW_GE80	0x20000000
> +#define IEEE80211_UHR_PHY_CAP_DRU_DBW_60_IN_PBW_GE80	0x40000000
> +#define IEEE80211_UHR_PHY_CAP_DRU_RRU_HYBRID_MODE	0x80000000
>   
>   struct ieee80211_uhr_cap_phy {
> -	u8 cap;
> +	__le32 cap;
> +	u8 reserved;
>   } __packed;
>   
>   struct ieee80211_uhr_cap {


