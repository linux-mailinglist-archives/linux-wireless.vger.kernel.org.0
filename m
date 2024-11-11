Return-Path: <linux-wireless+bounces-15188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DECE9C4490
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 19:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D0F1F22120
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713115D5C5;
	Mon, 11 Nov 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kg7S3JO/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF01AA79E
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348519; cv=none; b=rQ/Q2eoNtYYhiZBnNUnagXQT9sZJo4Dz/l399ynnd1KwjpShx8ABT06aGLds+5nrnkYASo2ZknIK5krOFrFJs5dAGRvtKwu+AmCvIwav6T+shiROE5GOkiCYx6cEu//vG9v3Omk1JwLLEu26kEWbYmn9J4UOsQxA+xd+3QAM8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348519; c=relaxed/simple;
	bh=yimHYY/B0qH4+vOuy2H4iWTSXAKkW8vbKAefeFDF22A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AFg6RUS3IiGBt2jsZZXxxTtKMFcxFtLzzHMHVikiwcc7cOjyQ2jw86kBPTMEiUkShTWhlk20UYikHc0oPM1VTiIlB3R/6vxL+cqFCdgoAq1jRJ+6EpWcZT2NYyvJnWzQqYOFPfFcg1JdnFHSEoEOzyANjY9l3YQTYEWaLg7ZOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kg7S3JO/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABC3qKD028001;
	Mon, 11 Nov 2024 18:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yimHYY/B0qH4+vOuy2H4iWTSXAKkW8vbKAefeFDF22A=; b=kg7S3JO/trtQ8Z1F
	JFkSEYwyjlHaTjyrNHsD1W7PruBqf+VLVZTMNp/mD+HHkUAzUNQOnF90F8AM01kB
	EeQ8Nt9GW3T48UOB4E7R7eyM5TyDvzetaC8egzX7PBUZS74EGH5N/AGc/YEo8qSZ
	G66UVULPkY4aYRxuHkYlqhb9MdAzzUbD8H/BjbYZD5uPUHIErLZX0uTmuQDVIW6B
	6anezZnAUkLCE80/JkXJ5GZzwCLXVowij8S4azAurG/qan0cP/P5H3kCBPiNE3UR
	Jaa3h7eD42mLxhjYA+1tgRKiqe3/bObqxjlYtJ3gVaRsUPMaEbNFH0zdu6feXhA/
	aUButQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sytsn0gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 18:08:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABI8Nnr006497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 18:08:23 GMT
Received: from [10.48.243.207] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 11 Nov
 2024 10:08:23 -0800
Message-ID: <89dadaef-3a21-4c38-9fcb-ad3238e3e34b@quicinc.com>
Date: Mon, 11 Nov 2024 10:08:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath11k: cleanup struct ath11k_vif
To: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Johnson <jjohnson@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20241111070152.85140-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241111070152.85140-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ocDy-wX-ScBBKj6ulPClijCsV3zCLrzo
X-Proofpoint-ORIG-GUID: ocDy-wX-ScBBKj6ulPClijCsV3zCLrzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=454 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110146

For future reference a multi-patch patchset is much easier to track if it has
a cover letter with a subject that describes the entire patchset.

/jeff

