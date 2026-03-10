Return-Path: <linux-wireless+bounces-32792-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCFNOEdgr2kDWwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32792-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:05:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD95242D2D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E97D5300D0E3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508528E0F;
	Tue, 10 Mar 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vr9LnGwX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEKyPCga"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C1405F7
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101120; cv=none; b=NfgIY2b+MuOUyoP8TR6XR4HnS+bpLijst8ddaUbEGBDyDcFUZHhThWrSODr/eHgjMmwPXwkXOcQesUnUIGPOO1mDxoARH01x7dx0otDkRECm0+mvoxo2LaG9mfhGIVIiaMfywF9LqePMjBZFXnjaCXhZSiZf48c7lATyRo3Sldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101120; c=relaxed/simple;
	bh=paV0mySP+9zV+Seo8jQCZrnwwyWiH+HvD8a4nb7UkmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqj8L8dqORsSiAMhl/+z1HqoJ2A8bOB4gLoqkJ0JV4k0efkggx/E/rRdx8s9CDc4PVwZ0wdKQ7BnT/co+KKcQ8/goZu23XO1v8lqR7CkXVFFBq+JhOsuKE66/x3v0DpQsIpLJYU+wAYIfA01A/jVhSUEYIE/cDtIRPoSsLasHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vr9LnGwX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEKyPCga; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBlte859605
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eq3YR8SJMJVvMJ+9JHxKSwsU
	I6gefV1Keb8jWt7Lh3M=; b=Vr9LnGwXIh56NKbRnXZ9oGqugFUK4IhcHRzvq3a5
	Un6ZQ8s8T1noY+p3OJ7nIlI/pFkfv3cYoEM4U7/xltLCa4Z/F2sl289yNUEOLOBa
	Z3BMufsHHwruxHaeqjTrfm6GUyvtFJbg8+zVVlRX1F67+pZN2/f57ytt82EYhETZ
	OewgGpdBKuqvpKxd0OIc6KSPJV+25un2J5yp3XmPiFYJMQ+y92q1SsXDbwt6Jmi2
	8hHVAJIACjd7Y1J5B9g55NXaSqTp8r6jKNbRIKYDA86kvmEp8GZBpLP2wJWX4hO2
	SEac3DT7Y/5jRBWsKq2SbbWyH2StPJI5fzOoVYyq7M6BDA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyhbssrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:05:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7a25c5a9so1229144885a.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 17:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101117; x=1773705917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eq3YR8SJMJVvMJ+9JHxKSwsUI6gefV1Keb8jWt7Lh3M=;
        b=IEKyPCgahhLNOYwIRYrp6obtaYlFz9T3SDLUehQJBGltxV095bNZzBrpP/jVL5ZTAS
         jgmt5F9xIt/VIYW57QEpxQvcdLV8iDPxWvgVcR6+oAmzQufz2o6MNlitWqPSrntIwwRH
         M2uKN4sUgSRb500FzpOkCuWpTMAf1WklX82PUux7xfWB99V6MvBXCMdOG4O72O+FI45h
         YcDp89HL7I1prjUa3YcDol83vDUJZWv/WmiaQWYKCyc4SNbhMlQ7xSF383vcZCBIa8E1
         SX6bCEKXgfEug8R/wcIawJAHb95wBG04DGpkJYHN0ICvpe7muCVgn55tZUYbSKy0fXt+
         NvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101117; x=1773705917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq3YR8SJMJVvMJ+9JHxKSwsUI6gefV1Keb8jWt7Lh3M=;
        b=qx1fr58QVABRLSkI0ZLy1X+Bs+DFTv6eqevqKYCKI87i0hMSfWXwnXzn9hVfGFp1nn
         Jl9UfMFRlpA32t/3ANe6MlQcTDz3OHLu7r0vv1Td32XsJ1GfV3vLOoK20bQl0QlpxD/8
         B3YytaamcGTGxRjnquu0YYDCHO5PvaQaq0bY9aa4Og64tkJxa3fZN2fLwuVj/qLFmPlc
         6fPQvsMu0YlLURxe7ejET/sBB1rJuasQfY8G34hwi3fDEZI8Yzx9lTWGspsxaXom6Be7
         kd9J0RuRZ5GA3NoRzkGhq+ankcy8nf94YSO8Nt3t0xOVniO7jmF4N9CW6FOM8ghBni3D
         O0+A==
X-Forwarded-Encrypted: i=1; AJvYcCWm6FmB8CRH3FLOGLsNxn3TkZhL//1NQS4LVTcKOjsJYzXz1EWNn+VgcA6HiW2sqRRiBgbag1ahJCHGfq8ovg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVG5xK9F3LcjU+des3cx/mkbNoFoi6l3uXZP/3M/zkszyXX8N
	9F6tlSpuDPV3V/aoQ73NQ8Ie/xIp5fiA9UupW0R12za/gXpy/R4LuAtM7Dqf2CYVH6ZrkbYQPLm
	M/FahqkQZRNXoCMEc29vpRgqYBwyIYMzyFKywvx7k/1cAdrtjj9EVL6zJv82xNAsI+v/sjg==
X-Gm-Gg: ATEYQzyj7eiuJRVoWqeCM+vIqpK2ByEsyXCgtz+OqCagCABnrxw0yxjPG4gqBNpiVeh
	D+3qmqh5Uqkxv35nLwqmb8jhuQOeJGErPjpHfqL7gT+AiYTNpHstbKRAMTtoVpRe2WPd4i2FI4X
	432/jQD+bKiktgSRYJGi5rMqo+rn5/Wh8P7ZKCED2+xMCagGzIq44jCCmi6qMjZ+GW1Q1yCvLJU
	XHY3MxYModjA+qaW1GQx5wGuBU8m6Tr2i+/6IT2gU3/3xJDksDDDANeYQK+W8Ag5kefkI0TONW3
	cwsRlTGoPzG6bZtO0ML90TqGz/61i4wW8H5J4hWnNo4oGeH3qcq/zKIbnqHaWMr1MafmWwU+gR2
	zp1txCakfQ+HerO5HXgA6yGRVZ//2ZLb9xyuFY4fgyfCV+7UDDzqf6j2EBc0EuyKipfYQLNgFEH
	HjxoPtLnyrgtlnetUXl6A5RgNKI2JdbKpstIk=
X-Received: by 2002:a05:620a:1901:b0:8ca:2e36:18b0 with SMTP id af79cd13be357-8cd6d4d5b1cmr1601783685a.39.1773101116999;
        Mon, 09 Mar 2026 17:05:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1901:b0:8ca:2e36:18b0 with SMTP id af79cd13be357-8cd6d4d5b1cmr1601779485a.39.1773101116549;
        Mon, 09 Mar 2026 17:05:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cf6fsm2324914e87.11.2026.03.09.17.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:05:15 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:05:12 +0200
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
Subject: Re: [PATCH v1 3/8] net: drivers: wireless: ath: Use the unified QMI
 service ID instead of defining it locally
Message-ID: <6mm6z62o6xlso7mxyelx5zho5iowh5zfa4tlbfsexrb6vohzjl@citw4jcjsgsn>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-4-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-4-daniel.lezcano@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Rcmdyltv c=1 sm=1 tr=0 ts=69af603d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=n3fwWfvLsPu2TWPVUDwA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX0E4AySIFbJ4J
 scWHo9/3k+eLhvsezUzOnkt+rttfSZ19pHUdq5vQuNzR8+sblh0JGy5un1yv9RykMiB6yNLLdwD
 unxXSr4ajbwuliET2fv7UHXAmcGxDMnoFvuGCYfKyBmB9gFjFI4sYNoJXsUxVgGsWfjfZLm2P2u
 JyuHeLe+laaxLVWCBXayTBhX4/ctV86SgZPidzHTKCCf6R+c1p4NcUFL87iOI6IUBB+SlG2FjKE
 xTm1DCjMef8uReJiyUG9xdJtw2MqxZs2eHrNUb1xx+X7fCTLJEJmhvt1EBpKFCzV4xVyMNilR8j
 HlRlrFUgBphU7V9cmtaTLzV0f75UB02A+SPUn/06rccft738ALCjCkwBwpyDqOSkhPmBtxltQGj
 GrAZHzSwE6qFfW/KsJh6gU6VoeDcIKpFShS77f/g9Bk1dnH8x0cOWXwlTE9ecQD4fHc9b7DCnzR
 5p554TKIUlJ4RXawgfw==
X-Proofpoint-GUID: vtSB95xBF69j994pH3nMOVcSIaoqX4Nb
X-Proofpoint-ORIG-GUID: vtSB95xBF69j994pH3nMOVcSIaoqX4Nb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: DBD95242D2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32792-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:32AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/qmi.c          | 2 +-
>  drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h | 1 -
>  drivers/net/wireless/ath/ath11k/qmi.c          | 2 +-
>  drivers/net/wireless/ath/ath11k/qmi.h          | 1 -
>  drivers/net/wireless/ath/ath12k/qmi.c          | 2 +-
>  drivers/net/wireless/ath/ath12k/qmi.h          | 1 -
>  6 files changed, 3 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

