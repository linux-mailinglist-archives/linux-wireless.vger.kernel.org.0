Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0A63198EC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 04:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhBLDpj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 22:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhBLDpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 22:45:38 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEEDC061574
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 19:44:58 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id k10so7287906otl.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 19:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4SDy/3FUZQaQWYaudQGkVl4Fs4MFq5b1IZKtVmijUM=;
        b=ei+BFKKaLh6pNi9JSxtd8Tmd06eM+Hpa3ndQ3I73D4xZG2qKWiLSQGGyv1c2cQfbIX
         piRwV3aUseMXN3EZM05LlmpDmuPqj37/AADgophw7MD7GG4Z84in5XkhTZx2mh1ZUQHl
         hP6mtQ9dbXVWcvP3cK56EupTnSscpZDZ4hqBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4SDy/3FUZQaQWYaudQGkVl4Fs4MFq5b1IZKtVmijUM=;
        b=iMLNT9vQRFZDp7JhrhQKj5jF6FS6w2y2p0NFwO9TsaK/Fpg8baPxW0bIJqmPV1Q2I+
         n4nZkazRRszDioZpcQMj6FR+JEWoDoiX4xfhu64oVUdTdTtEfHpmhp791fnIy2ggcGcY
         hyeqhpv/+sm+04uHvCUf/oBNiklZe2VVXWAViFTSEgcy8ijHOab1ryIhr6PS5aKn8Ybg
         c3ebIMXI4RlxU1eEXIGeWzsUwQzenJuq7V0ff4ictyNFGZftUuQAzG8KirqsDb3NfxPf
         BsUC+UP8RofH2x4bu8osFP/zicxxacIJOjhSYntAUks2bwFU6+DBhA3WWwtIPszfL1Q0
         7FoQ==
X-Gm-Message-State: AOAM531HXGXhXUJDUL56yv2fV8cWBRm6G9vWIA5ZfcJF0EmKiZwv09Mz
        u8Pz54+ctQ43ijDtcdXYyE9Pl4IKKUgq8g==
X-Google-Smtp-Source: ABdhPJzo+NqmTPDA29vbMpOpmjs2lWCIem7FoByBfDV4/9llKQ7QAp4SbN7RQUNG4SgHG2t15CzyaQ==
X-Received: by 2002:a05:6830:1f4e:: with SMTP id u14mr761534oth.65.1613101497093;
        Thu, 11 Feb 2021 19:44:57 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id l133sm1572126oia.37.2021.02.11.19.44.56
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 19:44:56 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id l23so7251306otn.10
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 19:44:56 -0800 (PST)
X-Received: by 2002:a9d:3d76:: with SMTP id a109mr767748otc.203.1613101495918;
 Thu, 11 Feb 2021 19:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20210209070755.23019-1-pkshih@realtek.com> <20210209070755.23019-4-pkshih@realtek.com>
In-Reply-To: <20210209070755.23019-4-pkshih@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 11 Feb 2021 19:44:43 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN_TgaHvbthz-SqHdjrmRHVpEag9+sQWkGcivNFv94GAA@mail.gmail.com>
Message-ID: <CA+ASDXN_TgaHvbthz-SqHdjrmRHVpEag9+sQWkGcivNFv94GAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] rtw88: add napi support
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bernie Huang <phhuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 8, 2021 at 11:11 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> From: Po-Hao Huang <phhuang@realtek.com>
>
> Use napi to reduce overhead on rx interrupts.
>
> Driver used to interrupt kernel for every Rx packet, this could
> affect both system and network performance. NAPI is a mechanism that
> uses polling when processing huge amount of traffic, by doing this
> the number of interrupts can be decreased.
>
> Network performance can also benefit from this patch. Since TCP
> connection is bidirectional and acks are required for every several
> packets. These ack packets occupie the PCI bus bandwidth and could
> lead to performance degradation.
>
> When napi is used, GRO receive is enabled by default in the mac80211
> stack. So mac80211 won't pass every RX TCP packets to the kernel TCP
> network stack immediately. Instead an aggregated large length TCP packet
> will be delivered.
>
> This reduces the tx acks sent and gains rx performance. After the patch,
> the Rx throughput increases about 25Mbps in 11ac.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I think this version handles my review comments and straightens up the
locking situation:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

Thanks.
