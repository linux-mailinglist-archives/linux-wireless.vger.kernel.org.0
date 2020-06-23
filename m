Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD580204B72
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbgFWHnH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgFWHnG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 03:43:06 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67892C061573
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2020 00:43:06 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z2so18390621ilq.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2020 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=i2cat.net; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=m7LP9srDo9fVktQteVw+1bM33L1FfjrJRx75sppYlvY=;
        b=MowEVtjox791c02slT7M+ERj3orGgesyIH2aY1oddAMkjrWO4w6ZBS1cbLy/28pboF
         fEbBH9CWWy4lrzUBMQ9/sAv7KvyEwxdmVIE+yS1ZvIREywJ9+j+rltQiqZqWg+4mpMhs
         NaLRI5wcXVHGnSZSwNuSxco5DQtiPG+DHsxEAz3duqKf7EaV6XKnldJrKT6UOkyBoZAf
         sUmp4NJKtFvjBFx9a6uYDoDvQt9nwcUN3KCZs+uKqnIbN0o5YMU796zKwgHuRQjEdSAC
         C0pTmK940dCqYcalmxxomztnsnRA9cbRvDG0MSBvhiiZzzBqYem1PcLHHm+3T3g1g0wc
         z8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=m7LP9srDo9fVktQteVw+1bM33L1FfjrJRx75sppYlvY=;
        b=E1HALb0v2LLVOArX2Jf31w5P/CUL5YuMyEd/2P0vwUkK3RUHyRoRRxMOIgOw015FNd
         NDY2kwfaGsQ396CdFf6tN+lFJG8wgBr7kspAso8NKsVog0GlISeyDw78UVUMPNciTQeI
         q4mh8OaTmeXU1prXZNXKEYIQ2QOKdtMBG6BsT8UrFs4V+IrGl0EWAeqMcU4QYyEcbxnU
         ptWqaeUxxUVv09u/4ktvq1hkEnSgIKyEQZSgckOZIYXHFrUoF19SPkuhI2T5A1YNinPu
         zxLgsoWA8DSai3Mv2prh9PzLAHmME3YhV9xbbm5OemCC4mDVUXjiU4m2mtSo1L4asaNW
         Z/Kg==
X-Gm-Message-State: AOAM5324LBGknO+01zbeJdplUMMW0K/mn7Qfu5/H49LV5eb3c8w2amDm
        UZT20aePFHhbaA3NeenXIqyLXg62EIato74cqivFfahWl0xqaQ==
X-Google-Smtp-Source: ABdhPJx3J/Ux0sVUl5aSrvuyq3QyHYrNys5HQg1cfiDdNXmtjmD1SEleapN71SF5EIuTmTwIdfp3Xmd1bkgkiOra7mg=
X-Received: by 2002:a92:ce11:: with SMTP id b17mr20665914ilo.89.1592898185089;
 Tue, 23 Jun 2020 00:43:05 -0700 (PDT)
MIME-Version: 1.0
From:   Miguel Catalan Cid <miguel.catalan@i2cat.net>
Date:   Tue, 23 Jun 2020 09:42:54 +0200
Message-ID: <CAMHmoosdiQQ5qS_wP3=kcwf+DkXi4Z1h+osLWNyPq5__ey71bg@mail.gmail.com>
Subject: Support for airtime scheduling using ath10k
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

we are trying to apply different airtime weights to different stations
in order to have some prioritization among connected stations. While
this is working pretty well with ath9k, with ath10k we always obtain a
fair distribution of the airtime (i.e. 50%-50% in the case of two
stations), regardless of the airtime weight specified.

E.g. STA1:
RX: 0 us
TX: 2295610622 us
Weight: 200
Deficit: VO: 256 us VI: 256 us BE: 34 us BK: 256 us

E.g. STA2:
RX: 0 us
TX: 162597077 us
Weight: 10
Deficit: VO: 256 us VI: 256 us BE: 9 us BK: 256 us

We are using Compex WLE650V5-18A cards.

So, does ath10k support airtime scheduling? In such a case, do we need
specific Wi-Fi cards?

Thanks a lot!

Regards,
Miguel.

--=20
Miguel Catal=C3=A1n Cid, PhD

Mobile Wireless Internet Group (MWI)
i2CAT Foundation, Barcelona, Spain
http://www.i2cat.net/
