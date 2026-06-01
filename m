Return-Path: <linux-wireless+bounces-37231-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBzvNiAdHWoeVwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37231-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:48:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50981619C7F
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 07:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C496300AC33
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 05:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEC32E143;
	Mon,  1 Jun 2026 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kuqDQOR+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sadkb+u1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704741509AB
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292893; cv=none; b=PVZk4Hc83Fepa0clanz/Q6GFr148K+2TUSkVVegqQV8YaVsdnYhXY/NepKywDG4VnmjDkY0WY57+Z5k1L4s5uhE6hsU8zp/mVLKcRFcxFjbf3aJX3S1cOrqh9NqwEn8MMHhnTfadk7mWPPaTTVJ6+K4MMPOIlvIl6amIRsH23es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292893; c=relaxed/simple;
	bh=2DGe0QdSVdYaRtl5BQHaJOYb8E0JF40/eKBGPdKJ2WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMtqE9aVtIugesAtD4oWyD5Ta/fQQxcejuu21RHEJ5eD8aw4OJDKEi5MdX2NlVN/0AZ70abEjFeUeEvMuMQvVrUtDbTI7fwSUpsO4ly1gIlaR45pOl5l5T9lpwggWvG94Pv1r81w7bZKwwOU7uu08oy9BRD8JDM2DcMCVzXHQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kuqDQOR+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sadkb+u1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6512D5hk696762
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 05:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kRSNRxG5aWOBg5WXS2xrcW2VIlBVHjfkRZ6TmKPMIJ8=; b=kuqDQOR+a0PdBzOC
	/yQs0aRGVZBgqMp14YhFURmwhWorvk5Oyajv2jKtkRUdJjlH4VqmY/iVHt7gCgwn
	zXjmYy3wsKje+weNCbatuZYwet/jywLXaD/wnx7Z8Doi0YWKEuX1wj3N9fPNIy66
	uEJlJeDtjJLacDhwr1jbL5dX2mpJ5qHUW/HUbWpBGWn7km1OS94hkd4vEEhHtTnC
	wk4I5B2r/xYEX0VFOeGVTfeSsfug5x+34wStDYFvnIW/pbbt7oVerCzhwr5iYF0n
	7FcKXWOQmb4E8O6di7TClZuE072Bk6VJt8nYXuP7rM8mumd+cGrbNdF5Fs00bJXC
	2DxcZg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7fdxnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 05:48:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d98b74447so757228a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780292889; x=1780897689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRSNRxG5aWOBg5WXS2xrcW2VIlBVHjfkRZ6TmKPMIJ8=;
        b=Sadkb+u1tTn1FzezfD4Q6Sq+ZRIm192sgTnxItXXoPJ76Ha5zPNS1tY/N9QuZAa9FV
         lsACJvG+UHVAz1W27OASLbP5vvJ/HQL9F7b6XiZB47sGcwJwJgebVwzEdDYvbBQiYQE+
         RiNYaZf2fdHk+UNhueqcVJlFP2MBm4sORpeuVuwIDCEZELwmuSg24PwFQcqLDGhegrHS
         sYjvHgPrew//6uzmr57oFL1wmz1+yevdOMFSx/S8loDFXxdNgs9V3/7d5e+rooLcug5M
         +rYJYaU9bw7JbdX1+TUNw0aviBEJaFgfbNrM2y+sGsmSubyHA7NHNFuPOihBfnaUHoa3
         VKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780292889; x=1780897689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRSNRxG5aWOBg5WXS2xrcW2VIlBVHjfkRZ6TmKPMIJ8=;
        b=k0L4UeSnCxjo3MX52eQL4q25v4kHL69eoCaNLIb/G1eZLXdIgAFKv1rcXSRTkdYgkz
         ktr9HJb+REcDWTKOKxL5WyBqJ8LrLWDlcht01/lvfwubmRcwb1jb5bubwWlAKCUmp4UM
         nExX2r3mmXxbajs4+jcNaclPuIA5493+w5e0qLwMvkTuzHWWJxF8Wm9b8QH8Cr/AOOZI
         ApEbZ+wF5eSMaUAPpRYIPHI4EmAFbu3Hh3QDFu4aCUZPIzt6u+3WYNNUBTj04cGChfJn
         sLa4jBhTlbId+mr2z3oSnGRdamPOP8i1TfmeKuRWo5mRP6lE/oSjkYWFPwTCV9qNCP5u
         SxPA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ws27AG9meWV57i0TEkI4qv3WnBb7f4nWq4Iqw0/yUg4RebKDxXWLDXAopTKhF/sQouI0zdafMFdd7DaSMhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqChh12RBhIE+4V1Rnaqx3RYkfc+CUtCE94UpvK9XJaz96Z/tT
	hbDrgd0WHr1g6Hjir2U/DMN+Br3Z5Nzb/jdeaz/dz2X6SqIibi4yqh4DJWeS3xeK3199LSXigXh
	o1C82TtfnAHSJ1Mb/j0bvE2SSCZmOn62bGb933/NYv0/AH8u/guykECKW4HwToIXteVC2FQ==
X-Gm-Gg: Acq92OFK9zRBJy4rBOYVdP1ayp+kHXwUYBvlvFvHiLLkSVSJ/eaKOzDNaYqnufl6XK2
	8Q94w0QK216ON2W9SycqbqSlCMEMLC3iyBXO+ZtORszUkzSI0peqpDlTJ8DXEJA1QcI+9KA4+CI
	XNvoQgGs9KiFycNew6H7gkPzE8fHUPERD1ko0j7VFbojm3XKAxIgqdx3U3DTAQDrdThatGSkkrF
	fvbqWmOuIl7WOhicQEF+vk7yEVTmU1A9LiFVMS/kzhO/TuyvZahrIqWQpMTsdwk8ry2XVn/8wXh
	r5/OhT7SHqDJIkP/jZ8sIO2++aCz4cyu1GVParNCuucqOKH3DKI1p72tMh+qPVTiDYt/0y73+hh
	KkfG0bIKMOBx0PWvvyNtGEk5tuZr8hypHM/M1X4nSDbLw7wYfFhggR37Ormq9DLHgUif7GvNME/
	ILu3E5hwhLT6XkhIJ4rb9Sd+ZWVfpg
X-Received: by 2002:a17:90b:574e:b0:36d:633a:e8aa with SMTP id 98e67ed59e1d1-36d633aec7amr7430751a91.13.1780292889114;
        Sun, 31 May 2026 22:48:09 -0700 (PDT)
X-Received: by 2002:a17:90b:574e:b0:36d:633a:e8aa with SMTP id 98e67ed59e1d1-36d633aec7amr7430729a91.13.1780292888570;
        Sun, 31 May 2026 22:48:08 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6b7c178sm9341902a91.15.2026.05.31.22.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:48:08 -0700 (PDT)
Message-ID: <08385919-cc21-4235-8839-1c7efd7525d9@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 13:48:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix memory leak in
 ath12k_wifi7_dp_rx_h_verify_tkip_mic()
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260512021108.2031651-1-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512021108.2031651-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JORxCA67rbJcz3nJ1fvCOlqocJsbEQvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA1NiBTYWx0ZWRfX4yMRcnYFuYtR
 KZrukT4bOV5IU2ZusjWqQPNMe/dFp6Zzrquq5rw+PjtnQNAJI7NJOU7NXTS9qq8LsynpODEzFYD
 /3Y1HDtfKZUhVrzAO8zvP7QK711E9Kkatxs5pzq5hPbAeRUhBPLQl2PFgbvScf9XX4gM9AtAWyt
 rNv0gZXEdd6yDS6k6fMBJ13TJG+Spy8ewbZJVWVs1YltakWgpQAS0HLTqtXQPVUy70bI+mkUMU7
 ci2QcjfntEQI8TeQI9AVC1X5kCfzZUI0LCCT8hfVmQJwMkANj5BZ9Z4QN+Rm5wwM9cTDHk+UoNy
 Kkdf5vcJJWLp2U7Z/XcZjumPRUnFPmFmkkJ+lBGCAX82i1uOs/GCWHWWyi5rwea7vKokBR9D77n
 PtxLv2mGlFNaWcDFhl89d+yvP7M2NjnSmztOztGOzdD9RsUa7aSYUAvWqC2ROrKFSTxYjnZ2sbQ
 BO367Ucd+ehoJkVlGdQ==
X-Proofpoint-GUID: JORxCA67rbJcz3nJ1fvCOlqocJsbEQvq
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1d1d1a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=iDbfGhX_lFAZckero7EA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010056
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37231-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 50981619C7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/12/2026 10:11 AM, Miaoqing Pan wrote:
> In ath12k_wifi7_dp_rx_h_verify_tkip_mic(), the call to
> ath12k_dp_rx_check_nwifi_hdr_len_valid() may return false when the
> NWIFI header length is invalid, causing the function to abort early with
> -EINVAL.
> 
> When this happens, the error propagates to
> ath12k_wifi7_dp_rx_h_defrag(), which clears first_frag by setting it
> to NULL. As a result, the corresponding MSDU is no longer referenced
> by the defragmentation path and is never freed.
> 
> This leads to a memory leak for the affected MSDU on this error path.
> Proper cleanup is required to ensure the MSDU is released when header
> validation fails during TKIP MIC verification.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 9a0dddfb30f1 ("wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

