Return-Path: <linux-wireless+bounces-14841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F5B9B9FDB
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 13:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B331F232DD
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E816DEBB;
	Sat,  2 Nov 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOy5EUSy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF686AB8;
	Sat,  2 Nov 2024 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548842; cv=none; b=kt8Qkwe0se83xx2bl9jWPRJv7VKbW+St7QALPev8wLnZBP4j9cdsNSTU7HzInbjWhG47CpPUejTEZT0VU3HWBlhg6ikhw8sFqazU7TapmanhdQ+DJfyBOdUpRDvVIBNc1XAUGe5QJIZy+MceRLhFpNGr3xWvjgIIPv9DypAI/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548842; c=relaxed/simple;
	bh=Gax01FuZKLQfe+8CO7ewzivLwUdPlXNuJeuqRVWx8Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPhD6D+fBF6gzxknshcbpHophNoM6/04j4NwCEHkBrMCrE7APoX8V4bVH5bK57PbnOk86WxJX0WKDc4UVyBgbFp/OL6jOjF9lVgyjNl93XklaKnLUyKarsZr2Vnaxt//HrELRJ4MFzCAKDCEzIgMk61AvdoN3tFlVoWbMyRh6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOy5EUSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16A1C4CED2;
	Sat,  2 Nov 2024 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730548842;
	bh=Gax01FuZKLQfe+8CO7ewzivLwUdPlXNuJeuqRVWx8Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOy5EUSypJsqP3WaNWj8wo13ZKzdP7ItQe6wpSkp5E/shKd/Jg8XJds3y8apv97bG
	 dLxo0ECMkWdfaeaioW8poZ6Pfv+e5mFt00Pb13PJPM9O/JfvJfyPQBn5f3+fLyLg/t
	 tkpZgWTzCSxO7OAnfFRhi6M1aOZOZciftNFY+THjG81eeXl9ray4CYrQIDgPkmfE4r
	 jYqNlVCykpkR+5VhWbXt+xakVAIvvmJ4JObdP8Nv41Jc+I8n+i6ERrqmSdntKFV4F3
	 0Swj+Ss+SUPNn+onGxe1xtWPgISqAlW2xdxmIbsftlDJoItvn5q1SAhwPbZXsQ1SuY
	 6AoJjjmrG8dQw==
Date: Sat, 2 Nov 2024 12:00:30 +0000
From: Simon Horman <horms@kernel.org>
To: "Nemanov, Michael" <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH v3 12/17] wifi: cc33xx: Add scan.c, scan.h
Message-ID: <20241102120030.GG1838431@kernel.org>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
 <20240806170018.638585-13-michael.nemanov@ti.com>
 <20240809160355.GD1951@kernel.org>
 <33f3b6a4-f907-4374-90ac-d81a81700936@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f3b6a4-f907-4374-90ac-d81a81700936@ti.com>

On Mon, Oct 28, 2024 at 06:26:50PM +0200, Nemanov, Michael wrote:
> On 8/9/2024 7:03 PM, Simon Horman wrote:
> > On Tue, Aug 06, 2024 at 08:00:13PM +0300, Michael Nemanov wrote:
> > 
> > ...
> > 
> > > diff --git a/drivers/net/wireless/ti/cc33xx/scan.h b/drivers/net/wireless/ti/cc33xx/scan.h
> > 
> > ...
> > 
> > > +/**
> > > + * struct cc33xx_cmd_ssid_list - scan SSID list description
> > > + *
> > > + * @role_id:            roleID
> > > + *
> > > + * @num_of_ssids:       Number of SSID in the list. MAX 16 entries
> > 
> > @num_of_ssids -> @n_ssids
> > 
> > > + *
> > > + * @ssid_list:          SSIDs to scan for (active scan only)
> > 
> > @ssid_list -> @ssids
> >
> 
> Thanks for the feedback, will fix.
> 
> > Please document all non-private fields,
> > and annotate those that are private.
> > 
> 
> Not sure I follow. You mean mark private vs. non private members in the
> documentation? If so, private to what (the CC33xx driver or the underlying
> HW)?

Hi Michael,

I'm not sure why I mentioned private, perhaps it was a general statement
that all fields should either be documented or marked as private. If
you don't think anything is private - whatever that might mean - then you
can ignore that part of my comment. But suffice to say, there is syntax to
mark fields as private[1].

[1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#members

> > There are a number of similar minor Kernel doc problems with this patch.
> > Please consider using W=1 builds or ./scripts/kernel-doc -none
> > (bonus points for -Wall)
> > 
> 
> Ran both, got warning for "no structured comments found" on multiple files.
> Is that it?

I'm a but unsure why you see that, but what I was referring to is this:

$ ./scripts/kernel-doc -none drivers/net/wireless/ti/cc33xx/scan.h
drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_ssid_list'
drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'scan_type' not described in 'cc33xx_cmd_ssid_list'
drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'n_ssids' not described in 'cc33xx_cmd_ssid_list'
drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'ssids' not described in 'cc33xx_cmd_ssid_list'
drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_ssid_list'
drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Excess struct member 'num_of_ssids' description in 'cc33xx_cmd_ssid_list'
drivers/net/wireless/ti/cc33xx/scan.h:104: warning: Excess struct member 'ssid_list' description in 'cc33xx_cmd_ssid_list'
drivers/net/wireless/ti/cc33xx/scan.h:149: warning: bad line:
drivers/net/wireless/ti/cc33xx/scan.h:177: warning: cannot understand function prototype: 'struct sched_scan_plan_cmd '
drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Function parameter or struct member 'u' not described in 'scan_param'
drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Excess struct member 'one_shot' description in 'scan_param'
drivers/net/wireless/ti/cc33xx/scan.h:227: warning: Excess struct member 'periodic' description in 'scan_param'
drivers/net/wireless/ti/cc33xx/scan.h:269: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_scan_params'
drivers/net/wireless/ti/cc33xx/scan.h:269: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_scan_params'
drivers/net/wireless/ti/cc33xx/scan.h:295: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_set_ies'
drivers/net/wireless/ti/cc33xx/scan.h:319: warning: Function parameter or struct member 'header' not described in 'cc33xx_cmd_scan_stop'
drivers/net/wireless/ti/cc33xx/scan.h:319: warning: Function parameter or struct member 'padding' not described in 'cc33xx_cmd_scan_stop'

