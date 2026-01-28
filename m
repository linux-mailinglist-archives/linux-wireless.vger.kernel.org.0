Return-Path: <linux-wireless+bounces-31250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNjzNTpueWkHxAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 03:02:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390519C1CD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 03:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953D630107D6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 02:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957826ED59;
	Wed, 28 Jan 2026 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aL0iERnc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwiHhSSW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61513959D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769565752; cv=none; b=DyMq+k5xQmbqn1ZkI4sPa5wLFLfDqFVmeN2sfM+4ruUBho3zoWzPZtmKDb9KtfPeEfgMCGPWCkHdOttvKbRN1ZN38MccDfvKC0bVaELLdsMJOTUtUMeuk2sq5NDBexp55660lhqnOg3bBLFmMZGv4xoNAd4ElzK0tEvBRq+81l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769565752; c=relaxed/simple;
	bh=CJEfcqW2U7Qa9X/95E2HMniLxELUDncdwsRirAeqUww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSKVcyeecyWv21fcUVypU/1NMVhDPNwiOdAu2wreumi3v32Um1e+HD9mk2rJb/wPgpoEYLjv6yZJ8oEC2Y6QS310RjXHef60OTna6a6ZRyTYpyDIpqRdb70dYoRYy29zL48czq+xUH16TuELkhSq8RKUdnhnd2KwQaX6Uv+eHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aL0iERnc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KwiHhSSW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S00RW01066277
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eUBYL6RZjVFsIo1jzKugu9DaCmQl+n+h37h+zcrRbuE=; b=aL0iERnc/R7SGW4x
	fg/3YjTAdHSEn/gOZewu/4kEuTA1wSNFRHkOt68aJ47RNGLcuGB/lgaxaySs5msH
	utP+NcUpVO5WnTj7iYsaC9O8qEGCgnoBNlsUMBGFina49RazD+59O6Gy2DhBgmHq
	bZjcS6hNKQtbS8mf8NLoAe8sKWafwU1/QyLNFAhtYIY8CyPIpGZCKOUjRaLIhpug
	/iRpasIZzDR2XdQJPlYtgCyV+ChM+xYbAcsxr2H7hEjjchaw/mK2UomAIdRWlTi4
	QXFOdoJa7G/tPxtnp44Akn3adCeg8io1hkyYKHgKGiebMw7olZt/3/2jC5N3STTe
	UhMBkg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxy8x262g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 02:02:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82317005ee6so3009752b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769565749; x=1770170549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUBYL6RZjVFsIo1jzKugu9DaCmQl+n+h37h+zcrRbuE=;
        b=KwiHhSSWiIHc1C13kP85m/6ZIki1h79zRS97gscojkcmXA/K1DZefL+DOOE08zcRIr
         V96syg9oacfuD9QBxZ2uSZQwMX3v3HfWqrYKOJH8oC8El5gMTT4dDXzI3nvZaybAcHtW
         h/JzNu/0cMEJXqDM7XR02KCMRJT4jGYn1MxgYZaCJ4QF92K5EJYftfIAaTXXv4HeVaEj
         kX7r5Ggy1coH49YnUDnosJ1JhcdXUlXC8fWrTxw2PSCgiR+kBETUDg3jfBZuwGduQ6Bf
         JntUKhXW38sglY5gRp9Ie73QIbnG4luY8ykJID0GekJ8Cy7Id664KEEv4BQBt3XXb6Jd
         lPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769565749; x=1770170549;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUBYL6RZjVFsIo1jzKugu9DaCmQl+n+h37h+zcrRbuE=;
        b=GTo0KW9MiwJGb8nrVCRkFtz3zzY6Bs3galumnEr7echWOEP11IMDJleoMg2LJpS1MT
         /dthvHuCAmHy4LosTta4pfUd2OtOG4bKA5Tkk3bLlp7tIgFQZQQQxz/YQASa9n/J6Eu/
         vgYy98pmt2GSfXoEOmEZtbW7h3lWDsuHRg+0/gBwvFZCB1+uDPFvBPEmw87NX4hNDdVC
         cz0yexKthccDV/djyoXlr4ZrrTZpMcONMmzvf+qlFt9ZlQNB/GnynZyXtpeD5FYCWRaU
         lFIQyNBON8t0Rw/anQGqrMAhHIZY+NgDegouKoboCc+GfJZ1ZuDvm8Dpy9xfeT5ETdzU
         izFA==
X-Gm-Message-State: AOJu0Yw1+BVfMezB3Opp6EoVV0hnvR+SIfQza2dEwBa0Imq9bz8X5nus
	9yMXYzQlMivJ6WdllrRALqR5HW2eeYzUl91UEcW4Av8eRcIyBjQls6QkyE05U+2Z2XDXMZRzWlX
	uOYQJ+pb13ukjtzqQhkbSvigRALj6eeIVyK19I1vKeMgtzoiaC34BGzsPwL7gR9D7wWL0ag==
X-Gm-Gg: AZuq6aJy+PimiVrDzPqdWEspIEcgxIE6Z4nmMow1v779dI0KSvXdq0ODFRQRDzbQOct
	0XQUqFsntXIpeHy400SynJ6aHE1R1SYlGUfssNtBbqcc4zsxWVnq/w9zsHXYAH8W14F35TOrkWT
	orETTcOLe8k3rHgQRiiJj68Bbusx3bMElQFO3ETNIIUvXgLR1D06hveWQxDN2mEPDMIQiiCiiHF
	aLFG3YZ6TnC5KLDfMY4VXbSaiH7BwTy+wOhA88wtl+MPXs/KmvNwZ5Q0wmyieGD1/2QS3ErBWEN
	V6ruO/c3nDQpKyAXPNLH7WEaRT1TXVCmqlJr2poKY/4A6iBFOR8Dsg0SQsY8P+GGzqkwJGvQ+9G
	NeO/+3gmWzQTJ2zBLm9N2UyEZqN0AOtANIY6ye1Hsxf/dYVVRbN1a4DsCYAw56MOtxZHeR2s=
X-Received: by 2002:a05:6a00:a29:b0:822:d43a:103f with SMTP id d2e1a72fcca58-823693110c2mr3481271b3a.60.1769565748953;
        Tue, 27 Jan 2026 18:02:28 -0800 (PST)
X-Received: by 2002:a05:6a00:a29:b0:822:d43a:103f with SMTP id d2e1a72fcca58-823693110c2mr3481238b3a.60.1769565748310;
        Tue, 27 Jan 2026 18:02:28 -0800 (PST)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c241afsm788264b3a.56.2026.01.27.18.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 18:02:27 -0800 (PST)
Message-ID: <ae79035f-4428-4a5c-93be-68d065df1318@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 10:02:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: clear stale link mapping of
 ahvif->links_map
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260127033400.1721220-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260127033400.1721220-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WShIgbMO3vQJrkVmtYOksVG3AttJKdKm
X-Authority-Analysis: v=2.4 cv=OcWVzxTY c=1 sm=1 tr=0 ts=69796e35 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3S48Id3VpGTgTVoLZtsA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: WShIgbMO3vQJrkVmtYOksVG3AttJKdKm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAxMyBTYWx0ZWRfXy+7GyyvDZr10
 YdqD/rWK9zjsjk3nvAOh6+PR3E1dMcPOp09VVLAO0/K4P634XYTUwFk6PxWCYu2JrwiZOCBB31M
 S1nrNO0d96hWG0Lj3iiFe6dv3iNvB0Awzrz9bceV5ni6xYAQK+cLN8YNz1wJ0MUhy2mu5QU1t0e
 vLGKtO4Ena1xh5mgs3ZhvxRaQ0dHD2LzEJAUl1Q8m5fVfyrf3d9rytTF7tOoWW1VzBi8b4JsAoX
 TLnkubg9ZWc3mUCXHY45ovYe9/4pMhC8CKt2GFP9zVrNpfoLyjbYcF3b1i0NNWpfMSFptmX1oGh
 iJnTI/cApq5NYFH0bGPzdFAbVQLaveK6+4FtukBhC+eQgcNwRe0iXW9/0b4yNoxizXjnEK/nZOG
 hSiKVa4f6zpnuHziLwCzQLnnZ+goaFsSqxUWLUvPGDlzF7P8NSWgNfAhEAsU2g5QhVZDGZqkxPw
 MlAIijoGUCKCIyG+TCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280013
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31250-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 390519C1CD
X-Rspamd-Action: no action



On 1/27/2026 11:34 AM, Aaradhana Sahu wrote:
> When an arvif is initialized in non-AP STA mode but MLO connection
> preparation fails before the arvif is created
> (arvif->is_created remains false), the error path attempts to delete all
> links. However, link deletion only executes when arvif->is_created is true.
> As a result, ahvif retains a stale entry of arvif that is initialized but
> not created.
> 
> When a new arvif is initialized with the same link id, this stale mapping
> triggers the following WARN_ON.
> 
> WARNING: drivers/net/wireless/ath/ath12k/mac.c:4271 at ath12k_mac_op_change_vif_links+0x140/0x180 [ath12k], CPU#3: wpa_supplicant/275
> 
> Call trace:
>  ath12k_mac_op_change_vif_links+0x140/0x180 [ath12k] (P)
>  drv_change_vif_links+0xbc/0x1a4 [mac80211]
>  ieee80211_vif_update_links+0x54c/0x6a0 [mac80211]
>  ieee80211_vif_set_links+0x40/0x70 [mac80211]
>  ieee80211_prep_connection+0x84/0x450 [mac80211]
>  ieee80211_mgd_auth+0x200/0x480 [mac80211]
>  ieee80211_auth+0x14/0x20 [mac80211]
>  cfg80211_mlme_auth+0x90/0xf0 [cfg80211]
>  nl80211_authenticate+0x32c/0x380 [cfg80211]
>  genl_family_rcv_msg_doit+0xc8/0x134
> 
> Fix this issue by unassigning the link vif and clearing ahvif->links_map
> if arvif is only initialized but not created.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 81e4be30544e ("wifi: ath12k: handle link removal in change_vif_links()")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index cdb72439dcf4..9a926f5b7e8a 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4281,8 +4281,10 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
>  		if (WARN_ON(!arvif))
>  			return -EINVAL;
>  
> -		if (!arvif->is_created)
> +		if (!arvif->is_created) {
> +			ath12k_mac_unassign_link_vif(arvif);
>  			continue;
> +		}
>  
>  		if (WARN_ON(!arvif->ar))
>  			return -EINVAL;
> 
> base-commit: 13f9e5344a517048f3d8c61e49a9a72f97410de3

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


