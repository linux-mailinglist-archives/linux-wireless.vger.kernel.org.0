Return-Path: <linux-wireless+bounces-19282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41039A3F5AF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 14:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABF47ACE30
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F320A5EA;
	Fri, 21 Feb 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKYK1koq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3E208A7;
	Fri, 21 Feb 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143878; cv=none; b=vBUzaeA5P1d2TyZ8oViZ+TpN/jO6U905sHAJUOpINfpQKytt4JjMCr6TEWKSTW+ktu92EL/6UzR/kLir9m3XZIbzT3mpP+mve/4Vg5vnIYnXB3+7k3qccebQSNvRjzOUUuRnjPREnI2ICN8gtcVbzm1pqPxAp4J+a+0Ythp+Lqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143878; c=relaxed/simple;
	bh=DT9iRaIBL+udRMxD97hQUdsy12XVo3Yu70K5bIC7KA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckW4hKsme0nbzzfPK4iZ5DUpEb/MDiZJNcwioddKYAvOouhRpHQZdphRPG8/xzJrDfDKaSgroYR5XL3HxxFIo4IqVXPbf6sTEbtx2tgsDIiiJLB1V/B9eBRb2qSth55neV2XrH3Yg+p8hyT3QTQChUd0H1hVc/5GfhdIEPxJkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKYK1koq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4399deda38cso12715605e9.1;
        Fri, 21 Feb 2025 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740143875; x=1740748675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxdkO4eWzOxPQ8e7BEH1y1sIplAqxNP+2Y/WjifVMvg=;
        b=SKYK1koqKRU8ILVWPCFMz2hFueMQ03hzECDL4lQcHW0vRuK4/+JCpdF6ZnnpbyK3KA
         1tfrBUMR1jHT1Ks+iiaC3Ljcx2qEEhrPiStNGnD7BQuGTc3Q3plZqbfW9n80/CZQBToG
         aOi0i/H2xi3yFP3oNqSfVc2Nkv8ivHPiBnRI7rliIaygr7IM6t+rAAeevvtVTB+8Haut
         q0KsBkMYRQ4PiimrQZnuF8ck1Qy8Q+BRfdZmC9/ez4HSN9IHUkTOlE/zs9KSPV7/NfwL
         GWSVQkVVwSB93omIFvXebkbdmCot65bIKXcvGd4DWjcefWeS9T1xi7gcwu4PUk4RWDAU
         gDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143875; x=1740748675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxdkO4eWzOxPQ8e7BEH1y1sIplAqxNP+2Y/WjifVMvg=;
        b=dqP6RUcwzh7b2r2O8SD23zHEPau7TUh+ZWQRw2FGy+t2p061Fu/f0IABBr6buRn9Rz
         BBA991R7f9WPVydm/Y7T6DAIP2uq65EKPrZCnCNqHkcHHzrenPbA//igCosqLjMlqdtx
         dEb2r/MjCXW/NXFQu+pZeT+UpJ6P3EdVKAhUxSlOrWwddw0szwqelYr2hl1C7x9oFQX5
         MMcYVvcNA8PUdai+3P1rfiNDEzKKWzh0HAzFFSizy+JqQmKS8/h0D6hDiAIGcpIVKvOh
         DI1Bt3V1Z50OAhfBg57FC4cbMgUXNEbOi1GSvORu/RGG9t9bq6QDUhVAVMqCiJ76r1Dy
         DvsA==
X-Forwarded-Encrypted: i=1; AJvYcCUyaEKhNO4unm+h91uby5erwe+kqZFggUeXL2J58CkRzyk/d+HMEsU82YlVZ9sg8EYXZH+Xpu30@vger.kernel.org, AJvYcCVKhqVpYCSpYv5D5OUpvoOWGKcH9Nhxczl0EjU47tVmLWVNwlPfR7xehF1BBSdLUEuxnI0ps6pO9NP7aZs7@vger.kernel.org, AJvYcCVKzS8qfpEL7pX4SOf3eDaaHh1xpcBO+VwMNEI6YRJ1jV3Gbmng9AUe5i1pHerdVS4UPaluAYDZXmWcGyqqmpM=@vger.kernel.org, AJvYcCVO4iE/aqFoQhB4b9c6BeZpNhNlgIdiHL4p3cx4gG9FjJZu24DJgg0otWiD1amL3FNRfuNaigGu1po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9KYOC2cknAEkIGj7ciKvKO+amTWTvUBNqcFjYAx9Q5lNyUpL6
	J/+Vh3Vbu/6uSm5JPOubhJqi4JXUWu1CTok7JW7PDD2T5lolWaV/
X-Gm-Gg: ASbGnctPwJ6XlH2mrBbJqbvzwFgzTE+4be556F+yRSgW6LdLR9PMKGt7zMSTFDZIBfA
	5yyNCnh03TXBNyeRY2Yg2Hq98vf0qECGxv/iX8fihB2eMqwmBiBPyhpOgt2LB7pcVWpUBtFG1K3
	aEZ158Uduj/PE7gqVboBfQ+KDdm3kXAYwSRBufBM4HYcf30oyn1583uMTK6/7kF+oVx1ZNUaqSr
	2DQi4+51ljRd8rm9+pScFEGnh1Dlmaj5j3w5sEMH+I+mC/5BX/83hQ4x39TRxea/VMjUS41tptL
	wqDDtsDheArmqbnQBb4jdw76NczBgOEqMpGlwTbNJlf33KuPkkxr41Dyfyx5eRnl
X-Google-Smtp-Source: AGHT+IFEnb3Uy5SAyhF1sfaPGDZjAZ8t6tjaoxEn8/OFHajHLngrqu73q5GLsLafJuQQBeGZShNTew==
X-Received: by 2002:a05:600c:458e:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439ae21e4c8mr31896855e9.30.1740143874844;
        Fri, 21 Feb 2025 05:17:54 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce685sm17224815e9.2.2025.02.21.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:17:53 -0800 (PST)
Date: Fri, 21 Feb 2025 13:17:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Simon Horman
 <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Johannes
 Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net-next v5 1/2] net, treewide: define and use
 MAC_ADDR_STR_LEN
Message-ID: <20250221131750.0630c720@pumpkin>
In-Reply-To: <20250220-netconsole-v5-1-4aeafa71debf@purestorage.com>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
	<20250220-netconsole-v5-1-4aeafa71debf@purestorage.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 18:29:20 -0700
Uday Shankar <ushankar@purestorage.com> wrote:

> There are a few places in the tree which compute the length of the
> string representation of a MAC address as 3 * ETH_ALEN - 1. Define a
> constant for this and use it where relevant. No functionality changes
> are expected.

The fact that you have to keep adding 1 or 2 is a good indication that
it really isn't a good idea.

	David

> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>  drivers/net/netconsole.c           | 2 +-
>  drivers/nvmem/brcm_nvram.c         | 2 +-
>  drivers/nvmem/layouts/u-boot-env.c | 2 +-
>  include/linux/if_ether.h           | 3 +++
>  lib/net_utils.c                    | 4 +---
>  net/mac80211/debugfs_sta.c         | 7 ++++---
>  6 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index f77eddf221850fe2778cd479e49c91ad695aba3c..12699831e3c9fdbafd4862a339aea4ef04cf522b 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -721,7 +721,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
>  
>  	if (!mac_pton(buf, remote_mac))
>  		goto out_unlock;
> -	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
> +	if (buf[MAC_ADDR_STR_LEN] && buf[MAC_ADDR_STR_LEN] != '\n')
>  		goto out_unlock;
>  	memcpy(nt->np.remote_mac, remote_mac, ETH_ALEN);
>  
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index b810df727b446b1762a1851750f743e0de6e8788..b4cf245fb2467d281111001bb7ed8db5993a09b2 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -100,7 +100,7 @@ static int brcm_nvram_read_post_process_macaddr(void *context, const char *id, i
>  {
>  	u8 mac[ETH_ALEN];
>  
> -	if (bytes != 3 * ETH_ALEN - 1)
> +	if (bytes != MAC_ADDR_STR_LEN)
>  		return -EINVAL;
>  
>  	if (!mac_pton(buf, mac))
> diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
> index 731e6f4f12b2bf28e4547d128954a095545ad461..436426d4e8f910b51b92f88acddfbb40d374587a 100644
> --- a/drivers/nvmem/layouts/u-boot-env.c
> +++ b/drivers/nvmem/layouts/u-boot-env.c
> @@ -37,7 +37,7 @@ static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, i
>  {
>  	u8 mac[ETH_ALEN];
>  
> -	if (bytes != 3 * ETH_ALEN - 1)
> +	if (bytes != MAC_ADDR_STR_LEN)
>  		return -EINVAL;
>  
>  	if (!mac_pton(buf, mac))
> diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
> index 8a9792a6427ad9cf58b50c79cbfe185615800dcb..61b7335aa037c7232a0caa45572043057c02dde3 100644
> --- a/include/linux/if_ether.h
> +++ b/include/linux/if_ether.h
> @@ -19,6 +19,9 @@
>  #include <linux/skbuff.h>
>  #include <uapi/linux/if_ether.h>
>  
> +/* XX:XX:XX:XX:XX:XX */
> +#define MAC_ADDR_STR_LEN (3 * ETH_ALEN - 1)
> +
>  static inline struct ethhdr *eth_hdr(const struct sk_buff *skb)
>  {
>  	return (struct ethhdr *)skb_mac_header(skb);
> diff --git a/lib/net_utils.c b/lib/net_utils.c
> index 42bb0473fb22f977409f7a6792bb1340f4e911c3..215cda672fee1b5a029c2b61529c6813c0edab11 100644
> --- a/lib/net_utils.c
> +++ b/lib/net_utils.c
> @@ -7,11 +7,9 @@
>  
>  bool mac_pton(const char *s, u8 *mac)
>  {
> -	size_t maxlen = 3 * ETH_ALEN - 1;
>  	int i;
>  
> -	/* XX:XX:XX:XX:XX:XX */
> -	if (strnlen(s, maxlen) < maxlen)
> +	if (strnlen(s, MAC_ADDR_STR_LEN) < MAC_ADDR_STR_LEN)
>  		return false;
>  
>  	/* Don't dirty result unless string is valid MAC. */
> diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
> index a67a9d3160086ac492d77092a0c8a74d2384b28c..a8948f4d983e5edee45d90ad267582657ed38e38 100644
> --- a/net/mac80211/debugfs_sta.c
> +++ b/net/mac80211/debugfs_sta.c
> @@ -457,11 +457,12 @@ static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
>  				  size_t count, loff_t *ppos)
>  {
>  	struct link_sta_info *link_sta = file->private_data;
> -	u8 mac[3 * ETH_ALEN + 1];
> +	u8 mac[MAC_ADDR_STR_LEN + 2];
>  
>  	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
>  
> -	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
> +	return simple_read_from_buffer(userbuf, count, ppos, mac,
> +				       MAC_ADDR_STR_LEN + 1);
>  }
>  
>  LINK_STA_OPS(addr);
> @@ -1240,7 +1241,7 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
>  	struct ieee80211_local *local = sta->local;
>  	struct ieee80211_sub_if_data *sdata = sta->sdata;
>  	struct dentry *stations_dir = sta->sdata->debugfs.subdir_stations;
> -	u8 mac[3*ETH_ALEN];
> +	u8 mac[MAC_ADDR_STR_LEN + 1];
>  
>  	if (!stations_dir)
>  		return;
> 


