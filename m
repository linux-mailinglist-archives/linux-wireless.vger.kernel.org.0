Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79E1C960A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 02:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfJCA7N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 20:59:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33783 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJCA7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 20:59:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so1315860qtd.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Oct 2019 17:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55RbO+WJOZQM19PtQHPKSMAcog+78GCdZAbUU16u3QY=;
        b=Sqr/+PBJ5fEYkxrO1ypoC2tYCBLiV47GV9vCT/nTGcrpbllCs/FDKV880+zZt9x0Gj
         5iTgP7DGuJJrNOGCHiFtLtKi5jn2nY9rNJfhEWYFzdN0OaP8kecSwpHFuU2IVDaPoWxq
         bMerE5fK9wIhPN40VUcqlDb6C3sYp3feqhxSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55RbO+WJOZQM19PtQHPKSMAcog+78GCdZAbUU16u3QY=;
        b=HhhvvOuEfoQumSVfk4xUhs8fCb7777TU3HLxQmHnQ1d4ylPdCbuHdJJDX93lQtBlVi
         z5Sqcs8h9BHJa1lxYwR7VX/TnDHreDBAgSeaZuxs1LKNK46fJvvO6eWpSBuPOuIhPucg
         7FMHxk1X3d3yLYKMDrVRgvJKOlWFHUam9rkkutso06Xm3d2HxKOCHB+xmEyNn9A2d1xQ
         18z9as58NX5dE2pY2aEI2xU0vh0SWCwXWs9ckIXmQ0L/b3ZdMOVNKA6Rkx7pkJOtphiT
         GwSwWWa6UosZ1QjGfk/VB/G5c22xexcYVxAOS/nY9q8AtFdqRYWORPkpLm3pPTYJkRrN
         +YAQ==
X-Gm-Message-State: APjAAAUffMQ4SVrGI1dwp3fgi9f31V7rbH7euR9sp/EIjooixm1t+Q/O
        jgxoUsdI9qowkJhYwVvBn1C+PlBosBI=
X-Google-Smtp-Source: APXvYqxgk3J8722oAddEHVAJkOrthZ3OLnw4Nmsf0GKw7dfF61LHqU9sfEOpg1qC8tcri41hCV2Rmg==
X-Received: by 2002:ad4:430a:: with SMTP id c10mr6023106qvs.140.1570064350965;
        Wed, 02 Oct 2019 17:59:10 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id r55sm492513qtj.86.2019.10.02.17.59.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 17:59:09 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id o12so1285652qtf.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Oct 2019 17:59:08 -0700 (PDT)
X-Received: by 2002:ac8:6047:: with SMTP id k7mr7395287qtm.238.1570064347909;
 Wed, 02 Oct 2019 17:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <1534402113-14337-1-git-send-email-wgong@codeaurora.org>
 <20181114225910.GA220599@google.com> <CA+ASDXMh7vdfkA5jtJqWEU-g-4Ta5Xvy046zujyASZcESCGhAQ@mail.gmail.com>
 <87woe5aehr.fsf@kamboji.qca.qualcomm.com> <40854e84bd4b4a9699b60530b1c373ad@aptaiexm02f.ap.qualcomm.com>
 <87pnjvctjh.fsf@codeaurora.org>
In-Reply-To: <87pnjvctjh.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 2 Oct 2019 17:58:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNXZrBS8dZW4jmXkg7c8-sK=pcYtQtj5KPxCDCEc8XqYA@mail.gmail.com>
Message-ID: <CA+ASDXNXZrBS8dZW4jmXkg7c8-sK=pcYtQtj5KPxCDCEc8XqYA@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <wgong@qti.qualcomm.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Sorry, I failed to follow up on some of this.

On Fri, Sep 20, 2019 at 12:32 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> But I mixed up the flags. I meant that can we enable
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR in ath10k? Does the firmware
> releases which have WMI_SERVICE_NLO support
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR as well?

I'm looking at firmware which supports WMI_SERVICE_NLO and
WMI_SERVICE_SPOOF_MAC_SUPPORT. This leads to support for
NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR and
NL80211_WOWLAN_TRIG_NET_DETECT (good!), but it also leads to
NL80211_CMD_START_SCHED_SCAN support and *not*
NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR, which is inconsistent
(bad!).

(I think a few times in here you noted the FEATURE_SCAN variant, when
you probably meant FEATURE_SCHED_SCAN.)

If I understand Wen correctly, he is working on dropping
NL80211_CMD_START_SCHED_SCAN, which would fix the inconsistency.

But I also noticed that ath10k does not support
NL80211_FEATURE_ND_RANDOM_MAC_ADDR, which is again an inconsistency:
we're going to lose randomization when in WoWLAN + NET_DETECT mode. I
don't suspect we (Chrome OS) would ever enable this feature in that
state.

Regards,
Brian
