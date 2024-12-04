Return-Path: <linux-wireless+bounces-15877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542949E3122
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 03:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC09B27FBE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56654224FA;
	Wed,  4 Dec 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLMU9adE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE41A296;
	Wed,  4 Dec 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278089; cv=none; b=AfmcgUdHkCO12KE/CPWkrOT8WidBaJ09+Jg1B9Ey4e2nQjVNZnL688RmKFdy3JX317lt++kJgsDYuq94lQVaprg4axmrIW9aBaD8Wli1UumP20nHzjaCGB3FrQWuYNPhref3l9180InkjPRyDfLhY21aQ3nvlLOBgj6OW+mmPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278089; c=relaxed/simple;
	bh=hd1/msMOulHJcaxIISi6QmyLYUJzfSJUMaX3HYjuCPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzAcrQrjt85MHQzIU8ddhz0HAyb4CK7+4pgGDyX4SFm+ODbNyxkf+vG3X7DwTPwHV79X8akn6l+DnZB4wjJXeYIe9OUImweBIUR7bRLK0JbEE2IPOWLF3S5kwaWSnJnefEaIkjdzAIwEtCCvuLjL0a2+aQNHOGe0duNBxqcfzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLMU9adE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598EBC4CEDC;
	Wed,  4 Dec 2024 02:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733278086;
	bh=hd1/msMOulHJcaxIISi6QmyLYUJzfSJUMaX3HYjuCPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kLMU9adE3hS5kUhr/aesVrPjRFqCvuj/7PJJwDJTmfvTc62qHfnfJCetjs7HA1Vum
	 PoIcy3UZSaOQL/BV0x+kAEk6L51oZGvrUx+gqssXmKD81duPJzpJgMQkOANo9BMkUZ
	 Fz08H1ODR481V18uzFNz/UUwt7Kb80IRPp3mLZUpHWWA6VrRRWioFxG5LqTTTJokgF
	 ukZ0wtr6JIOHKJsGVKCS14FbkFtV09daeJIr6264GTKOifkL8yDEGgPZWZtdC4GnNr
	 d37P9JTcXrLNvn5Hk9hxUI6a/AX/ZW264lipEo+C6AG8k24k4XQCoHZiPessd7eURb
	 ytEIqzhxz5jQQ==
Date: Tue, 3 Dec 2024 18:08:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 6/7] netlink: specs: add s8, s16 to
 genetlink schemas
Message-ID: <20241203180805.5bff1afe@kernel.org>
In-Reply-To: <20241203130655.45293-7-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	<20241203130655.45293-7-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:06:54 +0000 Donald Hunter wrote:
> Add s8 and s16 types to the genetlink schemas to align scalar types
> across all schemas.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

