Return-Path: <linux-wireless+bounces-28546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4AC31F9A
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C528D3A2380
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA742F531C;
	Tue,  4 Nov 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cU8IDiex";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W44d1FmM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C2280A5C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272629; cv=none; b=elRiQbL4KaEgwymYpiHY3k1mmN7k9KEoDoMshNgaQsuun7kBreY/qx+6gWR9I4BqbAsQ9oqi3UnfNsPsd2M6mJR7GIJtFuylnPWyhfGVNzeRh6g81ITwA8xX4l2X2/f0LGz9HMhGKRTVvODal6Si5ardtYxswB37h7ZXPufVQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272629; c=relaxed/simple;
	bh=+7fBbOp7oH2S06pRjVL9yEumxvv2qb0a+f5BSrTCk7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEMBydiXctF+7yYJWSQXdhwlz0GNA/x5gtYSK6iC/XENk8cZbTPNJ4VjjqBcvl4ZGcMO35uJ3tOfHYazXaED8X4YVvyM4G/SdRhrrn14d+ZUegSdctpu5qHuJLfLf5a9HLS2N970JVuaBzHtbAhRsUyqaGEd2Grt5M+Esy/Io/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cU8IDiex; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W44d1FmM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cg4m61988259
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 16:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZQrP5WHqap98WOxR8qOdXIEhS6MSJIDFks5mJnLwaVw=; b=cU8IDiexAHmddhGt
	arumR01Mc1lRaS4Y0+PoPpDBZQErxl82MK//gAarv/dAFUEaJM6Wlp4xkOAQVG8h
	DjYU7a+rosko4HfX5aqTTH2XDjRuN1QI+Op8FsZYbbNxhngu5ltKnqe6CfequfSK
	SLO4IFOcHSVRwimdE4j8abJnODPJLj5vbD48t6uEj02VbNARHk83q0BkSzSEYfCg
	grmu6Ey1P35kbPuYDvmJL9pf3Vm2V8+vYUs2aJBr+qbOQT0VrXhITVxQpiMYJvfJ
	78krIdrGxl771QBNsumJcU+ICAWDJylF7/F8NSzHtFwC+xdFfnlrDo1+vXsev2va
	f+aksw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7hbjrnnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 16:10:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so5003391a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 08:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762272626; x=1762877426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQrP5WHqap98WOxR8qOdXIEhS6MSJIDFks5mJnLwaVw=;
        b=W44d1FmMyViDFvGyCNY5nf3GFp9mzNYXqY8nxyOtmdoD2yrgLLiAet0iJcTbec7dNP
         JK+1XsqG0IoQEmSo5yYAlS9CywptC19hAX7/PCC41b2TCMVNbEEXX/WqXkA5wVGncfe7
         /oldoAGInGkXedeJh9FeiyJebsZ/ddiQN2ROdosqld9UFiPR1tPliXkrQsM5sgN9ikAc
         0SvVnhPa35lT02EcrXGgudCGNroWX7PEesyFZEWGaDfD/a7Y4tg9f8X8Tf6hV3nQw4Qc
         IpCaEhsQtWPlpa//zLdrcgTkX1jFePp78lCMxHGN2PhlnRk0Jlpwbcw3G3fqjJNilUcW
         MuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272626; x=1762877426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQrP5WHqap98WOxR8qOdXIEhS6MSJIDFks5mJnLwaVw=;
        b=NMiUq8fefg7TBA9o2juMYaH6qQOOuYCLcD9oz4twYGqhmAuL40Zitjrq+bc3fiBYHk
         aMqVCob9kNV0lk2WNv1jsIzejIQq8aiyAtVbLA1cHE3lFf3hDED76DikZUCz9A7ZI2P7
         ZuAge8v2ckVcWmuGLSd3EgmCyqEEUsG5IrLcgaoFzgcP7/Nw9dxCugl+MLPV9ER20jxZ
         b0rQqOBgb/+RE2RRyEny7einLkMDnO5lCp5XRLNatACJMWWhBY6vIm+/fwZ85jIRDiFK
         JRPGRqx7i7T/HiaMTAPFngRh8epvhKSl+kX4dQ7sjcXwRQfX+Fh/7F3m47Ak5kQDz7RF
         2orQ==
X-Gm-Message-State: AOJu0YzDSE9o4KWgcHtKv9QoXsbE3Y12rjNQ/TYz7Q/XncL6xrY9/2xT
	f48PGquFxg2S/8bivnzYVsNAhZWOiExj8a+XvQzpyZ3UEpBWATlOlimZfqZEaQH60YGlEROYIoT
	CuDa7PUdiMqBHOcgx1HowyShyPz10A6Aw9phrxrWZNbzGGMepLUxAa0HtWVMgjd75Owg2Hw==
X-Gm-Gg: ASbGnctXVVyanAbwGXxFnQMiyB9GHAUgQbErrrATXYytnleAr18D4FzwB0FOutlzshF
	QkQT81wEufRHy24cU+ynDuZWQRh+qBerQ8sJzzoL/PKsuRr00SE16hcRaq1/sjZt818XXEftoX1
	oYPJiPLmgW07eS6nNBqKjk1wOrUB/3Og5BfL0/k26OJbI0ZYZZaDeVOn54qBGb0WSG64rtMp2hW
	fp1Oh/StK+J0cStHDgJTWSYHlhfINlO9PrXgsPUuaphRBEOIV1n2t4YC57UoqVDI3tfXYQA9Jgo
	dFQWA2nrCtrx2im60KKKNkWXCxtcCibRIEIfAoInUw0Me34WMVuYfeFu4gALGH6V2Q61I2O0YeA
	3QYEHDvLyd6yq+s4b8Dc1YjXG5tqOYaKKlsAV9he115eWua/giMs=
X-Received: by 2002:a05:6300:2109:b0:342:6c97:3680 with SMTP id adf61e73a8af0-348cc5de256mr22035815637.53.1762272626387;
        Tue, 04 Nov 2025 08:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnDuSVihu0019z7oy+sRp1dedKuJLH1z+cP8yp0FcauqMuZpGj0DFfD3qXi5P4WV5PFumEzg==
X-Received: by 2002:a05:6300:2109:b0:342:6c97:3680 with SMTP id adf61e73a8af0-348cc5de256mr22035758637.53.1762272625750;
        Tue, 04 Nov 2025 08:10:25 -0800 (PST)
Received: from [192.168.225.142] ([157.49.219.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a80459sm2808606a12.15.2025.11.04.08.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:10:25 -0800 (PST)
Message-ID: <f4db2511-8aba-7fd0-9ee7-6c27fc3afc23@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 21:40:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next] wifi: ath12k: do WoW offloads only on primary
 link
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20251103-ath12-primary-link-wow-v1-1-3cf523dc09f0@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251103-ath12-primary-link-wow-v1-1-3cf523dc09f0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Uv5u9uwB c=1 sm=1 tr=0 ts=690a2573 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=UfEK/r8AT5XTvLeqrvTvgQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4lmNr4T_BIov7qbIXHMA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: cPV53SzRuGtCWnxE_eY7mhwlQqSh09bg
X-Proofpoint-GUID: cPV53SzRuGtCWnxE_eY7mhwlQqSh09bg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzNSBTYWx0ZWRfX9OQCUmf5ZB0R
 BPZjHPEnw3ZDU7AlC92MJXrehJldaSMWcNkOaBwrjIoZPRjPnRj24sj08db6kaeNk2M2wuptOoM
 aprexJdF8GFqftjHEvppKNdYHkytARqj7eqMn1ooEmDYUoyHw4Mq+QWeR9M7JnMglrRwvNQIJvb
 AWVUORcJO/gb0HEwQF5oxs7ik+DS1JkwWetj3ip+9wLYf7+c9ml2OlDyzX/Qcq8CmUfbsrKjdzG
 Rm1IT0Ubz49wvad7i0dP3nk3PLyn6kPXy/67WHyoHm4H/yMnr0yAjsztPsbsJLmy8OOQ5ZMtl6P
 SDlgyQukd4WCAONY2CGh6wsSXxNnClzUTRr6MshQptrnSYL0LRvwiCyWjrMsUfWky7vUHlSS43v
 qQ9tzWSuuQK4xa2HY8zCT9/uspfxog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040135



On 11/3/2025 8:14 AM, Baochen Qiang wrote:
> In case of multi-link connection, WCN7850 firmware crashes due to WoW
> offloads enabled on both primary and secondary links.
> 
> Change to do it only on primary link to fix it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: 32f7b19668bd ("wifi: ath12k: support MLO as well if single_chip_mlo_support flag is set")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

