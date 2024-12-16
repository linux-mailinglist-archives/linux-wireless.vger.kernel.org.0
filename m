Return-Path: <linux-wireless+bounces-16422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DDE9F36C0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B797A7BDC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5BA207DF3;
	Mon, 16 Dec 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIzLm85r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40745207DE0
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367865; cv=none; b=pJ9Ls5wWRp9Ldy3OsCp1OcGF2J1m0M4na8lyNoTFl2dmpcs+pIJDrggiInnWWckxnpL00xVVvgVJDnpftHAH5k6zQSR48ALdfhRRX0BCq/7SyVlcZwu1QgETljyMKVY4EkgGU5qqHd2WFViJTOx1ABclRQRlazEL6bO0vv2bo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367865; c=relaxed/simple;
	bh=41pdPmUIVXAqHSup3nG97a+OnZhqonVA8oMg2NvxWrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mr0ZSW4/wIsUxHF/Yssqk9mQTuvKha2mYsz+oSXbG/wOCwkTlTRt6IHy6zpHQHD2IqQvUJqlP48vl17eyB48bekBVv6YpOJXApcyim/9vChaRJkBO8WIk39CG1IWK/Xs6zZHyKuP6IbTktfERTVc1y4bK9KWPTbIJ5gkZVHYWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIzLm85r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGD0fYK023764
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A30SR6P2F4Bg88v0mF0YsJP4SvSWPa5Vxlr8SxbBJ4U=; b=gIzLm85r/NWGsYkC
	CDGSTMCeZqK0iOjwHLBHp+GI+rbv7N2b6sJtdR+V5cYxsjUmNgnfAc0G515UNrSV
	5iyd2fWQWdjUmc7kavgCI/dclLVs+7HSTkUqzNR+6lOIk5aCU7v1TMnAtwZGkdoa
	jtziw1QqHn3ygtVY30geFIkbHklKfLMRTFX1v6rSROKMpxuu/O6XsZD9sApUioLQ
	YRsC2pit+Ju6pHKKSddxaBi+C+XL7+Yr77OcJURYyRes6+x+QniSdbFaylUKnjmJ
	IBSsjThz59sh0vA528a/6KjJA7tM7+M+E8QuwDyPwSTtu0ut6PZYQoodVHjwKH74
	FzE8UA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jmqcgk5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 16:51:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-728e3ae8112so3303525b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 08:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367861; x=1734972661;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A30SR6P2F4Bg88v0mF0YsJP4SvSWPa5Vxlr8SxbBJ4U=;
        b=VdEJ9Avl46y1AukLfEeWQFTJXv+zofVEOVjlLU7edSkTjEFRZJ42icoo2VYGAJdvlc
         a8Y0c1LnFnxjpTj3cCqA7sMiCcwGHKgOrx9hLyo56zcWR554S0JzRMhIsVNAPXvvfOLz
         UFmLy0b13jnJAUbfj9P3d5au36hxG2/hpqGTIsxE7+75don6SPkH3wL0aqR3V7hFa8Ad
         6h0HV/S6qsPJ/0ipEiqAK7NeWhcswIl2Q65s/eMkMznVr5UQmcoImfYgrBkPXeAK8oM7
         vBNRbmJEo6YNXIEJOnh0Ok2CK8XtImZXYpB0Qd1FzRCcxlC2WvxCLePVZWtpttsyNisi
         JYiQ==
X-Gm-Message-State: AOJu0YxNM8EIk3qs30jDrGTImWpVXKeNWnv0nem32g8nlYUVA4IbnmLI
	lHVUl8H7dr1BVmM0/xMTc8Y9RHM1tTWyIeuUK/INDtjsSMSa72avfN7ZBd/8lucVszKi+CLVsoW
	E1twBEDPyBxaqvD67Mf3afSxFsS8x90jGfEBI0c01ndSF+qzxQSmgw1chIN0PzLNByg==
X-Gm-Gg: ASbGncsXX4j/dnv7ZMs+kaOesD8LpDBBRBvOW4WLXyhQ9HAMDof206IuojaJUGvcErn
	jR+MqyR6/nEgP7Je0H2L9kskSOtwObPnQF5yNsypWJeGCUlon6OHovpA33/9y79jDS/gDTgEwj9
	689jiME2hAeuV1e9lnF5genpVRkGidyup/McPCbDa72MPN3Gj6PpAM9w2IegooSWgo6gJipwQN4
	vHoSmbFpc8SpAJgFSyneF5KdkfqF435vuBYAFCUQZUIUJp1ppz5Gb6sfTo93yXBxU9vL7O1n0z+
	of/Wq+DLMbKwQ9LS1g==
X-Received: by 2002:a05:6a00:330a:b0:729:597:4f97 with SMTP id d2e1a72fcca58-7290c243231mr20951651b3a.20.1734367860705;
        Mon, 16 Dec 2024 08:51:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHE+RXhL7PwjdEM8OJ4eq1C6kH23qH1FIqxLWVJgsjJzzTgC5L8N+5TXVmtuDizMBEjICTEA==
X-Received: by 2002:a05:6a00:330a:b0:729:597:4f97 with SMTP id d2e1a72fcca58-7290c243231mr20951615b3a.20.1734367860303;
        Mon, 16 Dec 2024 08:51:00 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcde43sm4937486b3a.194.2024.12.16.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:51:00 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org>
References: <20241209185421.376381-1-kvalo@kernel.org>
Subject: Re: [PATCH 0/9] wifi: ath12k: MLO support part 8
Message-Id: <173436785972.3413746.2874349352867763991.b4-ty@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 08:50:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: CKh_t977TmceROiaK5iKAoOm1eJzPWn6
X-Proofpoint-ORIG-GUID: CKh_t977TmceROiaK5iKAoOm1eJzPWn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160140


On Mon, 09 Dec 2024 20:54:12 +0200, Kalle Valo wrote:
> Getting MLO to work with QCN9274 is getting close, this should be the second to
> last patchset. Small patches this time. Minor changes to data path to support
> MLO, some interface combination rework and few fixes.
> 
> Please review.
> 
> Aditya Kumar Singh (3):
>   wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large
>     allocations
>   wifi: ath12k: fix ar->supports_6ghz usage during hw register
>   wifi: ath12k: pass link ID during MLO while delivering skb
> 
> [...]

Applied, thanks!

[1/9] wifi: ath12k: move to HW link id based reveive handling
      commit: e536c8690cf423f47e5e2f491134d3511edbbaf2
[2/9] wifi: ath12k: add partner device buffer support in receive data path
      commit: fc1e7e004b1808da38c862d57fccfad631a1445a
[3/9] wifi: ath12k: add helper function to init partner cmem configuration
      commit: 5a8abdf88deac066c4c4a224e45b80088ea94ff0
[4/9] wifi: ath12k: introduce interface combination cleanup helper
      commit: 2e4b8a49191ea9df8430cb6e8af7429eadd54709
[5/9] wifi: ath12k: Refactor radio frequency information
      commit: 4b861d256235c0c94d1a09e4dd888accc0eec5e9
[6/9] wifi: ath12k: advertise multi device interface combination
      commit: 03156d08d9ae768bffc0eba5eeeede868f52331f
[7/9] wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large allocations
      commit: c14725f359ef982923f3bc7e222c7687ffe4e496
[8/9] wifi: ath12k: fix ar->supports_6ghz usage during hw register
      commit: 95740fb0d3dbe276bf414c44cea0c35948407800
[9/9] wifi: ath12k: pass link ID during MLO while delivering skb
      commit: 1d015d783da57b002fda75b29aa3b886724c0129

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


