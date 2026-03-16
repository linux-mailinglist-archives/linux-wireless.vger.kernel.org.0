Return-Path: <linux-wireless+bounces-33306-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGOwAaA7uGmpagEAu9opvQ
	(envelope-from <linux-wireless+bounces-33306-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:19:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8329E036
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 885513065AC2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DF3D091A;
	Mon, 16 Mar 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DVsSgDcA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvDC9HYF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271C3CF697
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681282; cv=none; b=pBv8+dPc6t1IAqaBYCFl38a0tcK4F5hAdvK80z7fD2GycOzzmxzXZKe6tWM7ZdS4wBzNRfdgKwI57CuSK/L3Zf7cy6l0fO0bxFTnNrysQd5AAL2+2XxnpHXLrE9EaqUpa3J9hWqmSlXLBT/oDeowRFxvM7WQrZDcBrMLQDTIE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681282; c=relaxed/simple;
	bh=vBQ6tTOdMa9PYbW5txamAlvd10vFcBIuxy+lZseqTwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyvjPhnwZhTg3tLkVprQwDoQYxa4hyZCjBcHf1ChPcMtANRMD9WV9a0tjo1ImZAURmQAJiqYjtO7VSpY/f6decbcoAOS4zF7RAinh+SRXy/yyBG1SHvQeZBoHRXdQziHNLid1BefCdYGJK/tnco6KcKHi+bPTMUOkk8dVlJDSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DVsSgDcA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvDC9HYF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFMp1k2314567
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JbLYlc4Rhba
	fmIWJaPEz85qHfWanHtwL6D/B5T51hlU=; b=DVsSgDcAKCTmEeR7blNUSxx/K50
	JpPXUhCOYXuK+aOwWkb5J5g+nEO9VT5fBX+8A+kFJiHfFYkae5jwOYz5xd2CDh+W
	zWzlQF6DjO9E+VAB5xGOEffGRrA7NKQsskBhnMhFhHMWdfJuESNFY4Awjhn5BLE5
	Z4zTDfL76Z1zQIRWnvwqMMGyxsEC2N7hYOU/0dATVMbpUIp+jxJiDr9Hd4uYKEmz
	GM1CtzSl9SJFqEuMBjmcv/KQhuJd/ANnR1xDVCrhJZPGDbk/16T3S+JSiMEYhnpN
	l84P19B96VJeN03VrJOLe+/Mz7nd3Yh2LwAN5/yGySj9hWp5vN0XahRUwNA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxmf28e5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd83cfb36cso1453665485a.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773681280; x=1774286080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbLYlc4RhbafmIWJaPEz85qHfWanHtwL6D/B5T51hlU=;
        b=cvDC9HYFa9itb9N4t8ZKRqYhyJSuSSQDSGak0uu0Bw8CgK16aoUwpL3tm/PLKtL0dg
         vgeib2Z+fSgrHi10uZoFsCglEc4C+nxuGUzx9W0eikP/poHS4hkDxXJ04qRgS9ShZ9Si
         g8uiT2YNun+E7Xw4ieayY7kdDaupYco3IMY0fMQoTNM9uUOpKdwL5MtWX5m91f0XWAj5
         /bhbZhri3J9D0TQ4MeobXSe/U1r/hjlM12JWm3LLqgxwMbypWjwHGMerZVLzsE7kX7Zl
         mh4ylxrwAM/+EthqFmBmLixkWB5fArz/WILuGeu72MjTpO4c1f+n2K7ylBi+qYeBlUT+
         1y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681280; x=1774286080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbLYlc4RhbafmIWJaPEz85qHfWanHtwL6D/B5T51hlU=;
        b=DKVeTuSQC01NxQNGuiVXuIs67EVFJehAR/V07ultRSGvo1ujVjPLr1ZKO3odZoJdUi
         EahtmoCJNo3SZ4FDocgU92CfZQwc5/4R86PMdR2ddEriuo9W0/eSTuA5Y5PzkCcY5I0L
         Qw9IOsLNwGTPA3Tt7IE0oMIm4x9p4TH8P4816VwwZQHFWg1Q4P/RjV9ZK0U7LL0fRiH5
         yJqt6yONJbyrnuEWxhx7rxCfuFoDhkjizoRhfcqqvMD1L7WVzdLWJW511nwsFHkw2the
         4Idf0hrhb7YyOP1ZFVPaRxc6+KmmHAj8w+bq/RQwJUHt5oOz8Yu01rDp4eF9jdvdL0OK
         0zdg==
X-Forwarded-Encrypted: i=1; AJvYcCXBryZfrWVo0ZtF6qXY+qnUT4roTbGj1TadBac9+GwpXU3WS1/BOKjCTP0whla4oBre2fp668xR1euG11im/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF67bBOQeKCKWwzPj2t6AB8RFFODrW7bGJzz/5iOBeB6T9NKst
	YvSwUQeN2uoX5NYt7tyOF1sRInJsSeXglgvn73caoYW0M4geY6tK0v+YxDN4cvgD/TkD8cKZm6G
	jLWRobI+Svqffw9KjVPUknVM308/Hg+lgAABQU5hAp+s3df+GE6UZIfampPIYkDWuGPXp7g==
X-Gm-Gg: ATEYQzy1kaE884f/w7IOTcx9pEjipQqiyb4beluf3khGGV+eAD3gcXSvAd+wYVhkapI
	wUQN7JaqrUGQehsu1QqKeqJPCgwKvRPAT7n5tWJZVgoFE+4xsTAweKQB+1QStFfVt4Qt8jsnZy/
	tyaG2miEqod4Gwhbg20CLYa4hpGGXFauWM085Qw8NlqMgDt53ct2u40dV0TGdeIF1N3IbA768j1
	lejsbpD74L3c9/5RVkpVdAU7SKKZYIcvcZHa6MJgbtESKvBPZm/352wiZlsRsamvxhfeqs2ie9E
	ZFDb3etjSEwZXQ0KgUScuqPHNUHkv8fxHYqR5seK3kdvn0NJ3FAvEygPsLXpa6ltA7TNcYmINLe
	NfjNFepYr2yxpwrRHFNLMN0ldVFeOvl5P8VKj5w2vhvzvTbXliA==
X-Received: by 2002:a05:620a:470c:b0:8cd:b2cd:10a2 with SMTP id af79cd13be357-8cdb5b4d4ebmr1859178385a.49.1773681279625;
        Mon, 16 Mar 2026 10:14:39 -0700 (PDT)
X-Received: by 2002:a05:620a:470c:b0:8cd:b2cd:10a2 with SMTP id af79cd13be357-8cdb5b4d4ebmr1859171685a.49.1773681279092;
        Mon, 16 Mar 2026 10:14:39 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm43860993f8f.20.2026.03.16.10.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:14:38 -0700 (PDT)
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
Subject: [PATCH v2 1/4] net: ipa: Use the unified QMI service ID instead of defining it locally
Date: Mon, 16 Mar 2026 18:14:11 +0100
Message-ID: <20260316171419.2619620-2-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 0TMDGfhaVPDsFMPqu8wQ6_Di9sFVFwPI
X-Proofpoint-GUID: 0TMDGfhaVPDsFMPqu8wQ6_Di9sFVFwPI
X-Authority-Analysis: v=2.4 cv=FvcIPmrq c=1 sm=1 tr=0 ts=69b83a80 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=shTvKy1OFHrmHVGPjj8A:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfXyVLWIB2uH+kd
 W8FptJDBF/0iWiNQ5O8mihlwX8Q0w/ottCWsY6B5W189ppglupVRXG8vhoWXStfErCQZnrQ3+NZ
 TAMuGApOZlb0qvC+PWoHrulKNJGy39Um3iB3ejDzu8ICug7YmVCUzYLaN1qed/fRYt+XzcOtp6M
 20HGqPXzyIdH0ECNa0fjv1iT6T0+prYJjbzmrFq2JgJfllr7mKIY3arGw3lNFtMd9ja+Hj6d6aN
 iI3nmLJVI8NfQSKDCpcH2HOssCbtBtaMH0RiUjG+TpQT7/2oQmg4h0YSVrOiMlHxzVb5Bz8SzDJ
 oee+fkP2WTsoMt2/acRDCMDm7UvTd+ksTns1c3EslPtmPkQCA9HKLaz22nJ1gB/ukitQajLw5Fu
 5lywQoWA52saNMJPX2FKWGJeHGybtmiL/oweqKfoYZV7bBm/ax6Rg7byLDj/moIhYTzDN08a62D
 ovPlg9girQ1AzCS5/aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160133
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
	TAGGED_FROM(0.00)[bounces-33306-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0A8329E036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of defining a local macro with a custom name for the QMI
service identifier, use the one provided in qmi.h and remove the
locally defined macro.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/net/ipa/ipa_qmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
index d771f3a71f94..37936ad132a2 100644
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -66,11 +66,9 @@
  *   determination of when things are "ready"
  */
 
-#define IPA_HOST_SERVICE_SVC_ID		0x31
 #define IPA_HOST_SVC_VERS		1
 #define IPA_HOST_SERVICE_INS_ID		1
 
-#define IPA_MODEM_SERVICE_SVC_ID	0x31
 #define IPA_MODEM_SERVICE_INS_ID	2
 #define IPA_MODEM_SVC_VERS		1
 
@@ -484,7 +482,7 @@ int ipa_qmi_setup(struct ipa *ipa)
 	if (ret)
 		return ret;
 
-	ret = qmi_add_server(&ipa_qmi->server_handle, IPA_HOST_SERVICE_SVC_ID,
+	ret = qmi_add_server(&ipa_qmi->server_handle, QMI_SERVICE_ID_IPA,
 			     IPA_HOST_SVC_VERS, IPA_HOST_SERVICE_INS_ID);
 	if (ret)
 		goto err_server_handle_release;
@@ -501,7 +499,7 @@ int ipa_qmi_setup(struct ipa *ipa)
 	/* We need this ready before the service lookup is added */
 	INIT_WORK(&ipa_qmi->init_driver_work, ipa_client_init_driver_work);
 
-	ret = qmi_add_lookup(&ipa_qmi->client_handle, IPA_MODEM_SERVICE_SVC_ID,
+	ret = qmi_add_lookup(&ipa_qmi->client_handle, QMI_SERVICE_ID_IPA,
 			     IPA_MODEM_SVC_VERS, IPA_MODEM_SERVICE_INS_ID);
 	if (ret)
 		goto err_client_handle_release;
-- 
2.43.0


