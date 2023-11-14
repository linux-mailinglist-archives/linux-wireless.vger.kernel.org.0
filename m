Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3BD7EAB80
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 09:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjKNIUS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 03:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjKNIUR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 03:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CE4D4A
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 00:20:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37345C433C7;
        Tue, 14 Nov 2023 08:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699950013;
        bh=4N7GVjwSCjPbc2a2ptNOVzUWfFh28n3fXrbaDbzETxw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HyNQGQlMwK2poFbIMOD3ONv7+FrAy5XYxL/MdEfQa/ZxGjzAc1CjGOrZHHDtdER8I
         dpjezoUbcEw1FjEIIj72QIgnAx1GmAdqVuYQy+FjEqMFZ02IEGpdejAXnQ1VwrFtPs
         GZWe73tG1PfgDrmifm9XHqqeQbdJgkvVkj24pkcHEimueIMd2nrTV+Hk7fAIdOuvwl
         45QSNPZ07r3/J9YN5ziUJyCaaRBCk+YMOKQP7arHsN9ByEfSg+MSuKLHh+g/ILOr+G
         XLXLPTynPlVohfxpPGfsQOEjeJ+DXdhRr5nznKvypzVfzJqttzIn0O8VwI3gDfVoNX
         2tH6NunlnSGQw==
From:   Kalle Valo <kvalo@kernel.org>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath10k: add support to allow broadcast action
 from RX
References: <20231017165306.118779-1-prestwoj@gmail.com>
        <169989062657.3473659.188127753057713210.kvalo@kernel.org>
        <2033c16c-4d9a-4592-bb81-7a9ad7821576@gmail.com>
Date:   Tue, 14 Nov 2023 10:20:10 +0200
In-Reply-To: <2033c16c-4d9a-4592-bb81-7a9ad7821576@gmail.com> (James
        Prestwood's message of "Mon, 13 Nov 2023 09:27:59 -0800")
Message-ID: <87wmuk926d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> writes:

> On 11/13/23 7:50 AM, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> wrote:
>> 
>>> Advertise support for multicast frame registration and update the RX
>>> filter with FIF_MCAST_ACTION to allow broadcast action frames to be
>>> received. Broadcast action frames are needed for the Device
>>> Provisioning Protocol (DPP) for Presence and PKEX Exchange requests.
>>>
>>> Signed-off-by: James Prestwood <prestwoj@gmail.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> On what hardware and firmware did you test with this? As there's so
>> many
>> different combinations in ath10k we use Tested-on tag to document that.
>> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag
>> As ath10k hardware and firmware can work very differently from each
>> other I'm
>> suspicious if this feature really work in all of them.
>
> I only tested on a QCA6174 (and I'll add Tested-on for that). This
> makes sense and maybe enabling unconditionally for all ath10k hardware
> is the wrong way to go about it.
>
> Since I don't have the ability to test every hardware combination
> hopefully someone from atheros can chime in.

Heh, Atheros is long gone. But your comment made me remember the good
old times and smile :)

> Is there some firmware/driver value that can be queried which tells me
> if broadcast RX is supported?

A good question for which I don't have an answer. Does anyone else know?

Do you have a simple test case for this? It would help if people could
test this feature on their ath10k devices and send us results.

> Or if not is checking ar->hw_rev == ATH10K_HW_QCA6174 good enough? 

BTW instead of checking ar->hw_rev our preference is to add a new
boolean to struct ath10k_hw_params. That way it's easier to enable and
disable the feature per hardware version.

> Or are there sub-variants that may or may not support this?

There are several QCA6174 variants and you can check the variants from
ath10k_hw_params_list. For example, hw2.1 or SDIO firmware may very well
behave different from the PCI firmware. To be on the safe side I think it's
best to enable the feature only on the hardware versions we have
verified to work.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
