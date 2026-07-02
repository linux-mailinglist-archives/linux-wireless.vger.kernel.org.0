Return-Path: <linux-wireless+bounces-38525-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ocCQEvVeRmrjRwsAu9opvQ
	(envelope-from <linux-wireless+bounces-38525-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:52:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 946856F7EEC
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mJBKst+O;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=enjjBuih;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38525-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38525-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 556AC31892BC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3734949E3;
	Thu,  2 Jul 2026 12:42:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5A480979
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 12:42:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996168; cv=none; b=KCC/n8onZSt7pSqNaFFdzcq8SD3SEs8/t5pP//vd1+fZ+NruSFQtvBf3MUOgEaQFjoyil3EbmPQt68rGAbBZGarPTz+dji4rCujbm7Z7GFOZ00pWRaC+1IMBjIX6UlGla1gfaoSyf/6gmFqc4x7FXrfbN8O+gB9meGMQT4JOS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996168; c=relaxed/simple;
	bh=4H/dH38mcKnwWsTsUFr9jJv0sAS5+eL2wl2jZ00FV80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIXIYZMdk37AkrrXx1LC0kN6F1O/zRDpUD3/yBVY1z8coL2xKGtHzRm6glmZOzjiJ3DFK5jgc70E+lYOC3TOmqTzWT3pRONuWF6NF7ZtLuR2p3THDaSvNXy+9CBZThyCgz2K0e4ltANEXRqNsJ7narh/R9es7HuN/0tlLT6UwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJBKst+O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=enjjBuih; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AmYsb3591674
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aB0/3lyXHC3ZlM5SwFzi5j4g
	uLDgZlNjnzid/utDH7E=; b=mJBKst+OMR5KcMFc2JKBQMbAfP7KoWxb55hHtBGS
	9g2VKZE7rU64T2P3OMn/WcyPooBtMab7l4/48RTI+7lOI4lhzZ7ECd/ugPaZKOC1
	KltM6a8/aXg6Y3qUy2fbRuTY7NmA+Ce4P+geAowOWAcMMyyElnk4Txe04vN7Jfbl
	SttmubuweSUSx2KUWEGFBgUNLEnsnPFrZsOhy+QHhKXikPw/yr+HtuRlKWlIuAdH
	fq9OGxYuObQwpqbnNl2fVrJWuZYbow/0JGBJM9O3C6sc4ILs2ceqCSVH10TGdr0f
	0Ri83OqJqKex31j98t19W1sc2/gber6r0clidS14sANBqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9rcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 12:42:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e4f946461so211033285a.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782996165; x=1783600965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aB0/3lyXHC3ZlM5SwFzi5j4guLDgZlNjnzid/utDH7E=;
        b=enjjBuihAiIkW/IwVUSoi9PXVjIS93QZXlxMRWtIBJrNbaLLnrCJfKT9xnxBlDI0sp
         yUdD1MSaAFH4yernbzWCljCG2blhbIguo/7P5HAoCqjoirAskdPHz2ZE1SxmTMKHjiVl
         zXT58zUsS29qVty0tyNCsP+HozZt6jBgIZSvaaLElVAREKUwtGsKIWvDu/bujHf7aioJ
         OyW2xuNO0sEewo5qCbnLh+waypIHDC1GmQIG8wHtdtLtAChuM2xWjefIuvmEj1lP3Roq
         ShiDFWQvXC0NGAUmhl8Gpn3nmj25WkxDgC3Hmm3T7cB494GRDs3nyKJCIfHKA3lO63TK
         R0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782996165; x=1783600965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB0/3lyXHC3ZlM5SwFzi5j4guLDgZlNjnzid/utDH7E=;
        b=YgO6wr5WfIVfREak05t/BUmUWbrM+4rElkk6fnWMuQE/0hKx3RtwT2UeeP1mIEkzT4
         eHiNO+R1A+3p3QCwvv5ZzWxQKbbC62StcUZiZZXWlD32zd4cxiZLnwxOJBaf75FcTU6K
         rJQ3GgwmiL9E9zwYIZCeuYWrq6gZbydVDVoD6bwpCeGiTx62MRA/Ex4OnLmvDpEMkaii
         /T+ZvlOEq/gTj7Num42oMAzsTGmFLZk7x5HcP0Au+7nAM7lYvm7b7XmsWN8JT/dkLgJl
         8W0L3Rnudjqt3NWYeeuB7t3erddycWdifgfvqf0uVYNSbhzYJzxKSsRWEaqFnewsItzf
         7K8A==
X-Forwarded-Encrypted: i=1; AFNElJ9i6OtruB+fONI0BtrnpSKETfyQIbXCCmgpCvczMO9eMcm5d06VTrXYqmwvtViaIe4Y48vSCm5fjKs8LBv+PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHY3xnBmWf5b06aMZdxkmWUTGY0ZvtQ4PGnK432/wep0tcQ8D
	GvCxnWZMjGP6TtqlpXNmDuva3Si3oZJTbRivDGGi3WfNkMgejdQ4VJHpLF8zQNFPHCb1wQXWEms
	U6x4oYurmlV73ffuXvJVByz676A6NoC9ZbGH5ViwJuYHL9F1IDNCtEzVn2v3lSDOZ7qgVEQ==
X-Gm-Gg: AfdE7cmhEyF+m9vBlclxXlL5L4RhOk519MPjnKEVrii2XGrSdIW7EEUeQ2gC5EJHnTi
	l8dRHiZM8QBtcHt8UgbWQ2/0NjTQcoMt9qZO+Ke+ZsHwySJKxmjNRwWy9zvnzL+QzoJ/14vKQ4D
	PMAhfc+fmveHyKcXY8QVUdbk1Sp//EiIgXivQMSn1160hKc+wazkWoCaKgPLNUgNwClsfunlROo
	24ZLeAB0nW/MoSQKmqwzTTtTCI75Lmph3l8zk3JL71NEJ5UfDxMd+0MBHwoD/ULYnCbifcD/P28
	cnELJjb9M3Sy5JoDN7nwuGhYJlAEZaqD67fdp8GEXKitxevV5DC6+aU1bJsfep0O9GsisxXeqFv
	79I65lCYBXUUclQ6H+oo4Fv8zJ9QPwG8hPUX2aMCdnpA8IkXtEg1vrDyGinoYGytwk1Oq6NkD6Y
	DbJNJGydLRk27rRRLRVAQ8cAJl
X-Received: by 2002:a05:620a:a18f:20b0:92e:7ba3:73e2 with SMTP id af79cd13be357-92e7ba37697mr501589985a.74.1782996165228;
        Thu, 02 Jul 2026 05:42:45 -0700 (PDT)
X-Received: by 2002:a05:620a:a18f:20b0:92e:7ba3:73e2 with SMTP id af79cd13be357-92e7ba37697mr501587685a.74.1782996164732;
        Thu, 02 Jul 2026 05:42:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fe9e91sm5484791fa.34.2026.07.02.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:42:43 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:42:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "Dreyfuss, Haim" <haim.dreyfuss@intel.com>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        Josh Boyer <jwboyer@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: pull request: iwlwifi firmware update 2026-07-02
Message-ID: <uubxec2mrfo3xbjl6arfsyrqagvekwx2rgluyij6twfzyy2sry@ucjmqa3jpurz>
References: <DS0PR11MB788099813ABEFABD32A85E36A3F52@DS0PR11MB7880.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB788099813ABEFABD32A85E36A3F52@DS0PR11MB7880.namprd11.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX6THgCevv0VT3
 aBjpQ+DinCV9hXpmnp7fCD33sefe0okH2XqH9gjlz+bST3/qC7LK9IZFnWmu6wD0uOXTw8mequr
 Ylu2MLMwz0e0kDIHLPxjPlQmKe21CiCmJMg/FLnMfo3/4xkQ8GxnVueEKh1Mb3LB7ZWhcuq0u7J
 tU7dB2VRlzC7/r7IJ96x74RWzr2MztU5yyWCTjpWIgPOxGbc80os2zRPcrfGbB+z3mdUaXCA2HD
 0XpGVrUS+KENk/AHE7X1yyZZb947lWJY7ALCxpxrN0JVG/I7MQVzwZW2apIUjZlago6vb3Dp+li
 mV/kguEWs2MBEPsFbHKLYuKs3MFB2ILom+bADt3D+8xQpN6d+9K74AaDWFHME90c6zzN3SXSpWK
 3dVL5Qbd3AQRHYaLnJyYpGtegzJxmKefpSuBTVK/W/zNaVo9Ojdxx6oTu1UYjTbr+x9H2UCgqqQ
 d6pbIK+ZuG4sP7NNHsw==
X-Proofpoint-ORIG-GUID: _1DOzidMSc1QW7fZXwX-keDboea8ikl1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX5bsOdASb9xup
 DTWtxOmhDilb4ZonUv6hJz+0CmdUnthkAl5qsuNPFVwFn94nhEhyWcLz/Q6wWam+fTcT2Ej3U04
 gnUosoKaciHAzWINhLcVW1OnnaikIFY=
X-Proofpoint-GUID: _1DOzidMSc1QW7fZXwX-keDboea8ikl1
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a465cc6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=pOhtE3V0Tdau712M8d4A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020133
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38525-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:linux-firmware@kernel.org,m:haim.dreyfuss@intel.com,m:vicamo.yang@canonical.com,m:kyle@infradead.org,m:ben@decadent.org.uk,m:jwboyer@kernel.org,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 946856F7EEC

On Thu, Jul 02, 2026 at 12:29:13PM +0000, Korenblit, Miriam Rachel wrote:
> Hi,
> 
> This contains the firmware of core24.60 (106) for all supported devices.
> 
> Please pull or let me know if there are any issues.

Thanks, merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1132

> 
> Thanks,
> Miri
> ---

-- 
With best wishes
Dmitry

