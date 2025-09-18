Return-Path: <linux-wireless+bounces-27487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC84B85E91
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8741161D41
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECED313D41;
	Thu, 18 Sep 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWsuGhjA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206623D7E9
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211683; cv=none; b=Swmzwd0NvVBboypZ+lO4+ARZ9e/4+LbEEY6nHys/kBEz8IZBwUPxZPcVDRh9ckd8xm0FFP0qoV+tX+6LFNHgnZolz4bQdfGzNn4B1+vnu//YKWnwhjz728xg+RgBdkgFoHffw7Ox/WQjVBRxv/sWWE1COlPE/DpGhrMFhS04454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211683; c=relaxed/simple;
	bh=3LBAiHgmOEKmh8TVOjpuNesD82rvtwmdFUTaJPqFIBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYUtsq3+g0Z22Y87yiVYeySt1tBPNhRJV7MlGN0W0voV0aDCxQ7jTSD5xJene8xVS8DsFzgK6RQm7jheSunrof5z0DXY/DAUkVeFEAO6h1KHOVxojaR0jMqNHLfZ7fjg705/1VlYI04kvTwuBG8LeFJls/hQN+V14PlY8gqjTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWsuGhjA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IB8TGh032421
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qICgYr9pTII0ek2CGvjEE+bggBezqbDRv5s7Qp5blPE=; b=lWsuGhjAfPcG/dFC
	Y2QGOArgYjmDWw6zhISUE9kj6glVXlRkLr0c2dEETQaj0qomW3jv0q7FWy0wSpe9
	xzTbnxKh/afGiDyXNK6n+08US6G4exQLze3YYujrOy77jJU29WuNyHGCmmNMxht0
	OFgLCZC2oDsp12R8t1aF4gkYITBDAQeXs0hCTJudgdVucamdYQRf2/5sfGTbrzq7
	4rEoQoWCI9ESbDs+95OfVe5ZEV1Ip0jFgoD1wfNrOy/9wWOPoXgrJ/kRHHoDlB5X
	u0iTdscOHdx2WlfPkS7YblTfLoBxejS0rqN0BDqxM4Zb9DFaTK3KFuGuA7kTOXUi
	hMZEZw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyq2ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:08:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77ddaa4caabso519028b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 09:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211680; x=1758816480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qICgYr9pTII0ek2CGvjEE+bggBezqbDRv5s7Qp5blPE=;
        b=ApM7dniT8zIHKej2hXdrcp9ARNBPkg7+q9w+WcqY+DSxYKE/Rx3nnVyh7pGTZuHjWr
         RxAWuBawfbEP0je1nKtfVxpMAhZaqTZt75Ncd716iPjSorS1OGHggUyY6B7E/ZNZ1aoV
         WEOXkF8nio1uftkF4S6gbq1Q8ZtmZ3q0AYjgncA+Hd7PEfjFnOdPBUVTbyUWge6L8x7i
         gMG4FeXmvXCVtyC2HfHE79iS/TR3dmFinOoFz/XOZeiFiOJqWT/hp7os/hA3TapH8BhL
         kJemcUjJ5I2bXDeEsAHHNdfP4BD6BVeslLYb3IdheZdD2uFkWoNb4lSggskvGubAS+BM
         Qiyw==
X-Gm-Message-State: AOJu0YxomTOanZSiSOjfemp94y2rM/eMq3Qv1whxkLaZK0wTEAu1kliG
	JXZGU5cx/Q/SpFt1jkzll+3CbdjtYG0SBkitCoXdLVP5s35puCyKn7jz9803FIBHbBeuM8grwHa
	VX5dYul0EzlZPIWLl1Ur8jAuyHDN/pPBEG24wl7dW3dkx21/pvUtYzlHs62BApgc02uoRUw==
X-Gm-Gg: ASbGncvSJMost6Um1V8TN1IMYNF30bQ7BQ2OD29F87q+XzHxy0+gphpI4V/xBR7EHQd
	MZKa2guMKbUTJo45ju0qGbIQlIaXB/FHzYDx9DMg3nl2iVGZFvdm/FmE5WE4rodFwl18V6snxEj
	olLNQocMolK8WOcJmrw+dyadhs9DBJqzu8xyjnOgvwL+0B75g7kkoljGEU1eEWUsxDXXXAIYNnL
	jNfKX2gwvrbg5S8uRtEw4HXNMvgJEMrDHYAkjU3YyB+HWrIBSCV12Zyz9Yx0vWZzlua1WxHQTNq
	GrBhKdRLKNpG9Ge5qTlo0y2B5H+VbebuTZdPWmpwB34bJexknwXY0V2qm+yHM1exIDz902Ogr4n
	M300BsOxK
X-Received: by 2002:a05:6a00:ad0:b0:778:97e1:f499 with SMTP id d2e1a72fcca58-77bf9c4b95bmr8516637b3a.21.1758211680061;
        Thu, 18 Sep 2025 09:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZc2KMQorqsMojd+psOzChVBBFfgXHMXPd0ZabNoIuhc/lj2qbM9Uj58M/Sr3DdXCoo4dh4A==
X-Received: by 2002:a05:6a00:ad0:b0:778:97e1:f499 with SMTP id d2e1a72fcca58-77bf9c4b95bmr8516591b3a.21.1758211679475;
        Thu, 18 Sep 2025 09:07:59 -0700 (PDT)
Received: from [192.168.11.100] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec403c1sm2705361b3a.83.2025.09.18.09.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:07:58 -0700 (PDT)
Message-ID: <d3f77052-bb4f-4ba4-b165-b672cc67147e@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 21:37:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] wifi: ath11k: fix group data packet drops during
 rekey
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <aLlaetkalDvWcB7b@stanley.mountain>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <aLlaetkalDvWcB7b@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cc2e61 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=b9pLVJSGNDumshOBPLQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: dQAgk5-WGJnFk99rUTp8SfBE80hjUJ7A
X-Proofpoint-ORIG-GUID: dQAgk5-WGJnFk99rUTp8SfBE80hjUJ7A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1jvLJ//PEf/D
 Ep0Zlt03cIlz7b9uNAQx6PLtuQoGFul1+qfYdfEzMPdtSrv5NFHytSmj/m3oheoEgl9y6nvFPHO
 gzZen2PbBAttu5KVsnE0aTvzegpAGqT0ZC+OS+9/sEnOxlU9hCivKSZ6ZJA9kzjCeXvhhNi093t
 jtwl9/kWxdQJkIoJJB/6fU29YOAlVWzgj6YQaEPcyuHiVqS27tS4OXrLiI1woX1r20jUAp2GJE1
 wboW3zVUp1Qpk+f//1MAB5sjcmBYyKKBB7JG1saf2tNQrfh8JSeoGQaojiUTEC17Gvdl6ZzO+7X
 38eW4hpGMVHy6lXJbDhqMpXJvj7aPYhEN8JbctrhhywqwgGW36lIv1S7Yi7KvtfBJB1brZf+vsR
 v/3IQPee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/4/2025 2:53 PM, Dan Carpenter wrote:
> Hello Rameshkumar Sundaram,
> 
> Commit 97acb0259cc9 ("wifi: ath11k: fix group data packet drops
> during rekey") from Aug 10, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/net/wireless/ath/ath11k/mac.c:4459 ath11k_mac_op_set_key()
> 	warn: bitwise AND condition is false here
> 
> drivers/net/wireless/ath/ath11k/mac.c
>      4428
>      4429         /* Allow group key clearing only in AP mode when no stations are
>      4430          * associated. There is a known race condition in firmware where
>      4431          * group addressed packets may be dropped if the key is cleared
>      4432          * and immediately set again during rekey.
>      4433          *
>      4434          * During GTK rekey, mac80211 issues a clear key (if the old key
>      4435          * exists) followed by an install key operation for same key
>      4436          * index. This causes ath11k to send two WMI commands in quick
>      4437          * succession: one to clear the old key and another to install the
>      4438          * new key in the same slot.
>      4439          *
>      4440          * Under certain conditions—especially under high load or time
>      4441          * sensitive scenarios, firmware may process these commands
>      4442          * asynchronously in a way that firmware assumes the key is
>      4443          * cleared whereas hardware has a valid key. This inconsistency
>      4444          * between hardware and firmware leads to group addressed packet
>      4445          * drops after rekey.
>      4446          * Only setting the same key again can restore a valid key in
>      4447          * firmware and allow packets to be transmitted.
>      4448          *
>      4449          * There is a use case where an AP can transition from Secure mode
>      4450          * to open mode without a vdev restart by just deleting all
>      4451          * associated peers and clearing key, Hence allow clear key for
>      4452          * that case alone. Mark arvif->reinstall_group_keys in such cases
>      4453          * and reinstall the same key when the first peer is added,
>      4454          * allowing firmware to recover from the race if it had occurred.
>      4455          */
>      4456
>      4457         is_ap_with_no_sta = (vif->type == NL80211_IFTYPE_AP &&
>      4458                              !arvif->num_stations);
> --> 4459         if ((flags & WMI_KEY_PAIRWISE) || cmd == SET_KEY || is_ap_with_no_sta) {
>                                ^^^^^^^^^^^^^^^^
> WMI_KEY_PAIRWISE is zero so this is false.
> 
> I should probably write a static checker warning for code that does:
> 
> 	flags |= WMI_KEY_PAIRWISE;
> 

Thanks for reporting this, will send a patch to fix the if() as well as 
remove the code that does |= WMI_KEY_PAIRWISE.


>      4460                 ret = ath11k_install_key(arvif, key, cmd, peer_addr, flags);
>      4461                 if (ret) {
>      4462                         ath11k_warn(ab, "ath11k_install_key failed (%d)\n", ret);
> 
> regards,
> dan carpenter


--
Ramesh


