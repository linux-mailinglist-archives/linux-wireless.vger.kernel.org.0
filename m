Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8669488D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 15:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBMOs1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 09:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjBMOsK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 09:48:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D772B1C313
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 06:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 731C36112F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 14:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4792C4339E;
        Mon, 13 Feb 2023 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676299684;
        bh=HNfv647gJT0dBNkG5c5F9MxLCVJD5r7S65m8Jrvhha8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObUKh++mgcsqxusn5wFzMgUPpHrNKCQ9WdJDSUa5DSu6iahRKWaRqGXKw5zybcDfS
         jh4Acl3FytHalXFgdgaLfDY8leelVWVJKXGEUStdnywm3dVMPe0g7y9nPn+9DU1Zip
         22WiTz5Gm79z9HZei6COlF6JXbNJdl5NJJKE3C5xnrCoJZRg1xrcoR9pKbcvCMll6p
         U7hgPiMjqA3MTIPXr0TEVfUlxeZLI/8ra0UEZHm7yCCTElZ2nsyuWbtyJumf4m6lo5
         8xiTEmkBik41Xvq0N+guckAdWz0OKu8v179XM/Ht3Ynkq7kDz05SbWLMbdiTKvzmuF
         n5gvJ3vXq0fVQ==
Date:   Mon, 13 Feb 2023 08:48:03 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Eugene Konev <uejikov@gmail.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Russia
 (RU) on 5GHz
Message-ID: <Y+pNo9jQqmMIt2QV@ubuntu-x1>
References: <CAO7DJoCeUdHzRYkXg-HXTQqYpBPijR-ZbUy_C6Lx35s-wYR-mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7DJoCeUdHzRYkXg-HXTQqYpBPijR-ZbUy_C6Lx35s-wYR-mQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 31, 2023 at 07:49:09PM +0700, Eugene Konev wrote:
> Update regulatory info for Russia on 5GHz in accordance with
> current regulatory rules.
> 
> Source: https://docs.cntd.ru/document/902048009?section=text
> 
> Signed-off-by: Eugene Konev <uejikov@gmail.com>

Applied, thanks!
