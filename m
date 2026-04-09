Return-Path: <linux-wireless+bounces-34553-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHGBDbPz12llVAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34553-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:45:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8954B3CECE9
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6363027692
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12D23E121E;
	Thu,  9 Apr 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVhCmE63";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bmg3L7WG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F205345736
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760270; cv=none; b=rkK8DufDeVT+vblEJ96LbdOneTXxvPvS8Lz1nk9151rV6/p+56A1PNXR6rsT70iX9k+9SBtiad9Z42hVAPkZR/EM65t2+9Cb2vqamb1ye6RhuUVvbRWSwWEk/ttyD3BAQnaeNiplvwlWFHnqUSHobL3vjBtCjhgCWuIOxWbK5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760270; c=relaxed/simple;
	bh=cGx5rhIf9GMEbq3wTXs6XETLmzWFnik4G6mgdGSY4Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cydTXaBKOZLW2e/GD+9i1PkM/gkgc7jF4gnaqX2wt8r0vODVnTHTmBRmQENyqJFH7EQW6R5YVRxTcCvIRNlFUHbifTe5QMt/Y1HkKvFbd8fv4sbNnWw17KWd+03NmUZjoreXKLzbbNqXP/RCF+ZaB78UcXCQW1VAKiABta2kigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MVhCmE63; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bmg3L7WG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639D1cFm1972721
	for <linux-wireless@vger.kernel.org>; Thu, 9 Apr 2026 18:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fm03BrLOH8durwa3lCWW54gnX/Tgar9SDSS7/SegCVk=; b=MVhCmE63iWJLbGqe
	bHISkbq/tW6kZRh5ymI2Oq29KHzNl0rQrXZwjEU3C7RTqurUA7XuHK6F3hq5XfBQ
	y4W7K/vE+jHkPZktTh50ueBMrMYtFR5mVJx6ihsZGkP1lFr2/l/y624V4Ypt5vor
	ifLGgsGx4DCRXSgWRjOr3AaJ9AsW5W38IAaflQPvrP02WKxt0wBnsuHjEZNt14v9
	poc/esklxWH9d8MyZy4EiDV2sZeqW08n4MBfazpaRtqglsb3n9BcihzEnHmn56/s
	2hnJnWQw49RYMmmhm5ytOsSaF5f38WKnr8YEqK95+5vaPCIcij6woito7Ht1PcQu
	k9zy5A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decms19vw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 18:44:28 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c20d5d7f4so9615049c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775760268; x=1776365068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fm03BrLOH8durwa3lCWW54gnX/Tgar9SDSS7/SegCVk=;
        b=Bmg3L7WGHOemfzxhUJ9UbAS6LV8ObIUxsL5SIBUCJC7PNuXio7QzuQRvnd7Jkxp3l4
         MSr6BA32d7DC0fc3hXfZq2wEtHK8P/HLy+8Z0Y8e2c+trkDLU+jaL1i+JEAZrzG1JDlM
         aV4LuIuF2fl7VUdHpVcc+B3j67rHkFldiPUby1GB8Fe3PljroMEc7UkgZoLdPUn7Fj9i
         +JU+kbwXbXi4IgxOo7lVoIACP7EPl7GdRLAnIJ7IURgquf/JZFLe3XaZ++nK5Cw1X0tx
         M8nJkjhqi9mQgEP0OFP/3+DGBrxU/DA6t6ovWW/4MER67NfGeU6RNHXZ1kzNMn37JFYh
         VrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760268; x=1776365068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fm03BrLOH8durwa3lCWW54gnX/Tgar9SDSS7/SegCVk=;
        b=dsW3Mcb/76/8CGYD58DfM5aeohw3Sz8UiFy8qG72Cc4p7R4nA21k36/AMWnOS5jcp1
         DldLDn1fosm+DZkj9cAqa+U1Eegx20NTw0SOwsOa70YPe8SvTMLm0qWOKTcgm4dWKPR0
         d+NvtTpxeE2WugCYF9D+F8RAx0ovP4JMK8KwLoOqdyoyayJwvEgWjG02OT6t67W4RZ3Y
         U0zs2At845reNI2PXx91lQUFUbOKfnLruiCU5EhboaEP1Qqk9rt+TICBeU9jfNHJouiW
         Qx9dC4mdPoYZVVMgnWgWuHDZOjf7V75ltCmuXNw6c6lV8mW8i1FAKdk7XKNCBGMYoEQV
         szcg==
X-Gm-Message-State: AOJu0YyilTZfr/G6XyjTC8ZnPFFzDdWNDpC7D85tdhWlEGVxXbUXpXWX
	Xp49v8VUzOEa0oTJGjsZzYcDb1yZ3iOHvH7OCVYGl+74G+eTt/Mh/ZywqnfF+3WvyNQoIetiwiX
	QrJ/hPclwNmuZ1nNBR/DqOzuCnLNTXwqyyfFuoOhM4K5S4K3WSgP9yLIKv89qxOXqlLirqw==
X-Gm-Gg: AeBDievbtY7j0ENz2xBB1BiaoPJdVcv344PFemfVN1EnMjGb8dGlOKoQ2Cl+rtUhILj
	5DDV13A8nudleMX4q1lOHHTLwtU6ra3xI6WyROGomh2eeGWIKawnk9n92Q+ph4ez7eeBH+gCiKd
	d1qVTpZ2wBczL15ntvhIldcG2DdsIXPu7Yk5hYt9vsl0K/X/otvCoZq+o0kLboZfF1BMVUFaQNd
	7TZc0pulIxWPUvmttdJCntMqRkgZYjiQenCRmCUxyQO1NEbR7h8AF4JQjzMyuJeje2ylvAG1yfh
	1SM3PEeR1Lr2zs69CWewXjsdmqmqxfqxK04+nl+3v0aabg+ms+m0ukO2sZNR+QsTiyLE1QuLLj6
	2NB98kiroGSXtl0yQJEuOLe6h37Q3nSQoP3888/64Cet3YrK7cbz4mzu3iu+6bpOf/EVSYCKEbN
	l7
X-Received: by 2002:a05:7022:6183:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12c34dbeaddmr166187c88.0.1775760268017;
        Thu, 09 Apr 2026 11:44:28 -0700 (PDT)
X-Received: by 2002:a05:7022:6183:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12c34dbeaddmr166158c88.0.1775760267419;
        Thu, 09 Apr 2026 11:44:27 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm513985c88.0.2026.04.09.11.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:44:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:44:24 -0700
Subject: [PATCH ath-next 2/2] wifi: ath12k: Fix ath12k_dp_htt_tlv_iter()'s
 iter() signature
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ath12k-htc-proto-v1-2-cda86d6355f1@oss.qualcomm.com>
References: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
In-Reply-To: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: J6qiC83-pkf-UR1TFIIIH-fDj6hWhNct
X-Proofpoint-GUID: J6qiC83-pkf-UR1TFIIIH-fDj6hWhNct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MSBTYWx0ZWRfX54mFNDTugLx5
 LCzcLFrQ++yJGFjvLe10oRWBmCccZZDhutEQKoMVRrGMgoQGM3xox3QkA47vA7okE5+W428sfCO
 7iELV56y2idnwr3e8grWZKamrwOIDax/TQVqv8cgilJuoB1ulr2yHmy78rkotv3BXt5WEsaDGVi
 6t+M0sqUE8yrPJStfYHf5yZMYcCAJfhhg4rbIFA7llEugd0IAohyVVAs7gYX7w0ODjzKVnQ4vMH
 yCgWW1hxaaabcZ/twpenTr1Q98CkF0X6q7+Lazlt5ww1dwM7hElRVg/ij24BusaNkTFrn8ej5l3
 iQCPeeTB6UHudMHJoxSAEiGPldSiNv4N97rdFE2eozl92afhAUMIH0Zomc7TdXAxLHZA9grH9hB
 ON38MANRdTgB8tNV/Cu1lvNbmQxRLllU5MIod9uvfV+duRSzukMNq98xwD3kYVI8TuBvjHPvzyi
 iiy3bvRPa+nKX+RQhUQ==
X-Authority-Analysis: v=2.4 cv=N/sZ0W9B c=1 sm=1 tr=0 ts=69d7f38c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=TfkjnaP5MeWC5N93_1wA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090171
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34553-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8954B3CECE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Per ath12k convention, a pointer to struct ath12k_base should be named
'ab'. However, the current signature of the 'iter' parameter of
ath12k_dp_htt_tlv_iter() uses 'ar'. Change it to use 'ab'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_htt.c | 2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 9c19d9707abf..52e10059c6d5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -146,7 +146,7 @@ static int ath12k_htt_tlv_ppdu_stats_parse(struct ath12k_base *ab,
 }
 
 int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
-			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
+			   int (*iter)(struct ath12k_base *ab, u16 tag, u16 len,
 				       const void *ptr, void *data),
 			   void *data)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.h b/drivers/net/wireless/ath/ath12k/dp_htt.h
index 6020e632f74e..987689f11cda 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.h
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.h
@@ -1523,7 +1523,7 @@ int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
 void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 				       struct sk_buff *skb);
 int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
-			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
+			   int (*iter)(struct ath12k_base *ab, u16 tag, u16 len,
 				       const void *ptr, void *data),
 				       void *data);
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);

-- 
2.43.0


