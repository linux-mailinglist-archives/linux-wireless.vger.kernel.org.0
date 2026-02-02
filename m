Return-Path: <linux-wireless+bounces-31448-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJQaKihrgGkd8AIAu9opvQ
	(envelope-from <linux-wireless+bounces-31448-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 10:15:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CCC9FFA
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 10:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F14E301701F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF95218AAD;
	Mon,  2 Feb 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZywOnEcT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D86d6SY6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7621FF5F
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023491; cv=none; b=VM++5bnEtB4sBrs13qklQjkBKYovUiB00THLJPlSxpm0JvJe81sUywTxa4vyhI3yJNc0ynsXXOpiPGQrNsy789KeRGt8EMtfwYEYD6/qP6QKdwa3iOX460gZO6Uow5l8Oq185/htv1nds1LzI8N+WKaEPLQkRvLCyMUBU6jMReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023491; c=relaxed/simple;
	bh=k1LmDDT6b9dMPcCONujObqtJg9jUtXvk5j6MzwKgax0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlCEwDGnbc2UsjR2iTGW/mHL0xpvgxEKcFSTzG97RSZWF6YTZpWt4vhA2TW7xaevSnfZZPz4GETBVawj+Rk2ofX8J7DhPF4IETDL/GYeox9RDmKcfwjOEeTNyhWi9CZMViygQmsWzz9sdfpdjtnBeAIknMbWwttMiXGJOW7qtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZywOnEcT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D86d6SY6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6128AKqq769243
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 09:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eN8FZFV3v73ds3IElQVUqYG0
	lD7MUuBen0ntV/aMJC4=; b=ZywOnEcTXNX8O6U/gFHyjGPAHh21W1ZYtNX5cCOl
	y1oEsmRmdpW3NVh8VWprqk+5YEuKZL4pRJlke49qeaIGFuWpOewn03uhKLAqLTRO
	bThBjLOysL+WNYO6W0y58AbgBi+gOZT8+O1naZsDgrncCCYATnD5b27Vfc2fuo0l
	hCnlQc9aU9Kr4sACuoiBmZmy2LpLF2L0RCb+XsgJun1nKHnbz/O83eI6j9m7Tk7S
	gkJWT8+aRjDNcO2kcMYKjqHGFzDWFPN7gGv9zBQo8Ax9aYUqa8C0dn/amlWore8m
	l684gd7dMNEW2aXDlY+Rj+1S1oL3KeaRqfmWvYFN7Sja0w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arecr5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 09:11:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a2ef071dso1067742785a.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 01:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770023488; x=1770628288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eN8FZFV3v73ds3IElQVUqYG0lD7MUuBen0ntV/aMJC4=;
        b=D86d6SY6J9/2WbEo4kErvxUvzp/oB39L9NcesfM+vDNrdSOMdgB8sDAPMLAQyXwibK
         oItkPV0tjv07adhY8gL8HH2i6bsLCkpsMT5/MZUOe6P+YbgvLxb2TRC2GPDfSVEZPlV5
         6NclwslPBsJIrw7N5wEpB7WEIkA7CR/C+gurFo20NwwsMrLTqJ+IMmDpKX97x+mTrV6Y
         XzrVuJlVMByIHk9/VbDA1y4NOZ9Oz9saU/g+/koeVbKDiSV1vKF4gIm2pMthc4PyxiB1
         3kZEi7eGIW32z8lOAvEhC7cFafqc/HANT+gCgbN9TEX7qRvlr6ZwtQHQraE1lM2VjXLs
         TXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770023488; x=1770628288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eN8FZFV3v73ds3IElQVUqYG0lD7MUuBen0ntV/aMJC4=;
        b=YmSO7njkZS27bI8ABRisZItqnVlBiDoU+zSfMEhZQV6KRJSvryD5VtBAHhcci3tcLZ
         vgLztuUMIec2A+XQH2IxMRuosPtvsLOuz2v91Crsn/ZdqLf0dx9G8jopE5F2tfsQAWWa
         fXopy+BLfZJrLMRDR3uUA3BDBqH8hjW1o2236OoHxqiRH6Yhb9FciMUTBqy79jXpK86m
         L4oqTIdIdI5X0Fn01G3Rv+ZI0sBGHKWl7fnYFnIXGQ/OSOlouCDH5rwNr0x1ZGy0C+0V
         y/+aip5N+AL7W4iYYfv3BS/F7SMipANIc0O8UWFaHaBJJSpenoYPhp7aRKwEkP8OhlRx
         HoZA==
X-Forwarded-Encrypted: i=1; AJvYcCUmItzs3SXB+Qbu/l+vZbAiz0yYZ60EWosTbYE26Gl7HWeqMsP0qKcnSq+p/ilZ2POkqrfYnT8L6EZCH3WiPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZE6ZtipLgc2ilkhETG/tngr35HPNLbshInLtScjho30GgID5
	SsleY5dIVol4ToCDCfoQk+QwhzjPUmV8zchr6TXi9i+FqrIEF8IrXfXiIsFqHE/ZVx2UTISYP0y
	PB5oZINVycs8yqLx4hWNIRvT0d5EoqoUXq8AflwMTv/VAtcxvdCKafr9qxh6NZlcjtNbaoQ==
X-Gm-Gg: AZuq6aL38jhYFUwi37Bm2ksMeLkMjLJh78wTExl7SwHLjf61mPuDtn/+tVc2HYaVJTe
	TNmIK+9OcpXpLelwkD3K/6yZW4qL5djPkWuR3+atqDppukFhVce/EBfIOj1yfeDmFheq976gRn9
	U9V3VW0S3GIQZSXUmAJCZ9+Q3d+zcKSZDzc1vgoKSwHi+dEFJKM4jjmXhsFVRDYqMcgelRe49b0
	lFGaK73yQ0Xjr/KcNqBQDaj6WmgUfZbncZT9G5AeNaVUVbiRRQo9XCVTy2HQ/WMSX99mNS8byun
	0UQHqou0EmM4BBg4CD3dr9MZ4yVonJMvFpfD3Sk31U0fgU8MAqlC7RQt8JrUZgaF+TI4ULKDBrl
	ufJ12+dtzA90el2d0Ylev2d0seIoDpU6nEhR9b3fr8RR9dHvnL/n66/Bw9JcfsM/JhHQrqbvWU9
	lgCXghSmsfuPJXzhJiOO4LyEY=
X-Received: by 2002:a05:620a:2197:b0:8c9:f996:8203 with SMTP id af79cd13be357-8c9f9968266mr808623185a.13.1770023487618;
        Mon, 02 Feb 2026 01:11:27 -0800 (PST)
X-Received: by 2002:a05:620a:2197:b0:8c9:f996:8203 with SMTP id af79cd13be357-8c9f9968266mr808622585a.13.1770023487206;
        Mon, 02 Feb 2026 01:11:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e07481c22sm3401897e87.10.2026.02.02.01.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 01:11:26 -0800 (PST)
Date: Mon, 2 Feb 2026 11:11:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260130
Message-ID: <cwzz5ndtvkr3dqn5xr4erfdhi2pb7xjijcu3c23pdpfgnmlyvd@nuvbtkakxile>
References: <ecf412bd-7bd3-42ed-bea4-d7aa837ddcae@oss.qualcomm.com>
 <34lnv35rbicqk6duyqhhidunulcipttsj6ryvzw6embgablnpl@gh3wtsknmcma>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34lnv35rbicqk6duyqhhidunulcipttsj6ryvzw6embgablnpl@gh3wtsknmcma>
X-Authority-Analysis: v=2.4 cv=NNfYOk6g c=1 sm=1 tr=0 ts=69806a41 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=2b7Me9ADDCpIAGoeTPcA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: jc_3MwXcgRm1crQfMbuWcpheI18n3rxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA3OSBTYWx0ZWRfXyPjF7Sm941J+
 SPG/F2ldgxVQZxKIthGzseJaSEaGXoY6gnn8oJZPBVQxtnOBzbYTnI15mjLiozMO9UQmq11+VGL
 hXqksFr2Eic0xUDCcQhpHOjU4qHdZBHqyQz3GcycyJjg6OtJ7ovJ5ok4MLZfhaJN5TL7wujkxiG
 swN9yqf6vDhlEH+FDMIF8x9+d50sx064kgm32FT2HgpN1KD4dMbdSCqduonR6BRHgjf3OqltlSX
 QdJOixrHbYF95XATHn3j4TUIXhCe+3q8IHfY035p6WKY1eMG+Z9mQ5LGYEZuupD00Mzn+T+sECz
 Jx1r/dblWiN1Gs4/vg8b7ja34ihDyj+u0pG2z9dgmRtJBp1XTs15+Ua4a/UOp4lGWYWDUcZqj7b
 Ce7NMIX/691r0OoMTpfzhwVBurarY+THUCODBGw+Q5X9eeqDBH7KGgC4HfkWHZngU/eOScqpaF9
 UTbboYg14ERuNSuU3Rw==
X-Proofpoint-ORIG-GUID: jc_3MwXcgRm1crQfMbuWcpheI18n3rxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020079
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
	TAGGED_FROM(0.00)[bounces-31448-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B8CCC9FFA
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 08:39:57AM +0200, Dmitry Baryshkov wrote:
> On Fri, Jan 30, 2026 at 12:29:48PM -0800, Jeff Johnson wrote:
> > Hi,
> > Here's a new pull request for ath10k, ath11k and ath12k.
> > 
> > For ath12k:
> > 
> > Update firmware for QCN9274/hw2.0.
> > 
> > Update board file for WCN7850/hw2.0 to support:
> > bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8001,qmi-chip-id=2,qmi-board-id=255
> > bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8004,qmi-chip-id=2,qmi-board-id=255
> 
> These two were not a part of the previous upload, but... They again have
> board-id of 255 (unprogrammed). Why is there no calibration variant?

Our engineers clarified that for the PCIe cards with the programmed
subsystem-vendor and device we don't need calibration variant even if
board-id is 255.

Merged and pushed out: https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/899

> 
> > 
> > 
> > Please let me know if there are any problems.
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

