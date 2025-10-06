Return-Path: <linux-wireless+bounces-27823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FCFBBEBD7
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1784EF78E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601952248AE;
	Mon,  6 Oct 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hx7D1XsH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAB222566
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769516; cv=none; b=OnE8D537s/fc3Cs937GCBh9nNU35+RqyDGrCTNRtNXYI12MMKQmtmgcsViply8pjd5ZQOWBlitGwILCa0WX/yE7/yfLkRM+20RmzFd/rroK/YyZ/4V0JfFxQxiNRLVELV4i8BVkVKXnu+36ZFGP1V3j+FPrbJ87yoRBju5twvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769516; c=relaxed/simple;
	bh=ql9bzj2CkiEdmCC3267zR2T+lCqlKMuT+ptwOYqA5a0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rmWIJeljii+t30twXeyDdUfRazqctLUChdMStPhe63ILs2Eekx2lgA7Ujzxdqix+o/lveROfJgt+i3ISCmCIWMjITu2Zyqf0PmLLmdIYLP2L2qiWQ2CjnV0QrQy4MqNvRYOGwGvq6M1R0dcp5rMmzp5Sfw72GJpqaIJpNnHkhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hx7D1XsH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596F51S9001346
	for <linux-wireless@vger.kernel.org>; Mon, 6 Oct 2025 16:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aCx5vCUHglohbFtZcwRnf+9BWw1KFYF96ZfRMd8b8e0=; b=hx7D1XsHjCv39C4W
	CEJCdZg4wawRx/rAy+XwOXJfKjLtnSOjh5QrLdsKBW7S4Z6A6NBQmFrIkhUi/6qw
	sLM/e+huxK+FWs927m8kmqbcD9Z8zyFctqX6NmC/Fn12Rx0WBuzhJcaMxgGSvzHM
	D8Fm47Qa6KFGcJXzJKcB7V6/ISlmBIwA58KERmTP0HNA4nooGjRe7TxgyZTdUhXN
	Di6t9lbE9IHW0j9+P5OtM/dTU2itDNzqNvyEBoD9M/N8MmPnKuul/x3kwzKXuzFH
	elevAkZzWekMCL5Ve2EQwmHd8k/tZkyrCj5GjDVQK3fZkLvlfaQndllPtcJw36kK
	qXGDew==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1mft1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 16:51:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781269a9049so8696180b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 09:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769513; x=1760374313;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCx5vCUHglohbFtZcwRnf+9BWw1KFYF96ZfRMd8b8e0=;
        b=CreFtkWwmPXxBGwHCNZWl/pTa+DLUddoVTD2s+qX8ubmRGoMqqay9J6ecii6Y3FBKp
         LdrxGEZsrDbw3MS4Fj9Nj/TzmHYGjQ6HfD78fWQJaUvP9AVFC2OTVNaxRwPeXUOhkkdW
         ATOJPC7Mqsx4lzg4AdrTTnvbDM1q/FF8W5Bot0buMxFGz3wup9/g+FkO+j5BoKsf/Jdz
         fblJUdlflwrDlV7sMb9+C4MjPxQ5qAuD3Pcn787j/ZpvRYB+gTnhOtbiNerFQsF1iD6R
         Ihvl+N8Kdh1NLkf1ynlw+Rov2NXDWQMhG0RUejwOYmX3t5NkHFTAjweD3r/EIjkT0RmE
         IZEw==
X-Gm-Message-State: AOJu0YxaIIODJYkk6ckQF4uUfgD83gCZMWtCsNpxlCMQEn38i4f95KSa
	cUqUZbyHKU1OEI8Ea7PHL/dm/+PiW2ddhD/mHZrVn6/qyKMYs5mqKLpPUoc6ASB/VI+lkCMzGeX
	ZN4d48GXav8SinBXLKctNQh/09S6vTXlynMhQl0cR3xLXkzssvEIdRMIAFcjkTNh3Zf4rbacTAF
	YWlw==
X-Gm-Gg: ASbGncthWPFm0sIuqz9dXRh7SKKrN1RwLutxiuKke384an8DJkTh0vYSfYv/HCsGa3u
	mIMNMZhFmMzqos/wNEl2Ew/8hWFu1VXnt5MUjTQzFQbSFgHJ7P7Bl1VwEwGdRxwotBkT717Ffj2
	Sm/NAkfzXaC/2z6ewu54E+V5wqVkpr49MNqFDz6DVFZIIGXW10io7WSDNSg9ezVBxTqWRwp64dR
	xhcUYY34kwGwa5KJO/K7yTNzkPW6GNWCqcJS/SUC0w08N4cOIwMZVmyxmt01lZtOacunXoDxSI/
	Op8w2f8Pv4K9PiKi5ROAdNVlNnPEEjBC+Ie+aETBk10j24oKB85vTc3YxEgn7oyIEIiJAkg/Kf2
	kkDHqDA==
X-Received: by 2002:a05:6a00:cc3:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-78c98cfe33cmr12970356b3a.30.1759769512666;
        Mon, 06 Oct 2025 09:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjnzLkv6OnvbfH2XheORbcoIkytkatzvBBOtJvnWxceAZbgVilRU6aprK7/tQRV5PadLpY+w==
X-Received: by 2002:a05:6a00:cc3:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-78c98cfe33cmr12970329b3a.30.1759769512183;
        Mon, 06 Oct 2025 09:51:52 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205336csm13293176b3a.45.2025.10.06.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:51:51 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, kvalo@qca.qualcomm.com,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
In-Reply-To: <20250926195656.187970-1-loic.poulain@oss.qualcomm.com>
References: <20250926195656.187970-1-loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH ath-current v2] wifi: ath10k: Fix memory leak on
 unsupported WMI command
Message-Id: <175976951148.3451922.9085792171850947526.b4-ty@oss.qualcomm.com>
Date: Mon, 06 Oct 2025 09:51:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: _0bmMBC6LJlt4Zx2Au2BVoTtAKuoft4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX20pAvYUwf2mh
 cpyhHx3iiI7B6Nu16FVQHs/V4BNpbjwbdmZrm0ix2D4TdjVKEQZTvutKAFqtBi03Q0hxVaezjzk
 pT0LXeU0hrRE7+fQEPQnCqbu4Msjg/3+dXiw3ScaigQnqxS/GEuVTjpUnkgkcLiztzq/sltnMA+
 YgvZ7Ua1OsKKIbRXS1tQz7egzAIqcVjydkDO6suaRrRZ+a/zpcud3i+KMYmP8O+KnLN5JynC5Wm
 gAbSf3lEjHvARpq/gYcdAcSCvIS1BtHIzkLPGUlrVmyMQXyS4mMkAIAK6zEE/gtqykDbx8qP/0Y
 T4rUGrJt0zbTBGjmDnlfYORWm0c14bMstVfMttR3gBCuyW3ShAIuJPrCQ1zV/fXYOfhioNZPNkV
 rWsbFII0mogyZcIpppR0e2PUEuPOvQ==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e3f3a9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=wXeUjoMwVmF5acqhv3kA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: _0bmMBC6LJlt4Zx2Au2BVoTtAKuoft4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027


On Fri, 26 Sep 2025 21:56:56 +0200, Loic Poulain wrote:
> ath10k_wmi_cmd_send takes ownership of the passed buffer (skb) and has the
> responsibility to release it in case of error. This patch fixes missing
> free in case of early error due to unhandled WMI command ID.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Fix memory leak on unsupported WMI command
      commit: 2e9c1da4ee9d0acfca2e0a3d78f3d8cb5802da1b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


