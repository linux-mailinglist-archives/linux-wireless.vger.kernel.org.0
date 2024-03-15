Return-Path: <linux-wireless+bounces-4796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE287D77B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 00:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162111F227D4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 23:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6105B663;
	Fri, 15 Mar 2024 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HiqOOYLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116F5B662
	for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710547180; cv=none; b=p9wL9uwOr58Y8E4ywiWHJMeEBr9Nm1T4yEM+JuvYhK20SfXYhWY0r2o737MCwbndxlBe7Em5tCsfOuT+o5TqfJMrQU9eZy2FES6w+rHwFSe9u62IQl5g6KJ1rlvxL7EwcJZPufJkU+kHaOab/Hn0HCXorwJpsp6AQzW/nlQcluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710547180; c=relaxed/simple;
	bh=/qe2C6UzLO3RK7msEASzcX8M6B1BxDpAmXsdMnRe9Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1GuUNGTuPIiHMM5LBUrdf83P/8IucQEj5Haq8GtDivuSGZUvHw8fEU7Ty6qriLwfzVKqtU0f/Nfv0GP0l0FH2Y8byHsAFzPYbao8VD4Gsnw3QzD3sNJ2mToflyPWYvJZQ4aF0KydlSwAmJ7kaUdh4JSEg5dWN8eFKoO3ksdASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HiqOOYLD; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1816912a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710547177; x=1711151977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K09KhbcXS9T4hJ0XOrJctzifoDfc6dpMxdFzFIYAJOc=;
        b=HiqOOYLDTzJxom+iV/wo0AYsBa8Y1ahHe0uFaawuUKrWBERpH5hD+sVE/dt5L6Se25
         qCp7aQimkzzu+CGAhLWg9+B2yrmDsJfHAyEL/QxaqLoBESvGfyVfIOeSDBBNH5M2TpNt
         oQsXbPBER26/Q0b6eDc+EPdEZ2SJGcAh52OUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710547177; x=1711151977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K09KhbcXS9T4hJ0XOrJctzifoDfc6dpMxdFzFIYAJOc=;
        b=dSw1jZTpqGVplaqPLMGjlx2BM5ze3/E9hoLKZhF/6xr5HLGmwWUAuTKQvbnJjYsGki
         CrTa3Ny+B1hatCVULY3474UxNWELbSkgFuh/XFxprkreDnI6QRuAt3qKWpeV1KWcv+gn
         Wa4gabKxQ63411PG/BFMZrq5stsvyLxHQA2jJq7O/GHhZXgP5YOL1yG8F0rDfu1HBpfG
         zU9Vzhr1BntBL/L/A7wfmONwr7yMS2wxcwTLJS1gcwwjHcKwnhjpb/t8mMhjPcvsFSnX
         uUCTlKZv4jeYISDMZj9VMPxrIj2Z2aWx0+fiUGm5sBpy8b+DuMKyybZcHKA6WswQVqUZ
         LRrA==
X-Gm-Message-State: AOJu0YykWqYLw0larzrOATGZCPXXb79FGOAoSD5We3Kq/1vX9iYoXaHS
	xx3DBAQJelwx6+t3GFkA5W+jMTqrMk2skrwrWnsuzycYM1rAwUvAYn+B2SAOH0FVpvfMPdY50II
	T7w==
X-Google-Smtp-Source: AGHT+IETlKoG/gGZzsb4uyHeCExcjwo/I7r58Qp9AAiM1Eq28K/zYAZ62FFM4w+GI6Bw1rL9mk4BHg==
X-Received: by 2002:a05:6a20:d04e:b0:1a3:4a0f:b790 with SMTP id hv14-20020a056a20d04e00b001a34a0fb790mr5115521pzb.35.1710547177332;
        Fri, 15 Mar 2024 16:59:37 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id sz4-20020a17090b2d4400b0029bcf62e296sm3404920pjb.42.2024.03.15.16.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 16:59:36 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:59:36 -0700
From: Brian Norris <briannorris@chromium.org>
To: =?iso-8859-1?Q?V=EDctor?= Gonzalo <victor.gonzalo@anddroptable.net>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Add missing MODULE_FIRMWARE for SD8801
Message-ID: <ZfTg6H0Zrwrjbclq@google.com>
References: <20240313183156.2234301-1-victor.gonzalo@anddroptable.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313183156.2234301-1-victor.gonzalo@anddroptable.net>

On Wed, Mar 13, 2024 at 08:31:56PM +0200, Víctor Gonzalo wrote:
> The module metadata for the firmware file mrvl/sd8801_uapsta.bin
> is missing.
> 
> Signed-off-by: Víctor Gonzalo <victor.gonzalo@anddroptable.net>

Hehe, I guess you're finally following up on my request?

https://lore.kernel.org/all/ZQt7RS+FdOtkH0c6@google.com/

Anyway, thanks:

Acked-by: Brian Norris <briannorris@chromium.org>

