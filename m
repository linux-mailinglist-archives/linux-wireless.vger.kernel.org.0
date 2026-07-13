Return-Path: <linux-wireless+bounces-38925-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U8o+EZxHVGqbkAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38925-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 04:04:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F574686F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 04:04:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=lzZarns4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZXDENw+O;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38925-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38925-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68E0C30094F3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4402D063E;
	Mon, 13 Jul 2026 02:04:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BDE2116F4
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:04:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908249; cv=none; b=faE+y37RiKUXLhPL/7RZQgjCQMCRETfJDDa7i7D0DjLla2iv8NRddM9RwsSVYOuzzHzpFnEhPt/9KZgZhpMKAyDaQvwQWLvrGH7Oe6cIOP1lrO/CcJiozdvonmmCGzj6PHTydT27yLdWmjVkR4PB9LdKx5/oJNJ2FVRwLuzvONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908249; c=relaxed/simple;
	bh=SDEQdz3SvnCqfp9Vkg5u3uZLgN3RRhGZsDLR3vL20hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BSS6W8TJALwi7cXvSmfLr8VLsK2Yfwm94fw2KoV6KHaqIySqgEPp3LbdIh74rQQFBSvZ7XNK6J3GQDH+apkB3Z/IJ87wV8bkv1yjYR7QQFom1IodDIZNypUxah+beZB+5Lc05Ji9nGlNS2opP6Rq8n06v2hPB8dpaS6T6Bu6pvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzZarns4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZXDENw+O; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D0kBxX4018605
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IqI7QBEnD99A9xQfzy37mGvJ6+18Nd5vcj2
	Jej2Ru9I=; b=lzZarns4DcOH3Adkezj1JAQsshicXcOPihdBlu3bOElC//5SeUm
	qwhiUfoBo9XGqO8fPoL4mPmN3LM+ZYPKeMJO2Q2Wduv5iucncbDxcgKR2Z+x/ObJ
	X8hZiFDf9CbwhUbDVPOtX8Bg8PNuPYLO7kquxIii6+6h+T0YkhFC5iFFZhXIJtHK
	IrC2R3/MWwzNlmsN5cUfMPKn8UKW/0/A4weZN6Y6BhW/bAw8V85JhTUSA696kHfq
	rHLpF3G2qELSpdqnvSXx9EqjZyBCdbe6HxrPskpJPHlC77hmw3xgvuhwHjn7q/wz
	EB80rOB+OMaT76n5iq5wiuEYrLbGn15z4Ow==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe913ytj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:04:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so52821815ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783908246; x=1784513046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IqI7QBEnD99A9xQfzy37mGvJ6+18Nd5vcj2Jej2Ru9I=;
        b=ZXDENw+OUhJ+Eu1XJF8KauEDZTnimqI3Mia9bLnx4CajSODMUFEs3w4yaZ4V+gcY+t
         iz2kIgnm0DVHJ3o9yZrXWkGzB/P5HY93fSwJSitnjbUl3JRnvOyY92p/31KokaXUhWkK
         hdMhlyUD9k+K16V9WKBI5opUxcKwTsQ1wKMpRaZRdUeL2JerO5eRt9IKzl2gtGU5pMQr
         P3QoYrZyfy4M5tnC5H6+11moopdAFCJobKKizkppJG1WeQ2sg5jsbK7z4YdRvaywiNFX
         NOLj7Q5S9RrX+8LERmGDyHGC/Y/RXU/zdPRS0YkHnDFippDXi/WWhN0soGddHBhSEJSP
         RP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783908246; x=1784513046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqI7QBEnD99A9xQfzy37mGvJ6+18Nd5vcj2Jej2Ru9I=;
        b=PBmDhqyS6uDir+dY2npEIGdNvtRlcnsdVmma2rjeUTd8xqaZpmEbEIE0W8N0eqSGWK
         KG1MEBeCaQPzO6OnbfNXB4XJZGbEvphsd+vRc8VUtcxs1deiBTYf7Sbfu6e0+n+gTUQg
         r8fxiLwYZrfsi95yLr1zWvIVTplb/i6OwUBW2Bw6PgJ+n+LB8WfNU8QGM3jB/zRel0Ai
         4dmBM6AOO+eTbmXnWN871Tv/gjZSYCGoFCLkyt07aRXbIKgc+rl+/ZXTI82rZNlnIK2p
         pVYnHSiVznDMdD898UT2qEDkmffw1H49/ChSHSupqX+FQhS8uc547JXVYeT0gimaBJgx
         tTjA==
X-Forwarded-Encrypted: i=1; AHgh+RqnjwdgfDDPmeEHYbIJr5pNDjln6bmmHZ9vh4qIAjmF+8eQMSpdhTl1W/QP5MovmmCW7gKB1w6hKmB6ZxNJmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSMgWEz0LJJY5FqaXigJCkNGXNaHvkBMOejWxC7VPkO1cOfGW
	LcGwDvhQZ62Be/K1fAKCYGBk0OlWVRf885MADb5gb3gUCLFq3W9nyqTyeXQjv1BbF8gANTao7oN
	3N5JOVSTTaLXa9J0gs4ES7BReLflmUdiZZJVNe2ZN/SfV7Z8MQezvl+h1GQJt3inV7HUk0w==
X-Gm-Gg: AfdE7cnRyUaLjoTHxCsuoACJnbU1qSlMZVgccoCD6vX1dvYznXLavNNbG7Yf7YnXtno
	Uz/eJk9yXs7T1rGZHZQyO+rP75Usmbqi3RISgCWbqvHYRR1zcXiVFGHM3fqV0JXM1459R+L5vwq
	qTolat+edhI7K6iOyIkQdCcRlt3rrpSIUtv3lfSJu73vkPmhWqqLdBublRD4fSce1yvlv+dldQR
	H8gY6LlvWKU6Gc8AQj+CuzAel4GFCrk+BX9FlpW9ncEdxB7774JLW7RKAOxtoLGO3PYVgBxGc35
	uIREBea31G0Q3FkYB8hHKPL63Stm0QgFmrGWmTGDgSzCSthuqxgpz3FHw6ieJz6AFkEC0Ny/4ki
	z9w5OYmNyDn8YBP82L704BFqJT3qllhveVSERz8y4WvV2fdgxpDCKG+9HJkJKLc+tqVtvJA==
X-Received: by 2002:a17:903:2d1:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2ce9eabdb5cmr66409855ad.19.1783908245912;
        Sun, 12 Jul 2026 19:04:05 -0700 (PDT)
X-Received: by 2002:a17:903:2d1:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2ce9eabdb5cmr66409605ad.19.1783908245426;
        Sun, 12 Jul 2026 19:04:05 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf7678sm91862655ad.20.2026.07.12.19.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 19:04:05 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath11k: add purwa-iot-evk and qcs6490-rb3gen2 to usecase firmware table
Date: Mon, 13 Jul 2026 10:03:59 +0800
Message-Id: <20260713020359.3618193-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a544796 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VTncd2SxVE48FkO8qcgA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAxOSBTYWx0ZWRfX6pZ5tQaPDe3t
 Kv+Ril5H41ugU1jt9Pm0M3qbO2Il2N0IgowepL084wv1LqcPI+d+6ag+mGXMB4JqUfwC/Oz7Xbr
 o6ItG/DTDi/F1OsAnSqsgO/0l8bnLcc=
X-Proofpoint-GUID: ykGaYs3LB12g7WiQeQNY9iVB-vx0nomn
X-Proofpoint-ORIG-GUID: ykGaYs3LB12g7WiQeQNY9iVB-vx0nomn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAxOSBTYWx0ZWRfX9PrSFXgaqZSh
 RTtGV6lnrQMIEVxwmYJk3+0p+qaIdcLWUXP8eY4mRxanb/uJ9sNaxmVbkfTCBEfr2MnwhlqAdrs
 w0eYENgYs/EMoUgcJtR8pZrTaquG/Joh4iSh3EdQMfHvVrvisHvEPSx0JpcJqUpBnszKMUGk40Y
 DUkzueW+YSsFKDfk73wkqjQcneiAor8M8i/kHW4VwBKeIwBGukQbP072c0cq3jNdhk9moOHjeFe
 JFg8iOFzPLEG2OupsDHyoYLgXCNWArOVRgtw/hoU6SXRgWAmPoPWWLAUW9hdZ/6RkJHl+hXFIo7
 3r7S3m0gg3nXXWPBne+IsZ8Mz8PK1EiojTGoldAWFYKp2JYhHYE88+zJQywfWDRqxqSKECjYeBx
 iyPqWX6R93Psa/xPmefGkGLTnZf8XLmFJobzaUFUt5MMI5y+rHZqwi+pb78yssWazQ2Z7Q5UBNB
 fh9f/m55SQ/9xFGSAZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38925-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miaoqing.pan@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F0F574686F

Add purwa-iot-evk and qcs6490-rb3gen2 platform support to the
usecase firmware lookup table for WCN6855 hw2.1.

These platforms use the nfa765 firmware path for usecase-based
firmware selection.

Also reorder the table entries by compatible string.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8dacc878c006..8039124e7832 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1049,9 +1049,11 @@ static const struct __ath11k_core_usecase_firmware_table {
 	const char *compatible;
 	const char *firmware_name;
 } ath11k_core_usecase_firmware_table[] = {
+	{ ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
 	{ ATH11K_HW_WCN6855_HW21, "qcom,lemans-evk", "nfa765"},
 	{ ATH11K_HW_WCN6855_HW21, "qcom,monaco-evk", "nfa765"},
-	{ ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,purwa-iot-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,qcs6490-rb3gen2", "nfa765"},
 	{ /* Sentinel */ }
 };
 

base-commit: 951dc0a744e4dc8490935316d3b76e23990bde3c
-- 
2.34.1


