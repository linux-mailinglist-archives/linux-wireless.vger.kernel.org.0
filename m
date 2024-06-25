Return-Path: <linux-wireless+bounces-9527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC79165B8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 13:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F8C1F2143F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EE1494A8;
	Tue, 25 Jun 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN3aBgWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E61095B
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313555; cv=none; b=NSD9UzHtLbX9TRnVbvYm+odwF34avK9cQ/CzJqcyqWjywTleGwZkgLnvIck1DNuQf2gO8ULYmfwh7XWpGDf/+SZBNhNOJ/nxX/wgW1kxE+IIDpzDtHhJk+kMymW7CJWCChezm6GecYPlY8CvnnIYx02ZFe5/fjxRCklbP1jCd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313555; c=relaxed/simple;
	bh=nROsUan24OqOh1Ym7dj3p2iSv/HVveaf2Ct6nkmGWI8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hTrXBFIeoQrsGj/I8Z5zirY+rOWB3cGKguv3U2nU706scdPJhF3VN2CQrbonGqMOAaETqHKcVibPgiXIAHStB0GHKPXl3ejuHfc+Quaphxz7Adu5m2N6lgPCwh3DgkEwr7fzXbKhqa6bugW+C5VG3U7m1aChTMBma6NSOEGXbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN3aBgWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD12C32781;
	Tue, 25 Jun 2024 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719313554;
	bh=nROsUan24OqOh1Ym7dj3p2iSv/HVveaf2Ct6nkmGWI8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BN3aBgWRH7lxH0AFtpDMOTxyGRTspEIwEwLQN2G49WmA1vZfzzlVv8FeP+y69/9pL
	 PCVM84+RYS8PQuS8jyaArNU1vriOfbFEZ0aEBHIQS9oBk2tNt3gW+Vk+g5iD7xbSAS
	 posj7C00OgWPQN/EbnFEnXHvVQdMLOOj+JbdcOSt3y8WkkSTWKW/zT7ncpTplgADWi
	 ow22C5zZ3N5u+y62JMsclOdy1U2nd0KNkOZ9JQv9umB0Oh0RDEHpf8lS4ZyCX846GM
	 2C1/cz/kG+ubUgG4iLJlqKb0s5hFgww1UmfmRu7NR1gLcDC3ApbB70ICxJWbJ6DwoQ
	 kEIrQ2yyU4Reg==
From: Kalle Valo <kvalo@kernel.org>
To: Denise Finger <Dwanderer@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Subject: Re: Larry Finger
References: <77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net>
Date: Tue, 25 Jun 2024 14:05:52 +0300
In-Reply-To: <77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net> (Denise
	Finger's message of "Sat, 22 Jun 2024 18:01:23 -0500")
Message-ID: <87tthhgu3z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Denise Finger <Dwanderer@lwfinger.net> writes:

> This is to notify you that Larry Finger, one of your developers,
> passed away on June 21st.

I am so sorry for your loss. I appreciate informing us, Larry was so
much respected in our community.

I sent a patch moving Larry to our CREDITS file so that his name will be
in Linux kernel sources forever:

https://lore.kernel.org/linux-wireless/20240625103929.1332926-1-kvalo@kernel.org/

Kalle Valo
Finland

