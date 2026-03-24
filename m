Return-Path: <linux-wireless+bounces-33777-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP9UAwugwmm3fQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33777-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:30:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4330A2A7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 15:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D31683118C0B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6083FEB3D;
	Tue, 24 Mar 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lx+RkNfO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BF34EaeN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF83FF88E
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362386; cv=none; b=mOpxA0fKHX8ZR2N/CO+gk6Aki1ZNHelVmvfvDvSFuA6bmc0PhYchqy5M5I7XJl7jbz//R/FbgVdv0w2hw7Ry7WAiOAvizbni2zZQmzw3RiI+07fPyenQhSvc7seqQIzD1KNPQbdRs3fqDsFQAXlG/+GzjpQgPnezTYi2IyMU2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362386; c=relaxed/simple;
	bh=qF6LEQ+EMgLc1uuhlTDvAsfDxDFED46KcuzGEBqkj0Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=dQj/Oozi86FqiXz3fwrH72wL915y4MWETfhwHbfYp7Kpej+ubZLIkvoGIOAX8GsGVXoXA85FG8OgVIKrzkEqTxq5RkztbmR7Zp6KfrdfIKC7LpEFI4HCc1Zo+XGb+gMCWcERMx/wLkr4w29OT1MecxW4vse2OvduLuJxCL1gBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lx+RkNfO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BF34EaeN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OBaxnH1291321
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zFfpdhBbsrdk8VoedMBkIm
	KgB4/G1LamNSITgtRYBVw=; b=lx+RkNfO9S5pfauFJwNbAf+vhR3/y4Y/rrvv8s
	UuwGfafxjzIYcFIE2tc+aItnHxIiFaAXatokxH9slC/4xMZoEaaO3rJIEz45Hg5R
	Z5x1irMyRou/cWGXvpwfivl54NgM8qBN6HsNgViOV5h+WHCdAJOo/jgJgF5ymKCq
	Z0tlr5WrIySWH5Wi0weFQnBKfTZHcp/WO5HGHb+6LC3OUciZyD2YO+rRVhcQivoA
	7cOr6/KxwsY8eLPfCcEnaAsyP9V4w+AsAmwcTjOUXkrdpKfD8AY0dX7xjldITi6P
	3dsb6lwg4mN9uFg9qhRmhuVgVdkSuW92SYv8TjsO/GwPbwfQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw40py9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:26:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso1174658eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774362382; x=1774967182; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFfpdhBbsrdk8VoedMBkImKgB4/G1LamNSITgtRYBVw=;
        b=BF34EaeNaTHAYu248VoCD06gg2R0bHExS3G9fTl2QKFVqmevv/JgwFGtssE5lYbheV
         nmsbgYBVnD63WSK9xMw4F1dQWSqJmAGoJchh7/wntjdPb2lrf3K30sFhfTcHw6X7rDWX
         jXw4aX87Vk2WgjEvhqNI7lClA8PdNvzR7+2Kqjyuo3pB4SUaPBQa37fDyk+2zO2zcXbm
         RwaoeuWglVCndQmq7UF4u9+pBIUA/hliz7gGDauZyD/FqGlZ1IE3H7oJu8hlMLG+kmnO
         625a0xUpSY4Ng0i9vXqS6Jffu0agV6Z98IsKTgPybuFVPmsEBqkMaF7aM6578dAPvenQ
         PGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362382; x=1774967182;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFfpdhBbsrdk8VoedMBkImKgB4/G1LamNSITgtRYBVw=;
        b=NknPyQtSQ+XEGqPQPndGrRQIG5wk7sYEZlpGnN5NLjRLxvpKrRaPovBW2ei89LlNDM
         loDVBoAU99VzzCMiD83a0RdadWjx2v5UyWU9Z8rlFnvnnBbU8aiP4Bsn4/9ZPJiLB2mQ
         2TTrid8tz2EqLCCEGokESHkgjqdXmdjGvwRtsyC4J9TpSRWzE5B5TlRpDoxM78iRu0GM
         RprquIevwA0dXPata/IU1XlJsxajHERrpvzvt9kbq41CN4Ry9VPbV7y34Z8zXDNa7WDU
         zaUz6af0uJirhX2S1iKrlT2B3IZ2qW85Vv3PjXbCqgNKOqow4lAk3zAvWFNfAzFx+5Dp
         ztkg==
X-Gm-Message-State: AOJu0YyDKNsK0DwHbvZeFoDT7UGoc1xYCY5ichIGRAF0Yj8uIrCfmf/d
	JZZID8plq5Sjzob05u1VhMWCsgJzWE3nz7lW4VslMjjSRnjr2AiYSAIZkIw5TI/OkXSjFSdqElf
	j5bcNOQ62Md0g+ZdNbPRhUmsR5PpWepaTDn+luE14lKF0OVcMwHOhJ6h9pSDH2l4mn0/4Z5eBp7
	gthA==
X-Gm-Gg: ATEYQzzrNtS8Y03+XVC3ivXs2pW0nDPzui9qo1Y8fSfvmroqN2HSwT6juHHGhcIqOlK
	gIQqlTCXn8zS2/TLM7Trr0TO734C1ltSH/gwaD0SVvFlfFIgKYHss/g1nuAiO2mmzRXMCJEeh2E
	iQs2vBX/k5KAK9VMY2XD9L+h0UF9TknqvXILx3mcmt/vk+GsMC06u0rtAg/pAwddLkOxt/wToRU
	nPzc538Dk8MLN5Yn9iHdlZ7HW0SBqYiqthPstRDR1LIf2m4UGtFnHZ9Oh768FAxsMUR8g1e7bJj
	dvPDSfU84benPsYdo8nNxoFwD5ShPmfj1Lwc0j42lfiIbHgL1pv27WwNXxE/xmV2Z4gF/aCGmnr
	nZOskw941kcEjZLJEz3txZuXa5wjt0CVBq4njmMjjxsVf64BwsBf6yZ1NLA==
X-Received: by 2002:a05:7300:d706:b0:2c0:c5e4:6057 with SMTP id 5a478bee46e88-2c109711608mr7572335eec.19.1774362381739;
        Tue, 24 Mar 2026 07:26:21 -0700 (PDT)
X-Received: by 2002:a05:7300:d706:b0:2c0:c5e4:6057 with SMTP id 5a478bee46e88-2c109711608mr7572309eec.19.1774362381155;
        Tue, 24 Mar 2026 07:26:21 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c299sm15307555eec.6.2026.03.24.07.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 07:26:20 -0700 (PDT)
Message-ID: <652ea26a-dcac-4491-b3d1-8344b2969750@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 07:26:19 -0700
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
Subject: pull-request: ath-next-20260324
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExNCBTYWx0ZWRfX8B5iFwXHWjer
 dOjfMi/WV2g+M+xzyifvlSO+RyJbcVWoNRiOEP5dfs50L5ziFiUPpJSbpf4CG2SPqvbE+DodCf8
 s2Ru0E+0s75CtugtpGKZQor2JCzKQrcMuy+jyixM3CzrXK7EAJ1wbDrVEUGU1Ppj5ufhtdq6Q1l
 vI5Q7SOCKJLzkXyeVrAyGD2SfhsmWy9mueqOIiKUm1eh1gBq+J3XWj544qHLu78JnBXrco0+5kX
 wy8k/INfMDobUuZMcL+1SPpqoCXEsVbFhm85VlVAYToM98B/kYtt4c5RKoJEmP8XKJuyr1UxiH4
 bR7nHlWPE3ivKuQLDjBpNZVhRynCZL0VdFVebL9wQji2B3rGMN1rjvUP08EhuFfdlZvx2rsWdKs
 BjH2nVsQbYW9gF51O9Ajx4nqJxSxaxinJuQ+9tQYoEzd8N61Bj0NuGAtcquUZ/4+TGl7WbPO9Fz
 /cjjLnebUE1RiZDh4tg==
X-Proofpoint-GUID: rbcN0-spWeXnB1H0bTJJtSeIYJMaMyQm
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c29f0f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=9AVruJRcYE4s2g_FswIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: rbcN0-spWeXnB1H0bTJJtSeIYJMaMyQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240114
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
	TAGGED_FROM(0.00)[bounces-33777-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 4DC4330A2A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 44d93cf1abb6a85d65c3b4b027c82d44263de6a5:

  wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing (2026-03-04 11:50:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260324

for you to fetch changes up to 7bbb578fc43e7dcb8690cfc98844bd67bc311e8a:

  wifi: ath12k: Remove unused DFS Unit Test definitions (2026-03-16 08:34:23 -0700)

----------------------------------------------------------------
ath.git patches for v7.1 (PR #2)

A few small cleanups and bug fixes across ath drivers.

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: Use .mbn firmware for AHB devices

Gustavo A. R. Silva (1):
      wifi: ath6kl: wmi: Avoid -Wflex-array-member-not-at-end warning

Jeff Johnson (2):
      wifi: ath12k: Clean up the WMI Unit Test command interface
      wifi: ath12k: Remove unused DFS Unit Test definitions

Johan Hovold (5):
      wifi: ath6kl: drop redundant device reference
      wifi: ath6kl: rename disconnect callback
      wifi: ath9k: drop redundant device reference
      wifi: ath10k: drop redundant device reference
      wifi: ath10k: rename disconnect callback

Manish Dharanenthiran (1):
      wifi: ath12k: Fix the assignment of logical link index

P Praneesh (1):
      wifi: ath12k: Fix legacy rate mapping for monitor mode capture

Sarika Sharma (1):
      wifi: ath12k: account TX stats only when ACK/BA status is present

 drivers/net/wireless/ath/ath10k/usb.c          |  8 +--
 drivers/net/wireless/ath/ath12k/ahb.h          |  4 +-
 drivers/net/wireless/ath/ath12k/core.h         |  2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.c       | 24 ++++----
 drivers/net/wireless/ath/ath12k/hal.h          | 31 +++++++----
 drivers/net/wireless/ath/ath12k/mac.c          | 67 +++++++++++++++--------
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c | 76 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/wmi.c          | 58 +++++++++-----------
 drivers/net/wireless/ath/ath12k/wmi.h          | 14 +++--
 drivers/net/wireless/ath/ath6kl/usb.c          | 16 ++----
 drivers/net/wireless/ath/ath6kl/wmi.h          | 11 ----
 drivers/net/wireless/ath/ath9k/hif_usb.c       |  4 --
 12 files changed, 180 insertions(+), 135 deletions(-)

