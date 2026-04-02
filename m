Return-Path: <linux-wireless+bounces-34303-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM9SJRbpzWkLjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34303-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:57:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 571043834EF
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1595830CA260
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 03:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6707935FF50;
	Thu,  2 Apr 2026 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUez0uUu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c8PORUJD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9935F614
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 03:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102070; cv=none; b=GaSCSxXYLSAwc2v5HxQcdw5HIS7qV6iHIcHwVzTNq3V1aokQAxltWAmeBptOF+UOiTABr84GTDUW0XXR82unXcl3Nnu1sPKOUvu/Os+99JnroLUQeNDWzTCY/AW4qdAZC+bB+M0EF0PBhB0drojF0JdyGvyWSlfQ98lGOGgFnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102070; c=relaxed/simple;
	bh=4qfqDIpl9+i1jdlyMFnMeF5YaTgLpAL85qTp0ms9CR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdIqdR1a5Npbe/xRl0tQGWyHv2PlTWr+LR75M+jGlwtFeB3KMwXwU8H/FrysErnS4lZKg1HqLQ2QUtEQMpxVf2/YIAV+vwtRXwVTLzMBTlN91v6WjXlw92oOETkwaYwBUnMPgf/06W574TF5xV3BZZqAGMujO1p1EOcCYTsDdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUez0uUu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c8PORUJD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M40hw3745892
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 03:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h0IyBeCS0RIC8L0kumGdv7nrT1SM/aWdVx2fCYERunk=; b=MUez0uUuB71PII6S
	zoqOYG4dVhkR/hcIbNeOxzJZrPY0DwkSJNnNcKTnsQJsc5lHRxO/b5eOyOdRTCsl
	7xCOgvDPDJpfCu6mrtk/EewnYWAz9KRtseShRPrP3n/1nTBB18t7K6U+fvv0qhGI
	6KFYjjnv+X0cUqKoo2fQAZr1eVH8efIeEwQn+dLDDMQnpHLui3P2zVllHOaNLWlv
	riKvo87XfISwlPOhC7Kq2QMQ99uBiiJnXQGwd2SZnT747i+MFObEdmF275Pd99Se
	CTIYEX4hY1akI2JfWYg1/SXjd/P1L0Bp0Kyo2akmQXHLuOeN7sx3wgrgUJ4sXKe/
	t41Vfg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9324k833-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:54:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c649dc145so244963b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 20:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775102068; x=1775706868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0IyBeCS0RIC8L0kumGdv7nrT1SM/aWdVx2fCYERunk=;
        b=c8PORUJDgOUgSZ6Qk75MGaJ5155xO+RUN3/an/DX/06KMIOH6ttg+3G+FLES+QT6W9
         VVw6fB8dRJWx77kF7uYvn9PF7I+SYAOSfioTmK0VZpbYOENWC3a4XWXim2ly8oKT+C4J
         ebbbRE2SLIlXzp1XaYtjbmgLC19Ei6i1W+apkhpg1CGGinYxmqgYTZFhLRtJcNmawT/q
         oZCGmnf1Sox3n1XmwpplGthtT/iwwtVjkKQJ30YSn7CJ/k6IV8zMsQfLj/OnsXrdq91q
         ds/AYmA5CYmFA77RTEm6ZAFRC/7Y+T0+0EsCFZ1j+Myv4kGDtmCE746KQaujZR64byww
         JDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102068; x=1775706868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h0IyBeCS0RIC8L0kumGdv7nrT1SM/aWdVx2fCYERunk=;
        b=FPtvxNRd19ZJNj+7lmPoS7aZzBjEh3BNoKoyaP2Ixio9cuE4GL8kt0fJSdEKlVgvUk
         wJWXOLK0pSeYGVJmtbmzTuGbdy77GCIAq9snvv/PIADffQgSxF3aMh/xhOXe4zeKXIsY
         Lx90zr6rcMf/vLjB/ibZmwikACpL2M+DOv6eoLwMWgOlOGg6vdMrgn3K7KvPNmg6FZba
         D9LHNx0DXnjaS91LRMiHlmfgTtA0IHpxuUOVWLRzGJtJ49behRIy7qy6qbF0U9q0NYnE
         hF0RQs3yHdfZl73TJkZdFp68wzzyKS2V2H+K5cuIJqHlYOrLvgMqLrwDtN74b6R0RxYv
         PODg==
X-Gm-Message-State: AOJu0YyQSCe05bogXL6WEXIS87AbA9ZJpSFyVOOt5LWYHSMvGjl3sRDb
	WY1G8+VI5IWAhxbGDZSIyj4QXtwvbobW7lvJG9BOmK/ANfM5W6h3HsDupSvrEkiVL8I22eKPCV4
	u47G1KL4x5lXgGEcLpKV4cqybhnd6EuRHZQyIKtqikm99qGLyQ2BVK1Q3a09P5JJYARyDfg==
X-Gm-Gg: ATEYQzxubEgrXWou2QmmysviTqkCqP9ktTmoAG7ZhVMAg2Jr6pImeFCOleUKtUr6esm
	gEoZLqfdWUA4JpOxhf38DVbWKn16M8qzhE3c8KTOppm156tthP7v/tyClgiiC45vAEmBotiTH6t
	JelqwciTT1JdEgjyq7Z4L0IThzCDZbPv2u9VDSWNKjq9xBrMnfNXC3xx8IPZsN/tYU75Rk2xqLn
	7tJezF/dGm9NLixzlpTimlKj31DEJ3E8U+XmC0xwPJA68q5/LM2Yybc6WLJgUQdF6G+ahumRVxD
	wVPJsaDxIDI9z0kJT/Uemoyoq1rcuaiqFVnkjp0+Ehzjjzu62nqL58Q9S9xJBxTalqy//AhId/h
	5ZrzNKxO7DfzfuI0nvRMCoB0v7i7dgtiCTYMHRiCZSJDnbngFAg1OrxNBx7w022jqPp12bSV3A2
	4fMJsqrh1vmS0hbAHsAse9XFJoNETqM3rA46NGZA0=
X-Received: by 2002:aa7:88ca:0:b0:81f:ac81:d597 with SMTP id d2e1a72fcca58-82ce86be17dmr7041550b3a.0.1775102067558;
        Wed, 01 Apr 2026 20:54:27 -0700 (PDT)
X-Received: by 2002:aa7:88ca:0:b0:81f:ac81:d597 with SMTP id d2e1a72fcca58-82ce86be17dmr7041527b3a.0.1775102067106;
        Wed, 01 Apr 2026 20:54:27 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm1456189b3a.12.2026.04.01.20.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:54:26 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 09:24:01 +0530
Subject: [PATCH ath-next v4 3/6] wifi: ath12k: add ath12k_hw_version_map
 entry for IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-ath12k-ipq5424-v4-3-cd1e0f0a6c88@oss.qualcomm.com>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
In-Reply-To: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: S1_XMpm6rq-cyDro2RS24ZUqVj_-dggC
X-Authority-Analysis: v=2.4 cv=TKBIilla c=1 sm=1 tr=0 ts=69cde874 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=V2VgLR5doq-8DBhT5hEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzMSBTYWx0ZWRfX41ftDAxftXHR
 i6VQ9J2QBoyqlO8jKgJJIGFIwr8M9TSoWl1EnsZydkNxnTVliwj75K8AM+jPRYZoYOb0G1uSQQX
 YKARgSFFIXUnbfPDe/a47qJIHndRrAUGp3C9Fd+64oGcA17wxkONkrx3uTTyaSgj+cW4yTVAonN
 KOkKyperQLXkdcVgqE9sAMm75Savjw+gZP88tfFHEUTVZ6nmDiPIOev+rU8w15oYgestCym+S7S
 TjvGnLIloBsPPwuyxvUsOERatdmGXPGUuz1VHmCPoht2KavabrrmNZMwZYqvobnyZdzAjXftTXQ
 Q9SPJkB6aec7eWoD5iZe/He8dRncQs+pUQhvjP2namYUwTAOKsYBNPawdCtRS8D4sXYZTIRp++i
 noDY5f12JWSfL7g+EGVJ+y6B/2jq8rZTZOVO5LsWE6vBCOEY2+rH8YlSberFtjKzgFcF5FCfwJ3
 mggDdfo/W/2fFHHgaBw==
X-Proofpoint-ORIG-GUID: S1_XMpm6rq-cyDro2RS24ZUqVj_-dggC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020031
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34303-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 571043834EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new ath12k_hw_version_map entry for the AHB based WiFi 7 device
IPQ5424.

Reuse most of the ath12k_hw_version_map fields such as hal_ops,
hal_desc_sz, tcl_to_wbm_rbm_map, and hal_params from IPQ5332. The
register addresses differ on IPQ5424, hence set hw_regs temporarily
to NULL and populated it in a subsequent patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index bd1753ca0db6..c2cc99a83f09 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -50,6 +50,13 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 		.hal_params = &ath12k_hw_hal_params_wcn7850,
 		.hw_regs = &qcc2072_regs,
 	},
+	[ATH12K_HW_IPQ5424_HW10] = {
+		.hal_ops = &hal_qcn9274_ops,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
+		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
+		.hal_params = &ath12k_hw_hal_params_ipq5332,
+		.hw_regs = NULL,
+	},
 };
 
 int ath12k_wifi7_hal_init(struct ath12k_base *ab)

-- 
2.34.1


