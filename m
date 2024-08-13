Return-Path: <linux-wireless+bounces-11371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66DC950C7C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F6C1C20DE3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2DB2374E;
	Tue, 13 Aug 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O9lSvYb3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0E1BF53
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574822; cv=none; b=EDuz4qkBWYZ9xBAM9ARHMEAN6vBtAJ16PXpKFubVLHXPg2A7U5+IaJI7IlzZ3AdCj/R7ZHv2XHBCydS+0QDfAIBKUxnWtecT/ZWA8/g2G/YEKQESX2n5HYTq4H55jIe5wriGF2TOWxTuWhK74WIbO9z29ujJ30eQI9EDAFbyno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574822; c=relaxed/simple;
	bh=bDvxS1S1KwuxAuHcoCUWohBnL69VD14jLl+gbV7YlHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PYO+hnxwbtDKN2GSBg63G48psUzFBuN4NMNKYLZbxACNf5BfbtrxbYzHIjhhmZ0QJQnjuUypf7XfZth5y6ndjcgjZT3Irxopof7rv43f2cajzhHYotRNBb1sHOTshYYHs1sMiB9GWqE6x8rOwNe7Wb8UCbBSbM8+hZx9oL1oHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O9lSvYb3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DCY2aX016308;
	Tue, 13 Aug 2024 18:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iY4SfQzp4s5O6kPfCIVIirA4s79uMO27keGZLJs9RxI=; b=O9lSvYb3EbOTILZM
	cmk0GvoSekoua6aA1mDX+7gphCdgUiYrsLuob7JNKlPV20jmfFNSoOO3OVM4tEr/
	rLt9Dvng0L0UZMgPpJFFiwee+SS3Yfk8ER9tCyOmY177R9q/x5LGnTh1NbF63Xg8
	GOnzST9W1K2cQZkT8jZxwpOoZ1qnIUEzvS6Nv4yAHkV0o6ybsS3rKCH/J6NBQe5m
	Lgsm4e75vU7+bXCxsuOfWxVLsuiM58hyyGvhiUaEav6mOBRGdFR9DoYhJ3yL/u2W
	A0QGAUbukZKf72/ZGjC+ca/vAgdrkTpm0/3HVhMYxDybjntg7mv8Y3iTQMKMQziA
	BqtmSA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1chrpbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:46:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DIkniS026753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:46:49 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 11:46:49 -0700
Message-ID: <e60ca2b0-f3a7-4fc1-97dd-2540b548510a@quicinc.com>
Date: Tue, 13 Aug 2024 11:46:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wireless-regdb: Correct regulatory rules for China (CN)
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, <linux-wireless@vger.kernel.org>
CC: Chen-Yu Tsai <wens@kernel.org>, leslie_sen <leslie_sen@163.com>
References: <20240813-correct_cn-v1-1-26dec3cecc38@flygoat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240813-correct_cn-v1-1-26dec3cecc38@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 83Uenit43e6NQw-cNa_os0ba0vMefDQl
X-Proofpoint-ORIG-GUID: 83Uenit43e6NQw-cNa_os0ba0vMefDQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130136

On 8/13/2024 8:32 AM, Jiaxun Yang wrote:
> As per "工业和信息化部关于加强和规范2400MHz、5100MHz和5800MHz频段无线电
> 管理有关事宜的通知" ("工信部无〔2021〕129号"), only 5250 MHz - 5350 MHz
> band is required to have DFS / TPC.
> 
> This is slightly conflicting with is attachment "2400MHz、5100MHz 和
> 5800MHz 频段无线电发射设备射频技术要求", which stated that all devices
> working at 5100 MHz band should implement DFS/TPC.
> 
> After consulting authorities, we determined that the requirement in
> attachment should be interpreted as DFS/TPC is only required if the
> device will work in DFS/TPC specified in the article.
> 
> Correct regulatory rules to opt-out DFS and revert TPC power deduction
> for 5150 MHz - 5250 MHz.
> 
> Reported-by: leslie_sen <leslie_sen@163.com>
> Fixes: e427ff2a592e ("wireless-regdb: Update regulatory rules for China (CN)")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  db.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 788cd049ec21..9a55f6b8cc98 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -416,12 +416,14 @@ country CL: DFS-JP
>  	(5925 - 6425 @ 320), (12), NO-OUTDOOR
>  
>  # Source:
> +# https://wap.miit.gov.cn/zwgk/zcwj/wjfb/tz/art/2021/art_e4ae71252eab42928daf0ea620976e4e.html
>  # https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
>  # https://www.miit.gov.cn/cms_files/filemanager/1226211233/attach/20236/d1dc19424d5a4cfe90d631adeee8dd58.pdf
> -# Note: The transmit power for 5150-5350MHz bands can be raised by 3dBm when TPC is implemented
> +# Note: The transmit power for 5250-5350MHz bands can be raised by 3dBm when TPC is implemented
>  country CN: DFS-FCC
>  	(2400 - 2483.5 @ 40), (20)
> -	(5150 - 5350 @ 80), (20), DFS, AUTO-BW, NO-OUTDOOR
> +	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
> +	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
>  	(5725 - 5850 @ 80), (33)
>  	# 60 GHz band channels 1,4: 28dBm, channels 2,3: 44dBm
>  	# ref: http://www.miit.gov.cn/n11293472/n11505629/n11506593/n11960250/n11960606/n11960700/n12330791.files/n12330790.pdf
> 
> ---
> base-commit: 003c282a297f8cec06a576fe1434c94353d14610
> change-id: 20240813-correct_cn-1d2e30b41e07
> 
> Best regards,

You should Cc: wireless-regdb@lists.infradead.org
https://wireless.wiki.kernel.org/en/developers/Regulatory/wireless-regdb



