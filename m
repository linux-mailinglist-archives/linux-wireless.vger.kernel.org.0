Return-Path: <linux-wireless+bounces-32794-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ+PLMBgr2kDWwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32794-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:07:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5CB242DE4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E04304CE98
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8420242AB7;
	Tue, 10 Mar 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH3i+5Hm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lz7hMBhX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F83B1BD
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101200; cv=none; b=K79r72CHuwFxd1TZavQ501UorfJJAQLAIklnnggNIdaHeHzFtuBhxS89X9VuebmgZXTqRAHEiSmthLGXOqG0zIOFde3rI7i5Fa/kpOkgzbGckvBcArUA2JTJouptD19gifGhWw6gue7zZVHgAdy+L2aSXc+p9FgP21MjdVAfeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101200; c=relaxed/simple;
	bh=tUmt6OxyYKm3dZ2u6t/zmku4MTRZYJky3GUiLcfgz/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcCndDXPUyN1WoBk0roskaBrho/xtJ1CMhO1+gnEcnUzAN9UstPfOtuhr0mXcabkyBHk3uhKM+3TZwN4L92ocwysbupehyy55nj4n2X4c7vDVolQvZTyYHMWfhgccK0nmlI/5gY+QBjSffTlHmMoPQqqQCyKX1ak7A1P48y+0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RH3i+5Hm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lz7hMBhX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBqHB1297909
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Hhzas3m6jtpCWQCVIcrAsr4W
	EI6JkmKF0k2Y62ZMW8M=; b=RH3i+5HmDrcWtIsbYsGLYPAucQJ49p5jSFCP1XK8
	cmD1TTszcORCF20BgNAuXaMv/jJiLRErS8OSN8QmqlCTHyPy1z+QkEdtxohyjYG7
	A2mADZnPK9mA9JpXvpYpZGSIN7dK+BD6vZgH+2IvNkfpcXulgdym5sqCTauzjtkf
	vtuiyUTc65s3tMmjbV0vaKA2UBoopnEDP+Wh4kABNLM7l2sm0CNYv97yvtbjRe+8
	S+oMT8HwInm2qtDIf1ZRhXBmNqquWgIRW4C+P3hXW2N0zjD2euQ9JQXbhB2aEC63
	TEvjc5oqXJ7b/UHtcEB1uZLhcWij+XqY/Bv4WDu7ADTmvA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv19tj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:06:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd81c571a5so1002485685a.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101197; x=1773705997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhzas3m6jtpCWQCVIcrAsr4WEI6JkmKF0k2Y62ZMW8M=;
        b=Lz7hMBhXTcTAhut+tWMjq23JjIGrRVAj6Rwy/noN8p1xxb7jhb5SwVyDGw9z+3Hp59
         3X3LwkcAUVL9UAizuXmoJKhB3+TKeFFJHOOS9SqpJjVQ0YSOA/XjHtwSHxruxuKthPJL
         AoTDbyQh9UyVfUeUcO8c2tpLMxp8K5vD2uzDYWSyISP4bNZTE30q/N0CD1TRg16Ugc3H
         rYzjTxphR2PiThhK1SXaMD81PXGZQXkN/dGf6tkQh7KO0KExg2nlAEbNzHlKNN+6/BFI
         ++7CdmSnmAeFUYh6OybHOmJaUPaBn03nGQwRBYR6HXKqI1okFEz3VTkVsTSjRJHqv3Zd
         dz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101197; x=1773705997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hhzas3m6jtpCWQCVIcrAsr4WEI6JkmKF0k2Y62ZMW8M=;
        b=q0Fm/lwzS9fLQxXb92NoE9uUGygcZ3vWW7R+0R5AEhTBpSh9jfk9MbG6qbS2Zl5QDl
         3hl4LeWmxwyEnFOK1wiDyT1508neLfRHqBBEy3z5lWKHSKInAHgrbx1NT9WMd04IyyGI
         PnL7k8yP3zutpWvq5YqxQFvfndqiXiicY4ZkwStlsHmPxtvv/p3jnCCTUXO01fqlpsiz
         Wfis90btZHxK7F5aSoorfzYFy7qLabhkVAoV7Fxvzzg8QOgnqrExQzSvJAZBYrDu3AIs
         M82ZsrivEa0CYvet7GyzmiVFPykhyp30tk75r/FdpgMaYuLdTimATAgdyI+cyRGNCTfW
         KuWA==
X-Forwarded-Encrypted: i=1; AJvYcCWW51JZMWUCYCBC4cmLCNiXMTMwXsUbGD3jNaaegz0DDJXFJluwg1CRbd+85C/Y4s7VAP0aviJFUKagr0UGgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDM6NTeYxicoB2b0YPeBV6MefEOgLXyM2XV4b+KaZMa8N1Y436
	eXeFxBbJ3YjrYFi7DkaHG0n7aKU1KbOuUSUPcPOBHWc05fT5a3ukGpqDcv4GLqEadxXiOqY5Lhz
	W2mFSRCM2ETZoTq88MR+83FAHIgF3QbepwJRAhnQsgN7l7XzU7WS2gUnuxRULh3kO8yz8PQ==
X-Gm-Gg: ATEYQzx/HarY/c0Hcl4DjJtWP7UZ7+9mQEhhmFgO4vBWDnJK1b8dblTrpH1bmH3xC+j
	x3KqFlM23MmVFIaQ2UpGxFcc5Q4onczv/81cl94HacBvODWTmI2bsVpCihMp8YHrusPyhrf7XHw
	Hr39aSDu0H1vJh5YnFC7GkqikC2xXALupJ6bWcW84eRmg6OOcGhrsPIUHw7rjIDoJIbE52z+qWF
	m5OJDU7CFRLwtibCWuCP+Za+h4WhQYcxhGgFNieUAuv1VpMCk3abpJKDuBBwoCb3pPBgr5POAfS
	DSQeZFhX/nVA7AR8ZJqSlIJ42pjU1kO/SdLeRt8Iew/xSf4TzxkGdO6GWqxEwvlP1/ufBEx0d0Z
	RXx1x+4Z+uGfpTK23bcM0bR9VzQhDikS8s6ljxxlCVT1lZMCneHgwGgs8C4AMl1kr9REw+eDVta
	3gXvQVVF2a2EqJR0xc9S3fklSzsNTX1oRtDsQ=
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd6d4afe58mr1491598285a.78.1773101196858;
        Mon, 09 Mar 2026 17:06:36 -0700 (PDT)
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd6d4afe58mr1491592585a.78.1773101196256;
        Mon, 09 Mar 2026 17:06:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d08d269sm2464700e87.84.2026.03.09.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:06:34 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:06:33 +0200
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
Subject: Re: [PATCH v1 5/8] slimbus: qcom-ngd-ctrl: Use the unified QMI
 service ID instead of defining it locally
Message-ID: <6dvg5nev7sbqyfhmzgw3oln7hb4b4jlw2yhrskrcibdscoziox@hir4jpjcrzey>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-6-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-6-daniel.lezcano@oss.qualcomm.com>
X-Proofpoint-GUID: buWLiAV-D3nIMW59b7vFLKc6ab91Ii4q
X-Proofpoint-ORIG-GUID: buWLiAV-D3nIMW59b7vFLKc6ab91Ii4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfXynGcddNJuhok
 3gOnpo758DD/jIptV6Sw8lLYlrD9X4fKSsHHa8HUSvN7cG6KeZdeulz9nCqB92cy81Gs3MpqGz4
 my0EtiIWgvL+CN9X922JiKsonEXixWLJsEbC9V0f5yrKQXqUXUuO+2VMpH8i9f7AjYWc3SV+kwM
 mMjx8szwvT9TXbtXRjfzuOYPopL+5We+4oFtJ60ZnUN8/QG/2H3GarMmWe4oMXhxw6mrAMDeyad
 KA5eWRN4rakoz5cD0/TF2RqBkVDRnKi5WoxKOcIi+tPCndObo3mGGLrKmqIMPiNpzxQWOzI6WCH
 bgWGCf4is7GKnMVGAtSU81C6iEK9LhKeuSivl8dzxbyZ1QhvbrH8+AWeOmgHfU2htoYy5V278mw
 j8867HsNBlYAAVKOuGuHawOzFLLVCqP2pr2r676uflCcFjRGYdaOInVtJK0RQyFzaXnYKmPb9WV
 DSu6K18WoHtMfNvRdkw==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69af608d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ho3SWJPnPTLIVTUpvTwA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: 0E5CB242DE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32794-lists,linux-wireless=lfdr.de];
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

On Tue, Mar 10, 2026 at 12:03:34AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

