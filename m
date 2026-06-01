Return-Path: <linux-wireless+bounces-37250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEZhBfFjHWpdaAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:50:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359161DDF9
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F33309D116
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138E35CB89;
	Mon,  1 Jun 2026 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oS1aQXPe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KcYKZv0L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD03090D5
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310038; cv=none; b=fR0lV/4t6ad0s3FESXNGODXYY39yOf79LqvKFAASJQInORPaF51f8Ymgqf+a2PocLZIFO260XNKIoPVLX0WAI2Xal2+DTeVfmFSkAfUHZEcqjjTUNUjUQAP3N95n8gofbj6CkhBAe02NBJFrkDhuFrzBLBU/mYOEi4HZNFuLguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310038; c=relaxed/simple;
	bh=9k2RkWKiyA2cbtltWVCmhS8C32E8Tr6MqPJEo2uQoks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sylKDD4ulDHhOHfqKUSy/jISqJ2/pHJWxqff0hjwadhNNTJlStYanSo52h4bqIaFw/puNDlFZrle+MKMkZy9wlEykulsGhbv3KM35IVzlfegv1HL9lJ7s/s+JzS2fPJxikmCZcvJaKsLkkXwMooa+1xHlOpvoLis8QuSSBuPDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oS1aQXPe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KcYKZv0L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dne04110823
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 10:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WAtem1ZMIFkHJBQil5FvuprGA6SCScdsTuwFGekziuk=; b=oS1aQXPeFxQJvJ3j
	vKdwKl40abijxch4yzoaVxKseHXWrEnmp8iW8+yubcnOwtyrmO19cOi+h2/6S8D7
	8wRVJRFUTcqDiLISoNdueBlre11qByAzZM15mjC8bO+IJZrmPVaWBRyAMjYnipCx
	/PQ6cSQ1z+pqaH/nrcZ9X6zcIGPFVx0gbcijOcz9brIBrgpcytaJI4386ju1aca6
	OEEwrvSBS/Qb4m1SznqNPQPiOffza9mhwidIvtMH67m6WMScgX74L3/kvDtvCZr5
	g90BrNe5YI7zlFBfIIEtpGmtSN8KZ+K640jrQEdNrDk0fZRy+pcYplCKHpQ4GRGh
	CjYUcA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3rem7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:33:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842278a630dso2733302b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780310035; x=1780914835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WAtem1ZMIFkHJBQil5FvuprGA6SCScdsTuwFGekziuk=;
        b=KcYKZv0L43NQoa2+H1ujR3WrEGJaMgS87C/Ub/gk+yghJYb4OXsocDdZD08Yz3AEh9
         IL7Fwi5tW/RIdTbZSSpGAl/d3EskV+lxte4bGhdK5uFVkewhKXJBByTRwmYyrb4eFrBB
         wllM3LWL5UF1+tsIQHDbJgLdbJSZi2Obd5grDCYj9La3wdCG15LIVzU3eFI72IrffgGo
         Z+/Miiz8cQx6oy4XmERxtOAqOEogwrmmUy4H/1cKy/o+z7EauMbGLyTY3pGgCTEtzmUt
         uceLZrhAxLFg5Cz2SVoNZCFj0wXyv3G560DDp+CMlysX/hWoB0UUxxyPSNt4RWrqHl1Z
         TecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310035; x=1780914835;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAtem1ZMIFkHJBQil5FvuprGA6SCScdsTuwFGekziuk=;
        b=k9SvRx/hpJt1GpvABEOHWDNoJ11Z6XSD6hTWwIOxjHJYB2EUW9wRbSNcH19l1Gb1Jq
         jo8FpJCCoxyjEQtcYgjOxSpKRwBe1GCGwVPIQINmVUJ6280AKTtfVUWTCUqkL3mRfO6A
         tgb/If32LGmlgAAnrKy0/OfF1UaMTo99YSMA6Tcjg7kGRG13MPrxiGRHncE/hfPmK+W/
         6d0S7lKuw9MaT26Ekq4eigJnLiuAnpQmd1XGrOQU5/mGNieJNdB4Kqf+20vL3nnqAMgq
         X8gz6U8x9AxICaIff+cJSsKBtr2Y5dqo9kWVfxOTHvEceNHDeLKX5RkF4h3HHHxz/ihK
         50ag==
X-Gm-Message-State: AOJu0Yzl3wpZQHcH1EMetIrE1+hENSCXnvN6OQFUkqWDHTq2mLLaaSN3
	Qdyjkekn6RELEy1bqDa1NCMJBfgm70cY5tOicco/z/OH3315Z1O+H1iwvdSHRCLUEQJjnXaU50A
	1uW9HpdAMIL4opQI2s4io4xjrOHTMKHfn41mdE59VrKRZ/5eSlJXsfEbT7I3Dnfpgfza2JA==
X-Gm-Gg: Acq92OGKpO2tMNKmYLQxGqNRlqWcIsk6+qV59R1ZZozngR9ned+sra8LH8MZbgWIlBa
	FCW6jCsM5EDjftr/gRNbLoAAbDdaEbO7VP+jM/7512Sc3MM3rt3ZeNFtd8WAcoVHNZAd86HIjgf
	iPEvbTqDtMP6/yUH1sN+lPl+yqRuk5viF9bJsONUXjpWyvaTA95iRuDn3YjuM6eZq5rYQmT7WRo
	e7mqYI88I5QBUAeVt7DIjl7Yx6pa/q9yxW/BneR/5Kdhek9tmtsjVaNPklFUzUE6IZqIE0ew1yB
	9lIOjKjVE1W2qEfIgArkyB4rWqxpWzPKhAGcdrcDTpZfNzYPwOxAeH3jTLm2eWFfE6VqOmPp3sp
	mVB57bEsC57tZcJEWf1JoYEucDAjYFk8IFOL12szYaW1EDKv/1vsv7OY3Hl10gZNGqi98RjKW
X-Received: by 2002:a05:6a00:73aa:b0:842:2bcf:1d76 with SMTP id d2e1a72fcca58-8422bcf2188mr5755257b3a.45.1780310035418;
        Mon, 01 Jun 2026 03:33:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:73aa:b0:842:2bcf:1d76 with SMTP id d2e1a72fcca58-8422bcf2188mr5755236b3a.45.1780310034928;
        Mon, 01 Jun 2026 03:33:54 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423aeff467sm5211246b3a.25.2026.06.01.03.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 03:33:54 -0700 (PDT)
Message-ID: <312a25ff-c887-4e3e-ada0-6ace79c85b7a@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 16:03:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Prevent incorrect vif chanctx
 switch when handling multi-radio contexts
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20260522091828.3199584-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260522091828.3199584-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1d6014 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=8GVvVDYDP2p1e3aVpqAA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEwNiBTYWx0ZWRfX8c57XO6MWmwV
 9Z2PYvsCPnbUe9bnKy3UT+/+nJmW6cBGxzSQsUq/beuZlYHRxuemE4RKr3flFkvb0cy+IsoqxpN
 putt/6CkJ0b328SdOQQFbwdwiiGt8lOIOLTiG1OOPJSMH3ttVKrAYkvqbv8K6S/E8pUBV87DnGO
 8LkRQPlbRTwOYicEGHBI4oOG2sxjwCI3PXUhCledUSU52Tch3GZfQifASJwunNTEyyAkBsB4mUC
 CNTwc1I3RQNA7pJ8Bloyv1JZDqipC6HsSDmvIPqkPpX5TitIaOlgE40iLPsTCA/RX/XpcqVK/EA
 4NSjg328kOlHVb42Q8iRdBVu2ntRNIL06MI0b/9544oHdZBXsNbH6a2oXlbRV9hB6jm+A5v+zqI
 xprUqW1dahc0Ov1LOyUImmDicYxkSvimP9RwonSBRBscok/CP4ycNkE8ZXIxRUVdBipxaNizt1C
 D0JIBdva8+RtirEI7ww==
X-Proofpoint-GUID: BNOUzgCtZYXPyQY3rW31Qnfl0vXdCsvf
X-Proofpoint-ORIG-GUID: BNOUzgCtZYXPyQY3rW31Qnfl0vXdCsvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010106
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37250-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7359161DDF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/2026 2:48 PM, Maharaja Kennadyrajan wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> When multiple links switch channel contexts around the same time, mac80211
> may complete CSA for several links together and invoke
> ath12k_mac_op_switch_vif_chanctx() with an array of vifs spanning more than
> one underlying radio in a single-wiphy configuration.
> 
> The driver currently assumes that all entries in the vifs array belong to the
> same radio and derives the radio context from the first element. On multi-radio
> hardware, this can lead to incorrect vdev selection/updates and may corrupt
> driver state when the number of vifs exceeds what a single radio supports.
> 
> Fix this by validating each vif's switch request and then processing vifs
> grouped by their associated radio. For each vif, ensure the band does not
> change across the switch and that both old/new channel contexts resolve to a
> valid ath12k device. Reject attempts to move a vif between radios (not
> supported for now) and return -EOPNOTSUPP to upper layers.
> 
> Then, iterate through the input vifs, collect all unprocessed entries that map
> to the same radio, and invoke ath12k_mac_update_vif_chan() separately for each
> radio group. This removes any reliance on mac80211 providing the array grouped
> by radio or sharing old_ctx pointers across vifs.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Co-developed-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

