Return-Path: <linux-wireless+bounces-25261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076A2B018BD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4CF8E090E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B2E20F07C;
	Fri, 11 Jul 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KK4lz0Vj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FD18C933
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227397; cv=none; b=HXlm/7eWT2o4CG4JCOXkJ9jLYzjbOTBl+kWn16lEkaT6UIoWsPecN4hQseHR4CVUrv4ZD+DugNPGo1YwrhAo/A0p4K65QxDX3DOPhUXAJgLTG3OWkupn/tNKprCW+iuunEEoQIsC87e6DFXAjI5Yy064XgUfP1XmL6GuowaiGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227397; c=relaxed/simple;
	bh=vQJsX3q4bcXNR08ufKd03TcQ/OpjbfQmiXct9GRow9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmjZB3WPdMndpJmX/GOX+ZDXeZRSx62jUb1Knmm7pQJVfrXlso9gT8b3GMrwAeXi9iRMCBPkwyqYEdWRmqg7e5XQ3X/WPl8JnS/pLhQMYOUxW5VXSasyKPisT9bKETlPSPhsJ//51I+EfZhge5e2yhUe1gi83LFhCAKNJ4tXh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KK4lz0Vj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7JD003786
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 09:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WRhs5SKtUrZ4bvXs7ueipxeY5Jhku5rft92ybHCVSDg=; b=KK4lz0VjdOfaS56a
	Dzba0dZIE+UTgc8SiCcXewTv1jpOghxioMhN9laMKdzVbSGRrL0+G4wbleelaJpv
	NE5jlVa3P2wv5yuwCeHsRS6sLBIT1ZszN6QqbK7mdebpgpVeJfE8K1djnQaiYUo6
	AdIWu1Q/T95IIhfMweipUV2JZRfn5gfNn+CCM+qBEIyPlFHWJ0gICMJYX8p/6Jhn
	p5zZtS1hSdu502x//rZZc0xsimLgkWH1B9i157bqnoSnPSZeEta0b31Ja2D9y3rZ
	vUSscMM2QorgfB9OGr3pqGzY4pPfZs+dQ/06ZGxfB8BJaYFf1jRZf8K6S9uVTxUs
	H+1cXA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp0680-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 09:49:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7492da755a1so1739163b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 02:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227393; x=1752832193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRhs5SKtUrZ4bvXs7ueipxeY5Jhku5rft92ybHCVSDg=;
        b=nfYNq08qS0PjArq5mXhmH0uR6qQZ+Iwbc/lHnrCELrJz+dA6A60RM3O10U4iVCVtTp
         XtyaEYsoUWT1Zojur7LjQlIpLRnVV4D+UVGGDn9rP5QRzpNOIpxIcKcuEVNK1NsqQ5QR
         GpMxPECipCjYGUL+oGMC/q3Kl8xx3vsn47lKCS1Kg0nXxoHiYSM5yM8oOZqXe1J9Vnok
         2uqjfEoyWcrVIc/eeU/pULm+nTHL0mFrHmqLTrmsGu7XI6wNwsDoJU2VtUSdXx+uuDBD
         92WKDE00OpWZLBvQAejagtUjnqEcebSeqxE14kPrDSqV+QJ/8f0GTYa4QzIcf5hBDmdD
         fFpg==
X-Gm-Message-State: AOJu0Yx3kIs+dQb0i7A8MML8QjX6OLpbYx2p/MfKueKa2D4niB2Ug+Cw
	Rn0Yx1KrUgSqVwL0WY49enEZuW/XvzPP7YL70zLWsT/WOqzaMx9AbCQbMDrKYEuDvZ7aaEfVZw6
	ZKJ+yD3EpphIyl1UvAH9JLHtqJIgInHKNIu5jMpZCNuryV6NJ9FIzHUqJuiEfEeHD/2f3QQ==
X-Gm-Gg: ASbGnct8FhCtY1/BbgrqJKBpAUSnHgDN6t+W/2vNLKE08qvAynFV47NJSr8nOWLRTUC
	g2Mz9dP/2p4Em51cjbrh6RW4jKVCbM2mZBveYdBCTk11g8dYjSgc5Isi64WZXUey23oTYzY3Aoq
	c+iRPtX/LO6eKmPLJsjGa1NJO8mAwf0wRm3K0DfPCcJOJ+6hf5Zn/7o0e7mHgkhFX+tlhEFbug9
	B0plm5NBSYns4Gx47zeOcIuzLe4/JWJaiaKXlqbsbCdyU7OIj666OkFD3NPdCXBkG9NLpS3RQ+M
	JArWtVsWPvULaxcRHFMCdhvvX+ukgjWmf/38hwbLssumhGjCLse7Ht1vsNQ1UJRHKj3z8o27VLv
	honhBVk3YbcY=
X-Received: by 2002:a05:6a20:d489:b0:223:dc82:95db with SMTP id adf61e73a8af0-23136e6fa2fmr4153804637.32.1752227393311;
        Fri, 11 Jul 2025 02:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbH10SxfEWLFK0mnaKiBGnmC1/dgQa3l2D9Fk2Qac+/Eu/udUsVIFryyXJheRx0nLhChgAtQ==
X-Received: by 2002:a05:6a20:d489:b0:223:dc82:95db with SMTP id adf61e73a8af0-23136e6fa2fmr4153773637.32.1752227392882;
        Fri, 11 Jul 2025 02:49:52 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.107.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7134sm5381734b3a.19.2025.07.11.02.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:49:52 -0700 (PDT)
Message-ID: <9f4e3b2d-5665-2c5c-2dbd-7b923d4a6b21@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 15:19:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] wifi: ath12k: Add support to enqueue management frame
 at MLD level
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>
References: <20250711091704.3704379-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250711091704.3704379-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA2OSBTYWx0ZWRfXykAPW3l+QxAD
 IENm/VtsoSI+HuuK+z9YCxrF+47m0NFtIFO6WANKLPiW8uuzTVbXBLgwt5djsTeAWSnnrC9xd4o
 dB7UzTwj2PIwKm32Ti4MzJNrkFoowFcxx/OAe7L/zQdxlrBRKPZqBw1KneaVP/yGyaNYV0aIZZf
 izWvUQXlKjfudqpV98ISBHqx3HHcfkGNEGG9EkpFNxJq8hxh81/y90wRpfwIvCw397SvmJoXjEu
 J0XAQcveJGMqRE72XnjoDMjQ9wERWG5pvtJOItGs4mutTT29eLmpHvD7525hYnG3Gx7UtY7/aLM
 PX4T74C6uJVxfDTi+xJ66LavRFlBcjlWsF/0pwbW/m2SJ6kBmrUnNd7/XGdp5QBYexTzjw+x7Kf
 oGLZp7cn3Vk9MC0lD3DCtRIOAcxIStvik5M/cBS4M++IoYFVLWJr7XKLt8IVMa1L/uzorjkZ
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=6870de42 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=46pNLmHVIUaJrpSFID5ybA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=gs4PZpNABTKqZCAykd0A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: d54zWxDjpr9530EO9FdzJaVVQNXzZez_
X-Proofpoint-GUID: d54zWxDjpr9530EO9FdzJaVVQNXzZez_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=795 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110069



On 7/11/2025 2:47 PM, Roopni Devanathan wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> A multi-link client can use any link for transmissions. It can decide to
> put one link in power save mode for longer periods while listening on the
> other links as per MLD listen interval. Unicast management frames sent to
> that link station might get dropped if that link station is in power save
> mode or inactive. In such cases, firmware can take decision on which link
> to use.
> 
> Allow the firmware to decide on which link management frame should be
> sent on, by filling the hardware link with maximum value of u32, so that
> the firmware will not have a specific link to transmit data on and so
> the management frames will be link agnostic. For QCN devices, all action
> frames are marked as link agnostic. For WCN devices, if the device is
> configured as an AP, then all frames other than probe response frames,
> authentication frames, association response frames, re-association response
> frames and ADDBA response frames are marked as link agnostic and if the
> device is configured as a station, then all frames other than probe request
> frames, authentication frames, de-authentication frames and ADDBA response
> frames are marked as link agnostic.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

