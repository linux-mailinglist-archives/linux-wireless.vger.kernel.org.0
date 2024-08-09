Return-Path: <linux-wireless+bounces-11226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D5D94D41F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BAF1C21202
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275CC198A0A;
	Fri,  9 Aug 2024 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge3/4AUi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598F194A4C;
	Fri,  9 Aug 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219441; cv=none; b=ObH7l6v/zCpPLKZ8vAf7E1Mbg+e8shgdiyi/D9J53O+QptZ5xtjal3faHTK5OHZKiWH+xYRqBbRUiynNWet6hitMOlHmF3MUhneeGevfzIL+Z0eql/rRS7YnIRWzYxbzaNLFWzhMIZFljkha6rOdvLjO7hLzwfGZP3urYfxkLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219441; c=relaxed/simple;
	bh=3X4KnqOVvMgnV0xVVa+Fn5xLpXaLDEnmDWpiCsg0VZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKamNwtfBgex270+/cLyyDLrdNcRcjdiKrf3xuYXQqBbVOlfZmMDXnrtBV7xaiM6GSHB8bGS2vs9fONzdUMy3HB7HMlxlYjejQAdwSHERhkBVO/0zNynca1CJEIKZRPB+4aFwEzvoW9wPzWM3cqrpuUtT1mTTGsP2ykzs60coxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge3/4AUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FA7C32782;
	Fri,  9 Aug 2024 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723219440;
	bh=3X4KnqOVvMgnV0xVVa+Fn5xLpXaLDEnmDWpiCsg0VZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge3/4AUi+b2X9uEi+mTizqxwaCD5rARF6blKYGvDdPpWTeLWDFIaOQFPcr7y7DI2O
	 24yirXPxxE0vvi6VW1rd+TG3EGekAcefZMYr0sPMl8vsplQBg3YCRH+xzJkGXRFv9m
	 4+GzkA39C21hvxnyM6w99WoEqTCmKvSigqer2t2Bk/oUqwiBCQdS7KMPASEUlHEGOG
	 7C+O4x3oDuVV1K2dejYx0wNhmA11ks9EPfsb/VFq7qik8ckBqZzScC74ca+BS6XAas
	 MmroD0WsxZ7+y8W/EyWNzCOdOhZqjpvp47+sOX0rio0lUroOeGhg1RtBBwHHszKe7I
	 7eskg1ZUxjEeA==
Date: Fri, 9 Aug 2024 17:03:55 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Nemanov <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH v3 12/17] wifi: cc33xx: Add scan.c, scan.h
Message-ID: <20240809160355.GD1951@kernel.org>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
 <20240806170018.638585-13-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806170018.638585-13-michael.nemanov@ti.com>

On Tue, Aug 06, 2024 at 08:00:13PM +0300, Michael Nemanov wrote:

...

> diff --git a/drivers/net/wireless/ti/cc33xx/scan.h b/drivers/net/wireless/ti/cc33xx/scan.h

...

> +/**
> + * struct cc33xx_cmd_ssid_list - scan SSID list description
> + *
> + * @role_id:            roleID
> + *
> + * @num_of_ssids:       Number of SSID in the list. MAX 16 entries

@num_of_ssids -> @n_ssids

> + *
> + * @ssid_list:          SSIDs to scan for (active scan only)

@ssid_list -> @ssids

Please document all non-private fields,
and annotate those that are private.

There are a number of similar minor Kernel doc problems with this patch.
Please consider using W=1 builds or ./scripts/kernel-doc -none
(bonus points for -Wall) 

> + */
> +struct cc33xx_cmd_ssid_list {
> +	struct cc33xx_cmd_header header;
> +
> +	u8 role_id;
> +	u8 scan_type;
> +	u8 n_ssids;
> +	struct cc33xx_ssid ssids[SCHED_SCAN_MAX_SSIDS];
> +	u8 padding;
> +} __packed;

...

