Return-Path: <linux-wireless+bounces-28330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE5C12DE1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 05:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AD4466E3B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 04:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F111E570D;
	Tue, 28 Oct 2025 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6jb0Mca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EF3C38
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761626096; cv=none; b=Vjk+SynVzAiGObsyc8T5s0HtTpv3s0fjmjbwlkcfOS3PS459amDOJxLSXI9nAaORLRI1PxVFIV4ok0XJyuiVNY9hFW13Lajs80h3vCzWqOqDnG68S8TfJtpUAALWUt/r8z+kr4R/mqTbEw9EEiXOOF0PyMjOYTq2kFPydWfGXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761626096; c=relaxed/simple;
	bh=fg8tFD7/dxR/xyk4u0afHRNrNLydihFFtwkN7oUy1Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKZsd12101/roc2HOROMExn/wOQy+71xmNgm1QgsPXrOONl00IQn78r5lpD3eQNBYcB+wF/Lya554GPc07rVOQ2mdmMLjtX0VNkK6ftpO4N4f8BoEJECyVDZ4JiGMMH1rmLl7LVmQQ2S+JoDYI3s6PEFt5Q3AEMNrTL/WMSK5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6jb0Mca; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RJtq1m2546726
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 04:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=M4LpyJwg/5ltHE3unTKLRRHwCp5ckUw2bZQ
	gIpby6e0=; b=Y6jb0McacJPIoU/W7EWtoUMRY7JiAHAjriccRNqMOlTz9lWVttL
	BLdl4a0Iyn8MdeLReD5uDxR1faASYJB4Don56X0jyohglYZfpfE4ucptKN4AjYnV
	/Vqrtq2P7ax5iY031lwEOItxPkSpA+TmE0onRHY1ugJF83MJ8ISNW+CSXsbYoPSs
	N9VM5pFg5vJnSoTPcSBZGtDjfsl6ZJqAvZUVa9vd1asq8DAs7gosL5mMTZbxSM82
	OS/eiOehu+xPTy95rjWHRG+N7bHzmfVHfKmHlcAepHb8eZbA+NLgkgHkb/MaWbmO
	8+L9So1ge6zNnSHcdeQ+95I+rQM029E5PnA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2js4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 04:34:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bb4d11f5eso5319506a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 21:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761626092; x=1762230892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4LpyJwg/5ltHE3unTKLRRHwCp5ckUw2bZQgIpby6e0=;
        b=LyfPYa/64u6efMnlp6dvJkoxo86nn37KFTDlBXhiM4j225uuWYCO4FlVX1qn6RfQP1
         wDesBYx41BY0zohXakdcnaYxZhnmXq1P8jlP8A4Ta60iZB5R9lfZDjIhBpCSBSikSs2D
         FZYhyoltEuzFZOH0qWl7lEyElyhQ9Q7fRu3qLqIHF9tlAVEJnv1cxaThjho0g32JjrpS
         V3w/SavO+GrkDgf8GzpaoSPElaCIt/j+qOPHQLCYe/ZRYooICNA2ON2QApx/YkCnoewi
         Xx1b1M46u+oinrGljSfRN3U1wKOh+MA8bg13kTVs6svycAeQePRquSm1TYyXKbc+5daW
         HeMA==
X-Gm-Message-State: AOJu0YzqjlOH2eXSgwSh9ZhXgese1rbykKXHFOUrxtUrRzD9gJ+SY7ry
	ryazMTYK8PZicgKTyH7PIknbGj6xFFDmn4Cx5LHU4rsG+NFEWBok1h6ySqXqk/biWeztyLikNjR
	AhtfVNZnrnB0Ys6FvcAHBIGEtQqhvF2e7WG4uO0I6nb91ckaMjGLe2lYPM6mpd/8OapVDDg==
X-Gm-Gg: ASbGncvtHWfegtQOWwMFfmIEunNL+63tQuYvn/pMyibNpGTfwmiDf19o330nDZi4TvO
	Ibhggv8IxChhqAD5m7HnoO5LxtIxOItPn9fedwV2OqPhh1yjj8S6Ni02KjUEe5SFke2jYrXed5v
	8APcNPHal62D1rywiueGFrtFisZxAlBjK7XLCtzvGJm9RyX6d5/5kIe9T8dYyBsFkQa494xR5eP
	RhwISWuv3chKHvu8xEsOx6Y3Aum5IJogviDPvmjsuDU+rx+cX7dIkHQQcCi6++NFn693Ah9trDw
	yMGY1F9dD0tpoQvmIZSe9fgaMBp1iHXLYl+1dKSNXgRWaIlwc/HjVzUi76xvKboIu6kxWe0z4nQ
	Bs6HJBzVUI5WoeSNZyosiXyz3GCnkDAMbn8ecJ/bV4486NKlXLjVumaW1BhYllzW+fLFlIW3Dwo
	kKuhly1GI7Rq8LizeplHdK0Q==
X-Received: by 2002:a17:90b:56cc:b0:332:6356:86b6 with SMTP id 98e67ed59e1d1-34027a04268mr2336692a91.9.1761626092337;
        Mon, 27 Oct 2025 21:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIhTEI69DQ6bryc46vnkxo3dp2xWAB7AIWv/c80+DCh1lgO2+1GRRV3V10olRbCWqcUSRyyw==
X-Received: by 2002:a17:90b:56cc:b0:332:6356:86b6 with SMTP id 98e67ed59e1d1-34027a04268mr2336660a91.9.1761626091873;
        Mon, 27 Oct 2025 21:34:51 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402942f298sm529568a91.5.2025.10.27.21.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 21:34:51 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Thomas Wu <quic_wthomas@quicinc.com>,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: Allow HT Action frame processing on 6 GHz when HE is supported
Date: Tue, 28 Oct 2025 10:04:42 +0530
Message-Id: <20251028043442.523647-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iW2MEobXqUOkPbeLun9Sn7GbPM0dkc1o
X-Proofpoint-GUID: iW2MEobXqUOkPbeLun9Sn7GbPM0dkc1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAzNyBTYWx0ZWRfX1oz7Bj7XhApM
 aMp3kCUnyZVJbtY0fL+1viIgu9HIR4fipIEoMYf+symtF8GtUk8Lrk/a7lQWG1dkOtI/DmJfGhu
 DpDy/Pt8IS1wPFm2vIIuoOQqVjfZDrbl0S47aqxqgDLSueX5BQykqHxdVz81WwrxHhOI9IwR+/a
 zPRvN72W0vKZNl+gp1sfM3jTzuXG0E4yKNVdUkOJTmDioWvOfliDPWsl9R3UUjOVOsyT0btVm+M
 0YKJUT+6sWXC0tn5GIFQ7PjSHP7PEPoFqxilg3+UdUkPYPAao7UZR7533GvFWJ27K1nenlVPmqb
 Nw+AxmaUpASmoddJSrpUf9LghGwFbAZkDhbZWFn+rx60YIVsKDIrDN8RBROKjXmtms0UtpOOF6z
 FuRVIJ3WpPst9RcX8hwEv2MeY9Zo8A==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=690047ed cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=TfuwYnTvkOvh0IDu4YEA:9 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280037

From: Thomas Wu <quic_wthomas@quicinc.com>

Management frames on 6 GHz do not include HT Capabilities, causing HT
Action frames to be dropped in ieee80211_rx_h_action(). The current logic
checks only ht_cap.ht_supported, which fails for 6 GHz radios that support
only HE and EHT.

Update the condition to also allow HT Action frame processing when
he_cap.has_he is true. This enables support for HE dynamic SM power save
as defined in IEEE Std 802.11ax-2021, section 26.14.4.

Signed-off-by: Thomas Wu <quic_wthomas@quicinc.com>
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 net/mac80211/rx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4641a2a80856..d9553e8854b7 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3570,8 +3570,11 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_HT:
-		/* reject HT action frames from stations not supporting HT */
-		if (!rx->link_sta->pub->ht_cap.ht_supported)
+		/* reject HT action frames from stations not supporting HT
+		 * or not HE Capable
+		 */
+		if (!rx->link_sta->pub->ht_cap.ht_supported &&
+		    !rx->link_sta->pub->he_cap.has_he)
 			goto invalid;
 
 		if (sdata->vif.type != NL80211_IFTYPE_STATION &&

base-commit: 88de08348af8ce15dc563e0ebb5553eddd821c06
-- 
2.34.1


