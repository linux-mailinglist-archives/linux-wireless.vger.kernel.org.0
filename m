Return-Path: <linux-wireless+bounces-34968-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMuVDmbd42lrLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-34968-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 21:37:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E16834221BA
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2879302B53C
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90E02DF717;
	Sat, 18 Apr 2026 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bb0cWBk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E7PsAS9l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531682D2381
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776541025; cv=none; b=UptmyPHdD2zVzDPahc4CN6J0frnV2QSSD45SxxVYRy4u1l78+FSd+rJLL98yACVb/jDB+wo5mNmqAm7kZj/rK+PQJOArtws75F1h3i7+C2UXjTNciqkaXbvXpH/oGTYoNTn6G/ZsIy1mWhfWxLjuDsi2ujz/9en2jF5jKyyE3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776541025; c=relaxed/simple;
	bh=aDR9hNINvNxqpRZmj0QpzoMu3SykIFvwvCMbcZncM5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I8B8Gf2oYaaf0PrDWZFRKz+tcazb8YFRIvEP5avZkuiC+UbaETy19BPX9TDUxSl5a9JNpHxZTQi6P62KRDzqo4lev4gWiQxufWw65zl00LgCTnqtkAq/nIzDImQRhM/HadVZZksDAo2Y060qPt1UBBvXynC7ocuXLHXsufg8Jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bb0cWBk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E7PsAS9l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63I4UKkO296232
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 19:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w7Iwo5uHe5C9OO3L3JZKR1
	TUNA+oxWQTPxdODdb44PA=; b=Bb0cWBk0qN3EObrRaZwxLm2Sf8yrWmAImXsJg5
	sE3ZiQjYZ6uqlKKhL+8lR6tUkuvtWD2wRJnew9n49UowTtH/AHW1w9bYYN+2NjDq
	lSbng52fkYy5sUyhwJMtbC4MwVhBVObi4RWuSKihBqqyg720aC1V2+Wd9A5WvT8Z
	7lpACaK/bKHHDK6dozAs33REwKH54FARjA3tC58htmuczxU9pQew8cEQpsMwsswT
	z+VhaZQuqrclkMn7/39Ebl86s1FFlIfe7nX+w7M2iME/aB75y1LB1j2M37bBkAp9
	mdZeaZDyuS7jdq/aSmJhgXCdcoLndsfzrZHux6IYuBsLzouA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr1ga3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 19:37:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d984c74a8so41446781cf.1
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776541022; x=1777145822; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7Iwo5uHe5C9OO3L3JZKR1TUNA+oxWQTPxdODdb44PA=;
        b=E7PsAS9lHzLxhkzm1B2fg9f8ZoP1VYbEAReAoU3Zdum5esqzspReaIrJxZkDodyt+M
         BRwYQ/AOtEWSsHYCRZuvWZ57HQ1a0qY+8/3HZ9MXVmcuVeG+rdrLYot1XLx6ra/4wFEW
         0gP+o721nWMCYLyHt3370IjJL7iosxTrcda1vuO/Nfk9LA5KEzbakOBCsw1U2P/hWY7N
         w74M5pEZCM+ps9gaUpqWdrSj1vqLOlcb+ACTxfLxv1eT2YmqFeK2wI+R4eVm/HPCFgk8
         V40M5MPBoHER6J0NXroJac4EMTqI3ppH5vGhfrkW5hU38brmg8NmaAOWHwIgl0A072Ks
         JbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776541022; x=1777145822;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7Iwo5uHe5C9OO3L3JZKR1TUNA+oxWQTPxdODdb44PA=;
        b=rq04qVYc2KJHTqwHeQdcAiuJ3hSCnImQ+CwLvcvZa0YGH0u6tk4wA18n9cr4jXbB4T
         Eyb632wt5I8pGNQyIqHnFKhL8+w2rjX4vrNVlaZf92FH0+D1uUF2pzKZQZFSgvxx0dTE
         GhluhdL7B1QVZfl+NKeLxVdjuX3ofBS/ci6hhYDwPtkIYqqBJuN1TzpGbmO20WIWwJjz
         NcWh3r1iAL9Cya9E0/ffg7EWJYIL9952tEDvEvLb45KbE7n5Zibufy1nAYkeRuzwWihU
         BZd4FkitfRGFLx1xUQWTZXJRByAFGXieNzSJ3uX2FN+vi2D3Gtul2QnaMD96to5zeVkw
         xznw==
X-Forwarded-Encrypted: i=1; AFNElJ90bPAKRKujtlJhVHTnxBCVArDOAodVkRscnwyKnoqGOQWRoJPRw4dqCC6DOH81Zmd+VG02WjG2nERed6C3AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfE5kPErXKddbLNkLdliZ4NMJv21XxX468GnD1MZuRqcItg9X3
	mzuPdpZv2/vDIHahjPOUoO5eH6t6FuIn8gtVoV/diEHoojdGUv5dYaeOxqCsJdLyNYKKS7/eGZq
	QC/lBUYeWgO9QwTYzPjz3+Nurz8wZ8UQd5SN8sdqIM2gmY3OYB98XGkKtWwMmvI7OwWIMUg==
X-Gm-Gg: AeBDieu7vZRXd6Jz3ONuir6SFSk6WODRvLvrhzK5cISXSCWW4QCbAspjcOu3iiYbfLn
	4yHxpsX7KxB8DFIe7pZuJWewsfmlv87bwIIS6WeL3EBfmYT1WEB0SNXHv6kr4/RGW1Y+70BNF5R
	JYW+cQu7q9bupv0PAMDeB+VxwRgq8LdWAn09EKWGcxv5bgO6JNlo2AsKfdxIkDJPkW3PJyqgLmr
	TaXHzsGIu1BgfbkIEUYngmy3wTc28P/bo+oxPXTCWKz2kRcUQMcYyJh7WD35nT6R3pJ0vdHkV9V
	7X6eM2I+FevPPXfEkWfeOJP+gMZMuNRxCAuQTn0imIM7cEbP0tZxmvEhuiqZIb/xHQ1wvppEIxC
	oGphon/Le9ZIV26lhogvPhNp5JXvedrURXavapIsAUkwJX9+kJDrVOrxeed7mOj/+P5QYW59Vp5
	ZWf1tgRpYQWv5X6uhimcYk/hAskBw1UMgr5+nNNc+3f3k1IA==
X-Received: by 2002:a05:622a:199b:b0:50d:8d63:3899 with SMTP id d75a77b69052e-50e36b3d8bamr118926611cf.14.1776541022546;
        Sat, 18 Apr 2026 12:37:02 -0700 (PDT)
X-Received: by 2002:a05:622a:199b:b0:50d:8d63:3899 with SMTP id d75a77b69052e-50e36b3d8bamr118926161cf.14.1776541022093;
        Sat, 18 Apr 2026 12:37:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad143sm1586143e87.7.2026.04.18.12.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:37:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 22:37:00 +0300
Subject: [PATCH] wifi: ath10k: snoc: select POWER_SEQUENCING
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFvd42kC/yXMQQ6CMBBA0auQWTtJS0QbrmJcQDsjo0nBDiAJ6
 d0tunyL/3dQSkIKbbVDolVUxlhgTxX4oYsPQgnFUJv6Ys7WYTcP1rxQ4+hx+iSlNwbmhl3v7NU
 xlHBKxLL9prf737r0T/LzcYKcv101BdJ2AAAA
X-Change-ID: 20260418-ath10k-snoc-pwrseq-dff5f8b8178f
To: Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=aDR9hNINvNxqpRZmj0QpzoMu3SykIFvwvCMbcZncM5k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp491cGBWz3WfcTYyPvEr0U8zRHA0y55JdJWf2z
 jtgVYxnNdCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaePdXAAKCRCLPIo+Aiko
 1Z5ECACHXHx8lEt4Xus33W1KCWPew7OFmum6qixxBGoy7UOF/hkhVoWxVZfT/5g/BOOCtq7j47y
 cMh7Q+KsVxwc+7V4k6XEV81VCXI0Xg1lndP53px9UyywqKBeSSeIvKNuo8VuHS9EapoGkjbEA4x
 AEl8MtzASaZB7d4Hiiiy6HsWOlgWJz7vodXgQruhHeyKnc64y6zlBVf0lqcLJQ3VpGTYGeFdK/y
 OQikkFNpwagGqcKI8KmF5Z7/RTnCUyQo2BGLIOIqnO9LH8WTphXn/LGk/44itDc5bU8i6CouJ7v
 y9wypiCxVw0c+B3w1+xY0RTyRQG6Ba9owUG4qknh9xbZKPti
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE5NiBTYWx0ZWRfX62XSlGcGQY0H
 FX9x683/Qyy48wzHPvRQq/LQgW8N0L+G2SW082O9g7PHiZA8oidv2Q3iqIWnnXL2O/IDBmHONpI
 HYPyFBxVwFnt0m4Jl3LEylKIzz3QoxpbTWwu5MTmEh3SCFsamzFbBYqhCWTI2w+cBvz/8rYyfkN
 mDt8thI6Ao5WIB89+/DTo5+GlKI+AKOfBqXisBkWtR/Eioobwas+e1+xMV84d2yqJIvU1GKsSJm
 4bL/PN5B2ZJmVxv9Oq1Al0lsnkbo7pGzUS51FxlYpLRWnc0mpnGluw+LcQq5kzviINQ2at2IjD0
 E6Rp/5cir3gK8r16h7fmhCjleZ6DkgmugmuvMqIfMZrCtsVYhCncujfYKDssiDS/cxBW5vvAFC6
 13lnWzpaDes5rydaMtB1bVrPXBwe5vq5lDVgqaPJ0w3wt5kFGm/rHTBzFDwlcyWqsqT+IA5crvC
 OrNpd3j6Gqd+yUbubuA==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e3dd5f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=AUALJoc_gh5xkgD4DrgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: GvflXtem1QZF1w2olWgpWlSnYj-oNv4f
X-Proofpoint-GUID: GvflXtem1QZF1w2olWgpWlSnYj-oNv4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180196
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34968-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E16834221BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The commit afcf3ec615c9 ("wifi: ath10k: snoc: support powering on the
device via pwrseq") made ath10k SNOC driver use devm_pwrseq_get().
Select the corresponding Kconfig symbol to make sure that API call is
always available and doesn't return an error per se.

Fixes: afcf3ec615c9 ("wifi: ath10k: snoc: support powering on the device via pwrseq")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Closes: https://lore.kernel.org/r/DHUHU7UIT487.139L3KIVRVREU@fairphone.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index 876aed765833..efb9f022d8c6 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -46,6 +46,7 @@ config ATH10K_SNOC
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on QCOM_SMEM
 	depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=n
+	select POWER_SEQUENCING
 	select QCOM_SCM
 	select QCOM_QMI_HELPERS
 	help

---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260418-ath10k-snoc-pwrseq-dff5f8b8178f

Best regards,
--  
With best wishes
Dmitry


