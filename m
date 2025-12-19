Return-Path: <linux-wireless+bounces-29916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB3CCE845
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 06:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 547ED300E366
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 05:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6DE2C2340;
	Fri, 19 Dec 2025 05:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVK5U2xd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="caTd6C4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638B288C34
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766121854; cv=none; b=i3ITU8A81BjDtRxZlwB7LX2Y4dRQV/KT4Vmhts3WKwXPB23GIsTRBthajIcpLBnxBqjCtPlHrvIHCMFfDIPT6tFSma9vgmHd3gGmVF5B8QFmi5rxsweL64IUeu4KG3xxfdRBiT7MC1+X1P3MaQxk1gJMFuGTOLNWo251RWDOFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766121854; c=relaxed/simple;
	bh=tHTLu6pYA17IPA3+9SgO0Vy2yrt8LY9SceGnhjjzWDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRNKEVUB83dppfSzctqoyZ3zn1PfT1vRyY8PgKU5K0z9SKPUUyHZTsoEA0hY252bTLF9wSSBBK2+1dxNxiGUYt7KYCvwgms6/QjZE6LouUVrscFfeH1QRsdgqdcVKfRLzr0zETLlW839LoCjwP14Te2mR5pgExqKk8855n6kBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EVK5U2xd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=caTd6C4L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4c9S03319083
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 05:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f2jVuL0Bz+ej9c5464E/vN6YXCzWpbQDOG1kB6pWIUc=; b=EVK5U2xd7w11dyD9
	m/EcxE1g2aA+CkfA6DrSB+28WD6CxIV/vKTeizav5ySWxuTtDwhJIBkTx5rmJRtd
	myu1sBu3cW+l/V5MPLIeQ3KkVT8z0nOadR71w5hfYrqpc6I2yqIACKf3lTazvklF
	rR7hxH1pv7R0Y8UwdwIz6zJkY7GC8pN3S3yplK8AVL8pwspO642JguJf8I00h2Gj
	dBd+10MMzAmw3i3bHYXKdGGD6uNxI90wVN7M1FMfUi3EG9O8wgb+1t5q2ToXDb6E
	58gINAfdum8IRmXumuQ+oESng8kNmINbx6Qqnsz1SyzfsqdsigmRgUyOt9MmbC5H
	uIhsww==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2esad5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 05:24:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so1683207b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 21:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766121850; x=1766726650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2jVuL0Bz+ej9c5464E/vN6YXCzWpbQDOG1kB6pWIUc=;
        b=caTd6C4L6vLnxzSU3Q884kaw2IBgTPM7Ef/rzUAXFR5c+5FWUcapyeIkxfU1yJm1Tt
         S20G86IRXh+DSGCmvPPMLqudb7ZMzjrjKh6LSfTDgl4tJgwF5Ef/7i1E2a01p+IO2Wf0
         33it7ypaGQRTDwZNuVtg1L604nSJbBkbRoqoS5ygu5UV24RMQ9wJhhzwshPpveT6KKQb
         GjbJozxNTEIqe/dGs0z75TywTNitkFmyVOoDgdGrn7FXRVED7OKzPhQm2+uVvYkocsR6
         Z9/2xkbd3ETQTCEMOl1nO6XqC0ksuT3Uhl+wV1G9ebeibThKirnql8ObFDAAKlbmZIUV
         PzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766121850; x=1766726650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2jVuL0Bz+ej9c5464E/vN6YXCzWpbQDOG1kB6pWIUc=;
        b=BYiscO+E7KPjGrF5kBe6oFwBFEee8aoZnf2uPH09gEXQFfDWBT44y6Nsq4FV6hK+IK
         Qde+vXWF9T1il3QchfS9H7aXySlrmu70dl+qZrGRZeVi+pXSsF3gd5ddaOidUHHzYzI6
         oAcRsLwqxYAKLKcSsfDtzdvS1AbS0o1kzT7fl2pKz8nZgSWa9/lnOI2ZP2/z4FzX9XOH
         779FOVgPmcGGczFcuOdUItKKp/d2IaGEa86fCMjqN6Li7fuDbzJJ3XRST6KGvnJg8t4n
         ihSZX1yzBQBZBZRWrc+1AXzWwq17SbZDJJ/tjf9nEcXDoyyB8KKDPKFnpYykLAK1Q/GK
         XHZA==
X-Forwarded-Encrypted: i=1; AJvYcCWmxNa8JLV7fCLwMmCx6LPMBf+qHpsDrH8aO9cVihx/31lfs+gLk94+N3aG4V56MNgBZT+/Se/Xds09yIjY5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7ch5HOLb/NP10nY36pJP5hz9h/4Q0WHq9JLQubVuVdknoGrK
	2q9g3/2xEV5JVDKov0Ti1AMjokVSUFfaobPdL9QvHeCxz5PYmVTAdZ9GFwsFiytnv/IxuPmoscF
	Tgz5nyb15YPf5CqgDCSlFFIshKGOI7iqCpy7/S1dc0cKvJq92nfrl+THa+uYq1rbWxXmwUA==
X-Gm-Gg: AY/fxX6RwuxH5VmMWXIz7x7M0MeMouRt+aWuuYTQe9Lp6sy0CD/qkLMHkBsSwducL06
	iBMf1ytabsc7VjNjrDZIijvAXRXb5TXT41b1VENFBHXNgpHinpTX2RwJNc7wtCrzcruX+QLHw3f
	UQVJmhu+am+pNMcYme8JLwK6Xu26HUKsSHNDuvpEFpNoQAkk3DOrT+Jhn9DUNyVNEPuELW6e0mi
	sNFBIJ5yZxzA6BtIhjpC8T7IeNMUfJHMmcVxbUalx+hxXIBdwkflSFRhAhkCs0JqTF27i/TLB1E
	bvgz1jCKy3EOiWc/eU014WpsPE8isj3Ynk6JCrtL35/k4KEctXYE18pvkqwmFSVT/4vNlevruem
	bBeYv+/6Wpb69/iuz1HhAT0BZei7icvAtz06XvSZnkiPSP+jJTysdG9rGbtDIeA==
X-Received: by 2002:a05:6a00:6ca8:b0:7e8:43f5:bd51 with SMTP id d2e1a72fcca58-7ff676624demr1420515b3a.61.1766121849884;
        Thu, 18 Dec 2025 21:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhNQ3Te/f2XMrvAgCZ2aPBy38yMuSSI9w3vtSAX45LrLQgNLXDnHqH4Y7M6btY9r8I1mSt6Q==
X-Received: by 2002:a05:6a00:6ca8:b0:7e8:43f5:bd51 with SMTP id d2e1a72fcca58-7ff676624demr1420502b3a.61.1766121849408;
        Thu, 18 Dec 2025 21:24:09 -0800 (PST)
Received: from [192.168.225.142] ([157.48.120.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e0a19d8sm1011419b3a.42.2025.12.18.21.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 21:24:09 -0800 (PST)
Message-ID: <1fa108fc-a06d-a9cf-a56a-c905e4982b41@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 10:54:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH next] wifi: ath12k: clean up on error in ath12k_dp_setup()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Ripan Deuri
 <quic_rdeuri@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aUOw1J0TU4VgeXj6@stanley.mountain>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <aUOw1J0TU4VgeXj6@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oITnxKUAs3D3sYHgYjUWzrHRiy3EqhOj
X-Proofpoint-ORIG-GUID: oITnxKUAs3D3sYHgYjUWzrHRiy3EqhOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA0MiBTYWx0ZWRfXwKwrGLp4msTj
 v5cqi41XLBUme005iRIOHUeXBZ0GsDsXPWSvX1jGgSLDh6n7YdM7qIBsxFGogVxRcVvnVhBEu5V
 qEM9GfAu42jClx3CffJqX451eeskN4XD0k8DxAoRIHdnOtNE1Lsw3gn/fXX7zLwUJpa8ub9FiJm
 N+38p7H9OVifqTCDqQDY0SCKFEESh07iD1/M387CVSwQVwXrtmLD6EsyzwYIMKUNWbetonZehYE
 rW7lSSJxn9jrkGrrx6S0e4yVUSkDfbQ48ZgL7U5PTKojLXqcchAqhAswv6XFI4qSgyIc8kR05Cg
 MAVdVvcjabyB3DjEExD4XbaSvh43g5MeflMWD61WO/WSN+kAjQfXDRxv0RvQEn6jic8p2eUZ5Po
 vcgwmxX3EpAM4NvtwpjDOy66RikjJs+rOsYeQePO8DeR+a4DwQkeVL95NSJ5q64g7ynuGr6H2vX
 FtPGLe3SxXbSueAG46w==
X-Authority-Analysis: v=2.4 cv=Tp7rRTXh c=1 sm=1 tr=0 ts=6944e17a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=U98CeTqYmU67p05RdacNqw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=OFcc0y_4Mb4PjAsfjdEA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190042



On 12/18/2025 1:14 PM, Dan Carpenter wrote:
> Destroy the rhash_tbl before returning the error code.
> 
> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

nit: The next branch in ath is actually ath-next.

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

