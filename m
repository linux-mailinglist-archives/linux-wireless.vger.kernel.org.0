Return-Path: <linux-wireless+bounces-34708-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJVkAWAO3WlsZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34708-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:40:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C13EE164
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C0623010810
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F43BF68E;
	Mon, 13 Apr 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EaCkhGes";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/EiEaAy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6513E1D1C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094784; cv=none; b=N6XzE6+Ci+7JJo46hR4ZmPV3OJfnvVvrxVGJAy8YTYFFe6OuliJxVddt0fr79RRFh8FH+9JT/h9cn9HzREGk794sLW3nGPCYZrazFHuJl3yllDd55QL3uGK40uiWlvKAsqDUS8L9cr0n08a1bEtI9C8M47DWOChMBs4j42XwTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094784; c=relaxed/simple;
	bh=vbrqIemNZ+WyTOmjaIuecXLvyiqLYw7sH+A7J8nE9OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coggRzXIieD1gpv4wOgP3sDZBKstV5sVweQtzcFWyNTomJ1wqoHg6wzoSrsajXRDxF+VIzlalsGkwJK06Vy35oHWkZXorxcttBGdXh77Uc8mO3EHkvidb4M/0bKYLfpGPhG7G7Qj/Kmx5Ppv5sT7FVX+zDzw5kapDufBp8qhp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EaCkhGes; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A/EiEaAy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DF5pk43751102
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LTZe5zfbQKe
	nBOvcXLaRuSgtBUm3MTFg5vbLv0R2nqU=; b=EaCkhGesgGef8kyIUUstghePAzx
	YD96o8arVhF33UkPpuFcujK5LbzW5oqT6njJmcXWlpcdaBbVtPkhMsMK/dZI53YF
	i0wlGgvHf4zSMC4uTahbiiwgm2E8wrARBBEJ5IU8E+UoV8fMpezVX68gAyP/Vi2u
	FKxp7NVkjDPoLtD7Z+OOO7Utx0yVirOvPAAgN66rvqA8FhltxGPx+U2LaB2hMh0I
	uT/8eeHsGP+qmMgDB657RpAytu30rnBHd35ygls87mcNqbpzIQhVddIFXzvSuCCW
	G82go0141v023Uwg2wEnP8TxDgHxFKRZz53XghHo5VnNbLEgq5hHXPN7Msg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh2tu839h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso925346a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776094780; x=1776699580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTZe5zfbQKenBOvcXLaRuSgtBUm3MTFg5vbLv0R2nqU=;
        b=A/EiEaAyxEcrqx/T0TrQqpVq8y+mBqgbfCGBGuSlUxtw71OTowtuI+L9spc+35Ffoc
         wTq/kTUnxF/KpkFY+vZAtOhWwe5hN+iueI506Y70SAik5wCjdOUIulP7WKZEE4aFXuCX
         vns8RihWgRkCx1GB8LGU0k0tADOUdOhS6bEbwMuVm88/QzB3f3OJe5GVYQ0PxRejiDtj
         6sH1hiJ+PqJFJY/4uMkZ/d5yIqlQrc8RggzmKbFd8YAyP2idjCDMk4FOqyUuLKOciklJ
         TxCjCCtk3GWbAoicxyX0i1hTjN98iETLuHxWp/M9kfvskPF4gwuxFDMzaQCZ3SZR58wZ
         PD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094780; x=1776699580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTZe5zfbQKenBOvcXLaRuSgtBUm3MTFg5vbLv0R2nqU=;
        b=fhOzONo9BOaxAI0z5VN8nLhVGvoyjVUFW/Xea4lnxJgNE9J+fbtbVv2ZgGfDhB1AY/
         pqE7PJlPYhcuQpOqooNi/o+2BGpvoggfGVThYXPv0Un2ZS9RFVXMxVnL0jpPK7Xp3ubu
         K/6BOR7NLgLbtisD4Rkc3XzZJQAEivySSIiGOEE35Pd/Gp2HwMUpkw02VZpA3PYVyb5t
         GFB9tugHb9fu4zj/rcOwK0WkS7fVEnC3eku8+fPJs/F+8vTsQrCrje+RUDkHCTgpWIeP
         EVkqWqZHphcrBKXvnkpQjhsGNv4Pvs61rIqKHrXsMATWX6iMd2Hlnb7Q1QRn+BUDEk0T
         WZgg==
X-Gm-Message-State: AOJu0Yw5Kl+Rtu98T4SNOpOS3HZIYtadZdsinYkvaSFX/GYp4MlJCeEt
	c79mmJGi+bEXMx24aCuO9cqqAWkX+sjzfMmbZcJ7TIShfWfDzLdKKG7msSQI0hD5xuIKdRNPl37
	wU6oYJHMs8XtM8HHkM5OY+beIo7tdyx2YAm5zP226WGAPPVbBpw0YdUQs6k94edj3wNnUymDubH
	858w==
X-Gm-Gg: AeBDietUZeK8Zg6e8x7TbfmjXPRzq/ZhXN8rbTMXkV9dw0uQZUy7JGUh+fbUh0Smenw
	WVlis07QWwXYTfTAROxfaFPphCDG9ytH+iQ0+fbGvg+VYx9y3DRym7rTuUOiS+9Z37Ehu5DN7/i
	ek6jMnT6Cm8w9e1Myn6Dj3koaest9CibYAGipV1WlsxrtYnRtETOpgi7FU9hi0wMKicYRwc0hfj
	X4cp5FHlk3Q0889uMEeK/r/jsBx+lNrn6TcTe+Fl4pSCBR6h6HFtx5pqvNpEjPQQAh/HeJ7a4V7
	44QxccNtfWlo5rKLbzhzuUMINRrYFSVZuKR9lM6HlGhLW8/Q6r/Show2jTklK2Dim07Us/QVWbc
	pbbrezHHssq/DPyQnq33gBZK8gL9K3pgYm39IkD2DtUe0gdE0Y9uisB65ahyw02GjvosgqvD0C2
	ChHBw77l6pX84/ilnHZ2OGXqMMYHONMcW7x3nsMJTa8AW1oa/ijpU=
X-Received: by 2002:a17:90b:3dce:b0:35f:b313:84ca with SMTP id 98e67ed59e1d1-35fb31388cfmr5562152a91.27.1776094780229;
        Mon, 13 Apr 2026 08:39:40 -0700 (PDT)
X-Received: by 2002:a17:90b:3dce:b0:35f:b313:84ca with SMTP id 98e67ed59e1d1-35fb31388cfmr5562127a91.27.1776094779705;
        Mon, 13 Apr 2026 08:39:39 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm13000123a91.3.2026.04.13.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:39:39 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 1/5] wifi: ath12k: handle thermal throttle stats WMI event
Date: Mon, 13 Apr 2026 21:08:36 +0530
Message-Id: <20260413153840.1969931-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v6f_9H-6pwvZ6E6deqc7lWIjgsQVOYoL
X-Proofpoint-GUID: v6f_9H-6pwvZ6E6deqc7lWIjgsQVOYoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MyBTYWx0ZWRfXw7PARI3IfnZl
 9+DplzEvZ2fa6JmaiCVKQAtZvrkd/FgnON5vvv8xjyQPm3MqjwX1COB5fWTrGgVlrLQtUuOxZHY
 +8kto3MbcZD83rBJ/bT1jzB2eIy+Pbn12y+RQ/T3XP6CjTBVZZ3xWEikmgx1rScADwOTFaKnkxe
 wry5Ul2QljRjXnmZqIWzR0afiK2SYHjV+pqFw9jpeVMH7FR1ZALTt99dCuQSkCTat0WGQDc0Tuo
 OL0lv9BxcSBWdxUo+Gh70ZipQ5GIk7J4GqowVBfusdG9tJc7hFcTeU2RZmASZvaiNpnQ7mArnNa
 KtMQJJWkeEdHW/7kX2GT/h9mMUCqwIGBhTC2BUisf2il5UEhbFvYofp6YwKx3cIeo9Vi4927Sfc
 3gFMmp5Vz/unBT156ech7vNSYSpOeVHinAd9ZePNofDfpNh15V8FjU9SepWbop0Elm9CK7CE+I8
 c6q0XYw25RZCHa5AANw==
X-Authority-Analysis: v=2.4 cv=RJ+D2Yi+ c=1 sm=1 tr=0 ts=69dd0e3d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=E37thjIwhXKEW9KdV9kA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130153
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34708-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E56C13EE164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add handling for WMI_THERM_THROT_STATS_EVENTID by defining the
wmi_therm_throt_stats_event TLV and parsing pdev_id, temperature and
throttle level.

The firmware can emit this event periodically, including when the
throttle level is 0.

Log the received thermal throttle stats to get the current temperature level,
temperature and thermal throttling levels.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 39 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  8 ++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 484fdd3b1b7f..6b24911bdb7c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -8762,6 +8762,42 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 	rcu_read_unlock();
 }
 
+static void ath12k_wmi_thermal_throt_stats_event(struct ath12k_base *ab,
+						 struct sk_buff *skb)
+{
+	const struct wmi_therm_throt_stats_event *ev;
+	struct ath12k *ar;
+	const void **tb;
+
+	tb = ath12k_wmi_tlv_parse(ab, skb);
+	if (IS_ERR(tb)) {
+		ath12k_err(ab, "failed to parse thermal throttling stats tlv: %ld\n",
+			   PTR_ERR(tb));
+		return;
+	}
+
+	ev = tb[WMI_TAG_THERM_THROT_STATS_EVENT];
+	if (!ev) {
+		ath12k_err(ab, "failed to fetch thermal throt stats ev\n");
+		return;
+	}
+
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev->pdev_id));
+	if (!ar) {
+		ath12k_warn(ab, "received thermal_throt_stats in invalid pdev %u\n",
+			    le32_to_cpu(ev->pdev_id));
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "thermal stats ev level %u pdev_id %u temp %u throt_levels %u\n",
+		   le32_to_cpu(ev->level), le32_to_cpu(ev->pdev_id),
+		   le32_to_cpu(ev->temp), le32_to_cpu(ev->therm_throt_levels));
+}
+
 static void ath12k_fils_discovery_event(struct ath12k_base *ab,
 					struct sk_buff *skb)
 {
@@ -9811,6 +9847,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_TEMPERATURE_EVENTID:
 		ath12k_wmi_pdev_temperature_event(ab, skb);
 		break;
+	case WMI_THERM_THROT_STATS_EVENTID:
+		ath12k_wmi_thermal_throt_stats_event(ab, skb);
+		break;
 	case WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID:
 		ath12k_wmi_pdev_dma_ring_buf_release_event(ab, skb);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 4a34b2ca99ea..1853a6f9cf27 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -870,6 +870,7 @@ enum wmi_tlv_event_id {
 	WMI_READ_DATA_FROM_FLASH_EVENTID,
 	WMI_REPORT_RX_AGGR_FAILURE_EVENTID,
 	WMI_PKGID_EVENTID,
+	WMI_THERM_THROT_STATS_EVENTID,
 	WMI_GPIO_INPUT_EVENTID = WMI_TLV_CMD(WMI_GRP_GPIO),
 	WMI_UPLOADH_EVENTID,
 	WMI_CAPTUREH_EVENTID,
@@ -4120,6 +4121,13 @@ enum set_init_cc_flags {
 	ALPHA_IS_SET,
 };
 
+struct wmi_therm_throt_stats_event {
+	__le32 pdev_id;
+	__le32 temp;
+	__le32 level;
+	__le32 therm_throt_levels;
+} __packed;
+
 struct ath12k_wmi_init_country_arg {
 	union {
 		u16 country_code;
-- 
2.34.1


