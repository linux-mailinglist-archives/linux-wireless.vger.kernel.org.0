Return-Path: <linux-wireless+bounces-13649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778BE993977
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299EA284201
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC028EA;
	Mon,  7 Oct 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WHfV/Vqr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4218C353
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337400; cv=none; b=e0F9bD7BD/SGjj1KxB+w/V1k4SqlR8cebG9MjmiX2A9dYBvg5dCHlrjKub9ustCo2BjJWeO68FcyJPPlQkeiopvY+9ymsYgqOt6uEA6RYrA74KIzZZUFDCHksBM9EYc1xDcjfVSr0eMDPupaIPjzZCRA8E3nAdqHXY6a95LrzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337400; c=relaxed/simple;
	bh=ZFFp1SiZKrm1VIpiNdlFREL5pdvQG1rU7TylDuxLIvo=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=k5mOtfwQ0HMZ9QFB9SBnB8x/PmAHiYDgaPC+NjrH+/SefhoE6K9JcYsRrkYep3toF4gdZMgt/+Dch4ma68TfIgSrCtSWd/swySQY3Rhv7CtjNgzqgQgkZcZiom5dXqPQLT8frwyScC/G6LNft3BCFyYK+PKiRA7GhAeUMoRkY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WHfV/Vqr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497LS4oU006029;
	Mon, 7 Oct 2024 21:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xutLVwGX4uBH+NJkJwsYkG/0UC7q5qR2voCeLmDy980=; b=WHfV/Vqrmk/rFsUZ
	LN39wzmoXJIxLMJBXWOBo8zZLbDdyoepoEsImxlI+rJMeJdMrA6prUtQ7o3YSCYf
	phPiGkoorZVR1g0zS+EHevCjhAVZR0mifnOOLl0dNq46Sw389x5iNoNVQMH5DSAO
	v9jeu6l/odUl7VmzkGEdLWhkIO0SI8zSF60JNwQ4DqPfX24HQdh8Eu5LFJEo+vge
	4VfE+3Y8nwcuzo4sHqK6VPMjKrnpZH8jekF6ZKn/xhE4HgouPQGNQySjAko9opb3
	hz0DIs+Ay/NL3rFtq2pyWr+bFkyr+rYgfQaMd2JLNpSZBkxIT9FPLI1dHTMGedlU
	vK7zdg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424cy79t75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 21:43:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497LhCPZ011547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 21:43:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 14:43:12 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241001092652.3134334-1-quic_ramess@quicinc.com>
References: <20241001092652.3134334-1-quic_ramess@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix use-after-free in
 ath12k_dp_cc_cleanup()
Message-ID: <172833739247.2581613.18305318336936114869.b4-ty@quicinc.com>
Date: Mon, 7 Oct 2024 14:43:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8nAsk93DWGXmjyRQ1GuomMAWHXcQbujk
X-Proofpoint-GUID: 8nAsk93DWGXmjyRQ1GuomMAWHXcQbujk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 mlxlogscore=544 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070149


On Tue, 01 Oct 2024 14:56:52 +0530, Rameshkumar Sundaram wrote:
> During ath12k module removal, in ath12k_core_deinit(),
> ath12k_mac_destroy() un-registers ah->hw from mac80211 and frees
> the ah->hw as well as all the ar's in it. After this
> ath12k_core_soc_destroy()-> ath12k_dp_free()-> ath12k_dp_cc_cleanup()
> tries to access one of the freed ar's from pending skb.
> 
> This is because during mac destroy, driver failed to flush few
> data packets, which were accessed later in ath12k_dp_cc_cleanup()
> and freed, but using ar from the packet led to this use-after-free.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix use-after-free in ath12k_dp_cc_cleanup()
      commit: bdb281103373fd80eb5c91cede1e115ba270b4e9

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


