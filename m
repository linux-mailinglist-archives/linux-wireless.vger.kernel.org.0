Return-Path: <linux-wireless+bounces-31107-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IElWGKUfc2ngsQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31107-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:13:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B9717CE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7787B30028DC
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE436F42D;
	Fri, 23 Jan 2026 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+x4wPkA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B4C58gUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460A367F5A
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152403; cv=none; b=EcIjnFcPRkm487/9B/Eq2HBKkESKMmphg+actzMz+2TTqjLQ7xUmG1fcV0AS8AxCK/tfeVAYu/Nh/MVaYnvIH3ltvALGl0rjSfi3RG8IMrnrPIdWBGqFcEAMhZt817MKKZwgRqVI/ektZT68ny39nkogShUUD1XtWll3+3N6fhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152403; c=relaxed/simple;
	bh=ClLkuw6BLQNtUXLmdoqefRd6wp7sbp4hiRKAk8FRPt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbPPmdGI7ugsJWNngWG8JachFq8ln58uW2d6nex4mOREn23u1qsX+cqT4KY7zYjCZg9v7ArP40vZIV7Nk7s/sflQQDZyWy3ZbDpqOZhOiuo5fzp+Uybc+qyAfuC5NADElZxQ2V2yDe4wNj9E7GJmjc+JF4yUpNvCmXEbbnKRGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a+x4wPkA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B4C58gUt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6re6e3677799
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V/qwcHbMcXS
	H8QXMkuE5bSj87sqnAzQguXyeiqhw7ME=; b=a+x4wPkAndGyTEau+BBscujs/Cz
	sIEA+oja6uwO4eO9fVmb+py8THvB16HqnrmBqSTz2zzU5JZySyXTHfGK0Bw8e8VR
	rLTFHh/rRoQBKnKPy3JQslw/ruRx7Mu/CK9IyZpGUUsapNZemwsSdQAL3NSgXQDD
	7/JNWxZEEWtd+pa6Ii5Qa7bSB3yPd8l7neWLpWxxFW6ard7VZOwauWt4xwk4NSxO
	MmDBbx+Y+wHpUlMSS+5ervQn6ru/brkfYThC0bK0WUYNYMsS4PO5bXSEUSieKqc5
	7Xz9IUsFEM/b8TnzvRR0+vZN5g2akMZ4+zCwFHnCyXa+wkOImfg/q1Quc6A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buqyp2eq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a13cd9a784so17621775ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 23:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769152394; x=1769757194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/qwcHbMcXSH8QXMkuE5bSj87sqnAzQguXyeiqhw7ME=;
        b=B4C58gUtzEgmNIrgYOl8+SPhglzmKtxdtr9IwndIlH1bau0349KWQ88eBdUVj3lpA0
         j4pPyHrslZeOdOMgqijcfCorHsTR/O4qgBwrqZ3rYgNbWOg7fj7E2jVrdt1FTrj8b90/
         L+qAKGfE6ROAapnDFZN0m1BLVl7+YKuHC9zQYjNzFmWSfGb7DqKyL+z9CyVTU1dYYEc+
         Z8fh+r4mWurHruxNuokq1VD/TZPJqZ88vKt4JsxYTiah8kulUoEv8dyUoHDHNtn7p3n3
         UC7c6MpD71cQugx3eXC1cNzX7aixVC70JdJ9qbIfWvbraFy1MXC0f4+/Ay0fH0lBt8Vy
         S4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152394; x=1769757194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/qwcHbMcXSH8QXMkuE5bSj87sqnAzQguXyeiqhw7ME=;
        b=qWn8h+lL3eCNkVqoRRqN/9HVOgTWcl+1tsrqqrQGpDGJga9OHJyu37Tfx0KxYNkZ3+
         aLpNE5nfsaCuu1UkkJU4SpTYZPkFy4o1dPs/FrCZD98xSYX95tkv1/y8s3tUDS9FZm/w
         TvZ897LTJ/bOyicG5nTvFfH81wWYkSm7p4NcJ+U8z8HTf8UVJ8oLd5Myv/VAvtId1L7p
         1UN6ZvWdzAbsoHkqZ7MKrhPT6WXo6O/DlWMSyl0MC6LljDsitfas9VdsIfYYT+1627VP
         Ry6z29eVlRD0qAS00zJmdcdxZtpD1YYIJaVrbdLrTtRXC0FTJ/Md/IPTc60g+Qxu8/fo
         HTZA==
X-Gm-Message-State: AOJu0YzxOwjgUETqwI2Kmpbnxl7Vmpyy4h4vLT/dHlk1kcy8yaJkZfG0
	u9T+nMmcVOSK01TBl07cgIspQIOyWpFFRhMxHTUPoWqYolD2C3ANvg6cC46LwLTkpOe1pEIHXFK
	+Y2q0jtBdOYq3mBLblylqrbwCKxa2e+GR5TSKtgWLW8uGnWu5Wz0CFjIpLw5z/6R02Ld7T34qrU
	clYw==
X-Gm-Gg: AZuq6aLUgOKSGGU5NEU0o7NqeRh/gWzZeTRRRRpdn5IgTIQ5Lff2WXaN2000uXpw+vX
	lvpg25NCdeIgCQPOsMRa9JBogRiH+5tc4rTm7H8YL+GdoU2GAgEmV88ecnjcfmFpJ6+cviMPAOO
	HzGeGwwkLBzcV+c4qeR+8u9teTAw3wXCMFJD+yugeoZUP9Dv93z3dkt6AAYe+V0lGt2zgZNwMND
	aeSchtC86HfYRF9aIEmduhXRx87HPURJh2FGTKgeXsD7N2VNdDMUKTQYFRFyzWcs3X9M006pdNF
	ZkI9Zxlfccq+GH+rX/L8Rg2tR8u7nORmnoDlGnRVYerHTFH0hG5XahioXlWRNO5AIptV/X8IHGM
	fbiM343/AhhCYmpsJGEVFlXnkG9DF8TCglzwdqcsPB48vpYDGQeuaEZTsrGTE+tvHTEQQeTwA9A
	eC51+vc2B/Pl0afl5WGzSdknb3CUN6cbQ8
X-Received: by 2002:a17:903:3508:b0:2a7:80ac:85b2 with SMTP id d9443c01a7336-2a7fe571d6bmr18174325ad.16.1769152393422;
        Thu, 22 Jan 2026 23:13:13 -0800 (PST)
X-Received: by 2002:a17:903:3508:b0:2a7:80ac:85b2 with SMTP id d9443c01a7336-2a7fe571d6bmr18174055ad.16.1769152392863;
        Thu, 22 Jan 2026 23:13:12 -0800 (PST)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa654sm11319165ad.11.2026.01.22.23.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:13:12 -0800 (PST)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 2/3] wifi: ath12k: Add support RX PDEV stats
Date: Fri, 23 Jan 2026 12:42:52 +0530
Message-Id: <20260123071253.2202644-3-aaradhana.sahu@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=69731f8b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=45njEKoxy3GZgKQkHzYA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: rCOjXeZg-NEsCkIbWR06Xbs3kQWd_Vt6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NCBTYWx0ZWRfX5wAm+v0jBCZ3
 J7BPfoqmxsXKIMdrfGaSQAWTN/q+knaio/2O02IAsQp2ZpgBu/n2IL7K43W1j0lrWV5G087RIpP
 U0DO1whA4ySVnN1CjgZFBzJZIiCtX2POdNR6q3vVUBRV/6SGxIXeePKmThCB+q+Z7dBkjt4dQzy
 IpWtbphkng64uFuwCw2DNca8EGagw+dwXTlWC4Ila0OcjZ8Pdlm1XJNfp7o/8hS/CbVsu24bapv
 WT09IoPLCnNQ2UJ7W68spHPcUibG2J1gxqduqueUztc1M/EicIH1DLeB1vAq0UsyJQc8Z7BGpXS
 76VIWMzTd2t6FrWUn+eBzuyFy0JQs2z2nCNheGr9/0nqRwTop91tKZbzssMJZusfdBH4uT0kgTF
 DYsEHsdjl4P05yCyD3thxzeI0Z2dsGvH1JDk4hM9Ti0phqQMGt/+VnDDl+k0UJS0Vjbb+422ysr
 gYgkKKQZCU/F/p/nVuQ==
X-Proofpoint-GUID: rCOjXeZg-NEsCkIbWR06Xbs3kQWd_Vt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230054
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-31107-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 516B9717CE
X-Rspamd-Action: no action

Add support to request and receive RX pdev firmware stats using HTT
stats type 2. This stats type reports PPDU and MPDU counters, firmware
ring and buffer statistics, and RX suspend and resume counts.

Note: Currently, firmware on mobile-centric chipsets do not maintain
      these statistics, so a query will not return any information.

Sample output:
-------------
echo 2 >/sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats

HTT_RX_PDEV_FW_STATS_TLV:
mac_id = 0
ppdu_recvd = 1522
mpdu_cnt_fcs_ok = 1522
mpdu_cnt_fcs_err = 0
...
fw_ring_mpdu_ind = 1522
fw_ring_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:21, 5:0, 6:0, 7:0, 8:1501, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
fw_ring_ctrl_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
fw_ring_mcast_data_msdu = 0
fw_pkt_buf_ring_refill_cnt = 1567
fw_pkt_buf_ring_empty_cnt = 1
...
rx_suspend_cnt = 4
rx_suspend_fail_cnt = 0
rx_resume_cnt = 4
rx_resume_fail_cnt = 0
rx_ring_switch_cnt = 0
rx_ring_restore_cnt = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 125 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  55 ++++++++
 2 files changed, 180 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 4f749d473d0e..a667eb9966c9 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -5539,6 +5539,128 @@ ath12k_htt_print_pdev_rtt_tbr_cmd_res_stats_tlv(const void *tag_buf, u16 tag_len
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_pdev_fw_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			le32_to_cpu(htt_stats_buf->mac_id__word) & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "ppdu_recvd = %u\n",
+			le32_to_cpu(htt_stats_buf->ppdu_recvd));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt_fcs_ok = %u\n",
+			le32_to_cpu(htt_stats_buf->mpdu_cnt_fcs_ok));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt_fcs_err = %u\n",
+			le32_to_cpu(htt_stats_buf->mpdu_cnt_fcs_err));
+	len += scnprintf(buf + len, buf_len - len, "tcp_msdu_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->tcp_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tcp_ack_msdu_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->tcp_ack_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "udp_msdu_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->udp_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "other_msdu_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->other_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_ring_mpdu_ind));
+	len += print_array_to_buf(buf, len, "fw_ring_mgmt_subtype",
+			htt_stats_buf->fw_ring_mgmt_subtype,
+			ATH12K_HTT_STATS_SUBTYPE_MAX, "\n");
+	len += print_array_to_buf(buf, len, "fw_ring_ctrl_subtype",
+			htt_stats_buf->fw_ring_ctrl_subtype,
+			ATH12K_HTT_STATS_SUBTYPE_MAX, "\n");
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_ring_mcast_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_bcast_data_msdu = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_ring_bcast_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_ucast_data_msdu = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_ring_ucast_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_null_data_msdu = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_ring_null_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_drop = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_ring_mpdu_drop));
+	len += scnprintf(buf + len, buf_len - len, "ofld_local_data_ind_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->ofld_local_data_ind_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			"ofld_local_data_buf_recycle_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->ofld_local_data_buf_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len, "drx_local_data_ind_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->drx_local_data_ind_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			"drx_local_data_buf_recycle_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->drx_local_data_buf_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len, "local_nondata_ind_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->local_nondata_ind_cnt));
+	len += scnprintf(buf + len, buf_len - len, "local_nondata_buf_recycle_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->local_nondata_buf_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_status_buf_ring_refill_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_status_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_status_buf_ring_empty_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_status_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_pkt_buf_ring_refill_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_pkt_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_pkt_buf_ring_empty_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_pkt_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_link_buf_ring_refill_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_link_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_link_buf_ring_empty_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->fw_link_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "host_pkt_buf_ring_refill_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->host_pkt_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "host_pkt_buf_ring_empty_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->host_pkt_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_pkt_buf_ring_refill_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_pkt_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_pkt_buf_ring_empty_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_pkt_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			"mon_status_buf_ring_refill_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_status_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_status_buf_ring_empty_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_status_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_desc_buf_ring_refill_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_desc_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_desc_buf_ring_empty_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_desc_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_dest_ring_update_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_dest_ring_update_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_dest_ring_full_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->mon_dest_ring_full_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_suspend_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_suspend_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_suspend_fail_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_suspend_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_resume_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_resume_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_resume_fail_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_resume_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_ring_switch_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_ring_switch_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_ring_restore_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_ring_restore_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_flush_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_flush_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_recovery_reset_cnt = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_recovery_reset_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_lwm_prom_filter_dis = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_lwm_prom_filter_dis));
+	len += scnprintf(buf + len, buf_len - len, "rx_hwm_prom_filter_en = %u\n",
+			le32_to_cpu(htt_stats_buf->rx_hwm_prom_filter_en));
+	len += scnprintf(buf + len, buf_len - len, "bytes_received_low_32 = %u\n",
+			le32_to_cpu(htt_stats_buf->bytes_received_low_32));
+	len += scnprintf(buf + len, buf_len - len, "bytes_received_high_32 = %u\n",
+			le32_to_cpu(htt_stats_buf->bytes_received_high_32));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -5692,6 +5814,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_SFM_CLIENT_USER_TAG:
 		ath12k_htt_print_sfm_client_user_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_RX_PDEV_FW_STATS_TAG:
+		ath12k_htt_print_rx_pdev_fw_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG:
 		ath12k_htt_print_tx_pdev_mu_mimo_sch_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 8008658371aa..a6656f20b845 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -127,6 +127,7 @@ struct ath12k_htt_extd_stats_msg {
 enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_RESET				= 0,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX			= 1,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX			= 2,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED			= 4,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR			= 5,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM			= 6,
@@ -188,6 +189,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG		= 25,
 	HTT_STATS_SFM_CMN_TAG				= 26,
 	HTT_STATS_SRING_STATS_TAG			= 27,
+	HTT_STATS_RX_PDEV_FW_STATS_TAG                  = 28,
 	HTT_STATS_TX_PDEV_RATE_STATS_TAG		= 34,
 	HTT_STATS_RX_PDEV_RATE_STATS_TAG		= 35,
 	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
@@ -2075,4 +2077,57 @@ struct ath12k_htt_stats_pdev_rtt_tbr_cmd_result_stats_tlv {
 	__le32 mu_res[ATH12K_HTT_FTYPE_MAX][ATH12K_HTT_MAX_SCH_CMD_RESULT];
 } __packed;
 
+struct htt_rx_pdev_fw_stats_tlv {
+	__le32 mac_id__word;
+	__le32 ppdu_recvd;
+	__le32 mpdu_cnt_fcs_ok;
+	__le32 mpdu_cnt_fcs_err;
+	__le32 tcp_msdu_cnt;
+	__le32 tcp_ack_msdu_cnt;
+	__le32 udp_msdu_cnt;
+	__le32 other_msdu_cnt;
+	__le32 fw_ring_mpdu_ind;
+	__le32 fw_ring_mgmt_subtype[ATH12K_HTT_STATS_SUBTYPE_MAX];
+	__le32 fw_ring_ctrl_subtype[ATH12K_HTT_STATS_SUBTYPE_MAX];
+	__le32 fw_ring_mcast_data_msdu;
+	__le32 fw_ring_bcast_data_msdu;
+	__le32 fw_ring_ucast_data_msdu;
+	__le32 fw_ring_null_data_msdu;
+	__le32 fw_ring_mpdu_drop;
+	__le32 ofld_local_data_ind_cnt;
+	__le32 ofld_local_data_buf_recycle_cnt;
+	__le32 drx_local_data_ind_cnt;
+	__le32 drx_local_data_buf_recycle_cnt;
+	__le32 local_nondata_ind_cnt;
+	__le32 local_nondata_buf_recycle_cnt;
+	__le32 fw_status_buf_ring_refill_cnt;
+	__le32 fw_status_buf_ring_empty_cnt;
+	__le32 fw_pkt_buf_ring_refill_cnt;
+	__le32 fw_pkt_buf_ring_empty_cnt;
+	__le32 fw_link_buf_ring_refill_cnt;
+	__le32 fw_link_buf_ring_empty_cnt;
+	__le32 host_pkt_buf_ring_refill_cnt;
+	__le32 host_pkt_buf_ring_empty_cnt;
+	__le32 mon_pkt_buf_ring_refill_cnt;
+	__le32 mon_pkt_buf_ring_empty_cnt;
+	__le32 mon_status_buf_ring_refill_cnt;
+	__le32 mon_status_buf_ring_empty_cnt;
+	__le32 mon_desc_buf_ring_refill_cnt;
+	__le32 mon_desc_buf_ring_empty_cnt;
+	__le32 mon_dest_ring_update_cnt;
+	__le32 mon_dest_ring_full_cnt;
+	__le32 rx_suspend_cnt;
+	__le32 rx_suspend_fail_cnt;
+	__le32 rx_resume_cnt;
+	__le32 rx_resume_fail_cnt;
+	__le32 rx_ring_switch_cnt;
+	__le32 rx_ring_restore_cnt;
+	__le32 rx_flush_cnt;
+	__le32 rx_recovery_reset_cnt;
+	__le32 rx_lwm_prom_filter_dis;
+	__le32 rx_hwm_prom_filter_en;
+	__le32 bytes_received_low_32;
+	__le32 bytes_received_high_32;
+} __packed;
+
 #endif
-- 
2.34.1


