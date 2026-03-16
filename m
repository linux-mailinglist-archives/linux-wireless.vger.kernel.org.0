Return-Path: <linux-wireless+bounces-33308-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEL6F/c7uGmpagEAu9opvQ
	(envelope-from <linux-wireless+bounces-33308-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:20:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C0029E0C7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 429C130764B2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022F3D3301;
	Mon, 16 Mar 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3DU6dl3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrqvfI+8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22A3D1707
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681286; cv=none; b=sWMw3U+bV9/gtcS+V97eSfv1rOLOZCABYCO/I8pv4eeG1oD+9DSdF5k/W7G2KChaYAdS1a3crWT4cJLeWlVjWsL/oQrD49Q5Cf/dBlPKZQdD+OlE4tyee5ttko/e0XjwjsksVh7k94RVDzF7ggkk2Jcu+xh+NvfprJmi6eTuS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681286; c=relaxed/simple;
	bh=UocqjRyfFzM84DjFYioQo6kEjdPifFN5KCFxnX+Mtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu0KrSet16gHXlBsg4b+u32cZbsVrdWrt4TSirLfyG1HxUMvBeMVV4lxS382ziacnYcXnq9z9C0Hil7bxszYTUpWj4G6O3WNR9Ju1GkNkjIuO2fuAfi7qxber1/QxYkxdmWVKmf2NJaQdRwANsjZcWIsmlW6ZKwgvyYdykMsGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3DU6dl3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrqvfI+8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GECUH41639416
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WFXy8rqV6ZJ
	yXTmDCC1XrXB5vrLD+ozr+xme7NcdKiQ=; b=P3DU6dl3c9C+mKOoFj8fLnflTRc
	E4S7OufGIBneH7YqP+NWIVKQr0JamAB0ccP/h1Fu1YGnyp4csg0npjgoFeixW8JR
	Vxl/OXVJfgmTwzF4Vn7J2fQ1stksLuZyNanswJjCeX+tEvcw4wn+3J9ef+QTeG1n
	nsaaszMiZ/kCXgERsFktG+NFb0XemxxH757PA/JfVm3NnNUUQzrGnDx49KGDygK7
	pFlzs5B2WwtrEU11sYGr3Wy7XXdUOW1/NAVcRbrPi0lKxckc1uUQdMkQ34QJ+ljV
	4HrjH64gyE1cItzRHI72edpT4EBGjx60xlN9Izp4/hJP4ItIfIEv51VQ86g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke08pvy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb6291d95aso5381460485a.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773681283; x=1774286083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFXy8rqV6ZJyXTmDCC1XrXB5vrLD+ozr+xme7NcdKiQ=;
        b=NrqvfI+8EHRd+MVD032RWKR2d12VgpuKL0Oqd8RkWQ1N3C9JTANmVroK70M8+0/5Oj
         UdT6yk8N+cfZUkfq6S6R63zOLGOe+1THxBqMTKkmmHhx8Vt9jpMOR7KrW6Zy8mj28nNj
         Qffy16hAr4shMxnIXDgrvmOU1QXptyiaCfAZPP+GsXMc7CN4OfufezD+8WrkeYNLBesK
         oLv7RxmZLhX1y2B+9whenBjnhkoS7n8WQlTsq/3KlN0likuiOvykEDn4sWBRIpzcebsf
         E+XXGp3hKBfavX5GT7pPjfe2iRXfrFTuSLnzaaKLiMqIoD3k1Xk1B5PuExL2W47Bap6j
         +/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681283; x=1774286083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFXy8rqV6ZJyXTmDCC1XrXB5vrLD+ozr+xme7NcdKiQ=;
        b=mlMLl2u4XD375ct8bUgtniCZgzbtIQH6xpWXjNJMg3FvdSUVG28t8B6EhM+TVHiYx2
         5SBf3i8VWbgcYXhOGY7914LzLYyBAPViFPP6+84nqnScDZkLh9wiYODBlkbrCd5xTIzL
         BFwwgE0U2dvig8tMwhKgcooBeYMEBOUjIFzT49meC+wzxFbKU6OGwSVMKLJw+nZ1MawS
         upPR14sY7C+UDhEAwsvCvNBO8GDIYhFnlAQfPE1sSyDuHRPYzYKN17VzVg0LrMLblJMX
         Ix3KBg8nD56ix3BZocPoozmz7ojdpV3w56nr7e763EzKnKtwIlDhoDv0mDsNiOFRmlg7
         I4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWmPOZw3xbeMEKA8n4pPuS4OeRZeHDfy+bJi0XzvM9M9IB+5U2nMwEzCcZHicipBmBtNNhpuwaNUgcv9GaMVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvJ3ysTtJBV8qB7JtgQeH4ar0S8Z0T5I0/9YlNeI/hntfBPXr
	l4hFSZfuxt0nLF4AeoVsb/NNw9HCx7pXD6ShAtLvYJ1hz3zi/ImPHCjcPybIW5FQkUeHurUSAg5
	wrqfcd7VH3suA75jpcnlaI4rSQ4edbCu21JcZepcuV+HpG2C9WoM77X2XS1gEIHVbsZlvFg==
X-Gm-Gg: ATEYQzxuP8qVD5SrZxUJlciUC4gXWQl0U/l0g6ovVgIACCBXuiIu964lnkH0m2L+qfG
	AlkwKlb2o2hBxu4xWlIzEbTTADOimxGPY265SbjbJAgyB7NPVf7YtQR8XlZy/oh5IXOPKbanG4C
	LypcNP39zTFJ0bxrorNHuqnmYoJIdDA8Ju+Cj3nR3TCN3lWGVaTH9VANJGtbAiO23WZIklHn53S
	R2Qw/msNHbST/aTeD5S22LAyVBZNDP2Khq0CC+OygZiaEd+ig1YnTTP2lSN4RcgcPXl3p6KfysP
	AzJaFIFly76f5SRhE2P1VK8N9WxvNBJndt+TMqZI70idh6LNjdt2feChZzJYzxHj76b9l1hYN5e
	1J7wXYLDmxmzMVam4QFb/eRuv8VFNP5WCZ+ODBBRFr6cT4h+5fA==
X-Received: by 2002:a05:620a:711a:b0:8cd:b3da:5b5b with SMTP id af79cd13be357-8cdb5a4b098mr1839479585a.10.1773681283387;
        Mon, 16 Mar 2026 10:14:43 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:8cd:b3da:5b5b with SMTP id af79cd13be357-8cdb5a4b098mr1839472185a.10.1773681282736;
        Mon, 16 Mar 2026 10:14:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm43860993f8f.20.2026.03.16.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:14:41 -0700 (PDT)
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 3/4] slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of defining it locally
Date: Mon, 16 Mar 2026 18:14:13 +0100
Message-ID: <20260316171419.2619620-4-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: gy_Dn7uiftrcorLZX4IsWHv7ETayAQDz
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b83a84 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=PhtMypRRY1SmXJO8NnMA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfX+FLZnpkB/o8t
 r4Ge/QL9ov6Yzc8fmpExZ8PAAY5cL14w2n/pj7AyzBtw203V2+zzdy5XLNjoQ8jABZs/x5CAeLt
 fitwbG/mdxZTwuISqPCtS9QUKo7drv+g4ogzDlWWGQNyOKbmiwyACCLoScz+C5E8sx/qRFve5m5
 JIWK+bq9Kn9X6XaxFpYP2T1BhIjA3b1LBbmiO9LrB6mzaMOfYJ7/BDpF6QOZaQV9zrWEO0IH7D9
 E033rVbOnCLdqnFf9gRVQVfCwUL6mcfKjktk3XEsAqkqPwrjAlvNNcJvX0HkL/Xz27BAgQbWQ7i
 H++qJrXgQ9uEIudVEqK7xfBB/vBjZCCOpNhYgrKYPmxCqRforLQD9bGPXCmKzxrtdNNHItO5zwZ
 3aghXAFsuiGyFNsSI3GDHUxrucSun7UFIVQX3J6jM+AMLAVF5Z24aOCWpdlL0Ut7KQYAai4x+06
 CHbJj3lJjLoB7UIVlXg==
X-Proofpoint-GUID: gy_Dn7uiftrcorLZX4IsWHv7ETayAQDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160133
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
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33308-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: D3C0029E0C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 9aa7218b4e8d..0b88b8577bdb 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -48,7 +48,6 @@
 				NGD_INT_RX_MSG_RCVD)
 
 /* Slimbus QMI service */
-#define SLIMBUS_QMI_SVC_ID	0x0301
 #define SLIMBUS_QMI_SVC_V1	1
 #define SLIMBUS_QMI_INS_ID	0
 #define SLIMBUS_QMI_SELECT_INSTANCE_REQ_V01	0x0020
@@ -1408,8 +1407,8 @@ static int qcom_slim_ngd_qmi_svc_event_init(struct qcom_slim_ngd_ctrl *ctrl)
 		return ret;
 	}
 
-	ret = qmi_add_lookup(&qmi->svc_event_hdl, SLIMBUS_QMI_SVC_ID,
-			SLIMBUS_QMI_SVC_V1, SLIMBUS_QMI_INS_ID);
+	ret = qmi_add_lookup(&qmi->svc_event_hdl, QMI_SERVICE_ID_SLIMBUS,
+			     SLIMBUS_QMI_SVC_V1, SLIMBUS_QMI_INS_ID);
 	if (ret < 0) {
 		dev_err(ctrl->dev, "qmi_add_lookup failed: %d\n", ret);
 		qmi_handle_release(&qmi->svc_event_hdl);
-- 
2.43.0


