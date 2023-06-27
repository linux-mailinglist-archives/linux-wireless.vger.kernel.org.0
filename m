Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF76740090
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjF0QNi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 12:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjF0QNe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 12:13:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B35359A
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 09:13:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so572158866b.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687882403; x=1690474403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38IFDIc50A0wOd5ucWLRdj34aoYIh2uUJmN13AkN1yw=;
        b=YAgGNR2N1C05Q3NtdRcMx/oorMCVCLdWODRbJs68ry8j77ZAOLaHH630JN634mq1tT
         DkzY5+mWsIXRz7G7O4Z/WZ0EAaVx4PTUImAXOZcsa62SatNsQqzvfTf+jZ1M9wTKV2W9
         VCECyUx2cIoelR9UyPROo1EQ9OnpvQddj0aFmaVD+ZmHj4XmGggmD/MmQ1tocZAMaymv
         Ek5aAG/HwcI0YeiL6cfKJ0oYk23zT2nE4O6tti2bDen/wybDR/8CrKT0d/L08ND62OyA
         DUG8c67n1DW+I0W0wA5ucGxnbMelqtosfiAEm8fvUjqyi3j6JKCEtPw1GKE4Uho8omt0
         crsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882403; x=1690474403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38IFDIc50A0wOd5ucWLRdj34aoYIh2uUJmN13AkN1yw=;
        b=aJRYgGo1NoV3yUypFlhObVw8s01++uBWhX8E6YK0YiqcncRrPckRfLjtYn8YuKu6J0
         mgsaXJHEX68X5u8KXv5UkBiN489frekhV5CVbnbNiYIJXpV74+RwAcUT1ONGeR7Nc6ex
         MXMU3+K9DN95oI2myjxWaIajGV6Avlxb2RSX0n51niPzOliQDBpYezFyI6+C9v2Tn+nf
         a5Zpvax5q7sJ3sAyEi5pYTV6sTsnXeBB/ag8Sd81MuuuNY8xrAqthGA43EuE4R8dKqbf
         PuGzQQzPUPxwwAeaCsMqjm2mBwWrSyIYTAkbM+4qk34HkiyVTfBe/wTO4sDJhylZkYpg
         gTRw==
X-Gm-Message-State: AC+VfDw3LKxozXX8w1YR56rnYPGpdkdQ7xG+jhyUeog2QMJ7aGoLK01z
        Xe3iAHHQlxCSPe2Fv5jq/AF2vJkVll9qHPlVYvFcf2U=
X-Google-Smtp-Source: ACHHUZ4r92X5b16LqQjgbvi6zaoz7f1bX7cN0msoCLQl3k7bJ/dE0MYoyyh6rXP9COFA4mMwyfN0rMxghEuW2AuOK4s=
X-Received: by 2002:a17:906:730c:b0:988:9ec1:a8c5 with SMTP id
 di12-20020a170906730c00b009889ec1a8c5mr24409800ejc.55.1687882403333; Tue, 27
 Jun 2023 09:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com>
 <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca>
In-Reply-To: <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca>
From:   Giulio Paci <giuliopaci@gmail.com>
Date:   Tue, 27 Jun 2023 18:13:11 +0200
Message-ID: <CA+zRt5GTSbKBjARaD19V7oQEkXUJJz_pvYO1fOXA9hPrzPS1sg@mail.gmail.com>
Subject: Re: Realtek 8822ce connection is very unstable
To:     James <bjlockie@lockie.ca>
Cc:     linux-wireless@vger.kernel.org
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

On Tue, Jun 27, 2023 at 6:04=E2=80=AFPM James <bjlockie@lockie.ca> wrote:
> I would try a different distro.

Any detail about why you would try a different distro and how much
should they differ?

Actually when I tried Debian Bullseye wifi seemed more stable
(although I did not use that system long enough to be sure that it was
working without issues), but touchpad was not supported by that
system.

Do you have any specific suggestion?
