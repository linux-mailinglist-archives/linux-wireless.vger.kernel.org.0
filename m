Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACCC6400FF
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 08:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiLBHZL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 02:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBHZK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 02:25:10 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94922AC6F1
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 23:25:08 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id i12so2937496qvs.2
        for <linux-wireless@vger.kernel.org>; Thu, 01 Dec 2022 23:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkxAZ6i0a46NYva8Tu5LZq5jw3SaAMYQxWXgmzM9ieU=;
        b=hfluDAzwKX/IXE/smnV7yY66FtJhs1rotB6hNAzmGY1C/SMzEzzPWzkKsqlCaehRdm
         ieS3yhGnliSM52kxsjmYSTFD0ivaIWWmqPjLZ2Ej+skI3ejY2fwHDtqayUjHS8JpSmiT
         pGXlgLELtFg9xrBkbS/t8bJvYZdihRSJYyZtM4N4abCZrQDDa7TVSpCaLqjAuDf6pTon
         CTQjNdHRtYHn3GldCJXU1O3RofnkBnGUgn5Oj5+oRuCeF4dpN4BJWLI5TkqWfMeYtV7i
         4Qc0yso4j1EtgapIt8Z33cim8wHDYGQGs4VHoFGh887I7zecurJ3w0lJ+PxxgUl1dQ4E
         kksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkxAZ6i0a46NYva8Tu5LZq5jw3SaAMYQxWXgmzM9ieU=;
        b=7wyYRjrIX0A1wjrQ0wEQrSbFqtd2+yawDAFieyK35RfpMtFjCEP2r2Fh1MxYrIYm+W
         SOoi2lfnxHAt8opvJwL85upcYd0GizqQMu39MmczYqJraPS9eqjjJGC2OQXY/JCcSBER
         II7pna7u79zffhfQJUhTCUi3TewNVkgZ3eP83GC9N0qkFV74P0TRzJIa230YlF11xAjP
         mjtueGAHLi8V4AvKKIEtpTKjcAWAvJDaVqwhpagXRbLNSkGQmL1ub/gRzmOXJhii9Lws
         2FAFQO+jH3lgxEfCpKrbmiKTH2DBwUUwKuo911o3Qw0u4jGWgrZvE6a/DU/JtpDD14j1
         JKLQ==
X-Gm-Message-State: ANoB5pmtWncBjs6hEEd2840SW7ZZaDvkdeZ2tM6dWjaGwSGqu+TMMp/x
        PB6hL2N7FzpgXlpKSsbe93Uv5h2+Co5k0KglU5ljvD2ijAQ=
X-Google-Smtp-Source: AA0mqf7Yh0y8Tz0BsDAkzOm9ODSpehe++0JeuBF5D/YyrQeKHUC+5kjvT7zsRMt9uvyvr9gowTNvfrY1+KK6L5wwWTc=
X-Received: by 2002:a05:6214:170d:b0:4c7:4add:6123 with SMTP id
 db13-20020a056214170d00b004c74add6123mr186580qvb.100.1669965907704; Thu, 01
 Dec 2022 23:25:07 -0800 (PST)
MIME-Version: 1.0
References: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
 <80556c56e69405d7c8f8bc3d57e2ba697074c660.camel@sipsolutions.net> <9093c08e-302d-578c-3e16-619d238b4022@airpost.net>
In-Reply-To: <9093c08e-302d-578c-3e16-619d238b4022@airpost.net>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 2 Dec 2022 18:24:56 +1100
Message-ID: <CAGRGNgVGsii7+jdN3PnMWdCSeRyCDF96ivVOfxzi8xDufUigNw@mail.gmail.com>
Subject: Re: every other wireless scan shows bogus (too low) signal strengths
To:     Bruno Dantas <dantas@airpost.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bruno,

On Fri, Dec 2, 2022 at 7:08 AM Bruno Dantas <dantas@airpost.net> wrote:
>
> Hi, Johannes. Thank you for your help.
>
> To exclude a bad network card, I replaced my laptop's card with a differe=
nt one (with the same Intel AC 7265 chipset). The replacement card fared no=
 better. Therefore, I put the original card back and ensured that the two a=
ntenna wires are securely connected. There is no doubt now that the wires a=
re secure, but the problem persists.

Stupid question, is there any chance that one of the antennas is damaged?

You might get slightly different behaviour if you swap them - if your
X230 is anything like my X200, there should be enough slack do that.

If it turns out that one of them is bad, you might be able to find
replacements on eBay or Aliexpress, or in the worst case scenario just
install a generic antenna.

Hardware Maintenance Manual is here:
https://support.lenovo.com/us/en/manuals/um014928-hardware-maintenance-manu=
al
and the steps to replace the antennas don't look too onerous.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
