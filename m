Return-Path: <linux-wireless+bounces-28114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49C2BF31DD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF8F405A75
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EB3244687;
	Mon, 20 Oct 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bxxTWAlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A51E511
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987419; cv=none; b=FT6G1AyPO5C6eKLO7oobKYJk3edfNtg1wv897ZJ9Q++brBSozSgItc0zM6U0xIcQLSiY5rYTLKRYZlN46B4R7TwBL+rTENdw+J5bul1M6Vn/5b2F5gdxCOpevgbyxDyeH6bYr31g13eLbKxyBL1aZa3FtBLnnCMUWmsImDuJHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987419; c=relaxed/simple;
	bh=yzMuFEKLkLg4cUyPzJ8L8XlJRjRXyriI3UI6ZizNKkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jw67a7Sncqq9Eed+oJpOpPHtSMlkX7X80YfVSAhm4i0DTGbKgUeD58jkDu1RdjX43tTTnAGpXnCVEK3TOk1oP1JYkIDyvJy03/zjYAR/T3jm3QTk7PdAJbD9kGKPTRCKiVmlLB6l2suoXfO02J9ocRRGY2MFH/82mr1cXEuKmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bxxTWAlG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KIxCYQ013063
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 19:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yzMuFEKLkLg4cUyPzJ8L8XlJRjRXyriI3UI6ZizNKkU=; b=bxxTWAlGFb+c3Odr
	5HAbLzMyAEILhm9zTyaUNFHHIH724DRNWdL/Gjpb7fYaHG6CwhEb1waxwY1gMA7L
	Yr5ZxZ+AydKHeOgprBSVj4iNkR/Hb61C0plNU+c01d26Q5ZhCyJiALNg2bU3yhad
	LZY99F30r+zuKaR8Er1QfuzhLHeiNtOow4/6isXxa8tT5ZgvXqRDRVWy5hEznBVu
	AU/3+kPGN6mZW3+PpDa+K+Lt6mooIVma7+Xks8ZXEtLLM3YMtm37qzqa6m8cWvwz
	hmoFbJ/Tu7/Ldt/oM8I19lG6Tquhk4zbdYYm45+XB42Sd1O/HeeQRAXVBxTvu3Mg
	HXdPJw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtger2qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 19:10:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so8383760a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 12:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987411; x=1761592211;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzMuFEKLkLg4cUyPzJ8L8XlJRjRXyriI3UI6ZizNKkU=;
        b=HuzsKZTdUN5zfxXvaByGbhH2vzzc1pc9UaaC3Fbh4+aq5x9eJuHvmVyYIM7et150cm
         vVAvsiecuIAm9tsvkkZKJgzvaWtreTfUjOQgmvTDp3D0fWVwR6muOziaj4U/IQekOZ42
         cfpypP0BbpT9HF3opfeV1Wac/jgd/1ZJ5kzk1hx51tUmH9yP4zj9+Q5tHLrosSx2HdVa
         NE0OB6QfNB6pyxKqZRgsFRQX6MPj2kH3UsduzCKXNVsBApRCdBXcL9PchnlA9CJrIN+h
         9mey30ZL3aPtvokQvzGhk/YLWMhZ6iag3CouZcZvLjhmYW6SMNprt1xkjWcR5aZlC7jL
         5uBg==
X-Forwarded-Encrypted: i=1; AJvYcCWYPn84Z8+EDQd0ngJbIiDho7AxaUCkgjMrhQBp6EMfRzl/XQafoVp/iAEbWB4gEGxDdp9re2c2B3zGYTpeUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/W1wlxd0Yf544s1CSW2AhQaRuoTdq1A6R+fobA+iTkL5peYiW
	DK400X0dUsYAGPLN/3Iw9yVTihKVdvM4BOyWqAoCUhfJa7wuy3EibxI0LXFPQ42WOhiAXwmHWVV
	em78h9OKrPQpv4/mOmreo3nKMzeSTDCUJBklojFSEnP55oo0MyuiDHC2TRxgj7OQu2vp5lgAYdL
	rhmQ==
X-Gm-Gg: ASbGncvIx6tvtwIcuav0JxqPATSNuwg3IRZyUxbE2lIQdOT9KS3AyWReuso14Hi2NNB
	q0PTHFlLnsPAlXjxiMu1ul6PtYcxMcuKlcU3F2yBzliIOfiPpOjZVTOT4c457kkfBpIBHPDPadQ
	jofyEfOIILxsh2JJieuDnLFJzig7NRTz1QmJKxBxs8Z7QMDPjShlJBtMNy2k/r/uLBvnbLvs9Rw
	XlcffGV8hNEv8tAuQs7CFBz5jueqnhDA+LttdJ/SxAffEoXH8sFEfJwmfhvBMGbzDRcw2yKfpub
	zzWwf3K44DOlOQUCUKjqlXEfXSHKR7x6ZmLhOv8Quj+KFAqn+Gq3fdVGhBFHjnt1PXjnZLrR7AP
	uuLHPIsDI2pLm0+DOi1bVWqLaxTKr/w138vCUj/sHzkHfcncEl/5DiV5LVmoL1Buzp/Qalag=
X-Received: by 2002:a05:6a20:42a3:b0:334:a82b:97d0 with SMTP id adf61e73a8af0-334a84cf411mr17501123637.22.1760987411137;
        Mon, 20 Oct 2025 12:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt/NPam4b5rrf4LmdQPIY4ADl573FSqQwAJ016hQUWxp2uqRMDdylgVudT1VdQyOPbZPC0nQ==
X-Received: by 2002:a05:6a20:42a3:b0:334:a82b:97d0 with SMTP id adf61e73a8af0-334a84cf411mr17501091637.22.1760987410686;
        Mon, 20 Oct 2025 12:10:10 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664a462sm8777498a12.8.2025.10.20.12.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:10:10 -0700 (PDT)
Message-ID: <5e0b80b9-8cd9-4e5d-a5c0-7fbea8325855@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 12:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: Support for FTM TLV test commands
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20251020153759.407516-1-loic.poulain@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251020153759.407516-1-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5Jd72dY29vKWYKCyGKyqJGz2luAutInO
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f68918 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Oq1PXzKV_Ju3vwlGj5AA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 5Jd72dY29vKWYKCyGKyqJGz2luAutInO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfX2SZNAdXCZJL4
 V4Icaxv6My0QaPb1YBLOYnq6ggdEohCRPNV9LVxSeVonv/GiwHTwiglDleNHetehruZoGHKELBv
 D0VWH45yxNq+WWSS7ixwBQ53Mdh2ggzzWup1BdOi3rzmCKhoXGCXau2mj8ijJGo73nRRULSG7k6
 bppfzRQYQUt4SeaGjnIUFZnYkz7/+qJF9csZm9PSqxFl/wogcGwekA2dziV2qx2VQSsEbeP/sIs
 ZgPlGIsfJ7rQzr/zEfNb+/n1wZ9P4/9ZluzXObGHTLwFFMhUGlJewY5+H4l77JqKz+87AIN3689
 fF8GTuuksJOSliDC+HAR7FW1Fz8gOTaVXwV4sl/LkGIyDYAQA9mdL5hulrTXPqz4MWZDYyKeYKn
 hxvaQjuqE3v07GU1fQ0B1wLgs34b7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154

On 10/20/2025 8:37 AM, Loic Poulain wrote:
...
> +static void ath10k_tm_event_unsegmented(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)

i'm going to split this line to address the ath10k-check issue:
drivers/net/wireless/ath/ath10k/testmode.c:34: line length of 91 exceeds 90 columns

(for now ath10k/ath11k/ath12k prefer to not exceed 90 columns)

/jeff

