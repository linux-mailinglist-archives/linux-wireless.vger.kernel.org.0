Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D437358A580
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 06:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiHEEra (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 00:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiHEEr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 00:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E587B3C8F5
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 21:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B03160EDD
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 04:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DA7C433D7;
        Fri,  5 Aug 2022 04:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659674846;
        bh=FmKwzAx6tYuW/PdvvLxIOtwxLkZ7VwpD8hSB3GYZixo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otZQ93y5SaMclvsXAAgys3YaI16GRHsa37lmr1hKJ7EkIi2ggKCoKvhEKIILBqGpo
         kc5eNWaa+UPjT/Ic3xOhAvTfzH1t/Hv4ZRtK9j5ZvTHh3UNgvhn1Md5hntKd13iq/b
         X/JAiZT7YjYZdxATP4d/hMKurlHt+grfbjCvxlME=
Date:   Fri, 5 Aug 2022 06:47:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dmkgrim80 <dmkgrim80@gmail.com>
Cc:     linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        gregory.greenman@intel.com
Subject: Re: intel ax200 problem after iwlwifi source change from 5.6 to
 5.7,current
Message-ID: <Yuyg2nYP0HrwKwUO@kroah.com>
References: <8155d519-8ae3-6fb2-ca44-552541b3fedf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8155d519-8ae3-6fb2-ca44-552541b3fedf@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 04, 2022 at 11:47:27AM -0500, dmkgrim80 wrote:
> Hello I have a issue I would like resolved
> 
> 
>            Hi, I have a intel AX200 m.2 installed in a old Acer Aspire E15
> E5-553-11PT
> 
> I am having some issues with kernels newer than 5.4 and possibly 5.6.

If you can not use 'git bisect', it's going to be difficult to narrow
this down to the offending commit.

Please try to use that, and also remember that you can use 'make
localmodconfig' to reduce your configuration file size so you don't end
up building kernels with all options in it to reduce your build times.

good luck!

greg k-h
