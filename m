Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073CD34ED3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2019 19:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfFDRbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 13:31:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40008 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFDRbc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 13:31:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id a21so5292802ljh.7
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2019 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Bc8vPbFX2tliT9MrCWMKPuMK6hgmMamCpZ5rNAKRQw=;
        b=PpjWXm1jVPIsRz7rulWNvQn99keNFaa71SZ17GTZf1SYK/jEtb5wWtm5IBbo5AVEMi
         ByaWfyVjsM9XfsE9TmckhXdg1Riz8kFWR/ZvaYEZ8VKjx2JtGKOELtmijpjpjann4eLE
         fkmg3y+jJjn8JdWU1wYsVAGZOg/W4AVA1+ZrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Bc8vPbFX2tliT9MrCWMKPuMK6hgmMamCpZ5rNAKRQw=;
        b=avUZfT9YUInA59sE7Uy/vk84fr0l5eM6RZ99BLg6arP23E1/uMddXhshQYpQeJMC7Q
         or46gmSQjlOwzBc8iE4qDjo+FL0yE0VxMs7IhCy+EbYUSmal0SzxHRb9xgbgYHTCgnMo
         z3rK6UsOLvIPfAXaBesE35CAkYGUK/7o6fVu0Ke3HIlq/zdwHS0vBQTao4NtV3pMrOAu
         lqdwTKvzjPFurPAunB220AUGWDI2uvHR9rgKu30rGLTZ0bFVY+g8k0bPX7oD2nKthZA5
         XRstXPHD0y3DZITM+HY5w2RS12ZDu89KbypwUP5pTxMrQwaN2Q01pu7YjixGajSGdSzV
         KKVA==
X-Gm-Message-State: APjAAAWeA89a09dB5E6oD3bIvRnMttn+sCcEm/ECgTqzpGyUIi6GBh0P
        gNHdVO046/SuS4qEShbeP7WeengHkog=
X-Google-Smtp-Source: APXvYqwY8aO5N6OvkWLJywwTkJ/t1NQxjk1zV1gtwwuZ4vzVAT0XObOCBvNe895wS7842pDGLiP8wQ==
X-Received: by 2002:a2e:9c4a:: with SMTP id t10mr11784137ljj.197.1559669490492;
        Tue, 04 Jun 2019 10:31:30 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x27sm3933266ljm.52.2019.06.04.10.31.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:31:29 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id s21so9867423lji.8
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2019 10:31:29 -0700 (PDT)
X-Received: by 2002:a2e:9582:: with SMTP id w2mr2373368ljh.136.1559669489250;
 Tue, 04 Jun 2019 10:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190604172910.107199-1-briannorris@chromium.org>
In-Reply-To: <20190604172910.107199-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 4 Jun 2019 10:31:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOBhe81Z2V-s_-=briPhXGQys7YcRyWZ-j=F07b_X6zWA@mail.gmail.com>
Message-ID: <CA+ASDXOBhe81Z2V-s_-=briPhXGQys7YcRyWZ-j=F07b_X6zWA@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: drop 'set_consistent_dma_mask' log message
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 4, 2019 at 10:29 AM Brian Norris <briannorris@chromium.org> wrote:
>
> This message is pointless.
>
> While we're at it, include the error code in the error message, which is
> not pointless.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Oops, I sent this patch twice. Sorry!
