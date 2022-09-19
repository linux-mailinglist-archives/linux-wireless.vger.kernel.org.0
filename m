Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F95BC50D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiISJMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 05:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiISJMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 05:12:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA322B3E
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 02:12:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c7so21698584ljm.12
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=mAFejXazN7AR4DZL77v39AhpyXgCtkDstk5iMhmKVi0=;
        b=YFbrFAlMe9QmUKeWXk3YH9B5FY0FZldFJ0WYpCeVOZih5AR2KZZdfJmL+ud0O4j/tJ
         3pYwPS3qQaInszrT6MRsq9OcMyPyCmo8QYzpvabo6ntG/g6yL1qNwcpJuDO/fFGar8/Y
         8ieafbV65381IEWHkUqO1osrh4AMjTkDbXycStUJy8QoQQp0+wscFmWiH1egIIKxaaGX
         yYFJ2PftsQvM/FHAibs/tfYer10uxBIgZ7qTjyAM5XLFAR9bXwRagZ7V9FJSKjhx+BNe
         8o7l9bASm4fyjIeIOybnMk9C6PPVS0KHUT4xOk17wmkMYaScBxYlusesNpKqp1P1L7D1
         IfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mAFejXazN7AR4DZL77v39AhpyXgCtkDstk5iMhmKVi0=;
        b=fTsUap0hnf8BygKEwPtsDL1S4ash8Chkt2l8ybf+pLbHTNKn27Ac04dENe0rjYYFIb
         05cgQrDhbwuXTxVpb9+8EqPV4H6XUhWM691GMxQW9wsVFbDuE3LH5y6Qht+Ay03QDsjc
         TZ5RRj0plG2xzXkqt7R5NRL0OhAuHX+45FHeGwikeeOraRzNviUwexFgMrem0mPMmiHI
         SchKHqmGWJOwhJIl7Xo0pw1cWblt3F1QSF4nqpI2QraT2iC78VhjJAUdQwaCe6TA8jOW
         grGIajOX0v68E7YwzPNXKOCyJG0LDvN4g3jHUmtDLZwWbJn7egb8aMjqEgHH6F58Yyni
         5huQ==
X-Gm-Message-State: ACrzQf3wzmHkwiss9JOMt0IKv7L9IA+b95yQaLsyWv3qUKvrjPm3U4/0
        4CdM+/zdSpuYphJzXxW0ZyaUaCmmlmmFWh+KHNA=
X-Google-Smtp-Source: AMsMyM7os2hpFj0YHDsZypdcEz8v8zRZ4KHCcitV/zE+Qf0XRi5t4ItAb1WA9u1EFvbvIqQvrEuENjwwH7S5b+b2Lwo=
X-Received: by 2002:a05:651c:8d:b0:26c:4ef4:e4d8 with SMTP id
 13-20020a05651c008d00b0026c4ef4e4d8mr1306393ljq.74.1663578723327; Mon, 19 Sep
 2022 02:12:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9e57:0:0:0:0:0 with HTTP; Mon, 19 Sep 2022 02:12:02
 -0700 (PDT)
Reply-To: officialmanuelfranco606@gmail.com
From:   Mr Manuel Franco <zainabadamu6378@gmail.com>
Date:   Mon, 19 Sep 2022 10:12:02 +0100
Message-ID: <CAM7omXyak=5_HoKPkNBOE_bKEjwUpBMPqPr5Gw5iQj3mAmkN+g@mail.gmail.com>
Subject: darowizna
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zainabadamu6378[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [officialmanuelfranco606[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [zainabadamu6378[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20
Zosta=C5=82e=C5=9B wybrany do otrzymania darowizny pieni=C4=99=C5=BCnej w w=
ysoko=C5=9Bci 2 000 000,00 =E2=82=AC
Odpowiedz, aby uzyska=C4=87 wi=C4=99cej informacji

Najcieplejsze pozdrowienia,
pan Manuel Franco
