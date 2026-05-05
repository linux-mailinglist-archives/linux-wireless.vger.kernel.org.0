Return-Path: <linux-wireless+bounces-35946-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDYTKagn+mmHKQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35946-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:23:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 430DC4D1FBE
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35A58301E828
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1147DFAB;
	Tue,  5 May 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcRNRJ/y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BAA6zLMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A548B389
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001828; cv=none; b=m1miaTYKiUXD7lRGoUwGph7/R7XbqF+WOA6DSXSdMgr/JroYlIPLf3YfWgjukfdXKbY9o3bI2pLgfnsi5dvmben+y1EGFpnrgeYx/BOZ6HH5SMIdxHH5psNbhjOWziDIG8/7+TQezDl9OpQb4h4RP7MUBIlcxNo5bZT8uw8KH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001828; c=relaxed/simple;
	bh=oZbLOx2j4i3sJ0Hvp9o1k4G9ROZ3jCIN79VOm5LiXxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1BMhRCHipLSHpQ+A9goIDIzpbe/RP8yrcb8FMNv6qI4vwO9nzAYfam86ZbwINZBpTq2Hv6oRpFQsxa5mgyWlaPZIiCAsp5cyXvZ8maIMjtgWj3Ahoj+CRx197bJ4pv/ob1ndINsihCPmMj0OcfwDLNpbAP4g/J6vkimMS5sP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcRNRJ/y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BAA6zLMm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645FI4Y32859242
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 17:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FiK9+lfdONsd5fbVNETZ6m4mczFbTzGNIYa6E31bfJw=; b=fcRNRJ/yPpQYJP32
	i3tMzilpuqv5sBVh47Sr1j+g8LdIPM7ToB8xEvDU24NlL8mvbw5HNLnP0BTdZwex
	NJpCyY1sprRTcljQwccD6oefmMD9GeKoZJtSvMUtCDmJDB2k4zLZefWAdBE+PIoa
	+qzGI6V+lR67u3bJ1QzhqpSjuvptbxCPS7PhaFK0JzqsLbWEu9IGon/6ocB1cQpy
	cdGhPhv9ah64FdJ7oJ45vlfUrE38YrgUFn5hSUdsDQe6AOtdXik37NoNyYNaT138
	wgr+a10HLejMeITMZLEWzo4B+Ai1ZlFNdUmLPmGKp0ihaIsLLP5uY4e5tLeh3Bwn
	6mUDzw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dye0ahy7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 17:23:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-364c0e269e5so6177273a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778001825; x=1778606625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiK9+lfdONsd5fbVNETZ6m4mczFbTzGNIYa6E31bfJw=;
        b=BAA6zLMmHV2CN/z0J6Mzdj0llz5FfwH2hWdC1aOFsw6b9s3qXRzErcixHrphzir7/w
         Q0DjE+9E5hXUlB27+WKZd2M8d9/CvtYrFjURWzo3gIfVWGPiDZs5omae3KLyctDO6y6C
         jO84pbIwDpGhJTomVqYmL3CGUO9lE46lV7w9hDK2lQLXkMUiNXiwLOPMWSGqiKJbWs49
         Y+z5+5zjoxoB9e9bkWidKYzvqOVmwC8pwvAFPf7gR+1v++PcWlwPV0f9dxCDI70qaGhM
         elrQq/cWHp6CJq3W5+FNwts7NvscouVDO23epuGyslAwiRyxn6Tf8WEjbWtvb1KDBzOR
         a0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001825; x=1778606625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiK9+lfdONsd5fbVNETZ6m4mczFbTzGNIYa6E31bfJw=;
        b=RhzZ3XfqM/KIQok5Ea+CtYAPkAAfqasLOIZ+B5OzlBYQADFwNjiBI9mQz2+pqRWGuH
         PSxM3RokWVYpGnW1fAh31yCCKn8El0Q7usjm///ZSsYx2nVmuRKM6rDa+rspI2btk28R
         svXh2Wt655pWD3BRzvQsiyBGh41C5B2HwiMZt1LeY5NPWR/Y6qGAdt46tjOYC6JokuvB
         7SkJCsDEeoahl06JzL8rbECI7PhmB9aCuRqwMoj2yLspH2XYoemLm0Zaqws17KQTL4c3
         3Dgpbo1e/ioevcCJABlzjh4xwqalT6LPbhZc9CZRCVuFsnA+xPcmRdlnVEjVasrFCUWj
         bW9g==
X-Gm-Message-State: AOJu0Yw88ynwyhLDcV8hFmmBAOhc5LYdmFLWWdELF57YHF/A+vGT0Zny
	s0HxBvCSy83z1QKGr7A7+RXmN7Dk1mnti1ebDCluQBC1E0IwrWg39Dklph3InB28XZCmhfGylZE
	R19x4ywFyjEm5xw6/NIWSRBJ1iv2wXEOB32bLGxRe0VJBtOsvLyfo1MioGPdVdEHZsQJhm1AZG0
	H6JA==
X-Gm-Gg: AeBDiev/x63vxN+Kfy/hT6MKYPn9/gqASyFPq88vZNv2FFBT4fdiNkD3K3C/FeSfkiz
	z30hgjn76BOdRhN4tRmF8wnsTiYRCJMCdgxE/lnRUqGOa1eSFWPE7/N3ZSPXZh5v+ILkNsTkIKX
	gUnJ1QIfR3STU8YTyOUgyuCTjA4Sks9UJj40xhcZqn55bLSfYdd66omz4wVf+g81n5SpbLq6iwT
	WXXf+XAJNF4TuxXBx1jQavw+BgXcU6pACh/TGuusEaD8KMy3LDByKmHmA3IPRiKla5HTpXcov4P
	2o7Ct3nZ9wdxxNghqJLrFXCoGwefWOqc+JsyX2+qt5FKPUILp3Slxf/hDi3odUf6eq5gJUPFnZH
	ESV855UFhpHVVbpuNhCCEed/bdqhVRFD3btI6z4ghCewcOOE+3tPaUvo4lFY3qUiq5nxrzaduaX
	A2
X-Received: by 2002:a17:90b:3c45:b0:35d:a542:2dc0 with SMTP id 98e67ed59e1d1-3650cdb7d76mr14517263a91.8.1778001824975;
        Tue, 05 May 2026 10:23:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3c45:b0:35d:a542:2dc0 with SMTP id 98e67ed59e1d1-3650cdb7d76mr14517234a91.8.1778001824378;
        Tue, 05 May 2026 10:23:44 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf54203sm18802354a91.7.2026.05.05.10.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:23:43 -0700 (PDT)
Message-ID: <151425e9-564d-4d61-b37d-3eef9bc54b6f@oss.qualcomm.com>
Date: Tue, 5 May 2026 22:53:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath11k: fix error path leaks in some WMI calls
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260502071453.2379188-1-nico.escande@gmail.com>
 <20260502071453.2379188-3-nico.escande@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260502071453.2379188-3-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2NyBTYWx0ZWRfX8bPWQHihZPT/
 33hefg3Ee+7ZadlmI5SvYb6ckQy/X7oIcQVUhdFAjeF/fVTaVvFjbupYumofry27AFAvWyD2rLF
 R0eQkK97RtVVmzRPCaKqwc5+T3El+X4W65zWFPWbfrSdJKWqa10/XWbUgc9cVZNFvZ0ROvKGbAm
 cyp3pDj+UVxbigM3aU4nvOCcy4aREvXbf98hjToT0P5aEmH3VDLdn4RqBUGqEeKN6bRyiFHmcdl
 d89V5pyjX3Uj2W3qwmUn4lFTugPtBHSzUQps8zug+cY5bc7Ze0pM6pagc5VDjVinB0ZYtFtgwg1
 BSF7/N66ZlS5fITz71AcUFzyboYFpgSPSa8rTnVDLbeTnMxk+cumBBtW7pyRGdmVp8FfATfkWI7
 ZjyyMPdvhXB/S276qD2LOOy2Iz2K3wSqvV0Obx3Hwb6vSl8RYIZS/stPJtNkBhWZAdl3oUCE/ks
 +SIEe9gS3PztxWIUaMg==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=69fa27a2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=TcU8LgJCOK-_YL1Lr1UA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 9ojJD88o0h-EuGpXs-nAVejrzh4sBeG3
X-Proofpoint-ORIG-GUID: 9ojJD88o0h-EuGpXs-nAVejrzh4sBeG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050167
X-Rspamd-Queue-Id: 430DC4D1FBE
X-Rspamd-Action: no action
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35946-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/2/2026 12:44 PM, Nicolas Escande wrote:
> This is the same pattern that was previously identified as problematic:
> direct 'return ath11k_wmi_cmd_send(...)' will leak the skb in the error
> path if it is not explicitly handled.
> 
> Fixes: c417b247ba04 ("ath11k: implement hardware data filter")
> Fixes: 9cbd7fc9be82 ("ath11k: support MAC address randomization in scan")
> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
> Fixes: fec4b898f369 ("ath11k: Add WoW net-detect functionality")
> Fixes: c3c36bfe998b ("ath11k: support ARP and NS offload")
> Fixes: a16d9b50cfba ("ath11k: support GTK rekey offload")
> Fixes: 652f69ed9c1b ("ath11k: Add support for SAR")
> Fixes: 0f84a156aa3b ("ath11k: Handle keepalive during WoWLAN suspend and resume")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/wmi.c | 112 ++++++++++++++++++++++----
>   1 file changed, 96 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 024c2aad9fb4..dca6e011cc40 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -9299,7 +9299,7 @@ int ath11k_wmi_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
>   {
>   	struct wmi_hw_data_filter_cmd *cmd;
>   	struct sk_buff *skb;
> -	int len;
> +	int ret, len;
>   
>   	len = sizeof(*cmd);
>   	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
> @@ -9324,7 +9324,13 @@ int ath11k_wmi_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
>   		   "hw data filter enable %d filter_bitmap 0x%x\n",
>   		   enable, filter_bitmap);
>   
> -	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
> +	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to send WMI_HW_DATA_FILTER_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>   }
>

{ .. }


> @@ -10053,7 +10127,13 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
>   		   "sta keepalive vdev %d enabled %d method %d interval %d\n",
>   		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
>   
> -	return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
> +	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
> +	if (ret) {
> +		ath11k_warn(ar->ab, "failed to send WMI_STA_KEEPALIVE_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +
> +	return ret;
>   }
>   
>   bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar)


Thanks for fixing these. One more instance of the same pattern remains 
in ath11k_tm_cmd_wmi_ftm().

Please add dev_kfree_skb(skb) before goto out, matching 
ath11k_tm_cmd_wmi() above.

-- 
--
Ramesh


