Return-Path: <linux-wireless+bounces-10809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C476194463A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6843D1F22FE7
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76078EEB3;
	Thu,  1 Aug 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaxLL975"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B791EB490
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499799; cv=none; b=Eh/UIYsdDjr5sJFxYW0HSFgG3G68YvEIjXHXkHoNg0/muhhwKREwFhjuvbrPLmhRZcXo2WtBvEgIYbW4hc91qrDg1b2MfOfhW0UAarTVPH9jdKmphLEs4yN1I8wtq5ijqUnqgEwmG0OcIHqgSTUB3MxHvPsF0/8Vm0N/++PYLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499799; c=relaxed/simple;
	bh=LOFa34n+Q9ijIs9LWF30q2JFcv1cR4Ii10yde/yMeR8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gDCbJ/HdWgjr+aK7M9jgeXW/NL3AjcyM/m/vdj4CVYuVyhf05U12ZGF1QLrlLftIK1vNXFIS4nzfWsqCas+hNc0sjY77gNkNzZqAwldNfLWnYsX+GDPF8uBR9mumU+8GH46WKOnRZREPysWrVDxWEpQTuayNYUzV6se7AuWOz2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaxLL975; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A46BC4AF0A;
	Thu,  1 Aug 2024 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722499798;
	bh=LOFa34n+Q9ijIs9LWF30q2JFcv1cR4Ii10yde/yMeR8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QaxLL975nsVJiTB5QjeU3bAgAs2WxSTWMjNMDzDDyY6fz08hcEQ/eRWbYDCYEAiew
	 uYhvovVFB/bRlealZJiCHbQ3KWi1QuAAcv6o1tlov27D0VN8WUu1Py4TdyRnHarDGB
	 lNrUM/CbUuN0iCewUEaLrrPrrhNWDGNrf9ULrk0aDofoNO7gcBf9p8GX8nqea6RgKJ
	 MTuA92c2paUwYLZzFgUAHeqqTuGmgYjLNg/6sAbfXi3UQV18jV5WNgyIMzs3EFsI/n
	 c12vjM8O0mk3Klv5VkL+jZeM5yejiEoigDRNWdWvPCjnVKkkhBrd8XlBw8JmEa8w2b
	 +NUNuj9tH4Qbg==
From: Kalle Valo <kvalo@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for gpio_request_one
References: <20240731210312.7622-1-rosenp@gmail.com>
Date: Thu, 01 Aug 2024 11:09:56 +0300
In-Reply-To: <20240731210312.7622-1-rosenp@gmail.com> (Rosen Penev's message
	of "Wed, 31 Jul 2024 14:03:08 -0700")
Message-ID: <87h6c4k6jv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> Simpler.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

The title prefix should be "wifi:". I can fix that, no need to resend
because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

