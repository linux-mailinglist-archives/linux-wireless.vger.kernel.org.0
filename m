Return-Path: <linux-wireless+bounces-28214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427BEC0459C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 06:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EDF3B63C3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 04:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3823219E8;
	Fri, 24 Oct 2025 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0urqBMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4735B122
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761281248; cv=none; b=USl0XP3TkdYkS61/wJRyCeHIr/YMbzCjjj3hK+3PCHh/ghtT/fa/uiQPF6UiUgB4JcMnXTAGfdFmZcoHLQZGHs0Arn771WLgvtoO+tRYuSTo1wId9RT6p4mzw9AI5QRuko7axmi1eOVqpan1iPyC5bYnhGtqXhhUeq+rv7y+2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761281248; c=relaxed/simple;
	bh=TtU3Y4qgtqsg99geRkYk5mVIMnkeCMc5GOQuyYoF5CQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGa3990cluPXcGcQivooE3BAnWXlWMySRIJxUZqglrArXwYAL9s8yhhTFoW1w4DsfbGsI++jiOqUV8/USojYsgwrefv1ofcaGTtp94JpOkPreiO3Gan3rK11X2gLdKfMtpW2wTiEqNxlquq5yIOXnekAHomGXKgtY2m1qafznSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0urqBMm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3G2V8022770;
	Fri, 24 Oct 2025 04:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wiL9wXjOkEuBpdabPzTJHl
	ZPBHxMsFG8HQA8AySwHzk=; b=C0urqBMmJTt18B1YhRp0lohy6HdgNcPFLftm7P
	Q37x6qH9nxjU/XYyl4/qTOfO7nkKVqaL06xu2fS7Is5jS9vtfazOQDliXm0MEDsv
	By1O2NZ5D3wYHzB5IeS4CFmfFD+QbU8Vr7yzu4ZMxK3dYo3BK6dmqyA/1XJO84Kc
	KJ/b5eKVqG+6Pk2PpW5egd1wYu19/Q8u6vAU1nSJKaVj/2nhybljb1v54cDWWyhN
	9uRabeTBIYgDMO2MGfza239vneGOjECJ7sOpuI0uZqcIW9lJf5AV8vLbrIKMWvsL
	wOwCpgpHdyGP2SC+YQDcX+wztGBt2x1tT7xoBIcV4qOYdQig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qmsfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:47:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59O4lLtW021686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:47:21 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 23 Oct 2025 21:47:19 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next 0/2] wifi: cfg80211: Add debugfs support for multi-radio wiphy
Date: Fri, 24 Oct 2025 10:16:47 +0530
Message-ID: <20251024044649.483557-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX9MQrQDdMyp2S
 hoUjo+Q+RSpWdJBbYyJQF0Yupo8XZqPkwC9eeNK4Jmz3hPMG5PaODcP43uQ3C+7ChUtK1ioWPNf
 dcSiwmc6g4Sk/XrZXrFH4jsxUaz2aUFGw9wZbqDv4rZ6oh+0U6/Di8gfPECDMlSjXl7D0PwhM91
 Yqm2Y8J0m5cY8orXfcCY0iiZhF6Qw4NMZ3y/XF1JTECSZqnijzqhLvVizRqtVrzSXx0eGGlnILu
 7wvfvSoF7VGQcQ4/efZ0koIH6yYvdlAynk8ha9cnx8a6uwbNJNZZqYmxiKvUPgc9EWylOBrmKeH
 UvDsC4B07GQ05iqUG09xXtVz5kJMFS/X3TowWtOE4lhzM4AJEJDh7ulT4WLw1G8PbE6PrTPKWU/
 4SEqKYj8uCd2CqzYfauuEKhnOitkFg==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fb04d9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MIN5GFXLiVYSEp0tk_wA:9
X-Proofpoint-GUID: fZtdA-ttoss6haui9FdKoduWSJy3X4UK
X-Proofpoint-ORIG-GUID: fZtdA-ttoss6haui9FdKoduWSJy3X4UK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

In single-radio wiphy architecture where each radio is tied to a separate
wiphy, a few radio configuration parameters and wiphy parameters are
maintained as separate debugfs entries. So, the radio configuration
parameters - 'fragmentation_threshold', 'rts_threshold', 'long_retry_limit'
and 'short_retry_limit' and the wiphy parameters - 'airtime_flags',
'aql_enable', 'aql_pending', 'aql_threshold', 'aql_txq_limit', 'aqm',
'force_tx_status', 'ht40allow_map', 'hw_conf', 'hwflags', 'power',
'queues', 'rate_ctrl_alg', 'reset', 'total_ps_buffered', 'user_power' and
'wep_iv' are present in separate directories corresponding to the
respective wiphy. So the debugfs directory structure for 5G radio, for
example, is represented as:
/sys
	|- kernel
		|- debug
			|- ieee80211
				|- phy#0
					|- airtime_flags
					|- aql_enable
					...
					|- user_power
					|- wep_iv
					|- fragmentation_threshold
					|- rts_threshold
					|- long_retry_limit
					|- short_retry_limit
				|- phy#1
					|- airtime_flags
					|- aql_enable
					...
					|- user_power
					|- wep_iv
					|- fragmentation_threshold
					|- rts_threshold
					|- long_retry_limit
					|- short_retry_limit
				|- phy#2
					|- airtime_flags
					|- aql_enable
					...
					|- user_power
					|- wep_iv
					|- fragmentation_threshold
					|- rts_threshold
					|- long_retry_limit
					|- short_retry_limit

In multi-radio wiphy architecture, where a single wiphy can have multiple
radios tied to it, radio configuration parameters and wiphy parameters are
maintained similar to how it is done in multi-wiphy architecture, i.e.,
under phy#X. These can be considered as global wiphy configuration
parameters. In case of wiphy parameters, these are tied to global data of
the entire physical device and common to all radios irrespective of the
architecture. But each radio can have different values for each radio
configuration parameter. To address this, in addition to maintaining global
wiphy configuration parameters in phy#X directory, create separate debugfs
directories for each radio in a wiphy and within each directory, maintain
parameters corresponding to that radio. So, the proposed debugfs directory
structure can be represented as:
/sys
	|- kernel
		|- debug
			|- ieee80211
				|- phy#0
					|- airtime_flags
					|- aql_enable
					...
					|- user_power
					|- wep_iv
					|- fragmentation_threshold
					|- rts_threshold
					|- long_retry_limit
					|- short_retry_limit
					|- radio0
						|- fragmentation_threshold
						|- rts_threshold
						|- long_retry_limit
						|- short_retry_limit
					|- radio1
						|- fragmentation_threshold
						|- rts_threshold
						|- long_retry_limit
						|- short_retry_limit
				|- phy#1
					|- airtime_flags
					|- aql_enable
					...
					|- user_power
					|- wep_iv
					|- fragmentation_threshold
					|- rts_threshold
					|- long_retry_limit
					|- short_retry_limit
					|- radio0
						|- fragmentation_threshold
						|- rts_threshold
						|- long_retry_limit
						|- short_retry_limit
				|- phy#2
					|- airtime_flags
					|- aql_enable
					...
					|- user_power
					|- wep_iv
					|- fragmentation_threshold
					|- rts_threshold
					|- long_retry_limit
					|- short_retry_limit
					|- radio0
						|- fragmentation_threshold
						|- rts_threshold
						|- long_retry_limit
						|- short_retry_limit
					|- radio1
						|- fragmentation_threshold
						|- rts_threshold
						|- long_retry_limit
						|- short_retry_limit
					|- radio2
						|- fragmentation_threshold
						|- rts_threshold
						|- long_retry_limit
						|- short_retry_limit
						
To do this, maintain a dentry structure in wiphy_radio_cfg, a structure 
containing radio configurations of a wiphy. This struct is maintained to
denote per-radio configurations of a wiphy. Create separate directories
representing each radio within phy#X directory during wiphy registration.

Whenever a wiphy configuration parameter is added as an entry to phyX
directory, check if that applies on a per-radio basis and if it does,
create its entry in radio directories too. This way radio-specific
configuration parameters can be maintained along with global wiphy
configuration parameters.

With this change brought in, when user tries to modify the value of any of
radio's configuration parameter, only that radio's parameter will change
and the global wiphy parameter and other radios' parameter values will
remain unchanged. This applies to all per-radio configurations without
any radio-specific limitations. Also, when the user tries to write to
global wiphy parameter, then the existing behavior will work, i.e., the
global wiphy parameter will get changed, but in addition, that particular
parameter of all radios in that wiphy will also get updated to the new
value of global wiphy parameter. This ensures backward compatibility is
maintained, i.e., the existing userspace will work alongside the per-radio
parameters configuration implementation. 


Roopni Devanathan (2):
  wifi: cfg80211: Add debugfs support for multi-radio wiphy
  wifi: cfg80211: Add parameters to radio-specific debugfs directories

 include/net/cfg80211.h |  4 ++++
 net/wireless/core.c    | 15 +++++++++++++++
 net/wireless/debugfs.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)


base-commit: 55db64ddd6a12c5157a61419a11a18fc727e8286
-- 
2.25.1


