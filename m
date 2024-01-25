Return-Path: <linux-wireless+bounces-2498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F483C9B4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E681C245FE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424DD13A256;
	Thu, 25 Jan 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MddihEG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08113A255
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202905; cv=none; b=dJ0XNztDEq0G0Lt0U/95SSVXZyumbu1Jmul4Lp51K4V6VWEcv2VhRnjbBtuuA5Ezilm6l2DtLIepZd6NTYxWgfXBdndEAGNLkt7kQ+SBUdrZvNmw7M3HC8GScCOzzBriPkJkiFXrr6K/lxcXpYbdjyNoJuvCvnGFv9z971efPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202905; c=relaxed/simple;
	bh=Jpm406mDAglsgv8x0fhpn+KCsopS61DCPsvmQivwvAo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=saA2P3JPhVUy0TFBkdlddLw46aKoG5imyEvVkB/aH+s9px3okRjIGBXWD21p7vmJ5n4r2NVPOVnPFqfYwG6JZLQGV2VohKoNzdwJozLY7rjIYiAAmgOneCADA46ZHjSZn371YhyL0iWRPZMi/epkUmhVv9NyiUdwEW4TXxcYIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MddihEG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659C8C43390;
	Thu, 25 Jan 2024 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202904;
	bh=Jpm406mDAglsgv8x0fhpn+KCsopS61DCPsvmQivwvAo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MddihEG537vaUectpv7FwIOgb9bNQMXLintQCsuno8Ffd+gvmXIKgCJ78OQEHtsyX
	 FFe/XdWxu9ji3vi4bW7BuyNu7SG1zgpFhyxfEYGLaH0rb1p4qtsIukUP54Y0Fhr1wB
	 oMCmGHDXw/0HzlknFk5fhIgxV4t/zzXXUc/CK790nEr8DfxUb2iyOhyU8wRoGJxPzC
	 Az1taExiVCkjBuRi/E2cEAOyq4iWtbZz88KQlxRxRXSijuGIZux89D3tbqtIKdQ03P
	 iv/LIWPx3fKqLyZIlxIsjcig91c/sNqsdIFK5hHvGbP6allSr7KktLG7usmF+biHTM
	 zIwOUUqWVHwiA==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Mukesh
 Sisodiya <mukesh.sisodiya@intel.com>,  Mordechay Goodstein
 <mordechay.goodstein@intel.com>
Subject: Re: [PATCH v3] wifi: iwlwifi: disable 160 MHz based on SSID
References: <20240125163103.578d2d3a617f.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
Date: Thu, 25 Jan 2024 19:15:01 +0200
In-Reply-To: <20240125163103.578d2d3a617f.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
	(Miri Korenblit's message of "Thu, 25 Jan 2024 16:31:15 +0200")
Message-ID: <87o7d9cp2i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>
> The driver should not send 160 MHz BW support for 5 GHz
> band in HE if PCI Subsystem read indicates no 160 MHz support.
>
> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Stupid question: how this is based on SSID (Service Set Identifier)? I
just can't figure it out, I guess I'm missing something.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

