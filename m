Return-Path: <linux-wireless+bounces-34755-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL2nAJY132lqQAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34755-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 08:52:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 563AA40116A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 08:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B912F3034A26
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF325392837;
	Wed, 15 Apr 2026 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZqEK2fX8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xz6AIXzM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766ED3921F6
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235917; cv=none; b=ueGDu9JRHuJbjn7m04h6fnVgnpWuNwX4pSaJp6MRYxsJo5SyXAWjdxkfznmUqrSVn0hCtTknGkiD9UESBXT9hmUZDpcP87+cw0RFrgayUJYFxO/GzM9HlXC+LFj6nLq+u/zbcONxLK/Xd0osY97BWF9tR/iZEJCiRuKC+J5UbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235917; c=relaxed/simple;
	bh=BuSYjlZZlNzROOQdwXYJoiyO4szbc+mA6ON6GoCg6JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DxfDcywb08q1bd8HfFXkWdY9XfMPSzF7KPJAnwrhbAjJUSa2PSARYhQ7cEp4ugIZ0rH05oB+UguG1y6xYlWBr8yQLg1axp7hjxmE7iakkvOOYOMYv7yLXXwg8lVq36JykXC01FHPWFEzd666IoUl5SMWUJcCmvm/bKnq7W50H6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZqEK2fX8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xz6AIXzM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F0WdwV3936607
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hbs7vrxtLV5L6zSTwOywEn
	d+OfV+maVKHdmVyxIxnr8=; b=ZqEK2fX8+zWNoBqILUn3HyAg9aepp4zXq6iAoW
	jV6JBAYPzfuIW0hNrozgUsSpWbr5le3ItoEvLKOiuk2SKvLWveG6WgZEEZGboipd
	k7gI2y3Xy/9BNQSHsV7Z7q9K1afGksBF/dBwkqbZFXxY4tGJ7D4E5ZT3Bt1L7258
	hnxqLs7WcaYylB76Y/6ohlcwrEsLzFbdvHi5c6sPt7qFADlQSrJe1CunKK3A2DaU
	wpb8BzLr71rpEFrgUzAlv240EjLNH4yta8fRPoVsgYo4VnyEX0lcL+2V9JPifhpw
	uRf/xNYO7Zp6WogOSMUoirVzgRgSeCWKnjFtO/fj1lFNsV4w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrbf2j7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:51:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242062308so118293955ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776235915; x=1776840715; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbs7vrxtLV5L6zSTwOywEnd+OfV+maVKHdmVyxIxnr8=;
        b=Xz6AIXzMrpiMWQ6kuA6DGeiFX3dKUNaSlG2cifwV3mG5DMbc2uA91E7jtcj6dSNezI
         961x8K0Er3P867LrsBMCmYcWxzzZRl2E+6ZkUuz1g/eY3UiAbFdkSedUueolRAfeNORV
         ETaoAJ6BZ1SrMhNJaAW2i/SP2RIJsEgSOI+yCyBHs1MMyRHNnt4VZzTK28N7FCOCf/pl
         3tQX7JxvCyZcL9rDRPi1MzFEIA9F12Qoej5p2rTY9jusBcJGHZFkRFP933VdIhQz2Bg5
         DmVn4CmCOAzYkTWhjEPBjW4rJJ5JQYQ5w+qIMVswLdpzGg1iDMP0ze3uEJ9LS7vKzYVr
         zJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776235915; x=1776840715;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbs7vrxtLV5L6zSTwOywEnd+OfV+maVKHdmVyxIxnr8=;
        b=a5QmEFN4S7qxsTsJYGgTjlT1O5oy0NmfeotMp0Sd16Z9opQxXqBkHQoEc5DI9E3Lr7
         b66Ix/ht0exBNdxx9zTebN5b9IJLZm89FxclA2o/SnILvlMX2HFglNpERk4DWFwwLIc4
         n4J1LX/ZLjHU1BQD8qFsA2xMIuzOx7KtAbS4ZcG09rjCK0wuuecFKU4M8T9Lti7XY1Mv
         E96zn5F28lT9e4c4qkosZk63UCT5fwNUu9xYMn794LkemeUvopjEyV1sFUWF2zzhouoB
         ZufZMULxXgnHebwRE6iVi2LtoeACMC/ANpZpySTmeZ1fNz35E8bjTviJ512GU0N49Jyc
         C7eQ==
X-Gm-Message-State: AOJu0YxlNxzBnrHRyY1Cd1TyjRnwlm6ygDC+MAe3Wdiad66ErzdbjF2e
	PDtzuFKyv0OGNYBScNefMkeIfemaffBeaL86IqxxwWDWSlRgiue2uh18wcZr6Ftjgfd6p4XZw9O
	WEnxZ5ChllP9aGxkAJLMCEa4EdelwKXtswasJfJdg08pDH9aIY3ZU6y3lKthUciGNnMQ+mg==
X-Gm-Gg: AeBDietZgzSXdLn2vQjkX5opGiRO5lbXd5wT9AL3a6vUXNmX8kGDL6EwTVuuwzRGyIJ
	AO+LD+vcbRDuB11sfk1SbiXOQ5qqdesXLVfo5maN/hTNXABJXhXLoKMiEaHmJ8c2TvtFuBfy27a
	GzuumQmQYr0/yHmDg9Ualj11xN/9AnzGXy3x/jhLuDyOhDLRKNnq3F8e+nIeuoc2liTphpoHTwh
	u7Q9fQV2pbVLYy0GSpEJOL3HynYwp8iKGU//JGzSkTcqtln1zP1YEjv2A0fPeAR4yPUKhLVI7P0
	UYzlkUxchgI97+5xqAzSu5a86uL+DaGg4nw0cWYTB+dgqUOGuJF98qEGjdbwmd7nY4dGl5ShWxB
	b+YDVrNyFMRxHN/Z5M7eSPL4/N90Io+x9EBrGqoCC6evZn6shUW4EsLMqr03L4brK/MV9G3Ay82
	FUTE6blDyTwwLjk5ABtAhv6zVSVMqDPsPHFEa0KPqfTxxP4lNRzlIrvA==
X-Received: by 2002:a17:903:2ac3:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2b2d5a7a85cmr202325595ad.40.1776235914845;
        Tue, 14 Apr 2026 23:51:54 -0700 (PDT)
X-Received: by 2002:a17:903:2ac3:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2b2d5a7a85cmr202325235ad.40.1776235914240;
        Tue, 14 Apr 2026 23:51:54 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782acaf0sm11222425ad.67.2026.04.14.23.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 23:51:53 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 12:21:50 +0530
Subject: [PATCH wireless-next] wifi: mac80211: Fix ADDBA request rejection
 after MLD link removal
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-addba-req-v1-1-6eb9a33d8ca6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIU132kC/3XNTQ7CIBAF4KsY1mIGhlJx5T2MC35GJdFWQavG9
 O5iN7LQzSQv7+WbF8uUImW2mr1YoiHm2HcliPmM+YPt9sRjKJlJkBoQgdsQnOWJLhx0i75V2pv
 QsLI/J9rFx2Rt2D0mOlLOvKPHlW1LfYj52qfn9GkQ0+gHOgguOCKGANoAGrfuc15cbvbo+9NpU
 c6EDfILKBA1IAsA2Ajn2p0EB38ArAFZA/gBpPJ2qUgvrfgDqBpoa0AVQDXGNJqM1S78AMZxfAP
 Q+R6wewEAAA==
X-Change-ID: 20260330-addba-req-0673c746c9d5
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hnaraaya@qti.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: djJi7E54O-Ovg3uN8ElSTOemF0i3hu5t
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=69df358b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=o482_rHu_BYNnXZE7OYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: djJi7E54O-Ovg3uN8ElSTOemF0i3hu5t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA2MiBTYWx0ZWRfXz1JqI2qEz5cs
 NHkALwpCk340aTSik5SbPEx9xIKphBN81b0f1OXq8LeQQsjil6XfVRaLsQS8lU0YatdzWBGHXZC
 h26g/LDMPQPw5w/ybWm7jr1tj2RJIktOKB6kj9SV7QQLpQsQV/1/Bvkde+kwR/MOHsVNYcfLyoR
 aCvXkEBPed+qEkH4G7VIrX7yOBsVFMMiol6Tz0t05Lcv2S2M889hM2nyf+ofLKTfZN10XaWb8Kk
 1E5fsW5Irqx6eWNz/+CSPSJWEOAIPbEfAs0q9sjW79FSBKAB7gZQak/kOEPeqMYY0idsXPxif9h
 9BKSn7rYctTvEddXFlp+y5KyX1rXoIqDkNh5SVyTFHW4X+6VrQrDPSVciSRgY5+kLEjSwYsjyOs
 5tc6WwjTZx4kaTCRmPYRfdx9UE7PVJBLeqB1irLBv3wCVGOR8OsYEUoVZBZnpxAfSHSAK3qpDlq
 xF8W0mpHefGBlXgydrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150062
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34755-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 563AA40116A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hari Naraayana Desikan Kannan <hnaraaya@qti.qualcomm.com>

Subsequent ADDBA requests from a non-AP MLD can be rejected with status
0x0025 (Request declined), preventing BA establishment. This happens
because mac80211 checks the per-TID A-MPDU session's tid_rx pointer to
detect timeout changes on ADDBA updates. For drivers that set
SUPPORT_REORDERING_BUFFER, the reordering state is owned by the driver
and tid_rx will be NULL, causing mac80211 to incorrectly decline the
update.

This can occur during MLO link reconfiguration, where a non-AP MLD may
remove one of its links while a Block Ack (BA) session is active. After
the link is removed, ADDBA update requests sent on the remaining links
are rejected, preventing BA establishment.

Fix this by calling drv_ampdu_action() on ADDBA updates when
SUPPORT_REORDERING_BUFFER is set, so the driver can accept or reject the
update based on its capabilities and allow BA to be established on the
remaining links.

Signed-off-by: Hari Naraayana Desikan Kannan <hnaraaya@qti.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
Note: A similar fix has been proposed in [1]. This patch also fixes the
issue mentioned there. The difference in approach is to keep a similar
flow when the dialog_token matches. Previously only the timeout value
is checked, updated that to check the timeout only for the hardware that
doesn't set SUPPORT_REORDERING_BUFFER. In [1], it was changed to invoke
driver unconditionally when SUPPORT_REORDERING_BUFFER is set.

https://lore.kernel.org/all/5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt/
---
 net/mac80211/agg-rx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 0140ac826b23..20c849f7930e 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -376,6 +376,23 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 			ht_dbg_ratelimited(sta->sdata,
 					   "updated AddBA Req from %pM on tid %u\n",
 					   sta->sta.addr, tid);
+			/*
+			 * For drivers with SUPPORTS_REORDERING_BUFFER set, let
+			 * the driver handle the BA update, as it manages the BA
+			 * state.
+			 */
+			if (ieee80211_hw_check(&local->hw,
+					       SUPPORTS_REORDERING_BUFFER)) {
+				ret = drv_ampdu_action(local, sta->sdata,
+						       &params);
+				ht_dbg_ratelimited(sta->sdata,
+						   "Updated AddBA Req result %d\n",
+						   ret);
+				if (!ret)
+					status = WLAN_STATUS_SUCCESS;
+				goto end;
+			}
+
 			/* We have no API to update the timeout value in the
 			 * driver so reject the timeout update if the timeout
 			 * changed. If it did not change, i.e., no real update,

---
base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
change-id: 20260330-addba-req-0673c746c9d5


