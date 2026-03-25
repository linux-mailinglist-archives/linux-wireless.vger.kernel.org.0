Return-Path: <linux-wireless+bounces-33859-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL+FA0AbxGnlwQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33859-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 18:28:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A2329CC0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED7D33040E4F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783E4035DA;
	Wed, 25 Mar 2026 17:24:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52B402B8F
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459496; cv=none; b=dTtxVMHj6VwaNr9YjqMH8se+aZN8eRriUw+YqempW6QIof6BZ9cqF+93kM5u8jN/7911h/VRzsrWxEqXqTCuBt0zA8EMStESCWKaT6ZaYF3O79VvFkej++HHe90QZsApSy8uqmaGwwrw6hMlsnDlqZc+EmC2RBCFBUcGKwI0UWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459496; c=relaxed/simple;
	bh=WJCHadKIGcaNougMBQMInd24II9CRRJ+fXNCPrZLcj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGh/FobFN2GMDz5Y2LzoxBHVDk7H03sEqrqOsmjztqI2/bmryi3qi05Wwntl6hP2qi+28CRQKUW7PNXFQak7wRAin2x14xvlDsUuzzqBxcSGJkop7WKJUitPy0R3402puFdGPtEvcFOuqbtORe0mWKMGNEYtt/o4D3hNXAFVAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so1569465e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 10:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459489; x=1775064289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiw/GUjidliX10Xt88+2grOFSA9ojrEc+pd+AHSqD4Y=;
        b=bJsbsjefMOvr2V78GTs/bUqZc5Sbj4B/NKtMGu/sPBx30Mmiu1OINDmsa74H//60xi
         iK76ML6h3slMWJKgOpIAx8VziY7an6eCqBvTLtoDeHx0tjKFhSzYI8TYm7lzGTPq8qDr
         rgkbJxcpWFcEiZajzGN6ObAVZyJcH5/hsgoZna0ZwQkWBZbs6uOBM2cxNCgsGpZ8LjMp
         UweWSAYFOALOIpSlrKv3S4OHTgBeS2PWKf874QO9g1+r6x/JKSME2QJrRxs4W532/KsH
         zoI3L9a0H3FwhwgO2D4G2Xmi0RQT/x8st9vyIH9vmA0vWf0MXhmzkBz6F8eodoZLmex8
         ZxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyfjBpsWQkJ9lfioOkHTxByzvpL6oiemcGyQVp43hn1bgWbQ2ESQIbAfJlWoRluXkM0jz4KwSKI3IEvT+fbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwblbRJPse2hoM+o8Nvlc3KNJFKrRCuW41kiI/kQhvPUyEKyw+s
	492vHDZ5PEtES5KS18t1eThroek/Qm6LeT+6iNHcMVjG/1ASrGnhg/5s
X-Gm-Gg: ATEYQzwoUunv+gDnHre7+OCZe/lxy1RWYFDIyutAqDT0iLDxijqxjAz5e2r40hN4qQU
	lPJANJPiL0l9uqKSKn+/CGAnNXwTm3a0xtQZ/lxSQ8HR6TpIhWYRFiFmLSOd5LoKnEidkZUrf84
	WxvRGBLzVh7NW5NmvwJPYtZFnMdqwOKg3sZde7fQw2llF3+4GtCHWNmpM3nNCaWDOKbU3HQk3xO
	oOKjHqY1kTIJ9CCma6sec/EWEzQboGz08keXnpdvuuTpj9ZInf4zm71vzKocv/wJ8g9ZXyEpXQ7
	ih5m5LX5i12TlDoRpT6IyLLgpr6ZXK/Ev59zF3a4l2Og4fqrQz4nd6mh8MWDBvugtf87tZlJd8E
	GRGf9/Bio2FdQ9mbDlDbp1ElQZioQ6dx+USEtyb5Eky59DnAeQN6SxHaX4/0dhU5hmcbx+/s8p3
	JPnXUelAqcd32RsEQqM/c=
X-Received: by 2002:a05:600c:4705:b0:485:a4de:f4f9 with SMTP id 5b1f17b1804b1-4871608406dmr70720405e9.27.1774459489238;
        Wed, 25 Mar 2026 10:24:49 -0700 (PDT)
Received: from [0.0.0.0] ([94.156.174.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871e5d195bsm8481415e9.3.2026.03.25.10.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 10:24:48 -0700 (PDT)
Message-ID: <76bba9e1-1e87-413e-94d7-80e7c352a55b@linux.com>
Date: Wed, 25 Mar 2026 20:24:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid
 use-after-free
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Ido Schimmel <idosch@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Greg KH
 <gregkh@linuxfoundation.org>, Johannes Berg <johannes@sipsolutions.net>,
 James Guan <guan_yufei@163.com>, Kees Cook <kees@kernel.org>,
 Paul Moses <p@1g4.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org,
 notify@kernel.org
References: <20260324224607.374327-1-alex.popov@linux.com>
 <fa3c91c3-9ceb-4fb2-9250-cc239fb0c1b6@lunn.ch>
Content-Language: en-US
From: Alexander Popov <alex.popov@linux.com>
In-Reply-To: <fa3c91c3-9ceb-4fb2-9250-cc239fb0c1b6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,sipsolutions.net,163.com,1g4.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33859-lists,linux-wireless=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[alex.popov@linux.com];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.com:replyto,linux.com:mid]
X-Rspamd-Queue-Id: A46A2329CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 15:34, Andrew Lunn wrote:
> On Wed, Mar 25, 2026 at 01:46:02AM +0300, Alexander Popov wrote:
>> Currently we execute `SET_NETDEV_DEV(dev, &priv->lowerdev->dev)` for
>> the virt_wifi net devices. However, unregistering a virt_wifi device in
>> netdev_run_todo() can happen together with the device referenced by
>> SET_NETDEV_DEV().
>>
>> It can result in use-after-free during the ethtool operations performed
>> on a virt_wifi device that is currently being unregistered. Such a net
>> device can have the `dev.parent` field pointing to the freed memory,
>> but ethnl_ops_begin() calls `pm_runtime_get_sync(dev->dev.parent)`.
>>
>> Let's remove SET_NETDEV_DEV for virt_wifi to avoid bugs like this:
> 
> Did you have a look at all user of SET_NETDEV_DEV() to see if there
> are other examples of the same bug?
> 
> What i found was:
> 
> https://elixir.bootlin.com/linux/v6.19.9/source/drivers/net/ethernet/mellanox/mlx4/en_netdev.c#L3180
> 
> Does this have the same problem?

Andrew, I can't say about this particular net device. Looks like it refers to a 
specific ethernet adapter.

How can we distinguish security-relevant bugs similar to this use-after-free:
an unprivileged user must be able to create a given net device via user namespaces.

As I mentioned, applying this fix in ethtool could help against them:
https://lore.kernel.org/all/20260322075917.254874-1-alex.popov@linux.com/T/#u

Best regards,
Alexander

