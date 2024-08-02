Return-Path: <linux-wireless+bounces-10866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73834945F89
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06291F21333
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DF1DAC77;
	Fri,  2 Aug 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O4wuDubL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EBD1171C
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609688; cv=none; b=LYb6CP+ewPcIcz6ZWaSqTi9utkMCQu8ajq1mffpJgcCFjvgdYYh1k5OvjZ28cPUzUzrvpwgIqR0ltdOoRXYvTIkX2JJDPpAGEwaPzQQPoLYXjVq05ZfNDqSUxhA/BTg6Xf8E1aXYIkTOLJT05stVUE4pqM3cLq7X7HpXkYooo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609688; c=relaxed/simple;
	bh=3Kq1MpRsD5GEkfWbyFSfgSGuoyv96pfzJlhaSktd92A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iAKV5PmsXOyeMpH3Nry5Wc4b0wIs4R2j0+qKZES/Cvl45PW0juTeKswybyN5CnKk4yWmMTF9govzf0r/nk2sRYuGDIrxARHXSqlh9b6D4PS5mJ85Ww9BDQQgu53YtQY50VdD0iRE2IvRNlw5nAlv2LroKHU22ZSVwf6TtZxGiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O4wuDubL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Lb41W009996;
	Fri, 2 Aug 2024 14:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VAMfF463m7bTT5sFqa4WgaxnfSC2EPKRih83ZfpBHNQ=; b=O4wuDubLKByCOOXb
	NfEgwxQ6r3FAUkcu/4kQnuhS8AUm87NaQn/29bNWq8o8H/xCFYf41RF5W4VFgYQS
	12YUmb2C5D8hLMXsd+MvwJvWjuj1FGrfDIT+P4Rv+hmVS27WMxsfQgKs+NZ8nJzR
	IcovpiK8YlzvYlU/WAFshRrl98d54afKpHDXqq3s3HHDFIsIVx4Tohxlsms4AdVs
	irFqFqtToU/Pr0v3uGzgBMDSpUrYq/AzjIWlYXRWSJD7+PfYkziX0aUQfloDaI/h
	TLFg6uoyxw6DA3tyiRD56k9sXv33gU8Skh3/e6NAp3X970xlBlzGrK6gh/+3aP71
	SeBooQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40rje6hw2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 14:41:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 472EfMXB024834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 14:41:22 GMT
Received: from [10.111.177.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 2 Aug 2024
 07:41:22 -0700
Message-ID: <011f69a8-60cc-47bc-9ea4-2091cb5d3747@quicinc.com>
Date: Fri, 2 Aug 2024 07:41:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] wifi: ath12k: report station mode transmit rate
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240801112853.85508-1-quic_lingbok@quicinc.com>
 <20240801112853.85508-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240801112853.85508-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WWhSkizR1DSEgXLj8G8QjsluXOHFVZ7k
X-Proofpoint-ORIG-GUID: WWhSkizR1DSEgXLj8G8QjsluXOHFVZ7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020101

On 8/1/2024 4:28 AM, Lingbo Kong wrote:
> Currently, the transmit rate of "iw dev xxx station dump" command
> always show an invalid value.
> 
> To address this issue, ath12k parse the info of transmit complete
> report from firmware and indicate the transmit rate to mac80211.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> After that, "iw dev xxx station dump" show the correct transmit rate.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  872 ms
>         rx bytes:       219111
>         rx packets:     1133
>         tx bytes:       53767
>         tx packets:     462
>         tx retries:     51
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      403
>         rx drop misc:   74
>         signal:         -95 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



