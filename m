Return-Path: <linux-wireless+bounces-533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6F9808546
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 11:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77601C216AB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423C1E489;
	Thu,  7 Dec 2023 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceNszMbL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D71947A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 10:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D5C433C7;
	Thu,  7 Dec 2023 10:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701944155;
	bh=tFwkGv86AFFJXmIQAmk+BCCUjDOTKzu6KJoufVC72Nw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ceNszMbLhUEHsT8JEqxyUMeVOGN24Be3AsHYAdKcok5JSbKLD7cII4b1XQhnm+u/u
	 6OsSkIa4juic5Jyntdfl1CqQjhs12eXt4Cf67bhgRVq7EWcsjeqJ3GWz5QK3ikNIk0
	 y0f68BGaP1bw95DRbT2gv7+y0kB75mM46ohfktY1PBqwEKK9s4uAiKecflx25axWoM
	 qsNwGaWJSKjHHb2zEP4tZ85RJXWxnt8bVxrPSjClbD4Zpj9f82YAPqgDqZQ2DqYkbv
	 ntMuyejSRQfyYWUUka5aVtiENlG18oHgjRUxGtA4gfMW/bcHJixWE1aa0fGLjL0CJW
	 Rj5so2+fhVmVw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231205111515.21470-1-jirislaby@kernel.org>
References: <20231205111515.21470-1-jirislaby@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Felix Fietkau <nbd@openwrt.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170194415180.2678961.10511256344434552497.kvalo@kernel.org>
Date: Thu,  7 Dec 2023 10:15:53 +0000 (UTC)

"Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:

> clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
> unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
> parsing and add missing calibration data") added it, but did not use it
> in any way. Neither, there is a later user.
> 
> So remove that unused member.
> 
> [1] https://github.com/jirislaby/clang-struct
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Nick Kossifidis <mickflemm@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6783f10a1d07 wifi: ath5k: remove unused ath5k_eeprom_info::ee_antenna

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231205111515.21470-1-jirislaby@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


