Return-Path: <linux-wireless+bounces-34988-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDZlJXMD5WlCdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34988-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 18:31:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92879424B72
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DE893002D23
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C9D40DFA4;
	Sun, 19 Apr 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmmuALiY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Brk/Xls7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D3285CBC
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616302; cv=none; b=epUdMVsCSoObvq1Z+tqGPihV3ct+/GMI+b8OF2Woy7FyLptr3AxzpQ/3AmP63nqXsjK5KIvNbx2K/bzzhgS2nwjgO8dySuWY8bTwME6BBvAD6yf2wW2KdH9JbCxacg173vnbWzUALkq/7N2QPkmnJ2LbutrCELFUYF+F2KjNOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616302; c=relaxed/simple;
	bh=CekQDagyGBX0wZ1b0V1usH8D2Cy5wwj5cnCIZk5iFV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brjLK6lanA34PfYifjekeeh+PXaHcqWKSmJgKp+emAn5eXYKw/VR2aPe5ww7j8GQgoQo0aL7aoosJlnVh/D0EDOUWXE1hHiHI9Z2Qwb2SUnpVh1wLTojT7TWnYrAa1lkGK9rlw7VJ5Eo7YKtKB9j1r8V88sUWCRbQOe9BXl104E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmmuALiY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Brk/Xls7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63IL8nWW2309460
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 16:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4Ok21R8TtS1c7XoLZjXmfdoHlTBFWS1WBYcbTBRwSY=; b=AmmuALiYV7le/epv
	COBcK4V2DMIUGsDIbUQDwT28xndOD683UqUn6IMSBtYcvnxsCb+Lf/NUXfUi8jV3
	o2hbFmEOnmiZIPPsN4NxdjfaWRKT+VEkg2dNdItbJlBcRlhh4plSONgT/qmokvQv
	ni4d5QlDSl7F0aJm5P5bwKJ8g0YkNMYnwyc3MNqiTeRV5yMEtcHUZjBCBRBNnqlA
	5RSfsEefCVdcIvG4UQhcj/HI2TzF9251GKeHwLhn6bc+/srfw8ye7IETkfP6molg
	IM5mjBG/flnb8dW2aUgkDXQ/iIDjx8rA1cGXU4VNgKZC3z17d6FYM3TO50Q2YOHB
	LtZFtw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr30c4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 16:31:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d9467e85aso2211911a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776616293; x=1777221093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4Ok21R8TtS1c7XoLZjXmfdoHlTBFWS1WBYcbTBRwSY=;
        b=Brk/Xls7myv71zvnUh2Q/rO5WFsOAGHtvTUlOKU7YyHaspykdMUyBwNI6usb6AG2KQ
         7OpHZMK5GeXgADkLDnD5oJWXmLh8FljYWJFImKbiteGBdImaCaU7EQ6r+jw0VOiYio9e
         d6XRWOrM4AahcwPwuQSTMoZmxynQ4pYs4ZQrufbuou3vCG1ULs2CNkVoCW70DEne5eVw
         sxQihiuoRR/r3fmx5ONJxhwSf8GG1j2XHBHK6KFgeb9CARA9RjwvlhpDwMZmiX25TUu/
         UZ+0L36EE+WrFOYrCM94XTkqKd8WSZI8xDNBXyEvYbkYNSDzDSEkqGaLhWjIW+WLZzcz
         mUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616293; x=1777221093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4Ok21R8TtS1c7XoLZjXmfdoHlTBFWS1WBYcbTBRwSY=;
        b=BKkzKeDHUkVoZAB4tbp0Tbx4hjdnPEW/VXzfS1XvuC3FhsQxK6xQ5QAPPyXszGtyer
         RUuE5CsDP7BdNrnJop99yoRQpD9cm3PK0hsvNzS7ISPLr3tc76Vi5+z56HV+pobFDNWB
         kyy9fIuHEMJGk5IUdfor9EgazHs0bkTdVbn48A9HVYtjK0AI0b0f+JZS59iDDztuv9q3
         8kmdYNHKoI/oMOgx0lyEuLE/WPIq3bzdYtrSQI7WCIc7Lz6JJIU8OIKIRpbvA5QtQMLJ
         zWrSeMDgWFhhNnh2MjTq5+5hq48f8hgl2sBmciv3uSWoUMgNgfJKD+xf4+kJUv9Wl6YE
         vxuA==
X-Gm-Message-State: AOJu0Ywm+xd0GtWkoFXEJc5xyEppZGyXqdmcU5jCP8VBYYK7Cmla8wNL
	RvVtvaMoGNJFWBX/63hUpWxn23mEwTvl7XwYnuR5nKMrDfiAYDXjW9KGGMRemuZukQ1dwyMl/qC
	kioId+SVvB0X6EzvGyeHoFCMXI6/D148OLHEtfIiddQ3XZi59GiI110zCoZo8pY42Y43Z/Q==
X-Gm-Gg: AeBDiev1oxOt7mgz4FVhbbYA2/MOaXvnsG+bjdG8ygEcpytyLNyJlV6W+AS6m6uyA6X
	KdBpqegyBMfpsOiIHme0ZBwpdJmLFuxicIOTG+GbfFU1p7/S9OlkvnxJ5chKU3YiW8QaO5sbgv8
	Vmn2MTBY00mrSJ6JTjhDwH5+4Az1qKKNKDJibd2LPlH2634nRFxoAHIRU2KazG6eb33fG14oMrH
	wZsaluzTVSo4YFYltULKAiYP0Hf4PwBgLURUWC6uHL49tIZys1ZTcKAz66gIsSoC8Is8hbtxHWg
	g6luKTxJtvelw4DAqfXTuWjdvom53GfCwDSsTkmT4LSvi1kxhmkk/sjtEpkqwsaraQH5S07UjWX
	uG05aTfegy0xjMqVXeX28jxDOy2o+CQEJAxUlmAED5NX6keq5icZQ8IX860rkGFeMEvH0Urb4hA
	==
X-Received: by 2002:a17:90b:380c:b0:35f:b5df:448 with SMTP id 98e67ed59e1d1-3614049ed12mr10891804a91.24.1776616293020;
        Sun, 19 Apr 2026 09:31:33 -0700 (PDT)
X-Received: by 2002:a17:90b:380c:b0:35f:b5df:448 with SMTP id 98e67ed59e1d1-3614049ed12mr10891791a91.24.1776616292477;
        Sun, 19 Apr 2026 09:31:32 -0700 (PDT)
Received: from [10.118.196.30] ([106.192.65.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cddfsm114681905ad.49.2026.04.19.09.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 09:31:32 -0700 (PDT)
Message-ID: <38a1c477-c82a-49f8-a632-babe2069c427@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 22:01:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix invalid IRQ requests during
 AHB probe
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260414062829.2371761-1-aaradhana.sahu@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260414062829.2371761-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE3NyBTYWx0ZWRfX3xt0YXNpsrJ1
 mbPGx14PTeNp2z/qJk71TRZsbC7+uF0nPaUHgOA9CHBYQQUdYtsl1ux2Zw7AUlJoJQhm1jzr3kT
 Qcs4qzcBm26WQZQdvqc9//fCLYlw9IrsuEFsZlcJWISD9VYVwYGmkgmU3WWTZRNtMrlAKgBSg7V
 vUaR4y60whU6ZmUAptCzk8dT0blHcTBnqFZiDlBbcs/yUwd6PpqFFyS0cHjQLe3qXcGto+4ic4M
 9UZ2BhctlnGwUZPubS5yTdaZ8vwEZl7TAag7DxGso0mZQsDoLGnAgY5tDoqCn2rvKUOrfBW7TQd
 rRJN5AY5C5wp2Xv7r3BSknFvBplx2xCMyCUu7KcH3C8zm+cXfbFgKjn/N22pSYG8EebdWTgsIG+
 1LIWen76US2y6X1f0Vm78HxSX1J0K16VsfDpTG9DtGbn55qR3VUeCwsQIXxhnInqIeu6O86g8/B
 tALipi5relg7l+pvD7A==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e50365 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=hMyz4loUA+MjAVYq/NeUoQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0MLAdd28pQG-b0eIEP0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 5Ds9gFnZgO41frzPP3o73QDxFi1VRyw5
X-Proofpoint-GUID: 5Ds9gFnZgO41frzPP3o73QDxFi1VRyw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190177
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34988-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 92879424B72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/2026 11:58 AM, Aaradhana Sahu wrote:
> ath12k_ahb_config_ext_irq() iterates over ATH12K_EXT_IRQ_NUM_MAX (16)
> entries while checking TX ring masks, but the tcl_to_wbm_rbm_map array
> contains only DP_TCL_NUM_RING_MAX (4) valid elements.
> 
> When the iterator (j) is greater than or equal to DP_TCL_NUM_RING_MAX,
> it accesses tcl_to_wbm_rbm_map[j] out of bounds. This results in
> reading uninitialized memory for wbm_ring_num, causing the driver to
> evaluate incorrect BIT() conditions and request IRQs for rings that do
> not have an assigned interrupt line or device tree entry.
> 
> This leads to request_irq() failures with -ENXIO or -EINVAL during
> ath12k AHB probe.
> 
> Fix this by splitting the loop into two separate loops: one iterating
> over DP_TCL_NUM_RING_MAX for TX ring, and another iterating over
> ATH12K_EXT_IRQ_NUM_MAX for remaining IRQ entries.
> Also add a bounds check for num_irq.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6cee30f0da75 ("wifi: ath12k: add AHB driver support for IPQ5332")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

