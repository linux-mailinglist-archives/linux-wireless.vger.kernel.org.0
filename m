Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A738DDA3AD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 04:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404279AbfJQC0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 22:26:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38030 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJQC0a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 22:26:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so1316709qta.5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 19:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYYIz0DpXt+S96zKsPkYJbopZGRxz9flW9WuWLOogaQ=;
        b=DPl0z3hlFDrtFfUjhG/QNSp37MnO5lnNjz+RDVaYKEe9dx44OSQaiUs6jPgU1mlu+d
         GQCin+43NLsVlgi9RzYf+tI/v8b9tJjEPefiv3E2pYhpEp/PDLCDXOXBc48gTlgbGATs
         0ZDFck9LGWXjDpiuxxN/KMfjk2ALdUgI6P2xLFRdBBCRKSkvrBWX7rxWV4d6qXRxf9Un
         z2b5jV5twiUT24rOl6BJCgI1A0bAXsL8BSPuzwFH2MSOD2QVZaGw6E8KNPIHMd+IFlV4
         mJ+1OEqgH/WqxY7vxSTcY4bGsgAVXkaOtc/BstJ24QyN0sm7QAWaa926M5fJWb3OLiC5
         Dd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYYIz0DpXt+S96zKsPkYJbopZGRxz9flW9WuWLOogaQ=;
        b=sAroaHk7wY4ReK0AmEOjAoZd7fgrXoNhXpyQT36GrdsKbegYF2NMRSn/ANzekEffpq
         LVrFv5hkWrkiM+dXxH4KxCNFyk2KbVe0IE+0WFy0PyM/RtdWrqRRMC7jtcqH8p0lQHqX
         F2hbWjnZQwnR/2HypBEh3IpvXoH9ynHLAl5MrZrcXlz68029FtwAz0OdOO/ngl9VhclB
         GY6r751eQnvfybrXbEUXMM5FFZbrIOnRnBMgd3SgDL4Ij3uG2/1cSi25mlF6pX5VAxsa
         j2+Ku4NGALzOyO/sTHFtg9v1/8SE3s7s1d105OEWadQm5w96qUYkUpBKC+w0nJOX4geP
         9Mdw==
X-Gm-Message-State: APjAAAV+KKgLYND1TJ0hcTwCVPBOx9lYBWGKVChmagnI/i4WmQjkjyGq
        AqKh81jDwezyCf23fvR3/ldJ0zKM6JEuWSn6+loq7Q==
X-Google-Smtp-Source: APXvYqyQj2ZLctUSSL3V9JNUsWb05JdfRipaPfh6FHbT8hGhFaGCyPxwpFtBc+PUDLv4I6g5Tcjv2ImmCdkpX+suV3c=
X-Received: by 2002:a0c:c792:: with SMTP id k18mr1397138qvj.154.1571279189073;
 Wed, 16 Oct 2019 19:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191016015408.11091-1-chiu@endlessm.com>
In-Reply-To: <20191016015408.11091-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 17 Oct 2019 10:26:18 +0800
Message-ID: <CAB4CAwen5y7Z4GU7YgpVafyGexxaMDLzrZ949t9p+LiZ9TxAPA@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: fix RTL8723BU connection failure issue after
 warm reboot
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 16, 2019 at 9:54 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> The RTL8723BU has problems connecting to AP after each warm reboot.
> Sometimes it returns no scan result, and in most cases, it fails
> the authentication for unknown reason. However, it works totally
> fine after cold reboot.
>
> Compare the value of register SYS_CR and SYS_CLK_MAC_CLK_ENABLE
> for cold reboot and warm reboot, the registers imply that the MAC
> is already powered and thus some procedures are skipped during
> driver initialization. Double checked the vendor driver, it reads
> the SYS_CR and SYS_CLK_MAC_CLK_ENABLE also but doesn't skip any
> during initialization based on them. This commit only tells the
> RTL8723BU to do full initialization without checking MAC status.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>

Sorry, I forgot to add Jes.

Chris
> ---
>
> Note:
>   v2: fix typo of commit message
>
>
