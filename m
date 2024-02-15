Return-Path: <linux-wireless+bounces-3623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8408561FC
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E3EB354FB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20412B175;
	Thu, 15 Feb 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBpdcnPv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCA129A75
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996268; cv=none; b=CGEDQxFKx5C+3/K86qAXTgGs+CAmaiC4roFKtpdKYOBIiPB4QFcp724b9wi1/DuxWrKQ1IFObmcUZ4GtT6Qhhiicam6VlWCQm5zQ6X66EOD2y+aC1yYowd5RNST1ExtZaYTdZ2kx47TnX5e018qjW5eRz+YivkhiBtKcFW80J/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996268; c=relaxed/simple;
	bh=e9t4tQYz922y7RN5hEL4FP0g34f5lUia3j7hxRXj3xE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=U/IXITpSyjHjugh0UQrWqnnX9G8SpQb3aCQmQTz6FxiH85065ysYycpdacvklEWQa7QQAeVKbHj4bVAQkSFdAHGKwYeGzcz/ayPm4ohu+2nqsvzHdPAGSrna2kQP5Sy83EWrk9CO0P1lkXsWBtR0osOj/0JXTSPVdZ4o/bOyKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBpdcnPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD939C43390;
	Thu, 15 Feb 2024 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707996267;
	bh=e9t4tQYz922y7RN5hEL4FP0g34f5lUia3j7hxRXj3xE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=RBpdcnPvzXUVHrmoxV7aTFdDfQxiyWk4rGAVSfD/iaQDMwXhH7z6ImpxoAgc8gQtT
	 uizUf4q0fqIgdJPYu9J/sl0VwqWyyGzMnwRr7/cBSXl5WtdR4ZIAed10LwWEKRSsH5
	 DTilW6inGBBevIOCQpWI2+aP4LBAA9RJzWdyp2PrGiAO5KaOC/6BUdFLW9D1wZYzWA
	 icV2FNr6Jkn7eprXN3rdpAjaImrfEvdbeD+Bs2DlWnwba/ReihubmU9ddf4D5zJ5q8
	 36V1oHtvvun87jrcLsAFOtwULblmWNGBoY93tlm1XnhZdj09gD8SWN7X7rHlKqrnPS
	 Vvwd14dNorjLw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: remove unused scan_events from struct
 scan_req_params
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240211151036.1950292-1-nico.escande@gmail.com>
References: <20240211151036.1950292-1-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799626510.3860606.15664868735604637285.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:24:26 +0000 (UTC)

Nicolas Escande <nico.escande@gmail.com> wrote:

> As discussed lets remove the unused scan_events field from struct
> scan_req_params. Also, as it is not needed anymore, remove the underlying union
> wrapping too. No functionnal changes.
> 
> Link: https://lore.kernel.org/all/4be7d62e-cb59-462d-aac2-94e27efc22ff@quicinc.com/
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3ab6aff5793c wifi: ath11k: remove unused scan_events from struct scan_req_params

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240211151036.1950292-1-nico.escande@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


