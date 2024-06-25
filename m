Return-Path: <linux-wireless+bounces-9530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87817916834
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 14:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436FF289361
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4FC156F30;
	Tue, 25 Jun 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qadnPcsE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252101482F8;
	Tue, 25 Jun 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319283; cv=none; b=VFRWgBEPlfqeGJuv1v3LI+es6LVwON8k00AWLPix7ioZDPBiwEd9eJEoz291uC1DPJlXtywqCummd5Hvf1Tb13qCYMh3LvdUYSsAYDheY12A4p1c1O9PYsU4ZzJYhea6DVVRatRpKquEDepfJcMmqyV6S4eWCTcph2gWCDceFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319283; c=relaxed/simple;
	bh=YKQbZBXwulqYMQb5YUdN6Gpi46YdbW5u7wB0f6+CA2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUg3k6Vou2xSISH022mNDeOjG/WJJWE23cRI9Jh3dOoR0UFddpemOU3a2/dJgPjDkJ8yQSp30FHDEZWXc4yq5dUlLTO12QZLzTd6lK6bMaiv6XMbR/6o1IaBnH7ze7eR7gqDpXkvMGlA2bvA62kd/6q2FmCxnjvsAAZ7yGnLdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qadnPcsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BDEC32781;
	Tue, 25 Jun 2024 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719319282;
	bh=YKQbZBXwulqYMQb5YUdN6Gpi46YdbW5u7wB0f6+CA2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qadnPcsEQ2MUakso2obL04I2L3fleS49aB0nBdIoi3nLK7g3BzIjaEQeUgOjBTYb5
	 2VZFlXu40xDDZ4J/vlXR0knVOM7+/9gopB5FZxvtR81dJghFhwTN9zetKHphIcrG6D
	 JtQOOyo3Gz6rJB4C1+rNSpWt8A5rO6/b9lnXjpAQ=
Date: Tue, 25 Jun 2024 14:41:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	florian.c.schilhabel@googlemail.com
Subject: Re: [PATCH wireless] MAINTAINERS: Remembering Larry Finger
Message-ID: <2024062557-antiquely-slander-8b5e@gregkh>
References: <20240625103929.1332926-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625103929.1332926-1-kvalo@kernel.org>

On Tue, Jun 25, 2024 at 01:39:29PM +0300, Kalle Valo wrote:
> We got sad news that Larry is not with us anymore. He was a long time
> Linux developer, his first commit was back in 2005 and he has
> maintained several wireless drivers over the years. He was known for
> patiently supporting Linux users with all sorts of problems they had.
> Larry's work helped so many people around the world and I always
> enjoyed working with him, even though I sadly never met him.
> 
> Rest in Peace, Larry. You will be missed.
> 
> Link: https://lore.kernel.org/all/77997185-86a6-41c5-af7a-74e4e9064437@lwfinger.net/
> Link: https://arstechnica.com/gadgets/2024/06/larry-finger-linux-wireless-hero-was-a-persistent-patient-coder-and-mentor/
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Yes, very sad, he did so much for the kernel and will be greatly missed.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

