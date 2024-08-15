Return-Path: <linux-wireless+bounces-11480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2449952C56
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 12:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D7286020
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5234C199248;
	Thu, 15 Aug 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1nL5aoz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4217BEAA;
	Thu, 15 Aug 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715497; cv=none; b=oEuTQwLU1hTpSSJJa4D0oBfc6TULOSgcmGZyuLPJG9eg0dyDbdzw+hgWZqpiSkKYceFNFHKPcg9QMyklY+ofohw8wqHkevibl/uSgcw4nNpjhfUx+6SKT8ALn8mSFTG4r15jIXn+/he7SvRlgCDSpjSlQBHvvGSiix8msxPN9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715497; c=relaxed/simple;
	bh=J1UkmUFXsy8DG2J8jkCpx59FPXmshWrfK/EwyZH8ttE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MIr1ngqrS6Mj64WSvu4KSu10p7aETTV40YgHK1rBQXOQPkfW+qmAFx4toHBvfPElJ9HBH2Mf6GXB4VJ5r+bs1knOkvi1ELGhTNKb8bnXJnDGm3IQFuBi9p3Y1Ju1Rh3fjC/gYEohebBLxRp7Smcsma1GBEzkbelYjHLisKDSg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1nL5aoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED1CC32786;
	Thu, 15 Aug 2024 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723715496;
	bh=J1UkmUFXsy8DG2J8jkCpx59FPXmshWrfK/EwyZH8ttE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=H1nL5aoz0K8KtauZKgFdU+DL3yG3h4M7rGVqsRg9grr4iYMdGx4piO3MGCEI8I+mo
	 wX8P1YO585VCNLpbFwsP2h/GKUxjncYujDb9ZmM7HSuGC+Yo/82heiu+guIMdc7+4K
	 YZaN2qDZQnKo7tcVLQmgFrEQqkTbqUhdCsvOz6z17ne0GYx8TwpUK/ChqYhvf0x65M
	 USdgpJJCA3lFSK3yGUPnstPYLAwDxcY9FFZUz/WywqHJj85VmAuTruURjcQKPz++pF
	 k5zf+zQin3kv9JixuJLDQRlgp79I5Iv2RdZEeXdBje55TWLgoVMR5AM7nPYfurMov0
	 GRknFNEFRHAZg==
From: Kalle Valo <kvalo@kernel.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "johannes@sipsolutions.net"
 <johannes@sipsolutions.net>,  "briannorris@chromium.org"
 <briannorris@chromium.org>,  "francesco@dolcini.it"
 <francesco@dolcini.it>,  Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<20240809094533.1660-41-yu-hao.lin@nxp.com>
	<2024081430-derail-diocese-78dc@gregkh>
	<PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
	<2024081523-curator-pronounce-4619@gregkh>
	<PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
Date: Thu, 15 Aug 2024 12:51:33 +0300
In-Reply-To: <PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
	(David Lin's message of "Thu, 15 Aug 2024 06:20:48 +0000")
Message-ID: <87zfpexgey.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Lin <yu-hao.lin@nxp.com> writes:

> So that mean I still need to add description for every file, right?
>
> Once if confirmed, I will prepare patch v3.

Please don't send a new version yet, patchbombing doesn't solve
anything. I would say wait for review comments at least a month before
sending a new version. But maybe send the patches only to
linux-wireless, that way people outside wireless don't get confused.

And PLEASE do stop top posting, that's the most trivial detail when
working with the community. If you continue top posting then I will
automatically drop any patches from you.

Carefully read our wiki page IN FULL about submitting patches, link
below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

