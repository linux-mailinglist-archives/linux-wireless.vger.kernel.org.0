Return-Path: <linux-wireless+bounces-35028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMZSJpjt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F23428B0E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD2D23037F07
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216D389116;
	Mon, 20 Apr 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMi8Drbh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mcv6jw3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3EA38F226
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676190; cv=none; b=YFJaZb6iBJ3ifYpbb2HDsyWMymtJuK65KsPqplCZFEIFDUsEZr5xJcOOKX6XD+rlwENEa8YDM67UtHQqQNDKmShQzc0q8BR8qA3m5SpqoFa6bckLOiC21irZZiJ9QgSUO4sNMsiuudm2tSvnbXuqOR5Y5Fi1IWuDxSb+YjpM+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676190; c=relaxed/simple;
	bh=3oAwPSqUSWNLbBWan3lAgOgt+sT3/O/FFpnQG8O66MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iwatHTzuky45PEpWFoKamxPY46vZoHhX07QRrLi2iy/nVvcaZKP4ty2P0q5/N9dXTihwxeUZxcsmCJKObgNHk+wRdkf8p+LHhA6OqpdeZn1ylIsxee/bo3ReRTQ3o4aqzh+R9cZp4rx6aSwIm+Aw1SMNJehv4300FGPnDono9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gMi8Drbh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mcv6jw3S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7Wt6x1532102
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+qn1NIW45K+
	em9BTUPtoLJ3trXH+YxHK12XGZZm1G3M=; b=gMi8Drbhbd6/+5DP7v1tGUc8V5f
	d+Cx8Ikc4lTra3YtDKtI7wXro56TMDbhai5dYIcyqgr4ztaNKMNXPqcErJ8aNXRq
	+/cnp1u4ifR/E7hIfCAHFskAw1PW4m4fAKQ4jL+usVJ7rFUBn6vzIQIBo2+KDmos
	/73ox7pULIP8wQmdIuxGZREQKxPTkpXDNY1DX+0bt8paEp0nFzSqSXSiJCOQukrZ
	pE8SkVpgJ8H4+lrjDbXpWArLOyDekpQLKVN5xBPhdW7ylOr+IRh9rQgHcEjNI0vU
	neIEbgSWmBZjHWf6CsUm3PviFWfcWHZEAoZ8+D/3pd0TsX+juE1BPTOY23Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus0ns1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c44bf176so3332396a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676187; x=1777280987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qn1NIW45K+em9BTUPtoLJ3trXH+YxHK12XGZZm1G3M=;
        b=Mcv6jw3SGcbrGqzDcfRaoOCV0RR2Q1I2pbn8mgfcBpZ39xepxia/paVhOI2bUJ0ZpK
         7TNe40CAadEaxT9I5B9Z2JjIjZFZ7v1Uk207N7+T/H4vkJ7Ud8n7tViJbeOOlItO1Sg/
         rDzycaMYNhqIew/igZw8GHR8xBeoHnhLIqV+gjLSe4Ii/ZfJ7ewN5kBM9mZasV/SsaEV
         t9opEBZ89fqkfRu5/Q+p9BR00Nri+w+2TsGHUK4P/BVAkjzP3IXBKj2RruBx8Dn4TLCI
         VF2tAF0qe3OMvoHFZoxWGyErcA2h1O7sJblNIOYs6foMBjN8u5pAgwjUDn6WTChdv0lm
         QlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676187; x=1777280987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qn1NIW45K+em9BTUPtoLJ3trXH+YxHK12XGZZm1G3M=;
        b=IzmHusXAzxoAYIagfS4NSSdPM6fedHPjDUnWVMTzNgyD9PaHJMzmi3D2hyxpJcLqKy
         Yj+2XeeGvT+e8uUgYvRr49w1EySHPyDHM5I831zpUvXjeJevYoPKAB02/YqjQnO4FYyL
         K20qNDDNR18MITJY9h6ySFMkMMsUSLwxkRwEkP7iMnGrriC6wN17Brf37cbbr5VF9bD+
         t2/inblMLTSR3rs2KfpOv4Bow4X+qwJQUMDgFC0LawTJ72wZlGfzOKPmsVY6+9P5TbIX
         shIEydnflzwuJK/ff4lwqpuIXs5QdnZBOhro1cm8Y+hr+/7Z5IT2n7rcpA/pGzftxvUo
         z3Fg==
X-Gm-Message-State: AOJu0Yx39jetZzOG4CqTv/d7UzBtRj6k47xs1ANCho6Rh2i6i62WCEQ/
	XmZuH5lr3KbwjhgWUVIXCgY1wkoaGm877HYFQaFuPObS/IqE6ZKUXtfBESH/m7zQ/Blhy2VpRYa
	H0u2HfvmO/L/uQx899AuLI+UV4AJLP5TRgqzmkEf7gUdc84WPHjatX4j7ooQuaE8iRMSZ
X-Gm-Gg: AeBDietfZNX67mHV1KBJ5CYf0LawNea2PX7Ynmv4XOwqYQNvJvGR1IwOplXF1bIfOnC
	PpUXdo8g2xExaCobWdaMby7/tQMO+H4XmqgXycA++kiSeEgo8tntKoQ5cJGW0UncT48x3CXjaCt
	q3rKxiM+8ewK071PbKJKlZC3Q7DVh/N3/8RlIziSErZALSiMZJqEpvAcHd3UQ3/GNo0Gn30lYLC
	QBbfX0yM5M7/wWNrjMVHQSJIT7DmflWNBdBgx0EAerBYVlvX9aOlfKgP2+++R2xtUBA2dhm3aUa
	jDE/3sGg8gGl/T/zksKJnyDckigvukGV9W++MRQyyLyfVFJAgl/azZwthIk0sKh1t5OftbRl5Yo
	vSJc5L5/jdGm4btAFLz6+HeEUTEH88fFPNY3/KJA7ruPhLSTK/5wt10IE4tz4fKn7hw==
X-Received: by 2002:a17:90b:3c0f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3614046c9f7mr12880927a91.17.1776676186855;
        Mon, 20 Apr 2026 02:09:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0f:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-3614046c9f7mr12880895a91.17.1776676186239;
        Mon, 20 Apr 2026 02:09:46 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:45 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 06/13] wifi: cfg80211: add NTB continuous ranging and FTM request type support
Date: Mon, 20 Apr 2026 14:38:49 +0530
Message-Id: <20260420090856.2152905-7-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfX99IJW3HXvyJj
 BFCQ7sLRNNrWfs+Yi9hvSmfl3q4S6JW2tQ0PiKJ8jTOx/kEFETXqpt+TQcNPaVyOQg+shRBJt2F
 MaCD2QWXZYMInXZePgWEm4aC+p4owzblRlo+LDv5S2o+9h/86LMty9lkYPYPE//5h6SwyaUm4r2
 lMQCNqzFn/UUTK85c1cptLbIKewDiNefNYIb3J30pve4t67drozeDypAgN414lYcmyJ0Hvlpwfp
 qJlSTKD068zRngOPqEqopZqYFiFLUtwYqRWFzXBxXdQ0suGwW9nWlBvs+ptHg5Cd5yIohA2I+eu
 +mrpqvZyda3zE8QggsbIcg7sVHA4eCd74G8FALoo2b87RJ3dBTYWqagczXKz/oaFOHZCAyqWD8M
 vuzqs9WO7CoGUmFbs52GsX3ewgMHXAUyoSkZ7NASc299TR9SZ93qzvI6ZpC++TKKNzE94YmtQ+m
 mzsn6lgS8iny9x+bMwg==
X-Proofpoint-GUID: sUBgHGpIQUlRVEQweuuquggVJ6OcfUs2
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e5ed5b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=RhOg37svkhQRMARXwRAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: sUBgHGpIQUlRVEQweuuquggVJ6OcfUs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35028-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26F23428B0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable NTB continuous ranging with configurable timing and measurement
parameters as per the Wi-Fi Alliance specification "Proximity Ranging
(PR) Implementation Consideration Draft 1.9 Rev 1, section 5.3". Add
new FTM request attributes for min/max time between measurements,
nominal time (mandatory for NTB), AW duration, and total measurement
count.

Add NL80211_PMSR_PEER_ATTR_REQ_TYPE attribute using the new
nl80211_peer_measurement_ftm_req_type enum to allow userspace to
specify the ranging request type per peer:
  - NL80211_PMSR_FTM_REQ_TYPE_INFRA: STA-to-AP or AP-to-STA ranging
    (default if attribute is absent)
  - NL80211_PMSR_FTM_REQ_TYPE_PD: peer-to-peer ranging

Validate the request type against the device TYPE_CAPS capabilities
advertised via NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS. Reject PD
requests if the device does not advertise PD support.

Reject PD requests that set trigger-based ranging, as TB ranging is
not compatible with peer-to-peer proximity detection.

Add ftms_per_burst limit of 4 for PD NTB ranging requests.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 35 +++++++++++++++++++-
 include/uapi/linux/nl80211.h | 62 ++++++++++++++++++++++++++++++++++--
 net/wireless/nl80211.c       | 11 +++++++
 net/wireless/pmsr.c          | 61 +++++++++++++++++++++++++++++++++--
 4 files changed, 163 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 16b03a074f58..ec82ca19470b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4524,7 +4524,8 @@ struct cfg80211_pmsr_result {
  * @burst_duration: burst duration. If @trigger_based or @non_trigger_based is
  *	set, this is the burst duration in milliseconds, and zero means the
  *	device should pick an appropriate value based on @ftms_per_burst.
- * @ftms_per_burst: number of FTMs per burst
+ * @ftms_per_burst: number of FTMs per burst. If set to 0, the firmware or
+ *	driver can automatically select an appropriate value.
  * @ftmr_retries: number of retries for FTM request
  * @request_lci: request LCI information
  * @request_civicloc: request civic location information
@@ -4541,6 +4542,31 @@ struct cfg80211_pmsr_result {
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
+ * @request_type: ranging request type, one of
+ *	&enum nl80211_peer_measurement_ftm_req_type. Defaults to
+ *	%NL80211_PMSR_FTM_REQ_TYPE_INFRA if not specified.
+ * @min_time_between_measurements: minimum time between two consecutive range
+ *	measurements in units of 100 microseconds, for non-trigger based
+ *	ranging. Should be set as short as possible to minimize turnaround
+ *	time, since two-way ranging with delayed LMR requires two measurements.
+ *	Only valid if @non_trigger_based is set.
+ * @max_time_between_measurements: maximum time between two consecutive range
+ *	measurements in units of 10 milliseconds, for non-trigger based
+ *	ranging. Acts as a session timeout; if exceeded, the ranging session
+ *	should be terminated. Only valid if @non_trigger_based is set.
+ * @availability_window: duration of the availability window (AW) in units of
+ *	1 millisecond (0-255 ms). Only valid if @non_trigger_based is set.
+ *	If set to 0, the firmware or driver can automatically select an
+ *	appropriate value.
+ * @nominal_time: Nominal duration between adjacent availability windows
+ *	in units of milli seconds. Only valid if @non_trigger_based is set.
+ *	If set to 0, the firmware or driver can automatically select an
+ *	appropriate value.
+ * @num_measurements: number of Availability Windows (AWs) to schedule
+ *	for non-trigger-based ranging. Each AW may contain multiple FTM
+ *	exchanges as configured by @ftms_per_burst. Only valid if
+ *	@non_trigger_based is set. If set to 0, the firmware or driver
+ *	can automatically select an appropriate value.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4560,6 +4586,13 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 ftms_per_burst;
 	u8 ftmr_retries;
 	u8 bss_color;
+
+	u32 request_type;
+	u32 min_time_between_measurements;
+	u32 max_time_between_measurements;
+	u8 availability_window;
+	u32 nominal_time;
+	u32 num_measurements;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e540cd21b9e7..4be04dea7938 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7980,6 +7980,26 @@ enum nl80211_peer_measurement_resp {
 	NL80211_PMSR_RESP_ATTR_MAX = NUM_NL80211_PMSR_RESP_ATTRS - 1
 };
 
+/**
+ * enum nl80211_peer_measurement_ftm_req_type - FTM ranging request type,
+ *	used with %NL80211_PMSR_PEER_ATTR_REQ_TYPE
+ *
+ * @NL80211_PMSR_FTM_REQ_TYPE_INFRA: infrastructure ranging, i.e. STA-to-AP
+ * @NL80211_PMSR_FTM_REQ_TYPE_PD: peer-to-peer ranging as defined in the
+ *	Wi-Fi Alliance specification "Proximity Ranging (PR) Implementation
+ *	Consideration Draft 1.9 Rev 1"
+ * @NUM_NL80211_PMSR_FTM_REQ_TYPE: internal
+ * @NL80211_PMSR_FTM_REQ_TYPE_MAX: highest request type value
+ */
+enum nl80211_peer_measurement_ftm_req_type {
+	NL80211_PMSR_FTM_REQ_TYPE_INFRA,
+	NL80211_PMSR_FTM_REQ_TYPE_PD,
+
+	/* keep last */
+	NUM_NL80211_PMSR_FTM_REQ_TYPE,
+	NL80211_PMSR_FTM_REQ_TYPE_MAX = NUM_NL80211_PMSR_FTM_REQ_TYPE - 1
+};
+
 /**
  * enum nl80211_peer_measurement_peer_attrs - peer attributes for measurement
  * @__NL80211_PMSR_PEER_ATTR_INVALID: invalid
@@ -7993,6 +8013,9 @@ enum nl80211_peer_measurement_resp {
  * @NL80211_PMSR_PEER_ATTR_RESP: This is a nested attribute indexed by
  *	measurement type, with attributes from the
  *	&enum nl80211_peer_measurement_resp inside.
+ * @NL80211_PMSR_PEER_ATTR_REQ_TYPE: u32 attribute specifying the ranging
+ *	request type, using values from &enum nl80211_peer_measurement_ftm_req_type.
+ *	If absent, defaults to %NL80211_PMSR_FTM_REQ_TYPE_INFRA.
  *
  * @NUM_NL80211_PMSR_PEER_ATTRS: internal
  * @NL80211_PMSR_PEER_ATTR_MAX: highest attribute number
@@ -8004,6 +8027,7 @@ enum nl80211_peer_measurement_peer_attrs {
 	NL80211_PMSR_PEER_ATTR_CHAN,
 	NL80211_PMSR_PEER_ATTR_REQ,
 	NL80211_PMSR_PEER_ATTR_RESP,
+	NL80211_PMSR_PEER_ATTR_REQ_TYPE,
 
 	/* keep last */
 	NUM_NL80211_PMSR_PEER_ATTRS,
@@ -8227,9 +8251,11 @@ enum nl80211_peer_measurement_ftm_type_capa {
  *	default 15 i.e. "no preference"). For non-EDCA ranging, this is the
  *	burst duration in milliseconds (optional with default 0, i.e. let the
  *	device decide).
- * @NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST: number of successful FTM frames
- *	requested per burst
+ * @NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST: (Optional) number of successful
+ *	FTM frames requested per burst
  *	(u8, 0-31, optional with default 0 i.e. "no preference")
+ *	If the attribute is absent ("no preference"), the driver or firmware can
+ *	choose a suitable value.
  * @NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES: number of FTMR frame retries
  *	(u8, default 3)
  * @NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI: request LCI data (flag)
@@ -8263,6 +8289,33 @@ enum nl80211_peer_measurement_ftm_type_capa {
  *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK is set (so the
  *	RSTA will have the measurement results to report back in the FTM
  *	response).
+ * @NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS: minimum time
+ *	between two consecutive range measurements in units of 100 microseconds,
+ *	for non-trigger based ranging (u32). Should be set as short as possible
+ *	to minimize turnaround time, since two-way ranging with delayed LMR
+ *	requires two measurements. Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS: maximum time
+ *	between two consecutive range measurements in units of 10 milliseconds,
+ *	for non-trigger based ranging (u32). Acts as a session timeout; if
+ *	exceeded, the ranging session should be terminated. Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME: The nominal time field shall be
+ *	set to the nominal duration between adjacent Availability Windows in
+ *	units of milli seconds (u32). Mandatory if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION: (Optional) The AW duration field
+ *	shall be set to the duration of the AW in units of 1ms (0-255 ms) (u32).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ *	If the attribute is absent ("no preference"), the driver or firmware
+ *	can choose a suitable value.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS: (Optional) number of
+ *	Availability Windows (AWs) to schedule for non-trigger-based ranging.
+ *	Each AW may contain multiple FTM exchanges as configured by
+ *	%NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST. Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ *	If the attribute is absent ("no preference"), the driver or firmware
+ *	can choose a suitable value.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8284,6 +8337,11 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
 	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
 	NL80211_PMSR_FTM_REQ_ATTR_RSTA,
+	NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+	NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 51046d749581..3fb540c6adcf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -476,6 +476,15 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR] = { .type = NLA_U8 },
 	[NL80211_PMSR_FTM_REQ_ATTR_RSTA] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS] = {
+		.type = NLA_U32
+	},
+	[NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS] = {
+		.type = NLA_U32
+	},
+	[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = NLA_POLICY_MAX(NLA_U32, 255),
+	[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS] = { .type = NLA_U32 },
 };
 
 static const struct nla_policy
@@ -498,6 +507,8 @@ nl80211_pmsr_peer_attr_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
 	[NL80211_PMSR_PEER_ATTR_REQ] =
 		NLA_POLICY_NESTED(nl80211_pmsr_req_attr_policy),
 	[NL80211_PMSR_PEER_ATTR_RESP] = { .type = NLA_REJECT },
+	[NL80211_PMSR_PEER_ATTR_REQ_TYPE] =
+		NLA_POLICY_MAX(NLA_U32, NL80211_PMSR_FTM_REQ_TYPE_MAX),
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index c21f693fac29..951ba0b96da2 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -91,11 +91,10 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
 
 	if (capa->ftm.max_ftms_per_burst &&
-	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
-	     out->ftm.ftms_per_burst == 0)) {
+	    out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
-				    "FTM: FTMs per burst must be set lower than the device limit but non-zero");
+				    "FTM: FTMs per burst must be set lower than the device limit");
 		return -EINVAL;
 	}
 
@@ -128,6 +127,14 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_PD &&
+	    out->ftm.trigger_based) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    ftmreq,
+				    "FTM: TB ranging is not supported for PD request type");
+		return -EINVAL;
+	}
+
 	out->ftm.non_trigger_based =
 		!!tb[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED];
 	if (out->ftm.non_trigger_based && !capa->ftm.non_trigger_based) {
@@ -143,6 +150,14 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_PD &&
+	    out->ftm.non_trigger_based && out->ftm.ftms_per_burst > 4) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
+				    "FTM: FTMs per burst must not exceed 4 for PD NTB ranging");
+		return -ERANGE;
+	}
+
 	if (out->ftm.ftms_per_burst > 31 && !out->ftm.non_trigger_based &&
 	    !out->ftm.trigger_based) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -222,6 +237,33 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (out->ftm.non_trigger_based) {
+		if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_PD &&
+		    !tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]) {
+			NL_SET_ERR_MSG(info->extack,
+				       "FTM: nominal time is required for PD NTB ranging");
+			return -EINVAL;
+		}
+		out->ftm.nominal_time =
+			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS])
+			out->ftm.min_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS])
+			out->ftm.max_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION])
+			out->ftm.availability_window =
+				nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS])
+			out->ftm.num_measurements =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS]);
+	}
+
 	return 0;
 }
 
@@ -249,6 +291,19 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 
 	memcpy(out->addr, nla_data(tb[NL80211_PMSR_PEER_ATTR_ADDR]), ETH_ALEN);
 
+	if (tb[NL80211_PMSR_PEER_ATTR_REQ_TYPE])
+		out->ftm.request_type =
+			nla_get_u32(tb[NL80211_PMSR_PEER_ATTR_REQ_TYPE]);
+	else
+		out->ftm.request_type = NL80211_PMSR_FTM_REQ_TYPE_INFRA;
+
+	if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_PD &&
+	    !rdev->wiphy.pmsr_capa->ftm.type.pd_support) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_PEER_ATTR_REQ_TYPE],
+				    "FTM: PD request type not supported by device");
+		return -EINVAL;
+	}
 	/* reuse info->attrs */
 	memset(info->attrs, 0, sizeof(*info->attrs) * (NL80211_ATTR_MAX + 1));
 	err = nla_parse_nested_deprecated(info->attrs, NL80211_ATTR_MAX,
-- 
2.34.1


