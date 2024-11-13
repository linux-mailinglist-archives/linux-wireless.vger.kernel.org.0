Return-Path: <linux-wireless+bounces-15267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0649C75A3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 16:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2EA6B3A9ED
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC452F76;
	Wed, 13 Nov 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGosA3jK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7471DF73C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508357; cv=none; b=Bmc0joRvDQPSBmOcL1rZStkk3QyFdXqXguvbIon5xxo+3yDVjYZqfK5ELQR7rZ7GJAflopcWeUaN1WSCVYUfe4ODrdRLa29cCSzrDyvi3A5fExvN75fX1lN6Sqw9EqLRFKIlwj5lGYWgmZNNghKgTBns4lMARWh5XhfoykFRpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508357; c=relaxed/simple;
	bh=C452Q/8O3A+nm8i+0n3I6muBGO1ya41YZ+601Y8okNU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pBi4lIcFx59/wnE42OXxZvrkZrwmIkPMdbGnjSPgmkVTffotMgAGJivKlB4uNKEhvlORFCVQOiZ8Ygw1tH1Zg7e7H3MivZjR4bBtTN+9ffoL4Az9SsxLUgJ8JfFeCmtmkd01rJzC5DgEJfoSvrzLgkC5BuvB8Pho15A8pd/Pwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGosA3jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D644C4CEC3;
	Wed, 13 Nov 2024 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508356;
	bh=C452Q/8O3A+nm8i+0n3I6muBGO1ya41YZ+601Y8okNU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RGosA3jKMi07vIBYhcnlZrXVcj6IKhAm/uDD8+wJnYWy3f6+/tcPxhjw7/kny8IhY
	 Dq/v8s9080B8XSs54vBb5G+lsMPlYM8pDKB1cqLEzZZMyCXY0KgvqRm9NX992W4OIl
	 zfg9EeMTlWaJyewLg8REMb5bMGgV/Xs4Dc9PhyxWsnaBvsyzkKPp7oo1CQoY6gM53o
	 oCBNgXTTSINkMLUj9lk9FZ/T8rhagi/pTDLSwXivG8ndzw9tmO8FD5EEiW4eRRIFeG
	 JBeCNU32p8fligxfL/cmdZULnpuGADoA7wlqekoY+ydR/vIJe9SIrKQUaVtuofEXEr
	 mhRvX22sXsXng==
From: Kalle Valo <kvalo@kernel.org>
To: Dylan Eskew <dylan.eskew@candelatech.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ethtool: add monitor channel reporting
References: <20241112211422.331928-1-dylan.eskew@candelatech.com>
Date: Wed, 13 Nov 2024 16:32:33 +0200
In-Reply-To: <20241112211422.331928-1-dylan.eskew@candelatech.com> (Dylan
	Eskew's message of "Tue, 12 Nov 2024 13:14:22 -0800")
Message-ID: <877c97w6f2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dylan Eskew <dylan.eskew@candelatech.com> writes:

> When running ethtool on a monitor interface, the channel
> wasn't reporting properly. This adds logic to properly report
> the channel for monitor interfaces in ethtool.
>
> Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>

I think the subject should have mac80211, something like:

wifi: mac80211: ethtool: ...

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

