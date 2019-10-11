Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDBD377D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfJKCYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 22:24:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39000 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfJKCYV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 22:24:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id 72so5863419lfh.6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 19:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SjV9H9pvD4UfBezCzuurED84stJjiWTQaM9lntveN6U=;
        b=V6ox/LNAFOrwge/xclW0/5nANo7T6nEcuUMjdEM/Wgau0izWeJSEz/cbjVUyct1AqF
         m9yGbnSzbVeigxWS7Wqc+YbfVkvu7VDTqYdnfEsgvUN3PszcNp4basm8timUeftMeZrM
         nhchYgS3ekRXscC2Q3VJeUFXJIQgfsGsWJy2ow46sN7sHPnen44I5Zy6JReSTU/o3yw2
         /47Ij+shzt/H3NpmNXxYXQos/Cat7UcBvWyr3PtuTsgZhJxzlPjw1656FixZk89fR9GH
         Y7gKiTkmARsWZaCrGVIzD0Anlek2pZIrOf06UO5SsM6gs8J3zAMDB2q567Wnviy1K5sQ
         L6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SjV9H9pvD4UfBezCzuurED84stJjiWTQaM9lntveN6U=;
        b=enAPgR+/Ne7n0HWZcysWyYdOl2ns9hNs6GsSTOyZ7q6CAaa57pPUdFoXzC8AoA8ai0
         dCGs01J8EzoEEYxDVrPvPB4hx5CbegDIB+S5EbLulmc4kvsM3db2TeqOWgqJf2C4+yAw
         nTK84dHBblOz5HRrfL01FMiRbKpypjeHOODPip6bJgeuLaRAnfxuISb3+3jATr8hEUdL
         xQiTomda3mYfrOBmVCUltJwUVYIo3PdtpBKTkhy0H5z8PtPeQHsyO5utPNPoiIDtB2WL
         MEGkGL4TzcrWkPTgqEiQJUNqE5wY+mb8SudfQ8v24J4X8R6Pj4f93r3RfMQk9XSX3aRF
         +k1Q==
X-Gm-Message-State: APjAAAVGcN+JbXXClVIBQgvlFXDuch/uB+2H8BtJxHsn2VBKmk71ugY7
        aWZX0eO+EhyGCdmr8IEJEnpGxsvCqnUExrKjS+7DLg==
X-Google-Smtp-Source: APXvYqyF1c9G+UjSG+tfYXCeklU+q02bWAAhxHTvl4NcU9gFzaUgyRGvP8xq7x+9DITcQ+8s1L1Jq9IGvoMIxTOGGvw=
X-Received: by 2002:a19:7b08:: with SMTP id w8mr7371507lfc.95.1570760659240;
 Thu, 10 Oct 2019 19:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191010022502.141862-1-kyan@google.com> <20191010022502.141862-2-kyan@google.com>
 <a2cc0ebecfb055c8b667db57d0469fe69054a69c.camel@sipsolutions.net> <87ftk0jr70.fsf@toke.dk>
In-Reply-To: <87ftk0jr70.fsf@toke.dk>
From:   Kan Yan <kyan@google.com>
Date:   Thu, 10 Oct 2019 19:24:07 -0700
Message-ID: <CA+iem5u8p7pDZw-QvqU285p7F5AunN3Z4YyS=TjAd9xbKqegnQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > +/* The per TXQ firmware queue limit in airtime */
>
> I was pretty sure I mentioned it *somewhere*, but I think just calling
> this "device" or something would be more general. If you don't mind, I
> can edit that also (unless you have other reasons to resubmit?)

done. I will upload a new version to fix coding style issues according
to your comment. Please do help
revise comment as you see fit.

> > + * ieee80211_txq_aql_check - check if a txq can send frame to device
> I wonder if this really should even be have "aql" in the name? It's also
> going to return NULL if there's nothing on the TXQ, for example, right?

Renamed to  ieee80211_txq_airtime_check()
This function is not for finding next eligible txq, but return a
boolean to indicate if a given txq can send more packets to device. It
is also called from ath10k:
static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
                                   struct ieee80211_txq *txq)
{
       ...
        if (!ieee80211_txq_airtime_check(hw, txq))
                return false;

> if (WARN_ONCE(..., "...", ...))
> saves you the braces and the extra condition

done.

> But then again, we don't really care *that* much about overflow or
> underflow in this code path - it's not going to be security critical.
> But it seems that your code there actually can cause UB? That would be
> nice to avoid.
> Actually, that condition can never be true, right? Wait, ok, this one
> can because integer promotion?

 I don't think that condition could happen. The WARN_ONCE() was added
per your earlier comment. The older version don't have underflow check
and reset pending_airtime part and I didn't find any issues.

> Except aql_total_pending_airtime is still defined as s32 and that causes
> different behaviour?
> All this confuses me ... is it possible to write this more clearly?

I revised it to something similar to the original version, which
ieee80211_sta_update_pending_airtime() takes extra parameter to
indicate whether it is for a tx completion event.
void ieee80211_sta_update_pending_airtime(struct ieee80211_sta *pubsta, u8 =
tid,
                                          u32 tx_airtime, bool tx_completed=
)
This help get rid of the problem that airtime need be signed. Also
added the inline function of
ieee80211_sta_register/release_pending_airtime() as you suggested.


On Thu, Oct 10, 2019 at 1:12 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Johannes Berg <johannes@sipsolutions.net> writes:
>
> > Hi,
> >
> > A couple of points...
> >
> > First, I'd like Toke to review & ack this if possible :-)
>
> Sure, I'll look at it. I'm away the rest of this week, but should
> hopefully get some more time next week. It may be that it will take the
> form of another submission that integrates this with the previous patch
> I sent that put more of the calculation into mac80211 itself...
>
> -Toke
>
