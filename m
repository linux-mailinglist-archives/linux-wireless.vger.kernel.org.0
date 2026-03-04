Return-Path: <linux-wireless+bounces-32482-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLIBOzLEqGk2xAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32482-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:45:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E7D209184
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 575D03042460
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ADA221D89;
	Wed,  4 Mar 2026 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h9Gx7KQ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lo0XlsEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345B5477E
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667952; cv=none; b=KOyeu7y3RnRTOyncxmGp15Mk22w60STsfUCsFa3pBJokJavCF0USQNPBg431+9dfaNrDjI4bIE1OP32m65yWi9bgL7VPVbLfhA9x0wEuAwIZvFRCwQFHE0/LWxS/Qv1xSm4ZRe6g3t9LKDK32aFxkHtKUXGUxoqRZZbHnSg+WHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667952; c=relaxed/simple;
	bh=+1Y7UanKRqGrvnoH5Mr8xrxROqIOcpxOCtVT08BVbBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnwgRbIvRG0Zm7O/ZI9pK950L20gFOWDG0hKSQucc1OUss3/hSCxMdjb2P+5I43vnBdyGy3zChqsaWT2dJE7/bSpuz2sVyCmLkqu1t9fm28bwrW2VgubxXjq4arxUlIqDqei7U+UL4KOBtHzn8B8G0Om7ZUnWsVvBfGzW5NtqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h9Gx7KQ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lo0XlsEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624MccJL029424
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 23:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eTiPgJ8p02jTHd5/lFpc8tHF
	aJ1hfSTayk+CcTaAXKw=; b=h9Gx7KQ4r6FzcVz8fBA6lSdebKOPz9oKzFpTIK8U
	HSuTXWIa8HLx3Vgjo2JLhzPWLIt5k90wjP6C95E9PqUnct+hywvLbzyjB533mGpX
	J4H2Ef0y1oNWD9Az6mGdjf/itjMYLWL1T/H+VCKdWZf5Eiia16Vdz9IFTc6vkSJB
	T1IRAz7/HB13TT0uelhouItijGo4ZzEud87fQuLzrOOq0DUP0ACSdklAkRYtABCP
	gJ8qrrQjgFmlGkr246amBryvS33FG0EFpqRje4JcAqP9nc9eTV05z63Ta0RORexp
	xWj6CBFWLfrsctP4isZ+fXcf8nM/L1ozSzafuEgp0/wqvA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpp4fhq7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 23:45:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ed6c849so1241230985a.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772667949; x=1773272749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTiPgJ8p02jTHd5/lFpc8tHFaJ1hfSTayk+CcTaAXKw=;
        b=Lo0XlsEirwdEtwfvudC6JuL7uo+chEOKZ9jpiuo5vbdXILIEWiSTOSdpTvMYfa1Ems
         RYCswyz3cUYktz9KOdSroUYIkHJVAJejJHsdBy+lqtEQS8kLlQMjfpqBfEGKqNZ06JAp
         oHmuLZaDmjcAHjiVRzAg905PEPvu3/qQPDdFrJZppXrBERE5fJbP5htDRfhvVWSRSmIw
         7+NSgkHCaIdYkrcAE5EkX8CrgUI8pq05mSthiooLv+iw760H9G0VRNp82+krsz1jkAf4
         fhz+5IftffuspQUHKDZ0mr45qZ0gAt7AAvbWrNSZgtMJFqlpSqY3jL9lyVNshBKG1ihd
         3FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772667949; x=1773272749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTiPgJ8p02jTHd5/lFpc8tHFaJ1hfSTayk+CcTaAXKw=;
        b=vqvXhv3eJwptXInbXSkLbhejvgxMhUKJG/sxjEna/9tgHxzb5h/JQcIJL+xyJ9ONF8
         SfhhDjSrxcB0+BBes8iE2CuKo7q4p47i0F0M3X+dlr/IoSUbJiDh3czyrOsxgahC2/01
         lr3zA7uEIde1DhA2JzN/bdVj1RYtpcN/ZF11h4HImnJpcIj6U7/7u+rc0jCBHeqHxtsw
         SI6rHI4Isy5cWsjMBv0GaiZC4Nv/UVLmfsmN3zdEvjEhYFOQ2RaB6zOxq3er0hJiPJ78
         QiBoSibLLfnHg+TP8plFFeNGzfz3PpSstf5+4jMiQWDdw2z4cR3qqAbYhBCtlD9ktRd8
         8SOg==
X-Gm-Message-State: AOJu0Yw1slKxuJMdpeNbie7NmSRSfuwkg29SJJDEzD9bWVL1ew9NhFB6
	+2blW0As2gkB1fvzSh1Cqn8REKT5NGeUl2ZFdZC1Ts4m6Z7iVsONWxYr831qz/eOI+fSG4RTHgp
	buYs0TrJa/LghZW+kwKVbKzSiuckoNEzeVTD1ZSEF7+MmxRhlG916wzerTq+WaYR2Ua1zxg==
X-Gm-Gg: ATEYQzy3ggkpzA+YyEqM/WeMXwsjT8Ps18YY21SJOHmejuzwJSCINmOhrwwR4mAH58l
	jU3DLIVYTWYG2W99ZFnwp3Z3ZRJRsW3NI973zKGTFEdkVAxlVgUVQT76TScEIjtz/e5rHcRgWI9
	XUIAWEEbapRG8j7qa/2BG3KSGEDNK99X5xd2O7wR7ZRhw/dFlJSf4DtmgoDJ29BCJIFRmwMzxLv
	Qr3zyyY4JVYVMb3GXfYbNLs3o86qDVchG+0WurJlWBQP5LuQUd+hoccbNgwcydpsUv5Vz96/Lc2
	yDibk0vLl6k6ZIjBRLq8F20/Pmzcx28536Gge1n51KiZKbVciyunNgi7YsC7WK7rJ+4B6ncZdxs
	5OQYFesiLY27ZoivTDK4ztl/QAtLt6N3pK1aOO58crsULLyWa3CPQLr+mgHQWZNbudzf3oriZEZ
	9/9V+uO2nI8cedkjSCtUyuWoE66RcUu4tqe14=
X-Received: by 2002:a05:620a:4688:b0:8c9:e976:d20 with SMTP id af79cd13be357-8cd5af8033cmr487096485a.46.1772667948705;
        Wed, 04 Mar 2026 15:45:48 -0800 (PST)
X-Received: by 2002:a05:620a:4688:b0:8c9:e976:d20 with SMTP id af79cd13be357-8cd5af8033cmr487094185a.46.1772667948169;
        Wed, 04 Mar 2026 15:45:48 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a133201faasm14952e87.68.2026.03.04.15.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:45:47 -0800 (PST)
Date: Thu, 5 Mar 2026 01:45:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kerigan Creighton <kerigancreighton@gmail.com>
Cc: linux-wireless@vger.kernel.org, loic.poulain@oss.qualcomm.com,
        wcn36xx@lists.infradead.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] remoteproc: qcom_wcnss_iris: add support for WCN3610
Message-ID: <cptww2oiwbgwizp3rqi6wo222ahuldwebggzh5l3dyjajkrgdw@naknuuzr7f4b>
References: <20260304192409.927562-1-kerigancreighton@gmail.com>
 <20260304192409.927562-2-kerigancreighton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304192409.927562-2-kerigancreighton@gmail.com>
X-Proofpoint-ORIG-GUID: lBAi412-ELf5DGHhsXw2kfQZ4C98W5w4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE5NSBTYWx0ZWRfX/0E5JY1IHaYK
 gSHdbz35il9whZlnPbrQp/LhOEDUX0q5CLWD3nz+k+dLVhI5DeDSBg+KwaAmrNd6L9Ug3qgn9K1
 ke/vnXCwTrlp4JSSaopIK4jNCxXINpo4Pjya+8Qa4OBt6A/SJTJBsGdjh/dYgwXH0RiAhXUyRNO
 cnvGiM24jlSJkMH5EFTDbZJj1rdsi5vkLuBqXjVsdG5JvovMthKU90fbjjfElT1DuNj/VOGPHPj
 39D1fVR2yezzfnZayKvdev/PDH2PLB2bz7ki4rpdHfBqXu/gJ29ySDWWuirG0u/qFztjtc1S7IC
 WWXhWydj+rEKSswv9GqROa90oARgqv1fKA9JgzIHJCEG3z+txzKeH/P+/7I8/MSUm6lhj9lEDXL
 lgzLPGA6Gz9XpeaanjuzFM4hfJz+bFolpnpHL7ZAFwYkhW13l25hoEcm13UnRtDRguIkA4KJfBT
 m6WWbXCwLFnWj33Lnxg==
X-Authority-Analysis: v=2.4 cv=CdMFJbrl c=1 sm=1 tr=0 ts=69a8c42d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=mcKtCiK_ZK0mLSSqbOgA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: lBAi412-ELf5DGHhsXw2kfQZ4C98W5w4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_08,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040195
X-Rspamd-Queue-Id: 67E7D209184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32482-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 01:24:08PM -0600, Kerigan Creighton wrote:
> Add a qcom,wcn3610 compatible string.
> The WCN3610 shares the same register configuration as the
> WCN3620, so its configuration is being reused.
> 
> Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
> ---
>  drivers/remoteproc/qcom_wcnss_iris.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

