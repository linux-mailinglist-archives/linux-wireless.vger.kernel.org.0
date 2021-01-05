Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657E52EAC0F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbhAENl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 08:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbhAENl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 08:41:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05EAC061574
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jan 2021 05:40:48 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d9so28235769iob.6
        for <linux-wireless@vger.kernel.org>; Tue, 05 Jan 2021 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BHYk/pxYuqWXtTS9o1tJecF0BRYBednBn4aqWon7MRE=;
        b=f45oT3TphGOdr13Q5wNcfJtNJEyemKPHqdZ0QKbP3LMm2FvCwGtgWCli2+NOCGJyKb
         qxl3SASdQ2nYpXM9GQ7kaUARSRBmBnDwlZQFyvKmcaCugRd6gnC55Ivhe1q5tp9hrUb2
         V0TEFrFiMO+ePI9mxx6Y9LZXN6/J6DpI5MQaNCF65/nOT9nqFhpnAxkk6aJJb6dEC5Eq
         5tgnl9i+5hTf7lFIxJpWf99l4p2sgGcVxuCWcafu7oMh44lCkz1Jw7qcnAbbnSrqcke6
         BKMHiUk5jY2vCM5Cy7ACEmk6ILMFEGbNnUx2bia9liAdJjLaigGs4RDjLCXsUiPCLq7Z
         Nh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BHYk/pxYuqWXtTS9o1tJecF0BRYBednBn4aqWon7MRE=;
        b=T3ENWG8pXdLdid7Sjdea+U3i5s5eVeBdOJvoaYFkJbFPt5NTW6gcGb1vtgnKhHIcX8
         u+g2E9KDG1otW20R8StPjJqqgfcUVmgtR91DlofsW3OFhPV3jPnWaqTwoP1ADEdQQfFJ
         YKJT7yMtASABolDQm+35qq8BEVtoP08GU9e8V+pGSZqljcRHD6KE1V4bvTxgd3k+s3My
         sYCpmNB9waiWhn/6Kk4SfkkLpK4ru2q3CxSxfzvMfyw0R4Zyq2h+elSEsQOOnLTeZ0gD
         Y8P+Znrhaq7H2TXzur8DN96TeHNW+qhzEpbnYYUS2gEyfmX027OBs1x5qZ+tQ49v3OlB
         I0eA==
X-Gm-Message-State: AOAM531Pk7UioC9D6lEuJWMpo4aixJXd+epkGE3+MR1jIuowe8/I3+fW
        vfM2zP3NjaMiEfYBsptx75XFka+hRzpc97f10Tulb8pj0ug=
X-Google-Smtp-Source: ABdhPJwq7X8S7MO/f/miviSdav6uUhMpS9nxePG0fjQ0N/eZXkPfF9K/QkEl8ceH1xFLD+W74C85AbuZgG2uR6WEwqw=
X-Received: by 2002:a6b:92c4:: with SMTP id u187mr61812978iod.57.1609854047932;
 Tue, 05 Jan 2021 05:40:47 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
 <CA+icZUUM8cPUvwVRFqodZxNs=4pVaBJGCWu6mL=9T5tym_OmeA@mail.gmail.com>
In-Reply-To: <CA+icZUUM8cPUvwVRFqodZxNs=4pVaBJGCWu6mL=9T5tym_OmeA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 5 Jan 2021 14:40:36 +0100
Message-ID: <CA+icZUX7+bOgqPTtwNjXO4PCvjAm9T7akWvDxV47QPMR2auiSQ@mail.gmail.com>
Subject: Re: wireless wiki: ath11k missing in drivers page
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 3, 2021 at 1:50 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> recently someone asked about issues with ath11k devices.
>
> So, I checked the wireless wiki pages.
>
> In the drivers overview [1] ath10k is listed and linked [2] but not ath11k.
> Smart enough I found [3].
>
> Can you or someone else add the link to athk11 in [1]?
>
> Thanks.
>
> Regards,
> - Sedat -
>
> [1] https://wireless.wiki.kernel.org/en/users/drivers
> [2] https://wireless.wiki.kernel.org/en/users/drivers/ath10k
> [3] https://wireless.wiki.kernel.org/en/users/drivers/ath11k

Thanks to whomever fixed the drivers overview page.

- sed@ -
