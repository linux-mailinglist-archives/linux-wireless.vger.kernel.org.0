Return-Path: <linux-wireless+bounces-4443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963BA874058
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 20:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5322C2819E0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90C13E7F3;
	Wed,  6 Mar 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gCC1WdVx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529C13E7F4
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752993; cv=none; b=NnOj8OTYHcFqVFblApweFfFvIAMIghCh+YauP0S5vzNrjkic2Dl+dItmtxIX9X3CtiCBFC3ZxNnI3dUeaJrCgeC6sPcWv7vnVPecHEsW8i4/nn+Fpe4r2aIYIqjaGiHUMUTF0r/sRIM6o4J/Xibp5eFm1ndA3qpXwJpbzikP90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752993; c=relaxed/simple;
	bh=o+eIkwUBoOUL5XxSpZll8Hu2LirTZ7upNAmW82lLjA4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=eXjFukJHlKZbDc0JxJ5qKr8EEoCRH5dBJzB5PwMShaj7KJcKSSwJ4jDkj/+N+dEZbcC5vPMvkqX/etAgu445lFDfCBxPkA/bASMP7F3k8ledTJSRd8D7bqATm0gTw7V2BWb5UgqWMidg6qRVmxDN4vP86zi70qHL9mq9QtBu5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gCC1WdVx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426INnfw014934;
	Wed, 6 Mar 2024 19:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:to:from:subject:cc:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=o+eIkwUBoOUL5XxSpZll
	8Hu2LirTZ7upNAmW82lLjA4=; b=gCC1WdVx/33vEcr+GS4n08A4poRa4qyGbLxw
	gSPiYDQbCstkQg2yWo4qg5zKW4FPq/BahYm5EombSiSdO5/T+hWXDMwUBjFwkFMP
	k4ERmwOe46rUyXbgSF/k5QvPxD57b4Tn/+BKnVZmDAPvc76hUT+rwSgYn45tIRjS
	5w2QvnivJRRma46usK/WkoOiFwVjArW83NSyfv92nIgpJesYmmlTweySL1+EQLq/
	LHPqxK/3hIPnxoZMgow743xW/1OC+ivU3Uz5N/MFBgGhC5PQEWqaWNipUx2l+QOf
	G5wDQ5wAjYfK0IOX++CkNShpySP+W5mYidpPAARdozqwCr5KLg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpnfvhceh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:23:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426JN8XI025386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 19:23:08 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 11:23:07 -0800
Message-ID: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
Date: Wed, 6 Mar 2024 11:23:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ath10k <ath10k@lists.infradead.org>, ath11k <ath11k@lists.infradead.org>,
        ath12k <ath12k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: New staging repos for ath1*k firmware
CC: Kalle Valo <quic_kvalo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -p5vyI_FfmWX5a8b-GYt3kGdeJoIb33U
X-Proofpoint-GUID: -p5vyI_FfmWX5a8b-GYt3kGdeJoIb33U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 adultscore=0 mlxlogscore=982 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060158

Historically, prior to being incorporated into the linux-firmware
project, firmware for kernel.org ath1*k drivers has been first published
to Kalle's GitHub:
https://github.com/kvalo/ath10k-firmware
https://github.com/kvalo/ath11k-firmware
(ath12k firmware was pushed to the ath11k-firmware repo on a temporary
basis in anticipation of this move)

But in order to have repos with multiple maintainers, as well as to have
a hosting platform with more control, we have moved to CodeLinaro:
https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware

Note that most people should not care about this -- normally you should
use the firmware that is in the official linux-firmware repo:
https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/

You should only need to access the staging repos if you need a previous
version to work around an issue, or if you are testing new firmware that
is supposed to fix a problem that you've reported.

Please let Kalle & I know if you have any issues with these new repos!

/jeff

