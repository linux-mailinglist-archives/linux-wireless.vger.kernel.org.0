Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31A58ACF8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiHEPSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Aug 2022 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHEPSp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Aug 2022 11:18:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C41EAC2
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 08:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29C18B827DE
        for <linux-wireless@vger.kernel.org>; Fri,  5 Aug 2022 15:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4798C433D6;
        Fri,  5 Aug 2022 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659712721;
        bh=a3J98JmoOsmJUtPTXQWaXfCBE7p1487afXQtkt4+XQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7PB2+KPZ/rqLxAWqGN5HBb/GNhgjNqx7B5XXJHOgbiUuKpefK10Z8jI/T3AVMlYV
         dN2xCBLsja7SODoPuKaLmtcsMWSit9fZSsR8SiKqekl+IMV/X4nHnMIgz1ZmzlPqnE
         Lqx/DGqOK+ZDtoq4bs8ZDjhOVTBNCs9MDbCgoLKSztcNly6pfTLQn2DYBnvmX3ITva
         mvdhKSRbPNlEn1+OB6FTHRnpcxKTJYi6GkBK0lV0POoYK9WzIZJkTe4XWqJ/qv3j3U
         UY61P9MoGqpCCbD83DgWbpyrsGR3E4vk37QwJ0fykUyrOQID0APXOJXvC+7n7LzfnK
         6E94/IQ/ZWA6w==
Date:   Fri, 5 Aug 2022 10:18:40 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Murtaza Saeed <mnk.saeed@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Pakistan (PK) on 5GHz
Message-ID: <Yu000DvbyViZPeC+@ubuntu-x1>
References: <CAATNLbwMFDj0UrG1PBNh-dj7GT+GJ2Ud38TzHL=FmMG7wgNNbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATNLbwMFDj0UrG1PBNh-dj7GT+GJ2Ud38TzHL=FmMG7wgNNbQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 05, 2022 at 06:01:43PM +0500, Murtaza Saeed wrote:
> Hi,
> 
> The current regulatory rules for Pakistan (PK) for 5 GHz channels in
> wireless-regdb are out of date and have been recently updated by the
> Pakistan Telecommunication Authority (PTA) in June 2022.
> 
> PTA has allowed the use of additional 5 GHz channels which were
> previously restricted for use in Pakistan.
> 
> (5150 - 5350) at ≤ 200 mW EIRP (23 dBm)
> (5470 - 5725) at ≤ 200 mW EIRP (23 dBm)
> 
> The current channels (5725 - 5875) remain allowed at a higher power of 1W.
> 
> (5725 - 5875) at ≤ 1W EIRP (30 dBm)
> 
> The updated regulatory framework from PTA can be found at the link
> below and the relevant information is available on Page 10.
> 
> https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf
> 
> If I am correct, the listing for PK in the database should show as follows:
> 
> country PK: DFS-JP
> # https://fab.gov.pk/type-approval/
> # https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
> # https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf
> (2402 - 2482 @ 40), (20)
> (5150 - 5350 @ 80), (23)
> (5470 - 5725 @ 80), (23)
> (5725 - 5875 @ 80), (30)

Thanks for the information! This isn't quite right though. Annex A1
includes additional restrictions which need to be accounted for in the
rules:

 - 5150-5610 GHz are restricted to indoor use.
 - 5270-5610 GHz requires DFS.
 - 5270-5610 GHz also requires TPC, but since Linux doesn't support TPC
   we have to lower the max EIRP by half.

It also looks like 60 GHz is allowed, so we can also add a rule for
that. So I think this is what we end up with for the new rules:

country PK: DFS-JP                                                                                                     
        # https://fab.gov.pk/type-approval/                                                                            
        # https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf                                         
        # https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf                              
        (2402 - 2482 @ 40), (100 mW)                                                                                   
        (5150 - 5270 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW                                                              
        (5270 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW                                                         
        (5470 - 5610 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW                                                         
        (5610 - 5725 @ 80), (200 mW), AUTO-BW                                                                          
        (5725 - 5875 @ 80), (1000 mW)                                                                                  
        (57000 - 66000 @ 2160), (40)                                                                                   

Note that I also changed the EIRP to mW to match what's in the document,
except for 60 GHz where it gives the limit in dBm. We generally try to
have the rules match the regulatory documents.

If this looks good to you, I can send a patch.

Thanks,
Seth
