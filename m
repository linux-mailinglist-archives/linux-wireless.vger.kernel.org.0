Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBA56BE895
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 12:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCQLvP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCQLvN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 07:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C03B1EFB
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 04:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4AB62283
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 11:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B771AC433D2;
        Fri, 17 Mar 2023 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679053859;
        bh=sC7r4HVHlmlaWboC01OmGxjuxyr7jc2FfEr3pSQcoUg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HHfYeh6GodmlMsI9+xwt4W0YzgYZEwAhB03YdXBbzWesF6moZprpsBmpVzo8Mh1rn
         7tssSI6XRGaNprbr9sJeW7kv0xR8TH0Wl9AiWKpZOkxVsB+DoBHu5q6Gtrg8vP3sxQ
         4/eAMj0eIvMRrJTb45758ERHI0z7gZLtD3ADWmW+y7zguJHfLJ5J4Aiy7lTVoZ4bFI
         mbQBViRATzgzaIQO0JkY4XjpJeP6wJX4bbq/r3LwenGltEt3vAeW7/FF0wEegEGXhJ
         he6z1Q52ZVMp8xfmw3gBRqh8xQ1yp6Pql01T7llcZ9N7IMqomzRuDKJIAxbl0J2Pje
         6XV43pKdw2k9A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Vincent Tremblay <vincent@vtremblay.dev>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wifi: ath10k-firmware: QCA9888 hw2.0: Add Linksys WHW03V2 specific BDFs
References: <CA+RD57NTNJcxz0-nJFwKsm5HjChTXG-9seE6kGzwMpzqpYO_4A@mail.gmail.com>
Date:   Fri, 17 Mar 2023 13:50:54 +0200
In-Reply-To: <CA+RD57NTNJcxz0-nJFwKsm5HjChTXG-9seE6kGzwMpzqpYO_4A@mail.gmail.com>
        (Vincent Tremblay's message of "Sun, 12 Mar 2023 15:57:50 -0400")
Message-ID: <87wn3fiokh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vincent Tremblay <vincent@vtremblay.dev> writes:

> This is a set of files for the Linksys WHW03V2 that are currently
> missing from the repository.
>
> *  description for what hardware this is:
>
>   - it is a IPQ4019 based board
>   - QCA9888 V2 interface connected over PCI-E to operate on higher
> part of the 5 GHZ spectrum
>
> * origin of the board file (did you create it yourself or where you
>   downloaded):
>
>   They were extracted from the vendor firmware (version 2.1.19.209783).
>   The files can be found in the folder "/lib/firmware/QCA9888/v2/FCC".
>
> * ids to be used with the board file (ATH10K_BD_IE_BOARD_NAME in ath10k):
>
> bus=pci,bmi-chip-id=0,bmi-board-id=23,variant=linksys-whw03v2.bin
> md5sum: fde89e0dace1652566d96fb9c83b1c61
>
> * attach the actual board file (board.bin):
>
>   - The name of the files are equal to the id string in the board-2.bin
>     (minus the ".bin")

Thanks, added to QCA9888/hw2.0/board-2.bin:

New:
bus=pci,bmi-chip-id=0,bmi-board-id=23,variant=linksys-whw03v2

Changed:


Deleted:

1 board image(s) added, 0 changed, 0 deleted, 17 in total

https://github.com/kvalo/ath10k-firmware/commit/07101af80a3c94a395add066613af5ede68c0727

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
