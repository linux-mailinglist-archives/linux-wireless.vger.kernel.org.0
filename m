Return-Path: <linux-wireless+bounces-38668-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7faHLxuOS2rVVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38668-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:14:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7E70FB8C
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:14:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=HEu8BFF4;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38668-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38668-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F1353131A75
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10483191BB;
	Mon,  6 Jul 2026 10:24:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269839A4A4
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 10:24:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333492; cv=none; b=C7h4V878v1OSMw0w5+a0FkCYz6cXWi2my5XJCev22Cg0jMXXx2aw1XMB1CSFUIYSYY8SyoVIT8zq7DpAMXKrrAc9MIyqMe+/7fRiWajNRe8OfSwepVheHY5Stgz7oC/qxTRbJaonrsqaS3G6uT99jQNo5fAiS8yobjBN70ACIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333492; c=relaxed/simple;
	bh=O9Hfa8oC0u38UtQSZ+XZbruOQpLoF1g6Glx1EoeiFx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogq0MjttfofCfyeFEPHrrJ0HUSVMQQoVwQptfa3C7XB57h8TO3e14EV0o7advRTxSXQ879aLWGK+nPTYhtsmcsyK/8K+7lZWwz16/NW75R6rxk0n6KkNgFOZ9ZX6mkdB3sTX1nTQErraRpxOoffe52Si7t8t9kCBQQlUaquE5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HEu8BFF4; arc=none smtp.client-ip=209.85.219.97
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so19473546d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333490; x=1783938290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2KhUDOC7v7b54h9flInxSCdKtjGP9twprUarI6zHCrM=;
        b=rALBt5xVI4S4jR68Xe6CgcB0z18GVxqle0JOsQHG6pepTZI9oU1qffNoAxgTej6ENT
         OHtuEWrqHcV2X+vrk5lP7wOxeNg1XGxrSx3QUFkxzEI/jSD1ms/G5M1lIGzYV7+HPN2M
         oXrhYnpNBWEqogpyHaaXQNbX/yiPI0Kex6ksICEVkf9eDZix6++ZSudWsypq6/ls68Gh
         yLGp/AfS9CZRfWcgJBWqE/2BJqXtceBHTRgANTk3vmyXuLhC8WTAERVcjMCiKy2WQlu+
         0iJwwGmrw/y6CrnSBqlsoQ3Jvw+Y74IS3aC4mvBOkhOFe+b0VB1PczeX5fnXIdCl5uur
         ze0Q==
X-Gm-Message-State: AOJu0YxO1BIHN32N2x7mMxJwGOZt3nVz179epaC6nLVpUUfvDmREV9QM
	bM9WPwJwbLGi4Rea8cFr2zozC6MEwrj+e5LswRiuQ+vi9uFwtRTWrOc2oLCrWakv8PiFRZxCzBz
	qENkX41BW2oqp4ZHH0swET6dp+IURETms42KVuOmI2Ra0SM6sSwV6NuVSXC0F/RKQoJqVt/A/+j
	meQPVTTdaybm+psO418/r9mmx68YEJqw+54bHR/EqckpvlS260LasxfKQGgmWnBkzsseTpGJsCA
	LLobSI9P/uUcXAe1VTOv80mFREU
X-Gm-Gg: AfdE7clItDWm1fpZMits3MXLG65zWoqncDS3fvYJ95tvHTxt7+ahFes/NXxahOkknV5
	yUsjcpBP6WuWYEoFKZ65qmAo5Q/yuPmkcZxhlupDYxdXNHM2KsTHVQocRUJZWLtGVvwxlXHG55E
	HWL0l34Jv07WyMZn9+t6fq7WUH8vps1VWF0s9XfuwiGaFyRvZO1/hcdnSoawTIPaSaWcCGe+fTU
	dp/Ge9PKO1gW9t5GQpGFH80e2gq98vmZZVzA9YyrTV/nV0oGtw7ttMgezQcIDk0iPnB+kKQJuBp
	Ho18x90Gegojyocmu2fO+9setIFkEmt+YtTw2zOkUwPcpSqpw2N1rouEIekh+bcb6bqtgJ/lslX
	Hkl2HPtFMV2UkjnAn0nj6hRO4PD0x+IuVfcIK1HhRcLnyx/Su1ef8tz5JN+fjC/RtMuJaKfZTZZ
	X+f1er70m5pm6eQ6VnA6fYevJMSKLqbaTQGtZuSG3CdQi1QPphy7LK
X-Received: by 2002:a05:6214:2f01:b0:8f2:747d:3027 with SMTP id 6a1803df08f44-8f74adceb67mr143859776d6.20.1783333490002;
        Mon, 06 Jul 2026 03:24:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8f470695d24sm11019426d6.16.2026.07.06.03.24.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:24:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2caf4173b1cso54307835ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783333489; x=1783938289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KhUDOC7v7b54h9flInxSCdKtjGP9twprUarI6zHCrM=;
        b=HEu8BFF46d1M15YNGfex06ezgL8HmBvhALh48paEWosBS98DFLo581Lb9r0YPVixtm
         P4sdiKdeyMv5lkjkSz6JgIMeICUOphydUvS+v1+xvU8xJx8pCWfBWNqUQmpnbwWw+GhP
         IVRpSxF/Ull8R1r/xfHDytX8vV4ezgAJfIIZ4=
X-Received: by 2002:a17:903:2284:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2cb97e4428fmr100960955ad.10.1783333488807;
        Mon, 06 Jul 2026 03:24:48 -0700 (PDT)
X-Received: by 2002:a17:903:2284:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2cb97e4428fmr100960825ad.10.1783333488460;
        Mon, 06 Jul 2026 03:24:48 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85bde6sm81837200c88.9.2026.07.06.03.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:24:47 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Shelley Yang <shelley.yang@infineon.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	wlan-kernel-dev-list@infineon.com,
	Phil Elwell <phil@raspberrypi.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: 43430 and 43455 are CYW parts
Date: Mon,  6 Jul 2026 12:24:43 +0200
Message-ID: <20260706102443.1428484-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525083926.583964-1-shelley.yang@infineon.com>
References: <20260525083926.583964-1-shelley.yang@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:shelley.yang@infineon.com,m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:wlan-kernel-dev-list@infineon.com,m:phil@raspberrypi.com,m:arend.vanspriel@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38668-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CA7E70FB8C

On Mon, 25 May 2026 16:39:26 +0800, Shelley Yang wrote:
> From: Phil Elwell <phil@raspberrypi.com>
>
> The brcmfmac driver uses the SDIO vendor ID values to identify which
> vendor's driver extensions to use. However, the Cypress/Infineon devices
> have a vendor ID of 02d0, which is Broadcom.
>
> In order to use the Cypress driver extensions, modify the static mapping
> for "43430", "4345" (sic) and "43455"
> to indicate that they are Cypress parts.
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Shelley Yang <shelley.yang@infineon.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

