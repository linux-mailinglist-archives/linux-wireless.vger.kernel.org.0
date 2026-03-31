Return-Path: <linux-wireless+bounces-34213-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIrSDs/Zy2kaMAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34213-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:27:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D496936AF10
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCBF730582B4
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124923F7A8D;
	Tue, 31 Mar 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMoBOrDS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JmXrjOQX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C73FCB10
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967110; cv=none; b=mikp8JnLqSg62FIbz/qsdfnaBy8Tn8suiSd9oe9UKCYQkOod0vseRHhY1HdHvqt0GWFOIKIabq5c9sl4i9V3z0Nvyk3bdFcfREx02V+ub1V3Ww+56M2e80S0Ynrs2ccONmAenZlzn2RKGdqUg1+tKgLN6A/BwB8rIA4k+EWTNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967110; c=relaxed/simple;
	bh=oP6SaDxpvbDBpNqY5FGLigW2dGSKJ+Qiuuz0cSdC06w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7ZMVXo7LR5+mbUxqrK1vhHgJUXi45TB42I83UGAmZpnJfw0CkRJnK4Zh40eKt5iXhULLUOAVfplq9S/wd6/gepoYO+ZSPP/qRHrkIA5J0dtS9aDlBEQMOVlT9gPV/7/1+qSAtxbW68BvSN4nHTPjXn5zwldsvvXhPmAuXyYLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMoBOrDS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JmXrjOQX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VAovMH1841331
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ps6EZi5pljo
	LGLvzoDpPQHaRe0lZ6apdq8W+9amtx0E=; b=CMoBOrDSRj7dw1rueKgr5TLXv+T
	OZk7uboX63xl6sBM6XRdpKnZtdrqg7mE/qP8SxnU7jAIZuMPabo/y6K6trPTiq4W
	0//2CuRjpyp+Bl7CHLpl4HEaIOf7Etx3HlZn4jXC9sF+ZQNE0ydBuxrLTiqj+/HA
	768IQA/Qf7Ob2TxyAuvMhuxFjl3hHsxaFCIsoH/tUbJ8EOpDUwcYYEPx9a+VQGjB
	jfNcEjkHY48kn0ykzg4tQ5QYiUXvfRcmTQJFe+1pFTjg9Halco+caE/svAmgzz/o
	QBoW0slu8ko1SVa/JiEIMxL/tmvT4SZ6AomT0OVMP5rc+tN24GoEGhFIljA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80rskk6p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso104406025ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774967106; x=1775571906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps6EZi5pljoLGLvzoDpPQHaRe0lZ6apdq8W+9amtx0E=;
        b=JmXrjOQXdo0BBr9EBIcrkGhE1b1+mcpEsepkF9U6f4BWvumZT2tKhHOCY/v2R5olLK
         ZAzVObCcjnPChfIc4mLZGw/4cNgSSItdWaf+pF685N4bfSF9/SZ2S09PGBTmwbwxEWSc
         lhQZ3un41M7750sh03LW+M/Yf+lVv3OXuQ3rkSQW0EQO4FTfetmVOMP/xX8MrnmefOf+
         16SG9jbvq8svwxJORJtJr3WSPN/vOKwE514oLSo/N3llwYLbPIBdlBLz19wiD42RbTVY
         qPJZGKp0gbOAvu9i6gj66EAuKUr7xCReo4I/68SJ5CJnC08Wf7GE0IUQ0IkFvQLyrbhp
         GCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967106; x=1775571906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ps6EZi5pljoLGLvzoDpPQHaRe0lZ6apdq8W+9amtx0E=;
        b=sRCOaMdy/Th+2BXB3jhVx27mFPWlbMHOaNbcdxzZ5sm6N9huBNJI7SL3uQkatRu2/W
         ApKnnUGiGtUw7Ii7rNqsfxMaFO+Scsa0xyvzUq4EaqMsUkW8oqzvjydLlWOJvTjH/Opc
         fCPX96fjGoi6DtwPKO5/Bcf2lM8rFby9ziD4ul4MJeruZOATfK9KN4gJgk1+f714iENs
         8OoMMyGp/+QNj+AYa3FMVSIsZn/akrstTICBVQd5EI4iahwHDm/uROPjjWep17b3VmHg
         Il2stUKW9NmQAEjNscX46s6hfPtCNuPen7k/V4FMFHCW8SLqmRD2cOTnJAC4V+FKISeM
         66jQ==
X-Gm-Message-State: AOJu0YypVvLYkMKJeMt7bJX60JE31KGjofa1konQAprh3yuMDmlMPr20
	cu5z8BSbKObyb6CRPR+C60524Twgz71q5NIj6nHm6mAyaLl7CvtAJkcSoDxmjFePJK9ErJllDzi
	PGioNBP6YPH3WUUlnHPgumsbUs6snwbi7WO2OEieoigPs+ZOTW7xhzCdDgFyj9YhHlJTWUA==
X-Gm-Gg: ATEYQzySTJehR8gY+KvNN9SfegfhczXlJvkayXuxg8zl1v7+sycYpXcK+o5NdyiQbNE
	70xAd5BpjmzgP2EtYKXmQFHqJQlbhtIgB9ruGLKy7WjPFkkA7rk5ozYR9GZ2wVyX9PN4maNKIk4
	DkvPyIfzHvlse/9uwUZ7A6FWcvbgm+mja2J9ZJ6ukQ6rR33+Ax+5VC50lz6leqLxAlt45+Wn3u1
	zINFaZQMST19/owiavDsKEJP/F1L78n6HwwWFypWJ1ssNs3+zLU73F2gBRE2Rug7rubRpaIK0Ol
	YihpiCczRguFvMYUNPHwy8z7Dy535Dg9KP1Bb/VwCeyD8C518CTjPwQNuvYbe7Tyk/JDxNWpWOQ
	EEFylYBKTX/NNiGciOV5P270i7+Tap7oeL9+g6Pu5eMhcafdNOD5vAUPIjI/pHZyUdDR7IBQaMM
	WXHewB1U28B4YAIHklZRTVh+dJhPVS18OaV4pFbIpid/fqDeHxWow=
X-Received: by 2002:a17:903:1450:b0:2b0:5626:f75d with SMTP id d9443c01a7336-2b0cdcb7d29mr185104345ad.26.1774967106053;
        Tue, 31 Mar 2026 07:25:06 -0700 (PDT)
X-Received: by 2002:a17:903:1450:b0:2b0:5626:f75d with SMTP id d9443c01a7336-2b0cdcb7d29mr185104045ad.26.1774967105522;
        Tue, 31 Mar 2026 07:25:05 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm112030225ad.38.2026.03.31.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:25:05 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 1/5] wifi: ath12k: handle thermal throttle stats WMI event
Date: Tue, 31 Mar 2026 19:54:42 +0530
Message-Id: <20260331142446.2951809-2-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CKSU3HsPbvQ8po4JIEPszvh_S5mzEhz5
X-Authority-Analysis: v=2.4 cv=VInQXtPX c=1 sm=1 tr=0 ts=69cbd943 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=E37thjIwhXKEW9KdV9kA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: CKSU3HsPbvQ8po4JIEPszvh_S5mzEhz5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfX4UeSyVszPD1q
 xbwCaPPajMR3z5kiGU8mpPsViH9jB+5uBTp3FtyHZkvZ5uLjDr2J6TDwL0HKc72R0twoYrWzggL
 poDQRMoLjYkYdLoF/pcUPMU8hweC8woOephj1+n4X2mFdljy8vMH4jZLBcTdSxs5/9aIjsmlh3t
 7NFTW/4jsGTSzlym93c8vFH6MYr7H3jKIQjguBUxdArMOVb85yqe2zl0LnPcXHfOtWxd3Kc5keR
 4luN48j9T00j1DAHqa0wi5yMmHkZhZms0kFtV2lldVh9buha0eedizCN82Obd5Zvy4lwNZduOKv
 JP55NG+gAkneOEHQfJjv6nlNRClgLKS2ghyFMpi8qzEWEHQ65MfbHZhmB4TDQVo/BpsqjiyD3qh
 /uuczdfAgQHmebNjkfpUbybKmmJgWpXZ8mko+GqTJkFhPwPQaXOhWjLwSwo7HtXOX13u+X2J7V5
 uqI64k2epb7WaTyEaVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310139
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34213-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D496936AF10
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
 drivers/net/wireless/ath/ath12k/wmi.c | 38 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  8 ++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 65a05a9520ff..34184d0d03ff 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -8819,6 +8819,41 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 	rcu_read_unlock();
 }
 
+static void ath12k_wmi_thermal_throt_stats_event(struct ath12k_base *ab,
+						 struct sk_buff *skb)
+{
+	const struct wmi_therm_throt_stats_event *ev;
+	struct ath12k *ar;
+
+	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
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
@@ -9900,6 +9935,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
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
index 5ba9b7d3a888..8539435c292d 100644
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


