Return-Path: <linux-wireless+bounces-17619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB50A1498B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF95F3A1436
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 06:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE317555;
	Fri, 17 Jan 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pIwSg1KQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6B25A63A
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094324; cv=none; b=qL4cVY9lBY0LwPQuFZ1dGvBIwIDRAPmwVwCEFMjZhKI0wWHZK/t32KSsnnBX7yyepWQ6J0qcctb9zcUFlGN8MUrXbS+okAmvuM8zfiN9VhLFcHY28ir0f+eAp0AAH5S8lLg9K8wi2F+27+IOx/RXvlnSLUIj9h+90fyHUHexnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094324; c=relaxed/simple;
	bh=AbALSiqKAUOm2Tio8EnSj58rt3+Oq5zXBv+Sum2fBlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqKqNdyWoaTZb9WRQqnnmtHaHTIKCgfEKiw+TYh2x/A2Lz3+e3i645WZvAa0R2tC8YmnfqEfwzTl3ubjQq32aQ6EgpVETsVGqKj9jiSkyROPuE9D/F0kTR1FClawmwTGqf4jClRqplxWuxMgMXra/7R5SIM7FoNc4w5i+5GYHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pIwSg1KQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H66JjJ009450
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 06:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYPUPqaJRcCOk9BPdZFDHe4BhlHw0QIEMvPp1Iy0zxs=; b=pIwSg1KQyXjhFNFM
	zGgUDrhbYoy54mMLZ6UeAR8soTi+wf+YgJONv5NBXGWuVdffZ8OQTMFLojiv6qiI
	nXtWHmnWdnbPDwDJh1aIdt0KLwtEkFtEAQHhsEU1brHxwxVmU2Umv1gpplEmfE7q
	UdTW6QrT0AB7CdGwp75rWsb2cbSpFDrwrUGgCs5Qz5Otpz9vlr52QiGkFqgcR6mW
	KX51XtNBJwsd280XFKDD51MQAEZTfHIrFVf+UQvC+K+w3zhgj2+JOhEYFoflgZj5
	+M5ijXe99pDnLPsQMPlajnpd6Pow2bMVWbVHB0Kzhcsw+0wx9RPr0vt+GbnpBIO9
	GKfxYg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447hmt80fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 06:12:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21631cbf87dso34754245ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 22:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737094320; x=1737699120;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYPUPqaJRcCOk9BPdZFDHe4BhlHw0QIEMvPp1Iy0zxs=;
        b=vVPfdkgI0BChTRMAZPGe0c1OJUsTWDDJtHPX5T7gyE+wMjOH3vdxfR3un/vTrROH01
         ocnwgcn1cbaQudNPVIH4FmqRx2uMMuVO13S5i7WVTvXDbaqH7yZZ8UVd/WgvfiVjWwwf
         nXze/BjRY6KhUpxTSSMw94iY3jwOkxeofyoJhO7vexLJ50zAhImjF2I2JkPGMIPPB3vf
         Q9AG/uC9cPCJQZk8iK9PpjMB1+BHZv8621vOk+0tCGW1S6WjJOfeEAZSnB7I/dICbQKK
         If/QYCFsZUlvAo9L4niurgcqeR7h115k/IpRC9KdcfJPmEMxgsX577xHK5fZSreGy6gf
         9nUA==
X-Gm-Message-State: AOJu0YwqjjVv5IdarpH5u0qSQ1iF9LK7hulHniDnVH1l74pPLZedcNXf
	P1FjspZncH1MTJTnzMKIPB0FggFtaSoWCwpLIQOGP9W947m5wZEGJQJmr9XAiRYRlEYX1Bhn+Ob
	zlFqED20CbRFPjBwSRjo6+wHZ5GykbdyULDyhqbRVwlWYEx+mSGiaW2kDkvYM3o4c6A==
X-Gm-Gg: ASbGnctnlzkz1jgkC2uOte/JfeEh0xIhypcHo8gA54OHG2uDfug6SXatepnFAFwzbBV
	DzeAhtxQb5oarcE2Z2gjKMM3H47LozkSJwPWMo3KBn3HWxsO8MNlBl/MWIeYzUX+34sxBzSygIY
	2jxFt3/Pmc2Vvw3PFMX/gmfw6eERKBURjRhEONk1iNHvq8A01W9CKyCB9ai0y6wa7hsq45xj1EU
	ceNk4ztrOltJt84c0NQ/lxsFn6fFRHMPkf3ovTmAJi4UbMw62xQm/AmKs2Iognm90UlzWeQ74xs
	vXaHl9V1DybtIA7HUriQHZyrsWJvIqmCkEaZVEHl11r3QchmJw==
X-Received: by 2002:a17:902:ce8a:b0:216:32c4:f7f5 with SMTP id d9443c01a7336-21c3540c7a1mr21616835ad.19.1737094320207;
        Thu, 16 Jan 2025 22:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6THMfsJV7Tr0yKtiPhUtWA9Imk4nfvSHz4xHNjVLXrDOMH89qwC/tWjQdrggsuZ1xV6U69g==
X-Received: by 2002:a17:902:ce8a:b0:216:32c4:f7f5 with SMTP id d9443c01a7336-21c3540c7a1mr21616575ad.19.1737094319798;
        Thu, 16 Jan 2025 22:11:59 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba64fsm9046125ad.100.2025.01.16.22.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 22:11:59 -0800 (PST)
Message-ID: <c58a6a28-7a33-4f45-8e19-df94be29bfe4@oss.qualcomm.com>
Date: Thu, 16 Jan 2025 22:11:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] wifi: cfg80211/mac80211: Set/get wiphy parameters
 on per-radio basis
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250107182506.1838704-1-quic_ramess@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250107182506.1838704-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EIA2nCyqYWOsdjpENoUofrtQg96wfWk9
X-Proofpoint-ORIG-GUID: EIA2nCyqYWOsdjpENoUofrtQg96wfWk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_02,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170047

On 1/7/2025 10:25 AM, Rameshkumar Sundaram wrote:
> Currently wiphy level configurations like RTS threshold, TX power etc.
> lacks radio level get/set support and same value is applied to all radios
> of wiphy. Add support to parse radio id attribute and use the same to
> apply the configuration to corresponding radio of a multi radio wiphy.
> 
> This design will not disturb the global wiphy configuration. If radio id is
> not passed from userspace, then the existing design of setting attribute to
> all the radios will hold good.
> Also add support to get the radio specific attributes in a multi-radio
> wiphy from userspace.
> 
> Note:
> This is design proposal to extend support to set RTS threshold/tx power for
> each radio and get the same from the userspace and hence sent as RFC.
> If we agree on this design, all per-radio attributes supported in wiphy
> can follow this design to modify attributes for a specific radio without
> disturbing other radios in the wiphy.
> 
> The attributes that can be handled for each radio are:
> NL80211_ATTR_WIPHY_FREQ
> NL80211_ATTR_WIPHY_ANTENNA_TX
> NL80211_ATTR_WIPHY_ANTENNA_RX
> NL80211_ATTR_WIPHY_RETRY_SHORT
> NL80211_ATTR_WIPHY_RETRY_LONG
> NL80211_ATTR_WIPHY_FRAG_THRESHOLD
> NL80211_ATTR_WIPHY_RTS_THRESHOLD
> NL80211_ATTR_WIPHY_COVERAGE_CLASS
> NL80211_ATTR_WIPHY_DYN_AC
> 
> With this design, the new userspace designed to set/get per-radio
> parameters can work with both traditional and multi-radio wiphys.
> 
> An alternate design is to allow multiple radios to be configured with
> different per-radio attributes in a single command. To achieve this,
> a new nested attribute can be added to hold all per-radio attributes
> for all the radios in multi-radio wiphy. The attributes and respective
> values passed from userspace (say iw) can be parsed in NL80211 and for
> each attribute, corresponding handlers can be called in iteration for
> each radio. This design will require adding an attribute indicating index
> of the radio along with the nested attribute to circle down the radio of
> interest.

Just pinging the community to see if there are any comments on this RFC,
especially since there are two different designs proposed so some guidance on
the preferred design would be appreciated.

Should we post a [PATCH] of the first design where the core wireless portion
is already implemented?

/jeff

