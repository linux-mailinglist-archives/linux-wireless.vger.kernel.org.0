Return-Path: <linux-wireless+bounces-766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5847E811FC9
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F01C20A6A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3C7E548;
	Wed, 13 Dec 2023 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="YGdLgmpR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967549C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:17:21 -0800 (PST)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id D6n6rc1FYWcCIDVfUrvjco; Wed, 13 Dec 2023 20:17:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DVfTrQqiRGKIcDVfUrHIAl; Wed, 13 Dec 2023 20:17:20 +0000
X-Authority-Analysis: v=2.4 cv=E+beGIRl c=1 sm=1 tr=0 ts=657a1150
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=zq1JsgicG58flh9ZypQA:9 a=QEXdDO2ut3YA:10 a=phs4urI-Bf8A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=egfqI6Be/HRfAvxJFdozcRY+cHCT1gxshiIRm0qO+vk=; b=YGdLgmpR4EdamO7f9efq6zMrQt
	AbMdZEQ1d5xNrO+efpMjxdOuqVfeH8oR8jPFvX1O0H5kFcC/0E7rECecsMd/Wk4wK+gW0sgDkXd8r
	WIvIaVSzRxetnw0/fIWOSt6CaqDkIn29FabqWyjRQ1yTVW51V4uzoM2iP/mWQIqnYzzoloASKtVMk
	f6Al2+tXS0J67AQS/3zTE5YSr116/jFibF3oyc8jhxRUguQCWiIsYn+k7tzdc96I6knAfHM5gFClk
	aWVVJ3vyL57avR5oODjcqsE9iTMxAl4GMDoWkT4ilLFMS6IBuXjfMs/hLISBKBB4CobbOq/WEtLTe
	CyHTeVvg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rDVfT-003Rqk-0z;
	Wed, 13 Dec 2023 14:17:19 -0600
Message-ID: <708ed53c-181e-4149-b544-eaf0725d58fc@embeddedor.com>
Date: Wed, 13 Dec 2023 14:17:17 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] wifi: ath10k: use flexible arrays for WMI start scan
 TLVs
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVfT-003Rqk-0z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIDa40VoK79kXunJSg+dmYcUZwHgqO03XCNU870XhLewzQCivqdmGfnU89z/jfnEZa3ww/ftiEWVGOS7rMUpTAv5OtakcRtJxERi5cRiRultcL/zZOg2
 UuRElEABFhhClXzPqDuNnuc+qzT+MjP2HgrHMPf96zO3z9bzp/t5gIYs8K3Db1RfTOi293OqAaIUDh7iQbXv/igxxtu8uAWww9wHe+YcVOkks3F78U4OxwLs



On 12/13/23 11:06, Jeff Johnson wrote:
> Currently ath10k defines the following struct:
> 	struct wmi_start_scan_tlvs {
> 		u8 tlvs[0];
> 	} __packed;
> 
> Per the guidance in [1] this should be a flexible array. However, a
> direct replace to u8 tlvs[] results in the compilation error:
>         flexible array member in a struct with no named members
> 
> This is because C99 6.7.2.1 (16) requires that a structure containing
> a flexible array member must have more than one named member.
> 
> So rather than defining a separate struct wmi_start_scan_tlvs which
> contains the flexible tlvs[] array, just define the tlvs[] array where
> struct wmi_start_scan_tlvs is being used.
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
>   drivers/net/wireless/ath/ath10k/wmi.c |  8 ++++----
>   drivers/net/wireless/ath/ath10k/wmi.h | 11 ++---------
>   2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 88befe92f95d..4d5aadbc7159 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -6927,14 +6927,14 @@ void ath10k_wmi_put_start_scan_common(struct wmi_start_scan_common *cmn,
>   }
>   
>   static void
> -ath10k_wmi_put_start_scan_tlvs(struct wmi_start_scan_tlvs *tlvs,
> +ath10k_wmi_put_start_scan_tlvs(u8 *tlvs,
>   			       const struct wmi_start_scan_arg *arg)
>   {
>   	struct wmi_ie_data *ie;
>   	struct wmi_chan_list *channels;
>   	struct wmi_ssid_list *ssids;
>   	struct wmi_bssid_list *bssids;
> -	void *ptr = tlvs->tlvs;
> +	void *ptr = tlvs;
>   	int i;
>   
>   	if (arg->n_channels) {
> @@ -7012,7 +7012,7 @@ ath10k_wmi_op_gen_start_scan(struct ath10k *ar,
>   	cmd = (struct wmi_start_scan_cmd *)skb->data;
>   
>   	ath10k_wmi_put_start_scan_common(&cmd->common, arg);
> -	ath10k_wmi_put_start_scan_tlvs(&cmd->tlvs, arg);
> +	ath10k_wmi_put_start_scan_tlvs(cmd->tlvs, arg);
>   
>   	cmd->burst_duration_ms = __cpu_to_le32(0);
>   
> @@ -7041,7 +7041,7 @@ ath10k_wmi_10x_op_gen_start_scan(struct ath10k *ar,
>   	cmd = (struct wmi_10x_start_scan_cmd *)skb->data;
>   
>   	ath10k_wmi_put_start_scan_common(&cmd->common, arg);
> -	ath10k_wmi_put_start_scan_tlvs(&cmd->tlvs, arg);
> +	ath10k_wmi_put_start_scan_tlvs(cmd->tlvs, arg);
>   
>   	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi 10x start scan\n");
>   	return skb;
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index 833ce0251a2c..52a409ff94e7 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -3218,23 +3218,16 @@ struct wmi_start_scan_common {
>   	__le32 scan_ctrl_flags;
>   } __packed;
>   
> -struct wmi_start_scan_tlvs {
> -	/* TLV parameters. These includes channel list, ssid list, bssid list,
> -	 * extra ies.
> -	 */
> -	u8 tlvs[0];
> -} __packed;
> -
>   struct wmi_start_scan_cmd {
>   	struct wmi_start_scan_common common;
>   	__le32 burst_duration_ms;
> -	struct wmi_start_scan_tlvs tlvs;
> +	u8 tlvs[];
>   } __packed;
>   
>   /* This is the definition from 10.X firmware branch */
>   struct wmi_10x_start_scan_cmd {
>   	struct wmi_start_scan_common common;
> -	struct wmi_start_scan_tlvs tlvs;
> +	u8 tlvs[];
>   } __packed;
>   
>   struct wmi_ssid_arg {
> 

