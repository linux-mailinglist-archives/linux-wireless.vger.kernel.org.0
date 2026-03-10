Return-Path: <linux-wireless+bounces-32791-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEmfJXZgr2kDWwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32791-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:06:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DEC242D73
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9655B30A3074
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2A28E0F;
	Tue, 10 Mar 2026 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QfWNIKkC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5o5tqV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D8C145
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101080; cv=none; b=BVkEoP73TQaMx/0AN5scQUR4yJh25ErYD+2FLV68h/2J5j0srIAicWyVt8uQKJsREW7P/zngti1d7BeWufl+52iIxLG67snwPYgNZDfeP9dI2nj5576kSHptllsKWn7yti1k3T8r48/3FJJTAQSMnOFCUxIZ+SeI2JXXg5Bf0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101080; c=relaxed/simple;
	bh=f7kZUGzjWGj2VYO06vzk356/r5b9I5pX5h0xqGvHbs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLQh+6O0tqsfhNHHNXG9diLn8N/tG9VW98dwjaSXfWkEPPMgab02NHX5DxTz4eyOu9LuTR4XDbQe4HHnFLqcCAj6OwgGhwl/vbkXpQhfpn7vica+DBa12/MLt1ZBWoNKoyoX4vzyHNezLdI7HSObscerhdT5DNwiiliv9b435fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QfWNIKkC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N5o5tqV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HDMZh1214071
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FiLdFIOl9PlXIMdxcVYmcXmw
	vstc2sRWR+kyhh3rVZM=; b=QfWNIKkC9L6ATOW8Ig/yhvIj62nRnrFOVe6u0i4i
	4SZ32G4q13/XjC6wjoBiX8F1pTq3XNepVaYX0T+oyA2Q9Vm3uK67nIaUFji9Pyf+
	ipBJ4RGGeoO5nDlAEtl1fSE8dMVjD79050LVrVqXE/Wa2IY3y6Bh1B+ZCb33sO3Y
	8XKi0FbmrtdoLFWScHZ6pvb0EVSLgjVdOh2eWTsoDOnWCS26vX8XHk0bTQGDg4l1
	Jjxjac5njC0WUG+OdkzWWBJZN/M7cvotNl1JQ1hBhVteDkljpcTmOXMzFSmrOMNJ
	KZhxmLXuEJU3I/67AV33kt7aK5/Xuy3rGFoZvqswBhG4NQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cswwkj4jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:04:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd81506677so1070734185a.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101078; x=1773705878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiLdFIOl9PlXIMdxcVYmcXmwvstc2sRWR+kyhh3rVZM=;
        b=N5o5tqV6C5IVghZGBKed5EksxzKaTeK+S080uamO21KZKNprlrgTNaG48gLOXPw+Ks
         AeCEnoU2O2E0G9OrS8ATlSmwDAi51NMZ8e6+CwZpmjpDp+8EMlggy6upxqfuy7GdoyO0
         3+GPWnt49PbFMaIgiu6rw/9lT3zjAqDdjq3E570ruFrJL4HS8xibBZJEkMNLRWTI3DT5
         eVpODLeRQdOx3YIrhxbLICJ2uECXPmYgXcG0lZcpwVoi4+57ByZxq//qWvaxgALASS5q
         8v/vHKaMpy6OezeVLG1/n3Uc13u7pkxAB3ZUALVqBvzJGwS81EexFbHvsDjn+QmHpC3b
         UfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101078; x=1773705878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiLdFIOl9PlXIMdxcVYmcXmwvstc2sRWR+kyhh3rVZM=;
        b=BV1KOCfM7BmyciS3ltDWri5l83DRahf0MccnbEIfQedYBEI1DdBLmihvG6oIEp+TIQ
         k8A1vwLkBr0cUu9LEaOT+BIhPYg7utA0HYxsqU5YdYcBkw/HKQVRZwMITHARPgk0wtuO
         pbT0qVGDTxV9DDRRlGNvE8DHTnTzK7VuHjaYp81zY7je7+0HvNVNQzY7NRc4WOQwCSVG
         N8QG6gIJBtaUs8pHB9VXCt7BvpSt0SPyUB0dpxVlMXvOeB+x2G4GPh8v2oS4Pxms0KTz
         g0aQJMNx0jjw5gc+5oQ9b724YqUiRU/RMoWCVDYZMGdj+h6fYOGftiaIf0ab0Ys9Od4U
         NTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9eJmM2WG3/13V2aD22qsGK6wSIIxe6JDzb6rV/RL+bQU5Mcw7eaV45uMyn6tPBTvqdRV1E0UHn8BeHW3l+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gNB+UOugExM+xlktRQOPErRDPr1Bxp7PpzjSP4dVWk/IgoXo
	LIf86MB82Y+6eNMNqkbyqrs8dp6m4zPwovXSQH3AbVwTfRLIEriok4SdJWsv/7JNAyngkLW87Cb
	D+iw+8imX+8m9DgwVUXs65jO/Hq9xex90yizHFFUqJHDN9h4rpWrZc6GQV4n1tpjaRRpm0w==
X-Gm-Gg: ATEYQzyoRUuw08c76WazoexyDB1Gw08jUErvs9DfN/j1ifUNGOl3WYKti+0y+PFu8OC
	RWQQVVGsBQeOoc7Ak9CYV0onLIjRXmWyfA4Z4gAzUlUwL/exggKbeEaBPwJGZd1dRAu84os5H9e
	belQn+WdhQlxxmP9xT8GDbCHfVL12yo5N9T8MIFsVPstrkFApi4pFbN13CFdkcLuVfxdv1hZDqD
	Djs5spWE49Bv4arM2j1kx6DznjHWpPtJ/QUHdLC5YvHLWjbIWMpv/txM7tQdSX9Vy87/D0qt5l/
	xDVREO4ChUkld8WK9tCj/JSPjzOuS5BjwLmDdKJ7J2m6V1gk3QsYGoClIo/mDrn4M4LCHECoku5
	jEP1r63/zy914tVZ4I/Ws9URXJmFipLqU23LTtDVy7uD1NG8Yb+/Awn2+KCxzNpDp7MRjPOAE90
	7p7TL6EOEVrNC9D0sBcp7iG6CPbfnz1n5/txk=
X-Received: by 2002:a05:620a:4055:b0:8cd:8938:eff4 with SMTP id af79cd13be357-8cd8938f34amr639762685a.16.1773101077984;
        Mon, 09 Mar 2026 17:04:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4055:b0:8cd:8938:eff4 with SMTP id af79cd13be357-8cd8938f34amr639757885a.16.1773101077459;
        Mon, 09 Mar 2026 17:04:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5cfa1139sm2074911fa.5.2026.03.09.17.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:04:36 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:04:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 2/8] net: ipa: Use the unified QMI service ID instead
 of defining it locally
Message-ID: <4py26yy2xkroj26amwxu6q3ynlvla5fmoyju7xu57ncgo7zswb@dvujowt2rxmm>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-3-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-3-daniel.lezcano@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cZ/fb3DM c=1 sm=1 tr=0 ts=69af6016 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=R5u7ATk22_IFkQxjSk0A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: RdBe_X0TacxPlRkT9Oj_5r1vZ0Laa_Us
X-Proofpoint-GUID: RdBe_X0TacxPlRkT9Oj_5r1vZ0Laa_Us
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX2yKx4uH7/hbq
 XUNLPPTYy5iYkn/fHyUPT4rvcUKFMsRpxcqCWvj3SC2I3dR625IguNyGD5vIbHwOodsprmEzseD
 lZHaprc9dWuxYSIaeSRLNNIwkMEK1DFvk5C2GocX0UETyvu2Icb/Aqnajw9ZZH6Qe7Kyek/h6c7
 +JNcyMHeXDooI70JgzlakaVxeFbsPva4AEpEtDaEeu3+YL3VlVLPgSq7QeIWDV7UY2S+6QzPGTK
 ycgOqhomsbIkkfEGDfWaDGaWJNt0tsuYa7CNWcbETXgN/UHwzSWq3ZDtpPM0SybG3rlaidf97+f
 Dc6/RpL5eYgkNH0e8ZpuvaabqqrZIurtx/azJAhzhG03ZnQq4LgHJAVexrnsd00n4J8loh9hzwG
 L0EMisRrV9KEC7ITFzo1GrdUOWJyu94OUYoaxJVnBhHzhftW/u712AFkkh+rCKDR2k63fccgYnP
 ozIUSIBuSBqLMVr5ueA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: 38DEC242D73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32791-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:31AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/net/ipa/ipa_qmi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

