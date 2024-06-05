Return-Path: <linux-wireless+bounces-8574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C168FD5B1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B488F1C21878
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5517559;
	Wed,  5 Jun 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkQKFxTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C91156CF
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611987; cv=none; b=Kv8SYNmSrNrKEAfqEPrvnPx3Yl+XZjIyRlyIAowSbNBl5FYA8gB4ITzG0GWo93bb8mRF9iYswR98K5OALebjLJLTar/R+lQJDrzjcuN4jxvXLUvLYImRG9fTV9t+NuKyYwzpTzHe6cbeaA/ihNTNUe3Ub+OOq6+N3qhbW/lJbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611987; c=relaxed/simple;
	bh=g1QxCXo+SCtZiMHOFaIU/h+j9UGaKxIf74kG8Dk3sW4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MJutpG5no+frjkqAMqPbwbGwjkbMPyRxwWrbTOnG3mrJjn8ZxeSqJFqYKcOvkRvOb1dRrsqg1rJJ60zMCaUR025aTnQn33UtIWVEzGrZ4gCTf2facPbg608IGIuLGqXINl7hz8y+kf1z4Iey5JT52E7FK0uyrKixoUPAkHnz+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkQKFxTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06234C2BD11;
	Wed,  5 Jun 2024 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717611986;
	bh=g1QxCXo+SCtZiMHOFaIU/h+j9UGaKxIf74kG8Dk3sW4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=pkQKFxTr4oejL02Kd8pgX8HYNVoE1+hK60AyHjSLPBFPpiSFiJ/YlO1sFOOl9F+nS
	 Q52jDr6O9EG6aiiK/CCAwu+dmE8CIL3ys2B/hpKkAD13HgKMZz0yOMPPluufukd6fo
	 43e9p6g3M8Z5I9AjnC5ikCKq3dQio4+b5+BeXPGaYPn0LuYK/yht2FhJLbxTqngzoj
	 dKwqhH2jP2qKURCOJEw8jHoyFxcd//XBYvmPgApZyY6uMeK4y5v11EXAnkA9FTovKv
	 Ii06kt0Mwuz5tjHIgVlWyKe+rVCyHpv7LtDvfx59B1qexc6Q/3OSFIbfkTDOBMdYSa
	 NmYdqi+Xp9uDg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-06-04
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <6f28cf60-56e3-4a6e-8a5d-1465bb30b53b@RTEXMBS04.realtek.com.tw>
References: <6f28cf60-56e3-4a6e-8a5d-1465bb30b53b@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171761198397.2099453.12190142092984762900.kvalo@kernel.org>
Date: Wed,  5 Jun 2024 18:26:25 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

f29dcae96ec8 Merge tag 'rtw-next-2024-06-04' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/6f28cf60-56e3-4a6e-8a5d-1465bb30b53b@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


