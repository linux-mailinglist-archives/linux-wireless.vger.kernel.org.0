Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0797DBECA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjJ3RYX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3RYW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 13:24:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA693
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 10:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE5DC433C8;
        Mon, 30 Oct 2023 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686659;
        bh=/gtylxtjgXGqYCM+tNlyZ/hRTlzs0qm9kng5oqm9bNI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SCirkedLY3zag2f98ghgjPwjzlG/kD6p3KGjdQM/l50Y4hCaCFzxg1UD64Rg9WGxG
         huQWE+CyhtuM0qOd6xjiScvKOWVga584ZQjEae+3IhSW+bWa5njZtsPlFDHZaDdjZy
         HbO9W0gLZzyemRMnuo+lJ0oHNUzB1/SdujgMn19thD/41Kee1OrrO9ySP+aN4sj2R8
         CN8jIN5P4+guEW78B65TCeIA/ohx2nNpDRyO9LaPIvcNnASuI8++HTKoktkp0TqL6o
         /R8Ro2OTXVhHGzpCz3o+wgibWUY3j660Wo4y0LrIZ2RbHLu4I0N/COfdNau8tylsQP
         TOFacQlmRB1fQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: wilc1000: simplify remain on channel support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231026141016.71407-1-dmantipov@yandex.ru>
References: <20231026141016.71407-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868665669.1993746.1466382778731928122.kvalo@kernel.org>
Date:   Mon, 30 Oct 2023 17:24:18 +0000 (UTC)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> For 'struct wilc_remain_ch', drop set but otherwise unused 'duration'
> field and adjust 'expired' callback assuming that the only data passed
> to it is 'struct wilc_vif *', thus making 'wilc_remain_on_channel()'
> a bit simpler as well. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>

2 patches applied to wireless-next.git, thanks.

a0ddf39ac642 wifi: wilc1000: simplify remain on channel support
ebab2723d0bd wifi: wilc1000: always release SDIO host in wilc_sdio_cmd53()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231026141016.71407-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

