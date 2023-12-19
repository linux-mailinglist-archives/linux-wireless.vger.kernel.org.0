Return-Path: <linux-wireless+bounces-1001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529E4818E37
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859071C2170D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9AB341BA;
	Tue, 19 Dec 2023 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud7EygRw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED8341AC
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA3AC433C7;
	Tue, 19 Dec 2023 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703007204;
	bh=YV1viPAvkQj1veDTA8/RlWO8+ONFJQx0r0bJB5cx4OI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ud7EygRwL0ADipNVOObBqNGjRQBQQqgn9cr9YZW+rxaExU0lAeOBIEA8pEsJqWPvR
	 OcSr0dMNuGVQfAJhAJ5rZO9WtC/J3LG2TnXy4CNY5NIN5pvhKpo/LRWmsOMh/MV5wY
	 OQNJKNIPfHCA1XoVOrBcR/jDm+z7sFupz4I36jWlPZJwrNZq/6l6Uj1rKb6rnRd5Fx
	 bwG2YaWhelTp02x7gpKh+bhMbIrWdI0Hn8GYWgwotpJZ5MBqiTW5AylAu6DYqmVVse
	 aOPY6GRtoc5HRAo8amFlK0pZl4JitdnQXxSeJTF5XGwNOGDtJcOCT9Luff/4rm6SBF
	 ndi2dYQZDYVaA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: p54: fix GCC format truncation warning with
 wiphy->fw_version
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231219162516.898205-1-kvalo@kernel.org>
References: <20231219162516.898205-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, chunkeey@googlemail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170300720199.899034.3258255171064401475.kvalo@kernel.org>
Date: Tue, 19 Dec 2023 17:33:23 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> GCC 13.2 warns:
> 
> drivers/net/wireless/intersil/p54/fwio.c:128:34: warning: '%s' directive output may be truncated writing up to 39 bytes into a region of size 32 [-Wformat-truncation=]
> drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 16777215]
> drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 255]
> drivers/net/wireless/intersil/p54/fwio.c:127:17: note: 'snprintf' output between 7 and 52 bytes into a destination of size 32
> 
> The issue here is that wiphy->fw_version is 32 bytes and in theory the string
> we try to place there can be 39 bytes. wiphy->fw_version is used for providing
> the firmware version to user space via ethtool, so not really important.
> fw_version in theory can be 24 bytes but in practise it's shorter, so even if
> print only 19 bytes via ethtool there should not be any practical difference.
> 
> I did consider removing fw_var from the string altogether or making the maximum
> length for fw_version 19 bytes, but chose this approach as it was the least
> intrusive.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

I forgot to include:

Compile tested only.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231219162516.898205-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


