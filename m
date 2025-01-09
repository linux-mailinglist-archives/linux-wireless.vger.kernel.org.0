Return-Path: <linux-wireless+bounces-17267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09243A081E1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 22:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322903A71F3
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451E84039;
	Thu,  9 Jan 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jF7FVezU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B219067C
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456448; cv=none; b=Cfmr96+eh9o0Y4ORhmLbkGZIvOFgSwt6pGglWPTmYl9by9pSPzbVvy3qog8OZmcrqbbmdwF2kL1NFhDTcHG/KnzKr081BLI91glTMNocmkBt5eIbTXqdMqkNuw3OTS7NJ3GsgSdRYQirGBMGnfTr3FIzP8J04HllP8kT7Z+szs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456448; c=relaxed/simple;
	bh=OwqvO2HyfyuD08noOxTamPK9Jp4msluB024oTeQPMI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJakcLH0JKI9lL3cu4EMrjCO6cyxrjb/v9KKub+xF6M7nK4m0cf306Ur0MtqNEiXvSc+50XeUvwzbV0cVdus9w+0hPvvdxZlsC8ibQuAdAnkbABf1U999bVPOniBDUZo8o6obgi8sEWfZSL03CzNLIA0Is58Ht0KNOYwPViOpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jF7FVezU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509K1gL8030474
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2025 21:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2y7zaXSi7gZ6s7ePNlQEwcjv5qGnWP1LxEv+a8XnG8o=; b=jF7FVezUXbFAKuHb
	2F9OKvAXJwUV+3as0ipu+MP7xvLBCIMiGYTfIP3o44mdpR5etGUs3M1jM2xW03Up
	bNq+6rsCndbakimLzWGK2/jScthQC8pE+5IbzVFEW3XyT0ZQvFUxqRk6QbYfFxuc
	2nYo1IKrLLcnFW8YW+fwYjlZpE9v3liTbJ6cgcTARMiVpvc00Q8MojvcZ7tVpYln
	w76x1Io5OWBuxCg8xbRRBNu9K6eGtwCqjh0mC8esPEp5289IkKr4fxziX6ewSCDc
	YL7/6opy4qO+Rb1lBYyZC+KHsSDVwoOe9/R0QeXfhZ/B7SL7nTiwfA+QvR/vTmqf
	GPGQDA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442n4r03kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 21:00:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216728b170cso24695615ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 13:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456444; x=1737061244;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2y7zaXSi7gZ6s7ePNlQEwcjv5qGnWP1LxEv+a8XnG8o=;
        b=sOMHoJPCfv73+e2gc/75ieAh3yNDhTBkUTs80JeiOIbnCXfIZnBrBxYDlbJC2gHXXp
         rGIJv21fYDa0pKbWqodM6VzO10qNrsxoYAhz/TmxSxov+GafXYXc78LN+gCn0nHjoXip
         K7orNj96hMbFu5T2g9P++7n7NbxjQX+6Hs5Na8FVcRIDIGQ5rqTxUsLAw31ydOsavWIR
         mRBXZ/L9PKSxsbrbrOUOi7MciEuywuWY/bYED7I1U+3hReXjCZ9yvq4l0VP2hREymOS1
         UsHVd1+N7HOrQV7HSaVjEvkWAJDuftFohclu9YrRzWnRtMuZPLqEks/YGVEAbnV1lA4D
         tecQ==
X-Gm-Message-State: AOJu0YxeifZpwlbusbFAVacazH5rDaMjlLu8M+2+o31vLqU3waE2hqNP
	s94MY2zKSeycikxeZCa6+5GS0ifRNMCzOeI+GrZlsrTHQTvqZRM1a/gHLCgykgljwlI9RwJ4Mxp
	Wqcq5OH4NEczjoYbtkl3yh+Csw0lWWJuywwyvFzfuuIBFdHMoyKP27xo6trF8FlkunA==
X-Gm-Gg: ASbGncs8c6sFTYw/4mXrIq0SeqTvb/N5NfOi2ESJIVCB+PSav/UfY5dFaQXnlImIfgT
	7HcYkfgYN/kPJR4eqldxeECfD7p5mCWIi3bSk1rhlxkvPRhS3ULsUIRd3+ZuMrJP9dNktzk9146
	yxD3c5EZCNhNzI+Pr/YqZOPs0ChqJiH33HWi1WbbXPsXLC5WtIJoyIGF8CaHi8pGkwMXi+O1DM8
	MUjaW8UYHCG8njURn2feDRkzlZjO3ezX9kRw8paH/v5TzOQbguz6pijz7DZRv2rwlmYNIbjpfnE
	nVOeBDGg5I/cYmEVmvKhpFoAOF5f1vLpQ0O4
X-Received: by 2002:a17:903:1cf:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-21a83f4cd36mr129741205ad.23.1736456444341;
        Thu, 09 Jan 2025 13:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPR95QCCAc76At1lFc/1jm4USSn/95SsQYqfRmZvn8eP+T8Lzzbafcqg4TZqQQcedWEHoFOw==
X-Received: by 2002:a17:903:1cf:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-21a83f4cd36mr129740505ad.23.1736456443747;
        Thu, 09 Jan 2025 13:00:43 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a34e456sm4450099a91.35.2025.01.09.13.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 13:00:43 -0800 (PST)
Message-ID: <dea8d952-92df-4a7c-9622-288921b23332@oss.qualcomm.com>
Date: Thu, 9 Jan 2025 13:00:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] wifi: ath12k: Disable MLO in Factory Test Mode
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
 <20250109183551.1028791-6-quic_aarasahu@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109183551.1028791-6-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dUlplZB15qD_NjUd96V-07N69lAVOZ5k
X-Proofpoint-ORIG-GUID: dUlplZB15qD_NjUd96V-07N69lAVOZ5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=771 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090166

On 1/9/2025 10:35 AM, Aaradhana Sahu wrote:
> Factory test mode(FTM) is supported only non-mlo(multi-link operation)

only *in* non-mlo...?

and s/-mlo/-MLO/

> mode. Therefore, disable MLO when driver boots in FTM mode.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>


