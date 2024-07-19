Return-Path: <linux-wireless+bounces-10402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BE937E3B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 01:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A551C20E9B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FAB14884D;
	Fri, 19 Jul 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jfn+cFRu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19B145A12
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433143; cv=none; b=E//Gy0yJLl5FguuIbrA0DBhORmNKosqLoFwazCP+XN6WMhD8cVTwkw+VCsog4AFsEdaF16gBZM4JmHAq2lkoB1eXud13JsLFt3lMMjKz8rlZJdxJ+VdZclhmwxK7o1uxspiFGAF0z6fEHiiUSRqkQ2/qfg9taTbjVyqjZ+8uCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433143; c=relaxed/simple;
	bh=kPugjwGLyb+5HXp/G5KGld7enSKQ0QH3/b5/l9Tv7VI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bcrODJPg/6LwzgYI8lTtZcRUkYmI8KsqCBLHNcLn4aLexU3+xGmFNkxWnKWeoF9jfx/2LNaC9nxA1s738GyfnRX5/trpIBHj894oNOmDglzmaAuyYcA79MuxHWM3Zk/5J/34GXhwOiRq9/CU45vrhYJ0j4ENuBaaY/+BAd0pac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jfn+cFRu; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9cc66c649so1324036b6e.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721433141; x=1722037941; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEnSOsVA0F46XmwXThGwLi5Aj74hNRj717pQmQdcib8=;
        b=Jfn+cFRuAwZGnc5xxx+5mv7NLBzbyd67g70AykQJEMxTEVdjucWZ4BgVg0Rm/PMIID
         x3xlmDQUhhbep1hvnyz5IE9Sg9iJV6bs72/iu3t1rXrp1rYez8Pi0bjVk5w4acZ2B3Br
         ZTAb8C54EqqR1X8dWIs0WOefCU2eQiD2HctofqpAjx7saO26KOS2XfEtBsRu5+6Lej1Q
         lFrQHymLz1ankFdAstw6WC+aD8jiEKFLXEgpeFFCdPGRWpEc5p/DBxLjog9WprYed8I0
         Gnyw3r6BwRlYe+gdEs34F6qELwEQYGDqahSJZQzmxMEqK7WMygG9gPNA2VYJ6OYDAzRM
         VgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433141; x=1722037941;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEnSOsVA0F46XmwXThGwLi5Aj74hNRj717pQmQdcib8=;
        b=Nw0/vyDBBbLRjuoC+XSxgssDuYWG1nRJePEMwuOw1yYkKvgnGZleMHzr5+3Dyi8f/Q
         eIeUkXy2SlwMxvKay3iR73VP5VHgiPtYfWSviNiQ8g3aEITzS2MMZNbJ3AmMX52WB9iH
         +0Ibq0hXD/KW5DWYXVp1ioqSxPNXJz0/CuMNdwtC3UrFiJANfXekw4L9d5PmSOs87tfu
         Y9BlA4hX6np2kMJewC/nN9dDIf0ZZVZzqTJiU2Xb/6MRZ/1aVX1i2RN/uDMhJgmOXN7H
         d3982aiLa2ikKzuUWuVxXJfYJUEHqEVrfuT7H9HDddrVpgYNgao0egB3t+h9u+30I0wG
         jaLA==
X-Gm-Message-State: AOJu0YxsGlwJr0c21OJ/tk1UoxmumvUbzhIHOoE050p79s64QBt5DCJo
	Ugl12Pp9hFAS6Pw2pN1NnO4wpHRWbki79JoPtkVV6xSrgnWmk8jWT/3/qqMkrnIezee0kpmcw9h
	l
X-Google-Smtp-Source: AGHT+IHO3l2gonceyWSIoN6u6zxLS595PjEdtfpSR0601uhUtrn+dqsTrzKJdMmbN1DzQ/JLdxJRzw==
X-Received: by 2002:a05:6808:150a:b0:3da:e007:9d7 with SMTP id 5614622812f47-3dae607ea8emr1457092b6e.38.1721433141167;
        Fri, 19 Jul 2024 16:52:21 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:739a:b665:7f57:d340])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae09d6089sm486404b6e.50.2024.07.19.16.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 16:52:20 -0700 (PDT)
Date: Fri, 19 Jul 2024 18:52:18 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: cw1200: Convert to GPIO descriptors
Message-ID: <45ee8b5f-bb11-48a5-bc68-392f4ee30cb3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus Walleij,

Commit 2719a9e7156c ("wifi: cw1200: Convert to GPIO descriptors")
from Jan 31, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/wireless/st/cw1200/cw1200_spi.c:446 cw1200_spi_disconnect()
	error: we previously assumed 'self' could be null (see line 439)

drivers/net/wireless/st/cw1200/cw1200_spi.c
    435 static void cw1200_spi_disconnect(struct spi_device *func)
    436 {
    437         struct hwbus_priv *self = spi_get_drvdata(func);
    438 
    439         if (self) {
                    ^^^^
This check can hopefully be removed?

    440                 cw1200_spi_irq_unsubscribe(self);
    441                 if (self->core) {
    442                         cw1200_core_release(self->core);
    443                         self->core = NULL;
    444                 }
    445         }
--> 446         cw1200_spi_off(self, dev_get_platdata(&func->dev));
                               ^^^^
Otherwise we are in trouble.  Unchecked dereference inside the function.

    447 }

regards,
dan carpenter

