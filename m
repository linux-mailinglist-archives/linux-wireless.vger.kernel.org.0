Return-Path: <linux-wireless+bounces-37279-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBscJZK7HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37279-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:04:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B346622FD5
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F388308FCB5
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E87A3DC4B8;
	Mon,  1 Jun 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gf/33KL5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EcU/3y0p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2C3DC873
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333246; cv=none; b=PQp9wsGMHtNXsIQnMHPJjWEKw+Jk6NKCRqa1G9hhuKiYJAMpMck5FvTxNIpTycCigsd7+qknrwo8fQQXsLN9IaibO3mYrE02iC7/9njSi5bAq++jt0uzJxB4e5nsmY/e+JpC3QfuPXG49I6cv+U2wsFvu+3jwu5JWCBrHybnxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333246; c=relaxed/simple;
	bh=JPNknHQ5MA0OaYkZ76JwMn+0Szzm52+xucMBr0GJ8u8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VF1yb/2cSfoN7JtG+bUvFDOB1PyT+RZ07jP/BlQYv5k4V1PSu5dP4E0XiEDR1Wq3kcDj0mYNAWvoGUZuAPFcR0b9945H7E2RoP0WZdxUDSWn6COcORwXN1HBDQ2E0Ay8jEktCjfP4Cjbg5rAysXnTLrjKkJ6hnANKQYKmkMD7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gf/33KL5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EcU/3y0p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FFR6K4065408
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VHyhw4d/8lKtqslD5J+ghkn/sF3Pzc6D9/+cR5SsbyQ=; b=Gf/33KL56dOGJBWf
	5DKtpCoH52juQZ9WxIX6NiMcL8x0fX9sNUNNNx9nxBBJzWEPZUNoCx4CH2SZuKb/
	Q46SItINduoCFLcq8Iw55ORatCALE+jjMZF1r32lGsqpZhymjgxc1NRocy5yqttI
	KF9D6PphivQJ3QIxlWTtJgPp8TE9cPxewMtBugh/WD951jLT/v3GLIGRDRQicPxg
	VL29Zs1EF/U5SMYJEG9AEkeZrNXO0sIOPadAseD75PckOPhjMtQfPTcrac31gGR7
	5b5xn5/iCJdTcu3VQ5WfwhJfd8DX67qWdnv3LxrFUF+ASPAXFfeZlrfN1W4X/VlY
	/i2b/Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6swt3fw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137dd3a60e8so2178766c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333240; x=1780938040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHyhw4d/8lKtqslD5J+ghkn/sF3Pzc6D9/+cR5SsbyQ=;
        b=EcU/3y0paQ85Dkcri0s5KHKYz0T0kK/AxmVmQ/ge1iDDgeHIy3+YRN0lCY5YvfOIdr
         03rkq43cb8s8ZogKyl7SsuA0Y6XF+jwJEE40EojQXjyy4Hxd3NB1K6VzPo67VjgLggK/
         UuxHEzGbd+vQl1pin8vI0D7r/+AMqvlIOqQb+IZRfn59rCLT8VPnzgyZBvLLR7MlhZ5Y
         NVyTt+wUoHma/pQeXyeVv7FzvYG7H7fisd+WSsTVQFA1NT2Iuy+RRiMYxAW5wgZdZGoL
         du3bDTwVvrRBA91mTP5zHX7YjxyYbFLlCoGZcXl4595xrtmP35vXMCfEjZQ1eu5zh6Aq
         1XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333240; x=1780938040;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHyhw4d/8lKtqslD5J+ghkn/sF3Pzc6D9/+cR5SsbyQ=;
        b=QYvVkNQOz/BzxpgfoqG5UXAIjGmivTA2sl4Msl0/99RwQP5w3U+sb+NJ8Je25+mNuD
         /HVqtcopFhAEU7vvMtRcsShAqb3HRMjsvVxI8QyZekjbiAsyUweaTe/S3F6zPx9WliHZ
         Yh1y78exTRaULMvmYth7zD4Evh6NbdzGteYKiMi5cdhfRfLUb2ydyvpICLJDwJdqOfGQ
         HsvTrQVdE4vf+L7ZyYx/doTQDRWEGMOelnHDN2NqDSfOa0RQr8YBdrPkEPHTL4QDzcJM
         yj0kd59ucsdu7yU/lghXTpuh3zkVvq5vzxE7bnbpEtM8R5f7XGNmbetwn4jYxDZd2m2w
         Pr3g==
X-Gm-Message-State: AOJu0YzPx8gayoCkto6oAyDMjRpkMc5mnMwAG7d67omOS1VNtX1r3AER
	cWJB2T0pATVH3X23+hs/1v+vZj5cUyRdCA99ttc2uHcbHmJGolp/oNd29/4ErHRRTrVsyMRa9Q1
	150pDW1A/RbhBsWtvEThY1JYME1QkfURzUZrcUmhDiJViQd1uTyAFSKnjhjfnOpkVH6/vm96//2
	g/1A==
X-Gm-Gg: Acq92OFxQeOeBTLjYZumlYo+wkzp/2Kcz7xtaz+nFfHBRthUL1xlRSXwr8vLiPHifhy
	5Yaq+gZbkNX/FatG+nxgK8EndxIIptv+ebci91qsSXuv9GthQ0Hb+SBYr/bjzwkyaXHX+ruAoFX
	FHhdBiBdNTJhgrH3C4LERps1gabEkCSNuzU4ggdwWdn//hisMKj6hRMVwpRJMsvijWY3W3cNsjj
	DzNkfa80D5svRSI/5xThqic/JsMdK68+ZpJ19d5id5QwxvLmztUmtvuSwHAVQJGJLDuFpLUvn7x
	EwnX7geiQgMoixyUBwJGELGu/l8SE3P2u5Rd49l/HwsFjq3sEMbS4ACzAk4ZN1ed0pvmhHjpE/8
	HspMYNyUtLcjDG4qrteWS1U/zvjClq1/2gmC4qUMhhTDAnf6+KER4HLLt4sz8pVlsKVxE8fZ0Ub
	DVCyrLc8AhP/8=
X-Received: by 2002:a05:7022:671e:b0:134:cf34:b8e0 with SMTP id a92af1059eb24-137d3f184e9mr5378395c88.9.1780333240172;
        Mon, 01 Jun 2026 10:00:40 -0700 (PDT)
X-Received: by 2002:a05:7022:671e:b0:134:cf34:b8e0 with SMTP id a92af1059eb24-137d3f184e9mr5378346c88.9.1780333239512;
        Mon, 01 Jun 2026 10:00:39 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20260522091828.3199584-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260522091828.3199584-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Prevent incorrect vif
 chanctx switch when handling multi-radio contexts
Message-Id: <178033323889.2045173.1791096745771424829.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1dbab9 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KrZl9qRX-uZY2yUkPFUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: _RBlBfNsuZM10jEk0fAsSSGqKWSZH0s_
X-Proofpoint-ORIG-GUID: _RBlBfNsuZM10jEk0fAsSSGqKWSZH0s_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfX2OSBfju7/WsE
 JQlUvsV9lRvhI4Pj7bSut2yjTLTg/EbfI46JFzIlAS5An0Se0SU32hO+Xef3ckJKhyoftxSxdH0
 J0NKi7g/JyagUiAhOU1A7S4gibgAwzINPSRy65gDoOoPP4b9qkyQBUe8bB5Ryaaz4u9QcoBk3mB
 vbLFIBMmWZ5Ns+Utn5CRuzCrENWusNBD0HPabLBRv6QzQeUaEgqe8+SrvUpXUeJjhyvr9D1W1OB
 mb7mSJ9JTVlK7ZUQ/Yh/zd0+X4mVQHHF/mq6sFw/upJNlkmT0iwrHmsUNSVO5oQUmH6aZgeKY26
 NZdT/iYqXq4aMb+jcbOiQpNMwLR6A+72N9BEGZ4RK3DNXZgyovR5WXlkm5TMRa5eSpohYBGjapB
 BDrlqlv8oHx+P5BDxXD9ajQz09H8fgwwq/S0xSr2ubTv9ZcLXenwl3hnBEQorjtfWmiuXun3j/1
 CVRL7xmpnms8X5JChFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37279-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B346622FD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 22 May 2026 14:48:28 +0530, Maharaja Kennadyrajan wrote:
> When multiple links switch channel contexts around the same time, mac80211
> may complete CSA for several links together and invoke
> ath12k_mac_op_switch_vif_chanctx() with an array of vifs spanning more than
> one underlying radio in a single-wiphy configuration.
> 
> The driver currently assumes that all entries in the vifs array belong to the
> same radio and derives the radio context from the first element. On multi-radio
> hardware, this can lead to incorrect vdev selection/updates and may corrupt
> driver state when the number of vifs exceeds what a single radio supports.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Prevent incorrect vif chanctx switch when handling multi-radio contexts
      commit: 675aa75bfc29fb18c6e4d58904a91c1d37228217

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


