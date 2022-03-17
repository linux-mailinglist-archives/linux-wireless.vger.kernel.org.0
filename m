Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFB4DC8CF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 15:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiCQOdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiCQOdo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 10:33:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCC116CE77
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 07:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57ED5B81E90
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 14:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0D5C340E9;
        Thu, 17 Mar 2022 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647527546;
        bh=8TgAue8mdjKkQNfphFS3ILUs38qv8S40AivNDDGb3RE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HTeWQrDPEwtNRV5iK7Pwf9CQCC5qEHNmTyrt8qpEfHDyUm2Ax8GvfMgnqr5HnYeDj
         tiiC0FnrjNKo8A58WwARTAnL6zjsXvwCCbRvkBBeiGodm4tOwtHxsWs8ybfVEMub3Q
         wKrG4IDDY+VAa7/BvyCxxohRM4a2RWBENEx1/zwTYIvkaxzEA7J3wCgwGGZIWc6IA4
         guHdwK20hDeVhqSFgvYrJPHoa4rVaQMoriMGmxftEdpxFsyx7U3KmQlccTc03SgiAm
         xLIrroRTMB/rWy43DCMm4X8d+IPFoQf85LjG4wYPqIPXvPEiw2ALEOUrqOgcSLbCTz
         yOc6eyUvH8mdg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2022-03-18
References: <de917732-79c6-4ced-2761-f372ff5dea71@nbd.name>
Date:   Thu, 17 Mar 2022 16:32:21 +0200
In-Reply-To: <de917732-79c6-4ced-2761-f372ff5dea71@nbd.name> (Felix Fietkau's
        message of "Wed, 16 Mar 2022 21:25:12 +0100")
Message-ID: <878rt8ps3u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's a new last-minute pull request for 3.18
>
> - Felix
>
> The following changes since commit d179c1f1c3703d1a6f7a6f2ad08383220673240c:
>
>    rtw89: fix uninitialized variable of rtw89_append_probe_req_ie() (2022-03-16 17:49:04 +0200)
>
> are available in the Git repository at:
>
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-03-16
>
> for you to fetch changes up to 24e69f6bc3ca4a1696158b68a6fbf14252a8bd28:
>
>    mt76: fix monitor rx FCS error in DFS channel (2022-03-16 21:18:06 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.18
>
> - bugfixes
> - mbssid support for mt7915
> - 6 GHz support for mt7915
> - mt7921u driver
>
> ----------------------------------------------------------------

Pulled, thanks Felix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
