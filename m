Return-Path: <linux-wireless+bounces-38841-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZaYqJMmEUGpK0gIAu9opvQ
	(envelope-from <linux-wireless+bounces-38841-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 07:36:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBACA7375D3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 07:36:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nLt4cIn3;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MN6rwQd3;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38841-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38841-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90A6D3011C4E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 05:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF428834;
	Fri, 10 Jul 2026 05:35:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1C379C31
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 05:35:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661746; cv=none; b=Z8gRG2dWB9aHSjTocRo03iZl6pCdczG3fZ5DLzAdfu7uAnLMtzbX2gwvsrLW8AxO1gz9g7VpuY4UNOI5W5dsXslZjFAIyOSCUAwFkIA1+DWsdhwDEYCCR5jddbWJRC9GRYNGMvZMLe7ozGpqYjqcTwL80yPw+0wjnz+F09xHPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661746; c=relaxed/simple;
	bh=yA6xmYx8MsK6J1ncPK4Z1d67bXyiguGcEY2pNzSu9AA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X5H8dTLrZrRRiTyQxrVHV0zoc/GsPTTFwtiYlRrhtv3HpwuPFmetdYtK60XtR+G+VN1H0c/nyoV37gLkZDRnC+bjlxVPkHpBPw7x++DVoseyUuYnD0FWeG09sVEGplB+gQog6uF2FEi8IPYNLI9C/nuG+M9BhG2SXCdULb0uFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nLt4cIn3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MN6rwQd3; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3n6hx3661819
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 05:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/y07Nah1gPKdVcQOzYQMg4hKJRLS1w2nIeC
	X7vQdc+8=; b=nLt4cIn3EtR9ZvzKi0lPYKQmpl4zhdeuhnyyyGMwJEIBza0rk9c
	daFHIv+kStQd/Fzeu+1ApAlMEA+CIp9rjLkmuhlDPjNr3yTngdzh6YPYDUM7jHOr
	JiKOhYwBSUAZmESvA70umEVr8Exx0Wjvbi14faAWBYeCEBg5jNBvHWEm+l8iZkPx
	z0n+cBoscuWoXwu8GyamyLqaD5V7WK5xmJMKCd/Rx30KiU/OBTL27UcB/KFVBLPF
	SQismoDfeixtvpi8uJQUOJSs4ekqiEQ8grMCSlyjgnHJczf6W3FDMJ4f2+Xawxlj
	o/4y/0epeJZOPP3p1gB0pqiZamdzqSx/5SA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24tqjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 05:35:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88da04b719so631237a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783661742; x=1784266542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/y07Nah1gPKdVcQOzYQMg4hKJRLS1w2nIeCX7vQdc+8=;
        b=MN6rwQd3m1o8JGwNGD8UrBCtlWifW3Jq/1IQHZimcR9HbIh6E2je6cswkJ9CarKDNF
         OEKlUwTfY33VU12bjXA6Ckv/Y0Utxz0ijns/bOFcLqb2WHw3G2qCUmNj4k76Hmrgljp8
         K9DBkq1qNzwClUcTpP3B/66foVQp9YWibaRjHw/EbmJgItMqsOi9mx4bWhVpPuwjVQ3i
         jQkIqq/FpTWTVYFCwk3Ixh6Ch2FAiAxMlqLC4E5zKBQhCI433W01VYfMRsSC/0A7UU+U
         RxOMfqXT984ivyr5yB3FmvUq+VuU5UXgSvkIEKcHCAxT16BaDoRFmAEHIzdKxuV2VPP9
         CI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661742; x=1784266542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/y07Nah1gPKdVcQOzYQMg4hKJRLS1w2nIeCX7vQdc+8=;
        b=Y6gOBQwky1FTYuBPkcMJie5ZfQ16V3vajrjsG0/pXBEwzpZ1pJnzY6EkDhWZ4H0Y0s
         mnN7wU/Pjqm9RwW2DmkKXPe290ReETgfN5B/FZBnVxewhUuHU/Kt5X6HH7+ACdAE+jj7
         sO+h3KpmbgH6PKC38reBg8RooRlRxM+KFd1WtgleggTpFX5DurvdrvUcFMaEXk4eDjR6
         IXzvyvqIDNiL56sJSvl01r0uHrgAooIzr+9mOjasn8lMdJPueh2NrJBNQ7xtlGgqtVKa
         vF++I6u/sS3b1cVrYeQ1uw4hc7tftWp3oye5I+UetOui8pL+4fskmWHfLQQ0T1w5M9xF
         UQng==
X-Gm-Message-State: AOJu0Yy/y6Yt++coShh30mRHviY0vSCNeSL+ByhMHY3oX5XILZGNWt/n
	S1tAoCEUZABx7eqbv3Jjo2aC3EDicc0q8zRuPqpH1nUmQ7njO/WEP3DPiCUJn9kFmd54Q1+nTcr
	wXiOiQMMycNgQwpe3TpL4EQeirQb7SIlnLAzBQapNc5+0q+vT6vAOIdnIKBijGeSoFh8xVg==
X-Gm-Gg: AfdE7clcr52VBnCHqRJuRARevsgXRt9UWanBPJ0HlfVn7dV8eSx7lsthdAXbND3Wj/f
	/9yQ7UmeUXOTHf4zz898HeirX2WyKek7ec/UBHtg2z15VvLhgF/Qh4hu9rdDYANbL+SysEthTI/
	TPylG4IRdrxNYjo/LZHjtudx8bx1yy9eHlBbXCmYaGE95230+ZDtL8U2yWCa1VisHHkA/eUb1NL
	VXyV0pqGzvhRJURyl0ttA+Dd9j5m68B/TY+Pr5K290j9/K5IkzUpsY5lNROvpks592yOORe6Bkp
	k3Dq1FXC3EBpzAB9962v5U/2fIT4rzyXkldxlwjyK1pdGe4irxHhjjky5bnV96VhoH/5SZ+0PYh
	rVO/hwH4ttuizrEJP5eAKtAFwoyoyvoKezpJIkamsouqZWOAZTxiaZzOKqkjAVolLZ3AFJKVZjH
	53OzbigXlTXJSjxe0tf01usxjulpfxe6llww==
X-Received: by 2002:a05:6a20:a107:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3c0bc95a3cbmr12227738637.28.1783661742505;
        Thu, 09 Jul 2026 22:35:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:a107:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3c0bc95a3cbmr12227702637.28.1783661741879;
        Thu, 09 Jul 2026 22:35:41 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm34576780eec.4.2026.07.09.22.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:35:41 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: update IPQ5332 BDF address offset
Date: Fri, 10 Jul 2026 11:05:34 +0530
Message-Id: <20260710053534.879233-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bBlOUd3z0HKoNVr_V1pQY21wqtduNtQ_
X-Proofpoint-ORIG-GUID: bBlOUd3z0HKoNVr_V1pQY21wqtduNtQ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MCBTYWx0ZWRfX+nXBehqylXLW
 qQZO7feo9E+idoATZio2Gs5dHbFnsaqytUnA1wO/4TYj1sw7xwSicmtHAkM6Vr+E64WBe1ST8uQ
 aIc6YG7ZH/P4N1/eJcvblqKEem7ogLI=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a5084af cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=veBU2d8d2MSVlRlIhgAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MCBTYWx0ZWRfX53ZndcC6RrX8
 n+WLaGxNBtJasQ0rIqY9oITKpvTDE+HnZ1GQuSe3CSPK85tio71Akc7ir5sItdCeyGsEwZcMxDJ
 Pic5/CFXe3yJyfh0UWBBtieIn7PWJ0gZMEknHLJfi3D1DomkidwmDxA6Ln3ypV/pmED1kvNsgnC
 fyEdu+KyJ7rux51dwNWUtPhLrd7GusKofzk3N5dC7nIRT+K5NCOk61myQoAmQdkON7azi/vV77G
 CsjzHzC6wNKqRUV/zCZF/T8fhWApYjkN10P51s042F2fKFTdZzVS3oQl08kP0PgGdYfVVzkDzOa
 /lFoWFTyqtFefFBbPACjD3rTP8GWBnyWKBTQISiYM6Lm9aWUQqvA+1YW+iCdG0ObQvUmtB3RurR
 ERVDGFR50dYSyYvL8WS2WqcscGlLpzAjl0Cv46+gfV1yxYhZuym58c6ke3A9N4HXF2XfQFmJaL2
 NhHMOQnFVe1xI38Wx6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100050
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38841-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBACA7375D3

In the ath12k driver, the BDF_MEM_REGION_TYPE address is derived by
adding a fixed bdf_addr_offset to the WCSS Q6 region base address.

The current offset (0xC00000) works only when the Q6 region contains
the IPQ5332 ucode alone. On some IPQ5332 platform variants, additional
devices share the same WCSS Q6 processor and place their firmware
ucode in the same Q6 region. This results in multiple ucode sections
within the region, and the existing offset can cause the BDF memory
region to overlap with firmware read-only sections, which can lead to
firmware crash and driver boot failure.

Increase the bdf_addr_offset to 0x1A00000, determined by analyzing
firmware memory maps across all known IPQ5332 platform variants. This
value represents the upper bound of the largest combined firmware and
ensures all IPQ5332 variants can allocate the BDF region safely without
overlapping firmware regions.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index e5bf9d218104..03f87374881f 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -689,7 +689,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.ce_ie_addr = &ath12k_wifi7_ce_ie_addr_ipq5332,
 		.ce_remap = &ath12k_wifi7_ce_remap_ipq5332,
-		.bdf_addr_offset = 0xC00000,
+		.bdf_addr_offset = 0x1A00000,
 
 		.dp_primary_link_only = true,
 		.client = {

base-commit: e36b3c776adc9891d8574241be77640ded819ee7
-- 
2.34.1


