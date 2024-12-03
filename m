Return-Path: <linux-wireless+bounces-15868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C889E2CDB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 21:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA9328C9D0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 20:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472641FBEB4;
	Tue,  3 Dec 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epKMAgtq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B5F1F9AAC
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256897; cv=none; b=CpiFZC8xUcGTEf+Y9Mh7sR33p1gmCNZfuZ4IAVju7w++aemY/wNiqiLfIZtY2Brm2z5ChgLZ8Vn8aIdua0CuVwzZd8CDCthzlxBEEpTv/rr2BdYsrqYmGDMp5kINw7/oXlhjUHNH7rpqK4IWf91w9biiTBRT5dJF61CELQkF1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256897; c=relaxed/simple;
	bh=jJsJD5gkAYTSSl6aVBYfkyXyGRLHld2148EjGe2n9nc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ckl1APIHDkBPdpStBKEH8DqnnDaRiaaeeb/6oL6ydOnSYsJAg47iVFrWtfv/mrWKBO9v4kgXbAMuYZklUVzVlOBoI336lyebnUlqcj7fJRp4egrlS00AteFDUTBlbcKDjPuBIwZbMUtOCdWmrt7TeAMJMovgv1XYso0l1OzmNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epKMAgtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A2C4CECF;
	Tue,  3 Dec 2024 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733256896;
	bh=jJsJD5gkAYTSSl6aVBYfkyXyGRLHld2148EjGe2n9nc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=epKMAgtqyfOul8twEwHyoJl9QszM61hTT64KugSgT6IhvxsTi2tE+kuaYp04k/rK4
	 sb6YdAzDJydPpu4QXynWsAFAf0Z3NwZvZyb7elAGlJyazyN3EHAvo+jCv4Gx1z6rXj
	 cftLPG1HiI8iH4PbiPx3UXwCHrfpgYMK2i7+keSfYJF7itABPTXboKBhMopWA8ZiIP
	 fN5NZQfGpHCRFuYcx5q8grxUAQs7VmaSnfDfTIwjdlAkR4tVcRb4Nj8DqPMcBrP6dL
	 BJvl4ExC4lEbg8y8jsCj11r3LEld/oEAY19TkIl14BUEYpyB/lgBgvdZSaK3lggJ28
	 VwbU+smXiuQTg==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Andrei
 Otcheretianski <andrei.otcheretianski@intel.com>
Subject: Re: [RESEND] [PATCH v3] wifi: mac80211: Accept authentication
 frames on P2P device
References: <20241127211312.60ccc73a916b.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
Date: Tue, 03 Dec 2024 22:14:53 +0200
In-Reply-To: <20241127211312.60ccc73a916b.Ib3074ffbe7b296e0f162b2543e84346b190dfbeb@changeid>
	(Miri Korenblit's message of "Wed, 27 Nov 2024 21:14:04 +0200")
Message-ID: <87ser4ttfm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
>
> This is needed for PASN based P2P pairing.
>
> type=feature
> ticket=none
>
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> ---
> v2: fixed commit message title
> v3: removed internal tags

I still see internal tags (type & ticket).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

