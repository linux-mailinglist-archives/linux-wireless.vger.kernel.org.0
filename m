Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1661E5196
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE0XGp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 19:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE0XGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 19:06:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC0C08C5C1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 16:06:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f21so9506663pgg.12
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=lH9UFEFyC9PbcpDDWxKIhHqdIg99lIYzqQzYTEi2KMQ=;
        b=iJCcjw9YupOhUq7tV/PK0fMzEnl+M3cAwjgMpO+od1KLlbXCGd112h5nFVzeMDkd9g
         9WFMbq6PFsJguVDZcQiFh0eOTUbLuh+Xii5KzFOkFBG0YzcjMIM/hoTw6n+zrfac17vr
         sCVIRhtKVPuyNDy0nf0w5MPOlJCGI2+TwUdeVxbpAenqOAMGez4P1utEbNVYfhpacThu
         M8miAmX5XEXRLqVxJLWDh3UpnTTRecbL5EtckC1UpU3oCpEWLqA+/PTTvoiaMpHuJkw1
         x8OjvIfC7XAHtRETwWkZLhPM1ADDNJg8cunTNLLbYStPLQwgW6Df1x7jXpOm9Sn9Bhhi
         NC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lH9UFEFyC9PbcpDDWxKIhHqdIg99lIYzqQzYTEi2KMQ=;
        b=LOT3lZSef/tDX9L73UOiCqayK03gmnqLPeuLKcPIgw4XGfmRlwZhS4h5aCF6hrBRWM
         DRbY2iJPxT6jQhjfOu/1v9oMhbM5h3uAHDXnOQDKaPbci4KwrlpxA5rUPMZpbNB1Flq/
         CI+777lPJ6DCmDkB0wU6fGRZosdNb1WdRqTS9qz380+bdbEShwx7j1dqfkg/rAojV3P+
         RwvOXeQvicuRvSGQO2Bqzqt66K1wNagTLg9VjABkWcK4x4Hp0qaWOqwpedADUahJHPPT
         YHOCiNYxleOKtu1w7rQVFOaOTxT7MaluPK9qEjjGUHmETaUHDgmcW6T++ov+qNf+hDE3
         YGpQ==
X-Gm-Message-State: AOAM533jR6PoaniH6AbjPS+7y9Rf7WOFSOoiYAAZS29BGI9xBTcioQk0
        32tcCGD5xln/CfAcDNfI9Gk=
X-Google-Smtp-Source: ABdhPJxhm6UWPhk4FHJjW4RezsTu1Qxnn1EZW3/znHrWFI1U7VodeteQ3LkdDG5/ehiqpzIaR6g/Rw==
X-Received: by 2002:a63:724a:: with SMTP id c10mr107625pgn.130.1590620804538;
        Wed, 27 May 2020 16:06:44 -0700 (PDT)
Received: from host-29.home (50-39-160-111.bvtn.or.frontiernet.net. [50.39.160.111])
        by smtp.gmail.com with ESMTPSA id j26sm2918932pfr.215.2020.05.27.16.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 16:06:43 -0700 (PDT)
Message-ID: <845ab63a2796fa0a4d7042f79268a2e10f87bd99.camel@gmail.com>
Subject: Re: Potential IBSS race
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Wed, 27 May 2020 16:06:43 -0700
In-Reply-To: <b3859a019b965a7a4053c1946a4cde441c0dbc75.camel@sipsolutions.net>
References: <CAPv5Ue5DY07E3=JDwjJkuad6Z3cuYtJg=dypUjy0KyBhn=JL9A@mail.gmail.com>
         (sfid-20200506_174456_293312_214B015A) <b3859a019b965a7a4053c1946a4cde441c0dbc75.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

> 
> Maybe that's a better approach - make the merge timer be randomized
> between 30 and 60 seconds or so, so that they can eventually merge.
> 

That sounds good, unfortunately it doesn't really help with our test
environment since we don't want to wait around for that long... But
yeah due to how long scanning takes, maybe thats just the way it is. In
a real world situation this is probably fine.

Thanks,
James

