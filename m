Return-Path: <linux-wireless+bounces-18166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A4FA223EE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 19:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDEA16607C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588241DFE2C;
	Wed, 29 Jan 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="daw3hMH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477325A643;
	Wed, 29 Jan 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175541; cv=none; b=TlLCK2kg80sojG2lf1XsEMl8Clr41+tmADID+WClhaiwbJJC9QxVwWVXn5VpIiJVPcowQgLGTAZj8RTQ8RbEyv+TFwFTqLW4al4lPHoQA1RJ9TqJbYm5zqW/wTOCHlV5HPkHuIn18yajcvyGKUJpy8k9XFvvzqwrmtObvkitzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175541; c=relaxed/simple;
	bh=fdINn5ZVXcAHMJidAyQoexqzAz84w/QYget/mXSUckg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KJyeYmKFx75irRNTWU6jQp2uqYgYs8FtmrgRy9/Ihn7HbQAF0h+XPLoKceOBvK3PzV9ne14jwGH57IZ/WZOVovtZobUk7rd+BGRweFXHYrdGwgcvvvX3Jz33SvPXRX9+7w0lvN4Sq2gxYJYdAiUPfyCByN4DMa235xmAZjIUlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=daw3hMH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6OeUT004269;
	Wed, 29 Jan 2025 18:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sAEETuxW5lVZ2CcIMJ7LkFqNGzVvXQk3ted4/hCr4kM=; b=daw3hMH/i7fDSIhp
	KIjk2Wy48xcWQa7sZLR/d6fm5Wg3PupRAQglaYvKaYAtiT/PjfkKPI4IT/jWpSBF
	zKFRUrX+do/AfH5Bz5cSul/P8IsX/RacJtqpQRTiHv3MlD55hDFzSGhWWOeFdE4V
	cfFa9d1uR1DHYk/dfQ+Da9Zq6DaDfSQmBjOZcervSkRiF9G0Sn0aVP5m7HzcmPwB
	Wl5mm2L2Pyv7vLIjwKyjCnb9Wbueu4V8GQUncZTPJMLay4NB38BaJKyCh4sOEZym
	SK8AfEkNCCk4pzwmnPwY9Ra6BIIlGCyJAjEXmznEp5gO9rW1ha51lLHQ9n8q5rKR
	DON7mw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ff1q1cpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 18:32:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TIW8fu006128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 18:32:08 GMT
Received: from [10.216.5.143] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 10:32:04 -0800
Message-ID: <4abbf772-8254-4892-be3c-6d7af708f459@quicinc.com>
Date: Thu, 30 Jan 2025 00:02:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] wifi: ath12k: Power up root PD
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <20241210074159.2637933-10-quic_rajkbhag@quicinc.com>
 <a76fca66-70ce-4a6a-ae39-dc218d57fc83@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <a76fca66-70ce-4a6a-ae39-dc218d57fc83@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wRD__r6WivKRSjwy8nO06XA99-z_Icad
X-Proofpoint-ORIG-GUID: wRD__r6WivKRSjwy8nO06XA99-z_Icad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=991
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501290146

On 12/10/2024 8:20 PM, Krzysztof Kozlowski wrote:
> On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
>> +
>> +static void ath12k_ahb_unregister_rproc_notifier(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +
>> +	if (!ab_ahb->root_pd_notifier) {
>> +		ath12k_err(ab, "Rproc notifier not registered\n");
>> +		return;
>> +	}
>> +
>> +	qcom_unregister_ssr_notifier(ab_ahb->root_pd_notifier,
>> +				     &ab_ahb->root_pd_nb);
>> +}
>> +
>> +static int ath12k_ahb_get_rproc(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +	struct device *dev = ab->dev;
>> +	struct rproc *prproc;
>> +	phandle rproc_phandle;
>> +
>> +	if (of_property_read_u32(dev->of_node, "qcom,rproc", &rproc_phandle)) {
> 
> You are not supposed to read phandles as numbers but use proper phandle
> parsing API. See of.h, e.g. of_parse_phandle.
> 

will use of_parse_phandle() in next version.

>> +		ath12k_err(ab, "failed to get q6_rproc handle\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	prproc = rproc_get_by_phandle(rproc_phandle);
>> +	if (!prproc) {
>> +		ath12k_err(ab, "failed to get rproc\n");
> 
> This is supposed to be dev_err_probe. Lack of handling deferred probes
> and resulting dmesg flood is all over your code. You need to start
> supporting defer.
> 

Sure, will use dev_err_probe() in next version for all applicable probe error log.

>> +		return -EINVAL;
>> +	}
>> +	ab_ahb->tgt_rproc = prproc;
>> +
>> +	return 0;
>> +}
> 
> 
> 
> 
> Best regards,
> Krzysztof


