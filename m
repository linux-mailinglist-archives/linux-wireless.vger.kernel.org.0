Return-Path: <linux-wireless+bounces-15176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE79C3D60
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 12:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8C01F26579
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25213C670;
	Mon, 11 Nov 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfrwpL/s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9317139578
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324829; cv=none; b=k3KXDWKi12jvWeyq6HygjrsFfuNaAWZ6eA+2LLvVIIzyEVdKSsMl+ujmmTtp1AzvJyfUwli99o2NjLNZ3OqAt1tfyObsht2tzkW1k1m2xZo+haUxhZSvAwzW4/N3mTWJ3tqTzMubQK5LvcLOJ+hdlWJqmmRdm7jUJKxk8AgGfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324829; c=relaxed/simple;
	bh=p4GOM1pUubneDS/MhVgg5m+EflLOrK1KEv8vLfpVWvM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CHdN/pRBNGlz0BoCyoX78ttY19/4DCF0A9GSvObx+8RnYSsO/xOiGVDiTYrCoAIva5UkKYPhR/TYETq2yv71NtWADMByYXkqGdQnADd1VLvFwPArF13VG03g2TMuPuEFwRr29la4BRJyGdP1wMP7aceeKK7l4i7U22AfRowNwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfrwpL/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAA5C4CED5;
	Mon, 11 Nov 2024 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731324829;
	bh=p4GOM1pUubneDS/MhVgg5m+EflLOrK1KEv8vLfpVWvM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=sfrwpL/srwXQKNtIWzguIc3GMTCm1TfHe8raLiOVar7RHU1KDpye/oHmKkrY6IA72
	 5bxq/4g+z2oAmdiNfm4nwwapyNgCEcpumwGCFoswAN3YoxaFpbmPb1Jmq3kYoexz3R
	 EpFk2qTJVwXZ8f/ERhIKcooEZPoiGAIBqGWthMIf5HcvUmw5f9Wh042GoF5+EZUE4S
	 PGUsjdF4/54vB9YvH+AhbOP3HewB6SlRTXOCPOUDSfSsJrWtgOylHnealr2hMOgpIQ
	 8WucdPl4PN0L0zOZG+XjSW1PJW2guHA5YfRIbznC9gMcrGfts3K0YroS7IFA9h6WsF
	 Kf71xrarB201w==
From: Kalle Valo <kvalo@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "kernel-dev@igalia.com"
 <kernel-dev@igalia.com>
Subject: Re: [PATCH net 0/5] wifi: rtlwifi: usb probe error path fixes
References: <20241107133322.855112-1-cascardo@igalia.com>
	<7f14133bbf0c4f2b8d7889e65c3ccf2a@realtek.com>
	<Zy3uKIzbZXluWcJ8@quatroqueijos.cascardo.eti.br>
Date: Mon, 11 Nov 2024 13:33:46 +0200
In-Reply-To: <Zy3uKIzbZXluWcJ8@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Fri, 8 Nov 2024 07:55:36 -0300")
Message-ID: <87wmhavwbp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

> On Fri, Nov 08, 2024 at 01:41:45AM +0000, Ping-Ke Shih wrote:
>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
>> > These are fixes that affect mostly the usb probe error path. It fixes UAF
>> > due to firmware loading touching freed memory by waiting for the load
>> > completion before releasing that memory. It also fixes a couple of
>> > identified memory leaks.
>> 
>> This goes via wireless tree, not net. Just send to linux-wireless (you have done).
>> No need "net" in patch subject. 
>> 
>> I would quickly check if you did really encounter problems and
>> have tested this patchset with real hardware?
>> 
>> 
>
> Yeah, I was playing it safe here, in case some of the same rules apply, and
> "PATCH net" was required.
>
> If found this with a reproducer emulating a usb gadget device (by using
> /dev/raw-gadget), and then injecting memory allocation failures at
> different points in the probe path (at ieee80211_register_hw and then at
> init_sw_vars).
>
> I haven't tested this with real hardware, but given this lies in the probe
> error path, I suppose it would be harder to test for the bugs that they
> fix. On the other hand, it would be nice to at least confirm that it
> doesn't break them, though I find it hard that it would.

Yeah, regressions are what we maintainers are most worried. We certainly
do not want cleanup patches breaking existing setups.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

