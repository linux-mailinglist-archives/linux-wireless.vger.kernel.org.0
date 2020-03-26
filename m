Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7652194678
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgCZS2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 14:28:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43904 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgCZS2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 14:28:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id n20so5706991lfl.10
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FflzYEgbhccaMu2bSI41Ji/OUyYkwvZCdKXZhpVA39Y=;
        b=V4GPb6IJE7TmflEROR6+xsBXaynZ75EIMH8RWRpHHNfy8/LFLWC4S6nzX3Yf4jnxcA
         3FMWto1Ygoo/1sPzBI+FK5bmZReYCjdBj9NO98jhO8542PU9uQ57KoGksh/peeF+OVbB
         LMLLOmtHbErBoOZqWnIPiXeO7xbodZPUzOBIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FflzYEgbhccaMu2bSI41Ji/OUyYkwvZCdKXZhpVA39Y=;
        b=mOZHqbDphk8AXEoqWyWYo4iuLz93uQAYd+KyCB1WsviMf6gykw5xCxcFK9Cyh15OVq
         DkJKaFoV4mK2r3vX6WKlCZThko1FttCAPd2Fu8M+ds+mMniEiaXji+a4VIqfyE6o6Hn8
         LRTfdpKAi4XXpZEdu+NwqKr++XFaBZXJm76DY31FqtZ3i75lgZ4lfXsdxptmLLZDSw0w
         qdFjS9/4CKkFIFsjJbcyuepq+B7OXRAdYzgIvOuNsv1PoqCZ7bWDwxOB6IFvhWiR/ZPa
         NZvBuEM5+cPDk15Yl6Kh6YfUa/JZLrofleF3LRcstNzdR0G4xbQExQG9RiJ1YP7QoNX+
         rcbQ==
X-Gm-Message-State: ANhLgQ0tVbdG1X+a2i2nY1VOkwq8MQWRCSKgpOUQ4KmhLNBfeD4YJB/n
        0v+9+Zlx/9TGZuvjQ9/cFEZMQuNofj4=
X-Google-Smtp-Source: ADFU+vvRll4nc2ah45INCTM9IxyHwr+aT9Ch0ZE4m7PocRZXaX3JzMBYVXAGrM5lNSXy0jJu+oPydA==
X-Received: by 2002:ac2:50c7:: with SMTP id h7mr6713724lfm.101.1585247289062;
        Thu, 26 Mar 2020 11:28:09 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id e12sm2070904ljl.36.2020.03.26.11.28.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 11:28:07 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id q5so5713024lfb.13
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 11:28:07 -0700 (PDT)
X-Received: by 2002:a05:6512:50e:: with SMTP id o14mr6762113lfb.85.1585247287256;
 Thu, 26 Mar 2020 11:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200313065114.23433-1-yhchuang@realtek.com>
In-Reply-To: <20200313065114.23433-1-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 26 Mar 2020 11:27:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNZxBZxVxzdNLiOZKwoQyWB5Pph=AeMW5gJ4cmMKigKcg@mail.gmail.com>
Message-ID: <CA+ASDXNZxBZxVxzdNLiOZKwoQyWB5Pph=AeMW5gJ4cmMKigKcg@mail.gmail.com>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I know there's other discussion on this patch, related to nl80211 vs.
debugfs, but in case the discussion ends up permitting debugfs, I'll
put my review notes in.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

On Thu, Mar 12, 2020 at 11:51 PM <yhchuang@realtek.com> wrote:
> +static ssize_t rtw_debugfs_set_fix_rate(struct file *filp,
> +                                       const char __user *buffer,
> +                                       size_t count, loff_t *loff)
> +{
> +       struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
> +       struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
> +       struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
> +       struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +       u8 fix_rate;
> +       char tmp[32 + 1];
> +       int ret;
> +
> +       rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
> +
> +       ret = kstrtou8(tmp, 0, &fix_rate);
> +       if (ret) {
> +               rtw_warn(rtwdev, "invalid args, [rate]\n");

Seems like you don't actually need this print, as it doesn't provide
any additional data that you don't get through the return code. People
interacting with this debugfs interface will already see things like
"write error: Invalid argument" if they're handling write() errors
appropriately.

> +               return ret;
> +       }
> +
> +       dm_info->fix_rate = fix_rate;

It feels like you should do some real bounds checking here; as-is,
you're allowing anything in [DESC_RATE_MAX..0xff] to mean "disabled",
whereas it seems much more reasonable to specify a single value that
means "disabled". So you could do:

  if (fix_rate >= DESC_RATE_MAX && fix_rate != U8_MAX)
    return -EINVAL;

Brian

> +
> +       return count;
> +}
> +
