Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E050552A73
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 07:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbiFUF1t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 01:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFUF1s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 01:27:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414362124D
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 22:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D329B811BD
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 05:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939ACC3411D;
        Tue, 21 Jun 2022 05:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655789265;
        bh=yK3nXqg2eNSJeQjGh5W2zZkGr8q4fhRNwnX2NA7kehQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IkBMgHxe656D35+KVFsFPIcZJ9mvVkIOrtdwlxKace09RrmCNbU4goQ3Cq17ruvkx
         It08/PCOf/wkz06o5BWI10GpAYKrO8t7y/FS3bbdjEsI0zMIeFyYUywEANOBtwDL6n
         37UVlMB03L01AaVYHDsP8BQU/HJFHyagOSycrGaXmm4be0n/b4AZ1ZavgTxBCKLzNB
         KLTxF1vEhslJMufv1TXOx41zXl2NAGUjIycb4xUZHoAgtVPvhAubWLY7B8+yMr0fWl
         EUwlOEa/F5WRREMjbVJg2e8jbXJEKiy7RIEDcM7AOKkWYr/fCVhJjt4ANUscfj78lU
         9LJDwmrn1QJMw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211_hwsim: set virtio device ready in probe()
References: <20220613210401.327958-1-johannes@sipsolutions.net>
Date:   Tue, 21 Jun 2022 08:27:39 +0300
In-Reply-To: <20220613210401.327958-1-johannes@sipsolutions.net> (Johannes
        Berg's message of "Mon, 13 Jun 2022 23:04:01 +0200")
Message-ID: <87v8supovo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Just like a similar commit to arch/um/drivers/virt-pci.c, call
> virtio_device_ready() to make this driver work after commit
> b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses
> the virtqueues in the probe function.  (The virtio core sets
> the device ready when probe returns.)
>
> Change-Id: I617d3b819b5e5345471a8e79db25342981a92424

I might be too late, but leftover Change-Id.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
