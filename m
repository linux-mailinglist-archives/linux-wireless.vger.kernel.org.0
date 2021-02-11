Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13DA319483
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 21:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBKUbR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 15:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBKUbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 15:31:15 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814BC061574
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 12:30:35 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id l23so6386945otn.10
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 12:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seY9jQrIhwxdy16d00IF4zutM9CHG8sdW3Pm+wZ44qA=;
        b=Y4djpH27l7H2T/tCMTp/6XTtHWboJMARiQ7k9nNNy/VPyFDCKbFGEHVlAK7Oxi2mRF
         bFIWZLp37HshqadU8LjWCZHB6BKyNw2XFFC/QDwzMlH0NRrlPsb5GjvoFXH3seyoAVet
         nl+RZ+T1murNub8nnNWWUu4tLZvQdgJa0mHgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seY9jQrIhwxdy16d00IF4zutM9CHG8sdW3Pm+wZ44qA=;
        b=VYoygksb5JVfYadBzUVQIvtsR71DkuwYfmOqwz4i/4ZrECAxYAeOGqaJSlnFgdSvQW
         oIXSyfOWj3yLplZnvEAQmzdYKbYsrKkBUOz9DP6GxnQZdt34fZ+YBwwNsPWo9CxBtDab
         xfyJWlulEDg1OjRn679o3TOZVuGy3SOPynxaMG+ArcAphaE51k6UKGVMhyrYwIL9K8cN
         O7vQtf26SLAzCT31DbNAi3xTNHnd3DyyfPq6q/Dr7gGTCJ9lJQhb4gc1w1hi0gbmCpsG
         hBZuWsed4oJsWhs1Dr3IIexlVoOFObIfUu5jrnNnTjJMZOWK50kR1hND6FM2nxD4/E4r
         +YBg==
X-Gm-Message-State: AOAM530I1EuW/n0h6mvnrcuQVMSkJHC8K/7fkMN5V7Ui7ousVargGdlW
        QmwcoNcKkPShT2yaiPRk40OakmJMk7l29Q==
X-Google-Smtp-Source: ABdhPJzUMtnkYGAbmloHlXz7ETBmFCWIPALW5CylP5UN5TMcbMP/Ez/PRNTHJM28Cs98BEeA/Pe7rA==
X-Received: by 2002:a9d:6ac3:: with SMTP id m3mr6987846otq.52.1613075433913;
        Thu, 11 Feb 2021 12:30:33 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id z30sm1239605otj.61.2021.02.11.12.30.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 12:30:32 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id d7so6405306otq.6
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 12:30:32 -0800 (PST)
X-Received: by 2002:a9d:6ac5:: with SMTP id m5mr6998379otq.365.1613075432196;
 Thu, 11 Feb 2021 12:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20210115092405.8081-1-pkshih@realtek.com> <20210115092405.8081-4-pkshih@realtek.com>
 <CA+ASDXPtwyZMByRDaAQv9b-DEBeRgPxpDz4+mCP-zi6P_-zr7w@mail.gmail.com>
 <d84e1a2c0d8e481588eec7248abf5c1a@realtek.com> <CA+ASDXM7e4eSiJNoVMES7=mZ3M-NGpVZ9jLbjNm4yqMSYH4r+Q@mail.gmail.com>
 <e8e451faf35e47b494f6d49fe92d1858@realtek.com> <1612855085.8436.15.camel@realtek.com>
In-Reply-To: <1612855085.8436.15.camel@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 11 Feb 2021 12:30:21 -0800
X-Gmail-Original-Message-ID: <CA+ASDXO6ASrx1JiNo22HkOVsECw6J9++snqeGGpUiNz3OBg+Cw@mail.gmail.com>
Message-ID: <CA+ASDXO6ASrx1JiNo22HkOVsECw6J9++snqeGGpUiNz3OBg+Cw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] rtw88: add napi support
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Bernie Huang <phhuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 8, 2021 at 11:19 PM Pkshih <pkshih@realtek.com> wrote:
> Then, I have another simple thinking -- enable NAPI only if interrupt is
> enabled. Other operations with RX ring are working only if interrupt is
> disabled. So, we don't need a lock to protect RX ring at all.

That makes more sense; thanks for the update.

> The irq_lock is still used to protect TX ring/queue, and now it also used
> to protect switching IMR. Some comments are added to describe about this.
>
> Above is implemented in v5.

I've taken a brief look, and that looks better. I'll likely provide my
Reviewed-by there.

Thanks,
Brian
