Return-Path: <linux-wireless+bounces-32799-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHq2Bb1hr2kmWwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32799-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:11:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CA242EE7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8E5302BBA3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D91482E8;
	Tue, 10 Mar 2026 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqxwLbmW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hKX6fenh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05574C14
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101494; cv=none; b=XDE8s3ZhnRWOE+Ed9o147TvPrIGe51dAmX5RJZ2TJ2RqszOYWm0SQC4l0ySkZTZ3JaH4NoOiMp6R2cyGh6cIsK1UeJRIzTvUmUZweAUZKwrYd/HE7QGrkvjeWXY0xWDrt9q6yXlBeKBhzIm9tkpuSDEYQIcltfRJYTJK/Nxw+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101494; c=relaxed/simple;
	bh=m9qCDpkjy5X2THY0acR9kltKP5HQGUMAZKo/7H5omio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGzK3zpzdGZ9BMqYOgFlv7WvhoOr7DVvLnuE7w3V+vJecMKz9NOgDmWpJZZ6P88Qobc+r/Pe4YsOq449NLnUC9PLnJM/r2Nj+650oyoq1JTYmNw0zrtGCdSM4H7m0Fe1EBSZ3wZ9angQycZomt83I3ju1NoZ4sFUfuORbQh3kZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqxwLbmW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hKX6fenh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HCEfL1212183
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Pkr/1ETbWQejqwBM4qtLfTAa
	AxiiLLi9EmI3z7gEzag=; b=WqxwLbmWApf+MP0scmsGweu9kRuuQzlAxKa4xDS0
	me8bCEsYRkKs0UqWwp4R59vPcDuVB+sUvSjJYiktF0Pg+GoksF/Yb9wLMbKTsSy6
	eEvNwkXDKNb2s5O8Q9n7PJaB1PwXlA41ErXyFErlqYexgIloTKVfQBgaWmjJG5qY
	vZkjvoz4Gc9Hw2a0R2lMbYCxaWXF0jiwiNDghAdbIFS/l/57J33Cfq5PJC0QFLDz
	V83A0oMU9E0jnBSSPOM7pcI20Df55lyB4rTvvcc/Le0Q7hATER62nsGQGoDz1Ql6
	a6NqXFKxHRyQRVayozXJPrejWDjiCtYw3AzN/Slg69jV0w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cswwkj5h3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:11:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4d191ef1so1700950085a.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101492; x=1773706292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkr/1ETbWQejqwBM4qtLfTAaAxiiLLi9EmI3z7gEzag=;
        b=hKX6fenheOiLvBPZevhG9VID7p4DsmaLpZlIfdorXKat+r2czs4uFFCyDbc5iBcri7
         m2qmd7cnB/g5GytWPA0NCMLwUjgSEV1f7vvS6rT3YaCj8CvuxLVpODJCoH/D+BOXCqey
         1r7CxxPnek/GVzwh4PzROW9Sf3SwEmu+abu4OmbxAkDkU5FwLDd/HJ6s/t6cyKaF3uow
         d/4JvNLVBK9gJ1+eTS8PnDr8HuJYRBiUeKUAtNyBHKGFnzUJV4JW+6FuvpsAvO9YS3In
         +unmnhx8PkWH+xlxE8Lxfff06+qkbBB5iF1ApxoSFpg3nn2TlOovZbG07CyI8AwD1y9O
         hnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101492; x=1773706292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pkr/1ETbWQejqwBM4qtLfTAaAxiiLLi9EmI3z7gEzag=;
        b=vBvv35h79evq0o+sL8tEqcD7Xw8io1B1Y3Sjka/XDOfV3xXf4yn31Kx8nfk2WI/xst
         C07h/oIr3J6XX+YDMzvPYqYxU5RpVJydCpSzgMvQGiEMEoAoacjgKAxRC5IQcznK2v/K
         2+CgVopJkunMxGcdMxTlwchHAS7BTyOmKzITeYxQarTA71TDzqfCDt11Z+OspQZZyddz
         OoJ1Xy3AsKDxdApHnJCqV9SB4XmEYpWUgkyKDY9PAzhKw14vQFJRwQAPeICmz/a1i9Xb
         WwL+F6rmq42IJA9dDIWw2ID4AKvIjMPJANgaR7h91ki3+sN5tUyjlqCSLlo3CZP4aa8J
         wvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU30aheNcDArfqKjOgAHCDaXpHe8dRMh5CzEXc4vZPzFBE73b3572B5iWRC5h4GYFHAAwt7YjYbwl3d06Fc1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOq57WedrGpVPKFlfUyplWJ8k8JGKQ3KKPRPjkjz9UdjZl7ZsR
	IzUoEklp9xKWQpQ+Xv/5DI5ov32PY2U9Wua/xrEn+4a/fXoHgikqsgJFr72YYf1WFJcQiMW26Pe
	27Bv7wpmbE/0UBgWETus+lcSLF+aFZxLKYbWZmHVW0cij5IVveJDyCRJSm7PdVkzKhC/D+w==
X-Gm-Gg: ATEYQzxNHRa5MI+SVI5ByP8I8VDnlSG6DwVtjnpG19oy2gtWlTcZK+ONI5KBp7Hsr+E
	M3OI8B4xAFXa6zwOSsephK828/px1+po9/GWB5RtVppINFDpeEtTXPYKS3lRFoQEk9DnEOY9Mri
	prPqt2JWJQmE2Pyd1zv7vVMlEM6r/15SRXgAZj7d4gVu9JM7t+h7T44/n6Rh2PFLbkEQLhrTX18
	cWcyWBFJehA0uTXsnQoJUc9NAHGLsZuuyEEA77ABbNHDad392bxtPz1u2tpUfeu4SAOaHuiiPhW
	Mm1U5wegNvspc5AGbklEZrD+xE5FBN3LH+r3xEkVUQvhIGtun6hEw/EBWTQanGyzNcQhCEqzbpf
	w6gyfT7CAlIHkl/izQTH72aCDbkV58F+y39Lz22ridGK0d8PDAHi3o1tAyqfpV0drLY1M/Fdoz9
	Qt5OZfjiZg6IOjBtccw0kyFGoPxgNhcNrEXLQ=
X-Received: by 2002:a05:620a:4445:b0:8cd:8635:c031 with SMTP id af79cd13be357-8cd8635c4e0mr698514585a.20.1773101492229;
        Mon, 09 Mar 2026 17:11:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4445:b0:8cd:8635:c031 with SMTP id af79cd13be357-8cd8635c4e0mr698510485a.20.1773101491691;
        Mon, 09 Mar 2026 17:11:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5cfcb1d5sm1692581fa.16.2026.03.09.17.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:11:29 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:11:26 +0200
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
Subject: Re: [PATCH v1 0/8] Group QMI service IDs into the QMI header
Message-ID: <ce5hwbo75dr4e7tt27bcprhpch6fx47omhn22ni6v3uzwfb2f2@fa2bebk7foct>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cZ/fb3DM c=1 sm=1 tr=0 ts=69af61b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pNJNIoqo8oUBudG6fy8A:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: S5wibvV7PdraGQd3S0XDqFOI712y6HhX
X-Proofpoint-GUID: S5wibvV7PdraGQd3S0XDqFOI712y6HhX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX/aoLAoJd/vTo
 OnNGpNfSvtYHj+hN6fc3QbtRdTfWeVJDHdKtzH5ZnYZ4phrAxabANwIxAA1eqelyYX7vzaVrv85
 vhjLHaIgka0DdqLrmGf0otIo2XRedvbiG3GSc4a9fpwlK08Oop5brxUFyau4nB4HpkWgxApkYL5
 iHHeV+mDBuxzCrCc90E7xrdMW35eVRWGDEbfYji8RqeUjBlAYVnxnIYq8o2AvNCDcDNB7gqpyd0
 BIhaIMLDtHwQDLitn9ItoLtpbW1Y87W12bSh2DTNVBfodPXkmBQPuqL5D0kNIi5KgqJ4s4jrzPB
 f0LOGPz4VPPdV4XmDEw3ml6gzPd1+p+JGhEWeMXzyAN+OptuFa4KmHf3cYzD7SQMHSl4+Kmuovd
 kF9tgf6jll3jRHoSdjtTySiZg8mCbWNeCHR6u5TWknV+ACgAVuFM89/ixY6FLqebSfKQWei0fwQ
 CrMu1D9ETXtnX2v2Z2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: 6A2CA242EE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32799-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:29AM +0100, Daniel Lezcano wrote:
> The different subsystems implementing the QMI service protocol are
> using their own definition of the service id. It is not a problem but
> it results on having those duplicated with different names but the
> same value and without consistency in their name.
> 
> It makes more sense to unify their names and move the definitions in
> the QMI header file providing a consistent way to represent the
> supported protocols. Consequently the different drivers will use them
> instead of their own definition of the service id.

Also this looks like a first step towards providing qrtr service debugfs
in the kernel.

> 

-- 
With best wishes
Dmitry

