Return-Path: <linux-wireless+bounces-36223-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPxJIi6xAWppigEAu9opvQ
	(envelope-from <linux-wireless+bounces-36223-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:36:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978150BF89
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17AA4301E9B7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549E73D891C;
	Mon, 11 May 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTuAx685"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F53D8117
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495783; cv=none; b=p4iOfb6BYQidHROJ4zEs/Sml13dj9mjNzRIL1RoXAzkvdxWYuJZlhKX5jUS6EODJFzRVpV7oN3QjwxHrRApBxMifSoXL+W00pua98evBaNxgUoWyaTpUn4U/uTmSv48/pZFC3ke1z8A8q7zu2UrFezgr9T5USsvKcVJe6+NJj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495783; c=relaxed/simple;
	bh=IENORfZd5dSYQkrNitKAXWYKfDtZSTBMvfDRDDw/UDU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBtIyWLSs9RlW+BWsia/KsKT9ZCNWR9PvJ1fXLfxGL4bric4XPxG0vJfYXK9WRu7r1sueH/jBHuOqmZpCNMIEwlONGhH71yAgea0rOARe7kjC4E4ielUMC02Rn7sGaOK+9/L7kuBuJEKSgsvtySF+ttLE9udATQmyRo5ImI2C68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTuAx685; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6072C4AF0C
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 10:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495782;
	bh=IENORfZd5dSYQkrNitKAXWYKfDtZSTBMvfDRDDw/UDU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=UTuAx685dUHhXY1vmr4J20mhBA7yb5/tBU2HA3whjbnByMPWJp90i2ZMTYOSC0EeA
	 Wwl8i9/vk8aPLtXV1CowQWl6Ut8EyCvV2uU6bPQPmeM9W4L++LuVWNXWs15zLAhMUG
	 oe00G4W2qZLaXZCVpfV7uH9nxTTUHzoc0M9H72ivRlX/NAn3LVomvj2CJasqtJ1WUm
	 tPHdaHVYOtydmAMXf3ylAL2/vQdBzceGQOLw5N4QZSIQZSl3MSH3Ei0GcJVr/pOvgN
	 wiLfPjS7r8jPIGlFPwqqGobTQsXEFTmIUQ8RK3Qa44ZIevkoE2xiv28sEybqbi+4d0
	 h9EytHNbVCG2w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a525aedb24so4085008e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 03:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8YMRDIfgorVuLY56scNjqkCgj3SA0WBeK6Hyt9CeHOn6Di5hlVMf7Ut6iRaWtZkLvFm0DWKhgcwEXakxQ2CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKIKmv5YoEGbay7rg0eB7Ao8cRm3nq0ZTf4huYTjaI4bZ3aiW
	Mya/R7VfuiJubbX8IwUpwoVDv9HHxBt+h11+4mSR7AsQ7MBG9UMUlnV3ATkchqaJ5mhdqGiGCV2
	GXawglgXcYxThLzGAXIfnqrMAdR5xbjD//I83pv3t/Q==
X-Received: by 2002:a05:6512:3e1c:b0:5a8:b966:7b1f with SMTP id
 2adb3069b0e04-5a8b9667b9amr3508208e87.16.1778495781398; Mon, 11 May 2026
 03:36:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 03:36:18 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 03:36:18 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260507-block-as-nvmem-v2-5-bf17edd5134e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com> <20260507-block-as-nvmem-v2-5-bf17edd5134e@oss.qualcomm.com>
Date: Mon, 11 May 2026 03:36:18 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdi5DuwhewSpaPCJCWWkmw57pLPx3snSyV_gtBN1gWtMw@mail.gmail.com>
X-Gm-Features: AVHnY4LRJOdRAiXXJAqk3x0LB0U9Hhhkl-SHYK7hw0ni4PNj3Dx_sfKHg57uYFk
Message-ID: <CAMRc=Mdi5DuwhewSpaPCJCWWkmw57pLPx3snSyV_gtBN1gWtMw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4978150BF89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36223-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, 7 May 2026 17:24:40 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Factor out the common NVMEM EUI-48 retrieval logic from
> of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
> accepts the NVMEM cell name as a parameter. This allows other subsystems
> (e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
> different cell name, without duplicating code.
>
> of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
> "mac-address", preserving its existing behavior.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

