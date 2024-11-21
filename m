Return-Path: <linux-wireless+bounces-15563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D89D5083
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579C92823EB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E97219D881;
	Thu, 21 Nov 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjPKzF39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88A156225
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205566; cv=none; b=lqiJlLW8hCVylJ4PWu013Gcq7OLpFU7uuEwW1QCqLYiUSp/bZ4yrqAFOFdNcSpp8U5k+g/IVuS3chBZUH7ztFNH5jRdoK0G86y13Q/a3rQDHFoxwW2x7VR6eyyjoegbNottZpavlstOvXjb+d/FJbL+q/kEL6NDDU/IMcYml+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205566; c=relaxed/simple;
	bh=UrCs6NzXop20Mw7Ob25zqCN0HT7+A2wWMYlqTAzlXRI=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=K9zh6Ng7V4/X7oGUnuNUsbwqG6UwbV8OdfDQgWbOEmTfYJxk/iZtUTKWV74zi/qXKQeMjVyUFQkJdHU3nni3f2517A58B6vO038MM2dGY9qAXcT7CF185t7p6Ry0gdanidaJGXOcW1f75GZmk8ofuJYIacj2XGP6WGdlCu1pAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjPKzF39; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8jMkU003948;
	Thu, 21 Nov 2024 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dQ+WFixI+DUJbZX7N0hWTEABNSlsWjF5Or89OIfzfsU=; b=FjPKzF39msGc3hep
	Q+vLErAUPIQWZHVo+QwWbBZ6iwWriDujC11Po3QqqVqZhmbvJzYtf6MySm/wP5VC
	9tx2+lFqvrRgEoAF5Q+j7QUdWoPxYWpf6sQkNgFR4XX6aFclrhVIQsdgSDvBk6ba
	Hkx/JYAbps1aZz3Z1IZ2iPJCo45Ld7BXVBlH5LtgyZ2+yu+1JWXPqkqYMBZDYP3z
	Il7FMjwKUGatOQff0T+cyd10HcUapZ8z+VppBo23sEdROQPPb66J/qp5Vxz06paq
	2RXLbOsABH0oN9mxQr9VJRzJ5+BxEG2MCxZk+r8z34iXI40ZdssFMyyMApe219eP
	E7a1sw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ce3ckx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALGCeZq023479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 16:12:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 08:12:39 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241118035722.1755373-1-quic_rdevanat@quicinc.com>
References: <20241118035722.1755373-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Fix inappropriate use of
 print_array_to_buf_index()
Message-ID: <173220555971.3016923.14190692040130925339.b4-ty@quicinc.com>
Date: Thu, 21 Nov 2024 08:12:39 -0800
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
X-Proofpoint-GUID: p86jXSQHZNWzZ-YfzFUFsLme-_lZ2shF
X-Proofpoint-ORIG-GUID: p86jXSQHZNWzZ-YfzFUFsLme-_lZ2shF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=569
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210124


On Mon, 18 Nov 2024 09:27:22 +0530, Roopni Devanathan wrote:
> Currently in ath12k_htt_print_tx_pdev_mumimo_grp_stats_tlv() the
> htt_stats_buf->ul_mumimo_grp_best_usrs array is printed using
> print_array_to_buf_index() with a stats_index of 1. This is meant
> to convey the semantic that first entry in ul_mumimo_grp_best_usrs
> is associated with user 1. However, unlike some of the other "usr"
> arrays which have that semantic, ul_mumimo_grp_best_usrs does not
> have that semantic. Instead the first entry corresponds to user 0.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix inappropriate use of print_array_to_buf_index()
      commit: 47c7ebfba30f242a24a89317c74eada47adfaa95

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


