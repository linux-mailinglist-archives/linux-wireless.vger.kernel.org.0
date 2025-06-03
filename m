Return-Path: <linux-wireless+bounces-23582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A3FACD038
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985173A797D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 23:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF0C24DCFB;
	Tue,  3 Jun 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cReK5JVJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21417238C06
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992842; cv=none; b=Bc4Dj1+N5SunJlMBMJnJLKBFWSa1kFwRBvSvfV8ihKrmWU49Ts+Jnq/TMx4TZhfSqsVkZBEawt57gy7hOtrzOqLm8CIEqxNpdhJ90gGAyaZqBvk5Yfz6Gt0NVLhXE7fN7pv/iZA6uxnrFphqlGK+9Zg+XZsI7Ovxg4ZN6kQ1q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992842; c=relaxed/simple;
	bh=OyF1baAQIwpiGTzqAMSLhSTQmTNIIolPN9GPrsjq0+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxOvN6IO3PMLy7JdgtXILhS/UKqUUw9iOF16x0gPZevwHm27fXc6ijrae/jxxPZXQWVBRREkHSR7ICUlJsmn4uwA64oe7kZp0+pkN/fmumIHPtBy8L8K/cgxJA2VlfBavy5skIaKJkZGV0qmE/wKIYdrnR9MyH9DZ6G4GKxQ9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cReK5JVJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553JnB0q010372
	for <linux-wireless@vger.kernel.org>; Tue, 3 Jun 2025 23:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/vC8D0+Kj4sSwmy4nTAOX+3nnZ5SU4Z2YYaYDBCex6U=; b=cReK5JVJjhbm+tAC
	0WDDu4cYn0Ts+Wc4KrEW2ISlMi/4FIfTHHj/SL0v1adh5hdnOUQd8xo3hMZm0w32
	u8pTUYNI8/O6t+8mpGWRCgoteiVi7Znv7DmeGc62U1odwt7PmlYUu4EVbz3+qsI2
	d8Sk8NP0LnZZrVNQxoIgOJpcA3OBOHUxxHlWqlPM3wrSjFFfUYWvkrn2QXSFv7q7
	BAsCouQlzajrrWkbJC58A2IG+LkWE/GJh3Mb05TJS5wOyeGhWLlNVf5LGn/diJ5r
	48MNuXAS5Z+83mkTY+tpb2Xsx/EpRPzB2hA+Fw9foE8K4CrA0OYZbkZJdCi2ii8V
	qmtmLw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ym44m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 23:20:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23228c09e14so82470875ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 16:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748992837; x=1749597637;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vC8D0+Kj4sSwmy4nTAOX+3nnZ5SU4Z2YYaYDBCex6U=;
        b=bU5Jv8Bdud4K4BgU3RDFaCR24/zqpIyMATZ9OcOkQpgIR5jUJgDjSdo8XHKkit59Bb
         d+6laOJEMfWoOCgM9ffcjlikcAyx+YQC0GXVQc9GQWZRmWJVsdDKknfPOZfMkRs4Nysq
         ax76gznvOinIpfAO4SKqz0UZ06Yos47I9oLPacYTkmnJrDuuP/GcOuJYyCGtL2CjquDE
         UZy4IThRz++PIc2pxHUdagDQyH+ib8oLkL2mlFm+FOfGFeQUpy4bVMj03BaukoRwgHjR
         RwludFB5LWqmhCrdY1/QOmZJHRMlN8UT750a0NHYIHdmka/1TjZIQefGfnHjzyH5AK3U
         P9JQ==
X-Gm-Message-State: AOJu0YzU+OhZY0uKDHd9yyA1FQKnmfD+PFql+OTav+tfLzqGAW+7Y/VH
	cC42x/hm3hVmG606I5JY9tqXgZWyX7ol07JqYB5CyKBvixC9p5n7ZMxGv6nuX1O1+mknOb/bn/h
	2tMJewfsIwNVFadoASrfTHlr+CdsRKBxf8hxVNyeBPYYqnsuCGqxl2jNbxRY06/zSaIZWPw==
X-Gm-Gg: ASbGnctooHa7xVNhoHtjMNIqH1BWfOlr7FrpoqaqXZiFvE8oO2MMRmaJtkxB8eiN7jq
	JtnPY5fnXWv2KZUUFMs0wphJXqXFzMhXVy6lJnYoMBhv7tObTjxLnUT1FN8++1X/mNBpcshSv3y
	WXOu3FGhSMsJGm9Egsa07yBaYigL2B5aW9CPVQPPJ1Nan5pgYAsqEwhZxwrgdvBnofTtlwmHADv
	w02UcQdL0LsnqO5dIlnqisWDKel7PgToVVOir7lpsHqapr9oPJW9S27kD1gCE2pKDmxuIVt8338
	AjmEnaCplshkAg3NO3zCgYmeoMwbZhwZdCOYwc85HMgbeoXMbixviexg+P4JsaxR450HB6faYqn
	G0Rh/N4Dvb1ofKFk=
X-Received: by 2002:a17:902:dac6:b0:234:d7b2:2aab with SMTP id d9443c01a7336-235e11c0314mr7729035ad.14.1748992837238;
        Tue, 03 Jun 2025 16:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvZE5Q03u7FYFP6DR3K7O9QxJPbPAunMPtwL3P7zckuubV68DFLTnKndy+fSYrjZjFfjekJg==
X-Received: by 2002:a17:902:dac6:b0:234:d7b2:2aab with SMTP id d9443c01a7336-235e11c0314mr7728755ad.14.1748992836834;
        Tue, 03 Jun 2025 16:20:36 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf47c0sm92280135ad.175.2025.06.03.16.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 16:20:36 -0700 (PDT)
Message-ID: <ea4ac3d8-b467-49fc-8bcf-d4719d7312ad@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 16:20:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] wifi: ath11k: move some firmware stats related
 functions outside of debugfs
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250220082448.31039-1-quic_bqiang@quicinc.com>
 <20250220082448.31039-5-quic_bqiang@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250220082448.31039-5-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDIwMCBTYWx0ZWRfX8rO1ozzyJ1xX
 QVnud8UFWG9fdg5FmpH0hA/pDQzjUl9BA3qBH8o5x14VfWyyiYEYuBZgd8t3OtBj2DE38KE4rHH
 yCBaQn3yEdHpxP9iYpXIdNc04neIEOWZUljwqMnCWfsPdJmvKpNA0j4p/nmzUJS03MvbK2HMRgU
 QUf8e0o4eetCPsb4vbenyIF6IdGIxa24NB6jv94gVTzI6o6oRUWo08D+1H5iUKCirIplBMfEopK
 6VVjd9An95uoLq1i4g+q3B2o2B8osA0ZdOnSCzPtxodWVccF/qg7uh8k5rB7Gv/+1/N2MItvk1X
 yqKX0AwVH7JUxEXpzoV1fWoc03bbT33479J535oCD0N8ikPmEYRAcbpXfLz6auicYc+JU+CkDEc
 zF/uER4Dk5YwANc5diXbkHxmBW627saJZxymo+9cv4HNjHdGAkPAvmrk/GdBizI106jfV1jy
X-Proofpoint-ORIG-GUID: jIyJ8eBPzjRJC2KC91_wUvPd9IrwulXE
X-Proofpoint-GUID: jIyJ8eBPzjRJC2KC91_wUvPd9IrwulXE
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=683f8346 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=Ub6YIYI0a6To4LV50ygA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030200

On 2/20/2025 12:24 AM, Baochen Qiang wrote:
> Commit b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
> and commit c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")
> call debugfs functions in mac ops. Those functions are no-ops if CONFIG_ATH11K_DEBUGFS is
> not enabled, thus cause wrong status reported.
> 
> Move them to mac.c.
> 
> Besides, since WMI_REQUEST_RSSI_PER_CHAIN_STAT and WMI_REQUEST_VDEV_STAT stats could also
> be requested via mac ops, process them directly in ath11k_update_stats_event().
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> 
> Fixes: b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
> Fixes: c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")
> 

if there are no other comments, i'll remove this blank like when I merge to
'pending'


> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

