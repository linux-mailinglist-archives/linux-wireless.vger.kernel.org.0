Return-Path: <linux-wireless+bounces-33309-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBEhN0o8uGmpagEAu9opvQ
	(envelope-from <linux-wireless+bounces-33309-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:22:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9753429E11C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 389813088717
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CDF3D3D04;
	Mon, 16 Mar 2026 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfegwWmK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ewxQnOCL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261C3D091A
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681292; cv=none; b=MmhfT4jKgvflkdF0L2fofjH4VeTRBhreNpqWYvYy2vsjGl2MSJxLLarnnR838xiUPqxtsNM5hQcSivJ2UoNMBlCYvHCy8g+zsrO+rmH99AlDjNC7gxLLyDE/bs5y+C5VJbAVvA/ER1qsjHr7l9wcd8kr1UQhgXcRC1wmlHT2hTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681292; c=relaxed/simple;
	bh=HtFIHBv2fwd3CfESxvQmQ/xugQw0YlUT46/6770djq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unAMUlbWKm6swvk3qXMSlFm/r+qXLtoTZ7oE/DNv/8Rir74vkf65SGF+6ENfNHRZ13vqaGB/IEVHrXcRsg3dpfh0OswjyJ3i7kV63gZqc3tDCybXslrpsmFUxJ7w61XOvEBwMlgP8gN3rMoKE4RtEmszHi2Bqx4owEBmqs8UL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kfegwWmK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ewxQnOCL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GGA1F23124533
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZoAGvqbvmk8
	WgSq3LDSsC0+/Kn2gQStwEGDclAd8WF8=; b=kfegwWmK+oeYWJpckng+sZks14U
	rsp48Lfzham+N65Zre+9ESiRr5oysAv2RkJYK7Y+U1U3MM/CnD8fkCkDZkAOrGUW
	Hpx6CYpG+On9figKHVPAr45yictYQnhXhAUrutjya7i9Xr31yLY/RKA6S+hzO5ZA
	tVsYisIr+HoXh9INI1/BlXHpPS0mSWQneF1qU4EmtOOvJVzdC5r7dKj1v6MmYSNe
	MiNWiBBVxfLFnBIb40R0DteoqRIwA7azcqxzpQp9Jw3OycFuhBKR6sDy8FoVAiun
	FX7nQKMr8eGtigtM96RpSP4VoX/itwoVqd0fo0XuZ0vROwJT3T3e8omsNSg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxfsmhkgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd81506677so3101418585a.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773681289; x=1774286089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoAGvqbvmk8WgSq3LDSsC0+/Kn2gQStwEGDclAd8WF8=;
        b=ewxQnOCLd2STVMDUb82XtgHi5yW+EPxLZ5lUpZ92ms51CuK5/5RD64dhOyZr3pvbyz
         +Qj96wSS+WafM7BPVTV3BRW/2ClOaaTQXWdbzLdnLRziEcuxIw0CRuSzdHnYaQxe3R6T
         3PVkf0vNVEJOY/eM3TXT6W+FIQINzh+JBi8w0Gm2qAvtQ5y3N7oYZTtQdE8tkH7wZ9NL
         /acwmtVCNC1MALsT4AAc3ecNThRkUzdNvgMRwSfjgh4vz8I/yZ7FsD09EGpmg1GKFyLV
         Oyrkyxb1MCgQVEC/tIJZFi+y6dCftuYXxe0aqc9zj9QsLEBYVtCSJIFKr1Wa2UBEx3Hz
         UElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681289; x=1774286089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZoAGvqbvmk8WgSq3LDSsC0+/Kn2gQStwEGDclAd8WF8=;
        b=QSSnAjW/lyxoQpgFJxmLEMBBDnHWgBbvmw4CDKRzjh2QzsGrrRw2rvB/eLBtCpPIiu
         WQgr4pf3phQE5y8JiHT+epm5TngC2N9W+kHZ1CpDnjdeJcmSdSDP01pP/1exT7A08gHw
         lVjN72zYWtiyvQSVgxz6arLrxfBJfnYcf7EQnSz3szXbxdlKWHGSebfPTqCc5wvoKEwW
         0eUzc3Tez9nHtCgCsE2TUlpq5uBiVXGQroCVL/u9IabT2lxK9NCYfklxE8xl3WGVuOO/
         RTcud0MfMiG8VDzEU2F8TdAPN3MT555+z/ioH4SgBG4s8U5Pen8RQZ62fvD2/G95HKMX
         Ub+w==
X-Forwarded-Encrypted: i=1; AJvYcCWJQF7USB2Xk70VASS3zbh0gf1a5Drcj0cYOK2JtDMtwkiXN0E1q/QfF0eButd2k1y4rsDnxQRGCP3iwpMdHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnPjRErdeSvlnGXJ/RFV45EtbU69+FyBC9aK3wZIDeZP82o4e
	dhy/uB09wLQ25VzkBsAYDPF6KSW2AgxGDMKZndMvB0LWQn72hMma0Ak5jYnbyKgftiEoN3lndiW
	1Joatw3my8+qqlW8YvLEkdsfMQkbkghiRgYTclBeqw953utKarRUgM+lw6Nx6i3jQXy0/JQ==
X-Gm-Gg: ATEYQzypGNEIMho2GR3tzS4Uny3p0wTC8IdxSgz+0b6FaTHmUw2hpxM5lmFIySkwsgL
	d6+e5SL7RC580eWcBwfMdnF1LoE4qqyqLObFfEpOiibd0zMnHwMcY0K0LI+3kje2jNpjBn69Txu
	Nf8R4TEx+oZ9V8ANMzfjxShOOh7MFdETcXXHgXrgquIeepl/Dhb+hOGfrqIV732EKOrsXMh2Kkg
	eYxV6Pf0R/flYRMPHpHiEUf1LQLBqofszD/j6iU+W1WTa7jn+ans20GWwg/kNg1FcIP6eCVR7vU
	H6hPj66qD6IFAMYUAUvniiX+N+ntFoJCQEoZW8vLzGVn3WUNtggco1nc57updID7Fom1scJGurw
	kjaD5sgBneVx/VD9i6JwMgl9Hq7hGh5wtLG5T4v2VH7t51Fe3Lw==
X-Received: by 2002:a05:620a:4d5:b0:8cd:b626:cdf1 with SMTP id af79cd13be357-8cdb626d117mr1319005285a.46.1773681289379;
        Mon, 16 Mar 2026 10:14:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4d5:b0:8cd:b626:cdf1 with SMTP id af79cd13be357-8cdb626d117mr1318998385a.46.1773681288653;
        Mon, 16 Mar 2026 10:14:48 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm43860993f8f.20.2026.03.16.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:14:47 -0700 (PDT)
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
        linux-sound@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 4/4] ALSA: usb-audio: qcom: Use the unified QMI service ID instead of defining it locally
Date: Mon, 16 Mar 2026 18:14:14 +0100
Message-ID: <20260316171419.2619620-5-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfX0pKCtmynQtsD
 JCG9AJlUbWVWPNmZxQ0zi0TXnd6r8uzlkGs2HE0j7JfUBZzGrHFYIleupmmkbcGoXuC+yR0MalO
 T32xBkAI5iqSJUqDfvai0zvwI5KIaNqjr1BJIgTyiBEEa0EGY9joZi+ggmqCB1Sf5XfU5SaA+pl
 T2hiKbi8QShSWFzvKlYmcsjAF3HeC3CAIdDfsOjZB+Zv+B6o7ya6yPonE2d43mR5X1nQ2AsF9E9
 F5Cu20UCC27SHZWE9crW9xcQ1NUq4kUjETqMRcJUjQQKcl6kascmldTyXPewJgxPssImdbcMuJp
 p7HoOomhBfa/y583BjHtZki8k19sLyEyw9m6f8QF4hl2rVy8jri6CxkGW9n0Hw3rfVyQ/Nraayw
 0+SvcThrXHJOg5omdampPM+z7KTKuNyi6wOJX1xjT0R6QtpPWLdHCAm42cgBXctdfuLry/TuZDq
 qBKLdFat0D1VUKew1RQ==
X-Proofpoint-GUID: ZYgEv6Brvd6h1vLZ8NivoFNnnyXdoeWY
X-Authority-Analysis: v=2.4 cv=V/hwEOni c=1 sm=1 tr=0 ts=69b83a8a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=GLuZV9TbpKr0kWuSc8UA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ZYgEv6Brvd6h1vLZ8NivoFNnnyXdoeWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160133
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33309-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9753429E11C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 sound/usb/qcom/qc_audio_offload.c  | 2 +-
 sound/usb/qcom/usb_audio_qmi_v01.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 01e6063c2207..38d36397bb40 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1927,7 +1927,7 @@ static int qc_usb_audio_probe(struct auxiliary_device *auxdev,
 			      QMI_UAUDIO_STREAM_REQ_MSG_V01_MAX_MSG_LEN,
 			      &uaudio_svc_ops_options,
 			      &uaudio_stream_req_handlers);
-	ret = qmi_add_server(svc->uaudio_svc_hdl, UAUDIO_STREAM_SERVICE_ID_V01,
+	ret = qmi_add_server(svc->uaudio_svc_hdl, QMI_SERVICE_ID_USB_AUDIO_STREAM,
 			     UAUDIO_STREAM_SERVICE_VERS_V01, 0);
 
 	uaudio_svc = svc;
diff --git a/sound/usb/qcom/usb_audio_qmi_v01.h b/sound/usb/qcom/usb_audio_qmi_v01.h
index a1298d75d9f8..c7eee03225ec 100644
--- a/sound/usb/qcom/usb_audio_qmi_v01.h
+++ b/sound/usb/qcom/usb_audio_qmi_v01.h
@@ -6,7 +6,6 @@
 #ifndef USB_QMI_V01_H
 #define USB_QMI_V01_H
 
-#define UAUDIO_STREAM_SERVICE_ID_V01 0x41D
 #define UAUDIO_STREAM_SERVICE_VERS_V01 0x01
 
 #define QMI_UAUDIO_STREAM_RESP_V01 0x0001
-- 
2.43.0


