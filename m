Return-Path: <linux-wireless+bounces-15875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422C9E311B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 03:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D68B1679FC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B265227;
	Wed,  4 Dec 2024 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAD9Hk2H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B2802;
	Wed,  4 Dec 2024 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278036; cv=none; b=AC0dlgEyP/jZ5fa0pPs9o9eq/9cNVoDxbYfW3f7pTPJh2sf5XW9uaYFLF/wyz+jTIDjyL59qhx5/EXB8ODdC09cjiFcgYsQKUY6hp0odgQCVJBQyfv5ymGuJzquxTZk4Q1aAzGvirXX2j7Mrj8D4AGCqNyR7ihqPLu8okGt7LC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278036; c=relaxed/simple;
	bh=lCX3itGwT3xJJBqJ/zED6zfmra//WYBjFA7KgoQSvnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgtxVSqFriZAZ8tPbE08gHQ2FfIz7lp+oiE+ItJeSVTEvYX0ISgJBMHCsBU9Of3z9nRWFR5KyECNnhOI8E9pcGY7Ze4e9+aMUQ9TKswrrAhS3+vBFyWpwqdApO/GVtIvRqMJV/Hiz1O37ZHaT3lzePorrinY7H7xRweF0UQIcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAD9Hk2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325A1C4CEDC;
	Wed,  4 Dec 2024 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733278035;
	bh=lCX3itGwT3xJJBqJ/zED6zfmra//WYBjFA7KgoQSvnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JAD9Hk2HJ9Dl2gSyfwyudwo1s9AA2zPs2S/5/5dEN5BVNaQ3sjYIMxMWc8XNnc5BO
	 J8aJlR4hQWWuJ0wKt39occ59Zc/E0moOIAE7DnDNUjicrR6FCNMadAIKgOsfD5f+aA
	 v47Nv6byHq8t0PmSEh5gNni8dDPhL6qyNlxK6Vo5mmQsUL7LrYotF/872TQcuR9h5c
	 6LCoGdnbo8PdrqUmow9xKNMubLhpQW4ip8YFYmjV9GkDwfwDpPOu+n8hBR3GPO2gYA
	 tAghaRO2PXyWZfQN+NCgaoPHqUzteoXvJ/d9NZ71q2LZJafCMbHb14mBI3AYHxyI3q
	 5T1gWqn+kfEPA==
Date: Tue, 3 Dec 2024 18:07:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 4/7] tools/net/ynl: accept IP string inputs
Message-ID: <20241203180714.45a2af81@kernel.org>
In-Reply-To: <20241203130655.45293-5-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	<20241203130655.45293-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:06:52 +0000 Donald Hunter wrote:
> +    def _from_string(self, string, display_hint, type):

Any reason not to pass attr_spec instead of the members one by one?

> +        if display_hint in ['ipv4', 'ipv6']:
> +            ip = ipaddress.ip_address(string)
> +            if type == 'binary':
> +                raw = ip.packed
> +            else:
> +                raw = int(ip)
> +        else:

I wonder if we should raise in this case?
Especially if type is binary passing the string back will just blow up
later, right? We could instead rise with a nice clear error message
here.

> +            raw = string
> +        return raw

