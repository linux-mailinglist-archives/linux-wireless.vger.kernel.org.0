Return-Path: <linux-wireless+bounces-32782-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KWSBp9Sr2lMUAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32782-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:07:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B691D242866
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6FC30FF0F3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 23:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D53BA24D;
	Mon,  9 Mar 2026 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBfD8/ns";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LRXwQU+a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EA426687
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097552; cv=none; b=l6H7RjOAvy+mFSfiZvdf7soecv8QDNZ8GhSLXZ35uDY3D3hj+VqOsE/rPKqps4aViu2j8qEK/7vHju7yQHslvORPQlFf2DESaFkusimNOUSBZp9J9ezgKthhzs2mD3PuOgEdzrnigdLeKxnXOj87FrA6NkQZi2Hx/fmvCRtCBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097552; c=relaxed/simple;
	bh=zL69uAdweI4X0y0Z+IAisT4rMg++38nfIAzKDgVfeho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqoJH//ta7nmqj48118Rwd2PHf8Lq0PHGoHlBx0FAdy2axyaP3YAo1eI6HxRGzCv6k1Qo+hW3+BPq/iom7fRooq1Zq4CidVbTYQaAvUfweZsTKCyCI81duza+HbK/FI/mKazGiEEIDY40hDWfuk3dCok5DZNM8md5qLVy6lj2is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBfD8/ns; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LRXwQU+a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBn4Z1203506
	for <linux-wireless@vger.kernel.org>; Mon, 9 Mar 2026 23:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PTfKdHxXDsD
	Bf9qbtcJy20RFKCKAaUi+C0QbWC3j2OY=; b=lBfD8/nsjfep7uWpNTtXTTH97LP
	adqHrnvrTVmVgz0lWbAL5VcrdHrI4FRTSXkiz+u1QcKmurgn/d88hHz/4iBBAoj+
	SgF0dP66UX7GP3KqmHq4FBR51A54fIi9wNxDZIo/awWFssBbLgEaNe0j8xL0eSu4
	6ohLKXiqBj9NRM3ztv9YLcdyDch7tWK3LyfdOBKXfoqDRIixooDyqouwjHgLJuOl
	Z4pMUTPjrfg3DUOyVZm3GPKNXh9IR5fH1JW8M+0dXX3xAhqbHxUTvP+UD3hMdiGU
	wmJYD7HdlW4rfeiSqQS1ja79m2ZdhWjJOgTQi0iWoF0sex2KenSTQG+ihSQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct0329n2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 23:05:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7de0e161so1264070585a.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097550; x=1773702350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTfKdHxXDsDBf9qbtcJy20RFKCKAaUi+C0QbWC3j2OY=;
        b=LRXwQU+ahVItUcd7XgXpLBKk5T4a+a5v6R6I4NCx63YBkMPsfSObF81oTrOp9iicyx
         EX5IYkV1xt3/rq6xrlSZKL1xf8Wt/x+iM+Aj2DALp1I0Dj+s1gTq0P9teJ6Qv6BiPEjt
         dgDHeQOLJnZIhSpmp2laI7BsJNlEW1f59plbJiL5roVffGTQvRPrb8vo1wkmrVzk2z8v
         RVE1UHlvuz73x7lVpOHZKmMQHJMZ8b/HuoKyWLA0poACviJINMqGokaD9KgCDuhdoQx8
         LFQFG4C9GJTMj1yek+rSh1WcZrZSg/GSn5mqePkPpMAH228P8j4IdekoA1JA4qaNeaPi
         iQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097550; x=1773702350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTfKdHxXDsDBf9qbtcJy20RFKCKAaUi+C0QbWC3j2OY=;
        b=OaBwVppNBio4fKNZCybNMaOhrE3CKOfkY+cytVnfsV1rWOXGf/34JY1IyNscL4n1JT
         LA6oMQfB6iqASuE38/lpFhPASiv5bCdjQ+i9UvEmbr37zer8rNrkMQ3fvSxyg1WQz7pI
         rdMhkjK9QbGa03AD971ZMDNpeTw12ooDAdzYpAlrI5Jl+jMs2bEp6CunFTXRHzjgWsBK
         uQJnLKJ9m9upsa10XGjuJrrDCRfvwucj6jEdpqOPBUrwnfZK4qkTqv8udLq0yaS4NdmM
         P/2EnwQs5PkNWc/EWxctPYCKMiPrBqjC3VInio2dVpDQKd/zxMkunlJSpmHpCVMz8zlR
         Vt5g==
X-Forwarded-Encrypted: i=1; AJvYcCUT6a9yPssuL2EiJbVZD6NQyskVU0ejdXATdUmYc9V2HXyXJWbQIef/xUPBLaSv4NIB7jtZYEnUC1p0Rl9H0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcbEk1+U3v2Yj0UnAePylMRIiC6sPU1DwbGTQ56yV2pP2CVWi
	KQ68DftZvb9StkyCKbl63mjDEUIdd2ea3pvzi56z9N8xflKzLPbUm1X3C3kxBPLaPAkMnn7/4t3
	KBzkBQMiME+EakkspR/2iTNgNnC+XilSBmwzyzLDkGyJaXNeHH4QfzjAaO9Q7PtMH+d5LqA==
X-Gm-Gg: ATEYQzwKQg0WwX8cXAYpklqL9jMaDsrVHC/MnUywYm9IV9kJB/T6MhRot2mH5HAIvRM
	ISikv/LMsZttEIeDQGr5JrkzzoQPB0mQDTQ5GSjzOFTPYc21OYxGvG5jzeuqLbxT98bYl68d4mh
	PfB+X5/HzXXY0rC3WA92+EsJvmJ7pg3GfrdsZEr90Eu4G7JxnJyuFKvCuXqDex3yG4iNqEw9X9g
	Qpe/d3FZxflU5h40aiSbHTm3iGQxdd8N5s1MnkC6rYnCSO93jPwG4pBFjU509oZMJEpqwcr17Nk
	HF2U2GTGHTV9e8qt0S6LRulItwQsk2QYsT+TNfpcd0vUIl/Kuf/kNVfpr6jGyGtoYWjwBSQgrCX
	hzfgEVFvsAZ2CQQbZh6NpmP3rIqrVH5FSikfEbv57JnjotXMamA==
X-Received: by 2002:a05:620a:4002:b0:8ca:2a02:dfd5 with SMTP id af79cd13be357-8cd6d38f9bemr1747206585a.30.1773097549762;
        Mon, 09 Mar 2026 16:05:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:8ca:2a02:dfd5 with SMTP id af79cd13be357-8cd6d38f9bemr1747199885a.30.1773097549238;
        Mon, 09 Mar 2026 16:05:49 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:05:48 -0700 (PDT)
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
Subject: [PATCH v1 2/8] net: ipa: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:31 +0100
Message-ID: <20260309230346.3584252-3-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfXyME2gq0ENxfD
 cgmiXjm0E9JYbOrs1qAqWuPUt6nGMN8AcPoAARZiU/lePhHRmxWEKW0q+UUqUJjuC+hMbgcmRTF
 4eNuQNMVHYM7kpipyjyLL3ivVC0bQeNO50b3fpQqGeYTC7cCtfDCU7NBGwvAfMdSRQD/fsnfWFd
 5KEA/nj7AFlYWNBGsBnOnB916V7I9OUIa6QnMsPF/oQHIxf10GFK6TPhJRp1Nta8lNov2MjY0jR
 5p+Mj8rheTl+rsBQncrHSDNxLXkffmhIrK0ySzN6d/05O0je+ZJazVl1i6P4nFp2ABF/D+3leH8
 ts0z2xVizaFyHeFMH5jlhFMRbVfOoFFb7cu2acZrJV4vYB+nj8Q7Sn3sDt2QMZeJfQohkIGLA8E
 xB8r9eJfBQ5SUB6kDRC7UyaRtqJgaey5IpqUluUYvVf52d8wXvPx/Nr5NJSzv9UbM/6tfKaiSVM
 YJCI4NaWAdEWFY+fNcA==
X-Proofpoint-ORIG-GUID: HRESPoNYbvV39bFZm7jXbR2Mn-6wimRZ
X-Proofpoint-GUID: HRESPoNYbvV39bFZm7jXbR2Mn-6wimRZ
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69af524e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=shTvKy1OFHrmHVGPjj8A:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: B691D242866
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32782-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


