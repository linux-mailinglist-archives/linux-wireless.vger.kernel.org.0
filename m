Return-Path: <linux-wireless+bounces-14102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C379A0F7E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 18:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37F72845E3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230D12DD8A;
	Wed, 16 Oct 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bm9T3Xeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE345008
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095634; cv=none; b=PGmFA0PHG5nwzJPQme0f9AEy/wvDgJUXlHDBS0KdzAMuaMy8AWC7ZV5N17vGY9gZrMMdHFkh1qoYT8AuhR19T3IafffA+l+QaNnFSRcxQVya+WHJpuQvC45rKxgIAnDxkCvVXp24mdPBBAnW01O7NfpCQ4/VORmV8DqvPKKGM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095634; c=relaxed/simple;
	bh=0unY2/E0whQLzFRxXD50F5ep/Wtnk+mLvxYrno1oMF0=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=PIrrTbyHhE1BofdCDkGpaN6Wu8WZnYVi4olTMuoLuERxXXr6SpVuAd4IgRIIr8XSszFiPY0LnF83lD+PcUgadEvQXY0bPPGOi/tuszj2CKw75tJ8iu4NhCyY5UiG/R6WIC9OhKDOsXOC228vf2IdObgynI5Zfm80ZCCmvJFQ2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bm9T3Xeh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GG57s8020259;
	Wed, 16 Oct 2024 16:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CBvnqpDxgBvTqanvD/cUWB
	TJeOUGKK44XBIn5Lz9+tc=; b=Bm9T3XehQps/qLR1L/x60JdBrC9yhDKOlG3P3w
	ocI7KcpMFBHrDKflfyVYtBcExv3wMhkG3v1hzEmVvFG9WJ6EkXYWbOA0/nmQTNgp
	NM1zlWBerf/np86hKd6TPezspGy08zHttHvrIRjpuEpDv1u535ucmhqyHJpGV9rF
	9AVKFDz0bQvDYkYKscK1F4dcQQIn1zuiYXVmEtf4gnyZ2EtAksNKAp7UsgGi/Psn
	zIzIWm+RPOsZzcEJ6PLhlf5NLp3QB0WSGqoTCAhYZUu82u76+uFz8xOClInFFl7y
	CCu4b84v8v4F1wJujrwx6Gjev44SLjLBxSOw7rksw4xxqISw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429t5kmcwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 16:20:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GGKT9w004632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 16:20:29 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 09:20:29 -0700
Message-ID: <0ea819f9-d563-46c1-9a68-3800c81565dd@quicinc.com>
Date: Wed, 16 Oct 2024 09:20:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
To: <linux-wireless@vger.kernel.org>
CC: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <quic_kvalo@quicinc.com>
Subject: pull-request: ath-current-20241016
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FTfBsfP4HxitA9rBLVQ834n4EaXpKw8r
X-Proofpoint-GUID: FTfBsfP4HxitA9rBLVQ834n4EaXpKw8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=877
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160103

The following changes since commit 2f833e8948d6c88a3a257d4e426c9897b4907d5a:

  Revert "wifi: ath11k: support hibernation" (2024-09-02 19:33:00 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20241016

for you to fetch changes up to befd716ed429b26eca7abde95da6195c548470de:

  wifi: ath11k: Fix invalid ring usage in full monitor mode (2024-10-16 07:30:31 -0700)

----------------------------------------------------------------
ath.git patches for v6.12-rc4

Fix two instances of memory leaks, one in ath10k and one in ath11k.

----------------------------------------------------------------
Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Remi Pommarel (1):
      wifi: ath11k: Fix invalid ring usage in full monitor mode

 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 7 ++++++-
 drivers/net/wireless/ath/ath10k/wmi.c     | 2 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 7 +++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

