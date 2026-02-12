Return-Path: <linux-wireless+bounces-31787-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA2CN58VjmmZ/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31787-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:02:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14C13020D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CEFF301E7ED
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD99F1DFF7;
	Thu, 12 Feb 2026 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="itsgELcM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ap1vXozF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA8F513
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919322; cv=none; b=QvwRh7GskK+LMfDbnEaKOfi0HKpymZ/wl9yPlxx71PLSZ1xW09TvfA8k1xZhQgUN7jOaGdnyxOtODD2WynwAdVaWZ1dcDTKROO4tGfeaUjpa6qqFX97ZkP4R3wRWMIr1bizyolGNZaxGJHrHuKPhKJAvACnwDV7QKZzdq3I6cmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919322; c=relaxed/simple;
	bh=i7ihBRJzDYvUzfy1DjG6GzyAzr21/xAf5QUdYL5ROkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QGDFILBIRq14h14AFX6Q5ml0AKPMVLHfN1Ut9y7H6rKQY8ecSzBzwhG8/6/Yemkq7a9J23DIVkoA2rDg57YytOzhiJR4q8CPiBSsBd6IFw3MkJYq3YoHJ5u2wNyMdO/qXnkwHuKSNoF0Ge0kEeXO/0TFmnQaGj7FENSpAjtuuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=itsgELcM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ap1vXozF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CGY3sV053350
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=i6hbUt341STIcTtnbQMW5kOvwiDdNHYn0X3
	mxzxIUdE=; b=itsgELcM8SdywALRLdx+8kvot8HcZhc92tvof8aeh/cmOEo4h27
	UUSOdefUcJ3p0mJrRSh0tGolTHLwt68jaDVg9kbRv0pWchdN61gpmJ3ChVVAqREx
	WYzZeO9xrRkap3pvujCJzCKysXDKCPWtrIRq1W19mpOtO32t0L5CGNi/jcW36Tpz
	6euxzaeMypDQPeYpVh8wQHbd4BYTStY0wKuPiIkgYfiQJ2XHkf+vkQuV8MPYoeZt
	m7GlmX6v/OHG7RyAnT/EZD2WuRm7Zad+rJUI22P2f5ynPgtRAWsHHVvgP1VOJqAP
	Kj+3BCnhNPiiBbZWURH0ln/Bea1lrdt1slA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9jgb8cvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 18:02:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3562bdba6f7so417802a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770919319; x=1771524119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6hbUt341STIcTtnbQMW5kOvwiDdNHYn0X3mxzxIUdE=;
        b=ap1vXozFLrmujT1/FMAk7729xT97nYJWtUdAFvv6XQBt++wcyZJfpo2Fo2gicD4lct
         kh0Y0TXwgiZOvSpVoH52NK7aP9UGIf+tfEI0JYg0qe9F6ZQZuZ3sk4r5GcPUuhkb/G8p
         w2VSpwsXDCFCX6MP1LZkqDsPCmE9OZubyAF6l7fqQ7jqkwHg1OIoq02S7B9UJafhMoc8
         c1BiAlL2gXvJZrVgSBoHXiCCNcnEvSiLe9q4/DVAneXk9eGfl7imf+mhEil1TUvuX8dn
         gZPbD6312B1XLb55bdg8lrvhme0uKeYoSw0LmLZm/WZUsn83Urbxj0070ZC8ZUR4YlaJ
         EF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770919319; x=1771524119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6hbUt341STIcTtnbQMW5kOvwiDdNHYn0X3mxzxIUdE=;
        b=MxoMcqM0D184+Uc0DqRRjX4mZFPtaCnwbJNFI+O2jcqSjV3OLQFsG9ZeTK+um2pnDH
         gH5V4pegjafOdTzGdOpCTnDKW4tvXOGLL2hQY/EDMiEuk3YoIFbDx45YJoJatw4KtV9t
         s0eWeUmButuDoZag9pkQvTkDlrha5kcAdizZOGLzrF53AQ61QTtLiFlmgAx7CkA32SBR
         ffNccwqFYj5UvZHyn/RG424hn+n9kocAG94uOomjLMji4jmNJ6QjYu6swrLifG+VIqPW
         8fKmlACNOthbSfM5WHMVQng5xUhXstPB0CE8EPSNldaXPaOp/whrTDkIN/GRx8EL8kJ4
         E6qw==
X-Gm-Message-State: AOJu0YwHfPj0qWW1fEbXnbuEn7B9RaOB0t8tSg+lNYU+3RttxI1Fp8iZ
	phUH0pC5+HxK+XITgvyM5F+0Hw8phWHpY0t3QjoXC4rdqsn2EVd8yclBBs6Xehcq3N+elEwSw2p
	7I57e+Ph7bFhcr3wtHBGa8PfPwuy/QODgwVhvPfamEIgRaCp1HChYNABvjl/2pIVc60IgpA==
X-Gm-Gg: AZuq6aK3sDNvX59F6WhV2JoJAnUGYt+k0Y6QZC92I4xmY2aY3+QhxdizxDImPUoCpVW
	c1G55E7cw96YLmqSK2ePawgpLLpu3dA8cl/OsHMK6ottKUtw5HC+GbF1NqRcWK1m7/203mwtHKP
	PPK0mPFmzZ59RP8g5vSm7S/Uf/BOJagbO6sSd7BkgYLmRron3wNsiO0tikzkoK3vNCiu7t912sH
	Xhnab6mHlhL2536FtHQW17kkl/UuwUGSg9TsQ6KfhGQffj6gusrnUlgQVOdiW1I440mqlHZ1St1
	2mBOl4hr93DwvIdvudBfeWucBqyk5k84F4fAPWL+vYhUdTsn9sQ7hHEL2tOrxknQlP/PU0XS5Jc
	sn6akp3Ut/hhX/dd9JyWVkzXOuGKIGQNudHBitVQhRolL/TUaojaNQ/T+L+SZQPYr3A==
X-Received: by 2002:a17:90b:2651:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-3568f54a934mr3558416a91.37.1770919319266;
        Thu, 12 Feb 2026 10:01:59 -0800 (PST)
X-Received: by 2002:a17:90b:2651:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-3568f54a934mr3558386a91.37.1770919318708;
        Thu, 12 Feb 2026 10:01:58 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662fac3c1sm9714130a91.17.2026.02.12.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:01:58 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 00/02] wifi: ieee80211/mac80211: Add UHR (802.11bn) Capability and Operation parsing helpers
Date: Thu, 12 Feb 2026 23:31:26 +0530
Message-Id: <20260212180128.257565-1-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzOSBTYWx0ZWRfX9F5E8QJDXfiC
 X5ueKQZ0P89gZKYOkN1VC08yQJzWMb0FFhDwFcdxnZsL2kY/2H+kwJes4CPcFCFuLNTTFf8UkqK
 8hEwB5gcVUAy5bzDYdaIa3hmuWogxxNzmR7dxN4AcHSGthiWWDMljkDrRydkpT9NgajgGH6nWaF
 /EoVjPxyGe91tlJ6NfeUQxvhsGG6r7h+Icj+auZEkTxoxXu2Kzftwl4GlkXIuhDJGMxHxVacygf
 WwX8b7Z8SW4Snng0t64sbt/zmETH95tRHAUbSgh7W8PMVlhfhLObNOPU6yaxori/408si76Nqy3
 XKMllnpNfVrZgg5B7qltxeRTju/ryS7lrvQ0wNPGwkznyMYUHn3D0R0shtjSkzV1wGM8lKXuRkW
 9I+Nt8WZl3YhGgxsnStd0lbZ0udN+wrwvAQlmnY0SlqgNZ8caS4wARz/10vmHod99OG1vwv9DJ+
 W1O0UM81B5pEwNkOAyw==
X-Authority-Analysis: v=2.4 cv=ArzjHe9P c=1 sm=1 tr=0 ts=698e1598 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=9AfIhKOTUZz-8RWr15wA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: zcd8MT_neTcGynM5jWCGDCnoFolLXM42
X-Proofpoint-GUID: zcd8MT_neTcGynM5jWCGDCnoFolLXM42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120139
X-Rspamd-Server: lfdr
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31787-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA14C13020D
X-Rspamd-Action: no action

This series covers support for UHR capability and operation (11bn)
parsing helpers for DPS/DBE/P-EDCA, and adds mac80211 hwsim changes.

The code changes are based on the IEEE 802.11bn Draft P802.11bn/D1.3.
There may be changes in the code to adopt upcoming 11bn spec changes.

---
v3:
	- Addressed Johannes's comments
	- Removed reserved macros and unwanted
	  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP

v2:
	- Rebased the changes on top of Johannes's initial UHR commits
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 288 ++++++++++++++++++
 include/linux/ieee80211-uhr.h                 | 239 ++++++++++++++-
 2 files changed, 520 insertions(+), 7 deletions(-)

base-commit: 333225e1e9ead7b06e5363389403bdac72ba3046
-- 
2.34.1


