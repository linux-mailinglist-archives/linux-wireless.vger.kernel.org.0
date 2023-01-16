Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D936A66C7ED
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjAPQft (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjAPQfK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 11:35:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60A2A99F
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 08:22:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D03FB81063
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 16:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F85C433EF;
        Mon, 16 Jan 2023 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673886166;
        bh=EkrK/AeJb1OAG5NzGS7loqPQvsbtyprsYs6TU2koRm8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FGvRj3F+Y50OY7hHIOY9kvKhaLH6TwAfKVKT5iTQd2jm/VwwTSE3Y1PBQVYhA8EBA
         V4x6A9JR6oMBzsniWvtAvsORspQmvHOFjFjuxDIt49w8GHL9dinkJdQkRED47WEqYE
         SYK2NPfqa4fHei1SoK/mw9Kwz9hBmDvGsCh7Zk40rfysVHgSEzF3b+dqB4uhWE61jG
         7kyRe6mD6GrqCn9bG3zGps7LjAzB8fwhX3Q+IFPy0M/4z9zWvt7kK+qGUj9gJdCpng
         NFWLjfRKCzdz7HalqjCjpadHtMH6EXIg3LDm+bsc3h6eo4KgKSYpZcrxgZBQ70U2bx
         ztEcHtk+7lYcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: orinoco: check return value of hermes_write_wordrec()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221227133306.201356-1-aleksei.kodanev@bell-sw.com>
References: <20221227133306.201356-1-aleksei.kodanev@bell-sw.com>
To:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc:     linux-wireless@vger.kernel.org,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167388616414.5321.302246308386486154.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 16:22:45 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexey Kodanev <aleksei.kodanev@bell-sw.com> wrote:

> There is currently no return check for writing an authentication
> type (HERMES_AUTH_SHARED_KEY or HERMES_AUTH_OPEN). It looks like
> it was accidentally skipped.
> 
> This patch adds a return check similar to the other checks in
> __orinoco_hw_setup_enc() for hermes_write_wordrec().
> 
> Detected using the static analysis tool - Svace.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

Patch applied to wireless-next.git, thanks.

1e346cbb096a wifi: orinoco: check return value of hermes_write_wordrec()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221227133306.201356-1-aleksei.kodanev@bell-sw.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

