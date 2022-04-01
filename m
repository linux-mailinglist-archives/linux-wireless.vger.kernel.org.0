Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879454EE8A1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 08:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbiDAGvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDAGvi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 02:51:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FCF19E3B5
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 23:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2CC0BCE2485
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 06:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D3BC2BBE4;
        Fri,  1 Apr 2022 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648795786;
        bh=R8Df+NZA+D+ArFodW3Esz53VOD/MqNamehLFj8foYkQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=j+7+GdVQXk3qMD93Y9qDMVGwe6k7Ac4JU2DD7S3/dUT/WsN11EXoMGeHDsKHewEff
         u7bVkzj8gePf+3V4nelVDP4uhMN/Tb6PVjQMyUbf57R126mzTt/TzxuqF3/KABwquk
         5dshjUxfNje2CNe/HLMQU5AaHg4TRcAxEwr5MDv0G1m9pyxn8ca0U9+xH6IgXo56gn
         s6siGVvzkwb4WWZKmEhWB19a4eiYG+3WN8l4PFz1ARYtUprpHDRdXu3FsIrpGaHLfJ
         vAZ+zlueN+TFaOpYDnN/8RSKMIaRlX9pW7ElSS0z4lfhPXm61SrPDCAoPAWjML3nGc
         aVMWTsoDR7FLQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     <sean.wang@mediatek.com>
Cc:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: Add hotspot mode support
References: <734908dd741b85b7cc3855f23596cc5884c335e4.1648765636.git.objelf@gmail.com>
Date:   Fri, 01 Apr 2022 09:49:37 +0300
In-Reply-To: <734908dd741b85b7cc3855f23596cc5884c335e4.1648765636.git.objelf@gmail.com>
        (sean wang's message of "Fri, 1 Apr 2022 06:32:24 +0800")
Message-ID: <877d89uwla.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

<sean.wang@mediatek.com> writes:

> From: Sean Wang <sean.wang@mediatek.com>
>
> add hostspot mode support to mt7921 that can work for mt7921[e,s,u]
> with the common code.
>
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Hotspot mode? Why not call it just AP mode? No need to confuse people
with different terminology.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
