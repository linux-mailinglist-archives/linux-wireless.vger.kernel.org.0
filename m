Return-Path: <linux-wireless+bounces-36307-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPrtIFLKAmpAwwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36307-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 08:36:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C45851B1C9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 08:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DACB304A6F9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77935B632;
	Tue, 12 May 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jWvtS6hg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WH4R0t69"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F31AA1F4
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567403; cv=none; b=RSeYiCTj9z60lVK/LdIEOqrUocj+JEB3aoxSYn/OZWD5yEyY5LSqeknBW3plLv3BwCvMct98qNn8lWKP4ZKMqGYyINSVIErt/4qYFQ4N0yELTu4W6L79KkSHOQPMoStXNTfXEJwQN5TV0ficLODyfOh72Ae9l8GcPvOVI4bfsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567403; c=relaxed/simple;
	bh=zb57PPL00oUNjZ0P+deKRvi225f0oyKYrkdSGG6vQAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl9hZGLnwPFAA9y/yR4vCW4l+0LsnO6dtRQD85ibTQoguMFfhHnG+/6P7LAHHVL7FayJRASHWH8C/9QC0Tx0+S2qEqKI2U+uUrR01l094HZoXyqD7eqPJejfl58epDMro1Xif/dT2jVnEY7201pYSnhegq4VIRHDC5mJgMD2XtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jWvtS6hg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WH4R0t69; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5bpaS2172407
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 06:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2nOVCL/9tt+FInVx9R38fMMLDSnoK60AMq8V0QYUjeo=; b=jWvtS6hgJM725QLn
	KWV4w9cADpqkRltOpMl2/CDsmyzZnJDF5vCB3UbesQaO4DbAsR+dL0Cw2T97bIJi
	8OSMJIWSvPZHPoP5Rj2X+6bJGVsbhiK1d824WbXakWO+MNO0YPwybPeKFAPOzzPM
	x2M10slANvezixQBkrK/zgYuEo0pITsL3XYsR31g3eBSTY6eDS6p1xywH69iBi7O
	94a2D+v4uwiyyWRuM1Lyv2wTMGG0cMkojJjvUZbEsHmHjmBc9/CI5RHDVeeqiwsV
	HRzwaP62g1ODd5LNI/GPWNUv101DH87hvZljwOz8vMKSvNsgntI1D5wO3Hjug5Bb
	3pxxqg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj9un3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 06:29:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2baf7748d0aso44919325ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 23:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778567386; x=1779172186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nOVCL/9tt+FInVx9R38fMMLDSnoK60AMq8V0QYUjeo=;
        b=WH4R0t69wp2JGZDHHikCaC7cZ/vIyvSM/MCCIsyNKP1Z01WBJHvTG38BHCBNqyNGML
         zYqOAdKo2ZT4fdxqXy1tYsA2Su0gTc0lNlf8RHA7LatVmNNwUpd7lmqmYQOHK8plx+2b
         GAIU6KaBERsep8PoKKqesIy6H6R/z9xnMpu1gbSam6iRj9DIAVj++Qmiq1YnzwECDVFl
         T2gkKSEwAsdq8GGB4ECHX+XQ9L8A104HeCNx/bkf2u1hhUHECp0dM8sNl7XT0jVQPULh
         mVVj+bAqI5+ytVPG1t7DfheitPW6wr9Cdr6aVPpyhMsN8bZnqvk6vMjt2isouy3dyeaS
         HnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567386; x=1779172186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nOVCL/9tt+FInVx9R38fMMLDSnoK60AMq8V0QYUjeo=;
        b=G4x2S0j88Utsat5IMQcAShQNcQ2ju+NFQvp/rKLMdQ5tasT0D3bWok90veklYkAXF3
         h4QLCvowF9q/ZLDrOBOjLTutOOC/0NHZgoAGhtPlMEwxYiq5ZH3DZxxUD8jpfAolIE+H
         tN2NIc6+T9G2UZnU3ljr9+rHqRDwdTZzTRxHcJFTJGjg/rj73xr1fCe7haV3a1hu+f1g
         Fd4o7c6DQEXxe/lHxumG0tgcW8yKZI9C/TSez74SQpaVK/OnthFq6U04UD+SM5xMve72
         RwgQkhh9PtsW9ls+ot7fHGFYveVqIuHJH9yVwAxTbu1/Al/Ivcxv3Yvtt+uviB2VaNIx
         7y+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9UdqzUkc6q7wGzDZ3NurmgPVkbs1XwgOtbmNXG2EwM9WyDlw2vLQbl8VqITAP2lhdPN34VMBjSe0TP207FdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6ShlMOf2W81KoSiFX+t+f2bMh4eqfDL8lBuEHA7f/JSAoZzW
	C02WDpCzMLa4LKOVRWKM4wbhh1yX2rvNWfSWpbLqblWxDHncpjiKfuP9cn+63DYIOFuVnHgWSId
	NskMr1oZ6y8j62xubiqIc7iJNZxKd8MPxeGK8LNJDEntrTiuV0JoN3/6Cu3fODmwZI+O9VA==
X-Gm-Gg: Acq92OEEv+xj2JfKiEKn8ZDpXTn2J3PFCSSJH931CRnUhM6EZbKNh5KHVMPifsTt/Sw
	NMnCgJdDHh6ux9gNQfm54A+P3U4ZZIfWPImN2ssVIBOiMhpLh0XhLM92ZPgceCnqICKtLAOVG+E
	FnT5o7AZ/xqGVdlwuJzyZsKB2km/EqrM6y9I1CeWtrDxetrT7Da3LonyZhgqOeDv5lCv9PcQqZE
	1X3Bqx2hAPAsa0wKoJp/KA8ssP+/d2UudVDmIuDOvdueo404eVs2ylqqSjiCuSoM3+AMQsmc7mR
	wUbtuWtHeKRFrW4E8UCivY+VXkUODJnjFAwNlc9TLaJMvO3YhVKztH9708bRMCJFwRfWUvwBcTt
	3uQZa4i+ypKkBnUxwIEa1aDru5IruZevxNPv3mXDmRa9nw0c=
X-Received: by 2002:a17:902:ff8e:b0:2b2:6df1:111d with SMTP id d9443c01a7336-2baf0dd594fmr173790155ad.21.1778567385945;
        Mon, 11 May 2026 23:29:45 -0700 (PDT)
X-Received: by 2002:a17:902:ff8e:b0:2b2:6df1:111d with SMTP id d9443c01a7336-2baf0dd594fmr173789715ad.21.1778567385398;
        Mon, 11 May 2026 23:29:45 -0700 (PDT)
Received: from [172.20.10.2] ([171.79.60.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4094fsm124649425ad.19.2026.05.11.23.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 23:29:45 -0700 (PDT)
Message-ID: <32ba727a-e4e9-4895-92ea-2bb9c61e491d@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:59:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath11k: fix peer resolution on rx path when
 peer_id=0
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FbE1k7Tna69HnqJKke_JfhicEDsWFwF-
X-Proofpoint-GUID: FbE1k7Tna69HnqJKke_JfhicEDsWFwF-
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a02c8da cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=roY0INCFEICOlP0VhbB1ZQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=4RyH2EuIL7uwbwVYth0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MSBTYWx0ZWRfX8vSSqwpcVTgw
 5NanAwLh3EXYMhDeYkxE0JPERafrXLWSeeh2APG7d8k4EIonEto14LYrG4OqycQCDmkY8dE+g9i
 I661Wuxfv8iixgAsFkzWWhqmh8dzMjErA7mHrpU/tSFWoD/dqKAxjsOa6ytXWPt3q5xbFeZbK6s
 +UXOk6kB/nZ4QRQDwNs0yrRRpFUYBfcgxX6kMmhlEcyT1W/Wmuxc+Fw5Z/54qFtwckLa3S+vWgC
 Q7C/pElzcWTPAK9TQpSUp1mC5+f/3MIAzVU4oKYJAkvTb9mgJ16V3HHXWh3oWChemUPcHd15rPO
 XbCQjWl+AhOqSI4dsmLGglwRBShvPtb3agKMiRuBjFK1NZYpoWdA7zXbwzy3/tm2zEjViPY3M1Z
 RD7hAthEV/2Q0/Po1Kki8Av6h+RnUAoxj2xOW8dyXCGdndsY8qYCX4oGe80WM+snjGG2+DSZo1W
 Elq4ROjweZjRHGKZN2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120061
X-Rspamd-Queue-Id: 1C45851B1C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,infradead.org:email,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36307-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 4/24/2026 3:20 PM, Matthew Leach wrote:
> It has been observed that on certain chipsets a peer can be assigned
> peer_id=0. For reception of non-aggregated MPDUs this is fine as
> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
> based upon the source MAC address. On an aggregated link, the mpdu_start
> header is only populated by hardware on the first sub-MSDU. This causes
> the peer resolution to be skipped for the subsequent MSDUs and the
> encryption type of these frames to be set to an incorrect value,
> resulting in these MSDUs being dropped by ieee80211.
>
> ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
> ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1
>
> Remove the null peer_id checks in ath11k_dp_rx_h_find_peer() and
> ath11k_hal_rx_parse_mon_status_tlv(), allowing peers with an assigned ID
> of 0 to be resolved.
>
> Fixes: 2167fa606c0f ("ath11k: Add support for RX decapsulation offload")
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
> Changes in v4:
> - Prefix subsystem with 'wifi:'.
> - Added the 'Tested-by' and 'Fixes' trailers.
> - Link to v3: https://patch.msgid.link/20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com
>
> Changes in v3:
> - Clarified that the mpdu_start header isn't populated by the h/w for
>    all sub-MSDUs in the commit message.
> - Fix second null-peer check in ath11k_hal_rx_parse_mon_status_tlv().
> - Link to v2: https://patch.msgid.link/20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com
>
> Changes in v2:
>
> - Since peer_id=0 is a valid condition on some chips, remove the guard
>    that prevented the peer lookup.
> - Link to v1: https://patch.msgid.link/20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com
>
> To: Jeff Johnson <jjohnson@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: ath11k@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c  | 3 +--
>   drivers/net/wireless/ath/ath11k/hal_rx.c | 5 +----
>   2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 49d959b2e148..ff2c78a4e5f3 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2215,8 +2215,7 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
>   
>   	lockdep_assert_held(&ab->base_lock);
>   
> -	if (rxcb->peer_id)
> -		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
> +	peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
>   
>   	if (peer)
>   		return peer;
> diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
> index 753bd93f0212..51e0840bc0d1 100644
> --- a/drivers/net/wireless/ath/ath11k/hal_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
> @@ -1467,11 +1467,8 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>   	case HAL_RX_MPDU_START: {
>   		struct hal_rx_mpdu_info *mpdu_info =
>   				(struct hal_rx_mpdu_info *)tlv_data;
> -		u16 peer_id;
>   
> -		peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
> -		if (peer_id)
> -			ppdu_info->peer_id = peer_id;
> +		ppdu_info->peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
>   		break;
>   	}
>   	case HAL_RXPCU_PPDU_END_INFO: {
>
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1
>
> Best regards,
> --
> Matt
Reviewed-by: P Praneesh <praneesh.p@oss.qualcomm.com>

