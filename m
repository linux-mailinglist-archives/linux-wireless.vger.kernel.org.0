Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F952E8B59
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 09:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhACIVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jan 2021 03:21:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:40349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbhACIVw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jan 2021 03:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609662012;
        bh=k5HEp7s8K6E5K8g8odOAEu/I6EoXFn4zzfGpoedVYJ8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=h4Y49bokhbV/ekbTHvhpVKnd9MvXBl/RGbMFd3l7dou7lK0fe6Ks1+3pfYeiIrDIb
         uh/PAWFmxJrAYDuL02RW9j/J6xmNO45UsNqpL/DYBuQ1E5wOaotNbPKroH2OglNT8c
         TW33RicuRvWU/TxlT8dGgzhJS4IeDCKjWOn/DfPg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from E480.localdomain ([84.61.118.33]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1kMdw539xh-00ZcFv; Sun, 03
 Jan 2021 09:20:12 +0100
Date:   Sun, 3 Jan 2021 09:20:04 +0100
From:   Zhi Han <z.han@gmx.net>
To:     tangzhenhao <tzh18@mails.tsinghua.edu.cn>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        amitkarwar@gmail.com
Subject: Re: [PATCH] drivers/net: fix a null-ptr-deref bug in
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c
Message-ID: <20210103081939.GA10783@E480.localdomain>
References: <20201209132640.36031-1-tzh18@mails.tsinghua.edu.cn>
 <20201217163316.7C64DC433CA@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217163316.7C64DC433CA@smtp.codeaurora.org>
X-Provags-ID: V03:K1:tS9Gpbzz3FVyqHWyFhfcVmGBBQSfveZbmGYXUF7OEwA2m6kIKot
 +gdDs2qw+OU4VOAIVUllrbwabT8xWeI/UI1aJ5kb1QZhwZ8bEBjV3VlGlpDqFnlqvgIE0mP
 +1+7w4LXhkmVTML+HTkxAFkCmLUBg7dX2E+ouvjMPjXZz/hqbgyPFoyDV4bMgNH/2d3syA4
 rPfzdqQaYGtGHbDeKsGSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sANg/PNJHSo=:zF5v0KY961CCt0g7tehGzC
 iW4hXgLa8ANutlJ2R41ydpq2hRsJYHIMW9lSu/WmRQhmqRFwFHD1rXVzDcYgV9lExPeCvyN6c
 Zi8Hhrmh7tAIdgJBmXY3zsuDBSRanmwHFc6cXP35xu3zOea7ZquhQwNiQDXrZEVau0eJUBf6F
 MBNNuq3Fwt7+QxlpjgFdbWgMefMoY0G4QYEA2x3pvWXMO3hlW71mriEvjtHU8Y0lI1fHIvKDH
 hBduBu9/6ttGUU5qgwLBymzP9LZ2+cy1xptIEd90JvR+mef5qiLEMNoUHX57J5uyS2r6CZ0ma
 YQkOK0kM8KfaClmzatoDzN1w8XFYMT7uwj4V6/uAvJQmE0J82vmAGsUNpDzP8ynADwXsSkfBf
 v4BQR0/+MYM5quUJjMD2k9GOdiiKUX30qsGEGfDKTiwkHxPaE54yhX6is6h3LXFL9KYTdaRGT
 WsZfAJVKPPogoA0nn+NeZ8GyQbdrEHgMquHWuP5dC59UYR0pd7hMWrIz93ztly3fO0yyMTXp+
 YExoyt/8Ic985ZkqOAjhiPru+ErNEG5nHyvL3O6wvhtXo/jCZmTA1SL/WAgvticYR+Cjp++Qz
 B/k4Tnnwq0Cov7U4cYdpjJEHLHjcmNlHChijKAKN+WLqrlYgUfH07EMobiEU3TGKni9VXr8YV
 QCIf578xFct8cq13rMMpeQXCysKJluNRQauY8Z1/ONEfxuVnL8CktrAkrlFsI1tTrt5Y4F6k0
 NefAxz51GDtO4CqFKW1/9dY+axWrES0WPr8BcRN5uOq6UpbSgjXtSexCmZ6g+ibzcOggzBPO8
 TGTBLZDheldot3Ib3MhgafIreonVNQddTf8QwP3j7Hv0fFheN45yBtruQg1WzZfvke5j1/OKz
 aZlRcwqWnPIOlw4KCfkQ==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tangzhenhao <tzh18@mails.tsinghua.edu.cn> wrote:

> At line 257 in drivers/net/wireless/marvell/mwifiex/uap_txrx.c, the ret-val of skb_copy should be checked to avoid null-ptr-deref bug.
>
> Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>

"\n" should be added at the end of message to avoid corrupting other logs
and to output timely.
