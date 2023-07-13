Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D229A7515AD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 02:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjGMA6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 20:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjGMA60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 20:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F62117
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 17:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8188F619BD
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 00:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A6FC433C8;
        Thu, 13 Jul 2023 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209900;
        bh=grGiFzlDxzvz6wfqR7lcyVgzjUiMch7I2dZdDCE4ABE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JfZJWpZz3hAG3QAQdkLSuP0yyWAtMLPyMsxgZio/UgVxrszSX3T40pwZToK8Uu2e0
         KLtl/KRdsqWQMfdRBkXCeR8svGDPrXopOvYIhAqU4o7aiM/reWdko+wKWkd8JDkhvA
         XVkCT8fORorljlQ83eDjUG4H0MbMpW4occq/CoQZRVhW+h3ubVbABx0Z1TeZftyci6
         QzR3vpWGrXeiE69zuaIV7PHfazGiwDNd6WaO47xW846isHL6wC5eMDWdlE0CtldMS8
         vSj03+8rueJGy6SeU3H8JYIN5DagRv4pQPjV3VwE6cGZlZyfml5jlo3CRzcsrMBE2A
         TO6ZojGlBGqaA==
Date:   Wed, 12 Jul 2023 17:58:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: fix memory leak in
 mwifiex_histogram_read()
Message-ID: <20230712175819.1f8a7c24@kernel.org>
In-Reply-To: <20230711082504.18838-1-dmantipov@yandex.ru>
References: <20230711082504.18838-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 11 Jul 2023 11:24:53 +0300 Dmitry Antipov wrote:
> Always free the zeroed page on return from mwifiex_histogram_read().

Fixes: ?
