Return-Path: <linux-wireless+bounces-26977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C2B42778
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FE91640C1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F22701BD;
	Wed,  3 Sep 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cgRRnuwT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129293148CD
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918866; cv=none; b=RxGnHfLIkB+qgjghR8DsHKQKA01oLAd08b1RjjnxcNom5E+eA2GYDjAWm8V6/Zf7XVj6gRl+tnDDT0P67EFSY7rnuViT8I5C/DEMaqoMSR4szT4lrjpVskp5fIF3UxVdKnDyMhyxanWqBt8zsHITiJfkaQF8db533ll4TgEYkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918866; c=relaxed/simple;
	bh=W81qmHD0+JJnGvtj9YgseSKt3QgxHb+O/6Enrxj8KSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4aVN2Rq7aumhKMvIzbujOQXW2O+9K3toU0tAWDdm0rbX9SDITR2S0vLUjvY9BTNZn2aK+EgqU+9JxL34mJON+oO3wC+4a10aKJC4VCnDBGRR8RD9X99CU7g4CyTJoyuAhsLhRgGXdsvUhpF9mdmSk9jBVNAja33C5cYvOS5u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cgRRnuwT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx1FX007644;
	Wed, 3 Sep 2025 17:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1p8+8wt62sIkcfigaau0mK
	RzPTiMtr3iG3Iu2AC0X5U=; b=cgRRnuwTIYUSOT1UNh9YRNfb0NGn/RClrkDXM8
	Wqmclwwf2WFBzaVZZXm+imxNg4tXeNCDEkz3TDazZk6m5u4tTk3zBa51UpAcnFEp
	rZ2Z8PhoC1uGRh0FtHwLiG+lcNgG490UKgHPpJ2hBFo6Xv6iXxU3o+5tlEHQ42cF
	nnvCYVkHyfG+ZsFdONOOTlKA2gShG/51QiGJ6fsjQN7sEk6VgM4SknKm9BeBIy4B
	xKQPCI+vuiF+JBZci5x5aKCnkAmK6yMpjaD51QbRc5f4ZqPkd+WAB+Y+F1B818xK
	S7FUI/GZWxJ94qNGT3cU6wixobGdvaJIp5lkandXhrKR5AFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv4nfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 17:00:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 583H0vr3015291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Sep 2025 17:00:57 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 3 Sep 2025 10:00:56 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [DESIGN RFC] Add debugfs support for multi-radio wiphy
Date: Wed, 3 Sep 2025 22:30:42 +0530
Message-ID: <20250903170042.3830067-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXygRc3m85ysIX
 0fLkntNeu6ixyD8gb00U14IHjY/fDefidccMuR3ysWQMRBUVlMgBkgqqaE9G6A37kggyIjq6Ygi
 E9Z7hXuPQmvEpMrxP0omC6dj/QZEMbNlUK9a+t+eaLbwZ9OksbHfLk2/Dgh0qwvMKxEzOmI2iZn
 AO0YPL2h7Ri/XzS2IhWlf2w72ffLUnituuvjGzLDk1itbMnB/swqNn740l3ftzPLQpR4SbIwu5g
 WApwFsURw5pu29GY3ZuTGbBpjMx0K1aMm92VFpwwUveOACk1cJ6CrrIEFCWD4n2O1N7t+BHwMnl
 /S/+gj5Q1nXZzwZrrrm0ykK7/GBDr4ZNpG66A2hXQSAABUb4kmaCGBh5kyoz8KYALLNs3B+ozxx
 yV+JFLnm
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b8744a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=IsurDZg_-Bx4nWSp264A:9
X-Proofpoint-ORIG-GUID: HvsyAG2mDlfnpcmVhLChwmG-jKR2BQ6R
X-Proofpoint-GUID: HvsyAG2mDlfnpcmVhLChwmG-jKR2BQ6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

In multi-wiphy architecture where each radio is tied to a separate wiphy,
a few radio configuration parameters and wiphy parameters are maintained
as separate debugfs entries. So, the radio configuration parameters -
'fragmentation_threshold', 'rts_threshold', 'long_retry_limit' and
'short_retry_limit' and the wiphy parameters - 'airtime_flags',
'aql_enable', 'aql_pending', 'aql_threshold', 'aql_txq_limit', 'aqm',
'force_tx_status', 'ht40allow_map', 'hw_conf', 'hwflags', 'power',
'queues', 'rate_ctrl_alg', 'reset', 'total_ps_buffered', 'user_power' and
'wep_iv' are present in separate directories corresponding to the
respective wiphy. So the debugfs directory structure is represented as:
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

In single-wiphy architecture, where a single wiphy can have multiple
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
denote per-radio configurations of a wiphy.
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc8..ebf1ab99766b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5584,6 +5584,7 @@ struct wiphy_iftype_akm_suites {
  */
 struct wiphy_radio_cfg {
        u32 rts_threshold;
+       struct dentry *radio_debugfsdir;
 };

 /**
		
Create separate directories representing each radio within phy#X directory
during wiphy registration.
diff --git a/net/wireless/core.c b/net/wireless/core.c
index a7e2931ffb2e..46d9c881c7fc 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1009,8 +1009,14 @@ int wiphy_register(struct wiphy *wiphy)
                 * MIB default values. RTS threshold is disabled by
                 * default with the special -1 value.
                 */
-               for (idx = 0; idx < wiphy->n_radio; idx++)
+               for (idx = 0; idx < wiphy->n_radio; idx++) {
                        wiphy->radio_cfg[idx].rts_threshold = (u32)-1;
+                       scnprintf(radio_name, sizeof(radio_name), "radio%d",
+                                 idx);
+                       wiphy->radio_cfg[idx].radio_debugfsdir =
+                               debugfs_create_dir(name,
+                                                  rdev->wiphy.debugfsdir);
+               }
        }

        /* check and set up bitrates */

This will create separate directories within phyX directory like:
# ls /sys/kernel/debug/ieee80211/phy0/radio
radio0/ radio1/ radio2/

Whenever a wiphy configuration parameter is added as an entry to phyX
directory, check if that applies on a per-radio basis and if it does,
create its entry in radio directories too. This way radio-specific
configuration parameters can be maintained along with global wiphy
configuration parameters. Also, initialize the entries inside radio
directories with value present in global wiphy configuration, because at
the time of wiphy registration, all radios in wiphy will have the same'
parameters configuration.

With this change brought in, when user tries to modify the value of any of
radio's configuration parameter, only that radio's parameter will change
and the global wiphy parameter and other other radios' parameter values
will remain unchanged. Also, when the user tries to write to global wiphy
parameter, then the existing behavior will work, i.e., the global wiphy
parameter will get changed, but in addition, that particular parameter of
all radios in that wiphy will also get updated to the new value of global
wiphy parameter. This ensures backward compatibility is maintained, i.e.,
the existing userspace will work alongside the per-radio parameters
configuration implementation.


