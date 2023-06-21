Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3CC73801D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjFUJV3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjFUJV0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8B1B4
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F04CF614C7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E157C433C8;
        Wed, 21 Jun 2023 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687339279;
        bh=nsVwiMkVL0ODjNvgmiZTSWnr0tfEycFYv1F01wZoxPc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gkMvHoNmph3INS0Snn7Xf9+ONo66zes9q7k/pYzOI82XzDW+Mc3vyT3ua3mbbmsPi
         CnXYj8CeIgqSXtNlsSDz4zXzNB5t8zT/3oRp/On46cEx6cUfE9whpYZuAXQcOoxFXu
         LA3M6HyN9EWqdKgGV5699+SVOWm6dUcSJbv9pNJPOln2YrrTotrJS4BxzX4zEy5sqZ
         VT9jTxcM1BfNwaCxnpKjWecA6tUkUwEddaYgB8OW0JD9BwMM7oAWPmyBEwC6AJoyaD
         b7RyaQK6GitdccsJXMoH2X5s6c1seDkEPYvlpvPgRqkGUEGYJSuthPB7NgkW/Tw98q
         w0l4QGEO71kPw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] wifi: rtw88: correct AP and PS mode behaviors
References: <20230616125540.36877-1-pkshih@realtek.com>
Date:   Wed, 21 Jun 2023 12:21:14 +0300
In-Reply-To: <20230616125540.36877-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 16 Jun 2023 20:55:34 +0800")
Message-ID: <87edm59nn9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Note: The patch 5/6 ("wifi: rtw88: refine register based H2C command")
> adds new static function that is used by patch 6/6, so compiler will
> warn unused function if we build this path.

Thanks for the note, this is always good to know. In general it would be
better to avoid having the warning at all, for example in this case one
solution would have been to merge patches 5 and 6 into one patch. But no
need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
