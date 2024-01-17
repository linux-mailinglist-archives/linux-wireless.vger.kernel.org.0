Return-Path: <linux-wireless+bounces-2102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4348830972
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A611C21052
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2B219F5;
	Wed, 17 Jan 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KFg5hoAf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22C219F7
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504471; cv=none; b=DkqIzkfErSXxfuEUYBc1NZlKPXNaH7qXzI1rRB+1qgmZiHByxnQBRbFPuKkAmNduQfTLCvcFWW20NSKyGYk7UoTHomu7whMFcGWPlSJpyJYElo1g4EVYhfoYt6UgW98WobGKRzXvK52R4xJvHL2UJC6KCrx0avDAO9ZZ4u6+lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504471; c=relaxed/simple;
	bh=SR+/PK5b/j4/RnLWW+BX0mFfHVcAS02J8jKKuMW7cUY=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=e54H0wWTAQoDdklyPNT07KrZDMFacFmDmc5lbRu7Iw9dMiifdms4TWK0p6U3kizFfVPSBxZj2FOUAD+04nRFksUTyc2O2rKuhhSUWuUxp+a9IBgTv/QsblyNr2cyfWFhQ8y7xm2qcOkB88c3yu6jToGqtiu/lS/BRJ0dLWn4P5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KFg5hoAf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HAwJYW002388;
	Wed, 17 Jan 2024 15:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vY13OMwURnYF3oJ+tMFaDllV/xPgD0V6VbV/1dumRA4=; b=KF
	g5hoAfmkBzivgOtpz8B3rupTc9Hss47RdOPKc2lsWsn8GnP0dJtb1DA0FGKwhhbT
	mLK9eF3WNAZ+gjVll/yQSEU3FHYz63h8NsbzdVsSeZoqBMEGoaw4Mwpo7iv4YT4y
	TNPMRRGNiknkRr0kJr1Kl/mqMG5M5dnYJNZZR8rEI+AZL9caS5RhrtcS8qkLulCB
	D/ITKYAF3sy77749OxSTTb+VV3xCFJQfWW1fvrg6H+S7YKsR2gSPKV5m/NhXyqGG
	CZLEHJt9zBWflxsfsFwGNwJtR/yAh3NwdkZpymN20izbvUVq5Sqtsi3sWmjPkK7R
	rTEWUSUecHQvItg/wZBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpdfgrhbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:14:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HFEJjF029359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:14:19 GMT
Received: from [10.110.99.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 07:14:19 -0800
Message-ID: <26a42f14-dd38-4c67-8f66-16baaff25885@quicinc.com>
Date: Wed, 17 Jan 2024 07:14:18 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: rely on mac80211 debugfs handling for
 vif
Content-Language: en-US
To: <benjamin@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC: <ath11k@lists.infradead.org>, Benjamin Berg <benjamin.berg@intel.com>
References: <20240115101805.1277949-1-benjamin@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240115101805.1277949-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mdzieFL6KutfGEZTA3iOFLEC5scv_ncz
X-Proofpoint-ORIG-GUID: mdzieFL6KutfGEZTA3iOFLEC5scv_ncz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=525 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401170110

On 1/15/2024 2:18 AM, benjamin@sipsolutions.net wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> mac80211 started to delete debugfs entries in certain cases, causing a
> ath11k to crash when it tried to delete the entries later. Fix this by
> relying on mac80211 to delete the entries when appropriate and adding
> them from the vif_add_debugfs handler.
> 
> Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218364
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



