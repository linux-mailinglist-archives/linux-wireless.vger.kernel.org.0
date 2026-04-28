Return-Path: <linux-wireless+bounces-35499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNFGF57I8GmfYgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:47:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BC4874C7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADE5732BE440
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D4F46AF19;
	Tue, 28 Apr 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQ+wYtuQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idKfXJl6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1D4534A3
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386221; cv=none; b=t9AoxQzKtg1xEi2eexKn2NTWH/Z6PoWWI4HVTifCeO1QgZhnXv7yi3gtr73LOUn4B4qZcpYt3WAMeVSA/ajtRAzrzji4e15JCZ9V6rXJMQqH54exFH9BAS0rEk5ev6uddBtTSkl1b4NroVoqoFUX7QI3obAf7krBhbGv2sJckZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386221; c=relaxed/simple;
	bh=cLdgwybwmVheaxNq3A4ptASzy5fGo7sa3nM19lVmCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSwkqI69M6V1l7JyJusC/ZPEx54RGrKXQCbHzG/HTWzHtcP5xGVrsobvF2Gjfau/1I9YiifH+n0je6iWY+zWBL1EVSJkETI3JoZVvwQZCW+jT0gXAyy5PrBj5yO6lw7u3lvYvBX+UTSUnnyr1UVYrIHipe5lTgklkPmrGaeIsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQ+wYtuQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idKfXJl6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9riVa2111945
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=; b=PQ+wYtuQpw3oPdCo
	Gv/gVuNnwt/v0F9FkMF60jbuMEHY4L14JYQaQUOwHFH1G3xmd8JGROy1iaQc3qCf
	xacYJ5iFZhhEvfINckpnl7pe5XdKIR8RrXz7NmcKQkcfYMsZ8670/KE+i9433HVY
	I3uzks2RvFKVhlkSnnkcQhsQxSe6Dwpsp2xugO+/dXf+pDwjajCKcGCmOEUySDpy
	Q7yvsCalSlXcw5IhBPFHJd69TWdMafW4FPvkDPWc8Wd8Qr/L/Dxn3e4F1h1+zzVp
	2Opc/mqH2z6oKmknDbAJV3AgLHGknJwt8JpiVaaMnqAYbOAWwooOJgnk7FlbifJU
	5umC6g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbm0ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:33 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56f52dcdc90so7880394e0c.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386213; x=1777991013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=idKfXJl6dS8Zzp7sfP2ChRmhq51ljHlNA9yqsinQs464iNOepLrcyvtY2x+R/2fAIJ
         phjga98Pt+GpAI0TR5gTgQbkAYfScQJ2vhRxhPKQvjT32g7quORhZfB5yxAkRUQSNbqk
         Peg4thCXJf2IZ97cglEVNw0EhUuiAgngg9zqTOSA6EC+YcI7OGtGq8BGD67ejUFvv1oc
         Z2SURaOzdqLAz73lkD5/GNrFpdn08hQDW/QxwfqrxFohLIzwpd6i12bZIhvOoKx/hsPB
         Gk0sTN1qLKpCacvg+m4Joqc4PLj84kA1QPfIsKbR0GWQZ1N7XlfNUTmzG3Wwg7trSGPf
         D+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386213; x=1777991013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=FR/NgHHSCA/DH12uxl2hSGPijE5JD+iNmAl6iW3dS1K9YaYyoOB6xIRtX4vQLEELco
         xPhtP30bxa1f3o+4ijB1Tx9RW/a4bK0DOlGOTu3VsPuxCf8zpeH//7kdVA8JdvtwUkvc
         t+v4x9STiEMilzIUfX9v0jeGEZs+0U927TWQcthQEVeUKWHlK6ZbecXLA/a9GTNhhNtI
         gMg7gv6LkdvLF6B3+HYTsZqzoPxEYOLyp/OEVAfRUmvKBzYlayNXwK9A6YkIsgwBvvel
         5c45QgAydFykZhoUR7cp1tzKe+wMApaGBz9/OANMrW73PmimaVLW+TZWEYlh/rwWEKfL
         U6zQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t1eHY7Nn5emN32yZMhDc1W19Ha/F3CAF32LHakpumESjxan8aTf0jLMpSXEO94vwzDWi7r1j5tAVl8y2FKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZniQT4BI3h7ZUXZdLM5ss2njvHFqeuqkvgTT2NETer+Z/cJC5
	o3Qd3cuDAQmmaSvSFsZ+GkiK8OFPXsk1Mmg3OZJAEBr42Yf3gShDyjzX6aU+cq0RfcShh12+tMJ
	pRp/lYVI9p4dy5RLhVijq8On2LeujvaLIfZf19m8LjETAf131T1J09KQ387Vdlm2J6bW+rg==
X-Gm-Gg: AeBDiesaV20mafu3/UOMwMi4u3bKGkzwdl4vA+c7Z6yeQsKcn0Tfsp1k9KcYnEusXXz
	JrzOrTFhD4hdK89EWagPt8+2ftZ4hQ7D4l0KUDkSILMi1qJPnVQRCLFns4FQ5C9zJsw3c+bGaB4
	aBaM8XlyE0uLM7XKPXO2nx25+VAnYpQ33hA8bBC43raWtiObK8MCjMzqblRN/lavv7MraDxs9LQ
	ncDIYsSIKRxAX8ei9Xbm1axs5K1aU1M7GJvweegc8tJ5fjlEasE0qcC6z3S7hGFP5I4UojlIkWA
	rE1M8FhAs5PW0OexvvlsbHwAqFt5Gs6AnPHEncQjtd13S76+CDAGZEwts8qE+Hj+omLIsl7ZJ3f
	a3u/lWqz/RyAGxdES4hphwfONXGHiMkvwBYZyjrHK1PZVCk+JtQSXrjTd/6gesbPmX/nHPow/20
	KpUSXAORimClJ1SPDWti+PniAThAA=
X-Received: by 2002:a05:6122:4d04:b0:56d:b50d:3ee7 with SMTP id 71dfb90a1353d-573a55191e1mr1867543e0c.2.1777386212567;
        Tue, 28 Apr 2026 07:23:32 -0700 (PDT)
X-Received: by 2002:a05:6122:4d04:b0:56d:b50d:3ee7 with SMTP id 71dfb90a1353d-573a55191e1mr1867307e0c.2.1777386211467;
        Tue, 28 Apr 2026 07:23:31 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:13 +0200
Subject: [PATCH 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-8-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 2TuroQgRlwAYlPainHGEkQdUNincM34e
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f0c2e5 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: 2TuroQgRlwAYlPainHGEkQdUNincM34e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfXyNRrdws3Ouvv
 TOjuaATNGTgD3yIt+Js8lzW6MKbpo50nNjuKfwvd55lAhQQTACuI0OGFCS5n8xb2Zy/1zn8eV7s
 v81+dPnDRcNlPEMY5mmdCulntOArNdhawy5wwbZNuAMHT2MocwtV/7WiIxMDczS6sjv+f6BMxQk
 yszODouD+SqLme7+cF8hgQgIVi0k84Gi7JpZ0CT3Eht+jsAwNXuEn59Trl47xEvO91EfnxYWLYD
 Sl8TtZZ8coHFkgYa95osIZ7gtjh1a2EZB1bWqCyfyqKR6WFLQLzjtULJYQUlSvwBYYF2eyvo+/g
 RUJ71XZXmBAPOo4F8JCNM+RrWU5wJsjhdh4HDxDgIZEtTtY9PKjnvbuGyrYBqF2yOFUvwDy69bM
 ywyh9rp8LFVBwDhqIDaNOqER+D61QOaI9pnwW5jb/i+a2EDwJFr7MsRHymwBX97KQ5iyLy5x0FN
 BYUn14EXh24raD+ebNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136
X-Rspamd-Queue-Id: 1A5BC4874C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35499-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1


