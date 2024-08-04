Return-Path: <linux-wireless+bounces-10890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5F946DA5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCEB1C20921
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C6200DB;
	Sun,  4 Aug 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9VDnTmr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA00200AF;
	Sun,  4 Aug 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761686; cv=none; b=cgbUp80sJ/qR5dtgPBANlL7lCSJqntkEa1sVrW2Q59c07Tlkoy0WOoSZeAxPo8+vQGN/kGyQQSS0x5hJZHfVJOK9fRkRgz/wJg+G9lN2x+n6U69pI9x31368fpLTrHZz3sR+HWhewxlK3Db20ZtvW5pw+GOTes9YIxdp5DyNFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761686; c=relaxed/simple;
	bh=KRSUZ4HuImd2WVoGdC79EAeQoDEKWHbaRKDfzGsstso=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aj8f/Xdwduze1gTUZ3FRIeQtf63ev6XfBj/SqbRDUxqsnFC6tMoLmcy5hbjvk5GfEp82+BynoIXDBbrhbHxYFfFZdgKq6z82JkmWscNPLyJAEQy9AScXxtUpCi4eYZyqsawc8xJRv+PifiyKJBU1nZLKxqWERrTfETENOLx4eck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9VDnTmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E1EC32786;
	Sun,  4 Aug 2024 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722761686;
	bh=KRSUZ4HuImd2WVoGdC79EAeQoDEKWHbaRKDfzGsstso=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c9VDnTmr32Hg8dAIRfouNNA9Fgl2SSNObrYffQWW+M3PGtwv4KC6iu3IWsuXTeq77
	 u9gPenUNZE045Vum2nmmUqKpefftCkHwkuuMtFT18hM3PX8C27p2wGli6S4LhEl2+D
	 C03BBWJYX9ajZ/9LwiEyl/uVrYa1hXX6W8wXYtdMHN/8VoMCVjq67N91TyrdA0+tX7
	 qDByO35ZYqI66Ji1jfflHTOHs1VR0WvY3QsKeznupHW72vmZ3eergEZpgS8wpAymFV
	 EsX7lk8Xhi0CKbGt+APoeAhLN+01AllFuA6gZhsrig4DdyH4J/elubfnPbNbSkvT6A
	 l3142CsH8Dg0A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240530130156.1651174-1-s.hauer@pengutronix.de>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, David Lin <yu-hao.lin@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172276168252.2804131.2723697552155891651.kvalo@kernel.org>
Date: Sun,  4 Aug 2024 08:54:44 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The maximum number of AKM suites will be set to two if not specified by
> the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> specify up to ten AKM suites in the akm_suites array.
> 
> Without only the first two AKM suites will be used, further ones are
> ignored.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

e8b7d0c66a4d wifi: mwifiex: increase max_num_akm_suites

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240530130156.1651174-1-s.hauer@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


