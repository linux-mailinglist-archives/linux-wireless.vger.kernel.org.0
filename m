Return-Path: <linux-wireless+bounces-18834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E6A32197
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5ED3A5940
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151F205AD8;
	Wed, 12 Feb 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dpce4hbL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7412054FC
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350668; cv=none; b=AZw/BRYvfarCirJ84c9hesAXbpKdWuF+REvF7FFMYe0kcUNxUaLIorZy9F4yBuJqjvNEOgmMjD1nYQ9vffeBW/sKVeMlarLG+ZUfOVMMCVWp/GEvBNg+Gr1h7WsNsHuGE5AtgsIKADQDq1EA6sZaP761cdwARZKCOKlqj3Gg+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350668; c=relaxed/simple;
	bh=jBYHb/Q1xw/D9uFfYicb9NT8nlJ5HhIFcQOHpEfMn5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WhbE3nJRpGb3Z/9cPvoIDwKO0cxTTHFl+PrWuvJRyeAdTAIBocSji9eR7JftWvOrPh8OSkGod9dgHrYxgw95jixYX+QxIHLBrfIITDqtYLe5Ev5W6hcl60aqNWXtuLVz8xA1wMugoW9GjjzWT7h6CSytacPK6PIG4eIuF8JshuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dpce4hbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09610C4CEE2;
	Wed, 12 Feb 2025 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739350668;
	bh=jBYHb/Q1xw/D9uFfYicb9NT8nlJ5HhIFcQOHpEfMn5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dpce4hbLF145avGuvbtUPEHwW6wUJRxFHgVfS7iIrN/8S1m/uNvLsMcRH12scfnw8
	 s7sxLwKWJaIMGTwkklTED6q3YnZTNJ63o0WKLCLtfJYbmb8ffvSoJb2thUq6T0cya5
	 PdjJnjuVuzzTCIU75EAEpEfUyLmFZUWZ73aAwdjMeMsZJSNXRN4oiXQAzg9K2IX0Xv
	 2rKyvXdty37IL9VV3OeXtzbMfWujXJtkNRGWypJg9V9oRQ4cOybj03cZI609cKOXAq
	 0SR5QdAKTcgtvOb7ZGhUOnFbzd3mpGnUsLnqYQG3I82wC12jbetuP79br3G2apfO7X
	 A51IHI9XzEOPQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id E92F25F725;
	Wed, 12 Feb 2025 16:57:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Avgustina DiPierro <tina@dipier.ro>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <EC8B2D35-4EE1-42B1-91D0-46F788EF6C61@dipier.ro>
References: <EC8B2D35-4EE1-42B1-91D0-46F788EF6C61@dipier.ro>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Armenia
 (AM) on 2.4 and 5 GHz
Message-Id: <173935066491.2471378.9238438834798247701.b4-ty@kernel.org>
Date: Wed, 12 Feb 2025 16:57:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 09 Dec 2024 21:02:17 +0400, Avgustina DiPierro wrote:
> 1. For 2.4 GHz range, based on reworded subparagraph 9 from
>   https://www.psrc.am/contents/document/4749
> 
>   * 2400 - 2483.5
>     - 100 mW EIRP
> 
> 2. For 5 GHz range, based on amended subparagraph 10 from
>   https://www.psrc.am/contents/document/11375
>   which also supersedes the previous document
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory rules for Armenia (AM) on 2.4 and 5 GHz
      https://git.kernel.org/wens/wireless-regdb/c/bd70876463fe

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


