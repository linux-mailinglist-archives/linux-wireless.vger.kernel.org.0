Return-Path: <linux-wireless+bounces-14093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1E79A0CE7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCCF1C21FC4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA0120B1ED;
	Wed, 16 Oct 2024 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RCtZaUa8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DD156225;
	Wed, 16 Oct 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089566; cv=none; b=cB05tiTWMyPgwkJkYP/f5O+St1pF7LwOlLYSToGaOUZ+tmgPRrfa3q3OWg+i428gBkQ0sh6o3v+62QrRaI+13kslcmoF0806NP/k+rmZZ/urcW93XLJHSr4ZtMNpibu3xzN0pXsG1dTWYO6rNdNTvCzrCxg/Dz/uBrwu4ZX2j1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089566; c=relaxed/simple;
	bh=P/vIoFTqalR+NE876/z2yANZnM3e8XwIzSzaacKqF98=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Hi2nCtYl3ayoXokcazFemW+rttg0lBpxyphCWbWFSeI41xpjPv/Q+GCvapOf9p4W7by8w761qznpFN0LYCfW88bRNB7ZUZeiH0AEuwH9jXmxvYylfSGGYpGsKhIglxBIxYdevzokfYTPLve+UQPDF6ilxJeGUUKqtXSosWonJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RCtZaUa8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8Q7V0007485;
	Wed, 16 Oct 2024 14:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	seIIshYJlqe/FATEkYnojoUiTE4TpzoHzavH6e9Q2W4=; b=RCtZaUa8lmof9Eae
	eYjx5c0ZrNjwbjCv2MPeHfDTp4OcuIfbOCp9A1HKbcwqKanpom7dyd5ghrxV8Ik3
	d7650oVYlTCNlggFqOXiepyMixJsJTDDsI5/xNiZFybOxgNeGCS6+LsyD9mzTLmp
	CPqkAR7OnVda6JunvNC/gTspDGa9aPf+fvirsN9CU2sKUgZTa9wBjVURtNYntnvE
	HAB8KcuDoagjcrIS5DTfSzDDBIy4KC2TzJckuYS2rmcv9rOzR6pWfc89Tip1UoKk
	PcXKuHoKJzk04nrXJCsTj0g9xoyOyQcW9FCPhRSVb4SR4k9IEMOxDTtIEfnt5fhc
	9q/bYg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mjy51gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:39:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GEdJ74029797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:39:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 07:39:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath10k@lists.infradead.org>,
        Manikanta Pubbisetty
	<quic_mpubbise@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20241015064103.6060-1-quic_mpubbise@quicinc.com>
References: <20241015064103.6060-1-quic_mpubbise@quicinc.com>
Subject: Re: [PATCH ath-current] wifi: ath10k: Fix memory leak in
 management tx
Message-ID: <172908955957.387396.967405971287918715.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 07:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6jRpfr4888X-lCbk4JcUpt9CoRAxHb4Q
X-Proofpoint-ORIG-GUID: 6jRpfr4888X-lCbk4JcUpt9CoRAxHb4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=679 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160091


On Tue, 15 Oct 2024 12:11:03 +0530, Manikanta Pubbisetty wrote:
> In the current logic, memory is allocated for storing the MSDU context
> during management packet TX but this memory is not being freed during
> management TX completion. Similar leaks are seen in the management TX
> cleanup logic.
> 
> Kmemleak reports this problem as below,
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Fix memory leak in management tx
      commit: e15d84b3bba187aa372dff7c58ce1fd5cb48a076

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


