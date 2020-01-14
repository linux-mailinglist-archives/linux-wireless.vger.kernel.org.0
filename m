Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95009139F9B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 03:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgANCwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 21:52:30 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:41777 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgANCwa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 21:52:30 -0500
Received: by mail-il1-f169.google.com with SMTP id f10so10099421ils.8
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2020 18:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ysc0kSQv0C2nCyyZOQORY8gg50c5kI1Ihctc9NkfI6w=;
        b=WbQB2AHtbo9KXBXmsEDNlx3KW5VSi5LDlBfXREPAI6JTml0jJwJ0kpOeCaGORjUqpN
         HXt21rADx7tv78BQI1aoP/zJaCAsaSVbKukmWFUZvXk6VzdraQcmRp82rrp0XYp1ovgp
         qHYyvNQ3I76ED0Xvs5vnJY2C+cm6mUvll4An0QJqq+dNj9CZW4jkZ0ntbFqNNjeNQ0Vr
         VSoLRLy31/yeT9nLz5sVYhAksSiguWykZX8bK1o5qaU5m4PeXQ6DCPMjgMhjlSXYafTp
         d9CO8e/Oc3qz8t3fQXEa5yXbsmEOeYSGgQffO6JVCL9zOxRuAnoSixrtpS0AzYCrJV4f
         xuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ysc0kSQv0C2nCyyZOQORY8gg50c5kI1Ihctc9NkfI6w=;
        b=TIHpKHelRowZTMiEtaW8kA5BPZu4xa+zkB6f+ajvNHI3yPgdC1y3SqcBjxNkW70mDQ
         83asFOQR6OzHksZJ5Ns7SqLgX39LLtJ6mzXSoan0YIz+gO2vSlXjQ8ylp2u+uQSzoTgG
         heFxMYGt3ij1Zzrifid+QOrJwEqFipkeRvCEK+n2xHOBwBMZOnxLLokU0HC2QvEQ1lHt
         aCYMyOEqvD4yc8c69G/tAlt+0kfFhr/rwmqcddlCScx/5ts643WdJrM3Zu7+0ZcENT71
         Voshfp9kV1s4KaC9RyGH9qPpakrp2BNSAEWqoRzs0Oy3Kj/rfhAoV7D8yVdE2Kp1inn+
         VKIQ==
X-Gm-Message-State: APjAAAXrVatOak9PBhRqwAvmT6f2SatNDX3ppdJTJv7y/VtyxKK3KaVr
        CGdvuJ87La0Vjer/eOx2MtGTm3TeBU8TACXc3bg=
X-Google-Smtp-Source: APXvYqwQTS5fYQm6k8DpbxL/Qj0Fs7t8AVXq7TjGcp+dFQP+DsyTFYnSYmODRPcAMvpiarE75QFJqdAmnFe4h3ztmI0=
X-Received: by 2002:a92:8f4b:: with SMTP id j72mr1588482ild.1.1578970349484;
 Mon, 13 Jan 2020 18:52:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:a0b:0:0:0:0:0 with HTTP; Mon, 13 Jan 2020 18:52:28 -0800 (PST)
In-Reply-To: <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
References: <20200110132142.7737-1-denis281089@gmail.com> <aab66c75-49ae-0955-03a8-f817685b0925@nbd.name>
 <CAKoLU8P3MyauCUevcRHtzMj8HSZQLD-hYyEaZyRH9OfLye6knQ@mail.gmail.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 14 Jan 2020 03:52:28 +0100
Message-ID: <CAKR_QVKb21WWbUup-O9nsDvfVO7-c_+Kpxx3n8=b1e4X5pkmkw@mail.gmail.com>
Subject: Re: [PATCH v3] ath9k: fix firmware bug in some Mikrotik R11e-2HPnD cards
To:     Denis Kalashnikov <denis281089@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13/01/2020, Denis Kalashnikov <denis281089@gmail.com> wrote:
> I read value from the SREV register of AR9582 -- got 0x001c04ff. I
> looked through the code of ath9k and found out that in this case the
> revision is 4. So, since AR_SREV_REVISION_9580_10 is defined as 4, I
> logically concluded that AR_SREV_9580_10 would do the job. But you
> suspicions turned to be right. I tested AR9580 now and it has the same
> value as AR9582 in the SREV register -- 0x001c04ff. PCI Subsystem ID
> is zero on those Mikrotik cards, so it is not useful. Felix, guys, may
> be somebody have any thoughts how we can distinguish AR9582? Or that a
> chip has only 2 chains? May be values from other registers?
>

read MAC OUI any apply only to mikrotik ones?
