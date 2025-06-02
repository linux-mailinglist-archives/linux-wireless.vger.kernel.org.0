Return-Path: <linux-wireless+bounces-23536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CDACBA50
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 19:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269AD3AC87B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674351C8629;
	Mon,  2 Jun 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0ZI9Lcx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3ADDAB
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885357; cv=none; b=H37IHlNta/t4ESq/IPpDBw2GIDUI6eQUZ8d6Ojatmai/XtrYHs1ZLHo2RgtFoLOI631HbENN0dP74I5RX2sk8ZMHnyEUCVYgk9cBhkIUdKI7H/7UEC6JIwhyTj0tY4YMfGNrEzVaUbiqc3Jpm5lAFXNqBiEDLxWNznjNdiNN5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885357; c=relaxed/simple;
	bh=Oef/CcOrJr02mxd3NtDi+4Zc2Roce9t1GAEKchkdV/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8ekIRncxm+Fk+igBolLFgvD/WNGGsX8dT3uL/zp+pgrUMklomOpW8nD9C/hOa733vO7peWyWaVKDrC56UWGUQ0d0fKxyPcuZZHR01jTG7++qAQtnxatLdpysA3f9+rJQl2n+Qy6CjZc1sU3DZWrTBZjpvDJgDjVja9e0AZQwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d0ZI9Lcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HJjwj007548
	for <linux-wireless@vger.kernel.org>; Mon, 2 Jun 2025 17:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yk6rWolYJemBdD6MBou1f4X5j8FMZQ78Fl2r0hRpViA=; b=d0ZI9LcxWQwGVjb5
	ZzxayO9vhGgOSityP5EMUhE2bOQ2Ag8vVmpYtp7TCPYVtIV96VNbCr5XucsYBc5O
	2oYDSW3n1+q/lark50T9nlm63fKkrotNQ24z8jm5IajeoPhoJ29zsereTylHwr6V
	gDXc2RprcKuj9o/v2Q603bu8nCir4MEwgYQQ339f68vkdS4jsV9z4is6v98VdLwh
	vXN0k/gFVwdet/jwxIsvNLuDzWXdKPcX9THq/pRsIJnTZ7bAlB7abGwUS6w2sJG8
	OKwacRnSHDyXWhEt85cRu48A8N0HCvJcSZ6cqhFbytcMDzJDukJ6qkFk6NTqQGS4
	Kd3GHA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t80pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 17:29:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-312ded04e68so320052a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 10:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748885353; x=1749490153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk6rWolYJemBdD6MBou1f4X5j8FMZQ78Fl2r0hRpViA=;
        b=v0yOKEo3iBfnM1raTCRThI1j3dj9yu38a83U1cLjX0kA+qqcJO1+z6LCYcIAhKJAtC
         koeeFElhmWFeGoKpfgjBeki5ioUR1G/7YarUcJwv2c6TWq2jIZplCTQlwU8JpURxrqoC
         QQZzJyvY6KLspw53yx4R7EtcdsmNiBpIq4b89LVv/Sg27IwJsdRyPgarte46wgyH6UdI
         Z3Ih4cSvjbncS9FNAfskay6LxfuPh2eNyxs9tDEsgNLXAdL5jBeJfoab25VEZyryoU8s
         FhmWOmAVgWmmqbbDC0WvIkLt/D5PzvP33Ki+zSs1ZiaZZazVh99/P6mxmZzuWHh4gZIU
         4N+g==
X-Gm-Message-State: AOJu0Yzmufz4adm+JHAlw6oRoIQ74SvaHXDSQn/eDg/sO9IqP7PDXtTB
	CXIYrw+VsYVmKm0U+5TKJs84dh3B+jsUa6wAwcbcf77veXW2pGUxOsp0/wxSK0nzfsn34oJliye
	0NEBpYWJ3V3FqmSODWDIt3ISlM+sn3cC2EvCx4qoRRBhmMbCR5OfxucJuelPeA3rdukJ2IQ==
X-Gm-Gg: ASbGncsXPcqsPbHFqwDKoaQm5v3sM9y+YjIDCMBG8OJvyzCUrU94oiUJET74tsILB/E
	Ft6n5sJFyN1wbxuqQMELU0Cx5lkfULAzSnB0LhyS3BypqYPxuHTq7fkJ6zArsrtljI0aNPLsczs
	PQR2Jy3Ao2FXR3x37rArmagZoUsAjXvOxu77W7z6ipnlvHNkjpcW8XVjBf5UlZTOUz66LAWsoSD
	oZk6WW24s8OF703kuzk9GxE6b49pZljf2HlyMtJSFlPP6r6Yd/UvKC6E9aVrQukcjKVhQA6e8d8
	McvPk1UN4yAznK3Sd4CsE8XEyK0uM330ivS4vBy95eUnx8PVmEfFPg2VAOwq/nNLmN32vDimKBn
	vxddbicD8b/gzBMPjq9/KCpNZq8X50ugLGJQ=
X-Received: by 2002:a17:90b:2f0f:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-312504538f3mr18840625a91.33.1748885352942;
        Mon, 02 Jun 2025 10:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfUrJsmpLDb7QMJI1xGYYommWJtFioQaO7nwSCM0daCXy1FJ1+DBp4tUsZwOFxjlScDulTyA==
X-Received: by 2002:a17:90b:2f0f:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-312504538f3mr18840587a91.33.1748885352449;
        Mon, 02 Jun 2025 10:29:12 -0700 (PDT)
Received: from ?IPV6:2409:4072:6d38:213a:f95d:ad03:27f3:e9a5? ([2409:4072:6d38:213a:f95d:ad03:27f3:e9a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3c13ffsm5828869a91.41.2025.06.02.10.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:29:12 -0700 (PDT)
Message-ID: <3290279e-c577-5c05-1f4b-ffb3078d004f@oss.qualcomm.com>
Date: Mon, 2 Jun 2025 22:59:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: disable pdev for non supported
 country
Content-Language: en-US
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>
References: <20250506214930.3561348-1-muna.sinada@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250506214930.3561348-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE0MyBTYWx0ZWRfX+1wtn8277tQb
 hvXkMGYufFZLErDWDJO6ApfkB2sNYHuf32tCTZxs6h6V4b7kVWxfmCSDtLl5nBKb/MFk6yxrpZA
 Arow0RZAktp0rwrDkBSuaN775pp//szxP1UDmMUEbIcoXYKNPYuiaigVg8uKw6+GkqnE7r8ZqVq
 ZvrvQt372DWvHlMWOPACu2xIhXhmkUnwVFuvHIaqUg6nC4EKPA/xAa4E6i6EAKCpBViJrtw3Gnb
 T1zCNFq9XlYZXqGv2j3In75LNqg9rRaTUPu0WMn5xrQDgHCCqmIkyCznaqokk/9MxTV/VaBCHv9
 y+r5fHes2CyNm/jj90ezCEz6YiEN2/gQf5h10BPma3YRjVkLuMCzePnyRrhi7I=
X-Proofpoint-ORIG-GUID: KuoeUthKQBM9yfE-ZGrpEEupIphYQ4ff
X-Authority-Analysis: v=2.4 cv=OuxPyz/t c=1 sm=1 tr=0 ts=683ddf6a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=j1_G22Jgsno5ajverhEA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KuoeUthKQBM9yfE-ZGrpEEupIphYQ4ff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_07,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=608 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506020143



On 5/7/2025 3:19 AM, Muna Sinada wrote:
> From: Karthik M <quic_karm@quicinc.com>
> 
> In MLO configuration, ath12k_mac_radio_start() iterates through all
> the radios and makes the ar state 'ON'. Even though some bands are
> not supported in certain countries, ath12k_reg_update_chan_list()
> tries to update the channel list for all the active pdevs and ends
> up in the warn_on for non-supported band.
> 
> To prevent this, disable the pdev when the number of channels across
> all bands supported by the pdev is zero for a particular country.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthik M <quic_karm@quicinc.com>
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

