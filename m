Return-Path: <linux-wireless+bounces-20570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971EA69502
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC141894514
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3131DD0D5;
	Wed, 19 Mar 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="WAWv4AoB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB815A85E;
	Wed, 19 Mar 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401879; cv=none; b=bWLkMHhhOw1LrKIkJ5t8qm4aE+QFq75tDqamLGtUTJZN3ofR9gw+rUU8wmg9tebel9apWIxzUj0OFq5h8bOZ7XfMeI8+QFzK2i7BMZR1fBsTIiGQnbL8+JQu87zW3zxMzC8c/W2VVJxNEDiqyvomRf+g1VqSOMVGOcEgRu5Y+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401879; c=relaxed/simple;
	bh=pQTuBt0wisvk9x/Q3TKGzpZhJh+ONCcvBgZ0qUsV/hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYMdbTbc7Q3Ts6qXEhXt4PUvafEIdDkRTsWNn5A+W7LWwj/36CsJwsaWjO96m9prs6QdjAowipSoWlyOn3WpWpPlI95DWBJxdVzYtz24mmHUxeHGDUGcZBYBfE4sWST4mQAwRFfVux+o+a237VLokMM8bBqgBGQLgLUdsqOeRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WAWv4AoB; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 63DA31F92C;
	Wed, 19 Mar 2025 17:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742401874;
	bh=pQTuBt0wisvk9x/Q3TKGzpZhJh+ONCcvBgZ0qUsV/hc=; h=From:To:Subject;
	b=WAWv4AoBFVzJqBgibuz68OsigQmKihdF7K370F8LPRFZQxQGohc+5PgnWZcCuCPhw
	 rLtIZT9B7TWdrDcPuG+a+ukR+5QbE69PitXKgcZjDGKeqWeRaF6i+gYXBksrqJ08Uz
	 9iiyv3nFCekO6IeWu3aosB8+hj7RL5FLseKv16ckliB6jlvnB+69WoVwbNCtq8Pd+M
	 eyKhP535H5l2nQzLSPhAXeFNyOz2lWrnYD/qg/xzxBEiVJhik703DxFbh3Jm/bfpoq
	 pR5EhE4OLWYR5GAJytbBg67REXIMBw0385rEG5iB2KRJJ2E/CS7T++yEAZL+esQwgv
	 dxcCSHbbjKVvQ==
Date: Wed, 19 Mar 2025 17:31:13 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data download
 from file
Message-ID: <20250319163113.GB46894@francesco-nb>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-3-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318050739.2239376-3-jeff.chen_1@nxp.com>

Hello Jeff,

On Tue, Mar 18, 2025 at 01:07:39PM +0800, Jeff Chen wrote:
> While this patch restores the ability to download RF calibration data
> from a file, it may inadvertently break the feature to download
> calibration data from the device tree.

I do not think this is acceptable. Fixing something by adding another
bug is not ok. You should fix the calibration data from file, without
breaking the device tree calibration functionality.

Francesco


