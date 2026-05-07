Return-Path: <linux-wireless+bounces-36052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CuXG6wW/Gk0LQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 06:35:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D53014E2E40
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 06:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FF60301982F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 04:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210E72EAD0D;
	Thu,  7 May 2026 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g36vbSuH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apBuASVL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05372D0602
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778128552; cv=none; b=DLABkP8VMWrjyOQ8oaUqUv3iKmR8sh2XHi8xON3a3XskxEGSAOPUqA3X9umeLEI0bTiJhpjHbFMRz3ZttUrpScw7XrSYTE+LjlGlz0tQb+0/3xCo7PDJ/blNW8NgURQtxccDl1xlmOSMywYhmfFOunNKWHOUGjWXZnNyQ/id0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778128552; c=relaxed/simple;
	bh=eH6xA35rrZZIlhrP/HthdGfmNTPeRZ5BxmnGssJplwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huCUHmyJf0fdrdaaWlGXujMiUKIwcnD8YGdXmPn4ub/sBDMpBZTPROn9/XWHVc+n4QtE+m3KmqH9p2cxyLOcbc+l9O0VC+RN2XE5n7fqKB9zqvmcptPSAL6U7VY8vnhDIEcaepwiHM7BfSxXiZNNNKraZZce/82Yl7tWfA5PLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g36vbSuH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=apBuASVL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647442LW150997
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 04:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ruQVtWuvbWXiZDcvVPrTAqUnZO0qlxn6z8O
	rFS8ezEE=; b=g36vbSuH6F7W8lU0qFFgfqsuFQFSQ+NhFiSokmhlRkRxpiI59SM
	hq2r21+JAyb1zdnAKjYnH1LzA3K5vHqDRKUQcyEvPwd7G/S/NG4nkNL3EQHSj58J
	MkHq61KC4jxMYuK1jOcsAPYXixjHXx0QrLTLSJpMNK8pqFeWSgNT+k11Qdhe7a2W
	0tk0WSi47aWBkG16Zmaxz/gTNylaNUPUqNMoQw8iAp7iIuLqWvWUUfWZ5LcAWYY7
	mJoI85pdBgHlDbAzS58lkvLwkbHrjpgf+Jyd6F2UJkPrUOluo2WkWZYeJNJ5js2d
	CvmPTQ01ZoGF36Q5jN/rSX869OoUwBjSDzg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kctr2hs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 04:35:49 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1275c6fc58aso809988c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778128549; x=1778733349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruQVtWuvbWXiZDcvVPrTAqUnZO0qlxn6z8OrFS8ezEE=;
        b=apBuASVL45BcOBeMHot5nikd/OhcrK31m6UFX7FvhTmDLDDedx0qaT2FMxR96tddRP
         UcSCszFWAl7hP15kPhSeh69C1RTFevjZAZDX4spscSjYcsLD4Qw2Wfo82PIdo2KC+HRf
         UCFiqaK3i8R9cKF5RgucNbi+V+AxUVNrDtkFdiVsFCD9opk5RLelvnSIPjXSyMx8bl1h
         UQmm3gqQ4i9EsfkId1dbZrG50lT79t9hVmKwJjf6mg2OkCihYxGOZLEH18hS0SSH1xQ5
         ScX+36/t6eo5NTtJonEHRNVNjFlCu7wQ8X8yggUVsJq8tUN9k0uvgUY2cf9ox+/sFtWi
         bPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778128549; x=1778733349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruQVtWuvbWXiZDcvVPrTAqUnZO0qlxn6z8OrFS8ezEE=;
        b=alD+fBGMrersPgXpPbhqiQSSLC6q5ZKHbDcvW6X3zemOc9BM1RUVFG2Mo8SyRP8afV
         LkGFx37gHz1VlMP5SnV4fcbcHHPkqY7YUjy/mL6nf/j2SjhaYjaSwbLQ7aS8QR0IuEKX
         Q/ighRkOyQMBoNOJeGckxk/cFxNqb0fm+pdmxqYp001ETzGOadWFe0VNutRfXql7MnK9
         CcDHDwzTw+rTfF2Y2nt0+ir1DOttkj0xt1tcYeqUhS3KbSWZTATRPs2EI6LLz6HcKq9R
         uS77xwSRyKt3S0iJX0uIMnZzhTGBygRzT8j5+QOLgncLvJrOnEL+KptqTewSg6n0Py1z
         L4Uw==
X-Forwarded-Encrypted: i=1; AFNElJ9zmZgLFN6KI/WQAdAwVB8KDIK9vx214vUbS50f8aBZXWUMC95iP015zxUrPG0Iaff2Hlw05aJWO/Nv4/5xfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKG3cex+7yq7p+qP91X9nOP/tu0DzB9qK6bxezVHTi9BVuTdR
	9Pzj7MLvK9pJ20nOuBWWl9EKxU22zeWoCv+ECMXMa6NQonQ268IoLsn3PRiPppz7hnVFvPvFg9N
	bXdbGvHoIf95317OMcmzTnWY1RTEafD6A+GeywcU0gk106iyJlf0g58vAHro2Owjhq+VHrQ==
X-Gm-Gg: AeBDiesz9tlDm02Cq12ozWfYuUVjrSp0FmV8/EYn6idpzm9NDi/dAdG7wINVT2kuqle
	B+mY/Olx6Wdu79bW7ibCSyOdW+589VEgNMeQxy0r7iAGbC648RRsWICq0P9FhGAfHOH5DyfKVZR
	7K0fCwrTt6ZIrvPjlIsePctD8dLBJXfzu46FJCnnFt0kg+wOA7d2TvgxVEj9l/PZaiMiuxY32MK
	bQRYygH01zY014TCFV1FNquAiUWVlENYOUtbqqL0jjOnt0dHemU96MLv/2zdsByn/ZVpGZrO0iR
	HvFTjzX0Atlt1gLKAr1o+8sLGsmyK82n0BFrIzBgLLH+iAQ8fgvmR+Z3deDmHuwPyvbBtYb/BVc
	mftsjk6YLqtDu7YEXDHEk43QlC0s4PPLFWA9bhviX1gJ0uRDMkiTZcn7myz9cC129XzyqPhlaoS
	9W5tWb4w==
X-Received: by 2002:a05:7022:21d:b0:12a:8ea4:252 with SMTP id a92af1059eb24-1317d893837mr2888995c88.4.1778128548611;
        Wed, 06 May 2026 21:35:48 -0700 (PDT)
X-Received: by 2002:a05:7022:21d:b0:12a:8ea4:252 with SMTP id a92af1059eb24-1317d893837mr2888983c88.4.1778128548119;
        Wed, 06 May 2026 21:35:48 -0700 (PDT)
Received: from WOSSA.na.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd909e3sm6442727eec.20.2026.05.06.21.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 21:35:47 -0700 (PDT)
From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, rajgupt@qti.qualcomm.com,
        Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: [PATCH] wifi: mt76: use kfree_rcu for offchannel link in mt76_put_vif_phy_link
Date: Wed,  6 May 2026 21:35:31 -0700
Message-ID: <20260507043531.492-1-rajat.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.2.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XsPK/1F9 c=1 sm=1 tr=0 ts=69fc16a5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=w3WHTBj6JGnpVM5uIqMA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: lZ0xJZlHfoTrUEGfS6aIEhul_Gy34XEV
X-Proofpoint-ORIG-GUID: lZ0xJZlHfoTrUEGfS6aIEhul_Gy34XEV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0MiBTYWx0ZWRfX1wDvrJI/LWJ0
 BT/QKOeKj5ok5GSiyGXjTkgqbNHWvPyLvm53yY78g3xPBZMvHnH4t6fGcHp4+nS6U5K9LPJMU0n
 TqxIZKeHxPb8kDCHnYGsx7OQojuUW5Ae9yFuCVeR2FEftr+LKZSulkWCMMOMZvtW9ygyUZfRoqn
 9QT9/t/a26TH8+N73VV4RF9W6Ar40SDn8prDQomxS7i7VzCeG+lCP1tIEIXL8vTYtr4Nc0yT2Sg
 xl3WyqmREaecQXmiwV2kLRhBeNij1usOnRk2cqFd+dGWX6OJB+BxA0l7i/BqLp91OOwdzNRoCx4
 Gykf/vlSRaKzMHbzuEneIFQxRMiuSYcxfKZ5aN1p+RgGfzIwAK66j6MLFjbz6TvBqWsLOEzOeoO
 0wz5aVY7rqQx9hTGDY2e8FGtGOAfYOdO4C1YDkH/Q4s92xQijM4DdRlfNhN5LILz0kw4hgNLhYw
 fNTweq3NTjwX09KGW2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070042
X-Rspamd-Queue-Id: D53014E2E40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36052-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rajat.gupta@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

mt76_put_vif_phy_link() frees the offchannel mlink with plain kfree()
after rcu_assign_pointer(NULL). However, rcu_assign_pointer only prevents
future RCU readers from obtaining the pointer -- it does not wait for
existing readers that already hold it via rcu_dereference.

The TX datapath (e.g. mt7996_mac_write_txwi) dereferences mlink->wcid
and mlink->idx under rcu_read_lock. If a TX softirq obtained the pointer
via rcu_dereference just before the NULL assignment, it will dereference
freed memory after the kfree.

struct mt76_vif_link already contains an rcu_head field that is unused at
this free site -- a developer oversight, since the adjacent
kfree_rcu_mightsleep call for rx_sc in the same function shows the
pattern was understood.

Replace kfree(mlink) with kfree_rcu(mlink, rcu_head).

Fixes: a8f424c1287c ("wifi: mt76: add multi-radio remain_on_channel functions")
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 05eee6470..6edcb3b8f 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -307,7 +307,7 @@ void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 	rcu_assign_pointer(mvif->offchannel_link, NULL);
 	dev->drv->vif_link_remove(phy, vif, &vif->bss_conf, mlink);
-	kfree(mlink);
+	kfree_rcu(mlink, rcu_head);
 }
 
 void mt76_roc_complete(struct mt76_phy *phy)
-- 
2.43.0


