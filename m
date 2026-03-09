Return-Path: <linux-wireless+bounces-32784-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO03EYJSr2lMUAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32784-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:06:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03957242842
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B18DD303EB8D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C238F943;
	Mon,  9 Mar 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EPv3YztV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NMD611H/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1B425CE6
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097555; cv=none; b=QM2de4zZ0Q+upEoWc8TM74fSfL+HgIljPMZYzy5ITO6cNqlV/rdhJO2mxKX9oBAKd+Uex1E9D6sUDRhuOsc/LxYgvkpeOlxHxTCeiNJBTJmRi2kxjB089HQxDCSZNKnvJdxdAZP4mlRwEj/8wQaA9/JiSeHcf09sS7scJsB+oAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097555; c=relaxed/simple;
	bh=BaDqkDWGu+XD1uojRzTNHydt5ix2dxjskfbmR4KTJ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxxd/FkznvB5h6c2oJJhZw/xQyURR5dEdGggh87cK4C4LHTz3SyMTH4Z8GZMjwdACfPIL4HfgV7lN84ypWLECbI4dQe6rTxNcn6Gs4zka6F7xoZG7kdrgnj5W+Cj31AVeflW8aW035VLQBtGhUp96eU4b4x9kYnyM0Zqm7BHmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EPv3YztV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NMD611H/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBpIK1297700
	for <linux-wireless@vger.kernel.org>; Mon, 9 Mar 2026 23:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=auzznPiIzKm
	n9bZWwZ9h7mLY2h3ZNHzFBrhGQFkkIvg=; b=EPv3YztVJ+FAUct0n2jY0AEZbxq
	N4yJ5ZDT1QeglA759UBVXPrEh3zXHp5Ray5s7pgfyA7mLlCX3AQyJdv4N0XHVz1V
	OZ9QVTI8oCqhTWzLM+cVUnCNq+4M5Yzl97VoxT6SmJnlYgveq6RE7m8Y0lU7CCcx
	k8Haf9d+4068xXR+NUlHuEi8Xqxp2N3uCUYTJneVk3O8E/tX30xB4TcMIxeqWoZ0
	JUFI6cMGgngrsXg/IZO2SB9y28JcPOBNpWnXBZTf8w6+yGT4I/WFdTaYfJcOf32Y
	WMB2yW2wjsiFRzhTaGFIC4a37N06tgo/lxuGc/eVVPmJ/AV+usj7OzLW6dg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv19nx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 23:05:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7774be64so1409953685a.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097553; x=1773702353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auzznPiIzKmn9bZWwZ9h7mLY2h3ZNHzFBrhGQFkkIvg=;
        b=NMD611H/h19jKpuLsVaSIEZmStieghkesArYWyGMCGWr5SFxYZngAP+FBROJe/lsSS
         K/adZlpKfn74TdinIBrHZIegYjsL/LU1xzbEqeNOJO+VF800E0Ko9v9fCbsvI3KKQJhn
         +F+gkU8beWD/RXhKXtAi7STEGjltqpOFs0uAZCL4QFObQFVzbKNV86yxc3Rp/wZNJx6l
         Zl8dGLD+82evulOHrsiy5GnDWGFlt3nlf/In8XAniBX6BexHUvyfErZHz6De0RZtHciz
         48kkU+3UA3qB+zqG9fCPxaWdDJTd87fGTjipMzRupo2yZf/hc0AcbfGeLv2sMbwmIduP
         GzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097553; x=1773702353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auzznPiIzKmn9bZWwZ9h7mLY2h3ZNHzFBrhGQFkkIvg=;
        b=ZwYqfrruh0FcQvbpu19XSweeeV5iTpD0EamEmaFeSNXF9WT1Kle782sBBE7lD2xynz
         kW406HKfQwga32OnFqYwHXgy+PEmo7clOqxiWRoDqYevMmjkR2nZSYsj01gCSXqA3Mxh
         AmlVEK6bYsDEMpTOmmH8VJJAb5mfO2KcoitdvYShijbSGlq4kPpsZMK02k05ckGHXqLu
         GwUaVHu0Qe+c6tcI/C7VkJC0kixFt7ZjB2yHx9Vb9D5poeVziALbulK4s16X3ayfBUhH
         0deRwLhi0aXQmPCnITnfJWpCGFXOe1Tu8mQ8KS6WFGIGrvSZyH/CSJhmg1lSJwkH6386
         hKHg==
X-Forwarded-Encrypted: i=1; AJvYcCWb3CtXMYhnpmJQiPTIPtlWzgbnQNG3V06csUVK6pzNJRRIrViMV2DEJ11wGF6l5O33MsIhS4nsL1hmocUHhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9odRDnskG1PHh+8J6x/2IzR95cDNB1zOGqBdQIvdG4Y8TUiiR
	4Na9i3QgMKCvtUa7IvaE9+4XcAFSqSXwJgDlRmodUmrFrcnYZc1LTNGK1IJwEcKY9r0sfEKU2BP
	Zj87ktYg98nN0Al2mQ/4qQ2EN0vf5gW4EjWPk7VAD/eKc2/OpynwL6GS3Wa8ThFT+bDSKtA==
X-Gm-Gg: ATEYQzzfJj7cuzeqkGclDGQ7pdtnzgCXuVb3tusWL8Tb6vYe8OPkX5Z5TMMlI8YqRdK
	2vmvcY12o39hksGhvcR/pWofFxSwq/+kUgxQ1N7gO82E4LBwP5WNiI5Hpbmr2+3dvQddX8DDEND
	NrR2NyHZxjYThZ14mrZOr68Goy9usVF+Y1ZNbW14p0kQHPJXBpn8rXq9bvu4Bm2qKU/QSnKOV1O
	F/pvv37oxyQBNx4qSjqdThCbJLs7PrvnoRA3kylnioAEMNJpMaoTUwMKYC9TxYOAasd7OdroNm1
	1ORUmcC144UHvzcpnyMd6l25lsz+ck+kT3pxVhXv3npeOlRHRzQUnABg+0CZr9BBiji4tMbYW4L
	jAOBVIM7hsJVXSrgQdQtuBUiuBIRHrrgAUf1SktqQT8ZGgPFJXg==
X-Received: by 2002:a05:620a:269a:b0:8c7:140a:7dbf with SMTP id af79cd13be357-8cd6d4fcc9amr1622779185a.77.1773097552997;
        Mon, 09 Mar 2026 16:05:52 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:8c7:140a:7dbf with SMTP id af79cd13be357-8cd6d4fcc9amr1622773385a.77.1773097552533;
        Mon, 09 Mar 2026 16:05:52 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:05:51 -0700 (PDT)
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
Subject: [PATCH v1 4/8] remoteproc: qcom: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:33 +0100
Message-ID: <20260309230346.3584252-5-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-GUID: B-onzzygGu2Q1elBnPZxKLqTkyuByVAd
X-Proofpoint-ORIG-GUID: B-onzzygGu2Q1elBnPZxKLqTkyuByVAd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfXz1NKIrUS66td
 EeW0dLHG1oCvgK/aj47TdkoVxwNAe9VKt7CHhWEvcKJUNGrV3magOc019cX2huFH6oUkRMxEVM/
 dGGhwtqZn/ZwtmeMGnzwFmXsj1DAp55fc3qExLu088NZjh3sEF49jP20ZnPxOl+I5/lR27sx3Df
 l9ifUOBPYDHgnIDY0ObfQLQAKrqaXNgGrd4EplOO3NZfhwZ/lbjgiTeMcjLKiG4Ltk7UicmzX64
 AoGPGuscwS9C3lcE6raxzATxRYn5oEVIyDlTzXLuI8RNUUU+Jmyx/0tp/F6Q1XEtNQFWwo1vjOc
 JgjNGXASI4J3JAhCkiW+advRc4vUdW2IaOL+Di3J/j0JZ/BL2oCh46ieBFQ0c/fDf01uKQ7rjSO
 sCCte308+CITNXZOqX7+puJa+76Y4TH9g9RWqHccHVlS+j+NtUjfFW0rsqdynGJWra2ow2Es01E
 gAxhF8YeKQUD33aYOiA==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69af5251 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=LIGoIQd8k4OXu6S84WYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: 03957242842
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32784-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
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
 drivers/remoteproc/qcom_sysmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index cf10e8ecfb8f..5bd4147f1f37 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -677,7 +677,7 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 		return ERR_PTR(ret);
 	}
 
-	qmi_add_lookup(&sysmon->qmi, 43, 0, 0);
+	qmi_add_lookup(&sysmon->qmi, QMI_SERVICE_ID_SSCTL, 0, 0);
 
 	sysmon->subdev.prepare = sysmon_prepare;
 	sysmon->subdev.start = sysmon_start;
-- 
2.43.0


