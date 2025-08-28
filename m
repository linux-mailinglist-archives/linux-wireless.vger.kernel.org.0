Return-Path: <linux-wireless+bounces-26794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E8B3A2BC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E161BA618F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3423128C9;
	Thu, 28 Aug 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdcwNHFe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667793128B7;
	Thu, 28 Aug 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392787; cv=none; b=BgEBjcWtFgcwIbIugeS9B7vq8eLtvQLiy2vFkZDvSvPJN6GddTQYyF6RTbyTbb/wSXtSALf2lLlN1XU1ZW5v8rp4ftfjxR1lHTQ3gqCX6k6coGhw5dZN1aGtH3hk1o6HIU/meFe2VdRLFUtIfS6YRPrlu8bbPLmOAT8ZIyjBAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392787; c=relaxed/simple;
	bh=tkhL9L53Smx9cDaCOVD3UH+JCscUxXQ2KufEgyoREOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEeqCVWu07Wt+6GHZ7r60QAKY8GKosxGvFeaXbfqlN716V0GJC3HBgUptLyXJQ3H4hBtSdVYh08zX9ICkkoWKySDnLVkh2ylBdTGtVSPJvFeixDIVYDs/QHjtZvCjEfj+K0O5AkPqLji2AlNCh/dXWHKABhcUvXnLN70C6hS0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdcwNHFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB0BC4CEEB;
	Thu, 28 Aug 2025 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392786;
	bh=tkhL9L53Smx9cDaCOVD3UH+JCscUxXQ2KufEgyoREOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gdcwNHFeDr0hZ817wBNdkFDJGo3U0mr6CsBQ47gS4GYMzDZPiq3YrvKkq2CGLXe/s
	 /KxOhF+YwLMC+G6MiGTZJpTcsVbvtA2hFEiP0XBQe7v6sTNDhcrIN4Xg4VITNhTKIw
	 9bfDElwfPByEzN11/uUgYvaehp0IfmoSgoHPR0jLymu3nrbog3M0NZPk2PIGDlcZUW
	 GLvOoL/ZGtcUKrxTD958lX2bmW7Qpmxed05XitXUypcZ1p+kGZO0qZnXwkHUoXeXQ6
	 iCzFd4DUk5T3l2lJAzuH6n1XnZYZbJ9gJcZX7rGusHYTPWqHLn0REQLV9Smsls8/qG
	 CYxk/hGo6OFgA==
Date: Thu, 28 Aug 2025 07:53:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2025-08-28
Message-ID: <20250828075305.46c22eb5@kernel.org>
In-Reply-To: <20250828122654.1167754-8-johannes@sipsolutions.net>
References: <20250828122654.1167754-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 14:25:58 +0200 Johannes Berg wrote:
> Back from vacation, and a bunch of things accumulated
> for everyone. Nothing really stands out much though,
> except perhaps the various iwlwifi regressions for old
> devices, which were all my fault...

This missed today's PR. Would you like me to pull before
merging back to net-next? Or no preference?

