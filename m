Return-Path: <linux-wireless+bounces-17332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2AA096DE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C216D3A20EA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E1212D6F;
	Fri, 10 Jan 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gv2Vo6ZH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EC212D6A
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525566; cv=none; b=d8hV2YUxPzY9BSP8O4uOPg6sUOFNYRPLSoh3CWmKrmjsqXoievdi1fNHqeFRwD6Bpd2zPbgGnW2uuMZQcxa+kepNAFhDNSbk67Nd8wXcwHbCEIJGPJRPYpd9n6CGCpu7MtfPs+IuH5D5BLXgLpglq8IqEUQPkz4e1fIUh8auB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525566; c=relaxed/simple;
	bh=YAOZo+NTWRicR8g28OtPZyQ2Bmvf7oTUVKJXeXVFGi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XA9Grzj2jT2xout09q3lJI1WncqSEo613UOTP1xJwBTBOAEJs0NbAc/4Touf6xsgV86N4E4I6a5Vrd1z2tnfuAjgPf0ZVmonIyKhTi/HZIPFqQOyaAyeiTtMZjLExLIobdmCQGOns4TePKMPxw0MpiT0xfjkR0ZOa/vdlhPHnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gv2Vo6ZH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AFFMDe004902
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j3TJHhPMA2Fw7NxEBMxigl/WAtTUPKcgdLOLzcKgB0o=; b=gv2Vo6ZH4fhiegbK
	f+/v0hB+Qkdwv+5GMEWKVWyxQGNUPELl5VjiBQWEwHGdCFhLv922SuA4591AQfeM
	rI5E/uMb7MPM621ycQ2oCjpX691lZ+xB7hCEtGJromIHFnCPyL5UJ1W/r8/mH32J
	Dckaz3dDdoWBVyeiaLqkOy+RpMKRXIvlr1W2QgaoqGUT9vzgybZxwCOmAfTHueCm
	KGu0cSFGCaISSAb06nDUEt4uv9PwrSaIS5QZJuylNN6yS4NhL1zHmNBemd6Thd7Y
	VTQpiFgGrGGv/mrYrf4W7ZIwTouX9mrPQfgw46VaxSEVmm5zRRu8GAnP/FG1IBPo
	6k9OTg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44361885mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166e907b5eso43387625ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 08:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525563; x=1737130363;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3TJHhPMA2Fw7NxEBMxigl/WAtTUPKcgdLOLzcKgB0o=;
        b=PvLdEAEAjpVzauv7e2jYXeAEApq8HvGYzDqGLKRyiz9BCBmribJzAfiMKJ9NRoVsPv
         nIw7bEl38ZlSKx4f6I7yz7YFWUtW+3azX9TbFgUPh6m1t8P3valUymHUgyt0QDC3TG7j
         MROcsG978Qb8G4UU86zLc+RoiobXoiqQ09j0EAWBbDmYJrfgeVX6JOfq4hTxahA3RvSM
         A58meQ4m4PVqmlz73DKF2v2GBKsWp+Zkmrc30lK+vePkLvDcijbwMEmGBMOwffxUaVMV
         Yx8f8xBeA9QSnBlNv9C0Xpr+b3umG761tXGxrYLUxU5NwoWYfaAo4WeNVi99A1cz0+J5
         /dKw==
X-Gm-Message-State: AOJu0Yz+FeJYtzp4KIXCBnT1FpeuI5AWy+K0en6FrJ9D/7obdsyF0KN2
	QXaaRWZPbsFid4UxAmWBrShKSSV/c2Q2h6GrgUzY7AoAR1w0QFoIzjjNSHzrtoJJdH1AMa8S42j
	P2DrMFm/erg7AWTd9uwwlk5qQ0kyPcn7URw2zPe+4eYI4NRKIvxkKC2lrRK3eA1r8ew==
X-Gm-Gg: ASbGncsx6TcJRRsNM1WGQIliRnwE0L7+nO0N5zzMzQ/jjSDYaA4swfHtIxCcJNr3fEb
	fmLD+MsW20Wz3+vJYK5sPZjFEK1KZ2HLSU9FltNK/8vAB1RvoxNkFMOK10QRVfG7kX33QSnvfAP
	vhkZNIcvFywgFOzmv9ATpNtn0U3b6TKwvNGx5Gszhjt/l+nxfXI06Z1xCddzSMefX5xJn7J9Mlb
	t9KPybZLg50JAhXFp772az6V7P1JuD/UNIE5hRZN8Yph8n/2OI+tR8EhoJfB2uyZCt4QZBEUkBX
	fHYsHNlS4pocMi+02cptNRoOYTbMnhOH3l9dZLyhKlRiY44Abw==
X-Received: by 2002:a05:6a20:3d83:b0:1e0:d89e:f5cc with SMTP id adf61e73a8af0-1e88cfa6a6amr17693300637.11.1736525563312;
        Fri, 10 Jan 2025 08:12:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRnudrbQIMABFvgTVAlsf/04lev79yZwEeuehcQShSD2zRWiv/ke6EUrLsAk8qn8f5/dAGwQ==
X-Received: by 2002:a05:6a20:3d83:b0:1e0:d89e:f5cc with SMTP id adf61e73a8af0-1e88cfa6a6amr17693269637.11.1736525562969;
        Fri, 10 Jan 2025 08:12:42 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31de807786sm3034286a12.76.2025.01.10.08.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:12:42 -0800 (PST)
Message-ID: <ebe97485-0b70-4a9e-b1ab-a39701d3fd58@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 08:12:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath12k: Refactor the ath12k_hw get helper
 function argument
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
 <20241217035920.2683568-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241217035920.2683568-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3mXvabCJaI-fHdOS6VnKjxfOd1cJIu0l
X-Proofpoint-GUID: 3mXvabCJaI-fHdOS6VnKjxfOd1cJIu0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=935 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100127

On 12/16/2024 7:59 PM, Karthikeyan Periyasamy wrote:
> Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
> ath12k_hw get helper function takes the device handle and the index as
> parameters. Here, the index parameter is specific to the group handle.
> Therefore, change this helper function argument from the device handle
> to the group handle.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


