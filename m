Return-Path: <linux-wireless+bounces-13573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87C9922F3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 05:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C258D1C20893
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 03:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D75179AE;
	Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXfqT3ph"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CF17999
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271672; cv=none; b=emxIPD4zTFE2IkG1M6dBQfwXzN4Qg343vNR25SUs4Pb8ZVzN6HDQif+qQBa4Hs9RaQQEY5QUtQOv7n/RFej/LSXoFDyWsbBJ1vcvK7slVr98eRmIvEzvN041RlQafeaxc5BhS1snF6lQ3o5Q92aAwZ0kQx6SpvHRJsdX17JWCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271672; c=relaxed/simple;
	bh=qVO1g+cGILr+migH4IAk5G+/RneP2PQyhnhSxr4chpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hTYtN0vBJ6nrQtqfvGd/APOgDNoVD58uxS/TpMGEmglW98jH8E6NInPvge/A/U6wMb2WrVO1s09SjTfvZQbh/QRjswBxBouq7cF4P6jPmu6HxwzMSGE9sk6TVq+2VMu9HBLBw9nlhospQ97WgLae9qtabGdhXWjKJRafx/vj78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXfqT3ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17F4C4CEC6;
	Mon,  7 Oct 2024 03:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728271672;
	bh=qVO1g+cGILr+migH4IAk5G+/RneP2PQyhnhSxr4chpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sXfqT3phJ/lSvX4eE8KF0lQSRmtal01Iyd99fzD5tlNzJ0385NrVPbp7ks/VTBE9N
	 X4m9v7aOmJq/X4GZmOjt9+jW+sCsKB2bDZ1e+BInTaGa6rIQ2YbRQRcF4J1EXz8G5X
	 vTImk28QArSuH61nHlYl6saCKIC0r26qoEOfJOGb/DQFUegBzbBy4P3oyFLbgm1ogz
	 8WgTB5QtfXQohbNjsoYEShfEWscZyssZ5xz6bSIVmIlprxjTQbzYmlOfzzFV3TlnhQ
	 O97ULICrTt0BII+ThT3jC1h2cEG3VnwJi5VvPmJTeueXstG7/s/LmWVwf3m85D8a9B
	 uQrgKpcKVGFCw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 4EE7F5FA88;
	Mon,  7 Oct 2024 11:27:49 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20241001093049.37515-1-pkshih@gmail.com>
References: <20241001093049.37515-1-pkshih@gmail.com>
Subject: Re: [PATCH 1/2] Revert "wireless-regdb: Update regulatory info for
 Serbia (SR) for 2024"
Message-Id: <172827166928.1242641.13961845240628425833.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 11:27:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 01 Oct 2024 17:30:48 +0800, Ping-Ke Shih wrote:
> The country alpha2 of Serbia is RS instead SR, so revert it.
> 
> This reverts commit 388c80ccba39d4ff4957a5d153c461aaac53e22e.
> 
> 

Applied to master in wens/wireless-regdb.git, thanks!

[1/2] Revert "wireless-regdb: Update regulatory info for Serbia (SR) for 2024"
      https://git.kernel.org/wens/wireless-regdb/c/dbfae475bf85
[2/2] wireless-regdb: Update regulatory info for Serbia (RS) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/b44edb2eaf3a

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


