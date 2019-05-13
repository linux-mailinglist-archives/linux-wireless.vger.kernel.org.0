Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0101D1BBDF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfEMR0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 13:26:21 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44987 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbfEMR0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 13:26:21 -0400
Received: by mail-pf1-f173.google.com with SMTP id g9so7540881pfo.11
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfEQg2/4Lo4syLQP4Lsd9Ax1nY9ZYwEa3f/LsUKcLcM=;
        b=fYt7cXZ2ME/dKOC//KsjBDEjtAXXZKUvbDYF4UP7SGD0IBgqq3XYjOrDlbP3zNk3pE
         QBDlgzWrfj7EqvfwGWQY3vMl2oGxHAZzcjKDXu8mi4Kc0F94ceS7hEdLYlAaWOsMAOur
         zkmAIYOkBVX/jZs4Phh0EMkQM6NDBu34Jy1H1ZkXUxa+qYPSD4L4HM/LJrYwup/bzV0q
         0R05k9g8VwjEqCKEHGoWFIGLbWpruOEykO1JvL1qaIsasvHrawhhnepbD4FFtu38n7wZ
         30Oef5COj/1VE9bc/D7GmPtHux/CxMVGCG0sdr5Tl8OgZL9Sa2qdlIaSUsgw8mFTTY9W
         tDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfEQg2/4Lo4syLQP4Lsd9Ax1nY9ZYwEa3f/LsUKcLcM=;
        b=W1QwpxS4NyjEScpIPFt+8MTjvzD11f+5kkG0/oUvQRx36GVYxTdvXD/JDSO0JucTC6
         62cSfLBfwKYs4fuF4OYaanL47u7wP3o58esEUIBrkr6IpUqUYmsIWhkr0/x2LCLwdN9N
         PGGlxmkqB9D56E9OtjCQiLIh4T69kBDJ826b6GU+RRrcobBAndiqbDo9ZiY8Al/eKVu0
         cUtbPhAVk+TipMIfd6QEZEws9sbLme28+E/LEeMMn+Sdb/ndLG/+2sirPj/iSwlrazI0
         9pwmJbApf8V6I7VM/iMVy5JJOfvuyprnSb/wKWKoVbiKPZJE87OzHAb+fpwCFjD0wBtO
         HJxA==
X-Gm-Message-State: APjAAAVyOjvczsP1qJpo0JEsYDF0JE/98aO9Eem4iVZZk7CwTNwko+fv
        vfqkAbSir0WnhCE13cMBICB2oPCXiHNna24uMqEynh3QAw==
X-Google-Smtp-Source: APXvYqzpIC6BmQk0bj/Ru4tBrsx/mBIfHeU4iW/tYbky1Nm+FMUCblSyf5MQ9U8lBshOPXsxk0aLbNxfb4BXrtGdZOU=
X-Received: by 2002:a63:c64c:: with SMTP id x12mr32561842pgg.379.1557768380953;
 Mon, 13 May 2019 10:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGJ1o_KskiCKQ8V-6U0nxWGgXXa4NWHV0EEwo41bMPSj1bbdg@mail.gmail.com>
 <CAPGJ1o9qDYPQF882cw65uysjCmUYi6kJCmL2EUa0AXbwHj59Mg@mail.gmail.com> <a236cf47-556d-c515-0093-82dce6e8ad8e@candelatech.com>
In-Reply-To: <a236cf47-556d-c515-0093-82dce6e8ad8e@candelatech.com>
From:   Sam Samy <to.swami1@gmail.com>
Date:   Mon, 13 May 2019 10:26:09 -0700
Message-ID: <CAPGJ1o96QSfoFzFpSPbh_4TwSgAU-1FGhX6P5MVCmfZv_bugHw@mail.gmail.com>
Subject: Re: ath10k 5Ghz RSSI low
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hi Ben,

> Hello, what firmware are you using (ath10k-ct, or QCA?)  If using -ct firmware,
> please try QCA firmware and let me know if that fixes the problem.
>
  I tried both. Both have the same problem. I tried various versions
of the both(-ct and QCA) firmware as well. All have the same problem.

Thanks

On Mon, May 13, 2019 at 10:00 AM Ben Greear <greearb@candelatech.com> wrote:
>
> On 5/13/19 9:56 AM, Sam Samy wrote:
> >   Hi,
> >   I installed master branch openwrt onto Asus MAP-AC2200 AP. It has tri
> > band. Its based on IPQ4019 DK04 QCA reference platform. 2 radios
> > (2Ghz/5Ghz) on AHB bus and one 5GHZ on PCIe bus. Its generally working
> > fine except one problem in 5Ghz. On both the 5Ghz radios the RSSI is
> > pretty low on any channel I put it in.  In one feet range I see -60dB
> > RSSI, where as the stock firmware that came with the AP gives an RSSI
> > of -36dB at one foot distance.The downstream transmit rates are MCS8/9
> > for most part. The 2Ghz is working fine. Its using the cal data from
> > the flash that came with the AP.
> >
> >   Can you please suggest anyway to debug this or improve the RSSI?
> >
> >   Thanks you!
> >
>
> Hello, what firmware are you using (ath10k-ct, or QCA?)  If using -ct firmware,
> please try QCA firmware and let me know if that fixes the problem.
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
