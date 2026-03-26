Return-Path: <linux-wireless+bounces-33914-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DNnLK6/xGnp3AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33914-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:10:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD932F42E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00725304416D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 05:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379534DB6D;
	Thu, 26 Mar 2026 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WYJv1lOt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qmpn7OxW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4F34677F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501617; cv=none; b=cocMr9qh+ZHbonm6CrSkcEoPT6pgx+Uvxr7LCXMz+2ljAPfM+Ruk90ULXN8AqaS8+aHWd8Pdpjv4Vw7zXjoK3f8EgU0CSwB3q6KBa9zz9OHZLlZeIqJvLR+v33HQx+D78r7C+Shd1Y/QQQZoxvk50v+yU6gf1FcwltyhhYOEKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501617; c=relaxed/simple;
	bh=HYk3wgRyOSvBwoc4jXW8QC+C+4l+Swiz38oQj371sp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JebU+SBqQOJdNIjdPSwXdryBu8UTwTbM6ud48fBh9YsoVx6u258bGr4ad2def7AlNgz16rq1YVrxGmAACt6NN0ju0sk9ulVkxoqUdtelZ5vjxq+o9WoYW72EaKXBfWbfKsTIg7aLrQsoHWSoqLLXtNoEEt1n/auNjIUfjFT33t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WYJv1lOt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qmpn7OxW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q1IP461432763
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sIOTdj/aFHn/N8qdhQJVWiK9jhfEsHg2Ob4
	OUCYolXM=; b=WYJv1lOtWZ6OkBuhuTkdA1txGfXRt2C8iDu2+U/YbE9cLK7I/KA
	YX9tBqfhSObAd2TnjK4RuLEsKPQCvO9+4giww09nFnWpUrKKS8wWbdMUrB62gZcz
	UUlX0Yx2AeImi1Jw6OwToVx+Bua1U1FS1jvrQNmkOz24ZFK2ZJDaYgg1kQs2UvER
	M5BJFMecVe6kkDFu4q66aEdufxUEvBraV7sDPgj49u9uURfRDnLJLtQXqqkJ4Hh3
	+vDDKbHLW9SGJMlxunjfNiNH0QVhN5q0ri/thFodX6HpArQDL/pgH0xtkbh6OfEr
	bTD8BjepZvQwgHYZrA70S7TRmZP2wVOs1vA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4jc52ect-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:06:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aeb90532f6so7157795ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 22:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774501614; x=1775106414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sIOTdj/aFHn/N8qdhQJVWiK9jhfEsHg2Ob4OUCYolXM=;
        b=Qmpn7OxW4PPnZmjZqeI8MsTLxqovb42zHXxPXtdP32Qbbw5HQAS19CERxymwUPQAuC
         au4uWYZCkJLqkv5yqY+O8667CzcjeneDRJUoySGFP0RA+yK23Y52BlOnVXH1RcohH3Xu
         LGCK0gfcmmbsHJqw8RTf44Qf+JmMwhkh+gKZf5HQlO5lsIeHkYudYzSdqGSF0ECWkaJs
         goZdvrhPMhsDczELlOBfy/sd1iG92N0VAUVSMMkqnxCqjMgkpdX56f+tpbMEyxPT5Y4y
         WNU19TY4j+jvMKZmOwJdJ+HDEAYk4QLM2p4rZo++E/CG2RWuhUmzQcrPZ5ZOMDWLNE0I
         wIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774501614; x=1775106414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIOTdj/aFHn/N8qdhQJVWiK9jhfEsHg2Ob4OUCYolXM=;
        b=cOLkk6s5RWw5f8FbTp3BQ3c2y+Rpmfhi0lFzIAAUOF6bh7aAqo+Nogqlj7+++JE44U
         LmoaGX+cFEEf10RxGFlgNToZL5u+pbO1Q0XkHp/CyaKViyZ9voTdlx/wNZtXyaQMLdo+
         7hNAct009tVdzyjzbZg/5NquRYllj8Mp6X6/b2FIyBA7wNy8jZ111T5GTOKY8oV5UkOy
         12WU850t6ek1VT8BYhIYzWrNN2VLAlioEZzZ72MFcYL+f9+UJ9q8UZEXP5ab2GS9nBlQ
         oIGv31MfnSy8N4ngkv1z9E9km0hw8txcGWyM/Y2yv46KDmID3+DFFgFLij/suk4JxCWA
         LJiQ==
X-Gm-Message-State: AOJu0Yy8XrsLPV1mKlaknfJPVzm4UTm8pXMO1gQSSIumr1BvU4FrMY1y
	gkz8/biSRxvqQXO94Ym2X+7Eka74EBvea1VR+5ZSo16HNKy52FY8QnQYLx1jqG6SVk8WISp8EcO
	tc78LdHgTmjJtAlzrcz8//JOmR4WqgjwC6rDT4eyhhf9PasfbKA22Ejbpt9UOFFqAULVpqw==
X-Gm-Gg: ATEYQzxU+KUDSix7IMvBHEzjYZ6BjpS/av3P+nT3uAF9BY0QxthR7ZwphmsfmrT247b
	ouXBUlSl/SS6gzrcsLQYzYb2/iGgiJL4r30p03/IjZUvYTdcrpxLzQwi0GLkPuibBUWdr2+nrkQ
	UMvxgf8kIHidMuztoDYMt1u80bPwA/LP/2VHHdMWEoiTRYPrAbz/3qeY/WxDlM9SIwMMs+EurQ6
	tNXXNS9N+UvkgUT7K/kfZwKG9Ld4ASRcINhdhnDCj/GAgwJgPdeB3FvRdsp6OIfySquKDuK0xmQ
	INX3qT06VyYYrOz5CexleQu1dATiB5bf7zMSQvnEP7MMNawIpju6xZGHoGCZ3Ea9w3Mq/aPLFcX
	uDVOBkrxHw7pdIPqXct/bRzAuSiqSBvx8bafd3RjWgiBA0cc+ap6q6matcc1Uoyi8tozpok9kdY
	8jhAv9P9/u0gtcEKSD1kAlk2H3SYnjOVGXtJmDtxUtUZkkk1Fm
X-Received: by 2002:a17:903:3c4e:b0:2aa:e3c7:6048 with SMTP id d9443c01a7336-2b0b0a42d45mr71321015ad.23.1774501613723;
        Wed, 25 Mar 2026 22:06:53 -0700 (PDT)
X-Received: by 2002:a17:903:3c4e:b0:2aa:e3c7:6048 with SMTP id d9443c01a7336-2b0b0a42d45mr71320675ad.23.1774501613210;
        Wed, 25 Mar 2026 22:06:53 -0700 (PDT)
Received: from hu-rdevanat-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8fac97sm15259845ad.71.2026.03.25.22.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:06:52 -0700 (PDT)
From: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Harish Rachakonda <quic_rachakon@quicinc.com>,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Support channel change stats
Date: Thu, 26 Mar 2026 10:36:41 +0530
Message-Id: <20260326050641.3066562-1-roopni.devanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1991dxyo5eVUosK7ZY3btgT4AGZzJW2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAzNyBTYWx0ZWRfX4aUeXlSnOukZ
 gQytTr3cMMYfKrkI80eo9ftp2qp+tChhhXY5DhgVmhHMfUtNFVINJ3H7WGWsGk5AD4iTVakd9EJ
 ZGf6zXG+vVDdybLyemL4WHh6KDJVDi4hKxLuh6Z/LUfHky9DVHV+WOnpkZ90qyxvLd/y2mNUDYT
 p2WczkD5hPToAXOmq6EG71NzVrirx3/yDUBeLyoyRrPln5l6RySLJGp0wS52S9rRVlmynBL7eix
 t+wl42zybMlPqz/bbNRfhuccRVkYr4yGJLoM1VyxhfM4482w6ncS6WvRWqP1WRnzK2ULX3p2CG+
 vLEjLyihVsQeYbWEnXpamJpUkFYvS/U8UA5xVUMq9rKB0Gb0FmKWihNjigGA6q1yC2jeaBUreos
 gRMpGUzXFVKZuWGrYHhXLLGnHA9XLXRB8oIrlVet27h5OelwcCunLNTihvKISosnJrvFELFT+Gj
 UeLNF+86QWx/ZQmPyiA==
X-Proofpoint-ORIG-GUID: 1991dxyo5eVUosK7ZY3btgT4AGZzJW2p
X-Authority-Analysis: v=2.4 cv=KaLfcAYD c=1 sm=1 tr=0 ts=69c4beee cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=8HdXM4_gyVcZDa-Q9oUA:9 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260037
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33914-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roopni.devanathan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 15DD932F42E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harish Rachakonda <quic_rachakon@quicinc.com>

Add support to request channel change stats from the firmware through
HTT stats type 76. These stats give channel switch details like the
channel that the radio changed to, its center frequency, time taken
for the switch, chainmask details, etc.

Sample output:
echo 76 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
Channel Change Timings:
|PRIMARY CHANNEL FREQ|BANDWIDTH CENTER FREQ|PHYMODE|TX_CHAINMASK|RX_CHAINMASK|SWITCH TIME(us)|INI(us)|TPC+CTL(us)|CAL(us)|MISC(us)|CTL(us)|SW PROFILE|
|                5200|                 5200|     24|          15|          15|         448850|   2410|      10546| 434593|    1071|   1100|         4|
|                5240|                 5240|     24|          15|          15|         450730|   4106|      10524| 434528|    1306|   1150|         4|
|                5180|                 5210|     26|          15|          15|         467894|   4764|      10438| 451101|    1337|   1508|         4|
|                5200|                 5200|      0|          15|          15|          13838|   2692|       1736|   8558|     686|    802|         6|
|                5180|                 5180|      0|          15|          15|          13465|   3207|        855|   8579|     578|    760|         6|
|                5200|                 5200|     24|          15|          15|         570321|   2441|      10439| 555661|    1574|    949|         4|

Note: WCN7850 firmware does not support HTT stats type 76.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harish Rachakonda <quic_rachakon@quicinc.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 72 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 26 +++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 7f6ca07fb335..b772181a496e 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -5722,6 +5722,75 @@ ath12k_htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_chan_switch_stats_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_chan_switch_stats_tlv *sbuf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 switch_freq, switch_profile;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u8 i;
+
+	if (tag_len < sizeof(*sbuf))
+		return;
+
+	i = min(le32_to_cpu(sbuf->switch_count), ATH12K_HTT_CHAN_SWITCH_STATS_BUF_LEN);
+	if (!i)
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "Channel Change Timings:\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "|%-20s|%-21s|%-7s|%-12s|%-12s|%-15s|",
+			 "PRIMARY CHANNEL FREQ", "BANDWIDTH CENTER FREQ", "PHYMODE",
+			 "TX_CHAINMASK", "RX_CHAINMASK", "SWITCH TIME(us)");
+	len += scnprintf(buf + len, buf_len - len,
+			 "%-7s|%-11s|%-7s|%-8s|%-7s|%-10s|\n",
+			 "INI(us)", "TPC+CTL(us)", "CAL(us)", "MISC(us)", "CTL(us)",
+			 "SW PROFILE");
+
+	/*
+	 * sbuf->switch_count has the number of successful channel changes. The firmware
+	 * sends the record of channel change in such a way that sbuf->chan_stats[0] will
+	 * point to the channel change that occurred first and the recent channel change
+	 * records will be stored in sbuf->chan_stats[9]. As and when new channel change
+	 * occurs, sbuf->chan_stats[0] will be replaced by records from the next index,
+	 * sbuf->chan_stats[1]. While printing the records, reverse chronological order
+	 * is followed, i.e., the most recent channel change records are printed first
+	 * and the oldest one, last.
+	 */
+	while (i--) {
+		switch_freq = le32_to_cpu(sbuf->chan_stats[i].chan_switch_freq);
+		switch_profile = le32_to_cpu(sbuf->chan_stats[i].chan_switch_profile);
+
+		len += scnprintf(buf + len, buf_len - len,
+				 "|%20u|%21u|%7u|%12u|%12u|%15u|",
+				 u32_get_bits(switch_freq,
+					      ATH12K_HTT_STATS_CHAN_SWITCH_BW_MHZ),
+				 u32_get_bits(switch_freq,
+					      ATH12K_HTT_STATS_CHAN_SWITCH_BAND_FREQ),
+				 u32_get_bits(switch_profile,
+					      ATH12K_HTT_STATS_CHAN_SWITCH_PHY_MODE),
+				 u32_get_bits(switch_profile,
+					      ATH12K_HTT_STATS_CHAN_SWITCH_TX_CHAINMASK),
+				 u32_get_bits(switch_profile,
+					      ATH12K_HTT_STATS_CHAN_SWITCH_RX_CHAINMASK),
+				 le32_to_cpu(sbuf->chan_stats[i].chan_switch_time));
+		len += scnprintf(buf + len, buf_len - len,
+				 "%7u|%11u|%7u|%8u|%7u|%10u|\n",
+				 le32_to_cpu(sbuf->chan_stats[i].ini_module_time),
+				 le32_to_cpu(sbuf->chan_stats[i].tpc_module_time),
+				 le32_to_cpu(sbuf->chan_stats[i].cal_module_time),
+				 le32_to_cpu(sbuf->chan_stats[i].misc_module_time),
+				 le32_to_cpu(sbuf->chan_stats[i].ctl_module_time),
+				 u32_get_bits(switch_profile,
+					      ATH12K_HTT_STATS_CHAN_SWITCH_SW_PROFILE));
+	}
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -6024,6 +6093,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_HWQ_CMN_TAG:
 		ath12k_htt_print_tx_hwq_stats_cmn_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_CHAN_SWITCH_STATS_TAG:
+		ath12k_htt_print_chan_switch_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index bfabe6500d44..82ab7b9e4db9 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -164,6 +164,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_PDEV_MLO_IPC_STATS			= 64,
 	ATH12K_DBG_HTT_EXT_PDEV_RTT_RESP_STATS			= 65,
 	ATH12K_DBG_HTT_EXT_PDEV_RTT_INITIATOR_STATS		= 66,
+	ATH12K_DBG_HTT_EXT_CHAN_SWITCH_STATS			= 76,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -267,6 +268,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_PDEV_RTT_HW_STATS_TAG			= 196,
 	HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG	= 197,
 	HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG	= 198,
+	HTT_STATS_CHAN_SWITCH_STATS_TAG			= 213,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -2156,4 +2158,28 @@ struct htt_tx_hwq_stats_cmn_tlv {
 	__le32 txq_timeout;
 } __packed;
 
+#define ATH12K_HTT_CHAN_SWITCH_STATS_BUF_LEN	10
+
+#define ATH12K_HTT_STATS_CHAN_SWITCH_BW_MHZ		GENMASK(15, 0)
+#define ATH12K_HTT_STATS_CHAN_SWITCH_BAND_FREQ		GENMASK(31, 16)
+#define ATH12K_HTT_STATS_CHAN_SWITCH_PHY_MODE		GENMASK(7, 0)
+#define ATH12K_HTT_STATS_CHAN_SWITCH_TX_CHAINMASK	GENMASK(15, 8)
+#define ATH12K_HTT_STATS_CHAN_SWITCH_RX_CHAINMASK	GENMASK(23, 16)
+#define ATH12K_HTT_STATS_CHAN_SWITCH_SW_PROFILE		GENMASK(31, 24)
+
+struct ath12k_htt_chan_switch_stats_tlv {
+	struct {
+		__le32 chan_switch_freq;
+		__le32 chan_switch_profile;
+		__le32 chan_switch_time;
+		__le32 cal_module_time;
+		__le32 ini_module_time;
+		__le32 tpc_module_time;
+		__le32 misc_module_time;
+		__le32 ctl_module_time;
+		__le32 reserved;
+	} chan_stats[ATH12K_HTT_CHAN_SWITCH_STATS_BUF_LEN];
+	__le32 switch_count; /* shows how many channel changes have occurred */
+} __packed;
+
 #endif

base-commit: 37538641dac955f6690372f0ebb94e5e14a23418
-- 
2.43.0


