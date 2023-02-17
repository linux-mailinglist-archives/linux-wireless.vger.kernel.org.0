Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACEF69A712
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBQIgk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 03:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBQIgj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 03:36:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CBE5ECBF
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 00:36:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DB9361277
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 08:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39CCC433EF;
        Fri, 17 Feb 2023 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676622997;
        bh=mQMQd5XfG1I4angU5mQ48Mo4ValoFKLNIdDrxSHc+lE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jt8onWUpLmSyxeSrR+eVoFRq34JHhb4jVTqbZgHvi1BZQM1gu6MBTp9+Qn+cTNr/K
         B2zSj7+mKS1aRTsjSAFOX+8tbwcyry/jY43H/0MNtIxRMRtXQ7gquVied6hIC20PXg
         dK3prUhPzkEs8t2L9aZvP0jpsJYFl/NXXNbC6qb4YLyS1MHkO/QDxpfkP4uffSP9er
         Uwa5KoNXX2V+z9032KwRUQ6zSYQW64qaDDoMwdGJW4W5kXZicAErMD41VP0iM4yy/D
         qoek/FfEu1bg0aA4BqoA8gAuKzkN0/eeNQ360Iw6T+yFADhvgx9uvcGPPk+1lUX6CU
         J3x8x5C4Ex3ug==
From:   Kalle Valo <kvalo@kernel.org>
To:     Anthony Refuerzo <anthony96922@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iw: Add more VHT capabilities reporting
References: <20230216205925.10091-1-anthony96922@gmail.com>
        <20230216205925.10091-2-anthony96922@gmail.com>
Date:   Fri, 17 Feb 2023 10:36:31 +0200
In-Reply-To: <20230216205925.10091-2-anthony96922@gmail.com> (Anthony
        Refuerzo's message of "Thu, 16 Feb 2023 12:59:25 -0800")
Message-ID: <87fsb44rjk.fsf@kernel.org>
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

Anthony Refuerzo <anthony96922@gmail.com> writes:

> Add extra reporting for VHT capabilities. These were not previously shown.

Signed-off-by missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
