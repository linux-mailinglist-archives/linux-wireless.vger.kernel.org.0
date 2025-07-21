Return-Path: <linux-wireless+bounces-25763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EEB0CAC6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61DB7A8CBE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8521B9E5;
	Mon, 21 Jul 2025 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="R/vceMfb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E4221DB4
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124403; cv=none; b=OV1TjyMUjEUVT/6TbC32hGGJFJrsEkHSVrQRyHix1vx6rpaLpiOQB1zAst+P89FQj4IJo16JAk0srcChfsxqUT5NrWFESeRKaBBsmYo80c1shuy7FTvim0X/HZ9PnOf0LyJNwCMxiomkp6embGWwxZx9rH7+iktWWPEaysgXrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124403; c=relaxed/simple;
	bh=G6ewJ2NkykcMO6/O9LB9p0M3chk+XdnpAN2zUJIxIpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPqDVt63Q/FEg4CFJ80RIcu2zz8vjZ+8SuNPpDuUqRFGngx9j1qf1er7+pyuS8M5uDVzi4NrcwH7NpUzbfoDtF1JqEN+9Ucr8EBqu1xsCkf2LMYWBAlmkpRCC2/bCJA7V6ZVeINwS5MnlvRMm6IbGSf84ekX1iG9CpTjJPCtuF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=R/vceMfb; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id ducouwbUzXshwdvk1uMKxf; Mon, 21 Jul 2025 19:00:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id dvk0udeOVCvF1dvk0uPyuw; Mon, 21 Jul 2025 19:00:00 +0000
X-Authority-Analysis: v=2.4 cv=fvwXZ04f c=1 sm=1 tr=0 ts=687e8e30
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=elAakMZAzsQyfqpwiXQzJA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=stkexhm8AAAA:8 a=vaJtXVxTAAAA:8 a=sXnjJTT6HAGxZc7ZnGQA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hPCkWypsW3D1iyV1K+MtBgVaLgvuO0v5TmWkASdkVgw=; b=R/vceMfbENCuP0nMYjonqTthax
	T8oGsuJS5LjfPNwr2gVK8ZxoUc0NZLY7zeuYVSxK8P3hS27rn3fPW8VTrwzFjM+R0KlxvNGM4aYta
	5KMiQEvUxL9wbC+ZzGl3jrGjh89k9fJagTV3ic/qEUWEh2zEgkS8KMusD7dZcrhousYZcZ/yLQusd
	yRje6KGWF4RDjO2n+1G4fmX1ez4UON+ax9M1IC7R+ZIlKLbjkptTK6sL/PQsFdUZmpc5Pkxzm3/7W
	CYh8jKgEBSpAcOM7uZXDe0f9E/SI9PSsMUOSoOMgKVxoMbdn/zzicAzre/Pn5FFFIbLvCInWxArjt
	bE3ir3eQ==;
Received: from [177.238.16.239] (port=55344 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1udvjz-000000023Si-2ZoH;
	Mon, 21 Jul 2025 13:59:59 -0500
Message-ID: <f0f18d5a-a26a-49c1-9a46-2a0a70ef492c@embeddedor.com>
Date: Mon, 21 Jul 2025 12:59:54 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: Set num_sub_specs before looping through
 sub_specs
To: Kees Cook <kees@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250721183125.work.183-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250721183125.work.183-kees@kernel.org>
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
X-Exim-ID: 1udvjz-000000023Si-2ZoH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.239]:55344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIZ0cekGQWNzv15STwA8QY9iJsmFwmPLp5Ncef7Jm/xnHlkEApaT755xVClWqc67Dr9b1lJ5AiMIYxhsFWwtYlrGuncX7AmYcSNOs5ELG8z+jCwosNP9
 Yd9ShTZT3zNZ4tDi5MwWxY0Q4OiH2sp6qz4HutPQjC3YGEeoeB5d9uFwTRqrh72dBZ6Z+KhjwWnWyjgCiaiatGQtLTARrtAn4vClD6ELVcr+eW+cVXiKJ4ug



On 21/07/25 12:31, Kees Cook wrote:
> The processing of the struct cfg80211_sar_specs::sub_specs flexible
> array requires its counter, num_sub_specs, to be assigned before the
> loop in nl80211_set_sar_specs(). Leave the final assignment after the
> loop in place in case fewer ended up in the array.
> 
> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: <linux-wireless@vger.kernel.org>
> ---
>   net/wireless/nl80211.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 1c808b08b747..db8b089454ca 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -17559,6 +17559,7 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
>   	if (!sar_spec)
>   		return -ENOMEM;
>   
> +	sar_spec->num_sub_specs = specs;
>   	sar_spec->type = type;
>   	specs = 0;
>   	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {


