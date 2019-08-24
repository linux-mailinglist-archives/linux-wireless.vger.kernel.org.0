Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1753C9BBF2
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2019 07:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfHXFTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Aug 2019 01:19:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38508 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXFTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Aug 2019 01:19:36 -0400
Received: by mail-io1-f65.google.com with SMTP id p12so25077762iog.5
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2019 22:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xffSZoeEsT6W79B2O8n1Y95CCP4jcyur3pRaEjhRstw=;
        b=FmyyS4t1+TBtnyNxSyf3IhP4NRofT7zUH9V0e5KiE/GyUEWSF0lO+HShE3XUZOkhL9
         +JVbZDZGVL+7KxN4sTPr9oimhlY2Rzf9QcTRSePIpr2V30J+g3hf+r2z0AxDOCtNfAQc
         VAjPGujNDJNCwqc27aGvVViExcfAvc4atTecphTq8stNFj0C/KgwVZECAYypJePNwF5O
         0BtqOrW2VcgAtdWOGENzcBD+fEKlbKf3PBcvvwf2zr33ktzakgWNf5S0jZ2s/5P0ZSde
         8gljCQcWtUVDCbgeACvlFIJnnmZVG7GrUXwV2WyGUgnB8ztmkn66ijm3FT6TAZKZVBlz
         BnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xffSZoeEsT6W79B2O8n1Y95CCP4jcyur3pRaEjhRstw=;
        b=X95GaXCQkqGuVwhwyPNDcn/PXmxKI3aRGnhdm1/Ap68z+PnJ72pjKkx8XdoAy5Q0xw
         agzEgYRLLMbliFRTYDDhStcKYmERZYrkuzNcNSJWQlFnDr7FppknhRZvYrR+yo/5VWgA
         dGVfPgFpGPDY04b1NrhrrmmmnWGYdCcbjc5Le78xeAfeVlkjNsrYOqSlssky18gFwgJ2
         NnLGqJrIzJquW0ldGREe3uYT5RrUhPKwG6P5DKTo6HgSM28YhyiFpxNEJyVhp4T3USu7
         lqkHI9WcSxKg1Cs1tqkDQSeTXkWp5iVMfJ3lpNnCE8qalcrzHKxfdokJSMgN0uX3IaTa
         z6uA==
X-Gm-Message-State: APjAAAXCSc+Cfd1/fJwI5zijZns6n1EV+bAZDCosmnXwRSzik9FjyxDD
        kZkhEZfuwLfRBpQMIeXHYM63wvef2z72AKqMVXE=
X-Google-Smtp-Source: APXvYqzWFLEekiYZOsAXOjFpiRaH/XQlvDWChazqi/lRkbjriIsCezitlafsP+yWpktb6lGaQlvTp+KYVPme3tueWMA=
X-Received: by 2002:a02:a492:: with SMTP id d18mr8757481jam.27.1566623975283;
 Fri, 23 Aug 2019 22:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <1564427246-25592-1-git-send-email-hanipouspilot@gmail.com>
 <20190823190019.GZ3071@ubuntu-xps13> <CANoib0F5U7suFoHdKYuqQvjB+XN5bkqzNtBd6RkUi_Rnt7_OrA@mail.gmail.com>
 <20190823192143.GA3071@ubuntu-xps13>
In-Reply-To: <20190823192143.GA3071@ubuntu-xps13>
From:   Dmitry Tunin <hanipouspilot@gmail.com>
Date:   Sat, 24 Aug 2019 08:19:25 +0300
Message-ID: <CANoib0H_NdF7oJv6rno4xVNx9xRcykvh6DrEWo6K45m8NMuDaA@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: update regulatory rules for Russia
 (RU) on 5GHz
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> It's not specifically 20 dBm, it's halving the power limit (i.e.
> reducing it by 3 dBm).

I suggest to leave it on 23dBm. It is low enough especially for 5650 - 5850.
I am sure that a lot of Linux devices are certified that have this limit.

The TPC mentioned in the reg doc doesn't explain what it means.
