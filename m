Return-Path: <linux-wireless+bounces-23185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0CABE0A7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 18:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668FF3A6290
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75726B94E;
	Tue, 20 May 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqROJ4AD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19E264638
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758484; cv=none; b=A7aqSQazPddchNjzIVbkgIdObnuYVijGgaw28tqaIFo3TliBbg+M/1MHn7oAS93VvSZKYjwvLCj4qpUE5gfW0Gri9pfmuwfJWfe+gWf3VML9Y6fuX0hywZw8Hw8GISwGtCU8K3foXTUv5AQwIZUojjYksXkEngdt3PYSe1NY7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758484; c=relaxed/simple;
	bh=zpwGDhz9rNuqBod4PWnCiwUX3N0nb1RnjAyBe0DAPYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLWTuz9bruGTseJn6+q3BejuL1+AYcW8hsGpeBsY9zq3JoO1qqGkhLng/fFCuW5kopV+XRPtbey8mUFZgEcI7+H6hzMsoCn39QRj9KW5d7i8ui0Uwj3eXxfRdh27fH3LBqIp6ygDPA8/1Nk7mpnxrTUZW8IRC8MR4J+IWeRwYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RqROJ4AD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDqhE8014108
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 16:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oWkE6wrfAiys8X9HQrhID/AOg4udR5WQhCtdwknEz8w=; b=RqROJ4ADMDc/egCr
	IWrOEx5RYW4X9XZum8bGzVp0XFdWIMAJrqrEhS4wuCS7wtiV+Ywu9ORD77wPNHjw
	WctM/m+clvQJmLdVjQh715QeiSltWIY22qxmn6WnVNYBD07f2Y1f8qMiqWxGCb/X
	neT9mT+6b27O9fBydUwz8KffzOfNc4lpdDmUD9fdQYwYvy7cJ0fpUs6z/nzg0mlQ
	jJ/L2Aq+rPO72/0Wye5YWvjU+XtEWDFVBT0PL78mrYOcf3KBNo8ky4+H13RbNI2x
	2lxz55GxzLNFkngYlsex/CXMFfHuDBXsYm3mhLZAVWfj6D/x7JZGzjWyZ1RBMk1R
	jJj7Ow==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjnyrd26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 16:28:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22aa75e6653so41372685ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 09:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758480; x=1748363280;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWkE6wrfAiys8X9HQrhID/AOg4udR5WQhCtdwknEz8w=;
        b=os7nZVeDwVPMvYcFtucUrcjgI7TK799QoYleRZ5Od9pWoK4cfz4URfP+xUtLBDpKF/
         kfcjHYhHggAe65SX+l+r9fsFMndx5WY/gf/BzdfnTw/LJwa1axeZFNDOdkkJDhvSSKDw
         dfZ9xQhvzSFRjfOwzi6Tnq5bQMzXdb3p/gdoUGwJQdXkuqBTOOtQCMju0mhjaFr7PFPg
         DrWOGvmmoyvqCJKN2SaPp76UJGnnr0lkU1rtxecWG2oXtdjaJMZGKdzA6mHokbEie+2t
         zhwaKkG1cIF7Hs4bau1uZVyyhXr8Wl73VHG070N5PH26rHEo41M3Hk59L7S9wfOdd7Nv
         nHPQ==
X-Gm-Message-State: AOJu0YwuOsQmGdmop6nI5UGJThjA/rvVBMsU/W5gFEPDaYg8j87XNm+P
	CBVIe5alRc+zIYBIhuILIZZ4i/Nx3HUFKeDQ1M4vShR/cZQl2NIxK522FhwzX3bkD/uFbtVKYje
	W+DYG3BIXIP2UMr+iIr9IxX5be0YHi3/rWcMyps4hLgDobgq4CPT0nw0oMwMIn1pKGwt0+Q==
X-Gm-Gg: ASbGncsYG3r1TyPydG+PU1HEFSROr6DMbS2M81xPOGXVaw84t4Q/Mi+nl42HgtZLhXo
	oLDM8g+WpbvysG2nhvoayxkEHVmpbfojszlzu21MoNLrKdZc3GefZutAwajQqWXab6ll9aVmQMp
	nctLz+qX+4PyBSN0FxkHireOFXG1+gTrgCpA/GBX4TmfNb4TvR2rP8hrjMx/SJBc+pm1+EQ2hXG
	prlIuLb8qDDNxie0L1R1tsVFf9P96ymbJ4UHn2yVGtD7+EZbSAMBXFiJlb0RcgMJ7FfbFDFf242
	Vav4VN2hpkdac/SGFAh7rvAwk0QPisV9r5UqVPbYELZdrAUf3nUSg3FD4J6rF0ZTcJA=
X-Received: by 2002:a17:903:22c8:b0:233:b397:1a38 with SMTP id d9443c01a7336-233b3971a69mr1035275ad.2.1747758479749;
        Tue, 20 May 2025 09:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5eCXMwctL6VYRhnYTfMJUpfPRTT3rczhB1NUrHqOcjFwE3PZOtwEroBxliG5kQjGn1ipa4A==
X-Received: by 2002:a17:903:22c8:b0:233:b397:1a38 with SMTP id d9443c01a7336-233b3971a69mr1034885ad.2.1747758479312;
        Tue, 20 May 2025 09:27:59 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233abb99a06sm3393195ad.254.2025.05.20.09.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 09:27:59 -0700 (PDT)
Message-ID: <748f0908-75e8-4712-86ad-220174c1672a@oss.qualcomm.com>
Date: Tue, 20 May 2025 09:27:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 5/5] wifi: ath12k: Enable IPQ5424 WiFi device
 support
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
References: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
 <20250518-ath12k-ipq5424-v2-5-ef81b833dc97@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250518-ath12k-ipq5424-v2-5-ef81b833dc97@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEzNSBTYWx0ZWRfXxJVwz96bqW48
 jtEWR4J72TVeBnJCO7KhhG6zMpooKzP9Cm7He0lfBDYuTrIczcTkTT/xxm5Y72xAMAB1bb1RtlL
 IvFfIvwtyRDB6D6zxMIlUV54bf0dwAo1z1IK9WLS3kiBIBOtkNynNJCgP8byLAtbchYZt5hpjv8
 ietJFc7lNnqm1JBhB8cMIpgLGp3mehDoJe+aMMYRlkoGHJXYPqdk6H6pW4pvrDzgiu0RnMRvi6L
 NjiyGO9HpLLFk9q5GS5yUqb41EccBCMjfzYOyw+yfh0NaowKuNpnvo5asWJuz2w4uoITpGb8/UB
 W52LbIWGppt6DdnDNewCcorX3cYn1Y2SGSL3t4NNXX9MVmtErtZi2Mb5ypu4GSU1JkP0+hFdvYv
 QkAxUi7S/736Ix4QPbhkOoaPYAd/gN7QoDcYIkJTOm4fdEyLkHUluFJtaU+n4zJzuhpyZ2SV
X-Authority-Analysis: v=2.4 cv=Z9XsHGRA c=1 sm=1 tr=0 ts=682cad91 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=b1i3P6Qac5NO7_78IJgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: G67lNXPsdbJZFAOwqn3QX2bM1Up7EkaD
X-Proofpoint-ORIG-GUID: G67lNXPsdbJZFAOwqn3QX2bM1Up7EkaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200135

On 5/18/2025 11:22 AM, Raj Kumar Bhagat wrote:
> @@ -1008,24 +1011,19 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
>  	if (!ab)
>  		return -ENOMEM;
>  
> -	hw_rev = (enum ath12k_hw_rev)(kernel_ulong_t)of_device_get_match_data(&pdev->dev);
> -	switch (hw_rev) {
> -	case ATH12K_HW_IPQ5332_HW10:
> -		hif_ops = &ath12k_ahb_hif_ops_ipq5332;
> -		userpd_id = ATH12K_IPQ5332_USERPD_ID;
> -		break;
> -	default:
> +	ab_ahb = ath12k_ab_to_ahb(ab);
> +	ab_ahb->ab = ab;
> +	ab_ahb->ahb_data =
> +		(struct ath12k_ahb_probe_data *)of_device_get_match_data(&pdev->dev);

seems like an unnecessary (and incorrect?) typecast
ahb_data is const struct ath12k_ahb_probe_data *
of_device_get_match_data() returns const void *
so the const void * => const struct ath12k_ahb_probe_data *
promotion should happen automatically, without typecasting away the const
qualifier


