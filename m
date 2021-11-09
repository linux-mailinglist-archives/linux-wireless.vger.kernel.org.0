Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F143044B26D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 19:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbhKISJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 13:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241777AbhKISJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 13:09:21 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E8C0613F5
        for <linux-wireless@vger.kernel.org>; Tue,  9 Nov 2021 10:06:35 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s139so96030oie.13
        for <linux-wireless@vger.kernel.org>; Tue, 09 Nov 2021 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O+fhYkcqhMQ8k14bNZcPRV6UkOwVHbARh5DBR4w4Kpg=;
        b=CPnbviPehHndJcufAKnxvmQCz4mp4bEQpdeHccnDuhigP6kyJib/gphfqJKMBD9sYN
         oez1oJmgZmzZ9XoEAsKiegEc6B939nNhVcBQpeUfDIlRCKzPMyNeltxhWg23GOET6xug
         ceiQT9g16XrsJlHxHY1H3O2rBE2zM0ITmzCjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O+fhYkcqhMQ8k14bNZcPRV6UkOwVHbARh5DBR4w4Kpg=;
        b=HIIrRfUKkOesSMkMkdFlN5ufFxF6DPoq5tiZNiguxkV+fY0IYsFKe9S9RJoTCbAjyz
         VqZpS3p6bQe/6r1pkZGPLBa4WLqSs7cgH9nkDPVBZ9B3dxXTt68xsisuJUs8ATSO+6xt
         tQZbToiI79fHGzakxKETT467bXxO9xCA0dZK+PGxkW7d3G0C+fHwyK8fTxEAVAokOvHf
         uV2pR9yh0liG47qVEc7jDexWnK4ZVDxVGD32cKvLusta2YiEs0vCxqKDO44mQOtTaTK+
         mHx6rKG0IH7bJvDRcnA1hzaSNOjY/DOJiWkrZTlQMXWIX7aYDxHr+2Ts/fTl3l7s+EE8
         NLqg==
X-Gm-Message-State: AOAM533Fsnn5kguc9HCRu/FwW7YdLlrE15Q5yWblo42beEHqUMj4CXIe
        vJpRv4Ey6IYFmfceMK73hlDolIHr7FksLA==
X-Google-Smtp-Source: ABdhPJzK/Eb3wWlYsRQjKfvb0BxleBM+HXjoFHCETxbQF4JRTByGodESXxb2ddQkVO3HpjNEknte1g==
X-Received: by 2002:a05:6808:d1:: with SMTP id t17mr7250618oic.161.1636481193943;
        Tue, 09 Nov 2021 10:06:33 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id e28sm7766162oiy.10.2021.11.09.10.06.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 10:06:32 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso32104459otv.7
        for <linux-wireless@vger.kernel.org>; Tue, 09 Nov 2021 10:06:32 -0800 (PST)
X-Received: by 2002:a9d:734a:: with SMTP id l10mr7706868otk.3.1636481191553;
 Tue, 09 Nov 2021 10:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20211109010649.1191041-1-sashal@kernel.org> <20211109010649.1191041-10-sashal@kernel.org>
In-Reply-To: <20211109010649.1191041-10-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 9 Nov 2021 10:06:19 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPwH9esHZFVy4bD+D+NtfvU6qJ_sJH+JxMmj3APkdCWiw@mail.gmail.com>
Message-ID: <CA+ASDXPwH9esHZFVy4bD+D+NtfvU6qJ_sJH+JxMmj3APkdCWiw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 10/39] mwifiex: Run SET_BSS_MODE when
 changing from P2P to STATION vif-type
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Kalle Valo <kvalo@codeaurora.org>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 8, 2021 at 5:18 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
>
> [ Upstream commit c2e9666cdffd347460a2b17988db4cfaf2a68fb9 ]
...
> This does not fix any particular bug and just "looked right", so there's
> a small chance it might be a regression.

I won't insist on rejecting this one, but especially given this
sentence, this doesn't really pass the smell test for -stable
candidates. It's stuff like this that pushes me a bit toward the camp
of those who despise the ML-based selection methods here, even though
it occasionally (or even often) may produce some good.

Brian
