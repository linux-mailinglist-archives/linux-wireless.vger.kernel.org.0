Return-Path: <linux-wireless+bounces-13354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8498B51B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8F7B2177E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 07:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C11BC9EC;
	Tue,  1 Oct 2024 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isbcCBHc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2A197512;
	Tue,  1 Oct 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766220; cv=none; b=tAPyImmAEIbDsq2SfvT3Z8WSll0m5+Pao7jm7mMufGmlLxDECzjSBtEcCOfUwnjlx2CTz4XZ8AE5wYKu9yCk66rBcLbRnibYcpx9zqKkVCRmyx6Bp/WuzpZPtUzB9b3K/T/g79PXoLhg/EpatekcCGYdrBzB5LpKjqF8uWWaE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766220; c=relaxed/simple;
	bh=qtWWEMIRVQbFedJW6zmbbSRjrfDiTDpXpl0KrqnKuzk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YtUs0+T8j+zLPHZVRP+NQRIZTpZ2cDwKBUMwPzE/t372I1+TmTFcODkz8uvGbeBex8Dd8dkfRqX69Lo+bcOXt3MV8y549WO6vsNs5ldZLnp5FaXXEGix+IjgBITg3+EKI60ygdqJto7ZXcftnemEkrrMpqRIb4Ob9fUy7IKALH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isbcCBHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754ADC4CEC6;
	Tue,  1 Oct 2024 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727766219;
	bh=qtWWEMIRVQbFedJW6zmbbSRjrfDiTDpXpl0KrqnKuzk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=isbcCBHcHOn96TPzAVTE2ebdhPQ98xsT0KvRD5KudGgI1Yl1czAuWvusNP9HUfL6w
	 5kzShwNhmQzVinvs5aH/r8dwj+9ExXrrS+8ODgC0E08NustleMA9r7cfxeIgnkIQG9
	 h3LVHpllJffiNvaYv17MGDKvvHo1nkFBxEgtW6YJu1CQbtXn+W1XJps4D5ahv/3ftt
	 zAjH+OcAudDGoKgJ3f1L27O9qZpYNoUnavHgJ005DGI0+C6umNWPlp/QmKXi/YPbou
	 GmU2eCbFJh2UMhNc84FidwluxEOdFul7pfRbd6O7vkh9t5iTKcrmfGk3JmnbywM0hS
	 adiYJu/D+3frQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: linux-wireless@vger.kernel.org,  stable@vger.kernel.org,  Stanislaw
 Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH] iwlegacy: Clear stale interrupts before enabling
 interrupts
References: <20240930122924.21865-1-ville.syrjala@linux.intel.com>
Date: Tue, 01 Oct 2024 10:03:36 +0300
In-Reply-To: <20240930122924.21865-1-ville.syrjala@linux.intel.com> (Ville
	Syrjala's message of "Mon, 30 Sep 2024 15:29:24 +0300")
Message-ID: <87r0908fuf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ville Syrjala <ville.syrjala@linux.intel.com> writes:

> iwl4965 fails upon resume from hibernation on my laptop. The reason
> seems to be a stale interrupt which isn't being cleared out before
> interrupts are enabled.

Is this a regression? Do you know what version still worked?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

