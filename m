Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFB634021
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 16:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiKVPZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 10:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVPZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 10:25:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF02E20184
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 07:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C9BEB81BE9
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 15:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDF0C433D7;
        Tue, 22 Nov 2022 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669130739;
        bh=+K9JC4R4AjIo3a+fXuKyFCM7hrS0PX9YEouwWKEuY44=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LodYFak2P+OeVhpTcpX/9uSOdO8qH2Iahun8uEcOArXAKv5MHTTusTOTRkbL11R9R
         Iz8uHSptoENmQakaZnXy0YWuPe/PRv6VcSW/yxRvP+bULaYVjpaKzZDHHDsW2N3taw
         X2+OCi9aTmZVA/cxv+X5jhTKxyb6rOB641VTxrH7kSywLy9Az5oa0eSvEz0pkbvkRQ
         J2onvTXVisFACmQ9yI08BIgzPl7qKhryPNenlxvPD6Bw/8VeWhA/TaGfCtAvqm5tt8
         NtgJWfyEsUxSr0iTz/J63HUP/XgLeASACZcvSCsRNi9R04zAC7JB76e5bFgE4//jLu
         88a+M2j92aHnA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     gregory.greenman@intel.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH 1/9] wifi: iwlwifi: mvm: Advertise EHT capabilities
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
        <20221120185147.73b38ef7c70a.I214005645f3da21d8f2458a70355deeca04a19e8@changeid>
        <87wn7o8f8x.fsf@kernel.org>
        <4aa47c8c-925e-69b2-5205-4605c3dd8122@broadcom.com>
Date:   Tue, 22 Nov 2022 17:25:34 +0200
In-Reply-To: <4aa47c8c-925e-69b2-5205-4605c3dd8122@broadcom.com> (Arend van
        Spriel's message of "Tue, 22 Nov 2022 14:48:35 +0100")
Message-ID: <8735ab8101.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 11/21/2022 5:05 PM, Kalle Valo wrote:
>> gregory.greenman@intel.com writes:
>>
>>> From: Ilan Peer <ilan.peer@intel.com>
>>>
>>> Add support for advertising EHT capabilities is supported by
>>> device SKU and not disabled by module parameters.
>>
>> I'm not really understanding what the commit log is saying, some cleanup
>> would be nice.
>
> Would it be more clear when it would say: "EHT capabilities *if*
> supported by device...."

Hehe, indeed it would :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
