Return-Path: <linux-wireless+bounces-31044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kb5DdGmcGlyYgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 11:13:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB0D55043
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 11:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBB5B8C670D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D16480DD3;
	Wed, 21 Jan 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTo6k5pF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFF7XKAZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12E480961
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989074; cv=none; b=gvKNQCULFgt8rXnP9bWHXq3xJW5W7Gv83TjFYI8V3pFaBZ417QrB2hh9fZbobu+nC9setLvhSpmCZFZnvpI0OKQh1MrzvTAOVUF7qZ29Qmx7FuNgDSx9PIJTHF9oGOlkU+pOHcuSumurG33psHbMl9wXRSdKZr7kMQuvy0GZ4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989074; c=relaxed/simple;
	bh=iIFQSPf41OaAvM8iise5edInA3f/VqBobQtOAR8O3tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbiKGd/fHThXbHy5gEkxH6JukeGT78gTkmy71aynhStUg+H0IiLkB4cAF0izbo80QCfdjGRFZpem7mzi+km9n/1aTQ0Q0uKDpG2VS0Dvxgvd2/DhcBhCMvL2GZDKb/Rat4tHRlUYm8aE2I8S2kQvPw1I82X564pUqnZ8+IZv+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DTo6k5pF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFF7XKAZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L6021x1036610
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g02eooS4X37
	Eg3/73OINNWI5q5Qo0hRIZrYjs1jrqxc=; b=DTo6k5pFfIkP/b1kAGFTkw+T4Cl
	PwQG8YYPuETSEi1ixptZh2+t7jEOu/b3ayvXmuvJP5bFHSQ34nuoBfRYELjJR4H3
	f04Pg7owgJgL3naHdYeVyFQZ9iQXCy36/ZSov7xDmpPNuufARg8/5IdKLeW4TZto
	1UGSa02lRFKm2zAMygETnOIz2/Wwb6qCbbzpL+9aaugCZ0DYrBb01HRVlzDPyKhj
	JIbzVbulxIhZ5l4HchkD+NqZWuCISSIY3HhAKf8jaG/7+xE4Bp2beTpa4qPZk++9
	AFOtfyu5WV0qrKihZ/lXSv3h0l+o21ZLvbHeZjAt0O5z/xDdK8WC/E8ECEw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bth55jrk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6133262e4eso26286a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 01:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768989070; x=1769593870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g02eooS4X37Eg3/73OINNWI5q5Qo0hRIZrYjs1jrqxc=;
        b=UFF7XKAZgHGmX+irw8q9audsdw/w3jSnGLGzlJDZmt9PTP4L5P3mdTLAFhl59i2J3c
         hk1X+tEAo3adN4LMyOdaQ7OoWsCBHZYxojWMDyTheHcL6cLBRLg11y9XYgb0l3ssDDLD
         OfR8k7wpZMPRni7EY5Qd0/U1lk8mKpL8aslru5NNYP6mOLlXIyBSMvzYyTDD0MmKBjwd
         2ZRtqGel+u1nViRFd9KU4bk8J7YIUxrRw95fZJrLpO33QgPUo/Snky5OI936Hpgm6wnE
         8+jPp1evl8IYIIk7Txhb/iPHGAMUyji447ZkZ17R4EcmPs5f+wxwTv+4vgldh/iGNO9X
         UGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989070; x=1769593870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g02eooS4X37Eg3/73OINNWI5q5Qo0hRIZrYjs1jrqxc=;
        b=BmYevqM8LYmmoKaiyiOIfGmq5OJ1U74cX3f0SozMfJZ2XkqJBkx9ZVhIdVKBHnllNy
         0kgTX1bIM/PjzBSU+9k0ChxTJHznwdPd/GYY9+zCbGyST+nDhSYnIDz+p0qGyUJPjzD4
         ittkGQ9N643rNp7er0FKxCeDWuAYCoc90UtF39bebvgRdWXOQ8alqe/7LeWG3REIaqnc
         PCK/iFKpuJRKrfqQ459hJ8XXELyR96oisXjqjtswahS+36rQicRqa7PnQILEM3+N7iyD
         ajuSJQA9jw9/BdCyOZ2wAF6lJ6nL5lhmqpjD87sp8Wyz+wg64gN4LfCscyxz0R2Oa776
         g4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCX3wf8abBbtPVZ3rFg3epquUPPSLVVnSWzY7VGxnZLwW+ubKGH29Bjfy5pbqjMyIAwnsdraxFFDChJM20r+bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6/83Ofl26VNgJp0BwNgt8cMjIUJA9dlI3TTMntG+eIBQoOHD
	T/gAgp+8kDYQLYslWbr33hZHx6x17EfXGBs1ZiaapgpPmZGhGs4ora2vGxBUIwZDyN5jjC/alt7
	zFnfR8S3YHv2rdRrPfWxqWuWIsZ+8Okb5IRTL1qMj9dHBwUp0JCfbL+lLd5W9xpnq9YNzQw==
X-Gm-Gg: AZuq6aIEzxVdhjjAmetrJddlXcCqoY8Kj2V7cLfXVaK9rIJLNBm0HblYt0h3SNnmu/o
	vgHGN3FkT+0C8mjh1QZIkVIv2PU0/OP4a2fqrZ4CwPdGfZGz49r+xA9e2yu02OU8hE7o2FI6lZx
	V50VdioMZN4BmJJBJG2NkjY5RxpKQvv06nN+TM3cDKBm964n3hP8pxOCAw001Oq+Jo22PoMLUg6
	ZHezxScpspuIGTnUENlQfzNmKDED0qI1SJmqLf9y5agqN/FlwsoLKyxeROL5HbIIGJJnreAFrUz
	T/ToKQb1Q9Eap5SSozpd3fpTRIrcLvlawkqOVVdpLfb7MoQJcoF1F3fEPgmVn/KGNxEn4lISGTd
	3joJUhaHHQ06Bg24a2PPVkVtin+S52xRtYvBEtt31RAk9oi64qgz5FPPFKs74ssfRdZ9t
X-Received: by 2002:a05:6a20:7485:b0:366:14af:9bbd with SMTP id adf61e73a8af0-38dfe7c965amr15559369637.71.1768989070495;
        Wed, 21 Jan 2026 01:51:10 -0800 (PST)
X-Received: by 2002:a05:6a20:7485:b0:366:14af:9bbd with SMTP id adf61e73a8af0-38dfe7c965amr15559346637.71.1768989070019;
        Wed, 21 Jan 2026 01:51:10 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678af047sm16997295a91.10.2026.01.21.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:51:09 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzk@kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH v4 ath-current 2/2] dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name' property
Date: Wed, 21 Jan 2026 17:50:55 +0800
Message-Id: <20260121095055.3683957-3-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
References: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GEqVy6KS28QN8jGCahyQE27_F-I7iPJa
X-Authority-Analysis: v=2.4 cv=Oa6VzxTY c=1 sm=1 tr=0 ts=6970a18f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gumsBO624h-QSWVlTkIA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MiBTYWx0ZWRfX8AQwkPw50TYk
 KkypdsiLAUfVBblbawZ6XtsLbnNqE+2qeFYzcge+6/Utgg2Hy6+KWUchoDnVT+iaXcAC3JQoKBI
 r4eZKIoK5vTsDhvnQg9X3ZoKXV2JgKDXD5XA00Sm4F8lLLBE0jPMOt+Xe9hO08L/uViYsYO+RPO
 9jxuFbfHXMnXA/LCyZ+RH2uuwYsH9yF/XkzDwfOumZ5STe3fC42pureyR29w7jxrDKrzGzOJmMu
 /Te6PfDOCu8Hwevepgvj0LiENVehsvQJVSFT4mUpvR3T8iMOkBUgxFrcfqlv14en5UMG1UOwG2l
 Uzo6r6TjSuQ4+EpWGvJbuuyr2VYUcQkjG5Cl+Y9JBRd9ZKu+fei0xB27zkyjtyOkCv0+F9YtkEK
 dUyRB4fvT352zdOUxFtOZcyBi6QfxoYY5oHpIE+dsFMkRoebE+J8iYmY9d7cjMsmMDU3zEV0V15
 qCehoBz/WLB61PeRqAg==
X-Proofpoint-GUID: GEqVy6KS28QN8jGCahyQE27_F-I7iPJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210082
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31044-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AAB0D55043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The firmware-name property was originally introduced to allow end-users
and integrators to select use-case-specific firmware for the WCN6855.
However, specifying firmware for an M.2 WLAN module in the Device Tree
is not appropriate. Instead, this functionality will be handled within
the ath11k driver. Therefore, the firmware-name property is now
deprecated.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index e34d42a30192..0162e365798b 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -37,6 +37,7 @@ properties:
 
   firmware-name:
     maxItems: 1
+    deprecated: true
     description:
       If present, a board or platform specific string used to lookup
       usecase-specific firmware files for the device.
-- 
2.34.1


