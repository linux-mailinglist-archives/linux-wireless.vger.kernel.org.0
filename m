Return-Path: <linux-wireless+bounces-25762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30AEB0CAB7
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10FFA7A6F3B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89D21FF54;
	Mon, 21 Jul 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KF+ywaYt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175321D5AF
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124117; cv=none; b=X1AfA/qaPlo9jDOoPR7K4W3PU/+KDWmTES4mEHmTApZ6n7YuFarloAjlEX0fmdWu4opa1W8ArcNh+MFHo1OBEXFiOzpsFja690dc2c5973au/8nWm85/cL09H99VLPAONqDt1EfGalZTK/+poGUJN5/N7p3ABLtuN1L+LmdyIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124117; c=relaxed/simple;
	bh=rnHeXAcRyQ3rssGoQ+P6O2rG+zqGthi1REfAADS6Vl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5H71qRXFDTYXGZqkfjg5h7vFa/1aSQR0rKuz8JHRMMH0lQ3vg5joaU+gwkoaJC3nmkO8nM0ZHsz4+z2D4NkrYexAgMg2FHdAv721BqKfhW5RIOzaSTHyVPR0mr/6spezFZ2Jyaie2LthrIGW40YGj0GBLhYMHhwwrgZv5wAYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KF+ywaYt; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id dfoxutE5QXshwdvfHuMIJ9; Mon, 21 Jul 2025 18:55:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id dvfGue1DfXiq1dvfGupQhR; Mon, 21 Jul 2025 18:55:06 +0000
X-Authority-Analysis: v=2.4 cv=WeQKaVhX c=1 sm=1 tr=0 ts=687e8d0a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=elAakMZAzsQyfqpwiXQzJA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=stkexhm8AAAA:8 a=KF2CoUmeBr3NaIPvZjYA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rVL5hVz9/5SnJaz7ql/wnvCuNsYr81PNsB+ycNjAoUw=; b=KF+ywaYtMvjOXA5ExoaW4ScvB3
	8ME+m46DzmJihhbL8Q6xR58UeRGjH2o0+dS6iVtNJZ1bPwanNlYYus9A+VAZ5CbWojBI8ZKDZX+Un
	FlIfF7Fd4DALcBl1/xQHAkkiftDeYAZIKk0uvn0z1mdzc/T0EeJYczBlbHBkhYUN3fvxqlcrvt4Cr
	Gl37Z7M5swg1pB74hL2WK3jHW6o05YQU4dOlPmcyFdc0IcD8y/aRl0Ds3o5b7PAHzERC140l8Ibeh
	as2du0L4MXBzoGZAPF0uai5SDslxwmSBJKT+N0oZJo7UFC3i/GkpOl9+KLY+CQ1w048knF0UqpEOP
	mLEn7i9A==;
Received: from [177.238.16.239] (port=55416 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1udvfF-00000001wrf-2KLS;
	Mon, 21 Jul 2025 13:55:06 -0500
Message-ID: <331e54f8-f678-41ee-8788-9e91e3f5ff24@embeddedor.com>
Date: Mon, 21 Jul 2025 12:54:59 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Write cnt before copying in
 ieee80211_copy_rnr_beacon()
To: Kees Cook <kees@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250721182521.work.540-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250721182521.work.540-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.239
X-Source-L: No
X-Exim-ID: 1udvfF-00000001wrf-2KLS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.239]:55416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLsDjECaMXiZsyCVnW0yR2q1dhbVumRFHRzKAvv2geQqPfvdJRFX8XarYKJVf4UVZ9ZZozQmak1t3W7Dx69xgtpVBavt2oEWsOlcBh9zjYaW/QL4rZzW
 5LGD7LiTk11IipPD0Pg7oGzCVLoFfviRxKsSxDmKSh6IwdVMDEtklmhNcHrdTVPtJ2nYLUhijr1/BNDHjNSHbNpBS+4DTLVsNPAXPYAfFqnkroxprrjIdXUE



On 21/07/25 12:25, Kees Cook wrote:
> While I caught the need for setting cnt early in nl80211_parse_rnr_elems()
> in the original annotation of struct cfg80211_rnr_elems with __counted_by,
> I missed a similar pattern in ieee80211_copy_rnr_beacon(). Fix this by
> moving the cnt assignment to before the loop.
> 
> Fixes: 7b6d7087031b ("wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: <linux-wireless@vger.kernel.org>
> ---
>   net/mac80211/cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 4f20d57ab913..2ed07fa121ab 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1176,13 +1176,13 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
>   {
>   	int i, offset = 0;
>   
> +	dst->cnt = src->cnt;
>   	for (i = 0; i < src->cnt; i++) {
>   		memcpy(pos + offset, src->elem[i].data, src->elem[i].len);
>   		dst->elem[i].len = src->elem[i].len;
>   		dst->elem[i].data = pos + offset;
>   		offset += dst->elem[i].len;
>   	}
> -	dst->cnt = src->cnt;
>   
>   	return offset;
>   }


