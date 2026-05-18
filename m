Return-Path: <linux-wireless+bounces-36596-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDR9OinuCmo89gQAu9opvQ
	(envelope-from <linux-wireless+bounces-36596-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 12:47:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63356AEB4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 12:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E74A30805C6
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144C3EDADB;
	Mon, 18 May 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0gsLl39";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jU5XgeL+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C73EAC74
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100285; cv=none; b=Y50MoW2JimJn6qUQoc2QfQX+EhdOpHC9kUWxDME8lCMdjE9kF0KlLsAM/nwLiHpdO2kASMxCuIyxsP9iRZI+ncNXYxLPnIG1tg1AoRe85yYFmI5iR0duxt3zcnHWA8KpwGOHHbMRfOwQLfHw41TL6w+fy6JzfSRZPPGfBwybLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100285; c=relaxed/simple;
	bh=j+5ZmLw5kXbhA+yWHPm/CtKw3oGDfcXRjjF0//pR9qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cta7PWurFpTLz0j1KI0iif2WQGnW0ayK41So+qR8gttf6k0PHsI+WOsQ9p064p6hAv+ckwcGwicLsP4qxXBFnX1Ykyngi8SUt+pFiJXthP4VC/yZ8NXJXKQc0zx3Ub25p2WI7+520MIpW6gyrZQSi6YgWrZiTg0wdkUad3UM6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0gsLl39; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jU5XgeL+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I5YmWg2685210
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ddtAGxw0WjUkRKuWSaH/5ef5p3edd5LVT64
	Mmo5gEQA=; b=n0gsLl39yvKUrK7+DeZ3C1Lod1DQ7Ms09wSvPqKLflj61GMgkvo
	x410ZKY328WuGuHbpPtG9pN/0MIpHjuhpMgC3iDTHuylxsK0xTQ5L/6NaVpYJgoy
	Bv5yunJTG/eHRuQbeW9Y7mnq0WbCcsqL8S7mCkDPTjGiiV0f2SD2dcJTHqDPfPzO
	qUP6zSnn0LXN3cteW9KRAQ20KtOteqKAss/aNd7Ged3zDUkdVCQjf9zV52QCZ/6B
	V3599GO399CvcKlmVSIV6JTnywZ+6evQ/OBOz/wH/MRHtjqLF8l2r9D1GiNl9Iph
	PpOKfY8jSu2j56k9OfJmPSrJd5u4hEc/Fqg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbs9m2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c823549b1fcso3820472a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779100273; x=1779705073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ddtAGxw0WjUkRKuWSaH/5ef5p3edd5LVT64Mmo5gEQA=;
        b=jU5XgeL+AddLegjU5yibVsdTrdnqAdWf+3FKT5Ao5Om9eCWRuzWtuSOVGJ5K1YPL2e
         +DtEp0nLC5dVoDwToxQulsr1eKKMuMFHGHt70rtGNtorhyuofRiF7baYBPP7BG/X8Yyk
         Fyvb8XcYj4U1IGnfJa4OPPZtgfle2DPCGvmIeTEXgfUU7MZKLA1SDjbZB2j6HfIJwYe/
         g8Ifop/viGugyCa2EivNpldFevLJVVYkHfhth/XYdWLgqkXSMhx8KD1OllR391tFE3+i
         qkkjr8VnibbfT2C+tmnpmFGVu4dVeRONvN3h08f0p+z4s5965EYroBCBYaPTrZs64yg1
         Yrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100273; x=1779705073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddtAGxw0WjUkRKuWSaH/5ef5p3edd5LVT64Mmo5gEQA=;
        b=qq+s5hZ+jqaO4cirL7Xut1exbpJABsE7XZ8fr057PqzQbTAN+V6mz5E3jtOB+KjfZc
         ApTnJaslnzLnL6i612jjQ3KurPXHSePbw4SgApwJ1S8R6qE+CO+t7kkJohsZUq6Vv74x
         /IO/5GgWTIB5ezWhfG9WIti8HsNRqqVVmRZyVb6m7tiW00E8wP2z4l9MJb8olAXA41/9
         6TG+qMwshTOXsFedLhHPtewK0FYhi1Lt/ZOq9c/gvIIGDi6pT7T4/VUPvGYIlfdyFdl3
         OP3B/dqtJcFnlucT0u3FxOseQ4T+n+6kVjBiF87gB0ufGd6mItJXIJVwU3J8IzQheKu5
         ocqA==
X-Gm-Message-State: AOJu0YwkoCy7r5Hqiw97MxW1/nHCKVbL6qda+KIsTsL5/+tkh/nGFCm5
	KpEI/N4MGPjEDDprdTakXESJXJ6wDVdDO1X9drtnoion7M0q7Y8Z3OLHd7OqRwOTe2xAaDwiwxa
	8Qyh24LO0HZFkG/fAax16ON7lRERUjCe1uBMgrH61b+LkCHskgD3GgIFfaPqmPyYyYPwv
X-Gm-Gg: Acq92OHBnNm2bV/w8v5UvBZH0haTmPQ2i9fG0lpbJfMaC+3AYfK+uj1fOwzEAFfj0rj
	WuZnxy4ywkrPFURU6nFUNFvVlufBL6kc7XrRglpX4z8iJbqX+aYzFnSmopM3ZgW1I3furQXGAWd
	rSOu3EtyQ60Nwrg5OTawxShL0u3tc5+1ec9nIDdNxjBBsH1O7Gjsr5arBfHm6UJporvfYwLlJzb
	kFaCAsLXxzBfFmedzzBLUcEjNf+uOJv3lLB8XQJ1UDOER3J8RC4MdA5Uopd8xsnLojkoLw40rej
	03953zUZATgoUJwoYttiEH9iL9W4APYxRVRkdY9yvUGxLULDaw6yxNmEj9XikEMBONdS8F8dWYe
	BlVbpxjVE/VsAbHca2VikBvSEW3LTfnS5cxwJLPCVlx2uH5tLwARinnunhKETa6rRX4VU1FZqS4
	TIenpIe2TzVF38PSAUNDisvxSg30SMWgD9W5geE7BUKgK+Nbo=
X-Received: by 2002:aa7:8894:0:b0:83e:e05d:ebb with SMTP id d2e1a72fcca58-83f33c319famr14919648b3a.25.1779100272772;
        Mon, 18 May 2026 03:31:12 -0700 (PDT)
X-Received: by 2002:aa7:8894:0:b0:83e:e05d:ebb with SMTP id d2e1a72fcca58-83f33c319famr14919608b3a.25.1779100272208;
        Mon, 18 May 2026 03:31:12 -0700 (PDT)
Received: from hu-pshashik-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19775ca3sm15107597b3a.14.2026.05.18.03.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:31:11 -0700 (PDT)
From: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, vikram@qti.qualcomm.com,
        kiranv@qti.qualcomm.com, pshashik@qti.qualcomm.com,
        cgopi@qti.qualcomm.com, ybasamma@qti.qualcomm.com,
        vthiagar@qti.qualcomm.com, sivad@qti.qualcomm.com,
        uvignesh@qti.qualcomm.com, mohathan@qti.qualcomm.com,
        abishekg@qti.qualcomm.com
Subject: [PATCH wireless-next 0/2] wifi: cfg80211/mac80211: Add Max Channel Switch Time (MCST) in channel switch started notify event
Date: Mon, 18 May 2026 16:01:04 +0530
Message-Id: <20260518103106.1462604-1-shashikala.prabhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ocWdmRFv_LskkcnhM-NvesV7mNLe3TO1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEwMSBTYWx0ZWRfX3VncWph5lQ+0
 ldS64XlcUmm79C01eJ7OUkuAupPfz5cGDvrQZlQiRyXjx3HU1d6VB7xTxbIzRI09XBJF78BtT8s
 Lsyq4J8qoCYqp/C56So1xgW6O5s2eLLZs0OwMhu6DmlxYdq4ysU7wPTNOviVSe6xBQV26hcCGmm
 6cUl9/vUNC/9M4hhpsKrtEFhJ/OrMvDeo17GHot+hMzPTeKQeeh02T2KX6+V9cqTQnZmpSufdyj
 M1oO4HBEYNqzmM/dQxz4klK27XldeiEI8rgfmHnqYzlQD13d3rBsTfGWDrNAbyXjByyqX9E+MoU
 1QMRplvkRVCJlRUziO9JhPUv57FzljKsjE3p0T7i6HorkuJ0E/ejTsOrzV1ck/KANbkfAgN9tTv
 5iN6+KkDxPbBeMCaGDOgEjpR/yfZLoHapwt/mf0BYLlSbaOsRpOLWBAlnysGeqyuyQ5WpgeY+H+
 EK0zRTaqy3SUZt8qrzw==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0aea71 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=7hzyat0Z0xvXN-skQlgA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: ocWdmRFv_LskkcnhM-NvesV7mNLe3TO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180101
X-Rspamd-Queue-Id: ED63356AEB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36596-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shashikala.prabhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

IEEE Std 802.11-2024 subclause 9.4.2.216 (Max Channel Switch Time element)
defines a Switch Time field in the Channel Switch Announcement (CSA)
element that indicates the time delta between the time the last beacon
is transmitted by the AP in the current channel and the expected time
of the first beacon transmitted by the AP in the new channel.

Add a new u32 nl80211 attribute, NL80211_ATTR_MAX_CH_SWITCH_TIME, to
carry this value in the NL80211_CMD_CH_SWITCH_STARTED_NOTIFY event to
userspace. This enables userspace to decide whether to remain connected
or disconnect before the AP moves to the new channel.

Chandru Gopi (2):
  wifi: nl80211: Add NL80211_ATTR_MAX_CH_SWITCH_TIME attribute
  wifi: cfg80211/mac80211: Pass MCST element value in
    ch_switch_started_notify


 include/net/cfg80211.h       |  4 +++-
 include/uapi/linux/nl80211.h | 11 +++++++++++
 net/mac80211/cfg.c           |  2 +-
 net/mac80211/mlme.c          |  2 +-
 net/wireless/nl80211.c       | 13 +++++++++----
 5 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.34.1


