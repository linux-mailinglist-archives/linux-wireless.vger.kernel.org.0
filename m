Return-Path: <linux-wireless+bounces-37963-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Psj/J5vVOGouiwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37963-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 08:26:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A36ACF10
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 08:26:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LfPp9i7u;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VZi95YFH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37963-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37963-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B429A300F9D1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5224BBEB;
	Mon, 22 Jun 2026 06:26:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A26233956
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 06:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109593; cv=none; b=onj63odVBfHrMUyFfz8RO9sd7xNwXzIpD7z+xoqYnHRjUcSU/kpVVQWbqLMS7qRMz+jjvvFC0LLQvXtlT+deVKqaeHCIWoqS4tq/TA+z/iFCpd8SIWD6mYq6xPe877DCWX9RM11YfNzU5PCb5+W03g2X07F9DIuxvFcRPTSdJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109593; c=relaxed/simple;
	bh=s/wYxf/a/f+khimlrxpzAayEWKg0c/93vtX1n1Tty+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKGYVDOpRmzn582876vT+CP+o0ZVFngHan2Y5UMQouL0ax2txiDtr4N8H0HErQkhMCGg3Cd6IK19zObbgEA1yihyMayatsPTnCiVlRBZP/CSvL//VQlD0cHAnjdLlJgHuFKLD4kZU/Ie0YfB1538R9mw04vvkgHoJC/SWOGD3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LfPp9i7u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VZi95YFH; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59Df91275444
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 06:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5QCOjORRhwy8f5PoTDOoRqr4PyIF61sQpvI
	gvDJe4B8=; b=LfPp9i7uDpq8i5SzHJWi/3BKAIpVUYR7YhY3dsryUUEMGgq7C4m
	9tCAiVOWtTPgjWNW1MqjBWGDCGRptggHEusHHExOztzgrpzYkuYpXN3eGoyp/WPN
	6tnSBKbUQkRyFJ842fEXGS5wA2bvq20uRI0l9BwL8EmLvXpmrHLDKZNERTZ+UdtC
	sO/bpIvKwfywQ1uCij8aAdr17Trj59dkeD56ha2bQfY8KioNcbyf9PzA9dLwt1CN
	Y6lek38QnPhK+CsR4myefjkE7z0SpGcso8kSW5IUJbAjI+d9r1zt6UOMeWmJNMCW
	HtO+jLFmd2hy/yiMHZbU46eIdu8vwqRAjMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewk32w0nt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 06:26:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37d125687b6so4057739a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782109591; x=1782714391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5QCOjORRhwy8f5PoTDOoRqr4PyIF61sQpvIgvDJe4B8=;
        b=VZi95YFH1ISG0pvyH1SKuaKrfkZO+ddLbIwTPxShGEc5e0aaODSL+OxmXLRRNm/DD1
         t3XdHeH8AZGFCkIEU4nYE9kzMENlaf3cn4DxveA10W5y03IgPifkFwMNOEJpGy6w6+NB
         1rTd6YwpfHXS+A8RRFtwgaYskJ0yYnQ4BCHNwLYvfIVxTM7c6LS+kEYC7Xr7CKNHzi9C
         CtVI+6IwQAsQWjw+WlJMjF7iZskSmx3VM3+NtqvWy8tEv8Qas4909TGmQmL47ZUQXBt+
         WuymwTpu2kpOqCU4CqIJ964dadHe5fTshXpEX6VxbDVFcrDjWsHFLY9sDpxjcLvf2KEH
         OX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782109591; x=1782714391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QCOjORRhwy8f5PoTDOoRqr4PyIF61sQpvIgvDJe4B8=;
        b=ib9XyQYskixayXbez19SFhcNv8pkcE5gfWPZLFUI7hKSwHuIWj9KkJTT5CVndznFZ5
         lOu2EAEyaQ0EtpKPzTbbnJZqVCu8yOf8SUHlut+IeBKMaHgCJc5YAcy2y7B73ssNrrhj
         YRkVzu6Io4t1srfi4gg6ubvSZ4ygczh7Eye1CGbvzZVCA426TDBrtxGFaceZlKIKEzVY
         b7VVrPmgcNsmoTc0NKaQ3Oi3Cv4/CbKIjZOP40aUj3LoACSLDDR0ijtwSHFaJhe8V8+N
         0O4cH/74JXEYN3HJT9bOEVtjk7m5sduQfor1jjHnATsWZp/PGoUObJHcPS05+6ne9L/Q
         0BAw==
X-Gm-Message-State: AOJu0YwfiSyP8EhgI6aEXble4B58cst1Va9pzZhIwYY5rYPicXPUMt+I
	hy6h48rjmrc2CEzS2QuSGlWJJ22w0vV0v+NTOUzAH9bt+p3+grgfhDac2fP4H46WtT2rcvIM1Di
	/xD+P1OuqwTyo6As5CyUuN80OOHdsFzHX+2HhN1RPOqPF3kHTboiu4xcb8jT3uUNPYhnFIg==
X-Gm-Gg: AfdE7ckygTnVNyZxS9Uf4XqhIQTyYix3YI4MYRIgx2P3F+HSNNl97+d5gxEJ5JdfAs5
	A7uRcZvtjW884ReMVKS0u3+6AMZHmQnS9qDa+xaneqM6KHBQP6vWledT0zNii1JiGm5bWxOd9Ok
	cth6dNvGBSRn4pG+brv+34YEOZO/TOO3wA2UJoiIU9cQq18amKSQlvO6L6KkAfwKcAJ+pvsPW8I
	ZJCJOgP099zN01M8omOr8CHYn8ey5FCE+ediq/DhPwTvCr7jTF9N2LE4UR8OYngnvxqs8Yynjur
	5pUXW2+oY46DAYpdIx3LyjlpWSfXi3N13hf1jXaaUw7Q1dUffE5Dl7UIMiq5bxLJ6pxBqiLXton
	8I+ZQ9WXKakXLrJGbTUciJ323YsxrngFbwyk5w/s/8Aa6fp8wWP7OHdYzLQG7EWl3kuKAXlTO2v
	eqGLLcSlZc+SRVIF946JNWQnWUP793Rp8NGahY0eaAPd4=
X-Received: by 2002:a17:90b:2686:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-37d1ea6759bmr12541195a91.24.1782109590453;
        Sun, 21 Jun 2026 23:26:30 -0700 (PDT)
X-Received: by 2002:a17:90b:2686:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-37d1ea6759bmr12541179a91.24.1782109589953;
        Sun, 21 Jun 2026 23:26:29 -0700 (PDT)
Received: from hu-tmariyap-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f315842sm5904652a91.17.2026.06.21.23.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:26:29 -0700 (PDT)
From: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Set congestion control max MSDU count
Date: Mon, 22 Jun 2026 11:56:14 +0530
Message-Id: <20260622062614.760166-1-thiraviyam.mariyappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 87XFwHyLIuHL5aQkcVrmnbQFx6XVM2yT
X-Proofpoint-ORIG-GUID: 87XFwHyLIuHL5aQkcVrmnbQFx6XVM2yT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA2MSBTYWx0ZWRfX7m+rv7fGzBgP
 5Zob6sCiXIidhnOuTO6pdwJuCI1X0TIbobXn+NzynbjfMLl+xhFeXrvKsBaD5REzYOFhadHSdh0
 2Sz3UY6hMts1B7ndLJ82c4FFo9tW5DM=
X-Authority-Analysis: v=2.4 cv=NovhtcdJ c=1 sm=1 tr=0 ts=6a38d597 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3WufNbzN01JiPezyzvUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA2MSBTYWx0ZWRfX+0jhANMTIxqr
 VWzBTcgwRMABVTDOC2N02mK4HN6rtKWcQplT7tPL+6LiFqJD+WzKrxhWCdY3cbOaJbusCUQy/9s
 cue6mcNCztubBCD5uw5NQ6FB8kaaWf9D3CDVy6uGoeIwTVIdNYwNyW/ch50WxWkNOM8hSCd8qsg
 zGRN4Gj+JBbFZAEy5CGmt/mRJPRswyI8yA+EVRRl6IdCSDFEpv4hZ6XIRrKPM/Bf0Brk4EaucZj
 Z1hrP6rvKA8MqPLN0C32KYyYBL4SyCp4wNg8hskZNIYc2kQZpN4zi/oBrbdWlDoOYCdx06j/vQ1
 G0kBB43IJMNqMrqsCYdhz4tdfRS9+Ce+chBA7lNqUBpvlsstf9y/l+AtLbPmpfRjngi6Uq8qnAM
 t8WegCxw9GKW3MZuC2Ze93/mTTp/B9DYdvuIrJpcITD3SNCIH02YpqRrRheeCMCpKoIRj49MM7K
 mJAGv36wnb57fX67BIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37963-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:thiraviyam.mariyappan@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thiraviyam.mariyappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thiraviyam.mariyappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA1A36ACF10

Currently when running 128 clients UDP DL test in 5 GHz HE80 (NSS 2x2),
firmware uses the default max MSDU count (16K MSDUs). This lower limit
causes the firmware to compute a smaller TQM drop threshold, aggregate
packets at a reduced rate, and results in increased packet drops with
TQM drop threshold as the completion reason.

To fix this issue, set WMI_PDEV_PARAM_SET_CONG_CTRL_MAX_MSDUS to the TX
descriptor count using ath12k_wmi_pdev_set_param(). This increases the
TQM drop threshold, reduces drop events, and improves throughput from
~722 Mbps to ~1060 Mbps with 1200 Mbps ingress.

Add a new HW capability flag (supports_cong_ctrl_max_msdus) and enable
the WMI parameter only on supported platforms.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hw.h       |  1 +
 drivers/net/wireless/ath/ath12k/mac.c      | 13 +++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hw.c |  6 ++++++
 drivers/net/wireless/ath/ath12k/wmi.h      |  1 +
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index d135b2936378..ad62f93441b3 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -192,6 +192,7 @@ struct ath12k_hw_params {
 	bool supports_shadow_regs:1;
 	bool supports_aspm:1;
 	bool current_cc_support:1;
+	bool supports_cong_ctrl_max_msdus:1;
 
 	u32 num_tcl_banks;
 	u32 max_tx_ring;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index af354bef5c0d..403f00ab2e3e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9722,6 +9722,19 @@ static int ath12k_mac_start(struct ath12k *ar)
 		goto err;
 	}
 
+	if (ab->hw_params->supports_cong_ctrl_max_msdus) {
+		ret = ath12k_wmi_pdev_set_param(ar,
+						WMI_PDEV_PARAM_SET_CONG_CTRL_MAX_MSDUS,
+						ATH12K_NUM_POOL_TX_DESC(ab),
+						pdev->pdev_id);
+		if (ret) {
+			ath12k_err(ab,
+				   "failed to set congestion control MAX MSDUS: %d\n",
+				   ret);
+			goto err;
+		}
+	}
+
 	__ath12k_set_antenna(ar, ar->cfg_tx_chainmask, ar->cfg_rx_chainmask);
 
 	/* TODO: Do we need to enable ANI? */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 3d59fa452ec0..8c99c50a4ba9 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -390,6 +390,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 					BIT(NL80211_IFTYPE_MESH_POINT) |
 					BIT(NL80211_IFTYPE_AP_VLAN),
 		.supports_monitor = false,
+		.supports_cong_ctrl_max_msdus = true,
 
 		.idle_ps = false,
 		.download_calib = true,
@@ -480,6 +481,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 				   BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				   BIT(NL80211_IFTYPE_P2P_GO),
 		.supports_monitor = true,
+		.supports_cong_ctrl_max_msdus = false,
 
 		.idle_ps = true,
 		.download_calib = false,
@@ -568,6 +570,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 					BIT(NL80211_IFTYPE_MESH_POINT) |
 					BIT(NL80211_IFTYPE_AP_VLAN),
 		.supports_monitor = true,
+		.supports_cong_ctrl_max_msdus = true,
 
 		.idle_ps = false,
 		.download_calib = true,
@@ -654,6 +657,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 				   BIT(NL80211_IFTYPE_AP) |
 				   BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.supports_cong_ctrl_max_msdus = true,
 
 		.idle_ps = false,
 		.download_calib = true,
@@ -738,6 +742,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 				   BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				   BIT(NL80211_IFTYPE_P2P_GO),
 		.supports_monitor = true,
+		.supports_cong_ctrl_max_msdus = false,
 
 		.idle_ps = true,
 		.download_calib = false,
@@ -826,6 +831,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 				   BIT(NL80211_IFTYPE_AP) |
 				   BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.supports_cong_ctrl_max_msdus = true,
 
 		.idle_ps = false,
 		.download_calib = true,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c452e3d57a29..4937c547562e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1083,6 +1083,7 @@ enum wmi_tlv_pdev_param {
 	WMI_PDEV_PARAM_RADIO_CHAN_STATS_ENABLE,
 	WMI_PDEV_PARAM_RADIO_DIAGNOSIS_ENABLE,
 	WMI_PDEV_PARAM_MESH_MCAST_ENABLE,
+	WMI_PDEV_PARAM_SET_CONG_CTRL_MAX_MSDUS = 0xa6,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_THRESHOLD = 0xbc,
 	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_PER_AC = 0xbe,
 	WMI_PDEV_PARAM_ENABLE_SR_PROHIBIT = 0xc6,

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1


