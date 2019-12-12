Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC311D096
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 16:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfLLPLd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 10:11:33 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43559 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfLLPLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 10:11:33 -0500
Received: by mail-ot1-f50.google.com with SMTP id p8so2296858oth.10
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIhIS2YRgmUMObqWxEWVGA4aACRsODuzv8jQKXYM0Rg=;
        b=KLHrpDMbmnM81Q4xUZEG5d3l2uH6WXOvotUm+GFFDLPgzTXjQcGWpSLwq/gBKO1nxC
         z050ENWHsjL9MnzFu+svtP7MvZI1D0Hnxzagle755XHKlgdAIc3Z/nC8SL0M7m9dU9AW
         BOgrfbmIWScHGcA88UbThBiFxJJLMKUYUbNGcEt9C8HTwOVM62sYL4fkzg98Pyr9JwBM
         RPdDhVzu5STJxJOBr1TDvEoPgFRxdhTFo43PEL57Vv6hp4Ps3fh87Kt+/UnyFkClbnWL
         Eincvd+SSSUiDRdk1peT+d4JFk8HyrcqAhOHKmP0BBl99JRFfsS0ZXO0YUWsR9r8/X0q
         Xc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIhIS2YRgmUMObqWxEWVGA4aACRsODuzv8jQKXYM0Rg=;
        b=NwESLSgCnMvnxDyKxR0eC7pUakfKD0pGL2x5DsBfxQJDJO8d+1vlJ6u9vpuZBm3set
         nYB7/jW145nOBpf6ypP6S1RwTWdT1Bevm+FGX3+WtFRtaJsPSm2mxq6n2V4zPcbYh2it
         jdyAzBUkjQJI6p4n2Y8diM2n5utwGrqBoTQqqog4Gk2N3bBT/14InYNOV+ptNBnj3m1i
         6DFUV+vUePAGmLIkdI/id7IQho/SBIYbLqmxG88YQztG2kDcZHEPWh7msZB1jVUW7T1R
         1DOF4jU18G8YOBDFuH6zsECMqO0BaNaJoDBwPc01+nuCrLbOpL8Hg/uHhqvvMFKPnL6u
         uK2A==
X-Gm-Message-State: APjAAAVEVleIBKqgryFvHJHsuT8YV38xY8ZpFAEkWogGrMuRuKCvwkUx
        YjXkaw8xbSrT4EpxMh3Gaj6O9iv8YhZtsx9bWOTKwg==
X-Google-Smtp-Source: APXvYqxy+6Sljwk7iFfOaKx/1+V4f5mtJq5yy/t6TSwXFxYoJS86rUxJqzrstDSC4Q6jeoGnMBriYVzN5yyFeM0koTU=
X-Received: by 2002:a9d:624e:: with SMTP id i14mr8755970otk.371.1576163491195;
 Thu, 12 Dec 2019 07:11:31 -0800 (PST)
MIME-Version: 1.0
References: <14cedbb9300f887fecc399ebcdb70c153955f876.camel@sipsolutions.net>
In-Reply-To: <14cedbb9300f887fecc399ebcdb70c153955f876.camel@sipsolutions.net>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Thu, 12 Dec 2019 10:11:14 -0500
Message-ID: <CADVnQym_CNktZ917q0-9dVY9dhtiJVRRotGTrPNdZUpkjd3vyw@mail.gmail.com>
Subject: Re: debugging TCP stalls on high-speed wifi
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 12, 2019 at 9:50 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> If you have any thoughts on this, I'd appreciate it.

Thanks for the detailed report!

I was curious:

o What's the sender's qdisc configuration?

o Would you be able to log periodic dumps (e.g. every 50ms or 100ms)
of the test connection using a recent "ss" binary and "ss -tinm", to
hopefully get a sense of buffer parameters, and whether the flow in
these cases is being cwnd-limited, pacing-limited,
send-buffer-limited, or receive-window-limited?

o Would you be able to share a headers-only tcpdump pcap trace?

thanks,
neal
