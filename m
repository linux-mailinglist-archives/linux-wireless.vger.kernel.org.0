Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224095F44DC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJDNyy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJDNyu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 09:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A2FAEC
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 06:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 627D06143D
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 13:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3842CC433D6;
        Tue,  4 Oct 2022 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664891686;
        bh=i3x1hvLG3GXt+VJeK3d8bwYoLCGo5dZ2NStVTrZCDWU=;
        h=From:To:Cc:Subject:Date:From;
        b=kvkUj1yCNfIdI4HnnGSuWoySGHqKDTsudX2zleLFuBKjJ5CQzrsAPf4vjj9nVlHKY
         H9XQJXVWt/PGWNR+VQRgpsyW31Wrv3zvU6qH2tSAcPargrk7SZrfv2+Mf+ATQ+/v0D
         nVdyFvsr2gJmJxdrMzIL+9M+7UwRRmyyfYHXljSthF2ugc3oe1UsYcp5T3E0r1atvd
         29dD5DR/50mwJUMug8hgD+PJ6zrs4iOtOUONqCnr+R1aFy0YQOOqArs7cNZpqPLTIf
         UA6wDDYvLNkb9NJv3HSydDDRvB++GbJLLek3fUKdPcMZIaRvFhkmpjIX++7IwyvDv0
         MlcJHo/rcF4yA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
Subject: Wireless workshop at Netdevconf 0x16, Lisbon 2022
Date:   Tue, 04 Oct 2022 16:54:42 +0300
Message-ID: <8735c3r8wt.fsf@kernel.org>
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

We're going to hold a Wireless workshop during Netdevconf 0x16 in
Lisbon, Portugal:

https://netdevconf.info/0x16/session.html?Wireless-Workshop

The schedule is not published yet but we have requested it to be on
Tuesday October 25th, though the date will be confirmed once the
schedule is publically available.

As usual we have set up a wiki page for the event:

https://wireless.wiki.kernel.org/en/developers/summits/lisbon-2022

Everyone are welcome to join, but a registration to the conference is
required. We ask people to add their name to the wiki if you are
planning to come. Feel free to add any topics you want to discuss,
presentations are also very welcome.

We hope to see you there,

Johannes & Kalle
