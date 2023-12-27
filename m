Return-Path: <linux-wireless+bounces-1289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A181EBDF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 04:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81051C2136E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 03:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E02581;
	Wed, 27 Dec 2023 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO5Fdo2Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E152571
	for <linux-wireless@vger.kernel.org>; Wed, 27 Dec 2023 03:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943AFC433C8;
	Wed, 27 Dec 2023 03:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703648013;
	bh=KwTNs2I5Gc7G3gRH1bQlkYzl7DzwzHQlsgG8bEBH5O4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DO5Fdo2ZyhUjTbgh6ZmlFKV5M505k23KCAUt+Gsel495HV5bZQbAoL4z5hJuOdWco
	 wqhAMnd+87h/SqupRQ//lbAN71L0AVEQWFvnnmPVdgeI2+kWtGcwzgtaP1xOeLXdoG
	 LhM59Bm1KHNt0DmtTilOjvsd05UYjz3cnMuU6B0lIsB6H8e6YS1CJujpTCJnDr3L1B
	 OBFh9jgsKpvMIW52x0UdwcmYDx8io8zFBh+JDylD8gSn7LI/JAgRUowrBP97iDcChf
	 NC+peDGN7w2MiNqPsvry6UkUjZ4ZARKENavy/XrIGe4mBumb+aw50EO35nHjbgiPcl
	 SXiEQm0PvlT3w==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6957A5F8F9;
	Wed, 27 Dec 2023 11:33:31 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, CaffeeLake <pascalcoffeelake@gmail.com>
Cc: wireless-regdb@lists.infradead.org, 
 CaffeeLake <PascalCoffeeLake@gmail.com>
In-Reply-To: <20231223130852.44711-1-PascalCoffeeLake@gmail.com>
References: <20231223130852.44711-1-PascalCoffeeLake@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Japan (JP)
 for December 2023
Message-Id: <170364801140.3396033.12249221541805414020.b4-ty@kernel.org>
Date: Wed, 27 Dec 2023 11:33:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 23 Dec 2023 22:08:52 +0900, CaffeeLake wrote:
> Support 320MHz bandwidth for JP region.
> 
> The Ministry of Internal Affairs and Communications has approved 320MHz bandwidth with 11be in Japan.
> 
> Source: https://www.soumu.go.jp/main_content/000919158.pdf
> 
> 
> [...]

Applied, thanks!

[1/1] wireless-regdb: Update regulatory rules for Japan (JP) for December 2023
      commit: 149c709aa510fa3fb6e98d8f30f9698ff19c26d9

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


