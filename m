Return-Path: <linux-wireless+bounces-4458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5668753FD
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 17:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6572528317D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FC1E49E;
	Thu,  7 Mar 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKwmC8hU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE31EEEA
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828091; cv=none; b=Kephe1swU3INN0DnKixig+9oUZa9xK7eDs765bi7eieXEjkHEEURCJwgwdQ+9Xhv8iZgyoEVkNZTlelC/rJR3y5d1WCFkAhH5tG3x2TFmCtrzgX+drT87CPCAg7hpaW0iDd3sPeCAMSO9AdrIcRxiEWYH3oqEtXZ+7y/TydIOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828091; c=relaxed/simple;
	bh=QLKHu4wr/Z8unpsuiPyLu0/96WcGSaB7uVKEveHcOY8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4RCWYzdDDV93aSBJ4QoEkqsS54XhuJBiDNj6hGstmkGv2pEP4azqtCHa/6FEsF4by9/xH4/pMwPEymyhVscrIsm9kYHzhIxw5b/CVzFm1NOQeFDzfrnzFGXm22OKXQfDA4beBeCZ8VdffNEBW/5niIOsdTIIENGHiNrAYmA1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKwmC8hU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51323dfce59so1019421e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Mar 2024 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709828088; x=1710432888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3pccFh9QeQc8osAVDN9SW+WA/jGQlV6jyKzeyjL3g4=;
        b=bKwmC8hUBFVT0E36JhWr8TAFXiEBTpGyx5vGImq9anD4FIlngZLh0h6vMLY5PMtaG5
         fw0pD4kDlw00Ed9UByv7RqLjzp2uObrL24XYmkVWQgdphtTXjrRAqWl+S/ZNKlCPmkt/
         W/974qPMwJiltgzKqiyLE0EIPaN9ybwbWZ8kU0BaEUfo9Rxl7uoM7WF4khtwH+d5DDwc
         WlJq6m4Xv6nKiFjNW7L7knNLB1+2JByQ6X8Xk2X+cs8nOy+V+y5/R6Z6Ei2TqpAYT5a3
         cUGXzpduRXhqUaE7yGppU2PyZfjgK0j1/5Xd5x8QXH9USf/ty7LAbfqA3gfBdqHw7mbJ
         NUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828088; x=1710432888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3pccFh9QeQc8osAVDN9SW+WA/jGQlV6jyKzeyjL3g4=;
        b=Y3O6WpQJKdvJnTiQYJ04HZY4Gp9Oa2DlS75FsuUEe3YUK76KwZR/c4YNriDgTXGjSy
         vUYC0R5itMZWSe3iBXHo8lv965R7rlBfSLC2T+sUOpYklLh4jSI7Coii5XECT2FEyZKB
         EpZJyDcNwYexsJz2CHSxkOPn0Vnrmpom3pWfK7BzhlHD3Gt2GdRQXPpd/rElIcSsZ8bD
         sUxnslR5kO2smaqYmQqUz6NIdYij9Vhe7mvj+etQZDKZJYeknv0VKusr3cbqVx5GKaZk
         e0fzVtnnWZ5UylCfM1UeETyzNytdpf5IzQulnLv8AcyDrMa+ZGOmpWrRQO0v7fLcoQTL
         kQrA==
X-Forwarded-Encrypted: i=1; AJvYcCVbC95fC0Bvo/EI1w7lI7r/lHufN2pY9h3BmUbwxxxPrAI8xSi6UiwqBu/B+45/Gh1rR/hydWynzTqJZToj8wLCA5v6l+xfeNyLDhwNBkg=
X-Gm-Message-State: AOJu0YxYyJeO1q7gfvQZlImjSEln4dELt01ADGn8/OzJTlIZOts5N+C+
	B9eyMxM3wbOzk+dCQCYcTNZbsdsUVzyjd4NNlXdZAuJulSN/6iZyyIYrJl/oDGpeOw==
X-Google-Smtp-Source: AGHT+IFtCU0PehP9TCdRvH72QeC5r8XVh/nI8gXn8Rviv91SWqPHmNFv7w460WIzjmGbJY+cj6+q9w==
X-Received: by 2002:a05:6512:329c:b0:512:bf99:7d80 with SMTP id p28-20020a056512329c00b00512bf997d80mr1826309lfe.1.1709828087596;
        Thu, 07 Mar 2024 08:14:47 -0800 (PST)
Received: from radar-prod1.wnam.ru (nat-inorg.chem.msu.ru. [93.180.12.29])
        by smtp.gmail.com with ESMTPSA id o15-20020ac24bcf000000b0051357109ae5sm1132030lfq.3.2024.03.07.08.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 08:14:46 -0800 (PST)
Date: Thu, 7 Mar 2024 19:14:41 +0300
From: Ruslan Isaev <legale.legale@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v7] Add JSON output options to 'iw' for scan results
Message-ID: <Zenn8QaDJ0kxon2w@radar-prod1.wnam.ru>
References: <d1988e179abb5911a8ddedfe95018bf4.legale.legale@gmail.com>
 <a1ac8dae34081e0ccde0fddf445f2ef13dbd06e5.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ac8dae34081e0ccde0fddf445f2ef13dbd06e5.camel@sipsolutions.net>

On Thu, Mar 07, 2024 at 04:23:47PM +0100, Johannes Berg wrote:
> On Mon, 2024-03-04 at 23:01 +0300, Isaev Ruslan wrote:
> > v7 changes:
> > - binaries json/a json/a.out removed
> > 
> > v6 changes:
> > - add iw_printf(const char *key, const char *fmt, ...)
> > - rewrite print_ssid_escaped() as a demo with new concept
> > 
> 
> I guess it'd kind of be useless to test that way, but it'd be nicer to
> review a patch that only has new concepts?
> 
> Maybe split it anyway - one patch to add all the external code, one to
> do the 'right' things and one with all the other stuff for testing?
> 
> johannes

Ok. I will replace all the prints with new concept prints with iw_printf().
I hope it will not be useless.


