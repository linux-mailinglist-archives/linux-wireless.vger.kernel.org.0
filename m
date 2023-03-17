Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545876BE886
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCQLsS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCQLsP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 07:48:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC8B11672
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 04:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EBE4B82586
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 11:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8321FC433D2;
        Fri, 17 Mar 2023 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679053690;
        bh=g+WLQk6lPmjDVyE7QTR6gGrMAPZ74IUZN67A0anHq1g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SLwp9ijMICb4rODg9/LmGM1bAf40WOgbtKwQgqCvpb+hJPVW0XqSGXr2sAgAwKktp
         LolXIW4mXpy+0IkfW+8u0S5QNn8bszFKSB7diOzL3P2IfBasCTPwydOzYFw8MwosqT
         +3QldAamhgm72noD2J0rsmpEAW4VwypPinwQwwpHhwIQv2umSeOEm0axpyYrvPJPXU
         IdKHpqzFKTgl5HrsVFZl/60nz9MvQSFdFAzGvYz7oSInwmRDGg+TknaxQipbmz+h7V
         12AF1EN7fvoHfZNYDMhdefzJGUtfY/zqlRgrMNXlT3r71phzOa44WtM6Vl0LZqspif
         L6tnp73/5EztQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Vincent Tremblay <vincent@vtremblay.dev>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wifi: ath10k-firmware: QCA4019 hw1.0: Add Linksys WHW03V2 specific BDFs
References: <CA+RD57MNn7H13uHadJFr2UsxK7VodB7UAba9jr2GquYOzq+bwQ@mail.gmail.com>
Date:   Fri, 17 Mar 2023 13:48:07 +0200
In-Reply-To: <CA+RD57MNn7H13uHadJFr2UsxK7VodB7UAba9jr2GquYOzq+bwQ@mail.gmail.com>
        (Vincent Tremblay's message of "Sun, 12 Mar 2023 16:00:24 -0400")
Message-ID: <875yazk39k.fsf@kernel.org>
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
>   - one QCA40xx radio is used as 2.4GHz radio
>   - one QCA40xx radio is used as 5GHz radio
>
> * origin of the board file (did you create it yourself or where you
>   downloaded):
>
>   They were extracted from the vendor firmware (version 2.1.19.209783).
>   The files can be found in the folder "/lib/firmware/IPQ4019/v2/FCC".
>
> * ids to be used with the board file (ATH10K_BD_IE_BOARD_NAME in ath10k):
>
> bus=ahb,bmi-chip-id=0,bmi-board-id=20,variant=linksys-whw03v2.bin
> md5sum: 0435269fbb0797bf269b8cb0591e7544
>
> bus=ahb,bmi-chip-id=0,bmi-board-id=21,variant=linksys-whw03v2.bin
> md5sum: 79042d093e81a43c8c790bc124ca4dfc
>
> * attach the actual board file (board.bin):
>
>   - The name of the files are equal to the id string in the board-2.bin
>     (minus the ".bin")

Thanks, added to QCA4019/hw1.0/board-2.bin:

New:
bus=ahb,bmi-chip-id=0,bmi-board-id=21,variant=linksys-whw03v2
bus=ahb,bmi-chip-id=0,bmi-board-id=20,variant=linksys-whw03v2

Changed:


Deleted:

2 board image(s) added, 0 changed, 0 deleted, 128 in total

https://github.com/kvalo/ath10k-firmware/commit/785cdae1a7a818813ac1faa715f69bc925e381ee

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
