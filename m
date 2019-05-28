Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAF2BD3D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 04:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfE1Cch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 22:32:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41172 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfE1Cch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 22:32:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id m18so20272074qki.8
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2019 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gazIaoRjX4+ZH2UoFthw+2LC5GJZT06O6CMr8RDmhSw=;
        b=OyRdXpdzi3s1S8noasNbxCVQTvgCNb1jt09tkwpfQtEiqBFrGZ5Xq1rHdJVguW0jWk
         D3JYNTEpjDsifZXfusqjvSRUOM8ECBijRcu5fVIdGa+zpuQT7cV7rYICzI9hQqwaErSn
         lIRXLxi2ERkQ2stkbKgVTw718AJhQjZPMLoS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gazIaoRjX4+ZH2UoFthw+2LC5GJZT06O6CMr8RDmhSw=;
        b=fO+k8rMsVmTVZh+sIfHXg59tFjz4/Kw6vUS9ftY+qte3Tm/kWYO0VUWXe0f2wO4GgH
         9NVZxseG/jtEBCBqLblrLXrv78nIaLM9P7eeh6Vv1HUyxY40Z9KXg95zcraz+R3d21zz
         TXB3QFCVxUbMk1tM1yb1taEEhIwfYWXMWBrj1euav76k00sKdE6CcZAg+p336LvUY9Eq
         0bVQwFPVmY4mZ6p0bpicgXSy9AAS43Xd0KTmhPs7z+oju10irnpIuES1aRusZ3pdgx3f
         nxE7bQqaa29CpTCzz3MOaaTWNqPeaFEmd2+/ij/1aL0SsW/LxG3z4tjSPU8TBHCvJHza
         KOuQ==
X-Gm-Message-State: APjAAAUf6b4tUeM2SdWqacC1Im7bhXSSAEfs5n3t3LeJ4DWhPXQ44p1e
        bpkO/sdCjm/SKKo4nEH9V3PBIiGrRcjN0kRW3itCVg==
X-Google-Smtp-Source: APXvYqyK1ZwSczQWrH4SrzKh0yrWlc2AguPwpnCRPMfy2AHPig+E94P5GmmGBxVJdD/ddu2rbTk+c+FmOzkVavmkeRw=
X-Received: by 2002:ac8:2907:: with SMTP id y7mr61840750qty.278.1559010756074;
 Mon, 27 May 2019 19:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <1558506776-19702-1-git-send-email-wgong@codeaurora.org> <CALiNf28PQFtAM6uZVPhh-_ASnYeeAtm8kWpP0b8k_P6zGwxbcQ@mail.gmail.com>
In-Reply-To: <CALiNf28PQFtAM6uZVPhh-_ASnYeeAtm8kWpP0b8k_P6zGwxbcQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 28 May 2019 10:32:25 +0800
Message-ID: <CANMq1KDgafzxyVc6H6i0OtKW32T2mpMSp4di81qNChDv-5RBKw@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: add support for firmware crash recovery on
 SDIO chip
To:     Claire Chang <tientzu@google.com>
Cc:     Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change to the interrupt handler since v1 sounds good to me.

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

On Thu, May 23, 2019 at 4:53 PM Claire Chang <tientzu@google.com> wrote:
>
> Tested-by: Claire Chang <tientzu@chromium.org>
