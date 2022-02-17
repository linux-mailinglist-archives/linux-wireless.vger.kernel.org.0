Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74B14BA3C9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Feb 2022 15:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbiBQOzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Feb 2022 09:55:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbiBQOzC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Feb 2022 09:55:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B52B2C6F
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 06:54:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j7so10481643lfu.6
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=11Msxpj6saXhCjkH+nNzBnzST2VwOlijviYdJ5EL8xY=;
        b=h5HMBr2qhvXOVt5Rfn/vHXtiCQDuOpsxkvtFXY0SaiScqWYvwpMJt7Ts5GoC0oM9lu
         oZj3IfLiiIcHvrxc3JwV25jjQsMvXlueV81dkAF15o0UJ2Wc1KHJgUiBV6+YYsPTH98G
         8nWuYP3W8FBS6N4SeEuBzBAYUDcjwdH/gP8aX0MTiZXvEu4z93liPMgb34C5FYDQctPi
         G5G0CrnohL2XTBUHXFu9UhV0YmK4fiIERHclNELjygJMVr+BGfUBjhvEtptQCK+yxtkm
         aeY1WFNrw8P8mIxnuUxVsLdP4wnwmi1KwCEPf/m/0deGHDK0O/gNRAMxVaGIpLfuPW6C
         jOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=11Msxpj6saXhCjkH+nNzBnzST2VwOlijviYdJ5EL8xY=;
        b=vI9GoHMt/7nS9SGJWN6bKfeT9aen6IUOq95Lvmq9ZAQNVcOPQEf5p4sAOshSZpEFzi
         jPmwIPQWc8epNomFYdYUKJT7lWq0Zj/tTaUMx2rpxC/nCTMAKdKNVFFDW+J2kuun4u7Q
         GoYXkG1RnEoEDcbGaknLik/5+aMwWgGP3mP4xrK71Epyar/Qcl5S5tojxtPCs6dztE7b
         pdGLiT5PS+Hk6C4YLIw7BsTOiCuXdHu/TLksVV+daPLxSaVkXr1flVtZMepKVCdc7iWk
         r5kWSaP4Ye+l2iCNWbxp7yq23zzADBxO08cEiEpzyIQwQa/zEoLfskX+gBWNKxzU5v06
         a6PA==
X-Gm-Message-State: AOAM532e9tFOY5LFgM2OM4ennBGyl4VzrvN8oL3EP+VJFsr9BfCybae8
        9aflelJD+dlJ3TpUp13v20SB+PHHdrqZFysHkUgmfA==
X-Google-Smtp-Source: ABdhPJxr6FXLaH1va6dG7alhD1yu9EwTbfNIoN/IWCmHeyc0IwCpkdkpbk1bdcrCPBR912vFQwi6slrPY3X5Othxofw=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr2301608lfj.254.1645109683832; Thu, 17
 Feb 2022 06:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20220216093112.92469-1-Jerome.Pouiller@silabs.com>
 <20220216093112.92469-3-Jerome.Pouiller@silabs.com> <878ru924qr.fsf@kernel.org>
In-Reply-To: <878ru924qr.fsf@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 15:54:05 +0100
Message-ID: <CAPDyKFqm3tGa+dtAGPn803rLnfY=tdcoX5DySnG-spFFqM=CrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: wfx: apply the necessary SDIO quirks for the
 Silabs WF200
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 17 Feb 2022 at 10:59, Kalle Valo <kvalo@kernel.org> wrote:
>
> Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:
>
> > From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> >
> > Until now, the SDIO quirks are applied directly from the driver.
> > However, it is better to apply the quirks before driver probing. So,
> > this patch relocate the quirks in the MMC framework.
>
> It would be good to know how this is better, what's the concrete
> advantage?

The mmc core has a quirk interface for all types of cards
(eMMC/SD/SDIO), which thus keeps these things from sprinkling to
drivers. In some cases, the quirk needs to be applied already during
card initialization, which is earlier than when probing an SDIO func
driver or the MMC block device driver.

Perhaps it's a good idea to explain a bit about this in the commit message.

Kind regards
Uffe
