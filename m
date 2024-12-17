Return-Path: <linux-wireless+bounces-16466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AFE9F491F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 11:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DD41882EF2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C51E5721;
	Tue, 17 Dec 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dZsHYjmk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953D1DDC3F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432192; cv=none; b=jyz2G/Wu+ZuXZ8wc040Cd2Aw5aNimj190ZzHv8tSL9VJpu7Buj993CjVafoc6VPgaWsbuhBGHK29qsS+arGDzL+Jixb3FkLB3xpyb4VYEIWk9YXrjoW6dLvaqgYxI3TlSX3s+nBEiBq7G7jAxVMxuq/K53wfP14N7QN2Ym4kGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432192; c=relaxed/simple;
	bh=y6kN0ytC+JEAm663I+e3ce52E/uTgwxjwdVw6gidIJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHvhN1broOX9ESqSc8cjgOv57ZU+ECQaaSFQUKHRcX6AL72Uyy78XnPgxzIvhM4IllOueXROZQWoag6OaeKTPPwYRp0XdrrGbP9FDJgvllZpg82s9YSTO4b5keuuoF7T4ULGR9sE42TJFpfsLNLUTYSBQMdeAL+ibCE1+ghXLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dZsHYjmk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361815b96cso34051265e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 02:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734432188; x=1735036988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=dZsHYjmkhvWBVsm2tNMZTYJ6fifUvbeljbA9rzuGPR4hxzY9sTa1bgk/BveyCJn/Bj
         010mgKQbGqWAeVoFnqoxUE8FX0smvn9wMVd8zLeNMV24ZhSGjjzHDVtstCR8LNh+dOQt
         RQKEHwEtPbCHTIFgMWzJwak1Sj1f5c71F8Fz8X2nUb5qtVihBlaJQ/dkqeAbhgbBxC2e
         bDL6ufuTtwJ0M7OtKhA6d7ncZ1Tf0zrYh35377rPYi/q5NqCA73aCAc2pj51VmqrV2KO
         YO6CUv3jdCn+/5p/brlrKV8WwhevbP9z6V3pTnZU0dVjSuF16UY6u3A3ZdfpCfxcO2+o
         GDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432188; x=1735036988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=vDHev+Xkh5JD43Qc9QCs2yjif400Lll8YEuVe1He2JMM+S9TAq+A7RAQzzTA1emN9k
         a/FLvlZkSATE78QnV2J0xmXwBXxH8JWfe5oSCAj1QxDngv9kBSEtck29/hcKVIudPFsw
         TLBv1BSpxgGuFVTqZIXHBuPNy4hVip8bzsMbzv/BcYA+B3w543PLjAzKmOpF2XhhRqsH
         bwW6BXD+3HiFV/0PKA6OrvQvgzPgHK3AWUDTARA+km1DipW1jxnE5fXKzkvRUaiLXZut
         YZpB2qZKrr5eng80cn6MipMU5KWrKsFiagUoD5/CulgbdMZvC5qdwc02cbno7eTfYM9B
         RVSg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/OyaC6JbTeAvcIBjnu/h2o04QgjBUOfxVFrJbM1CvY1hmxgJzM9zL+IuzOKb23DXY4NQdZs+Whptvmr5+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRch1iLLc0rgXpNNNB8Xry7ONLfRIFzq5NIqxgDUNfnFMSO8K
	ULkZnEm/MsKf0xpjyquRBn32I17QDib2DMMK38CkIrRDGBp9KhWiWpF0t9UV1Zs=
X-Gm-Gg: ASbGncu/OxTJE/GFqr+vLQJM0klLh+0Q2XUV/wjB+9VG8XJ9wNiu82Zyz8SzHTMmSVT
	nGdRn2r6nfXQbzfZLBVhQUOFG17IX25DyBnJKdD3R0GNDF+zoViX72E+4nm4V96ZKOI6liEpkbc
	UjnGh88Hyhy0ch1p9Y6yLi8CX0bPJGST7JQV3JYpX/rk2Ovb4jcUqUz/JJzQLktMaxD2FgYxtG5
	pjCE4BUV86L72V/D2jH31ACwPWQDKFk0A4iQb/PH8xkuiqNd72O/5OUjA/F4rZ9+Tt+TLTNj/HW
	NxY2Z22Y06SQ
X-Google-Smtp-Source: AGHT+IE+WugOposmvo/jcHeaw0Ch/ihxlIzSWqzgKieKmOo/fttsPn7O0uxSSG2XNkVbg/PrQmJctQ==
X-Received: by 2002:a05:600c:8715:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4362aaa8b9fmr140737975e9.29.1734432188304;
        Tue, 17 Dec 2024 02:43:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706595sm170469495e9.33.2024.12.17.02.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:43:07 -0800 (PST)
Message-ID: <66adcd4a-d4ae-4dc6-a706-2761efd5084a@blackwall.org>
Date: Tue, 17 Dec 2024 12:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: bridge: constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shahed Shaikh <shshaikh@marvell.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/24 13:30, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  net/bridge/br_sysfs_br.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c7e7feeffef3c993404529ba88559..c1176a5e02c43ce32cb3dc152e9aa08eb535a419 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -1002,7 +1002,7 @@ static const struct attribute_group bridge_group = {
>   * Returns the number of bytes read.
>   */
>  static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
> -			      struct bin_attribute *bin_attr,
> +			      const struct bin_attribute *bin_attr,
>  			      char *buf, loff_t off, size_t count)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> @@ -1023,10 +1023,10 @@ static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
>  	return n;
>  }
>  
> -static struct bin_attribute bridge_forward = {
> +static const struct bin_attribute bridge_forward = {
>  	.attr = { .name = SYSFS_BRIDGE_FDB,
>  		  .mode = 0444, },
> -	.read = brforward_read,
> +	.read_new = brforward_read,
>  };
>  
>  /*
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


