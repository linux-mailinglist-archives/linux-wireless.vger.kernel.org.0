Return-Path: <linux-wireless+bounces-14243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0733C9A5CF3
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D411C208C6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 07:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D243194A75;
	Mon, 21 Oct 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeHCcg+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC917C200
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495641; cv=none; b=mpWyZsHta+gOnOh7eEnxJwZ4Mg2IN5jayWaAfbUtUQ4zEzNJlhzc2gAbaPupPfHJpUGhiKcBjqa5XEGMKR6GIcHssagCWC65I6Gh1ibni23sTw62++VsVlLH/Vy+12hWDmqFeQxDp4/xSXH7Kav9KxypdglEoRTXmYVNzhY6dwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495641; c=relaxed/simple;
	bh=h0qmM9+DBsHmsuho2kHr16gzHURt2rejjddeGlKj9w4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FQgW6uCzfUEA+j+eZ9xonUQWbA8vrMjcdiyCNpHjJao4o/JrZ/OOWnhZxAT2miAlCf7x7m2n4fbLnbRnINGO8KAWdtHNwYwu9rOZ+YtShGoaUFZZn45GT7cDz1OrsXfhLz8oq+spwOxTIC8D7yqyvg1bUz7E8R3CIQI73I6PW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeHCcg+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B061BC4CEC3;
	Mon, 21 Oct 2024 07:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729495639;
	bh=h0qmM9+DBsHmsuho2kHr16gzHURt2rejjddeGlKj9w4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aeHCcg+D8xsNzK4E9JkeoG5/UxNSmp3GRjXKoqETE+s5PHe8VeZ8VnUrvN7X/10oh
	 S9+EFkXHsO554oOlNU5KmpGG5cJLwXb67r9A6D0y4NDvlzAJhynftPremy4BCy0Co2
	 jMs/rCz2bgQ/fSPkbGfS5P69r9ZC4Om3IMt5eTOuVctE2Xwxv9YmMVvmANrEgci2Q9
	 4i6bXk7g/+HnZSG8QNNyJ6ZXVKjE2NYlLfuzKpKnRCFyEDGSjoLkQheQOj7acDqhIu
	 f7UhO5JjCqc6zizm3mVtlb6AFBuRO01adivmn1bFYkif9p8uU7MMDYrng2h3sv/xJR
	 zplMqVKkUyn3g==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <johannes.berg@intel.com>,  linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
Date: Mon, 21 Oct 2024 10:27:16 +0300
In-Reply-To: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com> (Baochen
	Qiang's message of "Mon, 21 Oct 2024 11:42:25 +0800")
Message-ID: <874j55531n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Hi Johannes,
>
> My AP is configured as WPA3 SAE encrytption, and GTK rekey interval 30s. After enable WoWLan:
>
> 	iw phy0 wowlan enable disconnect
>
> and put system to s2idle state:
>
> 	echo mem > /sys/power/state
>
> I see in sniffer there is M1 frame from AP to station but didn;t see
> M2 response. AP retries for some times but finally kicked out station.
>
> such issue is not seen after changing AP encryption to WPA2.
>
> HW in use:
>
> 00:14.3 Network controller: Intel Corporation Ice Lake-LP PCH CNVi WiFi (rev 30)
>         Subsystem: Rivet Networks Ice Lake-LP PCH CNVi WiFi
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at 603ebb4000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: <access denied>
>         Kernel driver in use: iwlwifi
>         Kernel modules: iwlwifi
>
> kernel is from https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/ and with version:
>
> Linux xps13 5.19.0-rc8-wt-ath+ #4 SMP PREEMPT_DYNAMIC Tue Dec 26 17:02:03 CST 2023 x86_64 x86_64 x86_64 GNU/Linux
>
> is this an known issue? or am I missing something?

That kernel is over two years old, have your tried a recent kernel
version?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

