Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C919A4D2DED
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 12:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiCIL0x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 06:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiCIL0x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 06:26:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD2C16A58F;
        Wed,  9 Mar 2022 03:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1CA5B820BC;
        Wed,  9 Mar 2022 11:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D35C340E8;
        Wed,  9 Mar 2022 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646825150;
        bh=pi/I+f8oAdMPiZ00hqEd4Ori4d69XCBM0oR4J3iG4Uc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FK/dDSqoq8Xsvhj4ooyEUYZckolVVsXt1KFHMDZRO0jeurQVkMc18XT8/6tf3quko
         6bYURW33hASZHe0qn+7POw4VgmH1DRATQv+G+IL+o6W5BORIQF3jhlxd66EIOjUf6D
         KzSIR+ovdHwhWcf7Qymn22pbw66FPBpXIqzLjLUbK/23htI62XMkOfH3sFF4jYRVSf
         jHxQpkETsyUUP6OOuzHjO8Uy7O0HY2JqLjyfrFwCNXZIxiMDulJ0f2oZDj3wAYVTz+
         IAyQp3VOp2KbvkbUc/8iekTNtV9IONimHaB6xkptGMXLp+Y1zErHm1c83ZDhvalZq0
         au90zhS7i64bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: add devicetree bindings entry for mt76
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <8cbfeceef642ede408b4922c363953cb243cd87f.1646766851.git.lorenzo@kernel.org>
References: <8cbfeceef642ede408b4922c363953cb243cd87f.1646766851.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        robh@kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164682514615.8809.15088883190596586692.kvalo@kernel.org>
Date:   Wed,  9 Mar 2022 11:25:48 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Specify devicetree bindings entry for mt76 driver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Felix, I would like to apply this directly to wireless-next. Ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8cbfeceef642ede408b4922c363953cb243cd87f.1646766851.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

