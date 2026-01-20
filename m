Return-Path: <linux-wireless+bounces-30983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BCD3BD66
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 03:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A301E300E075
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 02:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FD824BD;
	Tue, 20 Jan 2026 02:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brFy5M7P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bcc3zHUG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED521CAA68
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874493; cv=none; b=NRO0j/3jq5WIUfSB8IEHei3rp/5a5aJbibXpklKOwH1gI8e08FpiATPs9/GI64mWNLrzywtEOdte+1uOTkVoTm9bCalaolffhBG6xEe711whDGbPn5O8Pwg+urcdpTZUwXi/wWx40616zRBGirPB/y/USgZYnzvocmyM3pK2Wx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874493; c=relaxed/simple;
	bh=c4tKnUXW8/gdBDJBTzHvP0y+UJCa3pBNhpIlf+hWw44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcPqLlcC79uHxsfXo0G6zQ30jvsNQFjUmDWTya+gXYIWajP9uVUrOdc0vOrdqoXb8TkTi0OTSmoo3tQ/yOTXwaEl5+WY13JnLbLocAReuxhYKJP/55QAIQpa6F7yM5GzXDTZuvwjul0zpeOFl8sdyjG4MH8ncygGNdAEU3nJoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brFy5M7P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bcc3zHUG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JIXbfp2965098
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Juc8e8AfwPvuNOf+7emuoewebBwAonAzshf0dRAn3sc=; b=brFy5M7PDxnjKYTx
	kJFr/aN+WeH6uuMFKuX0JHZmpiM47s3Svoef2QWJQ/tZtftnrLUGJagJcDk5X5It
	h/bllhwPkXOsiQqz98+3GatFwY5ypk9JMKCT5XFgxGvON7trS0Apibw95/q58z8a
	p2JQlIc8ElcqF3I602rjZepKJNMo2ytl2M1aYnVte/9JodA9mSJ7GSyuRMnwsVNH
	Lepdqzmo4lhNZyHJgl29vs5303w7JaOwiRbXBgAk4rW70IXUJYlEr7O2Qvsd+TJU
	TLZZlKW1LM7fXVa7H46BtO2ePkCJ7Fy5Q7RKzB2dLngNW6hpVF0J278Nm3A9sfVq
	gPePxQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjaaa886-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:01:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f46844106so4698708b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 18:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768874491; x=1769479291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Juc8e8AfwPvuNOf+7emuoewebBwAonAzshf0dRAn3sc=;
        b=bcc3zHUGv0I66AamDkIs70PfNVpWlNC/jXadpDFONJNxkRKAdmXzBYWWjNSNGilJmp
         eDrT/ZfWEyYpOWcUHHM+7anEU+WYrrORfPtWXIgVfzIWQstL5ISoCAB50Ef6LqkK9w/p
         3KaSP5U4n4WjnIezFC85z5Wipqqq4sxw7E7bSt6OZbvHsiEFI4ZZHxZ0pGNBPDxGUtih
         3LnWYqYFl91hQ/D7KyFsZ6xjGyA7rc2ggddYL5yhi+8/2/4sFyAMszx7CxodbHH2d33L
         aaL5kXX/nx/uZIDiqstl27UYqfE5PUrIWFU8M1ZC3q75YAt4MSq/xC0dS7J54Sc3Gnih
         XOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874491; x=1769479291;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Juc8e8AfwPvuNOf+7emuoewebBwAonAzshf0dRAn3sc=;
        b=ebBM79dtnEMZIzI6HnkIcpXrCwr9EdRE8sn+2B9HcCWJVxZ/Jd2nF94gKscrHSrW/x
         c4PXkYLAk+EOR9EAlnSnlfs0aYFQZIXeXfDEMgp4JYIptKOlNnr1L3ZJ+z9Zyy0O22XJ
         aZA54l9qpCnL/TZ1UpdAZYRt4Yrp4QMMkMlU+fohN85OxG4FlgCs5XKnn5Lf+KAQMUg8
         rUwovCKYEZUQXVVE7xJW0uHlGpcTKe5L8oyyBT62R2fyhIW4Oirlex+8JlEmTL/dFKWb
         9ZfZRf4xmY5V7yWCEedE+43Zs08bgQC08XlDhPL1Vjt3+qs1dajbd6LjSzIiFmfZMCx9
         86IA==
X-Gm-Message-State: AOJu0YwExbbAr/aD8QeMgpt6EnLq5h/sWG8uVLc4TYPbjIwm4PT4wvdw
	iu9+7hxPWdSegrATPNgcfbszYWs00FeoWUFkdydFv5E5Xj8+MKNqaucVB4ZzfMMq2zmbFU9K6Kt
	jsGqjk0I88Oxas4JVsnbGHNEC5Il+d8iyoTzLs3nmL8Bq1J/UP2PF8hW8Wij+dl2+HbwbCaehMa
	ov0Q==
X-Gm-Gg: AY/fxX70XYrOxiv/SDvw2cDkg//Od+ZgD3/RZxdfJ5ntToPcl2zRURAEu2+IUVHFoV9
	LD+34rlfwOQ8fz7H6W8S+Tjl9R5i9pnxhuOSl8AcOnX16WKD07zD5FyFIjetD3U10+ZjkPbpGD3
	GjcpHnnzdlp4Vvs+bmCTpaPeI3DYxm2yF3CGp26EBU3diBs05AwXBE4wELoulk0v85YgXyS/0rn
	xpQ/qwdjSC6dbdQMnZVLlzXtL2S+GbbpuwpMwTJ+BmZAclhXYyLMazXsw3gr4k3CT8ThsjD+iAJ
	WzN4CkLLKF7Ou/2AOjXgDxSz4alN9gMvF/WknZPGhiAzb/5ic4jv077ZsMGXE5Mi2fxPvPCSmz9
	4glEax0md1BnxzpnpK5qku0j5Pfn/r+OoLe+5BpkdN6b3Ezjo0kRbyzRuXxjfUOi8erqpOfq/te
	/K1qPzA2o=
X-Received: by 2002:a05:6a00:3cce:b0:7e8:3fcb:9b00 with SMTP id d2e1a72fcca58-81f8f12191fmr14322084b3a.22.1768874490402;
        Mon, 19 Jan 2026 18:01:30 -0800 (PST)
X-Received: by 2002:a05:6a00:3cce:b0:7e8:3fcb:9b00 with SMTP id d2e1a72fcca58-81f8f12191fmr14322039b3a.22.1768874489769;
        Mon, 19 Jan 2026 18:01:29 -0800 (PST)
Received: from [10.133.33.150] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108c51dsm10335933b3a.14.2026.01.19.18.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 18:01:29 -0800 (PST)
Message-ID: <6655c609-2b5b-448c-8cda-cb4a97da64e1@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 10:01:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `ath10k_pci 0000:3a:00.0: not found station for peer
 stats`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAxNSBTYWx0ZWRfXwY7Y2IS+bznL
 jFh2EC15fD1AGTqk6X5uD/meR4lMarP8yDRd2gArXlIm+4nkI3fQ7m1VrK9EdM/JS4pAzf4Gd3H
 TRHAxi5CGc1GKONvVYPD2rPcKmjjRxEhL2VHQZa3Pk8PRodsAsnZL7OUriJCjYQ72I9dlXTCzX6
 irDLITF+Eb5kFDA/IuAP7eDxc5yg+iuOKKaf0vnNNPDGh52TUDsXfkf/q0Bie2MmKU5inZUNm3a
 pqQxEURiATkjACHeowjlKF2cJG8hu+00nxaor3PSIDY7OSlggdXjZHGbyfR80sWnvIDBpu78ANl
 qUuWRIM8iZuHYLMvuiiqYcutImwl2dLx1KnaZpW4hPDl/pTECt1GwGpQWDhxcTW5qc+pFvJo7vk
 VQX9bibnRIe0eL67S1ztoB6rZPnTIo1zJ5ZFVLHxf+VSz/jd8F6ecA+JChfVVrzVXwK1Up/8BOP
 Md2NUKmuM2e0KPOuH5A==
X-Proofpoint-ORIG-GUID: wXenR3iuTs5Kd6TCDk8KbMPFrfzFPVnR
X-Proofpoint-GUID: wXenR3iuTs5Kd6TCDk8KbMPFrfzFPVnR
X-Authority-Analysis: v=2.4 cv=L8gQguT8 c=1 sm=1 tr=0 ts=696ee1fb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=5A7qu736JXePB-kiOIsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200015



On 1/20/2026 12:41 AM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Since January 10th, I have started seeing the warning below in my Linux logs, that reach
> back to September 24th, 2025:
> 
>     [   37.108902] ath10k_pci 0000:3a:00.0: not found station for peer stats
>     [   37.108906] ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
> 
> It started appearing with 6.19.0-rc4-00282-gb6151c4e60e5, the version running before is
> 6.19.0-rc4-00003-g3609fa95fb0f, but I do not see anything related in the commit list:
> 
>     git log --oneline 3609fa95fb0f...b6151c4e60e5
> 
> The warning log from `drivers/net/wireless/ath/ath10k/wmi-tlv.c` has also been there since
> 2021.
> 
> Do you have an idea? Please find the output of `dmesg` attached.

please try

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a203dbeeca15a9b924f0d51f510921f4bae96801

> 
> 
> Kind regards,
> 
> Paul


