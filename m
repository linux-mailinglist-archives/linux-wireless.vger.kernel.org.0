Return-Path: <linux-wireless+bounces-32795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGXUAslgr2kDWwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:07:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20A1242DF3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF283013B5D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1BF72634;
	Tue, 10 Mar 2026 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JapuiHfL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJV8BRjR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BAD2AF00
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101210; cv=none; b=L1gMfOyIzLP17jOyw4AP060nDRzwO4y9UGaQo+8krCLdMcKNLPEGJUZR3V6d3wM/RQRkJ1m6kEsS7HeXICh7cNDHTb0FkqDrd/IZgDQ2TXoELMFgVyE4UEYsCESmjgrgCterBu/ce8HU3IvDmaSbawUU0fqc1SdPNu9z7HsKWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101210; c=relaxed/simple;
	bh=EeFpgHgJ4EK0P/FdP0P6/Wa/ChILFm1ALZyRl6FBEdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ggxg0qLHfp8pPCEzZZ4zjmKOYzEJz68oiko4j6NYtKUOGU7XYXeuegLDLQXwdlg9mhHR/9sDrV6kpylx8oFeimvPmosxJ3V8G0Wu7vQR+m6vIavTw//qCQKuETvn4qF8i6vD21OhsJXVKDoUelrPF5bru3UBGc0SfXhmmVa8RHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JapuiHfL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJV8BRjR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629NoUpH4130862
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VFmhFycj2WExrdRTfkSysTZd
	dOqHarJ5plPefogYPpg=; b=JapuiHfLWZPy7Qf1nLM6DfJ2elKq7wWA9Yz5rN8O
	RpcjqtxbVZQzPTeEaWzhCzJvIQB9NqUTVZPR0OLNID2rxrhJ9m0OKBhLQdtt+uQB
	yuFo+H1vhdnVA9t6TKi/gGnCrozq5gKa6R4+3bReYtOAad9u/0n8Jo8QPHo7xI8D
	cCt/YeY2P7veEZ7jG7qhD9+DzYDBeo0J0H2ZHl7U+XfV0as0rPy10njp4OBO5Vhz
	yGlYbJ/CR7EkMmFIcuI0Ai5YHFdPRfqBxlTo6PghMlnTWcANCodJh/75Qk/GjMov
	kGUR7kIDRhzZa9CTzNtrE8raj+VEE+v7OFR4E0kTo741+Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct88001f5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:06:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7de0e161so1293316585a.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 17:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101208; x=1773706008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmhFycj2WExrdRTfkSysTZddOqHarJ5plPefogYPpg=;
        b=RJV8BRjRQrzvtXO+9ZiuKZvWLhgIURVucA9aTWLXXE/X4KA8IKA4x0iNJvWL9Eo+MN
         H2vMK8BtNG7+oHHp28sHo4l9d6sOZ5NePQvFD9fXFcuv4ILA7EAuQjH0oF/kVL34fiwF
         TDQxBu4pg9IslEVHI4OhLItpAfHchyFXnAkFNxh5uZ/Kg7lpBDdSskM0ILJ53an6IP2d
         bfyvxl1o7FfZBJMc0R1GS/ScESfLeFLszs1RkPcnj3bX+YyXrxY+Imj62ImTTffuygfi
         8MXMMPqCiCMgGrHaUJHeMB+x9TNT+2FRuGsDm67UZLIbmOLuVUWJtxgLCYHvJG8ueUvR
         wh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101208; x=1773706008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFmhFycj2WExrdRTfkSysTZddOqHarJ5plPefogYPpg=;
        b=b0z62LBp4q3kGR86WqhcRASMD1LDrv5aDLrbljBx19gk/APumdU4PLKCf2P28Jbk0C
         pmOdg7O+RM10RQhEdmQ1tbJp+9hzRvna/XGW40tQRIcOMIYURWZx6Stn7COcvtG5eAhB
         YTYBsdJzkfoJEG1EOk3cLPKmT6uHH32zvrBJFc6BLKBsIIkoYqdim8ZwmLUsvpVm7khj
         UuWSSASfv0KRRRuuBrU8puOlwZj9UM2YRsscXIYbcALzKu7xzWLDWsRYSppqQ/PrCPmc
         HDrJ5+9JhULjZs2prEvClxX/sh+lOxmUpTtGhS//5NG8gw/7qY5/Mn2kY9Y1QZ86M0yD
         pGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMAFOJxF85ZZ5Gh9qsDtSEgW3iGWciMZZrCIOYUoHvbqbOojdNtIWk+CmF1xZdjQKLEQ1cx6j8crWmsiRlyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCv6IdEjev2GEkybpYzsCvl6sTJ1Wmfb4fTYC4UgQZytdkx81U
	C2QtitFJgKZAvGthCY6/bRAPWQwI95oZRNP+yiBYlAVI1fV/aKeX93HE6/h7X9tFHeOXXeNjwET
	mNBhN+LdbD/hy+uen40Ns3bspqD9poWl+Zgdcusl8lVR6zbZbche4J7LWnl7tYu9XrY0CUw==
X-Gm-Gg: ATEYQzyJzuXhP7B26hljifq37nZQh93BKvxB0Ug8BJMHHk/VocQM3ildJaaBW9m4R6P
	F3DRf0fQsEnYR4KjkSsnhSF5zThBQ9SwMzSz2Gfz1j6KlWPGicP09p/pgQbXA7+z1eEdtXNJlVy
	tCDD1cGOyYPPOsJKKYckpBGVQGilGgGY9nW8iFsnXYcEq6hsdg9Lsx7yfbBM3QKBKkm31AkvxA5
	N9G7/zfb60BaZlTQ026XEvVFfHJfRyIbH4+tFcW93IcO6FwuZu6MDrqQ+IzFdM8RhYHVt+ocxTd
	Ct6EJ/K8T/rSvBkuMvSzu8DrKWdxRS3yr+gJzP0HWxYQOxbfmB8oMENqR6rjoQlUHZwA66tlo4G
	2OaEBBBexcnS2Pzt/W/Glo1IMJcjWOezONX84RPZCRymtXlpyOj2Ey1iP0iRnZamBJhd+2QLsk9
	vThATVBouVz64NWfDpj6peAbZtPD/NSRjPMpo=
X-Received: by 2002:a05:620a:46a6:b0:8c6:c9a2:504d with SMTP id af79cd13be357-8cd6d488044mr1675002785a.59.1773101208106;
        Mon, 09 Mar 2026 17:06:48 -0700 (PDT)
X-Received: by 2002:a05:620a:46a6:b0:8c6:c9a2:504d with SMTP id af79cd13be357-8cd6d488044mr1674998085a.59.1773101207669;
        Mon, 09 Mar 2026 17:06:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d08641esm2376849e87.74.2026.03.09.17.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:06:45 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:06:44 +0200
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
Subject: Re: [PATCH v1 6/8] soc: qcom: pdr: Use the unified QMI service ID
 instead of defining it locally
Message-ID: <sm2yj2zmhswp6ydjeonal2upnm6qwokivmrnyajmw42iw2zeyu@d7kwprkm7voi>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-7-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-7-daniel.lezcano@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX956LZuEOclfA
 ejHAahGklJo+DFrjejOCVoIU/T3JXabfB3dFz8H+KIp2mZeW2eVyb9r/tHi75+4vgf9Qx3dp6Tz
 daDWEsMHOilRFDjP9UAZdrjfWQihv6mMYmOAudxBxCuK+PHugg9UiJ4srIrY1vl1L/s1XUtEtnb
 y3b73B7p3ax+7wwFfM2p2EsMhInM3y5/xYe48/wRMQxggE8CtLTXzxbFE2Fm21v0Mf3CTvZ/mh9
 1rbB9BVe0hkgqZWlKoL9XqXq8dkEhrc6YfAsNxfh0thj1Gzyf00KjJEvHMYI+txB2z9u1bOFAgw
 fK4yx9u2/25RQdkZN++f6z3r5oeUmZl+b/shXVS6w19qE1NSMWZWIQJmkl1WQwoTBZpc4qGYjhV
 1Pap+z31/P+BhTa6xcoJ6BISU5qiqt1H4Fs/6G1vpnkakjrNaedTKfVz/wKT6nyqZ9KfDHbokJk
 qvEhCxDGIkK7IHVkupg==
X-Proofpoint-GUID: hKNnNaa6G4Z8Cyn59ezAXPTfKqoDXOCS
X-Authority-Analysis: v=2.4 cv=Jtf8bc4C c=1 sm=1 tr=0 ts=69af6099 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1EgtvGsZK5M7WpkkhHwA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: hKNnNaa6G4Z8Cyn59ezAXPTfKqoDXOCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: A20A1242DF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32795-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:35AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/pdr_interface.c  | 4 ++--
>  drivers/soc/qcom/pdr_internal.h   | 3 ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

