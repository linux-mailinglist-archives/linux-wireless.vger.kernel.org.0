Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56368662997
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 16:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjAIPOb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 10:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbjAIPNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 10:13:47 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F46B321BF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 07:12:43 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 3so4602723iou.12
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jan 2023 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SAHK9jtNLRrQUyZb6MXhljSvLL5U9vlRZ5bhktjJ8s=;
        b=fBZNxAxLCYPm2S2JJ4KIW8Fnrhuk5DBSbl68ip2qtcOdOCX5T3CSyAGEkMh49cDRIF
         8bafwtqfl/EDlUVbs1C8ntaUE+xWF3z8eQTRCcIomJCsyUEiStZwEm9wsPhSUvoz+O5h
         vM5rm1AIhpf54Ow7c/PCMuays4r01kIwaFgzMwwh52871p6dRMGRETzHY500gu5kpH4+
         kUUwwxlyUPLrbcQ31MoOprYW00ch3Dw/YBI41v3I9ZK80eX0P03Qq43J2vUU1eRun5uF
         qbUPWamwNUFTiV2P8Is54gEyktohD197jjOpb9t3TYQxbpaiX/2al/2UIBf1d6BYikqG
         O4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SAHK9jtNLRrQUyZb6MXhljSvLL5U9vlRZ5bhktjJ8s=;
        b=wNSrSIrRXmCU7cJc6p5yw5QipZpe3Ir/8zlak815Kz519dtbIBLiPPaAJzPnd6NvWT
         PbIXEiBP5odaarJ7PqSCLdgfMqhDUEdNGNjOEvVkx28/iXQeVDNGpsulkXwyVpy6HJRU
         2FNbYFFirDUB0otdHN3Ivl4EbmlQX2ZxSwDy8k5SPTIyFaWU8D0xTpL1tzgH9J2NaZ4n
         bYm7uMFKPdhzEBDrm+OeURNBeCvSj66FophQ9hx/IveEBazNhWFVPIGSXaOGVAXNHO1G
         3UrFaxSaCDxVpQZZ79Ej7alSjZDsDxcuARELZ86ROeZcBGgOcl9uK53l5ahJTCPZCSAo
         g6yQ==
X-Gm-Message-State: AFqh2kqL2NYf9uEaQd1k4u5lR0C7ETFT/OZkAhAILtq0bz1yUqYyaALN
        lFpxPmU7vu8Ajl5yFFuC1JzNcdGw12JP0xgOPub23g==
X-Google-Smtp-Source: AMrXdXsxdRDxjw0TiMdL8EiBHMqPR+dB4WMFtcYECvoSLQtaGEiblYuPAfmzF4NBGyyPS3EPrMzCuC+Gb/4LjHgYARU=
X-Received: by 2002:a05:6602:18a:b0:6ed:13b9:2e1e with SMTP id
 m10-20020a056602018a00b006ed13b92e1emr6060364ioo.172.1673277162206; Mon, 09
 Jan 2023 07:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20221220134733.2309329-1-jaewan@google.com> <20221227010034.1399587-1-jaewan@google.com>
 <87tu0zhi57.fsf@kernel.org>
In-Reply-To: <87tu0zhi57.fsf@kernel.org>
From:   Jaewan Kim <jaewan@google.com>
Date:   Tue, 10 Jan 2023 00:12:30 +0900
Message-ID: <CABZjns4EXD=nThk6i7iyj17=Jq=cOx62Gym2BGaaPgrU6Qo=9A@mail.gmail.com>
Subject: Re: [PATCH v3] iw: info: fix bug reading preambles and bandwidths
To:     Kalle Valo <kvalo@kernel.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 9, 2023 at 11:55 PM Kalle Valo <kvalo@kernel.org> wrote:
>
> Jaewan Kim <jaewan@google.com> writes:
>
> > Preambles and bandwidths values are considered as bit shifts
> > when they're are used for capabilities.
> >
> > Signed-off-by: Jaewan Kim <jaewan@google.com>
> > Reviewed-by: Kalle Valo <kvalo@kernel.org>
>
> I didn't provide you a Reviewed-by tag[1] during my review, please don't
> create such tags yourself. For example, in this case I didn't review the
> patch in detail so I'm not comfortable giving you my Reviewed-by tag.
>
> The general idea is that you only copy paste the tag when someone gives
> you one, you don't create them on your own. I think Reported-by is only
> exception but there might be others.
>
> [1] https://lore.kernel.org/linux-wireless/87ili3kfdr.fsf@kernel.org/
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

Sorry about the newbie mistake. Let me remove the line as you advised.

--=20
Jaewan Kim (=EA=B9=80=EC=9E=AC=EC=99=84) | Software Engineer in Google Kore=
a |
jaewan@google.com | +82-10-2781-5078
