Return-Path: <linux-wireless+bounces-31680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KevJqGbimmDMQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:44:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAE116631
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 518DC300C307
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F9E2E0914;
	Tue, 10 Feb 2026 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPy/z6/8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWovgopy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15132DC339
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770691487; cv=none; b=cuiAWxBji26aXZXXUKM+VXfr1t3U7Uiq2qsmt7li2NSj/cukohCCsFVxwLa6DvyA0WGsjtcdhxy5rGubZePgjLem36OFcfqAyx6hhHiJwWaeaD7NIQfxT7kRwzGnk2qFiJYggVOzRUy0xN/t+pjwSjg7lpuY1on0m6WwAYPGsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770691487; c=relaxed/simple;
	bh=q+/NbD63JY/ZK7/EmHVPqsMjWB4mZV8/ipy+dWbKNeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kwZItS4xntKeB0JJEL+IqMLcmhmLg64yUnIiUF6990eNvjpza9OwqW2unsjI7xKYxE55M5ud0t7yPxMznch+ozuxLuAzo8feLws4l7N244S6uDu2PznuKoM1lmVeTqgIMkzYw6VeWLPs4N+gi90ZEyUTQpd9pqFwxhcD79POUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WPy/z6/8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWovgopy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619I5bMk3700007
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6oX3bVTmNxU+vLhGk2hyLQm1uGh8KjppfX+
	Vzhlvkr8=; b=WPy/z6/817WxLGyKeWO79Ibk//CcAN1vPQFFGx1tV0TwxYb6xfg
	Uc3naF7ITXqDANq6NhO66kxi7cCtLmc8QiCM31+aiZ0YYwpuP1xcxPmdbC8IkE24
	bmnsSTFu/uP8a66Q4CCUHIFPqSnSlevkwpdiJmwppsCMbg4BvTd0xtP0Fmw8Xd5t
	h3kqEfSoB/ayc4QPIc1dxY5BziZTp4IdFbpxFLv7CiWRXfo1FpzBMlPe4iwtER4H
	vRL+FmlIfzrq7EfiNKyU2VcyeyGvdECWlMe0QMuLsXn8C4ZXg7LgWibe0urOi3Yn
	5R52rlnxwHKT1oizHohom5INe66aSGrvvcQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4mawux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:44:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba66faa692so1521258eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 18:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770691484; x=1771296284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6oX3bVTmNxU+vLhGk2hyLQm1uGh8KjppfX+Vzhlvkr8=;
        b=GWovgopyyS+xWK96MfefTpXFnPhT6LXTZhprNcyS6hO2SEYjdaPfb54ep8mZfO6IL1
         J4XvUBxd3m7kkV9ForpM8n4v/6yhGeNekU0V/0hb/vUJtzqDgN4+3GXz+/9dH4e/nD+D
         L+LXI4ABy57JQqLhP0fYBVpNH0MJzdP1IkyL1/6LE9S0D4oAld8YUpngQHioO8EpYA8T
         Q5rJTNGdoCE/6WekmoON+jnelt7qCd8C3vGbf33pOY+rY9fC2UH78g0Ce4I2D0gvzobx
         /HKgJ/sYg8QCJ00282bIXai+zEApJd59wwkF1f7CKaM8jzvlehwccbkAUVSWbJ7c/pSt
         XwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770691484; x=1771296284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oX3bVTmNxU+vLhGk2hyLQm1uGh8KjppfX+Vzhlvkr8=;
        b=lFElT6CbdsHFXEo/dttrZQRw3Csx8wq8Tpzcu7Z99TLRHr8WGCuwUhV1l3LbvrkLMz
         eFtaS90UadPgmVZ4mAk5dYQ0BbgzCDw518UIro3HbYXfU+g1ELk+3AHSv4yk9K5LzNI8
         vl4pmAZwd9hBnsGium4gJUeRqU8vWFUHDjR5Lecx3e/mL7lM3DPbXhsBjRg/9X2tl43U
         Kgj9uh+cRHMX3GB6y+Ri8dfuItd9ryc5OFyoTvxQI755rjLpnuAu0Y1dmmwoMMRAdqH7
         jiVYE5+ogJnKI/OIfq7samlpvkydXdnet85J4hBRlFPBdZc745RN0/fPhVtGzbFX5GTD
         NPeQ==
X-Gm-Message-State: AOJu0Yyg98qPtuDt41Ba4OnnEW6RUpROtXwH7/2vB6zx6NKO4da9Duwt
	2/7fyrfLkdafLNeHTutyEbJ17l/SuMdKWdm7sN2TReX1gfS78eEgFADAxxuqxtnMbSnODJkRrAR
	98O1Sb/ujTYA6j+dbgdOYWQSZ0MSmGTcGTsMRalVy/91F97qgHuihtkcw83uGFt8A6zXkpIxTiH
	Q6XQ==
X-Gm-Gg: AZuq6aJFodR/NLhYCCB6iWaDwk2DotBIKJQgtmFpfMeL2UtY+Gu58xosdVlzq6nzO/n
	HeVjnrEkQrqtHjoeuxSDhhyaq8ZTSQT5PLRvLXSQ+mBNdSLhenEi3GlI7cyl2vcFaCYbud6bIm3
	VtAjsG+qmdJCTKM+Mvgx9kmfv6WEcWbT/c72ltjr00MgQezqosiEhUa1Pib3j7eJfJ7QEL6Wwml
	9ZY15VozIi/Vbhutw5LrxylgSWjn/COmSXbU2mYFgPsOYyqj21b1/XsGnl9M/FT1UnDs8JJOlRy
	WnE1P70ip1L8+HyF6/weFwdbn/+53nwfovRVk335j+h4zY/t56qTT9BpjjIxbMHbaLmMmjJobof
	BgVQ2YgoMQbGr0Je8aG7hP/B4BhHvfqmH59oehbYGSoUxc+yXqfq2x1JYQMXtKYfBM3rzcbXnPr
	12
X-Received: by 2002:a05:7300:f602:b0:2b6:af85:dd2d with SMTP id 5a478bee46e88-2b856833be8mr5762293eec.32.1770691484146;
        Mon, 09 Feb 2026 18:44:44 -0800 (PST)
X-Received: by 2002:a05:7300:f602:b0:2b6:af85:dd2d with SMTP id 5a478bee46e88-2b856833be8mr5762285eec.32.1770691483568;
        Mon, 09 Feb 2026 18:44:43 -0800 (PST)
Received: from hu-yintang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba734ed83csm3143196eec.23.2026.02.09.18.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:44:43 -0800 (PST)
From: Yingying Tang <yingying.tang@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com,
        yingying.tang@oss.qualcomm.com
Subject: [PATCH ath-current] wifi: ath12k: fix incorrect channel survey index
Date: Tue, 10 Feb 2026 10:44:40 +0800
Message-Id: <20260210024440.3422264-1-yingying.tang@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O-hgW5e1Jfh3cx4nggPfbU-rtUWh2B6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAyMSBTYWx0ZWRfX8RhFdmXOawCb
 nhBK2ZAP2Vi64eU3xOdpQ93QMHuDbKbhOYHBbeYie1GFJsHamnroQHvTcMIaBFFAx6YvfdP9HDs
 oUhOYGd+cuSzHriL2afqs1Ulw8riL9OKilFQV5KS964FuF7+zkYJs+EilbqTpuv075wuNyGRcfN
 DogFstQDCf58DKkAezTMKfEX9MkS0OCP2tRZvTq2SnjzJT5i2W06mMWp1Pys7L7jja8pbNSt3VN
 u2IDkS3UBX6QZIZCUTyPQ0uJoTEwsiHtIJzyFx9ayK4gk1RZwGVLoJwitPN/AGgSA/2GWLhL0vo
 dP3atq5SxFqK589B8yQYZB7dGgNTR6duAeJ9hzMyr6G4C7PEcFn30zzpDNaz+G7h+dA7S/hiqnq
 2WtsNIDsCA54+Gf/oIttKmoXnXEtXblwI5MgZzbkmYQU5rCnVfheXbnP2FteHTd9vX6ReSbSN6w
 xDvXiKhLNYbfvHYzbWw==
X-Proofpoint-ORIG-GUID: O-hgW5e1Jfh3cx4nggPfbU-rtUWh2B6Z
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=698a9b9d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=qZVxHVLM7CW3LY0gG6MA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100021
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31680-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yingying.tang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 20EAE116631
X-Rspamd-Action: no action

A wrong channel survey index was introduced in
ath12k_mac_op_get_survey by [1], which can cause ACS to fail.

The index is decremented before being used, resulting in an
incorrect value when accessing the channel survey data.

Fix the index handling to ensure the correct survey entry is
used and avoid ACS failures.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 4f242b1d6996 ("wifi: ath12k: support get_survey mac op for single wiphy") # [1]
Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>

---
 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e0e49f782bf8..86ce7d87b5a5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -13086,6 +13086,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	struct ath12k *ar;
 	struct ieee80211_supported_band *sband;
 	struct survey_info *ar_survey;
+	int orig_idx = idx;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -13120,7 +13121,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 		return -ENOENT;
 	}
 
-	ar_survey = &ar->survey[idx];
+	ar_survey = &ar->survey[orig_idx];
 
 	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
 
-- 
base-commit: 1cac38910ecb881b09f61f57545a771bbe57ba68

