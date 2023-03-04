Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5BA6AAD6D
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 00:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCDXN6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Mar 2023 18:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDXN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Mar 2023 18:13:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9CDBDC4
        for <linux-wireless@vger.kernel.org>; Sat,  4 Mar 2023 15:13:56 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a7so3603936pfx.10
        for <linux-wireless@vger.kernel.org>; Sat, 04 Mar 2023 15:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677971635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YO4ZU9CMdBkS7EHwVUMi6utYEYLEsZRr5G63eg+uzH0=;
        b=M74wV7sG65kZ9BZBoWWVPkDYgTONkGqjNnly73h1whoz9X5IyJinhvq0HQy2IO64Uv
         mw66yAa2Jn0/48ekL6PulmuDaLpk+wkStidFLEmRuo+0H3YFT0RnIfMRLIdJJ4c8mdm4
         n0Kkfg5wK4RxKJ9lW0WDHPmxfr/ScSx1wFbeN4MkVOrQoMtD4sAArLfr1DCTXlyiyHQ3
         pUdFsfrR6dwUvgDe5MoL0FgwhOio8dqZeQzcIdX3DJmB6EQFYrJ0YMibtftLUgqamq1C
         m3dTk+LXCZ4ncmMhS2BUTEvK8pVlW6Vhu6a9V7NNgTZIDVK8RQmHKRfwSolc3DYsywVA
         e/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677971635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YO4ZU9CMdBkS7EHwVUMi6utYEYLEsZRr5G63eg+uzH0=;
        b=eAgQcE1/aVrNcvAbzstjH0lGSrnDNFA+wWHwickUWyDyVPLJRSF77hnFdeE3oC3rRH
         UTko9sEVdDZ/6JhaVP6o6Lu+dAabdi7gE6j1gfrG5g9BSBvnB3ADTc6v2/Kvno8gswHk
         E1sAWgxjVvkYqFcpRoPHxj7WsCa71TCeP8pzb7rCYu8KPVxMSFQ4syI9lCSRdqH/uwEr
         0gIh6K4jImD3VrF+a5SgUKEZHbfTks98Xo75u4U3uY/yLU9HQCml7WCpvqSS+Rvy7DHK
         SIBDYAN9i3orVm38kph5VRgdnliL0eVfHqeqVKS05aT1YTqZWEY+rNlPuSXBDCrVKUOz
         bobQ==
X-Gm-Message-State: AO0yUKUyrvagxWlVAeaZhpZ8s/SIXImOGZBftuEVWvDn7UhQOEykzmIm
        rdoT0wCVJHiKDbTfyP+kt0cFyf4vxNJL4vrwsds=
X-Google-Smtp-Source: AK7set927FxL/u50NusgEv648LK27bNJoL+vAxtLFQ/8b8/g9AZ6DGpFB6WmrEAPNAsAv/jULWPizqKyrhSzugzVivs=
X-Received: by 2002:a63:ac53:0:b0:503:7be2:19a7 with SMTP id
 z19-20020a63ac53000000b005037be219a7mr2115945pgn.1.1677971635195; Sat, 04 Mar
 2023 15:13:55 -0800 (PST)
MIME-Version: 1.0
References: <CAMPnHXye6EBTix6125NzPrQSitwKikK6b77g=K5t-ihmU11JHg@mail.gmail.com>
In-Reply-To: <CAMPnHXye6EBTix6125NzPrQSitwKikK6b77g=K5t-ihmU11JHg@mail.gmail.com>
From:   Keshav <the.ridikulus.rat@gmail.com>
Date:   Sat, 4 Mar 2023 17:13:44 -0600
Message-ID: <CAMPnHXy49dSKdiCzeEZ86q3YEEWW=PrfPYwPevA4A2bFBe_sbg@mail.gmail.com>
Subject: wireless-regdb: Please correct the regulatory rules for India (IN) on
 2.4 GHz
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I noticed that wireless-regdb db.txt [1] has restricted India's 2.4
GHz maximum power to only 20 dBm:

country IN:
        (2402 - 2482 @ 40), (20)

However the Official Gazette of Government of India (PDF [3] linked in
URL [2]) mentions that upto 30 dBm is allowed in the 2.4 GHz band.

2.4 GHz Rules for India (IN): Pages 87 to 88 of PDF [3]

I would like to mention that I am not an expert in this topic. I am
not sure if there's any other reason to restrict 2.4 GHz for India to
20 dBm in the db.txt. I also couldn't find any other official
Government of India document that restricts the maximum power to 20
dBm (due to some other reason). Please look into this and correct the
regulatory rules for India if needed. Thank you.

Although not the topic of this email, you can also find the 5 GHz
Rules for India in the same PDF [3] (pages 94 to 97) if interested.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt?id=7f7a9f7bc6011b072b5427eced1ff19261764e95#n853

[2] https://dot.gov.in/spectrummanagement/gazette-notifications-delicensed-band

[3] https://dot.gov.in/sites/default/files/Gazette_Notifications.pdf

With Best Regards,

Keshav A.
