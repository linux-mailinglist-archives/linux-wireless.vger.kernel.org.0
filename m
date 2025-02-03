Return-Path: <linux-wireless+bounces-18277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98110A251E1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 05:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600E31884122
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 04:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779C35955;
	Mon,  3 Feb 2025 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WmIiZqg0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42F225D6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 04:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738557988; cv=none; b=esOHZKboEJ8UA8aEMWRBtj7wSj/5ry18AjeEoX11Webt9bn3wMs6zNxaSAqm1DJdkHmpoCrAnPQiCjdBb0Xn9dl0WEOdVlIWAYJz+ybpXXkcyuLN99bJgAgl6ZuBoqlPrYEYkSPApcvgnk4wPVm26aKTrZ/UVaFDuuO8Uz016CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738557988; c=relaxed/simple;
	bh=7bo/NLsGLJrT5DWruxODPIaJ9tJMXRWXAN9dXh8OzmI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rwOoij1T4ngiOnA+AdEz0oW72In+eMKEGIUWiCptwWWk61sexrQQNzSKpta/v/qpQgGejs+KQ67JLexU+Ag698CWu+qJ2FpwLHR8LWGAxoSaCWY/yYz+Qy0Ko9IvC0qz9f9sflMC633I7/b8HDudBffOMfORB2Mm//GBKhmSBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WmIiZqg0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512Kf6G7017675
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 04:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/R8c0E36huanx8aWAZWdvl0frejm+gHbdcLPUBmJBBg=; b=WmIiZqg05lIjmb0y
	2klMDFG9dHExs/lOX/hz2O4SxvpqUJGhxRY/NemRpSqBXoFT43V0gcFCq1Wtr+eL
	jTPz3r5IzSkpKnw1gqY0Pbw3gJeBdjy6xLRVPfvQRGG8E7/n60ZAC2lTFVlu4rXr
	DyzAGfXk2z5A3/sV8uZCmq0r7Ycbh+acCflJUbBceIgG8ttWlvpgYcSeTgFN5chD
	qXQKJAVPrdxthKCg2F3YT/VMejYC2JXeFa7FsA4a7XjLJCrsrXAvVxHSQRQ1pD84
	8/cYGb5TiWbcQh6PH4h9TlobOqaPzvkqofOOwOh5hdL/suuvghDFn516624gDL66
	OgrFbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44hd8rb6ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 04:46:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21650d4612eso38102235ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Feb 2025 20:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738557985; x=1739162785;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R8c0E36huanx8aWAZWdvl0frejm+gHbdcLPUBmJBBg=;
        b=CH0KuQojqUfXedeL2dSQ7hs/nVkfibSSnLuuKPqp1S5CmY7crPnJv8rLguFtJBGJha
         bKLtKIGsAGydTem+/Kr1u8+w3CI/IwXcDiUFFTMhB8qiO+64deBc7L4Iw3iQ7jsLreMF
         5IyYpCvDUVnVUmHbX8XUDb8t2uy12b1B0/7OwWZMwLafRjyXPZrSHR+yFxLg4HkXZnVL
         5tXoUlIFcP1qckq8TVYTER6KeC57JrYNE1KPDwLAsb3QLwsttCTept3E8cMzQH+5t6B/
         7/4mIecrOrXj6SEVhupx8g+JTlLFm6l/dQIeuA2fnbpkPSsJWjgL2T6vfLO1b3baIU9t
         4iHQ==
X-Gm-Message-State: AOJu0YwxCzotYq9Q/HxBubKO2odKY1tNxsy/4P8bZn0CnVvTiD2q8fEi
	DTAmTkhmWKbqjlwTZUCWygPq0KcBJ/ggfPpRNDikqg123ZkUtxk3Q1C6g7k3v1cOe2HNuS/UF2y
	t+JfBUb3EQZ4VAuBOmLZ7KzdKlVK1AG1/p1fbc2LUaGtq6+9WqB0AZG8hcEo5/Tcfcw==
X-Gm-Gg: ASbGnctKhZuZe/PcSalSpQ9NxKXBQ1t2DIhGfExq7m+vN6IwAMXuXbH4K4buMytxHKH
	2DQb0VuBL3ZsHoNc23huujAfsCLS32XzaAdrh4CXCGnfTgbHA5PT4Uf166VJ4F0L9eXcMSoUJzu
	k2WtVT1aG45kZsUdQ+XS3sf/ktLIsHsAUf1dyoUZf13VPm0LSFL2TQG98qY/iPzIMgBGDIuZu3V
	w9q5+ai/pLTBaiZ6zixQNEezetF8dvfL2X44/3Wmq7kQt3dsfyY7X4H0l0tv/DqacvTo6mYCDjf
	KY9jvd/b3w1ZtI+YNvorOePmwS9pbj0pVQhTPj4=
X-Received: by 2002:a17:902:e80e:b0:215:30d1:36fa with SMTP id d9443c01a7336-21dd7dcb183mr299466735ad.39.1738557984824;
        Sun, 02 Feb 2025 20:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwpfI/y0iuDNby60PhxDzhLpsb6ON6HlI2m9WQtsMnRHLbdVCvSzI0ttBHdZfnWhaNM29vpQ==
X-Received: by 2002:a17:902:e80e:b0:215:30d1:36fa with SMTP id d9443c01a7336-21dd7dcb183mr299466485ad.39.1738557984447;
        Sun, 02 Feb 2025 20:46:24 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3205a17sm66914855ad.106.2025.02.02.20.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 20:46:24 -0800 (PST)
Message-ID: <770548c9-b3e3-4748-a67e-f3c9bfd2838e@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 10:16:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and
 bit mask definitions
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203025016.3851279-1-quic_bmahalin@quicinc.com>
 <20250203025016.3851279-2-quic_bmahalin@quicinc.com>
 <e0cfabf5-a858-4069-928b-ba4dc86f307d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0cfabf5-a858-4069-928b-ba4dc86f307d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QfiYZx7vAG4c9s3PvJzdwcgxmNIO3jlF
X-Proofpoint-ORIG-GUID: QfiYZx7vAG4c9s3PvJzdwcgxmNIO3jlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030039

On 2/3/25 09:38, Aditya Kumar Singh wrote:
> On 2/3/25 08:20, Balamurugan Mahalingam wrote:
>> Update the HTT_TCL_METADATA version to the latest version (2)
>> as the bit definitions have changed a little to support more
>> features. This new version allows the host to submit a packet with
>> more information to the firmware. Firmware uses this additional
>> information to do special processing for certain frames.
>>
>> All the firmware binaries available in upstream/public are compatible 
>> with
>> this HTT version update.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481- 
>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Balamurugan Mahalingam<quic_bmahalin@quicinc.com>
>> ---
> 
> Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 

Removing my reviewed by tag -

- Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

