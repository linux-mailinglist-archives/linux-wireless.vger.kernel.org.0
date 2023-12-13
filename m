Return-Path: <linux-wireless+bounces-769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C560811FD3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 21:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D911C209EF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EE7E55F;
	Wed, 13 Dec 2023 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tm6zPjg1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544EEA
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:19:45 -0800 (PST)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id D73ZrKuzKL9AgDVhpr2YeW; Wed, 13 Dec 2023 20:19:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DVhorcAdBqkaTDVhorEnwJ; Wed, 13 Dec 2023 20:19:45 +0000
X-Authority-Analysis: v=2.4 cv=bY547cDB c=1 sm=1 tr=0 ts=657a11e1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=COk6AnOGAAAA:8 a=1Esk1x17uEsZNe3dHhQA:9 a=QEXdDO2ut3YA:10
 a=phs4urI-Bf8A:10 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=98lukoNBw6fhWNDa2SxpMcydjo1sjKiYLT9wVXM3PxE=; b=tm6zPjg1Djc4DWouBDS8NxqlFl
	+MTPv0p8Ypf3qJyaUufJApz7iOB3u+VyBzoojFmt/Tfrikqe6Ira0WeJ9Zv3w16hPDVHuXyNzsEbR
	/j3+nbLr2zsgDph8Cjo6kfEfr8qaRgrz8rvZn/92qiSWVvMqqNYp8QmaNceHD4BpBhDCOT6SvIkNH
	kHQac7WZsHpalfetvivcbjDJWK2x16vtBmFEGzpt0gvSU0pyG+ylxEEMX50Vt6TATJoncz9ylhAfW
	mrYrB0trAeJcxi/9VF1KlDzLrh1Ul4kI9HHMoL3zagfUAWIcDkNYfTWTSgIR27JLDgsCG2MijIivk
	k/bJv5WA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rDVhn-003Rqk-2r;
	Wed, 13 Dec 2023 14:19:43 -0600
Message-ID: <a015d185-ece0-4608-821d-061d1296d4e7@embeddedor.com>
Date: Wed, 13 Dec 2023 14:19:43 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] wifi: ath10k: use flexible array in struct
 wmi_tdls_peer_capabilities
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVhn-003Rqk-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 26
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBUy3INF2qR5wOw4aV/lip1N8NCSlkrnnE2yWFHm9dUZrC95hKaWEOzgyjKzTUEWZ5ZodJgu6Uo9+/IcNkxXwHAuXc6IFMh4tF50X4dBBwnhcdkd5QNL
 c6o9iPstmydkGbvu2vFQ2KDV7TeESElWBqAVwRlS2jcqMhJKpJVPic2KevTQ1sNALCC9Kqhjhb8r2WJ+hJjsMOZGPN0BeepEhOMknOjSQhd62TyBT2Wxd7Ev



On 12/13/23 11:06, Jeff Johnson wrote:
> Currently struct wmi_tdls_peer_capabilities defines:
> 	struct wmi_channel peer_chan_list[1];
> 
> Per the guidance in [1] this should be a flexible array, and at one
> point Gustavo was trying to fix this [2], but had questions about the
> correct behavior when the associated peer_chan_len is 0.
> 
> I have been unable to determine if firmware requires that at least one
> record be present even if peer_chan_len is 0. But since that is the
> current behavior, follow the example from [3] and replace the
> one-element array with a union that contains both a flexible array and
> a single instance of the array element. This results in a struct that
> has the same footprint as the original, so no other driver changes are
> required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/
> [3] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/wmi.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index e16410e348ca..b64b6e214bae 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -7162,7 +7162,13 @@ struct wmi_tdls_peer_capabilities {
>   	__le32 is_peer_responder;
>   	__le32 pref_offchan_num;
>   	__le32 pref_offchan_bw;
> -	struct wmi_channel peer_chan_list[1];
> +	union {
> +		/* to match legacy implementation allocate room for
> +		 * at least one record even if peer_chan_len is 0
> +		 */
> +		struct wmi_channel peer_chan_min_allocation;
> +		DECLARE_FLEX_ARRAY(struct wmi_channel, peer_chan_list);
> +	};
>   } __packed;
>   
>   struct wmi_10_4_tdls_peer_update_cmd {
> 

