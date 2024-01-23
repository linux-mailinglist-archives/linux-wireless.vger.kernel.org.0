Return-Path: <linux-wireless+bounces-2363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F9183877F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC0C1C21B3B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DD56466;
	Tue, 23 Jan 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNH9ksjP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDE56450
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991483; cv=none; b=pwjbSRiK9GN09JGSryj6EOBlqN9y583HbkgqW/wJsDODo7NaCbAFQiENWw+hfLvJj9cRj0ojDzAleV4AF0fCrZy3zMNeneY+kjDQJ7jv1BP2S+/1BsvKJdRPGXAQBlIf0wVFEoyKz5AI4CsNAFj31Ed4Y61JvUggG7/70BGfhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991483; c=relaxed/simple;
	bh=S+4Mqb0dYvMpyjrxXpBv1kJJpgn3/DCcekoEbYp+P+A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aNziD7kx7NWQ/Wc89iagwdAgN5NiR6PohDmg6xBuCN/U+Vq4SnuE6y4BlosK7EqqJ+cQpUKy7FsI6B0F2tqGMuf3y6S/PreSyJgNP01B0aI1vyGmZVLQmJzFjKbE8JRS8u1TV1i8TsmqJCOz5AIpKjUauZEXnpP3pxEhcmLgpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNH9ksjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C6FC433C7;
	Tue, 23 Jan 2024 06:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705991482;
	bh=S+4Mqb0dYvMpyjrxXpBv1kJJpgn3/DCcekoEbYp+P+A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aNH9ksjPXsZo0WnUC/dLfPFujbe66tMgiGmQ/3EsYyeaMUxq+ptJtrbc2w64lW/EC
	 qDr2Pjom5y724Ets41ll7rhrTZhkmJWmiHxXAkR+4QseYKqO1ZzH/1GzIkwl3Ij8GU
	 mnFD8C9USvww0w5DNSPaXzF855/ypFft/BskrSRPhZ89P55H/pQAuN1gnR76V+wE5y
	 PQehoBSkNK1nYbO/2GemzCsWi1DhqFPeQlNYEv8SWPHKDY4nQDfvudnHRA4eTYmgU+
	 9uPKK6k0N8/7p0AMB+rXOsI59fEsbpbj184zA1gRPV8t7aZAQ+u53DbvTtSZ6TowNZ
	 mDT8/UVtSwxZw==
From: Kalle Valo <kvalo@kernel.org>
To: <Ajay.Kathat@microchip.com>
Cc: <davidm@egauge.net>,  <linux-wireless@vger.kernel.org>
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
References: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
	<1776feff-0886-4db8-896c-c542d3e626b0@microchip.com>
Date: Tue, 23 Jan 2024 08:31:19 +0200
In-Reply-To: <1776feff-0886-4db8-896c-c542d3e626b0@microchip.com> (Ajay
	Kathat's message of "Mon, 22 Jan 2024 16:57:10 +0000")
Message-ID: <87jzo0ef2g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<Ajay.Kathat@microchip.com> writes:

> On 1/19/24 14:51, David Mosberger-Tang wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> The current version of the wilc1000 driver has a probe function that simply
>> assumes the chip is present. It is only later, in wilc_spi_init(), that the
>> driver verifies that it can actually communicate with the chip. The result of
>> this is that the net device (typically wlan0) is created and remains in place as
>> long as the wilc1000-spi driver is loaded, even if the WILC1000 chip is not
>> present or not working.
>> 
>> Is there any reason not to detect the chip's present in wilc_bus_probe()? The
>> patch below (relative to 5.15.147) works for me, but perhaps I'm missing
>> something? Would it make sense to merge something along these lines into
>> mainline?
>> 
>
> I think it is the WILC driver design that the firmware/chip operations
> are executed only when the netdev interface(wlan0) is up.

Yeah, that's good design. I think that wlan0 is down wireless drivers
should turn off the hardware to reduce power consumption as much as
possible. Many drivers do start the firmware during probe() to query the
capabilities and then turn it off immediately.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

