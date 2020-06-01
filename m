Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECD1E9C80
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 06:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgFAEYJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 00:24:09 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]:34437 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAEYI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 00:24:08 -0400
Received: by mail-qv1-f52.google.com with SMTP id fc4so135060qvb.1
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2020 21:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEgNxIXqPtmbg89bFCyQQcY4OfFh0TLKWX3E1EmaJUA=;
        b=qnqf7BYth4a4dt/3Gtnbt5XPwtlzJx+oxb6QF8fgbRZVY1YOeln44sRqjjTR5zO3aC
         8D/fvFLY7XWasBfkUuwMxSe2UNMZelSHgCmf2L8+OuIicYfnLO3hiVSO0nWEwVR6n3p4
         +XGTkitDImtYCgFEO0ndgXCTNyvGEAKw5GxvnRYPcXD9we46Zpv/iU2GojFkIbC4DX31
         HASFjXqS8vAmzlWOXvPCqoOYoISTzUumEHBHSl71Kr7uJOoPufk74YWKZr3VmaiszlkX
         0U2SB4PZb56IrpjZ21Rh3hlP0wt1dvRkOG2/hh65GCFPjJ3Xs9sacweEYf0EEzbU6cYT
         ZZDQ==
X-Gm-Message-State: AOAM533Gy+pp4qAKrF0PuLx45NMEiROr6oHKu4XR2gxDv5Esu0D0R9eR
        FV0h9x4AqmoHODTrhGye7jDFCxrYjdZQgbYBHr6edg==
X-Google-Smtp-Source: ABdhPJzKKxUJ0KnZ1BYVTA7YwCGBa2avQXMi+HbK1T5RTAxd1RVaBd+BACvF585b0jnMtHf413MGHRtBtlqgTPgHHxE=
X-Received: by 2002:ad4:5282:: with SMTP id v2mr18252962qvr.167.1590985447844;
 Sun, 31 May 2020 21:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <75f092e3-b667-341a-e810-61edd8f089ac@candelatech.com>
In-Reply-To: <75f092e3-b667-341a-e810-61edd8f089ac@candelatech.com>
From:   Adrian Chadd <adrian@freebsd.org>
Date:   Sun, 31 May 2020 21:23:55 -0700
Message-ID: <CAJ-Vmo=-w=mvKB8=8g+jn3sE6vwJLOfq0SarMpeJq8OdgMApuQ@mail.gmail.com>
Subject: Re: Un-recoverable ath10k 4019 NIC lockup.
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 27 May 2020 at 11:30, Ben Greear <greearb@candelatech.com> wrote:
>
> While doing a torture test on OpenWrt using ath10k-ct drivers/firmware, the 5Ghz AP fell off the
> air.  After debugging, I found this in the console logs.
>
> I am guessing that the only way to recover in this case would be to reboot, but in case someone else
> has ideas on additional ways to kick the 4019 chip to have it start responding again, please let me know.


Hm, i haven't looked at the Dakota datasheet in a while; does the
platform support or ath10k actually power off/on the core fully, or
just the RTC/MAC/PHY path?

Chances are there's a reset controller somewhere that lets you put the
bus and tensilia cores in reset..



-adrian
