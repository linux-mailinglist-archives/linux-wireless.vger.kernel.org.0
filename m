Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5622E1F1CF1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgFHQIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbgFHQIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 12:08:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F095C08C5C4
        for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2020 09:08:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so19552858ljm.9
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2020 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClSQBWTNKy6QM/u0O+83mkKXa/fUb2mZhnsBDib3FXU=;
        b=Wj7uIHi3iVob7U2MnpWEYNidthbOPgWUvDSYkULGV6+X5T7T2QDw4sHvTkrkAIv0Ab
         6Fg0K6exQtytZPQKO34LagmdPRaq460ZHKWIsEukUVc/6/emrmYy/9IVYBXfE7+n142s
         THP8lUfiXgV4DF0FjAkuCp2x97R1OfEHEVP/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClSQBWTNKy6QM/u0O+83mkKXa/fUb2mZhnsBDib3FXU=;
        b=iRDbu6R5ClsrIc+UsIHl/ew/d7ys1X+emjnaP+f5xGWoobBk1KlIrnmV1eZ+vHqTVS
         SEWBA6dobKMJ/bhie5ZojnkxJVwXxLpTvChA0HkdruKo61MxTOxZ/yABWQvdrzvj+5f9
         KwM+jLA+L/TGvDiTO3P/lmB4b/yCE7LuSQIa2jkizHSCY8Pb2hABJIXxhJVVr472Qb73
         oATdQqUtObCfLEf2WMu9HPXY6eI1ALuKza17iq2GPMkNF23pJDxhpXelDLUrgAJf27+b
         wbulp4Mn/nyqPT53AooPbD0N9lBT1jweP/ySiZEQVi7hkqJLRS5caSke76oV0KwtT0J0
         sbwA==
X-Gm-Message-State: AOAM531icEw6XFIIRkeeDbvCBTaJM04mwKnyB5ifivL/GyWeUny1Fbz9
        V4b0AKyM1Vvm75UqpksD8cDJKLqFeCk=
X-Google-Smtp-Source: ABdhPJxtWGV7ScgJG/MxvxZK3TAZt30Vt4fUJ+ckTRlnaF2rDWYyMKmlOlOmesRA83W+cwcFPq9gSg==
X-Received: by 2002:a2e:1558:: with SMTP id 24mr1397608ljv.202.1591632483637;
        Mon, 08 Jun 2020 09:08:03 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a27sm1373357ljn.58.2020.06.08.09.08.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 09:08:02 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a25so21203088ljp.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2020 09:08:01 -0700 (PDT)
X-Received: by 2002:a2e:b4c1:: with SMTP id r1mr6601345ljm.370.1591632480876;
 Mon, 08 Jun 2020 09:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200604105901.1.I5b8b0c7ee0d3e51a73248975a9da61401b8f3900@changeid>
 <87v9k1iy7w.fsf@codeaurora.org>
In-Reply-To: <87v9k1iy7w.fsf@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 8 Jun 2020 09:07:24 -0700
X-Gmail-Original-Message-ID: <CAE=gft76Nqo93QvvXU9xU-6sY-Q88H4RezMx8G6MWSBE7vJDKA@mail.gmail.com>
Message-ID: <CAE=gft76Nqo93QvvXU9xU-6sY-Q88H4RezMx8G6MWSBE7vJDKA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Acquire tx_lock in tx error paths
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@qti.qualcomm.com>, sujitka@chromium.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org,
        Michal Kazior <michal.kazior@tieto.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 8, 2020 at 4:39 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Evan Green <evgreen@chromium.org> writes:
>
> > ath10k_htt_tx_free_msdu_id() has a lockdep assertion that htt->tx_lock
> > is held. Acquire the lock in a couple of error paths when calling that
> > function to ensure this condition is met.
> >
> > Fixes: 6421969f248fd ("ath10k: refactor tx pending management")
> > Fixes: e62ee5c381c59 ("ath10k: Add support for htt_data_tx_desc_64
> > descriptor")
>
> Fixes tag should be in one line, I fixed that in the pending branch.

Ah, got it. Thanks Kalle!
-Evan
