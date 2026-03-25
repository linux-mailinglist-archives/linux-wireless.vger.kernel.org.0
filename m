Return-Path: <linux-wireless+bounces-33866-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB+EGFQjxGljwwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33866-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:03:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22732A404
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C33473063832
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688523CF69F;
	Wed, 25 Mar 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qbv5X0Hb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LqhtlkN2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DF2853E0
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461610; cv=none; b=PWgLL+NUJmZg228IWkOVZC8njiz2BF2sBve1R0Ttxx4CawUcfVGHKKi1oOg/wRK/3HKxie6b+2rQ1c3AJyHU7lIhIV7ABY+jNqgJE7myiT16kZVvYa49y2pNuMzW98Rk8NO5kDnX3TOWLNrBO/Flr5ThzCI7ir9EiHsekoc/dY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461610; c=relaxed/simple;
	bh=zkf/rL7/VcnTAZf3LwDJ2M/BKBSaZhUrZA7v2T4WaKM=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Welho/Lj8nG/DxrEiCovv4wbsTjfVZl8YBWMjUCydxVOdzCNuHt/BUy5kFiXBmmQkI5NyKxLYNmVLMf5MpabLfred2c5jydk8SHu/g1DOaRd7EVO+GFbwnWUBEsyJ4qcj+EkVfR8sbyu6bnrWF00m1L/VukxX3VvN0IrPWGEZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qbv5X0Hb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LqhtlkN2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFHANS2737654
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 18:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M2igQvo0xuhoDdesLA15tF
	kb4vPga0Hsxbg78nCkoEo=; b=Qbv5X0HbVUZz+vewgHuF9ZN8NA/EpeX/qykEMP
	nf07y7SUKqHGQKCiXfclA2j2MIo4SNlLok57ay7OwRmTa+XB1p2oXh2WyKnpSVxp
	bGvAl9kYl2Ou+U/BgZEk5ZZ0160XEAa2bGL7vsXHEwsV6fCe5v88flhlnUD/1Urt
	qE4cI270bk9H1lPbYuasIVtfS1HdcrT/0wYAWOYpfoP+qrZou3p+h5Q8+oPDHL4l
	syoCRgv0x9FxzyQ/tod31mWf0iwn8CY9XlzQ+cV+YFO4Kauc5wmPFwgl/Lw52aY2
	gcN5eoyfgU6Q4sKA1hXGuijWiQPcwe986ydsQQzr1w3TgdpQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4859b1e3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 18:00:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so134904eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774461607; x=1775066407; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2igQvo0xuhoDdesLA15tFkb4vPga0Hsxbg78nCkoEo=;
        b=LqhtlkN2fzXYfQy007bj3y76XnPM/q0H9KAZSmviUZH99gOFnu6+5WSN/LZrQNMG7K
         zU5jlndNn1tzdnEU2TOJKO5zTcDbBV51X6RmQfD5sWLFS02Y5mzt7ml8h10XcLaSVEmC
         0MvCcJ7x84v8TYE+2VzQzfDzoXuXytBhO6pmoFjrbc8bra/DTpWqJn07XE/2FuzbWpE9
         w9m/08Pt0WoCu+POvJd8S6OXOQ6sxJufaYiWkeVrLLRB/q4dfacTknQt/jYEvhb26Orj
         dW5gOpIJTP0qK0PillqZr8o2Jozs4+B//r0RujAF2P1JZi782lsgdU56qIRepE0WM9tT
         kpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461607; x=1775066407;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2igQvo0xuhoDdesLA15tFkb4vPga0Hsxbg78nCkoEo=;
        b=rpSSmm064dsRAn6ULQCY4o3Yxhy+ocp/T8qBOD+NOcT5fZK5u6DYSdp5777ATLBFWW
         944u5fjtGgZyY89tq4P2e+1flXCuHanPf1FH/U/VuYPHHBGq/T+TpCRj2icdM5spE6Ko
         PMq1lQFWBircE/nZsi2B5YRxDSEOzVvvoHXzxaWM18uSITY+BZSwOIXfamWXi2BakgvE
         aQjBGt0jOji05nkie4xsGAhy8YOMTCJb4JMg7aktqGDccX0BM2s/yOztU8jAbEDKFaJt
         VVKGtClt2SFMBM0eKYT5SqaA5SMlZ++qGTZs7vgAcT3cy3DxwDtrwBON+O4CFW9aLfKL
         wG5Q==
X-Gm-Message-State: AOJu0YySO80m39at1okOi2piIO+pvsZNrrJL7Be8d6Xedrpmrz7RD5Qx
	Eo+l2TokMKHBwbxDZKPOaJqRySLzPQVqdpkUreT2cR1XQx9pWrkvWgo/nSox1TRnRa224arY9jE
	EBL/CizfQ5KGxYsZe3hwhaHHPWYfVwyualdSCJcz9Whzt4y09mX06jLNdNkRi36wiOxCoGg==
X-Gm-Gg: ATEYQzzjJwN+TWwxCNPmbyjL674rYepu7h+RwkcjoVIuKzUN3/DiShdbE4/pLHjELT6
	XvC5nI+ZsQm8TYSuBPdZn/DU8ak0fmNBYT6qZjZcoqB/Q1OdydIKE1d5dMmq5ryl/faTN62T1YN
	Ua4fNE+mBVCpawe+ck+Om2ggWXWuA6XwJysbGGlEGTdBrtAe0wdohAQM1aW5hCRvLLyMR3L8Q/r
	hV7xlUrcQt+dKMeNGfftTKFxxmboiOPfpPKZ+EZjirKzxn4CA7zL3rlh5nYcTj6Xw4YxmXdFl/f
	p6DvbM0uT11PoLqBE87l8wDt5QlVjvYuD/fneHN7CThW6p6w7887XP5xhY/1qiYdDaVofe0nEYE
	FFWlW7HGGLfQ6JkJkTrNiwYTdh4NHa7PRaD5EAMtpPYszOqHktdpUdIkX+g==
X-Received: by 2002:a05:7301:e22:b0:2c0:c152:ecc7 with SMTP id 5a478bee46e88-2c15d3568d5mr2650441eec.16.1774461606773;
        Wed, 25 Mar 2026 11:00:06 -0700 (PDT)
X-Received: by 2002:a05:7301:e22:b0:2c0:c152:ecc7 with SMTP id 5a478bee46e88-2c15d3568d5mr2650432eec.16.1774461606183;
        Wed, 25 Mar 2026 11:00:06 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec2690bsm428056eec.5.2026.03.25.11.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 11:00:05 -0700 (PDT)
Message-ID: <32af006e-265f-4239-9b5f-be3d52996e10@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:00:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20260325
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzMCBTYWx0ZWRfX+WV7lBlKZMoN
 EiGBPlVea8ZedgvGOq+/r4iNgpogZ1iErAzAJ4XqqwvZ2pl0o5UT9DczF3VjQPC1ZeP+/49ie+Z
 sL8D9NCIklN5otkvVEvQw71zldldSga5kxed0zui/SldHPytp0U5i9pjEKYzBo8SkGTLCncEE8I
 pDRkmGw63gKXTA5vPL7ZqUUQODFgRLx+k4kLMw5ZkokjF75CU+4MTEKsLSsSEZ9GnMCBRmlbO+J
 UqdA1btCbFLpl6+mM3/garAUnBZNwaEbUUUW4Net6qdiSCuKXJU3YH9VgAAOVpdi00cYEOERRXZ
 J4cm1PWgaQt7NWJGGulAEN8nQfFyxTBUrKV9txXPt9F6/rssOFnf2jx1mSYbhnkdSAqidhurFJx
 o0X/BaOJtP9GSrz+vflo/6/Uiz8a/hrxOW9scu2qJ/2Vep7eQaJzkVB7kQFVzBtL0Rknu+4Kfc2
 homYk7pIVACy8x30kwA==
X-Authority-Analysis: v=2.4 cv=VODQXtPX c=1 sm=1 tr=0 ts=69c422a7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=6dYnDcIryfdnK3l1ooUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 7iJf0CH12jUxlBitz5MF3AFbR5kHZXAW
X-Proofpoint-ORIG-GUID: 7iJf0CH12jUxlBitz5MF3AFbR5kHZXAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250130
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33866-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CE22732A404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 51d2775ba036b0dfbfe44c7ba0a1350ddaefc058:

  Merge branch 'qat_4xxx' into 'main' (2026-03-23 21:17:08 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260325

for you to fetch changes up to b56c03b621391558627e3aafe5a8dc32d3997680:

  ath11k: WCN6855 hw2.0@nfa765: update to WLAN.HSP.1.1-04866.5-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1 (2026-03-25 10:53:18 -0700)

----------------------------------------------------------------
Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

No updates for ath10k or ath12k

For ath11k:
Update QCA6698AQ and WCN6855 firmware to address a WoW page fault issue.

Please let me know if there are any problems.

Thanks,
/jeff

----------------------------------------------------------------
Jeff Johnson (2):
      ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04866.5-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
      ath11k: WCN6855 hw2.0@nfa765: update to WLAN.HSP.1.1-04866.5-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

 WHENCE                               |   4 ++--
 ath11k/QCA6698AQ/hw2.1/amss.bin      | Bin 5083136 -> 5079040 bytes
 ath11k/WCN6855/hw2.0/nfa765/amss.bin | Bin 5005312 -> 5079040 bytes
 ath11k/WCN6855/hw2.0/nfa765/m3.bin   | Bin 266684 -> 266684 bytes
 4 files changed, 2 insertions(+), 2 deletions(-)

