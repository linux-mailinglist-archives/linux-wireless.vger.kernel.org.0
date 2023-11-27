Return-Path: <linux-wireless+bounces-116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BA87FA646
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BF61C209C7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9D35882;
	Mon, 27 Nov 2023 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="caFWUgSL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84034EA
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 08:23:14 -0800 (PST)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id 7bj8rJXCRWcCI7eO8rWs6e; Mon, 27 Nov 2023 16:23:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7eO6rGNru8vT07eO7rtXfL; Mon, 27 Nov 2023 16:23:11 +0000
X-Authority-Analysis: v=2.4 cv=ffi+dmcF c=1 sm=1 tr=0 ts=6564c26f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=Ln01kCxmXRaHJmvONIYA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Q7Pri0fJihW9QCH27OFmaRs5wYVEoLLYvRhIYgKafM=; b=caFWUgSLCTaYPsXEwcpS88m2tX
	Wae30zMmAoCLFoGLaGiozVIJlBLvvIoCg6iC7IbwjWF2Vgy/9iFq4q6tZbtG+uHbSrNTpBQmtS/uB
	udxzNMAzpsmSWp+trbQHVlOWY/9NExYuF0rXrC5A0ADTpzEVyBV4hMfHYlNg9/ng03rnpwTRWcNxp
	KxBUC1/OBl6qs/qq/5Q4+j8PA3AjmXI2UIN3SmyMUTV70kzuNu1KUnYOPhpwwTzsjM0PAIL0HRQ1f
	mr6hrmjU3BoNpYx1ZuQIymER6Xv+yUa78lQQfxuJmecO2wzK7/K7ZOZSfoev5GorSX/SzXG7TTXBf
	94flIJXg==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:35864 helo=[192.168.0.9])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r7eO6-003aet-0l;
	Mon, 27 Nov 2023 10:23:10 -0600
Message-ID: <4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
Date: Mon, 27 Nov 2023 10:23:07 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath11k: Use DECLARE_FLEX_ARRAY() for
 ath11k_htc_record
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
 <20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r7eO6-003aet-0l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.157.122]:35864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB472J77Hx/WFo5aObhAiC9ujwR7ICEL2X7Wnmpns7vdKr7N7wt93U5aZEaw+/2bhDy5BZpAqZDFGS7buvEd/C+3GyVCYHJRMLocKgUY5SNFoM5+AYVB
 jLD7XiQ8jZtQF4m4TGhImVq6PN17Pa1wI1J/DCzqOWVZ7ECbLIYEIBqbGmOOjjzumopmNpQguNsXLjHFAJpBjzhe2SE2b/MVe//wZJDicpSthNJ6ZG4EXmDh
X-Spam-Level: *



On 11/27/23 10:14, Jeff Johnson wrote:
> Transform the zero-length array in ath11k_htc_record into a proper
> flexible array via the DECLARE_FLEX_ARRAY() macro. This helps with
> ongoing efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/htc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
> index 84971cc9251c..e0434b29df70 100644
> --- a/drivers/net/wireless/ath/ath11k/htc.h
> +++ b/drivers/net/wireless/ath/ath11k/htc.h
> @@ -151,7 +151,7 @@ struct ath11k_htc_credit_report {
>   struct ath11k_htc_record {
>   	struct ath11k_htc_record_hdr hdr;
>   	union {
> -		struct ath11k_htc_credit_report credit_report[0];
> +		DECLARE_FLEX_ARRAY(struct ath11k_htc_credit_report, credit_report);
>   	};

Why not removing the `union` and just do a direct transformation [0] -> [ ] ?

--
Gustavo


