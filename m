Return-Path: <linux-wireless+bounces-34530-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDXwAxaT1mmiGQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34530-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 19:40:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BD33BFB88
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB0763002B0D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B763D3D06;
	Wed,  8 Apr 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgCTKpW2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ds5XbUVu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93C328B75
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670035; cv=none; b=YMd0XkuQl46Hlj4AMswbzN0yE34MHmD86Cxqrn43zXK3/nHk3O0euVCXJz8+kyrETmZIYVMKOw2k51Tzj6UpsZNuR+4tAn4Dmh+tL7nSMSapfXYHhH4SidklVn/OSKls/3dvb3CKd58BFKGbzUFtm3/MP6PVI73A4iCDOiRqeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670035; c=relaxed/simple;
	bh=h7zKrbTLgcKjb3x6kal25n5pMbMueE4XNNoTBPUbIM0=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=sTMtMHa0KNH+722ovp8IbhKAvhR0Idwz+r2oppZ00o01ArrI50PnxgaJZVXwn9lwTuAIOutDv7rfvKqIe5sNzJU2fTQw9UDzzzhXntAzYFc9LaoSdSipwDMsWlJmXoPfb4OK5esCFSiu0FW0F1+5s7Bg18RY/7ig73cjHWhfRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgCTKpW2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ds5XbUVu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638GWsSD2412018
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 17:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gofqv9WBuYyuN9VxKxGkKG
	wTp+Gy1foUOIiV/v+fJvI=; b=pgCTKpW2pon0Z3JntM2ZX2JLNgSxCciidnvJn+
	wFvMIwNQLvhzjZUo+6YypRjYmu3yx8T9VTT2+Cu43mIyPkip09EwlRR4w7cix9Pa
	IdadODgN5Uo6nFX2CBjv1/LBELqktsPnP8XvA75TTWniXW3Q7nhgL02uajHkoQf3
	c68Jp6xt/lq89qA9Nn8BhuB2aZAwZzFuM4v+G6Qo537gBbr/EvfAf10Dx/Kp9EHR
	3RlzrviX3W76Qrm6z6vx4Z6JIc2Hy+0HdkBcN8vKmTMyYKqMWSgKzkUv9rgNdh1p
	9SX+ZiU627VXLGM991nf35yWWuUKGZsR6IhCVwAPcFOcjDkQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61vcx3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 17:40:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c44bf176so342956a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775670032; x=1776274832; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gofqv9WBuYyuN9VxKxGkKGwTp+Gy1foUOIiV/v+fJvI=;
        b=ds5XbUVu6cueIuvRFo+sOxeH/329pr5BdRkCpG5BEB0vOMs7a7g/Pghm3dYXMKzmcP
         WZp07AeKYbrV09iWX9/VPVp1dxHE2qzCnFjrstVaVisa/9YXgBLEQYVNDGt9KJPjjUdW
         ABH6osFwt0HUFSkKQTqFvklSls1JdJjKlOZ9gz+n0gtnwXYk55BuiXJghyxjO7cnhwwG
         XxJRzoDA/jMVkorXWup2k5CaGYzzt+o6jyFOOGWOBa6ZZKlWa97yY2LUYbwV0+92T3VQ
         3EsVBFponSGNtRR1Tv/wl0k481Su4slUzXDLIZS4Ui90qIGE80nHLHHnj0BLb8OuHTWy
         dwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775670032; x=1776274832;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gofqv9WBuYyuN9VxKxGkKGwTp+Gy1foUOIiV/v+fJvI=;
        b=Yj7wU/SkCE2xPJ+LugQb8dPI7XyvtLRuswkBa7jMQsSUymBOnPvZC2JKQVKMc9mflH
         YQW9pH+UgHSJ1YApsGuUeh2X1ei6nTBHoCQGY39FHVV7+JebWzHhjfXtWZRLu5kXsmkC
         bzoiOgWX/MAo8IEpDCA74cBp10+lDF16Xdbe2VjrUjBdwspJUN01hns2aOb88T71U9TY
         c9N/AiAMrTpwVKHmOwn4GCbTy9TX+/3EbaMUb4f7u/iirwLOB7jEorLCelM85CQn+pve
         Mtpejx/vcJUOynVRR/ujuUHHiSrvTgY5zNGb6eCNE3r0bJ9R+mOjWDNY2ObKVSyB2f2R
         gsPg==
X-Gm-Message-State: AOJu0Yw/9GeI6A2UXBcE9zIYNtOVHMQBsryb7CYMl6s/z1N9OZaRS9qt
	R4beLjRh9XR8GFbi2opAOddfsMp4Upz+7BNZEHk7WsVIWLaGH5RfPeK1A9vdvbdA5R+iZqkL5HJ
	lW1wETZcfHELoO4tPst89io9zrWBsk0jT3Hdlahi+qGgIFz1k3Ovb5Y9IPUBrhrhVYzadkGAB0W
	WDGw==
X-Gm-Gg: AeBDieuWUYg9sU9q58LklqcTkyqlml1ps24HydI48fBsQIDN4tBJNA9r4wgzaRPBx8+
	6Nl8nFnHpZ8WwMIaRdAAoPe3pPQh7S7kQtuvNaVGWdraraFJJ8qCF5eZ1vtIJkR23IXXK8Wo5we
	1KVYQ94CV7VXaQhW/XJA4WZqvS1uTxxZFnheQsxA3eaY+gHWUU0tgxLoYiXNjWunUKVENz+hIBl
	N0Nujmi0eVDhBybgcI3FJvGu6Vmtu/m631sWYdhGTY0RLtCwdKPOa2UMw6f090al5/3gZIl26ng
	TxY5dIbKx3vxYgAmcKctxoTrbTou5plwXhV+mSBWzXYobD/o/MZrFsW8cIT7FdU4ZqMfjxA6uYe
	kt7mcIobaGLRUtkdDeGYOwNZ1FUOkBhLhzAGklmyF53ilag83e7+yCvnAdw==
X-Received: by 2002:a05:7300:a907:b0:2d1:93b8:bc81 with SMTP id 5a478bee46e88-2d40eecfdb4mr267769eec.31.1775670032084;
        Wed, 08 Apr 2026 10:40:32 -0700 (PDT)
X-Received: by 2002:a05:7300:a907:b0:2d1:93b8:bc81 with SMTP id 5a478bee46e88-2d40eecfdb4mr267742eec.31.1775670031453;
        Wed, 08 Apr 2026 10:40:31 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cef60a435dsm13465207eec.10.2026.04.08.10.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 10:40:30 -0700 (PDT)
Message-ID: <aa4cecc7-d5fc-41dc-ad36-80f010e5f426@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 10:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org,
        Paul Sajna <sajattack@postmarketos.org>
Subject: pull-request: ath-next-20260408
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE2MyBTYWx0ZWRfX93hOqXCPuHFG
 0T/GWIu+kwEmnr3pTpuhR+kKHhzDnevrm3toALHsmI55+qd/rXqYedw1deOuSPvn3z419+sxrRB
 S4bDE/knuj3jhswF2MM+u9QG3Mh31FiWPPsORxiroPXUrD65WamR2O8GUf7OgJ/PxW9+DeyL2Uu
 +ZysYPnPmH70AhCNd/45qbu/HxYlJyHXuQ/M0Z3hB3vF6Q7VTblH7hkr8Ly1wz2K0ou1TfJeUhf
 RTN4XlM9BoxhrgX4NyoUgEnUEDWdGUoqX+bLJOi9tba7KxGjWH6JrdImfjdSP7ndN6ZBfcgYSNc
 H+xd8BXqYOtBngfeTpP/jZENitTmyrcBHaBy6HJUrMZ2dNqrUjJiiZq4c7pin0/9+XSZx9rejrq
 MlqO0wC7YPl9f57ScrIUpH1VhqWaiZmlzRHA6iUfPU5pp3jtdZ6+//KwA9Ykq7L5aQbJByMLDnt
 Xz+6NxbaIyzvSRmEhng==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d69311 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=WLBL4ONXHNtVtiLGnawA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: s5wJA-RliFGAdZF-YQuZjhzlNWFsYiJ_
X-Proofpoint-GUID: s5wJA-RliFGAdZF-YQuZjhzlNWFsYiJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080163
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34530-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4BD33BFB88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This was missing a DT review when I sent my v7.1 PR #3.
Hope to get this in the merge windows since there is an in-flight patch
that would leverage it:
https://lore.kernel.org/all/20260331-judyln-dts-v7-11-87217b15fefb@postmarketos.org/

---

The following changes since commit 8c6d03b7a249ffe85ba2bda09a2a7614c0ff03db:

  crypto: Remove michael_mic from crypto_shash API (2026-04-08 10:11:37 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260408

for you to fetch changes up to 6a7693873b20680a3c33bae0c9f9cb3185f64ade:

  wifi: ath10k: Add device-tree quirk to skip host cap QMI requests (2026-04-08 10:13:09 -0700)

----------------------------------------------------------------
ath.git patches for v7.1 (PR #4)

Add support for an ath10k device-tree quirk to skip host cap QMI requests.

----------------------------------------------------------------
Amit Pundir (2):
      dt-bindings: wireless: ath10k: Add quirk to skip host cap QMI requests
      wifi: ath10k: Add device-tree quirk to skip host cap QMI requests

 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml       | 11 +++++++++++
 drivers/net/wireless/ath/ath10k/qmi.c                       | 13 ++++++++++---
 drivers/net/wireless/ath/ath10k/snoc.c                      |  3 +++
 drivers/net/wireless/ath/ath10k/snoc.h                      |  1 +
 4 files changed, 25 insertions(+), 3 deletions(-)

