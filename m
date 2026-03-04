Return-Path: <linux-wireless+bounces-32443-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALLKCn7cp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32443-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDECC1FB79F
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 390BF3091AAE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51430CDAF;
	Wed,  4 Mar 2026 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6zVNRNN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P3/TskKm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6F34D398
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608589; cv=none; b=qSMIPzU847hmR63YIUscTFcwLTRUmwpzGXZQB3O0ULTw2UVBBHmfuGkYsxNixh+NdAJY4zw5bEN0a2pP92uHzoDIq5Gc0W/hekZgst6TvpBYKfcZaqMJafvrZnw7/S1+AzhJL6/SgwcWoXBAaT8uElhq+OxmciHTlqt8fjfddE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608589; c=relaxed/simple;
	bh=Xw/vZYWXKIur1bEfBGgo4c1PgteXoha3zbBdrefYyl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDKkrqGdhtJ5cVXq8AwbT5Jgrf1wrBQdplEdh9D7dOK+crW/LM6SkQOSkcOQcXQ2ipqQKiIuPh6sEtn57hSag42oFdS/lEGbU7wXIDaDl+ysRkKjaAcp7sICXhKN8mEaDicU2cFJkE3OkOpUzig28hNnN6XJN/XpGAB+rAslYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S6zVNRNN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P3/TskKm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6246D6w91203226
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9UwMfnszUC+
	63XUhVNWS5dkm0JUBPy0SLykuzcR3JH8=; b=S6zVNRNNQwtk+1ccAH4LsiV8doh
	jSi76mccsYN2a56gAR7Zg1a3bX1E3l2UOgp0OVPGMyP7r6euDfRyGK2cijNRGYHA
	aD5JL0cLoqtJQovg8pI8HslFrit0oE9wBasx/dG4QQXNYeR38v+N16Y45ed4BcE/
	SeBUAKinaOCV57/2Q0JVzGbiEElce/clD1eT3Mye8baS/W0p+bYyKq977ySZY3eE
	d8qK3jj4/3G31rmg203IXnFVSv+gFVljw56pCaBIwqvkbVkxtATQ7FpnoOpE4pe/
	Ga4MhftluKnF+eNzJgAlerYY3Ap90UO1GNZ989rqD2peSyqD3MddbQo4E7A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpf9c05ya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70efa3b730so3688930a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608586; x=1773213386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UwMfnszUC+63XUhVNWS5dkm0JUBPy0SLykuzcR3JH8=;
        b=P3/TskKm8kJhJhG8sU+xQQZelWKWTtljccMgI+C8uMYUST+856Igj+/i/NRyxVpREt
         WOaNJSECXxkwOsv34UotcFMgJv645wSH5OHCPPm/NC/7x2oB8KVENK9K0sqQq5d1m+9k
         hCS7+wOT1hQRqBynuZw9355qqUs5CUkdfxh6mbb73lv+VlItIU+k9H0YCmcoij4olUbz
         KJQnBxRI+SEdczEJkLzNIXHKaTD0tpdNL0zFUQCwlq7JxQFeu9OSIB2gX7VuZ3Mdaf0d
         aSdRAJYJkX58nibFnEfQfUezGez1dQUkR+aJxryhYN8eUd8RnTELCesnE1QcZ2CtFcEQ
         6NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608586; x=1773213386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9UwMfnszUC+63XUhVNWS5dkm0JUBPy0SLykuzcR3JH8=;
        b=ZHSUmZ/7DB2Ynt06sDrRdHm/xFT3rYsYp2wFCgVupTchNnCGYZ8qu+3Raspdt9Ln5w
         hJm1OBak/1kaUdN3N9EuRzHfU3skHUVZxWUy8aeu6j+JTgGch+/nvR94fSupGhBg7iqL
         9ATMaoBiMaVr6MxhWlLegAZZ2xoyU42VuDKVgP80oGToE9jFSUX68WfGOnju7cH3wl4p
         K7qeoxvDpFKC9hHyomOLOzSb2a1MnskpRQQ4nHJBTn0FISi0CZxlAnLmSQHdiTZK+NHF
         BoJm+m9JFYbfIN4AaiB9SX6naQv8QwU4go+8qvlA2/tjBeYnfDBVAUVT8Rsgf/RsSy8N
         98jQ==
X-Gm-Message-State: AOJu0YwRzZlHfEMZr6f0Geus0VReCsGklO+TF9wLFQEYLpsgelR3ZG0U
	ilzwbQPGZ9Ok8QJmKCw5VdlW9EgJiOHs0iYhAGmAjL+e9fy5NL8fc1L5/Z7HAR6qRuupyWrD4SR
	0P0PbkP1wG0kTPeFvm1qrWgAXUGwk2QDT0Gr+e9wf+w5PDkesuSICsqyYwOvS9SzKahHGtsXvvo
	tJ
X-Gm-Gg: ATEYQzwkrItwsIDzh356a+KOxAt08H6r7bGsjl9RmPet8/jvQEilgYFUY2du5laA859
	3Alh1pvhbiK5N2Pkk3BKlMihgyHCWI4zRqOh1v/xVEiXliHteN/RkjECdQwx6JqHpfBEkegoiGi
	dWhgcCVBZQk3l/4VKYw7kidrmt7YB5QtVFrI6kaQis/T+BIEETS/NGiQkPJVtT9JYjOJbDtZbYj
	tVTz0BpshfIYf5o9me1yjDEnRLSRb62sjb3BbfXglQ9etiuUc6W8gps6gL0eebmjLE+wB++M7ha
	f4EX/U0DzKGnk33DypIRRiRqKe6x0xdg8drqpWXbOzNRJi73LE3dGZU8uQHXxPdeEaBEh/iyHSN
	nfdvnZZZn06N/JHHctw5yLCHVwj8hexx8zmCYndV9T4CeXPS0wHRevfo=
X-Received: by 2002:a05:6a20:db8e:b0:393:c607:9d3c with SMTP id adf61e73a8af0-3982e1f03a2mr1142834637.47.1772608586454;
        Tue, 03 Mar 2026 23:16:26 -0800 (PST)
X-Received: by 2002:a05:6a20:db8e:b0:393:c607:9d3c with SMTP id adf61e73a8af0-3982e1f03a2mr1142803637.47.1772608585882;
        Tue, 03 Mar 2026 23:16:25 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:25 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 07/16] wifi: cfg80211: add continuous ranging and PD request support
Date: Wed,  4 Mar 2026 12:45:29 +0530
Message-Id: <20260304071538.3833062-8-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX3dbFx+/hRbW7
 nmVRXzQHRJuMG/bObYT6TlwTdfgaCcYMr3vyeaFHgcIR+UT9sHCFP9Nck6aMrXMg5+ZFxZjfz9g
 vVKmWWIcvQRcdEz9ZAQaT63Z4mOVRC1f2/5yAJQ8tzEeJEy+zf1amSs6SOdC7WRxEK4Tkt8OTBG
 VtHFCCgCEKnS1wFWVsi4dWNVlZyeLXh6u3CPRKGdnIpyyI8Ff56dXyddioEFidZZwmlmzwHKLj4
 Q2Dn14uEuF0buDNRFe4uubEdq5vwf1Kxv7dOP6hZQEadQ06a7yl1Txq1iIN1oioXADcLNYnz5mO
 jvJ4fECuDnB9Nlz0nXLvxbNokBYLXqLk1vU70ijZLihhcH68XQnFcENroeKkrA7RHA5NYSf0H58
 Xv9ZourZTe7NVxIJMrdwAVKU7kYm73MXHfd5R4zag4OWG8iY8zJZk8ODMJOMdR6Mv4jMlTx7wgG
 J/xe+vLaDUoO3TrhKtA==
X-Proofpoint-GUID: G367HZkQJZp0-wOzMS6tXQGFW8YujESE
X-Authority-Analysis: v=2.4 cv=S4LUAYsP c=1 sm=1 tr=0 ts=69a7dc4b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=dR6-dSxPkkEvzmubSWgA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: G367HZkQJZp0-wOzMS6tXQGFW8YujESE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040058
X-Rspamd-Queue-Id: BDECC1FB79F
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32443-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Proximity detection (PD) applications require sustained measurement
sessions without repeated FTM negotiation overhead. Currently, each
ranging session requires separate negotiation.

Enable NTB continuous ranging with configurable timing and
measurement parameters as per the specification "Proximity Ranging
(PR) Implementation Consideration Draft 1.9 Rev 1, section 5.3".
Add PD capability validation to support proximity detection sessions.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 22 +++++++++++++++++-
 include/uapi/linux/nl80211.h | 26 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 10 +++++++++
 net/wireless/pmsr.c          | 43 +++++++++++++++++++++++++++++++++---
 4 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62a2139b2f37..b66300497312 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4369,6 +4369,19 @@ struct cfg80211_pmsr_result {
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
+ * @min_time_between_measurements: minimum time between two consecutive range
+ *	measurements in units of 100 micro seconds, applicable for
+ *	non trigger based ranging. Only valid if @non_trigger_based is set.
+ * @max_time_between_measurements: maximum time between two consecutive range
+ *	measurements in units of 10 milli seconds, to avoid FTM negotiation
+ *	applicable for non trigger based ranging. Only valid
+ *	if @non_trigger_based is set.
+ * @availability_window: duration of the availability window (AW) in units of
+ *	1 millisecond (0-255 ms). Only valid if @non_trigger_based is set.
+ * @nominal_time: Nominal duration between adjacent availability windows
+ *	in units of milli seconds. Only valid if @non_trigger_based is set.
+ * @measurements_per_aw: number of measurement attempts per availability window
+ *	with a maximum value of 4. Only valid if @non_trigger_based is set.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4388,6 +4401,11 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 ftms_per_burst;
 	u8 ftmr_retries;
 	u8 bss_color;
+	u32 min_time_between_measurements;
+	u32 max_time_between_measurements;
+	u32 availability_window;
+	u32 nominal_time;
+	u32 measurements_per_aw;
 };
 
 /**
@@ -4395,12 +4413,14 @@ struct cfg80211_pmsr_ftm_request_peer {
  * @addr: MAC address
  * @chandef: channel to use
  * @report_ap_tsf: report the associated AP's TSF
+ * @pd_request: indicates a peer-to-peer PD request
  * @ftm: FTM data, see &struct cfg80211_pmsr_ftm_request_peer
  */
 struct cfg80211_pmsr_request_peer {
 	u8 addr[ETH_ALEN];
 	struct cfg80211_chan_def chandef;
-	u8 report_ap_tsf:1;
+	u8 report_ap_tsf:1,
+	   pd_request:1;
 	struct cfg80211_pmsr_ftm_request_peer ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 59e8ba9c37c4..4dafaf25b0f6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7792,6 +7792,8 @@ enum nl80211_peer_measurement_resp {
  * @NL80211_PMSR_PEER_ATTR_RESP: This is a nested attribute indexed by
  *	measurement type, with attributes from the
  *	&enum nl80211_peer_measurement_resp inside.
+ * @NL80211_PMSR_PEER_ATTR_PD_REQUEST: flag attribute indicating this is a
+ *	peer-to-peer PD request
  *
  * @NUM_NL80211_PMSR_PEER_ATTRS: internal
  * @NL80211_PMSR_PEER_ATTR_MAX: highest attribute number
@@ -7803,6 +7805,7 @@ enum nl80211_peer_measurement_peer_attrs {
 	NL80211_PMSR_PEER_ATTR_CHAN,
 	NL80211_PMSR_PEER_ATTR_REQ,
 	NL80211_PMSR_PEER_ATTR_RESP,
+	NL80211_PMSR_PEER_ATTR_PD_REQUEST,
 
 	/* keep last */
 	NUM_NL80211_PMSR_PEER_ATTRS,
@@ -8012,6 +8015,24 @@ enum nl80211_peer_measurement_ftm_capa {
  *	%NL80211_ATTR_TIMEOUT has expired.
  *	Set %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK to ensure RSTA will have
  *	the measurement results to report back in the FTM response.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS: minimum time
+ *	between two consecutive range measurements in units of 100 microseconds,
+ *	applicable for non-trigger based ranging (u32). Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS: maximum time
+ *	between two consecutive range measurements in units of 10 milliseconds,
+ *	to avoid FTM negotiation, applicable for non-trigger based ranging (u32)
+ *	. Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME: the nominal time field shall be set
+ *	to the nominal duration between adjacent Availability Windows in units
+ *	of milli seconds (u32). Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION: The AW duration field shall be set
+ *	to the duration of the AW in units of 1ms (0-255 ms) (u32).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW: meas per AW field shall indicate the
+ *	number of measurements attempts per AW with a maximum value of 4 (u32).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8033,6 +8054,11 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
 	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
 	NL80211_PMSR_FTM_REQ_ATTR_RSTA,
+	NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 77447f63d112..2b7de56c466f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -372,6 +372,15 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
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
+	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = NLA_POLICY_MAX(NLA_U32, 4),
 };
 
 static const struct nla_policy
@@ -394,6 +403,7 @@ nl80211_pmsr_peer_attr_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
 	[NL80211_PMSR_PEER_ATTR_REQ] =
 		NLA_POLICY_NESTED(nl80211_pmsr_req_attr_policy),
 	[NL80211_PMSR_PEER_ATTR_RESP] = { .type = NLA_REJECT },
+	[NL80211_PMSR_PEER_ATTR_PD_REQUEST] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 17f0b1c97d58..4ae25b946111 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -91,11 +91,10 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
 
 	if (capa->ftm.max_ftms_per_burst &&
-	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
-	     out->ftm.ftms_per_burst == 0)) {
+	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
-				    "FTM: FTMs per burst must be set lower than the device limit but non-zero");
+				    "FTM: FTMs per burst must be set lower than the device limit");
 		return -EINVAL;
 	}
 
@@ -196,6 +195,36 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 	}
 
+	if (out->ftm.non_trigger_based) {
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
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME])
+			out->ftm.nominal_time =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW])
+			out->ftm.measurements_per_aw =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW]);
+	}
+
+	if (!out->ftm.rsta && out->ftm.ftms_per_burst == 0 &&
+	    out->ftm.measurements_per_aw == 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    ftmreq,
+				    "FTM: Invalid parameters:Both Ftm's per burst and measurements per avail window are zero");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -223,6 +252,14 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 
 	memcpy(out->addr, nla_data(tb[NL80211_PMSR_PEER_ATTR_ADDR]), ETH_ALEN);
 
+	out->pd_request = !!tb[NL80211_PMSR_PEER_ATTR_PD_REQUEST];
+
+	if (out->pd_request && !rdev->wiphy.pmsr_capa->pd_support) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_PEER_ATTR_PD_REQUEST],
+				    "PD request not supported by device");
+		return -EINVAL;
+	}
 	/* reuse info->attrs */
 	memset(info->attrs, 0, sizeof(*info->attrs) * (NL80211_ATTR_MAX + 1));
 	err = nla_parse_nested_deprecated(info->attrs, NL80211_ATTR_MAX,
-- 
2.34.1


