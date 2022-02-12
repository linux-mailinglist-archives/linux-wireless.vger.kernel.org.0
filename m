Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5214B35D9
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 16:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiBLPcK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 10:32:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBLPcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 10:32:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D5D83
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 07:32:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B46360F39
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 15:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4185DC340E7;
        Sat, 12 Feb 2022 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644679924;
        bh=R1bdVDolcdtT2fashMkw+F1Y+o8am6yqFn20HD9E0Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJN+qy2UwN5nPYsaRBwZlCOXLfHlgbHiDzudNMWZLcuOp4pmFybdP61lpDwbEIMDW
         PUKy6/gKY5yEO3l4u3dp9Vmdil36kVWhUESaw1TqK1BucR0U9uiSyqrn/60azDYOeX
         ns8PhlfumGWqQBq5NjMQoIPRRV4h3SHKS1Mg1y1fdrKuFikORQoN2jFlV5V/9lYW0Y
         vlCombnfO8G7C6yygwo+2oYKxPFkTG4cWAmHZd+GcsWvah5eft0vBmodw2U3N62dI1
         7lByQsYnoeyxIP/fifMudJ5nvxWAgGpAI98w2vIosuqPN/UlT19fmEGYsS3oPVmmT0
         47ze0UKtb5DtA==
Date:   Sat, 12 Feb 2022 09:32:03 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wireless-regdb: add support for US S1G channels
Message-ID: <YgfS89Qge+3JWw2C@ubuntu-x1>
References: <20220208012450.190982-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208012450.190982-1-thomas@adapt-ip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 07, 2022 at 05:24:49PM -0800, Thomas Pedersen wrote:
> The 902-928MHz band is one of the US ISM bands, so follows
> the same emission limits described in FCC part 15.
> 
> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

Applied both patches, thanks!
