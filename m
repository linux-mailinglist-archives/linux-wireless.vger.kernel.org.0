Return-Path: <linux-wireless+bounces-23817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F707AD0A1C
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7510518971DE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9E23C8D3;
	Fri,  6 Jun 2025 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C87jzYaH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7F23A9AB
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749250824; cv=none; b=X/UD/7nszCsJmplChj8CaNDFtYZDjThHEnsyGXqNByI7z09c6LdfzPY30NVwGUMGnXH+ma/wyPUS5/x1opQeqF4JIJ+JcjxiK3v1fjU22n0FDsKsPZ9gzXS9fWMEpBrVv2s0z1DLN2a9EKnhKjx/RkUYKLOhyVnTEYvQUfTorFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749250824; c=relaxed/simple;
	bh=wgOe9oGQBPicygJ2wtdDkUZYgoKUx2ndvWSvuhFOfgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTkOQTWvC9dc5GG0eL2P4L1KzX9ZgK0Uy6qN5skT7lEMvDht8oN/RNkLzOwB0lHJI8EJe0IZctCeGuckG0wIhqBhWfzbPjEHDwJb1zYPM1tc6Tsxopthr3GpC/vP7rlRoVntHuv4cDlAjSYK39QjgdXud1J94lMYya3iXMIi6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C87jzYaH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F9SEH023300
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 23:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9PBNYpHpthyOUGGJ7lE8j0pFLOw80CFSTRyI4+cBOZM=; b=C87jzYaHFcEngeXk
	fxYpRw2OIm/NLupmcHm+sYVQP5a2BY6WgJjUmOnQhkovGKrW20+HarNM2cmTiMGJ
	3+9kEHp5dfGaPJaLToDTAnyLvuy/l+9rYWSdwuqBlY0xFx5q3tR47eMVJ7d7gnAj
	xO8W5t2/fI4voxjILZ8mwGe8E4/6ppaL8XT4CZT4kQ9PlxLgmMV26Wv8NLACGlT8
	Xqrzzg8OFsl/RSconSY5g7BBqpyWW2qksiLqrI0mE87mm9R9tfGnX6P3hOd/mqCA
	eW/mf3Iew62neu8T0pwryRUHhEuhtgzvPgVJILc298KdFGDm2wHC2u0Y4Lnmr5GL
	MJQlgA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be89nca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 23:00:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2358ddcb1e3so37409635ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 16:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749250821; x=1749855621;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PBNYpHpthyOUGGJ7lE8j0pFLOw80CFSTRyI4+cBOZM=;
        b=MI6RLNGrZsx8azfKFSSg0J6k6yoCMunl8BCb9l0BI8pXDIlTvhVXRgt4xbPFFyl4cC
         dn+GWxApmwGx/01Im/t9FJaQIw6TwVQtJthGIsvrc32nlzFjko+7Z/betX+lH042IG14
         CRc+hI3FIs/CXrgnsFf2a2NNtwYcuk2Tic1fyRZY8+H4e3u7CAwkknT3eUzVXIBOEJ4M
         ua1SdtnuHCV6dmFPJTVqqe0EHLSt6XWQbNW3rs+nO5TBDhhH30LQKsnwQTv8jqYW7jpy
         99LmuZnPwE/Ppa88ih8XMinROqdJPgyUIc9nGqNF8RnYCTS6dXjX4Ibs0r0GJM+FDnKH
         XWYA==
X-Forwarded-Encrypted: i=1; AJvYcCWQmtsYmPNFReHhCdaYGd4l9KNoHFzLEFLcKmFA20E0Vk0IH+4hl3xeIQJVi9VKMUUPf3GgGxWksZMf9Rzm9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YweU66qcl8bko38faznC5AbGGsRs7dLoqZX7O+/iuf9qJu/LUI+
	ZemxkEp3Y4ByJS7WExD2EGsaXmJPPIdFDdlARYhOyjY34IdhU/nd9o5TyNC7cWc+SJRJws7Ryqa
	DHaQcJS/atcKYkm9WPkly1y8zd3Oep+0I4r8ORQ9wZ/X9XYs8Mce5cr6Z8gY/IQ8b8JUnlQ==
X-Gm-Gg: ASbGncvMNqJ7vMTfN+2nehdDTAbu7sf9nldffu6zdvsqsCT6CdwJTkMfYz46TERLntr
	Vsz2jFqPypRVZ+uAenNzlYzxKR8FuVDYh0KbhAd7F1OA4q2W+67XpJA9LwLwjlPEPQQDf6AS62T
	+hkmMz42yNHwGLUtJreA3OceJBYX7sjfcdggkzWMalLHnj9STJj/gwz3/ATdi4DL9/k2VjBcEw+
	4uXkBXvkWg/UZxxy35OD4EJJIJ42TH2P8e8hYFN5RosotJLze0Tn+0Sxmmlnr5tHaQo2CT9P9GQ
	TwFRMWyu/KTXEuBbRxPzR6mMqtL4785p55lZEJlm6WrkSi2fo9tnWPb2h9/bxv0UE2GcE3wcuhX
	hM8OTGST2rE0DjFo=
X-Received: by 2002:a17:903:986:b0:235:ecf2:393 with SMTP id d9443c01a7336-23601da7bfamr70694935ad.53.1749250820993;
        Fri, 06 Jun 2025 16:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEJZ+s/3QhqXDs1c/0gIYCAZvR8FCRt2sIzp2/qhB1y/M0rzJJcy3nU24F4cd7HneWwFuq7A==
X-Received: by 2002:a17:903:986:b0:235:ecf2:393 with SMTP id d9443c01a7336-23601da7bfamr70693935ad.53.1749250819766;
        Fri, 06 Jun 2025 16:00:19 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ee6eb96sm1668224a12.17.2025.06.06.16.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 16:00:19 -0700 (PDT)
Message-ID: <2b56c510-2e49-451d-bb50-d96ce3aacff1@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 16:00:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Johan Hovold <johan@kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org
References: <20250317072036.2066518-1-quic_miaoqing@quicinc.com>
 <20250317072036.2066518-3-quic_miaoqing@quicinc.com>
 <Z907FGWBV_MNlTcE@hovoldconsulting.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <Z907FGWBV_MNlTcE@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=68437305 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8
 a=COk6AnOGAAAA:8 a=zvfRP35NZ5SxQhbWGWEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PmOh_KOLHNFvq5YjoYz70h-ZTFlldvyY
X-Proofpoint-ORIG-GUID: PmOh_KOLHNFvq5YjoYz70h-ZTFlldvyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5MSBTYWx0ZWRfXxvoBjN5CgWKZ
 Zvf/KJVDYx4XHUanzzv7lOjTjoNj/YnNb4o/Kpr/xcEK3ELJ9XfujjsfQYbwnY9ac7Gdbv+mEhr
 KFs/ZB/NrZ8g0gG1g70V+1JSKlJInphnGZI4PKn0ma46kGzPz2HJzscb1JjcB3H/5Joq0hcnsNU
 FOFTGGUCWbn1P8pumW1wJU+JGw3+sIlJDof8Gtc58m+f7y/cIs+V7ynr1qmq7WBgauf1Usc8gbV
 ZFZy7zEMv60zUbi6giZ3Z1l5kbAHDFun6oYdsvHb317OTwsOLwYk57bhLq4GWDLRUTlH2nB/nNQ
 f4KlG84eH0kRhwwXxNRgWt4kyABZT4zK9WeX1Y6QSghBAgS7Ps1WyHYTPttWTn4wLkpRuObQQPk
 /SUR5XLDMOSBQ/akgkviGqIY3RV/f5+VPrRlICiSLda58Da/Y3rCd18h7c9VTZXgsrsRe/e7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060191

On 3/21/2025 3:10 AM, Johan Hovold wrote:
> On Mon, Mar 17, 2025 at 03:20:36PM +0800, Miaoqing Pan wrote:
>> A relatively unusual race condition occurs between host software
>> and hardware, where the host sees the updated destination ring head
>> pointer before the hardware updates the corresponding descriptor.
>> When this situation occurs, the length of the descriptor returns 0.
>>
>> The current error handling method is to increment descriptor tail
>> pointer by 1, but 'sw_index' is not updated, causing descriptor and
>> skb to not correspond one-to-one, resulting in the following error:
>>
>> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
>> ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
>>
>> To address this problem and work around the broken hardware,
>> temporarily skip processing the current descriptor and handle it
>> again next time. Also, skip updating the length field of the
>> descriptor when it is 0, because there's a racing update, may
>> never see the updated length.
>>
>> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>>
>> Reported-by: Johan Hovold <johan+linaro@kernel.org>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> 
> As I've argued elsewhere, I think this should be fixed by adding the
> missing memory barrier which is needed to prevent ordering issues like
> this on aarch64:
> 
> 	https://lore.kernel.org/lkml/Z90yyrZcORhJJgNU@hovoldconsulting.com/
> 
> The fact that this alone does not seem to be sufficient to address the
> issue on qcs615 (and qcs8300) suggests that there are further issues
> with these platforms that need to be properly understood before adding
> workarounds in one place in one driver.
> 
> I've just posted my fix, a version of which users have been running now
> for a week without hitting the corruption (that some used to hit
> multiple times a daily), here:
> 
> 	https://lore.kernel.org/lkml/20250321094916.19098-1-johan+linaro@kernel.org/
> 
>> @@ -387,18 +387,26 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
>>  
>>  	ath11k_hal_srng_access_begin(ab, srng);
>>  
>> -	desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
>> +	desc = ath11k_hal_srng_dst_peek(ab, srng);
>>  	if (!desc) {
>>  		ret = -EIO;
>>  		goto err;
>>  	}
>>  
>>  	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
>> -	if (*nbytes == 0) {
>> +	if (unlikely(*nbytes == 0)) {
>> +		/* A relatively unusual race condition occurs between host
>> +		 * software and hardware, where the host sees the updated
>> +		 * destination ring head pointer before the hardware updates
>> +		 * the corresponding descriptor. Temporarily skip processing
>> +		 * the current descriptor and handle it again next time.
>> +		 */
>>  		ret = -EIO;
>>  		goto err;
> 
> Your tests suggested that you always see the correct length the next
> time you process the ring buffer, but AFAICT that is not guaranteed to
> happen (i.e. if you hit this on the last transfer).

I'm going to mark this as Deferred in patchwork.
Let's have Johan's complete set of barrier changes land both in ath11k and
ath12k, and then re-evaluate the need for your workaround after that.

/jeff

