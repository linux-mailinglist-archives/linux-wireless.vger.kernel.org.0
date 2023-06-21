Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E469737FDC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFUJfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjFUJec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA11BC7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DCC0614B6
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057D8C433C0;
        Wed, 21 Jun 2023 09:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687339959;
        bh=/iCNRmmomHR8mEwjqDMj0Boz/zJRnjQXqYJaolxNT3o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=M/WVnIJ8EpmnX1lNlHoVYzZbqXpZ2ZFkvsQgeMb0TKcXJIgs1jeSVJ5XutaZ8SVY5
         qwvxcIlamwsYhLDag+Hftl/M9KQNSXcEUPQxl4n1I7hSgbgxiSf2Mtx/CCYXiTlVfl
         WTeSsfKGi9SSg7fX68QFZe2moWsMT7jl/2ZOlhy6DSwAA26lX+9aeixAWRgEbRC5Y5
         /+D2RoXEGOhyjQEtxgddpJhaEBjuKVQuFuvv4SFxkNPAGS7sUi/jRbCWRQHaHYkSDb
         TURbBZrJ6ntsc312KsWYcefCm1PyHla8Wf52PePlctyu+3zH2PSsQWgKwYApp0YKIl
         GqRG8cavnbaOQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Amisha.Patel@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2] wifi: wilc1000: add SPI commands retry mechanism
References: <20230614203215.9652-1-amisha.patel@microchip.com>
Date:   Wed, 21 Jun 2023 12:32:36 +0300
In-Reply-To: <20230614203215.9652-1-amisha.patel@microchip.com> (Amisha
        Patel's message of "Wed, 14 Jun 2023 20:32:46 +0000")
Message-ID: <87zg4tdutn.fsf@kernel.org>
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

<Amisha.Patel@microchip.com> writes:

> From: Amisha Patel <amisha.patel@microchip.com>
>
> In some situations like, chip wake-up with powersave enabled, SPI
> commands are failing temporarily. Reissuing commands after reset helps
> to overcome the failure. So, add the retry limit and reset command
> sequence API for read/write SPI commands.
>
> Signed-off-by: Amisha Patel <amisha.patel@microchip.com>

[...]

> +retry:
>  	result = wilc_spi_single_read(wilc, cmd, addr, data, clockless);
>  	if (result) {
>  		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
> -		return result;
> +
> +		/* retry is not applicable for clockless registers */
> +		if (clockless || !retry_limit)
> +			return result;
> +
> +		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
> +		retry_limit--;
> +		goto retry;
>  	}

A for loop is recommended over a goto loop. Also in this case I find
'retry_limit == 0' more readable than '!retry_limit', it's a counter
anyway.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
