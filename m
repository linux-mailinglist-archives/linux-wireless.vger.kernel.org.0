Return-Path: <linux-wireless+bounces-33776-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL2GNumdwmm3fQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33776-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:21:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C4B30A143
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1141303FF29
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62883FBEC9;
	Tue, 24 Mar 2026 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivg/mWnZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d7nJvZ0A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95D3FE664
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361948; cv=none; b=cVDan1L1dIw/IoOkqWeCc+Mn7yYV4Ouo9CkAvun6G1+Th5aKqVROB7ciyIMBW9rQVml0MEA2bGv4lJu3t80FWxucWd/r3S8Mmk5fULuooiFOGsrdIa60NMUQD76bZMC8xe18pdKleBBoPeRse64bLgMTk1sofpyWoALOYQE66Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361948; c=relaxed/simple;
	bh=HoKQW5HjJDnLAFdgzPsCUalof/mjf5dYjTNYvmfcclI=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Sf6yIkXTUIAzoxd+oqDQi8T3s2QeI3ipZYw5dTGaPQo8/hJ8j63qdYnSufQPzKV/9T4qTjJVJ/G1wJC7oAsooVlMUjznRtajDttk1huQcEGGIdm4PhoWAmnNEGwchLo95An2A+Z4k/MN6HYDLRMQkFqhpPNBLOFoZftoDSWY9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivg/mWnZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d7nJvZ0A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8xfbg2322822
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AFEWlTNSgwy2TspeiD1fvF
	mTtd2MiDsPAba4aSIeMGo=; b=ivg/mWnZ400T0g6ggTpY1VKzyWpyN1gi43+q7t
	Fe5Zkb9eT7uOCj9YDH+/dVwrE4YVL53hCq11dKbL7coYWqtiQVcV6NzH4s64L6T2
	6Y5TTprvUz3EHJa24vb5yVw0gZRLy0nFWrbpzEWYbHZIWiXS2qMPUlUMWBecEHa1
	T6UCWTTejkBXHaQ3xD3xfJhA1QcxUHnb5GcYIb3n47Bh53T09/wbZHe1CBOAqIT1
	lfNaxLH5ZpS8XBpob/JnBs3tN6pPNrexokzt9LG/Uil1px8Kmopbl6DG7U9ecB5w
	Aln9Jwf60+yJMZ2FEgzOHwLFdAn6xwTSPeANDEgMq43WJUpA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qkes8r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:19:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c1596fabb6so3988676eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774361944; x=1774966744; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFEWlTNSgwy2TspeiD1fvFmTtd2MiDsPAba4aSIeMGo=;
        b=d7nJvZ0AGYt/Z2XcvPkO7unFH40XC+GLVEQF81X6QmjHOub3wOlWz9TCXvffWKJrLY
         z1L7hhydl8wr1Z2nLxUQLcgJf1sZ1Jb53Lk68EVurt5mEjhRaxGhK2x0LjAwKcnp8HXz
         C57gLhQzVbgtJXaGRJm1Thn1Id5ELNyBo6bilbKwAmV3avGM/meu8nkv+HJRX8SGDzo/
         IZRagEE6AdoAjCW0iVIp2bBoA/WUEmjNXjPoWCF8gJRhUPaek8LkFqyNVL5igrPWnE2x
         bAhfHN8K/BEXqoOMId4pdpjnM69/iTXeF+eCQTYnp9yoR0lbztyeVc6HH16irWfcaD37
         L89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774361944; x=1774966744;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFEWlTNSgwy2TspeiD1fvFmTtd2MiDsPAba4aSIeMGo=;
        b=RfTqW903TYHeBCPsGrbbm+jvRD+G6kLdQZKnhwGUNnentAyrq9WulO2nb1YZfgJEL6
         t0Orb7zbjzHQ8yVxygrh+1fXpQYoY3ggBoGskYUg5a/PRvb2BL/CJBOMt0QLaXDQo68P
         uQT/6Q7VGfQDKRLqLyCaypNT8+kMTk+bnYD2wiRo/8K0pRZiWe6V9jUxSGllq6lhdrcR
         ERVtOKBqN2YNPFtQxJtLFWFom59sKjHQvzBahAe6J+vpC6N6C2rZTaTMkMRFvpN9x+kd
         0uSw5/MyLRcs5Wx0ewCs1qPLmRxkraZ+3TFJN0l59KrOlrhKWMmHhVAlHLRYz2E7QwEL
         /XvQ==
X-Gm-Message-State: AOJu0YxDXIn7zqPN3SavJL8vB+tQiUemf2Ger4hr3wnT5WzY91vx7ni9
	8JfUHWtgs6w5oU2VxTm8dmqpFrDEZVy7MUnHVweXM8zrjpNNZ8iga3MPpGEOiJso5R7SKGRc+jK
	mrCP9Ryfl+nkws8XSqEul+Rjb3v8mjVJsXhWlW6LCZCixoivzdLIDLGcNmqTUEBUNy9myQ6ppEn
	P5wg==
X-Gm-Gg: ATEYQzyVR3Vpd47MwphW1mwdAchKUeA2m9kcGb9ENVmMN1eutVLmhyS+7Ef6dZ565/F
	9GmmWcEidFneNa5hqzw/SONX6zdeZobiyUJTl0a+ojJgVNLQOdYMvfb1syxuCLVoZ7AEaiYNzut
	1foH5Ph45p5+W/WO/ODVtcsrBiPu1Bzl+5Zk4BU9Yu0MAycwIdC5vJTT5xmkHZkZsBrAWFbwA5B
	UxWEEkrz0WyBEZcwRopky1r1t/nC+c63zv4Mi1tBoSy5nQkKNY5E5Skk6K3NK+P8PW9dR025vMz
	7xbhxj0BYNAHz4+PligStWU2MhbBpQ6ZjLO98hTAt6RFYxp88MRTrh6+Vx1qRLFHr6neUAjJfVH
	UpE1n1liN0SQhkGQuULBEtBSob07VWErjwjNQRopqbs9J0uXiV7O7bDJgtw==
X-Received: by 2002:a05:693c:3005:b0:2b8:64ad:ad4d with SMTP id 5a478bee46e88-2c1097c1a0dmr7850343eec.26.1774361944033;
        Tue, 24 Mar 2026 07:19:04 -0700 (PDT)
X-Received: by 2002:a05:693c:3005:b0:2b8:64ad:ad4d with SMTP id 5a478bee46e88-2c1097c1a0dmr7850313eec.26.1774361943372;
        Tue, 24 Mar 2026 07:19:03 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c1313bf5fdsm6899720eec.14.2026.03.24.07.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 07:19:02 -0700 (PDT)
Message-ID: <1d9e6d43-6014-43c0-bf47-843ef08738b4@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 07:19:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20260324
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l_CEAbEJ_ANRp7CiJNR5hL0jFcLK3L1k
X-Proofpoint-ORIG-GUID: l_CEAbEJ_ANRp7CiJNR5hL0jFcLK3L1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMyBTYWx0ZWRfXxmkO49LyuGoV
 PWHdG4MC9uYBV5csCbGgtF9yKpIgERcI5KyB83ao/LhpEFUNpPAmmQTL2Xgpf4dyNXW8HHNEV84
 ORRfbH/AU/0bz6LDRQoSrssaNgdNcDtyPwQmmXHY34h7SX4P+nV5HsfrKABBsUXoBQao7F5U0tv
 4Gg2rQzlchEqeU8Ov1fzJiRC3ZUJnjBo/uZrTcJyznSr5jIv43grJfPmSUUgJbcOtQnUVjLwluR
 fg5WZ/Enlf5hR6xyToRLYZnRb5FK98EVqKEUVW3z9MGToHt9OEE7u7tgS5S91LnFD8UhCJ2Jx2b
 xo0NIzVqbe6OR8NpF9DolGyajen+ote6LszUWNFFRhXSL+6DQR4Bu0asPN2qgwJsDqxaxYOwoky
 bn1uOVlVOZpdmKovS0yCOTTNK/sVfD2mycgupeeEuKlOhCIlhzhxTBcHKusSScbwUgpNaON0ymy
 78/E6xr1UaJ603vZvsg==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c29d59 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=3k6IHe8u8opv2P9pMhQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240113
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33776-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35C4B30A143
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit a1d9d8e833781c44ab688708804ce35f20f3cbbd:

  Merge tag 'net-7.0-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-19 11:25:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260324

for you to fetch changes up to 4242625f272974dd1947f73b10d884eab3b277cd:

  wifi: ath12k: Pass the correct value of each TID during a stop AMPDU session (2026-03-24 06:44:00 -0700)

----------------------------------------------------------------
ath.git update for v7.0-rc6

For both ath11k and ath12k use the correct TID when stopping an AMPDU
session.

----------------------------------------------------------------
Reshma Immaculate Rajkumar (2):
      wifi: ath11k: Pass the correct value of each TID during a stop AMPDU session
      wifi: ath12k: Pass the correct value of each TID during a stop AMPDU session

 drivers/net/wireless/ath/ath11k/dp_rx.c | 15 +++++++--------
 drivers/net/wireless/ath/ath12k/dp_rx.c |  4 +++-
 2 files changed, 10 insertions(+), 9 deletions(-)

