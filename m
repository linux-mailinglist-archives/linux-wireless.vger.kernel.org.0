Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C5112A87F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2019 17:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLYQTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Dec 2019 11:19:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37281 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYQTG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Dec 2019 11:19:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so9379141wru.4
        for <linux-wireless@vger.kernel.org>; Wed, 25 Dec 2019 08:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=i2yMdmxjGb4rDaw+dBL/0nptlZbgGHghIdN7JfaSM6o=;
        b=QiGsp6cxGyNxvLLvobXb7h+Gr5hs3JN9ST893NLQP9HkMue7vnCBi91Bmcp8xNyGFV
         5rXu3e9nXziXOJyu/18MHMNVQPGGZytjZXj/b0mH3f9yc+YgNng0D7lCsd11DurhyGAT
         bKix0eSYIg4POlt7agBjAn4Q/i7lQRArBG+BTlMnC1BwqKV+7wt1w9ud9j8smM/lV3Fh
         MIbD6k79EPy0ngJ/6de20D3SIWMECJtvniSZyyRBuCiYqDQoflbSSYncvm2TSTvw39GP
         MaThfU+mu1XVbfMCtRzh4Z7AGAJXXJQel9PxGTcl+1ayKRB3K/2M2CmGpFqIJ2SOh2G1
         OsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=i2yMdmxjGb4rDaw+dBL/0nptlZbgGHghIdN7JfaSM6o=;
        b=H+kyi3YlQFnlpyEtcKOpzx4vvCNAM4/3yqCX1aH1AKZkmWXtwLdT1MYBuMb+eymR3o
         qphr019SAWtSQ7tcO6DobOd7kNe52rEDFI1YOiC/grM2vF5wHjTG+KCilQtHvTVWS9RC
         TFwYHMlQRBi+CJ1gIGdLpoyxHDUvxJgetStyJDc2daZEaIpucLWSJSjnlhUT5/VRoROx
         rrvKVitGAXc4HBxBtaPX/jiFAL5EBlXkP4neukel8qFxGhDepVAYRVrlideD4WYADECM
         LroFTHMJWgWiLlhzO8KbDHs16liP/IR84N3Gk7Pu99Yv0AEOtrWTdC1C8NM3BQdeSa9f
         jdjg==
X-Gm-Message-State: APjAAAX5BEiHSHJ9ccArSEWzWEBZGi4jdeMFs+7mmxp+aan2rW7dS+dW
        EcAMFZ445b8YrOGnSyKtRZY=
X-Google-Smtp-Source: APXvYqzUDv09s+UkniSvRxOsdfCpF/xhS1irr8FwzeBER2cQaL9e2e3XslBaoC5PzL2ruhNJ4Ubtmg==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr42888625wrn.274.1577290744219;
        Wed, 25 Dec 2019 08:19:04 -0800 (PST)
Received: from kaiser (ip-89-177-205-133.net.upcbroadband.cz. [89.177.205.133])
        by smtp.gmail.com with ESMTPSA id a5sm5975037wmb.37.2019.12.25.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 08:19:03 -0800 (PST)
Message-ID: <24df021f5e30c51e2d9fff8533ff5591d37d2d2d.camel@gmail.com>
Subject: Re: [PATCH 1/2] Support python 3 in utils/key2pub.py.
From:   jtojnar@gmail.com
To:     ahmed.taahir@gmail.com, linux-wireless@vger.kernel.org
Date:   Wed, 25 Dec 2019 17:19:01 +0100
In-Reply-To: <1437542484-23409-2-git-send-email-ahmed.taahir@gmail.com> (sfid-20150722_072142_438085_5E3B829E)
References: <1437542484-23409-1-git-send-email-ahmed.taahir@gmail.com>
         <1437542484-23409-2-git-send-email-ahmed.taahir@gmail.com>
         (sfid-20150722_072142_438085_5E3B829E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2015-07-22 at 00:21 -0500, ahmed.taahir@gmail.com wrote:
> From: Taahir Ahmed <ahmed.taahir@gmail.com>
> 
> utils/key2pub.py can now be run under either python 2.7 or python
> 3.x.
> This required some minor syntactical changes as well as switching
> from
> M2Crypto to pycrypto, since M2Crypto doesn't support python 3.x.
[...]
>  CFLAGS += -O2 -fpic
>  CFLAGS += -std=gnu99 -Wall -Werror -pedantic
>  CFLAGS += -Wall -g
> @@ -42,13 +46,13 @@ ifeq ($(USE_OPENSSL),1)
>  CFLAGS += -DUSE_OPENSSL -DPUBKEY_DIR=\"$(RUNTIME_PUBKEY_DIR)\" `pkg-
> config --cflags openssl`
>  LDLIBS += `pkg-config --libs openssl`
>  
> -$(LIBREG): keys-ssl.c
> +$(LIBREG): keys-ssl.h
>  
>  else
>  CFLAGS += -DUSE_GCRYPT
>  LDLIBS += -lgcrypt
>  
> -$(LIBREG): keys-gcrypt.c
> +$(LIBREG): keys-gcrypt.h

Changing the file names to headers appears to install them. We probably
do not want to do that either.

[...]
> -    modes[mode][0](output, 'e_%d' % idx, key.e[4:])
> -    modes[mode][0](output, 'n_%d' % idx, key.n[4:])
> +    key_contents = io.open(f, 'rb').read()
> +    key = RSA.importKey(key_contents)

It is a good practice to close opened files. It would be even better to
use context manager (i.e. `with io.open(f, 'rb') as key_file:`) since
it will close the file automatically.

Other than this the patches look good, crda builds with both Python 2
and Python 3 with the patch and produce the same keys-gcrypt.h files.
Comparing to the keys-gcrypt.c, apart from the trivial formatting
changes, the ul suffixes for numbers are the only difference.

I was not able to build crda with USE_OPENSSL=1 with or without this
patch due to a large number of compilation errors. However, the
differences between keys-ssl.c and keys-ssl.h are equivalent to the
grypt ones. Also the addition of ul suffixes fixed the overflow errors, so definitely an improvement in this case as well.

