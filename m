Return-Path: <linux-wireless+bounces-38636-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VKuRGlqTSmozEwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38636-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 19:24:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6783570AAC6
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 19:24:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gYrvjScA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iS4RKWHP;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38636-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38636-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A311C300F0F5
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441232F8EB1;
	Sun,  5 Jul 2026 17:24:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100B2853EE
	for <linux-wireless@vger.kernel.org>; Sun,  5 Jul 2026 17:24:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272256; cv=none; b=Tacc1Z6PeqXVXtIUekCj2/Nhxm4hUK2Hzshqwf8qk0GigxyIpl4FkCaelSM6R/ZU1EY+u0uhuyBU/pWErcgs6k9po5wM9XDKunGncKFUrKRdGewCMx/v09GC4RsJSuuSHARg+ZJfhZEIEKolL3dn7l7EzKBApIDqdexEp2gG7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272256; c=relaxed/simple;
	bh=uiuszvPty2XQ6RIkE13BPFdZyUPom/HeObIFiARKQeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IG+PEROHAmjOZI2C1jmhy6beM/tQ0fFjkluntsHx4Xa3T320z37ujZ4tgNEQ/meSFsEjjTrgX9t+jSXXtOEdFYO9TPc8TeQjzSuwhtb0KS8gpOG90cwD5QKZ5S7wIlGwzLNa56fcUTdrhMstJb+hQmcNon7VqTkIAUcMEC37zQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gYrvjScA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iS4RKWHP; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665FL2nC1981974
	for <linux-wireless@vger.kernel.org>; Sun, 5 Jul 2026 17:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TwGRgga0mvc3qxnE3GKPjOkFPsDuJ1dPcXE
	FmaTASCo=; b=gYrvjScAPeDdg3iPTLNnZGPvH+No+rOisiyhui/H5hbmSIWBzlD
	g8PAAdUy3u7cGna2v8QLucNAWy77y+yHBvQs2o5xqcAZeF3/zyiw55lojgYULv5k
	k0uaK12pJSJkoPfG8wJdzJF0gZ/k3RIbHCAHwK+9jvzRkKEVGYjfq0cVthbZ1bL1
	IDP5qYELibXol5V99z+TT1A31/NJYcMKTjAl+sCTOXOBOXO2oWTkpZ1vE+tetGek
	bQlvi6akC8+PhWSyKCff6ATrUjTe6mWUtprymeZi8O7ranrAJDF1dW4If4Oqx/3A
	/Hcs9FRkj4HRq8TXq+cFu12BTqXNP5nTQGw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnkd75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 17:24:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e55721a8cso215136785a.1
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272253; x=1783877053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwGRgga0mvc3qxnE3GKPjOkFPsDuJ1dPcXEFmaTASCo=;
        b=iS4RKWHPI7lubmSysVNJFtvdv8l6zxrY/jU6VWdH9aJOqPZT1HEnEjZ3FyC6xBAbzt
         O4zUlIa0NAMtM1CuxqzEJy6R1Wphc1S7C87OKSluQVJn51G8VlAjYjWVaqzarJIj6z55
         xpT0F3znQ/WLYu2qc/QN6atTVq+feqd4AR4nDgWhot+nq2WTdYnRORNyHDu4/F6hEgU/
         kxOgHto8A1z6O15jJFMv7ys7pilm/9hez6fydW2bITDt/ITxYmGqR3kfvGBPg8WJArxy
         x8v/VV5hqtUysg1E8mG6nsc6psVIfm+eZeeos7iFsLHQY4Flx8AC3ndPutT165I3Y9o1
         7KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272253; x=1783877053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwGRgga0mvc3qxnE3GKPjOkFPsDuJ1dPcXEFmaTASCo=;
        b=g40cXR8ztGTj2+p7cijcBahoBDMD6DYl8vFGsspkBFU5bKOPO/76Bo0Neacappjls7
         USVqXs0Z19N7vcsT5QmEk/+XQygHF3fv6hiIu5hhxybSxYO7NKwHD5FbvtVxCGCYZ/hw
         Nu42C7BHox2prrT9GndIvfDhTuRgiWlLt2dliAeY9YzZbK2QJ2UE6YYQDpXY9xgBFIIN
         qv90dVVuAOuz/EzBAWoNgut2vgmg0l4gcss3ESG4Fo9lp9WD1RBvCTy580M5Kz4TpQyu
         2YwD88TaZASpGkRbUdO5+4W8R7AmyTFM1CRuF83OpijC2MlnvHfn+l34au8MbWAJhHA3
         xOdw==
X-Forwarded-Encrypted: i=1; AHgh+RoAg1hIrZAsMdsqjwMPh65njLpwu1B3UOiqFWoOzRvzNnNG9AKwBr9TSrEI+Cxf7jH4c6KgKNCIvbGXZ4pT6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4iMZanTnyXBUgfbt2V5h6+540+as3AKOkVLQCtSUt9AYIH4Zi
	hEzQYVfnYdFVp5+Pf1DuifNzBokXFKItnPdruzSqfXCXI7lTmLVBUzRXdLySNMpFH3MSqD9acBZ
	HSHPWgo3qGCZqPPgyCv7WlPaSdy2kPsJgQwcu4VPb516EIDgcAcYr39mm2lkn6XXiIPCTXg==
X-Gm-Gg: AfdE7cnEBlkXE0fdO7FqsSQgmPJutXSxG7wCyKcsBEAHn0J3Z/zmMiRoJdjvSMj8oGi
	jpqFkPcF6nCD2SUSLnsUTnmg3Nda12PpV2xKF+oNj1DFykwWsdw5Ea4W7JK9r5xaYeHDUY/xEdr
	43N0CcxFhTRUcuJKO0xD9blwUmP1ewsir9wpKfPx2SUNzIhPaMY5rgaFQ5Ie0Qe+IRUBrU2i597
	g5RnPliIUqQF77A9EIBpAVSQN/IoUukD69sXqd/+Rped8U4U6ddgc+8HTD8tCIQP/CjJeyncSbv
	BMXjYfgZH8R6xg+80zLCYghGViyiHiZHYMzM7Ff/OqlfF9rkFcmHm3AEKYdEfVNv+Cw9RrU62gj
	z4I6LvPTGcVrIKUiJPvPjsYWkIbY=
X-Received: by 2002:a05:620a:31a7:b0:92e:7a3c:add7 with SMTP id af79cd13be357-92e9a3753c6mr953329585a.27.1783272252730;
        Sun, 05 Jul 2026 10:24:12 -0700 (PDT)
X-Received: by 2002:a05:620a:31a7:b0:92e:7a3c:add7 with SMTP id af79cd13be357-92e9a3753c6mr953326685a.27.1783272252305;
        Sun, 05 Jul 2026 10:24:12 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce11497sm226179235e9.12.2026.07.05.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 10:24:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] wifi: ath10k: Drop redundant NULL check on devm_clk_get()
Date: Sun,  5 Jul 2026 19:24:06 +0200
Message-ID: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=uiuszvPty2XQ6RIkE13BPFdZyUPom/HeObIFiARKQeg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqSpM2+LM8QP+1/e2Ud2aU+CQkyPmIoe4pSGmg9
 kS5UteLYOSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakqTNgAKCRDBN2bmhouD
 13yMD/sFY1waNaWOBExVMy8wvWVtcfCXDcfyhUBn7iqz3dxvgnxrOP7ABcDvVpJeIiwuiUm1ks3
 nMfS8hIt97Mj0nr2rlldAl4d+mRx8z4N0pP5lM7U/KQwhJmBDIq9qyGHDgP6yo0kdRU4nRfzNV2
 snt6ZpoZuTs39Ed9x92ToX9P0etnK9C9wqfwsbQkzC1wSjRiBgdk+hS+PaK1BxrnjFgbytxW6QE
 fz8YkLDgTYusXCcUXO6Pw/hLhtzBBdGThE6fotoZCjp65z0kXmX8GEXIlecIVxzcUijKMyYcdpW
 A5PTcprY125w0KSKy/rgHIfe9XVZVbluLKfaUnMyODm7nLEZzb029wIVZnuJ39deeUaTyHpp4gQ
 AV/6XtHk3tkjqca0oh5WUMDhCr1koromJLqha1htFyX5+eRAVQmQMPMXVxbB6/v8m53QjT1ua66
 LZquemYfvCEADJgjisgLLdNXlMkSg9aEfig+MQ0zew3UEUvJqh7XgnwewA+mpogyJNS3JSv1u2y
 nG0aVB6R0uDqXidkaUpQedgaxpbJB9Qe7CEhjdg3PI0JEWtMW64AZghfmY3NjzCs+Eqs0ZOjD/u
 7cR1rGl0Nx495BoKtH57QhagWhjz/wQEiQBvfxGddWWcEC9BzzDUmb+NFda6/NYYi7pBVFymAFo +h4aR1jS6uwj1rw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfXz+qPt+l4/Y7s
 xXKE0hDl+9XAhtAwRBvCQKxXj7imAiwW2Swgp01Jo5sD5kGNrEMyVCqyGKOz6C2BmVZTH5VomD7
 /aIDjQ0GKlJ+3Eb/szR4p/oWT13QE4A=
X-Proofpoint-ORIG-GUID: CqfFNuW0I3s9ZSjywUWJ_gZH031kB0G2
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4a933d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=WP6Ezjl_j04BIvCI5BoA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX0ThF8q2I4vLA
 7MgZ7KAHVZN+4b+IilCySDLMaRP5oVBEi0EifwEhvf7wQWjglnS9SqgL+Le+qJQ6G4pi00ZIY4T
 YhDbsJyW6o6KwoGwv2/blCjqGp6RuM4pY+7oBR33tJhlPiFnh6L27MCT2SbUvimWmzz3YQHSkux
 4+E+odXZdiE6g97SJFkq/1OgNgP23lbPQSpl0HzprdpdekzUlOGfoFCykETGWljU+Crn54auCf4
 AcgnHQub1ONsweEYdf20jd03cPgHG5opyBaK3R/XgTLp4Q3kLbspZcYPh/5xL+rOKe7VWkcFKWb
 Deu9GNwYh8w8uwXXFnkFSsGvGv0ozJ+HLlvWPt7lqXQE9vM9XwXxMUsAWeKYZrFDjj8HN1/6O/b
 14QIy0z+XNH+4rJR3CNSY7mb1o4AOuqHdxFLIFj3GLyNNRnV2ARDaU711Gk1TselgSuF668lfxe
 8TnkgQp0bRk/pE6pgPw==
X-Proofpoint-GUID: CqfFNuW0I3s9ZSjywUWJ_gZH031kB0G2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38636-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6783570AAC6

devm_clk_get() does not return NULL (only valid clock or ERR pointer),
so simplify the code to drop redundant IS_ERR_OR_NULL().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index eb8b35b6224d..7456f885d2b5 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -87,24 +87,24 @@ static int ath10k_ahb_clock_init(struct ath10k *ar)
 	dev = &ar_ahb->pdev->dev;
 
 	ar_ahb->cmd_clk = devm_clk_get(dev, "wifi_wcss_cmd");
-	if (IS_ERR_OR_NULL(ar_ahb->cmd_clk)) {
+	if (IS_ERR(ar_ahb->cmd_clk)) {
 		ath10k_err(ar, "failed to get cmd clk: %ld\n",
 			   PTR_ERR(ar_ahb->cmd_clk));
-		return ar_ahb->cmd_clk ? PTR_ERR(ar_ahb->cmd_clk) : -ENODEV;
+		return PTR_ERR(ar_ahb->cmd_clk);
 	}
 
 	ar_ahb->ref_clk = devm_clk_get(dev, "wifi_wcss_ref");
-	if (IS_ERR_OR_NULL(ar_ahb->ref_clk)) {
+	if (IS_ERR(ar_ahb->ref_clk)) {
 		ath10k_err(ar, "failed to get ref clk: %ld\n",
 			   PTR_ERR(ar_ahb->ref_clk));
-		return ar_ahb->ref_clk ? PTR_ERR(ar_ahb->ref_clk) : -ENODEV;
+		return PTR_ERR(ar_ahb->ref_clk);
 	}
 
 	ar_ahb->rtc_clk = devm_clk_get(dev, "wifi_wcss_rtc");
-	if (IS_ERR_OR_NULL(ar_ahb->rtc_clk)) {
+	if (IS_ERR(ar_ahb->rtc_clk)) {
 		ath10k_err(ar, "failed to get rtc clk: %ld\n",
 			   PTR_ERR(ar_ahb->rtc_clk));
-		return ar_ahb->rtc_clk ? PTR_ERR(ar_ahb->rtc_clk) : -ENODEV;
+		return PTR_ERR(ar_ahb->rtc_clk);
 	}
 
 	return 0;
-- 
2.53.0


