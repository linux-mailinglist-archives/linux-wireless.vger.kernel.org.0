Return-Path: <linux-wireless+bounces-32783-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULX0MttSr2m/UAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32783-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:08:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDE242895
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A1431433B8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AD13BD647;
	Mon,  9 Mar 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdOiles1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWmq9UZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFA426EA0
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097555; cv=none; b=VnCy5KDiZUvmpF7K8yfExNN1+MIep7mzUbM3GskmzltuT0e5D9tAxPG5seShGD6v22uQGqeg3IUTh94b5lvcRbywXNfbwoFwkx5s7Pr41xmNVNsJjnbq66CPBunCBxcwx9OOWrFrbDsdJnfatDMvQdN6JuMNN3YS9ycSNPFQTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097555; c=relaxed/simple;
	bh=QZQdxBzDREz32KOHpC6Wbf0TNGVbGzPhgBMYA+OuF1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkMO9jhLK9MNS5BaXQZGj9jL9q5jpRr77FNia7soxUN8b/mEFBRYaD0b70rPYO5JZEIQYrZavtf1KHsNW4dxVHY4wttqTF6UK87s/s8LQg44t5GBfx/ac9fXGtcHPBC8Ypeq4oQjzMPuzv2CxyPNciYfSQUz9pT7mtddR01GNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RdOiles1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWmq9UZP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HC0n42427877
	for <linux-wireless@vger.kernel.org>; Mon, 9 Mar 2026 23:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=03PO2ofFbk0
	Yu5UA0mjka1WF4PLNd178/K38c0flSgc=; b=RdOiles10PVFNTsM+iN8mqyJAEY
	kLhkqbaC7CnBRxLlA4FssYmNKhQNycGzI6juLkAHvRtuzpXLnGxIHAbiBge3mT06
	sdZOjrvEnZTmrxqVJb1x6EdFzDW/nHGtdRFao3ac/Y+g+o24BXIDHBfOLVa7FUk7
	DmpcarEZxqgdUx/EefKsK+iK6bxGgq4Cp3hfOB4FryWGMKcFmYzwKGOjLkWYLj0y
	kBbEGi58WEdg4i42zYqUhKi1FK9+OIvOlu56FnolRdvOEJRAbRcxF4GuHNRhFWN4
	WTxfDFn4JFdQeIFvDYQPvfCFYSh1c9YrbeTgXLlrnN2W3OtoNZKr19o/xOg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct1eks90u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 23:05:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd77bc8186so2554237185a.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097551; x=1773702351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03PO2ofFbk0Yu5UA0mjka1WF4PLNd178/K38c0flSgc=;
        b=LWmq9UZPPbcP7ChKoM1E3dGiJn1hDoexA5f5WP/ahCjpT6u4OU1/2pnoWBHN50pHGI
         slAIApOTrSGb2PYnZrBc0MrFaUW+G+CoTl8GS56FMEzXFMHen+gGZVC4Ln4mCxCkG4ih
         icpYw7GHB90PIIWtTZrbxE4dFCj33/558hMpqFiQ7kOm4hEqUpPuXG+ApADKfH+6NS+Q
         1eKLiI+vpzCrdI6xvkQzVv6atqCrxuq9E6ubY4IOspJZEcAjnNSzA2/c2K+XBi4M37ws
         MsnHDJGoYcd0dx0vOK+/g8xgHurkq4XYqwBQ5eBqkxPmDI2TS6hheoUlllDNkRY4YaLg
         uk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097551; x=1773702351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03PO2ofFbk0Yu5UA0mjka1WF4PLNd178/K38c0flSgc=;
        b=QgSXv6Nv6Ig3+yiKVu6+ZYLKuBZus6yOBMlI5lLwu0iKSADJMYa3RQJxF8iGzZBycY
         oruxZ1q8aFaxhGs4J+hlUPqLqKWi/0+9bZGyc8ffZKofR6KMiMyeBxPXMHeWlY+MOecx
         fEelZD0+Ov+CfL872DeM3FHvuXMWU7FHB2EOB6DM2K0OsuEMan9+RGuJG/WjK5k7wxUO
         vvsUF5Dm8fInonFz9vG5+p8zH20FuecrLCkw7Y41ygZtWG+/+O6HQs2YV8qhDQ4H7YJb
         dpFvwC5ZQdVfxmyXeV+la66GS7rW135RSqATZ8xIUAWrNwEbFmlgo/5BVwMhcRqUYyqL
         6IcA==
X-Forwarded-Encrypted: i=1; AJvYcCXUaim5nQ1fYd15qTiCTBd4Gbpj+9OvaFkbBcIGpFuBQByNFxnFq89MmaZjlG10fcXCnEb0FS1ArclrY7uR1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK0bfe3aMlQB2wCgpKue23yPe9n0P0sFn4+46olQUjgLFDQBz
	MnaG34tAUimCBydVTAVCnqDgM+cZwk7JWPX/hWEYPRxiHN5o5in5cXjZoUVHNEqG1ifejQuq6Jj
	wgc52Tcf5JaQ7IRNzHPvGZUQ9g9ZjvgnidwxZxOY9nsmIl1lQWJA9BiukEmdUqmSwlICc8w==
X-Gm-Gg: ATEYQzxhsdhPU4JGy8qxed5EQS8kEnfu4sKFJyTkUtsblJzQJm0PUwiStNLsFLEdiVL
	yG3yDd91H+P4fQ/IeFmH9j2tHBkrz67v+Aul2DKaO+j7iqZTWU9Z2evmSL4debozoUaiWCWMnJO
	8J5NeaBRGo25bg3XcIoApVm3P5aEj8whE34xiTw2swXLtyeQeZUfiM5K4mmsWqNZTlag3vlQOcu
	14yGvVZMB1W7AIqfbLE8MrPDzYDg33JV+f+lhEElOS857k5Ym1JqTrjitfAfus10qYcmtakYBVk
	v683Hd4L/qlagEhxc/2GBcv94XrXWmnCTNhAruvYWv4iLymz7eLkqsxmyEKK6zNrvmZuNDt8LKk
	vtJ65NJe+ClnoixkP2uEKTgXm4D7360FpST9TpjM82ZdN5Oj8kw==
X-Received: by 2002:a05:620a:4445:b0:8cd:9584:6335 with SMTP id af79cd13be357-8cd9584736amr41477285a.77.1773097551426;
        Mon, 09 Mar 2026 16:05:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4445:b0:8cd:9584:6335 with SMTP id af79cd13be357-8cd9584736amr41472385a.77.1773097550949;
        Mon, 09 Mar 2026 16:05:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:05:50 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: konradybcio@kernel.org, andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: [PATCH v1 3/8] net: drivers: wireless: ath: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:32 +0100
Message-ID: <20260309230346.3584252-4-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 50X2Ohx8Yo451_JkXorDoD-Dt2PnPH6B
X-Proofpoint-ORIG-GUID: 50X2Ohx8Yo451_JkXorDoD-Dt2PnPH6B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfXzOLBQOS4FEI6
 kuYTVS0+mVbsLhTsjlIkPBMLcPu4BSI/edXUGnmeErLS+/9j6b+HBdQk50L5XnXecV3bEybpVwO
 XMAUDG1MYzx913pXhUL+6PG0hXltd3uwytR835J3FLCpLcAILX9H9UOjnU/2ab7yX7EO+MlXlyR
 dUSB79H38VSmlSYIFs6WH9uRb+exot4MseK/zFq7W01B2hHehyKTzWwyTH5Yi4GtKXE1VNCEeuv
 h9D2N7Ik8iDZxM/UU9FqqQ57fAV0DXRyyO2ytTMBbJoaVc/IVr5eFXQxqu58/fsAzW+ibB+2RGA
 xh/4WIG8OklIMTadVgd8JDFWotxvRTOTVdIz8lfqxWDuoxHpMDJtz4oWEerG7VfBqgPg4/yaasP
 KQc18+jbC/dLPzTZrcMMjyPzT16Cs7mLRAC1gioS/5uBEpMQf1rxEAo/fqdTbRLNnwFq/IQW9oP
 3W29qlCPI3YnVkLrKzA==
X-Authority-Analysis: v=2.4 cv=eIEeTXp1 c=1 sm=1 tr=0 ts=69af5250 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=DFXFU3FfpSgEbJi8yTMA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: 47BDE242895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32783-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h | 1 -
 drivers/net/wireless/ath/ath11k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h          | 1 -
 drivers/net/wireless/ath/ath12k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.h          | 1 -
 6 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index eebd78e7ff6b..4fdd0af415d5 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1105,7 +1105,7 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 	spin_lock_init(&qmi->event_lock);
 	INIT_WORK(&qmi->event_work, ath10k_qmi_driver_event_work);
 
-	ret = qmi_add_lookup(&qmi->qmi_hdl, WLFW_SERVICE_ID_V01,
+	ret = qmi_add_lookup(&qmi->qmi_hdl, QMI_SERVICE_ID_WLFW,
 			     WLFW_SERVICE_VERS_V01, 0);
 	if (ret)
 		goto err_qmi_lookup;
diff --git a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
index 9f311f3bc9e7..88d58f78989d 100644
--- a/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
+++ b/drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
@@ -7,7 +7,6 @@
 #ifndef WCN3990_QMI_SVC_V01_H
 #define WCN3990_QMI_SVC_V01_H
 
-#define WLFW_SERVICE_ID_V01 0x45
 #define WLFW_SERVICE_VERS_V01 0x01
 
 #define QMI_WLFW_BDF_DOWNLOAD_REQ_V01 0x0025
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index feebbc30f3df..1397756d6251 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3337,7 +3337,7 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	spin_lock_init(&ab->qmi.event_lock);
 	INIT_WORK(&ab->qmi.event_work, ath11k_qmi_driver_event_work);
 
-	ret = qmi_add_lookup(&ab->qmi.handle, ATH11K_QMI_WLFW_SERVICE_ID_V01,
+	ret = qmi_add_lookup(&ab->qmi.handle, QMI_SERVICE_ID_WLFW,
 			     ATH11K_QMI_WLFW_SERVICE_VERS_V01,
 			     ab->qmi.service_ins_id);
 	if (ret < 0) {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 7968ab122b65..eae416db8b52 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -15,7 +15,6 @@
 #define ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE	64
 #define ATH11K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
-#define ATH11K_QMI_WLFW_SERVICE_ID_V01		0x45
 #define ATH11K_QMI_WLFW_SERVICE_VERS_V01	0x01
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390	0x01
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index c11b84b56f8f..f31cba7af722 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -4061,7 +4061,7 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	spin_lock_init(&ab->qmi.event_lock);
 	INIT_WORK(&ab->qmi.event_work, ath12k_qmi_driver_event_work);
 
-	ret = qmi_add_lookup(&ab->qmi.handle, ATH12K_QMI_WLFW_SERVICE_ID_V01,
+	ret = qmi_add_lookup(&ab->qmi.handle, QMI_SERVICE_ID_WLFW,
 			     ATH12K_QMI_WLFW_SERVICE_VERS_V01,
 			     ab->qmi.service_ins_id);
 	if (ret < 0) {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index b5a4a01391cb..2a63e214eb42 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -15,7 +15,6 @@
 #define ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE	64
 #define ATH12K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH12K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
-#define ATH12K_QMI_WLFW_SERVICE_ID_V01		0x45
 #define ATH12K_QMI_WLFW_SERVICE_VERS_V01	0x01
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_WCN7850 0x1
-- 
2.43.0


