Return-Path: <linux-wireless+bounces-33221-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF5BFz1ltGngnAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33221-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 20:27:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D4828949F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 20:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77F0A301AFEB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688E3DD507;
	Fri, 13 Mar 2026 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vq8XhnZp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hDNSsipM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B4399341
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430069; cv=none; b=NCe+xuiZfz9K8pOQBO2foyPC8VRK7NeYFtuS3jqqpS+3L72wJ9hzkStPD6cXMVyWE3y2R+gKPYmlLZZiQ8RiIyKzZxE1O6JTil0adlyHFhFT7SvwUyXHiK4NU1gxyew4gKEbudoM/Ev35WONUoHQakbuFdgN+oZIQlnioC8fYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430069; c=relaxed/simple;
	bh=rKz6zJlCR7ITF7m2iyI0w+PyLtJ5s+0Gd/J2y9arA+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrmWLrFuJCaFR9NnWo39cqlP2eGd2RYuKWXmeQX018goF3r0vAT9tumaMrrd+zeH2y3q/4nc5b+VfW41YofaUNnyhXWt42TUyPt8u0+KXdXJPVg+LGlfpVvqqz8Vf6x++FI81ANhnKfbl3TD98r3XNvYaAB0v+VlQOYfU40R9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vq8XhnZp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hDNSsipM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DCkX9X4140672
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 19:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qtj/UJdhKICdBz0n8e3V90EO
	SN2LnU2hBaq2dvS9HzQ=; b=Vq8XhnZpMXKdAHtVII0VRF42/U7t960S2JjaTdsD
	1fuSwNpQSpSbxbNqBqwZKntiSvOcWPVusf02K+BF2mohlIdyowKn8NJuA1yU5TML
	zY8yONJLJE88+eog2KyvqntOLRqd3D0skersybpNkfDWpXQ8FBX2uki+rm6WaZWC
	JS6EN3E77TgF+GJjW+zlrjDkR7jBy3YOxuyYgtn3aFi+EIiuBSYXdnpbwaOZU2L6
	hAdRsFRp/ODK/Vn00F4R55dlSDEtK/WBV5HBNWD0Jqo3BiBbE7fG2bayZhatSaQr
	ty70Ze554sUP4km/oXEnzdALhsMZgHtw9hpfotTMS/jqEg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn2ayfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 19:27:47 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94acebd8d64so4153722241.1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773430067; x=1774034867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtj/UJdhKICdBz0n8e3V90EOSN2LnU2hBaq2dvS9HzQ=;
        b=hDNSsipMQ7HgnLHA14lDlj9ag12/czGUb+Yr0nRzlESpfQxi4qyb0spSd7sMP2swl7
         MSQwMV/V01ZlM1WviYt1SoMbbp0LrxtryBSPzrMWHuV6xmXa3x6UCmnSZMPTqXxPdqi5
         riBqcCI/v9qm4n5KOZq+RzMdcScNS/t6ZmPFzSP6Qy3CfaCNyr4UhZ8JtVUjWJDKrZ/I
         hIxgfcsbqXTjIT6A8O8nvFTTI+gR0kNOao3wAhcHjsvl5ULOx5xYF7nKN9Rfq8DeFD3m
         Ji5wpQk/tgqnsY/gfPCLMJH7SkGgLjWuJ8wnMsbwBDiq62OAFMJmGn4tHdZ7B/yj6ozk
         KqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430067; x=1774034867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtj/UJdhKICdBz0n8e3V90EOSN2LnU2hBaq2dvS9HzQ=;
        b=U8gEBeWgpE7zEMdiJO6jtb6JPvqnVPvSklzJ+yiwD5Tzoy7D3+nuxldodU29PDED7E
         wmlY8ukb8lbTgYrHgZqvPFid4B/DmZ5waP5GGwrFvPfleSYRkuCEKg3d8IntZb/ipwn7
         764hroRd2warU98xkb8owL4m36QBAqjuLyW7BkTH/SgLm9FyZ2vZ99ksZC0/vCYfPfVk
         7AolbY7UW6Io7B14aQW95qRA0sWZ49cjEFSJGiSZK0PwTzTg7fPCz1dyx8r/HirMWQg1
         ZM9Fo77lvI493KNErvDwsqGJKsIQG+cq0RfVCj1uNFo+oUXYdq0RiKrHY6H8tb2/eyQ2
         MqGA==
X-Forwarded-Encrypted: i=1; AJvYcCVlASsLycEzC7Yo37eiQGbbnZV4I/X06fY7BByLXd2HUiJIS429XeJZFxuueSu7JRmMeSJuTl4+jhdvxaYHBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3QUxUjIZpFvKzEvfo+LDDuULuiF2Ny1TIr9u+c0MBJs+rSAA
	Q2Vbviudnpa4M/U9ov77IzglW6qkW+tmkf3pStJZgKVF/TPfoI9SNH6cyMBhz7C9Sn83xuADVK8
	MrvOPSxqp9QVw0ScrXI+XR4h2q5phbaQX4tLYcPbbWTicQFOENc+0Ks2YGq3NUMAH2Nqy3A==
X-Gm-Gg: ATEYQzw3apgFTjg4MaWp69pAvfACjKkZhRHfJmQmtkqwe/jG785yqgkHWDDAHYV7TRL
	G3GN2aW6neIZYyS3rQpChnb2tak0TuJ0nsoTX+uSv4DI57sPkmRsy35esI1WRdbzFLVXSbW6Vp8
	wCuJ+//OhnfaPP59+/J8jGbyT5SLoo5uk1k0OB5JNBym1ue1Fy81MJ5B1mNmbkGHLQN7M9aw73y
	E3TzAFbvZUa+ltAJPHkiwNCGM1jwSgvkkB7LnNONyqnf+foynsHRhMbGAfsIqWa+vFu27nQi1fe
	q3ZIdLb1VS80vPFZeBNEmLzV1yJ98naFYe4Q7boxmyntZsoQYJPceIKh15GXkPWo06iesCq/BMv
	5cMx53IcEiWPSv0Tj06FCnmHH8hkVJIUb1agWq8A4deVv7eN0lFIgCbzvcSSW1qlW4M18dy83u5
	kKVsSn2lOJpga+bqxen7kIHNHdjvGYkTNuVi8=
X-Received: by 2002:a05:6102:304d:b0:5df:8f4:61e6 with SMTP id ada2fe7eead31-6020e59d4f6mr1853571137.32.1773430066949;
        Fri, 13 Mar 2026 12:27:46 -0700 (PDT)
X-Received: by 2002:a05:6102:304d:b0:5df:8f4:61e6 with SMTP id ada2fe7eead31-6020e59d4f6mr1853552137.32.1773430066362;
        Fri, 13 Mar 2026 12:27:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67db290esm16299201fa.17.2026.03.13.12.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:27:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 21:27:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kerigan Creighton <kerigancreighton@gmail.com>,
        linux-wireless@vger.kernel.org, loic.poulain@oss.qualcomm.com,
        wcn36xx@lists.infradead.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] remoteproc: qcom_wcnss_iris: add support for
 WCN3610
Message-ID: <2pyi6yavgbf47amofaw44znotleankmmou2u7vzx2v2xc4hpye@6f4fcdk3hebn>
References: <20260305003253.1022386-1-kerigancreighton@gmail.com>
 <20260305003253.1022386-3-kerigancreighton@gmail.com>
 <20260305-crouching-sceptical-spoonbill-fe75fb@quoll>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-crouching-sceptical-spoonbill-fe75fb@quoll>
X-Proofpoint-ORIG-GUID: eSoCwmxdi6t6O4mLm2RAPd1ii2Mhprjb
X-Proofpoint-GUID: eSoCwmxdi6t6O4mLm2RAPd1ii2Mhprjb
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b46534 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=D8mGTEjQazq80tWk8dIA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NSBTYWx0ZWRfX9Kn9yVmA6QHQ
 1+HacGYBMQ1LKIOOr0JKYXF16p8Y26NqX4FA+voH8zqXwyUguSTj2Dhl+woUjfYS/7Z/dzxZc02
 NONPv1V1uZGR4H0C4txdewINESrvtClXEDxy+Dp5G6wzyqib1E9rPoflKeN8WEEjrXJbPZq2T//
 Yk01VCRNAWfFZkysiiTO6hOxVa0dOCV+7F1Vw7N99u8QxY+T4gxyTn0h6CBqZVq+p/hg4p3msji
 MmiyYlmUl+hIj+7ThPKbEYZzxEF3OEJdZOozzP4/DBmhl5qXXAczZFukMVBUwYendgOBKyMhrT5
 H026V4XjrlIKkQwy0+MXFKWpsawSHQl9kn00tPNFRpt2UfmkghZFzp3r38sQnBonmmMTz+L4p9J
 RRO4FIIUjxZwvJdAYJvna8y2oNiCXET5YfYQyD3l1d71lI5zgDqUxig7JBpFUYU6iqsifjEFRMZ
 iGLATKPJmFkVUDN2/xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130155
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33221-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oss.qualcomm.com,lists.infradead.org,kernel.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 54D4828949F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 09:06:30AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Mar 04, 2026 at 06:32:52PM -0600, Kerigan Creighton wrote:
> > Add a qcom,wcn3610 compatible string.
> > The WCN3610 shares the same register configuration as the
> > WCN3620, so its configuration is being reused.
> > 
> > Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > Changes in v2:
> >  - Move remoteproc compatible string addition to the middle of 
> >    the patch set.
> >  - Add Reviewed-by Dmitry (thanks!)
> > ---
> >  drivers/remoteproc/qcom_wcnss_iris.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
> > index 2b89b4db6c..e58b59355f 100644
> > --- a/drivers/remoteproc/qcom_wcnss_iris.c
> > +++ b/drivers/remoteproc/qcom_wcnss_iris.c
> > @@ -95,6 +95,7 @@ void qcom_iris_disable(struct qcom_iris *iris)
> >  }
> >  
> >  static const struct of_device_id iris_of_match[] = {
> > +	{ .compatible = "qcom,wcn3610", .data = &wcn3620_data },
> 
> So compatible with wcn3620? Why are you adding it in such case? Drop the
> change and express compatibility or explain lack of it in the bindings
> patch.

I'd say, keep the compatible. It's used in the next patch. But yes, it
might need some epxlanation.

> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

