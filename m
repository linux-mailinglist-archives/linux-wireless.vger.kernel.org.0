Return-Path: <linux-wireless+bounces-31110-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIb5GC8gc2ngsQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31110-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:15:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D8718A3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B2E9300C26D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7637105B;
	Fri, 23 Jan 2026 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duqbpG2L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LSQaWUfv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C535D613
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152427; cv=none; b=NqpMiTbtTdF7h3lN72cm9lLDJLy4oYAKBzIB3wh7hes2jtQPgjxMqeE79EKhhQuPM88JOyJh/zvQLpZTF7IVl7agizYuier6YFahWMTku2Jq0BaOQHc6K/HkeiMAQ1q04ZZaMXZ2CysFiyL544XzTi/HHz9C0vT+Q6O5smzTd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152427; c=relaxed/simple;
	bh=gVhlKr6Yw+eHKsATgs3AFqpppRwzQXEFJbl2xup+LJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uriPmeqDkehMeLZm9TH98r2hvYo0yeHnU8garE9w9l5Ov84gifz8OSgqoSzCk686yPY0o1YrTdqPackFAjdmA0KX52eXMBHcPxTSi9LR/m87MdAMxOZnq8sRs+lzPA5UhL0D9qFoDprX+9vOfDvi7esNQ22Wg/qXIFgbvx9CecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duqbpG2L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LSQaWUfv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N1DRS13649502
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Eo5Cqh/YaDf
	/Hx/aCx/Sn/3ZIfQucmSQ5SKZhbC2KjY=; b=duqbpG2LbLs7v6OYMjTBcdaIrOx
	23x830RB7XkzTyNzt3Ii6JevPpKaN+9Kl+f3btlVWilqTLGgjT9/oZ03pzb4gocz
	6r4DqV0ky3xSaAO6AT+PKg9uqd8HHwcMhVksrgwroBhWuc75QIdyIuMwRDgkKxOy
	rJ8r0yhuhx3Y2FJSzll42W+bGG24Hw70hhtpm2HeGsMOEHiWps/wVui0HroL2mx0
	po0ELR8UAKxLxuiFzHLaiKl9pSWf/IN0pKDX/F2ubms15p1APXC5sDlK48o0JqKO
	lf8fee/lef6bV1/lyS/Dt/RxxTYETo8nbr27jRPKKAvAW95vsk1AHXQdXmA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buy4ns63r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a7a98ba326so19983345ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 23:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769152397; x=1769757197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo5Cqh/YaDf/Hx/aCx/Sn/3ZIfQucmSQ5SKZhbC2KjY=;
        b=LSQaWUfvTZlzZlzwL0ZjtzzenVZhz3cmM122ULpRvMgt7LyhKQzRWKueEbiDQa8djW
         2IMDo/RIr4K0FeiPCl0RKVmZC226hrByyi/mjONePpvB296/Yp/SSoqQ+ENtCISCP/VF
         BCfQHPImuhqsSiKpahh3Weev8nZFqzhR7jcGX8gJRhKQE+ISFuaAt5wvJ1sEvbib7jf8
         eD6Wxkae8mSEl8W5uBOQzI+enVqCjGRhViU1mgQQoTqhDCuQ60Fbu80ML3UmR3eGThY5
         So7kwM0aKC3GtDaBjpIhXE5/AiZDHvHJsnrJPbM8JrJVD3ovapXURsKiBv88cJJidt25
         8b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152397; x=1769757197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eo5Cqh/YaDf/Hx/aCx/Sn/3ZIfQucmSQ5SKZhbC2KjY=;
        b=uSSLkKkWAfDJo/X8leKGosiuROWzQJl6AxmZwrsyQ3BFHXcqwoCoQImDVYCcolbYB2
         XznYCM0Yyn7PTWPfC4DkQmIbyCeH5yxXW09sez8L7XIDb1HK0zRCnBwkpc3T+ZqSzqDo
         xe82iV1XKgp29+jGurxjJPNGDJlqozfevqUoDGfPKjsweixP5TkVFvV9O7UxzXiXgZU+
         FbIAx5VRi3DvaUmwIo4irHCFQUqoxBfJ6IrfvNWyDX/EysZ8PD7FyZ7k3Sb7D8HrPTOL
         ZXs7UAm/Hcwe+1U00MIwSxg38mZmH48AE3+hjQPQbk30TFPCWFxRgrCc6OD+NhW+xv7I
         P17g==
X-Gm-Message-State: AOJu0YzlMADVWO4TqcAGyxdBVwDNbUUS71ijC06f3YuGMAgwMrKi6f0W
	GwNhMRnz1cxNugWd/Y3mt3SzTF95Im/Fm9iZpJ193v+DxvXvXvyVGkLO0xSIqCfJkD0rrGpfMqL
	RG4+n4XJIQcYCZtKuoaLzkoImzdDfsBW5XIR345L04ronu+sOHwWqbvFbxWUJG4bHqmBMGarAF5
	UFhQ==
X-Gm-Gg: AZuq6aLlPjKAdIEFCYh9DcVBOYp7gS4hlzypjQ8hAnA7ovumK9tn07IYK/Y0B0Re+VJ
	g4CECJNCqu4DVl1Wfbphh+mXwXTxZtPOThx3WDF3473Mq3BI3YV7nR24k09VzkyqbcXzL2ftcGc
	bML4wkg2jAU9YzkqOlNv4JkC1nrapZh6QV9XNCpIF6t76Eiz6BXl9hKlABhTi435AyO1HW7VTfT
	uOu8uoLIqAvbAUl240lf3h0ivHbQ6i8idQygcl61yt/15wt/ENyrwxOHNzyj1ucV7Cst8ZlHxCc
	t+DzarsClj9RnTT9WnZGTcRjASFz6jNQovAknL6AId55ZGx+xP4j2lXSzf1/Ey4foVaRCa3tkDo
	tsgKJLg4yhkaNiTlrcHn85fSa0Yh7ahGVrle3h1/FNusXLXtG/0IVVlgerEDJ16hCqE2tjwqEV/
	MwUzUMrULQZit4oAc79nK7GwQ2i+O8Mg/e
X-Received: by 2002:a17:902:f54e:b0:2a0:89c6:1824 with SMTP id d9443c01a7336-2a7d2f17e0bmr51989475ad.8.1769152396837;
        Thu, 22 Jan 2026 23:13:16 -0800 (PST)
X-Received: by 2002:a17:902:f54e:b0:2a0:89c6:1824 with SMTP id d9443c01a7336-2a7d2f17e0bmr51989315ad.8.1769152396318;
        Thu, 22 Jan 2026 23:13:16 -0800 (PST)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa654sm11319165ad.11.2026.01.22.23.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:13:15 -0800 (PST)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 3/3] wifi: ath12k: Add support TX hardware queue stats
Date: Fri, 23 Jan 2026 12:42:53 +0530
Message-Id: <20260123071253.2202644-4-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qYHupsEWFaFd4R3T4jXiwnR6sKjC6Zsy
X-Authority-Analysis: v=2.4 cv=I5lohdgg c=1 sm=1 tr=0 ts=69731f8e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=r7p6sMyryvZn4FPVG9QA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: qYHupsEWFaFd4R3T4jXiwnR6sKjC6Zsy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NCBTYWx0ZWRfX0S9Z3vB0MiP5
 0lkRjanA0c1v46o7kKV0jJOrZ+29KrBWbgzYy0G3NJ8iTy4jyDEUC8kWOH6RB0uqRKy/2QDedCp
 gKP93qNdJGCK4le/S2Zpf+KpHkHq/zUoCG2fGNWzX1JOpnZ6oi7GVHKY85ZG7K7cMBxEKHIbmcU
 c1I9QE7BE7NvX5Jm+ps0E19IYgiIC+z4kbGUt2QUO8toFk1f7lMzKlJ5IhkmxtlvNuQcFReDSfG
 MLSOyL8ZkTPcg0ZD7oIWb+w2IWMsa8hcdQK+TyJz3vlC9r1Tqse+XV//3U4GgAqTnT1IUe5Nhw5
 Wgrh0uLVVhYrIcLqnxCA9CzRIeS+Bz2y+1JH9RNLdtMqYokKxm3Ct6IZ0L0guXAG2XM/+vajgEN
 GhXoevqRXQUQu+w1wGzWNZPY5muKP4bgvjZf/lB50olhEKylYcvvMG7i0NbjBvM8Oj0fHE6CQBN
 3YVz3iCr2KqT0eFmobA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31110-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 240D8718A3
X-Rspamd-Action: no action

Add support to request and receive TX hardware queue stats using
HTT stats type 3. This stats type reports MPDU mac id and hardware
queue information, including xretry, BAR, RTS, CTS, self, and QoS-null
counts, along with underrun, flush, and filter counters.

Sample output:
-------------
echo 3 >/sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats

HTT_TX_HWQ_STATS_CMN_TLV:
mac_id = 0
hwq_id = 0
xretry = 0
underrun_cnt = 0
flush_cnt = 0
filt_cnt = 0
null_mpdu_bmap = 0
user_ack_failure = 379
ack_tlv_proc = 0
sched_id_proc = 0
null_mpdu_tx_count = 0
mpdu_bmap_not_recvd = 0
num_bar = 0
rts = 0
cts2self = 0
qos_null = 0
mpdu_tried_cnt = 379
mpdu_queued_cnt = 379
mpdu_ack_fail_cnt = 0
mpdu_filt_cnt = 0
false_mpdu_ack_count = 0
txq_timeout = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 64 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 26 ++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index a667eb9966c9..7f6ca07fb335 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -5661,6 +5661,67 @@ ath12k_htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_stats_cmn_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_STATS_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			le32_to_cpu(htt_stats_buf->mac_id__hwq_id__word) & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "hwq_id = %u\n",
+			(le32_to_cpu(htt_stats_buf->mac_id__hwq_id__word) & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "xretry = %u\n",
+			le32_to_cpu(htt_stats_buf->xretry));
+	len += scnprintf(buf + len, buf_len - len, "underrun_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->underrun_cnt));
+	len += scnprintf(buf + len, buf_len - len, "flush_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->flush_cnt));
+	len += scnprintf(buf + len, buf_len - len, "filt_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->filt_cnt));
+	len += scnprintf(buf + len, buf_len - len, "null_mpdu_bmap = %u\n",
+			le32_to_cpu(htt_stats_buf->null_mpdu_bmap));
+	len += scnprintf(buf + len, buf_len - len, "user_ack_failure = %u\n",
+			le32_to_cpu(htt_stats_buf->user_ack_failure));
+	len += scnprintf(buf + len, buf_len - len, "ack_tlv_proc = %u\n",
+			le32_to_cpu(htt_stats_buf->ack_tlv_proc));
+	len += scnprintf(buf + len, buf_len - len, "sched_id_proc = %u\n",
+			le32_to_cpu(htt_stats_buf->sched_id_proc));
+	len += scnprintf(buf + len, buf_len - len, "null_mpdu_tx_count = %u\n",
+			le32_to_cpu(htt_stats_buf->null_mpdu_tx_count));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_bmap_not_recvd = %u\n",
+			le32_to_cpu(htt_stats_buf->mpdu_bmap_not_recvd));
+	len += scnprintf(buf + len, buf_len - len, "num_bar = %u\n",
+			le32_to_cpu(htt_stats_buf->num_bar));
+	len += scnprintf(buf + len, buf_len - len, "rts = %u\n",
+			le32_to_cpu(htt_stats_buf->rts));
+	len += scnprintf(buf + len, buf_len - len, "cts2self = %u\n",
+			le32_to_cpu(htt_stats_buf->cts2self));
+	len += scnprintf(buf + len, buf_len - len, "qos_null = %u\n",
+			le32_to_cpu(htt_stats_buf->qos_null));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_tried_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mpdu_tried_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_queued_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mpdu_queued_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_ack_fail_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mpdu_ack_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_filt_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mpdu_filt_cnt));
+	len += scnprintf(buf + len, buf_len - len, "false_mpdu_ack_count = %u\n",
+			le32_to_cpu(htt_stats_buf->false_mpdu_ack_count));
+	len += scnprintf(buf + len, buf_len - len, "txq_timeout = %u\n",
+			le32_to_cpu(htt_stats_buf->txq_timeout));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -5960,6 +6021,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG:
 		ath12k_htt_print_pdev_rtt_tbr_cmd_res_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_HWQ_CMN_TAG:
+		ath12k_htt_print_tx_hwq_stats_cmn_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index a6656f20b845..bfabe6500d44 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -128,6 +128,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_RESET				= 0,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX			= 1,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX			= 2,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ			= 3,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED			= 4,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR			= 5,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM			= 6,
@@ -174,6 +175,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_SIFS_TAG			= 2,
 	HTT_STATS_TX_PDEV_FLUSH_TAG			= 3,
 	HTT_STATS_STRING_TAG				= 5,
+	HTT_STATS_TX_HWQ_CMN_TAG                        = 6,
 	HTT_STATS_TX_TQM_GEN_MPDU_TAG			= 11,
 	HTT_STATS_TX_TQM_LIST_MPDU_TAG			= 12,
 	HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG		= 13,
@@ -2130,4 +2132,28 @@ struct htt_rx_pdev_fw_stats_tlv {
 	__le32 bytes_received_high_32;
 } __packed;
 
+struct htt_tx_hwq_stats_cmn_tlv {
+	__le32 mac_id__hwq_id__word;
+	__le32 xretry;
+	__le32 underrun_cnt;
+	__le32 flush_cnt;
+	__le32 filt_cnt;
+	__le32 null_mpdu_bmap;
+	__le32 user_ack_failure;
+	__le32 ack_tlv_proc;
+	__le32 sched_id_proc;
+	__le32 null_mpdu_tx_count;
+	__le32 mpdu_bmap_not_recvd;
+	__le32 num_bar;
+	__le32 rts;
+	__le32 cts2self;
+	__le32 qos_null;
+	__le32 mpdu_tried_cnt;
+	__le32 mpdu_queued_cnt;
+	__le32 mpdu_ack_fail_cnt;
+	__le32 mpdu_filt_cnt;
+	__le32 false_mpdu_ack_count;
+	__le32 txq_timeout;
+} __packed;
+
 #endif
-- 
2.34.1


