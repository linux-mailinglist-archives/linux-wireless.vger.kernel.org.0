Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74F523605
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiEKOpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiEKOpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 10:45:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84066106A54
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 07:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B4BB82454
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 14:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA59C34113;
        Wed, 11 May 2022 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652280314;
        bh=4emqUvocU097sO9W+zS/fxWNl/kZXPaTxF/+/3aijwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amrvuSWON3+2a+7/nCgU7vtimYV3QJFfkUJS/dO15nhEznOHZHLXcl3rbrBkR4e2n
         77KM1yBJEk7ETqNXRPWoYTQ6VoQ9iIv8kkAwb8D+4hDFh7CC/1N2Sly+vhrw22jXwx
         kKiENPOIqgJpgJ0uOtvNMWH4rY8nxSk/qfIV9fu2T/MHLJY4M7J5QiPO8aDExb6uoA
         udZiOxh1Q3iaqAp+/rGx+tqhqAkHBonTQsWu0SGNJHZdUm7ra9Bxz29b9/sZFVNDIy
         KPJICGmFlITRVynUeujo46hCkcstwdi/JR+0H6udpeQeNuNXMhEtvqdCvxmxRI6c8v
         3AaRnCx+25FwA==
Date:   Wed, 11 May 2022 09:45:13 -0500
From:   "sforshee@kernel.org" <sforshee@kernel.org>
To:     Claudio Menendez <cmenendez@openleanux.ca>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: wireless-regdb: Update regulatory rules for Canada (CA) on 6GHz
Message-ID: <YnvL+XqurmpV3HyN@ubuntu-x1>
References: <DM4PR12MB524525E824BA0B505B4E48E1BCF59@DM4PR12MB5245.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB524525E824BA0B505B4E48E1BCF59@DM4PR12MB5245.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 20, 2022 at 05:56:43PM +0000, Claudio Menendez wrote:
> Hi Seth,
> 
> I tried to commit diff to add the 6Ghz band for Canada on the db.txt, but I believe I did it wrong - sorry, I am a newbie at git.
> 
> Anyway, below you can see the resolution from ISED to allow indoor use on the 6 GHz band to a max channel of 320 with a max e.i.r.p of 24 dBm. The radio standard specification (RSS-248) is dated last November, and I did not see it in the latest version of the DB.txt.
> 
> Please advise if you need any clarification.

Thanks for the messages, and sorry about the delay in responding. I just
applied a patch to enable 6GHz in Canada. Note though that it has a
power limit of 12 dBm as a result of the PSD limits, which are not
currently supported directly in Linux or wireless-regdb. This is
described in detail in the patch description.

Thanks,
Seth
