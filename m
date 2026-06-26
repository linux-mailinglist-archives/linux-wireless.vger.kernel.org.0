Return-Path: <linux-wireless+bounces-38152-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJn2CGk+PmokCAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38152-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:55:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A936CB7FE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:55:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jfnFxxnq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bxbmQ7Be;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38152-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38152-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0795930B308C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258133E6DC5;
	Fri, 26 Jun 2026 08:53:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF093E5EF6
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463986; cv=none; b=cfh+O+xgXLX0TvVqXFPzpb5WWHPux/b+gbS0TvP0lj35zvQUVXV3b7Vw0YFmAdQf+IFRGHevzU3bPM/PW6efSfDEmtZqnfpq+ck0rxf0JesWqH2mqCflhjrYYDnD3AAuqka2LfnMMrUd/1qb+SO5tdmfhRmON3zoCx8OG5cnRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463986; c=relaxed/simple;
	bh=K9l/XLnMuJpCsQPyR1MJtdm3i0AFdupae6p5XwdddG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/VPIK975CGfrARZZuAQ4/R0IxxG/Gx9eXoXenvmoEC851clgKcSVoSbN5yoB1rX797ndQAlBR2GAY5in97N2T0jhZcE3cDkg4yUEgLUXFWJ2COJKaLKc5/f1rLsk845k6/+aH69ygtKEzxEoQ2qXj5rKauG7PEvQ5p4d407yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jfnFxxnq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bxbmQ7Be; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6VY9f587032
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wEk9Abs3/XO
	pIYJhgdbBcRXlivAQuIKLBNXKIsmmw0c=; b=jfnFxxnqndJv39hL1yf7q/0d5w4
	MpSGG4sDBIWh7IqlLWU+XCnsLtsDNFORvhRtCOvsUb7LnJ9HFkNiNB0dAWCcH+8M
	rbjqCSql5caomZu0NDp1uv7mB2xPUHTbaB55FV3b9DrYFsi92oN9C7/W8bIWE8GH
	fCdtkpqMf6p2innM6OCaBSEC3BdyugelK9AotgLj2xng9gYkmmRKk0J9cc/ufUv5
	rKZb8qChYd7zIA7hsVgKh2CPYVA3VqgLEXDY1MUQVKoMjip5Y3r/q3QpyKhzKs42
	I6YaySYWY/rSGBWt+IQgaUKkhQWsWuqkT8YL443JgM7uxqjubbEXMyEUD/g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eew9wej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ca81e05bfso4206eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782463983; x=1783068783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEk9Abs3/XOpIYJhgdbBcRXlivAQuIKLBNXKIsmmw0c=;
        b=bxbmQ7BeCk0L6G6vHzC0YpGEgiBrAr3t1b3spR+9JZ3wj/qz4Xg20efzVyyZ1x2FX9
         qKVDcy/eCV7bcKYFmNb0UliXrwGwk8a3fM43ur2ptGGTttGZpPT8jySOL6T6fiVknpPs
         LJ7UXZ8sNMZKCKbqhDAGck25x2qi8jMBam7rkJiVuXjXcC01SUbWfWyLzEtPgqrYJv0D
         scklX+f2CEAq1V3wbmLOJ4KHbKBU75uffDlUHT76llz55RVw1E8BImLhY0D3iutTNzH2
         SWbpjMZXbaX0bk5TkvEpMwZ+7VcS0XPU56dwCIAmkMuxKONllBP64KS+PI62e6whPpDb
         aeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463983; x=1783068783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEk9Abs3/XOpIYJhgdbBcRXlivAQuIKLBNXKIsmmw0c=;
        b=nFCHyxipwZIfLSPqP1CpenTFxvTvnMBZONgPGn/51iDNYNHTPIwjaibKqJdywicxgi
         cBVzn0uVXHOIVE3eToMxwRuJfU5e0MKs+zjvBmBD+Sk/nGSs2skFNrSZHH8hvlVOrChq
         nnVQLjqMztaiq7ODrWyhSZdGued1oIjymTZArrz2TvR2RGreg1sXSq/BbQ0QRHd4HXzT
         DrSpirONIb5O5ta36qJ6QCGhm9JELUUlALZ1fA4HbkMc5dUW2JloXMW7o8kUBLKiV3Sf
         FJsL3SSQG9khqkwVB9WMksGuOGLmmVVfWIJ+bcIl6RCvduOh5vick5ofB793Bq8/xcRl
         lzmA==
X-Gm-Message-State: AOJu0YzyhLbvdjjgc94DGc3hc+6gj5JBXkcsnraY8VhqQbc+QwhRZOLQ
	B1d+XxIgiYASIQ+oyx+GWPOJ1+FcJPHgeStTNPjwFlOWoxIebjGOpsJCVL7C0IHeKM73biYG3dr
	24XlKzj4fevQhaloKL9+8vPE7u5+xnBCrwEzDxtipQXO0e0mJwon8FZ72aHU2v32bZFc2y3mP0e
	b8
X-Gm-Gg: AfdE7ckKUOD8j9mLec2SLfvwkWPmNBD8wHQ9fk225p/2vx/lysZukaxuaqr4+i7/39a
	8OrNR1DbJ/avueoNtVfUDrycy0BHiAfeWQWV+XJ/sa+QL4jO6nPoAw0R0dX5KnlVOAc8+rgNl6X
	e5P2JqQ3Yq64W6rQW9zbPvWshuNVrglUUG9IghkKJfGWgDE20CsoPnjuUYzI1tL4wHk1KEniJUc
	FcS5+RVtIMu2PxQZhNDRTmfpfFy3lSat/4n/JOLYsB6nvlGH4rMEvG+qjkMB1wkEoW+iIRgWAKx
	bmZO8QU3Uoca9wLDKYjEZEPVgfKOdiDHGkY1q1ISiURERu67JakgvtAxFxQZ5rqkjiywCxpHlnq
	l9LUlZiFiYz4Q9s3/4DqBqlt6nkWrvOVNs3NNry2OtQOdotfGbM3vVimmYsD2GEWsfRaOx4Z8+N
	Qh4M8cHEo2Cm3x14Ux8rf05WfaAgpH9S2LNJaP
X-Received: by 2002:a05:7300:7246:b0:304:630d:e4ec with SMTP id 5a478bee46e88-30c84dc428cmr6642211eec.28.1782463982772;
        Fri, 26 Jun 2026 01:53:02 -0700 (PDT)
X-Received: by 2002:a05:7300:7246:b0:304:630d:e4ec with SMTP id 5a478bee46e88-30c84dc428cmr6642178eec.28.1782463982219;
        Fri, 26 Jun 2026 01:53:02 -0700 (PDT)
Received: from hu-ssramya-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca8b918sm17384044eec.28.2026.06.26.01.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:53:01 -0700 (PDT)
From: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, sreeramya.soratkal@oss.qualcomm.com
Subject: [PATCH ath-next v2 2/3] wifi: ath12k: Add timestamp to dp stats display
Date: Fri, 26 Jun 2026 14:22:52 +0530
Message-Id: <20260626085253.3927269-3-sreeramya.soratkal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
References: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX1EpInckPEsFe
 YhI2C3Lz84aRFEiCoQ4SN1SHPk3Qf07rXKR+RNOu7pecn0Vyt93MQgbL0RrCerZrAwUAeEbAQDJ
 ojW8zWPgtLFlM3brZDAXyNznjERlqLM=
X-Proofpoint-GUID: Zg44xSBY5qeAGBskYFgFWhmArDjyXQUn
X-Proofpoint-ORIG-GUID: Zg44xSBY5qeAGBskYFgFWhmArDjyXQUn
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3e3def cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=MF4ojy0fPj4DSkZxZrwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX8+b68YWiBCGH
 TqBnjFbkkPMC11nipbNxvaiRkO3Q3Rjoo0DCwnyAQ6Q+FA/1KRedr2MfbOn+ZD+VpY1SJKKMLHw
 5TYOZ1YbWz9AsdiAdLKG5gXGMufKeps2/AlCGthDRg2XzCViYm2wKcDFWkeG0MdIpatEMNablNW
 FmFfkkXc85rMnL9jLIhHaLdz6egq8PHgzp55BBZZukM3vq94suKGRXnEh7frgfvSj0ICxXKq5+d
 ML8jkaqjiCFt/9xkqG5gTN5M1D5i/rkGZJsmhpssNE5nYVUdaDDXaWQWOIeL56TKzXSS6hY0W0v
 k+pZRxNNJjBdh5JUw0exY8KYZ/pBy41jT4d5/DqBh2lz7+o/PJRD4iaDV/uhG0peinjhxU1v6H8
 5MMaQbQGvmmpAnBIw/X9jWFhM8VyubOUz1Tp4vJuw9yHF7I0HQqsH3v4xgK3F4Ocnln4kF1Bn/U
 QYjw+lTeFCQqx9rFfyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260070
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38152-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:sreeramya.soratkal@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sreeramya.soratkal@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sreeramya.soratkal@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74A936CB7FE

In MLO configurations the device_dp_stats debugfs file is read
separately for each ath12k device.  Without a timestamp it is impossible
to know whether two snapshots were taken at the same moment, making
counter comparisons across devices unreliable.

Prepend a ktime-based millisecond timestamp to the output header so the
reader can confirm when the snapshot was taken.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index bab9d96d6acc..57c213111259 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1082,6 +1082,9 @@ static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
+	len += scnprintf(buf + len, size - len,
+			 "DEVICE DP STATS (timestamp: %lldms):\n\n",
+			 ktime_to_ms(ktime_get()));
 	len += scnprintf(buf + len, size - len, "DEVICE RX STATS:\n\n");
 	len += scnprintf(buf + len, size - len, "err ring pkts: %u\n",
 			 device_stats->err_ring_pkts);
-- 
2.34.1


