Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6150372343
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 00:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhECW4o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 May 2021 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECW4n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 May 2021 18:56:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D12C061574
        for <linux-wireless@vger.kernel.org>; Mon,  3 May 2021 15:55:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 103-20020a9d0d700000b02902a5baf33f37so6143023oti.9
        for <linux-wireless@vger.kernel.org>; Mon, 03 May 2021 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iT5x1as+DLwE/KguiyzaXbBWSEHmVP8LZcgrJns3rms=;
        b=LzhWsYynIXFFNZ2wVzM+CsUFTOBLsXQou5L9NF8AYzP1E4dtyOq0nx2taIhTIFSuUO
         pIaFaKSKxL+aZ6cghoZSA3wfPX3GjbuyIYjwP93o7uaIC3LSJz3nhnPkMgr+JwWxkf/v
         Vi6uxiDHOIVJBnl+XWOpmNUp9gIm/2jB4Mlz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iT5x1as+DLwE/KguiyzaXbBWSEHmVP8LZcgrJns3rms=;
        b=UFUdQPqm5E62Qp4x9y2L5M//LPr3p8eHU7b4987ipJsNeaOLjcQRY4NqO29qvfw8n5
         YXluTpYJGoSlNk2F3AGB0jgqGIG9F+E2bKghmcwKS3eG+i5V9Im0/mfPQKLLwamh4SmF
         mGI9rqik2M4X2RuDngZJ/FF8KJpLqd7O3zbMyKpHhZAQdGDgpkNoR58K28zTytbqQ2/8
         54V/AuAkU80eQJ568T2Coe/XHQCx81N/cLFZ0wpg1eXASrYm0bO2o2s46qlTfxg2fP9j
         L95vcbh2iyn4x9W0bmu9AmXYyTR91fxfAH9dhuq2Acb7M6LqTGtRT36WeO7EZkrGQIer
         etWg==
X-Gm-Message-State: AOAM533AT3bB2lzgccjpinzYo0+cPOU/YTloZ59BtvPcSVp4O5gtjQr7
        R+GB3iHENX4/SB07cTx22DWy4oscq78rPg==
X-Google-Smtp-Source: ABdhPJwYh0lotNcs/MxJ0DaEzxa4uCqhyrDMwxqkWIkrnhN2hxlZSXtwXNOLbhzNxD6i+uYERiGTjQ==
X-Received: by 2002:a05:6830:2336:: with SMTP id q22mr17062492otg.346.1620082547816;
        Mon, 03 May 2021 15:55:47 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 21sm317185otg.4.2021.05.03.15.55.46
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 15:55:46 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso6607867otv.6
        for <linux-wireless@vger.kernel.org>; Mon, 03 May 2021 15:55:46 -0700 (PDT)
X-Received: by 2002:a05:6830:1bd8:: with SMTP id v24mr5731199ota.203.1620082546348;
 Mon, 03 May 2021 15:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210309060121.9099-1-pkshih@realtek.com>
In-Reply-To: <20210309060121.9099-1-pkshih@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 3 May 2021 15:55:36 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO1Eh0D3k4ssCqgymgbonNf0RVNy=AxpnzLO6+Ch5=hWQ@mail.gmail.com>
Message-ID: <CA+ASDXO1Eh0D3k4ssCqgymgbonNf0RVNy=AxpnzLO6+Ch5=hWQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: 8822c: support FW crash dump when FW crash
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        kevin_yang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Mar 8, 2021 at 10:02 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
> Although FW crash logs are already supported for dumping in driver, the
> logs may not be sufficient to analyze field issues. To improve this part,
> we add a support to dump FW memory.
>
> When driver receives FW crash notifications, driver uses DDMA, which is a
> HW ability, to copy specified FW memory to FW fifo. Driver can then dump
> these information from FW fifo. With this support, not only FW crash log
> but also specified FW memory will be dumped while FW crash. Besides,
> specified registers are also dumped.
>
> This feature is implemeted on 8822C first due to difference of FW layouts
> between ICs. In addition, we add a debugfs to trigger FW crash. It can
> simulate the process of crash, dump and reset. Through it, we can also
> check if a reset is ongoing.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
...
> +int rtw_dump_fw(struct rtw_dev *rtwdev, const u32 ocp_src, u32 size,
> +               const char *prefix_str)
> +{
...
> +       print_hex_dump(KERN_ERR, prefix_str, DUMP_PREFIX_OFFSET, 16, 1,
> +                      buf, done_size, true);
> +
> +exit:
> +       vfree(buf);
> +       return ret;
> +}
> +EXPORT_SYMBOL(rtw_dump_fw);
> +
> +int rtw_dump_reg(struct rtw_dev *rtwdev, const u32 addr, const u32 size,
> +                const char *prefix_str)
> +{
....
> +       print_hex_dump(KERN_ERR, prefix_str, DUMP_PREFIX_OFFSET, 16, 4, buf,
> +                      size, true);
> +
> +       vfree(buf);
> +       return 0;
> +}


For the record, all this print_hex_dump() stuff should just be using
devcoredump instead. There are numerous problems with dumping this
much unreadable (and opaque to anyone but Realtek) garbage directly
into the kernel logs.

My bad for not reviewing this earlier. With luck, Realtek will add
devcoredump themselves, although I suppose it wouldn't be too hard for
a drive-by contributor (e.g., me) to fix, given the time...

Brian
