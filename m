Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C7777EA1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHJQwB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJQwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 12:52:00 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B171E10C4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 09:51:57 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691686315; bh=/BDMGWcKXP+ytRs0TY0J5uo+yBStSHmXI/uhxHjbOoU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iOtoUH3a/87gETYSP9ok5n/tFpar+pG/X6ir92CDuiNn5UUd/NX9m4IXG9nXlOpS+
         OqUF1zQU7RPSQ+Aiqgn8vH/1Llk1cMjG0vFb2rE52QRJLukqV0F8KMhfDoFOGBmUCB
         fZ+WJ3tLdpcCqDf3/MVbEh14GcoeK3ulYVXDL5ac2xul/rqQRsgDrKY9sgTENdLT56
         r0qWnRRqkuSmKeUm0tOa1ykcaohCEUnNk8dwuOZHmY6lzPlEYvmdAa7HjeyXLAKdtt
         bupR/YB2mAH5lqxsHJ3YoZa6aBAc8FBTXITuHJnDYUIAtaTLUMhtPsp8nICWX1OZBM
         1kGcBFiGeVdfA==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH v3 00/11] wifi: ath9k: add support for QCN550x
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
Date:   Thu, 10 Aug 2023 18:51:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a5uyg7rp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


I've started looking at this now. A few initial questions:

> This patchset adds support for QCN550x. Compared to previous versions of
> this patchset:
>
> - Removed hidden dependencies on ah macro
>   (see commit b3a663f0037d20e77bbafd9271a3d9dd0351059d)
> - Done significantly more testing and performance improvements. In my
>   informal testing, the 3x3 performance of this driver generally meets
>   or exceeds the performance of stock firmwares, which was not the case
>   for previous patchsets. The main source of the improvement was
>   enabling the clock doubler.

Did you do any regression tests on other types of ar9300 hardware to
ensure these patches don't negatively affect existing systems?

>   Revert "ath9k_hw: fall back to OTP ROM when platform data has no valid
>     eeprom data"

This revert seems a bit dodgy; the commit message states "Users
currently relying on this silent fallback will need to stop providing
invalid EEPROM data to the driver." - which kinda sounds like a
kernel-to-userspace regression to me? Do any such systems actually
exist?

-Toke
