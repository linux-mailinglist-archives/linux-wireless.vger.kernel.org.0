Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3217044CA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 07:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEPFlA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 01:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEPFk7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 01:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF82133
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 22:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 686C6623F9
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 05:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FACFC433EF;
        Tue, 16 May 2023 05:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684215652;
        bh=fH3JC0GyPtb45owIqlv6gy7k54jAwf6IBM1SQxCn8ss=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KkYIZ/s8CqcrlDUJ303Hf06geydxQPHXXxvLrsnbRJmeOG96RHIzbnkpe1sWPlZlE
         d2BqK1/TBaL8YV52lRXwROkRF5b+9cdvjhw6oHuf7fMn6emQwwEhhLYk1IUiXTz1TM
         9Wj2jYCB2e3czNed4wiLjwghzjRDCIjRmKQ6fPJeYzDMqejm1EG7lxNvo1rj7tabOZ
         ei75yzMxX52i//dmrYvtu/hMrgpHCY3Xurd0mT5QfauOOwAjXlC8JS+4EqgJ478JBb
         JV1d0gFRxAgMuuzjXbDzVlO3MQmt7CvXemO2JniWglA8t3nhj1Ebj/eChTApevmUhs
         qE1ch9e+4Ca2w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        quic_jjohnson@quicinc.com, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] cfg80211: S1G rate information and calculations
References: <20230512122539.3868849-1-gilad.itzkovitch@morsemicro.com>
Date:   Tue, 16 May 2023 08:40:49 +0300
In-Reply-To: <20230512122539.3868849-1-gilad.itzkovitch@morsemicro.com> (Gilad
        Itzkovitch's message of "Sat, 13 May 2023 00:25:39 +1200")
Message-ID: <87jzx8n89q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com> writes:

> Increase the size of S1G rate_info flags to support S1G and add
> flags for new S1G MCS and the supported bandwidths. Also, include
> S1G rate information to netlink STA rate message. Lastly, add
> rate calculation function for S1G MCS.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202305110435.EhEiLYWA-lkp@intel.com/
> Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>

Changelog missing, see the wiki below for more info.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
