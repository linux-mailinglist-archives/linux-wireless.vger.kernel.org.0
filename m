Return-Path: <linux-wireless+bounces-770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFDD811FD5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 21:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679ED1F21653
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5F7E55F;
	Wed, 13 Dec 2023 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="br0evADz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2AF4
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:20:09 -0800 (PST)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id DT3frhkIGWcCIDViCrvlFK; Wed, 13 Dec 2023 20:20:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DViBr1LmJRQmiDViCrAtX1; Wed, 13 Dec 2023 20:20:08 +0000
X-Authority-Analysis: v=2.4 cv=CdcbWZnl c=1 sm=1 tr=0 ts=657a11f8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=COk6AnOGAAAA:8 a=VaYTkYKm6e9IgmJMUy4A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=48Kq4sHsiGNbPXyAoSW6B6IBFLyGbgamMMf7knlCaxo=; b=br0evADzg4ntTiZ0w6VYuGjM8h
	FPAXLRilVKTKleO2UxC8+0EU1A/eQRX8tHbHk+ojfe415t+E3j2j8qLrc2kcvBVDmx8m17i3ZsmCg
	8UEft8dtlf+5LGr0yfY6oUeriqz6RVevdusN1Gg/nXwzxDMs4QrRzb79YG1V5XPIbrUcQyl3n//tT
	6GDBLnVMVi7+a7kxTasZ5exYEajkZYjnSfQxMiyF06UCkCZThV9a+ZNXI/FIoBLUIRamaCefOz4g6
	oRtkefzSm2OEo2iledID2lWT+//HtJfLfVrwetGgA95n6+/zwNK3lTiELVcvT5JBpJwXYknfa3kyZ
	yPQo8Szg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rDViB-003Rqk-0V;
	Wed, 13 Dec 2023 14:20:07 -0600
Message-ID: <fb5ad3db-5d69-449d-81db-036abf361f17@embeddedor.com>
Date: Wed, 13 Dec 2023 14:20:06 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] wifi: ath10k: remove duplicate memset() in 10.4 TDLS
 peer update
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDViB-003Rqk-0V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 32
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGCPqs6CIsObcVIZyIIlXJC6JLv91uWAo86kieSJ2x76yAum53IpCjlxn72x6QELTDptUT7RbH7LItaxiUNAaQC1w58MPq60+5rzIJrHNpcsiF4Tn9YC
 28vs9b3Ekdrbh3jh3tCTBIC/9i+aBy4uUk7VXnF3kZnw2Nmw6pJ6hf9AlM7aljI22BfwjawEBsso9Dd+XpTHXPWaiXn7fCucI+ryRV1UpvMVmTTMAuTsZWbU



On 12/13/23 11:06, Jeff Johnson wrote:
> In [1] it was identified that in ath10k_wmi_10_4_gen_tdls_peer_update()
> the memset(skb->data, 0, sizeof(*cmd)) is unnecessary since function
> ath10k_wmi_alloc_skb() already zeroes skb->data, so remove it.
> 
> No functional changes, compile tested only.
> 
> [1] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/wmi.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 4d5aadbc7159..0cfd9484c45e 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -8918,8 +8918,6 @@ ath10k_wmi_10_4_gen_tdls_peer_update(struct ath10k *ar,
>   	if (!skb)
>   		return ERR_PTR(-ENOMEM);
>   
> -	memset(skb->data, 0, sizeof(*cmd));
> -
>   	cmd = (struct wmi_10_4_tdls_peer_update_cmd *)skb->data;
>   	cmd->vdev_id = __cpu_to_le32(arg->vdev_id);
>   	ether_addr_copy(cmd->peer_macaddr.addr, arg->addr);
> 

