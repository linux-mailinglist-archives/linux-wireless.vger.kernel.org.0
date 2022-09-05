Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C25AD864
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiIERcb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiIERca (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 13:32:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEDD5A3C8
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 10:32:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z8so12158212edb.6
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=FSC/JOUkzfGiawvUsuwBhFL5jIBix+tJ2uc4E2WmI/o=;
        b=TpQuyn82hNxO6J43K15JCybXJjwaCJw5itHidX8gINTiCVRB7utzWidFVILmU+Yn0i
         /epXU82RMf8yW7+Bdw699u5Ut2PeayfZ9yV6ks4P4eEnJZppuEysNDVkYuBD+e9O047X
         3nm8/x9XqOVdgQVyYGyVxMhw4uynd/5+3aIad0eeiEUS4Sl5bveEgStz2ng2Ob6vIlXM
         DdETV7UaslP3HEMmACiT7J3OAbGSvLd/T77Cf+T+r0P1ZfIoQmSnP+/XezNj2btCRS7p
         gSiDF/+oWXoe3C8h19rwgv7PUgTVTCmvqEFIb6ajbRpWDVFHW83P+Fhiao1o0BETpyNq
         udUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FSC/JOUkzfGiawvUsuwBhFL5jIBix+tJ2uc4E2WmI/o=;
        b=Q27975FecAosnvJbCgeCJBun0E8TQc/eucLNyZGNcX752IamzKFJUH6K3LiYGqbhth
         aUs0zMTt1BHIoMY1WBGSimcDTkBenzWr4/pj/XCEou7PNI25cR7T4sbHlbMDRd7pGtfD
         KIMkXcY6Xjb+PL4e3szO7x2/I7q0lhqCgglvEsOKEBIViD5DdHHy/qLIr4TTaTuYvrPR
         /Pw8mPs13gaVprGM9GURzo9V90q2OaO0TJlhLSP7StTBcnCKdXzZ1mi1zt64Nlv2HYod
         nqxAZB8cpGKwDjpT8jJZLFVajAGdVLjiO4RheAg6R7f2gj+RfHwwREFyH1NzlGUg+QkP
         D5zw==
X-Gm-Message-State: ACgBeo0nAPOqC72d+brhy7+1ZjauYuw8hls+QG2SFLc00c06LEt0Nj1t
        hiLQvf9S8WjtRoEtTxWZZ1BxGORyHyJv1F6uw0U=
X-Google-Smtp-Source: AA6agR6NgtEFkMwvNRJ38N1tnGgqPxphWRXSdc/NNe6RKih6tj0dYN2prQroSmdelF4/DRcwsQM/FjLfMy2sJuhaRWE=
X-Received: by 2002:a50:fe91:0:b0:43d:c97d:1b93 with SMTP id
 d17-20020a50fe91000000b0043dc97d1b93mr45868484edt.67.1662399147808; Mon, 05
 Sep 2022 10:32:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: f.k.fleckenstein01@gmail.com
Sender: arnettdavid65@gmail.com
Received: by 2002:a05:6400:17:0:0:0:0 with HTTP; Mon, 5 Sep 2022 10:32:27
 -0700 (PDT)
From:   "Mr. Ken Fleckenstein" <f.k.fleckenstein01@gmail.com>
Date:   Mon, 5 Sep 2022 10:32:27 -0700
X-Google-Sender-Auth: wy-fusLIK_HLk_I0460ZsTP1Bv4
Message-ID: <CAKbeoUt9TWV37PGJzxgmkSWLyfj=+jz54GO6Bk24Di5AeWXv5g@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_USD,
        MONEY_FRAUD_8,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I assume you and your family are in good health. I am the Foreign
operations Manager at one of the leading generation bank here in West
Africa.

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

In my bank; there resides an overdue and unclaimed sum of $18,
(Million United State Dollars) when the account holder suddenly passed
on, he left no beneficiary who would be entitled to the receipt of
this fund. For this reason, I have found it expedient to transfer this
fund to a trustworthy individual with capacity to act as foreign
business partner. Thus i humbly request your assistance to claim this
fund.

Upon the transfer of this fund in your account, you will take 45% as
your share from the total fund, 10% will be shared to Charity
Organizations in both country and 45% will be for me. Please if you
are really sure
you can handle this project, contact me immediately.

Yours Faithful,
Mr. Ken Fleckenstein.
