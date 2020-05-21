Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A731DD082
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgEUOw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgEUOw5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 10:52:57 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE84C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 07:52:56 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id w65so4140994vsw.11
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RaeuoJY8rKJQZCpKfSeifeRXidvsPBfJGfbnhauOBT4=;
        b=j/cJiiIWCZF+CLCG557cgpB7S12zg5Y7Md3P8u29+6wkyFpmP4/x+70LqLWp8gk5iH
         WWPGApvZDrJtDmXux7vFzW+rBGvgKajnXhtP0GIsD4qgS49iY0s81aJrPoYP9sPLtHwo
         TLQiD178g4nt13KzUsGvUqGTAt25MVWQIiA9tRVXRl3KtBU5aZJjRQrMqfgFDBqdZX7G
         PHhX6wNWbvzVWe92fnzcMEcbG60/7bYH/PmAYm6LBzBnzPMkoKYoPfTi34Y2T8bp0BwB
         grdanHaTEWXt//KYzVKoj2EMrhqr1Hz1aorRsqhzN4mSav+qONMGQxgS4Pr/xxEgm6Z0
         NOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RaeuoJY8rKJQZCpKfSeifeRXidvsPBfJGfbnhauOBT4=;
        b=B8d7v7ScBmtTnJU0tuJqST5Wvq66eiesf93VXlrye1ex44qxetJaA8dFqDKLpJgG05
         dPx18cXAXcOPVSM3kL5OTwRWhD+5NffG5ENQOgn9L73lQp07GeBrJACcVNPnet9px0L/
         2vTHZRym1o7ObP1v6KKw9mIcmKyjXcwZEobPAY+xQPXO3LEslhzjXzvPRKx3drvliDNz
         2EEhs/IsODR9dxICmIyXgXEzWP470pnE9UBEl3OCw/b8wcY9CMM73G27NIxpazTIhez7
         VwWvoJWuG4CMN88GMUdzBdjGljO06iKrhwLbBjkzLKkxtxysElrKMBVS92YI6rMRj5sg
         wRqA==
X-Gm-Message-State: AOAM531om+aaOBYty5BPWDZAIc93Vcw8BYS15R+yo/eD/aijjmUm93/U
        49mRUy78TPEOmsvQ2+r/rB9sEPVDhscrqvnNOg==
X-Google-Smtp-Source: ABdhPJw8L6W6noPkSqdeXkoEln2rm5zlJ/HmGdSylKKuyuY4yn+6gCna5F8QaxEeia5/HnkA5KpPnIpl+A5PdXJg8tk=
X-Received: by 2002:a67:f313:: with SMTP id p19mr3805235vsf.63.1590072775920;
 Thu, 21 May 2020 07:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net> <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net> <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum>
In-Reply-To: <20200521134011.656381ad@wiggum>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 21 May 2020 15:52:44 +0100
Message-ID: <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 21 May 2020 at 12:40, Michael B=C3=BCsch <m@bues.ch> wrote:
>
> That's not exactly a modern CPU, but measurements would be useful
> anyway.

It's not exactly a modern Wi-Fi card either, and being 802.11g might
actually help limiting the CPU overhead.
