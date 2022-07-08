Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5456BF25
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiGHSEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiGHSEs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 14:04:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E77B7C19A
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 11:04:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e132so22965987pgc.5
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jul 2022 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PnyL95lSTEiaGVewOXVcDaAe4G0VOqzbzPfr26idJtE3b19VoQn/eeLLDZtVeX6gRA
         oTRrHo+sRBZjH0IxH18r56INxxLJgthLIpLlhHYMQLwBSqhjWRVFd5gyivF7AlW843Dv
         zGOs+WSfrVW5qbjSVjyaILAyx3Kht3brHpBnD1b3kAXCUBB0ycCF07pMUm7Vtpfzt+yi
         apzIDogQX9FN7/2H4MGA56u3JlFQGsURiWzunzTlnICJZ2zEFcRkr3Rj2wGGW2HCwPaD
         Y3T92YNu2m8Bf9xHHNrUeFLFN0x7JQCnorYDTF8bqYe0HPaZKj1zS8Mx1iTgHoUjnKDm
         fWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=L7KGnNFraifvY7Uvd4uaJTpMQvu0ZDKI76r3vBhzjQr5xU80aZuUJFN+AOUOAnfZt/
         xTHVSiezFYQydQxEPLVXsRkmzBmUiq+T9NJ3+7G5RJyOlpOWai9RBugduH+33zrwcuHw
         ctX+OyrcP1h+uScoq6B1Xdka0IYBvD+bj7ckOO4qB9YcbSC57xLhqgcFpvj68vaRJHZX
         UWZaOWxTwmWlIBXyClVKba8TUxENHHxy07+u94veUNnG+lg3uqt/EuMESUZzzVTvKj/s
         /gyq7A5p0G4GFzVkzZV9cCNeDMD8cvCaqFJ1VSTYloOsBVWQW1lFmHaDHebN3G8YMLEv
         8HMQ==
X-Gm-Message-State: AJIora9R2GQ//VB8sgpACCRxQan6/o1Itxv4SccytwNwIDwQnMxCZ1Pz
        WwtI/XGH8GUmONdZZ3DMVYjqEEz5/x9YurUsIso=
X-Google-Smtp-Source: AGRyM1sAFauzDoQY8ItLUK+AGlRdCP/ax5fQPgqEE8lh/yIZPZFr8EUW0fpatDa+Sh7sI4tku1IO2L47TrWqkMhqvvs=
X-Received: by 2002:a05:6a00:a0c:b0:528:5233:f119 with SMTP id
 p12-20020a056a000a0c00b005285233f119mr5166707pfh.69.1657303486641; Fri, 08
 Jul 2022 11:04:46 -0700 (PDT)
MIME-Version: 1.0
Sender: guiraharouna098@gmail.com
Received: by 2002:a05:6a10:afca:b0:2aa:363:ff43 with HTTP; Fri, 8 Jul 2022
 11:04:44 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Fri, 8 Jul 2022 19:04:44 +0100
X-Google-Sender-Auth: oPI9dQmx4RyBku_947nuYlvaSWI
Message-ID: <CACKv48wBd73_Gz4JBTc0PHVFCUFn_UBXgBxN9UufFD2uFCsMWA@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


