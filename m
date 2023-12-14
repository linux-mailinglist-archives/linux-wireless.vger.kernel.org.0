Return-Path: <linux-wireless+bounces-809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F981387D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 18:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F9DB2145D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D5265ECF;
	Thu, 14 Dec 2023 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv7K2wj5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6ED65ECA;
	Thu, 14 Dec 2023 17:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D9C433C7;
	Thu, 14 Dec 2023 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574825;
	bh=bnqr0jl6e352eT1WhkqIxmaAirnqjoRIEQIzKS9Ksyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cv7K2wj5B6XKoMMeOYXhWlg6Fc2p5mkE8Qp1PNEzKYtuAhR/LHBjWbEe/PEWcuUKK
	 Mx47lPGg1mot0RBTNrUok3hr4X5M4J1l3j7t0maMesRQ6kN+fymLKz/RIoKBL7xRiZ
	 guEjPKsEBVCU2diFPL2SIYKTDgted3MmSCBhJFOO9NDi6Pd90eJLlKN+Ib7j3BU0iL
	 3QNo9RRzt/zo+09R2DwsCLgdESL4nDK3AoqT3gcn9OpOOuFX2SHHJak7nxmoP43RrR
	 UmaDY2Us25cgNwdMKZL0581k/HYIEOGUpKkNbxcDC2cOQHSshEdsXr93zvQHx7I1hr
	 CfnDksaqtVutA==
Date: Thu, 14 Dec 2023 17:27:00 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] wifi: cfg80211: fix spelling & punctutation
Message-ID: <20231214172700.GO5817@kernel.org>
References: <20231213043558.10409-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213043558.10409-1-rdunlap@infradead.org>

On Tue, Dec 12, 2023 at 08:35:58PM -0800, Randy Dunlap wrote:
> Correct spelling and run-on sentences.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>

Thanks Randy,

These changes look correct to me.

FWIIW, codespell does not flag any non-false-positive spelling errors
both with and without this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

