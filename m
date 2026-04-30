Return-Path: <linux-wireless+bounces-35718-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCN2Nn1182mt4AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35718-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 17:30:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8224A4C96
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E28D3027693
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025E2DA749;
	Thu, 30 Apr 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MGfqhAkY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F11254B1F
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562511; cv=none; b=ZlwsrmZN2W2wFX4sgpL82vlkySfz7zyn/BR8hcBp/8Mee6xCW3ezgY5WPZ1qRltVrjXUnhB78K/Mru5HsgNPkkp9gleNWjbzlLt6i9WqUbcXA9L+wylR4YeEKmjRHDAIgbUro5fW6TAgtzpwbZdttZ04VRCPDd009Jo3gfMvsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562511; c=relaxed/simple;
	bh=jfvurasXyO172rf8RueovQ21HocKi4qC6cmZUk6WC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/onXumDpEUrgcbZgp9i37g+UjWwVr0ueIkwYRXfaY4JIxIRGKkjTjfH7dCOL46murL//FT6gyp+FUsGzMrjIkh3HYkN073qFXxalzwAQ4rjv2n/gYyICLhn9t1BgAhQuZBD9cor91nbdLClSeXLnmikw7LELq3W+BXqTwaGELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MGfqhAkY; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so1214854a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562509; x=1778167309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6W7N3TF0u0m9VhuQZcYonFJHVZpaP1eZOWODDM2/uM=;
        b=Nlr+EUkm/dwtNvgfjyxC/f4jua0wXWfawKqKRg9zOndzx3b+O7s6pOSi71ghg9zS68
         0H0TOCJJqhxltaxk2UQFd9cbWrs1dEK4nT2EgvD4EhuV0s77hdEeMHBxMuMB7SiQhyBk
         ZfGxDlRoWVnXQ1vN0fmS3ssRQZr5SgUblPwQr7O3npvjr+7LJAXxhwDdo+5LIzABfv76
         mX6PR4pUryw2JJ8HBBJw3faNG/gY/RKXAdMKt8QECC7epi3KkSqeFlhRXqznvQkwPkWS
         A31O18hSUaWsx9KDRnMawfdQvq/PLVE7f6YVIWjycgZoEOGVs4n1AQcZ7bA0Lx5cluaU
         11tA==
X-Forwarded-Encrypted: i=1; AFNElJ+HG9+O/4+C4yvxp/+N02TVgnFTvK2osEweZMR2VeBPy3ibTz8PQjx80Wg19MDXSHv4gRNsijyFUz73qZLHwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WUJFDz2s2rDLkCCrSKSsO4R0pVg8uDXrDHgnME+aF8u8Nv1W
	EVBLDEW1hBkQ0uFiTsL6Zofk4gBQJhKZz8MHlFgTT0q8sCbpeLTSG6z6E7+gkOQKAxXJgKeS2q6
	HNHpITYhJJW7zIwcu2GPprV+deNzCZOFeg8JgiJkPVRrJthUfR1b5SUC1G1vxFAMYQz0GfqcwB4
	87zUoYaOtCEMRsyfMb1j+u+UvoqFIUXmncThpCZg10hSMObu0hl605Ah62Or2l7BUihtYtTO2ez
	hiBZAU2xVuWAZ1ixP9JcB6HFYbj
X-Gm-Gg: AeBDiesTNL9528RuoO+LLNYlP85COySRm90phBaGi7+lh46xrXCedihCmhN0SIRYfJ5
	TxisYagz4rzK2/3RnhkQpHmLg+ATynWjUjGw94Sz4G76+p7OZnUCRMqgls5NqqtXunG5kgA+xJs
	jPyp5Bpm9tEtoS5Sqw3SmnYoWI9muwIEdv45YMZZTbpRUK/PEvjCvaYSLTjsEdt1YeTYr3aS6Rb
	A3KBfX6fx0Xf+9WU7zfKy3Ndw/w0vdJixTUTztsnYKxZYetYd0s9lA+MCZA1YvbklbIkD+ne/DR
	fC0PKvC3rQjpaMYT2GkXLGqhShoTjdB8JmLXiT6sQ7XqzzLsq3F6+aSNDS9M4I7mYRbf6ywxYoT
	UkSwBXu/JbfVGNj5B9CdAkUYBkHHDKSLK7F2F8ol0DKfQOZ5CNyHR9+doDrnsEbpmbWa14wiy4O
	ott19ZCpOQYi+Q3zQCf0m/heJ0dT+176B+yBl4Jz85PVg9LLIuh5FalR7K9iQ8H3gL+JKF1NdQo
	A==
X-Received: by 2002:a17:90b:4cc2:b0:362:ded3:bbcb with SMTP id 98e67ed59e1d1-364c30df90dmr3506425a91.25.1777562509439;
        Thu, 30 Apr 2026 08:21:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-364bdc4211dsm283734a91.0.2026.04.30.08.21.48
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:21:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c20d5d7f4so4087895c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777562507; x=1778167307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6W7N3TF0u0m9VhuQZcYonFJHVZpaP1eZOWODDM2/uM=;
        b=MGfqhAkYKcVkIlprew8DDfV11f4dKa1ZBgf1i6N1rbvdBl+SbeMv/mv6RIleI5XogG
         QInMZEZz9paQa8uhaYeeyFDmgWV/f3WxMzpCuOCrBwFSMgJUBWswIVpdl49zX/1H+FbC
         NbbcKMqS/ZUFs/CiorAHaoSp9jYZKRw9V8kzk=
X-Forwarded-Encrypted: i=1; AFNElJ89h+eZ8nBFuVkLjlcmXzUXtzORjW6XoX+Ej053jf2HUUsAQL0+d6vy3NSx03ku0Kf/B4jnNoVWZ+QJOFpxug==@vger.kernel.org
X-Received: by 2002:a05:7300:fd03:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2ed3e386a41mr1602849eec.28.1777562094306;
        Thu, 30 Apr 2026 08:14:54 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2ed3e386a41mr1602745eec.28.1777562093564;
        Thu, 30 Apr 2026 08:14:53 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71ccesm286774eec.10.2026.04.30.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:14:52 -0700 (PDT)
Message-ID: <f817f781-43d5-40d0-9352-20769d9a6601@broadcom.com>
Date: Thu, 30 Apr 2026 17:14:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Steffen Klassert <klassert@kernel.org>, David Dillow <dave@thedillows.org>,
 Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>,
 Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Ido Schimmel <idosch@nvidia.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Denis Kirjanov <kirjanov@gmail.com>,
 Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>,
 Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano
 <venza@brownhat.org>, Samuel Chessman <chessman@tux.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Thomas Fourier
 <fourier.thomas@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan <zilin@seu.edu.cn>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, Philipp Stanner
 <phasta@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Yeounsu Moon <yyyynoom@gmail.com>, Denis Benato <benato.denis96@gmail.com>,
 Peiyang Wang <wangpeiyang1@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Yicong Hui <yiconghui@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 MD Danish Anwar <danishanwar@ti.com>, Nathan Chancellor <nathan@kernel.org>,
 Sai Krishna <saikrishnag@marvell.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>,
 Double Lo <double.lo@cypress.com>, Chi-hsien Lin
 <chi-hsien.lin@cypress.com>, Colin Ian King <colin.i.king@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linux-parisc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 5D8224A4C96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,nvidia.com,chelsio.com,huawei.com,linux.dev,intel.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,bootlin.com,seu.edu.cn,suse.com,google.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev,broadcom.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-35718-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[84];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

On 28/04/2026 19:18, Uwe Kleine-König (The Capable Hub) wrote:
> ... and PCI device helpers.
> 
> The various struct pci_device_id arrays were initialized mostly by one
> the PCI_DEVICE macros and then list expressions. The latter isn't easily
> readable if you're not into PCI. Using named initializers is more
> explicit and thus easier to parse.
> 
> Also use PCI_DEVICE* helper macros to assign .vendor, .device,
> .subvendor and .subdevice where appropriate and skip explicit
> assignments of 0 (which the compiler takes care of).
> 
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
> 
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.

for brcmfmac change...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
[...]

>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  17 +-
>   drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  52 +-
>   69 files changed, 1308 insertions(+), 1101 deletions(-)

