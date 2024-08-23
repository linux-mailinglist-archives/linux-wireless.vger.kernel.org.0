Return-Path: <linux-wireless+bounces-11863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD7F95D3E5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE081C20D2A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147791885AA;
	Fri, 23 Aug 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fn9vr9UG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB5185B64
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432489; cv=none; b=V7F4efH4QL1fuXQ18c5/pdzly5rBl+SDEyy+qM0NlmhHW9NhUDYSJZPoRfRNtCJAbFq5LWrgv2VjhWEucq/+qjbdvAjg03O6VWbNNq2X5R8Mi95eSxKxXhBYIZZcR+TPKk+Z1ds44zOhqpd68nTdSQCB18jI3uXprn6mwOyPKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432489; c=relaxed/simple;
	bh=dRWOQakGWVPeAiDAWQvLCol3//JYeKAxaHSWNjBbGmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0xek+OAX/2i1DfkMcT/kzbngSvPaO0JXbwA9+ZZn0DqTyy3dkBMyL+sqr0uF6nUYpk+Hxjz5ML4ZEH2qiQN6CK8xWR957lBm8QzZWgbU1xuxk/GOmnOFUAN7Q6NUkbRWsRqcpRSVPh9TTWJ2iooKCB7me0iF4SXw8PxykgPbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fn9vr9UG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2020e83eca1so22098165ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724432487; x=1725037287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WXvTj5hKPGYaRuXVlmgpULBUstvUKA2aKGRZ6UgIo0=;
        b=Fn9vr9UGfXbvGLBbgVibXhSquT5A11cqfrVlsch5KQDe6nz29EF47iO5+6SHIva2Ak
         NR2gK2L6Q6dd+NctZW5oDnAphL83RPU0gnZl+qKVQOaUwAevZMTyAIEVTXGgoh94sPKW
         Jx8BpbsihbqyRtEJSexmxM7FL9phsc+mAmOFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432487; x=1725037287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WXvTj5hKPGYaRuXVlmgpULBUstvUKA2aKGRZ6UgIo0=;
        b=Q87GHLype0A/TfuA+NkzOW//nBFz4ny/3aFe9GT4lSDn6O1ZI8QpIbSQGPRAdsUelf
         U0ERouSSuD4CibGLsWwsqy5uUEtJv6Za4+QRMrNWsxaIFk8OPBgGek5lzyZrufxmQhzE
         8WF2Y00QmhTJTeDOQMVUIHT9Th7PKSE/7wnz2EQm155SMzB/KX+r7VpgHrSp7rYurmME
         MLMjibh6bEBFbN+keEXKZ/wjBoBW8+o7SOR+O593Kv0IHQz6SeC4OUUk8Gyy/YeDHkJo
         jG446GAofHjW8PHVu2ccHGWCsuuMStbI6CpzJpiLuc85oz0MZ0wCk6vAOP4tS+br2V2D
         0cpw==
X-Forwarded-Encrypted: i=1; AJvYcCXQCwRjXsGzRwNbyLPS5PMqxUDXY1xDLwNw6W+K+xRofa/tzFPjF1awcMyl7DEnfhmKeEI1TeB+TAkvJwEzzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfP5OabB4htU3oO5TwxlLS2hTCo4kBSHshnjXw4cCZsFavTN9Q
	145aCSIOd6wt1ZrsWhV45sBgFZa0hiZfGDkB2zhiBQgSedq6+PivnT7ljN31UoB4rJOaFO9E0XE
	=
X-Google-Smtp-Source: AGHT+IFxRy7sr8mxRW8Kbetw0svXm7PUYpT6Tayz5pujoftJtRZ3iDb8TFyiMd53gOAIZ0FG6Z7KTw==
X-Received: by 2002:a17:903:188:b0:202:c33:b7a5 with SMTP id d9443c01a7336-2039e469d36mr34601425ad.14.1724432486885;
        Fri, 23 Aug 2024 10:01:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9d43:7af7:9970:8219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2038ba35d3csm28333295ad.19.2024.08.23.10.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:01:26 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:01:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Chen Yufan <chenyufan@vivo.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v3] wifi: mwifiex: Convert to use jiffies macro
Message-ID: <ZsjAZJjBvjGLkG7f@google.com>
References: <20240823070320.430753-1-chenyufan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070320.430753-1-chenyufan@vivo.com>

On Fri, Aug 23, 2024 at 03:03:19PM +0800, Chen Yufan wrote:
> Use time_after macro instead of using
> jiffies directly to handle wraparound.
> The modifications made compared to the previous version are as follows:
> 1. change the type of mwifiex_auto_tdls_peer::rssi_jiffies to
> unsigned long.
> 
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>

Changelog questions aside, this looks fine to me:

Acked-by: Brian Norris <briannorris@chromium.org>

