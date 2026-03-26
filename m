Return-Path: <linux-wireless+bounces-33915-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Dw2HhPAxGnp3AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33915-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:11:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D432F447
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFBAE3030B91
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 05:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB03502A7;
	Thu, 26 Mar 2026 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bISMWj/g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G7wS5+kE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF8336883
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501861; cv=none; b=p/xUuOFI3qOkwakstPm/2idhKxDr+HYhhbKsNcKpReUuxOmAPcyoPLeDfKXDdQqkHdZDJ9Tt3IWjNXmoMOsFL/XT1N+TaQsvxCdT7xeWZ8jqMwbcKOWLNoi9jJl8Iym45O1cJ8RBnh8rtfMl47MlI8l4n/A2dsqmSlIyH6p1mVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501861; c=relaxed/simple;
	bh=qXNG08BBCTUiqxDvrQD0Dj45LazxYXPDdsDBovIDXAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYQCl1BM9Lkd/V/7tpvAFi6yY5vxDLjEz2MOKPH6e19wOWroUXpo/HgwRk9g1bze/3BJG0W3TjCvQFfrCYcQOb4r6t8fOj2RNCNe+osi6WKdUvFOz7Ztdc9atXx6/vVAp3X0MeU93ju0goXCx8O7+cPeAwUeEv5QPdRxBJ31ODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bISMWj/g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G7wS5+kE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PKfxOc1965142
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	je9xx+M2zMyO3JH9z5bTiR8KWSCvjxHfgNsRcJjClNw=; b=bISMWj/gMVkNeIHS
	mMXgr3kGp77EyfFWpEE4jLYGnPt5Cs1vAMK22lc1ocwpx1tzRhFlFgOHI/WWJNoy
	917pXeduA6Jwg75oZqdfXNoTpfo0iLF3K8em2eEGZzDMdXix/XA6GI2i6kKN8aif
	kjaJD9/tSF5GLkHiGo9Sbt+7ZGlFPlzMQeaP0JI751l3Ccw7mB4kiVrK5m7+u7t1
	gLw5y0SrrutiKhxnVLOHULGE5JxplPJz64HLsfuMLlZT18aBkbBuvlgAYD8erPlx
	gRgljDy9aJexD2yJUz/HXV515iFPbbEJR6JzD8IUI5r43EeKbw2rM+CtjiKHUnJ0
	3uGMog==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4pymh9kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:10:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c69a72aeaso393153b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774501859; x=1775106659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=je9xx+M2zMyO3JH9z5bTiR8KWSCvjxHfgNsRcJjClNw=;
        b=G7wS5+kEhTDIJqxrQC0LJogG2DNKXosNJH6O0rjNIRofa9ttXEZH+W3hmzhCmrC5wC
         IuouF2+pQgQ6tJ30o0hl5IA4gzz+Kqaw9HcitEkbiPEQcDH0K/n0zzSEqQa7yNOlUAtx
         dy+GgUleHKvziSDSZ8jTKOdx0cdgcXMBDtl9qGK1ZqA1S9SFQpBfcLoxMjhkm5UILLGW
         4fHhXVl8f8jogg/Eyib4l/WtfGdppjVkNGrUCHzMLUCtMFCgNfnDw88JU+0T/fYOmN01
         B+kqnGrjGvbCcJ8jrQGOj5iCEolwUo7TDzGRC2nXMMt0iJx6RgRN6e8A6CP9Osr54Tz0
         WTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774501859; x=1775106659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je9xx+M2zMyO3JH9z5bTiR8KWSCvjxHfgNsRcJjClNw=;
        b=bkk+GfENfogMbojOhsoWAQOWsif18YekQXAQo/Ci8p/XFeSHIhj35y0JTH9nU/C0I2
         SCUrs2WrFEC2FNbzYGDfczkQzmrZC1VcO4fceBHjWfRSrJSDZM7UfQwAnnTrcIloSNKj
         4aqPW9KCY3rMUycPS+mbsb45CZZ37mMnaAChjYmMrXpf4Xt/FKM9/iA0su+xoSTj6iQn
         I/BfI8tzCgJod3KDDYGeG8EfgnAKvj7qQlA4rYe3lzbTR336AyPx/hTcKpmumG81o4v3
         D+3mwMLZTx2tM9gDJlys7th8I2enUKh+8hQqRduYJLj2THp5XmlDqsDmbd1PTEU0Xere
         ir7A==
X-Gm-Message-State: AOJu0YzERm7amo2C53ZB3YoSCmBil4GtewFhsjDd20Dci8TNXavh0LZd
	OoK1DOpXji3htA8vCZ/6rTjVG+Iutqt2S+QDjdsWMCXyKEVjjLS5J0dDa5SRM78jaDO+8I+Op4I
	sDeKzON+KHCm3h2tg1TCEO3hJggKd5sTmKgKuoJyo1v/JjvT13lJy9hw0ObAmvyFGn9Th3w==
X-Gm-Gg: ATEYQzw8ZmV1CBSl1fR58UQpax4c12sYt6vhGRlN/A76fHxUfC4kryLYTZRI0X7tOZ4
	fa/BQajpbi1UrtKxQQnyPRC7JRLb5gjtRt6wvRC3B5lRYSC0y+o+KrSJoSw8p8EaitvcL4WRWXp
	mhlCOHH/9P1oM7UI6le948bmQDb23p0p4BynRZF3gEC2jksuCiib72tt6fzXaaeBoDnwm4RYwUZ
	WuKTEDOIe+uHTFy8R0WWPEoP8+CgOHOtaH1A6uz5Wf5XqRbAW7UV4JyqVX2+lKKg7po0OANtGUq
	mqt4BBgkU87dYGGur05hB2SAiqKc0pqcYKn01Fh3vuqYoQ1m9P4YA2ouFIgzhYDe2JFJRPhB5Hb
	wcYeybVXO92/iEevSUgFzTmdRRAYqBH2NhFfO43f219g1VJkoHw==
X-Received: by 2002:a05:6a00:4bb3:b0:82c:7876:a027 with SMTP id d2e1a72fcca58-82c7876a666mr2759737b3a.18.1774501859105;
        Wed, 25 Mar 2026 22:10:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:4bb3:b0:82c:7876:a027 with SMTP id d2e1a72fcca58-82c7876a666mr2759715b3a.18.1774501858647;
        Wed, 25 Mar 2026 22:10:58 -0700 (PDT)
Received: from [10.152.196.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3f9593sm1246249b3a.53.2026.03.25.22.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 22:10:58 -0700 (PDT)
Message-ID: <c0f0d46f-fced-415d-b2ee-30339a0a0049@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:40:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 2/5] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
References: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
 <20250518-ath12k-ipq5424-v2-2-ef81b833dc97@quicinc.com>
 <12cb2f34-2142-4a38-9e73-49c2cf66d8f8@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
In-Reply-To: <12cb2f34-2142-4a38-9e73-49c2cf66d8f8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: J5gIyPCb4y00LHwJ-ctaOCMMPGY5RkAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAzNyBTYWx0ZWRfX+ar3OOwDrrk2
 KSE8D0bVYfvcE20JZDxhkfbVB8dcXTUYDpDenjVcS7FVdnZaeGMx7is+r9ZlKDPZamNvEdMwBPR
 kPdaJhgzN1gKAAtrDdDesAYSAQ89R7N2LelzlPfE5smfiLcDJacIL8O89xsZvdvmYHUu0HldAMj
 NLF0GVWHkUv0gef3/oXBbOpU58YoNKFL6QjVSuQKRyorExz/p6txWF25zhEgVhCLwiTQJBGNGup
 TfpOCTf1tPom6GGdSzGxghinqJCra8jyMro2nvJBmQEVTSi635L8RT488L29D3wpD+QyTtyblWS
 slx64XZ6E4FjRYUESjH3PN4lZgNxt3pttiz5+ZFqaQGNnC+54/ifTKy+ZLWDbtxcDf5fJmWMi9h
 OB+LoEnQ01E4+BuiVkaD5HvnNeH9J9/VxKju/qgG2vcc5QhYcUOpXIkErTqy1wNYJM5p9OIgT/f
 JTFs2ueDqkBqrw8WEhQ==
X-Authority-Analysis: v=2.4 cv=SvedKfO0 c=1 sm=1 tr=0 ts=69c4bfe3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=qC_FGOx9AAAA:8 a=xSzTO1CcoS2zrBndkREA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: J5gIyPCb4y00LHwJ-ctaOCMMPGY5RkAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260037
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33915-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,codelinaro.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 176D432F447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20-05-2025 21:29, Jeff Johnson wrote:
> On 5/18/2025 11:22 AM, Raj Kumar Bhagat wrote:
>> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
>> index 7e2cf0fb2085ab014fc14a5c81074802674b154e..866de53f37bb5af94e16c796a0052fda39eb4ea8 100644
>> --- a/drivers/net/wireless/ath/ath12k/hw.c
>> +++ b/drivers/net/wireless/ath/ath12k/hw.c
>> @@ -1590,6 +1590,84 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>>   		.ce_remap = &ath12k_ce_remap_ipq5332,
>>   		.bdf_addr_offset = 0xC00000,
>>   
>> +		.dp_primary_link_only = true,
>> +	},
>> +	{
>> +		.name = "ipq5424 hw1.0",
>> +		.hw_rev = ATH12K_HW_IPQ5424_HW10,
>> +		.fw = {
>> +			.dir = "IPQ5424/hw1.0",
>> +			.board_size = 256 * 1024,
>> +			.cal_offset = 128 * 1024,
>> +			.m3_loader = ath12k_m3_fw_loader_remoteproc,
> 
> Until the firmware is available in linux-firmware I cannot accept this series.
> Please work with the firmware team to make sure I get firmware via the
> internal release process so that I can stage it.
> 

Hi Jeff,

The Firmware binaries are now uploaded to CLO:
https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/tree/main/IPQ5424/hw1.0?ref_type=heads

Will send the next version and resume this series.

