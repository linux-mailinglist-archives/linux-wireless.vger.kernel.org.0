Return-Path: <linux-wireless+bounces-4499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F448768FE
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 17:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3175C1C210ED
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429E1B94E;
	Fri,  8 Mar 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guk7T/al"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7F568A;
	Fri,  8 Mar 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917121; cv=none; b=OY+Q2tqLuk6Cp34K+gvwDIwYABsbIoe0vDvwk/JfqCZEi9labkgyL7I3D7Kq60zOOYQoqBbmbmGgpNSxi84nLziiGdJEo0dbfhjTi5Ro05ZBulaUy1VK89fXtc+e6Oi2XQLeXcZF80MvuVfFKXmaT//Ide8fSuyTd0GRjHPhlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917121; c=relaxed/simple;
	bh=iNmXo8VTyuxY4K5U7xMgjpP8WIW/L8srrZvIuGs9f4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clrfNKmte4uee7v76zF0efbhezsUOGL/eGV2TgwFwJ0W4WyGjKyEwByADGUMoq8WvFGK5mxV9ZdJNifwI0lF3Dif16SPmN7GTjGJNOVQJaCvk69md+NSeCE4RGCNopSvOp3uGK+k4qcHvAdT3NNY/xgI/GecuJAdozc75uhQC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guk7T/al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36091C43390;
	Fri,  8 Mar 2024 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709917120;
	bh=iNmXo8VTyuxY4K5U7xMgjpP8WIW/L8srrZvIuGs9f4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Guk7T/alKYOoH/Zkw8c3fXXR8aKhbWBhKRPm/VVnPPlyzK2pUnff54kW5gXEW/62F
	 7ZeayGP9Wlgk0INLuZVI4mzdkImIIozg12UL8m0En76Tt9UVQZe3bKUXvHU2X+c9vA
	 rWpgABJbCclknX0Z+zkSKE08QGDYp/0eQtOx7yPquG+2/te/OBPtLN92F8BK51owz4
	 XX+3uw/i6VWkKaGIvM2ACWnLFO62gFi6hdhXnlZ2hNCIiUyPmLpIgYq2npVZXrrN7M
	 NTMe6prxrCnWNMotk980RSv7wEoP5CC0A9NFCxAnVJxcQUWWOHcc1q1+los7UG2nnZ
	 sevPv83bluSSQ==
Date: Fri, 8 Mar 2024 08:58:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, Ching-Te Ku
 <ku920601@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: pull-request: wireless-next-2024-03-08
Message-ID: <20240308085839.47d8cb37@kernel.org>
In-Reply-To: <87wmqc4qik.fsf@kernel.org>
References: <20240308100429.B8EA2C433F1@smtp.kernel.org>
	<20240308074539.04512f66@kernel.org>
	<87wmqc4qik.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Mar 2024 18:50:11 +0200 Kalle Valo wrote:
> > coccicheck flags:
> >
> > drivers/net/wireless/realtek/rtw89/rtw8922a.c:2235:2-4: WARNING: possible condition with no effect (if == else)  
> 
> Thanks, but how did you find this? I'm asking just to understand your process, at
> least the pull request shows all green:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240308100429.B8EA2C433F1@smtp.kernel.org/
> 
> We don't run coccicheck so it's not surprising there are new warnings.

We have another bunch of tests now which run on all outstanding patches
every 3 hours. selftests for example. We need to aggregate because
there's too much code getting posted. One of the "tests" we run is
make coccicheck.

https://github.com/kuba-moo/nipa/blob/master/contest/tests/cocci-check.sh

it's supposed to report back to patchwork as "contest", but
the reporting is not 100% accurate I need to fix it :| 
I look here instead: https://netdev.bots.linux.dev/status.html

