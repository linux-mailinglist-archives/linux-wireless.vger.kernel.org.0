Return-Path: <linux-wireless+bounces-19731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F0A4CF61
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 00:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34223AD8EB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 23:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3CB237185;
	Mon,  3 Mar 2025 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CFruHIQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A31F3FD3
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741045095; cv=none; b=dMJbVXvETMsgjpBFiSeI9/k5QXfUhDmD764dGRAu7Op3Ag7WeXzJRqqzKbNw27I1xOM6PXXbkh8B+qpjkhPv7v4cJsDnYWns/45B0T+VOS5RYoT4RUlXs2ge/7PD4ysg6qV/0qTL0WdJyLICf9o+5/ptNVRhTcN0uSIi4YBcSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741045095; c=relaxed/simple;
	bh=vEySwi+ouonn8uHDCcIbEHCbjzESbFCteqZz+MYy6o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsCwclzwli0d2MDkT1KzZtCKx2cHCcsknp2PyFxQYOMvmVWOeCum9CZhx30K8mXD6VzwkpUf55ceLQE/1QolmItaH0BRwY+3NaO4TCNzSov0pp1K0FbL2RI7s68QeYA4ffLbXA+88Ev5SUgI6KR+DaEod9aJ1rhl7QON0Ly53Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CFruHIQv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NX94a025632
	for <linux-wireless@vger.kernel.org>; Mon, 3 Mar 2025 23:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4hStxONONkWzSFmX4euTz1D7hHThMLmcZK1Zq+P66Us=; b=CFruHIQvqrsMtcSa
	g00GUWFXyx7OL3F28lsj+K58YvhVn2sjrcIn0+U5GwJF0eiNMy26Ls+ZVHngTB+i
	RwsrXU0iJr5hzROHqZ8GZIqSf0lbRhW5tJ+Hq43I8DoXgpeAgGHDXBm56eWg1ilb
	M024/KZkPLJqCy/7/Acpt+yCuQSo2C/143Fn1QDToNgZUl9sd/ow9CxK3BdblXOo
	w7GB9Lm5MzcHN2C06euoPjf8tU69mRdjhDtYJplp7kAnvP80BAzA8T/aFKP87tnF
	KEq+3BZW1LFXt751WmR5747eMduLvt8Zd5xb/lKtaPxdSP4RWV891/YsL0ro3II6
	oUvulA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6v80fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 23:38:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ccd73acaso51658136d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 15:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741045091; x=1741649891;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hStxONONkWzSFmX4euTz1D7hHThMLmcZK1Zq+P66Us=;
        b=jHyigXVT3AY7e8Mm7SizMrlMQ5kyp3eYpB49vmu86qSEP1stbokG9sIdG/YGYETH9q
         dF7GtTd5TPDckowzH+IC+aoGAwv2u7Zkaup8oWWwct/2LBuK+81DpkcPahDhvRKes11j
         Dnm++uwj/IQf4IjPsepLnQcnxhR/n0fsABFBI/r4ZfU1M15f7MkcWZtpz0R6coPyf73P
         ICM9O0haxW4Usvi0NVVVb1QV+wWU1af5NtPKjwL8lp6sh9kLT5ze/9yCoq3aSli0MJdJ
         4YN7bnh89nM5kxC/Zf7dMH/DAdgxXqDi39K+EoZfuqSFU0ba0/9vAUA3oJnCPilw7VRG
         E//Q==
X-Gm-Message-State: AOJu0YxOvnJiZ8Xn5YKQ+YN+r0C9dXrD70UkSKJqxdAiAsjM9JC+jD8o
	bYnZFB6C4GDwD6kcSb29CPbAJnwFD3M+jaCLt7uSP5EI80HsbwVYpo7i+bSz3eYdYj3cWMeUKSN
	QEKplU58NPOMGnMb6rX8t20tOXV3FHUxF5YwpXNa8CxAQbLjyBOIcSUTDb8fOIONPPg==
X-Gm-Gg: ASbGncuhnPwsZIEKALfZ5blomgySOstW+UqO03fQM/etM5rA7QreyNVdtHnFxIfWPFj
	efQf/Y7hyiIXDOBQ6ZS8AdAIv9BuHavD138KAFhnx3nH/N06CHEkjuzks8458+VBZSLC/HgpOjB
	iX94GwBUDea6kfiTlLLzJHYtBepOa24dH49VmJJRjrZU/j2h+yiqZKDiGDupXOcjp4/TK/qcsLj
	UIptQFvrMToEU938k7lJll6DcE4e77Eukas3tUbi4g1OmSQhVIIvrh44IHKz+LYrfZZEfrFqO8c
	ihe6ueBmXFRmtSbhwD49AW3svQOQOTMFJMAia8sqs060TKUlKqF2bICxmqq6W/dbJrYbeGhWpTt
	AJgcuplRo
X-Received: by 2002:a05:6a20:a11f:b0:1f0:e42e:fb1d with SMTP id adf61e73a8af0-1f2f4e73bb5mr31456093637.36.1741044781850;
        Mon, 03 Mar 2025 15:33:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYEIC9GIomQlA8PtDWhumRHgTkORsl3eKRkqEgrVvn+rFRo6ZnNJ6yNk77zuHkGDssT3iaCQ==
X-Received: by 2002:a05:6a20:a11f:b0:1f0:e42e:fb1d with SMTP id adf61e73a8af0-1f2f4e73bb5mr31456055637.36.1741044781455;
        Mon, 03 Mar 2025 15:33:01 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af221346042sm4863866a12.28.2025.03.03.15.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 15:33:01 -0800 (PST)
Message-ID: <addc9245-cfa1-4137-bb27-99beda42a147@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 15:33:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 4/4] wifi: ath12k: update EMLSR
 capabilities of ML Station
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
References: <20250303221843.1809753-1-quic_ramess@quicinc.com>
 <20250303221843.1809753-5-quic_ramess@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250303221843.1809753-5-quic_ramess@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kW8QdYWE__r2qvIysQzj1LNNiM2IJm75
X-Authority-Analysis: v=2.4 cv=bPnsIO+Z c=1 sm=1 tr=0 ts=67c63d64 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=X2mNUfvcDLwOzcfUwEIA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kW8QdYWE__r2qvIysQzj1LNNiM2IJm75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_11,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030184

On 3/3/2025 2:18 PM, Rameshkumar Sundaram wrote:
> From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
...
> +	if (u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP)) {
> +		/* Padding delay */
> +		eml_delay = ieee80211_emlsr_pad_delay_in_us(eml_cap);
> +		ml_params->emlsr_padding_delay_us = cpu_to_le32(eml_delay);
> +		/* Transition delay */
> +		eml_delay = ieee80211_emlsr_trans_delay_in_us(eml_cap);
> +		ml_params->emlsr_trans_delay_us = cpu_to_le32(eml_delay);
> +		/* Transition timeout */
> +		eml_trans_timeout = ieee80211_eml_trans_timeout_in_us(eml_cap);
> +		ml_params->emlsr_trans_timeout_us = cpu_to_le32(eml_trans_timeout);
> +		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi peer (%pM) emlsr padding delay %u, trans delay %u trans timeout %u",
> +			   arg->peer_mac, ml_params->emlsr_padding_delay_us,
> +			   ml_params->emlsr_trans_delay_us,
> +			   ml_params->emlsr_trans_timeout_us);

it seems wrong to print the values converted to LE if the host is BE.
suggest instead you cache all 3 host values and print those instead.

/jeff

