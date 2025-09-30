Return-Path: <linux-wireless+bounces-27726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FCBAB758
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 07:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75838189B8A1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 05:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56A19F43A;
	Tue, 30 Sep 2025 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9fJ0gkq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97779F2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759209397; cv=none; b=oOaL2TpA6XWI0VUG+ZxElT+590SIvkc2Q0X+Wt5ZMLdh0bjKxR5q4E3+FmwRhiSBtV69rh5cIcy3dVERZGLRGmbhvgwmzLOnpTa2Jq2Pbdc57erHFYzX33ZFHAzdlpJysuKQYeLcwclYwavi/zF551LxvfZwPw/6bdr3vRgChcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759209397; c=relaxed/simple;
	bh=QiTuFF2+CqAIylfUtn71ndfRen2yA3BFUK0SGFhyvx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smBERtmQEew9R383j7KHyhHm32nCypzHBlbSBME+mUzRJiTV9UFbSZZMeYIXA/Pfy24w+SinDESHKC2m2itoyKHwyh0lsXxjgqJTH7QlUIQaQGJaglRdBJYqFVxyaBNbldFxolRJkpivbU/TKqBrYPUCs3Si4QqE1gDnfjDHeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9fJ0gkq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HO7a014790
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 05:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H02vmDbMMdEjOybcZvmm/GRKXq+gslFZMruW6xhFCYw=; b=E9fJ0gkqmULGu6r6
	JNh2xAYq8riuWdIMQ1ZHtgbxktQ2TmYvn20fwTS3yE7n3xV2UOYYkah8jIb5Hywn
	4nbIqkPmzMILGvYO+2nGelL9v6EjTjK0YoWggF4dxIlQRSn2AY/BezvVD3+fhDug
	UwClFfQ2kpCPcciG0d2MyrpE+Y43nHHNGSnR6M8uhzT0wf9Q1ijt4kyw9KFeMb0q
	goJMdq9SgvAmsTtg8szSLSQifTBYEzUT/cZzOvGvWBvTvTl7o7TJcGwCDcsGeuf9
	YoAJgLjKM99NvJUebsp98rVWTogoK6sTZbN0/LISXdkgOzo9UC5ZKORBpsHU9nLM
	vLLEqw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqyqnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 05:16:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27ee41e062cso51103695ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 22:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759209394; x=1759814194;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H02vmDbMMdEjOybcZvmm/GRKXq+gslFZMruW6xhFCYw=;
        b=bs1zQ02eTriobeuyNxTvliAKARAWdmpbUOg7JJrw0B3OEzgbiBXofVPcFhcycY18ct
         bZ1dxs30FzbJnXHapdtIGu8g2lZSqbE9ogYAodwgqfvsyIoCx+msX2mLRfrZe5KLcnRu
         EB+9pPY0fhy9338MZwHuw3Oi52vxbqCtvBR/r6jeR0Y1NihdKeuBcIsXSTllT2/ohXFM
         gnOMlS6I0pVinxvTqrJaSdPVAYMWDWlTreK76bVRfpvht364OW/UhjEYbLhMGk88dahN
         xR7Dpkr5JbsBnr47c1cEToQ6ufo+VwflakuF+GyscrGp+d+gQgDjPjAJYVX7PGup1SIl
         qv/A==
X-Gm-Message-State: AOJu0Yx6aqiCIW4ie8Q/QQckCCV6UiHe19KRLQJVjXOKcrrXfWMBSF32
	G0896Gfpf7o8bx9kqGUt2djz/gl9lvQS1k0Xyx8bvvfiytjDA9iZjQHvIl0+XEIfUyJT2SPMqmF
	MopXHIUrAVdFNaLbtIqrEyCoJtgIqUxub2JjH/6gFSzx45sVdTg44fovSlfcQe5myWRShug==
X-Gm-Gg: ASbGncumZxo9iKFZFqy5NZuP3+VsED+j4E+zZB9gwU1bV0rhg4/4fRXjVJ9igk+Sw/r
	kO2bB0u2RBS2CTUcHhgzZZKwXAIQO0y8DvQFQAVo9qCfG4MpMGVwsfUdw4/jphAefKvMayORFJt
	M/UNnqemZXSRXq9oEM+LJNSv7wHtS3FGdz4R7N71oysEOvMCGOcw6tuTwTQU+QBDm5yXWzylKFq
	FPjN6+gU6yD31TdMxmeDkG+hUj2tN+la+LqfpoFa+DgcnGhY9DkBKpSXMm2ekcOREgt/S0UjnPB
	otmP7qj6zPlB6VKnV9xjz66A5qL1J2MUO2mZvyE78rlG14x4ydw76n/KrFdvrASZ2oOCyN3odqs
	R+UxG3KBl9Jw6A2qgnc1mxtWjS1Yb/4UrKhEFL6/+os0=
X-Received: by 2002:a17:903:3d06:b0:269:8f2d:5221 with SMTP id d9443c01a7336-27ed49b30cbmr197691485ad.9.1759209393653;
        Mon, 29 Sep 2025 22:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElVv7EYDT7b5Mi2v0IfgJsNyuquhPIoQt8a4oukRcnZZVOR8JHadilEM1KzwuxceOirc0osw==
X-Received: by 2002:a17:903:3d06:b0:269:8f2d:5221 with SMTP id d9443c01a7336-27ed49b30cbmr197691065ad.9.1759209392942;
        Mon, 29 Sep 2025 22:16:32 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821d3sm148402325ad.83.2025.09.29.22.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 22:16:32 -0700 (PDT)
Message-ID: <3033dd6a-8eba-4ff7-9ef3-b311b64e3d6d@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 13:16:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath10k: Fix memory leak on
 unsupported WMI command
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org,
        kvalo@qca.qualcomm.com
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250926195656.187970-1-loic.poulain@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250926195656.187970-1-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: w7nEemWs5hn_56UyZb7k2NM2beMrdOBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX29gm8w2FvOHx
 ynEw6cLneTT1VNF0/1FBkiVgrYNs1cksA/M81O+b84rb0mdQJRG9Dv9E/Bn9LeFC4CTykQbkwf3
 C8TsIzTEz0O6RSQ0NBDmlXMp2GtPSCO1N6yz75ZzpL/ZB6uws2lj4tYErvTy1LdcI5RGMtfh7i2
 9kWhA0Gsf2n7oLPf+uOoLstb0IWR+YFlv8Loh6XAhgrgiexNykmuL/ULkpokZ2W1K2b8OiGO3P5
 f5yWx4vt2o7wqMe70IsQ7U0B9T0Ov48tn1m9svSESpvxgy4flMTC7uwFnk+IY8uxUfSxr7punD2
 L2b1QudkEj/stKdUgg67D2a6Cu43pwBX25CMKSWBtnq8qu4ufNN+3kZ1awUhSAFp3sRgV//ZRep
 72fr1TDaz1RQm+6ILEj+6sAsB7zMxQ==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db67b2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-TLifRbWatlCRcOkvmUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: w7nEemWs5hn_56UyZb7k2NM2beMrdOBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/27/2025 3:56 AM, Loic Poulain wrote:
> ath10k_wmi_cmd_send takes ownership of the passed buffer (skb) and has the
> responsibility to release it in case of error. This patch fixes missing
> free in case of early error due to unhandled WMI command ID.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> 
> Fixes: 553215592f14 ("ath10k: warn if give WMI command is not supported")
> Suggested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

> ---
>  v2: Fix typo in commit message (s/responsabily/responsibility)
> 
>  drivers/net/wireless/ath/ath10k/wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index cb8ae751eb31..b4aad6604d6d 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -1938,6 +1938,7 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
>  	if (cmd_id == WMI_CMD_UNSUPPORTED) {
>  		ath10k_warn(ar, "wmi command %d is not supported by firmware\n",
>  			    cmd_id);
> +		dev_kfree_skb_any(skb);
>  		return ret;
>  	}
>  


