Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834D411E021
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfLMJDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:03:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32986 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLMJDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:03:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id d17so5614395otc.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2019 01:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ka38vJIL+Q5x82lOwfqXtKAirFyyCs3SbFGLKj42N0A=;
        b=mY7WoL4IPn5T4tOU3CrFn4PCXyZ0shLmFr+ocJtY9JHDAZvVo1apCd1xuH/ZoFvsjA
         tl54dn3A5w368QAr/KcUs7xAILtR5xuQaOwjmvoh6gbG1bIt0uhvlKhYO7CQbp/fP4Kc
         8Oed+P4iT5g2JZvkaptIR6Y8kbWqcGqmrtQ5zI0Fu0C2FypDwHJv0l+HlIm9/Q0t2Zwy
         +hSXoejWdiEYndhknuQ0vtgfO6ytxMeZrBFeVSUkSxxabLvEmmAFebVws+iow5TzVVcr
         DxXhDtiz5JZJUOFXcS+T/dnK1Lsrtf3Lu89BpPYGY/KAZPQauWJ9IN934srqvVhyX33H
         8niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ka38vJIL+Q5x82lOwfqXtKAirFyyCs3SbFGLKj42N0A=;
        b=T2AI+1nmhVfE/vYqKxJmqyrLYTdunWvPeYuQTCaevbKlGRfbRPTELSP0Qdu14Me3IX
         eKx0L91Lolyevol6EW3yI64Za1kt74F0ZPWY+oWV+PzkzpP0ssqE1/C2DDZTotReizdL
         zh8l51CE+AJZGfsbs5YtmdJBUZW3kiMlrvPVSzgXVs+CYVQW5fgB4Nw2a91BBj00zWcD
         DpXZyr7Rtvpo1P1oCuzcHhlFh64WzzkdPPLrfGM+ZEurINO8356H7xgF5Ggqo+7BfzvX
         Jlk4yJY/zw4502Zdvbi4p/jbTNBTn6NRaEClqnkrKi/FB2VNUM8ppqodsMsmAm4OIrUJ
         72yg==
X-Gm-Message-State: APjAAAUJIqyJlWz/bBvjPix23HeBh86h6crw0TQAgCu3NWM54KcZtyjU
        xiKPGlA3XUjCJfhXFoLP+PnttIYo+QYbK1DASWk=
X-Google-Smtp-Source: APXvYqzsrWgrHR4MSN/u2QtdXko80fEsIRTnpa3ApeVVUUCzzCrxs3uPT276sQdMiDNdLxSjzO7sGYV+5ZZouB1eaqQ=
X-Received: by 2002:a05:6830:10c9:: with SMTP id z9mr13440223oto.200.1576227832064;
 Fri, 13 Dec 2019 01:03:52 -0800 (PST)
MIME-Version: 1.0
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
In-Reply-To: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Fri, 13 Dec 2019 01:03:41 -0800
Message-ID: <CAMrEMU_w7dj5RVNmkVoCjU1o_FEEXn9oA7XCBwFQ+j2EQkck4Q@mail.gmail.com>
Subject: Re: [PATCH V4 0/4] Enable virtual time-based airtime scheduler
 support on ath10k
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Would it make sense to consider skb->priority / QoS in the Access
Classifier selection?

On Thu, Dec 12, 2019 at 11:26 PM Yibo Zhao <yiboz@codeaurora.org> wrote:
>
> This series fix some issues when enabling virtual time-based airtime sche=
duler on ath10k.
>
> Changes since v3:
>   Change schedule_pos to previous node once it has chance to be moved/rem=
oved
>   from current position in the tree in loop scenario and bring back sched=
ule_round
>   in case that same node is to be scheduled again in the mean time.
>
>   Increase airtime grace period to 2000 us in the first patch.
>
>   Put per-AC station weight checking in its lock during configuration fro=
m application.
>
> Changes since v2:
>   Changes station airtime weight to be per-AC based to avoid sync issue
>   Remove Co-developed-by and Toke's sign-off as Toke suggested
>
> Changes since v1:
>   Modify the author of Co-developed-by as Johannes suggested
>
> Toke H=C3=B8iland-J=C3=B8rgensen (1):
>   mac80211: Switch to a virtual time-based airtime scheduler
>
> Yibo Zhao (3):
>   mac80211: fix issue in loop scenario
>   mac80211: fix low throughput in multi-clients situation
>   mac80211: Sync airtime weight sum with per AC synced sta airtime
>     weight together
>
>  net/mac80211/cfg.c         |  29 +++++-
>  net/mac80211/debugfs.c     |  48 +++++++++-
>  net/mac80211/debugfs_sta.c |  18 ++--
>  net/mac80211/ieee80211_i.h |  12 ++-
>  net/mac80211/main.c        |   2 +-
>  net/mac80211/sta_info.c    |  25 +++--
>  net/mac80211/sta_info.h    |   8 +-
>  net/mac80211/tx.c          | 234 +++++++++++++++++++++++++++++++--------=
------
>  8 files changed, 278 insertions(+), 98 deletions(-)
>
> --
> 1.9.1
