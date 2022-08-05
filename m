Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2B58AB35
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbiHENCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiHENCD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 09:02:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D927B26
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 06:02:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef5380669cso23352967b3.9
        for <linux-wireless@vger.kernel.org>; Fri, 05 Aug 2022 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ofw0jvZ2/7KI6aHiBQB9FHRJE/XXpHMbSTZ5ybaT/g0=;
        b=fZSgKezadn3PxH17YIepYTNaQr6h8tSIJlVr8DLMjk4seY3iAraSH+qlt0CgEqIZvI
         Mqfb04ByJlYLKPxOs33CPqSYCHXD4KbC0wlkCbhXPCY5VXbHv6ONTjupZAC8COapWpbD
         LW/6cT4UdwdnGrG+TwWgXTVkkFBSKwOb1EFkpFLX5yf0z4NM2DCpZvtQvy1Yas9Vodnq
         ttjQMEb11zhonxorCklIVAeRtTUewbDhHUWwJtm50llYcyuigFX3pZskxvLNMpSs9EeC
         IDmybJSoBgzQ1/PG8IsHDj85V+fZXpU3Gw8yfYgwybsVLxQ2YzWtdKnPeqkUM3j2rUOX
         cerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ofw0jvZ2/7KI6aHiBQB9FHRJE/XXpHMbSTZ5ybaT/g0=;
        b=a4ikC9F3yrKfvk96G+v/KJSh9s6uPO+1XqZDioQGzPHA0Ndl1cQhCO8qLxjGryqgyQ
         ET8vaeCN0QHRBQqC4qb6OdJKp9rAhQogyx13fcrtD6m0+WkxnFZLacFEKbRSjI76D9ov
         JDAccNghFdPxFmIFMbzcTsP3QAmEYv7FSyO1NVIiAmHEIfsNtC0HZPgv2s7zwAyPMXdX
         iKL8rqO8ltwXW+tu2KgWz8P4HNijEz2pMA9d6oeNN09td6Vk+mS/7koIGS9nTg38Km3j
         dWsZetaLXi9fCwsF4+IDcaWMzK1CAy8/jFmbmDZd3MgY99wEYgdV9eNE2Jw5zIxKmdwj
         QrBg==
X-Gm-Message-State: ACgBeo2cI6i7VvMHzO+2GJDyPl+Hh8HtfTwJyESSivAxZUkrBOhRNRIb
        JLYl649TQuNsYA+ZgzvR7h8KMA+r82LWtjdXMhM=
X-Google-Smtp-Source: AA6agR45rF7jkoL6bd/LGzX7bdifVtom7ilUgj/zWx9mWf/xHPTHGdZxV0sMkb04W5C+I0RwnrlqNs7o4HUkw+gTTr8=
X-Received: by 2002:a81:1016:0:b0:31e:63f8:483d with SMTP id
 22-20020a811016000000b0031e63f8483dmr5791346ywq.199.1659704521531; Fri, 05
 Aug 2022 06:02:01 -0700 (PDT)
MIME-Version: 1.0
From:   Murtaza Saeed <mnk.saeed@gmail.com>
Date:   Fri, 5 Aug 2022 18:01:43 +0500
Message-ID: <CAATNLbwMFDj0UrG1PBNh-dj7GT+GJ2Ud38TzHL=FmMG7wgNNbQ@mail.gmail.com>
Subject: wireless-regdb: Update regulatory rules for Pakistan (PK) on 5GHz
To:     sforshee@kernel.org, wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

The current regulatory rules for Pakistan (PK) for 5 GHz channels in
wireless-regdb are out of date and have been recently updated by the
Pakistan Telecommunication Authority (PTA) in June 2022.

PTA has allowed the use of additional 5 GHz channels which were
previously restricted for use in Pakistan.

(5150 - 5350) at =E2=89=A4 200 mW EIRP (23 dBm)
(5470 - 5725) at =E2=89=A4 200 mW EIRP (23 dBm)

The current channels (5725 - 5875) remain allowed at a higher power of 1W.

(5725 - 5875) at =E2=89=A4 1W EIRP (30 dBm)

The updated regulatory framework from PTA can be found at the link
below and the relevant information is available on Page 10.

https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022=
.pdf

If I am correct, the listing for PK in the database should show as follows:

country PK: DFS-JP
# https://fab.gov.pk/type-approval/
# https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
# https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-20=
22.pdf
(2402 - 2482 @ 40), (20)
(5150 - 5350 @ 80), (23)
(5470 - 5725 @ 80), (23)
(5725 - 5875 @ 80), (30)

I hope I have provided sufficient information, and in the correct
format for the database to be updated.

Regards,
Murtaza Saeed
