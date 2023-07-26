Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57517762CEB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjGZHPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGZHOn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2430F0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9343F6167E
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745FDC433C8;
        Wed, 26 Jul 2023 07:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690355505;
        bh=dkzKe3On2YiIVLiOwt41UYCjYzyPDrbI3oPWE6tYnIY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dVl4qRCsfA/Ss/ZDGA7C3kIeCiRbHRHPaxNPYgKCAEvyLY1jQ+R0Hs4JZPaVC9R5F
         Owe613mfM6Ys0t/C37MoLe9zudGV+mLlq1wI7s7COJT70QyUSm9ltE7ZAk7yMTp+Gy
         0DWTW/pqhUmlp93RhaCMbpIj13gUpIhxhG5o+VZAIG7lJB8D0oLHG8KxRwb7EFQNCf
         ltGqVTRFOEo3cy45PaWTouzoYouJFNuqaQjo0hO+xXldJgtVAqAjkqZfSsAJ7nZw7o
         pNqKjn/9qOFkyGUPHHpc4XOqHibhvCc8jRkEN/CigI1gYSbIn9JSqnDSJuoUNBXMAr
         cqK1fB1hrUR0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] MAINTAINERS: wifi: rtw88: change Ping as the
 maintainer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230724104547.3061709-2-kvalo@kernel.org>
References: <20230724104547.3061709-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169035550252.3467307.11742202360657848157.kvalo@kernel.org>
Date:   Wed, 26 Jul 2023 07:11:44 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Yan-Hsuan has been away since 2021 and Ping has been the de facto maintainer
> the past year, actively reviewing patches and doing all other maintainer
> duties. So fix the MAINTAINERS file to show the current situation.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

9 patches applied to wireless.git, thanks.

96839282edc2 MAINTAINERS: wifi: rtw88: change Ping as the maintainer
25700d4916fe MAINTAINERS: wifi: atmel: mark as orphan
74b81eac2dda MAINTAINERS: wifi: mark cw1200 as orphan
e76983151dc6 MAINTAINERS: wifi: mark ar5523 as orphan
bc5dee3ce7c0 MAINTAINERS: wifi: mark rndis_wlan as orphan
0566ec90515c MAINTAINERS: wifi: mark wl3501 as orphan
c1e0a70de12d MAINTAINERS: wifi: mark zd1211rw as orphan
3ccbc99c152f MAINTAINERS: wifi: mark b43 as orphan
cc326aae03c3 MAINTAINERS: wifi: mark mlw8k as orphan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230724104547.3061709-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

