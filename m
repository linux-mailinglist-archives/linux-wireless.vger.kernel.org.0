Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90D791BE2
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbjIDRNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDRNH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 13:13:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BECDB
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 10:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F24BCE0F24
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 17:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C322DC433C7;
        Mon,  4 Sep 2023 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693847580;
        bh=UPNy4HAWRdr0nTChq8qXQikxaloyReFdF/RbT53gAE0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mASLX3l3c2n/kb9Wagv9JCBc9Saq32jwy9bi6EKizz0yq8fC5h6UEu+x9tz8fFeqQ
         PVbkyvVD6TqTtmKqErZd2jQK+Nlzy1ojU/it1a0o5j0j5BSUzxbO0qqxQBujMQ6naf
         y7c8wBCS8BVCsj1d0Zt3qpbEPuMz5ZSw6soUI1Bwl30H7lOvuqfzHLg9aMqirq8KfF
         RwMzI3X0c7kCCFgeB8XV+aCgelMUXQ/F7T6zi3j0VG4N8xgPd4PSwbeu9LJEnptBp0
         +yTFqQ/YBnHXi108U2HO+5m2L7+Ql8loOOYakGjuBFfFDIP4USVRRqq1te7GwijI1X
         alKooXWJp2c7w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] MAINTAINERS: wifi: remove generic wiki links from
 drivers
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230828123603.87621-1-kvalo@kernel.org>
References: <20230828123603.87621-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384757755.3420994.6057021301110200088.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:12:59 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> The top level entry for wireless drivers already contains to the wiki so no
> need to duplicate that in driver entries:
> 
> NETWORKING DRIVERS (WIRELESS)
> [...]
> W:	https://wireless.wiki.kernel.org/
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

5 patches applied to wireless.git, thanks.

84727c5727fe MAINTAINERS: wifi: remove generic wiki links from drivers
0b9480da79e0 MAINTAINERS: wifi: rtlwifi: remove git tree
42c5f0e20ec9 MAINTAINERS: wifi: rtl8xxxu: remove git tree
b8c713c13482 MAINTAINERS: wifi: wl12xx: remove git tree
d253fb3705b3 MAINTAINERS: wifi: hostap: remove maintainer and web page

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230828123603.87621-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

