Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E236E22DB
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDNMGV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjDNMGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF4127
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB48061601
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D62C433D2;
        Fri, 14 Apr 2023 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681473956;
        bh=FwNrvNe4VWH+lWbrqNpkKbPN7HxJu0u/3f/Jb+iLL8k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hcfhiXtpWrB3GceYpwIAZOvXgvInJqn9serexzBJLck6shITnU8Pe5BHL1LzRxWwM
         weJERWfzYweZj2KRwuLn7qPJAYWyx9kd3AziU/z5hXG3mrytg9EcUmDhG4Flp0UhNq
         LrZcR2bqm6EA9MnkB7tQehXm6Tm+P12ZhVy+OlFfwVdWn6ePT/Fzh11W/IDuSN56nL
         RH7Zbl7HEpCNUVEvJIfS65E+G8ELjAQeVNWS0aNc28q1QMKHZsPZ80Xcx6OaI4dSal
         qW2eebNUiI7EGO0CnKPX+sS+kY6yUjX+2bv5JCq7j4rmIAeeKNcbbRwZEj2W3EZg9l
         DW4lAKgrPwpzw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] wifi: rtw89: add function to wait for completion of TX skbs
References: <20230411124832.14965-1-pkshih@realtek.com>
        <20230411124832.14965-3-pkshih@realtek.com>
Date:   Fri, 14 Apr 2023 15:05:50 +0300
In-Reply-To: <20230411124832.14965-3-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Tue, 11 Apr 2023 20:48:29 +0800")
Message-ID: <87ildy7joh.fsf@kernel.org>
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

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po-Hao Huang <phhuang@realtek.com>
>
> Allocate a per-skb completion to track those skbs we are interested in
> and wait for them to complete transmission with TX status.
>
> Normally, the completion object is freed by wait side, but it could be
> timeout result that complete side should free the object instead. Add a
> owner field with a spin_lock to determine which side should free the
> object.

I'll change the last sentence to mention RCU so that it matches the code.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
