Return-Path: <linux-wireless+bounces-2603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE283EEE3
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4C71F21B88
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403472D04C;
	Sat, 27 Jan 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DqTH99eK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E62D022
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374827; cv=none; b=Sy7W9uUdt9IYHXiepR7Bm0PT5N2a2bk4ZCbYhopo3EF6U6rbVDwZpUFdabvLkXl5njVgYVIFhT0EJxJ7oZjP2RaRySUsJazKiTUMikDTd4gHOQ2Yy+jeMMqg27xQ+ZUMsgqReEPnnMbaHaCcP4UisEb09ptcsR31bv3llXmQvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374827; c=relaxed/simple;
	bh=fYD10lnewaXrNOHS91XQvwCssa62UEr3pHz9A1pAV3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaCM7E6VewY+SU1gAZlXDGcnsykSQw9IrMN29g8QXoUpzgCfcqoa/iSF9JG5Fq/ZfIlRqH8B5pAC+jNC7UORvU4NjT5xN5rJMVhZ3pG+EZ7AAJlKuSh32TFmaefhGQ2MtE7WXvO8H8vXqDMPLNnvoU9qSheEy+O6yuUBuEVEK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=DqTH99eK; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id TkBTrUAY2rh9zTm2Ury6Sm; Sat, 27 Jan 2024 17:00:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Tm2TrJ4mqWRcnTm2Urya1M; Sat, 27 Jan 2024 17:00:18 +0000
X-Authority-Analysis: v=2.4 cv=OPo0YAWB c=1 sm=1 tr=0 ts=65b536a2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=Q-fNiiVtAAAA:8 a=VwQbUJbxAAAA:8 a=bUQKSiCPAAAA:8 a=QyXUC8HyAAAA:8
 a=PW-KNzBFAAAA:8 a=cm27Pg_UAAAA:8 a=6yXzRheOZm4xIp2CHuAA:9 a=QEXdDO2ut3YA:10
 a=Fp8MccfUoT0GBdDC_Lng:22 a=AjGcO6oz07-iQ99wixmX:22 a=-fHZXUhsFbuwFN3fwQAr:22
 a=84zbTXrhsdUYOv-GFPQN:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Zbt/e+APJP7cVqXJui/sSNmCdYs0CvPuBfHjlhyExs=; b=DqTH99eKql8bHd8s9fzjBRlgqQ
	u5EzTJ+TQ3woLGulNCBKdYCKfkbZnCp4qgKUnjdzM37BM+GxBuLAdbof/Rj1W3Pwbh0PfG1S/eU0o
	D8EgyT3OTSmKjZzbWr+1IBJRs+nxwIKd0jstmbqyh5QEJ7fiYfeoRvnr0suVWRv6U0BDDRiSwVpQL
	Mx5zdLoxWdbYjlvcDHe+8tlzj0ripS9sRJlLgNGXKnnh2ShInfSHERao+YUxniaqTozAQXj3ceD+v
	sDl93PgB+QQc1O9PwDOE00CRGMpOfot4mmMNbntzJ+ZKNQkDdooddNwZNTbw/OqFMZaS5jPbUM0v8
	h99djU6A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48528 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rTm2R-001sE1-0h;
	Sat, 27 Jan 2024 11:00:15 -0600
Message-ID: <380ac5df-017b-47cf-a039-c60eb4eba39d@embeddedor.com>
Date: Sat, 27 Jan 2024 11:00:12 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, Kalle Valo <kvalo@kernel.org>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>, Ian Lin <ian.lin@infineon.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Wright Feng <wright.feng@cypress.com>, Hector Martin <marcan@marcan.st>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jisoo Jang <jisoo.jang@yonsei.ac.kr>, Hans de Goede <hdegoede@redhat.com>,
 Aloka Dixit <quic_alokad@quicinc.com>, John Keeping <john@keeping.me.uk>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240126223150.work.548-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240126223150.work.548-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rTm2R-001sE1-0h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48528
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIUBtz+cWkoQ8IdMNRqjfp2rQfCkEm8YAy+WBkxbZsuWRKu3Pm2SXnWd5XjVsLbBR27uH5GYhFJ/zHFJOHs2msK/NtgBYsB3TOeuBSoWVg3a1C8uQzl1
 1QGh7hyc1FDUqTb4FZrCpuw4iOBAXC0wZajoXeYMuu9u+RFC793R+TKQIXuUSkJRhrLSKnqOrd5gkL5vJDo8MeN8lelQ0Aa/9M7KLC4Qna9HX5EpWP4WPub9



On 1/26/24 16:31, Kees Cook wrote:
> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
> cfg80211_scan_request with __counted_by"), the compiler may enforce
> dynamic array indexing of req->channels to stay below n_channels. As a
> result, n_channels needs to be increased _before_ accessing the newly
> added array index. Increment it first, then use "i" for the prior index.
> Solves this warning in the coming GCC that has __counted_by support:
> 
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_internal_escan_add_info':
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
> n_channels' may be undefined [-Wsequence-point]
>   3783 |                 req->channels[req->n_channels++] = chan;
>        |                               ~~~~~~~~~~~~~~~^~
> 
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: Ian Lin <ian.lin@infineon.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Wright Feng <wright.feng@cypress.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 133c5ea6429c..28d6a30cc010 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -3779,8 +3779,10 @@ static int brcmf_internal_escan_add_info(struct cfg80211_scan_request *req,
>   		if (req->channels[i] == chan)
>   			break;
>   	}
> -	if (i == req->n_channels)
> -		req->channels[req->n_channels++] = chan;
> +	if (i == req->n_channels) {
> +		req->n_channels++;
> +		req->channels[i] = chan;
> +	}
>   
>   	for (i = 0; i < req->n_ssids; i++) {
>   		if (req->ssids[i].ssid_len == ssid_len &&

