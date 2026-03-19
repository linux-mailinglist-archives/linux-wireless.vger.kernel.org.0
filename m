Return-Path: <linux-wireless+bounces-33450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPFfK6Jxu2nSkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 04:46:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298B2C5A54
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 04:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04DA130B013A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2E262FEC;
	Thu, 19 Mar 2026 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xf8pT9Gj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yxs+fvKY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE12D248B
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891996; cv=none; b=gsdwnLqLHEigX8IlkaorJg9VGNIatz/u214jR0ACf4k8KElXzvPPvIcO9vB5QHxbSXSo0sNcyFA9FZJlITu5SB1scM/ReUNsXKyzcnULha9cY5JAiV45cVKRQ/a/ttSJ7KXhZ7/VaqvAvdaH3PdwfOCNb5EhZpR8L8EHXyR62ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891996; c=relaxed/simple;
	bh=730EHBuLk5bCeTw0u2oW5lqxojn+rPic07IRe8GT/80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/EHxqf9egN5x6b0QludP74hmUcH3RUYuU5yaM67wqOcaAOYepQxyf0daqO/5ViYXGpHGlTPlDZhgkuHPN61TGpxNCCYm+diRY4/RKDDYiWqMcrlM1iccpQ8bbFyXMrwtYNzfOoF5F+Qk16viT5CpLkC5ks+TljXp0PKh/r/9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xf8pT9Gj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yxs+fvKY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J2bvCs3413784
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 03:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4b3s3EAjr8009h48cjzBmOUcZa2ExsAEz1rsedC2Zbw=; b=Xf8pT9GjFFs40JBQ
	1uWNrrmdHG+ObQKYIuvorpoNna53OnBXqkCnHAKj+T7v0OI1rdEuxCYbcvlbP2dF
	7S0FPpto+n1WX/Izlqy6IqBxrWYmyKRIj/YaWqja+zvyvhShuCpQC2mQDqtU/zmt
	mbAW/M2BPM8m2tAUsO7cHF5NLkrYwh/9QxTMeC6BehbQTqNBoD17KaCT/eVD1sWU
	4MfrmwgtUCHXDb8mxk0Zjk5NLbXL4elYTH6lqSw9fDZV8mpjFOyqx/Eqruo4B4cU
	dPt51WcYtASbVMFMmoh1jUPhQVhSbz/sDSMnIYkhtmKqjrvdtwwAW0IjFb3MlmnG
	2KDi0A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0032hsam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 03:46:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad5fec175so23937085ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773891993; x=1774496793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4b3s3EAjr8009h48cjzBmOUcZa2ExsAEz1rsedC2Zbw=;
        b=Yxs+fvKYRfI5EVfaYe3F949hxsBRK6MDbUIBVqlBVQ7cxGmNT69N4QDtTb/bOnppO7
         ulhkN6aL2lYk3VsuEygMhRqDun4D2pX4ip3NyRrKmFtVCHE6Rmr/U93LVxdXS779Uy1c
         FsSQVxsmBh2l4wHmRP8yGKt9MsfDAUWXDjtxrvo3x/RLr+rw+2X5k5lxGwwQl0YtTwj0
         1+go8FGqdX9cT8suR73DHZJ1zY9iDQKwCzoQrxvebC8Lea++w3C+l05mAeSPvcD+kVxN
         ZH6Btp+Fi0HnVuF9Wh7wEEgb+8y7wNT/hllb4VVUkyvRQjGxbYlOd12LKyrbmKZXWxL+
         7r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773891993; x=1774496793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4b3s3EAjr8009h48cjzBmOUcZa2ExsAEz1rsedC2Zbw=;
        b=AWtbHAUNHYFXRt0cvqjImAgiYg1lf9NGZuMwdjok6vZhsrupsF49TW69+lJkBWwDFx
         nE33WSgf7p9If+JhbyQm6NnqPRXS8k1Svp52PC54Q/SibXAlp30n2JCR75Xm7oYGgcwK
         n3BjoZmOqB9ajUO1Tw4MRSF+3Zo/WqoOx37/ZhFmfeoQzQYjCl8e2/y0px2adxYSrje1
         t6AG9RMuThwAEH7UU+oeJr642x7QsAY96A+9l2e85uyRVA7COXBLRwZINFaJFZTiXflA
         8rLHPhWZ+NWTxZFylgpSikFTOfbJEaIuc7Z0DdqOSZ3MCx567G+7Znv2O/NZeO2rvpIc
         efAQ==
X-Gm-Message-State: AOJu0Yx3hJvmN2C/RvA5jgvdHzD8rHFwYW6tcQBt1JDJUiN2HCepzlzQ
	A9bp9iHHKdCYmAS1hyqUgvUCYtWa2u3nSVKjwPXpUjJNJyvMtj+sxNYxMDxdS0189Tk8UyaErSn
	N09yuvBgL3gfLQsrOGe7v5Fpkvm8BLc7o4as+C8sV34LHTZoazwkQiIbvECAaagodVeNaNg==
X-Gm-Gg: ATEYQzzc9h1A4v/9uJrfnXQgZKGwKlo87HMUTai7HEIpJy85FQtHQBShOHXhKHlRofC
	7WctiPKUwc+bwDJJ4JKRktbzdNHYLc9kdgvsXK841n3t9bNtteMUmSkwODuSXwEBYT2FuZiVPEX
	aM3rVSE9OsGRBdqL6x0SXOKEN2Xg9vjG3rYPX31EubUWA+hEuKVfHrVn5iNPab9Z4TNzANuQh86
	8x0MOU7zwRIRc/kCh11wtKoMfT/WpxnQpDYZcH4yjYNzsHPHDUi5yOSheYQApeF1x+I2QC/iGmk
	s+tOiUcnbUjQs8igaUmfBeer/Eimxw6MfKZ+WgGd8x94Or24ws28U7hUEZ3mvUijzw2TR5803cb
	wksRlPvd6c7/2Q3fE70FN8Bf7fKafO/IGLcPX2xdPcLWcVlgslfKOmR2TIxeovV3j7uM=
X-Received: by 2002:a05:6a20:258e:b0:39b:9644:6e99 with SMTP id adf61e73a8af0-39b99fc2baemr5217330637.43.1773891992955;
        Wed, 18 Mar 2026 20:46:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:258e:b0:39b:9644:6e99 with SMTP id adf61e73a8af0-39b99fc2baemr5217316637.43.1773891992438;
        Wed, 18 Mar 2026 20:46:32 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e543579sm3889526a12.16.2026.03.18.20.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 20:46:32 -0700 (PDT)
Message-ID: <8056cb5f-cdde-4890-b8cf-3b37d1c3483f@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 09:16:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: prepare REO update element only
 for primary link
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5f4Vy_vD2Pvwa0XQlrr2qDVENFvY7EIO
X-Proofpoint-GUID: 5f4Vy_vD2Pvwa0XQlrr2qDVENFvY7EIO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyNiBTYWx0ZWRfXwpLnhB1aIzIB
 vaJOMa6uWmluRep5MvlVELFtVeI/eQp5M5Tfe60MTotVh2pVysF7+Qhn6YxkEtXucppeyXl0Oyn
 D/yIeJJQr4P63ZwjrPE8dFZs4JR/2KhUPD76wbH0zS3wmaHm/RuBmDIyH3CExCjs+uqKQTtQxSB
 xEgmEYf+GLgsAVw57EXZv+XkzyHAtLGUGhRur7/4SrmbexTm7nKit/ffXfU0o0nSlOPD1VUabyf
 J6FX992KTHmDSr0Q9UWmwuRGJ6kUSuqouUJ6ojJ+qo1rZSI3SkEv0FNyBHAMC4wdUkLucqn1Z5x
 4hKLiFBaHMDLrYIeikwnpTOmK98OWhZnXvJeU29rSRcS1oPoIYFXwSTb1H1tPlw2NKbqCplsGDk
 tszRJiFazS89uljO2gm633G2UNec50oZNqDxW5AnN2T4FZlfB3C5YSzLkPDGLGrKW1oss00Qn6u
 phd51pXotmYxlRLA2sg==
X-Authority-Analysis: v=2.4 cv=WO9yn3sR c=1 sm=1 tr=0 ts=69bb719a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=v1BbFoewtlT1sTZsXLUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190026
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33450-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1298B2C5A54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2/10/2026 8:37 AM, Baochen Qiang wrote:
> Commit [1] introduces dp->reo_cmd_update_rx_queue_list for the purpose
> of tracking all pending REO queue flush commands. The helper
> ath12k_dp_prepare_reo_update_elem() allocates an element and populates
> it with REO queue information, then add it to the list. The element would
> be helpful during clean up stage to finally unmap/free the corresponding
> REO queue buffer.
> 
> In MLO scenarios with more than one links, for non dp_primary_link_only
> chips like WCN7850, that helper is called for each link peer. This
> results in multiple elements added to the list but all of them pointing
> to the same REO queue buffer. Consequently the same buffer gets
> unmap/freed multiple times:
> 
> BUG kmalloc-2k (Tainted: G    B   W  O       ): Object already free
> -----------------------------------------------------------------------------
> Allocated in ath12k_wifi7_dp_rx_assign_reoq+0xce/0x280 [ath12k_wifi7] age=7436 cpu=10 pid=16130
>   __kmalloc_noprof
>   ath12k_wifi7_dp_rx_assign_reoq
>   ath12k_dp_rx_peer_tid_setup
>   ath12k_dp_peer_setup
>   ath12k_mac_station_add
>   ath12k_mac_op_sta_state
>   [...]
> Freed in ath12k_dp_rx_tid_cleanup.part.0+0x25/0x40 [ath12k] age=1 cpu=27 pid=16137
>   kfree
>   ath12k_dp_rx_tid_cleanup.part.0
>   ath12k_dp_rx_reo_cmd_list_cleanup
>   ath12k_dp_cmn_device_deinit
>   ath12k_core_stop
>   ath12k_core_hw_group_cleanup
>   ath12k_pci_remove
> 
> Fix this by allowing list addition for primary link only. Note
> dp_primary_link_only chips like QCN9274 are not affected by this change,
> because that's what they were doing in the first place.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 3bf2e57e7d6c ("wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures") # [1]
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221011
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

