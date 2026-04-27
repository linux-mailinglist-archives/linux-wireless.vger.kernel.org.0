Return-Path: <linux-wireless+bounces-35372-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBCKBMFt72luBQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35372-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 16:08:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704774740A1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 16:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0283C30209D5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12103D1711;
	Mon, 27 Apr 2026 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H0hbbVxg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bomlw38m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E223234994
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298516; cv=none; b=PYU6cpLqc5OydwhDM+cpqvgsCJFLiFFuMWYXhWIzJnTJkjaDLVXff2JZEc4GjjiSCIx5f+0Du7vrkvg0OvCztRerbmDkOIo9wZ/OBBn74FnDVdmz8naj7RjDMySd3A0SooYvSsrsk5NuN4XxBaiYHpf66e/1+btAge37o5l8EFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298516; c=relaxed/simple;
	bh=lwq9gnr7V4tqYoFKWGoNOtiwfxUyXUX2hHu7W7ZX930=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Gj7Em7A2FVhmiUi4L+M2+BmaPIPUIitRCDKfj5hAwZ94aKxVwGhsQ0LC0fRVwnRU+tbwMUSI/PegxDFpX5wAMpaMrsZTL2L8ns39MaPy8V09HfrI4fuMvTuPpWzjovXhUjHDqdSA/cV9t6iJ/RTD7njC7OcEcgbVUVX6h7QAbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H0hbbVxg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bomlw38m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TEKM3639733
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nILNB2NfkxRGoIS1fc1qp2
	JXSYpJLFP16z5zIuaSkNU=; b=H0hbbVxgLqait/8cAo16Pjys5o01mh29ilPdb2
	hdaTjtYbbpV5oZcHNe66kjrEmjf+GtxUnrUj01OSWwnk2PyVdijk4FmOLr7dqez4
	JJR/dsbLAFKDQsib0xz9VXHEBjB0x/rsCTjbtvCLBQOCUg9DyGuZKI8mo5eoEZBP
	OkAfC2OHUNcWg1qvAmPDmPNENpWCd8WqE1XemimTC4saI/nFQageBpLcb52lmQMK
	Q+o1R2gPEFJV/AmDF93umW9SUT+90KF/8FP8AaLjRTUqJJwKogZQ0A4Ou+APoUJ2
	4sU/ATNjFCE5XftvZTbhgf7E7AGWwR+ArwE32snC4UuH1+wQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya02btf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:01:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso13016060eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777298509; x=1777903309; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nILNB2NfkxRGoIS1fc1qp2JXSYpJLFP16z5zIuaSkNU=;
        b=bomlw38mU1hcg6lLSlEvrb+t9CNoNKX941Nfahx+oIgefrYbm1O1bE1XamXcqt6G5J
         o97+V/E8gA9zBT3dvkv6I8B/mWNKI+PXTcKUVfr8qeuueI+B8kSZ6zb5HVNbBMftXW6P
         si38bMXXmXiW/78uBNQqETgG5RfVcx2vuIMYDOO1NI6AZLjsbkRIL4JR+SwAUsMzzhKz
         QsBo4QRPSYksKO71k3IPBKfZsti6R1nbfQNhPsNGSG+7Z49FjjjNkXRvRgOfmO3+iKpx
         DLCAErYdnWaMnv9Xj6bVyMWDtY6aaGTA4yeETREjSjRNcdzoVNMWpzbqqyzo3HtW1H8j
         dMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298509; x=1777903309;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nILNB2NfkxRGoIS1fc1qp2JXSYpJLFP16z5zIuaSkNU=;
        b=g7+o98Du1gCxMlbLTV3YC870ZIsqbeB2InIs5LNnL9pZvNi8xsfwPJISkRqecsjQE8
         hbcN4KOq4zQp1KKtriqar+UGHJ5VdCbP1qGcakRUo+fHhrq8+GtSAfe8Zltl3zQLScSp
         c3zWaGEbwaFOEsqAS29NfNKl2vwXzdt9DMEi4ppQ9NjzrLLBlKTPEcVtXvEAtN7FobMx
         BhDMu/SJaJ1Shyvn+k6Ns4W8rr8L5NacshkoDMjR6OkvCBp94VjzsZT5kh0Sy3Ngj4DM
         OvWXtL4PVKDC+FhWBHydW4ZQJqTHDmIaWaOmm5G/2pMBM1mvOjPx4xdeLH0kLx4kZc21
         8RIA==
X-Gm-Message-State: AOJu0YwjJm/SGH0MUC3aRnPuKpQJ36QVg1wN6yz1cwsrDV++eI5iWtn3
	WiyZQsLYdAEPPE3DtTK2mBgCHAiEIHo6MalIjUM5YOuiNIQjJsY5uERc72TejcvfcGEEH7tV8oZ
	ufLTZ12jiemtWtJzGe5oyAHlC1suPzmoBsZRK6v7YE2WcgTu6rfe7oRXYjfyMB1dZbkppxTgjV7
	QcNg==
X-Gm-Gg: AeBDiev7/8VypOR0/awUS9xJU2yKtBPaw0CMmAJ7n1OvD8ZBJwjDhbNF3RteCd0RRci
	h4NzvONeWd1zVvhyCSCmPRy7Ladt26uwWtjkJnFi08CBhOBfHmo0TNORSnQXHqiAZ2C26lWnj35
	6dMZQEEpHPLgRaMft2HnzbUAcmgQu/QqnqYdMK3WkbntMFGsLoxzfJmbrJsZcFklwm05CtyE+oT
	FpRB9/0yoUr8pQCygXdXUaKVtrOBPyYzEifS7fJq5iIKPuvTmujn6Tjt/5JIet9b0+N3zdmrb7w
	Kq3KGuqUI06ONBw2vZGoJsjjUy89Zwvm+AqiaJS/7V2zJ0tI7CVYnGsLeMggA+NFYzv0S6B4Q1O
	3KWn4n0mCntMYBvx4AuijmsKlnRIUt08cPDYtc7K/9836f0OUDgbFqiTW50w+Vr/Qfj6K
X-Received: by 2002:a05:7022:321:b0:12d:b654:8171 with SMTP id a92af1059eb24-12db6548357mr14649842c88.1.1777298507910;
        Mon, 27 Apr 2026 07:01:47 -0700 (PDT)
X-Received: by 2002:a05:7022:321:b0:12d:b654:8171 with SMTP id a92af1059eb24-12db6548357mr14649716c88.1.1777298505647;
        Mon, 27 Apr 2026 07:01:45 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dc6f08eaesm19806512c88.12.2026.04.27.07.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 07:01:44 -0700 (PDT)
Message-ID: <411dfb79-9449-4c7c-af0e-d9d1dc81f3c6@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 07:01:42 -0700
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
Subject: pull-request: ath-current-20260427
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef6c4e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=9dYn0W3-_-pxAYNLL-kA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: daZw4UuJkp1BIWDUeKyMwfdN1j6-UuQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0OSBTYWx0ZWRfX/Jx7/BWNx1zw
 a/DSjayWqHyN5iK2Jbzu6MXhosgmOenoIb7s20UFqkXUdX9TEzZu1qqt/dBEjpM15kNzy8k7CxY
 tsl3nX+6dIskrgc+QIT9RdrhwLjMo1enE6swdMGc4efMxw/zocBET1m1XVsqAM26hxbaVrCt6Ud
 A26i++PyuR4/62xuxAYqzka/Kaax4h8acI0/Xjmh/SO8SQDk2Rtg7e6tzjIqH/E5LY0GGczRflw
 1lICcyghA23SIpsIehS+wYzxXsmzHLQfQBROJnjJZ3bj3Y8MGEeTNwqvVJub6rcK8uneTu5eSPn
 xpZc2EWpEjo24SUEF0CbGCbrsUQlcsP7GjfKVAsuWROdS3LKaU8Bd8cWM/ORLqU/UOd3R4DCQTM
 5zp8m8jG1n/BRfZq0XaEwpRZ1QKR7Q==
X-Proofpoint-ORIG-GUID: daZw4UuJkp1BIWDUeKyMwfdN1j6-UuQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604200000 definitions=main-2604270149
X-Rspamd-Queue-Id: 704774740A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35372-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:

  Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260427

for you to fetch changes up to 4498664e2d5888efabb96428196a926acdaa25ed:

  wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions (2026-04-23 10:57:50 -0700)

----------------------------------------------------------------
ath.git update for v7.1-rc2

Fix an ath10k build dependency issue along with a few ath12k bugs.

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: fix OF node refcount imbalance in WSI graph traversal

Baochen Qiang (1):
      wifi: ath12k: prepare REO update element only for primary link

Dmitry Baryshkov (1):
      wifi: ath10k: snoc: select POWER_SEQUENCING

Yu-Hsiang Tseng (1):
      wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions

 drivers/net/wireless/ath/ath10k/Kconfig |  1 +
 drivers/net/wireless/ath/ath12k/core.c  | 77 ++++++++++++++++++++-------------
 drivers/net/wireless/ath/ath12k/dp_rx.c |  3 ++
 drivers/net/wireless/ath/ath12k/mac.c   |  2 +-
 drivers/net/wireless/ath/ath12k/p2p.c   |  2 +-
 5 files changed, 54 insertions(+), 31 deletions(-)

