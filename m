Return-Path: <linux-wireless+bounces-14333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C689AB191
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B151F235E8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D1A19DF99;
	Tue, 22 Oct 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XveL2wVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF5199939;
	Tue, 22 Oct 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609335; cv=none; b=rhqP5KEdfZqKMJyVYtj0fmsyRniR/NS8lklgv3YlTqf1XWyH8CQM6HPfO5HGppKEE7EC9sgowxMDQCFAVdbFNW661WI6oTih1O8y5xVMHfyuVmvUnl9GngSI2iXqcJqe5AUldDmw2PrPZu1esFLoX1DAK+OpDp7193jOuMr+16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609335; c=relaxed/simple;
	bh=dk9GVXBzMcljhw5qoxyb0/4o0TGxVOKtLeB4U0yWriM=;
	h=From:To:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Er7Q6V8GfNqv9PGzlyA3TV1nnZ06eKLud3DUQaMaZNkxSCPjsyFl6LGMTCxt9JDPjAnJd+EUGe8wRabth6PF2rqWtKJPNei1+VKl/KXD3QpuPToFeGTbfgT2QgfZXhnjEHOYEHliFDjpbGa4eagHiI9UuhrA0KQTec3d1jdOgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XveL2wVQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MBpanH023780;
	Tue, 22 Oct 2024 15:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4j0TSrcG4+GrKDdFhSudIfWhVj2QOoPGryroBU7BN2c=; b=XveL2wVQGWVvDPvc
	byij4+QOMdto+5SsR2HsbnHIxPUFV6JZKintrjw6Z9AHPV5mofyGRQZCaYl1J6cO
	j5JGKuPLIPhGw9XctqyhwFRUgPudXX8tJXzvuHIaaYsUIi3SkaPe9KBO/mPsW3K0
	OItknDCyfFUmgZq16txtpdMZld42tu3/zy6pcCEWDiULZGxYMkbAzdE1ZKmcNqbv
	zEFuWakkBVExT+MtLNeRtWkPEMqvkg73WrCDFZ6/l1WqWontnkBeF894dH23U8G0
	gYaH2RBKaM686aHvfM5G7jVZAY4wEQ4olh+vCqW+U4BaDp4cxgamN6Pj+fUw6kTx
	BZAyqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42e3cgj24t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:01:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MF1t3R019415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:01:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 08:01:55 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <kvalo@kernel.org>, <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jose Ignacio Tornos Martinez
	<jtornosm@redhat.com>
In-Reply-To: <20241017181004.199589-1-jtornosm@redhat.com>
References: <20241017181004.199589-1-jtornosm@redhat.com>
Subject: Re: [PATCH v4 0/2] wifi: ath12k: fix issues when unbinding
Message-ID: <172960931548.3037585.16411259457657952070.b4-ty@quicinc.com>
Date: Tue, 22 Oct 2024 08:01:55 -0700
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
X-Proofpoint-GUID: ukR6yyaYn5pRdcw48nrbrIDbsGSgoGCJ
X-Proofpoint-ORIG-GUID: ukR6yyaYn5pRdcw48nrbrIDbsGSgoGCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=479
 spamscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220096


On Thu, 17 Oct 2024 20:07:30 +0200, Jose Ignacio Tornos Martinez wrote:
> wifi: ath12k: fix issues when unbinding
> 
> Currently, ath12k driver is not working from VMs but it cannot be unbinded
> either from there. I would like to send these patches to fix the issues that
> I have found in order to get the unbind operation working there, at least to
> fix the errors found during the process when the initial error is detected.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: fix crash when unbinding
      commit: 1304446f67863385dc4c914b6e0194f6664ee764
[2/2] wifi: ath12k: fix warning when unbinding
      commit: ca68ce0d9f4bcd032fd1334441175ae399642a06

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


