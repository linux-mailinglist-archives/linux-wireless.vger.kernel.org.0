Return-Path: <linux-wireless+bounces-32550-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL8sEIGqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32550-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE521523B
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C402A304752A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0A3CA4B5;
	Thu,  5 Mar 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8I1aAHZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3atH981"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BF3CD8A9
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726875; cv=none; b=Ujma2cS+PAZ29d8Eo/KtsEVTH+IW8JRwQZHtl7BmNydxK0A406i7sgLsXM5IjdrNmOswE8ijLwTERn2jr7bdlDemSrCFprZ2CxptyH7QHLP07SjMk3kM4oj3B0UcIJ0/zdoOb2+X60EObxCCGykX555FI1p2VhPsu7r6qMck8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726875; c=relaxed/simple;
	bh=b1GblDm19067Sr4/CwERGPzydCktlyC29q6Y1AJ004o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2nvEDb+SEH0CD8PoweFNR4wqQseom5k0NrS+AxgEOlsHehH/0/ywSGA5YSFn2gFfDg2+fbiMSbqda3MWN5lqJ0KOsHK4w+oJoIjGIcPpcnP9yJ7lFKw8kOZ6Bf+Q+4T3Q9eEwD9dfFlhmQEZ+RQb5tU4w1abcncbw1zVwqZrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8I1aAHZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T3atH981; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFsZI861854
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=K9A+zIDsEkq
	lAjsla7AKRgzmOqqxZ5Vpm3vCcX2ep/0=; b=T8I1aAHZOhVhTbPwNv6aEVrxY3k
	oJzyWZXeOJ2Cnb5UcwKGrWZG9hqF3IH8GPTPSssXhYW/AQnFv4/YPgkt2gnFIqvv
	HyBDhkcOpcsMa2KVoRSdH0IYtcrYa7t5NGXSeX+BOdg43xhkvQOb/3eO5T2DMJoK
	VlY0/Mnc33wKm3o3Canc+/5VLt9wJOltuFSSm4ZTJ3chous1V5u/Yy0qYB3fGxfo
	HE93gCOrwlwayTVgOWgOuqspZcPAzKdTdeDVoxBqrcPC+dikDit1J1hsm0NbRHDH
	fFkHyjq1yBjHwUNsTKZhYpKgk9dST7Obtnr7cpPf7nb2R6d3US0EmKDbpFw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wby9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:07:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae4af66f40so55369035ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726871; x=1773331671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9A+zIDsEkqlAjsla7AKRgzmOqqxZ5Vpm3vCcX2ep/0=;
        b=T3atH981BzQxb5dsNTceizB2p+YhsU6j0VL6CHurWoYUwcKSeN243ehUGkx9y1nBeS
         EVhew4vSnJy5MfPhzNf/5pk7Yf1RfOpBrGzh6btByUEdluFJB1Rqsfb3kzTfKYkkERwD
         LdNItSEjBmAYHZAozkWH33YFQdGLNy+mSmrAurS3+EzWXdKlepmd/2lBdvSaWBSzWVyW
         346bqO8D0nYkxg88FtuEk7n2aJXnfP2Zo0jlvAJCF5ckxDWSMspLEZJ9OvVTtpKFZ3bf
         PqRy1gTOBs966QWzMMdnzox1MzhZgOI/rxZNkDXR4nt9FMHDYr0zza8h33s+7J4eXF+a
         jvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726871; x=1773331671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9A+zIDsEkqlAjsla7AKRgzmOqqxZ5Vpm3vCcX2ep/0=;
        b=AND4c7qpdAjR/b0JzZsA9rxmeWuylLZKZxPax3ENhs0CDqQD1XABgyKRnOu+lQVb8s
         5H6rI265JeUo7vSDUs4wPUubzWInHLxDjDweVtHEVw25A2mNVFNkBOqJ9Rg74wXnPDKM
         1AbDY583Y8ZY1C76gXWgjsgwEZpoKYlieVleJxIbkdHr+c7RRCrZFlKvDDBbxfdnSRs5
         fKfmgCzj9jeYv3SmmQyQ4pVIDxnBr7h5nsZtpsUGU/WbfMQ0290as/43u1WdwypHTsmI
         affGO97VtWCHA2ckZfg/1vueTfOPWzwwfhVicDCX2+J+8LWzu0o0TLDGHL6F1KwxWhOW
         +X3A==
X-Gm-Message-State: AOJu0YygMPKdIrLhUyqljzVI7wyK8gb6CtkzQM+hnwctUZCBKSzHO37t
	Y9X4PQNolB8G7qGAZRnoAkjZeraQKvc9wA5yHSPjTMb8kz/nEeyRz2l3P1why1JLh05BHUP6YFR
	1AEUxsDi83CaaegJ5g2cmHSGHvtgAX/uUuWLWmZvuqOZq4++xnq2kgWAMf7PSdt6SnL14yxWjrX
	nP
X-Gm-Gg: ATEYQzxbriz4QTGUuQzp5iimbn4y7xqUm0PStpWiX5EqEQbw/rb7m/TGXT/2xiBEv6G
	a+5ftm2O+9Na+sBvOPUzaIG52GAIb8/NfDc7ItFJjAhrwosfOVjPzKeLHK/zbgy5/H0AUr4Que6
	dZLrIkaNicjYqhkxXd/Iwztgr/fY617oFx/0pOnE+UyBC/1d5GCmajcJ6gHEy3nTIfktgtf4o+P
	UdyBOWsPoGPGVL48cqDKDSThoFLfy4YFbiXAsxI/owm3VT8GxGg5V5LHLhQZGEnDIdeukwDNrq7
	BzlMRLfXf1/fY5MnyovLU95hbRzGv/IKDqFCoSUaPNvGJIiRwCp1DEYPswqr7Fcq4T5BJHLWCVe
	dpPX9VxTu7A1b69xZq0Xx7Q+sbnu78KY0DnTC5APJYsXkaY7hpRMiDBA=
X-Received: by 2002:a17:903:2b10:b0:2ae:4996:c2a3 with SMTP id d9443c01a7336-2ae6aaa8a32mr66183435ad.35.1772726870875;
        Thu, 05 Mar 2026 08:07:50 -0800 (PST)
X-Received: by 2002:a17:903:2b10:b0:2ae:4996:c2a3 with SMTP id d9443c01a7336-2ae6aaa8a32mr66183055ad.35.1772726870193;
        Thu, 05 Mar 2026 08:07:50 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:07:49 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 01/15] wifi: cfg80211: Allow RSTA role without LMR request
Date: Thu,  5 Mar 2026 21:36:58 +0530
Message-Id: <20260305160712.1263829-2-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xqzaM8084Q7VfG1cZcFujjWMQHb_yCQh
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a9aa57 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=-tftlpCPBrNBlGCn5IIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX8chtgxHg2zV3
 SUXORhZqZUtj4pqfeAL4VGbssr2Ac5APrcJyAMQ4uZ8peNji6GG5tC8lrt5XMUzPY0fCDq/39pO
 ylib1cDcX43W/qfzJqek+VbEgz24RAxfoVzETkzrdVPy1q01RxXpgHZlwVUtgJkfxK5mzwjF8oU
 bNh3PZ0yw06NKkAFGakRjmMlEknyhSUjnLd94c6WNDZEWTokwoAfZfUBTDrsSpQjwlhS2rJhYu9
 sWdwPcjRuL4KgSYMZTpPOqp6ysBrelKpfCIFvLsqe0x5Ra4swknTFp5e2Bhyx/eTliq5vKjPQ2f
 knXS/nh0bUuNA2ueNiab/3OyeWRUjMV4o4Cp0LCrhLN3S37u3gTvGJ/DjI9nWfveqfDmoQVNZmT
 3d7JWDFdKS0Ncy9wnv5ZaVhKzjcXp40wcYYfwxsOisGu4I5wkx1BQVXM6O/AORiOPtZu1nxDBMC
 SHQQ8zVzCVG72ob5XWw==
X-Proofpoint-ORIG-GUID: xqzaM8084Q7VfG1cZcFujjWMQHb_yCQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 89EE521523B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32550-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently when enabling RSTA role in PMSR FTM requests,
pmsr_parse_ftm() mandates LMR feedback to be requested. This
prevents valid use cases where devices need to operate as RSTA
without waking the host for measurement reports.

Remove the check that enforces LMR feedback for RSTA role and
update the documentation to clarify that LMR feedback is optional,
though required if measurement results are needed.

This allows devices to act as RSTA for proximity detection without
unnecessary host wakeups while maintaining the option to receive
results when needed through LMR feedback.

Fixes: 853800c746d3 ("wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request")
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 5 +++--
 include/uapi/linux/nl80211.h | 5 ++---
 net/wireless/pmsr.c          | 7 -------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8cd870ece351..a54300b6899a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4363,8 +4363,9 @@ struct cfg80211_pmsr_result {
  *		 EDCA based ranging will be used.
  * @lmr_feedback: negotiate for I2R LMR feedback. Only valid if either
  *		 @trigger_based or @non_trigger_based is set.
- * @rsta: Operate as the RSTA in the measurement. Only valid if @lmr_feedback
- *	and either @trigger_based or @non_trigger_based is set.
+ * @rsta: Operate as the RSTA in the measurement. Only valid if either
+ *	@trigger_based or @non_trigger_based is set. Set @lmr_feedback
+ *	to receive measurement results in response.
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0b7a06c2b9f7..8e4f9192d8b7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7961,9 +7961,8 @@ enum nl80211_peer_measurement_ftm_capa {
  *	channel specified in %NL80211_PMSR_PEER_ATTR_CHAN until it receives the
  *	FTM request from the peer or the timeout specified by
  *	%NL80211_ATTR_TIMEOUT has expired.
- *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK is set (so the
- *	RSTA will have the measurement results to report back in the FTM
- *	response).
+ *	Set %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK to ensure RSTA will have
+ *	the measurement results to report back in the FTM response.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 556f30f5d60a..b875b61c0b48 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -195,13 +195,6 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 	}
 
-	if (out->ftm.rsta && !out->ftm.lmr_feedback) {
-		NL_SET_ERR_MSG_ATTR(info->extack,
-				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
-				    "FTM: RSTA set without LMR feedback");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.34.1


