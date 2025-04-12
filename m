Return-Path: <linux-wireless+bounces-21460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A17A86AC2
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8501B841A8
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB221662E9;
	Sat, 12 Apr 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iHJPmGwv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED72367A8
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431852; cv=none; b=tAeJRlPBRBHObjlqB2QDQJukyvfCofesPoHCe9o2pug3dWUwQ4Cwf3iBd9GoXAZYBh/9/DAhgzaRgIqSK2n/sUCPN0hwLEwGks89yxH4z/lTq7XITv9wCIHqijWZmoxU1tdfn5Q9BFzYHnkJlbHgYW0nvM3vBqyCtBI9Ceblk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431852; c=relaxed/simple;
	bh=SmASm3AXED8XjkCwF3nX7B/usTnqP76epJD2oZm5Qfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M7dYO7DmqtB1L225aUkcS6tC5DcE7Awi+mx29cLYfqZMWXg9clYDULfR0Z2C5Q6dpdWYWcG9EDVSO859g3NeH9RlSeHmQeWayqZW42mo7lTNwg3lFYmZ5rcWqnXoXKab01kxbSPPCo6Q2oW4gcszWRFXhdip93MhROiI2Nm4QDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iHJPmGwv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3jaN4016182
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v/rfn9ekfwgKGh52fBrF3Oxr8p4f+ryb0UbLPbGsRYk=; b=iHJPmGwvuZq0O++h
	00/FrVqsLdvLI9UDMlQx50Q/LtV4/4xiqDGsx6VqwS6nDSwNzXQ0knTKU4qMRTq6
	7A32jjpd1WSkmeyfH5ywETEzhx9Is6R5tTIErV9jIIim66wWUUFYIFzRtVg5Tpb5
	RNYpEK9Y+1qBiVEmN2RfOUOd2Ee7O4mYgQCre8E2zyIndZUMc1+t1Dn+NwxBrIrW
	QcjM3fX0aE8WYn9ITQZWCJWHEKDrDQ/ACI4zUIb6iqsBQ/di1qXpN2f7cLOEbll4
	b/LBI/UIfq+E072kfDCEcmpj4iNlcx7Z6uGlcrOpZz3/xeWRAJcjOS8G8nssSAOF
	Hs//jw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtbcd1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so2712449a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431849; x=1745036649;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/rfn9ekfwgKGh52fBrF3Oxr8p4f+ryb0UbLPbGsRYk=;
        b=H2M6wHyQqdtjDeZspibZMg/qLTfDSIbqtyBLiiSgqI69h5Mi6CLqLqQFDFwJCbxDPz
         yttBZgnojGEIUR8H66i93qfLNZosfjzM2DqoOeb/3RqtapZMuUkyKSgxqdA5jmy0SBbu
         ShYaLaGtt7piyIrD3rjTUWAftEKOenqPQwIgaSuekKL7nJ5MDPGWprmOcHLbdnT9IKaC
         86cUmjdijSWRARldTg+qGEYR9q6XeKvqyFbpm4IAViS5KBUr4KFFZsco8ZdnbAL5Vs+N
         5IUwI9NAySDUvkVOny8MN4bvwWEEMWrH8OhbGHrku7Aw/pg+2YeY9jbJvIv8ekWGu75M
         4GCA==
X-Gm-Message-State: AOJu0Yz/B+tD4zoSw05xOaOxbfGODWVpCYuLIJXCqhvmcf8sU6Vl58S/
	sddfgS/f4e29v376jQcY4CWP34gugLWHHr5GaIWK+pWN68A4tdrWS6xS2SPp4LuDOmt9d+JnVJ5
	eojLM+y20LrZIMlOJQag4SVrsk/xxnL3WNgMPfS9YpKGAwBOF33LPKYNYe6DWAOAwLA==
X-Gm-Gg: ASbGncuW7NRaOp4vgcNCs/lW+iem+UQWxvgi0igIL7F4lZH2HIVtEIPAk5Bt8HOTr0p
	0dwqOBY/lecloayun29+3MpMJKw8OgX6PKdow/nXL8Q/zKyAnK2+Jwe85HbkClVwfd+Jt00PZwd
	67RC3tzQVjmVvX0T5Yixu4iaaDBISkLCH5iC1hc6Jtok6vdQqGLyVd5m2RDWAq7Er9O8u1lN5RX
	QA0scZ6v62NzsSO7/5DUlsq1G25n5nj56frznBtWiBGKkzq9lzBjE8S2EAGX5Ac1EVt0CAhrsC/
	o+nQ6W0SGqYZSZneaqCLfChum1Bfh7CelMEMqfm7rj2R/RxF
X-Received: by 2002:a17:90b:2891:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-308237ce138mr4115140a91.30.1744431848917;
        Fri, 11 Apr 2025 21:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmni2XqUHIuZE1euURYN7ChvjsmXunDXEvq3EGa3TLtkCH5qTOkMC0aAyDH4+SZl2XFryD/g==
X-Received: by 2002:a17:90b:2891:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-308237ce138mr4115116a91.30.1744431848357;
        Fri, 11 Apr 2025 21:24:08 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:08 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Cc: linux-wireless@vger.kernel.org, quic_tamizhr@quicinc.com
In-Reply-To: <20250409155125.299380-1-quic_bmahalin@quicinc.com>
References: <20250409155125.299380-1-quic_bmahalin@quicinc.com>
Subject: Re: [PATCH v5] wifi: ath12k: Add support for link specific
 datapath stats
Message-Id: <174443184775.2972989.12552157443068329214.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: Kr3pa6cKxJhe8eJ7Ry69iIluW2VofZXz
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f9eae9 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=gwDi3P6tQxOowQPbMfsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Kr3pa6cKxJhe8eJ7Ry69iIluW2VofZXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=891 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Wed, 09 Apr 2025 08:51:25 -0700, Balamurugan Mahalingam wrote:
> Add support to record the number of frames enqueued, hardware
> descriptor type, encapsulation/encryption types used, frames
> dropped and completed. This is useful for understanding the
> datapath performance and tune the peak throughput.
> 
> The link specific stats can be viewed through the below debugfs file
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add support for link specific datapath stats
      commit: 5e0097514dfb923d27a49bd8900a649d3a50dc4b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


