Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926B87DD73D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 21:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjJaUor (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Oct 2023 16:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJaUoq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Oct 2023 16:44:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B093AE4
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 13:44:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B26C433C8;
        Tue, 31 Oct 2023 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698785083;
        bh=/FlQVzk+2p9U5lIDiQ8LPfxUXiO0yI8HaQK+bbMeYDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BoOx+Sht6lVVc+0/17jdLeJhCPWLpYRf5Mgphv0MvSI1lE63vmNo7MQk7JmVj9lkk
         b7EODG+yfn87xbGbGj6t3d1OvtAZZms1+fV9oaQxpVVD5Mv1gTbXggSIfSwWd34J7w
         zSbCyoLXtEqzLBm+S1ZIckbH1iE7bK04zLetNR5nNfzRkxhzLTTXA+sQ0CPRcMBOqY
         n5BMeS8mITgsefhk0Qn8xsVcBwdm3EW4IfjfH5jSRM9uBktHinDzM+mtVdfi23Sf+X
         U9fI+h2TjDTdHEBN/ITjl9x9MtTHGut0XUIGrq+b0IUV30X3MkqrBPHcW+EX5ssSSi
         YWdD3QUTotuoA==
Date:   Tue, 31 Oct 2023 15:44:41 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [ANN] wireless-regdb: master-2023-09-01
Message-ID: <ZUFnOZ5KstXnNoIm@do-x1extreme>
References: <ZPJF1/2YA4dP+ggY@ubuntu-x1>
 <CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com>
 <ZUAUahZakEvOXpip@do-x1extreme>
 <CAGb2v66cVj2O89G9qhKCqca+jyBK9ic3866giL=LZX4mQo-eDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v66cVj2O89G9qhKCqca+jyBK9ic3866giL=LZX4mQo-eDg@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 31, 2023 at 05:32:15PM +0800, Chen-Yu Tsai wrote:
> One thing I forgot to ask. After a release is tagged, is there some
> magic bot that produces a tarball and uploads it to kernel.org? Or
> is that a manual process?

Releases tarballs are produced using kup [1]. It's not quite automatic,
but with some simple scripting it's pretty close.

[1] https://korg.docs.kernel.org/kup.html
