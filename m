Return-Path: <linux-wireless+bounces-8767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F19027E3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 19:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B671C217A4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9291E498;
	Mon, 10 Jun 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtfQxFDv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD38F6D
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041167; cv=none; b=NiCSMMnlP3mnEPJS0b5EZ3zz+qY5C8pW7TvHtRV+xZO2fWoqboG4FBJ7brhQlsyA5xXbxnB+ptz3HsTHYXpP0MNS7LtFajHZOmzvJNcmafjc9jvZ18vOMhy/iVm2cYNpqx3PEFVZNjcZVGJJj0lhBtYyL6PSKkV9juoT1Wj2C6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041167; c=relaxed/simple;
	bh=3F9UHb2VKyAFwVlJD2kZKZeZ0Z1RrdD72eEyV+NL+H8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=i7tDlV8rO7r3IOrdqTPUedjcPY+upImc1xBh6JYGweUGu1fu9gMP0N90pNoxFxSWWPmY9teAq9/0SL42w9/KmPOR7LllHcglEg1RSZwL105ULcAhc5CwwDPhuwoYuBOpuh+x8UT9iIdK7Sirg++6p3SqdqXjwButh3IrJrqcaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtfQxFDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF96C2BBFC;
	Mon, 10 Jun 2024 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718041167;
	bh=3F9UHb2VKyAFwVlJD2kZKZeZ0Z1RrdD72eEyV+NL+H8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PtfQxFDvruDMc1OXRVsZqMzJfIqJ20o/ih0zeQ+aWA6posEOkk0dV0Svjzf9tDVLN
	 0FJTGZpwWWxQhbpJiuA770Wc4ha8BjU6eetyQb21H7T1B0ITaHgA2+mUy+PmjiBwva
	 wRHCo3y/0YA9IjizBfU4TVzttn+QYizw3vruFrxTPUaagUw2bszpi2OLcE92/D2FJi
	 LyPV59/UgD2guP0jc9yAymiJVWJPh2Ha7u/1i6p/bgCKmxiRxZMnruhKkOXThJbFMV
	 OzuOwon6nR7mJuoW5syihfTVwPEytsdz6bL+I5eiUxAZylQKrJUHbALtABFrg6p1CE
	 D15nUGcj706OA==
From: Kalle Valo <kvalo@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  "Le
 Suire, Michael" <Michael.Suire@Softing.com>,  "pkshih@realtek.com"
 <pkshih@realtek.com>,  "johannes@sipsolutions.net"
 <johannes@sipsolutions.net>
Subject: Re: wifi: mac80211: unencrypted message in 4-way handshake
References: <BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Date: Mon, 10 Jun 2024 20:39:24 +0300
In-Reply-To: <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	(Tobias Sperling's message of "Mon, 10 Jun 2024 13:50:53 +0000")
Message-ID: <87le3clmsz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sperling, Tobias" <Tobias.Sperling@Softing.com> writes:

> Hello,
>
> recently we moved from a 4.9 kernel to 5.4 kernel and observed the
> following issue. To rule out that the issue was already fixed we then
> tried it with a 6.6 kernel and observed the same issue there, too. To
> sum it up, the following issue can be observed with kernel 5.4 and 6.6
> but not with 4.9.
>
> We are using a Cisco AP with EWC (C9210) and EAP-PEAP as
> authentication method. Additionally, a session timeout is configured
> in the AP (300 s) after which a rekeying is taking place. So every 5
> minutes a new four-way handshake is taking place which usually is
> completely encrypted. However, while sniffing with an external device
> we saw that the fourth packet of the four-way handshake is send
> unencrypted by our clients, when it comes to EAP-PEAP. The first three
> packets are encrypted as expected. In case of the Cisco AP the attempt
> is then rejected with a 4WAY_HANDSHAKE_TIMEOUT leading to a completely
> new authentication.
>
> On our clients we are using wpa_supplicant 2.10 with the same config
> on all kernels and therefore would rule out an issue in the
> supplicant, as it is working with the same supplicant in kernel 4.9.
> As driver we are using ath9k for QCA2066 (starting at kernel 4.9) and

QCA2066 with ath9k? ath9k is a driver for 802.11n hardware and QCA2066
is 802.11ax generation, how would that work?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

