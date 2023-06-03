Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909EA720E09
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jun 2023 08:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjFCGHn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Jun 2023 02:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCGHl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Jun 2023 02:07:41 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C1E58
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 23:07:40 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6af896f0908so2044228a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jun 2023 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685772460; x=1688364460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0OiChVWQd79cihyrYsJS8Wpx3DInpcPihNV8fH8Ysg=;
        b=lmd7tJVvhk1eS2pbacK/xvdxd3viS18mRj0Z9d3/nV87mIXCYeD3qZF+Y2Wr/pWtBY
         /fFFkOZbxd3tnd++8kjTlogFvpp18sVVd/C1mqFxp6Z+A2NcNzF+xRyTFzQlXndlVzIP
         1g5DyDPt9MDAhaPGOg9OtT0bDVQWpx5Etg7W60RNrLLu4J4bYBu6UP5Y8gQDKrMsL036
         XPUxLTq+JfmM3mPvvIWxBVHXeiJB4JO43dmnGAoLVUnYIzcxtSdvoaMiFson01izIc8p
         mX+ICXIzqiwlcAVihJUiU2/yUwaVE2iFrr9CuvY22esE2vblVtG72Rimv22GmVuMCgyB
         HSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685772460; x=1688364460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0OiChVWQd79cihyrYsJS8Wpx3DInpcPihNV8fH8Ysg=;
        b=iGl0EZJUIPPrglVsHytdbtICXDn/igDCYNUQqUkFZj3oD9zwv466cobqQ9rnaqVrak
         YXPBl9lHYK7LlD3/rjiGYfYVPA+kczbb5k9gMxKeBMTxCDHSErmH87yarlu/uO8V9KYn
         WYULhkPOHyKpTc/p7Dp9Rd1NgBC5/hB5xe08SODHfzpysfDdfAg8pLzM6muEcxLQoJCD
         xg81DE12VfUyPlltVlNLrM/l1QlywmnU7t5aibRv7Q4rimi6Kl9mR3SkW9vZKc6OS8pF
         u1rnYKVSr1z0KumW92+595NrHpfPeeEKa6wdkRj/VUGbBFtV7lFh9IX9nJkLE7BCYDFI
         TEAQ==
X-Gm-Message-State: AC+VfDzRS6Vix2e2fwgCX2ivDHGZ5e8wMXHdwh954eBKO44bRIgBDe0/
        tNOOuhZcuBuuMxKMwqb+KMncd7EpMmO29YvVr4ilsEP+
X-Google-Smtp-Source: ACHHUZ7A9ujBPKz9XirdTnjA/1BOdVPSBlN/nY/bVCxFowTtr3Pp0J2zKOaDuvUhuBa2M2GJuNoq8LbV9O/36hmOqlY=
X-Received: by 2002:a9d:6a87:0:b0:6b1:5672:b290 with SMTP id
 l7-20020a9d6a87000000b006b15672b290mr51474otq.23.1685772459945; Fri, 02 Jun
 2023 23:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230601054034.43692-1-nealsid@gmail.com> <878rd2jup4.fsf@kernel.org>
In-Reply-To: <878rd2jup4.fsf@kernel.org>
From:   Neal Sidhwaney <nealsid@gmail.com>
Date:   Sat, 3 Jun 2023 02:07:03 -0400
Message-ID: <CAJ4cxaRAvaVqu6n2x-Oq2Y=QZ8ry1WMczikKhj+8D0mde9=3fg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: Detect corner error case earlier with log
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 2, 2023 at 1:32=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote:
> But the commit log should always answer to the question "why?". Is there
> a specific reason why you want to do it earlier?

Added context & motivation to the commit log.

>
> Indentation here does not look correct, did you run checkpatch?

Sorry, my mistake again.  I ran checkpatch for this version of the
patch, but missed it in the docs the first time because it's in the
"large patches" paragraph, which is very much not the case with this
patch ;)

Thank you,

Neal
