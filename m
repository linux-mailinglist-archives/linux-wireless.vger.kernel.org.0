Return-Path: <linux-wireless+bounces-3247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68A84BCAB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 19:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A7A1C23022
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F35DF5A;
	Tue,  6 Feb 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMroMUgm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF814DF56
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242793; cv=none; b=MNyNWOQ2Od8Yo90/t0KUwnDwiMmStd/x4gx6TGXZd3An2lNxD99EDP9f7FkQFdH3DM1BoRsKB0ZGPLgmz9hx0az1gUOjo/P1Dx6egP8yvgDBbRcVmJ56OTAXLElKp5atpw/Q4HgXc+hpO0Tf0/2Uz7REPmOptrkXLr4rz1orJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242793; c=relaxed/simple;
	bh=5gj2VcJqPALoxtQRmPAWqTM59hfQsY+gk1AqpFUyAx8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MIjhJGljGXagylo8ylmnDRlPwU1Xx+YJVGeT2/yV7NO0uNf31j6FPa4lMahnsL8SsU5NjM34wDOCZipFfSQc4fSvQa2GRMCPNmnugmS3HyYgPc5q0+uv8eaVGdL887smPd4eg9tC3/yvY351YsI4rghPjE/ZyW+2GF1dIrwI+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMroMUgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CCEC433C7;
	Tue,  6 Feb 2024 18:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242793;
	bh=5gj2VcJqPALoxtQRmPAWqTM59hfQsY+gk1AqpFUyAx8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OMroMUgmU3pAYg0479FxTJKKt5PEHGXhaFVXWZHgumOAyRPPGHbPWC5SUbfg8BN7o
	 6oLpBzXhtZO1/Sw6VfUHJTk2X0cwvYgsJRVPSWDmRzfz4FfWtowWMN1gzIw2spaKhW
	 0tJs62nsLiD2oE5hTrAnXPTtDVj+a+TsOtySIi+CGCV5d/EK1o7Hl1YG0mWfUjZJlI
	 vQxe4BoTjaE0jW+afizMoYIilJYJRcOng0ecWrTYzE3z8YDCmzBrBVuvSl5Vdpsj42
	 0ki9CHj2Dum+wxeXTfxVIy+9NU3OF8Km9pUJdyEhC4Ghxwb3QnrDrW2FlSoisHdL6G
	 ML7+AoLBn9VvQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: rtw89: fw: consider checksum length of
 security
 data
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240204012627.9647-2-pkshih@realtek.com>
References: <20240204012627.9647-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170724279068.1979906.13141395871215620226.kvalo@kernel.org>
Date: Tue,  6 Feb 2024 18:06:32 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The newer firmware file provides security data with checksum, so we need to
> consider the length. Otherwise it will fail to validate total firmware
> length resulting in failed to probe.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

dedf78efd288 wifi: rtw89: fw: consider checksum length of security data
5462b8505f53 wifi: rtw89: fw: read firmware secure information from efuse
12ff5e1cca33 wifi: rtw89: fw: parse secure section from firmware file
43f8a4dc40a7 wifi: rtw89: fw: download firmware with key data for secure boot

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240204012627.9647-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


