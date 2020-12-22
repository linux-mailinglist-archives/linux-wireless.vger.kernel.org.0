Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8B32E0E35
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgLVS1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 13:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVS1o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 13:27:44 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE78C0613D3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Dec 2020 10:27:03 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d20so12780021otl.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Dec 2020 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2yaYNLY/2Egp8td6IEyrDogvPXVN2oX1ZgCRI1aJpw=;
        b=UyGc2LXc1kA1vAINEbUyBtkq1liuLGnZGnHW8D8jjlkmywJAJh4v+aH8SEnvo9If6B
         2nb/wstlewkXJfht1E4j7JmQCmtHb94H5mFrf1XjmBojLoHwdiAPzF4uPrmGE419H/nt
         gYaH2fjep7r/3WPOq1NRTfKZI8EuFExBgDc68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2yaYNLY/2Egp8td6IEyrDogvPXVN2oX1ZgCRI1aJpw=;
        b=f6Rni3FyPH2PJ/sLRp/pFq+liXMPj4k5TePkmF/4GzBohkHVMaoOmvdugVAMA/baXp
         guSsR8VxxBbY31MO9GuEPJC4qvQv/UeCLZ/Fe+6psclACVXZfq4hCVCndVUeRvINYD/T
         PmdzCBY/5dcL63Rt1Ep7qPt9XgU8+Iw5t6xJIl9w0xqt3VIDjJxhLeCeKMZ3RQOvujfc
         FuCZL1J/Xn3hanSRmGtFcSKVeyPRoq1YaUraPnPZC+wi+30B87au61wk5PTye9FUT56j
         174kL/5AcvYal99mjK1eZtvyO6cWGTMGgaI2cW3WopJQiJjnXy5ZBYcrpp/FHcs1wUm4
         sCkw==
X-Gm-Message-State: AOAM531xvZ0URH8C59A07OOf/vJRaDeZV7cdWSHst6hvCRVchO+tL2jm
        zwtSvh6NkvvoxIFSLB4HWSMh1O2ItpETvQ==
X-Google-Smtp-Source: ABdhPJwe4M2jWESNE3b40rngp5To9EaMsCM16GlGpGfzUoaUpxdu0YyffXyKTlZTApR3OihuEiNYnQ==
X-Received: by 2002:a9d:892:: with SMTP id 18mr17319760otf.9.1608661622300;
        Tue, 22 Dec 2020 10:27:02 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id 73sm4665514otv.26.2020.12.22.10.27.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 10:27:01 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id w3so12718969otp.13
        for <linux-wireless@vger.kernel.org>; Tue, 22 Dec 2020 10:27:01 -0800 (PST)
X-Received: by 2002:a05:6830:1c2d:: with SMTP id f13mr16902484ote.365.1608661620897;
 Tue, 22 Dec 2020 10:27:00 -0800 (PST)
MIME-Version: 1.0
References: <1608618887-8857-1-git-send-email-miaoqing@codeaurora.org>
In-Reply-To: <1608618887-8857-1-git-send-email-miaoqing@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 22 Dec 2020 10:26:47 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNvQ1-0-OvwPGKroUf+9chG3G3nuoiOS7W12Tp-F1T-3Q@mail.gmail.com>
Message-ID: <CA+ASDXNvQ1-0-OvwPGKroUf+9chG3G3nuoiOS7W12Tp-F1T-3Q@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: fix wmi mgmt tx queue full due to race condition
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 21, 2020 at 10:34 PM Miaoqing Pan <miaoqing@codeaurora.org> wro=
te:
>
> Failed to transmit wmi management frames:
>
> [84977.840894] ath10k_snoc a000000.wifi: wmi mgmt tx queue is full
> [84977.840913] ath10k_snoc a000000.wifi: failed to transmit packet, dropp=
ing: -28
> [84977.840924] ath10k_snoc a000000.wifi: failed to submit frame: -28
> [84977.840932] ath10k_snoc a000000.wifi: failed to transmit frame: -28
>
> This issue is caused by race condition between skb_dequeue and
> __skb_queue_tail. The queue of =E2=80=98wmi_mgmt_tx_queue=E2=80=99 is pro=
tected by a
> different lock: ar->data_lock vs list->lock, the result is no protection.

Reviewed-by: Brian Norris <briannorris@chromium.org>
