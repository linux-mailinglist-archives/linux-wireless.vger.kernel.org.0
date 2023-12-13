Return-Path: <linux-wireless+bounces-768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF300811FD1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 21:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E621C1C20C68
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261A7E55F;
	Wed, 13 Dec 2023 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="i/zlG+7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421389C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:19:12 -0800 (PST)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id D5TdrZPZvVly7DVhHr1EhI; Wed, 13 Dec 2023 20:19:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DVhGrO1Tu1b9NDVhHreBmT; Wed, 13 Dec 2023 20:19:11 +0000
X-Authority-Analysis: v=2.4 cv=FLYIesks c=1 sm=1 tr=0 ts=657a11bf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=djptEZvh-aCtj6NnK-4A:9 a=QEXdDO2ut3YA:10 a=phs4urI-Bf8A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MNKjR+nK7XAlYd1Revlfq3lvgfnQG7K4VqUh9Q42Zkw=; b=i/zlG+7rBUFg3HiC7AaC7BkSrL
	dvm5MV6SWrR+n6B3+30hllQlXABFs7tFcC+Sy9F/MPR/yfYoZSQqYusra36mx79NX4DA+ZGdppozY
	YhUJMZaLqOHGlSx9mEKj4LiIAXkU8q90l9/MeSf1y3mH5OfufR1kra60xIFdpJY1DzYf47RaGhTqa
	q07ctrvqI9sL++WtDAf1euCA5Sn7yierFNfNjJH6GL3L5Qd50jxsYhGFnNwLZVSK6MtG2qTIOE5B7
	hwW0p/Z4Ibqpb8fSLP+eyIkWNAqvdtkcJc3UiAeRUVW5e4gRLvv/pkta7MNkgLhL8QG9RS1cCIbbl
	Ps+3TrUA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rDVhG-003Rqk-1B;
	Wed, 13 Dec 2023 14:19:10 -0600
Message-ID: <2741782c-48b1-474f-bb89-97a7a6358ed6@embeddedor.com>
Date: Wed, 13 Dec 2023 14:19:09 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath10k: remove unused template structs
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVhG-003Rqk-1B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH79ft5OOrWfCW6RxxWlKE0x79w8B0zc6yPS1TC52RfK2yaHpz0zU/JvO6rIIDEtbvj2ISNV/YoiddPOM2AaMLE/1Y/+1MUfU/qj8NSE7icSQ5Q6xAwV
 zY2KHowyq0zgTnrgRFKdNId1hG6TC3vQxvyrwLEIQepRlv0T6uP1LltWcJceDesEyAc2c0hDM8g1mQfdq5q2yXxPyOcDch6vJz7quc6HIOsBZguAUdB3p/K8



On 12/13/23 11:06, Jeff Johnson wrote:
> Currently both the wmi_bcn_tmpl_cmd and wmi_prb_tmpl_cmd structs
> define:
> 	  u8 data[1];
> 
> Per the guidance in [1] both instances of this should be flexible
> arrays. However during conversion it was discovered that neither of
> these structs are actually used, so just remove them.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/wmi.h | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index 37a7d421bd86..e16410e348ca 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -5782,30 +5782,6 @@ struct wmi_bcn_prb_info {
>   	/* app IE */
>   } __packed;
>   
> -struct wmi_bcn_tmpl_cmd {
> -	/* unique id identifying the VDEV, generated by the caller */
> -	__le32 vdev_id;
> -	/* TIM IE offset from the beginning of the template. */
> -	__le32 tim_ie_offset;
> -	/* beacon probe capabilities and IEs */
> -	struct wmi_bcn_prb_info bcn_prb_info;
> -	/* beacon buffer length */
> -	__le32 buf_len;
> -	/* variable length data */
> -	u8 data[1];
> -} __packed;
> -
> -struct wmi_prb_tmpl_cmd {
> -	/* unique id identifying the VDEV, generated by the caller */
> -	__le32 vdev_id;
> -	/* beacon probe capabilities and IEs */
> -	struct wmi_bcn_prb_info bcn_prb_info;
> -	/* beacon buffer length */
> -	__le32 buf_len;
> -	/* Variable length data */
> -	u8 data[1];
> -} __packed;
> -
>   enum wmi_sta_ps_mode {
>   	/* enable power save for the given STA VDEV */
>   	WMI_STA_PS_MODE_DISABLED = 0,
> 

