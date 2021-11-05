Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E77446048
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 08:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhKEHye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 03:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhKEHyc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 03:54:32 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAE6C061205
        for <linux-wireless@vger.kernel.org>; Fri,  5 Nov 2021 00:51:53 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d10so20785263ybe.3
        for <linux-wireless@vger.kernel.org>; Fri, 05 Nov 2021 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=VshUeeDSetU21+5KOh1TQAi9UpwH/OaoqJFGVrdYCmA=;
        b=I3bpcbxSfdxtQqvUhCcGZEjnEf7dFO2R56aPcMAZ4OyLdbhj4QmI6dT1jEFDfMlUsS
         VhitKM+4TRjmVZq5zFgM8MlgJu7V7V7EJ9X7axMQpD1B9h3uUQgaS9T5FPFZ2cBFG9pB
         pMiwYC6BIta6PsT/D7NqWHcRgjDqeoH7pDTO2D7ZA4hjFvuNHHxopxkUmrJbZAZ4TObl
         dz9LS0KiE7CTZfvRmwxzOVyZkbBUYb4yNh4WPruN52VhlfxekWl7KneTLbaaNhIS1Ngk
         rFqudHSrapTn8k7EcMztGADem47lue68BSRU5CCqOEAijxdxgXv+T82xRVgziK9p+eUh
         0CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=VshUeeDSetU21+5KOh1TQAi9UpwH/OaoqJFGVrdYCmA=;
        b=RAGn9/IqhwfRSyWScxebIU6gSIVsMHLLm0y+DSCGId9cIHGGyKdjMTWjHLEscRFkml
         ghpLg/iPC3TBDCJMKuQWldHT2f5WoXvAWFqe+ICIyVGR6l6xHDxkiqsjq9WaYawPj1e5
         1QaLvpBWrSR6kD0u7jNWCVl1T/LYbS6HgBeRvX6xTZM+y9IDAO8KlAgcphUB4gAl78zJ
         rNEObVayGrSFvto8K4QXjPvZceTDWHdG7FXjAuQBvw3SqiuDUUwtZs8t992pLCdMSGn9
         ptPcrmnrdno0ih9hQnz5wm3MrtW24GX3a2gsOU6ONse/es5bZ1amkQwvSmVykjv7JGf1
         ZGow==
X-Gm-Message-State: AOAM530ZMKKh75iMz+XgMOKr22/MdR/piUg0T/Fu/V5hpRFCpuq+5Dtf
        /au8ngaQp4kaXxKfFIUeDgnEgkXERo0LNVIyNR0=
X-Google-Smtp-Source: ABdhPJzDJr4Ms42pBsSB3dEJfI2TaxauRXfhuRlhDRnxXXlF6ZX8iuFNrvWQBltWjvuvIN4xqfi0ejMmuo8WaBssNd4=
X-Received: by 2002:a25:9887:: with SMTP id l7mr59886618ybo.431.1636098712213;
 Fri, 05 Nov 2021 00:51:52 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrmohammedmashab@gmail.com
Sender: musa129ibrah@gmail.com
Received: by 2002:a05:7000:8c19:0:0:0:0 with HTTP; Fri, 5 Nov 2021 00:51:51
 -0700 (PDT)
From:   Mr Mohammed Mashab <mrmohammedmasha@gmail.com>
Date:   Fri, 5 Nov 2021 00:51:51 -0700
X-Google-Sender-Auth: PMBJvCxslXX5WvCu_qyLGaHZwaw
Message-ID: <CALTZnk17veXWD6sf_VZDPNNOrVim0QYuLf5swP_5q4gAW+Xs8g@mail.gmail.com>
Subject: From: Mr.Mohammed,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good Day,

I am Mr. Mohammed Mashab, account Manager with an investment bank here
in Burkina Faso. There is a draft account opened in my firm by a
long-time client of our bank. I have the opportunity of transferring
the left over fund (15.8 Million Us Dollars) Fiftheen Million Eight
Hundred Thousand United States of American Dollars.

I want to invest this funds and introduce you to our bank for this
deal and this will be executed under a legitimate arrangement that
will protect us from any breach of the law. We will share the fund 40%
for you,50% for me while 10% is for establishing of foundation for the
poor children in your country. If you are really interested in my
proposal further details of the fund transfer will be forwarded to
you.

Yours Sincerely,
Mr. Mohammed Mashab.
