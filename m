Return-Path: <linux-wireless+bounces-1875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 155C382CBE5
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 11:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB9A1C21329
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8664B17BC8;
	Sat, 13 Jan 2024 10:36:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D020DC6
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d275b.dip0.t-ipconnect.de [91.61.39.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id EEBCFCECCB;
	Sat, 13 Jan 2024 11:36:03 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH V2 2/4] wifi: brcmfmac: add per-vendor feature detection
 callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240103095704.135651-3-arend.vanspriel@broadcom.com>
Date: Sat, 13 Jan 2024 11:35:53 +0100
Cc: Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A137AF57-B63D-4EE0-9A6B-7CBDC30DA82D@holtmann.org>
References: <20240103095704.135651-1-arend.vanspriel@broadcom.com>
 <20240103095704.135651-3-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Arend,

> Adding a .feat_attach() callback allowing per-vendor overrides
> of the driver feature flags. In this patch the callback is only
> provided by BCA vendor to disable SAE feature as it has not been
> confirmed yet. BCA chips generally do not have the in-driver
> supplicant (idsup) feature so they rely on NL80211_CMD_EXTERNAL_AUTH
> to trigger user-space authentication.

is there any way to tell if idsup is supported (firmware string or
some other mechanism). The just disabling and not implementing support
for external_auth is really having this stuck in WPA2 legacy world.

The whole out-dated firmware game on Raspberry Pi is already a mess.

My problem is really that WiFi 6E and WiFi 7 are essentially mandating
WPA3/SAE only support as soon as you move into 6 GHz operation and the
errors presented to the user are not decodable if you don=E2=80=99t have =
a
good understanding on what WiFi certification mandates.

Regards

Marcel


