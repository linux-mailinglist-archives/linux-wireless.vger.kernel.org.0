Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C2F494E84
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jan 2022 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbiATNC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jan 2022 08:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244861AbiATNCV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jan 2022 08:02:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC633C06173F;
        Thu, 20 Jan 2022 05:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA37E61709;
        Thu, 20 Jan 2022 13:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80158C340E0;
        Thu, 20 Jan 2022 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642683739;
        bh=x+DOYiFzn0XsRYi6KLFi9USIVaAdNpJ5jZO6Q3cWSlg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=C8CuLFCXikvbmdHpst4OgjTUCx2Bkhpk1lWk5J4m/KUDCBvQR5EpYVUsZxILP8Q0Q
         0aqCMEqMK/SGePNX6gocI87ritTUWznB7iijUAlIpwnJllcXjba4Kr3Ka1r935Qupw
         MsISpZuMEYvoOS1n23LryyCz27YBpoyJj8LUT7d9SM+/EEWkBOO0FX4Wzk8/dCgB3Q
         rj9EySX7LMXcX6M1M5KPO0/CsAboBqqchdLteAAOoEDpiznF5KRI9e38xQzYfmmmBI
         l/m4uGt1qBX7GV9LqbfyyYUkmhPAvhYX2wyWwZuHxRt88fd7MerfmtvFPmnBgrvvFQ
         YuFOZUwaJ9rsQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, owen.peng@mediatek.com,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings:net:wireless:mediatek,mt76: add disable-radar-offchan
References: <cover.1642009736.git.lorenzo@kernel.org>
        <221dab8bcc95160652e608def16d822da78717bd.1642009736.git.lorenzo@kernel.org>
Date:   Thu, 20 Jan 2022 15:02:12 +0200
In-Reply-To: <221dab8bcc95160652e608def16d822da78717bd.1642009736.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Wed, 12 Jan 2022 18:53:55 +0100")
Message-ID: <87v8yeimqz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Add the capability to disable/enable radar/CAC detection running on
> a dedicated offchannel chain available on some hw.
> Offchannel radar/CAC detection allows to avoid CAC downtime switching
> on a different channel during CAC detection on the selected radar
> channel.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml  | 9 +++++++++
>  1 file changed, 9 insertions(+)

Was the recommendation so that devicetree binding patches should be
first in the patchset?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
