Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677BB12571A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 23:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLRWpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 17:45:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33469 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfLRWpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 17:45:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so4470749otp.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oUM61ig48dGp6BTSyXKlzMTD2Se0Ze6HBqgSf5x4H8U=;
        b=TPvPsRBQ4RU9841X5EEjyKkIQKLPNUTPwte/PUm3es1Bhy80tSRxEfr+LbKduirPS9
         5KdfHy6GO7Rt+zVg+5z+cQgYPBv4QaijMUfeeT07WA/N4Knq6qx3vJE7orLPdJ/OcIe6
         7VZSEr0Mb7j6QbCX640q/TifvQ8O1Rk0T8VUmERs1gHQcHBz58E6G72G1fUoOd0MrmRy
         TKlvTUqHat8eNPK20246Ksl/RErAiTo/F7r3uGtPnrtUfa7SALOp3y9heYdnDrR2+0lJ
         /bWkE8iI0nHBLXd39fK105Dqntgh9/KVkwkz0pFkyPsZLWLSSKU4Y6CnhGeMtXbQKWY2
         Pugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oUM61ig48dGp6BTSyXKlzMTD2Se0Ze6HBqgSf5x4H8U=;
        b=MYRa8M8SE9Rn46jpq8S2ksbTOXFdKGNQG6HEFN7dOPNrMuwEsiCb8S0JQ3EaPr5/9K
         GyhYl9ITW2L8C1s92M5w0l9NHc8YQMpSC2oXd6pmpiSCGGYMBu6HJTgw35xtvIbtIHJ0
         DeZcp2rAyhKG1pTGhYMywgx69+avZZEINF+W6wlMQvNpyJTfaJ7lrmjlB+ox0wgB2GPN
         58ONTx26M6NB35H3a2G9+e/Bdu5YjXlRP8RPEFldQlmU0tckQScYfejASLY15/6Lmgm7
         Vof3B8kq9EHvNcwWVybYkKibPeGByG5Mq1txfD7z00Od9F5DSkHokwlftTkJdTAWpir9
         vA1A==
X-Gm-Message-State: APjAAAULOicw2pCbuwwLbEyZJpz3umpwD0IWCi6VvvmBTht71pyouTna
        rpt14bsK4xF1jdJsPBTx6u8n/KvUnzoXJ3tg58k=
X-Google-Smtp-Source: APXvYqyv4FSgGRe5K+ifNRYBl/StBzCnqJV+gR+y7xJRLH5ARyXNyfkBMSVi9HvdffmRpnkvGfwtPjs0J2BqM2c3/+8=
X-Received: by 2002:a05:6830:1116:: with SMTP id w22mr5311658otq.63.1576709110567;
 Wed, 18 Dec 2019 14:45:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Wed, 18 Dec 2019 14:45:09 -0800 (PST)
In-Reply-To: <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
References: <20191216092207.31032-1-john@phrozen.org> <20191217153000.76AB1C4479C@smtp.codeaurora.org>
 <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 18 Dec 2019 23:45:09 +0100
Message-ID: <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com>
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading support
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     John Crispin <john@phrozen.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ccing Johannes Berg since upstream change (mac80211-next) breaks build:

In the commit log its written: remove SUPPORTS_80211_ENCAP HW flag

Any sane reasons for doing that? mac80211 fails to build because of
removed flags, this is on backports-5.3-rc4

Other than that the feature delivers the promised:
QCA9880 iperf between wired and wireless machine
native mode 449Mbps
ethernet mode 522Mbps
