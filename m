Return-Path: <linux-wireless+bounces-32286-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMbfESNzoWkPtQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32286-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:34:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F25E1B6093
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 986F030329AD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529BD3148C5;
	Fri, 27 Feb 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nW5ZtIJv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wem4Ql1A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5936EA9D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188441; cv=none; b=Y9LILnNUmPs6BHgn7Mz/gQN04vf9g3oF9iHmLS5+ANVXmjKCabHf1+WODRO04vNS+fxry8pSQCfXUBIfunOxykEDxikPBmt9t8tacIrEffo5Ssr9JGJny9yWi0fQEcfSyxUmvmzYO5SCIvIoZnEI6xynNxgci62IXjaJTLjisoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188441; c=relaxed/simple;
	bh=5N5UcQaTLAh+3vlP4eCevLww+eoFD5KYLC/rM7F7/MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6KyshrXWU4EA3FTN/Sg0qA7xheTyRR0A8aSaYDv/KyGf3AvFOnWZEVr5Qf0fTfUwn1ox02Gv2zOUPCEeAphsIVb0pWKtJlrvsQmIGzdyQiA+RKgjsmEL2UltpktPAxpuzjyPT0o1NTcDnMHmMYIY+yxnhBxYS1PVXJeGpErsV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nW5ZtIJv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wem4Ql1A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RAE3Dh236183
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q0Zfgz7c8OWbFOK3XZczX8TwvU75kM+2bED6CLxjp/4=; b=nW5ZtIJvP11D1TIN
	Gu/zsW8eCRseo45i9GEcCQU0GNc6ka1LdvopXHxoAvDwulYK2r1XJKJCQmf3RScg
	1Bdpm5/Vh2IIubU+zBpv+s6NIVijIo/+CAANE/wUNhtDgEL2XX8S66CPhFd6TxVy
	v/q9/UUkbFZh2920Y1oeSqnmuSjcpwoRzlcUV0CSxUbshx7K71QjAbC/3JIfbh6k
	1y04JpcY3LsJqpEkCRX2/vgmpQ8iiIV7cGctzodXHf0MS/4l1IxgqcH8vM9ajHDy
	b5C+Ml1BWhsVmfQJYzTZVQRAhavMDsrV25i9Uxn5umQtw4raYF1Dl6tY0/vmPeKn
	whL5jw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xt51p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:33:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so1739648a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 02:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772188438; x=1772793238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0Zfgz7c8OWbFOK3XZczX8TwvU75kM+2bED6CLxjp/4=;
        b=Wem4Ql1Axsl8JNytNg0zraYNNuFpfUJzYZ19JXb0ce3VoXF9vpVvDkGq1nynNyr80q
         HNlw0j/jEnmtqh8+S5/EebRlFKG8BuLqU7yfUqzqKSlkcr+VfHLDEe0TY064Itib6cgX
         qq0KSeFmiT7du9SQcwn9F7IuVqNLqgAIq3oASbErWqbwx2d2wD/7tLeBHMhdoBb8agjD
         rudWgg8dA6fRm565qHN3asSwEoOZQFJO8ME8kKT7k9ZY9ttejs/a/LEnVNQi/SRpkcmg
         hDHVmL9i9aCVKbwnJ0NVXm/NSNSLHAdE0hc8WyuwerIWc4MzeLzYu+kP5y9JWF3PprRx
         QSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188438; x=1772793238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0Zfgz7c8OWbFOK3XZczX8TwvU75kM+2bED6CLxjp/4=;
        b=DvythXOiXDuu2Uqy+5zlwfVIM+Szu3+Kwzx3TqBDEKvHGWYnqoy0tTn5JGoWhvopu/
         7gHLe9KrGtDWpEHsf2cLnDFViGl7EZM9vMwMUxaevsSGhjTYiBN4C6/294tKTom22iho
         IAS+RiI4YuUCSAxI8OmCmeNbhKqQAvODvsv/yKurZ7m7qLCCrbU5Hiktg7N3HN53AJTH
         wXkAHOKWwlNdJe2PpDWprCVtMUx48Lfn3nfQsf7PD4IT78Q+ZqRobhdZevTcyEmAc1jg
         lZ9tS4otBn32i3Ch8kVW52bHMI4boZqtgFZnLEOkSS+d40fnHnThIuXjbslRa1d6gjtu
         tGEw==
X-Gm-Message-State: AOJu0YyGTcpg7Tusii6djYZON1E6gSGnBTur8hVOwudzdaRWi5sDH3Zh
	0rjZHQIWaFXU3L/gzBPq5+LcrWHuH2SfUnBY7cs67Qi9cZxR8Dfjnl1tvcTCvsF+chEJlehCW6K
	/SZwZynHxucHwGVfFQfE51vIMfH63MdajJAVsdKi+kcnu49KfEZykWRYcXHCSPt3zTfUJWA==
X-Gm-Gg: ATEYQzzD2rhBc1ot2OjhPownwblz/3nbEaF3++KdXP0QWrXM6ITUi526MyzUUlVC7Pr
	7o0d49MuNxP2959gR06IhnOR2/oUOSYC/tbSTzUMZ6u/Memzup1DBoXYfZjoBHtaABu9vr6rb3U
	mD1CHZekvcJnh75RbL7cnFM75hLKg/+5X1aLPUzBkRbQZ0wecvAm3bk4PSoetHXwrGQ4Je6OQi0
	qVwEmW2uFY8OCF/vNTsc+qgOw2To8uv/3YxMfMDvX//J7qyWlkmrVFbnsv6YAPoSdvbPaaTUrJu
	YipOHJeRp7ngnmQBSH84VHGT94aSkuJ0iSMonTEzXPca/fEBTD8CNdO9WLdiVu9Rbop2wenrkqG
	VuW/qXqmpS0udrtin2AYcow4QOeEvYAWM89sIsXRORQ5Vz2mVpKKOEex223efQYu9D/8=
X-Received: by 2002:a05:6a21:1bc4:b0:38e:95f9:8cc1 with SMTP id adf61e73a8af0-395c4601a3bmr2254226637.12.1772188438291;
        Fri, 27 Feb 2026 02:33:58 -0800 (PST)
X-Received: by 2002:a05:6a21:1bc4:b0:38e:95f9:8cc1 with SMTP id adf61e73a8af0-395c4601a3bmr2254207637.12.1772188437735;
        Fri, 27 Feb 2026 02:33:57 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8479aasm4533499a12.31.2026.02.27.02.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:33:57 -0800 (PST)
Message-ID: <84534529-50cd-468c-8a50-1503e6cf475b@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 16:03:54 +0530
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
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UKnAlDGM1q0A4QtpEEip9HmnGS7GWhtl
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a17316 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=YqZLIXxkOqM5MmwRYRkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MSBTYWx0ZWRfX6QMf1laXRAXn
 ZEHa61cZ3N75ixd14tnqJEv3lNvVijLHBHNETh8sAtvsY1cxunLQvS6yutCA/h2DpUhbmxbek9u
 Oe9bqD9owmMnbImzJ5JZvgiK/J9TlLhc56COi+qRGbhfS9zhh74ePWKhgZQTBKHGK/NKpiMLtuL
 iYtDVIEzvxTkgcdXmOTTgybiuiHgQKY4l6SYFRPAmglGOTCzWC3EiQ9QnjsPpl2PcRqDVAWAgoT
 xc5p+I8ub4zN0fdy4sw5/1aJIgLmb64hkaMlXgyFOs1aW/2uofWqNsTJ9Ny3IxcIL3iAddt2Ukj
 NzpJ3qLi5Nc1SBq+toosaCkfmR7TbwgRFDx9rfUcvyX3fuBxt4dmvesqFQEdDo8QRFiLdAU2LvN
 /9FOoafAfm8ga54t5W858KmthbZGxGgpJNNvzK3pYRUsK0P2hPXl4VVncGMWUedMUNs6Y8Jbwua
 KwUpJw/PP1gzdnFr18g==
X-Proofpoint-GUID: UKnAlDGM1q0A4QtpEEip9HmnGS7GWhtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32286-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F25E1B6093
X-Rspamd-Action: no action



On 2/26/2026 9:49 AM, Roopni Devanathan wrote:
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

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

