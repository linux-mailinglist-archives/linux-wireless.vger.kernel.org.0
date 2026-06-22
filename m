Return-Path: <linux-wireless+bounces-37961-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aE5VA+zUOGoNiwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37961-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 08:23:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2EF6ACEF5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 08:23:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=e33sqghe;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=G6b5sAKp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37961-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37961-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BD12300B9A0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF33335DA5D;
	Mon, 22 Jun 2026 06:23:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355235C19D
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 06:23:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109417; cv=none; b=lF3D6DAj6HwHwbKZonZx9/5K5ZDTB+QsnSkRcfC11znYSbb+1H1ICDow0GgsXVdgl0P6xO4oP5eQKFvQJ4x5GD8zekMstOpyamKEGayC+Fz5mq2C/GjEDx8eaz8MPb9lTyHRgoiujecHvLWUpBcSO5hD+4bkN8WhjlB89ZgzZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109417; c=relaxed/simple;
	bh=UkFDnMejlwwvZ+abtIadq18e+nJjkDPGYmZL95ZaVmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FFFUGXAsBbGRYIUg3ik48rcSrywLTxFDW+D+ZsQjE+Dpeb3boPshPrUwipbJoO6xzVPdB15y7hJsXBxYKgS61OD+IRRF2oObvPmbr/D70fkz8/aynCyWQglNCr8F0yQuOI0y44FOIUGvC8Q1dstX6PIqUUXCl5Qtob/DOl90KYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e33sqghe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G6b5sAKp; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5Bd3D4183630
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 06:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/C/8iYmL+lfKAPj1dd+sn/SjkpTMe1a5ENG
	ah+3sxuc=; b=e33sqghey/tokvjUfikxh2nrLF+Sn4d2C2CxZdX5EoY8gEdpd5g
	nFjve8gq1rA6QYVr6d61LqmLOwcy+zzmT0Kqf6I1WPnWPhVESwmw7UZDISAJ69k2
	4chHMs89zR6UhiAfFtJXqyMy544pw5DjcbN1jrEkq4By3QbioOGyfvrd26x+JADz
	CLS+6SDhnILARuw/f2IEvfb9/q2WoaJkQBukQMvI10Hw5qPuLg0Dyo3c6+cOULBO
	uokW6Yf43CNivQj5cbBXkmyRPHQRfn+bkohfmYBCgce2q+mzOZcV8OVLCXFE0DrJ
	Hy7JZVauk2d3GnRwgCfH+JR/AWFvwnOn2Iw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewj6h541a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 06:23:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c2c98c1be2so36518435ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 23:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782109414; x=1782714214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/C/8iYmL+lfKAPj1dd+sn/SjkpTMe1a5ENGah+3sxuc=;
        b=G6b5sAKprYD0yG5MHjVEjVloEsrO6jHK9scFcc11HDJROEDGfJb2xfY9sIoInSgd8W
         zyeHFP20+SLmuNjlTqeeU9U9I8haw2xqwZWgZK48c9iAdJ8yvqyFzM1hFL5xlXrW6WXE
         1SzTc6toNnBldekEAPTxilSe7mH7XphUS43x7VUChn4VWaA2TBv0EvmzMPM4TyOdr03Z
         wAROR4lPSbUWKeTtssUd/zmAuFvg3ts6zO/aYHIPeC5tQtqY69ze3wfnyDXinuE61zk4
         2dsPKnIi4pwUpFQ2lqqdMieDo1LfSVkiTgpXFQdBENRjgnpIRIiNNqRo+QLmdlg3lnsH
         ba8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782109414; x=1782714214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C/8iYmL+lfKAPj1dd+sn/SjkpTMe1a5ENGah+3sxuc=;
        b=EZlKbFdsgglC/+iNmUnnygA2k6330AW+vBQKh9Bid4KDN2g7bzsRgpdUbJw0UeA5Iy
         1mpcMzMqICyAjU37UHnHlWforrNozzJDdfJNlt587xy1FHqrIdj8PwNyVo6evxyKuzcO
         iQga6UnDEXLlGsW2C1RTIWTAWVOKptoCsZ5b4Q7gAyL+5SyG3hI+1/FBBPbATLGDTL8M
         B3taSnYnbruUxpFJanZkGLKsypd/gzePKVrFYM6w4oLxuazzaxPJpBa9cpP7cjhA12xQ
         nWaPVznPzfFOQ3F6x0hYqiAsiSh+fhdoY03rqVyRG4h6GJO55adqE3Pv7fJvWfvJ9YUJ
         N/SQ==
X-Gm-Message-State: AOJu0YzHYW+QwhGXwUxAWz4Tb5A69RnYKsF1n4cjOCP5a+6hNVgmjjMz
	c+qegBEft3tWlGH8mpq3T9iSL0gOvWMDaB4YLfl8fsg6HIN+x2rApoD2hcamhT1+lDqGY1qjvM2
	0kmOyhal7Iaej+tP/B7Pde6z0EWiUxq2w50kZNE1aC9/toJNZF1KdbXzQNpV7Um0L7jcCOAxe4w
	FIZg==
X-Gm-Gg: AfdE7cmoeFpd/KOdpRY8kRaHBB9YLE0F55d620+06mMU6vWnv++YvJsZV2W/BpfAGP/
	8QA8GfU3AFl3Vd3sl6pbq3+1cvKSLlSujx0Amd2BIHciJLni1r+2c+q2Rvvymy+cQXlUay8W1Z3
	nyl49f/AfVoWrMKkUvWxJQNrLxa3i5S6yTq385MycXHoa83UIXx4m6RCl8CcQnCTLKr1ptyTrgk
	PWAPWNNUKJsH5vRh0/F+wb8LGeJYPeRcPf4Pc2STxS4n0VPVvoTcZG3nHyPqqsC5gBmC+YczV8R
	zpLyEwK3FNn4D6taT7/jF0jK0AsyKfj1T+p61PrS6rGXi4h6P/pS2JJUf4lakbdh33Uc8A9rrwv
	B3eGKUQdnhAqDB0+yQH1WfQn9DJl2M4yGfR0Y9g4j0XafjNb9ZLBdJuLpIK3ZUlnnTDwpHYfxET
	5YsAgQSloA/SKWV4zfb8Z3cCJBZeCi1EWkIT4aJD4Smg8=
X-Received: by 2002:a17:903:2309:b0:2c6:a99a:52b5 with SMTP id d9443c01a7336-2c718cb1273mr141350365ad.12.1782109414066;
        Sun, 21 Jun 2026 23:23:34 -0700 (PDT)
X-Received: by 2002:a17:903:2309:b0:2c6:a99a:52b5 with SMTP id d9443c01a7336-2c718cb1273mr141350045ad.12.1782109413565;
        Sun, 21 Jun 2026 23:23:33 -0700 (PDT)
Received: from hu-tmariyap-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfe4fasm65772875ad.59.2026.06.21.23.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:23:33 -0700 (PDT)
From: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Reduce RX SRNG interrupt timer threshold to 200us
Date: Mon, 22 Jun 2026 11:53:24 +0530
Message-Id: <20260622062324.758533-1-thiraviyam.mariyappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA2MSBTYWx0ZWRfXwLab/D4rDAPN
 Ky0TFgPBu5FskhcwvGlZe0fdv0+ij5lujknc2q8Vma+MIGZCku6zb6hiVdzxG6ELXwnPvWh6eAK
 ALDXO+NWMv92PR+Lg8kVgrEdhkzR48SPFDsJYn8aJOyo4tT8hUCRu/bWb3oiOnDp5LmQjNGUkfH
 7A1LusBDTPe2Y5wiNJo8PMHQQGIgS7jeZLRdgSy6lEBue8kh3R3WjSPrDKz+klgOAU1JkkMa0cl
 miPENdmMQvox8jFhpjcFcUIyt4sxeN6g8jEOMHpzNgg82cVKlIjpgn856UDf7RLR7Ww+2vJ5EBL
 qA05hUWXHgThmiKrBGFNlETKcxS+xdtKB8DObRQzdMOtXcmfOja7FF9aCwccG6n4+x4sJxxTz4A
 +uBeMJVRvQdUSGNN7fGIE6k9mvuG85mdL+Xs5D7mb9P4mEYY4Hl2lWblCTeF+VKHoMstjXXZTfQ
 7sbMLm5s98ISg5KtrXg==
X-Proofpoint-ORIG-GUID: mI3jMY3r-a-HnwdKcmKLgEPNGTBOlFI4
X-Authority-Analysis: v=2.4 cv=E7P9Y6dl c=1 sm=1 tr=0 ts=6a38d4e7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=rWk4lG9R-Onagg9xqEIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA2MSBTYWx0ZWRfX9vCKnQizKk5j
 5HsVx/fZnDAYWbq4+zQ/j88YEP+Aif7DEDjuWuuwab9dENUfm6x+O33QUzp3RWyC4eD608CE/OQ
 N9a7qw49wRMG/NwbHi+WLMOS5UvSDkU=
X-Proofpoint-GUID: mI3jMY3r-a-HnwdKcmKLgEPNGTBOlFI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37961-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:thiraviyam.mariyappan@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thiraviyam.mariyappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thiraviyam.mariyappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E2EF6ACEF5

Currently when RX traffic is low or intermittent, the RX SRNG interrupt
mitigation logic defers packet processing for up to 500us via
HAL_SRNG_INT_TIMER_THRESHOLD_RX.

This causes excessive RX servicing delay, leading to increased end-to-end
latency and degraded TCP performance in low-concurrency scenarios.

In single-client single-stream TCP tests using 5G EHT160 (NSS 2x2) mode,
throughput drops to ~400 Mbps DL and UL instead of the expected ~600 Mbps.

In addition, UDP UL end-to-end latency measured in 5G VHT80 (NSS 4x4) mode
increases by up to ~48% (~570us versus ~270us) across frame sizes from
76 to 1518 bytes in uplink and bidirectional traffic, indicating delayed
RX servicing under sparse traffic conditions.

To address this issue, reduce the RX SRNG interrupt timer threshold from
500us to 200us so that received packets are serviced more promptly under
low-rate and intermittent RX traffic.

With this change, single-client single-stream TCP throughput in EHT160 is
restored to expected levels ~600 Mbps TCP DL/UL and UDP UL end-to-end
latency in VHT80 returns to baseline values ~270us across all tested frame
sizes. Under high RX load, no throughput regression is observed, as RX
rings are already serviced frequently. The primary implication is a modest
increase in RX interrupt frequency under low traffic, with no observed
functional, stability, or performance regressions on tested platforms.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 21c551d8b248..2a5bdf6d7653 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1024,7 +1024,7 @@ enum hal_wbm_rel_desc_type {
 
 /* Interrupt mitigation - timer threshold in us */
 #define HAL_SRNG_INT_TIMER_THRESHOLD_TX 1000
-#define HAL_SRNG_INT_TIMER_THRESHOLD_RX 500
+#define HAL_SRNG_INT_TIMER_THRESHOLD_RX 200
 #define HAL_SRNG_INT_TIMER_THRESHOLD_OTHER 256
 
 enum hal_srng_mac_type {

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1


