Return-Path: <linux-wireless+bounces-1706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB9682ACA9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCC2281816
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2612154B6;
	Thu, 11 Jan 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJzifp7H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97873154A0
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 10:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABC2C433F1;
	Thu, 11 Jan 2024 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970479;
	bh=YAn0gW7c9S02X1yQRKBnWhUNi7TdPFazJhFyTkhUOZg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=pJzifp7HCNC7XfYHkeAVVINdNvWxHPUoEj7idL6i+Qfaca+/n0MxNAIDRkQyAMsRR
	 09JwFjDCM53kXeJcm9AEieB+zekQWSCcxKkrY7FYjsqgfz75p50eV2XP1bUT2BllFh
	 EflGX7gN0XFUJFMLScrme+KHMPIZgc8uPQ7MNiStVemeyIoLcez8hAZulDQQuOQjKp
	 TRNjAMz1v5NfzIkRb3nhvJ6llKEqMUmKctSJf3Jvi9CxpW7Hh74uXyMZUdLKcr7STT
	 t9t112PW0Q5Zf4Hemc+afZXJBMMYlZvfLYJRyIgHwc9kwVP1DZKlYLmGqRImSK0IdL
	 6l7MlNTIZxK5A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: p54: fix GCC format truncation warning with
 wiphy->fw_version
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231219162516.898205-1-kvalo@kernel.org>
References: <20231219162516.898205-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, chunkeey@googlemail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170497047613.594140.11830619859424475231.kvalo@kernel.org>
Date: Thu, 11 Jan 2024 10:54:38 +0000 (UTC)

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
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Acked-by: Christian Lamparter <chunkeey@gmail.com> # Tested with Dell 1450 USB

Patch applied to wireless.git, thanks.

989cd9fd1ffe wifi: p54: fix GCC format truncation warning with wiphy->fw_version

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231219162516.898205-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


