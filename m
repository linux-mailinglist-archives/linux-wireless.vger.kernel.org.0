Return-Path: <linux-wireless+bounces-27076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398C1B487AE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26A317EF62
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97939224891;
	Mon,  8 Sep 2025 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="m5vi9rUk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942401F8EEC
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321967; cv=none; b=EZyOijxzRBy8ahK6xi/ShyDkRzHwrJ3U3aRBkyslsb+pTRWT9nhIxW8uG3EjvSYgXpLLbp1pETiDuPgglMj+l7hv8JnF96SPocdcPq0dUWb4iQu+Ur7jD6n5h/NV9g8b95XPfjP23ABZbMKX+FGv8FDEohB+kXUHuMYA9jKYc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321967; c=relaxed/simple;
	bh=qNzObxZi/gNdE+dTe84NJjTLXQrxRZ9athBl9Pcwxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpeTlAktWWcVVewXW7thYkSHewRWfyP7i0flecpsf2exU+5lk5FmsWbewV8QfPpw+6M7jc2E1QjbShhthrUGUPeND4AliM3oytuhAbpSfIK7sF3tHkXPJEGNTqSUoJ76Cjbw6pRmf5oMbfhwaTIPoEq3uU/KdBe0uuyEHcXMv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=m5vi9rUk; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 19985 invoked from network); 8 Sep 2025 10:59:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1757321949; bh=aZ+QUE32FwPhsQLyMAfBkawYsAuN48cp1oFyusK9M+w=;
          h=From:To:Cc:Subject;
          b=m5vi9rUkJMJmX6cez2tm5J+TxTVb2nMnS3d+Ql2pWM4Kp7Ucf4asOnv54JdNnHAcL
           +7BR+j/CQQMNzbXfeqHSBiXaGbdq7Rlb/9QmrMxp1zboXxdTkLI4uTzuAMu0V9m8l1
           6wj0o1JRrMnrcgp9qSC8CPD2hZOu4eKLDTw+O1m7PB/dsMYTna6X9tD7x5gBSoIH+Q
           2OWAYCBpEpkOvyqRjwp1gNxcCPEuKFwfUQGp5fHVM/OMC+g+q4P4S2RYsmvjjv6WFD
           4bXEfEcWeDKzTgTTXgbqCgb+CZpDsntBQ5fV2J5jA6gIZ0tOi2UgbWHm/ViYC75f1c
           tkKRPk5SE/KMw==
Received: from 89-64-9-45.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.45])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <chenyufeng@iie.ac.cn>; 8 Sep 2025 10:59:08 +0200
Date: Mon, 8 Sep 2025 10:59:08 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: Sanity check for sta_id
Message-ID: <20250908085908.GA7864@wp.pl>
References: <20250906094232.1580-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906094232.1580-1-chenyufeng@iie.ac.cn>
X-WP-MailID: 777d5367fe4f5f3d2000ecdc16a6e23f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gWMR]                               

Hi,

On Sat, Sep 06, 2025 at 05:42:32PM +0800, Chen Yufeng wrote:
> This patch is similar to 2da424b0773c("iwlwifi: Sanity check for sta_id").
> `2da424b0773c` introduced a sanity check to prevent potential memory 
> corruption in function `iwl_sta_ucode_activate`.
> 
> In the iwlegacy driver, the function `il_sta_ucode_activate` shares 
> a similar logic with the `iwl_sta_ucode_activate` function in iwlwifi. 
> Initial observations suggest that the function may not adequately 
> validate the range of the `sta_id` parameter. If `sta_id` exceeds 
> the expected range, it could result in memory corruption or crash.
> 
> Although there is no confirmation of a similar vulnerability in the 
> iwlegacy driver, it is recommended to adopt a preventive approach 
> by adding range checks for `sta_id` in the `il_sta_ucode_activate` 
> function. For example:


> ```
> if (sta_id >= IL_STATION_COUNT) {
>     IL_ERR(il, "invalid sta_id %u", sta_id);
>     return -EINVAL;
> }
> ```
> Adding such boundary checks can effectively mitigate potential 
> memory corruption issues.

Ask your LLM to write a simple changelog instead of marketing fluff.
Something like: 'Add sanity check for il->stations[] array index.'.
It would be sufficient.

> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
> ---
>  drivers/net/wireless/intel/iwlegacy/common.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index b7bd3ec4cc50..a3bcf9d9ffa2 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -1735,10 +1735,13 @@ il_cancel_scan_deferred_work(struct il_priv *il)
>  EXPORT_SYMBOL(il_cancel_scan_deferred_work);
>  
>  /* il->sta_lock must be held */
> -static void
> +static int
>  il_sta_ucode_activate(struct il_priv *il, u8 sta_id)
>  {
> -
> +	if (sta_id >= IL_STATION_COUNT) {
> +		IL_ERR(il, "invalid sta_id %u", sta_id);
Please compile check your changes.

> +		return -EINVAL;
> +	}
>  	if (!(il->stations[sta_id].used & IL_STA_DRIVER_ACTIVE))
>  		IL_ERR("ACTIVATE a non DRIVER active station id %u addr %pM\n",
>  		       sta_id, il->stations[sta_id].sta.sta.addr);
> @@ -1752,6 +1755,7 @@ il_sta_ucode_activate(struct il_priv *il, u8 sta_id)
>  		D_ASSOC("Added STA id %u addr %pM to uCode\n", sta_id,
>  			il->stations[sta_id].sta.sta.addr);
>  	}
> +	return 0;
>  }
>  
>  static int
> @@ -1774,8 +1778,7 @@ il_process_add_sta_resp(struct il_priv *il, struct il_addsta_cmd *addsta,

This check should be done here, in il_process_add_sta_resp() since we
dereference il->stations[sta_id] in other places in this function.

Regards
Stanislaw
>  	switch (pkt->u.add_sta.status) {
>  	case ADD_STA_SUCCESS_MSK:
>  		D_INFO("C_ADD_STA PASSED\n");
> -		il_sta_ucode_activate(il, sta_id);
> -		ret = 0;
> +		ret = il_sta_ucode_activate(il, sta_id);
>  		break;
>  	case ADD_STA_NO_ROOM_IN_TBL:
>  		IL_ERR("Adding station %d failed, no room in table.\n", sta_id);
> -- 
> 2.34.1
> 

