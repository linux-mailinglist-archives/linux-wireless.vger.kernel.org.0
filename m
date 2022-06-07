Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033445403DB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbiFGQhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiFGQhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 12:37:08 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FF6BFFB
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 09:37:07 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a8-20020a05683012c800b0060c027c8afdso3039752otq.10
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jun 2022 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=V2h9z/Ifbd6f4YrmaVfXNCHrvbCppjkt75BAO7WtpHM=;
        b=Bde9pbF8/kL2J+zYmNeX1Cy7rEupQvGPik/dAD0mz6TBfvu0v/svVPKmsUiEdbZQvX
         pEaEmtyF85i4F0GONmezo5JDuuP5wYfkFLHNE2DnVGnw6Fdion1COkG92tF17sznC31H
         S66iE0/jHww5XBFRJyMUk0tHl+KWJReHe11jMFxKhBtpKoPvF/f5OccBGKB8qcf6U/eu
         fjGMGw7qJcY1BXr+cYm2MmBpPoX2x8ZHkXXybXYq7JO4V2C0N/h+/GWBZNuornWxwh2M
         y47ZBnjUitDBWdekiF4M90d7oSkNGxCRaJlDlzY9fPjIuSyqldGQw/uGr1Yu0khMxEZW
         CcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=V2h9z/Ifbd6f4YrmaVfXNCHrvbCppjkt75BAO7WtpHM=;
        b=wClEX+CGdS3IhTyvNPlfZdx+Ncw2PjAefdNloQdhq3NYCU1UREeTZIXVRVja+8Rr3S
         0RdVjixU7j8mlqI7bYfLzLJ0FMjLkAoGrxe2cvoge6YLTZrZvJyksYfPAFkOCJyAw8NR
         KDhOkWh6uSU8Tq4cZMU/qfoEiGwuyBP2iCF6AKeW7GLe6H0J9mfs55NVD8F3+n+yyqKb
         VaV2A9i4sNFfXYQEWM8+4flMMOGCtTMRZWbREpk/iuruK0mc0iVg+MvM8maGMgUq9tQc
         kJMFton4iS5StSgb/yWqHMRFlp83FJTLHJsuDXair8uhbXzfs/1jsZ0g1vKJ1j4P7T3g
         6u0w==
X-Gm-Message-State: AOAM533Di7uDaMTF5ke572DjpoTlCmdVQfbN5GvEShJnJ0PDRvHv1A/x
        s1CFT6E6Ih0n8saLUiEvLQu0qG+EaPrAksrnNx9kUQ==
X-Google-Smtp-Source: ABdhPJw4ZEmR71RxBkUJKriac+k6z7Gaxe2UYTNIXIQ4Ge1yRvWFkuVPXxOeKiawse/tQZlZhJY7p4uiWEb5pTFs0dM=
X-Received: by 2002:a9d:2649:0:b0:60b:fd52:a47 with SMTP id
 a67-20020a9d2649000000b0060bfd520a47mr4497090otb.246.1654619825215; Tue, 07
 Jun 2022 09:37:05 -0700 (PDT)
MIME-Version: 1.0
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue, 7 Jun 2022 12:36:54 -0400
Message-ID: <CAM0EoMn_4k_w_maX=0=tmiK5k1nTEWpByGP+83qiJHdM0DbigA@mail.gmail.com>
Subject: CFS for Netdev 0x16 open!
To:     people <people@netdevconf.info>, netfilter-devel@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>, lwn@lwn.net,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc:     prog-committee-0x16@netdevconf.info,
        "board@netdevconf.org" <board@netdevconf.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are pleased to announce the opening of Call For
Submissions(CFS) for Netdev 0x16.

For overview of topics, submissions and requirements
please visit:
https://netdevconf.info/0x16/submit-proposal.html

For all submitted sessions, we employ a blind
review process carried out by the Program Committee.
Please refer to:
https://www.netdevconf.info/0x16/pc_review.html

Important dates:
Closing of CFS: Wed, Sept. 7, 2022
Notification by: Thu, Sept. 15, 2022
Conference dates: Oct 24th - 28th, 2022

cheers,
jamal (on behalf of the Netdev Society)
