Return-Path: <linux-wireless+bounces-31125-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG9DMUGvc2nOxwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31125-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 18:26:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 349CA78FC5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 18:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BF34301D4F5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A8296BA7;
	Fri, 23 Jan 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqspBZsd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mwg7ANrG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79A285CBA
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189181; cv=none; b=grXKMsAWP3G8mxtYRANQnpTPRxVkkOTmTxTy4j6Xq0rAVVun3Qb4LohKQNNEDz1Bt7wDzPKFUlIKGmYc8RrvJpjdX7jQTkFOoSn2+BvJ2eqeiHeE71BAhfCWQYRjGclgbfHJkUOs5YNZAAjdbZgibi6Wp4N3HkEQghIyBiSeQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189181; c=relaxed/simple;
	bh=eHk+vPthyUGqFVXs3XaT+4XSUiPADjJMf5aAkIcb648=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAQRuyPljBQJmzyjVntIgLWQR49msO1fuQra2oCHH8XN8zyfTtGxmnwS3/rINT4L66shLMtadgtiAo2IaFrur3fJIZuKdJj5Ww3OZcbj9xFitlYrgeWepKKZcbCsRvJkJh10wxbksHMSxQhcAL1FMBsV+owcEqtnkLCBws6aKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqspBZsd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mwg7ANrG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NDTBSD3677838
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 17:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g/E+2t1fdfEDSCOIA22/v+4jziQGVAuaEcc3NXgiKYQ=; b=VqspBZsd+V9CJ2kI
	NdOpx/du69Oxk+ab38K9IkVYiftPD9JCp7uh/Bn00h8WxmYg93ucSTopA6H796xb
	QhsnJSfQDsPxu8QcAuoMnxsFDNSLzzrHmWhbPmNUJfBfSV3+01mx9bBEhmSRsLR9
	N5/YRBZoLNrnzBe07Vpkw61fVBVrIDzbuI00qE6rQGl9Ad8g2FWtnWyZwUZjJH+X
	vDC6W59GJEuhoXv++EkuSipXTViFbsGEuvaQpeCf3wJc/qMTx/kRtRA+NOwm9FHQ
	isAw91QpcXXhF9UttqqxDFw3pqBJpJw5gAOhfaDd/8HB9rDoQ7r7Rn+xgP9rtdZx
	L93txQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buqyp4gvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 17:26:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b704019c98so2459873eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769189178; x=1769793978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/E+2t1fdfEDSCOIA22/v+4jziQGVAuaEcc3NXgiKYQ=;
        b=Mwg7ANrG0R41LmBsbu1h9GG+g2My6Xzn9dAC1Pd/VcmNG5J1/wYsHSGNaB++b61LND
         m06q8z9rmD5OVZy6jt4noNnsd3cePp/rbGrzTXOoKOc7P+yp2tCDIXy3KrFsoSrPcqu/
         1vhivNtlp5NVcea+f7Su8/RNs/eCbNiIfy4rNfhok7hmix0sjDkWBMjQP16RE4Ry30UL
         6uIQp31qI64DH7WHYUuPNFJLxfbUkVidSr1iPGerMhnCKwEGT4r6xSUdtNPPduTlS0E1
         38DBlqJzUvVepahzRB8lzit6jtNhNrg5zrTLDINVc8/okiFtyalEJTTiO0oon8eDGqvU
         3lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189178; x=1769793978;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/E+2t1fdfEDSCOIA22/v+4jziQGVAuaEcc3NXgiKYQ=;
        b=OH3Ojf3IcpViXcG9oAc2efRyG/GsVm66MtUoUowWgHJB2Pb0LTcdskAP1Y180SqBy0
         xZKkjEG3siFST/0Onc5wfXzdRKzpxRb7fxw/Dz2E5QW9VOB4CSVoQb/g633gT/YJrUkV
         Uj5tI8xliRKDBUPXymOAJyIN2y2gbUHXQKOgGOWVTN7PbF3BbcdCrVUmqb/3Qma1+acg
         rzkxqkoP95lRsCZ7E4ql7NuE8L20hZPaLKOkHs/hzAWdLiDMVb36TmHLNljo8sQMldG1
         wc+KQm+wiyumBB/GmEQGFk4vsZJm1sWIq/aC7yVhC9evyPB+UTtv5p6DZzNu+mGVukdn
         CdnQ==
X-Gm-Message-State: AOJu0YyNXI4GDYhn75bKpmzPGhv7GUL76NBTi72hf/gj64oRCGtiH1X9
	yAnqiTsH2e464eONd8m/IWS/e8ASFh/90jdj3xdo/Ne0QEfnPD0/VvHrRExk+OItN5iBVeapEya
	MkUq1mRr4rXv3taRiQ0Jzh2m80LjUPN/GMw5W4SoTjnq4spH5efgmkk7pmURnR50C6rKqRw==
X-Gm-Gg: AZuq6aLO7vCURDM4SeOaXh47sCfRlfQWkZRuXX7AbnFmQNdUA6Gq/JIDH0FPsjMLEgM
	zSlxeHj2+jAgcvTC8Eqko6Jko7W/1HbZAbJ/niIcyPETDJKOXJO8zK9kcLzBHLoF0TDxc7/1BGL
	3jYggDKyZ9XMTh8hecUfeFzgkEOFVvdBBbzU831nuyTWRh3sHa4jA/NuS4AgysUJilpw8VplGPa
	X3C5mbauDZRUp1B0Gq7WGBMVhcEmG9mmq3S/FZuon+NHyDpuSd66kIfGsnHLAtWiIBJ4IJjqquZ
	ZJJyrFbU/nuvgLd4qSmuKnKQsYLtXbfEa8SdKOToy+yvSZ+nvS72cRQCUaz3AfrE1obqrygv6An
	X7Q3jUyrJqCMArhafNwVMI/ZDLrbkl7wOggOLp5vNeJDnyBPDhPMGgN3EqcHZxIQT+syBQfftB+
	A2
X-Received: by 2002:a05:7301:4e0b:b0:2a4:3593:c7c5 with SMTP id 5a478bee46e88-2b73995a3abmr1580060eec.5.1769189177716;
        Fri, 23 Jan 2026 09:26:17 -0800 (PST)
X-Received: by 2002:a05:7301:4e0b:b0:2a4:3593:c7c5 with SMTP id 5a478bee46e88-2b73995a3abmr1580039eec.5.1769189177089;
        Fri, 23 Jan 2026 09:26:17 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6f5d2asm3809805eec.14.2026.01.23.09.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 09:26:16 -0800 (PST)
Message-ID: <d42a139e-7e8c-4516-ae4f-5da419a3191e@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 09:26:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: fix lock protection in
 ath10k_wmi_event_peer_sta_ps_state_chg()
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260123160244.262225-1-n7l8m4@u.northwestern.edu>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123160244.262225-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=6973af3b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sZ0xnW9vVDrYtnK7kcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: PNeQnoBaycuf9AXXma5Jko_nKwNivzKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMSBTYWx0ZWRfX8NE7PVeAiMqe
 GDEiZvLD2D/Xs5upr6bP14IueRo+ldC4p/drimCOBs+gHdAI+gHfTsFAszdD2ubYEvpAfx8lCCS
 nyLaYeqTqilKMzbuLw0RXX9PfUI+qlTvExQYjuIwvhNEZy5c4vognXvupGriDyCJAbh1pVJA/K3
 bbsnNDYHE7F/X1C9PWmCo48bxioXqpslpH94F1G7/u4pp7Ub6b6cfI4EqynR3BMoPLF8fYv1ft0
 2VAuqMMJIJ407Zbbcdgn5Wt9X+3GRzHBY9NfAk3/C8iHY9MK69YCSVJlnmGbOPOdRA5g843kcYr
 3Qu5GiA0gz7oEC3B0n1Dc0R25Oqqj60hqFk2ZomMg++TOjG56ssSAECq201ihq5qGgleR8LKEmp
 SnNIKs3jkehCYmthy4xSuWJtO3gch8kyMe/goSBfTJM40qNdkaBsf/MDPPFbh1jPRuX/8ca6SPQ
 rmUSYwxiw2Lm8uLQHuA==
X-Proofpoint-GUID: PNeQnoBaycuf9AXXma5Jko_nKwNivzKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230131
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31125-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 349CA78FC5
X-Rspamd-Action: no action

On 1/23/2026 8:02 AM, Ziyi Guo wrote:
> ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
> assert that ar->data_lock should be held by the caller, but neither
> ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
> before calling this function.
> 
> The field arsta->peer_ps_state is documented as protected by
> ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
> ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.
> 
> Add spin_lock_bh()/spin_unlock_bh() around the peer_ps_state update,
> following the pattern used by other WMI event handlers in the driver.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/net/wireless/ath/ath10k/wmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index b4aad6604d6d..40259504927c 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -5305,7 +5305,9 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
>  	}
>  
>  	arsta = (struct ath10k_sta *)sta->drv_priv;
> +	spin_lock_bh(&ar->data_lock);
>  	arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state);
> +	spin_unlock_bh(&ar->data_lock);
>  
>  exit:
>  	rcu_read_unlock();

this solution is inconsistent with the lockdep_assert_held().

either the locking should be done by the callers or the lockdep_assert_held()
should be removed in conjunction with the new locking you are adding.

/jeff

