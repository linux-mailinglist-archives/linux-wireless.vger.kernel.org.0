Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770DD6F59EF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjECOZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjECOZ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 10:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B2D5BAE
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 07:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC904628A6
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 14:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C159C433EF;
        Wed,  3 May 2023 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123953;
        bh=bLa5JCsvvnHG7alfQD8k/ej7JnLJbBqhc9pIBaJInd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A49+ALjxo7Lj8/yTLaHnGwwkuBVyeWcEM8Tosay0v+YVRjaNN7042NHhC4tqyNOuZ
         xse0ncLSI2SBW8OgcRb+Ofkec48bEknf+KEuD2jJDlqQPJvchuT69LYM4F5c1ayfJw
         il7zEOaMf8kGEyKhdGIwu5lZOhmR6CybCudrODn6q5HohP07WytHAdmbZDnWvbPVXd
         v43WKNn7yddb+5+KMTd9C+fKUoCNKsi+3eBn1k20uS49RcO11s9S4qQZdVyWr9d5UO
         W/HRgdRwlc3JDcnrosTexYLUP6EHil4Bg5vtUAkrd56yCCr0m13qwys48pefe9Q/cj
         n77iMRZWZHjMw==
Date:   Wed, 3 May 2023 09:25:52 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Kirill <me@16depo.xyz>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Russia (RU)
 on 6GHz
Message-ID: <ZFJu8FbgHF0Pbo+L@ubuntu-x1>
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 25, 2023 at 04:04:37AM +0300, Kirill wrote:
> Update regulatory info for Russia on 6GHz in
>  accordance with current regulatory rules.
> 
> Source: https://docs.cntd.ru/document/1300597464?section=text
> 
> Signed-off-by: Kirill Matvienko <me@16depo.xyz>

Applied, thanks!
