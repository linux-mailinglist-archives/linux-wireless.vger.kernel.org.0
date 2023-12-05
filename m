Return-Path: <linux-wireless+bounces-441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A476680601F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 22:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A65F1F211FF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 21:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329C6E2A3;
	Tue,  5 Dec 2023 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GCJobkAR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10C18F
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 13:05:47 -0800 (PST)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id AcOxrv8Z7hqFdAcbzrpejM; Tue, 05 Dec 2023 21:05:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Acbxr0wp9AKScAcbyrQXAV; Tue, 05 Dec 2023 21:05:46 +0000
X-Authority-Analysis: v=2.4 cv=N6w6qkxB c=1 sm=1 tr=0 ts=656f90aa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=c601a17RXwP2wWhsnozrzA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=WpM5r4VfDJVWwtKGMAgA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ELdMRvfVbTlW4kh57y4d7piETNWbebEO5+bLxPrF7YA=; b=GCJobkARQ6TF4IAWotopoUVOpf
	/EQA2Dc/8TfM/qBS7oBrxg4wOG44/4m03M3aCDiTXDExUH5de8o+3ErsK7IYSy+f3wmlIRslsDmht
	1HnI3uXcvu0W6QPvk88XNe99o0ELx4wGxXUofvpwCyDRuqcYMY6rKgCHA1mKqRe9jnXVW94gMKaxP
	d1Oe1tdsXWNmWQzOzWrZSWHmYImFZdnm/aM4o+E+otDrGBwq3LNvdMZjVz8SUE8eBsOyJXRa1BhjR
	G2JD1zMlg0ZkoZwCsxl8vOXYRTiNhVkdHSSZGrjCuMWNuc/Ut328cMSdbQE8QPnD2DWYhVzjJs0I2
	Ets8AZWw==;
Received: from 187.184.159.186.cable.dyn.cableonline.com.mx ([187.184.159.186]:21005 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rAcbx-001EZc-0n;
	Tue, 05 Dec 2023 15:05:45 -0600
Message-ID: <7ac54136-28a2-4ee4-ab10-4c52134bb515@embeddedor.com>
Date: Tue, 5 Dec 2023 15:05:43 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix ath11k_htc_record flexible record
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.186
X-Source-L: No
X-Exim-ID: 1rAcbx-001EZc-0n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.159.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.159.186]:21005
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCaKFC5N49Zmbu0k6zUub0zhNC4FjrdD/mzO/lZ0AvW6Ry4JrPcH9uufl4EVksp3WucCc+CoNLSk+Rq8PYX+4exYQ1CTcwZJhImFbtovyrPNZr34E2gd
 mGT7GVruIvWdIVI3gdIR64isJZObTL/8FZs8xa21+h4vasVm5Aec+qE83Ad+7CZ/kXY8j70/GDBR9v6UPsG4Nmcg4vfrc4RsmW+Zgzxo2LoU5ce48T8qdAbL



On 12/5/23 15:00, Jeff Johnson wrote:
> Transform the zero-length ath11k_htc_record::credit_report array into
> a proper flexible array. Since this is the only array in
> ath11k_htc_record, remove the unnecessary union.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> Changes in v2:
> - Original patches 1/4 2/4 3/4 already accepted
> - This is original patch 4/4, updated to incorporate Gustavo's review
>    comment, removing the `union` and just do a direct transformation
>    [0] -> [ ]
> - Link to v1: https://lore.kernel.org/r/20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com
> ---
>   drivers/net/wireless/ath/ath11k/htc.h | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
> index d5864a35e75b..86f77eacaea7 100644
> --- a/drivers/net/wireless/ath/ath11k/htc.h
> +++ b/drivers/net/wireless/ath/ath11k/htc.h
> @@ -151,9 +151,7 @@ struct ath11k_htc_credit_report {
>   
>   struct ath11k_htc_record {
>   	struct ath11k_htc_record_hdr hdr;
> -	union {
> -		struct ath11k_htc_credit_report credit_report[0];
> -	};
> +	struct ath11k_htc_credit_report credit_report[];
>   } __packed __aligned(4);
>   
>   enum ath11k_htc_svc_gid {
> 
> ---
> base-commit: c8a5f34ad811743d1b3aeb5c54198eebd413bc6d
> change-id: 20231116-flexarray-htc_record-ae46f039d4bf
> 

