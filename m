Return-Path: <linux-wireless+bounces-2865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B03843839
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91754289930
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F054F8B;
	Wed, 31 Jan 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsAGo4Od"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAD54FB1
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687327; cv=none; b=GMUOxkZVSbzJFr2dvsPfr7Ewo2A/Se92UMJU1MwXMKpiFHEmaHTNjkTKt9xihskycMljCoyBmoj0vbBa93iOLSb2FzJEzVP9/8+tCAEJOihA6+l3CSG5WLj7KkacWbygXrcXTrIfwavWQHtO5XhgwaPWK8clUlTuny6MualTLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687327; c=relaxed/simple;
	bh=z/QrSJfIBxmJxvBKEaaPDiU86iMe5I2XqnRbJeQ02cU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KzO2BJPJYSAFdi+o7RCAmFwoauZCbyWSncgz/O4XBA52wdsF3L8tMnheCieA7iKwsPbjYF7lV1n3U7IR0Boe7tIGIliKs3ZxfULkPdQOenR0zoOuLehKdi2SC2oG85Z7QNMtYwjmYpNu1MzGbOsqzauk//pSG17/r8x7pzypyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsAGo4Od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852EAC433C7;
	Wed, 31 Jan 2024 07:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706687327;
	bh=z/QrSJfIBxmJxvBKEaaPDiU86iMe5I2XqnRbJeQ02cU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CsAGo4OdMJ9RgKoiACV8SQz/Heqe/mGYO4e3AcIOTa/yp9x/dQCZlLQiDdYVZIyw+
	 7cIWjGqqyIbHuY+xYiRMRYCGbnT7gZuA0h/3Gq0DR3cPK3HXzhHSA452ZMfsinUujA
	 lOikgqvu5rEMPBKpUT5gQnA4j3hqQXejexQoL2fPvCGmj+Cc8eSos8AHERiGpIF919
	 s230+2bh9z9wKr77SNj4SqGKbuYcYlLErWJ9XPZHEWynAeyuHRP6D4WWRxUGsjH8Yz
	 Q/6Vk66XqKpn8K7hSKAVShNgXcUMsK6RjxSHqYKewy98ZYfKbxbT08V+w2Q/WmUiD1
	 LeG4MV9WB7wwA==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: stf_xl@wp.pl
Subject: Re: [PATCH 4/4] wifi: rt2x00: fix __le32 sparse warnings
References: <20240130151556.2315951-1-kvalo@kernel.org>
	<20240130151556.2315951-5-kvalo@kernel.org>
Date: Wed, 31 Jan 2024 09:48:44 +0200
In-Reply-To: <20240130151556.2315951-5-kvalo@kernel.org> (Kalle Valo's message
	of "Tue, 30 Jan 2024 17:15:56 +0200")
Message-ID: <87il3aaqoz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Sparse warns:
>
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    expected unsigned int [usertype]
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10949:39:    got restricted __le32 [usertype]
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    expected unsigned int [usertype]
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10951:43:    got restricted __le32 [usertype]
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    expected unsigned int [usertype]
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10953:43:    got restricted __le32 [usertype]
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    expected unsigned int [usertype]
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10955:43:    got restricted __le32 [usertype]
>
> rt2x00 does some wicked casting here so no wonder sparse warns. Clean that up
> and use cpu_to_le16() to avoid any warnings.
>
> Compile tested only.
>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Stanislaw, sorry somehow I corrupted your address but fixed it now. Let
me know what you think, patch here:

https://patchwork.kernel.org/project/linux-wireless/patch/20240130151556.2315951-5-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

