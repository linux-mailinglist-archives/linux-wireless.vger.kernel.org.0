Return-Path: <linux-wireless+bounces-36605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGswBKgbC2pWDgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:01:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A0556E3A3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B25FC301913B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359AC48C8BF;
	Mon, 18 May 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PcSYj1NO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jvw309Dv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922D48C404
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112457; cv=none; b=DVKTxFzjdvoSd76Z15wuGbka8gjmMCf71MuJGA4vDvhnnsku4MwrJdQ4ZkxuSdfQv/Sn7YpAOB4769p0xR2A3isc2p8yn4ZFhR7zsrN5LeIc/V98u8KFL4hD17I5TgsxJEP+jpGnJNUJhgFZZMRFyOwt4f5I4fobCHJq54gG8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112457; c=relaxed/simple;
	bh=hMAab1YF5KM/j/ndR+8A/mF9QaETpe2X4brJaAu0GMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UX3Fnl1NpPDUHjxs+Phu5S8HFJ91QHfqB+9ES09+2bVHHeBYG+H50DNuxn0kwXf4rLLd+dXTOINH0eV8zuolTKjni6E/EcjkfaslI6gnPfQTyg/bKxASWzvRFlvmBfRdVlyOif/NWHgKu8ja4YA++HFs8HMVKDB+slz7OLBmH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PcSYj1NO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jvw309Dv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IAa3vS2685335
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ar/YtC0yQYN5h932Kyk0AK4el2wmEbuBZQbQvZlLCrg=; b=PcSYj1NOqeqWBQ8w
	Mg85/nVTCWQv5v1XTxYfP4Vkh9EIR16/1/QUm3PHHp21gNKK9NcK1n78qBRJJ51Q
	ljN8E2olgGufwIWlL+tJDTX50N6AU3aqjDn8+RGz6urjnE7KfpgMmEH7SKIXvR6d
	DyJ6SwcmtQ3pVA8kRLTszkywkVxZIEauaTmvguLxbRf+IRUDdNKUi+kagvMcjQem
	a4nm4bStLxjAehLMA2w1VUPz0LyOsUJWY3OSc7b13X64Qi1Q8RXvl8F3oU8g94iZ
	i7pkGkRkiMbcwUusEgcVDcc33GYlM+kGcNkaT5SkP1wlYidktG36qb1xIpQrkW4t
	A+2DKw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbt2c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30230e64087so2737670eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112454; x=1779717254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar/YtC0yQYN5h932Kyk0AK4el2wmEbuBZQbQvZlLCrg=;
        b=Jvw309Dv/5VdQHw9HLJcYayEfS31F1rn/1KeXiB+CNzXTnxpQevVDJQwclG7uzOT/F
         Y/fXT9mNxc1AUEANKYAj1bWpiGCzth+WZvHJOO6yqZ7moA8WkzaX7yjHiSTHP8e9jN9X
         m9c6hd/R5EHAM6mSJXNJZgTw6Vg2BpVHhuwWVL0/WrUGIHE3pxdaSDWjHqfJ8NsEss1z
         J9gBB4nSvjbYqy8tpLPV9p4wZMtbnQpiSw/tuzyyFUiTQxC2ohT71EDtyLqRPs3feRCF
         v3A1IUdrBHMElVkl/TTjyuSBPKBEVxA17GHk+PdKs9kjQ5LM+4eq4bOKS+B/BtGy/7u6
         eKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112454; x=1779717254;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ar/YtC0yQYN5h932Kyk0AK4el2wmEbuBZQbQvZlLCrg=;
        b=DkmdTyDjrutU/vETb0XKYSgAZ+Y0aDv3rCsgs6q5bpX9D5TkMPzFRJcgrg+UxTlNBS
         ZhBRr3adePlgiVCImPz4KcfQ6u68GJYrkSo+F0MSRGjhjSXBNnbiUuUTFiEZ19PZVqcF
         k8sT0EwwqSJTj8ODOrCTP+dUxR6xAtoq495F4N9hziwSJzrWYg8dhJkScPShMCBgO51B
         Aa914rokB/UnzX6M7qBMWvaAeniNCfzckpI61t+15mWljFcoBHdhrZeGMg0MkSB/KGKB
         49L10Zxnbg9+IYoZrVOHx/Mv41B8J5LNucJVokkbfqyKVW903+GaMa3NpdMXo9CnfSgE
         7efA==
X-Gm-Message-State: AOJu0YxfenHCXXEuWtkHr7b4OawcmMXl/YiFs/vZpqdnUcye0mPoWSek
	2np/8Vj0a0Nad0h+Nsyr1yM4HmDDFEzhDETjKMvgpGcnMu91mlCqD3HRnUxoEubkj3j8LzkOTWm
	UIRzbQU0oVOF72rKQ2Y7JitIw2AIVhOrw8P2CfAOBTVkPurIcxfVbxZuafDgMhOPfCbTLPQ==
X-Gm-Gg: Acq92OEmFLOwQT5HV3wVX2pG2/eTPaEmTHL8Z4BtQrVeyPfENA61/Oxr5K8TQqSBYOy
	/0JkexN6WtPaCMBy+frNiE5myDhkIyD4yApW29GWmTdLdTwl7rOXkvGSCdoiho9bIrGiNEkdkaM
	izv0jeWxfhx06OyNxgaXSx/AANdqMS0C5kTIiZ5xjhzWeJ6bIt1D9el+8yntNKPJbpIGlSKMMmH
	+BFQIqdRc2I9SqqJukm/j6gTqhjRBYsj0ToJlH5zenwqugzN6P+nYrvkPqDSjtCTe1c5lyMLhaL
	b0772Ff7d2w4iw4jWMocn0RpJ2sFPWLc2q6d0cQbaUdhGWNY1eRiYB2z8s/qbc1lNO3GBuCj+PY
	CmG1a722CM7QZ+YfvQcEWdyudvdsqEXbHQxZ0+FRG5/6FZYRZGADmQXitwSrus4FcSdV2yAa7wl
	Bv
X-Received: by 2002:a05:7022:310:b0:135:5284:1dd9 with SMTP id a92af1059eb24-13552841ebemr3927097c88.12.1779112454518;
        Mon, 18 May 2026 06:54:14 -0700 (PDT)
X-Received: by 2002:a05:7022:310:b0:135:5284:1dd9 with SMTP id a92af1059eb24-13552841ebemr3927070c88.12.1779112453933;
        Mon, 18 May 2026 06:54:13 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm20870488c88.12.2026.05.18.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:54:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Willmar Knikker <willmar@met-dubbel-l.nl>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
References: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
Subject: Re: [PATCH v2] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
Message-Id: <177911245269.2671480.662822081841670473.b4-ty@oss.qualcomm.com>
Date: Mon, 18 May 2026 06:54:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: UFMOhP9qTBVZ7QjefRDGvsvEvtB2AnS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNiBTYWx0ZWRfXwSluC7uAPCjM
 M3bOZtF83pUoTBq5ChzLmgtBBSWotSesl1cya4BKv2qCajBxKWfd5JJ3Q8JM/FrWO4zKGQ4lIS6
 jkbSaaDysnpMd3DFsyD8fvSX+qaQxFefDLamd+M3l5qz0HW18pkbi47NG+zQWX4R7s4mfQPrgX3
 dnEskyAVGMlgMMT8/0L7YyGeEJEwgr6Dq7bzuLX6Z0wYi1NdazHXlCgG0KmpJ6rNhOVRJrWLp93
 6IpyTesOPmKWnT8SzCH5caBX7SZP7RkSJjOxiffe/xeZcQADitftbBlKWTK3ZSyGVbp5O06/lem
 AiI2xVyAoJ14Oo6jBH/YPC/gZvhwGPInAfb9g1q2prK4ccWy8yQWz+9O3Qh6MATdOssLGh02BHd
 YxrLg9rbm6hxulpBhwsbXL5xSLzwvOdVzPRNjw/68FzwqgorJYDDif9YtY/oRB7JP/z1HuPN3qI
 i/x5DLhHsDNxjE7JLFg==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0b1a07 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ljBxYmjjx4en0H8xEuoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: UFMOhP9qTBVZ7QjefRDGvsvEvtB2AnS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180136
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36605-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7A0556E3A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 05 May 2026 17:17:43 +0000, Willmar Knikker wrote:
> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
> the dev_kfree_skb_any. This can cause a use after free kfence.
> 
> Use flag for caching is_continuation for use after the
> dev_kfree_skb_any.
> 
> Changes in v2:
>  - add bool _is_continuation for use after the free.
>  - Add Fixes, label to commit.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix use after free in ath11k_dp_rx_msdu_coalesce.
      commit: 72b8654e3b83548f64524add2e9145e9b6c8a852

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


