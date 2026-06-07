Return-Path: <linux-wireless+bounces-37464-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y079A2iPJWrEJAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37464-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 17:34:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C9C650E29
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 17:33:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=VK1hobsv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Gy9RSW8H;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37464-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37464-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50F67300D605
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2026 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD30258EF9;
	Sun,  7 Jun 2026 15:33:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967802571C0
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2026 15:33:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780846435; cv=none; b=AfWNOHjaNiRlHNr92GdH0hv95iWDNjc65utLeHpoZUsJ9ssmweNpmHSrXAkWwkFGRg8FfrbPcvw5N6x/3MXXLbrrItJhH52ZsYply8imJ7uhwQ/nE86B5huaJvWLEdv8bw9WRpThcmoXwxhja4e34uR4KReXvQwbdKICOxQ9SoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780846435; c=relaxed/simple;
	bh=8TuQusAdK1oQCcUuK9QApsryj7PWU71xCwLTHAlMAxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6uX2lH+8d2yCxLDZ/TEaHHH06O2SFjcpoXyYoyBkkv0OQtACg4B7fxmeFXD5PtvfnRe1MgPd3F5ow9Hb1W+60lbluIPw+/v1Ds1rqGZJxa6q+Zj0xB8sJ4gkINA1L6teQZFjauhZ5Vkvv8MmYakqxdBQVZN7mJU8XedL2OLpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VK1hobsv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gy9RSW8H; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Ejs0L440307
	for <linux-wireless@vger.kernel.org>; Sun, 7 Jun 2026 15:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ctq/1w4DUNTGPmu45gjf8nQfOPRThFzezJAvYr6KElE=; b=VK1hobsv1CWC5LvQ
	JzW2rjpq8tTKS8T4rsxpyIdLGG+F99jp1RCRXGQMygI3N8b7sUKLnLtq8unMdiFN
	ErxpOu14veKQU5jsKeg81Eeym9TEgiY9EigFTzAS/p5z3Tc8v/e0A2wx90OfiY3t
	bfZdwUpqf7A3RdgyVBbEx9lAswnjRIYHPKJYzHAfCUUnpkaQSAWJt6ds9EIYUAlj
	ucW15yus2+aX9Ib2jJhPE2vA7R+Y3btIYbzT1HaiRhPrT7OucTQrLyENjNjnaA5U
	eW0Npki4zXNv4Pglx61YrGiuKi8ZAF+y0Xuw2yub1OrP6p7P9/kd0QpUESZcVAs2
	Iea9Wg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cvn75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 15:33:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1370417c0bfso3105944c88.0
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780846433; x=1781451233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctq/1w4DUNTGPmu45gjf8nQfOPRThFzezJAvYr6KElE=;
        b=Gy9RSW8HLINvsS7mq0GhOGQtzArtFx8+FfRMIt35BDU2WJA3UuYEjflYnjL5vEifvd
         XCmUdZiX380Yk/k1kmYz7jhiMWqreyQbYeritQ9sYm+sdXLA7gMpgPaYOCu0EUdg6E8G
         hXNp6FYYmLyhRX6EJ03IdcXitC6rPhfAQseo858dYmATzmT+zcyVsF1mr0jQTepr399n
         Xt+3pDmKne/l3dUz2dtUERV9cjSOqa3fhCPqFX0YlzozLsjKzbVcnvfzrtdsKy1H15Hv
         I+b0K57QbcWHyEw5falOulON333pvvFj9iISHXOVhD+00PxwcTqFSRxeOvTUlECvAuaW
         6y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780846433; x=1781451233;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctq/1w4DUNTGPmu45gjf8nQfOPRThFzezJAvYr6KElE=;
        b=XJ+WtowrZ3y/4rCgq4ohUz+3m+Gp0Q5eFnZs/9G6+6ZAnuV512TeYjI56UCKQvUVsZ
         3OA4LBpAkw3ZDZV1ioZzTV4EVemrrRwEfCcWzynUVDyPHzvQzHai6jf+UwqzM53x/ms3
         wpW1i38PiqGBfcbWucDHv16KVSRg8syMGAjUBBVwLV6Dav74z03xVCCuPsKy4eJtwIgy
         2CPbmliOlhakyEMgdvtU+TJ6SDeTm/25pCUMyLGeFgt99eWnl3dm7fTMxwi0rZnZ4OGC
         qf/6CS1n6mH2vBLUK1jYdKfswATap71V6/ZN/nn/UHsjKWFNhgndFKrNVvOwGx8Ydujm
         WnDw==
X-Gm-Message-State: AOJu0YwTGsK1y5QbUuSO5kpKh7S+GgOf7KggV0b0YuW0FGAXZ1lXTwSC
	SGadVdRbJsJXmwYSU0FxutDhiYn+kngZckphJ15ZPZSljLadt2T+euZYpqq6pPdFSWpU+zxaQ09
	jXO4/YGajqmCnDkQVgb5EVttZ7iKHE7LhJFpyhWOc8Jl6VMkYZ6K7W9KAlheJ4q3yf9b7Fw==
X-Gm-Gg: Acq92OFo9Rk6goj6kXh5WbtuZOnTnSZEkVqP+0sH9E/jmdquSmqVAUJN0+PTNXoFW3i
	BKMk9YuCEidaxf4TEcoVtWtlbrPAM1IIPfcjQgxz1NJhAQIOB3RgNCx8vM0GTO++jdpVki2Rs+1
	SfC90ujH1EccZJbVE1LOEk7qQCTW12ku+jOCLdMPYhYMW2tmctvBX30Ji6A8SHGKtH9Xooz4Wdz
	hL9nDw5hnyAcZ7ADTqWKzGr5uc/DpFH1s4ZuZN0bCDBHkXNr2MBwnI8SHwmyUzWLflclw2tLYH3
	GRzBxcmJsmVOR5gV0S3UIKZBFuAdfQ6+luD6IRqCs1+PwuUZeX2VICUG4meCn3fY9r9lwNUwTZm
	vBeLRH+iNxwFIesVHavLc8T9YJwDENADObR5n4igy9E+KdgrYIq2D7ztbArwp86D/pIh5V5/+XE
	czUSxUcKM84tmJYk80Uf9Kq1OB
X-Received: by 2002:a05:7022:b9c:b0:135:40b2:ede0 with SMTP id a92af1059eb24-13807d358e0mr5286692c88.6.1780846432969;
        Sun, 07 Jun 2026 08:33:52 -0700 (PDT)
X-Received: by 2002:a05:7022:b9c:b0:135:40b2:ede0 with SMTP id a92af1059eb24-13807d358e0mr5286675c88.6.1780846432450;
        Sun, 07 Jun 2026 08:33:52 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm6237066c88.13.2026.06.07.08.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 08:33:51 -0700 (PDT)
Message-ID: <a97dac59-a689-4b9d-8419-2b09c1d106ab@oss.qualcomm.com>
Date: Sun, 7 Jun 2026 08:33:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath12k: Add support for 4-address mode
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
 <20260525110942.2890212-3-tamizh.raja@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260525110942.2890212-3-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE1NSBTYWx0ZWRfXwPEu+ZqDJEjF
 NIEs9pRWTcZUa2JmLzDSeLsd4pPuN2lm2td94sXI62QaFIBIiFBdHQ5GVe5JVdQqu9LYVos3ueN
 GOjGNAJs3AxYo9ImfmvnHDjiRRRE3Y3UmH0iF3kqYcJw53KcnIkHqMNWmadz4DosSAbAeAkO3PP
 7xTAHkRlbCTggUAGpHSyjiqW+r/b+TVAgzgodb1NYh0w+XzEN/nRDE0iwbAFKU3UtoI2FgfgP6A
 g/JHzvYUZfW3pYCVUrgq311cOyARyqsYYb5OtA2lR9nfWD3zJ5hqDb7HxnAkjzXMdhxJbFve1tM
 Jl3D5yl5MmTRahNWgkYivE2LDzw+5OgoX17EeK+sTvHjMT9T3iYSe5yBS3dENqfdLu09aLhgSNo
 5kDKuF6CFZ+hLNAQStufhqagsEET2EGF8Jex5AE76ILK8/iIAV1J4Lk9WoUZeLEegfI86YWpkR+
 4ezcjg/JuDKTNviBTgg==
X-Proofpoint-ORIG-GUID: Cmg84IDlDFbfyqqp9f4SW6b7Ieb7MeRL
X-Proofpoint-GUID: Cmg84IDlDFbfyqqp9f4SW6b7Ieb7MeRL
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a258f61 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=AogDqfkJi6Jrrm46B_8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070155
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37464-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68C9C650E29

On 5/25/2026 4:09 AM, Tamizh Chelvam Raja wrote:
...
> @@ -999,6 +1007,11 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
>  			skb_cb->vif = vif;
>  			skb_cb->ar = tmp_ar;
>  
> +			if (ahsta && ahsta->enable_4addr)
> +				arsta = rcu_dereference(ahsta->link[link_id]);
> +			else
> +				arsta = NULL;
> +
Tamizh, please check the smatch warning at:
https://lore.kernel.org/oe-kbuild/202606051125.XaYVDQZf-lkp@intel.com/

This looks legitimate since there is a path where link_id can be 15, exceeding
the ahsta->link[] array.

/jeff

