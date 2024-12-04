Return-Path: <linux-wireless+bounces-15876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B19E311F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 03:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92ADB2477B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE2FC0B;
	Wed,  4 Dec 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMXJZVXL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAD3A1BF;
	Wed,  4 Dec 2024 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278075; cv=none; b=P4mFGzZ0H5Z4YUn7OGx20/drqJm0panBQHs6P5FXCsl5VHgLjI/XurQWfIVbk+5qyE7PKr9503FPMUsc5G4jauNmospliAfvU5ZUx2mLkwN3fGYxnrKQ0tvzMpHRdKe2LKE+RaWtMJ++mZ0piNOj+niXgLRYLzsSQTbBWomCMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278075; c=relaxed/simple;
	bh=8XiI8ts86Qv/wnLdS/pnNWjJHz7RYrFzo6X4pVSatyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ed+YIVvHDDmd8uiQBqySV11NrN9VVroSLcfYNMB0X2epRceECKmhzU3Ax/0fDuc28XKmuHhlc28z+FzHCzYNojhgiIXq1Zz+4V76Gfy4ZlZ9qY2+SGpR0qnhmAqF1O4PnM/5xuZLpCl7m99zWJOOf0JaDLmXJpXYp38C0drPArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMXJZVXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637DFC4CEDC;
	Wed,  4 Dec 2024 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733278074;
	bh=8XiI8ts86Qv/wnLdS/pnNWjJHz7RYrFzo6X4pVSatyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMXJZVXLt42J2nB2mp1dgpzzY/wcX95/THu9vmRu2JP1kWwG3vrbaFg4dg58dbjrT
	 IXJu+JBnlQjgMtzyS3+qfHpYUSRRTVq80YRgdiGwchyXYaEZ+5yZKP9c4K2ZVKfzGj
	 gdiK9+MRYqLBfXtAP4S0E9+o0Phnnaq0AlgaV69Wrc7uk9oKGuMI6lAr23U2sD1iAv
	 IiLAB41ss6+VrdxZw9iPWpt938Ao9giPnLQNqoQuLfC4wsOtXy97dQEQqoCHbSDFCo
	 7v7lCCAoei79rYLpsNk7u4prlbLluH5Tsb62qdIHj+mxwD1lowe82cylZBMiKKnqGl
	 057rD4JIf2ajQ==
Date: Tue, 3 Dec 2024 18:07:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 5/7] netlink: specs: support nested structs
 in genetlink legacy
Message-ID: <20241203180753.6b209c5c@kernel.org>
In-Reply-To: <20241203130655.45293-6-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	<20241203130655.45293-6-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:06:53 +0000 Donald Hunter wrote:
> Nested structs are already supported in netlink-raw. Add the same
> capability to the genetlink legacy schema.

Acked-by: Jakub Kicinski <kuba@kernel.org>

