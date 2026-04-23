Return-Path: <linux-wireless+bounces-35248-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cABNGoVe6mksygIAu9opvQ
	(envelope-from <linux-wireless+bounces-35248-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:01:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C21455D75
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4706C300B9F1
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73BB3AA1B5;
	Thu, 23 Apr 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFnQai6R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OSmm3BcP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716736D4F1
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967261; cv=none; b=YEyhM/rCG34xhdjKl6YgtC/sCXrnf7ze9FKFVnfhimpGGixlJoJ5cB3zc7qGwqW3ajQzdgXT+14qJTbXA0DE0nOmHS5CGdGx8HtSaht9XkvWkRJUhnAurv9JiKTwr41uqBz5SeWW0wxSy0MM6qhsX0RxAs4lNR87GzXbUr3ynCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967261; c=relaxed/simple;
	bh=fbYV82ycjpLIqxembbfEP1ptR7mSUhPqJMs5tOqUeHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HNzibLzIFLLsggPAjaVFcUWZzUb6LZrzA99Exe784cpqDnSW4osYiB6tSC0b5CqPCCcXiIQlMWbA7szbmDtExiYu1Cqz5aK0P8Eax49hReimAqcogRdKwuQ2YyM0z8fgHND4UG4YkcnmgI3q7rDXyj2ZDcE/AQvQ33Onb7lyHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFnQai6R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OSmm3BcP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NHftNl1532371
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+MAGwJytPEBGybgc2cfrWBTxlewcqZOcmpxm/HgRFBA=; b=TFnQai6RyrOqnnuP
	P5OGshjc7nJrC5CxCBdEEm1FJMJ4fAejsoohhyBOgXH0U0juEaW3GVmBOm8AlWow
	T10wZgD25EJyWsMEDIhLc8M8FKdwrxc7JNhmphuQtrOq/jRjHk5syUf3+IrzRVHS
	DbWptc+eLZ+7D4gOCBG0j74mSZxdBHWZSNGswLZQJUEgOuVPuEtBUuHEyppO0T5A
	cUWohbCR2VaxEgI8EtSAhNH2/rjxtBNEiFK7usR0r0WFfo1GEk3bbxHsBljX18ME
	1OcLPNyAlrVijz2o9eSo1ubfRFcIdoqFj463BliYD8IzSL4mzX/n342+2WsPSxnW
	ddo3Ww==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr26g3w1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:00:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2e60238adb1so14374585eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776967258; x=1777572058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MAGwJytPEBGybgc2cfrWBTxlewcqZOcmpxm/HgRFBA=;
        b=OSmm3BcPGc4piQ/dzbXrPI+lxXXRZiCvM4rTRKgyZIFgl4cONvuV9VIOg+NeIT83b3
         hpIPPdovoMTG+DlHLgxfFbmuNJTEIXAwnKz1f38NNotSjqKbePPU+XgJEyPuFJ5oPRe6
         Hf1KnkjvwmjE0JfTXFtYcKRRgAiH+jrWwtoLqwF5WGslRRn9507BC0pBr1d7XZ9aQ4t2
         irkT4TZCdkrlCI5YZpLMohzhyXhY8HYOttKvXqrbjTfhy9lAHRwSGPRCH0EhCVHs+DfB
         10jB7zUhIrJ8lJQ1T3yt0xiip+ZIvG+EB1U0mafiz+rKsDRVeJ5lGQnDgoJIxxkPB7YW
         KRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967258; x=1777572058;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+MAGwJytPEBGybgc2cfrWBTxlewcqZOcmpxm/HgRFBA=;
        b=is+PSduK8qalKOb4BzpZg8BV0JXYjHLcbgm7tdN+lBQzbp1fSQyC135GY0lLKYwEBX
         LNC27dohQ8MSd8h7+bhisI6Vc73XCnzJwujvv0ASrgVzf/vbqqnHlBvfyX2IQuQMtfXj
         eqbU+zd14j2Mo3GechWLL2AEqUMsy7AZ0m6+6OWUF/tmNvLzr2NJ+f+UpjqNMQ32XqDp
         QPwlq5HNQmLUltpIvmHq2PyUyBYztCZ53Dxy1E7bBacbCaLLKGU99vXSZoEFaacAmNPi
         WukafXR6PCejpLijO4PMzDxWLV8A5tNvdruC2g7I22jO/jHy/XYF9T7SnNTP5zVOPnAx
         q3EQ==
X-Gm-Message-State: AOJu0Yyr0VjLkJj2E4PZr6ChjEsqRSxzS/RrcaEZ7gqPiNgAqWtlDxSw
	ftqUT+d6qmfuIftB3DXdiNwWGFcK4M1K2fopqb6ICMGnoBt3EUN0Ub0J79/fwnRgv+pwX2HXQ0e
	R7tSI4x8edjTAf3tV3amBtGTDbEH5BmXC5WEWr4KD5mC7JCFfX0UF5DKy7OZYLleNb073AAVG0O
	wDSA==
X-Gm-Gg: AeBDies8OLBGV90/pTRx+vuaOdSCDskWGB0r30bEtj/E+2NYeNdrueHX3gdiF7KOR0Z
	CAXqfasXWCcjR+K79vQ8/+1GU0YE1ZswmQlONQkc5bYpE4eGklqAsVgAK+3c54UTevBe0nUF52r
	6E6Fc2zdEzx7nDO4gbpTdOzQfKi/xglrZMXTQQ+AO5y83yAy/C7SBK69vglJl/y1kEsCWmaCMxf
	F0Y+LKES6cFOiKKIlEPq8CDUl2ttNssrk72oFkfMtZ33pYdLP5yCue74CiJSswxAvHwSu22Msi6
	tCs0Nn3ppxdaNJcOqax9lXpla3NpqzGe3KiHojX5l4CBWi7SpDAp5FcpwTwGw5RccvZTlq2mmtq
	FcsHWA6ZqyYXxataCsiQ319zu07ScZ1vhIxY3uf1XXp2xMJiBh2/s6WcYH+LzMlxvsMTLaXpJP+
	O/2UQl1x3rUvE=
X-Received: by 2002:a05:7301:4185:b0:2d9:fa9c:87a9 with SMTP id 5a478bee46e88-2e464ea79b5mr16138613eec.5.1776967257864;
        Thu, 23 Apr 2026 11:00:57 -0700 (PDT)
X-Received: by 2002:a05:7301:4185:b0:2d9:fa9c:87a9 with SMTP id 5a478bee46e88-2e464ea79b5mr16138577eec.5.1776967257076;
        Thu, 23 Apr 2026 11:00:57 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm27867887eec.2.2026.04.23.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:00:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260410071300.2323603-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260410071300.2323603-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix OF node refcount imbalance
 in WSI graph traversal
Message-Id: <177696725615.2493545.11975303752151974707.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 11:00:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: hhlXx8F2d0zZcgZ_YLKVfDwuoj2adPfr
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=69ea5e5b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=EQhLecVpxEp8dAYONcgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: hhlXx8F2d0zZcgZ_YLKVfDwuoj2adPfr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3NSBTYWx0ZWRfX6IXIv3DA6EhH
 F4hdb6jKMq+z4UGetUu84OaPd5uMupocBlnEzDCPlkdVcQobsObR0OcP9okkqVoIlnjSQ5HzN8I
 hStU+5F1If/gVaRaE4NM0rI5xMXGsIqzcnJ4cwT1B4l1MpXqWUAeKq62gLn/8ilXsDeADwpDpT7
 ZC+O0IxEkAbMCV6X1AYhMmTPgRV66aPVLFYzKX1h29K9xY6S/14rSdO4KZ7mKPDDZRydupvWy0Z
 lieOcglFajOi4gY+MYH7y+J9JY3GXtksm3bmRtGkAIDnoEs8kFSu+8N7tNP0JQIFMjMbTzIUlX9
 GsVB6fFJbin3CWrFi10POZdHX5agJet0NJV3sgTrFjqgTnEecLmgqJdHl6bHdQMc+9ZLgnCaN+o
 tGWitQONZQrmaZxdtGe/E30whfJ3M92PdtC6/Ubui32y4tlGbD3MjdgHtCy1lyKK4PaaUAy2Zk4
 vniX/kE/IJWFHAq0/GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230175
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35248-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 16C21455D75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 10 Apr 2026 12:43:00 +0530, Aaradhana Sahu wrote:
> ath12k_core_get_wsi_info() traverses the WSI (Wired Serial Interface)
> device graph starting from dev->of_node. The current code uses
> dev->of_node directly as the local traversal pointer and calls
> of_node_put() on error.
> 
> Since the driver does not own a reference to dev->of_node, dropping it
> during traversal results in the following OF refcount underflow:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix OF node refcount imbalance in WSI graph traversal
      commit: f3ba9e05cc7b65f41f58bb4808f6c3a8f7894bb1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


