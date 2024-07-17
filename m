Return-Path: <linux-wireless+bounces-10317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865709343C6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 23:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B812E1C21C30
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F61850A0;
	Wed, 17 Jul 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK/tkL3f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B771CD26;
	Wed, 17 Jul 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251463; cv=none; b=PrR1mohsksHEJBIdgRo0Zhfn4J9fLvA21GWbd4wYvWhS3ag5UWQD2TpPFps4VmnykYhRSOYdht096svZcU87SGbPLGPvnuI9FwO8QO/hdC71dHH1ivhdTt+OXieACbjPGV+99xpiJYmThLhhF2LWaLeLYUYJeDrAAz3DjMU+7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251463; c=relaxed/simple;
	bh=1EY+vvc7jNlEdDJjAXGm1QryO1IfYmX5lIziu+1P168=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj9CpQtJPAPfwv5TfJ3izrqNF2wNjIjRwPFq0NvcsDJeQCLwI2EaWbcYL391F1oz1ssIVBCpb1IXdK4dgSMwtqnjYi1iOkmo369kijDhMKxEg7c4l86iJdbYrf3maVukmSqnIzqdKl2v8uvN/iP2OZ9QIcmL16VCc0q7/Ljq9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK/tkL3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F1AC2BD10;
	Wed, 17 Jul 2024 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721251463;
	bh=1EY+vvc7jNlEdDJjAXGm1QryO1IfYmX5lIziu+1P168=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gK/tkL3f97uSs56KpwRiMUV5Bwx3eXpVEi/WJjpgUZEX0th0IeqcGp0ItIgThbd9E
	 He+DVz2m1tMAa4wNF10MU6hQgtyYZpDaEQdKA++QhGAp49Tz/5eX9y7M+gVBozW8hU
	 oh3lctY8/fVWcDZpGzmQLJ3WyN+itS6m8Kf1Z1M1NGteuMEBwkHHuvWKV2r6thTBR3
	 WGGkVt0FibIraYnmzlnTYqhaWjkC/8RCRfebIYqA12cSVX+2KIPkQB352ORqY+osft
	 dyueKLESA3NX3q+Pm01BYwNXDxAXRiqZZn1TMhb78cnylJFgQb5tYxvVUKRpTBwzSD
	 HcMkB5oFXHUBQ==
Date: Wed, 17 Jul 2024 14:24:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Stefan Lippers-Hollmann <s.l-h@gmx.de>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH v2] thermal: core: Allow thermal zones to tell the core
 to ignore them
Message-ID: <20240717212421.GA1191@sol.localdomain>
References: <4950004.31r3eYUQgx@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4950004.31r3eYUQgx@rjwysocki.net>

On Wed, Jul 17, 2024 at 09:45:02PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The iwlwifi wireless driver registers a thermal zone that is only needed
> when the network interface handled by it is up and it wants that thermal
> zone to be effectively ignored by the core otherwise.
> 
> Before commit a8a261774466 ("thermal: core: Call monitor_thermal_zone()
> if zone temperature is invalid") that could be achieved by returning
> an error code from the thermal zone's .get_temp() callback because the
> core did not really handle errors returned by it almost at all.
> However, commit a8a261774466 made the core attempt to recover from the
> situation in which the temperature of a thermal zone cannot be
> determined due to errors returned by its .get_temp() and is always
> invalid from the core's perspective.
> 
> That was done because there are thermal zones in which .get_temp()
> returns errors to start with due to some difficulties related to the
> initialization ordering, but then it will start to produce valid
> temperature values at one point.
> 
> Unfortunately, the simple approach taken by commit a8a261774466,
> which is to poll the thermal zone periodically until its .get_temp()
> callback starts to return valid temperature values, is at odds with
> the special thermal zone in iwlwifi in which .get_temp() may always
> return an error because its network interface may always be down.  If
> that happens, every attempt to invoke the thermal zone's .get_temp()
> callback resulting in an error causes the thermal core to print a
> dev_warn() message to the kernel log which is super-noisy.
> 
> To address this problem, make the core handle the case in which
> .get_temp() returns 0, but the temperature value returned by it
> is not actually valid, in a special way.  Namely, make the core
> completely ignore the invalid temperature value coming from
> .get_temp() in that case, which requires folding in
> update_temperature() into its caller and a few related changes.
> 
> On the iwlwifi side, modify iwl_mvm_tzone_get_temp() to return 0
> and put THERMAL_TEMP_INVALID into the temperature return memory
> location instead of returning an error when the firmware is not
> running or it is not of the right type.
> 
> Also, to clearly separate the handling of invalid temperature
> values from the thermal zone initialization, introduce a special
> THERMAL_TEMP_INIT value specifically for the latter purpose.
> 
> Fixes: a8a261774466 ("thermal: core: Call monitor_thermal_zone() if zone temperature is invalid")
> Closes: https://lore.kernel.org/linux-pm/20240715044527.GA1544@sol.localdomain/
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201761
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>    * It is safer to retain the old behavior in thermal_zone_get_temp(),
>      which is the second place where the .get_temp() zone callback is
>      used, so make it return -ENODATA if the temperature value coming
>      from that callback is invalid.
>    * Add Tested-by: for Stefan.
> 
> I have retained the previous Tested-by because the part of the patch that has
> been tested remains unchanged.
> 
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    7 +++
>  drivers/thermal/thermal_core.c              |   51 +++++++++++++---------------
>  drivers/thermal/thermal_core.h              |    3 +
>  drivers/thermal/thermal_helpers.c           |    2 +
>  4 files changed, 35 insertions(+), 28 deletions(-)

This makes the log messages go away for me.  However I had to resolve a conflict
in drivers/net/wireless/intel/iwlwifi/mvm/tt.c to apply this patch to the latest
upstream.

- Eric

