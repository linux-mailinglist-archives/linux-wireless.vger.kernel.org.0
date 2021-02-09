Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488A1315746
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 21:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhBIT4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 14:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhBITq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 14:46:58 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52FDC061A2D
        for <linux-wireless@vger.kernel.org>; Tue,  9 Feb 2021 11:35:21 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id l3so10728553oii.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Feb 2021 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imaDHBwrWHrUd/4hjqmb301LjKtIq5cfc5kt3uXuSxk=;
        b=C7eKAiokkWt6A7HOHS9gByMMufBWqEk5MDfnpZ2L3ebZPxCjbiXireg24UpiAqxW14
         kwX6SfH6aenZPjflM/lk393VBAtv7gTfb7a2oFXkTE3iXIQVcyEntqxU2/igjvxoa12B
         h86Q9fXmLifDCjJzEORBTGjhhi6oJjCxIQqCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imaDHBwrWHrUd/4hjqmb301LjKtIq5cfc5kt3uXuSxk=;
        b=LTFMll9GRySHQnqZN1OFkrSBdwhCQ5TDgFsWFZ+RQXC14ItGlg+Oe+ShPsWSAR9ZST
         9rUOXG4WXC7t7bt3/eMqaFE0jgSLtmEgaCcUP26sT+jX1hfelB9DEcPVtI39Kn0JYLr0
         A9SKbM2pNroDCYXMkUAUSbZ5G2vSBYMDmdBigp3xNIubwOgnyqwNS47OrhHHiTRQ/DGU
         Wh/qUvzBCL0Th+XkXK4U+yOQEW0Y5QRyRyVrL1TRKo2H7PZNiQaFmWOMSIsS0rZ7ZjVt
         IqdXj7Pm4zFDxcjH20u8YLF17swlyVjuXWeiqmt+b/yICKlfKRHhbK5TLVE0Kuj2IU9N
         JP3w==
X-Gm-Message-State: AOAM532IaUFOmw/zBtUa1XgTVxYe2R7knO3elk30YyKtBRNaoR8stldR
        06dq9+9PA2+h3Le/5E8XfHVBTUm/W0WVnw==
X-Google-Smtp-Source: ABdhPJwXYsGcqWgRUU4AYRDu2y+L7/Qd6K5xg3VGOVIWGfWdvyt4XcAg3EgT9yFveuhCbrHhto9/Cg==
X-Received: by 2002:aca:b788:: with SMTP id h130mr3389674oif.62.1612899320635;
        Tue, 09 Feb 2021 11:35:20 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id s123sm4442720oos.3.2021.02.09.11.35.19
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:35:19 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id k25so20649004oik.13
        for <linux-wireless@vger.kernel.org>; Tue, 09 Feb 2021 11:35:19 -0800 (PST)
X-Received: by 2002:aca:43c3:: with SMTP id q186mr3465463oia.77.1612899319280;
 Tue, 09 Feb 2021 11:35:19 -0800 (PST)
MIME-Version: 1.0
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 9 Feb 2021 11:35:07 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com>
Message-ID: <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for large
 buffer size
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Steven Rostedt

Hi Wen,

(Trimming down the description a bit:)

On Mon, Feb 8, 2021 at 6:59 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> Kernel panic every time in kernel when running below case:
> steps:
> 1. connect to an AP with good signal strength
> 2. echo 0x7f > /sys/kernel/debug/ieee80211/phy0/ath10k/pktlog_filter
> 3. echo 0xffff 0 > /sys/kernel/debug/ieee80211/phy0/ath10k/fw_dbglog
> 4. echo 0 > /sys/module/ath10k_core/parameters/debug_mask
> 5. sudo trace-cmd record  -e ath10k
> 6. run "iperf -c 192.168.1.1 -u -b 100m -i 1 -t 30"
> 7. kernel panic immeditely
>
> It always crash at trace_event_raw_event_ath10k_xxx, below is 2 sample:
...
> The value of prog in filter_match_preds of kernel/trace/trace_events_filter.c
> is overwrite to the content of the UDP packets's content like this
> 0x0039383736353433, it is a invalid address, so crash.
...
> ath10k_htc_send_bundle_skbs allocate skb with size 49792(1556*32), it
> is bigger than PAGE_SIZE which is normally 4096, then ath10k_sdio_write
> call ath10k_dbg_dump to trace the large size skb and corrupt the trace
> data of tracing and lead crash. When disable the TX bundle of SDIO, it
> does not crash, but TX bundle is for improve throughput, so it is enabled
> by default. It is useless to call ath10k_dbg_dump to trace the large
> bundled skb, so this patch trace the top part of large bundled skb.
...
> trace_event_raw_event_ath10k_log_dbg_dump is generated by compiler, it
> call trace_event_buffer_reserve got get a struct pointer *entry, its
> type is trace_event_raw_ath10k_log_dbg_dump which is also generated by
> compiler, trace_event_buffer_reserve of kernel/trace/trace_events.c
> call trace_event_buffer_lock_reserve to get ring_buffer_event.
>
> In function trace_event_buffer_lock_reserve of kernel/trace/trace.c,
> the ring_buffer_time_stamp_abs is false and trace_file->flags is 0x40b
> which is set bit of EVENT_FILE_FL_FILTERED by debugging, so it use the
> temp buffer this_cpu_read(trace_buffered_event), and the buffer size
> is 1 page size which allocatee in trace_buffered_event_enable by
> alloc_pages_node, and then ath10k pass the buffer size > 1 page trigger
> overflow and crash.
>
> Based on upper test, try and debugging, pass large buff size to function
> trace_ath10k_log_dbg_dump cause crash, and it has ath10k_dbg in
> ath10k_sdio_write to print the length of skb/buffer, it is not necessary
> to trace all content of the large skb.

Is this the same issue noted in this thread?

[for-next][PATCH 2/2] tracing: Use temp buffer when filtering events
https://lore.kernel.org/lkml/f16b14066317f6a926b6636df6974966@codeaurora.org/

It seems like we should still try to get that fixed somehow, even if
the below change is fine on its own (it probably doesn't make sense to
such a large amount of data via tracepoints). It would be unfortunate
for next poor soul to hit the same issues, just because they wanted to
dump a few KB.

Brian

>  drivers/net/wireless/ath/ath10k/debug.c | 2 +-
>  drivers/net/wireless/ath/ath10k/debug.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
> index e8250a665433..5433dbdde0e5 100644
> --- a/drivers/net/wireless/ath/ath10k/debug.c
> +++ b/drivers/net/wireless/ath/ath10k/debug.c
> @@ -2718,7 +2718,7 @@ void ath10k_dbg_dump(struct ath10k *ar,
>
>         /* tracing code doesn't like null strings :/ */
>         trace_ath10k_log_dbg_dump(ar, msg ? msg : "", prefix ? prefix : "",
> -                                 buf, len);
> +                                 buf, min_t(size_t, len, ATH10K_LOG_DUMP_MAX));
>  }
>  EXPORT_SYMBOL(ath10k_dbg_dump);
>
> diff --git a/drivers/net/wireless/ath/ath10k/debug.h b/drivers/net/wireless/ath/ath10k/debug.h
> index 997c1c80aba7..cec9ba92f28f 100644
> --- a/drivers/net/wireless/ath/ath10k/debug.h
> +++ b/drivers/net/wireless/ath/ath10k/debug.h
> @@ -11,6 +11,8 @@
>  #include <linux/types.h>
>  #include "trace.h"
>
> +#define ATH10K_LOG_DUMP_MAX 1024
> +
>  enum ath10k_debug_mask {
>         ATH10K_DBG_PCI          = 0x00000001,
>         ATH10K_DBG_WMI          = 0x00000002,
> --
> 2.23.0
>
>
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
