Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96417D206
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 07:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgCHGOo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 01:14:44 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:39979 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgCHGOo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 01:14:44 -0500
Received: by mail-vs1-f54.google.com with SMTP id c18so4123653vsq.7
        for <linux-wireless@vger.kernel.org>; Sat, 07 Mar 2020 22:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZqeRJppyR4X7IWp+u7jYSDUzXVvmsDxdEb+Dt8/kZsE=;
        b=IxCr2m/pP4NZtELgoIXliDE+Isw4q7qF8vnw23ZTXaQ766RGKaivF5e+JwYtFo6ZLL
         uJKeilvNxX5z7rZBKrBOSRIESY3Iv1d3mkbZTkj/ffVgBW/kPx6yZKB9DukKhzGIfpsQ
         ncqVRiZd539TNYTUWXXWi/vO5DnwcBdVU4btcGUzxZ5ekRwy/IR6B3B5kuu/PXLZfq9o
         FEuK2FKyAyi3KtmB6fUyiN9CCLEtF07hC+UidKkwcJ2A308CrLyvs8zqq7Ho9PaHxzZ5
         2DbetxTyTnzare8dSqFbY2c3P58L35L3076D8xHMx2Cn6bUgC575rc5dF3czWXuJa+HC
         U4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZqeRJppyR4X7IWp+u7jYSDUzXVvmsDxdEb+Dt8/kZsE=;
        b=X+hpWFimNqX7vBdWx4ZfpbcMKkzHLt60sVmKdkWB8yIiYgE284D6gBdwUh9ToM7BFf
         cUysiCcrJc2DQAbHvNRP/nzV9sBxKzj3vq7lsei7tpXvgal7Y5aDoih4BUOauBfoR/gD
         a4EG5IgOd8zmQmX3sN0IoOuGeqyx0LsPUDvGVSl94hp5hOzzvfvLeItncB7wMXhI1/k1
         zzEooMPwgixmfG67xi1deH/bGOJyQ7g7D/wv/UdX4VxCNM3vMfHywSHSooNwUtpeTbSI
         BR7l6HRNJom2OxN/feAjl9knLjYQ55kx+qPnlNcPQOEsk/sWzLILDwg/mQzkSR+FYYy/
         RWtg==
X-Gm-Message-State: ANhLgQ2NmbeNsQV8BNOgCnz5uCRGMCohLsLJQj/ZO6k8VywNs8uoMQuB
        MJ07XM8UAAAi4oJ6K6sbjYCWPF63wmRoQOoXKdd3GHmu
X-Google-Smtp-Source: ADFU+vsvs7lLQ4pCULe2OAv2YUH+Mysp7mFJkaHZoQ38gSpYCUFphafOeF8dDt7iLefvOsfpWpQeqQmdc6EIjA+auc0=
X-Received: by 2002:a67:870b:: with SMTP id j11mr595823vsd.39.1583648083465;
 Sat, 07 Mar 2020 22:14:43 -0800 (PST)
MIME-Version: 1.0
From:   Justin Capella <justincapella@gmail.com>
Date:   Sat, 7 Mar 2020 22:16:19 -0800
Message-ID: <CAMrEMU-8A5scsr-sXdKYa9fO+AGVDWafMz2km5KnAu2R31H5rw@mail.gmail.com>
Subject: Re: ath10k: add QCA9377 sdio hw_param item
To:     "erik.stromdahl@gmail.com" <erik.stromdahl@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> >> +            .hw_ops = &qca6174_ops,
> >> +            .hw_clk = qca6174_clk,


Would it be worthwhile to refactor / rename these? I also recall there
being a qca6174_sdio_ops
