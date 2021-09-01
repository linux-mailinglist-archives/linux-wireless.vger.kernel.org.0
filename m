Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC03FD3D4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbhIAGcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 02:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbhIAGcW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 02:32:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7AC0613C1
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 23:31:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v1so878502plo.10
        for <linux-wireless@vger.kernel.org>; Tue, 31 Aug 2021 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bpafk1X41xGK7MXDbJ4VMxRCE4Mzuv5uYTag/1eQibs=;
        b=E4pSGWJ/pCQWOPy/QHPIVscmiPk7GDQnP8Ckbq4SEJS3kYCdoDp/GzKpzTwPQP/lse
         LrpKqoqSyM2OpkcoSxmvISKxyhKrbt9a0eIF+jrjgtqFSgKnYySy6qjpxb64ufkvhSXo
         WLaCLbuQC0EQQq/Lb84kToLsnPRw+32XzUuuhJgzo+x9ho7MBAfFY8shcFqa0S53cuF/
         7+6lNDZ03P0VuQh4BNtQKq/sLsPhUkzytxcudzH//w8Lx6xbleCcHtS+5g6SfJcikmhF
         2rlGg5vKWfepZK39qtS+oVNaDr/HlYYwnXrXY9s2s4LTx1zBrI+vX5vmB6rFhOa2XgP+
         GbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bpafk1X41xGK7MXDbJ4VMxRCE4Mzuv5uYTag/1eQibs=;
        b=ILVLbEtEmNzdqDwpLmMAVF+oOhOjw6uob2k+JKhJ4vQqaTK7IhWexVc90sTl35DSa6
         S/pDfyb9LdjWZtfJv7QU2Q9FKx5tmkth+hk9mXbdOoBERr1g5b/Bt1Mf414AnT8CK4+O
         O8Q/rpfv5GD0ARqZlXPAbjOLPYBfIqpenWuBNVtskcY7cv2LCI9ZvgiNPCSBc8Lj8W3t
         8+CpAvHJptTGdWht41CfL9460CybN2lA7TL04T6XhuJwZjz0rfEOo9hxM9g68ONjvuOS
         DXxYOnaCypr4oCPnFKFscUgO1XaP+jSf6Dw+0/t9Ld3zoDlA+ePVIjDkkFgvNpq/Kuq2
         Jtiw==
X-Gm-Message-State: AOAM532H8nIk3jDZkMS966IiuTYdhSMktI0fSSIq3vQuAdZYYQUlbxoX
        s93GNv9hywM42Viixy1rrsiVqKGXOPVdAWBkeTiPyA==
X-Google-Smtp-Source: ABdhPJxprnOJMY4UIu5n1XDKPKNGr9RV+zGkMFTEI22fw+hJGHUzBjxZ7RvaQyjWpEoorsORfRskSTs3bbt3V9WssXA=
X-Received: by 2002:a17:90b:238b:: with SMTP id mr11mr10076478pjb.18.1630477885388;
 Tue, 31 Aug 2021 23:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210901030542.17257-1-benl@squareup.com>
In-Reply-To: <20210901030542.17257-1-benl@squareup.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 1 Sep 2021 08:41:48 +0200
Message-ID: <CAMZdPi8QdLwrWM5ghDNYTT2nxNJm=NgNkZGxYvbRGsYQFHGxXA@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: handle connection loss indication
To:     Benjamin Li <benl@squareup.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Benjamin,

On Wed, 1 Sept 2021 at 05:05, Benjamin Li <benl@squareup.com> wrote:
>
> Firmware sends delete_sta_context_ind when it detects the AP has gone
> away in STA mode. Right now the handler for that indication only handles
> AP mode; fix it to also handle STA mode.
>
> Cc: stable@vger.kernel.org
> Fixes: 8def9ec46a5f ("wcn36xx: Enable firmware link monitoring")

I think it's good to have but does it really fix the link monitoring issue?
Is the connection loss detected in this scenario:
- Connect to AP
- Force active mode (iw wlan0 set power_save off)
- Wait for no data activity
- HW shutdown the AP (AP leave)

Do you get any indication?

In this scenario, DB410C (wcn3620) does not report anything.

Regards,
Loic
