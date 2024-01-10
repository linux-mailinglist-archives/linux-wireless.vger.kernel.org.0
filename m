Return-Path: <linux-wireless+bounces-1669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2AE829CD3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E38B210CC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04A4B5CA;
	Wed, 10 Jan 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bktM5zWa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911E4BA80;
	Wed, 10 Jan 2024 14:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACE5C433C7;
	Wed, 10 Jan 2024 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898316;
	bh=JxNVaKHwkBaUWUxhyRTq5wm+F4uKwNW37fw6ZLUIqhc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bktM5zWaVWAE6uFFo4z3nDnaQF2iIEfL+k5MasboLTIUfd9t8wFEcGtd38vGWQBsZ
	 GeyOf5n7Qf1TlbPf3DWRhtilL+uzsNkLA4/rQCfNd55jgKYqmPqKqQxpmrsrUvDTm9
	 qfqmwVVzEy5MlMiHPbw7FaeguOtCzogufKZ4h4YdrJmVFV73xXF8++fccz7hcj68RY
	 uYBvUJ7fFJwozwB8/wowQx6NzEvYyN4cti+lbffAdiRBDjpXiIqkvw2JnBpsEiwtzv
	 DBemw9t8xtNLihcDbBXOKSMKDjpX2DixEEo23nm2T03muuYYN1FAx1aOQcmbEKe27T
	 Z60q/IH4gWoSw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: rtw89: mac: Fix spelling mistakes "notfify"
 ->
 "notify"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231220141831.10063-1-colin.i.king@gmail.com>
References: <20231220141831.10063-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489831370.471554.11120935204830262187.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:51:55 +0000 (UTC)

Colin Ian King <colin.i.king@gmail.com> wrote:

> There are two spelling mistakes in rtw89_err error messages. Fix these
> and also add space between [ERR] and message text.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

6aeaa379291b wifi: rtw89: mac: Fix spelling mistakes "notfify" -> "notify"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231220141831.10063-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


