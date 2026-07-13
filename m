Return-Path: <linux-wireless+bounces-38987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D1mbN1QPVWoDjgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:16:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37B74D7D1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:16:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hcLhYbqL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Y8wJF5yd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38987-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38987-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCA7B3001855
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5DE347FEC;
	Mon, 13 Jul 2026 16:16:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D7337105
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:16:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959370; cv=none; b=josAMt2zzIwfUIOtZYkIhVyu6wEuzJVXDUgow2JaKu/9LU4EhCOj5LbK8VSoYMGZrnQX23LdgzR7hpAHEI2HLIUHBZsURCtP+sysOu9p8CKQvnxIk7IC7u0TCh0WSniZ0bJzerh+6c4iiVu1OPslFgXfxNkM6xUItmcQBmOxDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959370; c=relaxed/simple;
	bh=0eK9WLBIPXbMsczna7fU0yi1o5+hZ/IM8BkNE+Lj16A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ap2ndXfj52fl5z4gqp315UZmR00NkidKup+bU2EAwmt2JfACMW8mfFezMzEdBTdNU1pQslm9pQsI8L04ZzwuPurjsRSXE+25aBTQE5+uStSX3GJk4NeYuyBtP8IF3K6Xb3Gi8F/7qi40vQKy1L3Zob1JzgAV9dFGzXvP3cWJ89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hcLhYbqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y8wJF5yd; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8AJi1887861
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q2FVNtgJupCOGgrImLEh9tbVWBpZqEe14ORG5Bzq4qE=; b=hcLhYbqLG6LCHeiT
	DYDuabS7eA22M1iSy//7y5P2G9tnNh2FTXn1GFXHyRy3/7v/2NP+27bTYoi5fmzU
	r6w6iD31zeE8/CvuE2ie4ZRYTs2HObr8itnhWLk8L6tDnoFeWOIh89I//mDErJhY
	AfNGVOzITzjXfOEI4AZoTDOKNnss/nm18q1/3L/IULO51IHTUc8cmlUzPRFRd1F3
	eMj1Auc+jULhlRAOFsc92WCDBttS1oJhExj/NPcU8g70j9uZWMj39SsoPMAWZ5vR
	vEYgidHVKZ1g9wfUSYYrLY2n+tOCJ938S2BsdCNKI3yvM1IKH21V7orC/iYo9SLb
	bufq1A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavsntf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 16:15:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84859a64079so6085187b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783959358; x=1784564158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2FVNtgJupCOGgrImLEh9tbVWBpZqEe14ORG5Bzq4qE=;
        b=Y8wJF5yd9FFuruOc8w2UmWwcvhah+LEAHTMECtc42hq0GoIyjk6da/U9UszkV+n3oW
         hzFPGrh/bgJXvEqf0R50IIdbBfl4lRAvh2c9TL5v+Jo4dPMDp5ljdNsqXxsWwv/Licoa
         1Z64chy87rfbL9PtdY+IMUWiUHIQh3Mxw0Gjh74lKcJ7zgC45kdJK1o9gBblr8Ix0cXA
         YztK1SZqDU3c0K+t3kJyxObTRd7Pmkl3RlNQFd+U87Zb8VPEqOvSzRXl9axtyt5JWA/Y
         tLx84CarGeOlMqRsVw89rj/tM4Tzvlw0kFr/XVaiWsYd2GLXZWytBwlIXSnSef2gOWdW
         f5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959358; x=1784564158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2FVNtgJupCOGgrImLEh9tbVWBpZqEe14ORG5Bzq4qE=;
        b=KV8KwTU+KHSQKJTHtMeR/hM+kGgrUHdFW5vjxIwVm9q3ewka4taH8s9jjMgqAdJgQF
         JO1TNeR4GAGcmDYSt0eGuzyNXiXUrjottaBvXqNgbDSq5m1UOYslvf2MNhcd73IWUlPK
         7ZLyBpXQ9U9tOZhm0ogeIDDHEgiPhbDBT4ttmebSY6cc+c+Gpjs8znb4SwU1VikLP0eQ
         Xfoy3ig8s1LbbIoi+hjgf/GZbjkYBqvmUdltuRyGiWZ8KUb3YJ/GKYL0/0K8KbZcm0Qy
         kT8bNH4Ax6YpQrBY220X+OBMz0lG55l5bqFEWLNmUdNGsS4tvDe28dNmaGYzfYGukhHk
         SgJg==
X-Gm-Message-State: AOJu0YyUISU1Dvq52A1Fphmfn4JKECG50eKxJnoUJznVhyst6RM5J26u
	ywxmd5/d95whYZ1nIDoRepRsmKwbpML4SUC2nWfzLG+rFLqBisE32Xt2haYrzp6PJ3K5/HqnuB7
	Tejrh3iHKgrLmFVBbtNN4K636InpC6bIzTdjGl11B8Aquz3p2y6624lQuAEp/Uwru6CgL4A==
X-Gm-Gg: AfdE7ck5aS5utBx/5tZbdt/reeFxFnsBvURfguFFmnYQBopu9ZZgVA+Nf9ASCIQX4MW
	7x4tFmuP6x1ftbMw0kFcjrjeXBm4Kep2VWlnFXprGKtq4042+NyjCWYiqGBGowELPoeQWS7lWxd
	vwrtC6wekRfepOlzpRTo6RYRUwlcWU+/b7qOJhHgADo6EEVhtPPrfzVRsOusWTl/ejZ7kdC8hJ0
	SsxQowozsTAAvnSqxazifkBBU9QPWbzD79zE+js1Sb7JxPOc0ScP+0ExrXeBPfZrY/FVZU2MmfF
	TwTcrmvzeVkygGr2Bzr3GQm719dLqdLjIJBac8Iz11qdTTiBFqxdULXSOQs5vUUUASLmT8laosd
	t/TuEzMXgMck1ubNmDHmw5sr+u5zivMf8Mpt4nHUIK9sqc2swK47bgmq+1aPG3PE9Fw==
X-Received: by 2002:a05:6a20:9190:b0:3bf:5b7a:fc8b with SMTP id adf61e73a8af0-3c10fd60400mr10508137637.0.1783959358306;
        Mon, 13 Jul 2026 09:15:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:9190:b0:3bf:5b7a:fc8b with SMTP id adf61e73a8af0-3c10fd60400mr10508101637.0.1783959357882;
        Mon, 13 Jul 2026 09:15:57 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm60877039eec.20.2026.07.13.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:15:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:15:50 -0700
Subject: [PATCH ath-next 2/2] wifi: ath11k: Correctly copy the hint BSSID
 in WMI scan request
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-2-4ffc4a472992@oss.qualcomm.com>
References: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ZLH7rKfd13qReWvTn129tXw2QVhFtFC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2OCBTYWx0ZWRfX0NBMgO5K7M76
 BG8/qtm1dL7YTZHLtm0ki5YtygdRcF3tozIux4nLJ6ZSXHUONARm8qABBM04Tldm+ohfy5VADdG
 D07K1NyLe9Wgsi/C1n4fhmYoyJkQ7EGHDGN6wUw0JOnQAjKdDJM9eguWPvcQ8zBX+rMLMBIZfbU
 +b2kxP7vj1Fop3mGO5p7OrgnbRlg1sfBIs5NHqN14r0RkbOJHyKbxPDnc2UffqVExswLj6A7GWI
 soDCiUxbpXCdEKZC63ZilaUbnbzLmEMFIAtqUdEdamGDaE3ESVGsA//GXm5WWiiLrmFDw1FpcNe
 InQZY4npI4pKwuvYDYS+h273OxWFHGj6FvSZZ2ECQ2nnPZHajzttPHQx0uJBhH+n0PuFcT8kMmQ
 Wl2+AnWPDHpys7nkdgwwSIkK7DKenCjtut+bLjGLiDt381vpL2YJCMKL8G8q9qCjVvBL6BJz3LP
 /vjWQ13eqgwRUK+14PQ==
X-Proofpoint-ORIG-GUID: ZLH7rKfd13qReWvTn129tXw2QVhFtFC7
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a550f3e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RxwCyRMQgNksxjula40A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2OCBTYWx0ZWRfX4cQ8dcGEXA3O
 OVlVzgKrDotCnMlAcK2+L3YizHrWX6/DaJxBf7DJOMua7gKtH6En/JK59cEV0kFIiWgqE0CDw0C
 6x0FVRDibEqvvgYA146IxejddaVFr7M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38987-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:baochen.qiang@oss.qualcomm.com,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF37B74D7D1

Currently, in ath11k_wmi_send_scan_start_cmd(), the logic to populate
the hint_bssid copies the BSSID in the wrong direction, from the
firmware message to the argument buffer. Swap the parameters so that
the BSSID is correctly populated in the firmware message from the
argument buffer.

This issue was reported on ath12k, but exists in ath11k as well.

Compile tested only.

Reported-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-wireless/afbff608-a005-43c4-af76-968a58bf0cc3@oss.qualcomm.com/
Fixes: 74601ecfef6e ("ath11k: Add support for 6g scan hint")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index dca6e011cc40..c54f50b98a13 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2423,8 +2423,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 		for (i = 0; i < params->num_hint_bssid; ++i) {
 			hint_bssid->freq_flags =
 				params->hint_bssid[i].freq_flags;
-			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
-					&hint_bssid->bssid.addr[0]);
+			ether_addr_copy(&hint_bssid->bssid.addr[0],
+					&params->hint_bssid[i].bssid.addr[0]);
 			hint_bssid++;
 		}
 	}

-- 
2.43.0


