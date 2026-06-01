Return-Path: <linux-wireless+bounces-37233-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCAYFvgeHWpuVwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37233-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:56:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E598C619E76
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D88330058EF
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 05:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3532ED27;
	Mon,  1 Jun 2026 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gynzt6IZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJiI0ug2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4932E143
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293366; cv=none; b=pI8aiwmeELLQtpibC5CZJppqNGYJEKcOEOy+IZQilRsqYUT93+MbkVNkwFSXrfbRnIqb1izuT2yuIiWT0R95DKEmzIcZPBsiTvPDTRb/+zmMz23PyMxx00nJKUDdyilUTF5QRxBNsOr9M8MZbborTCwxPgeZj74tvMUYkguLwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293366; c=relaxed/simple;
	bh=XLES2v3PFd/4i3u7gxJd6Tq9X+jOZL42wA+HE6jVL68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxwavN4Z+hp8cJLIVPKy2QE94Cny9S8FwHlBSDWfcsMkpTCJkE4ztaEDAHS7rKbXvwF2IwWUqU7ThNFeDsPuAUiHP2fThhNxG1Ej6CFDgh5iLkU8hArfBcX9iwkfaf8K5JZvTu/Tcq5Uclsq/MU5XPG1tGI+bZ6584sQhW2+r5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gynzt6IZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJiI0ug2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLdSmU2789662
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 05:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CZA00uVe/S8IEAGfT8Zrn1us5JHS7tBDa90zZUoeImA=; b=gynzt6IZgF8dugQ8
	JuqKD14hwshsAMfaP0X8wDouESdTH85QGHN9jSeCWTofQmZYLx0n04SLmQ3iWcKw
	rFAYTX0mQ+hBL8BBZSEMz52a5uGpwSx5GuG/K+5OVdgUulcodFmE0NC8ucWluKPB
	UVrYRY5N1oiLUY7K1xrhRkFB9oehw58URQw3BH+fFxVXFpzaPLXtf47YxQvj0mZB
	JPZVeXtDVYKOzwc2fkxFO0rxyObyZMss8Jev6sSzbCUByx63YDh2oSEo5uCdM1nM
	pa9Lvf6p18WBfp1f9d+OjJWMIUOj6WwbUH8u84k3ACoveK8G9J0iSHVZVYqs4JYc
	55VyRQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyux00w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 05:56:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36b982ec27aso2770292a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 22:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780293363; x=1780898163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZA00uVe/S8IEAGfT8Zrn1us5JHS7tBDa90zZUoeImA=;
        b=WJiI0ug2cUAzVo7HuHq2SIhXxBfZmq1No09InTcYcqlyQgJVkviySVywHzY4PhI0kx
         FQ7klfcq4MZ35UieIuFHAbvrFd3iIbUkwNDIvEJI22up6AJ2B+LicQXDK403G+r4BMdk
         VMnYbYrFKYqvX+J2Oki7mc92eV2QkIqfaF8DltDrZAN32jCMhyQ57dNjb317FqlA0zwS
         FD7kHmNiVuw/E6o1WWdWeJ0vWjnZhBTM4wQx9t+JyOMaIoJZbb03CESHCX9P6zBgQ3jV
         R0Mtm4+8aj8LQcH/p/0ARkBxidkCZKh+Cu7VMM+11/o2qCXPV5QL4+ptc25K5QyBxj32
         c3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780293363; x=1780898163;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZA00uVe/S8IEAGfT8Zrn1us5JHS7tBDa90zZUoeImA=;
        b=Nq5wDI3lc8uI4wuBQC4twhH9Y5CWXFwGL0BcfqhIaXHOPKzPbEJi1G7IdPj7Sir/xB
         sfIFZKezltLbg7dVBANrt+hVrMFpxEBANH1WqHePXZdGy+6TQseBrc2n5wIg6mcOnz8v
         HMtsfcVvLjhIOiQw9A0jiyqNZcQaQ+zMCxeHmDt7yowu5aDoOOHPUakN9c0TkDBtsQWL
         sOg3jlRHrwhEe5Mo75vECtlojOBWV1bmiY3ppS96QszfZYw/RA33FiWVOLzaFGNAfIK5
         IYnbDRH7OIzjNeEexBVfrbRokNp0tqi3tZspP5Y/LMvp9RRkpNnGjUJnW0zOGtjD5LUT
         su+w==
X-Gm-Message-State: AOJu0Yw2NkJBp3/I7tyGDcL0vFoEzMsTtNwYLZP9qaMcb2mrMVo34c8S
	VxaM/vtl/P4ezIxfE2NBF4x0OvC3OTj6dgYprTEhLzsoOtRcrQNBXxkusULTmVmLOPr293yOZJV
	D7/C08zxqULnvWzXCqx+Te5Rxh5PnkvFjI435HpHp0hzeVIpgMVkdaqORaftokVBJN/l1UQ==
X-Gm-Gg: Acq92OFysh2LiupvLjfl3d3uBUlRAhJoi8gu9TksqPjwuZpANZyRs1tRFcSS3fpPQq3
	tHxGijQfdACRezLXJ0AgDZ9kQV8yTBuFXyFsZT3+9Eff5niEwqbMQo1znGURxHk57rCKnF8AO6Z
	qydvJxSC0XL64W5ycuZUMnAu8YrGk88qI2cG8Nx4PDfxsn9s367D2wkCL3BJ35RWsg0UVHt30Ke
	1zwqDdSt+AXXpxAytrXf3s2EKisqIzwqYsQqP+cuFf6QWHIbYM6YFvojJ3b0puRk7FqFjzUBHZ5
	SGA71cCbgNOy+m52g90/zjECLUE6eL/gCnv2YCbQ250GAynwuBM6lAKOpxdKGxTxQC6Fs0KWnom
	HTSW4EMOchvU6lDo9jvd1gi+KD/1ittz2DzZ4PL0K8Xeqv2AUfzBTWjip2NGhMxdzkdYmd+YuBJ
	AFkpKX+8taheLoF1h6Q4XRRTcXMqwx
X-Received: by 2002:a17:90b:580b:b0:36d:66d4:270e with SMTP id 98e67ed59e1d1-36d66d436cfmr8685600a91.5.1780293362192;
        Sun, 31 May 2026 22:56:02 -0700 (PDT)
X-Received: by 2002:a17:90b:580b:b0:36d:66d4:270e with SMTP id 98e67ed59e1d1-36d66d436cfmr8685586a91.5.1780293361676;
        Sun, 31 May 2026 22:56:01 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0bf8fc0sm9677443a91.13.2026.05.31.22.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:56:01 -0700 (PDT)
Message-ID: <303ed0d9-d785-4775-a467-95427caf20cf@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 13:55:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/6] wifi: ath12k: Add driver support for WDS
 mode
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA1NyBTYWx0ZWRfX04IZoGWGkWkC
 ZhpoMqds0aYhaWDY0Tahn1m8ABMwccyvBzHjbcfFgUjqxU7cTMpjiqxEN++yFH2Jlhq+UHX2SFU
 XDgkGP6g4ykMjtZPHp2uxPO3ugJifRo3Us34k9qxT+lxPNn6YQTJcevj5M4Mt8SL7cXmsP6qD8w
 C+KesqRdzoj5eYPfGHis3j7ye2OmF3bsDyZ0NFRnKIPe0mo1ewDdLWnCAD/1aC7spxG5A18F+yy
 CVrjB0TJ044rSnu3fI9rA0TMqOf9ffwNYRfyruJNOiZxaDuFWCWJhOWl5PnJXLA5anTFnW2mCfn
 UDAxItPixSNML92CpGLgAEBxPA3xpm14PYfDMRZKeCXAKggVAMpYjXeVuxrUMxGdRlNjO3WXKDi
 +iGQdGdgk6QrRvowKmQazPum29+mG2Pb3wNP6gLKEqmcWgya2WopT2OiwaeTPqZfrVucJ1zeRBp
 GaCTycUKsV+Tbby+l6g==
X-Proofpoint-ORIG-GUID: wRwHD2cwFA77sIZP0sU1v1VbQBJvk6jp
X-Proofpoint-GUID: wRwHD2cwFA77sIZP0sU1v1VbQBJvk6jp
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1d1ef3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kn8-dOTC4ExnFVu9xQQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010057
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37233-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E598C619E76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/2026 7:09 PM, Tamizh Chelvam Raja wrote:
> This patch series introduces support for WDS in the driver by adding
> below changes
> 
> Handling of 4-address frame formats required for WDS operation.
> Proper setting of peer 4-address WMI param to ensure correct transmission
> and reception of multicast and unicast frames in WDS mode.
> Conversion of eth offload Rx frame to 802.11 frame for mac80211 to
> detect 4address frame and initiate AP_VLAN creation.
> 
> Tamizh Chelvam Raja (6):
>   wifi: ath12k: Set WDS vdev parameter for 4-address station interface
>   wifi: ath12k: Add support for 4-address mode
>   wifi: ath12k: Add 4-address mode support for eth offload
>   wifi: ath12k: Add support for 4-address NULL frame handling
>   wifi: ath12k: Add support for 4-address frame notification
>   wifi: ath12k: Handle 4-address EAPOL frames from WBM error path
> 
>  drivers/net/wireless/ath/ath12k/core.h        |   9 ++
>  drivers/net/wireless/ath/ath12k/dp_peer.h     |   2 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |   3 +-
>  drivers/net/wireless/ath/ath12k/hal.h         |   4 +-
>  drivers/net/wireless/ath/ath12k/mac.c         | 124 +++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h         |   3 +
>  drivers/net/wireless/ath/ath12k/peer.c        |  11 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  91 +++++++++++--
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  41 +++++-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   4 +-
>  .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   |  16 +++
>  .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  16 +++
>  .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   4 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   1 +
>  .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  16 +++
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  18 ++-
>  drivers/net/wireless/ath/ath12k/wmi.c         |  47 ++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h         |  17 +++
>  19 files changed, 409 insertions(+), 28 deletions(-)
> 
> 
> base-commit: 30d516006fa1f72f957c18c6171f5680dcdebfb0

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

