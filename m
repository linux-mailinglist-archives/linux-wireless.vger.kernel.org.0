Return-Path: <linux-wireless+bounces-36604-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKwgH5YbC2pWDgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36604-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:00:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1756E395
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6ECE23066995
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAFE48B374;
	Mon, 18 May 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XasWpou0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aw/mZBrh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F348C8A5
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112456; cv=none; b=SJQhvRjROJ2zx8OulYq6zwbAnbRkk12lAAT7nEJeaxv7RzV9GbUiXzJoU0F5LP0umcr+dfpFUyhxpGH01Cl6Blo2GdCC1agfWo1Xbp1+t7M+btfcc5iQphWINh1t180VlMGLJbTTS/EzVuqDP83MrtxSMoswaFJDApK7kuEtQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112456; c=relaxed/simple;
	bh=WuHLeDoULsAy9LWNjQnEzMf3xEuqkvXpK2ASmJCxrUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K/BcDebDOxkDo9fKqjHhs3MZWc6wfMfSK0Z3GBf9Y6Wfc05u5opj5umKnB1HPTAhqMRe+i0lUzyIADItmEWd177tLFFC3rrq4w90OwhMAhTkWCTSsr4butV1I0Gd+fnZY8Ja3R0ZcuWLEJYoAMREDabQBLKN3DhHvWh2dgVYWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XasWpou0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aw/mZBrh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICFvdR2701033
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	adEAsg2ZzgM40o8WGasVv3IMJk1fWqgZiZUjX8Vrrs4=; b=XasWpou05i24BOWs
	1W17tSfaJcBGzNa59WjRxR7P/jAJdwa1ZKiR39Z1XeXVRbUTy9Cm01TTMpYe+GJc
	j5vjdFG4xMCkFxeZStL/FSNEW25rsrBGg2K5iZdtNXbp74Y3K3SuKZ/yqRg1ZOon
	dQzABuSWTEmB7s8gSYt5fjrXjCk5AoLeHNz94f57pgoUX6Q4Lk9pQMfarS3wGuoH
	We/CqcoGboV2gY2Pb+MOk0ci1AF50nS/SxUZCkWZTSVBG0M/cMptlG5FFiE/R+89
	aGt6eknLArjbNzOUoFnYEhWuCtO5RKYOLu8j+9CHzrStYtGwG6O0/mOxEBT3morU
	/5eaFw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82megbh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1329791f18fso3908007c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112453; x=1779717253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adEAsg2ZzgM40o8WGasVv3IMJk1fWqgZiZUjX8Vrrs4=;
        b=aw/mZBrh3IwOqVMOvXv975xlO2zLTZv/6FeffsnO+9wkLUoYSr3Gr32Tw9jri9onrl
         Riwe+cEI15/cRNgLAQl0/DRvhxoWEI/vDHGMdzQo9oVzijRGSdR66Iojv1iX3MjFh8hV
         9UpG2P9abxN8DD8Rx7w91t40ubHLPFrgjhdtxKiihP7YZvyD/3Gvo17UeSC4sY3XwXck
         etEoBqo6lx50661Y1NepGBxokEDBHqiWYvMYFsp3jcy59Eux9bTJXy69S4uQ1ok8ZrXE
         2dh6TqaH7CfpbfFfeB0c6QVxZ23Odpo4/lerluB7sBjN9a3kdUK5XVWMZjXfR4zuqA4Y
         ZhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112453; x=1779717253;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adEAsg2ZzgM40o8WGasVv3IMJk1fWqgZiZUjX8Vrrs4=;
        b=fiYiA/nxdA3/wJ4mGzZx/vbkOSnRAdUFiGy8jfm3xoz2vhvFSMDzs6n7Tb8qXSnV1F
         u1TTpHMdIT4pD309omDJzlKJnF/TuUHmzTMHAl7D82uj1lwLwzl4QiKm2lfoVFCSjlZQ
         o9tpfnZuZ6xRxHgRPEd7NR/fIYmgUqgaZEZe3Jr38XofPC+3Mwm/NZU/cg9wZG+hWIzV
         nC+IdUBkhGlQUBjUZA/h/QZvaASgYsKp0AjoRWGud0xR1Rd5FWdg3+E2dKCxzJuY7chD
         lzmvfUWVC14fBUiAU4t2wZBKgmBLsAmfTcvYsh8f7R5GrrgAqRMlnTUiHm7IVoejtVh0
         A0ow==
X-Forwarded-Encrypted: i=1; AFNElJ/jAnsLh5Mh3+Lk/aE44OcNLtEIUiRShgZl75ITWDVT0nRi9yKrlqblc0Z/JVErADeOZsEVfCLXVL7Og1blhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoa+Do4HT7MPSH1r8GK5IBdusEI3Y+tbhTygrSPz0zBCSRtCzk
	0cLTRdUrs/zTOiBfQ3rVoO5E5s8yPBQgDnhJ5SgL5Udf6fB6QrP4ksDaG/fAdYjrGxNheHgO6I3
	1Ge3t3a9xi7W9HZIkziJkjYiysPLaa6zN30rbZiWxb4kGBUm0mgb5PC/noeD2Dr9ksQ0rMQ==
X-Gm-Gg: Acq92OHf4WjvVPDXbOLOnfqxtQWJHvto3ponXCWfG+n+XoT8LObqiYGYU7A3pHbOd+v
	ub27NXXf7kzCVKtanoyv6lyACp2V7t75pbhokXPzVVDsgqsWolpTaPmDJvdASpwZSGlpdoaP5z2
	qXWTf19JzkqhA3TcacRdu34nhesEgyVS65fkIhm75JleRiPIve5fuCrb65y6QWC4tQ8OAfhDGP9
	s8aA+aKSn2XKBQ7PLxt7G+j3cFck8+2bvPAMRWLzJcP7PJ0eQ004gBOEf9YSNhYdVBK4vIiYjhH
	kkB15Q3D8D7nOCDroTdA7WmFaPtN28L3uSTc9W6HNdRpvWKU5WH+sHQy3eV5zXxUFNg7fOGQm0g
	0wlIs6K5hYyx6XJ7UDrytqyGx6+wcsOyG6ld9MEwHCTllNC0ZMLD5PjLSndjTkn+BsTaeWz0cQl
	XfBdCrqBpCmpY=
X-Received: by 2002:a05:7022:438a:b0:128:cf5c:5356 with SMTP id a92af1059eb24-1350440ab6dmr6181738c88.5.1779112453090;
        Mon, 18 May 2026 06:54:13 -0700 (PDT)
X-Received: by 2002:a05:7022:438a:b0:128:cf5c:5356 with SMTP id a92af1059eb24-1350440ab6dmr6181706c88.5.1779112452486;
        Mon, 18 May 2026 06:54:12 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm20870488c88.12.2026.05.18.06.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:54:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Matthew Leach <matthew.leach@collabora.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
References: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
Subject: Re: [PATCH v4] wifi: ath11k: fix peer resolution on rx path when
 peer_id=0
Message-Id: <177911245167.2671480.4093957799300242035.b4-ty@oss.qualcomm.com>
Date: Mon, 18 May 2026 06:54:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Tr7WQjXh c=1 sm=1 tr=0 ts=6a0b1a06 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=qak6Y_TGKhJDndXz1vUA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: CIf5dOtHCMLE-H1_0mTY_toxHGDCULyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNiBTYWx0ZWRfX3emFTfQUFDL/
 HwbQt1gcMKXUJ43wJfY0GvepajDwuBmS6RWZadxLilnLCL2ywc0LuLy2HaGVy3wKs0M6eXPBRmk
 65PQBUuHVJSs664yukP8xo6IbXQoR/CPUf52/of8UbiPhU4WdN2Q0/lBfVKdJfYTe7cA2fwlWrd
 9pEuAn0nTDnnBZPegenUyQmy5diG+JxImkYgafa+c1LBZX+dySpoh4mt+Xie+saPUtQBD0wcN1V
 bBlIlF1LalXoukgJxSbnmMyuLaNoMP4VCsL5EVycsxFOELoMjSVTyWmgMzoK7s8kvQGYNf3+YBZ
 2KauPGBhkS2RRyD/PBudFjBoD+dY+msyQxuuhmv0QCw5qz56uVRLIfjTKg97ShVF7S5LcSWLJjX
 PmV+00mLwH/tc/nvWQ3UM6Li4T8FzBuMTVLn+ZuCFu/ODfgf5KqGoy3uqfJfDkeOX1VycaJeZ0x
 7uM0rjn28m00KzcJhSg==
X-Proofpoint-ORIG-GUID: CIf5dOtHCMLE-H1_0mTY_toxHGDCULyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180136
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36604-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 81B1756E395
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 24 Apr 2026 10:50:35 +0100, Matthew Leach wrote:
> It has been observed that on certain chipsets a peer can be assigned
> peer_id=0. For reception of non-aggregated MPDUs this is fine as
> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
> based upon the source MAC address. On an aggregated link, the mpdu_start
> header is only populated by hardware on the first sub-MSDU. This causes
> the peer resolution to be skipped for the subsequent MSDUs and the
> encryption type of these frames to be set to an incorrect value,
> resulting in these MSDUs being dropped by ieee80211.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix peer resolution on rx path when peer_id=0
      commit: 2a2451a34afdf563b3102d36a4b6cf335cf813e2

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


