Return-Path: <linux-wireless+bounces-4803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC287DB46
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 20:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFDE281BFD
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF7168BE;
	Sat, 16 Mar 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wevPgso2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44F18EA1
	for <linux-wireless@vger.kernel.org>; Sat, 16 Mar 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710615656; cv=none; b=LFhl2yMdDbwJjKU/iQVnowQL1wbyKMfZp1mMSDPiY6oUiSkpqfYepW7Kqc5+KJyiWoKGvczb8Va53dOpE6z3FyRDKYSv0xpFS/BUcpfGQ4ZSVPi8/KGFq6a8xZPjtwtbcMkTA0zNZp+s4tBTVoFAOSGGTfAk2/aVzyvjH3CzsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710615656; c=relaxed/simple;
	bh=UaBIRXmICBdYqq7e7oTf77ZP4e7SfSf7lVmL7cq9gOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nklormgKkwCamUIj5t33hg6G7kumX4LBx/33rpvm8zRGh0tVQYp50PPs0/MfRXRiJJMqPTyKCnwPszsW+WZ/+5g8O0nuHR7HV7R16z+uQEjRypMqWhpNghWKLEbYjZD2m3g1W+nRHsR4RodnLg6HVkuav0Ezb5bvMRyKkRx/e7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=wevPgso2; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id lXPjrbTtwHXmAlZFWr2vjv; Sat, 16 Mar 2024 18:59:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lZFWrDtT0dVLQlZFWrT0Bh; Sat, 16 Mar 2024 18:59:18 +0000
X-Authority-Analysis: v=2.4 cv=ZufrKc7G c=1 sm=1 tr=0 ts=65f5ec06
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=GHxNDdVd_46DcYOc0x4A:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eI2igFSMoMgGwV+GQ0CiFXFR47TjD/v6V+k+ICTNe+0=; b=wevPgso2IGgJVqRnHCsH+jTtht
	/fvVibwPPB5J/OH88rwhaoNKg33NtVSE8ox40WAypeiCafMWiIyhS1rx7J8Ei0hvkzVMyXv5DeyOR
	REN45azO0qHulKDe4hZo/UPzdWYMBj4cGYZ+5T4GyOe+qIpIrw5bqyfnBLznToKXaeN0D5XZQhwx8
	sUqVn0YmekN09fFLK+jzjnsHhtX8Sm2QFhnLMeUfoZJyPyUZsmkj9BjOFs7MXNGiVvpRhWLd+4vGR
	m2NalmLLO7oMdTt/TOccHpMQAEH8GQqDjK52HOKmZ/y/Lr6kgbQ7zk46G4lwN+KPHIi6U48GywcYD
	M+8tc3Cg==;
Received: from [201.172.174.229] (port=41890 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rlZFV-001MV9-1q;
	Sat, 16 Mar 2024 13:59:17 -0500
Message-ID: <cfc4c4c0-83f8-437c-8146-6b86968db67b@embeddedor.com>
Date: Sat, 16 Mar 2024 12:59:11 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mwl8k: Avoid overlapping composite structs that contain
 flex-arrays
To: Erick Archer <erick.archer@gmx.com>, Kalle Valo <kvalo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240316150712.4633-1-erick.archer@gmx.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240316150712.4633-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rlZFV-001MV9-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:41890
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEFj2fVnzfEktkj1oHEFoRT7dm5goV11Le3gOwnir2wh9smj/1mRmXNbB1qoyHxcKc4NdSpJQxmcmjrRd2Rx1DKZZyq0HdBRMz9A8wVPoQHqkZF9aCbD
 JFM7FDLLEymn1XKoG8MdvszGDsUPryk4SjODpZJnBxza+zkO4W9JuaIzCiQYnYSWJrqaLuYWZQPgi/VOSBoD1IT142ar8b5qgkHlEUqtGDi18eCUsd/AZdSh


[..]

> 
> Link: https://github.com/KSPP/linux/issues/202 [1]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Hi everyone,
> 
> This patch is based on my understanding of the code. Any comments would
> be greatly appreciated.

Thanks for looking into this. :)

I'm currently in the process of trying a general solution for all these
composite structures without having to use two separate structs, avoid too
much code churn, and continue allowing for __counted_by() annotations at
the same time.

I'll be sending a bunch of patches once the merge window closes. So, for
now, I think it's wise to wait for those patches.

More comments below.

[..]

> diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
> index ce8fea76dbb2..57de32ba4efc 100644
> --- a/drivers/net/wireless/marvell/mwl8k.c
> +++ b/drivers/net/wireless/marvell/mwl8k.c
> @@ -586,13 +586,17 @@ static int mwl8k_request_firmware(struct mwl8k_priv *priv, char *fw_image,
>   	return 0;
>   }
> 
> -struct mwl8k_cmd_pkt {
> +struct mwl8k_cmd_pkt_hdr {
>   	__le16	code;
>   	__le16	length;
>   	__u8	seq_num;
>   	__u8	macid;
>   	__le16	result;
> -	char	payload[];
> +} __packed;
> +
> +struct mwl8k_cmd_pkt {
> +	struct mwl8k_cmd_pkt_hdr header;
> +	char payload[];
>   } __packed;

One of the problems with this is that `struct mwl8k_cmd_pkt` is candidate for a
`__counted_by()` annotation:

@@ -592,7 +592,7 @@ struct mwl8k_cmd_pkt {
         __u8    seq_num;
         __u8    macid;
         __le16  result;
-       char    payload[];
+       char    payload[] __counted_by(length);
  } __packed;

and with the changes you propose, that is not possible anymore because the counter
member must be at the same level or in an anonymous struct also at the same level
as `payload`.

Thanks
--
Gustavo


