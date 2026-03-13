Return-Path: <linux-wireless+bounces-33183-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E5VHfixs2lYZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33183-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:43:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 732BA27E44D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E12883029441
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF51E7C18;
	Fri, 13 Mar 2026 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGuTiW7o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foyah6G1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65F26299
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383138; cv=none; b=nb7YTyopeIyA6Ds85tyIcNCCrvCaZyiW40OkTXMUzYkABSo9Cmhg0YcFc4G+HgEMLRRyn5XYeLGyqVSUsANjMZ+WciJc/x1yuSZD/EJOJAg2CJw77Osm9pwXq25bndhoier8ND4TqGx7RDcvllkVP45p+3Un8+RfKCrK7cFJ+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383138; c=relaxed/simple;
	bh=itOaWhHAg9tceJ2Q/l6UsX1jJCe7412V+zc8gMLT3Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfwtPT9SIidZcEH83TMtvY055t2mOxNDGH6Lzsb2joR9LwOKzmqfpe8sExym5p3GwOnTjDyHoeHjVGSd8+n5Xl+e8TzEffOU/5BGdck2xlXvqScvW3HetG/bNEFWNbsPXEVc41w6JGmS5tkdM528SjvjiGhXIaidAuEryekLQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JGuTiW7o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=foyah6G1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tYq43229726
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TXrdpy/WIHE2X9P4Q9q/hAK5
	sgWHGc6Eec29rzkb/Q4=; b=JGuTiW7oyEus9gB2vM/Q29qihLHd+FAGe8PrXJA8
	fkZWJuX4MLEJkbxqiJOD8cdan2VsPx+t9/defMvDRePBWW9Qix2D+qwxcfBPII0H
	wAKXqe+pLD4Ma2W5SP7pdRqmh3hsBSXYVCTYAtO4E1HURQjjMvs7hFS5JPTNu7ot
	FD8VWnk20H6rpG0Eodu0vehkiA50jQPEfe5duCWuYBFIYm45Rmut7ofJqd/pTfYW
	WfY6p4+CjRx8aCKjC6ZlvxcH3DIpd6fZmLvV1zMqQICcNyIAZFqYcnxXEz0R/mHE
	2iDJJb46xwWtWnTsoRfV8S4vaziNJrkqyjZF+mkAHP6rnQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7gtn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 06:25:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7fec8d44so1229171385a.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773383135; x=1773987935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXrdpy/WIHE2X9P4Q9q/hAK5sgWHGc6Eec29rzkb/Q4=;
        b=foyah6G113yiH6gNwbJlusp506R+nMKazy+QbnFN9PMADgoHruYuxPxsSI85pHTq1O
         p5qU7JwI+FigA5B+uG9j+3ukmZmGSmkCPRVobYRjBO5UUt3fVsjhYdOld/KvGhhulU1J
         nYtde6Qwv4pSN7UlEX7FBYPRvP46r3nuV1NRI7za+FziSSnzsbp/TZfnWpTA6Kz4ngOe
         lI3aP8xcXqCIDXUg/3HrIoOAM34Ht3ekROkM+zY9FviNQwW66YBGGZx/IvQ5XpCePU3r
         FrU4HawM/Ri4YQy9sMSJBmBzAxOXxwRU2qycEE5f+gqyL9wv3asFd7+MK040cp/xBaEl
         JK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773383135; x=1773987935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXrdpy/WIHE2X9P4Q9q/hAK5sgWHGc6Eec29rzkb/Q4=;
        b=nI5LbPovvcGGoaT4jF6HR+7oNzWBEpHIqxoeiMAnA1E7qo0o9CbsfabB+IG2hbOCHi
         9n9nM3MLC4xq9SFtKxc3AhiqiluMzWG6VEvpWWNMfDYAdJfXcHmoswEKRdaTLsawVRdc
         sBtO93Ta1veN1mLzne+4uW+v6UBx1DGMOEqUEV8MsEbCtT+z6oQ2SvIjIoiRP8fDcxcf
         eMEYspZrqmD7q/dKpHPv4wWAWMCq8tRvCiuKTWRo6k6IzeGJE+tf4agTNU05E/A+/O90
         AVf9s+qgYYU8rbqHCtRfKcyZHAcqlsOCQc+41ZGFnpWiyiBa4ltPPoyrj2K4ZDaawg5A
         yt1g==
X-Forwarded-Encrypted: i=1; AJvYcCXmHAxI7MSSSxXqFalkckqDAVpT1M93Li6G5j7Ol7l+dBU6ojX4ZqoinOx715vfcYAmw5wkTKU+xfntHL8LKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8EicYel+2kL8KET90QRSMsEcA4qdhM1r8mJMoBC34ayKbnvj
	caTa2ILF9jB9r8JrHCBGXF2qzivWNJp0apTsrpxoJioIHMartq+R7oEwVWjNOmMQCIa4gI2bSGj
	Aoc7AypeVsmrrhAeO5hXX5gNecVCl1H1Qnf1qE2M/Chmdu+yE/2GCE7q9X05tbcXbUzZorA==
X-Gm-Gg: ATEYQzxfyWAm2h9rs/CLBLbo2BDDvoSR5C+e+Ctp7CDgOmAQzt6ytuHEb44ILf4JQXN
	1wQGKx1J0uzYkPIPE07vjJqM1AXsbvoETlMM6v5D8VEWbaAUzd2CbcKhYgUcIa9KFqNjgBxU97r
	oLVC3LsE9yAfDEy10hMuuG61srfuYHTjiYMm7nlFCIYX7qoUV7YtM/XCfw11B6dRRk3UV6iyMYY
	UpURpwGAfiR5ZUuVwzD3DywLeCiqfuM0NanEDp4A9mJVywR500VoUhQoCQjhMvlPWEEjrvlsIX6
	2cZY9Pue3i/6bbI+iyHH/5WaVC4TJ7GCCQMWAu5eyj3zoJLSJRrbT3Lq6ItABnGapg4U4a/AClY
	FpMsymlzHyVrHxNFIsYROVIhzERCSHJ9POj78y7ZPgvMuuqsL80zbtjO8jBYuFNnJoqIzhoTZYn
	RpJXzkY4Ge7xBRY9ZeKTVnZe0U6ED4msWADdY=
X-Received: by 2002:a05:620a:4111:b0:8cd:75d5:543e with SMTP id af79cd13be357-8cdb5b6fea4mr312600185a.61.1773383135355;
        Thu, 12 Mar 2026 23:25:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:8cd:75d5:543e with SMTP id af79cd13be357-8cdb5b6fea4mr312597985a.61.1773383134902;
        Thu, 12 Mar 2026 23:25:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e7dea4sm11787371fa.46.2026.03.12.23.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:25:33 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:25:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: JB Tsai <jb.tsai@mediatek.com>
Cc: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Michael Lo <michael.lo@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>,
        Chris Lu <chris.lu@mediatek.com>, Quan Zhou <quan.zhou@mediatek.com>,
        litien.chang@mediatek.com
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Message-ID: <3v4kz62swpdorijfdfza2vro75mafluyy3nux5ldjopqofqecg@t3w7vu4glmug>
References: <20260313005616.2853492-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313005616.2853492-1-jb.tsai@mediatek.com>
X-Proofpoint-ORIG-GUID: d065Q-cU1vMdLLI_pXymbGzRYx8_6wAj
X-Proofpoint-GUID: d065Q-cU1vMdLLI_pXymbGzRYx8_6wAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA0OSBTYWx0ZWRfX1WrDZ+yZUd1J
 E5Q5j1GX3BI0fNAdkUDMQYxObQO4enVjwD0p/itmWa4SKU1MN9S6Xy+Uh7v7i00bx80VYVZL0Dm
 ha+kecz++UNXZaWjxU49vE6tZwLbZHxhXNu0PpO3pX+CoKKIrq4PkLVeBoutex5oJT54FgGn49L
 S6tXEtN3AzoTbO7pfPVKtpOVPgvBJm5kRA4lgqWElHiW9DGVB8yI6dkJpV7Y+ZiXNb2ePty/v26
 I+XfAT8poD4LWXOH53gnX+oMB7rr6bNXnTTPrKLlY6FtRSMYs2nzLxsv6oeNygW36NXKNJvBkVb
 N/SOKZRyP1MQuXNJzI6F11Zp/Ro57jpRrOXHVjAizlnhAGvYHpE05V0N9evl5ai8V6xdk5KzK0x
 WtrSaoLLRRPzTXtfLTpB7gfGzlOC1xiK2rC1ZP1LlGyjCIVYrKZbZaza+RfDl8rsQDqk5wxw9Jr
 Aps62qxyJ/1ivAdPnXA==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3ade0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=mpaa-ttXAAAA:8 a=emzX2egCO8hrsF3yLq8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130049
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33183-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,mediatek.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gitlab.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 732BA27E44D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 08:56:16AM +0800, JB Tsai wrote:
> Update binary firmware for MT7921 WiFi devices
> 
> File: mediatek/WIFI_MT7961_patch_mcu_1_1_hdr.bin
> Version: 20260224110909a
> File: mediatek/WIFI_RAM_CODE_MT7961_1.bin
> Version: 20260224110949
> 
> Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
> ---
>  WHENCE                                     |   4 ++--
>  mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin | Bin 92192 -> 92192 bytes
>  mediatek/WIFI_RAM_CODE_MT7961_1.bin        | Bin 791908 -> 792036 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 

Thanks, merged and pushed out:
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/957

-- 
With best wishes
Dmitry

