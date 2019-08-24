Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28959BC9F
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2019 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfHXIuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Aug 2019 04:50:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43596 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXIuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Aug 2019 04:50:55 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so25652898ioe.10;
        Sat, 24 Aug 2019 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muJagJsfdHnHyt1SNcnTMB4/zCJ88Nk1+Jo9orlYcC0=;
        b=XBW4cNm0qnxhyEwFMkuxEl5vTH9NwzgG3y20cmccC8F4IgNszvhVZ9jG+gTmDwR2tu
         Lk5M4Fl2Bg4zG7i6kMiY2qlp4lA669sfCSAPoKOiTwR/w98hS3aMm42NOJwq23BEwxfA
         byAFwpb3lJ/mpsqxSiZnkLJ2Qr/LubHj9WAZjWWtNrhjnCwNgQ/IVaRQtGnZGkSsR1cb
         +RPbdQ11lqHCgOUvsJpyspaBZc+Oiu6JAKxyPU4XbTykLB92fYNGGln07+LFY7xAYyrJ
         /T0EhtTlVqzkblhUASlXRAe4RdiESpJcNGpjIth4hd5rJpBC03QderptnxdD3jnu5sLP
         lqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muJagJsfdHnHyt1SNcnTMB4/zCJ88Nk1+Jo9orlYcC0=;
        b=PY3WC/b5+JjPRK/ZbfNn8rf0Vjg6HrAMaRGG+DR9hx9R9iCAhs1RIyHfGJbtyT1hMu
         89uDxf9MBis5w6rsevUE++zFhw9HblUwwHxT3CCSNV5iC0QgkFZ/IMmhr3uj3zi4cBpQ
         bvs2fdm/cstKudzprotxLxipJv5niohFIfxXRmFGv1bEB0ZkNOfxWFN8xcmFuQDLj08h
         X3kgAxllT5gEJsRoFOjZ/cldTWX5j7j2HxjFKvtbQzeuCZad3piHdpu9mvlyzb84cKmr
         ICLe++8RxWIa+eQcoC0UiFUMnSwn37FY8YmXjEsSmlSdvklvB/HO16nYvpg8MGKZyF5i
         VI9g==
X-Gm-Message-State: APjAAAWWihToK6l5/UGdxvs2MyI3eGnR/0Ewc0RYlvdZUeP0Db1eZ5rO
        Lo5HxwUbDnrokRV1EDDgnkK8agk6Gt7LaLScXOCQPw==
X-Google-Smtp-Source: APXvYqwb+U6TbMKEF5uIuWghltgqWlOGqzkrikB5nB2zWW/oYEjEqkv09hK+/lhj/X4BrYkLVMw5WnIbD/wvSdR3Fj8=
X-Received: by 2002:a6b:6f0d:: with SMTP id k13mr12733354ioc.69.1566636654837;
 Sat, 24 Aug 2019 01:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <1566636490-3438-1-git-send-email-hanipouspilot@gmail.com>
In-Reply-To: <1566636490-3438-1-git-send-email-hanipouspilot@gmail.com>
From:   Dmitry Tunin <hanipouspilot@gmail.com>
Date:   Sat, 24 Aug 2019 11:50:43 +0300
Message-ID: <CANoib0F5YZ1i6cc2YDKLEovE29Jnzt2B1B-rJRWuQuDn+Gcbmw@mail.gmail.com>
Subject: Re: [PATCH v3] Russian entry is incorrect. According to the last
 regulations document of Feb 29, 2016, 160 MHz channels and 802.11ad are allowed.
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> EIRP has been reduced by 4dBm because of TPC requirement.
This is a typo. It's actuall 3dBm for 5 GHz.
