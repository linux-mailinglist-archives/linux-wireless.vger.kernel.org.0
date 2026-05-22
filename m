Return-Path: <linux-wireless+bounces-36798-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GZzDnAqEGofUgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36798-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:05:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0E25B1A7D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43CF2307D006
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70738887B;
	Fri, 22 May 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgzlyxGB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4aQfsgI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471C3AFAE3
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444086; cv=none; b=Wp8XE7D1vytAjE5m4vqTjgP1KsbPO4IsbT8eoL6pAmMA3NxSKCo5v+0boN/mn1QdU9j09E41GisUhWh/hQ8gxj/dWVu5w3Ju7nwxKkYkQJunyImhrDY0GMz7ZSdTtwHDqCk5F5I9584dZ7erGKdLxIAbvPnbW2/136DDOmF3+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444086; c=relaxed/simple;
	bh=BhFCU11Vli0eY4peRB1YT42TDHVLDyHFog9G3pGgq0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqNi8NQBXWnH4G7R2i4329p4tEd8CUeE9a54HQ4FETE7od6MOqObvKy38zc+rnbDsa9CV9NQA/2WsdN0pjPpQWYHxs47Clcy0Xv+Tar+Vs9E1YmAkBtBuE6dzjuyeYqjiWOGbdPLnmpg4Bm9v+EQuVGl6+g3oS3s4CyedoLSyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgzlyxGB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f4aQfsgI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M6MAr11298251
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P+6QIFUay/hg2xkAFLiW+meafenw/9VGhbxcOU+YUEk=; b=RgzlyxGB94tPSA5n
	VmceMUIf6T/pLYNQQdcpkxCalmE7Lg26vv2WwJqGcuj4W7nHxcjpcLM1mBh+iXE+
	72/xMMGiPCSy7eXlSFdyXhFM5lU2AVcEYijhJ3Pvwg8nESKOBXpZmVgkT4GMycdv
	ic8HSEjmbIz0XqwzDPbrZirpSCFDLRtUNlBVker1EaBUd4nnlU7n8EjkQSNIJLS4
	8Z+eaVoJpuyr42ZlyZia5YePGd9O5XuqnE9GP7ajY929j37pU30rk4XZMrBPB8KH
	5TmBdinMtcQfwbL69AJe9yj5FeSUdPjKDOny2ntiBeYmvcT8iiep0pyxYhJKlwvw
	VQ3lWg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0adgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:01:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8292a9605aso3539581a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444083; x=1780048883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+6QIFUay/hg2xkAFLiW+meafenw/9VGhbxcOU+YUEk=;
        b=f4aQfsgIMef3SiBknHfadiM5Nq9zyv0FFfVjVDmXaMfT7Ar01ufma5xf7Eq0G9djDi
         jZ2hsDEw2h12kmd0SZDrcPLDq7duxVe9UA59IKgskOI4sQZpcwYaLCc9TgY67Ux7xRus
         yljGHNnNmxowlUKaeQGuGDUdDpvL6XvyoUeoa/xSpJpXvDcvAlixbMeM9qdxI2mCsUq9
         4p/CeGYm1jVy7MbjLLJyxN1NerDZ6w2QzpXhn1RaiMUgoaMYsftOLxjpiU+8YB6DBcD0
         lha55/sPdstYlMJWAuylGikZ2g5Le+RYl1dLwvj/AWTzt8h3EuFsGzKHuRYL90ceIW4T
         uXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444083; x=1780048883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+6QIFUay/hg2xkAFLiW+meafenw/9VGhbxcOU+YUEk=;
        b=l6TkjqcR2jBz2inAba+2sXX6T0qtayIV8YbffHt9sIRbpMO9Yo53Tae/dK9SgQIwfs
         RLotB5wvKPgNKsiuStQZGUZi14IWrboPIHzXk32YuIUZ5VJ3X3F9zcKnd2gxewDOuCu9
         r4T2T0SgwfwxXrucXKxC0+Y01ZVEWE9LDLoeZOmMIVDDG+9TSBLxx/O7efMBs7hd1nDZ
         swIhk/a7rZrVHr+/zIgfUMK5t3X3sJthIOfEiNEZeTEynWarG6CTDjookIliKiSczMo+
         gyHxzaKNImVYxocxUKm7rKdXuPzniKjCutVVyRT0jrg3kELpGFhB3Rug7d4+vCmnU59O
         cZHA==
X-Forwarded-Encrypted: i=1; AFNElJ9CZJeHyVKM72th/aP18E9AMgdrQpJizi95B62peyk+5hR2B5xy174SZ+uauCjv9B5JaUwc7TDvP976aJjcCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUl9KIIfvg4HKeVYDryNuIQtuvaLxxiUjph7pl16/e/iaSlT9
	5J8jKOuE1txyDLxiTOfc+Kc0dEIDMwuygnWRcQtlNg6BykXMH6E+vckU02HyllAkdYWikm5cZNR
	6bzllfPMIRcoM9Rq2ac1LPQOB5Ncb8pKIZc2PTDlkN6YO0AjYgSfVVkrMJrvGE3QLUp4OhA==
X-Gm-Gg: Acq92OGrl5O58z1ZsS3XP6/bC7b1F/DVleL4r7M/tbds0lNqGS8RwIcfVUK6FxNM7zV
	/tklM1BfK/DjgEgxmos8emm0cVmUtxXLSYSwigSJyyPRiOpVHB7rFfHHEs5p3E0lDg56R4wSL43
	fkDeqOqhxFbjxE1slCeGyX4SwctJJNxGJD12Tsv6Gmv5GkzfpmnsRKk9l7Biwz4PwYRdMo0BUa2
	qPMGGF/L6eGLl0xkUoaF6Wz7VYD+xcJNKjcgBC6e7N9c0voVoMykJqJXWDSTallX+AK9n65Lr00
	+x9OMiTo/uIzdRsfsnyMjT10PgFOguRhD/ab5cyzhvA1Hm4bP3AygsEeEZXbBGLenG26yT7kRE/
	E+mOs9hD8WUoRDpQKEhI+QUlHErBG1DnwiaE9mM5eyuszbz8OUAijLci4
X-Received: by 2002:a05:6a00:438b:b0:82c:9f7e:518c with SMTP id d2e1a72fcca58-8415f32e17amr3015031b3a.25.1779444083208;
        Fri, 22 May 2026 03:01:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:438b:b0:82c:9f7e:518c with SMTP id d2e1a72fcca58-8415f32e17amr3014968b3a.25.1779444082645;
        Fri, 22 May 2026 03:01:22 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:01:22 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:35 +0530
Subject: [PATCH v2 4/6] net: qrtr: Hold runtime PM during active data path
 operations
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-4-fbebf41a82bb@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=5157;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=BhFCU11Vli0eY4peRB1YT42TDHVLDyHFog9G3pGgq0Q=;
 b=UVBS6HbShn+y5fJQr2GY5SAYIopHLLknf3feWh42YxN8Cfo16vZuvf1XVAOydKz7dA3b3K6eD
 /OQhLOIVtQKBDTOurt56nsyDbIEnzo5jjzEyQsOPqQr9m2m8ymwcde3
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfXxFGHM0l3q6Dp
 5+Bk/KNN5jlPuiFUetE8R6LjvIz2qRAAcOsJf+Cu9M5jH1Wsb644KHIPwFy7BE0Zb/Hj2yLlGrL
 HgTpa2b5xvKbNoEcxlJeMsQM4p0yNmYV+U2ZtTZzXDtT+uhGpT46MjeVoUFEo2GHsC3p+4bzHsU
 HuFKNka1G8yYGl1uhR0bAJsVG9PIXtZTGEyZnJWTpN8vW9YEw39rreXHb/NHcu79rBsTo+Wki8a
 52cSrThyiBg5bZmaJFOr9xjIDNF/RWQpgX6ZhRfRI5A15vZBykgS5jmFVjIH24526GPpQ6+1FKs
 BXZRpIHTzrIBDulehhxwjEmZ2f5TFdMRWiwph14bZbxRlhHHsM6T8L2S3hZvXDWH30F/9MmXNT4
 PtecjVDJZ9oO9LlzZyXuI9hef74HqIYyd3Yt2Nju4pE9+ttzM6CI8W6XL8vo+XiqHG/Iw18DFdF
 g3JsQdpjarglNPV2X7w==
X-Proofpoint-GUID: yCDbQ4GBg2c_01_tvTFdafVpSfOvrqQy
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a102974 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=mqvsnErzViNTL7-QoTgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: yCDbQ4GBg2c_01_tvTFdafVpSfOvrqQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36798-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE0E25B1A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The QRTR MHI transport driver does not coordinate with runtime PM, which
allows the underlying MHI controller to be runtime-suspended while
transmit, receive, or RX buffer refill operations are in progress. This can
lead to stalled transfers or failed buffer queueing once runtime PM is
enabled in the MHI core.

Add runtime PM reference counting around TX, RX, and buffer management
operations to keep the controller active for the duration of each critical
section. Enable runtime PM during probe and take explicit references around
these data path operations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 net/qrtr/mhi.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index 80e341d2f8a4..cba7a5daf7a4 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -6,6 +6,7 @@
 #include <linux/mhi.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 
@@ -38,11 +39,20 @@ static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
 	if (rc == -EINVAL)
 		dev_err(qdev->dev, "invalid ipcrouter packet\n");
 
+	rc = pm_runtime_get(&qdev->mhi_dev->dev);
+	if (rc < 0 && rc != -EINPROGRESS) {
+		dev_err(&mhi_dev->dev, "pm_runtime_get failed %d\n", rc);
+		pm_runtime_put_noidle(&qdev->mhi_dev->dev);
+		return;
+	}
+
 	/* Done with the buffer, now recycle it for future use */
 	rc = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, mhi_res->buf_addr,
 			   mhi_dev->mhi_cntrl->buffer_len, MHI_EOT);
 	if (rc)
 		dev_err(&mhi_dev->dev, "Failed to recycle the buffer: %d\n", rc);
+
+	pm_runtime_put(&mhi_dev->dev);
 }
 
 /* From QRTR to MHI */
@@ -54,6 +64,8 @@ static void qcom_mhi_qrtr_ul_callback(struct mhi_device *mhi_dev,
 	if (skb->sk)
 		sock_put(skb->sk);
 	consume_skb(skb);
+
+	pm_runtime_put(&mhi_dev->dev);
 }
 
 /* Send data over MHI */
@@ -69,13 +81,21 @@ static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
 	if (rc)
 		goto free_skb;
 
+	rc = pm_runtime_resume_and_get(&qdev->mhi_dev->dev);
+	if (rc) {
+		dev_err(&qdev->mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", rc);
+		goto free_skb;
+	}
+
 	rc = mhi_queue_skb(qdev->mhi_dev, DMA_TO_DEVICE, skb, skb->len,
 			   MHI_EOT);
 	if (rc)
-		goto free_skb;
+		goto runtime_put;
 
 	return rc;
 
+runtime_put:
+	pm_runtime_put(&qdev->mhi_dev->dev);
 free_skb:
 	if (skb->sk)
 		sock_put(skb->sk);
@@ -90,20 +110,30 @@ static int qcom_mhi_qrtr_queue_dl_buffers(struct mhi_device *mhi_dev)
 	void *buf;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (ret) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", ret);
+		return ret;
+	}
+
 	free_desc = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
 	while (free_desc--) {
 		buf = devm_kmalloc(&mhi_dev->dev, mhi_dev->mhi_cntrl->buffer_len, GFP_KERNEL);
-		if (!buf)
+		if (!buf) {
+			pm_runtime_put(&mhi_dev->dev);
 			return -ENOMEM;
+		}
 
 		ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, mhi_dev->mhi_cntrl->buffer_len,
 				    MHI_EOT);
 		if (ret) {
 			dev_err(&mhi_dev->dev, "Failed to queue buffer: %d\n", ret);
+			pm_runtime_put(&mhi_dev->dev);
 			return ret;
 		}
 	}
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 }
 
@@ -121,12 +151,22 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 	qdev->dev = &mhi_dev->dev;
 	qdev->ep.xmit = qcom_mhi_qrtr_send;
 
+	pm_runtime_no_callbacks(&mhi_dev->dev);
+	rc = devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
+	if (rc)
+		return rc;
+
+	rc = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (rc) {
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", rc);
+		return rc;
+	}
 	dev_set_drvdata(&mhi_dev->dev, qdev);
 
 	/* start channels */
 	rc = mhi_prepare_for_transfer(mhi_dev);
 	if (rc)
-		return rc;
+		goto runtime_put;
 
 	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
 	if (rc)
@@ -138,12 +178,15 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 
 	dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
 
+	pm_runtime_put(&mhi_dev->dev);
 	return 0;
 
 err_unregister:
 	qrtr_endpoint_unregister(&qdev->ep);
 err_unprepare:
 	mhi_unprepare_from_transfer(mhi_dev);
+runtime_put:
+	pm_runtime_put(&mhi_dev->dev);
 
 	return rc;
 }
@@ -151,10 +194,18 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 static void qcom_mhi_qrtr_remove(struct mhi_device *mhi_dev)
 {
 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
+	int err;
+
+	err = pm_runtime_resume_and_get(&mhi_dev->dev);
+	if (err)
+		dev_err(&mhi_dev->dev, "pm_runtime_resume_and_get failed %d\n", err);
 
 	qrtr_endpoint_unregister(&qdev->ep);
 	mhi_unprepare_from_transfer(mhi_dev);
 	dev_set_drvdata(&mhi_dev->dev, NULL);
+
+	if (!err)
+		pm_runtime_put(&mhi_dev->dev);
 }
 
 static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {

-- 
2.34.1


