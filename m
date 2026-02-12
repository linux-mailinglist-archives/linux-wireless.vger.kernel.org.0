Return-Path: <linux-wireless+bounces-31756-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fkWMB2l1jWnN2wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31756-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 07:38:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92E12AC87
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 07:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D22630177BC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DDC29AAF8;
	Thu, 12 Feb 2026 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FsQA5+xI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5719CC14
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770878306; cv=none; b=uC2tTmsFis2QxDVHeyvUvmE1TxL4tRKyUYEnYFSv4RgIXraEnLkSDgYtkGWZ0h2GkhXSBHt1HY5sF9EbtxmaNuhzWNLdYmKlDzgLhcCuEsh2C2om/RLjNfTOPXEvo6jOIgXTvSbYxFoDeHVBGzQJKzCfmXx1oiv3QszAH4AO9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770878306; c=relaxed/simple;
	bh=tCxxY3UDXOguCn5Z6PMX8hLpOHU+oxvdtRMs/2XO+EQ=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oNnUv2/wUSN2J0jkw9DljpsPVxAPjO4FHt5IC2ncNynmGS7ASdcdQ+BnuVb36hHZhdclS+eWDJuSFW3ELZceiGKdDh/ZEJrvmUE3rGJWKgZ0h9LRdAKDFI5VYXUP5WeOp85Y+33NRaEQZp6BEY9eVRJPtuaKWGLnHPlzLW1Y/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FsQA5+xI; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64ad9fabd08so4595359d50.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 22:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770878304; x=1771483104;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNM/BrzTJVVndX+x0JaCN6syaAPmeFxITXLSICcILmM=;
        b=COcxrnY8jdyTMgJsNj3SgY7w12a8gXaXuhGrz3Ho6Ge0PTagTuS6Wq3LjSi+N8P/2b
         oq5KR/Y1lmMh/pIso+9Js87nP5S5JYRFwum3B+KlN58FJJK/dINW/ywIh2IGeLLmPbuM
         G92ySYpIYP1XHlscrAvvt3eMz/IzE9ssN0d5lsr1SIerUt8/I5EXmVVj8JGqUXI/xu98
         uusrKItYLGBfPDPctgP1atnBR8kZTMTD8bs/dF9q0T5m9TovDdKgTemRYyiUgv/NcfXP
         +9+57lIEHxdo3Ah7wvCvxcNWVt6e8WY4qmSSC/PrVWcmW1vvo9qQwAiPZWws9W9gz/h2
         6Eqg==
X-Forwarded-Encrypted: i=1; AJvYcCVo6dTKp40cQFxQzpsKTQ5kQyMrgw7eXl+QA5NJzwrdb6JBKfjjwERWkks32ShfrA9v9dSfEkF8CBo0qlnSXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzScSKnjtTWY3F8/Yb8tegbYG8RhU+eOWAxRYexeZRS2J7Zq9rs
	fJfxr2rtMKqwZkr7jfXdThUcRmpWppqJuAHoW1xDYaaia+QPf0g/AkKJgfsixq7NLprpnww9Wgn
	GrR6RmpksPF2NWks2maXOYwUlHeIEoZC0e4ZP1PpGb6z5Mtz26w58SYcaUUMQFdndmspRB1+DD5
	+JuFdENWtf02HaQGOLpraHJBrKyB/BnqqzGMlVzW4JajXN6Ojz02+Bq+SsgGgw4Mc+RRLxK+fU6
	zGm88OIudi7762eFc7qaBlishK/
X-Gm-Gg: AZuq6aKhaymUhuiLXNCXzJVGUPf1JcDyf7kZtDyNLhwACyBiY03CClwZ96OGEBJGbs5
	Arn9B3v3B8bF8YaL8iNTDxp3ladd+VHjeNmUpnid4JpbgTcZAfYEh0vzTMGnotihbKBa7kuvYiO
	d1TGfQfxzx+wLZtaKVw3ZMPB524SazrD07lc7X4J869Hg+wSrqRKTnDC7Ua7jrcyg/PnFcj+WVy
	S9S9OepPTYk4kWovQUivikv9fVUFEQsMAJ5y/O/+mtY2BjOXgRpcWygiGGBx3EanO/9wd50eGMV
	uVaLSFct3NAp3EGqwOATqzY+XBrJUlyxPlxmM9gyNT79cbXp7DXoC0h50X2bTb2JF3cj5ZB9umP
	iy6qp9I405kK6anZBuKics8YYDHX2OFGZM21wn0JuuqiRMQZib2uKj4oDfnLBNwG1rqvP+hsrwV
	WRVEOZaV+nz7C0sNDS+lwfvLKvUKX9YwuGmVUvB+MWHKvML7wpiAp7+R95dQ==
X-Received: by 2002:a53:e1f9:0:b0:64a:db76:da1e with SMTP id 956f58d0204a3-64bbaad4751mr1110995d50.53.1770878304181;
        Wed, 11 Feb 2026 22:38:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64afc73c36csm356968d50.0.2026.02.11.22.38.23
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 22:38:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba87c0e198so2155143eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 22:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770878303; x=1771483103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LNM/BrzTJVVndX+x0JaCN6syaAPmeFxITXLSICcILmM=;
        b=FsQA5+xIUhwYPR7/RxVeXYTKMX/E5nES2bQuA946yAGU+YojLch6anzmsJAx6y+/N3
         AntK46A1B54R6QGR+lJHOLpixaDcjXz1EwMggkxwaJeNUWEfDoCH0+5J4BvPZXaVfluT
         y0H1D9QfYtW05osVgAV9zu3W+MUwgKRYiiDBQ=
X-Forwarded-Encrypted: i=1; AJvYcCWBgouqTO744tyxZirB/maCfpWgsyTAxJG4p4T7TdkFeXIQe9zRZP0Z8SG1V4HwAU1A5UXDLPsqSJ7cfdlkxA==@vger.kernel.org
X-Received: by 2002:a05:7300:572c:b0:2b8:26b8:3446 with SMTP id 5a478bee46e88-2baa7f6d670mr760882eec.2.1770878302853;
        Wed, 11 Feb 2026 22:38:22 -0800 (PST)
X-Received: by 2002:a05:7300:572c:b0:2b8:26b8:3446 with SMTP id 5a478bee46e88-2baa7f6d670mr760876eec.2.1770878302298;
        Wed, 11 Feb 2026 22:38:22 -0800 (PST)
Received: from [10.229.40.11] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dbcc02bsm3373410eec.8.2026.02.11.22.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 22:38:21 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>
Date: Thu, 12 Feb 2026 07:38:18 +0100
Message-ID: <19c50926790.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20260203102133.1478331-1-m.szyprowski@samsung.com>
References: <CGME20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59@eucas1p1.samsung.com>
 <20260203102133.1478331-1-m.szyprowski@samsung.com>
User-Agent: AquaMail/1.56.0 (build: 105600589)
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix potential kernel oops when probe fails
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31756-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2D92E12AC87
X-Rspamd-Action: no action

Op 3 februari 2026 11:21:51 schreef Marek Szyprowski 
<m.szyprowski@samsung.com>:

> When probe of the sdio brcmfmac device fails for some reasons (i.e.
> missing firmware), the sdiodev->bus is set to error instead of NULL, thus
> the cleanup later in brcmf_sdio_remove() tries to free resources via
> invalid bus pointer. This happens because sdiodev->bus is set 2 times:
> first in brcmf_sdio_probe() and second time in brcmf_sdiod_probe(). Fix
> this by chaning the brcmf_sdio_probe() function to return the error code
> and set sdio->bus only there.
>
> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")

Acked-by: Arend van Spriel<arend.vanspriel@broadcom.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changelog:
> v2:
> - changed return type of brcmf_sdio_probe() function
>
> v1: 
> https://lore.kernel.org/all/20251231143544.4158840-1-m.szyprowski@samsung.com
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 7 +++----
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 7 ++++---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   | 2 +-
> 3 files changed, 8 insertions(+), 8 deletions(-)



