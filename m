Return-Path: <linux-wireless+bounces-14843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD49BA085
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 14:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5BF28207A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74418A925;
	Sat,  2 Nov 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0UT1LrD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981261E515;
	Sat,  2 Nov 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553939; cv=none; b=S+gJg2oNvlGbja8Ho5YWUwIgrK2C+UVNs0VmMW/RhVVMotw7HYR3WjEZ3m4CErQnii5YXbrt86cV/8juS8RhQxgI4nxfjQPJuAiyQd4gbk+rytLWX0RVX7KIgDNjj4is+0/uUrWVmzsmmjAsYt+yGcWbP81Dk7qjUf36/YpAC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553939; c=relaxed/simple;
	bh=Brh7PCFfiHPodDSQkSEDFp8MWJQXOxvx1uid36Iwljc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3NiiJTiWRJ3ydqVW+NTAjHrYLgDkK0K4+FltDN619wly8OoMZzzupOIBlG6Nahu1ZHMN+SgitoXu+O26+68K109digyziOGC7tGRk9+D1SH7Jqad8uvc+p0mzatrkqSXrKN88HDm+FOVzjwsyQ1gJG4lPW6kahyx6rxT8Sy2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0UT1LrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2D9C4CEC3;
	Sat,  2 Nov 2024 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730553939;
	bh=Brh7PCFfiHPodDSQkSEDFp8MWJQXOxvx1uid36Iwljc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0UT1LrD0JnecxRQ9ghkR0Z8Mk/+S/sA2GbGMku5OkqJq8LM6KrVcsVNf04GAGuuO
	 8sm1lhzmUyW+Brp2t4BxAbCmmcKVkZu1qgsOslVddaki6ntWlrQ08SMVoEBxaQsU8+
	 1XrJjCqB7x9V9NwbE/Jo39qdCAXHjiyFwMCC0a7C0XJHEpbaBo9f6zsnlc9QYnAvTQ
	 fHtsGCDX7MblpS/fhrT6j7LI6SyLrR7ZWzPJhaHQJ8dZAgq+s/97q0edTtsMsvbt2j
	 dFPfcfvpZHJvNQ3gyDkT39hmDFTWa5hEiZ74qM3chMsvJtD6c75Ky2hQN9l8fV5qV+
	 Ed1S1Z4ypcwiA==
Date: Sat, 2 Nov 2024 13:25:32 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Nemanov <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH v4 09/17] wifi: cc33xx: Add main.c
Message-ID: <20241102132532.GJ1838431@kernel.org>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
 <20241029172354.4027886-10-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029172354.4027886-10-michael.nemanov@ti.com>

On Tue, Oct 29, 2024 at 07:23:46PM +0200, Michael Nemanov wrote:
> General code and structures.
> Notably:
> 
> cc33xx_irq - Handles IRQs received from the device.
> 
> process_core_status - Core status is a new concept in CC33xx.
> it's a structure that is appended to each transfer from the device and
> contains its most up-to-date status report (IRQs, buffers, etc.).
> See struct core_status for details.
> 
> process_event_and_cmd_result - Responses to driver commands and
> FW events both arrive asynchronously. Therefore, driver cannot know what
> he read from HW until inspecting the payload. This code reads and
> dispatches the data accordingly.
> 
> cc33xx_recovery_work - Driver supports basic recovery on FW crash and
> other illegal conditions. This implements the recovery flow
> (Remove all vifs, turn device off and on, download FW,
> let ieee80211_restart_hw do the rest).
> 
> irq_deferred_work - Does irq-related work that requires holding the
> cc->mutex. Thisd is mostly in response to HW's Tx/Rx IRQs.
> 
> cc33xx_nvs_cb - Callback for the NVS FW request API. Similar to wlcore,
> this is where the init of the HW is performed.
> 
> cc33xx_load_ini_bin_file - Loads a configuration file from user-space
> via the request FW API. The structure is described in a separate patch.
> 
> cc33xx_op_X - MAC80211 operation handlers.
> 
> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
> ---
>  drivers/net/wireless/ti/cc33xx/main.c | 5689 +++++++++++++++++++++++++
>  1 file changed, 5689 insertions(+)
>  create mode 100644 drivers/net/wireless/ti/cc33xx/main.c
> 
> diff --git a/drivers/net/wireless/ti/cc33xx/main.c b/drivers/net/wireless/ti/cc33xx/main.c

...

> +static struct ieee80211_sband_iftype_data iftype_data_2ghz[] = {{

Hi Michael,

Sparse seems a bit unhappy about this:

.../main.c:332:24: warning: incorrect type in initializer (different address spaces)
.../main.c:332:24:    expected struct ieee80211_sband_iftype_data const [noderef] __iftype_data *iftype_data
.../main.c:332:24:    got struct ieee80211_sband_iftype_data *

So perhaps it should be:

static const struct ieee80211_sband_iftype_data __iftd iftype_data_2ghz[] = {{

Likewise for iftype_data_5ghz.

...

