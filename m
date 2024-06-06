Return-Path: <linux-wireless+bounces-8623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDA8FF007
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FD71C22483
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C8A197536;
	Thu,  6 Jun 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heNGA8U5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35998195F00
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685394; cv=none; b=S5nzRVesA5iw0JsOkxVIvP3J9Qj95QlMxkeDGdyjODPYnwD4Cg1KHZ7464rVW9lWOcsPpRg7fvfgfxKiPt4MYStP0TdbfDqGFjnULdFCXClp6UzCwxTpdENcQsZpmO6yB4sTDWShLH6p81qv3OuNpMKQTbGTjR2RGE6tDQ0d/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685394; c=relaxed/simple;
	bh=KyWSqCy4y4RAmggOkMol/rJUPGZ7GGG0ZXiF6oovYR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KE1uL53yNNsnycRXYgk1loH72KUEMdV/6X3JuLIezvVVSM026R4erbjDyqT/t2rnyZNIBtgtZ3Y2v2ZzMuyNWdOYG29fPKv6ybnhQnJpCvzetVUDq/VNbu+Zz1H2jF5w5FkL687HBiQWKYnhALpF6MNH9Rz+C23GcKSkpwj9otY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heNGA8U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86708C2BD10;
	Thu,  6 Jun 2024 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685393;
	bh=KyWSqCy4y4RAmggOkMol/rJUPGZ7GGG0ZXiF6oovYR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=heNGA8U5jJ6uhJsp81YfDgADGow0uoDRDK4t1QyunDx2s5U1yBvRRL8KZsMMt9jat
	 T40SO+TneWiSCqhgEiR0RhrTFAvQiMeuC5lSdEGv/HYt9c3VYwMWNPlsgGxOfhdOLW
	 1yv56LyueR4EOWM7ldcz4fiNmz702XWk6cElgCrEY0FJD+RwDhCJdeiORvFRKSWRFv
	 T7kDN3nZND1giCGgsdPDzHlTsvbw8hI4/cjSdRbPmRraatfvOZdf/Dx/SslHHEtXZg
	 bK3bPOehZw7hId+rqaXPcpNMmdpH6TbEXyNCapt82hKB97OIy71lKXS7D12wMT6/Xd
	 oeuegQitoRLCA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 87B7B5F8B0;
	Thu,  6 Jun 2024 22:49:50 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240603060558.98791-1-pkshih@realtek.com>
References: <20240603060558.98791-1-pkshih@realtek.com>
Subject: Re: [PATCH 1/4] wireless-regdb: Update regulatory info for
 Malaysia (MY) on 6GHz
Message-Id: <171768539053.810063.5040807853852576172.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 22:49:50 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 03 Jun 2024 14:05:55 +0800, Ping-Ke Shih wrote:
> Malaysia Communications and Multimedia Commission announced CLASS
> ASSIGNMENT NO. 1 OF 2022, which page 11 describes frequency bands
> 5925-6425 MHz are used with conditions of 25 mW EIRP for indoor and outdoor
> use and 200 mW EIRP for indoor use only.
> 
> [1] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/4] wireless-regdb: Update regulatory info for Malaysia (MY) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/ddbf3192cbc0
[2/4] wireless-regdb: Update regulatory info for Morocco (MA) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/472f62de66a7
[3/4] wireless-regdb: Update regulatory info for Chile (CL) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/2b2e1f829e84
[4/4] wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/30b964dd5d3f

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


