Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D248E079
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 23:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiAMWlU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 17:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiAMWlU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 17:41:20 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA70C061574
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 14:41:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t32so1167158pgm.7
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 14:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=BxjCybmWNCHok5NRHFT0dn0hGwk/X82A96HqWcIDphe0qARo7VNFg+nR2GAC1k6PZe
         GaGEwflvKKfifYMjmeKuEOlaJ/zMyHUaZpVx3Kk6cP5OMFXAYN5ik00oQjQa7uKRy8eW
         6ryV/aeDT1ehLBCSmlLzSgTel8Qn42PDsITXt0EbZ+WKlpVs5CyLTVBLT+3U99cGGmmJ
         fIQOviFjASgnNpxyG1cYZs6M3Mwj2NN0mYlx+I/0Kjp0xDLchCI/0XJIp/USh3Qi9otC
         nlF22oPMDFttv1+cCf3Sh2F6LqOFu1DwjEMv2uSrTHvqf+uuvGszwtv45uuFwMQmtikF
         UFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=NR2O40ytE3z3/1jvwUgS8w3cCVdqI36tIoEfrHawykpfZ612bb/3xinxsB8mlnjzok
         qFM/NDmqChl4LXa0/HDjeBg7dGC4MoFYU82iKAvJP9dfr8r5aeU0XeMnSuANN87UKp7r
         7a1P3Bw1VYJTtBWS2OUulRH789Tv2S/F8JL/htNWgHtFj7Jesre1o6hTkTb2ep0sSbS2
         a8PhmlNQRgEX06+W/AI4eoERvLhw5WIo1WlFOh5vei1yOmLju7AT8rLMXR3MXttlmGKO
         ywZ3ICIrI+eDCHhapSsM8cxnO6q4R1rXaJQyk9KLFAD81prmsk5ojDt5S308bJGB9TEj
         XcLQ==
X-Gm-Message-State: AOAM5339CMKSbrhnRBGS6KW5WtozTONR8y6EceHf4qYgY78qzxI2QKG7
        j0mjB0ob4E0UGlTio5F3bhQJ9SBrEQhR0kWHtA8=
X-Google-Smtp-Source: ABdhPJwgWMGT/I6QEVhVN3da3EerEoxwghi/dPKdh7kVnnojkESUpOnSZUikfVBX9MIC/24miHvgH5eo7N++nD8jhEw=
X-Received: by 2002:a05:6a00:b55:b0:4c1:3512:d20b with SMTP id
 p21-20020a056a000b5500b004c13512d20bmr6166211pfo.12.1642113679566; Thu, 13
 Jan 2022 14:41:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f38c:0:0:0:0 with HTTP; Thu, 13 Jan 2022 14:41:18
 -0800 (PST)
Reply-To: mchristophdaniel@gmail.com
From:   Marcus Galois <marcus.galois@gmail.com>
Date:   Thu, 13 Jan 2022 23:41:18 +0100
Message-ID: <CANqBaXXy_A4bhGL0xg4Hcp=5ZW53yiu5Ab_mjryyaXJwUK0RWA@mail.gmail.com>
Subject: Good News Finally.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello friend.

You might find it so difficult to remember me, though it is indeed a
very long time, I am much delighted to contact you again after a long
period of time, I remember you despite circumstances that made things
not worked out as we projected then. I want to inform you that the
transaction we're doing together then finally worked out and I decided
to contact you and to let you know because of your tremendous effort
to make things work out then.

Meanwhile I must inform you that I'm presently in Caribbean Island for
numerous business negotiation with some partners. with my sincere
heart i have decided to compensate you with USD$900,000 for your
dedication then on our transaction, you tried so much that period and
I appreciated your effort. I wrote a cheque/check on your name, as
soon as you receive it, you let me know.

Contact my secretary now on his email: mchristophdaniel@gmail.com
Name: Mr. Christoph Daniel

You are to forward to him your Name........ Address.......,Phone
number......for shipment/dispatch of the cheque/Check to you

Regards,
Mr. Marcus Galois
