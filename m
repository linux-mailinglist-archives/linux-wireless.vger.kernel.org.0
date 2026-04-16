Return-Path: <linux-wireless+bounces-34867-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJoPAs1R4Gl/ewAAu9opvQ
	(envelope-from <linux-wireless+bounces-34867-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 05:04:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BD409D5E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 05:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60BE430A9D35
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1521EB5FD;
	Thu, 16 Apr 2026 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWZCpz+2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+41rIxU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF018872A
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308681; cv=none; b=aXoqGn4DQWfRvqehJk0uaAgTqILHfaD+ldtCgSCcvljbphdWSQbf3VoQd3eU/34dcCPxnJaNy3wO/US3M6TRGuEEY9+DkBJkvkfHaWBdPVMWyxXWOIsWk1a84yOmJPrHCGopaOQUYLD6BcCn5FKYIAT63pd+6CI7j2V2gdMXp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308681; c=relaxed/simple;
	bh=CrTPEIMnObysTszLOlunLRR7mQTkun/PywuTUh3krTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMgteX5aar++GKWcEnL6OmmoMjLmIREfsZqJwrAyumdtRbo3diyjqgT16v0keNe10Ne6xucP1F90ZtgjcUkDlU/VzDSFIeXbI8YUUKq7fDPRqrHxMKX67ZbpAnw2vzJUCjuU260kvxfp7dRmGDHnhTMaCC7tBhZrRNA2nHCursg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWZCpz+2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+41rIxU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G1BV0A2834774
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 03:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PhyfmB/I1JxtZ6CxSCKa3GHo7DPMkzT00WCUD2ZWGTQ=; b=bWZCpz+2lsjo2imB
	qOaQh/AOL5McMV4waeJbUHZ7Tt08a6s38pJ1QnBTmxru3jvcJOMz7N6xyAnBPuRq
	LQTc89IJcNvcBFjph/dgsv3UCtdbBJDzwOo6wMgwq3KVkCv0llMjRmg+yy+4TuCW
	tkzBF+R64uwxTd8u58Tf6w8yux3otIoD4ukYrYSV54dawvuMpU3b2QX3lsOe7Txa
	VS7kM7TWdBdBUiD2QCfF4N8UUvx6g1jQcQcuqjlnL1Wi2h5pTD3A2X6MoM6ZFGUt
	ph9TePzdMx06MtZl69uJaizIxWoiP7a4eqvVPacfryDtGrwrpY2cZlC9KcOLlJVk
	jGpeRA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcsvj1n2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 03:04:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f45dadbe6so5001240b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776308679; x=1776913479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhyfmB/I1JxtZ6CxSCKa3GHo7DPMkzT00WCUD2ZWGTQ=;
        b=j+41rIxUgtW68aMXplYgPUrtkly3rbHgiFi6ToIqvYY1KaM/Xzd1dm9w1S1ZOQ98m6
         WpNhOjwlZvI6Qu96RpcJSVLx7yRJoPvtUzmmMsHD2Z+GDq1Ecf4EEbDW9uvLfdRiEOrh
         fdfR6I7I+SEb5Unrs6w62FAafNyc20pCK1POWW7s0i8IWN1z21Z2Kq5x0nyhKKKzjaNC
         SDruVIU+3zdUdqZ9vS0eh0qqx7/ynfiRgsLvQ0iHsJ+42xbMwbd9M+1VwCpdGStt1ska
         nduPF8oZOgAGI2E9fxjPz4iyFuKl6bgaKpIYl4VmQT/w08PcBefjr4Gdt4S67hoBrDTh
         6JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776308679; x=1776913479;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhyfmB/I1JxtZ6CxSCKa3GHo7DPMkzT00WCUD2ZWGTQ=;
        b=DpVr21XqVQM5rrUEw96JBpAKCMZD5YoRg3vKZIYlsP5atFVDi4eeSWqrZGP50JsNs7
         s2sRNE9x1RhX+whqkkK5CZE+hbuIfOhwuoSLKM36TXh1RUWQ4Vldn2Xhv7XAnKjZ54x7
         IfHg4MIFtNHaUQqvCUl1FArKKmEQScpzdD6Wa1GFYZ+CFtni0t4gfRo5KKUvpXzyfWDF
         7H8Y+RU1rUHFUwUqY7N0b2WLQHBqMlp4LPPuRDKwnLv+/8C5nb9sqmvHodrG2jgg4TyU
         XzUBk0ZYM6u0934NOvWgm/LozZBDuFVHl97GJZhYgsinNP/sntttoNEc9QSjD6K1o1xQ
         tkrQ==
X-Gm-Message-State: AOJu0Ywdxdzekv6+ffToSIpbT11/FHI4Ccgvt6XfnvMD9OkDXPu4yLNm
	32uzKOaiAEHuBl32SIsU/UmKkk6YG8IAUNvAqz9FSVjaU7fDseeTh6TLRCPpXamNQfs6mtXgre/
	ACzLiDGQjFT7I6pnIxcejWSO/wXmbtVMgTyXvUy1H0ed/0vGne+F6t1PtM8wl7OOJKpa55QrVmA
	cvOw==
X-Gm-Gg: AeBDiev8tH2sJaSfapIWora027Y/OCFHXpXNBuDjMP3kWZGwE8eXox2OB1IyZaUy3r/
	N/MAB/rXpMu9M1SBm5pav9Pcd6oLJmWWGVMEFp+7PjeszZsHYblPevGjAZXaGCm+pzrT8+8Z4uL
	vzsKlYgbfkA724wKPc0VXWCEjL1p/Z2iZ8cdqOtaoRoQZfmODFr6CYTyBzfnP21kxYO9a6V7B40
	RnB3Ij3fQh1sAc4XkbsRlA1Rfzu8cU/6kzAelhnQ8C9ASIG8V4+83TZfJ3Iyv8MKnpnSYEZrUaf
	vMNXWQRpRNaOfBKih9+XvmI4egGZqikRLEIywh/IAf05wAoLV8CFBOKt0rA3FWWfnZa1eVt7bIn
	c2PCGmWvmC4dpi9mHAvi3xkJ72RUoO46dV8QL9V/795ZGBxng8ce7QCla+rLIhCHA83pgawWzmE
	H8t1R1HVcrAwKP23igWGVK6tuxf5ra6w==
X-Received: by 2002:a05:6a00:4197:b0:82a:17b6:53ca with SMTP id d2e1a72fcca58-82f0c2c2413mr24531228b3a.38.1776308678858;
        Wed, 15 Apr 2026 20:04:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:4197:b0:82a:17b6:53ca with SMTP id d2e1a72fcca58-82f0c2c2413mr24531206b3a.38.1776308678349;
        Wed, 15 Apr 2026 20:04:38 -0700 (PDT)
Received: from [10.133.33.118] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67416319sm3459347b3a.46.2026.04.15.20.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 20:04:37 -0700 (PDT)
Message-ID: <85c4d942-39f3-4cb3-93f1-29f932387e70@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 11:04:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath11k: fix peer resolution on rx path when peer_id=0
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GR3wqEZiALfWYsoITxv1fLzen8L9dzhZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAyNiBTYWx0ZWRfX3LxLTM/oyh5s
 SpqGyueVp5rHYMOPela3QcxrzgZjobnE8Fz3Wr9Hk+8l2lkBFkoWAaHLk52b1Xk7+oYswKtKhMG
 J1X8RdnaxFG2DjZ5EyuAglEfZPLBg7RepzV+FjONCIVbHMeljSgkiqy+zENLHeAolvjpQ6WXUXy
 OMxqarkECFO3QcjSI3FwZa4e/vbx2eXYIIXmZ1FeD71HLl9hxTsBHHMGA35jt+UOtgJyxMAr587
 9BGF1uOu+h3FIqIFdoKsXuB/JbdLtjQ2E4FIbw5dk7P5w60cupS3Sm9HEGjLUdG3at6EfZcUwvz
 facJm56MKPVwUJuIh75jpHL8k331Xdk19bd8etWP0OznawUKNewVKQybYSOZFdzLIyF1WUlAsmO
 QMRvivK8jAcQNQK0xmCmm61f7+fzmDaxnUNyJb6i+Fvfg29W7/CM7v1RhZirhuew7nMxDV+fHmz
 ArhWEHD9dtQMKAsp+6A==
X-Authority-Analysis: v=2.4 cv=Iby3n2qa c=1 sm=1 tr=0 ts=69e051c7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=QX4gbG5DAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=99YSq4wlOxbdC3gg6PwA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: GR3wqEZiALfWYsoITxv1fLzen8L9dzhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160026
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34867-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,infradead.org:email,msgid.link:url]
X-Rspamd-Queue-Id: A88BD409D5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/15/2026 7:39 PM, Matthew Leach wrote:
> It has been observed that on certain chipsets a peer can be assigned
> peer_id=0. For reception of standard MPDUs this is fine as
> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
> based upon the source mac address.
> 
> However, on an aggregated link, reception of AMSDUs results in the peer
> not being resolved for the second (any any subsequent) sub-MSDUs due to
> the peer_id guard in ath11k_dp_rx_h_find_peer(). This causes the

it is necessary to point out that the mac address based fallback does not work for those
sub-MSDUs as well, since the mpdu_start descriptor from where mac address is obtained is
not populated by hardware.

> encryption type of the frame to be set to an incorrect value, resulting
> in the sub-MSDUs being dropped by ieee80211.
> 
> ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
> ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1
> 
> This patch removes the null peer_id check in ath11k_dp_rx_h_find_peer(),
> allowing peer's with an assigned ID of 0 to be resolved.
> 
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
> Changes in v2:
> 
> - Since peer_id=0 is a valid condition on some chips, remove the guard
>   that prevented the peer lookup.
> - Link to v1: https://patch.msgid.link/20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com
> 
> To: Jeff Johnson <jjohnson@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: ath11k@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 49d959b2e148..ff2c78a4e5f3 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2215,8 +2215,7 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
>  
>  	lockdep_assert_held(&ab->base_lock);
>  
> -	if (rxcb->peer_id)
> -		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
> +	peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
>  
>  	if (peer)
>  		return peer;

the other instance in ath11k_hal_rx_parse_mon_status_tlv() is missed.

> 
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1
> 
> Best regards,
> --  
> Matt
> 


