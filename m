Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFF4101117
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 03:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKSCDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 21:03:32 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43541 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSCDb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 21:03:31 -0500
Received: by mail-qv1-f67.google.com with SMTP id cg2so7465130qvb.10
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 18:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQS70+b0I1j8R7UAYTKaEgykb1d75vU+jaQnzyuNmPk=;
        b=HCJm/4XfHWox+f92RE61t6JFY5wbYs9B85uZ/CZ8AERkrcEJISmyyxHIhEMuqZZuhz
         RuCaP2WY18zIX5XhvXcS5tQVwOTUS6FORn4igOdpb21g4fUCYuPpGTmMsUR4XFud4soq
         e7//yjktj7JGNkn2Kwf3T+nvV0al8103O65WvGPEvas+GjU/LDMxdNsTjDAQnzSMznmY
         dJSTjIhMZwdqFP6CiE+W3iLNTS4nnwBRrBHhwB7qn8GXABWx8uRLhMqIfJSP29vGHt2o
         Tx92zQcnY/h4N6Tc52Z6BDNp4cSPoaqXWT8CGopREYWwjSlwRUmbhPCCchSeBT8L0Muc
         w6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQS70+b0I1j8R7UAYTKaEgykb1d75vU+jaQnzyuNmPk=;
        b=p1uhZ8yJvZ6Mp8xdmKSaSHmOj8XgYPf/TUBq24xNm3Uo99iTpB2H2iR0jaIr+/2zIK
         asghOxhoRYbpjsZ46Itx6aQbM2Y6WOGQ0wwEM0ieaXUQx+oF76Q3mEF9FYx9R6bHmPfR
         ivJ5zt67r805zcSmrYGEKXY7n5wTxdS4RLGbMcZVWIij0nUzXZ1/1HX90LO2mrZ5PfSd
         2u35EnSBZ5NJR9bwaYd0Ttn03d+DfXtpB9Q9NB2uYrwKMS1En3r0TBJ3xFki11mwdSB/
         kQKD92CzDEs0Q3ojkqVqyYziKAXULHaOrl6C7OTFX6FRy0tPw7rGB6b/Cr62oiX619OU
         ehvQ==
X-Gm-Message-State: APjAAAUONFiF5g0KDzjBWvtoeQ+eQTQZMdT/PPzWQBWUqkyYbB6qwkYk
        zE8IgJxv0eQYjcjsG+7dkFIit/a/5InLuSJi36Hq7A==
X-Google-Smtp-Source: APXvYqz/elbLuDM0m4N9hUQjVW8FZsfrFxDX8knMmP7q8RB34vAAtRDkCJXx11qldtzAeTeB745hB53WCUB9RS2O7v0=
X-Received: by 2002:a05:6214:22a:: with SMTP id j10mr1722070qvt.154.1574129009235;
 Mon, 18 Nov 2019 18:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20191118095432.4507-1-yhchuang@realtek.com> <20191118095432.4507-3-yhchuang@realtek.com>
In-Reply-To: <20191118095432.4507-3-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 19 Nov 2019 10:03:18 +0800
Message-ID: <CAB4CAwfaox_tRQdVrbeCaEp3T9Ge+QWZukS3SukJ88EszbN_EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rtw88: pci: use for loop instead of while loop for DBI/MDIO
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 18, 2019 at 5:54 PM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Use a for loop to polling DBI/MDIO read/write flags to avoid
> infinite loop happens
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>


>
> v1 -> v2
>  * no change
>
>  drivers/net/wireless/realtek/rtw88/pci.c | 26 +++++++++++++-----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
