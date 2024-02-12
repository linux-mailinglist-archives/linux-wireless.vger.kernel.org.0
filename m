Return-Path: <linux-wireless+bounces-3449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228C85135E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 13:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D911F27344
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4AF39AFE;
	Mon, 12 Feb 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ljw+SAKI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C539AD0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740194; cv=none; b=ABx0ZDxVhW+40LUxn8Rl0BPqBbNEvJ/SuHX9vfTdw/+u/uCKdBd34fGpbqTg3MwIXnPJN8517cJOlm+Q8E4VgZKR5rYR8A38v5S5zZj6B0LRFGWPvO4DARX7aoUorCJ60JpdSZXTLFdQ5bhdDNi8mDPkwPGi+5v6pfEry7QpV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740194; c=relaxed/simple;
	bh=Br4zEs3LdubyfUnX3LSZRNLQBX+hY+HgJLp7vzdlye8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pcSUAI7yRLFUVJICrajh514oGJpgfFcJjayhq9AKZqGVg/mK0Ho923hzlrPI6AHJbkrAxsTy1mKfixVIWic/L0FYQnOuFMheZOcQuIQjjlWBSKBP5uuPnJeoWH3DrzAvueb76XsN4GaNtvh4zCfkAEL+4MOsHF/PZA4yEoH5nF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ljw+SAKI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CBrcTb028090;
	Mon, 12 Feb 2024 12:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=RPtNJ0Gr47PZ2J+LndZv
	y6fKAzPDWmhRrX2joTVUJHU=; b=ljw+SAKIZjp9nujebjIFYlQz6rFJr3i6E0Sf
	dZRvBpezKGn5Ohd7XnwA6wGsI3LnjDR171apZbJ6nJo0Lm+UBbpBg2NkJLIEDqGK
	YvGh6VsApuAPX/huB0hSTIPtPIEPGH6d4mcD6Tkz+CAizS9ZlGx/eOkpkF/qxfZv
	+HjR5vTiYAtZXX03tvR9iKWDMTxlaFr4fMarC8dT/z65a9yJshMh0PawyRnfrORk
	v4Ycafy+E0jR98vdVtGj6498VahjhLyl8GPIA7Mq+FUaYxtGSI7tEsJnADbFFPCP
	/385cXchkceo+3zxIGe6WdZ+15rquK2TTL3fscmgRkWrctvdlg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ju781k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:16:27 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41CCGOOZ002161;
	Mon, 12 Feb 2024 12:16:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3w627kpp7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:16:24 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CCGOQL002154;
	Mon, 12 Feb 2024 12:16:24 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-haric-blr.qualcomm.com [10.131.39.39])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 41CCGNAP002153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:16:23 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 3844793)
	id 35B6B411AC; Mon, 12 Feb 2024 17:46:23 +0530 (+0530)
From: Hari Chandrakanthan <quic_haric@quicinc.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH 0/2] wifi: cfg80211/ath12k: Add support to rx retry stats
Date: Mon, 12 Feb 2024 17:46:14 +0530
Message-Id: <20240212121616.3683197-1-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: phTxOVbnawcF8eoAVAHe6kcojiC7Q7Ls
X-Proofpoint-GUID: phTxOVbnawcF8eoAVAHe6kcojiC7Q7Ls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=282 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120093

This patch series adds support to count station level rx retries.

wifi: cfg80211: Add support to rx retry stats
wifi: ath12k: Add support to rx retry stats

Tested-on: QCN9274 hw1.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1

Hari Chandrakanthan (2):
  wifi: cfg80211: Add support to rx retry stats
  wifi: ath12k: Add support to rx retry stats

 drivers/net/wireless/ath/ath12k/core.h   | 1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c | 7 +++++++
 drivers/net/wireless/ath/ath12k/hal_rx.h | 7 ++++++-
 drivers/net/wireless/ath/ath12k/mac.c    | 3 +++
 include/net/cfg80211.h                   | 2 ++
 include/uapi/linux/nl80211.h             | 3 +++
 net/wireless/nl80211.c                   | 1 +
 7 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.34.1


