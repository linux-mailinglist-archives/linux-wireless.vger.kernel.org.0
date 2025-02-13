Return-Path: <linux-wireless+bounces-18886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A9A33692
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 05:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532D0188CA9C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 04:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CE209668;
	Thu, 13 Feb 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKKPEjk3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E30207DE2
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419409; cv=none; b=mhZZblZFpBL35CcHTMvQQ5jkDwkHR59F+se9uyGirBW/7HhPRel7U4ccIl2e/ktEZEz/wl44tKw0Szz6BwLV5uuvJBqBNv1Kaoh/GW49lHtx7T/tYg/oXW8LRAnXH8r4SLZG4OlysWUpz3Gar67rFi2BgrrZxd+rFQzpY60lh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419409; c=relaxed/simple;
	bh=2A5K/wxRshgPQA2xhfzm4SrvzCja8BlkXzsLZ/Cmg5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIXMMi7nQ4iBEZ/f185pGB7xcrxreu2ACzno+tTMB/I89P1tNU4KW2jq1KJUvIfwA6YGr2h3xV08GdqMrSecMNFTgS0vWaqpQ/7Xz5Sfh66tji2KkW+FPgOb3LRyFcGNCysDkG/NPWE/u51Tznkjtl7r3pX+RjljtqgHH0MsZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKKPEjk3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CL8kiv015726
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 04:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DpFojV8qvjKGTMHmuccqiv6sfbfKo8T3UgcGKfeRWYw=; b=kKKPEjk3JyH0A+wt
	bYgR3YB8tfX++DdPjLNGdgm512dNz/nAR7yYYkismprtT/5SUrDWvaD2CnZpfGTl
	OqyHOu3c3wAEYKkti/W0trYzrEa7EUjz71d42axVKBZn8wX1oQCEJY8eegDUWNBb
	5GV4HGRCpHyt6P9cR5IyANSkjj1cbxivbydwmoU5jmD08O9EWpKFGTnDxtlK+9Lf
	oX8tSzQcc8JH0bEUAqXwrb2d69jRQHSTu6Dd8OQA7aqKuhQ+JkHVsN31HgmQaQwm
	7WhwpEDk05Bhduc6BWeBM38lV7N7KSG5aa7pfDc810jWXmzbiUrZh8AGGqulwpY5
	juX5JQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rgpgkteq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 04:03:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f6c90a8ddso13863365ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 20:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739419405; x=1740024205;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpFojV8qvjKGTMHmuccqiv6sfbfKo8T3UgcGKfeRWYw=;
        b=LIZRE82c69M5o4n4I+SHGfGvUlo4kwDESX/7BS84k/IyejxStqhFdVqBQ01p2VDWfR
         4pWP8/svWveM9nooO/qIuYH6CifL5sHPK9kbycbz8XykM3DbOvXLnjFLxGj0e37CaYTl
         hqsiazHah1UsBSeXDgBDTP97RykOa7biH6lzlThvpoKKTjDcZofS0IUlQ7jmFvQOBdKG
         nj75I5QN316lcIjoba9sAvFH3uek3Vifkm0RBAKwfn+lcR01q39YobMwbhIEeCwJAPlK
         hl4aEtTnTpIdGe5jtgJC5N0pdklx3g2k/j/6hNeDdlZKghcT4fRRHP2XUpYuPUifBOju
         A10g==
X-Gm-Message-State: AOJu0YwvCUX/Afb0ETEFjzYHAiZKkZJEv2keY8rCJqi838tM92oz/ytq
	NorvvtGfq0JfRrXPzppIkALbgQ2wDub+/RjYi3W8GZE/q+tr28A2fHUYlENFJ9rGkuZskGUwXAT
	YsaWlrZSm00UoTfWrZzelJMWczXYWRaV4JsZp5+ALKE7TLS/NawXAhewSsjCKuzYVXA==
X-Gm-Gg: ASbGncv/y1k/g2B2gb/VwVtIQeaJyOQ0AjyT5VgNX8PgXudL7hwDUcG56D3ABjOBCTE
	uqR8n7gCUv1d+JQ9GzMrP9JCf7ZFeOHbqwIGB+sDMABb6VYR+GxxAi6TaY4BOYGQFmWK/m19QU/
	YPIj3EIMYkurLkB3ny8AxVnGOssacOmBTbBSHdmmmcL/9K6fT8Bivb71rdKLdQOl9zQJ0KUW/9Y
	qd3YajQNw/rn7kkARZQBsjYhKm7wXXzSlor+qT2rQk/NO97LzSyRl8GTydiQWgLlkWsEFBTAnC9
	qOfF8qSa06/gWnAbtDM5+WtZQOTCLjO9/k08b+Y=
X-Received: by 2002:a05:6a20:cd8f:b0:1dc:790e:3bd0 with SMTP id adf61e73a8af0-1ee6b33e920mr3631943637.15.1739419405485;
        Wed, 12 Feb 2025 20:03:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH80RdQecEYqdXH6ZAQ1iJdmJuvwwgU8GSEsQt9vZpz7RCxE50/YAiWlbAGv60OBfGkMybPlg==
X-Received: by 2002:a05:6a20:cd8f:b0:1dc:790e:3bd0 with SMTP id adf61e73a8af0-1ee6b33e920mr3631909637.15.1739419405135;
        Wed, 12 Feb 2025 20:03:25 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb586186f5sm225806a12.37.2025.02.12.20.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 20:03:24 -0800 (PST)
Message-ID: <78d9cf28-6fb0-44e7-8305-a2dc6b64a121@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 09:33:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>
References: <20250213012439.278373-1-quic_pradeepc@quicinc.com>
 <20250213012439.278373-7-quic_pradeepc@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250213012439.278373-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RD0Q1xRSKNnyO0t8OhrvgjeWMvan0nQI
X-Proofpoint-GUID: RD0Q1xRSKNnyO0t8OhrvgjeWMvan0nQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_01,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=846
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130028

On 2/13/25 06:54, Pradeep Kumar Chitrapu wrote:
> @@ -3690,6 +3859,7 @@ static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
>   
>   	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>   		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
> +		arvif->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
>   		memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
>   		       sizeof(arvif->bitrate_mask.control[i].ht_mcs));
>   		memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,

No need of setting arvif->bitrate_mask.control[i].he_mcs with 0xff ? It 
was there in v9 and this change is not present in version change log 
either.


-- 
Aditya


