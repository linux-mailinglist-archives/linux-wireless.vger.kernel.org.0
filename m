Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B094710588
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 07:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjEYFzs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 01:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjEYFzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 01:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D4183
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 22:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5EE96419A
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 05:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C2DC433D2;
        Thu, 25 May 2023 05:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684994119;
        bh=acZ5PbxAi8JxMHmjdpEAaUSh7XzjyxNU90ZWpqWEnlM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LB8CFaMpa+9X6LWpPFdIb86dQ3PhMWND8d/TWdzUUO0VSDFyuzdeTZsTaehAyWeOn
         vCazey4Sysa3NNkw88m8eeNV5CWROSxHMHvBFehn2wrEi+bekHUVrqjVl3uEwWZm7t
         zuv8qD8CJYRDqqM49saA269UUe1s4ZrQCd2qjojtc5I+NXjXEQQ/FrZt7kjiulaGUc
         8E/4grXpoI0JPq+6kPNS7sz2tEwy2E/98RqhjAylalpJLbKu8enh3GuYJW6xjQlIo8
         AEl60SHCDonRXKnKFMECjUN4SU1n+SzrL9o1DMeygzbTlUQZK4cLYjloXI5PygF21G
         ti6IfI4zmrgXw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        nbd@nbd.name
Subject: Re: [PATCH wireless] wifi: mt76: mt7615: fix possible race in mt7615_mac_sta_poll
References: <48b23404b759de4f1db2ef85975c72a4aeb1097c.1684938695.git.lorenzo@kernel.org>
Date:   Thu, 25 May 2023 08:55:14 +0300
In-Reply-To: <48b23404b759de4f1db2ef85975c72a4aeb1097c.1684938695.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Wed, 24 May 2023 16:39:32 +0200")
Message-ID: <87h6s1kla5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Grab sta_poll_lock spinlock in mt7615_mac_sta_poll routine in order to
> avoid possible races with mt7615_mac_add_txs() or mt7615_mac_fill_rx()
> removing msta pointer from sta_poll_list.
>
> Fixes: a621372a04ac ("mt76: mt7615: rework mt7615_mac_sta_poll for usb code")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I'll take this to wireless tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
