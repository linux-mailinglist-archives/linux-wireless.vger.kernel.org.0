Return-Path: <linux-wireless+bounces-19486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99532A46341
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EE83A6433
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C321C9E7;
	Wed, 26 Feb 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e6wWM2Mt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CE221542
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580886; cv=none; b=L1W2BzNaXY46W3Z4BhQ2iSvJeK786+KxLEZd306nwCgpL775VNoSOemM+jQiqFOwazB8DyrDxuve8qz9MovmLvaMaPmdHNEf2wHGkSUjae7K+2Cs0bryZ4My29pnA2ygNFN7UjndLRZSLHdeCUvXQJpRTojYEIio5yhWN/nv0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580886; c=relaxed/simple;
	bh=M0vtbFjBRFoNamDGlYi0cwxQk4heqtx6laK9L1615Fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koUyDvyhcKg2jT8joRagxAJYdhrfBWr4GFYonfDVhxtqd2bQO7YHhbeCnhAU242YasohGJx77pFXkdbS5bslLIwYcSEsNIU4e55DMnM/fIchBn8K/mG71tRVIu2gnwOf1jxV4tlbjnQ0Jy9xp5dumiHwRbqVYpHrUvG6BCdpbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e6wWM2Mt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=M0vtbFjBRFoNamDGlYi0cwxQk4heqtx6laK9L1615Fw=;
	t=1740580885; x=1741790485; b=e6wWM2MtTtpPwyIH1gzt9+YYo+J5T+gvD6z4jM3RzwikDu+
	ghSoVqtgrMlb15iOTC4gC5IfhVGkzfpgDJjpxNNuxBKBdzT3XEAnX6vjKBJtPT1m2/Ya9oVxAO04q
	8f9Skw+PnpdkWDacxw5GR7v7BF8qCXq0v1kWK2FkMILk8yLe738TTPBZTrirPMtTQATnv0VZZJOWo
	zLVxqU9ch3ZO1IbBVALHYBn2Nqm/dH4itJvaP+dA6cuvlJMV1EpoHG/R3UHHR+H/JtBniJM9cvUZA
	mtfy0a4P1/eZZt9IaaMXCuUz9ljyLgXZsOoZipe55kENHUMFVtFzjZj83Gtv2W5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnIbC-0000000BXgd-0TxA;
	Wed, 26 Feb 2025 15:41:22 +0100
Message-ID: <0aa5d6e8667350c7a3d80af4ce3956cad7096fba.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: Add support for management frames
 stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Ramya Gnanasekar
	 <ramya.gnanasekar@oss.qualcomm.com>, Jeff Johnson
	 <jeff.johnson@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 15:41:21 +0100
In-Reply-To: <20250211202518.126305-1-muna.sinada@oss.qualcomm.com>
References: <20250211202518.126305-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-02-11 at 12:25 -0800, Muna Sinada wrote:
> Currently there aren't statistics in mac80211 that keep track of the
> management frames that are processed in both Tx and Rx. This type of
> statistics is useful in tracking if management frames are successfully
> transmitted or are dropped. These statistics are also needed to
> provide information regarding how many management frames are received.

A very, very long time ago, when a lot of statistics were being added
(and required by Android?) I suggested that perhaps we should add way to
run BPF programs on incoming frames to keep track of these things
instead of having counters across the code for all kinds of things all
the time. I suspect that in the time since that has become much simpler,
since now BPF programs can be attached to tracepoints and adding a
tracepoint or a few could be very easily done.
In this case that'd really only require a TX and TX status tracepoint,
where the latter is getting the 'acked' indication, so that's basically
trace point definition + 2 lines of code.

I wonder what you think about that. All of these counters add a pretty
large permanent memory (2 KiB here) and code cost, and having them in
debugfs _only_ can also be annoying for certain use cases.

johannes

