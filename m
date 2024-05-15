Return-Path: <linux-wireless+bounces-7666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3D8C6021
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB9128189A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 05:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B139FD7;
	Wed, 15 May 2024 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewk9lT/T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798539ADD;
	Wed, 15 May 2024 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715750406; cv=none; b=EWnVonGlbOzqio7tTOgP4sNsJMydS1ZfO3ZbIVgwrr68SBPkju6OQn0FgUF5Kw5IoxdYSdqyuA3UClP4zIUA0XC4aJwIEKqOIog4JyGfZEn2691+Uw6QdKoZC89sJXTzBdeIEIqSj1QRcW1LNhit62L1Fpo/3MEcNFcQXobdd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715750406; c=relaxed/simple;
	bh=rl/7aOeZVPBm0n8NZhPXRYAk/jsWzpU7OGzVDPRqlds=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tQpUFJfLKkbmU79M/uw//9IzfJS8BGz0DBEUO+t9IEfa9Tc6I5VFY8Dyv8jtbSNezD4E6UOSLrJ+De/oJyRyTtXHSX8J4s9GZUIpV9NO9p54mjfRMhmXJ98mObxN6jgFheDlGIr26BcPphpbrMPIUIYQXmdkjbIYMV0W8rdyWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewk9lT/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D2BC116B1;
	Wed, 15 May 2024 05:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715750406;
	bh=rl/7aOeZVPBm0n8NZhPXRYAk/jsWzpU7OGzVDPRqlds=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ewk9lT/TEQ59ktaWGHajZTJc+lMOMhAHeTr9S3hJHkLc8jA87kL2H96LWeSAxT+gw
	 yfwSh8+4our/Z/0suMrVvBpsjfOKgWTr4pSDfrZW50Ockrl8UKgOiq6utY/vNi1epH
	 BqH4PChiBQF48VzAjFmQZpuMnA6iRJMNZ9WQkpDXH5rZO1E3bFocXWgL0wPuZJk1yD
	 59HfLaxhxVJ0UqnvZf/VQVq5GJBGPwm4wBizeDfH3yfvLCPl2xkb5Nt/FiA7hyQRsu
	 vW4TIl1zt43RypfJClw5HrxnIgRiklNy/6AzZaz2ymH5zk7C/96xW57U/Ct9OGuvEW
	 G9er1t8RjT1TA==
From: Kalle Valo <kvalo@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,  "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
  linux-mediatek@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  Felix Fietkau <nbd@nbd.name>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Ryder Lee
 <ryder.lee@mediatek.com>,  Shayne Chen <shayne.chen@mediatek.com>,  Sean
 Wang <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  Peter Chiu <chui-hao.chiu@mediatek.com>,  StanleyYP Wang
 <StanleyYP.Wang@mediatek.com>,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  Johannes Berg <johannes.berg@intel.com>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
References: <6061263.lOV4Wx5bFT@natalenko.name>
	<2341660.ElGaqSPkdT@natalenko.name>
Date: Wed, 15 May 2024 08:20:00 +0300
In-Reply-To: <2341660.ElGaqSPkdT@natalenko.name> (Oleksandr Natalenko's
	message of "Wed, 15 May 2024 00:51:38 +0200")
Message-ID: <87h6ezircv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(please don't top post)

Oleksandr Natalenko <oleksandr@natalenko.name> writes:

> Also /cc Johannes because of this commit:
>
> 6092077ad09ce wifi: mac80211: introduce 'channel request'

Have you tried reverting that commit?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

