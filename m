Return-Path: <linux-wireless+bounces-15223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 672B99C6669
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EED51F2270C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394617580;
	Wed, 13 Nov 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wpj9VHHR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5686AA1;
	Wed, 13 Nov 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459709; cv=none; b=sI3Iy8MpBXzlKcQ7d1ROQLdwH1JhG2GRiBXHtKzMn6eidACefrhbFvOvcplPMAlAkwbTZcZJqi7WY38ZCVQrWbJalsCtRgWwsDoIaTcTBTF2idQh6JK5BmqG09sDcOA9u7rezOKmbWbCzDzBnZaSKCc/j1psjNua+2GK/OThIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459709; c=relaxed/simple;
	bh=4Ns3J2KUts+NSeSN4f0eYlqsvA0iuLCvUIbKWSlgB0A=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qovCTZPV0vHlTDr7dD/wurFmCAiEoUn8Rhvk6wVBBS7GHDbMgyubQUvKmOxBz0obzVRQRQtqmRCYO/aTepILGRLITqH5lrQ2gJjEIRFeJOrF4gpY0rV1pZFK9DpY8Ea88OG7ly16R+5gcgRirw/qXIG6FB2TCODDEWIUxB+C2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wpj9VHHR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRUNr019976;
	Wed, 13 Nov 2024 01:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bbd3U3/kb+UHiB2b7mf/WFn3/vSnGPGUueA8NvYkIUw=; b=Wpj9VHHRhk9gyeSL
	I6vFWRMQCL8AphYNgG/egAuTTpDj5rGhXaKWUyJXZu3AfRySwZ0BvjgyzpP/OQDw
	6qxRPkCN2ASmu6GeZBWMdVVlLqXQk43qzMLRwQ5ZOFqxOY7kIFEmprSdxjV0/3pa
	7VFnoyPrepA3YJj6y5VEshMKg/E8XPAv32yEUclWUesc4hkTi897EWnOe2AJd4X9
	K+r/Xxre0d8LGh3bT8WMlhm+86Aa3F7gHtkwjzn4GTVrDlgYi4GGQ8x/UgknJtK5
	oNGBdGNMsZkxKxUOkz0nDwjezZyMIuGYg/aKcAxzgN3M/0zwcE/hOZbUVDf+oF09
	8tBUaw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uc60dr5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:01:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD11dOT023708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:01:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 17:01:39 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <kvalo@kernel.org>, <jjohnson@kernel.org>,
        Karol Przybylski
	<karprzy7@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>
In-Reply-To: <20241105101132.374372-1-karprzy7@gmail.com>
References: <20241105101132.374372-1-karprzy7@gmail.com>
Subject: Re: [PATCH v3] wifi: ath12k: Fix for out-of bound access error
Message-ID: <173145969935.2685813.8639859936545662512.b4-ty@quicinc.com>
Date: Tue, 12 Nov 2024 17:01:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NNq5O9uB3nIrmpp69lxQwJqNMcdp1wxM
X-Proofpoint-ORIG-GUID: NNq5O9uB3nIrmpp69lxQwJqNMcdp1wxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=647 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130007


On Tue, 05 Nov 2024 11:11:31 +0100, Karol Przybylski wrote:
> Selfgen stats are placed in a buffer using print_array_to_buf_index() function.
> Array length parameter passed to the function is too big, resulting in possible
> out-of bound memory error.
> Decreasing buffer size by one fixes faulty upper bound of passed array.
> 
> Discovered in coverity scan, CID 1600742 and CID 1600758
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix for out-of bound access error
      commit: eb8c0534713865d190856f10bfc97cf0b88475b1

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


