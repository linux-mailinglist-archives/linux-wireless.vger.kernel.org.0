Return-Path: <linux-wireless+bounces-32788-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEWFEoZSr2m/UAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32788-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:06:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 279AF242849
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04BDB3024B18
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 23:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1042883F;
	Mon,  9 Mar 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cR9bULr3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8XOX31C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99A4279E4
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097567; cv=none; b=bMB4Q3SvWLA0fWQV+vKDyF4Kl1cPMR3rCmXQet92z4gkVWuDokKeL/UziiNJCkl+YbF1WFi1bcr5sXZMKKPqMO2Qyxi9qGmtNcXip04qO4ObujWKgm9iNM0WPm71sPYph+jexy1pwoWFkH0JgMPoUo/Ssc+7ajsvB1K5/M7XaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097567; c=relaxed/simple;
	bh=JA1Emk2GOGrNm0wBvip1tqJqrJtVwNB/O0vGeFWX/84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEQqm/XpSN0sWNQPNu+7D7IM1GVt3htVCOccHbjwEac6hnKk7fB41QUTUwwduM/0RiHN5vH2PIP7puO6PRt2iZqBcXWZ/B5j8iPmaJxf8TJjTDqaWkqa5wIDt+QeSKcb8r8KWYfErYCgo18f0bU2BisSoS1KWEBrON5x7+5CFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cR9bULr3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8XOX31C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBwr7296579
	for <linux-wireless@vger.kernel.org>; Mon, 9 Mar 2026 23:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v2mAeI36jMe
	fxLTQ32eNJQTAV5FQOsM8JFUnk8b12HY=; b=cR9bULr3HuHIdluNoBJGFv+4inn
	oEkch/dAK8iHZXChBmP5YbxIOSs9RppPQ3TOJwqxNc6KjUG44l0NGpnP6kv+bW+n
	93OhKIOseaCH6RpcaT4bQYVVTt2zIv9g1XXzGixEOaqkG8xPAETVQCoustms+8/l
	1XL6XKajpsOZ7fXoIessDCYomEMqLT1Sx6X3lbhM3jZxWSOKB3YGmGnJ74qcBg4q
	AsE7BsGsPW2E1XJkUAqbhWuTQ8OdZtuPblMct+hrtcMMvkjsLExjzi9rEA4GjGOg
	PXDfBsHsJPiT4nYN8l0FHvpiUBgWVuZ9EIQhJ32d6/k+OSx5hXtL/yADkxQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy1rxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 23:06:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd77502295so1418742385a.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773097565; x=1773702365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2mAeI36jMefxLTQ32eNJQTAV5FQOsM8JFUnk8b12HY=;
        b=g8XOX31CxcmXx766z2IReF1IJvIswtIf5plLemO9Y8QXZHkKlFmlhiDNpl3v5o3+zZ
         SC6yDf7u8KyhpmeWRkL8KN4vIbavmu8TGnR/wapjh5/wN8uzqXrkiSfAypXpIjl2LpMH
         NhsYyx9v41ITpBZ9SLwd+I17SaxI1b8VPt1/JaSsnbFLGbE8Mmiacpd/ru8KB0+GiOyG
         6yQtx+vxXwnTukAkBwhS/jqXA+tCa0MTrStzdmLlXk2bZxumm07HAYvqA/NTEo2tv1H4
         gS78ZaphzaKzKMKq6AYNYL4ZJRp4iFJFFoWeO27TWz58d4JoCaJxtoaQHqJiZXruBvL5
         vsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097565; x=1773702365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2mAeI36jMefxLTQ32eNJQTAV5FQOsM8JFUnk8b12HY=;
        b=rsUhN4c4Cdj6XE1kl+kGysDf41rRTwLaCkauuFNT7I1l/VuGjefHdy49Y/B8Hh9ewD
         cdJlYNcY7FHmWYK08sAD4sVj0cpk1p3sxDbPcAdveZsPWHbBARiTBJqKzhnBwOfeIz0e
         esVIqWc76w5kVYhMwsH6D9nYXko3EM+slM25SZSPp7mBux0sAqkn+lKepmpp8ePIo5kI
         IkxdajcacNag6VAsf70rge2UwLZ7qhEo+r6kxayWsN2eb4OxvryKiWkcknxFShxZV0tN
         /SwwPP1+uW4++LOtJzT01hpg02smMmps8QCN39Da6MpgVB0P1g81nROrmbmnmgjMbvwD
         pfxg==
X-Forwarded-Encrypted: i=1; AJvYcCWejVEa/tBTRHRuP0dbs+pOL16VR0IQFJsyc2oCihZwV7CLyj2PwY+sxLZkh3qAZWE0wMnc8MfwXXUKl0+CLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpS3WilbljV3aEmdWKab4IahU0HTv9sVtVurmzw9UGJvM+wdC
	maCxeneJJnVVsCE1Zoh2R2ojy5eXXTeFCzcwG3cLA0NmecdBHV0Sjha03b5D9CfDP9x6giWhW8G
	VEenLRCkLkEO+QEJ/FdY33IYpUqL5gTcqkWRNrJkNvsuwFJguLlsNsjRTlG8SKERL0cprpg==
X-Gm-Gg: ATEYQzyWOh1Jl7e85lM/CtbI3IQwdlBFMtZavPjQqvAInZvH2Zd5UKR/SuJeYrZy/zX
	/qL1oPWZZmszdMTg1/M+2zwnIX7qQLKLkU21DxM+HqeRdqeSIQNAckhE7BiQ3Ivu+IIVA3lY9L0
	D0VEN4Xlt+CxXiWgLLYetyG+Za75PXzY0OwG78XEZBokK+/FJuGYsl1bpu2AMkS3uNJHCwpNS2H
	s1lTzz352VuQ+BqUqYPO5r1t9QbNVbh6UV3QibV3005K5FsqL73SB+cOrVWYjzuIZN7isYwbIYZ
	RN71OhLajRD0d4YBkxjwerOFBCC6z8lEWyg1nx48FeAAH8rO8TXaioBX+0MkjaPoyJASXsoB9gb
	vl8IDImLCA33L0eb2366Yjbj0u0QMLMVPbqnEuhW1i5ZKTmeD1w==
X-Received: by 2002:a05:620a:571:b0:8cd:7cea:aead with SMTP id af79cd13be357-8cd7ceac62fmr770644385a.2.1773097564720;
        Mon, 09 Mar 2026 16:06:04 -0700 (PDT)
X-Received: by 2002:a05:620a:571:b0:8cd:7cea:aead with SMTP id af79cd13be357-8cd7ceac62fmr770640485a.2.1773097564261;
        Mon, 09 Mar 2026 16:06:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33898478f8f.30.2026.03.09.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:06:03 -0700 (PDT)
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
Subject: [PATCH v1 8/8] samples: qmi: Use the unified QMI service ID instead of defining it locally
Date: Tue, 10 Mar 2026 00:03:37 +0100
Message-ID: <20260309230346.3584252-9-daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIwNCBTYWx0ZWRfX153ltQ9qEfo0
 XNmYxTE5b13GV+0DVJcJX4WxI13fyKuHcMxF5Me9Ax4bss1W7cXN0VAZnWbNsVN47VH/Yv2sk4p
 L9a78hRO1OAvB4yu4UUTtnb0jkTRkQWXRdMNtAS+vKIgHekbh5+AK8YpKPEiscIlrXIXTyl3ojh
 /nwj3e5rmBpYvhQzxILASXr3WNnYOvgnnNZ2JiwydlnE6P/ShCYpX2LV7C8f3/4mZmpBceoHjfD
 /siFD2NMzwwmF9NsJ4MaYiXDVIfMp/Z7GOIMPFxHhzFpqX/QGbo3Kj8orGYFoUJCojJJlAMkEmN
 TmhS0PEbBG9gN5Ij/h2cZY1fLv1P+SY1De118eAQ/9GOwBNv0LjssNeghwAMETGkQP4Eo/voiz+
 XVrkshQnG4FMM2tmy0GICF2jlg/OpYH11zqQcNo6CC90ZU43l3FGE5jpWRTDk6nOdP2rsTyox5X
 pSxHU02/jyB75gvArmA==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69af525d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=RE031ben1CQMdFOqpmIA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: wjFhPl9YfwtuiIJXEZKwLrzZyU2sR9WQ
X-Proofpoint-ORIG-GUID: wjFhPl9YfwtuiIJXEZKwLrzZyU2sR9WQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090204
X-Rspamd-Queue-Id: 279AF242849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32788-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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
 samples/qmi/qmi_sample_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/qmi/qmi_sample_client.c b/samples/qmi/qmi_sample_client.c
index d1814582319b..247ec5e54c4f 100644
--- a/samples/qmi/qmi_sample_client.c
+++ b/samples/qmi/qmi_sample_client.c
@@ -592,7 +592,7 @@ static int qmi_sample_init(void)
 	if (ret < 0)
 		goto err_unregister_driver;
 
-	qmi_add_lookup(&lookup_client, 15, 0, 0);
+	qmi_add_lookup(&lookup_client, QMI_SERVICE_ID_TEST, 0, 0);
 
 	return 0;
 
-- 
2.43.0


