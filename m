Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB36254F9AD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379298AbiFQOuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jun 2022 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358452AbiFQOuv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jun 2022 10:50:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5593141611
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 07:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01246B82ACA
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jun 2022 14:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C5CC3411B;
        Fri, 17 Jun 2022 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655477447;
        bh=M5/he+GrjhQIeU9BeJjdwoSJo2WLcrjwgadxd/BUjOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hik994yWZ1OHmY2jb7UzV/Gqx9JAsGxXem0AR66qQjzyb8tWswEJSfca/kVPdTKZd
         ZyvVAp9R25b3OJ+VDKqLanZ+iaYnHBu4V9tR7iXg60NlkbosiY8ItWPe8DX2eXXHfG
         vQCGE/e3nZLN3zEeIq0dTj44r1VuYOiiHqEbqYritDxVahC4mF71ZgrSPyd8H2UONa
         eJXhD8Fdoh+GJafuw0CK9u2eioKMZizLp1E9vr6Bc9/BLM2ThwWpm5cHZsrw2Jh4sI
         Q1vz6uURqZIH3VxvGuPmkPrRERzw3J/8PPinjp7gKdhe/A6ONpJVprsuVayoZuQZQT
         GMhg7VHKIPu1A==
Date:   Fri, 17 Jun 2022 07:50:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     golan.ben.ami@intel.com, Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Udo Steinberg <udo@hypervisor.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Bug 215635 - iwlwifi: Firmware crash with firmware
 36.ca7b901d.0 (8265-36.ucode)
Message-ID: <20220617075046.79f41945@kernel.org>
In-Reply-To: <28d2123f-65ce-f69c-12e1-f672b26225f4@leemhuis.info>
References: <915d6d66-4e42-8cbf-76bc-0f2f72d5e7d6@leemhuis.info>
        <20220616115808.141dec76@kernel.org>
        <28d2123f-65ce-f69c-12e1-f672b26225f4@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 17 Jun 2022 08:38:55 +0200 Thorsten Leemhuis wrote:
> > Any progress / outputs on this one? Folks are reporting it's still
> > happening on Fedora 36 w/ 5.17.13.  
> 
> Jakub, thx for bringing this up, I had "look  into this again" on my
> todo list for some time already. Out of interest: where where those reports?

The reports I was referring to are internal at Meta.
