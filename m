Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B45813DB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jul 2022 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiGZNIl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jul 2022 09:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiGZNIk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jul 2022 09:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF1022BDB
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 06:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ECF66158E
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 13:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6705EC341C8;
        Tue, 26 Jul 2022 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658840918;
        bh=jK6NsQySV+o3gjRAHr2c0nHKbA1txRp0bxckRt/Ux40=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kRwB4dWliww/bf+5UNKk25A762GhrwwIfnB6qNUuMPP1eniiM3SJ2z0mPnv27xlm3
         eaBanFixU3zEYFCJXUZHBzRckB5nHuqueuG86qbnAwTiAlMFMMhatmzFLLIW2bB/B5
         Ft2pMRWMrI09MmwkpwfcoeJieC5uuMFBYLqamO704zFCF2kw1oF1Czj4EFI9eWjcFd
         RafA7SreIx5BQqJsx1kt2pAQoBs0pKaFMt3V0UQ7gvWPh93NRxYw3B42JD+wLGdXHw
         iOfNJTOt7DYbs22zJ5RMeTDSeuzXM4i7+S0xoMxQANGIyMUAoDheCIxB/pRAq8z+XF
         lbQPimKjuN4DQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH 1/2] brcmfmac: Add brcmf_c_set_cur_etheraddr() helper
References: <20220708133223.101558-1-hdegoede@redhat.com>
        <56fa5cfb-7f38-4380-67e5-ba362dd8e440@redhat.com>
Date:   Tue, 26 Jul 2022 16:08:35 +0300
In-Reply-To: <56fa5cfb-7f38-4380-67e5-ba362dd8e440@redhat.com> (Hans de
        Goede's message of "Fri, 8 Jul 2022 15:34:57 +0200")
Message-ID: <87sfmokomk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> Hi,
>
> On 7/8/22 15:32, Hans de Goede wrote:
>> Add a little helper to send "cur_etheraddr" commands to the interface
>> and to handle the error reporting of it in a single place.
>> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Ugh, I accidentally used Kalle's old address. I'll resend this with
> the right address, sorry for the duplicate emails.

No worries. And it actually doesn't even matter as I take the patches
directly from patchwork :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
