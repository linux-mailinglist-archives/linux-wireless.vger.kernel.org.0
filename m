Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06CC4CD8D1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 17:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbiCDQPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 11:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbiCDQPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 11:15:33 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D41598D1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 08:14:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 51DDD10FB4;
        Fri,  4 Mar 2022 16:14:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P9vLXmuBVv2o; Fri,  4 Mar 2022 16:14:32 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 04 Mar 2022 18:14:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1646410472; bh=sh6teZAZ3oJ+RZRi/ZWxXm7sa16SJJdvz6GBv9UqROM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIAgIey9p0cF/SwHZr3hxa1ELsBOI7P+2YxLRWab0bL9WenHxMZsMLKtdtYuiJ7Zx
         grVYkJzbierYa0vNkJTni7Wx9LBISomeIMSGkVSfgsbM1LTNKpPGxq/rGCckNezgXz
         CI7tgCKk5dYFOJoi+hgtHlIJi9nSjXDesgaFSaGZmfYt81d3NAhNYMF1Hb328V+BiY
         JaGMsgqOjkFCDPWVdsl8iwDM1BLFAgrP6pzEgKWeSeVtfJT0i+5CZlXJm4+J0tBoso
         /QFIezkS9iFLk+WS2w8ATSjYILGuqrR+zUBvfdgfTdP8I3rAdCxFTwW6CMr0cKyRHG
         +1ZIkNHhkBg5w==
Date:   Fri, 4 Mar 2022 18:14:30 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: Re: [PULL] ath11k firmware 20211223
Message-ID: <20220304161430.GA430462@w1.fi>
References: <BYAPR02MB4567669033A210A78AC397E9927E9@BYAPR02MB4567.namprd02.prod.outlook.com>
 <CA+5PVA4WEuJDB3OCKfYK-BPaccpVWd9t_au9S7MCEtpy7cdF-A@mail.gmail.com>
 <87ee4brodv.fsf@kernel.org>
 <CA+5PVA5DJmwPqpz8F9iDbJKcF1hDBRLdDT4URgSaiEcjet74Kw@mail.gmail.com>
 <20220302175014.GA14801@w1.fi>
 <CA+5PVA6R6F=VqAZRf=xDwGcC+cpqLY1kStkoHck53XiLURVyaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+5PVA6R6F=VqAZRf=xDwGcC+cpqLY1kStkoHck53XiLURVyaw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 04, 2022 at 08:04:26AM -0500, Josh Boyer wrote:
> On Wed, Mar 2, 2022 at 12:50 PM Jouni Malinen <j@w1.fi> wrote:
> > Would the following in WHENCE work for you?
> >
> > Driver: ath11k - Qualcomm Technologies 802.11ax chipset support
> >
> > File: ath11k/IPQ6018/hw1.0/board-2.bin
> > ...
> > Version: WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
> > Notice: ath11k/IPQ6018/hw1.0/Notice.txt
> 
> We'd have to teach copy-firmware.sh what to do with a "Notice:" key.
> Is there a reason "File:" wouldn't work?  The intention is to install
> the notices alongside the binaries, so that would accomplish it.

Yeah, that sounds reasonable to me. From copying/installing/distribution
view point, these can really be handled in the exact same way as the
actual firmware binaries in practice.

> > In other words, there would be only a single "License:" line and one
> > "Notice:" line for each firmware version? The license itself (i.e.,
> > LICENSE.QualcommAtheros_ath10k) is same for all the versions while the
> > set of notices (i.e., those notice.txt files) can be different based on
> > what is included in the particular build.
> 
> Yes, that would help.  Would you be able to adjust the existing
> entries for ath firmware in the same way?

Yes, I'll work with Kalle to update the existing ath* WLAN cases.

> > > > I'm still working on your other comment about notice.txt, will get back
> > > > on that later.
> >
> > This part about clearly identifying the files should be clear now, but
> > it would be good to resolve that part about the notice.txt files in
> > general before sending out an updated pull request.
> 
> Given these were merged in the past, perhaps I'm being overly
> pedantic.  If we can mark them as Files or Notices instead of
> Licenses, I won't hold it up.  It leaves me slightly confused why
> attribution files need to reference agreements with Qualcomm, splatter
> Confidential and Proprietary throughout the file, and reference
> COPYING and README in reference to GPLv2 when the BSD license was
> clearly chosen.  Perhaps that could be cleaned up in the future.

Thanks. We'll remove most of the unnecessary information from the new
notice.txt files and that should get rid of many of the potentially
confusing parts. If that cleanup leaves something confusing in place,
we are open to cleaning these up further in followup patches, but it
would be nice to be able to get the updated versions into
linux-firmware.git without much more additional delay and yes, this
would be with the File: instead of Licence: entries for the notice.txt
files.

-- 
Jouni Malinen                                            PGP id EFC895FA
