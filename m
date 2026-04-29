Return-Path: <linux-wireless+bounces-35581-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BhvLxnH8WnnkQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35581-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:53:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C20A491628
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D30C301B907
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F283B9601;
	Wed, 29 Apr 2026 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3UWQnzr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3323B38A7
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452808; cv=none; b=mCLj+TmZtqKYf7bdTgi4mT4CwlPCpu5qkxafE2GD4oTiAFifXgV7askZ5HbRWFb42EVTgEVpgBKqOyq8Dt7ieJGVoX3LPlaNZkZC3QIoyU+X3gdL9qmB4WyhFQueA+Uksc+xJjJtlA6p8yRTuB4lfLGKzvFT0WRQVji1UBHvpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452808; c=relaxed/simple;
	bh=OJw0cqLkYrPfWmxwpz5gJ+Hg/xhQpokAFPoJSwnJrOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k//H4dniKn9HclyDlh7S4lUtMOCbUjbYC41nt1ONt3HUKuWLP0zaGQeYzAezVU/kZyo/rdfFzGk3qllJTXZwINJgqKMRrHGWpjquBzBvDAWyuWnGWxrd9gixPjYbFgsr0VHKMlqYOvr2hV8mL4I4B+9jMnI2UHsIZgHRDgKHxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3UWQnzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CC0C2BD01
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777452808;
	bh=OJw0cqLkYrPfWmxwpz5gJ+Hg/xhQpokAFPoJSwnJrOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y3UWQnzrugN9g7H9n39KSSumKtrAVIdasAppLHzAlH98NZkxwIQz2dEqFdm+0df1W
	 nb+rlwCt7e+lTtWWFXouOLexr04e7b7VqoYMY+vrlNjtRYIQMy5/ihOgrMObbCxrUy
	 vzs/cqUMvxmgr6U87O9FjjAwe3huAVPGxywkpcRpDyslgiwKHty6inVTVwN5MT1YoS
	 slP/fC9hAONh4xPfd/JmQgv+0BiiJvf43VIUHyOXKpTf4Nd94qgRkCxESRMmu3v40h
	 yKOBB/8fwhJvYz385/Y41mkLaA8qOpejbv3ED0KmtWvFIsAV0JtNNBsnZy2JWSLz5B
	 64hwJtq4rBNzw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a62f43b76aso6710017e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 01:53:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9r7R0VeaswDZZxN9V8WA3CSgQqZ7+TfbrmtgzV5vKBoL3ousavdDFWjLBfj74mCccXqO6vfsk/w/pdQwji6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwKs9AnABQ3PaqfBmM34zRYL6D4/pHEu6Db7HIWSHvE+HPEfD
	c1mAGGZkZhxcHsbWCwwqVI0/p7i2XnFtP2UrFAYNvDxirFVF7b+xKcxQiJZJaOXNEzAPW08U4Gi
	ek2STZYDbmiiBQ+wyiJ+mqKo+OzSAGXqfeoukbz2HLA==
X-Received: by 2002:a05:6512:2256:b0:5a4:2cf:601e with SMTP id
 2adb3069b0e04-5a749cf3d3amr1183325e87.12.1777452806809; Wed, 29 Apr 2026
 01:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com> <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 29 Apr 2026 10:53:13 +0200
X-Gmail-Original-Message-ID: <CAMRc=Me9G9vd06a39vi_UrXCTkUtJQRogm2MqgnwLS_r3Thyzg@mail.gmail.com>
X-Gm-Features: AVHnY4K2fPfnriRCC1GlEFUQD6V4mQElLKoEhFKcWJOmHGXZy_EUPGrUvrMD7WI
Message-ID: <CAMRc=Me9G9vd06a39vi_UrXCTkUtJQRogm2MqgnwLS_r3Thyzg@mail.gmail.com>
Subject: Re: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3C20A491628
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-35581-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]

On Tue, Apr 28, 2026 at 4:23=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Some devices store the Bluetooth BD address in non-volatile
> memory, which can be accessed through the NVMEM framework.
> Similar to Ethernet or WiFi MAC addresses, add support for
> reading the BD address from a 'local-bd-address' NVMEM cell.
>
> As with the device-tree provided BD address, add a quirk to
> indicate whether a device or platform should attempt to read
> the address from NVMEM when no valid in-chip address is present.
> Also add a quirk to indicate if the address is stored in
> big-endian byte order.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Is there any reason why we can't extend the existing
of_get_mac_address() with another property name and use it here? It
already has support for mac addresses from nvmem.

Bart

