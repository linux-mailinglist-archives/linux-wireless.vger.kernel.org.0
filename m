Return-Path: <linux-wireless+bounces-38443-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XZUGOv3lRGoi2woAu9opvQ
	(envelope-from <linux-wireless+bounces-38443-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 12:03:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7816F6EBDA2
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 12:03:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bcxMOZy9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38443-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38443-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 122BE302A781
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC8440C5AE;
	Wed,  1 Jul 2026 09:59:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043840B38C
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 09:59:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899960; cv=none; b=G0lVsU+gs65TzsvztzZqRRxsTK/AaSBwT4sI+Tb3UN/WoxL5xOl89n3GEl3w9tbmDgpVrsXOv7qlX9lITDS5BFa7c4I6+2/XQ08RNnwN/6ZA37h7VAm0NjGXXV7fr/LSuviH9xGCwH9aploI1zL0nW138QdVV94e4FZeGbdq+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899960; c=relaxed/simple;
	bh=KW9lh2K1hAahuirGr9kTW9/S1N/x4cAospR02gArHJ0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAegyI0RHESrmNVsMll7d6566vG2KnPAsYUwamuRMnJHp5+TWnr/y9uQhg6bYw+rNzqjnDPEXldJDMiTPUUBTXVM1HmIBZz1Vu8VpqsrBAIcp3xbjMOle0/G8aMzwc/4BubEebD0cfBAXh22NtiY3vQ5hvMLJkygFlxZVid48Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcxMOZy9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9D21F0156E
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899957;
	bh=KW9lh2K1hAahuirGr9kTW9/S1N/x4cAospR02gArHJ0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=bcxMOZy9+wUR0cIUa+U1DVQq23msK1GibupFls02SsSVec7WdoW+TaetCQmXuipta
	 75k/2KwNSJr7otVAL4jymBh8anWy6sHRyFNjlIDfZmbmDfCTNsStAcOhv31x0ivjQf
	 ooL1jlEQVfHJR53vjnmqNJ9OthmUgRGXccG1cosaT90q7Jh7xUooxf99keLu2hIfL8
	 f81yxjgpJIHT0GXG1uSI+WmPQIl4G0Kieunbvsnd2Yy6HVPRSLyxlMOrRUjvg+fVAl
	 DUAWcbtn/H6ycrJNXoKzsP8lYflD/0GOP+hByBLl57HhPfnuqXzEXLvtq/Y6fM2GAv
	 eqFtVbdgNSa4w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso442014e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 02:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpnG98ZVe9C9FLBrEBzo39WSHvMwfUpeznRHWI3PlDH0yVpjFuvgDegHV/1lHija1t15gQrSmkjblthPnedxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRhbsLishG+JoAi8xsH5rI4pLxrjfAv/OMqF6RxDa+g8VXcb+
	Yewe/MNnzy9k8K9h3SyCcF5AUhXE5q90IgaRQOno8JwvjmN04pIXpFRJ+oXI6KVhkikQtE0I1gw
	e3YE330S9vSccJRnyztzwTx9xEdq8sl2H6TfEQn8bKg==
X-Received: by 2002:a05:6512:2585:b0:5ae:bcf7:a741 with SMTP id
 2adb3069b0e04-5aec67a5104mr254124e87.18.1782899956542; Wed, 01 Jul 2026
 02:59:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:59:14 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:59:14 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-2-02770f03b6bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com> <20260629-ipq5018-bluetooth-v2-2-02770f03b6bb@outlook.com>
Date: Wed, 1 Jul 2026 04:59:14 -0500
X-Gmail-Original-Message-ID: <CAMRc=MejBiWKB74bz9ZD8HWgm+ZGG1ed7rRJsoaPFZcRWzC-kA@mail.gmail.com>
X-Gm-Features: AVVi8CeyT1GrSjfr-2uV0qlk0nwk3b4g-mFQbPvHBLEEqLDXk1SdAU72dFgl0qQ
Message-ID: <CAMRc=MejBiWKB74bz9ZD8HWgm+ZGG1ed7rRJsoaPFZcRWzC-kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] Bluetooth: btqca: Add IPQ5018 support
To: george.moussalem@outlook.com
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan <saravanak@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38443-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:devnull+george.moussalem.outlook.com@kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel
 .org,m:luizdentz@gmail.com,m:devnull@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,mail.gmail.com:mid];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,george.moussalem.outlook.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7816F6EBDA2

On Mon, 29 Jun 2026 15:01:45 +0200, George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> said:
> From: George Moussalem <george.moussalem@outlook.com>
>
> Add the IPQ5018 SoC type and support for loading its firmware.
>
> The firmware tested has been taken from GPL sources of various router
> boards. Firmware files needed are:
> - qca/bt_fw_patch.mbn
> - qca/mpnv10.bin
>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

