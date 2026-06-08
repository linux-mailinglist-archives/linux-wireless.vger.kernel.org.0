Return-Path: <linux-wireless+bounces-37539-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3ozLsoBJ2qHpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37539-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 19:54:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 379B76596FC
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 19:54:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Yr98avpo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=F7II811n;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37539-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37539-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AC41301FCBB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66E13769E7;
	Mon,  8 Jun 2026 17:53:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FC2D23B9
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 17:53:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941191; cv=none; b=W6UpQkJNrUk9NJJ4b59tcjBy6OuyZ0uwROXo/MFKKwC4jUC5RdgsLeL8JvULS9Z3jGlQcvwitxu/KSMLdZ/DCdh61bhO0dLz/J4p7yTmWy9uoCoJp6AuOU/iZrPKrf3IPYbSDpLo9fVynIeip6zl2ZdtUOdgUqu9N0KU46hg6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941191; c=relaxed/simple;
	bh=jQVaq4Y4tmDyHxroZ5PDnsvSNASfA71MctuFAGDL/bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBrJl7A1JQR/UmpE+MXHU4gGqT1JKjvArniIlvEciFc38qpabLhuXJRbROnNiZtV2vFF2WnSPH/p23riB3psr6esmP3nIdNaFGxGDIOmUJP96wDPwYDCzQl1MPpXPMKRWT18KDJa7m0ITBDbtlx5wNR/nQRLjhdVD44qE487ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yr98avpo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F7II811n; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFi1k3596531
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 17:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0o4A01Zx9wgjGmnTxMlZfyWj+VDfhGQEUZ0E8tBG+U=; b=Yr98avpooiWCFBBH
	lVs5U6rvIEpIW5P6S4f4CItVUxWli3WHZBdgS5mp5r1Je/h0lTZRc78kDDOrficG
	WIAy/SATDF51efn442zIGKoKtuA+7KosUG37Jq47cKxqxwuDwdSGUhs1Dok3L35S
	du5KHYmQNp6thLj1tMXDJj/lionibLaDsA2n4+PiItjmLFqZW1btwQziPWgLOu2a
	cPftw9dU1FbPLQgfqBUVtqNDMH7Hr1oKgWE6EWWqmprVw9lx1l1lRVgiIXMPNlYi
	vXdnh4BBvLCoiX0ZJws26sQErGDbP1VrYVrelXjeaJPW81UHHe2KMtUWPMyCgKjT
	/B0iAg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj9yxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 17:53:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf243973c2so32415275ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780941189; x=1781545989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0o4A01Zx9wgjGmnTxMlZfyWj+VDfhGQEUZ0E8tBG+U=;
        b=F7II811nTBhptQPI14tc7IjtjUWPoOdj9hyX61nsjRnlq12iv8ynN4u9r3t9OVUBzk
         XjOeWVlpTrU40MDEZCqBKMm1Uw2abZj6ii2ppVa56a+8peviMfydBloh/SoY2EfbZIsw
         XK+Q8h27eUNSg3U6p1YiVLeUBDtv819kDQnG95PTlx3aNEKiO7+cCSGHG2Wg5jS32R9k
         VOpoXShfLQzAxwOfftyaH+1Q+rLwKKyMiOgVyg4CtRUx6IKvMDDt/uJhoXFU4ObrEtEd
         0DAr5G+LoReHNfXlYo5lTXV89NKRKCNfGWx0jaKqUGBRzujbG7ws2kcLkkxMD+hyjf5q
         KQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941189; x=1781545989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0o4A01Zx9wgjGmnTxMlZfyWj+VDfhGQEUZ0E8tBG+U=;
        b=ARUWs3BA/pKSIUcf3SjIHZITRS2huElcMbGY7DiFRgLTp98rPRBu2cPaX5T688Cm4/
         LYhkzZVaahyoVO6eTO+sdrXFy4fI4yOj40ITkeIJHB9k9lo4SftZcwDiati1pe0keJHS
         DIpM9EZeAyOYrABBEsJciJo8JZqStndmdsaX0u2lC7VtGOYYQq3I8cdXxKoGIVA4oRK0
         W/7VsF1+awmhRvaXJXkO4xZCYzzF6O5guHjAH/AtkexoMAaCoGAwGzqr1iTZzXSPmV9n
         izcWAkBn0YzC9pvZ1xVoNeFzI6xtAs3Usc4pQ+E1t6LR2ALDRxUn1v3CMrhr+cbvHZCC
         IyKw==
X-Gm-Message-State: AOJu0Yw/9x4wIlWAMBcKdYYYFa/mSEsKdTqV8qcKqtdiJQoTk0WsRnro
	oSjTPHMoQKOVTlHzzZPbPsuYGGgfv+WfTBtHHZnK64kMU9b6nuF76b4XFeHxmXma91wlkoQylYP
	VVuMYvJoz3y5l7KFR7H+WRizB2CWY1LtTP3GupXfodXHp+zAkMr+0eh575x0gIkLE7W9raw==
X-Gm-Gg: Acq92OGf/5bos7EteZwYWSWJuJzperBDAkJC1CbC+NE7ryN/aJ04zIM9x6MP3EVK1RQ
	RSD7PE2/OYo0auMIoYoeqMRhdP3Ghh7mRIii+C9vuIbTVwfYhdW+TRS5eLgJT+WquWUB6zI+FMv
	/u4GlNpYH2wNIxN4fOnlhJE9diVCTi2TBvuQXdMrteRGO1D7uVdhwDJNjdImtA/zioEnacCsdXl
	aogCMZ2w8uOPoM9VEVy2N/5vE99C6/IyROsWI8C09o6ZII6fabKzC5v5w0lbsgDtQod4rCB+ToV
	C3K1X+peY409c1v4rPyLiVsttBC3p96HtkDa5eFJ5lLcF7JZZRJXNvYAjfDItVYj0SZKmLCSGKI
	pOj/MkoS9mzP3NZgQayL85ppdo4QhsyObYtE9GcivwcovrvtEV2KkmlK/QOk=
X-Received: by 2002:a17:903:a03:b0:2bf:2b84:c207 with SMTP id d9443c01a7336-2c1e8331ff9mr111298735ad.35.1780941189251;
        Mon, 08 Jun 2026 10:53:09 -0700 (PDT)
X-Received: by 2002:a17:903:a03:b0:2bf:2b84:c207 with SMTP id d9443c01a7336-2c1e8331ff9mr111298445ad.35.1780941188594;
        Mon, 08 Jun 2026 10:53:08 -0700 (PDT)
Received: from [192.168.1.8] ([116.73.159.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2e2sm184242265ad.49.2026.06.08.10.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:53:08 -0700 (PDT)
Message-ID: <e014bfbf-1144-464b-aeba-c7f0f58e8b2f@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 23:23:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/5] wifi: cfg80211: Drop unused link stats
 handling in nl80211_send_station()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
 <20260607175912.2266215-2-praneesh.p@oss.qualcomm.com>
 <ba13edbcfa590fe2bd764719b843e6ee8c675310.camel@sipsolutions.net>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <ba13edbcfa590fe2bd764719b843e6ee8c675310.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YCI62FJ5I0RSgwZwmHSFTSYVl5ZYZ18r
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a270186 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=0XKIscjZuezYqwSxLmfFhQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=_H_or78mt1J3sE7v2EIA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: YCI62FJ5I0RSgwZwmHSFTSYVl5ZYZ18r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2OCBTYWx0ZWRfX83e07vtvmGhL
 7GF7D+uzaKeUhJcg6b0RVE0NVohcCxdtL5bNvKPHO+cBHqCNVrM5EUWIpN3c/d4hdyIRWMSqh/t
 EzO/I1/1Zzw5L2irQeeNQET3crEZfX/gtWXYJBDa1DieqJ9aY5DyjC393I3pjbwU0P+6FiKZoaX
 +Xd6PNtOR1Ln7MOlKdGqQfo4l8Po+iVgGBcIMZTx27cd4k7Rkrt43iPNYEYiAuM4JRYAK68fFuK
 KC+mONJDd/w32sFcgJAWKgw2xvwUoTCkqzOPid1wP2CQch3vhmZLxYCWRdiXQnw4ouFql2cQG4U
 7XX63P1wsdDZQOeUyFOZvKhQWmu6vtE+wbAvq/yIE0dSpGuQmM3NscFPgCh5C5tbCU/oZAcmBYW
 XYskhiRaluH8aPln/G5Q8x6GFREdwTsnfnkozzOkw/ygIhV6kzY8ajIxQJcFce5fd8y5A52g0AT
 djRCn89dXVDN6vBjRYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37539-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 379B76596FC


On 6/8/2026 12:47 PM, Johannes Berg wrote:
> On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
>> -static int nl80211_fill_link_station(struct sk_buff *msg,
>> -				     struct cfg80211_registered_device *rdev,
>> -				     struct link_station_info *link_sinfo)
> It's a bit odd that you're dropping this only to reintroduce it in patch
> 4, but I guess it served at least to notice that:
Sure, I'll restructure the series so patch 1 retains 
nl80211_fill_link_station() as-is and only removes
the dead link_stats path from nl80211_send_station(). The function will 
then be modified in
patch 4 where nla_nest_start_noflag -> nla_nest_start is corrected as 
part of introducing the
new per-link send path.
>> -	link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
> all of the nla_nest_start() calls in it really shouldn't have been
> _noflag in the new code at all.
>
> johannes
Understood. NL80211_ATTR_STA_INFO, NL80211_STA_INFO_BSS_PARAM,
NL80211_STA_INFO_TID_STATS, and the per-tid nested attribute are all 
properly-nested
types and must use nla_nest_start(), not nla_nest_start_noflag(). All 
occurrences in new
code will be fixed in v2.

-Praneesh

