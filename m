Return-Path: <linux-wireless+bounces-10129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C9692BCB1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 16:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4B61F21499
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA03188CB7;
	Tue,  9 Jul 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KUmqfjOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FD15B980;
	Tue,  9 Jul 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534678; cv=none; b=H/bVAeJ6n55moBZ67WZsPHytXOzhkhinGFSCka2j+a0PelYlCV9DIRhUHj9SlQKWmqxyhAN84tXAjkCm1RGVeZvrdV2FRo6M1ACZZurQghflaZnTmdIhaxJa8uVxly9B+2+n5qZAt0FeO38WkJlmAciOoCVq6+SbTiQK2RBpfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534678; c=relaxed/simple;
	bh=d9OIMlWFAQq6nDGQev6p6KEjX+sSzz2+tjC7CnjeF14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uiSxyUe/28v40cSP72gizpAE+oaXrC+LW8xDv0k5Yl2IYC/bLhjWGtiDTkazPxNsmFg6PRRTbR7OxLFBCPIUIDtCg8HcL6R/nbTm5DkyZs9+Lff5eKKIprP8dhlsxe6eZFGn/Sxxol69ZKasu00h1MYGZYJ4cyUZksXMNgCHfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KUmqfjOF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469ACx1Z007224;
	Tue, 9 Jul 2024 14:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y9VA1iza+h9B8nN+Svz8hwQkj/T4Z31pBXmI7RGF0+g=; b=KUmqfjOFGgbIqx4S
	9NkyDaGWcCtFIsZnhwjk6Fv41rKyRJRmUTYe1Ub4GjPU40TDzhrMYvedWNw1ptNL
	2rzVbxv7TN7OvvaM42JYSg/g3mSzR4ihwdiRNhcIk36o7LZouzP5YMqP4Uh7Ug4K
	AOtjZ5JxKruh2RNuU/0BuhYIBJ5zimRfKHnMKQgGYvd5wuy2t6fo1AP9Knf9FMro
	Ei4stSpOZmkrPHcyOYP1JgImeL0JwLCOypenrbxSyORkZG0l4FFI8mR9Z5+v56uW
	3jPCVdSet+dH6NpraqNtZyCl3yjBjHIi4Zb0a/iW6J9qNecg+vcbxihrRe14nxg2
	z/v0Lw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmpsv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:17:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469EHlbq004711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:17:47 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 07:17:46 -0700
Message-ID: <10b11116-0523-4035-94d8-af244c96ed5d@quicinc.com>
Date: Tue, 9 Jul 2024 07:17:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix soft lockup on suspend
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
CC: Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        "Vasanthakumar
 Thiagarajan" <quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240709073132.9168-1-johan+linaro@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240709073132.9168-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dorYZWuIwxNM8yS7s3Pl5bwj3ID3Istl
X-Proofpoint-ORIG-GUID: dorYZWuIwxNM8yS7s3Pl5bwj3ID3Istl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=615
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090092

On 7/9/2024 12:31 AM, Johan Hovold wrote:
> The ext interrupts are enabled when the firmware has been started, but
> this may never happen, for example, if the board configuration file is
> missing.
> 
> When the system is later suspended, the driver unconditionally tries to
> disable interrupts, which results in an irq disable imbalance and causes
> the driver to spin indefinitely in napi_synchronize().
> 
> Make sure that the interrupts have been enabled before attempting to
> disable them.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org	# 6.3
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


