Return-Path: <linux-wireless+bounces-38702-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MTZCMS7sS2rmcwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38702-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 19:55:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB327142C4
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 19:55:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KEuW3qTD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ceaoRugY;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38702-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38702-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E8433EED3F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B212430CD1;
	Mon,  6 Jul 2026 15:47:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8FF30FC33
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 15:47:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352846; cv=pass; b=uZ0/x1WEr4stt1ObrgEGn+b14XzQ3krgBIHArlWp+CosLk6y0DYv9CduXyzvPOFa/RXqj4U8DYysvHHbESboc2Xxsxwf8hswILA4eiLclPzrs4L2qStPRjK6EEpHwUL/x+gP9cIxTi52eO+kSy1B8xoku//M0iJ4zHRjgaKaF2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352846; c=relaxed/simple;
	bh=Zb3cH/fai8fDmo5+VF4j0GwH/xc79uxvxl3GXDwcAhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvh4IAwvqBs+QfexTpz4H4t+AmFJJQjvSnyz9sXZ3n+7VX1IyQwetsc71abHWNm7g1wttiWuF+YqDOt8ZUJbUgghnDpXRjJ51yywQyryAlSKtP+ar2mfhQY09Pft0hcvHZugPTSmSz4S/pbQYkLtslwcgPpaaWFOKLpqKxDuTJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEuW3qTD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ceaoRugY; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF46W981479
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 15:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=; b=KEuW3qTDKSVLDEBs
	WHgcYg4mADpR1KremIPHqcJUE5rO9UXe0FCgTQUlCr0GGsBn1oAHmFJ6qFsOnGbH
	NqGAfDcCgi2FjZ3ZTj4flkfzWXbJghCk3+dN1uaFqs6S6zhQ1PwPWLzFuTa/aZ3k
	lDADQeuQJvTx8VPVcsOfVi7VBbDiBt/rX5OTHWH96MIwPNjkT3tCpZB+fWYNL6mT
	Dl57auozveBd9BwCQwUHY7YKr0lgsyf6dR+bi+Vv0Cte80Gv6shojFqsPRrXIZdV
	EJErFYAj5Q4nuoPFBX0/qjwfDi+91KmjhIL0d8k3vqo+r3ogmcWhAorQyIPPRMxa
	ybiAHg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgsr43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 15:47:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso70856346d6.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 08:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352843; cv=none;
        d=google.com; s=arc-20260327;
        b=ei7Kb0suMsnvtN2AkS+t7rWvukpDgxAhvBAKK3fGPO5oOhsKc/SMDsDpx00Kn2MfUZ
         LaVf6ERbkLSV8hXgrFfUD1wdJ2TnEKrsj588SrQW6d/ewOY0ggxTYDB1edz9pL+qJjhV
         DaU3HJN/RhYcVGxzHgtQXKR2MJ9j8at44bBcE3wsMZ2GLYK6THZlpb8Jy18i8qM+1VRs
         lLvcHu6kwi8qu6ioMmDhdz8gylUB9SjvtrBHM74uSaiZqHiBd2ASTfYF9X9skhQ2bxc7
         xfI3KUBZPFKDWBhPr3s8mqBygSYMSJWM+ULm06Z5O/qfPFWa8ANsSyeKvv74Et1DR2vi
         MRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=;
        fh=1H5OqoF3MMcbyCWEZzztzMjNGCVWGGqyxSipxWZC4zo=;
        b=jFYW+TUYmWtIfEech8RYeUkyF+MGka0tsH5kSj7VyjmV9KO9CJjTtiqxu6dGyhF/0x
         wB4sRH4c5s/sjIM8wgtsvS8A0EXDVfsu7iJZc27sYVDZAALhhjFDP61VRxjs7Rx1fORR
         nbg5QoU5OPgPv+/PZwtZA1y2H2Cod4Hz/UrhzyYP8gcj2ZnVwjcaUh3yxSROM6jt3K6s
         J3DgsZ4BUp/2qVXrPGaGC6V42XqFTS639xA7RvZsxi/BA0RyXCPFcc4rtVNygQr3qKSu
         pigcJAyhIxseMXpEUSb/TutF43RJHtaBOB+AMDNzOPtTpyK2aeDV2i4EtgQLVokldJG5
         fO4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352843; x=1783957643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=;
        b=ceaoRugYoap1V8gKQPQHievEoPWz13WzrZR5hIjJ3yxW3H7/q45yOQBPWC8qBg3zKf
         InZQCxbh8XioeM+CLMxHMHdxPZsTPTssjYb9BNbEANlZmmCYM8x4k54GzIpi29pUhSPF
         dL2J4FeuZNyd77ltzkI/D0oGYlwsILFBXROX6459V0jIksm5OtpN8cDmcY0R9pWrNiA7
         wt/NuM2Zyy89HiswFZg70P2RKVpPLh9j4E2GloSMAg11aYab8T/785CpaMu9IK/QTmES
         MfF6OuoiJWA4kOwIR0rXozq4bj5S6Gz3+Mb0zzyvM1vXI2BrYqD/hSbPtNnJ4xmn/WMU
         qGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352843; x=1783957643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=;
        b=RnanoiErpX3BAWcBccGKd0b1lkJoBGxjwjZk1F6GWvstVjkHkwxoHJQMitKg/sLT6R
         6QycX6TJ5/CyXJ+F2ToNiuNO58IPE2rKgTtH7vuvowKpWe1jW1QQOwgtBPUEVsXxC06C
         kaNoqvULN9bGYAjEKMqRFwY1cgUq+3kB1HBPD63rNmxjf3qnBQTZPLxeVpkM8Ik+tgfC
         I2hNYP+gru1h7oo+dlwkr2D+Lpo80YFWysSK1Ah/YZeL7TgzQ9Raa7E/C7s7xg8GKZBx
         K6Mh0uv+l/VDZa9U0cmLleVXQ3j2xzCFcp7d3MthAe/Nw1XKDQM+KNEhf9eP0KIKzCHW
         DdeA==
X-Forwarded-Encrypted: i=1; AHgh+RrKTCtydOHnbAwKxaMcETHnGs+GcZXdm8tizaDBJ+ArH9R3wEzQzVKIDZ/3nPfzB67TR5BhBX3f+O4GImqhzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RVU/zu8cPQwnLqKGHQFDLsErJ6LQeCa5MUWl/QAoec1TN4yJ
	SeZCDzX+Ya5MFXtPO38zAbYPpCDSJy1SvL2y7uVK7AIBOu6RdD3y4xmJz3u8t3h3XoBZnZcry6H
	7UU/EcIdCNeLGMTdbYPFwat+Lx1TzZk+ezuNJr/Z1b57FyAU0JrlEnd4z5B05vAbB4o0xFbue2b
	f+0hudyl+R0ozM8+yDt1dKU5V0al6+GZILtZiFzdBu+e1v
X-Gm-Gg: AfdE7cmqifXtzFNZ9nheD1WDPfKLKUbDfttDN3/N6xoYuOqRzdbgBYp+aJfPd1ezpkE
	KlhiAcryhwwCsBmrsQ+CqwNmDbko9IXUytW+aZ3b9bQ/J9V1s9rBzNLDtD4pNYYDFPLUBtj4coo
	CQq0h5LA125LBl6hA8SP5meIV8r72Dkz19CGXcD56uKU+i81Eu0CDDnu0XF3n8vrHC+mHD
X-Received: by 2002:ad4:5946:0:b0:8ef:5c5c:dbfc with SMTP id 6a1803df08f44-8fcb4a042d4mr12696516d6.43.1783352843327;
        Mon, 06 Jul 2026 08:47:23 -0700 (PDT)
X-Received: by 2002:ad4:5946:0:b0:8ef:5c5c:dbfc with SMTP id
 6a1803df08f44-8fcb4a042d4mr12696066d6.43.1783352842865; Mon, 06 Jul 2026
 08:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com> <20260626063014.1275235-24-lachlan.hodges@morsemicro.com>
In-Reply-To: <20260626063014.1275235-24-lachlan.hodges@morsemicro.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:12 +0200
X-Gm-Features: AVVi8Ce9U-pzBFpRo6F6_AW1qMU08gSYjLH35DGEhvet44vD774wHB9GxPSvsig
Message-ID: <CAPx+jO9TEcARhBc4_SUqj2h0uMhguzHJUSfYMH10v9Yuq1rW7w@mail.gmail.com>
Subject: Re: [PATCH wireless-next v3 23/33] mmc: sdio: add Morse Micro vendor ids
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, Ulf Hansson <ulfh@kernel.org>,
        arien.judge@morsemicro.com, dan.callaghan@morsemicro.com,
        ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: p0vo1SJ2I-ZJraTWiYq91BhaCdZnedOg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX/lgkxxPzZi3/
 cq8tP/I2DmMcMWOx3N6LA3BNZeZMxCD81Mk6OBY5kMjc/RycD4vDGnwsSrwtpmUcEBC3Y7WKOLl
 0OHJXnsjs41uFhz5VJMrMFBboBjUvgO2QhhzPpm0IDygjP+yUFP11J+TQgvqw//5/B4jMMePTDX
 8LUXq9HtO18cjP9VRfjJMvfqMMONaX28BHBhOGne7bcxWG/47p67VO+2L9NfTv+WwxZYjabRALv
 F5tZHHXAnBnxNCHnnY9F62sjwDoVXYzz0LEmOCjDfbaTKbmPn51ND4syrkstYSBwXN03EBf20sV
 S7bKlR9lXftt6qbZdG/D+JF1gKJUm64KlvBcmNyY0I5cRelxlXQDgqSm5FohcVr3NbD/5jPtWpC
 MhsO2p76veIrmW4zwe4h+BT9MyMtNY0lDsfbg2RIfvhHrCQsncI4KIoF8bztfxEFTMX3Lo4VphX
 V0bVrYzQiGwxNXsrCuw==
X-Proofpoint-ORIG-GUID: p0vo1SJ2I-ZJraTWiYq91BhaCdZnedOg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX0xwU/eMZ725B
 DzsISt2J7g3InEjnj5G7woGa5RbmS+dP26yH0Sn87qRb2Es+Q2gD8E661mFwNHszxZoNwox15r3
 gbU4zq9q2103i+NFrNLCdnlZGlINn+A=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bce0c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=YPXFKQCaAAAA:8 a=VwQbUJbxAAAA:8
 a=HBoK9o11-f7nQtA1NX4A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=R5n2JtruLZ7-kf9guG-3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38702-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:johannes@sipsolutions.net,m:ulfh@kernel.org,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ulf.hansson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,morsemicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AB327142C4

On Fri, Jun 26, 2026 at 8:32=E2=80=AFAM Lachlan Hodges
<lachlan.hodges@morsemicro.com> wrote:
>
> Add the Morse Micro mm81x series vendor ids.
>
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe


> ---
> Hi Ulf, since v2 we've made another slight change to the name removing
> a "B2" suffix so even though you acked v2, I suppose it's best to
> recollect again - sorry about that. As last time, the patchset is
> split once per file following wireless driver submission guidelines,
> but will be a pull request with a single patch adding the driver +
> sdio ID once review is complete through the wireless tree.
> ---
>  include/linux/mmc/sdio_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 0685dd717e85..bbffad9ae88e 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -117,6 +117,9 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_MORSEMICRO              0x325b
> +#define SDIO_DEVICE_ID_MORSEMICRO_MM8108       0x0809
> +
>  #define SDIO_VENDOR_ID_NXP                     0x0471
>  #define SDIO_DEVICE_ID_NXP_IW61X               0x0205
>
> --
> 2.43.0
>

