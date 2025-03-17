Return-Path: <linux-wireless+bounces-20460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A2A65F69
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 21:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2CE189EF5B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 20:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065F1F5855;
	Mon, 17 Mar 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ENDg0ENI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB51F5852
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244200; cv=none; b=Te9t93wI7E9pVd25lBf4lO9BYDu5WudfyJm9UaUwRWJ0gze2JXU7X/32H9S9gzeZMk0w/41l1Pnw5sUCmNhqdKGMxhjw3HGRH35IELvh8tIV4ybg47KFnCkhD2e9NhgPploIPuHrWrboCrH5RAu+xOepvcqI/bY9fwkO+SGxp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244200; c=relaxed/simple;
	bh=CaY9plOsZmG+vqb+Y1a/gKRrf/XFzCbAh8Gjy+jCWms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCnIE6IRcW84i3Bhi/e7bqgS6oSEcYtIZRGT8nLDgNYaz206uBNhUhMJ1WapLsPikrKKJJ3UxD5WFQDs1wjzHD38Icnxon4zHlpxlM1VEz4cPZwAEBFiFzK1jh2/rfpqrXhf8BINa6t2xYc0FeUp+Vk/vrWEXSjQz3ZIav/15ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ENDg0ENI; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso2144942276.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742244197; x=1742848997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMeuqQnVCFYcIh1s8lv0Ab4xH5GnpJ38EIK5c4gPr0c=;
        b=ENDg0ENIuz6Aks1W7JswZhQRnFXeDkSWMoghPY5Xljiy195QJRAQZh40nBJXj8NEEd
         t+sAvoGnQcSbUZBlMdFv6s/I3z36OZdXIVu5zuDrBKEOiP5SqgIt/WxMReR6xg4V/iYB
         INfgpIYEorasNEIay7nMF/n7O9ty+caatL28RaJZ+bB8xjnGClZdn9huEoYAleLZzaPM
         380ClgbkKoEOQ+A1ur/94l3YGPYGZ/FRCRsHV5LA1npPRf5eSh8H+OuzemKl2acsTdzD
         QVj+ytAj7fSpF4ESVcA5OJqkSgwFntEDnPBb2y5pBA/VdM55oASbIPsvMS5T4ejyqrX/
         qgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742244197; x=1742848997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMeuqQnVCFYcIh1s8lv0Ab4xH5GnpJ38EIK5c4gPr0c=;
        b=EEUc7pX/UPB+RJXaxcW5Wq54K+HxJ35BmnhEQd9ZCPWkVcQpXnPu8hiUsYvpdhjR/B
         FdHW63pBkTHzY054xwppXcI/D0Xfu4P/JORG/9Ks952ArL0lCP7OR9HegqFgXQsvwBTF
         xpSmaw/XLZq/I3N/cKkvTtpLVcoses3WUDrLa+Gt826UUvHE6XfUwK7eDVa9c1OJNXOz
         jsJK583BXYgJU6KmiH80WWRl9k5HpDOEd+Qqoij/bdx6E7tAW7Opexw9YP/xdOjpgn2h
         YkOamON+LxFfVe/r3ecopzq4zCivo+WfbJAssExKhQiWPOHw14+THrzDMEpWO30Cw5e9
         Lpqw==
X-Forwarded-Encrypted: i=1; AJvYcCVrRbY7fuj8Hv7bUDcmyD61wUPSzAC5hHRw/tym1krv9VEv8YLfccqGsdfWp9TFmqpHJ+g6rII7QcVxAhJwkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGahUaPs0InmtW6qcx5glIKT+QyuJRhuQm300RETz4GL9cogC
	IxzYkvGJ6MKXQwo+a+dduJL9ByCE3aIipLlLdmFmwNO3Ow6vbDqqyVRm5YsUyAuOKhqqysNmQrk
	j3xP9fCz/iJpJfoXp4G+TQg21aY1mYPq/
X-Gm-Gg: ASbGnctNlRMwg6QXA7E2F1pZktIy1PZdNPjKuoRCwLOAu2Vw1l7A/K5m5pbuaHSUoZ9
	SYRVMzLvg7pkR65/A1cGWvwISLAzzDAstNBIS3lSsb6HBsCdc/+iEdvA2iP6j+6NgbnpSpqHbbd
	SOeClPQcmlJrGGh7f6ym9wFVBcxA7Jr2/oEc3HbbUT1ttZ04X/PlZ1yMtxHpfv5pTmIoNlrH9os
	8ljTLNm9F6D/V9HifeEj3prdJTlbHskAa+MDMw9+KqqW8NWjbVIy/j6ij26GRLolUgpZla8QvLj
	zvFcTnOE98el2kxehORxvcsLHqjf9D1jAPXOCfOxCrmZGLGEow==
X-Google-Smtp-Source: AGHT+IGhYQOQzoo1W81n7SvjULK8kea4ne4u7SJCVMHMBohbiO+5gVHT5Why/Jb0nEdWm7n7qdstRUUSezbb
X-Received: by 2002:a81:c748:0:b0:6fe:bf32:a427 with SMTP id 00721157ae682-6ffeb390465mr12881107b3.0.1742244197208;
        Mon, 17 Mar 2025 13:43:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6ff32894af3sm4257537b3.37.2025.03.17.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:43:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3E38A340314;
	Mon, 17 Mar 2025 14:43:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 324C6E4020B; Mon, 17 Mar 2025 14:43:16 -0600 (MDT)
Date: Mon, 17 Mar 2025 14:43:16 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <Z9iJZBh5ZFq3wC6s@dev-ushankar.dev.purestorage.com>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>
 <20250225144035.GY1615191@kernel.org>
 <Z8tS5t+warQdwFTs@dev-ushankar.dev.purestorage.com>
 <20250311111301.GL4159220@kernel.org>
 <20250312203716.110b6677@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312203716.110b6677@kernel.org>

On Wed, Mar 12, 2025 at 08:37:16PM +0100, Jakub Kicinski wrote:
> On Tue, 11 Mar 2025 12:13:01 +0100 Simon Horman wrote:
> > On Fri, Mar 07, 2025 at 01:11:18PM -0700, Uday Shankar wrote:
> > > On Tue, Feb 25, 2025 at 02:40:35PM +0000, Simon Horman wrote:  
> > > > Reviewed-by: Simon Horman <horms@kernel.org>  
> > > 
> > > Hey, since this has gotten quiet for a while, just wanted to confirm
> > > that there's no action needed from my end? Is this in the queue for
> > > net-next?  
> > 
> > It seems that this series has been marked as Changes Requested in
> > patchwork, which may explain the lack of progress. But that designation
> > doesn't seem correct to me. So let's see if this can move this series
> > back into the queue for the maintainers.
> 
> Unclear why the designation was chosen, indeed, but let's get this
> reposted per normal process. The posting is a month old.

Sounds good, I've posted a v6 which is listed at
https://patchwork.kernel.org/project/netdevbpf/list/?series=943246 as
"new" even though it has several reviews from maintainers. Anything else
for me to do?


