Return-Path: <linux-wireless+bounces-18173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF57A22771
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 02:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D217A259F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5E4A35;
	Thu, 30 Jan 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WdNayDIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523564431
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738199938; cv=none; b=AmyQcYCuVp/GiYpoaeepf81PgO7EDj9HqY21jepMUDfuwqDcyJZ/O9RD7TV/SoZHtDdoaslgMdLpycUjKbFEtIlhlZRk3eC1JEXhxl3aRxzI0lr4i+G668bV8fClIO4RMfBWceXGIc1faj6XoIpc4LPVBsKLhYBFV7sABNJ2nV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738199938; c=relaxed/simple;
	bh=Yw/fIrkPo7x+gFvoB9GVNIP9KniGFZqFlMoBkAHFIeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If1y81MzGMsYJUpaJHDUI60e1uOxU0yCn60O8J6y8WspdFd7cJxATvuCRS9e59UneRCX4fRqFy2ivHMgRKkGaT8ncdjLPN1OZERXGAZ2POf6ZKqLqudPhIl4UVE3ZohxFRcAmBo7aP/Lbptfy2XCDMCd1eXVtCwmtvymVF2GjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WdNayDIX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TLlslE030325
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 01:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yvqaCWS17IqEgzdZAzaY4rFjPD53xUcgJY1W0zmOwSA=; b=WdNayDIXhwaBUKaA
	r6C+Ln1x29eiLr8V19AZYD1E304RhgZsWocD1nltvm31seaYcHfaaFF8anG9Hn9b
	27ki1OhHeMCnYHeJFT3+7ORh0l3rOSRkrQ8s6NMDnp+YTUud6YQ16WZ1YkRhtKHM
	rOWlNTQIcL0jAVgMLW3vxdw+NvtDoMi2MRbMNkxGdkF2A/c068/dF5bNnzbdyhS3
	RS2oT8fdNAnU9xXAM42YTACLU4idaLe3QBiCKDBvt1CS8CS/4pW6c/bF4jpyasdu
	dyfVmUmcnQX/6mt/KfwAKyg8mMkPBbyQdjbIpYITUXhQLk6I5Rpp4v8TFWNVm4hW
	b27R9g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fvjcgar1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 01:18:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21dcc9f3c8aso4258215ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738199934; x=1738804734;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvqaCWS17IqEgzdZAzaY4rFjPD53xUcgJY1W0zmOwSA=;
        b=ilSQ7th4vLgB5/cYORb6Eo85lDTQtsHOn2huL+2liSqr9ohGEoloL5vRF9vpga73cT
         KAHzvxGbcxf30kAjQ+x+oR9hhZeWjjHoe8oVS4s3nmUBJ/LFcrQPmxMBR5Gv5/2vYGn9
         WxBBMMLGqsMguXQRj984SHT9ZASX2wr6uoL4Ji9Hiv4Jw7rpRmea0TvtJMx3tHAPGy47
         m3HcIYGRFpvJVyOnXLOIEeess0lsWFK7b74rDkqwNLFhEPCkiwXgwjk4obJ9QrSRrVkP
         SuZP7O8/V4/JX6vqLc1Ia2ws87Jw0o9mpYXEn2zgGwDL4R8BLVKhwDxwcXtQG9rIx55k
         s/Tg==
X-Gm-Message-State: AOJu0Yz5w+bKH0YJWU6diBSgCgD2a2miiwlCaztAxM2vYNZpsDHRn40l
	j9PlJSW9NaNU7zSMYmqCXAUDDbch6ZttFB8mfbmoBpmMmGMDAcqRSfOUfE55gVe013tcqlkqg8P
	CoUV5vbbW85iJK3nbR3dZhpuL/fEUz/syJnrpEsHr26U+SpNalAIOCWpYZFwpqmpAeg==
X-Gm-Gg: ASbGncvYnKBuhtCJZiD8fFx8h5rM9xmyIxv+nky249tnMQDU6b2xJIG4L23QQNXLpzp
	pjP84wiMORLdtAWl2PIpTZGOEas/9vSmW/Bn9THsei8eHnJZ43Ul+jDN8hXJZFPa7fv/YDr5iOo
	71TQiLKCrZ66nzQecwqlq/mUufgqbVvia84HIZBzX3DqHhWvtBR5lritLo+zhPQ7txg7L5NCxuQ
	BVxhpT9FQ3OngHJDiz3/rX+aEB6cTNSsw9VwszgCSGQZ1kNo2IwsKqm+t75XvIRFp3Si1jwHo3S
	S9tpq59KX1FoAwMtcjTd3GcP3jQCH6psl3ezPmGTlv1g+KxZDb5q+Pc4cIjYhB+M7seIb/IqRA=
	=
X-Received: by 2002:a17:902:eccc:b0:215:5bd8:9f7b with SMTP id d9443c01a7336-21dd7c658c3mr77792885ad.15.1738199933816;
        Wed, 29 Jan 2025 17:18:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmPyNl4jBHg+pVC4DhmaWZfxo3Dj5bXKsKpiY749cnUuOVg4TO2EeuYKq32gVAYC7P19h9SQ==
X-Received: by 2002:a17:902:eccc:b0:215:5bd8:9f7b with SMTP id d9443c01a7336-21dd7c658c3mr77792535ad.15.1738199933416;
        Wed, 29 Jan 2025 17:18:53 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32efa0csm2322695ad.116.2025.01.29.17.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 17:18:53 -0800 (PST)
Message-ID: <2b5bdfc8-95f2-4919-830f-c35d152055d1@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 17:18:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath12k: fix handling of CSA offsets in
 beacon template command
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
 <20250124-ath12k_mlo_csa-v2-2-420c42fcfecf@quicinc.com>
 <6f52dcd2-3b0b-4c19-b8bd-cd17dc4543b5@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6f52dcd2-3b0b-4c19-b8bd-cd17dc4543b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jCwHVz90KuSMrQ-5gj5_Vvu4vlAIvHUI
X-Proofpoint-GUID: jCwHVz90KuSMrQ-5gj5_Vvu4vlAIvHUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_01,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300007

On 1/29/2025 4:40 PM, Jeff Johnson wrote:
> On 1/23/2025 10:16 PM, Aditya Kumar Singh wrote:
>> @@ -108,5 +108,6 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif);
>>  void ath12k_mac_get_any_chanctx_conf_iter(struct ieee80211_hw *hw,
>>  					  struct ieee80211_chanctx_conf *conf,
>>  					  void *data);
>> +struct ieee80211_bss_conf *ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif);
> 
> This patch now conflicts with:
> wifi: ath12k: report station mode transmit rate
> 
> but i'll clean that up in 'pending'


please check
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=47bc4c5c6598ef2ff3a362eb13dfe4573ab5d910


