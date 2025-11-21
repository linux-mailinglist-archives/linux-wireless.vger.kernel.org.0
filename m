Return-Path: <linux-wireless+bounces-29221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173DCC774EC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 06:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 423532416E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 05:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C72032D;
	Fri, 21 Nov 2025 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FoF1WAV3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GJAvNWN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73823EA82
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763701261; cv=none; b=kP0bKvGwd4eRtD9O6UizTOoIQB6QWMnHziVdjLZ8oE5Th/TmW0bnjpOtbpcuL45yQNTj8rVXWY3B4v4HeZfdDGf/p4QizeY/bzn3Mlhq8IMPooCkbxKOFNTR7aj+nRE5D19r1UHmPr+MXVwypu5cMGq1G8pCDEBO1SsyIz56ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763701261; c=relaxed/simple;
	bh=lbqWSpPH6GEIOINpPvsdssttEV76u0rT6ceiq30svAc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MoUp270rhuKwV379IovN06zqh4frwXNxqRqRCYg3tqv6BkelsAn0QR01bLj19q0wpRPF58FAD/D+dtW/F4KKkCEIdqIw2BplEJm2557a0k+hgIoQL/kdMesQC02ZQ/7EN3prBRcvi30lOej6Ba2xssE+Nbg63jPJaHq5KD0xsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FoF1WAV3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GJAvNWN4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKKArd01579535
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 05:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MnA4CKR/bhunOHOYeKoUfM
	bGWiO2RNra8goyL03dK/c=; b=FoF1WAV3E/6RxlsfgX8eb24HNz2vbJyRFziip0
	w0pe6lj3FE+uceuWTkfpZf8EVVxIq5M4YCmeTYRj+XbipXHvDbdb/LufSsadHWw+
	VyD7VLxixwVbw6R/Qs9ek6cl01q1NXO+S2028JJezNlvVzSlSh+Rkp1mY2U/GK6m
	ruCvVvP+eiekxEo/0mb/uaROPeLsnYxPIW1l6Y8ZOIcIsxZ5RGDMrwEsu0Q7UfQ+
	RwAYc52dAX+xYmySwOoezAqEXj3k8HixTQ69jPfE136lnhEDXAXf126aYS+ae82/
	GW6PbOqIAx7b/qM2SASRkXI7rGTEUXso/VTwgCItBtDOqsLQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahwd7bwpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 05:00:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958a134514so24813905ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 21:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763701258; x=1764306058; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnA4CKR/bhunOHOYeKoUfMbGWiO2RNra8goyL03dK/c=;
        b=GJAvNWN4iRipoXQPDvRKyQSpSyAQvfb5rp6qJ18d7GPV0IuEGLSgiE0Q9jmftfKs9r
         qd0SooT+tfFlwzNYsFpCC+FM7DcZausyHx4snnlCMp0uo53V1SgKg6mPHMgTpjjFapvb
         gxFRHQScxiaJ1y7Jr1QA3/0PbjleyW41Aml1guaJMl9BNVwLQDUzxKWKBToIm/pc5iV3
         6LbUVupeXUn5mndBVGjIJYsfUM9op5i9EFLYrCnwtVWoeSI6eHcBbVC1lzn+4MSPwIOx
         fGDlz48zZY9LGEuFwhA6WfMQG3dFydZIyfu4c6UZs+fv1+BTMICUBqad+91zIzStjU5g
         lMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763701258; x=1764306058;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnA4CKR/bhunOHOYeKoUfMbGWiO2RNra8goyL03dK/c=;
        b=czBFF1moiZcpNPoxPUb5r8qNwlH9m4VCpHMOet4xZQualAWNEVbEAeysZ9PixJkDZE
         2+2OC/jZQIDpx/4+hxg5i1mrojEhmmiqKNTewKuxtAWkDHlomgU+kSsi70fgl6A15Gnn
         AEwitVtpY1aT56TAqEKh75tqMj4ezxPi9jw1tYgc2UnZT7CsVrytmDgPJ3K0rGzAVVAO
         QsUg8pA9cqb/PXL3FVB2priGTPUovcYxwhMGnLf/rwfWomsWxl/9hxBCoRlmFFox7FHD
         8aD5fjGgRpLcT0lDasIe1EHodbL7esUPBdqy6Cx9HqGEVeHATJcnVzA7A7cxvH+U9fvx
         CGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOkNXkkJp6w2daKcZ4DFJ8rrvNDrlbr2dXVUpfbMit3il0abmZsRSgtjMjWpZGyq2MuafH9+U90m6wa+UhTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4G6GFQdJ9F7UxUV8PP/MT6H6vEaWwD0z9WvSYIuKQSMkbbhw
	3xcHbqV+v1OPSbJ7+idF3iscQH2eUStOgbw3ss+UdpWGTbbiHOFBUI8lSKQocY0rh7kyAkMAZ1I
	1aLJdG+gY6cJMf2dcaOfZhVyQiHstn3iJSnNe2Pc0Zw67Mh5cm82XDQiqtQ7ExnwKNF+Di9gP2Z
	zJww==
X-Gm-Gg: ASbGncu+hurBx4GJSwov+YFPTbqMeTvVMQTtJU81YQbYo1evdGGK9K5VRriwND/Wz6w
	CKRe1r/LxpCgEsNtgvo36bDmOEsn63FseUEwiD7Me9rpnkWGg7dm1LujDX/Wh8ZJy9gGjyXJteS
	ckCVafIXmDPfmANLIIp8MmtCdJ70O+e0o6r6IA0+cinVn87fBLVi3+hoCljIfXdxpB2R3k1fBrG
	HeTjNhkmFEKX2qiO4y7fJRTXOUBvsSw62TA0xrLe5zTsJHWIQQ7X2A3SkTuix+LzQK5v/AdC40S
	gW0N56U99ts+9YcUAnIiVH73X5fWVBnSl4x04Un3xDDbdAEvEvQrYmSMgfNuPTCAAY0XzIpuC3y
	S25VWzK1YD+PK3hfyFlGYvxiVZ66xmuE=
X-Received: by 2002:a05:6a20:7d9f:b0:334:9b5d:3876 with SMTP id adf61e73a8af0-3614eb3a0a2mr1425242637.4.1763701257978;
        Thu, 20 Nov 2025 21:00:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhujF5cbGslHO2+GEhYqVOk4N2nb8ss2vvcIZdQ2Av8HQyiwMcln7gN6Z4wcWAY6AF5s+Vuw==
X-Received: by 2002:a05:6a20:7d9f:b0:334:9b5d:3876 with SMTP id adf61e73a8af0-3614eb3a0a2mr1425194637.4.1763701257368;
        Thu, 20 Nov 2025 21:00:57 -0800 (PST)
Received: from [10.231.195.11] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e8b37f1sm4223375a12.14.2025.11.20.21.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 21:00:57 -0800 (PST)
Message-ID: <3f355c8a-5bf2-4a74-9b35-daa8ae479736@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 13:00:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: frut3k7@gmail.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_yuzha@quicinc.com
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jtf8bc4C c=1 sm=1 tr=0 ts=691ff20b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3NV70glMY_Z50JQCx6wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: zW5M8UjcHwzx__1wWCFgRhCztmPEQbNG
X-Proofpoint-GUID: zW5M8UjcHwzx__1wWCFgRhCztmPEQbNG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAzNyBTYWx0ZWRfX3NYQ6wsbtkvz
 +nsN8yYTrTlq+5cOg9GgwxTGLySwf1IxbOarA1RKp8sEk9Ak9ncAS71KFH4IOUqXGBDSz79D6Nv
 Ksf9Lyc1wWsilegnOsZGj7BXlh9vne4GkKJtyPZe/m74e7jnlMuhaSvyUq5aiZ4bj0L2R7vuTxN
 SO6v+zVPG4ET8m06R/f4bYqXFYUH4joKLh/t/mgv8U8vPmJeYK0pC3vkgJhGr4Y1ofXSuvxusLC
 lznNkDzi6N/LcPbbk4QzDX0pI7TycD6IouIduAlGY1i3l/NpTM5CvsQMi7LbUjhrTUhA1N7nPp7
 OnRk+PxoggBTpX1ggFxUGdIry7iGtotXkBt7SBmfMA4ds2Dk0sNlfq39/7u/Ba3WczFs0miguiF
 MS1iPJixWwfqFUk2GwKqn+HOc7K5kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210037

hi,

 From your log/calltrace, I didn’t see any errors related to MU EDCA; 
what I saw were related to SMPS. Did you also add changes related to SMPS?

Yuriy

