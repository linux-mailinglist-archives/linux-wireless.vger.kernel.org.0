Return-Path: <linux-wireless+bounces-34501-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAYMCcS01Wn78wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34501-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 03:52:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5723B61C9
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 03:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB8F93025165
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 01:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25BD35CB95;
	Wed,  8 Apr 2026 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nuykG9vC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gk8RHakI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708271E1C11
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613104; cv=none; b=QGuE+Jjz03qbQ0KcQVVwAuLB8tfJ2M5vpBb6tFFjYviHcF2YvSEvu+ja7u24hia9UBwgXqqME/k5uy5kLoDgS+6KSsrNSbITDcNsRoXDTu48clriyKcalHAaeK6/zInY6noR9UfXpiSAoTyWCWt8VrB5wKPvhReB6IKoWAsUi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613104; c=relaxed/simple;
	bh=jIdQrEbzfiA0SS7x0x1U8KdaCWzW5sPuZ/TQst97vhU=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Feo9OgTp1oxwkvoYgpCzFSa1izbye7hzfmcpQbI5FA18cdXKmM2n5QqN0o4QO1aiqy292+zuJ2wc8ipd0qdSimMZQrftzYavBoHyxG1guIROMk2NgxzvhJty4nIEZoXAvFGpcOqgzlASVuRjcxgurtVmw/kqxR99q8x9PZjSFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nuykG9vC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gk8RHakI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637J6piZ262907
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 01:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o5QbSAw7nIknHBwFapVmOK
	/Fh4hNDuSq1LL4DtnwsO8=; b=nuykG9vC6NuaBHj/cDAqarRqsDeR8cd1+o5LuN
	EPWjf8t/iL2VGWAWaVw+0gJKeRVFgvE3KExRF87sa3WYZPfp4s0MHjwcUZIK1/0m
	v30kjBMOegQoL7SvdB+Nh/ec4+iy9O/3joL3GfQgE7yGTSrDIiQMiCI09DxTaFMK
	XEJ+1blKTyD/AY4RAGb4Jr55hkN49Tirk/G1imCqH/7xrr/Q4xJAhlC4MqU2YEzW
	rinlz8ULcrReDR++BSgxRAgnmUKoE9hIuZnWhbOX2+05DaJfkQViUdj1ZSXqHVAz
	Oi+VMi4dnW1SqLXaLw+kMPWV7GRqOUtawI0zFQvgI5CjXODg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7t211cd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 01:51:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c4cfe08c9dso28729945eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 18:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775613102; x=1776217902; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5QbSAw7nIknHBwFapVmOK/Fh4hNDuSq1LL4DtnwsO8=;
        b=Gk8RHakIJHDUZKaQ9tIT6RxWNwRrHdbjUY0m55JrX9odQKhO9UY+oiZZnpoAqLF3sq
         vuQfDv/uSClMQUjMr9KAdB1LpF4OKyvt18AU6cxoAjNPIu0xELT6HxtVrou4cGY9WivD
         MslIteOr947Cbu6Mcg0UDvhy1y/bj2wKfR5ZAz4Y/adQdFn5bKmvF4qBsCOW61oCmICQ
         Vg3tFbw4IzsQd1sRQsBdscwhCmJhPh8sWjio+TIWciaRfsR3wuU8z//PJcNp2KSA/+ER
         yBRTYMC0MQB4DB8xS8Aimgfog8bbC3BIPGopa7lVK94nnxq98zjImjZ9ekvu0jdw+Z9F
         ZKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775613102; x=1776217902;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5QbSAw7nIknHBwFapVmOK/Fh4hNDuSq1LL4DtnwsO8=;
        b=asKC2XLg191986uoBbxjpKhZWGpJEGU4WjOh47Ha6BSRzyGITJTPHXEnhjeUoowOVy
         K5BNGv3kANNfsETXD1GcS2CxUj0Aojo2DEAOoQhPtQSFqVv6Q05ptcBsB30PrC6KeYvD
         /k/+Tf85MjobJhYQ8zZqUK8pv0Ty4j1zaiV1eCU8jo9jQkjXrQDYfwLFxpZJl38e0Vwi
         OaD28X4y4CXNDv10XAioUQaRrQJEXErRMhNzFXoqB6UiB6eeyvhfW8K8xC0I/wod9XjP
         whNd0q/5h4m/7CEmXPpJfdHBaNVwDpBmAvTfGaK7Gxo41VGMMWakXHY1GfA5gbxDCUbO
         6yVA==
X-Gm-Message-State: AOJu0YxUV6MYTYtr1Rr9PZnr0DiSe7+OA4p4uUHtZrzIo6Y3UZv2gYCM
	nRngoBa6wZidEnrhVRwmwm+SI1YogozfeYWPyaeBn9DwEWYqUof+FRTzBxs/S88AKd5tErfNoeg
	o/+XXmC214xLbIAavyh8xTsqYZB3zkz9KyvvZHPfx5AHkSPz0yZQrRl9Zh3elvpMQGiHoFcv9ha
	xOQw==
X-Gm-Gg: AeBDiesFDANruIyUZMztNP8BaspIyQtIWZJSvguPMp2onjz7gPoTkRP6u7KbBVDuUum
	5UxDzp1AKQvQOn0TpE/nknNGJuBW3KbPy0xGiZ4WBKUoxgI1ncuFWHHiTmtZzQJLA5KbCkSdYZM
	EOT5IueFga14RQ7MJeNSnefK4tyvUgVrjtNmJMVt3Su7aonaZBZeWT9td6BQPpELAxbnvUPgaJF
	xtCZeaDhT5wNIFG5v7TMZDSItS6Ow5fImr7uiFScMoga0CPN6IDt/fuNtOhg6pEUrPVKAFP4O4N
	x/dQ12HG0acDWLL52sYGxyQIkwbnm+iO+8ALSjkXxWb3XwDCePPr1wwKqyGAwi4VCaEoEaSJVvc
	Iwryi4SShhoo1R5IGebOYLyqVK6lgUD6I+gvs47i/RwSJSdIvsOmThSu01Q==
X-Received: by 2002:a05:7301:1688:b0:2c6:cdb3:bd5e with SMTP id 5a478bee46e88-2cbfc365473mr10151496eec.28.1775613101802;
        Tue, 07 Apr 2026 18:51:41 -0700 (PDT)
X-Received: by 2002:a05:7301:1688:b0:2c6:cdb3:bd5e with SMTP id 5a478bee46e88-2cbfc365473mr10151474eec.28.1775613101281;
        Tue, 07 Apr 2026 18:51:41 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2cb4a7cdbsm2749615eec.19.2026.04.07.18.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 18:51:40 -0700 (PDT)
Message-ID: <5af2dde5-a1d2-4c72-bbed-f0a2ef4b9788@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 18:51:39 -0700
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
Subject: pull-request: ath-next-20260407
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=De0nbPtW c=1 sm=1 tr=0 ts=69d5b4ae cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=6cTdqrwTxAmorz-Q3qcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAxNSBTYWx0ZWRfX5IWFBTklZbEb
 Q88MvroBHwRCPQziguM271wdoOquK2VosovdMsCbg5jzuXik9YhWm1XhlimCm5N7Cz5ZoNNNP9L
 L8BdE+Z4XIUJRMlaYIynSsNuvnMM09bCYGYj3cucOQJOGtHdDlDS6FMu/IVWzHvhttxFrUkIb2O
 N86BBMycZ0Ft5xagtHQ4jQ0XV3WV8xVha9IcCmCaitY9qq424AHu2w0mOMNE/8JiYOnPqgrD/bc
 rqrj6KBMQRgcblT6JXp00Ai7CNegmto5ts6aV2J0PTcdZkx4Ig+Z0OVl4B85G6EMMKX73BMlw1I
 DBbfN6Bjqsztq5h0olVYcPeDEsrFAqRhCqCl4soYJsLpj0D4je6/qSiHjRUls1qn46ktHnzSJpP
 d+haB0eXn+X0P8t4Ec3JuB6hyx2NidVgyIzNFVeP0cd1ZaqL1y5OrfoAt0V8lRDPWPup9OjGbnu
 aZCedruE8aRFUYIxD/w==
X-Proofpoint-ORIG-GUID: OQiJ15H_k61QeEa4-pSXbdMh5_Ms3LnM
X-Proofpoint-GUID: OQiJ15H_k61QeEa4-pSXbdMh5_Ms3LnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_01,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080015
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34501-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C5723B61C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit aa5e9884a2d63aa20fc3396d369382c1ecd16109:

  Merge tag 'rtw-next-2026-04-02' of https://github.com/pkshih/rtw into wireless-next (2026-04-07 16:20:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260407

for you to fetch changes up to 8fb66931fe31094aa2e1b2a5c015050b8b4cb2ec:

  wifi: ath12k: Enable IPQ5424 WiFi device support (2026-04-07 17:28:22 -0700)

----------------------------------------------------------------
ath.git patches for v7.1 (PR #3)

Add ath12k support for IPQ5424.

And of course there is the usual set of cleanups and bug fixes touching
the ath10k and ath12k drivers.

----------------------------------------------------------------
Avula Sri Charan (1):
      wifi: ath12k: Skip adding inactive partner vdev info

Baochen Qiang (1):
      wifi: ath10k: fix station lookup failure during disconnect

Harish Rachakonda (1):
      wifi: ath12k: Support channel change stats

Raj Kumar Bhagat (2):
      dt-bindings: net: wireless: add ath12k wifi device IPQ5424
      wifi: ath12k: add ath12k_hw_version_map entry for IPQ5424

Roopni Devanathan (2):
      wifi: ath12k: Rename hw_link_id to radio_idx in ath12k_ah_to_ar()
      wifi: ath12k: Create symlink for each radio in a wiphy

Saravanakumar Duraisamy (3):
      wifi: ath12k: Add ath12k_hw_params for IPQ5424
      wifi: ath12k: add ath12k_hw_regs for IPQ5424
      wifi: ath12k: Add CE remap hardware parameters for IPQ5424

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: Enable IPQ5424 WiFi device support

 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          | 26 +++---
 drivers/net/wireless/ath/ath12k/ahb.c              | 36 ++++----
 drivers/net/wireless/ath/ath12k/ahb.h              |  1 +
 drivers/net/wireless/ath/ath12k/ce.h               | 13 ++-
 drivers/net/wireless/ath/ath12k/core.c             |  4 +-
 drivers/net/wireless/ath/ath12k/core.h             | 13 +--
 drivers/net/wireless/ath/ath12k/debugfs.c          | 29 +++++--
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 72 ++++++++++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    | 26 ++++++
 drivers/net/wireless/ath/ath12k/mac.c              |  4 +-
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |  8 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  7 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 97 +++++++++++++++++++++-
 17 files changed, 383 insertions(+), 46 deletions(-)

